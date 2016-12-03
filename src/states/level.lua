TILE_SIZE = 32
COLLISION_CHECK_DISTANCE = 10
GLOBAL_SCALE = 3
SCALED_TILE_SIZE = TILE_SIZE * GLOBAL_SCALE

level = {}
moved = false

function level:enter()
  require "src.entities.vape"
  require "src.entities.player"
  require "src.entities.camera"
  require "src.entities.enemy"
  require "src.util.room_manager"
  player = Player()
  enemy = Enemy(20, 20)
  camera = Camera()
  roomManager = RoomManager()
  enemies = {enemy}
  
  self:loadTilemap()
  self:generateColliders()
end

function level:loadTilemap()
  TilemapLoader.path = "assets/tilemap/"
  self.map = TilemapLoader.load("Level_Design.tmx")
  self.map.useSpriteBatch = false
end

function level:generateColliders()
  self.colliders = {}
  local layer = self.map("Walls")
  
  for x, y, tile in layer:iterate() do
    if layer:get(x, y).properties.collider then
      local rect = HC.rectangle(x * SCALED_TILE_SIZE, y * SCALED_TILE_SIZE,
          SCALED_TILE_SIZE, SCALED_TILE_SIZE)
      print("player is at "..player.x..", "..player.y)
      print("making collider at "..(x * SCALED_TILE_SIZE)..", "..(y * SCALED_TILE_SIZE))
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
  
  if camera.mode == "follow" then
    camera:setPosition(player.x - love.graphics.getWidth() / 2, player.y - love.graphics.getHeight() / 2)
  end
end

function level:draw()
  camera:set()
  
  self.map:setDrawRange(0,0,1000000, 1000000)
  -- self.map:autoDrawRange(0, 0, 1, 0)
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