--import autoload from require "lib.autoload"
import TCounter from require "actors.TCounter"
import TCounterClient from require "actors.TCounterClient"

uscore = require 'lib/underscore'
require("lib/uniqid")
import p from require "moon"


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
    [[
      IMPLENT AUTOLOAD
    ]]
    local obj, id
    if m == 'TCounter' then
      obj = TCounter!
    else if m == 'TCounterClient' then
      obj = TCounterClient!
    else
      print "Cannot find the actor: #{m}"
      os.exit()

    id = uniqid!
    obj\setId id
    obj\setScheduler @
    @addProcess id, obj
    @initProcess obj, args
    @registerProcessCallbacks obj
    table.insert(@pids, id)
    return id

  addProcess: (id, p) =>
    @processes[id] = {
      p: p,
      receive: {},
      inbox: {}
    }

  initProcess: (obj, args) =>
    p_selfe = obj\selfe!
    p_init = obj\initialize(args)
    @processes[p_selfe]['state'] = p_init

  registerProcessCallbacks: (p) =>
    p_selfe = p\selfe!
    p_receive = p\receive!
    @processes[p_selfe]['receive'] = p_receive

  send: (pid, msg) =>
    if @processes[pid]
      table.insert(@processes[pid]['inbox'], msg)
      @msg_count = @msg_count + 1

  schedule: =>
    if @msg_count > 0 and next(@processes) ~= nil
      pid = uscore.shift(@pids)
      p_meta = @processes[pid]

      if not uscore.is_empty(p_meta['inbox']) then
        msg = uscore.shift(p_meta['inbox'])
        restack = true

        for k,receive in pairs(p_meta['receive'])
          if receive == msg\getTag! then
            m = 'handle_' .. receive
            print "running handler: " .. m .. " in pid: " .. pid
            actor = p_meta['p']
            state = actor[m](actor, msg\getData!, p_meta['state'])
            p_meta['state'] = state
            restack = false
            break

        if restack then
          table.insert(p_meta['inbox'], msg)
        else
          @msg_count = @msg_count-1

        @processes[pid] = p_meta
      table.insert(@pids, pid)

{ :Scheduler }