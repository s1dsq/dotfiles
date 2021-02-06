if !exists('g:lspconfig')
    finish
endif

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>

lua << EOF
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = {
        severity_limit = "Warning",
    },
    -- Enable virtual text, override spacing to 4
    virtual_text = {
      spacing = 4,
      prefix = '~',
    },
    signs = {
        priority = "Warning",
    },
    -- Disable a feature
    update_in_insert = false,
  }
)

local custom_lsp_attach = function(client)
    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end
require'lspconfig'.tsserver.setup({ on_attach = custom_lsp_attach })

local cmd = {"node", "~/.nvm/versions/node/v12.18.3/lib/node_modules/@angular/language-server/index.js", "--stdio", "--tsProbeLocations", "" , "--ngProbeLocations", ""}
-- require'lspconfig'.angularls.setup{ on_attach=require'completion'.on_attach }
require'lspconfig'.angularls.setup{ on_attach = custom_lsp_attach }
require'lspconfig'.angularls.setup{
  cmd = cmd,
  on_new_config = function(new_config,new_root_dir)
    new_config.cmd = cmd
  end,
}
EOF
