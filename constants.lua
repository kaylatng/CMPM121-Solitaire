
local Constants = {

  PADDING_X = 10,
  PADDING_Y = 10,

  PILE_POSITION_X = 240,
  PILE_POSITION_Y = 200,
  PILE_SIZE_X = 120,
  PILE_SIZE_Y = 164,
  PILE_PADDING_X = 15,

  WASTE_POSITION_X = 240,
  WASTE_POSITION_Y = 20,

  CARD_SIZE_X = 100,
  CARD_SIZE_Y = 144,
  CARD_OFFSET_PILE_X = 10,
  CARD_OFFSET_PILE_Y = 20,

  SUITS = {"spades", "diamonds", "clubs", "hearts"},
  COLORS = {
    spades = "black",
    diamonds = "red",
    clubs = "black",
    hearts = "red"},
  RANKS = {"A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"},
  SUIT_ROWS = {
    spades = 0,
    diamonds = 1,
    clubs = 2,
    hearts = 3,
  },

  DRAW_COUNT = 3,
  SPRITESHEET_COLS = 15,
  SPRITESHEET_ROWS = 4,

}

return Constants