menu = {}

function menu:enter()
  self.cloudScaleMultiplier = 1
  self.cloudScaleMultiplierFlux = .5
  self.cloudY = 400
  self.cloudX = 200
  self.startSelected = true
  
  self.title_image = Assets.title_image
  self.start_image = Assets.start_image
  self.quit_image = Assets.quit_image
  self.cloud_image = Assets.cloud_image
end

function menu:update(dt)
  if love.keyboard.isDown("up") then
    self.startSelected = true
  elseif love.keyboard.isDown("down") then
    self.startSelected = false
  end
  
  self.cloudScaleMultiplier = 1 + math.sin(love.timer.getTime()) * self.cloudScaleMultiplierFlux
end

function menu:draw()
  local cloudScale = GLOBAL_SCALE * (1 + cloudScaleMultiplier)
  love.graphics.draw(self.cloud_image, self.cloudX, self.cloudY, 0, cloudScale, cloudScale)
end

return menu