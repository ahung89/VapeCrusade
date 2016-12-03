Vape = Object:extend()

function Vape:new()
  self.firing = true
  
  self.smokePs = love.graphics.newParticleSystem(Assets.smoke, 100)
  self.smokePs:setParticleLifetime(.2, .4)
  self.smokePs:setDirection(1.5 * math.pi)
  self.smokePs:setSpread(math.pi/3)
  self.smokePs:setLinearAcceleration(0, -400)
  self.smokePs:setLinearDamping(50)
  self.smokePs:setSpin(0, 30)
  self.smokePs:setColors(82, 127, 57, 255)
  self.smokePs:setRotation(0, 2 * math.pi)
  self.smokePs:setInsertMode("random")
  self.smokePs:setSizes(1, 0)
end

function Vape:fire()
  self.firing = true
end

function Vape:update(dt)
  --if not self.firing then return end
   
  self.smokePs:setPosition(player.x + math.random(-2, 2), player.y + 10)
  self.smokePs:update(dt)
  self.smokePs:emit(1)
end

function Vape:draw()
  love.graphics.draw(self.smokePs, 0, 0, 0, 1, 1)
end