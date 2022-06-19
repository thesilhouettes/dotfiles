local null_ls = require "null-ls"
local sources = {
  null_ls.builtins.code_actions.eslint,
  null_ls.builtins.diagnostics.eslint,
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.code_actions.proselint,
  null_ls.builtins.formatting.rustfmt,
  null_ls.builtins.formatting.shfmt,
  null_ls.builtins.diagnostics.sqlfluff.with {
    extra_args = {
      "--dialect",
      "postgres",
    },
  },
  null_ls.builtins.formatting.pg_format,
  null_ls.builtins.formatting.stylua.with {
    extra_args = {
      "--call-parentheses=None",
      "--indent-width=2",
      "--column-width=80",
      "--indent-type=Spaces",
    },
  },
  null_ls.builtins.code_actions.shellcheck,
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.formatting.shfmt,
  null_ls.builtins.diagnostics.golangci_lint,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup {
  debug = true,
  sources = sources,
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
}
