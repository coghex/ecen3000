/*
===============================================================================
 Name        : main.c
 Author      : 
 Version     :
 Copyright   : Copyright (C) 
 Description : main definition
===============================================================================
*/

#ifdef __USE_CMSIS
#include "LPC11xx.h"
#endif

int LED_COUNTER=0;
int LED_ON=0;
int DUTY_COUNTER=0;
int TIMER=0;
int OLDTIMER=0;
int DIFF=0;

/* GPIO and GPIO Interrupt Initialization */
void GPIOInit() {
 //set up clock
LPC_SYSCON->SYSAHBCLKCTRL |= (1<<6);

//input gpio
LPC_GPIO2->DIR &= ~(1<<1); //set direction of input
LPC_GPIO2->IE |= (1<<1); 	//enable interrupt
LPC_GPIO2->IS &= ~(1<<1);	//set edge sensitivity
LPC_GPIO2->IBE &= ~(1<<1);	//rising edge

NVIC_EnableIRQ(EINT2_IRQn); //enable interrupt 2
 NVIC_SetPriority(EINT2_IRQn,1);	//set to 1 priority

//Enable LED
LPC_GPIO0->DIR |= (1<<7); //set led direction
LPC_GPIO0->MASKED_ACCESS[(1<<7)] = (0<<7);	//turn off the LED
}


/* TIMER32 and TIMER32 Interrupt Initialization */
void TIMERInit() {

  //set up the clock
   LPC_SYSCON->SYSAHBCLKCTRL |= (1<<9);


   //disables other timer functions so you better watch out
   LPC_IOCON->PIO1_5 &= ~0x07;
   LPC_IOCON->PIO1_5 |= 0x02;
   LPC_IOCON->PIO1_5 &= ~0x07;
   LPC_IOCON->PIO1_5 |= 0x02;
   LPC_IOCON->PIO1_7 &= ~0x07;
   LPC_IOCON->PIO1_7 |= 0x02;
   LPC_IOCON->PIO0_1 &= ~0x07;
   LPC_IOCON->PIO0_1 |= 0x02;


   LPC_TMR32B0->IR |= (1<<0); //set up timer_0 interrupt
   LPC_TMR32B0->TCR |= (1<<0);	//enable counting
   LPC_TMR32B0->MCR |= (0b11<<0);	//enable interrupt when counter reaches MR0
   LPC_TMR32B0->MR0 = 10000;	//interrupt every one millisecond
   LPC_TMR32B0->CCR |= (0b101<<0);

   NVIC_EnableIRQ(TIMER_32_0_IRQn); //enable timer interrupt like a boss
   NVIC_SetPriority(TIMER_32_0_IRQn,1);//set priority to 1 same as pin interrupt
}

/* GPIO Interrupt Handler */
void PIOINT2_IRQHandler(void) {
	LPC_GPIO2->IE&=~(1<<1); //interrupt disable
	LPC_GPIO2->IC|=(1<<1); //clear the interrupt
	LED_COUNTER = 1;			//increment the interrupt
	DIFF = TIMER-OLDTIMER;
	OLDTIMER=TIMER;
	LPC_GPIO2->IE|=(1<<1); //interrupt enable
}

/* TIMER32 Interrupt Handler */
void TIMER32_0_IRQHandler(void) {
	LPC_TMR32B0->IR|=(1<<0);//masks off the timer interrupt like a champ
	int duty = 0;
	int period;
	DUTY_COUNTER++;
	TIMER++;
	if ((DUTY_COUNTER%100000)>50000) {
		duty=1;
	}
	else {
		duty=0;
	}
    if (duty) {
        period = DIFF/4;
    }
    else {
    	period = 3*DIFF/4;
    }

    if ((TIMER-OLDTIMER)<period) {
    	LPC_GPIO0->MASKED_ACCESS[(1<<7)]=(1<<7);
    }
    else {
    	LPC_GPIO0->MASKED_ACCESS[(1<<7)]=(0<<7);
    }
    LPC_GPIO2->IE |= (1<<1);

	LED_COUNTER = 0;
}

int main(void) {

   /* Initialization code */
   GPIOInit();                   // Initialize GPIO ports for both Interrupts and LED control
   TIMERInit();                // Initialize Timer and Generate a 1ms interrupt

   /* Infinite looping */
   while(1);


   return 0;
}
