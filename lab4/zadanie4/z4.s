SINGLE_PRECISION_BIT = 0xFCFF
.data
control_reg: .space 1
.text
.global change_to_single

# Funkcja zmieniajaca rodzaj precyzji na single precision.
change_to_single:
 pushl %ebp
 movl %esp, %ebp
  mov $0, %eax
  fstcw control_reg
  fwait
  mov control_reg, %ax	#Będę operować na rejestrze sterujacym, poniewaz to w nim znajduja sie bity na ktorych widnieje rodzaj precyzji.
  and $0xFCFF, %ax	#Powoduje wyzerowanie bitow na ktorych widnieje rodzaj precyzji, tym samym ustawiajac je na 00, czyli na single precision.

  mov %ax, control_reg
  fldcw control_reg
  movl %ebp, %esp
 popl %ebp

ret




