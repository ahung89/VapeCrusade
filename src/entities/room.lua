ROOM_WIDTH = 10
ROOM_HEIGHT = 7

Room = Object:extend()

function Room:new(numEnemies, x, y, isHall, width, height)
  self.x = x * TILE_SIZE * GLOBAL_SCALE
  self.y = y * TILE_SIZE * GLOBAL_SCALE
  self.isHall = isHall
  self.width = width or ROOM_WIDTH * TILE_SIZE * GLOBAL_SCALE
  self.height = height or ROOM_HEIGHT * TILE_SIZE * GLOBAL_SCALE
  self.enemies = {}
end

function Room:containsPlayer(x, y)
  return x >= self.x and x < self.x + self.width and y >= self.y and self.y >= self.y + self.height
end

function Room:getRoomCenter()
  return vector(self.x + self.width / 2, self.y + self.height / 2)
end

function Room:placeEnemies()
  self.enemies = {}
  for i=1, self.numEnemies, 1 do
    table.insert(self.enemies, Enemy(math.random(self.x + TILE_SIZE * GLOBAL_SCALE, self.x + self.width + TILE_SIZE * GLOBAL_SCALE),
        math.random(self.y + TILE_SIZE * GLOBAL_SCALE, self.y + self.width + TILE_SIZE * GLOBAL_SCALE)))
  end
end

function Room:update(dt)
  for _, e in pairs(self.enemies) do
    e:update(dt)
  end
end