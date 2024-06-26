local function get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = { -- Needed for nvim-ufo to work properly
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }
    return capabilities
end

require("mason-lspconfig").setup({
    ensure_installed = {
        "basedpyright",
        "bashls",
        "clangd",
        "cssls",
        "gopls",
        "html",
        "jsonls",
        "ltex",
        "lua_ls",
        "marksman",
        "ruff",
        "vimls",
        "yamlls",
    },
    handlers = {
        function(server)
            require("lspconfig")[server].setup({ capabilities = get_capabilities() })
        end,
        ["basedpyright"] = function()
            require("lspconfig").basedpyright.setup({
                capabilities = get_capabilities(),
                on_attach = function(_, _)
                    local function filter(arr, func)
                        local new_index = 1
                        local size_orig = #arr
                        for old_index, v in ipairs(arr) do
                            if func(v, old_index) then
                                arr[new_index] = v
                                new_index = new_index + 1
                            end
                        end
                        for i = new_index, size_orig do arr[i] = nil end
                    end

                    local function pyright_accessed_filter(diagnostic)
                        if string.match(diagnostic.message, '".+" is not accessed') then return false end
                        return true
                    end

                    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                        ---@diagnostic disable-next-line: redundant-parameter
                        function(a, params, client_id, c, config)
                            filter(params.diagnostics, pyright_accessed_filter)
                            ---@diagnostic disable-next-line: redundant-parameter
                            vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c, config)
                        end,
                        {}
                    )
                end,
                settings = {
                    basedpyright = {
                        disableOrganizeImports = true,
                        typeCheckingMode = "off",
                    },
                },
            })
        end,
        ["ltex"] = function()
            require("lspconfig").ltex.setup({
                capabilities = get_capabilities(),
                settings = {
                    ltex = {
                        language = "en-US",
                        disabledRules = {
                            ["en-US"] = {
                                "EN_UNPAIRED_BRACKETS",
                                "MAC_OS",
                                "MORFOLOGIK_RULE_EN_US",
                                "SENTENCE_WHITESPACE",
                                "UPPERCASE_SENTENCE_START",
                            },
                        },
                    },
                },
            })
        end,
        ["lua_ls"] = function()
            require("lazydev").setup()
            require("lspconfig").lua_ls.setup({
                capabilities = get_capabilities(),
                settings = {
                    Lua = {
                        diagnostics = {
                            disable = { "trailing-space" },
                            globals = { "vim" },
                        },
                    },
                },
            })
        end,
        ["ruff"] = function()
            require("lspconfig").ruff.setup({
                capabilities = get_capabilities(),
                on_attach = function(client, _)
                    client.server_capabilities.hoverProvider = false
                end,
            })
        end,
    },
})
