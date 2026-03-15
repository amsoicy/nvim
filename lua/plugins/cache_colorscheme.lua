-- pick a location to cache colorscheme
local state_dir = vim.fn.stdpath "state"
local colorscheme_cache = state_dir .. "/last_colorscheme"

vim.fn.mkdir(state_dir, "p")

local restoring_cache = false

return {
  {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        cache_colorscheme_read = {
          {
            event = "VimEnter",
            nested = true,
            callback = function()
              vim.schedule(function()
                local cached = vim.trim(vim.fn.readfile(colorscheme_cache)[1] or "")
                if cached and cached ~= "" then
                  restoring_cache = true
                  vim.cmd.colorscheme(cached)
                  restoring_cache = false
                end
              end)
            end,
          },
        },
        cache_colorscheme_write = {
          {
            event = "ColorScheme",
            callback = function(args)
              if args.match and not restoring_cache then
                vim.fn.writefile({ args.match }, colorscheme_cache)
              end
            end,
          },
        },
      },
    },
  },
}
