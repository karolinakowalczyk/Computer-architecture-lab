.data
# Etykieta widziana globalnie, będzie przechowywała czas przed operacją.
.global start_time 
start_time: .long 0

# Etykieta widziana globalnie, będzie przechowywała czas po operacji.

.global stop_time
stop_time: .long 0

# Etykiety przechowujace liczby, na ktorych beda wykonywane instrukcje.
number0: .float 1.76
number1: .float 2.35
number2: .float 3.83
number3: .float 4.99
number4: .float 5.55
number5: .float 6.35
number6: .float 70.77
number7: .float 80.23

.text
.global related_instructions


# Funkcja wykonujaca 180 instrukcji dodawnia i mnozenia, ktore sa od siebie zalezne.
related_instructions:
 pushl %ebp
 movl %esp, %ebp
 push %edi
 push %esi
 push %ebx

# Zaladowanie wartosci na stos.
 fld number7
 fld number6
 fld number5
 fld number4
 fld number3
 fld number2
 fld number1
 fld number0


 xorl %eax, %eax
 cpuid
 rdtsc
 movl %eax, start_time # Rozpoczecie mierzenia czasu.

 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(3), %st
 fmul %st(4), %st
 fadd %st(5), %st
 fmul %st(6), %st
 fadd %st(7), %st
 fmul %st(7), %st
 fadd %st(6), %st
 fmul %st(5), %st
 fadd %st(4), %st
 fmul %st(3), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(3), %st
 fadd %st(6), %st
 fmul %st(4), %st
 fadd %st(7), %st
 fmul %st(2), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(3), %st
 fadd %st(3), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(6), %st
 fmul %st(3), %st
 fadd %st(7), %st
 fmul %st(5), %st
 fadd %st(4), %st
 fmul %st(5), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 
 fadd %st(3), %st
 fmul %st(1), %st
 fadd %st(7), %st
 fmul %st(4), %st
 fadd %st(5), %st
 fmul %st(6), %st
 fadd %st(7), %st
 fmul %st(7), %st
 fadd %st(6), %st
 fmul %st(5), %st
 fadd %st(4), %st
 fmul %st(3), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(3), %st
 fadd %st(6), %st
 fmul %st(4), %st
 fadd %st(7), %st
 fmul %st(2), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(3), %st
 fadd %st(3), %st
 fmul %st(6), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(6), %st
 fmul %st(3), %st
 fadd %st(7), %st
 fmul %st(5), %st
 fadd %st(4), %st
 fmul %st(5), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(3), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(5), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(7), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(6), %st

 fadd %st(2), %st
 fmul %st(6), %st
 fadd %st(7), %st
 fmul %st(1), %st
 fadd %st(5), %st
 fmul %st(6), %st
 fadd %st(7), %st
 fmul %st(7), %st
 fadd %st(6), %st
 fmul %st(5), %st
 fadd %st(4), %st
 fmul %st(3), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(3), %st
 fadd %st(6), %st
 fmul %st(5), %st
 fadd %st(7), %st
 fmul %st(2), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(3), %st
 fadd %st(7), %st
 fmul %st(6), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(4), %st
 fmul %st(1), %st
 fadd %st(6), %st
 fmul %st(3), %st
 fadd %st(7), %st
 fmul %st(5), %st
 fadd %st(4), %st
 fmul %st(5), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(3), %st
 fadd %st(1), %st
 fmul %st(5), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(4), %st
 fmul %st(5), %st
 fadd %st(2), %st
 fmul %st(1), %st
 fadd %st(7), %st
 fmul %st(1), %st
 fadd %st(2), %st
 fmul %st(6), %st


 
 xorl %eax, %eax
 cpuid
 rdtsc
 movl %eax, stop_time	# Zakonczenie mierzenia czasu.
 
 popl %ebx
 popl %esi
 popl %edi
 movl %ebp, %esp
 popl %ebp
ret

