local level = {}

function level:enter()
  require "src.entities.player"
  player = Player()
end

function level:update(dt)
  player:update(dt)
end

function level:draw()
  player:draw(dt)
end

return level