# Wartość 765 oznacza 3 zakresy unsigned char (jeden zakres 0...255). Jest to wartość używana przy skalowaniu. Wybrane zostały 3 zakresy ponieważ, największy zakres po przemnożeniu macierzy K i M wynosi (-765...765). Jest tak, bo mam trzy (-1): -255-255-255 i trzy (1): 255+255+255.
THREE_RANGE_U_CHAR = 765

# Wartość 3 będzie indeksem w potęgowaniu 2^3, czyli 8. Jest to wartość używana przy skalowaniu. 
INDEX = 3
.data 

#Każda z poniższych etykiet odpowiada za wiersz macierzy K.
row1: .byte -1, -1, 0, 0
row2: .byte -1, 0, 1, 0
row3: .byte 0, 1, 1, 0

#Etykiety przechowujace szerokość i wysokość macierzy. 
width: .space 4
height: .space 4

.text
.global filter
.type filter,@function
filter:
	push %ebp
	mov %esp, %ebp
	push %edi
	push %esi
	push %ebx
	
	movl 8(%ebp),%ecx #Pobranie pierwszego parametru - macierz M.
	movl 12(%ebp),%ebx #Pobranie drugiego parametru - macierz W.
	movl 16(%ebp),%eax #Pobranie trzeciego parametru - szerokość.
	movl 20(%ebp),%edx #Pobranie czwartego parametru - wysokość.

	movl %eax, width
	movl %edx,height
	
	#Przeslanie każdego z wierszy macierzy K do rejestrow %mm.
	movd row1, %mm3 
	movd row2, %mm4
	movd row3, %mm5
	
        # Rejestr %esi to licznik peli zewnetrznej - i.
	movl $0,%esi

		loop_i:

		 # Rejestr %edi to licznik peli wewnetrznej - j.
		movl $0,%edi	
			
			loop_j:
                        movl width,%eax    #%eax = width
		        mull %esi  	   #eax = width * i
                        movl %eax, %edx	   #edx = width * i
                        addl %edi, %edx    #edx = width * i + j - aktualny indeks
                                                   
                        
		
			# Przesuniecie rejestru %mm0 o 0 - przekopiowanie dwóch kolejnych komórek macierzy zaczynając od M[width*i+j] z rejestru ogolnego przeznaczenia do rejestru %mm0.
                        # Przesuniecie rejestru %mm0 o 1 - przekopiowanie dwóch kolenych komórek macierzy zaczynając od M[width*i+j+2] z rejestru ogolnego przeznaczenia do rejestru %mm0.
			# Mnoży 4 bajty z %mm0 i 4 bajty z %mm3. Następnie dodaje dwie młodsze części wyniku i ładuje je do młodszej częsci %mm0.
                        # Dwie starsze części wyniku również dodaje i ładuje do starszej czesci %mm0.
                        # Zmienia aktualny indeks poprzez dodanie szerokości.
                        # Kolejne dwa kroki analogiczne.

			pinsrw $0, (%ecx, %edx,1), %mm0 
			pinsrw $1, 1(%ecx, %edx,1), %mm0 	
			pmaddubsw %mm3, %mm0
		
			add width, %edx 		#edx = i*width +j + width
				
			pinsrw $0, (%ecx, %edx,1), %mm1
			pinsrw $1, 1(%ecx, %edx,1), %mm1 	
			pmaddubsw %mm4, %mm1
						
			add width, %edx  		#edx = i*width +j + width + width

			pinsrw $0, (%ecx, %edx,1), %mm2
			pinsrw $1, 1(%ecx, %edx,1), %mm2 	
			pmaddubsw %mm5, %mm2
		
                        #Dodaje 2 rejestry %mm, wynik w %mm0.
                        #Sumuje młodszy i starszy bit rejestru %mm0.

			paddw %mm1, %mm0 
			paddw %mm2, %mm0
			phaddw %mm0, %mm0
			
                        #Kopiuje wartość rejestru %mm0 do rejestru ogólnego przeznaczenia %eax.
			pextrw $0, %mm0, %eax
                        
                        # Mój obecny zakres to (-765...765), po dodaniu 765 otrzymuję zakres (0...1530)
                        #Nie mogę przesunąć o 6 (1530/6=255), ponieważ muszę przesunąć przez liczbę która jest potęgą 2. Wybrałam przesunięcie o 8, ponieważ wtedy otrzymam zakres (0...191) - zmieszczę się w zakresie (0...255).
			add $THREE_RANGE_U_CHAR, %eax
			shr $INDEX, %eax                                     
                       			
			subl width, %edx
                        movl %eax,1(%ebx,%edx,1) #Przesyłam wynik opreacji do macierzy W.

                        incl %edi

                        cmpl width,%edi
			jl loop_j


		inc %esi

                cmpl height,%esi

		jl loop_i


	pop %ebx
	pop %esi
	pop %edi
	mov %ebp, %esp
	pop %ebp
ret
