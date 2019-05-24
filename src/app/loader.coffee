{ TransformationNotFoundError } = require('./errors')
{ GistStore } = require("./stores/gist-store")
{ HTTPRequestService } = require("./services/http-request-service")
{ GistService } = require("./services/gist-service")
{ LocalStorage } = require("node-localstorage")
{ NoSoftBreak } = require('./transformations/no-soft-break')
{ RemoteCodeBlocks } = require('./transformations/remote-code-blocks')
{ NoEmptyLineAfterHeading } = require('./transformations/no-empty-line-after-heading')
{ UseAsteriskForStrong } = require('./transformations/use-asterisk-for-strong')
{ UseAsteriskForEmphasis } = require('./transformations/use-asterisk-for-emphasis')
{ UseUnderscoreForStrong } = require('./transformations/use-underscore-for-emphasis')
{ UseUnderscoreForEmphasis } = require('./transformations/use-underscore-for-strong')
{ SafeHTML } = require('./transformations/safe-html')

# TODO: See if there's a way transformations can register themselves
TRANSFORMATIONS =
  NoSoftBreak: NoSoftBreak
  RemoteCodeBlocks: RemoteCodeBlocks
  NoEmptyLineAfterHeading: NoEmptyLineAfterHeading
  UseAsteriskForStrong: UseAsteriskForStrong
  UseAsteriskForEmphasis: UseAsteriskForEmphasis
  UseUnderscoreForStrong: UseUnderscoreForStrong
  UseUnderscoreForEmphasis: UseUnderscoreForEmphasis
  SafeHTML: SafeHTML

UTIL =
  GistStore: (credentials) ->
    client  = new GistService(new HTTPRequestService(), credentials)
    storage = new LocalStorage("./.cooldown-cache")
    new GistStore(client, storage)

module.exports = (name) ->
  TRANSFORMATIONS[name] or UTIL[name] or throw new TransformationNotFoundError("[COOLFILE] Transformation with name `#{name}' was not found.")
