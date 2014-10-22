import p from require "moon"
import Actor from require "actor"
import Message from require "message"

class TCounter extends Actor
  -- Always declare this two function
  initialize: (args) =>
    print "Initialize TCounter"
    return {
      count: 0
    }
  receive: =>
    return { 'incr', 'decr', 'get_count' }

  handle_incr: (msg, state) =>
    state['count'] = state['count']+msg
    return state

  handle_decr: (msg, state) =>
    print "handle_decr: " .. msg
    state['count'] = state['count']-msg
    return state

  handle_get_count: (msg, state) =>
    print "handle_get_count: #{msg['sender']}"
    @send( msg['sender'], Message('count', state['count']))
    return state

{ :TCounter }

