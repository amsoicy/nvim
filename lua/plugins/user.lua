---@type LazySpec
return {
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local cmp = require "cmp"
      local cmp_mapping = cmp.mapping
      return {
        completion = {
          resolve = true,
        },
        mapping = cmp_mapping.preset.insert {
          ["<CR>"] = cmp_mapping.confirm { select = true },
          ["<Tab>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        },
      }
    end,
  },
  { "max397574/better-escape.nvim", enabled = false },
}
