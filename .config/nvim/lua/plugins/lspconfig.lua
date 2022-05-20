local ok, nvimlsp = pcall(require, "lspconfig")

if not ok then
  return
end

local opts = {
  noremap = true,
  silent = true,
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local base_on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gD",
    "<cmd>lua vim.lsp.buf.declaration()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gd",
    "<cmd>lua vim.lsp.buf.definition()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "K",
    "<cmd>lua vim.lsp.buf.hover()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gi",
    "<cmd>lua vim.lsp.buf.implementation()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<C-k>",
    "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>wa",
    "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>wr",
    "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "D",
    "<cmd>lua vim.lsp.buf.type_definition()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<f2>",
    "<cmd>lua vim.lsp.buf.rename()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<C-x>",
    "<cmd>lua vim.lsp.buf.code_action()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gr",
    "<cmd>lua vim.lsp.buf.references()<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<space>f",
    "<cmd>lua vim.lsp.buf.formatting()<CR>",
    opts
  )
end

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local sumneko_lua_settings = {
  Lua = {
    runtime = {
      version = "luajit",
      path = runtime_path,
    },
    diagnostics = {
      -- get the language server to recognize the `vim` global
      -- this does not work for some reason?
      globals = {
        "vim",
      },
    },
    workspace = {
      -- make the server aware of neovim runtime files
      library = vim.api.nvim_get_runtime_file("", true),
    },
    telemetry = {
      enable = false,
    },
  },
}

local servers = {
  rust_analyzer = {},
  tsserver = {
    init_options = require("nvim-lsp-ts-utils").init_options,
    on_attach = function(client, bufnr)
      base_on_attach(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      local ts_utils = require "nvim-lsp-ts-utils"
      ts_utils.setup {
        update_imports_on_move = true,
        auto_inlay_hints = false,
      }

      -- required to fix code action ranges and filter diagnostics
      ts_utils.setup_client(client)

      -- no default maps, so you may want to define some here
      local silent = { silent = true }
      vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "to",
        ":TSLspOrganize<CR>",
        silent
      )
      vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "tr",
        ":TSLspRenameFile<CR>",
        silent
      )
      vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "ti",
        ":TSLspImportAll<CR>",
        silent
      )
    end,
  },
  sumneko_lua = {
    settings = sumneko_lua_settings,
    on_attach = function(client, bufnr)
      base_on_attach(client, bufnr)
      client.resolved_capabilities.document_formatting = false
    end,
  },
  cssls = {},
  jsonls = {},
  html = {},
  graphql = {},
  ccls = {},
  emmet_ls = {},
  bashls = {},
}
-- add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

for name, settings in pairs(servers) do
  local base = {
    -- if there is no on_attach overrides, use the base one
    on_attach = base_on_attach,
    flags = {
      -- don't suggest on every keystroke
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  }

  for key, value in pairs(settings) do
    base[key] = value
  end

  nvimlsp[name].setup(base)
end
