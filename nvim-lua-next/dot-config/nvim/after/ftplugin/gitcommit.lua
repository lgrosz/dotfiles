vim.wo[0][0].spell = true

-- TODO
-- - Add wordlist for conventional-commits
--   - BONUS: load it only when conventional-commits are used
-- - When editing a git trailer, I want the indent to be 2... methink tree-sitter?

-- Complete whole filenames out of the status comments below the message.
-- Without these, `hello-world.jpg` is only offered as `hello`, `world`, `jpg`.
vim.opt_local.iskeyword:append({ '-', '.' })
