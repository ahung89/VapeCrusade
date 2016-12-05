HealthBar = Object:extend()

function HealthBar:new()
    self.distanceBetweenHearts = 60
end

function HealthBar:draw()
  local x = 10
  local y = 10
  love.graphics.setColor(255, 0, 0, 255)
  for i=1, 7, 1 do
    if i <= player.health then
      love.graphics.draw(Assets.heart_filled, camera.x + x, camera.y + y, 0, GLOBAL_SCALE - 1, GLOBAL_SCALE - 1)
    else
      love.graphics.draw(Assets.heart_empty, camera.x + x, camera.y + y, 0, GLOBAL_SCALE - 1, GLOBAL_SCALE - 1)
    end
    x = x + self.distanceBetweenHearts
  end
  love.graphics.setColor(255, 255, 255)
end