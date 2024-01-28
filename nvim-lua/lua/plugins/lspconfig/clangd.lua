-- When developing for applications with a Yocto toolchain loaded, clangd must
-- be able to find system headers. This can sometimes be configured properly by
-- the compile_commands.json, but in some cases (like Qt+CMake on Yocto
-- Sumo/Zeus), the -isysroot flag is not set. The most reliable way to get the
-- proper system headers is to query the compiler directly. The compiler which
-- is queried is provided by the compile_commands.json, but must be allowed by
-- "whitelisting" it through the
-- [--query-driver](https://clangd.llvm.org/guides/system-headers#query-driver)
-- option.
--
-- Yocto toolchains populate the CXX and CC environment variables. These are
-- also just common variables to be set to compilers... so we will just add
-- those as arguments to the aforementioned option.
local function whichstr(str)
  local command = "which " .. str

  local handle = io.popen(command)

  if handle then
    local result = handle:read("*a")
    handle:close()

    return result:gsub("^%s*(.-)%s*$", "%1")
  end

  return nil
end

local function getcc()
  local cc = os.getenv("CC")

  if cc then
    return whichstr(cc)
  end

  return nil
end

local function getcxx()
  local cxx = os.getenv("CXX")

  if cxx then
    return whichstr(cxx)
  end

  return nil
end

local cmd = { "clangd" }

local cc = getcc()
local cxx = getcxx()

-- Aggregate drivers
local drivers = { }
if cc then table.insert(drivers, cc) end
if cxx then table.insert(drivers, cxx) end

-- If there are drivers, add the --query-driver option
if #drivers > 0 then
    table.insert(cmd, "--query-driver=" .. table.concat(drivers, ","))
end


require("lspconfig").clangd.setup({
  cmd = cmd,
})
