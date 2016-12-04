Player = Object:extend()

function Player:new()
  self.x = 100
  self.y = 100
  self.health = 100
  self.xSpeed = 300
  self.ySpeed = 300
  self.collider = HC.rectangle(self.x, self.y, 40, 40)
  self.collider["parent"] = self
  self.anim_image = Assets.mary_jane
  self:setUpAnimations()
  
  self.vape = Vape()
end

function Player:setUpAnimations()
  local g = anim8.newGrid(36, 36, self.anim_image:getWidth(), self.anim_image:getHeight())
  self.idle = anim8.newAnimation(g(1, 1), .1)
  self.walkForward = anim8.newAnimation(g("1-7", 1), .1)
  self.walkBackward = anim8.newAnimation(g("1-7", 2), .1)
  self.walkLeft = anim8.newAnimation(g("1-7", 3), .1)
  self.walkRight = anim8.newAnimation(g("1-7", 3), .1)
  
  self.currentAnim = self.idle
end

function Player:update(dt)  
  local xVelocity = 0
  local yVelocity = 0
  
  if love.keyboard.isDown("a", "left") and not self:checkWallCollisions(-COLLISION_CHECK_DISTANCE, 0) then
    xVelocity = -self.xSpeed
    self.currentAnim = self.walkLeft
  elseif love.keyboard.isDown("d", "right") and not self:checkWallCollisions(COLLISION_CHECK_DISTANCE, 0) then
    xVelocity = self.xSpeed
    self.currentAnim = self.walkRight
  end
  if love.keyboard.isDown("w", "up") and not self:checkWallCollisions(0, -COLLISION_CHECK_DISTANCE) then
    yVelocity = -self.ySpeed
    self.currentAnim = self.walkBackward
  elseif love.keyboard.isDown("s", "down") and not self:checkWallCollisions(0, COLLISION_CHECK_DISTANCE) then
    yVelocity = self.ySpeed
    self.currentAnim = self.walkForward
  end
  
  if xVelocity == 0 and yVelocity == 0 then
    self.currentAnim = self.idle
  end
  
  self.x = self.x + xVelocity * dt
  self.y = self.y + yVelocity * dt
  
  self.collider:moveTo(self.x, self.y)
    
  self.vape:update(dt)
  self.currentAnim:update(dt)
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
  self.currentAnim:draw(self.anim_image, player.x, player.y, 0, GLOBAL_SCALE, GLOBAL_SCALE)
  self.vape:draw()
end

function Player:setPosition(pos)
  self.x = pos.x
  self.y = pos.y
end