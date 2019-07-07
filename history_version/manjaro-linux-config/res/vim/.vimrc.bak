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
nmap <leader>y "+y
nmap <leader>p "+p
nmap <space> :
nmap <C-l> :noh<CR>
"buffer
nmap <leader><Tab> :bn<CR>
"strip all trailing whitespace in the current file
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>
" }}


" hightlight
syntax enable
syntax on

" color
" airline can be display when set this
set t_Co=256
set laststatus=2
set background=dark
colorscheme onedark
let g:onedark_termcolors=256
" color molokai

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

" for vundle {{
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" add plugin at there

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-fugitive'
Plugin 'djoshea/vim-matlab'
Plugin 'djoshea/vim-matlab-fold'
Plugin 'dracula/vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'Raimondi/delimitMate'
Plugin 'docunext/closetag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/syntastic'
Plugin 'jiangmiao/auto-pairs'
" Plugin 'jeaye/color_coded'
Bundle 'ShowTrailingWhitespace'
Bundle 'molokai'
" plugin end here
call vundle#end()
filetype plugin indent on
" }}

" settings for airline
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts=1
let g:solarized_termcolors=16
" let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
" tarbar
nmap <leader>tb :Tagbar<CR>
" settings for nerdtree
map <C-b> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd StdinReadPre * let s:std_in=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" settings for IndentGuides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
hi IndentGuidesOdd guibg=red ctermbg=3
hi IndentGuidesEven guibg=green ctermbg=4

" settings for youcompleteme
" highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项
" youcompleteme  默认tab  s-tab 和自动补全冲突
let g:ycm_key_list_select_completion=['<c-n>']
" let g:ycm_key_list_select_completion = ['Down']
let g:ycm_key_list_previous_completion=['<c-p>']
" let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
let g:ycm_key_invoke_completion = '<C-a>' " 强制补全
let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2	" 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>	"force recomile with syntastic
" nnoremap <leader>lo :lopen<CR>	"open locationlist
" nnoremap <leader>lc :lclose<CR>	"close locationlist
inoremap <leader><leader> <C-x><C-o>
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0

nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处

" imap { {}<ESC>i<CR><ESC>V<O

" settings for nerdcommenter
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

" for ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" syntastic
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
" color code
" hi link StructDecl Type
" hi link UnionDecl Type
" hi link ClassDecl Type
" hi link EnumDecl Type

" compile and run {{
map <F9> :call CompileRun()<CR>
func! CompileRun()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ -std=c++11 % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    elseif &filetype == 'python'
        :!python %
    endif
endfunc
" }}
" add header for files {{
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java, exec ":call SetTitle()" 
func SetTitle() 
    if &filetype == 'sh' 
        call setline(1,"\#!/bin/bash") 
    endif
    if &filetype == 'cpp'
        call setline(1, "/* author: dongchangzhang */")
        call append(line("."), "/* time: ".strftime("%c")." */")
        call append(line(".")+1, "")
        call append(line(".")+2, "#include<algorithm>")
        call append(line(".")+3, "#include<iostream>")
        call append(line(".")+4, "#include<vector>")
        call append(line(".")+5, "#include<string>")
        call append(line(".")+6, "")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call setline(1, "/* author: dongchangzhang */")
        call append(line("."), "/* time: ".strftime("%c")." */")
        call append(line(".")+1, "")
        call append(line(".")+2, "#include<stdio.h>")
        call append(line(".")+3, "")
    endif
    autocmd BufNewFile * normal G
endfunc 
"
" }}
