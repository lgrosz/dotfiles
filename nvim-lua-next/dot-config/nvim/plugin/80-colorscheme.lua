-- Follow the OS light/dark setting with a built-in colorscheme (swap to taste;
-- see :h builtin-colorschemes). Checked at startup, on FocusGained, and by
-- :ThemeSync. Under tmux, FocusGained needs `set -g focus-events on`.
local schemes = { dark = 'habamax', light = 'shine' }

-- Each probe is a command, and a parser turning its output into 'dark',
-- 'light', or nil when it can't tell, which moves on to the next probe. A
-- command that fails or isn't installed parses as empty output.
local function has_dark(out) return out:lower():find('dark') and 'dark' or 'light' end

local probes
if vim.uv.os_uname().sysname == 'Darwin' then
  -- AppleInterfaceStyle only exists in dark mode; in light mode the read fails.
  probes = { { { 'defaults', 'read', '-g', 'AppleInterfaceStyle' }, has_dark } }
else
  -- gsettings is often installed outside GNOME, where it answers 'default'
  -- whatever the desktop's theme, so trust it only for dark and otherwise ask
  -- KDE (kreadconfig6 on Plasma 6, kreadconfig5 before).
  local kde = { '--file', 'kdeglobals', '--group', 'General', '--key', 'ColorScheme' }
  probes = {
    { { 'gsettings', 'get', 'org.gnome.desktop.interface', 'color-scheme' },
      function(out) return out:find('dark') and 'dark' or nil end },
    { { 'kreadconfig6', unpack(kde) }, function(out) return out ~= '' and has_dark(out) or nil end },
    { { 'kreadconfig5', unpack(kde) }, function(out) return out ~= '' and has_dark(out) or nil end },
  }
end

-- Run the probes in order and call on_bg with the first answer, or nil if none
-- had one. Asynchronous, so focusing the window never waits on a subprocess,
-- unless wait is set.
local function detect(wait, on_bg, i)
  i = i or 1
  local probe = probes[i]
  if not probe then return on_bg(nil) end

  local function parse(res)
    local bg = probe[2](res.code == 0 and res.stdout or '')
    if bg then on_bg(bg) else detect(wait, on_bg, i + 1) end
  end

  local ok, proc = pcall(vim.system, probe[1], { text = true },
    not wait and vim.schedule_wrap(parse) or nil)
  if not ok then
    parse({ code = -1 }) -- not installed
  elseif wait then
    parse(proc:wait(2000))
  end
end

local function apply(bg)
  -- Skip when nothing changed: :colorscheme resets highlights and fires
  -- ColorScheme, which repaints the terminal background (see init.lua), and
  -- FocusGained fires on every switch back to this window.
  if vim.o.background == bg and vim.g.colors_name == schemes[bg] then return end
  vim.o.background = bg
  vim.cmd.colorscheme(schemes[bg])
end

-- Block at startup so the first frame isn't drawn in the wrong scheme, and
-- fall back to dark when the OS can't be asked.
detect(true, function(bg) apply(bg or 'dark') end)

local function sync() detect(false, function(bg) if bg then apply(bg) end end) end
vim.api.nvim_create_autocmd('FocusGained', { callback = sync })
vim.api.nvim_create_user_command('ThemeSync', sync, { desc = 'Match the colorscheme to the OS light/dark setting' })
