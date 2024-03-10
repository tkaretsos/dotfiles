require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "elixir",
    "erlang",
    "heex",
    "eex",
    "html",
    "css",
    "javascript",
    "sql",
    "json",
    "xml",
    "yaml",
    "lua",
    "go",
    "bash",
    "vim",
    "make",
    "markdown",
    "markdown_inline"
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(_, _)
      local filename = vim.fn.expand("%:t")
      return filename == "default.po" or filename == "default.pot"
    end,
  },
}
