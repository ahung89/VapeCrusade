intro = {}

function intro:enter()
  Assets.audio.music:setLooping(true)
  love.audio.play(Assets.audio.music)
  
  self.anim_image = Assets.ganja_goddess
  
  local g = anim8.newGrid(64, 64, self.anim_image:getWidth(), self.anim_image:getHeight())
  self.appear = anim8.newAnimation(g("1-7", 2, "1-4", 3), .1, startIdleAnimation)
  self.disappear = anim8.newAnimation(g("4-1", 3, "7-1", 2), .1, "pauseAtEnd")
  self.idle = anim8.newAnimation(g("1-7", 1, "6-2", 1), .25)
  self.anim = self.appear
  self.strings = {
    "Hey hey hey, Mary-Jane... you\nare the one born with the \nVapor's Soul." ,
    "I am the Ganja Goddess, and you...", 
    "You are the one destined to return \nthought and color to this world." ,
    "Take this vape. Free your mind\nwith its funky fumes, and \nthe rest will follow....."
  }
  self.currentStringIndex = 1
  self.currentStringLength = string.len(self.strings[self.currentStringIndex])
  self.currentStringOffset = 1
  
  self.nextLetterTime = 0
  self.timeBetweenLetters = .02
  self.awaitingInput = false
  self.canvas = love.graphics.newCanvas()
  
  -- TODO: extract
  self.trippyShader = love.graphics.newShader[[
    extern float time;
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
    {
      number yOffset = cos((texture_coords.x + time * 100) * 30) * .003;
      texture_coords.y += yOffset;
      vec4 pixel = Texel(texture, texture_coords);
      return pixel * color;
    }
  ]]
  
  self.font = love.graphics.newFont("assets/fonts/DisposableDroidBB.ttf", 35)
  love.graphics.setFont(self.font)
  
  --Gamestate.switch(require "src.states.level")
end

function intro:update(dt)
  self.anim:update(dt)
  if self.idleAnimationStarted and not self.awaitingInput then
    love.audio.play(Assets.audio.talking)
  end
  
  if self.awaitingInput and love.keyboard.isDown("return") then
    self.currentStringIndex = self.currentStringIndex + 1
    self.currentStringOffset = 1
    self.awaitingInput = false
    if self.currentStringIndex > table.getn(self.strings) then
      love.audio.stop(Assets.audio.talking)
      Gamestate.switch(require "src.states.level")
    end
  end
end

function intro:draw()
  self.anim:draw(self.anim_image, love.graphics.getWidth() / 2 - 120, love.graphics.getHeight() / 2 - 200, 0, 3, 3)
  
  if self.idleAnimationStarted or self.currentStringIndex > table.getn(self.strings) then
    local currString = self.strings[self.currentStringIndex]
  
    local currTime = love.timer.getTime()
  
    love.graphics.setColor(255, 255, 255)
  
    if currTime > self.nextLetterTime then
      self.currentStringOffset = self.currentStringOffset + 1
      self.nextLetterTime = currTime + self.timeBetweenLetters
    end
  
    if self.currentStringOffset == currString:len() then
      self.awaitingInput = true
      love.audio.stop(Assets.audio.talking)
    end
  
    love.graphics.setCanvas(self.canvas)
    love.graphics.clear()

    self.trippyShader:send("time", love.timer.getTime()/1000)
    love.graphics.print(currString:sub(1, self.currentStringOffset), 250, 400)
    love.graphics.setCanvas()
    
    love.graphics.setShader(self.trippyShader)
    love.graphics.draw(self.canvas)
    love.graphics.setShader()
  end
end

function startIdleAnimation()
  intro.anim = intro.idle
  intro.idleAnimationStarted = true
end

return intro