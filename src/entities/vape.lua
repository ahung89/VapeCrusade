require "src.entities.smoke_particle"

Vape = Object:extend()

function Vape:new()
  self.x = 0
  self.y= 0
  self.firing = true
  
  self.particles = {}
  self.timeBetweenParticles = .05
  self.nextParticleTime = 0
end

function Vape:fire()
  self.firing = true
end

function Vape:update(dt)
  if not self.firing then return end
  
  self.x = player.x + 50
  self.y = player.y + 50
  
  local dir = vector(0, 0)
  if love.mouse.isDown(1) and love.timer.getTime() > self.nextParticleTime then
    local dir = vector(love.mouse.getX() - love.graphics.getWidth() / 2, love.mouse.getY() - love.graphics.getHeight() / 2):normalized()
    table.insert(self.particles, SmokeParticle(self.x, self.y, dir))
    self.nextParticleTime = love.timer.getTime() + self.timeBetweenParticles
  end
   
  self:handleSmokeCollisions()
   
  local i = 1
   
  while i <= table.getn(self.particles) do
    self.particles[i]:update(dt)
    if self.particles[i].remove then
      table.remove(self.particles, i)
    else
      i = i + 1
    end
  end
end

function Vape:draw()
  for i, v in ipairs(self.particles) do
    v:draw()
  end
end

function Vape:handleSmokeCollisions()
  for i, v in ipairs(self.particles) do
    v:handleCollision()
  end
end