set encoding=utf-8
set nocompatible              " be iMproved
filetype off                  " required!

let mapleader = "\<Space>"

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'
Plugin 'klen/python-mode'
Plugin 'tell-k/vim-autopep8'
Plugin 'davidhalter/jedi-vim'
Plugin 'commentary.vim'
Plugin 'ctrlp.vim'
Plugin 'tpope/vim-markdown'
Plugin 'mhinz/vim-signify'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'DirDiff.vim'
"Plugin 'joonty/vdebug.git'
Plugin 'taglist.vim'
Plugin 'tpope/vim-dispatch'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-ruby/vim-Ruby'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-endwise'
Plugin 'easymotion/vim-easymotion'
Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-db'

call vundle#end()
filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.


" vim defaults
set nu
syn on
set cursorline
set smartindent
set tabstop=4 expandtab shiftwidth=4 softtabstop=4
set showtabline=2
set ignorecase
set hlsearch
set backspace=indent,eol,start

" read *.md as markdown files
autocmd BufNewFile,BufReadPost *.md,*.markdown set filetype=markdown

autocmd BufNewFile,BufReadPost *.jbuilder set filetype=ruby

" set 2 space tabs when appropriate
autocmd FileType yaml,json,markdown,ruby,javascript,Rakefile setlocal shiftwidth=2 tabstop=2

" Remove whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Better diff highlighting
highlight! link DiffText MatchParen
set background=dark

" pane navigation with control keys
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


"""""""""""""""""""""""""""""""""""""
" NERDtree config
"""""""""""""""""""""""""""""""""""""
" default larger window  width
let g:NERDTreeWinSize = 40

"""""""""""""""""""""""""""""""""""""
" PHP linter
"""""""""""""""""""""""""""""""""""""
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']

""""""""""""""""""""""""""""""""""""""
" Python-mode
""""""""""""""""""""""""""""""""""""""
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 1
""""""""""""""""""""""""""""""""""""""
" end Python-mode
""""""""""""""""""""""""""""""""""""""


" highlight characters past column 80
" http://unlogic.co.uk/2013/02/08/vim-as-a-python-ide/
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight OverLength ctermfg=white ctermbg=red guibg=#592929
    autocmd FileType python match OverLength /\%81v.\+/
    autocmd FileType python set nowrap
    augroup END

""""""""""""""""""""""""""""""""""""""
" Ruby dev
""""""""""""""""""""""""""""""""""""""
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

""""""""""""""""""""""""""""""""""""""
" newtek shop dev
""""""""""""""""""""""""""""""""""""""
let g:vdebug_options= {
\    "port" : 9000,
\    "server" : '',
\    "timeout" : 60,
\    "on_close" : 'detach',
\    "break_on_open" : 0,
\    "ide_key" : 'netbeans-xdebug',
\    "path_maps" : {"/var/www/magento": "/home/rramirez/newtek/code/shop/magento"},
\    "debug_window_level" : 0,
\    "debug_file_level" : 3,
\    "debug_file" : "~/vdebug.log",
\    "watch_window_style" : 'expanded',
\    "marker_default" : '⬦',
\    "marker_closed_tree" : '▸',
\    "marker_open_tree" : '▾'
\}
