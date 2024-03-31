-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
local g = vim.g

vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.autoformat = false

opt.colorcolumn = "80"

opt.swapfile = false
opt.backup = false
opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.undodir = (os.getenv("UserProfile") or os.getenv("HOME")) .. "/.vim/undodir"

-- highlights
opt.winblend = 0
opt.pumblend = 0

opt.wildmode = "full" --"longest:full,full"
opt.scrolloff = 10

-- hide tab characters
opt.list = false
-- ast = false

opt.signcolumn = "yes"
opt.updatetime = 20

-- test feature
opt.wrap = false -- No Wrap lines
opt.backspace = { "start", "eol", "indent" }
opt.path:append({ "**" }) -- Finding files - Search down into subfolders
opt.wildignore:append({ "*/node_modules/*" })

if os.getenv("os") == "Windows_NT" then
  -- terminal settings
  local powershell_opts = {
    shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
    shellcmdflag = "-NoLogo -NoProfile -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
  }

  for option, value in pairs(powershell_opts) do
    vim.opt[option] = value
  end
end
