.text
.global rdtsc
rdtsc:
# Zachowanie rejestru %ebp.
# Ładowanie do rejestru %esp wartości rejestru %ebp.
# Zachowanie rejestru %edi.
# Zachowanie rejestru %esi.
# Zachowanie rejestru %ebx.
# Wyzerowanie akumulatora.
# Wywołanie instrukcji cpuid.
# Wywołanie indtrukcji rdtsc (która odczytuje wartość rejestru - licznika cykli procesora).
# Przywrócenie rejestru %ebx.
# Przywrócenie rejestru %esi.
# Przywrócenie rejestru %edi.
# Ładowanie do rejestru %ebp wartości rejestru %esp.
# Przywrócenie rejestru %ebp.

	pushl %ebp
 	movl %esp, %ebp
        push %edi
        push %esi
	push %ebx
        xorl %eax, %eax
	cpuid
	rdtsc
	popl %ebx
        popl %esi
        popl %edi
	movl %ebp, %esp
 	popl %ebp

ret
