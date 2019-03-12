" -------------------------- PRE PLUGIN REQUIREMENTS --------------------------
function! BuildMdComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

" ------------------------------ PLUG-VIM PLUGINS -----------------------------
call plug#begin('~/.config/nvim/plugged')


Plug 'scrooloose/nerdtree'
"Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'euclio/vim-markdown-composer', {'for': 'markdown', 'do': function('BuildMdComposer')}
Plug 'jiangmiao/auto-pairs'
Plug 'gabrielelana/vim-markdown'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-easy-align'
Plug 'guywald1/vim-prismo'
Plug 'Chiel92/vim-autoformat'
Plug 'luochen1990/indent-detector.vim'
Plug 'Yggdroot/indentLine'
Plug 'vim-python/python-syntax'
Plug 'cespare/vim-toml'
"Plug 'Valloric/YouCompleteMe', { 'do':  './install.py --rust-completer' }
Plug 'rust-lang/rust.vim',     { 'for': 'rust' }
"Plug 'vim-syntastic/syntastic'
Plug 'dylanaraps/wal.vim'
Plug 'aklt/plantuml-syntax'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-zsh'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'Shougo/neosnippet.vim'
Plug 'neomake/neomake'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'junegunn/goyo.vim'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'plaintex' }
Plug 'vim-scripts/scrollfix'
Plug 'tpope/vim-fugitive'
Plug 'othree/html5.vim'
Plug 'alvan/vim-closetag', { 'for': 'html' }

call plug#end()

" ---------------------------- BORING NEEDED STUFF ----------------------------
filetype on
let mapleader = ';'
colorscheme wal
let g:python3_host_prog="/usr/bin/python"

" ---------------------------- COLORSCHEME OVERRIDE ---------------------------
hi markdownXmlComment ctermfg=5

" --------------------------- SYSTEM WIDE CLIPBOARD ---------------------------
" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" ----------------------------------- LOOKS -----------------------------------
hi clear SpellBad
hi Spellbad cterm=underline
augroup looks
  au!
  au BufEnter :set conceallevel=0
augroup END


" ---------------------------------- KEYBINDS ---------------------------------
" edit .vimrc
nnoremap <leader>ev :hide edit $MYVIMRC<cr>
nnoremap <leader>sv :w<cr>:so $MYVIMRC<cr>:ex<cr>

" error switching
nnoremap <C-j> :lnext<cr>
nnoremap <C-k> :lprevious<cr>

" toggle relative numbering
noremap <C-l>l :set rnu!<cr>

" Show highlight groups
nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"" Autoclose xml tags
"function! s:CompleteTags()
"  imap <buffer> > ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR><Esc>:noh<CR>a
"  inoremap <buffer> ><Leader> >
"  imap <buffer> ><CR> ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR><CR><Tab><CR><Up><C-O>$<Esc>:noh<CR>a
"endfunction
"autocmd BufRead,BufNewFile *.html,*.xml call s:CompleteTags()

" --------------------------------- FORMATTING --------------------------------
function! MakeHeader(...)  
  if a:0 == 0
    let ext = input('file extension: ')
  else
    let ext = a:1
  endif

  exe "read!header_maker copyright_header.txt " . expand('%:t') . ' '
        \ . shellescape(ext, 1) . ' ' . expand('%:p:h')
endfunction

nnoremap mh :call MakeHeader()<cr>

"toggle between formatting and no formatting
function! ToggleFO()
  if &fo == ""
    :set fo=wantq
  else
    :set fo=
  endif

  :set fo?
endfunction

augroup formatting
  au!
  au FileType markdown,tex :setlocal formatoptions=wantq |
        \ :nnoremap <M-F> :call ToggleFO()<cr> |
        \ :inoremap <M-F> <C-\><C-O>:call ToggleFO()<cr>
augroup END
noremap <F3> :Autoformat<cr>
inoremap <C-A>c <esc>:Prismo<cr>$a
nnoremap <C-A>c :Prismo<cr>

" ------------------------- SWITCHING BETWEEN BUFFERS -------------------------
noremap gc :bn<cr><cr>
noremap gC :bp<cr><cr>
noremap gy :bd<cr>
set autowrite

