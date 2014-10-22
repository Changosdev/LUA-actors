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
local TCounter
do
  local _parent_0 = Actor
  local _base_0 = {
    initialize = function(self, args)
      print("Initialize TCounter")
      return {
        count = 0
      }
    end,
    receive = function(self)
      return {
        'incr',
        'decr',
        'get_count'
      }
    end,
    handle_incr = function(self, msg, state)
      state['count'] = state['count'] + msg
      return state
    end,
    handle_decr = function(self, msg, state)
      print("handle_decr: " .. msg)
      state['count'] = state['count'] - msg
      return state
    end,
    handle_get_count = function(self, msg, state)
      print("handle_get_count: " .. tostring(msg['sender']))
      self:send(msg['sender'], Message('count', state['count']))
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
    __name = "TCounter",
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
  TCounter = _class_0
end
return {
  TCounter = TCounter
}
