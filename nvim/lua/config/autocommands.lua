local autocmd = vim.api.nvim_create_autocmd

-- Stop commenting new lines
autocmd("BufEnter", { command = "setlocal formatoptions-=ro" })

-- Enable autoread
vim.opt.autoread = true
autocmd({ "FocusGained", "BufEnter" }, { command = "silent! checktime" })

-- Opens symlinks in their target:
function FollowSymlink()
    local file = vim.fn.expand("%:p")
    local real_file = vim.fn.resolve(file)
    if (string.match(real_file, "[^%d]+:/") or real_file == file) then
        return
    end
    vim.cmd("file " .. real_file)
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.cmd("echohl WarningMsg | echomsg 'Resolved symlink " .. file:gsub(os.getenv("HOME"), "~") .. " ——⟶ " .. real_file:gsub(os.getenv("HOME"), "~") .. "' | echohl None")
    vim.cmd("silent! w!")  -- Workaround for "file exists" error on write
end
autocmd("BufRead", { command = "lua FollowSymlink()" })

-- Adjust highlighting
function ClearHL()
    vim.cmd("highlight clear SpellBad")
    vim.cmd("highlight clear SpellCap")
    vim.cmd("highlight clear SpellRare")
    vim.cmd("highlight clear SpellLocal")
    vim.cmd("highlight clear DiagnosticUnderlineError")
    vim.cmd("highlight clear DiagnosticUnderlineWarn")
    vim.cmd("highlight clear DiagnosticUnderlineInfo")
    vim.cmd("highlight clear DiagnosticUnderlineHint")
    vim.cmd("highlight clear DiagnosticUnderlineOk")
    vim.cmd("highlight! link FoldColumn LineNr")
end
autocmd("BufReadPre", { command = "lua ClearHL()" })

-- Set filetype for output, error, and strace files
autocmd("BufRead", { command = "if expand('%:e') == 'out' | set ft=log | endif" })
autocmd("BufRead", { command = "if expand('%:e') == 'err' | set ft=log | endif" })
autocmd("BufRead", { command = "if getline(1) =~ '^execve' | set ft=strace | endif" })

-- Remove trailing whitespace on save
function CleanSpaces()
    local save_cursor = vim.fn.getpos(".")
    local old_query = vim.fn.getreg("/")
    vim.cmd("silent %s/\\s\\+$//e")
    vim.fn.setpos(".", save_cursor)
    vim.fn.setreg("/", old_query)
end
autocmd("BufWritePre", { command = "lua CleanSpaces()" })
