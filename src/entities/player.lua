Player = Object:extend()

function Player:new()
  self.x = 0
  self.y = 0
  self.img = Assets.yoshi_sprite
  self.xSpeed = 300
  self.ySpeed = 300
end

function Player:update(dt)
  local xVelocity = 0
  local yVelocity = 0
  if love.keyboard.isDown("a", "left") then
    xVelocity = -self.xSpeed
  elseif love.keyboard.isDown("d", "right") then
    xVelocity = self.xSpeed
  end
  if love.keyboard.isDown("w", "up") then
    yVelocity = -self.ySpeed
  elseif love.keyboard.isDown("s", "down") then
    yVelocity = self.ySpeed
  end
  self.x = self.x + xVelocity * dt
  self.y = self.y + yVelocity * dt
end

function Player:draw(dt)
  love.graphics.draw(Assets.yoshi_sprite, player.x, player.y, 0, .1, .1)
end