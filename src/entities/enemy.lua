require "src.entities.bullet"

Enemy = Object:extend()

MAX_BULLETS = 10

function Enemy:new(x, y)
  self.x = x
  self.y = y
  self.visionRange = 30
  self.nextShotTime = 0
  self.timeBetweenShots = 1
  self.image = Assets.goomba
  self.highnessLevel = 0
  self.bullets = {}
end

function Enemy:isOnScreen()
  
end

function Enemy:update(dt)
  --if lume.distance(self.x, self.y, player.x, player.y) <= self.visionRange then
    self:fire()
  --end
  
  local i = 1

  while i <= table.getn(self.bullets) do
    self.bullets[i]:update(dt)
    if self.bullets[i].remove then
      table.remove(self.bullets, i)
    else
      i = i + 1
    end
  end
end

function Enemy:canSeePlayer()
  return true
end

function Enemy:fire()
  if love.timer.getTime() < self.nextShotTime then return end
  
  self.nextShotTime = love.timer.getTime() + self.timeBetweenShots
  local toPlayer = vector(player.x - self.x, player.y - self.y):normalized()
  table.insert(self.bullets, self:getBullet(toPlayer))
end

function Enemy:getBullet(toPlayer)
  return Bullet(self.x, self.y, toPlayer)
end

function Enemy:makeHigh()
  -- change animations
end

function Enemy:canSeePlayer()
  
end

function Enemy:draw()
  love.graphics.draw(self.image, self.x, self.y)
  
  for _, b in pairs(self.bullets) do
    b:draw()
  end
end

