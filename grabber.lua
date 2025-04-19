
require "vector"
local Constants = require ("constants")

GrabberClass = {}

function GrabberClass:new()
  local grabber = {}
  local metadata = {__index = GrabberClass}
  setmetatable(grabber, metadata)
  
  grabber.previousMousePos = nil
  grabber.currentMousePos = nil
  
  grabber.grabPos = nil
  grabber.grabState = false
  
  -- NEW: we'll want to keep track of the object (ie. card) we're holding
  grabber.heldObject = nil
  grabber.snapback = false
  grabber.snapbackIndex = nil
  
  return grabber
end

function GrabberClass:update()
  self.currentMousePos = Vector(
    love.mouse.getX(),
    love.mouse.getY()
  )
  
  -- Click (just the first frame)
  if love.mouse.isDown(1) and self.grabPos == nil then
    self:grab()
    grabber.grabState = true
  end
  -- Release
  if not love.mouse.isDown(1) and self.grabPos ~= nil then
    self:release()
    grabber.grabState = false
  end  
end

function GrabberClass:grab()
  self.grabPos = self.currentMousePos
  print("GRAB - " .. tostring(self.grabPos.x) .. ", " .. tostring(self.grabPos.y))

  self.heldObject = self.grabPos
  self.heldObject.state = 1
end

function GrabberClass:release()
  -- NEW: some more logic stubs here
  if self.heldObject == nil then -- we have nothing to release
    return
  end
  
  -- TODO: eventually check if release position is invalid and if it is
  -- return the heldObject to the grabPosition
  local isValidReleasePosition = self:containsPoint(self.currentMousePos)
  if not isValidReleasePosition then
    self.heldObject.position = self.grabPosition
  end
  
  print("RELEASE - " .. tostring(self.currentMousePos.x) .. ", " .. tostring(self.currentMousePos.y))

  self.heldObject.state = 0 -- it's no longer grabbed
  
  self.heldObject = nil
  self.grabPos = nil
end

function GrabberClass:containsPoint(mousePos)

  local inBounds = false
  local pileIndex = nil

  for i = 1, 7 do
    local x = Constants.PILE_PADDING_X * i + Constants.PILE_SIZE_X * (i-1)
    local y = 200

    inBounds = mousePos.x > x and
      mousePos.x < x + Constants.PILE_SIZE_X and
      mousePos.y > y and
      mousePos.y < y + Constants.PILE_SIZE_Y

    if inBounds then
      pileIndex = i
      self.snapbackIndex = pileIndex
      print("Pile index: " .. tostring(pileIndex))
      break 
    end
  end

  if inBounds then
    self.snapback = false
    print("VALID")
    return true
  end

  print("INVALID")
  self.snapback = true
  print(tostring(self.grabPos.x) .. ", " .. tostring(self.grabPos.y))
  return false
end