" ----------------------------- PROGRAM EXECUTION -----------------------------
augroup program_exec
  au!
  au FileType python nnoremap <buffer> <F9> :w<cr>:exec '!python' shellescape(@%, 1)<cr>
  au FileType rust   compiler cargo | nnoremap <buffer> <F9> :w<cr>
        \:exe "!screen -S runCode -X stuff \
        \"clear && cd  " . getcwd() . " && cargo run \\n\""<cr><cr>
  au FileType tex nnoremap <buffer> <F9> :!pdflatex --shell-escape %<cr><cr>
  au FileType plantuml nnoremap <buffer> <F9> :!plantuml %<cr><cr>
  au FileType plantuml nnoremap <buffer> <S-F9> :!plantuml %<cr>
augroup END

" ------------------------------- EXTERNAL .VIM -------------------------------
" source ~/.config/nvim/plugged/vim-file-chooser/plugin/vim-file-chooser.vim

" ------------------------------ SYNTAX HIGHLIGHT -----------------------------
let g:python_highlight_all = 1
let g:indentguides_spacechar = "┆"
let g:indentguides_tabchar = "|"
augroup syntax_highlight
  au!
augroup END

" ---------------------------------- NERDTREE ---------------------------------
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nnoremap <C-c> :NERDTreeToggle<CR>

let NERDTreeShowHidden = 1

" --------------------------------- INDENTLINE --------------------------------
let g:indentLine_setColors = 1
let g:indentLine_conceallevel = 1

" --------------------------- AIRLINE CUSTOMIZATION ---------------------------
let g:airline_theme='murmur'
let g:airline#extensions#tabline#enabled = 1

" powerline separators
let g:airline_left_sep = "\ue0b0"
let g:airline_right_sep = "\ue0b2"

" Line numbers
set nu
set rnu

" ------------------------------- VIM-EASY-ALIGN ------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nnoremap ga <Plug>(EasyAlign)

" ------------------------------- VIM-AUTOFORMAT ------------------------------
let g:formatter_yapf_style = 'chromium'
" Tab settings
set tabstop     =8
set shiftwidth  =2
set softtabstop =2
set expandtab
set autoindent
set smarttab

" 

" --------------------------------- SYNTASTIC ---------------------------------
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"" movement
"nnoremap <C-j> :lnext<cr>
"nnoremap <C-k> :lprevious<cr>
"
"let g:syntastic_error_symbol             = '➜➜ '
"let g:syntastic_style_error_symbol       = 'S➜ '
"let g:syntastic_warning_symbol           = '➝➝'
"let g:syntastic_style_warning_symbol     = 'S➝'
"let g:syntastic_enable_signs             = 1
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list            = 1
"let g:syntastic_check_on_open            = 1
"let g:syntastic_check_on_wq              = 0
"let g:syntastic_auto_jump                = 0

" ---------------------------------- DEOPLETE ---------------------------------
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplet#omni#input_patterns = {}
endif

augroup deoplete
  au!
  au InsertLeave, CompleteDone * if pumvisible() == 0 | pclose | endif

augroup END

inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-t> pumvisible() ? "\<C-p>" : "\<C-t>"

" RUST
let g:deoplete#sources#rust#racer_binary='/home/master/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/master/rust-source/rust/src'

" ---------------------------------- NEOMAKE ----------------------------------
call neomake#configure#automake('nrwi', 500)
let g:neomake_open_list = 2
let g:neomake_rust_cargo_command = ['test', '--no-run']

" ------------------------------ INSTANT MARKDOWN -----------------------------
"let g:instant_markdown_autostart=0

" --------------------------- VIM MARKDOWN COMPOSER ---------------------------

" --------------------------------- NEOSNIPPET --------------------------------
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

let g:neosnippet#snippets_directory = '~/.config/nvim/snippets/'

" --------------------------------- SCROLLFIX ---------------------------------
let g:scrollfix=40
let g:fixeof=0

" ------------------------------ YOU COMPLETE ME ------------------------------
"let g:ycm_autoclose_preview_window_after_insertion  = 1
"let g:ycm_autoclose_preview_window_after_completion = 1
