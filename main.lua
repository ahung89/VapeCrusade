-- libs
Object = require "deps.classic"
Gamestate = require "deps.gamestate"
Assets = require "deps.cargo".init("assets")

function love.load()
  Gamestate.registerEvents()
  Gamestate.switch(require "src.states.level")
end