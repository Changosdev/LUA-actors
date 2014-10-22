local random, floor, ceil = require [[random]], math.floor, math.ceil
local time = os.time

MT_RAND_GENERATOR = random.new(time())

function uniqid(prefix, more_entropy)
  if more_entropy == nil then more_entropy = false end
  local out, num, prefix, charmap, i, pos

  out = {}
  num = more_entropy and 23 or 13

  if prefix ~= nil then
    MT_RAND_GENERATOR().seed(prefix)
  end

  charmap = 'abcdefghijklmnopqrstuvwxyz' ..
            'ABCDEFGHIJKLMNOPQRSTUVWXYZ' ..
            '0123456789'

  for i = 1, num do
    pos = math.floor(string.len(charmap) * MT_RAND_GENERATOR())
    table.insert(out, string.sub(charmap, pos, pos))
  end

  return table.concat(out)
end

return uniqid