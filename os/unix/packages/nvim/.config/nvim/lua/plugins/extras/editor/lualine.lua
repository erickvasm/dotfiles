return {
  {
    "lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options = {
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      }
      -- disable mode text (NORMAL, INSERT, VISUAL, etc.)
      opts.sections.lualine_a = {
        {
          "mode",
          fmt = function()
            return ""
          end,
        },
      }
      -- branch icon is 
      opts.sections.lualine_b = {
        {
          "branch",
          icon = "",
        },
      }
      opts.sections.lualine_y = {
        {
          fmt = function()
            return ""
          end,
        },
      }
      -- only show the diff
      opts.sections.lualine_x = {
        {
          "diff",
          symbols = {
            added = " ",
            modified = " ",
            removed = " ",
          },
          colored = true,
          padding = { left = 1, right = 1 },
        },
      }
      opts.sections.lualine_z = {}
    end,
  },
}
