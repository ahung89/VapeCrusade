-- libs
Object = require "deps.classic"
Gamestate = require "deps.gamestate"
Assets = require "deps.cargo".init("assets")
TilemapLoader = require "deps.AdvTileLoader.loader"

-- lowercase because fuck it
lume = require "deps.lume"
vector = require "deps.vector"
anim8 = require "deps.anim8"

HC = require "deps.HC"

function love.load()
  math.randomseed(love.timer.getTime())
  Gamestate.registerEvents()
  Gamestate.switch(require "src.states.level")
end