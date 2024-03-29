set nocompatible
filetype off  " required!
filetype plugin off
" To get a new copy of Vundle
" export GIT_SSL_NO_VERIFY=true
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
"Bundle 'Lokaltog/vim-powerline'
Bundle 'kien/ctrlp.vim'
Bundle 'sjl/clam.vim'
" Slime-like tmux plugin
" Bundle 'tslime.vim'
" Plugin for super-fast html/xml coding
" Git plugin
Bundle 'tpope/vim-fugitive'
" filetype stuff for gitcommit file types
Bundle 'tpope/vim-git'
" TODO: Check out www.vim.org/scripts/script.php?script_id=3342 OR vimoutliner
" Ipython plugin
Bundle 'ivanov/vim-ipython'

Bundle 'klen/python-mode'

" Webs-type stuff
Bundle 'ZenCoding.vim'
Bundle 'vim-scripts/vim-coffee-script'
Bundle 'groenewege/vim-less'


Bundle 'fsouza/go.vim'

" Fancy undo tree visualization
Bundle 'sjl/gundo.vim'
" NerdCommenter
Bundle 'scrooloose/nerdcommenter'
" Disallows Arrow Keys
Bundle 'vim-scripts/dogmatic.vim'
" Thing for storing code snippets
Bundle 'snippets.vim'
" Magic indent hax
Bundle 'ervandew/supertab'
" Automatically close matching stuff
Bundle 'kana/vim-smartinput'
" color groups of parens
Bundle 'kien/rainbow_parentheses.vim'
"Colors
Bundle 'Tuurlijk/typofree.vim'
" Has a crazy number of color schemes
" Bundle 'noah/vim256-color'
" http://vim.wikia.com/wiki/256_colors_in_vim

filetype plugin indent on     " required!

set background=dark
colorscheme desert
if &t_Co > 200
	colorscheme typofree
endif

"Map , as the leader key
let mapleader = ","

" Filetype templates
autocmd! BufNewFile * silent! 0r ~/.vim/skel/template.%:e

""""""Die, Error bells
set noerrorbells


""""""Visual
" Shorten error messages, and get rid of some obnoxious ones
set shortmess=atI


syntax on
syntax sync fromstart

""""""Visual
set number
set showmode
set wrap
set wrapmargin=8000
set background=dark
set ruler
set backspace=start,indent,eol
set showmatch       " Briefly jump to a paren once it's balanced
set matchtime=2     " Do so for exactly 2 seconds
set scrolloff=5 "Keep the cursor at least 5 lines from the top and bottom

""""""Buffer management
" Use +/- to change window height
" Use * and / to change width
if bufwinnr(1)
	map <kPlus> <C-W>+
	map <kMinus> <C-W>-
	map <kDivide> <c-w><
	map <kMultiply> <c-w>>
endif

""""""Indentation
set shiftwidth=3
set tabstop=3
set listchars=tab:>-,trail:-,eol:$,nbsp:%
set list
" This turns indentation into just 'start at the same as previoius line'
"set autoindent
"set nosmartindent
"set nocindent
" Convert file between spaces and tabs
map <leader>t :%s/    /\t/gg<CR>
map <leader>T :%s/\t/    /gg<CR>

""""""Terminal
set showcmd
set laststatus=2
"fancy status bar
set statusline=%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ L#:\ %l/%L:%c\ \ FT:%Y\ \ %P\ \ %{fugitive#statusline()}
set report=0        " Show number of lines changed by : commands
set ch=1 "Set height of command line
"levels of undo
set history=1000
set undolevels=1000

" Function to return current directory for status line
function! CurDir()
	let curdir = substitute(getcwd(), '/home/ryansb/', "~/", "g")
		return curdir
	endfunction

"Search things
nmap <silent> ,/ :nohlsearch<CR> 
set hlsearch
set gdefault
set incsearch
"ignore search case with all lowercase, use case when all uppercase
set ignorecase
set smartcase

""""""Encoding
set encoding=utf-8  " Set file encoding
set termencoding=utf-8

"Backups are for pussies. Save often. Use version control.
"Don't be a pussy. 
set nobackup
set noswapfile
set noautowrite      " When I want to write to a file, I'll say so
set noautowriteall 
set autoread         "Re-read open files when they are changed outside Vim

"""""FileType specific settings
" Autocomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python inoremap <Nul> <C-x><C-o>
autocmd FileType perl set omnifunc=perlcomplete#CompletePerl
autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp


" Python stuff
let python_highlight_all=1

" Highlight whitespace
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Map ; to : for great pythonic justice
autocmd FileType python inoremap ; :
autocmd FileType python inoremap : ;

" set foldmethod (fdm) to be indent-based for Python
autocmd FileType python set fdm=indent
if CurDir() == "/home/ryansb/.vmail"
	set nofoldenable
endif

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

"When writing a Latex file, automatically recompile it and then show it in
"evince
autocmd BufWritePost *.tex :!pdflatex % && evince `echo % | sed 's/\.tex/\.pdf/'` &

"""""XML stuff
"au BufNewFile,BufRead *.less set filetype=less
autocmd FileType xml,xslt,xhtml,html,less,css set ts=2 shiftwidth=2 expandtab
map <Leader>x :%!tidy -utf8 -xml -i -q -w 0<CR>

""""""Keybindings
" Map ; to : in normal mode for mega-easy vim commands. 
nnoremap ; :

" Map a quick way to save the current session
nmap <Leader>s :mksession session.vim<CR>

" When vimrc is edited, reload it
" autocmd! bufwritepost vimrc source /etc/vim/vimrc


