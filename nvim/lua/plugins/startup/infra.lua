local prefix = "plugins.opts.infra."
return {
    {
        "farmergreg/vim-lastplace",
        "jghauser/mkdir.nvim",
    },
    {
        "lambdalisue/suda.vim",
        cmd = { "SudaWrite", "SudaRead" },
    },
    {
        "lewis6991/hover.nvim",
        init = function()
            require("hover.providers.lsp")
            require("hover.providers.gh")
            require("hover.providers.gh_user")
            require("hover.providers.jira")
            require("hover.providers.man")
            require("hover.providers.dictionary")
        end,
        config = function()
            require("hover").setup({
                preview_opts = { border = "rounded" },
                preview_window = false,
                title = true,
            })
        end,
        keys = {
            {
                "K",
                function()
                    require("hover").hover()
                end,
                desc = "Hover",
            },
            {
                "gK",
                function()
                    require("hover").hover_select()
                end,
                desc = "Hover (select)",
            },
        },
    },
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        build = ":MasonUpdate",
        config = function()
            require(prefix .. "mason")
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
        },
        config = function()
            require(prefix .. "mason-lspconfig")
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = "VeryLazy",
        dependencies = {
            "jose-elias-alvarez/null-ls.nvim",
            "williamboman/mason.nvim",
        },
        config = function()
            require(prefix .. "null-ls")
            require(prefix .. "mason-null-ls")
        end,
    },
    {
        "williamboman/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap",
            "williamboman/mason.nvim",
        },
        config = function()
            require(prefix .. "mason-nvim-dap")
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        config = function()
            require(prefix .. "nvim-lspconfig")
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        config = function()
            require(prefix .. "null-ls")
        end,
    },
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        config = function()
            vim.fn.sign_define("DapBreakpoint", { text="" })
            vim.fn.sign_define("DapBreakpointCondition", { text="" })
            vim.fn.sign_define("DapLogPoint", { text="" })
            vim.fn.sign_define("DapBreakpointRejected", { text="" })
        end,
        keys = function()
            require(prefix .. "nvim-dap")
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("dapui").setup()
        end,
        keys = {{
            "<leader>dd",
            function() require("dapui").toggle() end,
            mode = "n",
            desc = "Toggle DAP UI"
        }}
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require(prefix .. "nvim-ufo")
        end,
    },
    {
        "stevearc/stickybuf.nvim",
        opts = {},
        init = function()
            require("stickybuf").setup()
        end,
    },
    {
        "folke/neodev.nvim",
        opts = { experimental = { pathStrict = true } },
    },
    {
        "tpope/vim-fugitive",
        dependencies = { "tpope/vim-rhubarb" },
        cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
        config = function()
            local function forcepush()
                local choice = vim.fn.input("Force push? [Y/n] ")
                vim.cmd[[normal! :<C-u>]]
                if choice == "Y" then
                    vim.cmd("Git push --force-with-lease")
                else
                    print("Force push aborted.")
                end
            end
            vim.api.nvim_create_user_command("GForcePush", forcepush, {})
        end,
        keys = {
            { "<leader>gb", "<CMD>Git blame<CR>", desc = "Blame current file" },
            { "<leader>gc", "<CMD>Git commit -a <BAR> startinsert<CR>", desc = "Commit" },
            { "<leader>gd", "<CMD>Gdiffsplit<CR>", desc = "Diff" },
            { "<leader>gp", "<CMD>Git push<CR>", desc = "Push" },
            { "<leader>gl", "<CMD>Git pull<CR>", desc = "Pull" },
            { "<leader>gr", "<CMD>Git rebase -i --root<CR>", desc = "Rebase" },
            { "<leader>gs", "<CMD>Git<CR>", desc = "Status" },
            { "<leader>gf", "<CMD>GForcePush<CR>", desc = "Force push" },
        },
    },
    {
        "turbio/bracey.vim",
        ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        build = "npm install --prefix server",
        keys = {
            { "<leader>bb", "<CMD>Bracey<CR>" },
            { "<leader>br", "<CMD>BraceyReload<CR>" },
            { "<leader>bs", "<CMD>BraceyStop<CR>" },
        },
    },
    {
        "lervag/vimtex",
        ft = { "tex" },
        keys = {
            { "<leader>lc", "<CMD>VimtexClean<CR>"},
            { "<leader>ll", "<CMD>VimtexCompile<CR>" },
            { "<leader>lv", "<CMD>VimtexView<CR>"},
        },
        init = function()
            vim.g.vimtex_view_method = "sioyek"
            vim.g.tex_conceal = "abdmg"
            vim.opt.conceallevel = 2
        end,
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
        keys = {
            { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
        },
    },
}
