local autoload
do
  local try_require
  try_require = function(mod_name)
    local mod
    local success, err = pcall(function()
      mod = require(mod_name)
    end)
    if not success and not err:match("module '" .. tostring(mod_name) .. "' not found:") then
      error(err)
    end
    return mod
  end
  autoload = function(...)
    local prefixes = {
      ...
    }
    local last = prefixes[#prefixes]
    local t
    if type(last) == "table" then
      prefixes[#prefixes] = nil
      t = last
    else
      t = { }
    end
    assert(next(prefixes), "missing prefixes for autoload")
    return setmetatable(t, {
      __index = function(self, mod_name)
        local mod
        for _index_0 = 1, #prefixes do
          local prefix = prefixes[_index_0]
          mod = try_require(prefix .. "." .. mod_name)
          if not (mod) then
            mod = try_require(prefix .. "." .. underscore(mod_name))
          end
          if mod then
            break
          end
        end
        self[mod_name] = mod
        return mod
      end
    })
  end
end
return {
  autoload = autoload
}
