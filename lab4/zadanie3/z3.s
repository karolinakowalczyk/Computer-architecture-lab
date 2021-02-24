RESET_ROUND_BIT = 0xF3FF
ROUND_DOWN_BIT = 0x400
ROUND_UP_BIT = 0x800

.data
control_reg: .space 1
.text
.global round_down, round_up

# Funkcja zmieniajaca tryb zaokraglania na zaokraglanie w dol.
round_down:
 pushl %ebp
 movl %esp, %ebp
  mov $0, %eax
  fstcw control_reg
  fwait
  mov control_reg, %ax	     #Będę operować na rejestrze sterujacym, poniewaz to w nim znajduja sie bity na ktorych widnieje tryb zaokraglenia.
	
  and $RESET_ROUND_BIT , %ax #Powoduje wyzerowanie bitow na ktorych widnieje tryb zaokraglenia.
  or $ROUND_DOWN_BIT, %ax    #Zmienia bity na ktorych widac tryb zaokraglenia na 01.
  mov %ax, control_reg
  fldcw control_reg
  movl %ebp, %esp
 popl %ebp

ret

# Funkcja zmieniajaca tryb zaokraglania na zaokraglanie w gore.
round_up:
 pushl %ebp
 movl %esp, %ebp
  mov $0, %eax
  fstcw control_reg
  fwait
  mov control_reg, %ax          #Będę operować na rejestrze sterujacym, poniewaz to w nim znajduja sie bity na ktorych widnieje tryb zaokraglenia.
  and $RESET_ROUND_BIT , %ax	#Powoduje wyzerowanie bitow na ktorych widnieje tryb zaokraglenia.
  or $ROUND_UP_BIT, %ax		#Zmienia bity na ktorych widac tryb zaokraglenia na 10.
  mov %ax, control_reg
  fldcw control_reg
  movl %ebp, %esp
 popl %ebp

ret

