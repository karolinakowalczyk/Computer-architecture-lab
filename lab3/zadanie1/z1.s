.data
# Dane wpisane (kody ascii) zakończone zerem.
# Program spodziewa się danych typu char (%c), a następnie char* (%s).
data_type: .asciz "%c%s"

# Etykieta character, w której zostanie przechowany znak (długość - 1 bajt).
# Etykieta character_pointer, w której zostanie przechowany wskaźnik (długość - 4 bajty).
character: .byte 1
character_pointer: .byte 4

.text
.global main

main:
pushl %ebp			# Zachowanie rejestru %ebp.
mov %esp, %ebp

# Wrzucanie argumentów na stos w kolejności od ostatniego do pierwszego.
# Wywołanie funkcji scanf
# Sprzątanie stosu - przesunięcie wskaźnika stosu w górę (o 12, ponieważ przesłałam na stos 3 argumenty 4-bajtowe

pushl $character_pointer
pushl $character
pushl $data_type
call scanf 
addl $12, %esp


# Wrzucanie argumentów na stos w kolejności od ostatniego do pierwszego.
# Wywołanie funkcji printf
# Sprzątanie stosu - przesunięcie wskaźnika stosu w górę. 
pushl $character_pointer
pushl character
pushl $data_type
call printf
addl $12, %esp
 
mov %ebp, %esp
popl %ebp		# Przywrócenie rejestru %ebp.


pushl $0
call exit

