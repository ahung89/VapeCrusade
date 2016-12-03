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

function RoomManager:update()
  for i, room in pairs(self.rooms) do
    if i == 12 then
      print("player pos:"..player.x..","..player.y)
      print("room location:"..room.x..","..room.y..","..(room.x + room.width)..","..(room.y + room.height))
      if room:containsPlayer(player.x, player.y) then
        print("room contains player!")
      else
        print("room doens't contain player :(")
      end
    end
    
    if room:containsPlayer(player.x, player.y) and room ~= self.currentRoom then
      print("room "..i.." contains player! swapping")
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
  if not room.isHall then
    camera:setMode("fixed")
    local camPoint= room:getCameraPoint()
    camera:setPosition(camPoint.x, camPoint.y) -- TODO: Pan
  else
    camera:setMode("follow")
  end
end