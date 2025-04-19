-- Zac Emerzian
-- CMPM 121 - Pickup
-- 4-11-25
io.stdout:setvbuf("no")

require "card"
require "grabber"
require "pile"

local Constants = require ("constants")

function love.load()
  love.window.setTitle("Section 02 - Klondike Solitaire")
  love.window.setMode(960, 640)
  love.graphics.setBackgroundColor(0, 0.7, 0.2, 1)
  
  grabber = GrabberClass:new()
  cardTable = {}
  pileTableau = {}
  
  for i = 1, 7 do
    local pile = PileClass:new("tableau",
      Constants.PILE_PADDING_X * i + Constants.PILE_SIZE_X * (i-1),
      Constants.PILE_POSITION_Y, 
      i)
    table.insert(pileTableau, pile)
  end

  for i = 1, 2 do
    local pile = PileClass:new("waste",
      Constants.PILE_PADDING_X * i + Constants.PILE_SIZE_X * (i-1),
      Constants.WASTE_POSITION_Y,
      i)
    table.insert(pileTableau, pile)
  end

  for i = 4, 7 do
    local pile = PileClass:new("foundation",
      Constants.PILE_PADDING_X * i + Constants.PILE_SIZE_X * (i-1),
      Constants.WASTE_POSITION_Y,
      i)
    table.insert(pileTableau, pile)
  end
  
  for i = 1, 1 do
    local card =  CardClass:new(Constants.PADDING_X + 5, Constants.PADDING_Y + 10, i)
    table.insert(cardTable, card)
  end
  
end

function love.update()
  grabber:update()
  
  checkForMouseMoving()  
  
  for _, pile in ipairs(pileTableau) do
    pile:update()
  end
  
  for _, card in ipairs(cardTable) do
    card:update()
  end
end

function love.draw()

  for _, pile in ipairs(pileTableau) do
    pile:draw()
  end
  
  for _, card in ipairs(cardTable) do
    card:draw() --card.draw(card)
  end

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print("Mouse: " .. tostring(grabber.currentMousePos.x) .. ", " .. tostring(grabber.currentMousePos.y))
end

function checkForMouseMoving()
  if grabber.currentMousePos == nil then
    return
  end
  
  for _, card in ipairs(cardTable) do
    card:checkForMouseOver(grabber)
    card:returnToPosition(grabber)
    if grabber.snapbackIndex then
      card:snapIntoPlace(grabber)
    end
  end
end