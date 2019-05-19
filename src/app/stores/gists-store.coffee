# { LocalStorage } = require('node-localstorage')
# new LocalStorage('./cooldown')

# Let's not create too many gists, they can flood the users' account with
# garbage.
#
# Let's make sure that we have some kind of control over the gists so we don't
# repeat them too much, and also delete/update when possible.
#
exports.GistsStore = class
  constructor: (client, storage) ->
    @client = client
    @storage = storage

  create: (gist, callback) ->
    key = gist.cacheKey()
    cached = @storage.getItem(key)
    if cached
      callback?(cached)
      return this

    @storage.setItem(key, gist)
    @client.create gist.toHash(), (err, res) ->
      callback?(gist)

    this
