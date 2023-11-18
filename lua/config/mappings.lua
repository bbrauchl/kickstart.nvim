---@type MappingsTable
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

    }

  },
}

M.plugin_on_event_mappings = {
  ['nvim-tree'] = {
    global = {
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
          ['<C-u>'] = { function() require('nvim-tree.api').tree.change_root_to_parent() end, "nvim-tree: Parent Directory" },
          ['<C-o>'] = { function() require('nvim-tree.api').tree.change_root_to_node() end, "nvim-tree: Change Directory" },
        },
      },
    },
  }
}

return M
