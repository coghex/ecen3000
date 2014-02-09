/****************************************************************************
 *   $Id:: blinky_main.c 4785 2010-09-03 22:39:27Z nxp21346                        $
 *   Project: LED flashing / ISP test program
 *
 *   Description:
 *     This file contains the main routine for the blinky code sample
 *     which flashes an LED on the LPCXpresso board and also increments an
 *     LED display on the Embedded Artists base board. This project
 *     implements CRP and is useful for testing bootloaders.
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

#include "timer32.h"
#include "gpio.h"

extern int fibonacci(int n);

char hexfib[5];
char morsefib[6];

char* translateFib(int fibNum) {
	int a[5];
	a[0]=(fibNum/4096)%16;
	a[1]=(fibNum/256)%16;
	a[2]=(fibNum/16)%16;
	a[3]=(fibNum)%16;
	a[4]='\0';
	int i=0;
	for(i=0;i<5;i++){
		if(a[i]>=0&&a[i]<10){
			hexfib[i]=a[i]+48;
		}
		else{
			hexfib[i]=a[i]+87;
		}
	}
	return hexfib;
}

char* morse(char a){
        int i;
        if(a>47&&a<58){
                i=a-48;
        }
        if(a>96&&a<103){
                i=a-87;
        }
        //char* b[16];
        //b[0]="11111";
        //b[1]="01111";
        //b[2]="00111";
        //b[3]="00011";
        //b[4]="00001";
        //b[5]="00000";
        //b[6]="10000";
        //b[7]="11000";
        //b[8]="11100";
        //b[9]="11110";
        //b[10]="01";
        //b[11]="1000";
        //b[12]="1010";
        //b[13]="100";
        //b[14]="0";
        //b[15]="0010";
        //b[16]='\0';
        //return b[i];

        switch(i) {
            case 0:
            	return "11111";
            	break;
            case 1:
            	return "01111";
            	break;
            case 2:
            	return "00111";
            	break;
            case 3:
            	return "00011";
            	break;
            case 4:
            	return "00001";
            	break;
            case 5:
            	return "00000";
            	break;
            case 6:
            	return "10000";
            	break;
            case 7:
            	return "11000";
            	break;
            case 8:
            	return "11100";
            	break;
            case 9:
            	return "11110";
            	break;
            case 10:
            	return "01";
            	break;
            case 11:
            	return "1000";
            	break;
            case 12:
            	return "1010";
            	break;
            case 13:
            	return "100";
            	break;
            case 14:
            	return "0";
            	break;
            case 15:
            	return "0010";
            	break;
            default:
            	return "\0";
            	break;
        }

}

/* Main Program */

int main (void)
{
  int i, j, k;
  char* code;
  int count;
  int oldcount;
  i = 0;
  init_timer32(0, TIME_INTERVAL);

  enable_timer32(0);

  GPIOInit();

  GPIOSetDir( LED_PORT, LED_BIT, 1 );

  for(k=0;k<21;k++){
  k = 19;
  char* result = translateFib(fibonacci(k));

  while (i < 4) {
	code = morse(result[i]);
	for (j=0;code[j]!=0;j++) {
      if (code[j] == '0') {
    	oldcount = timer32_0_counter;
        while(1) {
          count = timer32_0_counter;
          GPIOSetValue( LED_PORT, LED_BIT, LED_ON );
          if (0.75*(count - oldcount) > ((LED_TOGGLE_TICKS/COUNT_MAX)/2)) {
        	  GPIOSetValue( LED_PORT, LED_BIT, LED_OFF );
        	  oldcount = timer32_0_counter;
        	  while(1) {
        	            count = timer32_0_counter;
        	            if ((count - oldcount) > ((LED_TOGGLE_TICKS/COUNT_MAX)/2)) {
        	            	break;
        	            }
        	  }
        	  break;
          }
        }
      }
      else if (code[j] == '1') {
    	  oldcount = timer32_0_counter;
          while(1) {
            count = timer32_0_counter;
            GPIOSetValue( LED_PORT, LED_BIT, LED_ON );
            if (0.25*(count - oldcount) > ((LED_TOGGLE_TICKS/COUNT_MAX)/2)) {
          	  GPIOSetValue( LED_PORT, LED_BIT, LED_OFF );
          	  oldcount = timer32_0_counter;
        	  while(1) {
        	            count = timer32_0_counter;
        	            if ((count - oldcount) > ((LED_TOGGLE_TICKS/COUNT_MAX)/2)) {
        	            	break;
        	            }
        	  }
          	  break;
            }
          }
      }
	}
	oldcount = timer32_0_counter;
	while (1) {
      count = timer32_0_counter;
      if ((count - oldcount) > ((LED_TOGGLE_TICKS/COUNT_MAX))) {
    	  break;
      }
	}
	i++;
  }
  i=0;
  if(k==20){
	  k=0;
  }
  }

  return 0;
}
