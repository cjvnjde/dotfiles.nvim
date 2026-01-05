local utils = require "utils"
local typehint = require "config.typehint_autocmd"

local tune_options = {
  "colors",
  "diagnostics",
  "typehints",
  "codebook",
  "wrap",
}

vim.api.nvim_create_user_command("Tune", function(opts)
  local arg = opts.args

  if arg == "colors" then
    local colors = utils.try_require "nvim-highlight-colors"
    if colors then
      colors.toggle()
    else
      vim.notify("nvim-highlight-colors not found", vim.log.levels.WARN)
    end
  elseif arg == "diagnostics" then
    local current = vim.diagnostic.config()
    if not current then
      return
    end
    local is_lines_enabled = current.virtual_lines and true or false
    vim.diagnostic.config {
      virtual_lines = not is_lines_enabled,
      virtual_text = is_lines_enabled,
    }
    vim.notify("Diagnostics: " .. (not is_lines_enabled and "Virtual Lines" or "Virtual Text"), vim.log.levels.INFO)
  elseif arg == "typehints" then
    typehint.toggle_type_on_hover()
  elseif arg == "codebook" then
    local clients = vim.lsp.get_clients { name = "codebookls" }
    for _, client in ipairs(clients) do
      local ns = vim.lsp.diagnostic.get_namespace(client.id)
      local is_enabled = vim.diagnostic.is_enabled { ns_id = ns }
      vim.diagnostic.enable(not is_enabled, { ns_id = ns })
      vim.notify("Codebook diagnostics " .. (not is_enabled and "enabled" or "disabled"), vim.log.levels.INFO)
    end
  elseif arg == "wrap" then
    vim.opt.wrap = not vim.opt.wrap:get()
    vim.notify("Word wrap " .. (vim.opt.wrap:get() and "enabled" or "disabled"), vim.log.levels.INFO)
  else
    vim.notify("Invalid argument for :Tune. Use <Tab> to see options.", vim.log.levels.ERROR)
  end
end, {
  nargs = 1,
  desc = "Tune editor features (colors, diagnostics, wrapping, etc)",
  complete = function(ArgLead, CmdLine, CursorPos)
    -- Filter options based on user input for better completion experience
    local matches = {}
    for _, option in ipairs(tune_options) do
      if option:match("^" .. ArgLead) then
        table.insert(matches, option)
      end
    end
    return matches
  end,
})
