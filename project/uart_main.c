/****************************************************************************
 *   $Id:: uart_main.c 4824 2010-09-07 18:47:51Z nxp21346                   $
 *   Project: NXP LPC11xx UART example
 *
 *   Description:
 *     This file contains UART test modules, main entry, to test UART APIs.
 *
 ****************************************************************************
 * Software that is described herein is for illustrative purposes only
 * which provides customers with programming information regarding the
 * products. This software is supplied "AS IS" without any warranties.
 * NXP Semiconductors assumes no responsibility or liability for the
 * use of the software, conveys no license or title under any patent,
 * copyright, or mask work right to the product. NXP Semiconductors
 * reserves the right to make changes in the software without
 * notification. NXP Semiconductors also make no representation or
 * warranty that such application will be suitable for the specified
 * use without further testing or modification.
****************************************************************************/
#include "driver_config.h"
#include "target_config.h"
#include "gpio.h"
#include "uart.h"
#include "adc.h"
#include "timer32.h"
extern volatile uint32_t UARTCount;
extern volatile uint8_t UARTBuffer[BUFSIZE];

volatile int t, i, j;
unsigned char tempo=64;
unsigned char hit, clear, br=0;
int rand;
unsigned char beat[256];
uint32_t begin=0, end=0;
unsigned int time;
uint16_t lfsr=0xACE1u;
unsigned bit;

int main (void) {
	init_timer32(0, TIME_INTERVAL/8);
    enable_timer32(0);
    //init_timer32(1, 1);
    //enable_timer32(1);
    GPIOInit();
    GPIOSetDir(0,7,1);
    GPIOSetValue(0,7,0);
    GPIOSetDir(2,0,1);
    GPIOSetValue(2,0,0);
    GPIOSetDir(2,1,1);
    GPIOSetValue(2,1,0);
    GPIOSetDir(2,2,1);
    GPIOSetValue(2,2,0);
    GPIOSetDir(3,1,1);
    GPIOSetValue(3,1,0);
    GPIOSetDir(3,2,1);
    GPIOSetValue(3,2,0);

    /* NVIC is installed inside UARTInit file. */
    UARTInit(UART_BAUD);
    lfsr=(31337);

    while (1)
    {
      GPIOSetValue(0,7,1);

      for (i=0;i<256;i++) {

        if (!beat[i]) {
          //for (t=0;t<5;t++) {
            if (UARTBuffer[0]==0x69) {
              beat[i] = UARTBuffer[1];
              if (UARTBuffer[2]){
                tempo = 2*UARTBuffer[2];
              }
            }
          //}
        }
        UARTCount=0;
        for (t=0;t<3;t++) {
          UARTBuffer[t]=0;
        }

	    clear=(beat[i])&1;
	    if (clear) {
	      for (t=0;t<256;t++) {
	    	  beat[t]=0;
	      }
	      clear=0;
	      tempo=64;
	      continue;
	    }
	    //hit
	    hit=(beat[i]>>1)&1;
	    GPIOSetValue(2,0,hit);
	    //lowt
	    //hit=(beat[i]>>2)&1;
	    //GPIOSetValue(2,1,hit);
	    //hat
	    hit=(beat[i]>>3)&1;
	    GPIOSetValue(2,2,hit);
	    //snare
	    hit=(beat[i]>>4)&1;
	    GPIOSetValue(3,1,hit);
	    //bass
	    hit=(beat[i]>>5)&1;
	    GPIOSetValue(3,2,hit);

	    //time=50000.0/tempo;
	    //for(t=0;t<time;t++);

	    time=(int)(256.0/tempo);

	    begin=timer32_0_counter;
	    while((end-begin)<time) {
	        bit=((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5) ) & 1;
	        lfsr =  (lfsr >> 1) | (bit << 15);
	        GPIOSetValue(2,1,bit);
	      end=timer32_0_counter;
	    }
	    GPIOSetValue(0,7,0);
      }
    }
  return 0;
}
