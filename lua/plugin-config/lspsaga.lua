-- https://github.com/glepnir/lspsaga.nvim
local status, lspsaga = pcall(require, "lspsaga")
if not status then
    vim.notify("没有找到 lspsaga")
  return
end

lspsaga.init_lsp_saga({
  border_style = "single",
  -- when cursor in saga window you config these to move
  move_in_saga = { prev = '<C-p>',next = '<C-n>'},
  diagnostic_header = { "😡", "😤", "😥", "😐" },
  show_diagnostic_source = true,
  -- code_action_icon = "💡",
  code_action_num_shortcut = true,
  -- same as nvim-lightbulb but async
  code_action_lightbulb = {
    enable = false,
    sign = true,
    sign_priority = 20,
    virtual_text = true,
  },
  -- separator in finder
  -- finder_separator = "  ",
  -- preview lines of lsp_finder and definition preview
  max_preview_lines = 20,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    tabe = "t",
    quit = "q",
    scroll_down = "<C-d>",
    scroll_up = "<C-u>", -- quit can be a table
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  rename_action_quit = "<C-c>",
  definition_preview_icon = "  ",
  -- show symbols in winbar must nightly
  symbol_in_winbar = {
    in_custom = false,
    enable = false,
    separator = ' ',
    show_file = true,
    click_support = false,
  },
})
