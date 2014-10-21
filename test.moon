import p from require "moon"
import Scheduler from require "scheduler"

scheduler = Scheduler!
counter = scheduler\spawn('TCounter', {})
scheduler\run!
