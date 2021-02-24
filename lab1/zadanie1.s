# Deklaracja stałych.
# Wywolania systemowe.
EXIT_NR  = 1
READ_NR  = 3
WRITE_NR = 4
STDOUT = 1	#Standardowe wyjście - konsola.
STDIN = 0	#Standardowe wejście - klawiatura.
EXIT_CODE_SUCCESS = 0

# Symbole
textin_len = 1
textout_len = 3

# Sekcja danych zainicjowanych - dyrektywa.
.data

# Etykieta char_num nadaje wartosc 0, kolejnym obszrom 4 bajtowym (long).
# Będzie przechowywała ilość znaków wejściowych.
char_num: .long 0

# Etykieta textin wypełnia 1 bajt pamięci zerem.
#Będzie przechowywała znak wejścowy.
textin: .space 1

#Etykieta textin wypełnia 3 bajty pamięci zerami.
#Będzie przechowywała znaki wyjściowe.

textout:.space 3

.global _start

.text

_start:

#etykieta char_counter jest potrzbna do stworzenia pętli, która
#nie skończy się, dopóki nie zostaną odczytane wszystkie znaki

char_counter:

# Odczytuję dane.

 movl $READ_NR, %eax	#numer wywołania systemowego - do odczytu
 movl $STDIN, %ebx	#uchwyt pliku - standardowe wejście klawiatura
 movl $textin, %ecx	#adres bufora
 movl $textin_len, %edx #długość bufora
 int $0x80

# Ładuję do char_num wartosc rejestru eax,
# żeby zapamiętać ilość znaków wejściowych.- tryb bezpośredni

 movl %eax, char_num;

# Jeżeli ilość znaków wejściowych jest równa zero to zakończ program,
# jeśli nie to kontynuuj.

 cmpl $0, char_num
 je end

# Rejestrom edi i esi przypisuję wartość 0. 
# Rejestr esi będzie służył jako licznik pętli.
# Rejestr edi będzie służył do poruszania się po ciągu znaków.
 movl $0, %edi
 movl $0, %esi 

 loop:

# Wyzerowanie rejestru, poruszającego się po ciągu znaków

 mov $0, %edi

# Załadowanie do rejestru al znaku wejsciowego.
# Rejestr al - 1 bajt 
# tryb indeksowy 
 mov textin(%esi), %al

# Przesunięcie rejestru al o 4 bity w prawo
# W ten sposób uzysuję starsze 4 bity wprowadzonego znaku
 shrb $4, %al

# Porównanie rejetru al i wartosci 10
 cmpb $10, %al

# Skocz jeżeli wartość rejestru al jest mniejsza niż 10
# Jeżeli jest większa lub równa 10 to dodaj do wartosci rejestru al 55(dec)
# Następnie skocz do etykiety after_compare_all
# Skok: Jeżeli wartość rejestru al jest mniejsza niż 10
# To dodaj do wartosci rejestru al 48(dec)

 jl less_than_10_al

  addb $55, %al

 jmp after_compare_al

 less_than_10_al:
  addb $48, %al 

 after_compare_al:

# Załadowanie do textout wartości rejestru al

 movb %al, textout(%edi)

# Przesunięcie o jeden znak

 inc %edi

# Dla rejestru bl, w którym przechowuję bity młodsze znaku wprowadzonego
# postępowanie jest analogiczne jak dla rejestru al, przechowującego bity
# starsze z wyjątkiem linijki 112, gdzie za pomocą logicznej operacji and
# neguję 4 bity z przodu

 mov textin(%esi), %bl

 andb $0b1111, %bl
 cmpb $10, %bl
 jl less_than_10_bl

  addb $55, %bl 

 jmp after_compare_bl

 less_than_10_bl:
  addb $48, %bl 

 after_compare_bl:
 mov %bl, textout(%edi)

 inc %edi

# Załadowanie do textout spacji 

 movb $' ', textout(%edi)

# Wyświetlanie danych.
 movl $WRITE_NR, %eax
 movl $STDOUT, %ebx
 movl $textout, %ecx
 movl $textout_len, %edx
 int $0x80

# Ikrementacja licznika pętli o 1
# Porówananie licznika pętli z ilością wprowadzonych znaków.
# Jeśli nie są równe skaczę do etykiety loop
# Jeśli są równe skaczę do etykiety char_counter
 inc %esi
 cmp %esi, char_num
 jne loop
jmp char_counter

end:

# Zakończenie programu.

mov $EXIT_NR          , %eax
mov $EXIT_CODE_SUCCESS, %ebx 
int $0x80



