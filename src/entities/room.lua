ROOM_WIDTH = 10
ROOM_HEIGHT = 7

Room = Object:extend()

function Room:new(numEnemies, x, y, isHall, width, height)
  self.x = x * TILE_SIZE * GLOBAL_SCALE
  self.y = y * TILE_SIZE * GLOBAL_SCALE
  self.isHall = isHall
  if isHall then
    self.width  = width * SCALED_TILE_SIZE
    self.height = height * SCALED_TILE_SIZE
  else
    self.width = ROOM_WIDTH * SCALED_TILE_SIZE
    self.height = ROOM_HEIGHT * SCALED_TILE_SIZE
  end
  
  self.enemies = {}
  self:placeEnemies()
end

function Room:containsPlayer(x, y)
  return x >= self.x and x < self.x + self.width and y > self.y and y <= self.y + self.height
end

function Room:getRoomCenter()
  return vector(self.x + self.width / 2, self.y + self.height / 2)
end

function Room:getCameraPoint()
  return vector(self.x + 48, self.y + 48)
end

function Room:placeEnemies()
  self.enemies = {}
  for i=1, 3, 1 do
    table.insert(self.enemies, Enemy(math.random(self.x + SCALED_TILE_SIZE, self.x + self.width),
        math.random(self.y + SCALED_TILE_SIZE, self.y + self.height)))
  end
end

function Room:update(dt)
  for _, e in pairs(self.enemies) do
    e:update(dt)
  end
end

function Room:draw()
  for _, e in pairs(self.enemies) do
    e:draw()
  end
end