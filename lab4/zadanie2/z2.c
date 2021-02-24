#include <stdio.h>
extern float div_0_operation();
extern float bad_precision_operation();
extern short read_status_register();
extern short read_control_register();

void dec_to_bin(short n);


int main()
{
    int option;
    printf("Rejestr statusu: %hd \n",read_status_register());
    printf("Rejestr sterujacy: %hd \n",read_control_register());
    
    printf("Wybierz jaka flage chcesz wyswietlic: \n");
    printf("1. dzielenie przez 0: \n");
    printf("2. zla precyzja: \n");
    printf("3. dzielenie przez 0 i zla precyzja\n");

    scanf("%d", &option);

    if(option == 1){
	div_0_operation();
    	printf("Dzielnie przez 0 - zapis binarny: \n");
    	dec_to_bin(read_status_register());
    	printf("\n");
    }
    else if (option == 2){
	bad_precision_operation();
    	printf("Zła precyzja - zapis binarny: \n");
    	dec_to_bin(read_status_register());
    	printf("\n");
    }
    else if (option == 3){
	div_0_operation();
	bad_precision_operation();
    	printf(" - zapis binarny: \n");
    	dec_to_bin(read_status_register());
    	printf("\n");
    }
    else if (option!= 1 && option != 2 && option != 3){
	    printf("Nie podales poprawnej opcji.\n");
    }

    printf("Rejestr sterujacy: %hd \n",read_control_register());
    printf("Rejestr statusu: %hd \n",read_status_register());

    return 0;
}

//Funkcja zamieniajaca liczbe w systemie dziesietnym na liczbe w systemie binarnym.
void dec_to_bin(short n){ 
    if (n > 1){
	 dec_to_bin(n/2); 
    }
    printf("%d", n % 2); 
}
