local prefix = "plugins.opts.editing."
return {
    {
        "vim-scripts/ReplaceWithRegister",
    },
    {
        "godlygeek/tabular",
        cmd = { "Tab", "Tabularize" },
        keys = {
            { "<leader>t=", "<cmd>Tabularize /=<cr>", mode = { "n", "v" },  desc = "Tabularize on `=`"},
            { "<leader>t:", "<cmd>Tabularize /:<cr>", mode = { "n", "v" }, desc = "Tabularize on `:`"},
            { "<leader>tt", ":Tabularize /", mode = { "n", "v" },  desc = "Initiate tabularize"},
        },
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "tpope/vim-repeat",
        event = "VeryLazy",
    },
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        cmd = "Copilot",
        build = ":Copilot auth",
        config = function()
            require("copilot").setup({})
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        event = "VeryLazy",
        build = "make install_jsregexp",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
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
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            return require(prefix .. "nvim-cmp")
        end,
    },
}
