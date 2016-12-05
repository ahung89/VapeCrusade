menu = {}

function menu:enter()
  self.cloudScaleMultiplier = 1
  self.cloudScaleMultiplierFlux = .2
  self.cloudY = 440
  self.cloudX = 250
  self.startSelected = true
  
  self.title_image = Assets.title
  self.start_image = Assets.start
  self.quit_image = Assets.quit
  self.cloud_image = Assets.cloud_pointer
  self:setupAnimations()
  
  Assets.audio.menu_song:setLooping(true)
  love.audio.play(Assets.audio.menu_song)
end

function menu:update(dt)
  if love.keyboard.isDown("up", "w") then
    self.startSelected = true
    self.cloudY = 440
    self.start_anim:gotoFrame(1)
    self.quit_anim:gotoFrame(2)
    -- go to frame for the two labels
  elseif love.keyboard.isDown("down", "s") then
    self.startSelected = false
    self.cloudY = 525
    self.start_anim:gotoFrame(2)
    self.quit_anim:gotoFrame(1)
    -- go to frame for the two labels
  end
  
  if love.keyboard.isDown("return") then
    if self.startSelected then
      love.audio.play(Assets.audio.button_click)
      love.audio.stop(Assets.audio.menu_song)
      Gamestate.switch(require "src.states.intro")
    else
      love.audio.play(Assets.audio.button_click)
      love.event.quit()
    end
  end
  
  self.cloudScaleMultiplier = 1 + math.sin(love.timer.getTime() * 5) * self.cloudScaleMultiplierFlux
  self.cloud_anim:update(dt)
  self.title_anim:update(dt)
  --self.start_anim:update(dt)
  --self.quit_anim:update(dt)
end

function menu:setupAnimations()
  local cloudGrid = anim8.newGrid(32, 32, 64, 64)
  self.cloud_anim = anim8.newAnimation(cloudGrid("1-2", 1, "1-2", 2), .2)
  local startGrid = anim8.newGrid(136, 136, self.start_image:getWidth(), self.start_image:getHeight())
  self.start_anim = anim8.newAnimation(startGrid("1-2", 1), .1)
  local quitGrid = anim8.newGrid(96, 96, self.quit_image:getWidth(), self.quit_image:getHeight())
  self.quit_anim = anim8.newAnimation(quitGrid("1-2", 1), .1)
  self.quit_anim:gotoFrame(2)
  local titleGrid = anim8.newGrid(306, 306, self.title_image:getWidth(), self.title_image:getHeight())
  self.title_anim = anim8.newAnimation(titleGrid("1-2", 1, "1-2", 2), .2)
end

function menu:draw()
  local cloudScale = 1
  local scale = 2
  
  self.cloud_anim:draw(self.cloud_image, self.cloudX, self.cloudY, 0, cloudScale, cloudScale)
  self.title_anim:draw(self.title_image, 180, -235, 0, scale, scale)
  self.start_anim:draw(self.start_image, 325, 430, 0, scale, scale)
  self.quit_anim:draw(self.quit_image, 325, 515, 0, scale, scale)
end

return menu