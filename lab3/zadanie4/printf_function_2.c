#include <stdio.h>

extern unsigned long long rdtsc() ;

unsigned long long start_time;
unsigned long long stop_time;
unsigned long long result;

int main()
{
    
    for(int i=0; i<10; i++){
	start_time=rdtsc();
	printf("Karolina\n");
    	stop_time=rdtsc();
	result=stop_time-start_time;
	printf ("\n%llu\n", result) ;


    }
    return 0;
}





