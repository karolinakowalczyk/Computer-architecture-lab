.text
.global rdtsc
rdtsc:
	pushl %ebp
 	movl %esp, %ebp
	push %ebx
        xorl %eax, %eax
	cpuid
	rdtsc
	pop %ebx
	movl %ebp, %esp
 	popl %ebp

ret
