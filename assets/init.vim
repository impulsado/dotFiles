call plug#begin()
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'chrisbra/colorizer'
    Plug 'honza/vim-snippets'
    Plug 'yggdroot/indentline'
    Plug 'jiangmiao/auto-pairs'
    Plug 'arcticicestudio/nord-vim'
call plug#end()

syntax enable
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set number                  " add line numbers
set clipboard=unnamedplus   " using system clipboard
set conceallevel=0          " Can see `` in Markdown files
set hlsearch                " highlight search
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
set foldcolumn=2
hi foldcolumn guibg=bg
hi VertSplit guibg=#302d38 guifg=#302d38
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE " transparent bg