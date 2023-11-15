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
        "eraserhd/parinfer-rust",
        ft = { "racket" },
        build = "cargo build --release",
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
        event = "VeryLazy",
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
        build = "npm install --no-package-lock --prefix server",
        keys = {
            { "<leader>bb", "<CMD>Bracey<CR>" },
            { "<leader>br", "<CMD>BraceyReload<CR>" },
            { "<leader>bs", "<CMD>BraceyStop<CR>" },
        },
    },
    {
        "lervag/vimtex",
        lazy = false,
        keys = {
            { "<leader>ll", "<CMD>VimtexCompile<CR>" },
            { "<leader>lv", "<CMD>VimtexView<CR>" },
            { "<leader>lc", "<CMD>VimtexClean<CR>" },
        },
        init = function()
            vim.g.vimtex_view_method = "sioyek"
            vim.g.vimtex_view_sioyek_options = "--new-window"
            -- vim.g.vimtex_compiler_latexmk = { options = { "-shell-escape" } } -- Disable by default
            vim.keymap.set("i", "<C-x><CR>", "<plug>(vimtex-delim-close)", { silent = true })
            vim.opt.conceallevel = 2 -- Enable VimTeX conceal

            vim.api.nvim_create_autocmd("User", {
                pattern = "VimtexEventQuit",
                desc = "VimTeX: Clean up auxiliary files on exit",
                command = "VimtexClean"
            })
            vim.api.nvim_create_autocmd("User", {
                pattern = "VimtexEventViewReverse",
                desc = "VimTeX: Return focus to vim after inverse search trigger in PDF",
                command = vim.fn.system("osascript -e 'activate application \"iTerm\"'"),
            })
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                desc = "VimTeX: Reload to fix symlink behavior",
                command = "silent! VimtexReload",
            })
            vim.api.nvim_create_autocmd("InsertLeave", {
                pattern = "*.tex, *.bib",
                desc = "VimTeX: Auto replace double quotes in current line with `` and ''",
                command = 'silent! s/\\"\\([^\\"]*\\)\\"/\\`\\`\\1\'\'/'
            })
        end,
    },
    {
        "olimorris/persisted.nvim",
        event = "VeryLazy",
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
        keys = {
            { "<leader>qs", "<CMD>SessionLoad<CR>", desc = "Restore Session" },
            { "<leader>ql", "<CMD>SessionLoadLast<CR>", desc = "Restore Last Session" },
        },
    },
}
