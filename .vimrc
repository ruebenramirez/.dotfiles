set encoding=utf-8
set nocompatible              " be iMproved
"set nowrap
set paste
set nospell
filetype off                  " required!
set textwidth=90


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle' " vim package management
Plugin 'tpope/vim-bundler'
"Plugin 'python-mode/python-mode'
Plugin 'psf/black' " format python code
Plugin 'nvie/vim-flake8' " lint python code
Plugin 'ctrlp.vim' " fuzzy search through subdirectories
Plugin 'DirDiff.vim' " diff entire directories of files
Plugin 'commentary.vim' " easily comment blocks of code
"Plugin 'mhinz/vim-signify' " show version control diffs
"Plugin 'tpope/vim-dispatch'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-endwise' " easily find end of if, do, and def blocks https://github.com/tpope/vim-endwise
"Plugin 'easymotion/vim-easymotion' "https://github.com/easymotion/vim-easymotion
Plugin 'preservim/tagbar' " list outline of classes in file https://github.com/preservim/tagbar
Plugin 'christoomey/vim-tmux-navigator'

" syntax highlight support
Plugin 'tpope/vim-markdown'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'hashivim/vim-terraform'
Plugin 'tsandall/vim-rego'
Plugin 'LnL7/vim-nix'
Plugin 'fisadev/vim-isort'
Plugin 'jalvesaq/Nvim-R'
Plugin 'kamykn/spelunker.vim'
call vundle#end()

filetype plugin indent on

set paste

" display relative line numbers
set number
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


"""""""""""""""""""""""""""""""""""""
" file type associations
"""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufReadPost *.md,*.markdown set filetype=markdown
autocmd BufNewFile,BufReadPost *.jbuilder set filetype=ruby
autocmd BufNewFile,BufReadPost *.py.tpl set filetype=python

"""""""""""""""""""""""""""""""""""""
" indentation: use spaces instead of tabs
"""""""""""""""""""""""""""""""""""""
"set smartindent
"set tabstop=4  shiftwidth=4 softtabstop=4 showtabline=4 expandtab
set tabstop=4 shiftwidth=4 expandtab
" set tabstop=2 shiftwidth=2 expandtab

" set 2 space tabs when appropriate
autocmd FileType go,r,R,yml,yaml,json,markdown,ruby,javascript,Rakefile setlocal shiftwidth=2 tabstop=2 softtabstop=2 showtabline=2

" set 4 space tabs when appropriate
autocmd FileType python,*.py.tpl setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 showtabline=4


" Remove end of line whitespace on save
autocmd BufWritePre * :%s/\s\+$//e


" format python code with Black on save
"autocmd BufWritePre * :Black


" Better diff highlighting
highlight! link DiffText MatchParen




"""""""""""""""""""""""""""""""""""""
" NERDtree config
"""""""""""""""""""""""""""""""""""""
" default larger window  width
let g:NERDTreeWinSize = 40


"""""""""""""""""""""""""""""""""""""
" highlight characters past column 80
" http://unlogic.co.uk/2013/02/08/vim-as-a-python-ide/
"""""""""""""""""""""""""""""""""""""
" augroup vimrc_autocmds
"     autocmd!
"     autocmd FileType python highlight OverLength ctermfg=white ctermbg=red guibg=#592929
"     autocmd FileType python match OverLength /\%81v.\+/
"     "autocmd FileType python set nowrap
"     augroup END

""""""""""""""""""""""""""""""""""""""
" Terraform formatting
""""""""""""""""""""""""""""""""""""""
let g:terraform_align=1
let g:terraform_fmt_on_save=1


""""""""""""""""""""""""""""""""""""""
" Leader keyboard shortcuts
""""""""""""""""""""""""""""""""""""""

"set timeoutlen=500
let mapleader = ","

" close file
nnoremap <leader>q :q<cr>

" save file
nnoremap <leader>s :w<cr>

" new tab
nnoremap <leader>t :Tex<cr>

" horizontal split
nnoremap <leader>h :sp<cr>

" vertical split
nnoremap <leader>v :vsp<cr>

" insert date
nnoremap <leader>d :put =strftime('%Y-%m-%d')<CR>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt


" navigation with control keys
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nmap <F8> :TagbarToggle<CR>
