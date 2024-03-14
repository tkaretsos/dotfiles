local obsidian = require("obsidian")

obsidian.setup({
  workspaces = {
    {
      name = "Work",
      path = "~/obsidian/Work",
    },
    {
      name = "Personal",
      path = "~/obsidian/Personal",
    },
  },

  daily_notes = {
    folder = "dailies",
    -- Optional, if you want to change the date format for the ID of daily notes.
    date_format = "%Y-%m-%d",
    -- Optional, if you want to change the date format of the default alias of daily notes.
    alias_format = "%B %-d, %Y",
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    template = nil
  },

  templates = {
    subdir = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    -- A map for custom variables, the key should be the variable and the value a function
    substitutions = {},
  },
})
