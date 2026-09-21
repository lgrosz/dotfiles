-- qmlls (through Qt 6.11) asks the client to dynamically register
-- 'workspace.didChangeWatchedFiles' -- a dot where the LSP spec has a slash.
-- Neovim can't map that to a server capability, so it errors with
--   SERVER_REQUEST_HANDLER_ERROR: .../vim/lsp/client.lua:959: table index is nil
-- and qmlls follows up with "Registration of file updates failed".
--
-- qmlls only sends that registration if we advertise dynamicRegistration, and
-- its handler for the resulting notifications is commented out upstream -- the
-- registration was dropped outright in Qt 6.12 (QTBUG-133497). So decline it
-- and neither side does the pointless work.
return {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = { dynamicRegistration = false },
    },
  },
}
