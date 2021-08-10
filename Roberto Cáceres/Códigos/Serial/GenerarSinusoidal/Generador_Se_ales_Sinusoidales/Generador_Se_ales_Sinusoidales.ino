/*PROGRAMA DE SEÑALES SINUSOIDALES 
 * Extraído de: http://shukra.cedt.iisc.ernet.in/edwiki/Signal\_Generator\_using\_TIVA\_
microcontroller\_-\_2018
 * AD7801_FastDAC.ino  Arduining.com 18 APR 2015

Testing the Tiva C LaunchPad and the AD7801 (Parallel Input 8-Bit DAC).
Using the PORTB to write the 8-Bit data.
Using PORTA bit 2 for the write signal (WR).

Results:
6 kHz    POINTS=256   ==>  1,536 Mega-samples/sec.
96 kHz   POINTS=16    ==>  1,536 Mega-samples/sec.
Note: faster if offset is a char.( 1,9 Mega-samples/sec.)
-----------------------------------------------------------------------------*/

#include  <tm4c123gh6pm.h>    // TM4C123GE6PM Register Definitions.
#include  <math.h>            // To calculate the sine table.
#include "signals.h"

// bits 7-0 of port B address (Data).
#define ldata     (*((volatile unsigned long *)0x400053FC))
#define POINTS    1000    // Wave points.(256 max. to keep offset as char type)
#define PEAKVAL   128    // Wave Amplitud (128 max, inside 8-Bits range)
#define OFFSET    128    // Center of the wave (128 for full 8-Bits span).
#define TS        1/100

int sintable[POINTS];    // Array to load the sin table data.
int offset=0;           // index to point the data inside sintable[].


//------------------------------------------------------------------------------
void setup(){

  PortB_Init();
 // Fill the sin table with POINTS samples:
  for ( int i = 0; i <= POINTS; i++ ) {
    sintable[i] = sin(i * 3.141592 * 2*3 /(POINTS * TS) ) * (PEAKVAL-1) + OFFSET ;
  }

}

void loop(){
    //Write data to the AD7801

    ldata= sintable[offset];        // Load value in the port B.
    offset++;
    if((POINTS-offset)<=0)offset=0; // Keep offset in range.
  delay(3);           // To experiment different frequencies.
}

/*------------------------------------------------------------------------------
Subroutine to initialize port B all pins output.
Port B is used to output the data.
------------------------------------------------------------------------------*/
void PortB_Init(void){
  volatile unsigned long delay;
  SYSCTL_RCGC2_R |= 0x02;          // 1) activate Port B clock
  delay = SYSCTL_RCGC2_R;          // allow time for clock to stabilize
                                   // 2) no need to unlock PB7-0
  GPIO_PORTB_AMSEL_R &= ~0xFF;     // 3) disable analog functionality on PB7-0
  GPIO_PORTB_PCTL_R = 0x00000000;  // 4) configure PB7-0 as GPIO
  GPIO_PORTB_DIR_R |= 0xFF;        // 5) set PB7-0 as outputs
  GPIO_PORTB_AFSEL_R &= ~0xFF;     // 6) disable alt funct on PB7-0
  GPIO_PORTB_DR8R_R |= 0xFF;       // enable 8 mA drive on PB7-0
  GPIO_PORTB_DEN_R |= 0xFF;        // 7) enable digital I/O on PB7-0
}  

/*------------------------------------------------------------------------------
Subroutine to initialize port A pin 2 as output.
PA2 is used to drive the WR signal of the DAC.
------------------------------------------------------------------------------*/
