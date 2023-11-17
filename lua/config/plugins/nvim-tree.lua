
local my_on_attach = function(bufnr)
  local api = require('nvim-tree.api')

  local opts = {
    buffer = bufnr,
    noremap = true,
    silent = true,
    nowait = true,
  }

  api.config.mappings.default_on_attach(bufnr)

  require('utils').mappings.load_mappings('nvim_tree_on_attach', opts)
end

local nvim_tree_config = {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  opts = {
    sort_by = "case_sensitive",
    on_attach = my_on_attach,
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.opt.termguicolors = true

    local opts = {
      silent = true,
      nowait = true,
    }
    require('utils').mappings.load_mappings("nvim_tree", opts)
  end,
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}

return nvim_tree_config
