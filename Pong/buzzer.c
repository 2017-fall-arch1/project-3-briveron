#include <msp430.h>
#include "libTimer.h"
#include "buzzer.h"
#include "switches.h"

#define MIN_PERIOD 1000
#define MAX_PERIOD 4000

#define c8 4186
#define d8 4698
#define e8 5274
#define f8 5587
#define g8 6271
#define a8 7040
#define b8 7902
#define r 0
static unsigned int period=1000;
static signed int rate =200;
static int n=0;


static int Song1[]={c8,d8,e8,f8,g8,a8,b8,c8,r,d8,e8,f8,g8,a8,b8,c8,d8,e8,f8,g8,a8,b8,r,a8,b8,c8,r,r,r,r,r,b8,f8,c8,d8,e8,f8,g8,a8,b8,c8,r,d8,e8,f8};

static int Song2[]={f8,g8,f8,g8,f8,g8,f8,g8,f8,g8,f8,g8,f8,g8,f8,g8,e8,e8,f8,g8,f8,g8,f8,g8,f8,g8,e8};

static int Song3[]={c8,d8,e8,f8,g8,a8,b8,b8,a8,g8,f8,e8,d8,c8,c8,d8,e8,f8,g8,a8,b8,b8,a8,g8,f8,e8,d8,c8,c8,d8,e8,f8,g8,a8,b8,b8,a8,g8,f8,e8,d8,c8,c8,d8,e8,f8,g8,a8,b8,b8,a8,g8,f8,e8,d8,c8};

static int Song4[]={c8,d8,e8,f8,g8,a8,b8,c8,d8,e8,f8,g8,a8,b8,c8,d8,e8,f8,g8,a8,b8};

void buzzer_init()
{
    timerAUpmode();		/* used to drive speaker */
    P2SEL2 &= ~(BIT6 | BIT7);
    P2SEL &= ~BIT7; 
    P2SEL |= BIT6;
    P2DIR = BIT6;		/* enable output to speaker (P2.6) */

    //buzzer_set_period(0);	/* start buzzing!!! */
    //buzzer_advance_frequency();
}
void song_1()
{
    if(n==sizeof(Song1)){
        n=0;
    }
    period=Song1[n];
    buzzer_set_period(period);
    n++;
    
    //buzzer_init();
    //buzzer_set_period(2000);
    //buzzer_advance_frequency();
    //for(int x=0;x<50;x++); Trying to slow it down
}
void song_2(){
    //buzzer_init();
    //buzzer_set_period(1000);
    if(n==sizeof(Song2)){
        n=0;
    }
    period=Song2[n];
    buzzer_set_period(period);
    n++;
}
void song_3()
{
    if(n==sizeof(Song3)){
        n=0;
    }
    period=Song3[n];
    buzzer_set_period(period);
    n++;
    
}
void song_4()
{
    if(n==sizeof(Song4)){
        n=0;
    }
    period=Song4[n];
    buzzer_set_period(period);
    n++;
}

void buzzer_advance_frequency() 
{
  period += rate;
  if ((rate > 0 && (period > MAX_PERIOD)) || 
      (rate < 0 && (period < MIN_PERIOD))) {
    rate = -rate;
    period += (rate << 1);
  }
  buzzer_set_period(period);
}

void buzzer_set_period(short cycles)
{
  CCR0 = cycles; 
  CCR1 = cycles >> 1;		/* one half cycle */
}


    
    
  

