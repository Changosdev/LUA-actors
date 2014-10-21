import Scheduler from require "scheduler"

scheduler = Scheduler!
counter = scheduler\spawn('TCounter', {})
scheduler\spawn('TCounterClient', { count_server: counter })
scheduler\spawn('TCounterClient', { count_server: counter })
scheduler\spawn('TCounterClient', { count_server: counter })
scheduler\run!