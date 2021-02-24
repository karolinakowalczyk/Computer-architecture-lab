#include <stdio.h>

extern void write_memory();

extern long start_time;
extern long stop_time;
long result;

int main()
{
    
    for(int i=0; i<10; i++){
	write_memory();
	result=stop_time-start_time;
	printf ("\n%li\n", result) ;


    }
    return 0;
}



