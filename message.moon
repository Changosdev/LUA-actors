class Message
  new: (tag, data) =>
    @tag = tag
    @data = data

  getTag: =>
    return @tag

  getData: =>
    return @data

{ :Message }