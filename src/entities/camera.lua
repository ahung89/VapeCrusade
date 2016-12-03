Camera = Object:extend()

function Camera:new()
  self.x = 0
  self.y = 0
end

function Camera:set()
  love.graphics.push()
  love.graphics.translate(-self.x, -self.y)
end

function Camera:move(dx, dy)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
end

function Camera:setPosition(x, y)
  self.x = x or self.x
  self.y = y or self.y
end

function Camera:unset()
  love.graphics.pop()
end