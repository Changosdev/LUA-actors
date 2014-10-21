local Scheduler
do
  local _obj_0 = require("scheduler")
  Scheduler = _obj_0.Scheduler
end
local scheduler = Scheduler()
local counter = scheduler:spawn('TCounter', { })
scheduler:spawn('TCounterClient', {
  count_server = counter
})
scheduler:spawn('TCounterClient', {
  count_server = counter
})
scheduler:spawn('TCounterClient', {
  count_server = counter
})
return scheduler:run()
