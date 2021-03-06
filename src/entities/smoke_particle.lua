SmokeParticle = Object:extend()

function SmokeParticle:new(x, y, dir)
  -- print(x, y, dir)
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
  self.ds = math.random(.005, .0075)
  self.radius = math.random(22, 33)
  self.scale = 1
  self.created = false
  self.remove = false
end

function SmokeParticle:create()
  self.collider = HC.circle(self.x, self.y, self.radius)
  self.collider["parent"] = self
  self.created = true
end

function SmokeParticle:update(dt)
  if not self.created then
    self.create()
  end
  self:removeIfOffscreen()
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
  self.a = self.a - self.da * dt
  self.scale = self.scale - self.ds * dt
  self.radius = self.radius * self.scale
  if self.a <= 0 or self.radius <= 0 then
    self.remove = true
  end
  
  self.collider:moveTo(self.x, self.y)
  
  if self.scale < 0.02 then
    self.remove = true
  else
    self.collider:scale(self.scale)
  end
end

function SmokeParticle:removeIfOffscreen()
  if self.x < camera.x or self.x > camera.x + love.graphics.getWidth()
    or self.y < camera.y or self.y > camera.y + love.graphics.getHeight() then
      self.remove = true
    end
end

function SmokeParticle:draw()
  love.graphics.setColor(192, 192, 192, 200)
  love.graphics.circle("fill", self.x, self.y, self.radius)
  love.graphics.setColor(255, 255, 255)
  --self.collider:draw("line")
end

function SmokeParticle:handleCollision()
  for shape, delta in pairs(HC.collisions(self.collider)) do
    if shape.type == "levelCollider" then 
      self.remove = true 
    end
    
    if shape.type == "enemy" and not shape.parent.baked then
      shape.parent:makeHigh()
      self.remove = true
    end
  end
end