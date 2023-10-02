require('which-key').register({
  ["<leader>"] = {
    f = {
      name = "+telescope",
      f = {"<cmd>Telescope find_files<cr>", "find file"},
      o = {"<cmd>Telescope oldfiles<cr>", "search history"},
      g = {"<cmd>Telescope live_grep<cr>", "grep files"},
      h = {"<cmd>Telescope help_tags<cr>", "search help tags"},
    },
    d = {
      name = "+diagnostic",
      f = "open float",
      l = "location list",
      n = "next",
      p = "previous"
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
      d = "diff",
      D = "diff ~",
      g = {"<cmd>LazyGit<cr>", "Open LazyGit"}
    }
  }
})

