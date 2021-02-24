.data

#Etykiety przechowująca liczby zmiennoprzecinkowe.
one: .float 1.0

three: .float 3.0

hundred: .float 100.0

zero_value: .float 0.0

.text
.global bad_precision_operation, div_0_operation

#Funckja, która pokazuje wyjatek spowodowany zla precyzja.
#Dzielę, w niej 1/3.
bad_precision_operation:
 pushl %ebp
 movl %esp, %ebp
  fld three
  fld one
  fdivp
  fwait
  movl %ebp, %esp
 popl %ebp

ret

#Funkcja pokazujaca wyjatek, spowodowany dzieleniem przez 0.
div_0_operation:
 pushl %ebp
 movl %esp, %ebp
  fld zero_value
  fld hundred
  fdivp
  fwait			#Poczekaj, aż zakończy się obsługa wyjątku.
 movl %ebp, %esp
 popl %ebp

ret
