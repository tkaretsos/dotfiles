-- Disable highlighting for certain files
local previewers = require("telescope.previewers")
-- Put all filetypes that slow you down in this array
local _bad = { "default.po", "default.pot" }
local bad_files = function(filepath)
  for _, v in ipairs(_bad) do
    if filepath:match(v) then
      return false
    end
  end

  return true
end

local Job = require("plenary.job")

local new_previewer_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  if opts.use_ft_detect == nil then opts.use_ft_detect = true end
  opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
  filepath = vim.fn.expand(filepath)

  Job:new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end
  }):sync()
end

require('telescope').setup({
  defaults = {
    layout_config = {
      horizontal = {
        prompt_position = 'top',
      }
    },
    sorting_strategy = "ascending",
    preview = { filesize_limit = 0.1 }, -- MB
    buffer_previewer_maker = new_previewer_maker
  },
  pickers = {},
  extensions = {},
})
