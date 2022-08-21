vim.g.Illuminate_ftblacklist = {'alpha', 'NvimTree'}

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd [[
      augroup illuminate_augroup
          autocmd!
          autocmd VimEnter * hi link illuminatedWord CursorLine
      augroup END

      augroup illuminate_augroup
        autocmd!
        autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
      augroup END
    ]]
  end,
})
