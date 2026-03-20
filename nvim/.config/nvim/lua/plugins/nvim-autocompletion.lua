return {
  -- 1. Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },

  -- 2. Completion Engine (Blink)
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
      keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
    
        -- ENTER: Confirm the selection (and ONLY confirm, no new line)
        ['<CR>'] = { 'accept', 'fallback' },

        -- TAB: Cycle through the list
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },

        -- ARROWS: Also allow arrows to move through the list
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
  },

  -- 3. The LSP Manager (Mason)
  {
    "williamboman/mason.nvim",
    config = true
  },

  -- 4. The LSP Connector
  {
    "neovim/nvim-lspconfig",
    dependencies = { 
      "saghen/blink.cmp",
      "williamboman/mason-lspconfig.nvim", -- ADDED THIS
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      
      -- This helper makes Mason-installed servers work with your config
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            -- This modern loop handles all servers you install via Mason!
            vim.lsp.config(server_name, { capabilities = capabilities })
            vim.lsp.enable(server_name)
          end,
          
          -- Custom settings for specific servers (like Lua)
          ["lua_ls"] = function()
            vim.lsp.config('lua_ls', {
              capabilities = capabilities,
              settings = {
                Lua = { diagnostics = { globals = { 'vim' } } }
              }
            })
            vim.lsp.enable('lua_ls')
          end,
        }
      })
    end
  }
}
