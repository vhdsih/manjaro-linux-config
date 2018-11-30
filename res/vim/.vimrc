" for vundle {{
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" add plugin at there
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'jiangmiao/auto-pairs'
Plugin 'docunext/closetag.vim'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
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

" for airline
" let g:airline_theme='tomorrow'
let g:airline_powerline_fonts=0
let g:solarized_termcolors=16
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

" settings for IndentGuides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=1
let g:indent_guides_guide_size=1

" syntastic
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_cpp_compiler = "g++"
let g:syntastic_cpp_compiler_options = "-std=c++11 -stdlib=libc++"

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
set completeopt=longest,menu
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<CR>"
let g:ycm_key_list_select_completion=['c-n']
" let g:ycm_key_list_select_completion = ['Down']
let g:ycm_key_list_previous_completion=['<c-p>']
" let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_confirm_extra_conf=1
let g:ycm_key_invoke_completion = '<C-a>'
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_cache_omnifunc=0
let g:ycm_seed_identifiers_with_syntax=1
" nnoremap <leader>lo :lopen<CR>	"open locationlist
" nnoremap <leader>lc :lclose<CR>	"close locationlist
inoremap <leader><leader> <C-x><C-o>
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0

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

