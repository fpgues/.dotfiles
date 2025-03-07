"###########################################################################
"##################### GLOBAL SETS #########################################
"###########################################################################
syntax on              " Enable syntax highlight
set nu                 " Enable line numbers
set tabstop=4          " Show existing tab with 4 spaces width
set softtabstop=4      " Show existing tab with 4 spaces width
set shiftwidth=4       " When indenting with '>', use 4 spaces width
set expandtab          " On pressing tab, insert 4 spaces
set smarttab           " insert tabs on the start of a line according to shiftwidth
set smartindent        " Automatically inserts one extra level of indentation in some cases
set hidden             " Hides the current buffer when a new file is openned
set incsearch          " Incremental search
set ignorecase         " Ingore case in search
set smartcase          " Consider case if there is a upper case character
set scrolloff=8        " Minimum number of lines to keep above and below the cursor
set colorcolumn=100    " Draws a line at the given line to keep aware of the line size
set signcolumn=yes     " Add a column on the left. Useful for linting
set cmdheight=2        " Give more space for displaying messages
set updatetime=100     " Time in miliseconds to consider the changes
set encoding=utf-8     " The encoding should be utf-8 to activate the font icons
set nobackup           " No backup files
set nowritebackup      " No backup files
set splitright         " Create the vertical splits to the right
set splitbelow         " Create the horizontal splits below
set autoread           " Update vim after file update from outside
set mouse=a            " Enable mouse support
"set listchars=space:.  " Enable dots in spaces
"set list               ""
filetype on            " Detect and set the filetype option and trigger the FileType Event
filetype plugin on     " Load the plugin file for the file type, if any
filetype indent on     " Load the indent file for the file type, if any

" #########################################################################
" ##################### REMAPS ############################################
" #########################################################################


" #########################################################################
" ##################### AUTOCMD ###########################################
" #########################################################################

"augroup nerdtree_open
"   autocmd!
"  autocmd VimEnter * NERDTree | wincmd p
"augroup END

" #########################################################################
" ##################### PLUGINS ###########################################
" #########################################################################

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dense-analysis/ale'
"Plug 'rafamadriz/friendly-snippets'
Plug 'lukas-reineke/indent-blankline.nvim'

" -----THEMES
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'morhetz/gruvbox'
Plug 'sainnhe/sonokai'
Plug 'chriskempson/base16-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }


call plug#end()

" ##########################################################################
" ##################### SETTINGS-COLOR #####################################
" ##########################################################################

""colorscheme gruvbox
colorscheme sonokai
""colorscheme dracula
""colorscheme nord
""colorscheme base16-default-dark
""colorscheme onehalfdark

if (has("nvim")) "Transparent background. Only for nvim
    highlight Normal guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" ##########################################################################
" ##################### AirLine ############################################
" ##########################################################################
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1


" #########################################################################
" ##################### NERDTree### #######################################
" #########################################################################

nmap <C-a> :NERDTreeToggle<CR>
nnoremap <silent> <C-b><C-B> :NERDTreeToggle<CR>

" #########################################################################
" ##################### ALE ###############################################
" #########################################################################
let g:ale_linters = {
\}

let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\}

let g:ale_fix_on_save = 1


" #########################################################################
" #####################  COPIA DO VIM PARA O CLIPBOARD ####################
" #########################################################################
set clipboard=unnamedplus
set clipboard=unnamed

" #########################################################################
" ##################### GCOPY/PASTE/CUT ###################################
" #########################################################################

if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

"Ctrl+c - copiar
vmap <C-c> "+yi

"Ctrl+x - recortar
"vmap <C-x> "+c

"Ctrl+v colar
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

"Ctrl+a para selecionar tudo
noremap <C-a> gggH<C-O>G
inoremap <C-a> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-a> <C-C>gggH<C-O>G
onoremap <C-a> <C-C>gggH<C-O>G
snoremap <C-a> <C-C>gggH<C-O>G
xnoremap <C-a> <C-C>ggVG

"Ctrl+s para salvar
noremap <C-s> :w!<CR>i
vnoremap <C-s> <C-C>:w!<CR>i
inoremap <C-s> <C-O>:w!<CR>i



"#########################################################################
"##################### INDENTAÇÃO ########################################
"#########################################################################

lua << EOF
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)


require("ibl").setup { indent = { highlight = highlight } }

EOF

