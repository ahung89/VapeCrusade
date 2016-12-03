-- libs
Object = require "deps.classic"
Gamestate = require "deps.gamestate"
Assets = require "deps.cargo".init("assets")

-- lowercase because fuck it
lume = require "deps.lume"
vector = require "deps.vector"

HC = require "deps.HC"

function love.load()
  Gamestate.registerEvents()
  Gamestate.switch(require "src.states.level")
end