SmokeMeter = Object:extend()

function SmokeMeter:new()
  self.maxSmokeLevel = 10
  self.deltaSmokiness = 8
  self.smokiness = 0
end

function SmokeMeter:update(dt)
  if love.mouse.isDown(1) then
    self.smokiness = math.min(self.maxSmokeLevel, self.smokiness + self.deltaSmokiness * dt)
  else
    self.smokiness = math.max(0, self.smokiness - self.deltaSmokiness * .5 * dt)
  end
end

function SmokeMeter:draw()
  local smokeBarHeight = 240 * self.smokiness / self.maxSmokeLevel
  love.graphics.setColor(0, 0, 0, 150)
  love.graphics.rectangle("fill", camera.x + 25, camera.y + 90, 40, 250)
  love.graphics.setColor(0, 180, 0, 150)
  love.graphics.rectangle("fill", camera.x + 30, camera.y + 95 + 240 - smokeBarHeight, 30, smokeBarHeight)
  love.graphics.setColor(255, 255, 255)
end