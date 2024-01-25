-- Configure terminal title
vim.opt.title = true
vim.opt.titlestring = "%F %r %m"
vim.opt.laststatus = 3

-- Configure line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Link sign column highlights to line number
vim.cmd("highlight! link SignColumn LineNr")

-- Configure foldcolumn characters
vim.opt.fillchars = "eob: ,fold: ,foldopen:,foldsep:│,foldclose:"

-- Fix line wrapping
vim.opt.linebreak = true

-- Show matching brackets
vim.opt.showmatch = true
vim.opt.mat = 2

-- Show commands
vim.opt.showcmd = true

-- Hide mode notification
vim.opt.showmode = false

-- Disable bells
vim.opt.visualbell = true
vim.opt.errorbells = false
vim.opt.tm = 500
