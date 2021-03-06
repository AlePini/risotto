" ============================================================
"
" `7MMF'   `7MF'`7MMF'`7MMM.     ,MMF'`7MM"""Mq.   .g8"""bgd
"   `MA     ,V    MM    MMMb    dPMM    MM   `MM..dP'     `M
"    VM:   ,V     MM    M YM   ,M MM    MM   ,M9 dM'       `
"     MM.  M'     MM    M  Mb  M' MM    MMmmdM9  MM         
"     `MM A'      MM    M  YM.P'  MM    MM  YM.  MM.        
"      :MM;       MM    M  `YM'   MM    MM   `Mb.`Mb.     ,'
"       VF      .JMML..JML. `'  .JMML..JMML. .JMM. `"bmmmd' 
"
" ============================================================

let mapleader = ","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'scrooloose/nerdtree'

" Autocompletition
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'

    " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()

    " IMPORTANT: :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect

    " When the <Enter> key is pressed while the popup menu is visible, it only
    " hides the menu. Use this mapping to close the menu and also start a new
    " line.
    inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

    " Use <TAB> to select the popup menu:
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    let g:tex_flavor = 'latex'

    " NOTE: you need to install completion sources to get completions. Check
    " our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'
    Plug 'lervag/vimtex'

    " Color scheme Dracula
    Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

" Completition Options
au BufEnter * call ncm2#enable_for_buffer()
au User Ncm2Plugin call ncm2#register_source({
            \ 'name' : 'vimtex',
            \ 'priority': 1,
            \ 'subscope_enable': 1,
            \ 'complete_length': 1,
            \ 'scope': ['tex'],
            \ 'matcher': {'name': 'combine',
            \           'matchers': [
            \               {'name': 'abbrfuzzy', 'key': 'menu'},
            \               {'name': 'prefix', 'key': 'word'},
            \           ]},
            \ 'mark': 'tex',
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })

" Options
    set rnu
    set nu
    syntax on
    colorscheme dracula
    set termguicolors

" Set tab width to 2 because 8 it's too fucking long
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
    set expandtab

" Include some dir for C++
    let &path.="src/include,/usr/include/AL,"

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
    set splitbelow splitright

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Open NerdTree
    map <leader>n :NERDTreeToggle<CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Enable Syntax for rofi themes
  au BufNewFile,BufRead /*.rasi setf css
