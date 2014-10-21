import Actor from require "actor"

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
    print " -> handle_incr: " .. msg
    state['count'] = state['count'] .. msg
    return state

{ :TCounter }

