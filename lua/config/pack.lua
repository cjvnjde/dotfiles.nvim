local M = {}

local function notify(message, level)
  vim.notify(message, level or vim.log.levels.INFO)
end

local function get_plugin_names()
  local ok, plugins = pcall(vim.pack.get, nil, { info = false })
  if not ok then
    notify("vim.pack: failed to inspect plugins\n" .. plugins, vim.log.levels.ERROR)
    return nil, nil
  end

  local active = {}
  local inactive = {}

  for _, plugin in ipairs(plugins) do
    local names = plugin.active and active or inactive
    table.insert(names, plugin.spec.name)
  end

  return active, inactive
end

function M.update(force)
  local active, inactive = get_plugin_names()
  if not active then
    return
  end

  if #inactive > 0 then
    local ok, err = pcall(vim.pack.del, inactive)
    if not ok then
      notify("vim.pack: failed to delete inactive plugins\n" .. err, vim.log.levels.ERROR)
      return
    end
  end

  if #active == 0 then
    if #inactive == 0 then
      notify "vim.pack: no managed plugins found"
    else
      notify(("vim.pack: removed %d inactive plugin(s); no active plugins to update"):format(#inactive))
    end
    return
  end

  notify(("vim.pack: removed %d inactive plugin(s); updating %d active plugin(s)%s"):format(
    #inactive,
    #active,
    force and " immediately" or ""
  ))

  local ok, err = pcall(vim.pack.update, active, { force = force })
  if not ok then
    notify("vim.pack: failed to update active plugins\n" .. err, vim.log.levels.ERROR)
  end
end

function M.setup()
  vim.api.nvim_create_user_command("PackUpdate", function(opts)
    M.update(opts.bang)
  end, {
    bang = true,
    desc = "Remove inactive vim.pack plugins and update active ones",
    force = true,
  })
end

return M
