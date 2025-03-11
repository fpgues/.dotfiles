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
  {
    'sainnhe/sonokai',  -- Repositório do tema
    config = function()
      vim.g.sonokai_enable_italic = true
      vim.cmd('colorscheme sonokai')  -- Aplica o tema Sobrio após a instalação
    end
  }

  --{
  --  "navarasu/onedark.nvim", -- Tema OneDark
  --  priority = 1000,         -- Carregue o tema antes dos outros plugins
  --  config = function()
  --    require("onedark").setup {
  --      style = "dark", -- Escolha 'dark', 'darker', ou 'cool', dependendo do gosto
  --      transparent_bg = true,
  --    }
  --    require("onedark").load()
  --  end,
  --},
}








































