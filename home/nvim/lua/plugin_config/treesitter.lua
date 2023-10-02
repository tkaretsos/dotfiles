require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "elixir",
    "erlang",
    "heex",
    "eex",
    "html",
    "css",
    "sql",
    "json",
    "xml",
    "yaml",
    "lua",
    "go",
    "bash",
    "vim",
    "make"
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
}

