syn on

set number

set tabstop=4
set shiftwidth=4
set expandtab

set modelines=2

set nocompatible          " be iMproved, required
filetype off               " required
colorscheme delek
"colorscheme torte         " is also good

" shut up! I hate visual bells.
set belloff=all

" ack: https://beyondgrep.com/
set grepprg=ack\ -k

" Cygwin/Microsoft stuff
" set paste
"set pastetoggle=<F2>

" set Space as leader
let mapleader=" "
" set backslash as localleader
let maplocalleader="\\"

" Edit the macro stored in register q
nnoremap <leader>q :<c-u><c-r><c-r>='let @q = '. string(getreg('q'))<cr><c-f><left>

" create a dash separator line
nnoremap <leader>l- o<esc>16i-<esc>j
nnoremap <leader>ld o<esc>16i-<esc>j
" create a equal separator line
nnoremap <leader>l= o<esc>16i=<esc>j
nnoremap <leader>le o<esc>16i=<esc>j

" create a line of hashes
nnoremap <leader>lc o<esc>32i#<esc>j
" create a line of slashes
nnoremap <leader>lc o<esc>32i/<esc>j

" Split single line on pipe
nnoremap <Leader>sp :%s/\|/\r/g<CR>

" quit all buffers without saving
" nnoremap <Leader>qa :qa!<CR>
nnoremap <localleader>q :qa!<CR>

" Start line with upside-down question mark, end with a regular, and start
" insert mode between them
nnoremap <Leader>uq A<Space>?<esc>0i¿ 

" Replace all spaces with underscores on the current line and yank to clipboard
nnoremap <Leader>stu :s/ /_/g<cr>lb"+yW

" Replace all spaces with dashes on the current line and yank to clipboard
nnoremap <Leader>std :s/ /-/g<cr>lb"+yW

" Replace tabs with 4 spaces
nnoremap <Leader>rts :%s/       /    /g<CR>

" Open hsplit
nnoremap <leader>hs :split<cr>

" Open vsplit
nnoremap <leader>vs :vsplit<cr>

" Close vsplit
nnoremap <leader>cs <c-w>c

" Open .vimrc in a split
nnoremap <leader>ev <C-w><C-v><c-l>:e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Toggle :set list
nnoremap <leader>sl :set list!<cr>

" Turn off line numbering for a clean copy
nnoremap <leader>nrn :set nonumber norelativenumber<cr>
nnoremap <leader>nln :set nonumber<cr>

" Turn on line numbering
nnoremap <leader>rn :set number relativenumber<cr>
nnoremap <leader>ln :set number<cr>

" Turn on line numbering
nnoremap <leader>ll :set number!<cr>

" Wrap word in double-quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" Wrap word in single-quotes
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" Wrap word in backticks
nnoremap <leader>` viw<esc>a`<esc>bi`<esc>lel

" Wrap word in parens
nnoremap <leader>( viw<esc>a)<esc>bi(<esc>lel

" Wrap visual in backticks (figure out how visual select mode works first)
"vnoremap <leader><c-=> `>a<esc>`<bi`<esc>lel

" jk in insert mode = <Esc>
inoremap jj <esc>

" when expandtab is on, use shift-Tab to insert tab in insert mode
inoremap <S-Tab> <C-V><Tab>

" Fix vim's broken regex handling
nnoremap / /\v
vnoremap / /\v

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" uppercase a word in insert mode with Ctrl-u
inoremap <c-u> <esc>viwUA

" uppercase a word in normal mode with Ctrl-u
nnoremap <c-u> viwUl

" Open a term to the right
"nnoremap <leader>vt :vsplit<cr><C-w>l:term
set splitright
nnoremap <leader>tt :vert term<cr>
"tnoremap <ESC><ESC> <C-\><C-N>


""" The following functions and remaps will split the first 2 lines of a
" pipe-delimited file into side by side splits for comparison of 
" header fields with data fields
"
" in .bash_profile, add this:
" ccc()
"{
"  head -2 $1 | vim -c ":call SplitPipeSplit()" -
"}
" to be able to do something like this: ccc /path/to/file.csv

" splits 2 pipe-delimited lines in one buffer into side by side windows
function! SplitPipeSplit()
    normal Gdd
    execute ":%s/\|/\r/g"
    execute ":vertical botright split " . localtime()
    execute ":wincmd k"
    normal Pjdd
    execute ":%s/\|/\r/g"
    normal 1G
    execute ":wincmd h"
    normal 1G
endfunction

" pastes 2 pipe-delimited lines from system clipboard into side by side windows and splits
function! ClipboardSplitPipeSplit()
    normal "+P
    execute SplitPipeSplit()
endfunction

" splits the first 2 pipe-delimited lines of the current buffer into side by side windows for comparison
function! FilePipeSplit()
    normal 3GdG
    execute SplitPipeSplit()
endfunction

nnoremap <Leader>ss :call SplitPipeSplit()<CR>
nnoremap <Leader>cs :call ClipboardSplitPipeSplit()<CR>
nnoremap <Leader>fs :call FilePipeSplit()<CR>

" load templates
au BufNewFile * silent! 0r ~/.vim/templates/%:e.tpl
" but it doesn't work

augroup filetype_html
    autocmd!
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END

augroup filetype_sql
    autocmd!
    autocmd FileType sql nnoremap <buffer> <localleader>c 0i-- <esc>
augroup END

" Enable folding
set foldmethod=indent
set foldlevel=99

"hi Search cterm=NONE ctermfg=grey ctermbg=blue

" netrw setup
nnoremap <leader>x :Vexplore<cr>
"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

" Powerline setup
"let g:airline_powerline_fonts = 1

" slimv stuff
set runtimepath^=~/.vim/bundle/slimv
let g:lisp_rainbow=1
