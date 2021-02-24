#include <stdio.h>

extern short control_register;
extern short read_status_register();
extern short read_control_register();
extern void write_control_register();

int main()
{
    //Odczytanie zawartosci rejestru statusu.
    printf("Rejestr statusu: %hd\n", read_status_register());
    //Odczytanie zawartosci rejestru kontrolnego.
    printf("Rejestr kontrolny przed zapisaniem wartosci: %hd\n", read_control_register());
    //Zapisanie wartosci do rejestru kontrolnego.
    write_control_register();
    //Ponowne odczytanie zawartosci rejestru kontrolnego.
    printf("Rejestr kontrolny po zapisaniu wartosci: %hd\n", read_control_register());
    return 0;
}
