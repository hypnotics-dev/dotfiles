local M = {}

---Key mapper helper function
---@param map string|string[]
---@param key string|table
---@param func string|function
---@param opt string|table|nil
function M.map(map, key, func, opt)
  opt = opt or {}
  if (type(opt) == "string") then
    opt = { desc = opt, silent = true }
  end

  if (type(key) == "string") then
    vim.keymap.set(map, key, func, opt)
  else
    for _, _key in ipairs(key) do
      vim.keymap.set(map, _key, func, opt)
    end
  end
end

---Builds a telescope file picker
---@param files table
---@param prompt string
function M.build_telescope_from_files(files, prompt)
  vim.notify("Hello From telescope builder", vim.log.levels.INFO)
  local conf = require("telescope.config").values
  local file_paths = {}
  for _, item in ipairs(files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = prompt,
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

---Returns all root dirs that matches the patern
---@param patterns table|nil
---@return string dirname Name of the root dir
function M.root_dir(patterns)
  patterns = patterns or {".git"}
  return vim.fs.dirname(vim.fs.find(patterns, { upward = true })[1])
end

return M
