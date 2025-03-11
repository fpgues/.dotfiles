return {
  ---- add gruvbox
  --{ "ellisonleao/gruvbox.nvim" },

  ---- Configure LazyVim to load gruvbox
  --{
  --  "LazyVim/LazyVim",
  --  opts = {
  --    colorscheme = "gruvbox",
  --  },
  --},



  --return {
  ---- Outros plugins...
  --
  ---- Sobrio Theme
  --{
  --  'elvessousa/sobrio',  -- Repositório do tema
  --  config = function()
  --    vim.cmd('colorscheme sobrio')  -- Aplica o tema Sobrio após a instalação
  --  end
  --}


  --{
  --  "Mofiqul/dracula.nvim",
  --  priority = 1000,
  --  config = function()
  --    require("dracula").setup({
  --      -- Configurações opcionais
  --      transparent_bg = true, -- Ativa o fundo transparente
  --      italic_comment = true, -- Comentários em itálico
  --    })
  --    vim.cmd.colorscheme("dracula")
  --  end,
  --},




  --theme sonokai
  --{
  --  'sainnhe/sonokai',  -- Repositório do tema
  --  config = function()
  --    vim.g.sonokai_enable_italic = true
  --    vim.cmd('colorscheme sonokai')  -- Aplica o tema Sobrio após a instalação
  --  end
  --}


  --Tema  OneDark
  --{
  --  "navarasu/onedark.nvim", -- Tema OneDark
  --  priority = 1000,         -- Carregue o tema antes dos outros plugins
  --  config = function()
  --    require("onedark").setup {
  --      style = "darker", -- Escolha 'dark', 'darker', ou 'cool', dependendo do gosto
  --      --transparent_bg = true,
  --    }
  --    require("onedark").load()
  --  end,
  --},


  --Tema  OneDark
  {
    "navarasu/onedark.nvim", -- Tema OneDark
    priority = 1000,         -- Carregue o tema antes dos outros plugins
    config = function()
      require("onedark").setup {

        style = "darker", -- Escolha 'dark', 'darker', 'cool', 'deep', ou 'warmer'
        term_colors = true, -- Garante que o terminal use as cores do tema
        colors = {
          -- Personalize cores mais vivas
          fg = "#ffffff",
          bg = "#282c34",
          red = "#e06c75",
          green = "#98c379",
          blue = "#61afef",
          yellow = "#e5c07b",
          cyan = "#56b6c2",
          magenta = "#c678dd",
        },




      }
      require("onedark").load()
    end,
  },






}








