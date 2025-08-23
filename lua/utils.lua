local M = {}

M.is_quickfix_open = function()
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      return true
    end
  end

  return false
end

M.try_require = function(module_name)
  local ok, module = pcall(require, module_name)

  if ok then
    return module
  else
    print(string.format("Module '%s' not found.", module_name))
    return nil
  end
end

return M
