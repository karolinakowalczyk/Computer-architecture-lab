#include <stdio.h>
extern float unrelated_instructions();
extern long start_time;
extern long stop_time;
long result;


int main()
{
    for(int i=0; i<10; i++){
	unrelated_instructions();
	result=stop_time-start_time;
	printf ("\n%ld\n", result) ;
    }

    return 0;
}


