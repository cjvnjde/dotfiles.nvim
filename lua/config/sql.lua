local M = {}

-- Dialects supported by sql-formatter. PostgreSQL remains the default.
local dialects = {
  "postgresql",
  "mysql",
  "sqlite",
  "transactsql",
  "bigquery",
  "db2",
  "db2i",
  "duckdb",
  "hive",
  "mariadb",
  "n1ql",
  "plsql",
  "redshift",
  "singlestoredb",
  "snowflake",
  "spark",
  "sql",
  "tidb",
  "trino",
}

function M.dialect(bufnr)
  return vim.b[bufnr or 0].sql_dialect or vim.g.sql_dialect or "postgresql"
end

function M.select_dialect()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].filetype ~= "sql" then
    vim.notify("Open a SQL buffer to select its formatter dialect", vim.log.levels.INFO)
    return
  end

  local current = M.dialect(bufnr)
  vim.ui.select(dialects, {
    prompt = "SQL dialect for this buffer:",
    format_item = function(item)
      return item .. (item == current and " (current)" or "")
    end,
  }, function(choice)
    if choice and vim.api.nvim_buf_is_valid(bufnr) then
      vim.b[bufnr].sql_dialect = choice
      vim.notify("SQL formatter dialect: " .. choice)
    end
  end)
end

return M
