return {
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
        color_icons = true,
        diagnostics = false,
        highlights = {
          buffer_selected = {
            gui = "none",
          },
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
          {
            filetype = "Outline",
            text = "Symbols Outline",
            highlight = "TSType",
            text_align = "left",
          },
        },
      },
    },
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      local logo = [[
        ███████╗██████╗ ██╗ ██████╗██╗  ██╗██╗   ██╗ █████╗ ███████╗███╗   ███╗
        ██╔════╝██╔══██╗██║██╔════╝██║ ██╔╝██║   ██║██╔══██╗██╔════╝████╗ ████║
        █████╗  ██████╔╝██║██║     █████╔╝ ██║   ██║███████║███████╗██╔████╔██║
        ██╔══╝  ██╔══██╗██║██║     ██╔═██╗ ╚██╗ ██╔╝██╔══██║╚════██║██║╚██╔╝██║
        ███████╗██║  ██║██║╚██████╗██║  ██╗ ╚████╔╝ ██║  ██║███████║██║ ╚═╝ ██║
        ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝
      ]]
      opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
    end,
  },
}
