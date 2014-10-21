class Actor
  setId: (id) =>
    @id = id

  setScheduler: (runtime) =>
    @runtime = runtime

  selfe: =>
    return @id

  send: (id, msg) =>
    @runtime\send id, msg

  stop: =>
    @runtime\stop!

{ :Actor }