
local M = {}

local function load_mappings(mappings, mapping_opt)
  vim.inspect(mappings)
  -- vim.schedule(function()

    for mode, mode_values in pairs(mappings) do
      local default_opts = vim.tbl_deep_extend("force", {mode = mode}, mapping_opt or {})
      for keybind, mapping_info in pairs(mode_values) do
        local opts = vim.tbl_deep_extend("force", default_opts, mapping_info.opts or {})

        mapping_info.opts, opts.mode = nil, nil

        opts.desc = mapping_info[2]
        vim.keymap.set(mode, keybind, mapping_info[1], opts)
      end
    end

  -- end)
end

M.load_general_mappings = function(mapping_opt)
  local general_mappings = require('config.mappings').general_mappings

  load_mappings(general_mappings, mapping_opt)
end

M.load_plugin_general_mappings = function(plugin, mapping_opt)
  local plugin_mappings_all = require('config.mappings').plugin_mappings

  -- If we want to load a specific plugin's keymappings
  local plugin_mappings = plugin_mappings_all[plugin] or {}
  local general_mappings = plugin_mappings.general or {}
  load_mappings(general_mappings, mapping_opt)

end

M.load_all_plugin_general_mappings = function(mapping_opt)
  local plugin_mappings_all = require('config.mappings').plugin_mappings

  for plugin_mappings in plugin_mappings_all do
    local general_mappings = plugin_mappings.general or {}
    load_mappings(general_mappings, mapping_opt)
  end
end

M.load_plugin_event_mappings = function(plugin, plugin_event, mapping_opt)
  local plugin_mappings_all = require('config.mappings').plugin_on_event_mappings

  local plugin_mappings = plugin_mappings_all[plugin] or {}
  local event_mappings = plugin_mappings.events or {}
  local mappings = event_mappings[plugin_event] or {}

  -- Plugin mappings that should only be loaded on some event, such as focusing
  -- a plugin window (like nvim_tree). These should never be run all at once.
  load_mappings(mappings, mapping_opt)
end

M.load_local_mappings = function(mappings, mapping_opt)
  load_mappings(mappings, mapping_opt)
end

return M
