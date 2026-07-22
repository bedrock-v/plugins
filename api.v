module plugins

import vedrock.server.cmd
import vedrock.server.event
import vedrock.server.scheduler
import vedrock.server.internal.logger

pub interface ServerView {
mut:
    broadcast_message(text string)
    online_count() int
    player_names() []string
}

@[heap]
pub struct Api {
mut:
    commands  &cmd.Registry        = unsafe { nil }
    events    &event.Bus           = unsafe { nil }
    scheduler &scheduler.Scheduler = unsafe { nil }
pub mut:
    server ServerView
    log    &logger.Logger = unsafe { nil }
}

pub fn (mut a Api) register_command(c cmd.Command) {
    a.commands.register(c)
}

pub fn (mut a Api) register_listener(h event.Handler, priority event.Priority) {
    a.events.register(h, priority)
}

pub fn (mut a Api) run_delayed(task scheduler.Task, delay i64) &scheduler.TaskHandler {
    return a.scheduler.run_delayed(task, delay)
}

pub fn (mut a Api) run_repeating(task scheduler.Task, period i64) &scheduler.TaskHandler {
    return a.scheduler.run_repeating(task, period)
}
