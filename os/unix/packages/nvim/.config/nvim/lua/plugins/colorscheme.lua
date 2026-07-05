return {
  {
    "tokyonight.nvim",
    opts = function()
      local is_dark = vim.fn.has("mac") == 1
        and vim.trim(vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")) == "Dark"
      if is_dark then
        return {
          transparent = true,
          styles = { sidebars = "transparent", floats = "transparent" },
        }
      else
        return { style = "day" }
      end
    end,
  },
}
