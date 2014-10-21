local p
do
  local _obj_0 = require("moon")
  p = _obj_0.p
end
local Actor
do
  local _base_0 = {
    setId = function(self, id)
      self.id = id
    end,
    setScheduler = function(self, runtime)
      self.runtime = runtime
    end,
    selfe = function(self)
      return self.id
    end,
    send = function(self, id, msg)
      return self.runtime:send(id, msg)
    end,
    stop = function(self)
      return self.runtime:stop()
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "Actor"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Actor = _class_0
end
return {
  Actor = Actor
}
