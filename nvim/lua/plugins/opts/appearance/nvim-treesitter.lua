local options = {}
function options.setup()
    local treesitter = require("nvim-treesitter.configs")
    ---@diagnostic disable-next-line: missing-fields
    treesitter.setup({
        ensure_installed = {
            "bash",
            "c",
            "css",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "python",
            "query",
            "racket",
            "regex",
            "rust",
            "vim",
        },
        indent = { enable = true },
        highlight = {
            disable = { "latex" },
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        matchup = { enable = true },
    })
end
return options
