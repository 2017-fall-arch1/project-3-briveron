#include <msp430.h>
#include "switches.h"
#include "led.h"
#include "buzzer.h"

char switch_state_down1, switch_state_down2,switch_state_down3,switch_state_down4, switch_state_changed,playing; /* effectively boolean */

static char 
switch_update_interrupt_sense()
{
  char p1val = P2IN;
  /* update switch interrupt to detect changes from current buttons */
  P2IES |= (p1val & SWITCHES);	/* if switch up, sense down */
  P2IES &= (p1val | ~SWITCHES);	/* if switch down, sense up */
  return p1val;
}

void 
switch_init()			/* setup switch */
{  
  P2REN |= SWITCHES;		/* enables resistors for switches */
  P2IE = SWITCHES;		/* enable interrupts from switches */
  P2OUT |= SWITCHES;		/* pull-ups for switches */
  P2DIR &= ~SWITCHES;		/* set switches' bits for input */
  switch_update_interrupt_sense();
  switch_interrupt_handler();	/* to initially read the switches */
}

void
switch_interrupt_handler()
{
  char p1val = switch_update_interrupt_sense();
  switch_state_down1 = (p1val & SW1) ? 0 : 1;
  switch_state_down2 = (p1val & SW2) ? 0 : 1;
  switch_state_down3 = (p1val & SW3) ? 0 : 1;
  switch_state_down4 = (p1val & SW4) ? 0 : 1;
  
  /*
  switch_state_down1 = (p1val & SW1) ? 0 : 1; // 0 when SW1 is up 
        if(switch_state_down1==1){
        switch_state_changed = 1;
        song_1();
        led_update;
      }
      
  switch_state_down2 = (p1val & SW2) ? 0 : 1;
        if(switch_state_down2==1){
        switch_state_changed = 1;
        song_2();
        led_update;
      }
  //switch_state_down2 = (p1val & SW2) ? 0 : 1;    
  switch_state_down3 = (p1val & SW3) ? 0 : 1;
   if(switch_state_down3==1){
        switch_state_changed = 1;
        song_3();
        led_update;
      }

  switch_state_down4 = (p1val & SW4) ? 0 : 1;
     if(switch_state_down4==1){
        switch_state_changed = 1;
        song_4();
        led_update;
      }
  */
  switch_state_changed = 1;
  led_update();
  
}
