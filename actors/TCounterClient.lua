local p
do
  local _obj_0 = require("moon")
  p = _obj_0.p
end
local Actor
do
  local _obj_0 = require("actor")
  Actor = _obj_0.Actor
end
local Message
do
  local _obj_0 = require("message")
  Message = _obj_0.Message
end
local TCounterClient
do
  local _parent_0 = Actor
  local _base_0 = {
    initialize = function(self, args)
      print("Initialize TCounterClient")
      self:send(args['count_server'], Message('incr', math.random(1, 10)))
      self:send(args['count_server'], Message('incr', math.random(1, 10)))
      self:send(args['count_server'], Message('decr', math.random(1, 10)))
      self:send(args['count_server'], Message('get_count', {
        sender = self:selfe()
      }))
      return {
        server = args['count_server']
      }
    end,
    receive = function(self)
      return {
        'count'
      }
    end,
    handle_count = function(self, msg, state)
      print(tostring(self:selfe()) .. ": got count " .. tostring(msg))
      os.execute("sleep 2")
      local _next = math.random(0, 2)
      if _next == 0 then
        self:send(state['server'], Message('incr', math.random(1, 20)))
      else
        if _next == 1 then
          self:send(state['server'], Message('decr', math.random(1, 20)))
        else
          if _next == 2 then
            self:send(state['server'], Message('get_count', {
              sender = self:selfe()
            }))
          end
        end
      end
      return state
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, ...)
      return _parent_0.__init(self, ...)
    end,
    __base = _base_0,
    __name = "TCounterClient",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  TCounterClient = _class_0
end
return {
  TCounterClient = TCounterClient
}
