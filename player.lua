xSpeed = 100
ySpeed = 100

player = {
  x = 0,
  y = 0
}

function player:update(dt)
  xVelocity = 0
  yVelocity = 0
  if love.keyboard.isDown("a", "left") then
    xVelocity = -xSpeed
  elseif love.keyboard.isDown("d", "right") then
    xVelocity = xSpeed
  end
  if love.keyboard.isDown("w", "up") then
    yVelocity = -ySpeed
  elseif love.keyboard.isDown("s", "down") then
    yVelocity = ySpeed
  end
  self.x = self.x + xVelocity * dt
  self.y = self.y + yVelocity * dt
end
