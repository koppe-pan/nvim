return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        sections = {
          lualine_x = {
            {
              require("noice").api.statusline.mode.get,
              cond = require("noice").api.statusline.mode.has,
              color = { fg = "#ff9e64" },
            }
          },
        },
        options = {
          theme = "nord",
          globalstatus = true,
        },
      })
    end,
    event = "VeryLazy",
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local highlights = require("nord").bufferline.highlights({
        italic = true,
        bold = true,
      })

      require("bufferline").setup({
        options = {
          separator_style = "thin",
        },
        highlights = highlights,
      })
    end,
    event = "VeryLazy",
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      local function myMiniView(pattern, kind)
        kind = kind or ""
        return {
          view = "mini",
          filter = {
            event = "msg_show",
            kind = kind,
            find = pattern,
          },
        }
      end

      --https://qiita.com/nao-a/items/787d1c73575b778ee327
      require("noice").setup({
        cmdline = {
          format = {
            search_down = {
              view = "cmdline",
            },
            search_up = {
              view = "cmdline",
            },
          },
        },
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        messages = {
          view = "mini",
          view_search = "mini",
        },
        routes = {
          {
            filter = {
              event = "notify",
              warning = true,
              find = "failed to run generator.*is not executable",
            },
            opts = { skip = true },
          },
          myMiniView("Already at .* change"),
          myMiniView("written"),
          myMiniView("yanked"),
          myMiniView("more lines?"),
          myMiniView("fewer lines?"),
          myMiniView("fewer lines?", "lua_error"),
          myMiniView("change; before"),
          myMiniView("change; after"),
          myMiniView("line less"),
          myMiniView("lines indented"),
          myMiniView("No lines in buffer"),
          myMiniView("search hit .*, continuing at", "wmsg"),
          myMiniView("E486: Pattern not found", "emsg"),
          myMiniView("VimTeX: Compilation completed"),
        },
      })
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
}
