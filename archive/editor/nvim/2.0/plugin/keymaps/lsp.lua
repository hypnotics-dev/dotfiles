local helpers = require("helpers.misc")
local tlb = require("telescope.builtin")
local aug = require("helpers.lsp")
local map = helpers.map
local lsp = vim.lsp
local buf = vim.lsp.buf

vim.api.nvim_create_autocmd('LSPAttach', {
  desc = "LSP keybind",
  group = aug.autogroups.keymap,
  callback = function (event)
    map("n", {"<leader>ca", "gca"},buf.code_action , "[C]ode [A]ction")
    map("n", {"<leader>cr", "gcr"},buf.rename, "[C]ode [R]ename")
    map("n", "<leader>cd", buf.definition, "[C]ode [D]efinitions to QFXL")
    map("n", "<leader>cr", buf.references, "[C]ode [R]eferences to QFXL")
    map("n", "<leader>cs", buf.document_symbol, "[C]ode [S]ymbols to QFXL")
    map("n", "<leader>cw", buf.workspace_symbol, "[C]ode [W]orkspace Symbols to QFXL")
    map("n", "<leader>ct", function () buf.typehierarchy("supertypes") end, "[C]ode Super[T]ype Hierarchy to QFXL")
    map("n", "<leader>cT", function () buf.typehierarchy("subtypes") end, "[C]ode Sub[T]ype Hierarchy to QFXL")

    map("n", "<leader>sr", tlb.lsp_references, "[S]earch [R]eferences")
    map("n", "<leader>se", tlb.lsp_definitions, "[S]earch D[e]finitions")
    map("n", "<leader>si", tlb.lsp_implementations, "[S]earch [I]mplementation")
    map("n", "<leader>sy", tlb.lsp_outgoing_calls, "[S]earch T[y]pe Definition")
    map("n", "<leader>sl", tlb.lsp_document_symbols, "[S]earch [L]SP Symbol")
    map("n", "<leader>sw", tlb.lsp_workspace_symbols, "[S]earch [W]orkspace Symbols")
    map("n", "<leader>sW", tlb.lsp_dynamic_workspace_symbols, "[S]earch [W]orkspace")

    map("n", "<leader>e", vim.diagnostic.open_float, "[E]rror Message")

    -- TODO: customis format opts
    map("n", "gcf", buf.format, "[C]ode [F]ormat (LSP)")
    map("n", "gch", buf.signature_help, "[C]ode Signature [H]elp")
    map("n", "gd", buf.definition, "[G]oto [D]efinition")
    map("n", "gD", buf.declaration, "[G]oto [D]eclaration")

    map("n", "gcr", function () buf.references(nil,{loclist=true}) end, "[C]ode [R]eferences to LOCL")
    map("n", "gcd", function () buf.definition({loclist=true}) end, "[C]ode [D]efinitions to LOCL")
    map("n", "gcs", function () buf.document_symbol({loclist=true}) end, "[C]ode [S]ymbols to LOCL")
    map("n", "gcw", function () buf.workspace_symbol(nil,{loclist=true}) end, "[C]ode [W]orkspace Symbols to QFXL")

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.inlayHintProvider and lsp.inlay_hint then
      -- TODO: the nil values are for filters, we should implemnt a way to build a filter list for inlay hints at some point
      map("n", "<leader>ch", function ()lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled(nil),nil) end, "[C]ode [H]ints")
    end
  end
})
