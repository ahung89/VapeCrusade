Player = Object:extend()

function Player:new()
  self.x = 100
  self.y = 100
  self.health = 100
  self.img = Assets.yoshi_sprite
  self.xSpeed = 300
  self.ySpeed = 300
  self.collider = HC.rectangle(self.x, self.y, 40, 40)
  self.collider["parent"] = self
  
  self.vape = Vape()
end

function Player:update(dt)  
  local xVelocity = 0
  local yVelocity = 0
  
  if love.keyboard.isDown("a", "left") and not self:checkWallCollisions(-COLLISION_CHECK_DISTANCE, 0) then
    xVelocity = -self.xSpeed
  elseif love.keyboard.isDown("d", "right") and not self:checkWallCollisions(COLLISION_CHECK_DISTANCE, 0) then
    xVelocity = self.xSpeed
  end
  if love.keyboard.isDown("w", "up") and not self:checkWallCollisions(0, -COLLISION_CHECK_DISTANCE) then
    yVelocity = -self.ySpeed
  elseif love.keyboard.isDown("s", "down") and not self:checkWallCollisions(0, COLLISION_CHECK_DISTANCE) then
    yVelocity = self.ySpeed
  end
  self.x = self.x + xVelocity * dt
  self.y = self.y + yVelocity * dt
  
  self.collider:moveTo(self.x, self.y)
    
  self.vape:update(dt)
end

function Player:checkWallCollisions(xOffset, yOffset)
  for shape, delta in pairs(HC.collisions(HC.rectangle(self.x + xOffset, self.y + yOffset, 40, 40))) do -- delete this collider later
    if shape.type == "levelCollider" then
      return true
    end
  end
  return false
end

function Player:draw(dt)
  love.graphics.draw(Assets.yoshi_sprite, player.x, player.y, 0, .1, .1)
  self.vape:draw()
end

function Player:setPosition(pos)
  self.x = pos.x
  self.y = pos.y
end