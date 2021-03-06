require "src.entities.bullet"

Enemy = Object:extend()

MAX_BULLETS = 10

function Enemy:new(x, y)
  self.x = x
  self.y = y
  self.visionRange = 30
  self.nextShotTime = 0
  self.timeBetweenShots = 1
  self.highnessLevel = 0
  self.bullets = {}
  self.collider = HC.rectangle(self.x + 20, self.y, 36 * GLOBAL_SCALE - 40, 36 * GLOBAL_SCALE)
  self.collider.type = "enemy"
  self.collider.parent = self
  self.baked = false
  self.anim_image = Assets.henchmen
  self:setUpAnimations()
  self.audioSource = love.audio.newSource("assets/audio/fire.wav", "static")
  self.audioSource:setVolume(.7)
  
  self.soundbites = {
      Assets.audio.bro_far_out, Assets.audio.bro_pro_puff, Assets.audio.sexy_far_out,
      Assets.audio.sexy_oh_yeah, Assets.audio.so_high, Assets.audio.meek_wow_colors
  }
end

function Enemy:setUpAnimations()
  local g = anim8.newGrid(36, 36, self.anim_image:getWidth(), self.anim_image:getHeight())
  self.shootLeft = anim8.newAnimation(g("2-3", 5), .3)
  self.shootRight = anim8.newAnimation(g("2-3", 6), .3)
  self.dance = anim8.newAnimation(g("3-5", 4), .25)
  
  self.anim = self.shootLeft
end

function Enemy:update(dt)
  if not self.baked then
    self:fire()
  end
  
  local i = 1

  while i <= table.getn(self.bullets) do
    self.bullets[i]:update(dt)
    if self.bullets[i].remove then
      table.remove(self.bullets, i)
    else
      i = i + 1
    end
  end
  
  self.anim:update(dt)
end

function Enemy:canSeePlayer()
  return true
end

function Enemy:fire()
  if love.timer.getTime() < self.nextShotTime then return end
  
  love.audio.stop(self.audioSource)
  love.audio.play(self.audioSource)
  
  self.nextShotTime = love.timer.getTime() + math.random(.85, 1.25)
  local toPlayer = vector(player.x - self.x, player.y - self.y):normalized()
  table.insert(self.bullets, self:getBullet(toPlayer))
  
  if toPlayer.x <= 0 then
    self.anim = self.shootLeft
  else
    self.anim = self.shootRight
  end
end

function Enemy:getBullet(toPlayer)
  return Bullet(self.x, self.y, toPlayer)
end

function Enemy:makeHigh()
  self.highnessLevel = self.highnessLevel + 1
  
  if self.highnessLevel >= 12 and not self.baked then
    self.baked = true
    self.anim = self.dance    
    self.room.highEnemies = self.room.highEnemies + 1
    local soundIndex = math.random(1, table.getn(self.soundbites))
    love.audio.play(self.soundbites[soundIndex])
  end
end

function Enemy:canSeePlayer()
  
end

function Enemy:draw()
  self.anim:draw(self.anim_image, self.x, self.y, 0, GLOBAL_SCALE, GLOBAL_SCALE)
  
  for _, b in pairs(self.bullets) do
    b:draw()
  end
end

function Enemy:clearBullets()
  for k in pairs(self.bullets) do
    self.bullets[k] = nil
  end
end