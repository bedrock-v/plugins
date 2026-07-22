# plugins

Plugin framework for Vedrock: lifecycle hooks, command registration, and event listeners.

## Installation

```
v install https://github.com/bedrock-v/plugins.git
```

Then in your code:

```v
import bedrock_v.plugins
```

## Usage

Create a plugin by implementing the `Plugin` interface:

```v
module my_plugin

import bedrock_v.plugins

pub struct MyPlugin {
    plugins.Base
}

pub fn (p MyPlugin) meta() plugins.Meta {
    return plugins.Meta{
        name:    'MyPlugin'
        version: '1.0.0'
        authors: ['You']
    }
}

pub fn (mut p MyPlugin) on_enable(mut api plugins.Api) {
    p.log.info('MyPlugin enabled')
}

pub fn (mut p MyPlugin) on_disable() {
    p.log.info('MyPlugin disabled')
}
```

## License

[LGPL-3.0](LICENSE)
