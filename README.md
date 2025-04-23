# KLONDIKE SOLITAIRE

CMPM 121 Assignment 1\
Name: Kayla Nguyen\
Game Title: _Klondike Solitaire_

## IMPLEMENTATION

### PROGRAMMING PATTERNS
Some programming patterns that are being used are Commands, State, Flyweight, and Observer. I am using commands in the grabber.lua file to grab and release cards. I am managing the state of each card using state managers in card.lua. Flyweight is used for the card spritesheet to reduce the amount of files needed to render. Observer is used in my update functions of each file, where they check for state changes or conditions to be true. I am also using sequencing patterns, specifically in the update method when I program the game to update and draw cards as the user interacts with the objects.

### REFLECTION
I believe the card movement is one of my best features in this assignment. I learned how to use the update function for objects to create a drag when a player moves a mouse. As a result, the cards have a drag when a player uses their mouse to move a card. My goal was to mimic the implementation of Klondike Solitaire by Google. I also believe I did well on using a single spritesheet to create the whole card deck. This decreases the amount of files needed for the program to run. My implementation for the grabber function was difficult to apply to card objects at first, but after rearranging my code and changing the card and grabber logic, I believe my grabber works as intended (most times). However, if I were to approach this project again, I would organize my code and create pseudo code before programming anything to make sure I fully understand where I want to implement specific functions. I went through several iterations of rearranging code to make the card pickup and dropping mechanics work, which I believe would be reduced if I decided beforehand where I would implement functions. I would also add music or SFX if I were to revisit this project. 

A postmortem on what you did well and what you would do differently if you were to do this project over again (maybe some programming patterns that might have been a better fit?).

### ASSETS
Sprites: Modified spritesheet from https://dani-maccari.itch.io/cute-cards-deck \
Font: N/A \
Music: N/A
