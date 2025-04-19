
require "vector"
local Constants = require ("constants")

PileClass = {}

function PileClass:new(pileType, xPos, yPos, pileNum)
  local pile = {}
  local metadata = {__index = PileClass}
  setmetatable(pile, metadata)

  pile.position = Vector(xPos, yPos)
  pile.size = Vector(Constants.PILE_SIZE_X, Constants.PILE_SIZE_Y)
  pile.pileType = pileType -- tableau, waste, foundation
  pile.pileNum = pileNum

  return pile
end

function PileClass:update()
  self:validDrop()
end

function PileClass:draw()
  -- Outline
  love.graphics.setColor(1, 1, 1, 0.5)
  love.graphics.rectangle("line", self.position.x, self.position.y, self.size.x, self.size.y, 4, 4)
end

function PileClass:validDrop()
  local mousePos = Vector(love.mouse.getX(), love.mouse.getY())
  if self:containsPoint(mousePos) then
    return true
  end
  return false
end

function PileClass:containsPoint(mousePos)
  -- local width = Constants.PILE_SIZE_X
  -- local height = Constants.PILE_SIZE_Y
  
  return mousePos.x > self.position.x and
  mousePos.x < self.position.x + self.size.x and
  mousePos.y > self.position.y and
  mousePos.y < self.position.y + self.size.y
end
