import p from require "moon"
import Actor from require "actor"
import Message from require "message"

class TCounterClient extends Actor
  -- Always declare this two function
  initialize: (args) =>
    print "Initialize TCounterClient"
    @send(args['count_server'], Message('incr', math.random(1,10)))
    @send(args['count_server'], Message('incr', math.random(1,10)))
    @send(args['count_server'], Message('decr', math.random(1,10)))
    @send(args['count_server'], Message('get_count', { sender: @selfe! } ))
    

    return { server: args['count_server'] }

  receive: =>
    return {'count'}

  handle_count: (msg, state) =>
    print "#{self!}: got count #{msg}"
    os.execute("sleep 2")
    _next = math.random(0,2)

    if _next == 0 then
      @send(state['server'], Message('incr', math.random(1,20)))
    else if _next == 1 then
      @send(state['server'], Message('decr', math.random(1,20)))
    else if _next == 2 then
      @send(state['server'], Message('get_count', { sender: @selfe! } ))
    return state

{ :TCounterClient }

