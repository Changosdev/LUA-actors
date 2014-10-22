# LUA-ctors #
## An implementation of "The Actor Model" in LUA ##

## Installation ##

Dependencies
 - http://webserver2.tecgraf.puc-rio.br/~lhf/ftp/lua/#lrandom

## Usage ##

Your _Actors_ need to extend the class Actor for example, and
implement two methods: `Actor::initialize` and `Actor::receive`.
For example (in moonscript lang):

```lua
class Counter extends Actor
    initialize: (args) =>
      return {
        count: 0
      }

    receive: =>
        return { 'incr', 'get_count' }
```

The method `initialize` should return an table that would be the _State_ of the process. The runtime system will take care of managing the process state.

The method `receive` should return an table with strings specifying to which _message tags_ this process responds to.

In our case, the process `Counter` should also provide a method called `handle_incr` and another one called `handle_get_count`.

### Implementing the Handlers ###

A handler is a function that takes two parameters, a `Message` and the process `State` and returns a new state, like this:

```lua
class Counter extends Actor
// snip

    handle_incr: (msg, state) =>
        state['counter'] = state['counter']+msg['amount']
        return state

// snip
```

### Sending messages ###

To send a message, your actor can call the function `Actor::send`,
which expects a _process id_ and a `Message`. When creating a
`Message` instance, you need to provide a `tag`, like `'count'` in
this case, and the message data. The _tag_ is used to dispatch to a
message handler called `handle_<tag>`.

```lua
class Counter extends Actor
// snip

    handle_get_count: (msg, state) =>
        pid = msg['sender']
        @send(
            pid,
            Message('count', { sender: @selfe!, count: state['counter'] })
        )
        return state
    }

// snip
```

Then, once you to run your actors, first get an instance of the `Scheduler`, and _spawn_ your actor, by passing in the class name and the initial parameters for the Actor's _init_ function.

```lua
scheduler = Scheduler!
pid = scheduler\spawn('Counter', {})
scheduler\run!
```

### Stopping the System ###
From inside an actor you can simply call `@stop!`. Otherwise call `scheduler\stop!`.
