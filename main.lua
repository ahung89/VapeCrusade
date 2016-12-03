require "player"
assets = require("deps/cargo").init("assets")

function love.load()
  --player.move()
end

function love.update(dt)
  player:update(dt);
end

function love.draw(dt)
  love.graphics.draw(assets.yoshi_sprite, player.x, player.y, 0, .1, .1)
end