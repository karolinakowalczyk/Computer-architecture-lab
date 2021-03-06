#include <stdio.h>
#include <math.h>
extern short read_control_register();
extern short read_status_register();
extern int change_to_single();
void dec_to_bin(int num);

//Funckje służące do wyświetlania liczby zmiennoprzecinkowej w standardzie IEEE zostały wzięte z interntetu, jedynie zmodyfikowałam je tak, aby poprawnie zostały wyświetlone liczby w little-endian.


union u_float
{
    float   flt;
    char    data[sizeof(float)];
};


union u_double
{
    double   dbl;
    char    data[sizeof(double)];
};


static void dump_float(union u_float f)
{
    int exp;
    long mant;

    printf("\nFloat: \n");

    mant = ((((f.data[sizeof(float)-2] & 0x7F) << 8) | (f.data[sizeof(float)-3] & 0xFF)) << 8) | (f.data[sizeof(float)-4] & 0xFF);
    printf("mantysa: %16ld (0x%06lX)\n", mant, mant);
    dec_to_bin(mant);

    printf("\n");

    exp = ((f.data[sizeof(float)-1] & 0x7F) << 1) | ((f.data[sizeof(float)-2] & 0x80) >> 7);
    printf("wykladnik: %4d (nieobciazony %5d), ", exp, exp - 127);

    printf("\n");

    printf("znak: %d, ", (f.data[sizeof(float)-1] & 0x80) >> 7);

        }


static void dump_double(union u_double d)
{
    int exp;
    long long mant;

    printf("\nDouble: \n");

    mant = ((((d.data[sizeof(double)-2] & 0x0F) << 8) | (d.data[sizeof(double)-3] & 0xFF)) << 8) | (d.data[sizeof(double)-4] & 0xFF);
    mant = (mant << 32) | ((((((d.data[sizeof(double)-5] & 0xFF) << 8) | (d.data[sizeof(double)-6] & 0xFF)) << 8) | (d.data[sizeof(double)-7] & 0xFF)) << 8) | (d.data[sizeof(double)-8] & 0xFF);
    printf("mantysa: %16lld (0x%013llX)\n", mant, mant);


    exp = ((d.data[sizeof(double)-1] & 0x7F) << 4) | ((d.data[sizeof(double)-2] & 0xF0) >> 4);
    printf("wykladnik: %4d (nieobciazony %5d), ", exp, exp - 1023);

    printf("\n");


    printf("znak: %d, ", (d.data[sizeof(double)-1] & 0x80) >> 7);

}

static void print_value(double v)
{
    union u_float  f;
    union u_double d;

    f.flt = v;
    d.dbl = v;

    printf("liczba: %f\n", v);
    dump_float(f);
    dump_double(d);
}


int main()
{
    int option;
    double pi = M_PI;

    printf("\n");

    printf("Rejestr sterujacy przed zamiana: %hd \n",read_control_register());
    printf("Rejestr statusowy przed zamiana: %hd \n\n",read_status_register());

    print_value(pi);

    printf("\n\n");

    change_to_single();

    print_value(pi);

    printf("\n\n");

    printf("Rejestr sterujacy po zamianie: %hd \n",read_control_register());
    printf("Rejestr statusowy po zamianie: %hd \n",read_status_register());



    return 0;
}

//Funkcja zamieniajaca liczbe w systemie dziesietnym na liczbe w systemie binarnym.

void dec_to_bin(int num){
    if (num > 1){
	 dec_to_bin(num/2); 
    }
    printf("%d", num % 2); 
}



