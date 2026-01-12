-- my_mocha.lua
-- Catppuccin-inspired, plugin-free Neovim colorscheme

vim.cmd("highlight clear")
vim.cmd("set termguicolors")
vim.cmd("set background=dark")

if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "my_mocha"

-- Color palette (Mocha-inspired)
local colors = {
  bg       = "#1e1e2e",
  bg_alt   = "#181825",
  fg       = "#cdd6f4",
  fg_alt   = "#a6adc8",

  gray     = "#585b70",
  red      = "#f38ba8",
  green    = "#a6e3a1",
  yellow   = "#f9e2af",
  blue     = "#89b4fa",
  magenta  = "#f5c2e7",
  cyan     = "#94e2d5",
  orange   = "#fab387",
}

-- Helper function
local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Core UI
hi("Normal",       { fg = colors.fg, bg = colors.bg })
hi("NormalNC",     { fg = colors.fg_alt, bg = colors.bg })
hi("CursorLine",   { bg = colors.bg_alt })
hi("CursorColumn", { bg = colors.bg_alt })
hi("LineNr",       { fg = colors.gray })
hi("CursorLineNr", { fg = colors.yellow, bold = true })
hi("VertSplit",    { fg = colors.bg_alt })
hi("Visual",       { bg = "#313244" })
hi("Search",       { fg = colors.bg, bg = colors.yellow })
hi("IncSearch",    { fg = colors.bg, bg = colors.orange })

-- Syntax
hi("Comment",      { fg = colors.gray, italic = true })
hi("String",       { fg = colors.green })
hi("Character",   { fg = colors.green })
hi("Number",       { fg = colors.orange })
hi("Boolean",      { fg = colors.orange })
hi("Float",        { fg = colors.orange })

hi("Identifier",  { fg = colors.fg })
hi("Function",    { fg = colors.blue })
hi("Statement",   { fg = colors.magenta })
hi("Keyword",     { fg = colors.red })
hi("Operator",    { fg = colors.magenta })
hi("PreProc",     { fg = colors.yellow })
hi("Type",        { fg = colors.cyan })
hi("Special",     { fg = colors.blue })

-- Diagnostics (built-in LSP)
hi("DiagnosticError", { fg = colors.red })
hi("DiagnosticWarn",  { fg = colors.yellow })
hi("DiagnosticInfo",  { fg = colors.blue })
hi("DiagnosticHint",  { fg = colors.cyan })

-- Git (if using built-in signs)
hi("DiffAdd",    { fg = colors.green })
hi("DiffChange", { fg = colors.yellow })
hi("DiffDelete", { fg = colors.red })

-- Popup & floating windows
hi("Pmenu",       { fg = colors.fg, bg = "#313244" })
hi("PmenuSel",    { fg = colors.bg, bg = colors.blue })
hi("FloatBorder", { fg = colors.blue })


