Bullet = Object:extend()

function Bullet:new(x, y, vec)
  self.x = x
  self.y = y
  self.image = Assets.energy_orb
  self.speed = 200
  self.remove = false
  vec = vec * self.speed
  self.xVelocity = vec.x
  self.yVelocity = vec.y
  self.collider = HC.rectangle(x, y, 5, 5)
  self.collider["parent"] = self
end

function Bullet:update(dt)
  self.x = self.x + self.xVelocity * dt
  self.y = self.y + self.yVelocity * dt
  self.collider:moveTo(self.x, self.y)
  self:handleCollisions()
  self:removeIfOffscreen()
end

function Bullet:removeIfOffscreen()
  if self.x < camera.x or self.x > camera.x + love.graphics.getWidth()
    or self.y < camera.y or self.y > camera.y + love.graphics.getHeight() then
      self.remove = true
    end
end

function Bullet:draw()
  love.graphics.draw(self.image, self.x, self.y)
end

function Bullet:handleCollisions()
  for shape, delta in pairs(HC.collisions(self.collider)) do
    if shape.parent == player then self.remove = true end
  end
end