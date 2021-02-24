#include <stdio.h>
 
extern void read_function();

extern long start_time;
extern long stop_time;
long result;

int main()
{
    
    for(int i=0; i<10; i++){
	read_function();
	result=stop_time-start_time;
	printf ("\n%li\n", result) ;


    }
    return 0;
}


