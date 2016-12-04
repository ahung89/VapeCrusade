Player = Object:extend()

function Player:new()
  self.x = 0
  self.y = 0
  self.health = 100
  self.xSpeed = 300
  self.ySpeed = 300
  self.collider = HC.rectangle(self.x + 52, self.y + 60, 36 * GLOBAL_SCALE - 65, 36 * GLOBAL_SCALE - 15)
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
  local x1, y1, x2, y2 = self.collider:bbox()
  
  if love.keyboard.isDown("a", "left") and not self:checkWallCollisions(x1 - COLLISION_CHECK_DISTANCE, y1) then
    xVelocity = -self.xSpeed
    self.currentAnim = self.walkLeft
  elseif love.keyboard.isDown("d", "right") and not self:checkWallCollisions(x1 + COLLISION_CHECK_DISTANCE, y1) then
    xVelocity = self.xSpeed
    self.currentAnim = self.walkRight
  end
  if love.keyboard.isDown("w", "up") and not self:checkWallCollisions(x1, y1 - COLLISION_CHECK_DISTANCE) then
    yVelocity = -self.ySpeed
    self.currentAnim = self.walkBackward
  elseif love.keyboard.isDown("s", "down") and not self:checkWallCollisions(x1, y1 + COLLISION_CHECK_DISTANCE) then
    yVelocity = self.ySpeed
    self.currentAnim = self.walkForward
  end
  
  if xVelocity == 0 and yVelocity == 0 then
    self.currentAnim = self.idle
  end
  
  self.x = self.x + xVelocity * dt
  self.y = self.y + yVelocity * dt
  
  self.collider:moveTo(self.x + 54, self.y + 58)
    
  self.vape:update(dt)
  self.currentAnim:update(dt)
end

function Player:checkWallCollisions(x, y)
  for shape, delta in pairs(HC.collisions(HC.rectangle(x, y, 36 * GLOBAL_SCALE - 78, 36 * GLOBAL_SCALE - 28))) do -- delete this collider later
    if shape.type == "levelCollider" then
      return true
    end
  end
  return false
end

function Player:draw(dt)
  self.currentAnim:draw(self.anim_image, self.x, self.y, 0, GLOBAL_SCALE, GLOBAL_SCALE)
  self.vape:draw()
  self.collider:draw("line")
end

function Player:setPosition(pos)
  self.x = pos.x
  self.y = pos.y
  self.collider:moveTo(self.x, self.y)
end