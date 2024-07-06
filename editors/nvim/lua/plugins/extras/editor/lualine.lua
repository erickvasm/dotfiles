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
      --disable progress bar
      opts.sections.lualine_z = {
        {
          "progress",
          fmt = function()
            return ""
          end,
        },
      }
    end,
  },
}
