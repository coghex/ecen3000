#include"gpio.h"
#include "debug_printf.h"
#include "driver_config.h"
#include "target_config.h"


extern int asm_sum(int x, int y);
extern int fibonacci(int n);

int sum(int x, int y) {
	return x + y;
}

int main(void) {


	printf("%d\n", fibonacci(0));

	// Enter an infinite loop, just incrementing a counter
	volatile static int loop = 0;
	while (1) {
		loop++;
	}
}
