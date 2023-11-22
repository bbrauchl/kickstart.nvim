
-- Automatically close buffer to make it dissapear from bar when :q is ran
-- vim.api.nvim_create_autocmd('WinClosed', {
--   callback = function(tbl)
--     -- print(vim.inspect(tbl))
--
--     -- vim.api.nvim_command('BufferClose')
--     vim.api.nvim_command('bdelete ' .. tbl.buf)
--
--     -- require('barbar.bbye').bdelete(tbl.bang, tbl.args, tbl.smods or tbl.mods)
--   end,
--   group = vim.api.nvim_create_augroup('barbar_close_buf', {})
-- })

local barbar_config = {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function() vim.g.barbar_auto_setup = false end,
  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    -- animation = true,
    -- insert_at_start = true,
    -- …etc.
  },
}

return barbar_config
