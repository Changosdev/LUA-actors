local Message
do
  local _base_0 = {
    getTag = function(self)
      return self.tag
    end,
    getData = function(self)
      return self.data
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, tag, data)
      self.tag = tag
      self.data = data
    end,
    __base = _base_0,
    __name = "Message"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Message = _class_0
end
return {
  Message = Message
}
