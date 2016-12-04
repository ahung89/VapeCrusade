TILE_SIZE = 32
COLLISION_CHECK_DISTANCE = 8
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
  enemies = {}
  
  self:loadTilemap()
  self:generateColliders()
  
  self.greyscaleShader = love.graphics.newShader[[
    extern number div;
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) 
    {
      vec4 pixel = Texel(texture, texture_coords);
      number average = (pixel.r + pixel.b + pixel.g) / 3;
      pixel.r = mix(average, pixel.r, div);
      pixel.g = mix(average, pixel.g, div);
      pixel.b = mix(average, pixel.b, div);
      return pixel * color;
    }
  ]]
end

function level:loadTilemap()
  TilemapLoader.path = "assets/tilemap/"
  self.map = TilemapLoader.load("Vape_Crusade_LD.tmx")
  self.map.useSpriteBatch = false
end

function level:generateColliders()
  self.colliders = {}
  local layer = self.map("Walls")
  
  for x, y, tile in layer:iterate() do
    if layer:get(x, y).properties.Collision then
      local rect = HC.rectangle(x * SCALED_TILE_SIZE + SCALED_TILE_SIZE/2, y * SCALED_TILE_SIZE + SCALED_TILE_SIZE / 2,
          SCALED_TILE_SIZE, SCALED_TILE_SIZE)
      rect.type = "levelCollider"
      table.insert(self.colliders, rect)
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
  
  roomManager:update(dt)
end

function level:draw()
  camera:set()
  
  self.greyscaleShader:send("div", roomManager.currentRoom:getHighModifier())
  love.graphics.setShader(self.greyscaleShader) -- enable shader (TODO: only do this if required)
  
  self.map:setDrawRange(0,0,1000000, 1000000)
  self.map:draw()
  
  player:draw(dt)
  
  for _, e in pairs(enemies) do
    e:draw(dt)
  end
  
  --for _, c in pairs(self.colliders) do
    --c:draw("line")
  --end
    
  roomManager:draw()  
  
  love.graphics.setShader() -- unsets the shader
    
  camera:unset()
end

function level:spawnEnemies()
  
end

return level