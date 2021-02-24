EXIT_NR  = 1
READ_NR  = 3
WRITE_NR = 4
STDOUT = 1
STDIN = 0
EXIT_CODE_SUCCESS = 0


# Rozmiar liczb (danych), które będą mnożone.
# Rozmiar pojedynczej operacji w bajtach, u mnie jest to 4, bo 
# pracuję na systemie 32-bitowym (32 bity = 4 bajty).

DATA_SIZE = 256
SYSTEM_SIZE = 4	

.data

# Bufory na liczby do mnożenia oraz wynik.
# wpełnia zerami obczar pamieci o rozmiarze 256 bajtow (mnozna), 256 bajtow(mnoznik), 2*256 = 512 bajtow(wynik mnozenia)
value1: .space DATA_SIZE
value2: .space DATA_SIZE
result: .space 2*DATA_SIZE

.text

.global _start

_start:

# Czytanie danych z wejścia, dopóki długość nie wyniesie 0.

	mov $READ_NR, %eax
	mov $STDIN, %ebx
	mov $value1, %ecx
	mov $DATA_SIZE, %edx
	int $0x80	
	cmp $0, %eax
	je end

	mov $READ_NR, %eax
	mov $STDIN, %ebx
	mov $value2, %ecx
	mov $DATA_SIZE, %edx
	int $0x80	
	cmp $0, %eax
	je end

# Mnożenie.

	# Zerowanie bufora wyniku, w każdej iteracji 4 bajty są wypełniane zerami.  	    
	# 2*DATA_SIZE ponieważ długość wyniku może być 2x większa niż mnożna lub mnożnik.

	mov $0, %edi
	reset_result_loop:
		movl $0, result(, %edi, SYSTEM_SIZE)
		inc %edi
		cmp $((2*DATA_SIZE)/SYSTEM_SIZE), %edi
		jl reset_result_loop
	reset_result_loop_end:

	# Mnożę każde kolejne 4-bajtowe (32-bitowe części) - każdy z każdym.
	# Rejestry %edi, %esi to liczniki pętli.

	mov $0, %edi # j
	loop_j:

		mov $0, %esi # i
		loop_i:

			mov %esi, %ecx  # ecx = i
			add %edi, %ecx  # ecx += j

			mov value1(, %esi, SYSTEM_SIZE), %eax   		# value1
			mull value2(, %edi, SYSTEM_SIZE)			# mnożenie przez value1

			# Sumowanie wyniku mnozenia, ktory jest w edx:eax:
			# - dodaj eax bez przeniesienia
			# - dodaj edx z przeniesieniem
			# - jeśli nie ma przeniesienia skocz do etykiety zero_carry
			# - jeśli jest przeniesienie zwiększ index o 2 bo, 2 elementy już zostały dodane

			add %eax, result(, %ecx, SYSTEM_SIZE) 		
			adc %edx, result+SYSTEM_SIZE(, %ecx, SYSTEM_SIZE)
			jnc zero_carry
			inc %ecx
			inc %ecx
			
			# Propagacja przeniesień:
			# - dodaj przeniesienie
			# - jeśli już nie ma przeniesienia to skocz do etykiety zero_carry
			# - jeśli przeniesienie nadal jest to zwiększ index o 1 
			# - porównaj index z długością wyniku
			# - jeżeli index mniejszy od długości wyniku to skocz do etykiety add_carry_loop
			add_carry_loop:
				adc $0, result(, %ecx, SYSTEM_SIZE)	
				jnc zero_carry			
				inc %ecx
				cmp $((2*DATA_SIZE)/SYSTEM_SIZE), %ecx
				jl add_carry_loop
			zero_carry:

			#Zwiększ licznik o 1.
			#Porównaj licznik z dopuszczalnym rozmiarem liczby.
			#Jeśli mniejszy, skocz do etykiety jl loop_i

			inc %esi				
			cmp $(DATA_SIZE/SYSTEM_SIZE), %esi	 
			jl loop_i
		
		#Zwiększ licznik o 1.
		#Porównaj licznik z dopuszczalnym rozmiarem liczby.
		#Jeśli mniejszy, skocz do etykiety jl loop_i

		inc %edi			
		cmp $(DATA_SIZE/SYSTEM_SIZE), %edi
		jl loop_j

# Wyświetlanie danych.

	mov $WRITE_NR, %eax
	mov $STDOUT, %ebx
	mov $result, %ecx
	mov $(2*DATA_SIZE), %edx
	int $0x80

	jmp _start

# Wyjscie z programu.
end:
	mov $EXIT_NR, %eax
	mov $EXIT_CODE_SUCCESS, %ebx
	int $0x80

