local prefix = "plugins.opts.appearance."
return {
    {
        "folke/trouble.nvim",
        "echasnovski/mini.bufremove",
    },
    {
        "MaximilianLloyd/ascii.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = "│" },
                    change       = { text = "│" },
                    delete       = { text = "_" },
                    topdelete    = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked    = { text = "┆" },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require(prefix .. "nvim-treesitter").setup()
        end,
    },
    {
        "luukvbaal/statuscol.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "mfussenegger/nvim-dap",
        },
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                ft_ignore = { "alpha" },
                relculright = true,
                segments = {
                    -- Change `colwidth` to 2 for top two entries to improve spacing
                    -- Can also update `auto` to false to reduce jitter in statuscol, or to true to reduce size when not needed
                    { sign = { name = { ".*", " " }, maxwidth = 1, colwidth = 1, auto = false, wrap = true }, click = "v:lua.ScSa" },
                    { sign = { name = { "Diagnostic", "Dap"  }, maxwidth = 1, colwidth = 1, auto = true }, click = "v:lua.ScSa" },
                    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa", },
                    { text = { builtin.foldfunc, " " }, maxwidth = 1, colwidth = 2, click = "v:lua.ScFa" },
                    { text = { "│ " } },
                },
            })
        end,
    },
    {
        "folke/twilight.nvim",
        keys = {
            { "<leader>i", "<CMD>Twilight<CR>", desc = "Toggle Twilight", },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require(prefix .. "lualine").catppuccin()
        end,
    },
    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
                flavour = "mocha",
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        config = true,
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>xt", "<CMD>TodoTrouble<CR>", desc = "Todo (Trouble)" },
            { "<leader>xT", "<CMD>TodoTrouble keywords=TODO,FIX,FIXME<CR>", desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<CMD>TodoTelescope<CR>", desc = "Todo" },
            { "<leader>sT", "<CMD>TodoTelescope keywords=TODO,FIX,FIXME<CR>", desc = "Todo/Fix/Fixme" },
        },
    },
    {
        "akinsho/bufferline.nvim",
        keys = {
            { "<leader>bp", "<CMD>BufferLineTogglePin<CR>", desc = "Toggle pin" },
            { "<leader>bP", "<CMD>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
        },
        config = function()
            require(prefix .. "bufferline").setup()
        end,
    },
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        opts = function()
            return require(prefix .. "alpha-nvim").opts()
        end,
        config = function(_, dashboard)
            require(prefix .. "alpha-nvim").config(_, dashboard)
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            char = "│",
            filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
            show_trailing_blankline_indent = false,
            show_current_context = false,
        },
        config = function()
            require("indent_blankline").setup {
                show_current_context = true,
                show_current_context_start = true,
                space_char_blankline = " ",
            }
        end,
    },
}
