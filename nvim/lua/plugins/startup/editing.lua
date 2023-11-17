local prefix = "plugins.opts.editing."
return {
    {
        -- "micangl/cmp-vimtex", Seems very buggy, maybe enable in future
        "tpope/vim-repeat",
        "tpope/vim-speeddating",
        "tpope/vim-unimpaired",
        "vim-scripts/ReplaceWithRegister",
    },
    {
        "glts/vim-radical",
        dependencies = { "glts/vim-magnum" },
    },
    {
        "guns/vim-sexp",
        ft = { "racket" },
    },
    {
        "ku1ik/vim-pasta",
        config = function()
            vim.g.pasta_enabled_filetypes = { "markdown", "python", "yaml" }
        end,
    },
    {
        "godlygeek/tabular",
        cmd = { "Tab", "Tabularize" },
        keys = {
            { "<leader>t=", "<CMD>Tabularize /=<CR>", mode = { "n", "v" },  desc = "Tabularize on `=`"},
            { "<leader>t:", "<CMD>Tabularize /:<CR>", mode = { "n", "v" }, desc = "Tabularize on `:`"},
            { "<leader>tt", ":Tabularize /", mode = { "n", "v" },  desc = "Initiate tabularize"},
        },
    },
    {
        "kylechui/nvim-surround",
        config = true,
    },
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        cmd = "Copilot",
        build = ":Copilot auth",
        config = function()
            require("copilot").setup({
                filetypes = {
                    racket = false,
                    tex = false,
                },
            })
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        event = "InsertEnter",
        config = true,
    },
    {
        "numToStr/Comment.nvim",
        config = true,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({ disable_filetype = { "racket" } })
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        build = "make install_jsregexp",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip").config.setup({ enable_autosnippets = true })
            vim.keymap.set({ "i", "s" }, "<C-I>", function() require("luasnip").jump(1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-U>", function() require("luasnip").jump(-1) end, { silent = true })
        end,
    },
    {
        "iurimateus/luasnip-latex-snippets.nvim",
        ft = { "tex" },
        config = function()
            require("luasnip-latex-snippets").setup()
        end,
        dependencies = {
            "L3MON4D3/LuaSnip",
            "lervag/vimtex",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "FelipeLema/cmp-async-path",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            return require(prefix .. "nvim-cmp")
        end,
    },
}
