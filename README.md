# concat-brunch

Concatenate specified files to another file and optionally remove the source files.


## Usage

Install the plugin via npm with `npm install --save concat-brunch`.


## Options

### `config.plugins.concat.files`

Tell Brunch to concatenate certain files.

This example merges the content of `templates.js` into `app.js` and remove
`templates.js`.

```
config.plugins.concat =
  files:
    'public/app.js':
      sources: ['public/app.js', 'public/templates.js']
      # Whether to remove the source files after concat. Default to `false`
      toRemove: true
      # Whether to concat only in production mode. Default to `false`
      productionOnly: true
```
