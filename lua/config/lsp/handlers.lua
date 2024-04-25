local M = {}

-- global config for diagnostic
vim.diagnostic.config(PREF.lsp.diagnostic)

-- diagnostic icons
for type, icon in pairs(PREF.ui.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local cmp_capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

cmp_capabilities.textDocument.semanticHighlighting = true
cmp_capabilities.offsetEncoding = "utf-8"
cmp_capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
}

local function lsp_keymaps(bufnr)
    local map = function(mode, key, action)
        vim.keymap.set(mode, key, action, { buffer = bufnr, silent = true, noremap = true })
    end
    map("n", "K", ":Lspsaga hover_doc<CR>")
    map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    map("n", "gd", ":Lspsaga goto_definition<CR>")
    map("n", "<leader>rf", ":Lspsaga finder<CR>")
    map("n", "<leader>ca", ":Lspsaga code_action<CR>")
    map("n", "<leader>o", ":Lspsaga outline<CR>")
    map("n", "<leader>rn", ":Lspsaga rename<CR>")
    map("n", "<Leader>f", function()
        vim.lsp.buf.format({ async = true, desc = "Formatting code" })
    end)
end

local function diagnostic_hover(bufnr)
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local float_opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = "rounded",
                source = "always",
                prefix = " ",
            }

            if not vim.b.diagnostics_pos then
                vim.b.diagnostics_pos = { nil, nil }
            end

            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            if
                (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
                and #vim.diagnostic.get() > 0
            then
                vim.diagnostic.open_float(nil, float_opts)
            end

            vim.b.diagnostics_pos = cursor_pos
        end,
    })
end

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    diagnostic_hover(bufnr)
end

M.capabilities = cmp_capabilities

return M
