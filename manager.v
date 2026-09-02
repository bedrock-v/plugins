module plugins

import vedrock.server

@[heap]
pub struct Manager {
mut:
    plugins []Plugin
    srv     &server.Server = unsafe { nil }
}

pub fn new_manager(srv &server.Server) &Manager {
    return &Manager{
        srv: srv
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
        m.srv.log.info('Enabling ${info.name} v${info.version}')
        p.on_enable(mut m.srv)
    }
    m.srv.log.info('${m.plugins.len} plugin(s) enabled')
}

pub fn (mut m Manager) disable_all() {
    for i := m.plugins.len - 1; i >= 0; i-- {
        mut p := m.plugins[i]
        p.on_disable()
        m.srv.log.info('Disabled ${p.meta().name}')
    }
}
