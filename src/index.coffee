fs = require 'fs'
os = require 'os'

module.exports = class ConcatBrunch
  brunchPlugin: yes

  constructor: (@config) ->
    { @files } = @config?.plugins?.concat or {}

  onCompile: (generatedFiles) ->
    # Key is the destination file
    for destPath, options of @files
      # Read the sources and whether to remove old files
      { sources, toRemove, productionOnly } = options
      # Skip if we only want this to apply in production
      continue if productionOnly and @config.env.indexOf('production') == -1

      # Create temporary destination file
      tempPath = "#{os.tmpdir()}/concat_brunch_#{Math.floor Math.random() * 1024}"
      # Make sure the file is empty
      if fs.existsSync tempPath
        fs.unlinkSync tempPath

      # Read sources one-by-one sequentially
      for source in sources
        # Write them synchronously as Brunch doesn't support callbacks for
        # `onCompile(1)` yet. See https://github.com/brunch/brunch/issues/749
        fs.appendFileSync tempPath, fs.readFileSync source
        # Remove the file is desired
        fs.unlinkSync(source) if toRemove

      # Move the temp file to the destination
      fs.renameSync tempPath, destPath

    return
