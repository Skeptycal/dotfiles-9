set nocompatible    " do not try to be vi-compatible

call pathogen#infect()

set guifont=Inconsolata\ 11

syntax on             " syntax coloring by default

color solarized
set background=dark

if &t_Co >= 256 && ! has("gui_running")
    " do not use solarized within term with 256 colors
    colorscheme inkpot
endif

set textwidth=120
set wrap            " auto wrap line view, but not text itself

filetype indent on  " activates indenting for files
set softtabstop=4   " width of a tab
set tabstop=4
set shiftwidth=4    " width of the indentation
set expandtab

set ignorecase      " case-insentive search by default
set smartcase       " search case-sensitive if there is an upper-case letter
set gdefault        " when replacing, use /g by default
set showmatch       " paren match highlighting
set hlsearch        " highlight what you search for  
set incsearch       " type-ahead-find  
set wildmenu        " command-line completion shows a list of matches
set wildmode=longest,list:longest,full " Bash-vim completion behavior
set autochdir       " use current working directory of a file as base path

set encoding=utf-8

set nu              " show line numbers
set showmode        " show the current mode on the last line
set showcmd         " show informations about selection while in visual mode

set guioptions-=T   "remove toolbar

set colorcolumn=72,120  " highligth the 80th and 120th column

"set cursorline " highlight current line

" all operations such as yy, D, and P work with the clipboard.
" No need to prefix them with "* or "+
set clipboard=unnamed

" New split placed below
set splitbelow
" New vsplit placed right
set splitright

set foldmethod=syntax
set foldlevelstart=20 " buffer are always loaded with opened folds

" persistent undo across sessions
set undofile
set undodir=~/.vim/undodir

" always keep lines around the cursor
set scrolloff=5

" Let cursor move past the last char in visual block mode
set virtualedit=block

" show more matching characters
set matchpairs+=<:>

let mapleader = "," " leader key is comma

" xx will delete the line without copying it into the default register
nnoremap xx "_dd

nnoremap <leader>t :set noexpandtab<CR>

" Yank the line, comment it, paste it
nnoremap <leader>g yygccp

" When jumping to a given line, center the screen
nnoremap G Gzz

