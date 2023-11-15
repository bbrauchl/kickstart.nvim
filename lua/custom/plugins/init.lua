-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
local M = {
  {
    -- Override theme that comes with nvim-kickstart to use our own
    'navarasu/onedark.nvim',
    priority = nil,
    config = nil,
  },
  {
    'Mofiqul/vscode.nvim',
    opts = {
      -- Alternatively set style in setup
      -- style = 'light'

      -- Enable transparent background
      transparent = true,

      -- Enable italic comment
      italic_comments = true,

      -- Disable nvim-tree background color
      disable_nvimtree_bg = true,

      -- Override colors (see ./lua/vscode/colors.lua)
      color_overrides = {
        -- vscLineNumber = '#FFFFFF',
      },

      -- Override highlight groups (see ./lua/vscode/theme.lua)
      group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        -- Cursor = { fg=require('vscode').get_colors().vscDarkBlue, bg=requrie('vscode').get_colors().vscLightGreen, bold=true },
      }
    },
    config = function()
      require('vscode').load()
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    opts = {
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    },
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    init = function()
      local rainbow_delimiters = require('rainbow-delimiters')
      require('rainbow-delimiters.setup').setup {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },
}

return M
