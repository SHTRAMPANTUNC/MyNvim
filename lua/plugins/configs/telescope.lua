local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

require('telescope').load_extension('fzf')

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
}


extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
}


vim.keymap.set('n', ';f',
  function()
    builtin.find_files({
      no_ignore = false,
      hidden = true
    })
  end)

vim.keymap.set('n', ';r', function()
  builtin.live_grep()
end)
vim.keymap.set('n', ';t', function()
  builtin.help_tags()
end)
vim.keymap.set('n', ';h', function()
  builtin.keymaps()
end)

