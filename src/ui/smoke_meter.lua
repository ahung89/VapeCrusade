SmokeMeter = Object:extend()

function SmokeMeter:new()
  self.maxSmokeLevel = 10
  self.deltaSmokiness = 20
  self.smokiness = 0
  self.nextWiggleTime = 0
  self.wiggleDuration = .025
  self.atRiskOfCoughing = false
  self.coughTime = 0
  self.timeToCough = .55
  self.xWiggleOffset = 0
  self.yWiggleOffset = 0
  self.coughCooldownDuration = 1.5
  self.coughCooldownEnd = 0
  Assets.audio.cough:setVolume(2)
end

function SmokeMeter:update(dt)
  if love.mouse.isDown(1) and love.timer.getTime() > self.coughCooldownEnd then
    if self.smokiness == 0 then
      love.audio.stop(Assets.audio.inhale)
      love.audio.play(Assets.audio.inhale)
    end
    self.smokiness = math.min(self.maxSmokeLevel, self.smokiness + self.deltaSmokiness * dt)
  else
    self.smokiness = math.max(0, self.smokiness - self.deltaSmokiness * .5 * dt)
  end
  
  if self.smokiness >= self.maxSmokeLevel and not self.atRiskOfCoughing then
    self.atRiskOfCoughing = true
    self.coughTime = love.timer.getTime() + self.timeToCough
  end
  
  if self.smokiness < self.maxSmokeLevel then
    self.atRiskOfCoughing = false
    self.xWiggleOffset = 0
    self.yWiggleOffset = 0
  end
  
  if self.atRiskOfCoughing then
    self:wiggle()
    if love.timer.getTime() > self.coughTime then
      self:cough()
    end
  end
end

function SmokeMeter:wiggle()
  local time = love.timer.getTime()
  if time > self.nextWiggleTime then
    self.xWiggleOffset = math.random(-4, 4)
    self.yWiggleOffset = math.random(-4, 4)
    self.nextWiggleTime = time + self.wiggleDuration
  end
end

function SmokeMeter:cough()
  love.audio.stop(Assets.audio.cough)
  love.audio.play(Assets.audio.cough)
  self.smokiness = 0
  self.atRiskOfCoughing = false
  self.coughCooldownEnd = love.timer.getTime() + self.coughCooldownDuration
end

function SmokeMeter:draw()
  local smokeBarHeight = 240 * self.smokiness / self.maxSmokeLevel
  if love.timer.getTime() < self.coughCooldownEnd then
    love.graphics.setColor(180, 0, 0, 80)
  else
    love.graphics.setColor(0, 0, 0, 150)
  end
  love.graphics.rectangle("fill", camera.x + 25 + self.xWiggleOffset, camera.y + 90 + self.yWiggleOffset, 40, 250)
  love.graphics.setColor(192, 192, 192, 150)
  love.graphics.rectangle("fill", camera.x + 30 + self.xWiggleOffset, camera.y + 95 + 240 - smokeBarHeight + self.yWiggleOffset,
    30, smokeBarHeight)
  love.graphics.setColor(255, 255, 255)
end

function SmokeMeter:getSmokinessFraction()
  return self.smokiness / self.maxSmokeLevel
end

function SmokeMeter:resetSmokiness()
  self.smokiness = 0
end