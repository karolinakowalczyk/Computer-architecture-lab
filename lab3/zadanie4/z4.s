READ_NR  = 3
WRITE_NR = 4
STDOUT = 1
STDIN = 0
.data 

# Etykieta widziana globalnie, będzie przechowywała czas przed operacją.
.global start_time 
start_time: .space 4

# Etykieta widziana globalnie, będzie przechowywała czas po operacji.

.global stop_time
stop_time: .space 4

# Etykieta widziana globalnie, wypełnia 1 bajt pamięci znakiem 'a', który zostanie wypisany.

.global character_out
character_out:.space 1, 'a'

# Etykieta widziana globalnie, rezerwuje 1 bajt pamięci.

.global character_in
character_in: .space 1

# Etykieta potrzebna dla sprawdzenia czasu operacji zapisania do pamięci.

some_memory: .space 1

.text
.global write_function, read_function, write_register, write_memory

# Funkcja, w której liczony jest czas wypisywania znaku 'a'.
write_function:
 pushl %ebp
 movl %esp, %ebp
 pushl %edi
 pushl %esi
 pushl %ebx

 xorl %eax, %eax
 cpuid
 rdtsc
 movl %eax, start_time

 
 movl $WRITE_NR, %eax
 movl $STDOUT, %ebx
 movl $character_out, %ecx
 movl $1, %edx
 int $0x80
 
 xorl %eax, %eax
 cpuid
 rdtsc
 movl %eax, stop_time

 popl %ebx
 popl %esi
 popl %edi
 movl %ebp, %esp
 popl %ebp

ret

# Funkcja, w której liczony jest czas wczytywania znaku.

read_function:
 pushl %ebp
 movl %esp, %ebp
 pushl %edi
 pushl %esi
 pushl %ebx

 xorl %eax, %eax
 cpuid
 rdtsc
 movl %eax, start_time


 movl $READ_NR, %eax
 movl $STDIN, %ebx
 movl $character_in, %ecx
 movl $1, %edx
 int $0x80

 xorl %eax, %eax
 cpuid
 rdtsc
 movl %eax, stop_time


 popl %ebx
 popl %esi
 popl %edi
 movl %ebp, %esp
 popl %ebp

ret

# Funkcja, w której liczony jest czas zapisu do rejestru.

write_register:
 pushl %ebp
 movl %esp, %ebp
 pushl %edi
 pushl %esi
 pushl %ebx
 
 xorl %eax, %eax
 cpuid
 rdtsc
 movl %eax, start_time

 movl $1, %ecx

 xorl %eax, %eax
 cpuid
 rdtsc
 movl %eax, stop_time

 popl %ebx
 popl %esi
 popl %edi
 movl %ebp, %esp
 popl %ebp

ret

# Funkcja, w której liczony jest czas zapisu do pamięci.


write_memory:
 pushl %ebp
 movl %esp, %ebp
 pushl %edi
 pushl %esi
 pushl %ebx

 xorl %eax, %eax
 cpuid
 rdtsc
 movl %eax, start_time


 movl $1, some_memory

 xorl %eax, %eax
 cpuid
 rdtsc
 movl %eax, stop_time


 popl %ebx
 popl %esi
 popl %edi
 movl %ebp, %esp
 popl %ebp

ret




