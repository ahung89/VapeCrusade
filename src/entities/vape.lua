require "src.entities.smoke_particle"

Vape = Object:extend()

function Vape:new()
  self.x = 0
  self.y= 0
  self.firing = true
  
  self.particles = {}
  self.timeBetweenParticles = .05
  self.nextParticleTime = 0
  self.emittingSmoke = false
  self.maxSmokeEmissionTime = 1
  
  self.endSmokeTime = 0
end

function Vape:fire()
  self.firing = true
end

function Vape:emitSmoke()
  
end

function love.mousereleased()
  local smokinessFraction = player.smokeMeter:getSmokinessFraction()
  local vape = player.vape
  if smokinessFraction > 0 then
    vape.emittingSmoke = true
    vape.endSmokeTime = love.timer.getTime() + vape.maxSmokeEmissionTime * smokinessFraction
    player.smokeMeter:resetSmokiness()
    vape.nextParticleTime = 0
  end
end

function Vape:update(dt)
  if not self.firing then return end
  
  self.x = player.x + 50
  self.y = player.y + 50
  
  local dir = vector(0, 0)
  
  if self.endSmokeTime < love.timer.getTime() then
    self.emittingSmoke = false
  end
  
  if player.alive and self.emittingSmoke and love.timer.getTime() > self.nextParticleTime then
    local playerScreenPos = vector(player.x - camera.x, player.y - camera.y)
    local dir = vector(love.mouse.getX() - playerScreenPos.x, love.mouse.getY() - playerScreenPos.y):normalized()
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

function Vape:clearParticles()
  for i in pairs(self.particles) do
    self.particles[i] = nil
  end
end