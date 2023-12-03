local prefix = "plugins.opts.infra."
return {
    {
        "farmergreg/vim-lastplace",
    },
    {
        "jghauser/mkdir.nvim",
        event = "BufWritePre",
    },
    {
        "lambdalisue/suda.vim",
        cmd = { "SudaWrite", "SudaRead" },
    },
    {
        "sontungexpt/url-open",
        event = "VeryLazy",
        keys = {{ "<leader>lo", "<CMD>URLOpenUnderCursor<CR>", desc = "Open URL under cursor" }},
        config = function()
            local status_ok, url_open = pcall(require, "url-open")
            if not status_ok then return end
            url_open.setup()
        end,
    },
    {
        "eraserhd/parinfer-rust",
        ft = { "racket" },
        build = "cargo build --release",
    },
    {
        "lewis6991/hover.nvim",
        config = function()
            require("hover").setup({
                init = function()
                    require("hover.providers.lsp")
                    require("hover.providers.gh")
                    require("hover.providers.gh_user")
                    require("hover.providers.jira")
                    require("hover.providers.man")
                    require("hover.providers.dictionary")
                end,
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
            -- Try running following if Mason/Node can't install:
            -- sudo chown -R $USER:$GROUP ~/.npm
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = {
            "folke/neodev.nvim",
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
            "nvimtools/none-ls.nvim",
            "williamboman/mason.nvim",
        },
        config = function()
            require(prefix .. "none-ls")
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
        lazy = true,
        config = function()
            require(prefix .. "nvim-lspconfig")
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        config = function()
            require(prefix .. "none-ls")
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
        config = true,
        keys = {{
            "<leader>dd",
            function() require("dapui").toggle() end,
            mode = "n",
            desc = "Toggle DAP UI"
        }},
    },
    {
        "kevinhwang91/nvim-ufo",
        event = { "BufReadPost", "BufNewFile" },
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
        event = "VeryLazy",
        opts = {},
    },
    {
        "folke/neodev.nvim",
        lazy = true,
        opts = {},
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
            { "<leader>gf", "<CMD>GForcePush<CR>", desc = "Force push" },
            { "<leader>gl", "<CMD>Git pull<CR>", desc = "Pull" },
            { "<leader>go", "<CMD>GBrowse<CR>", desc = "Open in GitHub" },
            { "<leader>gp", "<CMD>Git push<CR>", desc = "Push" },
            { "<leader>gr", "<CMD>Git rebase -i --root<CR>", desc = "Rebase" },
            { "<leader>gs", "<CMD>Git<CR>", desc = "Status" },
        },
    },
    {
        "turbio/bracey.vim",
        ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        build = "npm install --no-package-lock --prefix server",
        keys = {
            { "<leader>bb", "<CMD>Bracey<CR>", desc = "Start Bracey preview" },
            { "<leader>br", "<CMD>BraceyReload<CR>", desc = "Reload Bracey" },
            { "<leader>bs", "<CMD>BraceyStop<CR>", desc = "Stop Bracey preview" },
        },
    },
    {
        "lervag/vimtex",
        lazy = false,
        keys = {
            { "<leader>ll", "<CMD>VimtexCompile<CR>", desc = "Start TeX compilation" },
            { "<leader>lv", "<CMD>VimtexView<CR>", desc = "View compiled TeX document" },
            { "<leader>lc", "<CMD>VimtexClean<CR>", desc = "Clean TeX auxfiles" },
        },
        init = function()
            require(prefix .. "vimtex")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        build = "make",
    },
    {
        "olimorris/persisted.nvim",
        cmd = { "SessionLoad", "SessionLoadLast" },
        keys = {
            { "<leader>qs", "<CMD>SessionLoad<CR>", desc = "Restore Session" },
            { "<leader>ql", "<CMD>SessionLoadLast<CR>", desc = "Restore Last Session" },
        },
        config = function()
            require("persisted").setup({
                use_git_branch = true,
                should_autosave = function()
                    if vim.bo.filetype == "alpha" then
                        return false
                    end
                    return true
                end,
            })
            require("telescope").load_extension("persisted")
        end,
    },
}
