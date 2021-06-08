local nvim_lsp = require('lspconfig')

-- settings {{{1
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', "<cmd>lua vim.lsp.diagnostic.set_loclist({ severity_limit = 'Warning' })<CR>", opts)
  buf_set_keymap('n', '<space>d', "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ severity_limit = 'Warning' }, vim.fn.bufnr(''))<CR>", opts)

  --Enable (broadcasting) snippet capability for completion
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = {
      severity_limit = 'Warning',
    },
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
  )
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "tsserver", "gopls", "rust_analyzer" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- these servers require snippet support
local snipservers = { "cssls", "html" }
for _, lsp in ipairs(snipservers) do
  nvim_lsp[lsp].setup { capabilities = capabilities }
end

-- Completion symbols {{{1
local lsp_symbols = {
  Class = '𝗖',
  Color = '',
  Constant = '',
  Constructor = '',
  Enum = '𝗘',
  EnumMember = '',
  File = '',
  Folder = '',
  Function = '',
  Interface = 'ﰮ',
  Keyword = '',
  Method = '',
  Module = '',
  Property = '',
  Snippet = '',
  Struct = '',
  Text = '',
  Unit = '',
  Value = '',
  Variable = '',
  Namespace = '',
  Field = '',
  Number = '#',
  TypeParameter = '𝗧'
}

for kind, symbol in pairs(lsp_symbols) do
  local kinds = vim.lsp.protocol.CompletionItemKind
  local index = kinds[kind]

  if index ~= nil then
    kinds[index] = symbol
  end
end
-- vim: set foldmethod=marker:
