"
" ~/.vimrc
"
set nocompatible
set showmatch
set incsearch
syntax enable
set history=100
set backspace=eol,start,indent
set ruler
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wildmenu
set showcmd
set autoindent
set smartindent
set list listchars=tab:→\ ,trail:·

" colors
set t_Co=256
colorscheme jellybeans

" plugins
filetype plugin on

" highlight after 80 column
highlight OverLength ctermbg=lightred ctermfg=black guibg=#FFD9D9
au BufRead,BufNewFile *.c,*.cpp,*.cc,*.h,*.hh,*.py,*.pyw,*.lua match OverLength /\%81v.\+/

" move current line up or down
nnoremap <C-Up>   ddkP
nnoremap <C-Down> ddp
