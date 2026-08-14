-- Yocto toolchains don't always set -isysroot in compile_commands.json (e.g.
-- Qt+CMake on Sumo/Zeus), so clangd can't find system headers. Query the
-- compiler directly via --query-driver, whitelisting the $CC/$CXX compilers.
-- See https://clangd.llvm.org/guides/system-headers#query-driver
local function whichstr(str)
  local handle = io.popen('which ' .. str)
  if handle then
    local result = handle:read('*a')
    handle:close()
    return result:gsub('^%s*(.-)%s*$', '%1')
  end
  return nil
end

local function which_env(var)
  local val = os.getenv(var)
  if val then return whichstr(val) end
  return nil
end

local cmd = { 'clangd' }

-- aggregate whitelisted drivers from $CC/$CXX
local drivers = {}
for _, var in ipairs({ 'CC', 'CXX' }) do
  local driver = which_env(var)
  if driver then table.insert(drivers, driver) end
end

if #drivers > 0 then
  table.insert(cmd, '--query-driver=' .. table.concat(drivers, ','))
end

return {
  cmd = cmd,
}
