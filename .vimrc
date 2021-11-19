set encoding=utf-8
set nocompatible              " be iMproved
set wrap
filetype off                  " required!

let mapleader = "\<Space>"

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle' " vim package management
"Plugin 'python-mode/python-mode'
Plugin 'ambv/black'
"Plugin 'tell-k/vim-autopep8'
Plugin 'nvie/vim-flake8'
Plugin 'ctrlp.vim'
Plugin 'DirDiff.vim' " diff entire directories of files
Plugin 'commentary.vim' " easily comment stuff out
Plugin 'mhinz/vim-signify' " show version control diffs
"Plugin 'davidhalter/jedi-vim' " syntax autocompletion
Plugin 'tpope/vim-markdown'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'joonty/vdebug.git'
Plugin 'taglist.vim'
Plugin 'tpope/vim-dispatch'
"Plugin 'scrooloose/nerdtree'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'vim-ruby/vim-Ruby'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-endwise'
Plugin 'easymotion/vim-easymotion'
"Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
"Plugin 'tpope/vim-db'
Plugin 'christoomey/vim-tmux-navigator'
"Plugin 'posva/vim-vue'
Plugin 'hashivim/vim-terraform'
"Plugin 'scrooloose/syntastic'
"Plugin 'vim-syntastic/syntastic'
"Plugin 'juliosueiras/vim-terraform-completion'
Plugin 'tsandall/vim-rego'
call vundle#end()

filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

" display relative line numbers
set number
" set relativenumber
set numberwidth=3

" enable syntax highlighting
syntax on

" underline the current line
set cursorline

" case insensitive search
set ignorecase

" highlight searches
set hlsearch
set vi+=n

set backspace=indent,eol,start

" file type associations
autocmd BufNewFile,BufReadPost *.md,*.markdown set filetype=markdown
autocmd BufNewFile,BufReadPost *.jbuilder set filetype=ruby
autocmd BufNewFile,BufReadPost *.py.tpl set filetype=python

" indentation: use spaces instead of tabs
set smartindent
set tabstop=4  shiftwidth=4 softtabstop=4 showtabline=4 expandtab
" set tabstop=4 shiftwidth=4 expandtab
" set tabstop=2 shiftwidth=2 expandtab

" set 2 space tabs when appropriate
autocmd FileType yml,yaml,json,markdown,ruby,javascript,Rakefile setlocal shiftwidth=2 tabstop=2 softtabstop=2 showtabline=2

" set 4 space tabs when appropriate
autocmd FileType python,*.py.tpl setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 showtabline=4

" Remove whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Better diff highlighting
highlight! link DiffText MatchParen

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
" vim xdebug (PHP dev)
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

""""""""""""""""""""""""""""""""""""""
" Terraform formatting
""""""""""""""""""""""""""""""""""""""
let g:terraform_align=1
let g:terraform_fmt_on_save=1

""""""""""""""""""""""""""""""""""""""
" Syntastic Config
""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


"let g:syntastic_check_on_wq = 0
let g:syntastic_yaml_checkers = [ "yamllint" ]
let g:syntastic_quiet_messages = { "type": "style" }

""""""""""""""""""""""""""""""""""""""
" (Optional)Remove Info(Preview) window
""""""""""""""""""""""""""""""""""""""
set completeopt-=preview

""""""""""""""""""""""""""""""""""""""
" (Optional)Hide Info(Preview) window after completions
""""""""""""""""""""""""""""""""""""""
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

""""""""""""""""""""""""""""""""""""""
" (Optional) Enable terraform plan to be include in filter
""""""""""""""""""""""""""""""""""""""
let g:syntastic_terraform_tffilter_plan = 1

""""""""""""""""""""""""""""""""""""""
" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
""""""""""""""""""""""""""""""""""""""
let g:terraform_completion_keys = 1

""""""""""""""""""""""""""""""""""""""
" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
""""""""""""""""""""""""""""""""""""""
let g:terraform_registry_module_completion = 0
