local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
end

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = { border = 'rounded', source = 'always' },
})

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- capabilities será setado depois que cmp carregar
vim.api.nvim_create_autocmd('User', {
    once = true,
    callback = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        local servers = { 'lua_ls', 'cssls', 'jsonls', 'bashls', 'marksman' }
        for _, name in ipairs(servers) do
            vim.lsp.config(name, { on_attach = on_attach, capabilities = capabilities })
            vim.lsp.enable(name)
        end

        vim.lsp.config('clangd', {
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                vim.keymap.set('n', '<leader>ch', '<cmd>LspClangdSwitchSourceHeader<cr>',
                    { buffer = bufnr, silent = true, desc = "Switch Source/Header" })
            end,
            capabilities = vim.tbl_deep_extend('force', capabilities, {
                offsetEncoding = { 'utf-16' },
            }),
            filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
            root_markers = { 'compile_commands.json', 'compile_flags.txt', 'CMakeLists.txt', 'Makefile', 'meson.build', '.git' },
            cmd = {
                'clangd',
                '--background-index',
                '--clang-tidy',
                '--header-insertion=iwyu',
                '--completion-style=detailed',
                '--function-arg-placeholders',
                '--fallback-style=llvm',
                '--offset-encoding=utf-16',
            },
            init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                clangdFileStatus = true,
            },
        })
        vim.lsp.enable('clangd')

        vim.lsp.config('ts_ls', {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
            settings = {
                typescript = {
                    inlayHints = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentsMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
                javascript = {
                    inlayHints = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentsMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
            },
        })
        vim.lsp.enable('ts_ls')

        vim.lsp.config('eslint', {
            capabilities = capabilities,
            filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                vim.api.nvim_create_autocmd('BufWritePre', {
                    buffer = bufnr,
                    command = 'EslintFixAll',
                })
            end,
            settings = {
                workingDirectories = { mode = 'auto' },
                experimental = { useFlatConfig = false },
            },
        })
        vim.lsp.enable('eslint')

        vim.lsp.config('gopls', {
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                if not client.server_capabilities.semanticTokensProvider then
                    local semantic = client.config.capabilities.textDocument.semanticTokens
                    client.server_capabilities.semanticTokensProvider = {
                        full = true,
                        legend = {
                            tokenTypes = semantic.tokenTypes,
                            tokenModifiers = semantic.tokenModifiers,
                        },
                        range = true,
                    }
                end
            end,
            capabilities = capabilities,
            settings = {
                gopls = {
                    gofumpt = true,
                    codelenses = {
                        gc_details = false,
                        generate = true,
                        regenerate_cgo = true,
                        run_govulncheck = true,
                        test = true,
                        tidy = true,
                        upgrade_dependency = true,
                        vendor = true,
                    },
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                    analyses = {
                        nilness = true,
                        unusedparams = true,
                        unusedwrite = true,
                        useany = true,
                    },
                    usePlaceholders = true,
                    completeUnimported = true,
                    staticcheck = true,
                    directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                    semanticTokens = true,
                },
            },
        })
        vim.lsp.enable('gopls')
    end,
})
