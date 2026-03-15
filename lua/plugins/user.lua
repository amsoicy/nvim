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
          -- ["<CR>"] = cmp.mapping {
          --   i = function(fallback)
          --     if cmp.visible() and cmp.get_active_entry() then
          --       cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
          --     else
          --       fallback()
          --     end
          --   end,
          --   s = cmp.mapping.confirm { select = true },
          --   c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
          -- },
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
