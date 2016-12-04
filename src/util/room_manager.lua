HALF_TILE_DISTANCE = .5 * TILE_SIZE * GLOBAL_SCALE

require "src.entities.room"

RoomManager = Object:extend()

function RoomManager:new()
  self.rooms = require "data.roomdata"

  self.currentRoom = self.rooms[1]
  
  local center = self.currentRoom:getRoomCenter()
  local cameraPoint = self.currentRoom:getCameraPoint()
  player:setPosition(center)
  camera:setPosition(cameraPoint.x, cameraPoint.y)
end

function RoomManager:update(dt)
  for i, room in pairs(self.rooms) do    
    if room:containsPlayer(player.x, player.y) and room ~= self.currentRoom then
      self:swapRoom(room)
      break
    end
  end
  
  self.currentRoom:update(dt)
end

function RoomManager:draw()
  self.currentRoom:draw()
end

function RoomManager:swapRoom(room)
  for k in pairs(self.currentRoom.enemies) do
    local enemy = self.currentRoom.enemies[k]
    enemy:clearBullets()
  end
  
  player.vape:clearParticles()
  self.currentRoom = room
  
  for k in pairs(self.currentRoom.enemies) do
    local enemy = self.currentRoom.enemies[k]
    enemy.nextShotTime = love.timer.getTime() + math.random(.2, .7)
  end
  
  self:updateCamera(room)
end

function RoomManager:updateCamera(room)
  if not room.isHall then
    camera:setMode("fixed")
    local camPoint= room:getCameraPoint()
    camera:setPosition(camPoint.x, camPoint.y) -- TODO: Pan
  else
    camera:setMode("follow")
  end
end