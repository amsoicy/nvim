local function connect_ssh()
  local address = "51.75.65.128"
  local user = "root"

  vim.cmd "tabnew"
  vim.fn.termopen(string.format("ssh %s@%s", user, address))
  vim.cmd "startinsert"
end

return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
          ["<Tab>"] = { "<Cmd>tabnext<CR>", desc = "next tab" },
          ["<S-Tab>"] = { "<Cmd>tabprev<CR>", desc = "previous tab" },
          ["\\"] = false,
          [";"] = { ":", desc = "enter command mode" },
          ["<Leader>r"] = {
            function() require("snacks").picker.projects() end,
            desc = "Find recent projects",
          },
          ["<Leader>tx"] = { connect_ssh, desc = "ssh connection" },
          ["<F5>"] = {
            function()
              if vim.bo.filetype == "cpp" then
                vim.cmd "w"
                local dir = vim.fn.expand "%:p:h"
                local file = vim.fn.expand "%:t"
                local out = vim.fn.expand "%:t:r"

                -- Prompt the user for arguments
                vim.ui.input({ prompt = "Enter arguments: " }, function(args)
                  -- If user cancels (ESC), args will be nil
                  local run_args = args or ""

                  local cmd_str = string.format(
                    'cd /d "%s" && g++ -O3 "%s" -o "%s.exe" && .\\"%s.exe" %s & pause',
                    dir,
                    file,
                    out,
                    out,
                    run_args
                  )

                  require("astrocore").toggle_term_cmd {
                    cmd = cmd_str,
                    direction = "float",
                  }
                end)
              else
                vim.notify("Not a C++ file", vim.log.levels.WARN)
              end
            end,
            desc = "Compile and Run C++ with Args",
          },
          ["<F6>"] = {
            function()
              vim.cmd "w"
              local dir = vim.fn.expand "%:p:h"

              -- Find CMakeLists.txt using vim.fs.find
              local files = vim.fs.find("CMakeLists.txt", { path = dir, limit = 1 })
              local cmake_file = files and files[1]

              if not cmake_file then
                vim.notify("No CMakeLists.txt found in " .. dir .. " or subdirs", vim.log.levels.ERROR)
                return
              end

              -- Extract directory from full path
              local cmake_dir = vim.fn.fnamemodify(cmake_file, ":h")

              -- Prompt for executable name
              vim.ui.input({ prompt = "Enter executable name: " }, function(exe_name)
                if not exe_name or exe_name == "" then
                  return
                end

                local cmd_str = string.format(
                  'cd /d "%s" && if not exist build mkdir build && cd build && cmake .. -G "MinGW Makefiles" && cmake --build . -- -j && cd .. && .\\build\\%s.exe & pause',
                  cmake_dir,
                  exe_name
                )

                require("astrocore").toggle_term_cmd {
                  cmd = cmd_str,
                  direction = "float",
                }
              end)
            end,
            desc = "Build and Run CMake Project",
          },
        },
        t = {
          ["<Esc><Esc>"] = { "<C-\\><C-n>", desc = "Exit terminal mode" },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- Mapping for formatting
          ["<Leader>lf"] = {
            function() vim.lsp.buf.format { async = true } end,
            desc = "Format document",
            cond = "textDocument/formatting", -- Only maps if server supports formatting
          },
          ["<C-Left>"] = { "b", desc = "move back a word" },
          ["<C-Right>"] = { "w", desc = "move forward a word" },
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
