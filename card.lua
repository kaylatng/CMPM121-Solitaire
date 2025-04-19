
require "vector"
local Constants = require ("constants")

CardClass = {}
local backQuad

CARD_STATE = {
  IDLE = 0,
  MOUSE_OVER = 1,
  GRABBED = 2
}

function CardClass:new(xPos, yPos, index)
  local card = {}
  local metadata = {__index = CardClass}
  setmetatable(card, metadata)
  
  card.position = Vector(xPos + Constants.PADDING_X, yPos + Constants.PADDING_Y)
  card.size = Vector(100, 144)
  card.state = CARD_STATE.IDLE
  card.faceUp = false
  card.index = index

  card.prevPosition = Vector(xPos + Constants.PADDING_X, yPos + Constants.PADDING_Y)
  
  return card
end

function CardClass:load()
  spritesheet = love.graphics.newImage("assets/card_spritesheet.png")
  local quadWidth = 100
  local quadHeight = 144

  backQuad = love.graphics.newQuad(14 * quadWidth, 2 * quadHeight, quadWidth, quadHeight, spritesheet:getDimensions())
  for suit, row in pairs(Constants.SUIT_ROWS) do
    for j, rank in ipairs(Constants.RANKS) do
        local key = rank .. "_" .. suit
        
        -- Calculate position in spritesheet
        -- Using the row based on suit from SUIT_ROWS
        local column = j - 1  -- A=0, 2=1, ..., K=12
        
        cardQuads[key] = love.graphics.newQuad(
            column * quadWidth, 
            row * quadHeight,
            quadWidth, 
            quadHeight,
            spritesheet:getDimensions()
        )
    end
  end

  Constants.CARD_SIZE_X = quadWidth
  Constants.CARD_SIZE_Y = quadHeight
end


function CardClass:update()
  if love.mouse.isDown(1) and self.state == CARD_STATE.GRABBED then
    self.position = Vector(love.mouse.getX()-50, love.mouse.getY()-72)
  end
  if not love.mouse.isDown(1) and self.state == CARD_STATE.GRABBED then 
    self.state = CARD_STATE.IDLE
    self.prevPosition = self.position
  end
end

function CardClass:draw()
  -- NEW: drop shadow for non-idle cards
  if self.state ~= CARD_STATE.IDLE then
    love.graphics.setColor(0, 0, 0, 0.5) -- color values [0, 1]
    local offset = 4 * (self.state == CARD_STATE.GRABBED and 2 or 1)
    love.graphics.rectangle("fill", self.position.x + offset, self.position.y + offset, self.size.x, self.size.y, 6, 6)
  end
  
  if self.faceUp then
    love.graphics.setColor(1, 1, 1, 1)
  elseif not self.faceUp then -- back of card
    love.graphics.setColor(0.5, 0.5, 0.5, 1)
  end

  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y, 6, 6)

  -- outline
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.rectangle("line", self.position.x, self.position.y, self.size.x, self.size.y, 6, 6)
    
  love.graphics.print(tostring(self.state), self.position.x + 47, self.position.y - 20)
end

function CardClass:checkForMouseOver(grabber)
  if self.state == CARD_STATE.GRABBED then
    return
  end
    
  -- local mousePos = grabber.currentMousePos
  local isMouseOver = self:containsPoint(grabber)
    -- mousePos.x > self.position.x and
    -- mousePos.x < self.position.x + self.size.x and
    -- mousePos.y > self.position.y and
    -- mousePos.y < self.position.y + self.size.y
  
  self.state = isMouseOver and CARD_STATE.MOUSE_OVER or CARD_STATE.IDLE

  if grabber.grabState and isMouseOver then
    self.state = CARD_STATE.GRABBED
    if not self.faceUp then
      self:flip()
    end
  end
end

function CardClass:containsPoint(grabber)
  local mousePos = grabber.currentMousePos

  return mousePos.x > self.position.x and
  mousePos.x < self.position.x + self.size.x and
  mousePos.y > self.position.y and
  mousePos.y < self.position.y + self.size.y
end

function CardClass:returnToPosition(grabber)
  if grabber.snapback == true then
    self.position = self.prevPosition
  end
end

function CardClass:snapIntoPlace(grabber)
  local i = grabber.snapbackIndex
  local x = Constants.PILE_PADDING_X * i + Constants.PILE_SIZE_X * (i-1) + 10
  local y = 200 + 10

  self.position = Vector(x,y)
end

function CardClass:flip()
  self.faceUp = not self.faceUp
end