" ,v will reselect the text that was just pasted
nnoremap <leader>v V`]

" ,w will disable autowrap line break
nnoremap <leader>w :set tw=0<CR>
nnoremap <leader>W :set tw=80<CR>
nnoremap <leader>x :set tw=120<CR>

" ,s will split vertically and swith over the new panel
nnoremap <leader>s <C-w>v<C-w>l:bn<CR>

" ,S will split horizontally and swith over the new panel
nnoremap <leader>S <C-w>s<C-w>l:bn<CR>

" Wrap a paragraph and justify it
:runtime macros/justify.vim
nnoremap <leader>j gw}{V}:call Justify('tw',4)<CR>

" activate rainbow parenthesis
" nnoremap <leader>R :RainbowParenthesesToggle<CR>
nnoremap <leader>r :RainbowToggle<CR>

" activate gundo
nnoremap <leader>u :GundoToggle<CR>

" remove all C/C++ comments and blank lines
nnoremap <leader>c :%s/\/\*\_.*\*\/\n\{,1}\|^\s*\/\/.*\n\|\s*\/\/.*//<CR>:%s/^\s*\n//<CR>

" set a tiny guifont size 
nnoremap <leader>h :set guifont=Inconsolata\ 4<CR>

" set a normal guifont size 
nnoremap <leader>f :set guifont=Inconsolata\ 11<CR>

" set a big guifont size
nnoremap <leader>ç :set guifont=Inconsolata\ 14<CR>

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>p :CtrlP %%<cr>

" semantic selection expansion/shrink
map + <Plug>(expand_region_expand)
map - <Plug>(expand_region_shrink)

" use shift-space as escape
"inoremap <S-Space> <Esc>

" print tabs with a special character (add ",eol:·" for end of lines)
set listchars=trail:·,nbsp:·,tab:▸\ ,extends:»,precedes:«,
set list

au VimEnter * echomsg system('/usr/games/fortune vimtweets')

"au FocusLost * :wa   " save every opened buffer when the window lost focus


set laststatus=2    " always show the statusline, even when there is only one file edited
" if has("statusline")
"     "set statusline=\ %f%m%r\ [%{strlen(&ft)?&ft:'aucun'},%{strlen(&fenc)?&fenc:&enc},%{&fileformat},ts:%{&tabstop}]%{fugitive#statusline()}%=%l,%c%V\ %P
"     set statusline=\ %f%m%r\ [%{strlen(&ft)?&ft:'aucun'},%{strlen(&fenc)?&fenc:&enc},%{&fileformat},ts:%{&tabstop}]%=%l,%c%V\ %P
" elseif has("cmdline_info")
"     set ruler           " show current line and column number
" endif


if has("fname_case")
  au BufNewFile,BufRead *.lsp,*.lisp,*.el,*.cl,*.jl,*.L,.emacs,.sawfishrc,*.pddl setf lisp
else
  au BufNewFile,BufRead *.lsp,*.lisp,*.el,*.cl,*.jl,.emacs,.sawfishrc,*.pddl setf lisp
endif


" move the current line up or down with the Ctrl-arrow keys
nmap <C-Down> :<C-u>move .+1<CR>
nmap <C-Up>   :<C-u>move .-2<CR>
imap <C-Down> <C-o>:<C-u>move .+1<CR>
imap <C-Up>   <C-o>:<C-u>move .-2<CR>
vmap <C-Down> :move '>+1<CR>gv
vmap <C-Up> :move '<-2<CR>gv

filetype plugin on
set ofu=syntaxcomplete#Complete

au BufRead,BufNewFile *.mwiki setf Wikipedia
au BufRead,BufNewFile *.wikipedia.org.* setf Wikipedia

" autocomplétion with <TAB> instead of <C-n>, depending on the context
"   function! Smart_TabComplete()
"     let line = getline('.')                         " curline
"     let substr = strpart(line, -1, col('.')+1)      " from start to cursor
"     let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
"     if (strlen(substr)==0)                          " nothing to match on empty string
"       return "\<tab>"
"     endif
"     let has_period = match(substr, '\.') != -1      " position of period, if any
"     let has_slash = match(substr, '\/') != -1       " position of slash, if any
"     if (!has_period && !has_slash)
"       return "\<C-X>\<C-P>"                         " existing text matching
"     elseif ( has_slash )
"       return "\<C-X>\<C-F>"                         " file matching
"     else
"       return "\<C-X>\<C-O>"                         " plugin matching
"     endif
"   endfunction

" inoremap <tab> <c-r>=Smart_TabComplete()<CR>


" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
        \ &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>


"switch spellcheck languages
let g:myLang = 0
let g:myLangList = [ "nospell", "fr_fr", "en_gb" ]
function! MySpellLang()
    "loop through languages
    let g:myLang = g:myLang + 1
    if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
    if g:myLang == 0 | set nospell | endif
    if g:myLang == 1 | setlocal spell spelllang=fr_fr | endif
    if g:myLang == 2 | setlocal spell spelllang=en_us | endif
    echo "language:" g:myLangList[g:myLang]
endf
map <F7> :call MySpellLang()<CR>
imap <F7> <C-o>:call MySpellLang()<CR>


" search the file for FIXME, TODO and put them in a handy list
map <F10> <Plug>TaskList

" side pane of class and functions
"map <F11> :TlistToggle<cr>
nmap <F12> :TagbarToggle<CR>
nnoremap <leader>b :TagbarToggle<CR>

" side pane of files
map <F11> :NERDTreeToggle<cr>
" nnoremap <leader>t :NERDTreeToggle<cr>

" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/bmdd
set tags+=~/.vim/tags/bmddsolver
set tags+=~/.vim/tags/dae
set tags+=~/.vim/tags/eodev
" build tags of your own project with CTRL+F12
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" close the buffer without deleting its window
:runtime plugins/bclose.vim
nmap :bc <Plug>Kwbd

