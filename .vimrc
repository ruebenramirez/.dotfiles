set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My bundles here:
"
" original repos on GitHub
Bundle 'commentary.vim'
Bundle 'ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non-GitHub repos
Bundle 'git://git.wincent.com/command-t.git'
" TODO does the github link work?
" Bundle 'crooloos/nerdtree'
Bundle 'git://github.com/scrooloose/nerdtree.git'

Bundle 'klen/python-mode'

" Git repos on your local machine (i.e. when working on your own plugin)
"Bundle 'file:///Users/gmarik/path/to/plugin'
" ...

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

nnoremap <leader>. :CtrlPTag<cr>
nnoremap <silent> <Leader>b :TagbarToggle<CR>

" F2 for nerdtree
map <F2> :NERDTreeToggle<CR>

set nu
syn on
set cursorline
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase

" read *.md as markdown files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

""" this is amateur hour here
" python column count buffer red line
" set colorcolumn=81 "set cc=80 "cc for short

""" This is a better way of doing this....if it actually works
" http://unlogic.co.uk/2013/02/08/vim-as-a-python-ide/
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 80 
    autocmd FileType python highlight OverLength ctermfg=white ctermbg=red guibg=#592929
    autocmd FileType python match OverLength /\%81v.\+/
    autocmd FileType python set nowrap
    augroup END
