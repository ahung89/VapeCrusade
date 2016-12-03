local level = {}
moved = false

function level:enter()
  require "src.entities.player"
  require "src.entities.camera"
  require "src.entities.enemy"
  player = Player()
  enemy = Enemy(20, 20)
  camera = Camera()
  enemies = {enemy}
end

function level:update(dt)
  player:update(dt)
  
  for _, e in pairs(enemies) do
    e:update(dt)
  end
  
  camera:setPosition(player.x - love.graphics.getWidth() / 2, player.y - love.graphics.getHeight() / 2)
end

function level:draw()
  camera:set()
  
  player:draw(dt)
  
  for _, e in pairs(enemies) do
    e:draw(dt)
  end
  
  camera:unset()
end

function level:spawnEnemies()
  
end

function level:generateColliders()
  
end

return level