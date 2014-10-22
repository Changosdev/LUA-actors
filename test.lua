local Scheduler = require("scheduler")
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
