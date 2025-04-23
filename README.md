# KLONDIKE SOLITAIRE

CMPM 121 Assignment 1\
Name: Kayla Nguyen\
Game Title: _Klondike Solitaire_

## IMPLEMENTATION

### PROGRAMMING PATTERNS
Some programming patterns that are being used are Commands, State, Flyweight, and Observer. I am using commands in the grabber.lua file to grab and release cards. I am managing the state of each card using state managers in card.lua. Flyweight is used for the card spritesheet to reduce the amount of files needed to render. Observer is used in my update functions of each file, where they check for state changes or conditions to be true. I am also using sequencing patterns, specifically in the update method when I program the game to update and draw cards as the user interacts with the objects.

### REFLECTION

### ASSETS
Sprites: Modified spritesheet from https://dani-maccari.itch.io/cute-cards-deck \
Font: N/A
Music: N/A
