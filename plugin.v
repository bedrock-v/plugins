module plugins

import vedrock.server.internal.logger

pub struct Meta {
pub:
    name    string
    version string
    authors []string
}

pub interface Plugin {
    meta() Meta
mut:
    set_log(l &logger.Logger)
    on_enable(mut api Api)
    on_disable()
}

pub struct Base {
pub mut:
    log &logger.Logger = unsafe { nil }
}

pub fn (mut b Base) set_log(l &logger.Logger) {
    b.log = l
}
