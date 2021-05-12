local custom = {}

-- uses builtin find_files for a particular working directory
local find_files_custom = function(opts)
  local cwd = opts.cwd
  if not cwd then
    return
  end

  return function()
    require('telescope.builtin').find_files(opts)
  end
end

-- find file inside dotfiles
custom.search_dotfiles = find_files_custom({
  cwd = "$HOME/dotfiles",
  previewer = false,
  hidden = true
})

custom.search_scratch = find_files_custom({
  cwd = "$HOME/scratch",
})

-- find file inside notes
custom.search_notes = find_files_custom({
  cwd = vim.g.notes_dir
})

return custom
