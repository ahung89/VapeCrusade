Bullet = Object:extend()

function Bullet:new(x, y, vec)
  self.x = x
  self.y = y
  self.image = Assets.energy_orb
  self.speed = 200
  vec = vec * self.speed
  self.xVelocity = vec.x
  self.yVelocity = vec.y
end

function Bullet:update(dt)
  self.x = self.x + self.xVelocity * dt
  self.y = self.y + self.yVelocity * dt
end

function Bullet:draw()
  love.graphics.draw(self.image, self.x, self.y)
end