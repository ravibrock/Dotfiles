local prefix = "plugins.opts.appearance."
return {
    {
        "nvimdev/hlsearch.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = true,
    },
    {
        "ravibrock/nvim-cursorline",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            cursorline = { enable = false },
            cursorword = { min_length = 2 },
        },
    },
    {
        "m4xshen/smartcolumn.nvim",
        opts = {
            colorcolumn = "120",
            disabled_filetypes = { "help", "text", "markdown", "alpha", "lazy", "tex" },
        },
    },
    {
        "fei6409/log-highlight.nvim",
        ft = { "log" },
        config = true,
    },
    {
        "pocco81/high-str.nvim",
        keys = {
            { "<leader>hh", ":<C-U>HSHighlight 1<CR><CMD>echo ''<CR>", mode = "v", desc = "Highlight string" },
            { "<leader>hr", ":<C-U>HSRmHighlight<CR><CMD>echo ''<CR>", mode = "v", desc = "Remove highlight" },
            { "<leader>hl", "<CMD>HSRmHighlight rm_all<CR>", mode = { "n", "v" }, desc = "Remove all highlights" },
        },
    },
    {
        "NvChad/nvim-colorizer.lua",
        event = "VeryLazy",
        config = function()
            require("colorizer").setup({
                user_default_options = {
                    mode = "foreground",
                    names = false,
                },
            })
            -- Doesn't work right without this
            vim.cmd("ColorizerAttachToBuffer")
        end,
    },
    {
        "DrakulaD3a/silicon.lua",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            {
                "<leader>sx",
                function()
                    local window = vim.fn.winsaveview()
                    local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
                    vim.cmd("normal! gg0vG")
                    require("silicon").visualise_api({})
                    vim.fn.winrestview(window)
                    vim.api.nvim_feedkeys(esc, "x", false)
                end,
                mode = "n",
                desc = "Export with Silicon"
            },
            {
                "<leader>sx",
                function()
                    require("silicon").visualise_api({})
                    local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
                    vim.api.nvim_feedkeys(esc, "x", false)
                end,
                mode = "v",
                desc = "Export with Silicon"
            },
        },
        opts = {
            bgColor = "#d3d3d3",
            shadowColor = "#555",
            padHoriz = 40,
            padVert = 40,
            gobble = true,
            output = "~/Desktop/SILICON-${month}-${date}-${time}.png",
        },
    },
    {
        "code-biscuits/nvim-biscuits",
        event = { "BufNewFile", "BufReadPost" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            cursor_line_only = true,
            default_config = {
                max_length = 40,
                min_distance = 1,
                prefix_string = " 󰌵 ",
            },
        },
        init = function()
            vim.cmd("highlight BiscuitColor gui=italic guifg=#6c7086")
        end,
    },
    {
        "yorickpeterse/nvim-pqf",
        event = "VeryLazy",
        config = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        keys = require(prefix .. "gitsigns"),
        opts = {
            signs = {
                add          = { text = "│" },
                change       = { text = "│" },
                delete       = { text = "_" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
                untracked    = { text = "┆" },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufNewFile", "BufReadPost" },
        build = ":TSUpdate",
        version = false,
        config = function()
            require(prefix .. "nvim-treesitter")
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.opt.timeout = true
            vim.opt.timeoutlen = 500
        end,
        config = true,
    },
    {
        "luukvbaal/statuscol.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "kevinhwang91/nvim-ufo",
            "lewis6991/gitsigns.nvim",
            "mfussenegger/nvim-dap",
        },
        config = function() require(prefix .. "statuscol") end,
    },
    {
        "folke/twilight.nvim",
        keys = {{ "<leader>i", "<CMD>Twilight<CR>", desc = "Toggle Twilight" }},
        opts = {
            expand = {
                "function",
                "method",
                "table",
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            vim.g.lualine_laststatus = vim.opt.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline and ruler until lualine loads
                vim.opt.statusline = " "
                vim.opt.ruler = false
            else
                -- hide the statusline and ruler on the starter page
                vim.opt.laststatus = 0
                vim.opt.ruler = false
            end
        end,
        config = function()
            require(prefix .. "lualine").catppuccin()
        end,
    },
    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        opts = {
            integrations = {
                aerial = true,
                barbar = true,
                leap = true,
                mason = true,
                which_key = true,
            },
        },
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        event = "WinNew",
        config = true,
    },
    {
        "folke/trouble.nvim",
        keys = require(prefix .. "trouble"),
        config = true,
    },
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        opts = { signs = false },
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, mode = "n", desc = "Next todo comment" },
            { "[t", function() require("todo-comments").jump_prev() end, mode = "n", desc = "Previous todo comment" },
            { "<leader>st", "<CMD>TodoTelescope<CR>", mode = "n", desc = "Todo Telescope" },
        },
    },
    {
        "romgrk/barbar.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            animation = false,
            auto_hide  = 1,
            icons = {
                pinned = { button = '' },
            },
        },
        version = "^1.0.0",
    },
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = {
            "MaximilianLloyd/ascii.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = require(prefix .. "alpha-nvim").opts,
        config = function(_, dashboard)
            require(prefix .. "alpha-nvim").config(_, dashboard)
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main = "ibl",
        opts = {
            exclude = {
                filetypes = {
                    "alpha",
                    "dashboard",
                    "help",
                    "lazy",
                    "mason",
                    "neo-tree",
                    "trouble",
                },
            },
            indent = { char = "│" },
            scope = {
                show_end = false,
                highlight = { "Function", "Label" },
            },
        },
    },
}
