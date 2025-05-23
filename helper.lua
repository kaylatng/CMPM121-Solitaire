-- Helper funcs

function table.copy(t)
  local u = {}
  for k, v in pairs(t) do u[k] = v end
  return u
end

function table.shuffle(t)
  for i = #t, 2, -1 do
    local j = math.random(i)
    t[i], t[j] = t[j], t[i]
  end
  return t
end

function drawRoundedRect(x, y, width, height, radius)
  love.graphics.rectangle("fill", x, y, width, height, radius, radius)
end

function isPointInRect(x, y, rx, ry, rw, rh)
  return x >= rx and x <= rx + rw and y >= ry and y <= ry + rh
end

function getCardColor(suit)
  if suit == "hearts" or suit == "diamonds" then
    return "red"
  else
    return "black"
  end
end

function getCardValue(value)
  local valueMap = {
    ace = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
    ["9"] = 9,
    ["10"] = 10,
    jack = 11,
    queen = 12,
    king = 13
  }
  
  return valueMap[value]
end