"let jj get you out of insert mode
inoremap jj <ESC>

" Let Y yank to end of line like C and D
nnoremap Y y$

"w!! writes the file using sudo
cmap w!! w !sudo tee % >/dev/null

" Word swapping
nmap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o><c-l>

" Character swapping
nmap <silent> gc xph

" tabs
" create a new tab
map :tc :tabnew %<cr>
" close a tab
map :td :tabclose<cr>

"let me add newlines by hitting enter in normal mode
""nmap <CR> o<ESC>

"Insert timestamp on next line
map <F5> :r!date<CR>

" Bindings for code folding
nnoremap zz zO
nnoremap Zz zM
nnoremap zZ zR

"go vertical even with line wraps and don't jump
"noremap j gj
"noremap k gk

" Mappings to jump me to the beginning of functions
" Cred to Globe for these ones
map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

" take you out of insert mode after being inactive for a while
" au CursorHoldI * stopinsert

" Toggle paste/nopaste
map <Leader>ip :set invpaste invnumber invlist<CR>

" Yank to system clipboard
map <Leader>y "+y

" Clear registers
function! ClearReg()
	let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"' 
	| let i=0 | while (i<strlen(regs)) | exec 'let @'.regs[i].'=""' | 
		let i=i+1 | endwhile | unlet regs'"'
	return ""
	endfunction
map <Leader>cr :call ClearReg()<CR>

""""""Plugins

" PyLint.vim
"autocmd FileType python compiler pylint
"let g:pylint_show_rate = 0
"let g:pylint_onwrite = 0

" Rainbow Parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['red',         'firebrick3'],
    \ ]
au VimEnter * RainbowParenthesesToggle
au VimEnter * RainbowParenthesesLoadSquare
au VimEnter * RainbowParenthesesLoadBraces
"au VimEnter * RainbowParenthesesLoadRound
function! RPT()
	cal rainbow_parentheses#load(0)
	cal rainbow_parentheses#load(1)
	cal rainbow_parentheses#load(2)
	cal rainbow_parentheses#load(3)
	endfunction
nnoremap <Leader>p :call RPT()<CR>

" NERDTree
map <Leader>n :NERDTreeToggle<CR>
let NERDTreeWinPos='right'
let NERDTreeQuitOnOpen = 1

" NERDTree and Ack
let g:path_to_search_app = "/usr/bin/ack"

" Gundo
nnoremap <Leader>g :GundoToggle<CR>
let g:gundo_right = 1
let g:gundo_preview_height = 20
let g:gundo_preview_bottom = 1
let g:gundo_close_on_revert = 1

" Chapa
let g:chapa_default_mappings = 1
let g:chapa_no_repeat_mappings = 1

let g:snippets_base_directory = '/home/ryansb/.vim/snippets'
map <Leader>h :InsertSnippet<CR>head<CR>
map <Leader>m :InsertSnippet<CR>all<CR>license<CR>

" ZenCoding
let g:user_zen_leader_key = '<c-l>'

" SuperTab
let g:SuperTabDefaultCompletionType="context"

" CtrlP
nnoremap <Leader>o :CtrlPMixed<CR>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.gz,*.tgz,*.tar  " MacOSX/Linux
let g:ctrlp_custom_ignore = '\.git$|\.hg$\|\.svn$|\.virtualenvs$|\.cache$|\.rvm$|\.exe$\|\.so$\|\.dll$|\.pyc$|\.swp$'
let g:ctrlp_user_command = 'find %s -type f'

" Clam.vim
nnoremap <Leader>C :Clam

""""""Buffers and autoload
" to save macros in your vimrc, follow this format:
" let @x = 'dw^[ '
" Fun fact: To save all of the current :map and :set settings just run :mkexrc
" TODO: check out Marvim
" http://www.vim.org/scripts/script.php?script_id=2154
"autocmd FileType python map <buffer> <F6> :call Pep8()<CR>

let g:pymode_run = 1
let g:pymode_run_key = '<leader>r'
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'
let g:pydoc = 'pydoc'
let g:pymode_lint_checker = "pylint,pyflakes,pep8"
let g:pymode_lint_onfly = 0
let g:pymode_lint_jump = 0
let g:pymode_options_fold = 0
let g:pymode_breakpoint_key = '<leader>b'


" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF


" `gf` jumps to the filename under the cursor.  Point at an import statement
" and jump to it!
python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

" Use F7/F8 to add/remove a breakpoint (pdb.set_trace)
" Totally cool.
python << EOF
def SetBreakpoint():
    import re
    nLine = int( vim.eval( 'line(".")'))
    strLine = vim.current.line
    strWhite = re.search( '^(\s*)', strLine).group(1)
    vim.current.buffer.append(
       "%(space)spdb.set_trace() %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)
    for strLine in vim.current.buffer:
        if strLine == "import pdb":
            break
    else:
        vim.current.buffer.append( 'import pdb', 0)
        vim.command( 'normal j1')
vim.command( 'map <f7> :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
    import re
    nCurrentLine = int( vim.eval( 'line(".")'))
    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine == "import pdb" or strLine.lstrip()[:15] == "pdb.set_trace()":
            nLines.append( nLine)
        nLine += 1
    nLines.reverse()
    for nLine in nLines:
        vim.command( "normal %dG" % nLine)
        vim.command( "normal dd")
        if nLine < nCurrentLine:
            nCurrentLine -= 1
    vim.command( "normal %dG" % nCurrentLine)
vim.command( "map <f8> :py RemoveBreakpoints()<cr>")
EOF
