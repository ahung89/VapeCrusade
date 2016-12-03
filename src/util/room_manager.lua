HALF_TILE_DISTANCE = .5 * TILE_SIZE * GLOBAL_SCALE

require "src.entities.room"

RoomManager = Object:extend()

function RoomManager:new()
  self.rooms = require "data.roomdata"

  self.currentRoom = self.rooms[1]
  
  local center = self.currentRoom:getRoomCenter()
  player:setPosition(center)
  camera:setPosition(self.currentRoom.x + 48, self.currentRoom.y + 48)
end

function RoomManager:updateCurrentRoom()
  for _, room in pairs(self.rooms) do
    if room:containsPlayer(player.x, player.y) then
      self:swapRoom(room)
      break
    end
  end
end

function RoomManager:swapRoom(room)
  self.currentRoom = room
  self:updateCamera(room)
end

function RoomManager:updateCamera(room)
  if room.isHall then
    camera:setMode("fixed")
    local center= room:getCenter()
    camera:setPosition(center.x, center.y) -- TODO: Pan
  else
    camera:setMode("follow")
  end
end