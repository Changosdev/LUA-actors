autoload = do
  try_require = (mod_name) ->
    local mod
    success, err = pcall ->
      mod = require mod_name

    if not success and not err\match "module '#{mod_name}' not found:"
      error err

    mod

  (...) ->
    prefixes = {...}
    last = prefixes[#prefixes]
    t = if type(last) == "table"
      prefixes[#prefixes] = nil
      last
    else
      {}

    assert next(prefixes), "missing prefixes for autoload"

    setmetatable t, __index: (mod_name) =>
      local mod

      for prefix in *prefixes
        mod = try_require prefix .. "." .. mod_name

        unless mod
          mod = try_require prefix .. "." .. underscore mod_name

        break if mod

      @[mod_name] = mod
      mod

{ :autoload }