-- For more information run ':h nvim-treesitter-modules'

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "rust", "cpp", "c_sharp", "javascript", "css", "html", "json", "java", "python", "typescript" },
  sync_install = false,
  auto_install = true,
  ignore_install = { },

  highlight = {
    enable = true,
    disable = { },
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = { 
    enable = true
  },
 
  textobjects = { 
    enable = true 
  },

  rainbow = {
   enable = true,
   disable = { },
   extended_mode = true, 
   max_file_lines = nil,
   -- colors = {}, -- table of hex strings
   -- termcolors = {} -- table of colour name strings
  }
}