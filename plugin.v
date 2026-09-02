module plugins

import vedrock.server

pub struct Meta {
pub:
    name    string
    version string
    authors []string
}

pub interface Plugin {
    meta() Meta
mut:
    on_enable(mut srv server.Server)
    on_disable()
}
