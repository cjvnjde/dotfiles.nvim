local ns_id = vim.api.nvim_create_namespace "LspHoverType"
local show_type_enabled = false
local hover_group = vim.api.nvim_create_augroup("ShowTypeOnHover", { clear = true })

local function escape_pattern(text)
  return text:gsub("([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1")
end

local function clear_all_type_hints()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
    end
  end
end

local function show_type_on_cursor()
  if not show_type_enabled then
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }

  if #clients == 0 then
    return
  end

  local client = clients[1]
  local encoding = client.offset_encoding or "utf-16"
  local params = vim.lsp.util.make_position_params(0, encoding)

  vim.lsp.buf_request(bufnr, "textDocument/hover", params, function(_, result, _, _)
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

    if not result or not result.contents then
      return
    end

    local contents = result.contents
    if type(contents) == "table" and contents.kind == "markdown" then
      contents = contents.value
    elseif type(contents) == "table" then
      contents = table.concat(contents, "\n")
    end

    local type_info = ""
    for line in contents:gmatch "[^\n]+" do
      if not line:match "^```" and line ~= "" then
        type_info = line
        break
      end
    end

    if type_info == "" then
      return
    end

    local cword = vim.fn.expand "<cword>"

    if cword ~= "" then
      local escaped_cword = escape_pattern(cword)
      local clean_type = type_info:match(escaped_cword .. ".-:%s*(.*)")

      if not clean_type then
        clean_type = type_info:match(escaped_cword .. ".-=%s*(.*)")
      end

      if clean_type then
        type_info = clean_type
      end

      if type_info:match("^class%s+" .. escaped_cword .. "$") then
        return
      end
    end

    local row = vim.api.nvim_win_get_cursor(0)[1] - 1
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local padding = string.rep(" ", col)

    vim.api.nvim_buf_set_extmark(bufnr, ns_id, row, 0, {
      virt_lines = {
        {
          { padding .. "↳ " .. type_info, "DiagnosticVirtualTextInfo" },
        },
      },
      virt_lines_above = false,
    })
  end)
end

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = hover_group,
  callback = show_type_on_cursor,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = hover_group,
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
  end,
})

local M = {}

M.toggle_type_on_hover = function()
  show_type_enabled = not show_type_enabled

  if not show_type_enabled then
    clear_all_type_hints()
  else
    vim.schedule(function()
      show_type_on_cursor()
    end)
  end

  vim.notify("Type on hover " .. (show_type_enabled and "enabled" or "disabled"), vim.log.levels.INFO)
end

M.is_type_on_hover_enabled = function()
  return show_type_enabled
end

return M
