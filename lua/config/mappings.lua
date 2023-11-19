--[[

Create a unified way to set keymaps in a more general way.

--]]
local M = {}

M.general_mappings = {
  i = {
    -- navigate withi:set listn insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", ":set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
  },


  n = {
    -- oops accidently hit ;
    [';'] = { ':', 'enter command mode', opts = { nowait = true }},

    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },

    ["<Space>"] = { "<Nop>", opts = { silent = true }},

    -- Diagnostic keymaps
    ['[d'] = { vim.diagnostic.goto_prev, opts = { desc = 'Go to previous diagnostic message' } },
    [']d'] = { vim.diagnostic.goto_next, opts = { desc = 'Go to next diagnostic message' } },
    ['<leader>e'] = { vim.diagnostic.open_float, opts = { desc = 'Open floating diagnostic message' } },
    ['<leader>q'] = { vim.diagnostic.setloclist, opts = { desc = 'Open diagnostics list' } },

    -- [[ File Operation Keybinds ]]
    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },


    -- [[ Navigation Keymaps ]]
    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "Window left" },
    ["<C-l>"] = { "<C-w>l", "Window right" },
    ["<C-j>"] = { "<C-w>j", "Window down" },
    ["<C-k>"] = { "<C-w>k", "Window up" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

    -- new buffer
    ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },
  },


  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },
  v = {
    ["<Space>"] = { "<Nop>", opts = { silent = true }},

    ["<Up>"]    = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"]  = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ['>']       = { '>gv', 'Increase Block Indent'},
    ['<']       = { '<gv', 'Decrease Block Indent'},
  },
  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
  },
}

M.plugin_mappings = {
  -- [[ Configuration for nvim-tree ]]
  ['nvim-tree'] = {
    general = {
      n = {
        -- toggle
        ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

        -- focus
        ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
      },
    },
    events = {
      on_attach = {
        n = {
          ['<C-u>'] = {
            function() require('nvim-tree.api').tree.change_root_to_parent() end,
            "nvim-tree: Parent Directory"
          },
          ['<C-o>'] = {
            function() require('nvim-tree.api').tree.change_root_to_node() end,
            "nvim-tree: Change Directory"
          },
        },
      },
    },
  },

  -- [[ Configuration for Telescope Plugin ]]
  telescope = {
    general = {
      n = {
        -- See `:help telescope.builtin`
        ['<leader>/'] = {
          function() require('telescope.builtin').current_buffer_fuzzy_find() end,
          'Fuzzy Find'
        },
        ['<C-f>'] = {
          function() require('telescope.builtin').current_buffer_fuzzy_find() end,
          'Fuzzy Find'
        },
        ['<leader>fr'] = {
          function() require('telescope.builtin').oldfiles() end,
          '[F]ind [R]ecent Files'
        },
        ['<leader>fb'] = {
          function() require('telescope.builtin').buffers() end,
          '[F]ind Existing [B]uffers'
        },
        ['<leader>ff'] = {
          function() require('telescope.builtin').find_files() end,
          '[F]ind [F]iles',
        },
        ['<leader>fh'] = { function() require('telescope.builtin').help_tags() end, '[F]ind [H]elp' },
        ['<leader>fw'] = { function() require('telescope.builtin').grep_string() end, '[F]ind current [W]ord' },
        ['<leader>fG'] = { function() require('telescope.builtin').git_files() end, '[F]ind [G]it files' },
        ['<leader>fg'] = {
          function() require('telescope.builtin').live_grep(require('telescope.themes')) end,
          '[F]ind by [G]rep'
        },
        ['<leader>fR'] = {
          function() end, -- todo implement this
          '[F]ind by grep on Git [R]oot'
        },
        ['<leader>fd'] = {
          function() require('telescope.builtin').diagnostics() end, '[F]ind [D]iagnostics'
        },
        ['<leader>f<space>'] = { function() require('telescope.builtin').resume() end, '[F]ind (previous)' },
      },
    },
    events = {

    },
  },

  -- [[ barbar plugin keybinds ]]
  barbar = {
    general = {
      n = {
        ['<A-,>'] = {
          '<cmd>BufferPrevious<cr>',
          '[BarBar] Previous Buffer',
          opts = { noremap = true, silent = true }
        },
        ['<A-.>'] = {
          '<cmd>BufferNext<cr>',
          '[BarBar] Next Buffer',
          opts = { noremap = true, silent = true }
        },
        ['<A-1>'] = {
          '<cmd>BufferGoTo 1<cr>',
          '[BarBar] Buffer 1',
          opts = { noremap = true, silent = true }
        },
        ['<A-2>'] = {
          '<cmd>BufferGoTo 2<cr>',
          '[BarBar] Buffer 2',
          opts = { noremap = true, silent = true }
        },
        ['<A-3>'] = {
          '<cmd>BufferGoTo 3<cr>',
          '[BarBar] Buffer 3',
          opts = { noremap = true, silent = true }
        },
        ['<A-4>'] = {
          '<cmd>BufferGoTo 4<cr>',
          '[BarBar] Buffer 4',
          opts = { noremap = true, silent = true }
        },
        ['<A-5>'] = {
          '<cmd>BufferGoTo 5<cr>',
          '[BarBar] Buffer 5',
          opts = { noremap = true, silent = true }
        },
        ['<A-6>'] = {
          '<cmd>BufferGoTo 6<cr>',
          '[BarBar] Buffer 6',
          opts = { noremap = true, silent = true }
        },
        ['<A-7>'] = {
          '<cmd>BufferGoTo 7<cr>',
          '[BarBar] Buffer 7',
          opts = { noremap = true, silent = true }
        },
        ['<A-8>'] = {
          '<cmd>BufferGoTo 8<cr>',
          '[BarBar] Buffer 8',
          opts = { noremap = true, silent = true }
        },
        ['<A-9>'] = {
          '<cmd>BufferGoTo 9<cr>',
          '[BarBar] Buffer 9',
          opts = { noremap = true, silent = true }
        },
        ['<A-0>'] = {
          '<cmd>BufferLast<cr>',
          '[BarBar] Last Buffer',
          opts = { noremap = true, silent = true }
        },
        ['<A-p>'] = {
          '<cmd>BufferPin<cr>',
          '[BarBar] Toggle Pin Buffer',
          opts = { noremap = true, silent = true }
        },
        ['<A-x>'] = {
          '<cmd>BufferClose<cr>',
          '[BarBar] Close Buffer',
          opts = { noremap = true, silent = true }
        },
        ['<C-p>'] = {
          '<cmd>BufferPick<cr>',
          '[BarBar] Pick Buffer',
          opts = { noremap = true, silent = true }
        },
        ['<leader>bb'] = {
          '<cmd>BufferOrderByBufferNumber<cr>',
          '[BarBar] Sort Buffers By Number',
          opts = { noremap = true, silent = true }
        },
        ['<leader>bd'] = {
          '<cmd>BufferOrderByDirectory<cr>',
          '[BarBar] Sort Buffers By Directory',
          opts = { noremap = true, silent = true }
        },
        ['<leader>bl'] = {
          '<cmd>BufferOrderByLanguage<cr>',
          '[BarBar] Sort Buffers By Language',
          opts = { noremap = true, silent = true }
        },
        ['<leader>bw'] = {
          '<cmd>BufferOrderByWindowNumber<cr>',
          '[BarBar] Sort Buffers By Window Number',
          opts = { noremap = true, silent = true }
        },
      },
    },
  },
}

return M
