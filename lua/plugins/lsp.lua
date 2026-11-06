return {
  'mason-org/mason-lspconfig.nvim',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'neovim/nvim-lspconfig',
  },
  opts = {
    ensure_installed = {
      'lua_ls',
      'pyright',
      'clangd',
      'r_language_server',
    },
    automatic_enable = false,
  },
  config = function(_, opts)
    require('mason-lspconfig').setup(opts)

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = { 'vim' } },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file('', true),
          },
          telemetry = { enable = false },
        },
      },
    })

    vim.lsp.config('pyright', {
      settings = {
        python = {
          analysis = {
            typeCheckingMode = 'basic',
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    })

    vim.lsp.config('clangd', {
      cmd = { 'clangd', '--background-index', '--clang-tidy' },
    })

    vim.lsp.config('r_language_server', {
      cmd = { vim.fn.stdpath('data') .. '/mason/bin/r-languageserver' },
    })

    vim.lsp.enable { 'lua_ls', 'pyright', 'clangd', 'r_language_server' }

    vim.diagnostic.config {
      virtual_text = true,
      severity_sort = true,
      float = { border = 'rounded', source = true },
    }

    vim.lsp.inlay_hint.enable(true)

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local map = function(lhs, rhs, desc)
          vim.keymap.set('n', lhs, rhs, { buffer = ev.buf, desc = desc })
        end
        map('gd', vim.lsp.buf.definition, 'Go to definition')
        map('gD', vim.lsp.buf.declaration, 'Go to declaration')
        map('<leader>d', vim.diagnostic.open_float, 'Line diagnostics')
      end,
    })
  end,
}
