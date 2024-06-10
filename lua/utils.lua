local M = {}

local uname = vim.loop.os_uname()
local is_windows = uname.version:match("Windows")
local path_sep = is_windows and "\\" or "/"

-- Returns the git repo name
function M.git_repo_name()
  return vim.fn.system("basename `git rev-parse --show-toplevel` | tr -d '\n'")
end

-- Returns the git repo root path
function M.git_repo_root_path()
  local dir = vim.fn.system("git rev-parse --show-toplevel | tr -d '\n'")
  if string.find(dir, "not a git repository") then
    return nil
  end
  return dir
end

-- Returns the current workind directory  path
function M.working_dir_path()
  return vim.fn.getcwd()
end

-- Returns the flutter sdk path
function M.flutter_sdk_path()
  return vim.fn.system("which flutter | tr -d '\n'")
end

local function _flutter_sdk_dart_bin(flutter_sdk)
  -- retrieve the Dart binary from the Flutter SDK
  local binary_name = is_windows and "dart.bat" or "dart"
  return M.path_join(flutter_sdk, "bin", binary_name)
end

function M.dart_sdk_path()
  return _flutter_sdk_dart_bin(M.flutter_sdk_path())
end

---Join path segments using the os separator
---@vararg string
---@return string
function M.path_join(...)
  local result = table.concat(vim.tbl_flatten({ ... }), path_sep):gsub(path_sep .. "+", path_sep)
  return result
end

-- The user home path, e.g. /Users/alex
M.home_path = os.getenv("HOME")

-- Returns true if the file with the given [name] exists
function M.file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  end
  return false
end

return M
