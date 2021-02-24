#include <stdio.h>

// Informacja, że w tym programie używane są zmienne zdefiniowane w innym języku. 
extern short short_type;
extern char * pointer;


int main()
{
    char tab[5]="abcd";
    pointer = &tab[0]; //Przypisanie wskaźnikowi pointer adresu tablicy.

    printf("Short: %hu\n", short_type); //Wypisanie zmiennej typu short.
    printf("Pointer: %s\n", pointer);   //Wypisanie tablicy, na którą wskazuje wskaźnik.

    return 0;
}
