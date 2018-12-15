
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" basic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
set encoding=utf-8
set background=dark
set showcmd
set number
set ruler
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set cindent              " 设置使用C/C++语言的自动缩进方式
set cinoptions=g0,:0,N-s,(0    " 设置C/C++语言的具体缩进方式
set smartindent
set mouse=v
set pastetoggle=<F9>
set backspace=2
set nowrap
set showmatch
set hlsearch
set incsearch
set smartcase
set nobackup
set noswapfile
set autoread
set autowrite
set laststatus=2
set statusline+=%F

" 打开文件自动定位到最后编辑的位置
"autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

filetype plugin indent on
syntax on
