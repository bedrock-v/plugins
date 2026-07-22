module plugins

import vedrock.server.cmd
import vedrock.server.event
import vedrock.server.scheduler
import vedrock.server.internal.logger

@[heap]
pub struct Manager {
mut:
    plugins []Plugin
    api     &Api           = unsafe { nil }
    log     &logger.Logger = unsafe { nil }
}

pub fn new_manager(commands &cmd.Registry, events &event.Bus, sched &scheduler.Scheduler, server ServerView, log &logger.Logger) &Manager {
    return &Manager{
        api: &Api{
            commands:  commands
            events:    events
            scheduler: sched
            server:    server
            log:       log
        }
        log: log
    }
}

pub fn (mut m Manager) register(p Plugin) {
    m.plugins << p
}

pub fn (m &Manager) count() int {
    return m.plugins.len
}

pub fn (mut m Manager) enable_all() {
    for mut p in m.plugins {
        info := p.meta()
        m.api.log = m.log.with_prefix(info.name)
        p.set_log(m.api.log)
        m.log.info('Enabling ${info.name} v${info.version}')
        p.on_enable(mut m.api)
    }
    m.log.info('${m.plugins.len} plugin(s) enabled, ${m.api.events.len()} listener(s) registered')
}

pub fn (mut m Manager) disable_all() {
    for i := m.plugins.len - 1; i >= 0; i-- {
        mut p := m.plugins[i]
        p.on_disable()
        m.log.info('Disabled ${p.meta().name}')
    }
}
