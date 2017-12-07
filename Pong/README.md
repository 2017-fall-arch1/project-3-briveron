WELCOME TO PONG

This game is part of an assignment for computer Arch that required th following

- dynamically render graphical elements that move
-- including one original algorithmically rendered graphical element 
- handle colisions properly with other shapes and area boundaries
- produce sounds triggered by game events
-- in a manner that does not cause the game to pause
- communicate with the player using text
- include a state machine written in assembly language
- respond to user input (from buttons)

This game meets these requirements and can be played folloing these steps 

- in the main directory (before entering Pong) you will type "make" this will create the needed files to run the game
-enter pong and with the msp430 conected type "make load" this loads the program to the msp430 to be played

GAME RULES

-player one (left) will control their paddle with the left two buttons (bit 0 and bit 1) and the right player uses the right side (bit 2 and bit 3) 
-The game is played up to 9 points and first to reach it wins
