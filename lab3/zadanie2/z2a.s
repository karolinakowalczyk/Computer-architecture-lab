.data
# Dane wpisane (kody ascii) zakończone zerem.
data_type: .asciz "%c\n%s\n"

.text
.global main
main:

# Wrzucanie argumentów na stos (odwołanie się do zmiennych character i tab za pomocą symboli zawierajcych adresy tych zmiennych).
# Wywołanie funkcji printf

pushl $tab
pushl character
pushl $data_type
call printf

pushl $0
call exit
