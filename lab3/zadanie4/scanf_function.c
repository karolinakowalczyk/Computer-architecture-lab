#include <stdio.h>

extern unsigned long long rdtsc() ;

unsigned long long start_time;
unsigned long long stop_time;
unsigned long long result;



char character_scanf;

int main()
{
    
    for(int i=0; i<10; i++){
	start_time=rdtsc();
        #pragma scanf("%c", &character_scanf);
    	stop_time=rdtsc();
	result=stop_time-start_time;
	printf ("\n%llu\n", result) ;


    }
    return 0;
}



