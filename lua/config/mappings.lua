---@type MappingsTable
--[[

Create a unified way to set keymaps in a more general way.

--]]

local M = {}

M.general = {
  n = {
    [';'] = { ':', 'enter command mode', opts = { nowait = true }},
	},
  v = {
    ['>'] = { '>gv', 'indent' },
  },
}

M.nvimtree = {
  n = {
--    ['<C-u>'] = { function() require('nvim-tree.api').tree.root_to_parent() end, "Parent Directory" },
  },
}

return M
