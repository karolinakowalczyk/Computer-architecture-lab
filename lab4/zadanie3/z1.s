.data
# Etykieta widziana globalnie, będzie przechowywala zawartosc rejestru statusu.
.global status_register
 status_register: .short 0

# Etykieta widziana globalnie, będzie przechowywala zawartosc rejestru sterujacego.
.global control_register
 control_register: .short 0


.text
.global read_status_register, read_control_register, write_control_register

#Funkcja odczytujaca zawartosc rejestru statusu
read_status_register:
 pushl %ebp
 movl %esp, %ebp

 fstsw status_register		#Zapisz do pamięci (status_register) rejestr statusowy FPU.
 movl status_register, %eax

 movl %ebp, %esp
 popl %ebp

ret

#Funkcja odczytująca zawartosc rejestru sterujacego.
read_control_register:
 pushl %ebp
 movl %esp, %ebp

 fstcw control_register		#Zapisz do pamięci (control_register) rejestr sterujący FPU.

 movl control_register, %eax

 movl %ebp, %esp
 popl %ebp

ret

//Funckcja zapisująca wartość 70 do rejestru steruącego.
write_control_register:
 pushl %ebp
 movl %esp, %ebp

 movl $70, control_register
 fldcw control_register		#Załaduj słowo sterujące FPU z pamięci (control_register)

 movl %ebp, %esp
 popl %ebp

ret


