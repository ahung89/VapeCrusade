SmokeParticle = Object:extend()

function SmokeParticle:new(x, y, dir)
  self.x = x
  self.y = y
  self.a = 1
  self.speed = math.random(150, 158)
  dir = dir * self.speed
  --local radians = math.random(-math.pi/6, math.pi/6)
  --local newDir = vector(dir.x * math.cos(radians) - dir.y * math.sin(radians),
  --  dir.x * math.sin(radians) + dir.y + math.cos(radians))
  self.dx = dir.x
  self.dy = dir.y
  self.da = math.random(.1, .2)
  self.ds = math.random(5, 6)
  self.radius = math.random(22, 33)
end

function SmokeParticle:update(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
  self.a = self.a - self.da * dt
  self.radius = self.radius - self.ds * dt
  if self.a <= 0 or self.radius <= 0 then
    self.remove = true
  end
end

function SmokeParticle:draw()
  love.graphics.setColor(192, 192, 192, 200)
  love.graphics.circle("fill", self.x, self.y, self.radius)
  love.graphics.setColor(255, 255, 255)
end

function SmokeParticle:handleCollisions()
  
end