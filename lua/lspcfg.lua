local cfg = {}

function cfg.set_mappings()
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'H', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set({ 'i', 'n' }, '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<space>v', vim.lsp.buf.code_action, opts)
            vim.keymap.set({ 'n', 'v' }, '<space>f', function()
                vim.lsp.buf.format { async = true }
            end, opts)

            -- Setup additional Telescope mappings
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>s', builtin.lsp_workspace_symbols, {})
        end,
    })
end

function cfg.configure_servers()
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    local border = 'rounded'
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    local default_setup = function(server)
        require('lspconfig')[server].setup({
            capabilities = lsp_capabilities,
        })
    end

    require('rustaceanvim')

    require('mason').setup({})
    require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'rust_analyzer' },
        handlers = {
            default_setup,
            rust_analyzer = function() end,
            lua_ls = function()
                require('lspconfig').lua_ls.setup({
                    capabilities = lsp_capabilities,
                    settings = {
                        Lua = {
                            runtime = {
                                version = 'LuaJIT'
                            },
                            diagnostics = {
                                globals = { 'vim' },
                            },
                            workspace = {
                                library = {
                                    vim.env.VIMRUNTIME,
                                }
                            }
                        }
                    }
                })
            end,
        },
    })
end

return cfg
