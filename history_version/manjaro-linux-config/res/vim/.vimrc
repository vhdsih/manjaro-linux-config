" for vundle {{
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" add plugin at there
Plugin 'VundleVim/Vundle.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'jiangmiao/auto-pairs'
Plugin 'docunext/closetag.vim'
" plugin end here
call vundle#end()
filetype plugin indent on
" }}

" basic {{
set number
set ruler
set showcmd
set nobackup
set noswapfile
set cursorline
set autoindent
set cindent
set smarttab
set expandtab
set smartindent
set wildmenu
set hlsearch
set nowrap
set guifont=monaco
set encoding=utf-8
set mouse=a
set tabstop=4
set shiftwidth=4
set softtabstop=4
set history=1000
" }}

" leader {{
let mapleader=","
nmap <leader>w :w!<CR>
nmap <leader>q :q<CR>
nmap <leader>q1 :q!<CR>
nmap <leader>wq :wq<CR>
nmap <leader>WQ :wq<CR>
nmap <leader>Q :wq<CR>
nmap <leader>y "+y
nmap <leader>p "+p 
" clear highlight
nmap <leader>l :noh<CR>
"buffer
nmap <leader><Tab> :bn<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}
"
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
map <F9> :call CompileRun()<CR>

" hightlight
syntax enable
syntax on
set shortmess=atI

" color
" airline can be display when set this
set t_Co=256
set laststatus=2
set noshowmode
set background=dark
colorscheme dracula "molokai
let g:onedark_termcolors=256

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

" settings for IndentGuides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=1
let g:indent_guides_guide_size=1

" compile and run {{
func! CompileRun()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %< -lm"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ -std=c++11 % -o %<"
        exec "! ./%<"
    elseif &filetype == 'sh'
        :!./%
    elseif &filetype == 'python'
        exec "!python %"
    endif
endfunc
" }}

