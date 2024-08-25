local plugins = {
    ----  VISUALS ======================================================================
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                transparent_mode = true,
            })
            vim.cmd.colorscheme("gruvbox")
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'gruvbox',
                    component_separators = { left = '╱', right = '╲' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = {
                        { 'mode', right_padding = 2 },
                    },
                    lualine_b = { 'filename', 'branch' },
                    lualine_c = { 'fileformat' },
                    lualine_x = {},
                    lualine_y = { 'filetype', 'progress' },
                    lualine_z = {
                        { 'location', left_padding = 2 },
                    },
                },
                inactive_sections = {
                    lualine_a = { 'filename' },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { 'location' },
                },
                tabline = {},
                extensions = {},
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            vim.filetype.add({ extension = { wgsl = "wgsl" } })
            vim.filetype.add({ extension = { frag = "glsl" } })
            vim.filetype.add({ extension = { vert = "glsl" } })
            vim.filetype.add({ extension = { glsl = "glsl" } })

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "rust", "c_sharp", "glsl", "wgsl" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    {
        "shortcuts/no-neck-pain.nvim",
        config = function()
            require("no-neck-pain").setup()
            vim.keymap.set('n', '<A-f>', vim.cmd.NoNeckPain)
        end
    },
    -- FILES ======================================================================
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            vim.keymap.set('n', '<A-d>', vim.cmd.NvimTreeFocus)
            require("nvim-tree").setup {
                git = {
                    enable = false,
                },
                view = {
                    width = '30%',
                },
                actions = {
                    open_file = {
                        quit_on_open = true,
                    },
                },
            }
        end,
    },
    {
        'theprimeagen/harpoon',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local mark = require('harpoon.mark')
            local ui = require('harpoon.ui')

            vim.keymap.set('n', '<space>q', mark.add_file)
            vim.keymap.set('n', '<A-q>', ui.toggle_quick_menu)

            vim.keymap.set('n', '<A-1>', function() ui.nav_file(1) end)
            vim.keymap.set('n', '<A-2>', function() ui.nav_file(2) end)
            vim.keymap.set('n', '<A-3>', function() ui.nav_file(3) end)
            vim.keymap.set('n', '<A-4>', function() ui.nav_file(4) end)
        end
    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set("n", "<space>u", vim.cmd.UndotreeToggle)
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
        end
    },
    -- GIT  ======================================================================
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set('n', '<leader>gg', vim.cmd.Git)
        end
    },
    -- LSP  ======================================================================
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup {
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    documentation = cmp.config.window.bordered({ scrollbar = false, zindex = 1000 }),
                    completion = cmp.config.window.bordered({ scrollbar = false, zindex = 1001 }),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'crates' },
                })
            }
        end
    },
    {
        'L3MON4D3/LuaSnip',
        tag = 'v2.1.1',
        config = function()
            local ls = require('luasnip')

            vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true })
        end
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            local cfg = require('lspcfg')
            cfg.set_mappings()
            cfg.configure_servers()
        end
    },
    -- RUST  ======================================================================
    {
        'mrcjkb/rustaceanvim',
        version = '^4',
        lazy = false,
        -- ft = { 'rust' },
        config = function()
            vim.g.rustaceanvim = {
                server = {
                    on_attach = function(_, _)
                        vim.keymap.set("n", "<space>a", function()
                            print('check')
                            vim.cmd.RustLsp('flyCheck')
                        end)
                        vim.keymap.set("n", "<space>em", function()
                            print('expand')
                            vim.cmd.RustLsp('expandMacro')
                        end)
                    end,
                    settings = {
                        ['rust-analyzer'] = {
                            cargo = {
                                allFeatures = false,
                            },
                            checkOnSave = false
                        },
                    },
                },
            }
        end
    },
    {
        'saecki/crates.nvim',
        tag = 'stable',
        event = { "BufRead Cargo.toml" },
        config = function()
            local crates = require('crates')
            crates.setup()
            local opts = { silent = true }
            vim.keymap.set("n", "<space>cr", crates.reload, opts)
            vim.keymap.set("n", "<space>cv", crates.show_versions_popup, opts)
            vim.keymap.set("n", "<space>cf", crates.show_features_popup, opts)
            vim.keymap.set("n", "<space>cd", crates.show_dependencies_popup, opts)
        end,
    }
}

return plugins
