set nocompatible
filetype off

let mapleader=","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Ctrl-p 文件搜索(子目录)
"Shift-f 文件搜索(最近打开)
"Shift-p 函数搜索
"Shift-m 符号搜索

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')
"vim doc
Plug 'yianwillis/vimcdoc'

"color
Plug 'tomasr/molokai'
Plug 'octol/vim-cpp-enhanced-highlight'

"search
Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
Plug '/usr/local/opt/fzf'

"golang autocomplete
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } 
Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

"c/cpp autocomplete
Plug 'Valloric/YouCompleteMe'           "code auto complete - many language
Plug 'Raimondi/delimitMate'             "code auto complete - ( [ { 
Plug 'Chiel92/vim-autoformat'           "code auto format
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

"google code format
Plug 'google/vim-codefmt'
Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'

"Alternate Files quickly .c --> .h
Plug 'vim-scripts/a.vim'

"markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'ludovicchabant/vim-gutentags'     "tags - auto gen tags

Plug 'skywind3000/asyncrun.vim'         "async run shell


Plug 'scrooloose/nerdtree'              "tree - file choose
Plug 'scrooloose/nerdcommenter'         "code comment
"Plug 'majutsushi/tagbar'                "tags - tag bar
"Plug 'ctrlpvim/ctrlp.vim'               "search - search everything
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" async run
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 12

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']

" F1 初始化项目根目录
nnoremap <silent> <F1> :AsyncRun -raw -cwd=<root> touch .root && mkdir -p build <cr>

" F2 生成ycm
" nnoremap <silent> <F2> :AsyncRun -raw -cwd=<root> /Users/zhanghao/.vim/plugged/YCM-Generator/config_gen.py -f -v . <cr>

" F3 格式化代码

" F4 重新生成Makefile cmake
nnoremap <silent> <F4> :AsyncRun -raw -cwd=<root> rm -rf build && mkdir -p build && cd build && cmake -DCMAKE_C_COMPILER=/usr/bin/gcc -DCMAKE_CXX_COMPILER=/usr/bin/g++ .. && cd .. && cp -rf build/compile_commands.json . <cr>

" F5 运行当前文件
" 参数 `-raw` 表示输出不用匹配错误检测模板 (errorformat) ，直接原始内容输出到 quickfix 窗口
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" F6 运行测试 make test
nnoremap <silent> <F6> :AsyncRun -raw -cwd=<root>/build make && make test <cr>

" F7 编译项目 make
nnoremap <silent> <F7> :AsyncRun -raw -cwd=<root>/build make <cr>

" F8 运行项目 make run
nnoremap <silent> <F8> :AsyncRun -raw -cwd=<root>/build make run <cr>

" F9 编译当前文件
nnoremap <silent> <F9> :AsyncRun g++ -std=c++17 -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(12)<cr>

" compile
"nnoremap <F5>   <Esc>:w<CR>:!g++ -std=c++17 % -o /tmp/a.out && /tmp/a.out<CR>
"nnoremap <F6>   <Esc>:w<CR>:!g++ -std=c++17 %<CR>
"nnoremap <C-F5> <Esc>:w<CR>:!g++ -std=c++17 -g % -o /tmp/a.out && gdb /tmp/a.out<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" YCM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
set completeopt=menu,menuone
let g:ycm_collect_identifiers_from_tags_files = 1           " 开启 YCM 基于标签引擎
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0

let g:ycm_min_num_of_chars_for_completion=2	                  " 从第2个键入字符就开始罗列匹配项
let g:ycm_complete_in_comments = 0                            " 在注释输入中也能补全
let g:ycm_complete_in_strings = 0                             " 在字符串输入中也能补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0   " 注释和字符串中的文字也会被收入补全
let g:ycm_show_diagnostics_ui = 0                             " 禁用语法检查

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" |            " 回车即选中当前项

let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ 'go': ['re!\w{2}'],
           \ }

"nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nnoremap gd :YcmCompleter GoToDefinition<CR>
nnoremap gd :YcmCompleter GoTo<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" auto format
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto format
"let g:formatdef_harttle = '"astyle --style=attach --pad-oper"'
"let g:formatters_cpp = ['harttle']
"let g:formatters_java = ['harttle']

"noremap <F3> :Autoformat<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" color
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
"let g:cpp_no_function_highlight = 1
let c_no_curly_error=1

highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

highlight Lf_hl_match gui=bold guifg=Blue cterm=bold ctermfg=21
highlight Lf_hl_matchRefine  gui=bold guifg=Magenta cterm=bold ctermfg=201


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-i> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeShowHidden=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" commenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_list_type = "quickfix"
let g:go_test_timeout = '5s'
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_def_mode = 'godef'
let g:go_decls_includes = "func,type"

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>

autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" ctags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tags=./.tags;,.tags

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" search - LeaderF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Lf_ShortcutF = '<c-p>'
"let g:Lf_ShortcutB = '<s-n>'
noremap <s-f> :LeaderfMru<cr>
noremap <s-p> :LeaderfFunction!<cr>
"noremap <s-n> :LeaderfBuffer<cr>
noremap <s-m> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.40
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
let g:Lf_Ctags = '/usr/local/opt/universal-ctags/bin/ctags'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置使用markdown插件的类型以及不自动折叠代码
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown nofoldenable


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" basic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set showcmd
set autowrite
set number
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent
set background=dark
set mouse=a
set mouse=v
set pastetoggle=<F9>
set formatoptions=c,q,r,t
set backspace=2
set ruler
set textwidth=150
set nowrap
set showmatch
set hlsearch
set incsearch
set smartcase

set laststatus=2
set statusline+=%F

set path+=/usr/include
set path+=/usr/local/include
set path+=/usr/local/opt
set path+=/usr/include/c++/4.2.1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
syntax on
