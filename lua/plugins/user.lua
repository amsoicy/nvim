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
          ["<CR>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
              -- If the menu is open, confirm the selection
              -- select = true means it will pick the first item if you haven't moved the cursor
              if cmp.confirm { select = true } then return end
            end
            -- If the menu is NOT open, or confirmation failed, do a regular newline
            fallback()
          end, { "i", "s" }),
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
