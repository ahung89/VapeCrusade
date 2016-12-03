TILE_DIMENSION = 32
COLLISION_CHECK_DISTANCE = 10

level = {}
moved = false

function level:enter()
  require "src.entities.vape"
  require "src.entities.player"
  require "src.entities.camera"
  require "src.entities.enemy"
  player = Player()
  enemy = Enemy(20, 20)
  camera = Camera()
  enemies = {enemy}
  
  self:loadTilemap()
  self:generateColliders()
end

function level:loadTilemap()
  TilemapLoader.path = "assets/tilemap/"
  self.map = TilemapLoader.load("testmap.tmx")
  self.map.useSpriteBatch = false
end

function level:generateColliders()
  self.colliders = {}
  local layer = self.map("Colliders")
  
  for x, y, tile in layer:iterate() do
    if layer:get(x, y).properties.collider then
      local rect = HC.rectangle(x * TILE_DIMENSION, y * TILE_DIMENSION,
          TILE_DIMENSION, TILE_DIMENSION)
      rect.type = "levelCollider"
      table.insert(self.colliders, rect)
      -- TODO: generate a fixture so I can use World:rayCast
    end
  end
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
  
  --self.map:setDrawRange(0,0,love.graphics.getWidth(), love.graphics.getHeight())
  self.map:draw()
  
  player:draw(dt)
  
  for _, e in pairs(enemies) do
    e:draw(dt)
  end
    
  camera:unset()
end

function level:spawnEnemies()
  
end

return level