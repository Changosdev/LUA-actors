local p
do
  local _obj_0 = require("moon")
  p = _obj_0.p
end
local TCounter
do
  local _obj_0 = require("TCounter")
  TCounter = _obj_0.TCounter
end
local uscore = require('lib/underscore')
local Scheduler
do
  local _base_0 = {
    run = true,
    msg_count = 0,
    pids = { },
    processes = { },
    run = function(self)
      while self.run do
        self:schedule()
      end
    end,
    stop = function(self)
      self.run = false
    end,
    spawn = function(self, m, args)
      if args == nil then
        args = { }
      end
      local obj = TCounter()
      local id = 257
      obj:setId(id)
      obj:setScheduler(self)
      self:addProcess(id, obj)
      self:initProcess(obj, args)
      self:registerProcessCallbacks(obj)
      table.insert(self.pids, id)
      local _ = [[    print "============"
    print "AFTER SPAWN"
    print "============"
    print "----- PROCESOS"
    p @processes
    print "----- PID"
    p @pids
    ]]
      return id
    end,
    addProcess = function(self, id, p)
      self.processes[id] = {
        p = p,
        receive = { },
        inbox = { }
      }
    end,
    initProcess = function(self, p, args)
      local p_selfe = p:selfe()
      local p_init = p:initialize(args)
      self.processes[p_selfe]['state'] = p_init
    end,
    registerProcessCallbacks = function(self, p)
      local p_selfe = p:selfe()
      local p_receive = p:receive()
      self.processes[p_selfe]['receive'] = p_receive
    end,
    schedule = function(self)
      if self.msg_count > 0 and next(self.processes) ~= nil then
        local pid = uscore.shift(self.pids)
        local p_meta = self.processes[pid]
        if not uscore.is_empty(p_meta['inbox']) then
          local msg = uscore.shift(p_meta['inbox'])
          local restack = true
          for k, receive in pairs(p_meta['receive']) do
            if receive == msg:getTag() then
              local m = 'handle_' .. receive
              local args = {
                msg:getData(),
                p_meta['state']
              }
            end
          end
        end
        return [[
            $state = call_user_func_array(array($p_meta['p'], $m), $args);
            $p_meta['state'] = $state;
            $restack = false;
            break;
          }
        }

                  if ($restack) {
                      array_push($p_meta['inbox'], $msg);
                  } else {
                      $this->msg_count--;
                  }

                  $this->processes[$pid] = $p_meta;
              }
              array_push($this->pids, $pid);
          }
      }
      ]]
      end
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "Scheduler"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Scheduler = _class_0
end
return {
  Scheduler = Scheduler
}
