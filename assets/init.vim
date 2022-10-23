syntax enable
syntax on                   " syntax highlighting
set hidden                  " Required to keep multiple buffers open
set nocompatible            " disable compatibility to old-time vi
set encoding=utf-8          " The encoding displayed
set showmatch               " show matching
set ignorecase              " case insensitive
set mouse=v                 " middle-click paste with
set hlsearch                " highlight search
set smartcase               " Enable smart-case search
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   " allow auto-indenting depending on file type
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set t_Co=256                " Support 256 colors
set conceallevel=0          " Can see `` in Markdown files
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set foldcolumn=2

call plug#begin()
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'chrisbra/colorizer'
    Plug 'honza/vim-snippets'
    Plug 'yggdroot/indentline'
    Plug 'jiangmiao/auto-pairs'
    Plug 'arcticicestudio/nord-vim'
call plug#end()

" THEME
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE " transparent bg
colorscheme nord 
if (has("termguicolors"))
  set termguicolors
endif
  
set termguicolors
hi Normal guibg=NONE ctermbg=NONE
source $HOME/.config/nvim/lotus.vim
source $HOME/.config/nvim/lotusbar.vim

map <F2> :NERDTreeToggle<CR>

let g:indentLine_color_gui = '#ea4c88'
let g:indentLine_char = '⏽ '

set noshowmode

hi EndOfBuffer guifg=bg guibg=bg
hi LineNr guibg=bg

hi foldcolumn guibg=bg
hi VertSplit guibg=#302d38 guifg=#302d38

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='nord'