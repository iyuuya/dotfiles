local treesitter = {
  setup = function(use)
    -- Treesitter
    use("nvim-treesitter/nvim-treesitter-refactor")
    use("Badhi/nvim-treesitter-cpp-tools")
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = "all",
          sync_install = false,
          highlight = {
            enable = true,
            additonal_vim_regex_highlighting = true,
          },
          hidesig = {
            enable = true,
            opacity = 0.75,
            delay = 200,
          },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "gnn",
              node_incremental = "grn",
              scope_incremental = "grc",
              node_decremental = "gdm",
            },
          },
          indent = {
            enable = true,
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
                ["af"] = "@funciton.outer",
                ["if"] = "@funciton.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["ap"] = "@parameter.outer",
                ["ip"] = "@parameter.inner",
              },
            },
          },
          refactor = {
            highlight_current_scope = { enable = false },
            smart_rename = {
              enable = true,
              keymaps = {
                smart_rename = "grr",
              }
            },
            navigation = {
              enable = true,
              keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "<a-*>",
                goto_previous_usage = "<a-#>",
              }
            }
          },
          nt_cpp_tools = {
            enable = true,
            preview = {
              quit = "q", -- optional keymapping for quit preview
              accept = "<tab>" -- optional keymapping for accept preview
            },
            -- header_extension = "h", -- optional
            -- source_extension = "cxx", -- optional
            custom_define_class_function_commands = { -- optional
              TSCppImplWrite = {
                output_handle = require("nvim-treesitter.nt-cpp-tools.output_handlers").get_add_to_cpp()
              }
            }
          }
        })

        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      end,
    })
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use({
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
        require("treesitter-context").setup({
          enable = true,
          trim_scope = "outer",
          patterns = {
            default = {
              "class",
              "function",
              "method",
            }
          },
          zindex = 20,
          mode = "cursor", -- or "topline"
        })
      end
    })
  end
}

return treesitter
