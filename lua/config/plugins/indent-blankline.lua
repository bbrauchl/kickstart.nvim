
local highlight = {
  "RainbowDelimiterRed",
  "RainbowDelimiterYellow",
  "RainbowDelimiterBlue",
  "RainbowDelimiterOrange",
  "RainbowDelimiterGreen",
  "RainbowDelimiterViolet",
  "RainbowDelimiterCyan",
}

local indent_blankline_config = {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  enabled = true,
  event = 'BufReadPre',
  main = 'ibl',
  --[[ init = function()
    local highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
    }

    local hooks = require "ibl.hooks"
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hook end, ]]
  opts = {
    exclude = {
      filetypes = {
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "nvdash",
        "nvcheatsheet",
        "",
      },
      buftypes = {
        "terminal",
      },
    },
    whitespace = {
      remove_blankline_trail = true,
    },
    scope = {
      enabled = true,
      highlight = highlight,
      show_start = true,
      show_end = true,
    },
    -- indentLine_enabled = 1,
    -- show_trailing_blankline_indent = false,
    -- show_first_indent_level = false,
    -- show_current_context = true,
  },
  config = function()
    require('ibl').setup(
      require('config.plugins.indent-blankline').opts
    )

    vim.g.rainbow_delimiters = {highlight = highlight}
  end,
}

return indent_blankline_config
