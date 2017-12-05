/** \file shapemotion.c
 *  \brief This is a simple shape motion demo.
 *  This demo creates two layers containing shapes.
 *  One layer contains a rectangle and the other a circle.
 *  While the CPU is running the green LED is on, and
 *  when the screen does not need to be redrawn the CPU
 *  is turned off along with the green LED.
 */  
#include <msp430.h>
#include <libTimer.h>
#include <lcdutils.h>
#include <lcddraw.h>
#include <p2switches.h>
#include <shape.h>
#include <abCircle.h>
#include <stdlib.h>
#include "buzzer.h"

#define GREEN_LED BIT6

AbRect rectFence= {abRectGetBounds, abRectCheck, {1,70}};
AbRect leftPad= {abRectGetBounds, abRectCheck, {2,20}};
AbRect rightPad= {abRectGetBounds, abRectCheck, {2,20}};

AbRectOutline fieldOutline = {	/* playing field */
  abRectOutlineGetBounds, abRectOutlineCheck,   
  {screenWidth/2 -1, screenHeight/2 -10}// -1 ,-10
};

Layer Fence = {//Fence
  (AbShape *)&rectFence,
  {(screenWidth/2), (screenHeight/2)}, /**< bit below & right of center */
  {0,0}, {0,0},				    /* last & next pos */
  COLOR_WHITE,
  0, //0
};

Layer layer3 = {		/**< play ball */
  (AbShape *)&circle4,
  {(screenWidth/2)+10, (screenHeight/2)+5}, /**< bit below & right of center */
  {0,0}, {0,0},				    /* last & next pos */
  COLOR_WHITE,
  &Fence,
};


Layer fieldLayer = {		/* playing field as a layer */
  (AbShape *) &fieldOutline,
  {screenWidth/2, screenHeight/2},/**< center */
  {0,0}, {0,0},				    /* last & next pos */
  COLOR_WHITE,
  &layer3
};


Layer layer1 = {		/**< Layer with rightPad */
  (AbShape *)&rightPad,
  {screenWidth/2+60, screenHeight/2}, /**< center */
  {0,0}, {0,0},				    /* last & next pos */
  COLOR_RED,
  &fieldLayer,
};

Layer layer0 = {		/**< Layer with leftPad */
  (AbShape *)&leftPad,//leftPad
  {(screenWidth/2)-60, (screenHeight/2)}, /**< bit below & right of center */
  {0,0}, {0,0},				    /* last & next pos */
  COLOR_ORANGE,
  &layer1,
};

/** Moving Layer
 *  Linked list of layer references
 *  Velocity represents one iteration of change (direction & magnitude)
 */
typedef struct MovLayer_s {
  Layer *layer;
  Vec2 velocity;
  struct MovLayer_s *next;
} MovLayer;

/* initial value of {0,0} will be overwritten */
MovLayer ml3 = { &layer3, {4,4}, 0 }; /**< not all layers move */
MovLayer ml1 = { &layer1, {0,0}, &ml3 };//leftPad
MovLayer ml0 = { &layer0, {0,0}, &ml1 };//RigthPad



void movLayerDraw(MovLayer *movLayers, Layer *layers)
{
  int row, col;
  MovLayer *movLayer;
  
  and_sr(~8);			/**< disable interrupts (GIE off) */
  
  for (movLayer = movLayers; movLayer; movLayer = movLayer->next) { /* for each moving layer */
    Layer *l = movLayer->layer;
    l->posLast = l->pos;
    l->pos = l->posNext;
  }
  or_sr(8);//8			/**< disable interrupts (GIE on) */


  for (movLayer = movLayers; movLayer; movLayer = movLayer->next) { /* for each moving layer */
    Region bounds; 
    layerGetBounds(movLayer->layer, &bounds);
    lcd_setArea(bounds.topLeft.axes[0], bounds.topLeft.axes[1], 
		bounds.botRight.axes[0], bounds.botRight.axes[1]);
    for (row = bounds.topLeft.axes[1]; row <= bounds.botRight.axes[1]; row++) {
      for (col = bounds.topLeft.axes[0]; col <= bounds.botRight.axes[0]; col++) {
	Vec2 pixelPos = {col, row};
	u_int color = bgColor;
	Layer *probeLayer;
	for (probeLayer = layers; probeLayer; 
	     probeLayer = probeLayer->next) { /* probe all layers, in order */
	  if (abShapeCheck(probeLayer->abShape, &probeLayer->pos, &pixelPos)) {
	    color = probeLayer->color;
	    break; 
	  } /* if probe check */
	} // for checking all layers at col, row
	lcd_writeColor(color); 
      } // for col
    } // for row
  } // for moving layer being updated
}	  



//Region fence = {{10,30}, {SHORT_EDGE_PIXELS-10, LONG_EDGE_PIXELS-10}}; /**< Create a fence region */

