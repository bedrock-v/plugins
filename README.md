# plugins

Plugin framework for Vedrock: register plugins that hook into the server lifecycle.

## Usage

Create a plugin by implementing the `Plugin` interface:

```v
module my_plugin

import plugins
import vedrock.server

pub struct MyPlugin {}

pub fn (p MyPlugin) meta() plugins.Meta {
    return plugins.Meta{
        name:    'MyPlugin'
        version: '1.0.0'
        authors: ['You']
    }
}

pub fn (mut p MyPlugin) on_enable(mut srv server.Server) {
    srv.log.info('MyPlugin enabled')
    srv.register_command(MyCommand{})
}

pub fn (mut p MyPlugin) on_disable() {}
```

Wire it in your `main.v`:

```v
mut mgr := plugins.new_manager(&srv)
mgr.register(MyPlugin{})
mgr.enable_all()
```

## License

[MIT](LICENSE)
