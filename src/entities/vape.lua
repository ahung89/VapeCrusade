require "src.entities.smoke_particle"

Vape = Object:extend()

function Vape:new()
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
  
  local dir = vector(0, 0)
  if love.mouse.isDown(1) and love.timer.getTime() > self.nextParticleTime then
    local dir = vector(love.mouse.getX() - love.graphics.getWidth() / 2, love.mouse.getY() - love.graphics.getHeight() / 2):normalized()
    table.insert(self.particles, SmokeParticle(player.x, player.y, dir))
    self.nextParticleTime = love.timer.getTime() + self.timeBetweenParticles
  end
   
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
  --love.graphics.print("supp... mouse pos bay"..love.mouse.getX()..","..love.mouse.getY(), 0, 0)
  for i, v in ipairs(self.particles) do
    v:draw()
  end
end