import p from require "moon"
import TCounter from require "TCounter"
uscore = require 'lib/underscore'

class Scheduler
  run: true
  msg_count: 0
  pids: {}
  processes: {}

  run: =>
    while @run do
      @schedule!

  stop: () =>
    @run = false

  spawn: (m, args = {}) =>
    obj = TCounter!
    --id = spl_object_hash obj --
    id = 257
    obj\setId id
    obj\setScheduler @
    @addProcess id, obj
    @initProcess obj, args
    @registerProcessCallbacks obj
    table.insert(@pids, id)

    [[
    print "============"
    print "AFTER SPAWN"
    print "============"
    print "----- PROCESOS"
    p @processes
    print "----- PID"
    p @pids
    ]]

    return id

  addProcess: (id, p) =>
    @processes[id] = {
      p: p,
      receive: {},
      inbox: {}
    }

  initProcess: (p, args) =>
    p_selfe = p\selfe!
    p_init = p\initialize(args)
    @processes[p_selfe]['state'] = p_init

  registerProcessCallbacks: (p) =>
    p_selfe = p\selfe!
    p_receive = p\receive!
    @processes[p_selfe]['receive'] = p_receive

  schedule: =>
    if @msg_count > 0 and next(@processes) ~= nil
      pid = uscore.shift(@pids)
      --p pid
      p_meta = @processes[pid]
      if not uscore.is_empty(p_meta['inbox']) then
        msg = uscore.shift(p_meta['inbox'])
        restack = true

        for k,receive in pairs(p_meta['receive'])
          if receive == msg\getTag! then
            m = 'handle_' .. receive
            args = { msg\getData!, p_meta['state'] }

      [[

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


{ :Scheduler }