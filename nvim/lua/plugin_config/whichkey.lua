require('which-key').register({
  ["<leader>"] = {
    f = {
      name = "+telescope",
      f = {"<cmd>Telescope find_files<cr>", "find file"},
      b = {"<cmd>Telescope buffers<cr>", "buffers"},
      g = {"<cmd>Telescope live_grep<cr>", "grep files"},
      h = {"<cmd>Telescope help_tags<cr>", "search help tags"},
      s = {"<cmd>Telescope grep_string<cr>", "search string"},
    },
    d = {
      name = "+diagnostic",
      f = "open float",
      l = "location list",
    },
    c = {
      name = "+code",
      d = "go to definition",
      D = "go to declaration",
      i = "go to implementation",
      r = "rename",
      h = "hover",
      H = "show signature help",
      a = "code action",
      f = "format",
      l = "lens",
    },
    g = {
      name = "+git",
      s = "stage hunk",
      u = "unstage hunk",
      p = "preview hunk",
      r = "reset hunk",
      S = "stage buffer",
      R = "reset buffer",
      b = "blame line",
      B = "toggle current line blame",
      d = "diff",
      D = "diff ~",
      g = {"<cmd>LazyGit<cr>", "Open LazyGit"}
    }
  },
  ["["] = {
    h = "Previous hunk",
    d = "Previous diagnostic",
  },
  ["]"] = {
    h = "Next hunk",
    d = "Next diagnostic",
  }
})