/** Advances a moving shape within a fence
 *  
 *  \param ml The moving shape to be advanced
 *  \param fence The region which will serve as a boundary for ml
 */
void mlAdvance(MovLayer *ml, Region *fence)
{
  Vec2 newPos;
  u_char axis;
  Region shapeBoundary;
  for (; ml; ml = ml->next) {
      
    vec2Add(&newPos, &ml->layer->posNext, &ml->velocity);
    abShapeGetBounds(ml->layer->abShape, &newPos, &shapeBoundary);
    for (axis = 0; axis < 2; axis ++) {
      if ((shapeBoundary.topLeft.axes[axis] < fence->topLeft.axes[axis]) ||
	  (shapeBoundary.botRight.axes[axis] > fence->botRight.axes[axis]) ) {
	int velocity = ml->velocity.axes[axis] = -ml->velocity.axes[axis];
    newPos.axes[axis] += (2*velocity);
      }	/**< if outside of fence */
      
    } /**< for axis */
    ml->layer->posNext = newPos;
  } /**< for ml */
}


void p1_UP_DOWN(u_int sw) 
{
    if(!(sw & (1<<0))) //   if(!(sw & (1<<0))) 
    {
        ml0.velocity.axes[1] = -5;
    }
    else if(!(sw & (1<<1))) {
        ml0.velocity.axes[1] = 5;
    }
    else 
    {
        ml0.velocity.axes[1] = 0;
    }
}

void p2_UP_DOWN(u_int sw) {
    if(!(sw & (1<<2)))
    {
        ml1.velocity.axes[1] = -5;
    }
    else if(!(sw & (1<<3))) 
    {
        ml1.velocity.axes[1] = 5;
    }
    else 
    {
        ml1.velocity.axes[1] = 0;
    }
}


void collision1() 
{
    if((layer3.pos.axes[1]  >= (layer1.pos.axes[1]-1))
     && (layer3.pos.axes[0] <= (layer1.pos.axes[0]+15))
     && (layer3.pos.axes[0] >= (layer1.pos.axes[0]-15))) 
    {
    bounce1();
    layer3.posNext.axes[1] -= 4;
    ml3.velocity.axes[1] = -ml3.velocity.axes[1];
         
    }
}


void collision2() 
{
    if((layer3.pos.axes[1]  >= (layer0.pos.axes[1]+1))
     && (layer3.pos.axes[0] <= (layer0.pos.axes[0]+15))
     && (layer3.pos.axes[0] >= (layer0.pos.axes[0]-15))) 
    {
    bounce1();
    layer3.posNext.axes[1] -= 4;
    ml3.velocity.axes[1] = -ml3.velocity.axes[1];
         
    }
}

u_int bgColor = COLOR_BLACK;     /**< The background color */
int redrawScreen = 1;           /**< Boolean for whether screen needs to be redrawn */

Region fieldFence;		/**< fence around playing field  */
Region pad1;
Region pad2;

char points1=0;
char points2=0;


/** Initializes everything, enables interrupts and green LED, 
 *  and handles the rendering for the screen
 */
void main()
{
  P1DIR |= GREEN_LED;		/**< Green led on when CPU on */		
  P1OUT |= GREEN_LED;

  configureClocks();
  lcd_init();
  shapeInit();
  buzzer_init();
  p2sw_init(15);
  shapeInit();
  layerInit(&layer0);
  layerDraw(&layer0);
  layerGetBounds(&fieldLayer, &fieldFence);
  drawString5x7(50,1, "SCORE", COLOR_WHITE, COLOR_GRAY);
  enableWDTInterrupts();      /**< enable periodic interrupt */
  or_sr(0x8);/**< GIE (enable interrupts) */

  u_int sw;
  
  
  for(;;) { 
      
      sw = p2sw_read(); //added----------
      
      
    while (!redrawScreen) { /**< Pause CPU if screen doesn't need updating */
      P1OUT &= ~GREEN_LED;    /**< Green led off witHo CPU */
      or_sr(0x10);	      /**< CPU OFF */
    }
    
    p1_UP_DOWN(sw);
    p2_UP_DOWN(sw);
    collision1();
    collision2();
    
    P1OUT |= GREEN_LED;       /**< Green led on when CPU on */
    redrawScreen = 0;
    movLayerDraw(&ml0, &layer0);
  }

}

/** Watchdog timer interrupt handler. 15 interrupts/sec */
void wdt_c_handler()
{
  static short count = 0;
  P1OUT |= GREEN_LED;		      /**< Green LED on when cpu on */
  count ++;
  if (count == 15) {
    mlAdvance(&ml0, &fieldFence);
    if (p2sw_read())
      redrawScreen = 1;
    count = 0;
  } 
  P1OUT &= ~GREEN_LED;		    /**< Green LED off when cpu off */
}
