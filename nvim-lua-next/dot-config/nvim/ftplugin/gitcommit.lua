vim.opt.spell = true

-- TODO
-- - Add wordlist for conventional-commits
--   - BONUS: load it only when conventional-commits are used

-- Complete whole filenames out of the status comments below the message.
-- Without these, `hello-world.jpg` is only offered as `hello`, `world`, `jpg`.
vim.opt_local.iskeyword:append({ '-', '.' })
