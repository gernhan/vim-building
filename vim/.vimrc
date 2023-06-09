set termguicolors
" linux only
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let &t_TI = "\<Esc>[>4;2m"
let &t_TE = "\<Esc>[>4;m"
" let mapleader="\\"
" let mapleader="\'"
nnoremap <SPACE> <Nop>
let mapleader=" "

set pastetoggle=<F3>
set encoding=UTF-8
set autoindent expandtab tabstop=2 shiftwidth=2
set number
" linux only
" vnoremap <C-c> ""y

map  <C-t>l :tabn<CR>
map  <C-t>h :tabp<CR>
map  <C-t>n :tabnew<CR>

set mouse=a
if empty(glob('~/.vim/autoload/plug.vim'))
	  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

      if !has('ide')
        Plug 'mbbill/undotree'
          nnoremap <leader>undo :UndotreeToggle<CR>
        Plug 'liuchengxu/vim-which-key'

        " On-demand lazy load
        Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

        " To register the descriptions when using the on-demand load feature,
        " use the autocmd hook to call which_key#register(), e.g., register for the Space key:
        autocmd! User vim-which-key call which_key#register('<SPACE>', 'g:which_key_map')
        nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
        vnoremap <silent> <leader> :WhichKey '<Space>'<CR>
        set timeoutlen=500

      endif
	" lsp - easy motion {{{
      if !has('ide')
        Plug 'voldikss/vim-floaterm'
          let g:floaterm_width=0.99
          let g:floaterm_height=0.99
          nmap <leader>tt :FloatermToggle<CR>
          tnoremap <silent> <Leader>tt <C-\><C-n>:FloatermToggle<CR>
          nmap <leader>tw :FloatermNew<CR>
          nmap <leader>tx :FloatermKill<CR>
          tnoremap <silent> <Leader>tx <C-\><C-n>:FloatermKill<CR>
          nmap <leader>tn :FloatermNext<CR>
          tnoremap <silent> <Leader>tn <C-\><C-n>:FloatermToggle<CR>:FloatermNext<CR>
          nmap <leader>tp :FloatermPrev<CR>
          tnoremap <silent> <Leader>tp <C-\><C-n>:FloatermToggle<CR>:FloatermPrev<CR>

        Plug 'sheerun/vim-polyglot'
        Plug 'prabirshrestha/vim-lsp'
        Plug 'mattn/vim-lsp-settings'
          let g:lsp_semantic_enabled = 1

					function! s:on_lsp_buffer_enabled() abort
							setlocal omnifunc=lsp#complete
							setlocal signcolumn=yes
							if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
							nmap <buffer> gd <plug>(lsp-definition)
							nmap <buffer> gs <plug>(lsp-document-symbol-search)
							nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
							nmap <buffer> gr <plug>(lsp-references)
							nmap <buffer> gi <plug>(lsp-implementation)
							nmap <buffer> gt <plug>(lsp-type-definition)
							nmap <buffer> <leader>rn <plug>(lsp-rename)
							nmap <buffer> mE <plug>(lsp-previous-diagnostic)
							nmap <buffer> me <plug>(lsp-next-diagnostic)
							nmap <buffer> K <plug>(lsp-hover)


							let g:lsp_format_sync_timeout = 1000
							autocmd! BufWritePre *.rs,*.go,*.lua call execute('LspDocumentFormatSync')

							" refer to doc to add more commands
					endfunction

					nmap <leader>xx :LspDocumentDiagnostics<cr>
					nmap <leader>ca :LspCodeAction<cr>

					augroup lsp_install
							au!
							" call s:on_lsp_buffer_enabled only for languages that has the server registered.
							autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
					augroup END

        Plug 'prabirshrestha/asyncomplete.vim'
        Plug 'prabirshrestha/asyncomplete-lsp.vim'

        Plug 'easymotion/vim-easymotion'
        nmap <leader>j <Plug>(easymotion-s2)
      endif
  " }}}"
	" dracula {{{
        Plug 'dracula/vim', { 'as': 'dracula' }

        "Include bold attributes in highlighting >
        let g:dracula_bold = 1

        " Include italic attributes in highlighting >
        let g:dracula_italic = 1

        " Include underline attributes in highlighting >
        let g:dracula_underline = 1

        " Include undercurl attributes in highlighting (only if underline enabled) >
        let g:dracula_undercurl = 1

        " Include inverse attributes in highlighting >
        let g:dracula_inverse = 1

        " Include background fill colors >
        let g:dracula_colorterm = 1

        augroup dracula_customization
            autocmd!
            autocmd ColorScheme * highlight CursorLine guibg=#2E303C
            autocmd ColorScheme * highlight Folded guibg=NONE
        augroup end

        let g:NERDTreeIndicatorMapCustom = {
          \ "Modified"  : "✹ ",
          \ "Staged"    : "✚ ",
          \ "Untracked" : "✭ ",
          \ "Renamed"   : "➜ ",
          \ "Unmerged"  : "═ ",
          \ "Deleted"   : "✖ ",
          \ "Dirty"     : "✗ ",
          \ "Clean"     : "✔︎ ",
          \ 'Ignored'   : '☒ ',
          \ "Unknown"   : "? "
        \ }



  " }}}"

  " tokyo-night {{{
        Plug 'ghifarit53/tokyonight-vim'

        let g:tokyonight_style = 'night' " available: night, storm
        let g:tokyonight_enable_italic = 0
        " colorscheme tokyonight
  " }}}"

	" airline {{{
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " }}}"

    let g:airline_powerline_fonts = 1
    let g:airline_skip_empty_sections = 1

    let g:airline_left_sep = ''
    let g:airline_right_sep = ''

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = ' '
    let g:airline#extensions#tabline#formatter = 'jsformatter'

	Plug 'morhetz/gruvbox'
	Plug 'tpope/vim-fugitive'
	Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
    if !has('ide')
      map <C-G> :NERDTreeToggle<CR>
      map <leader>e :NERDTreeToggle<CR>
      map gf :NERDTreeFind<CR>
      " let NERDTreeShowHidden=1
      let g:NERDTreeChDirMode=2
      let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
      let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
      let g:NERDTreeShowBookmarks=1
      let g:nerdtree_tabs_focus_on_files=1
      let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
      let g:NERDTreeWinSize = 50
      let NERDTreeShowHidden=1
    endif

	Plug 'vim-syntastic/syntastic'
	Plug 'ycm-core/YouCompleteMe'

	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-repeat'
	Plug 'machakann/vim-highlightedyank'

	Plug 'svermeulen/vim-yoink'

	Plug 'altercation/vim-colors-solarized'

    " vim-visual-star-search - Start a * or # search from a visual block {{{
        Plug 'nelstrom/vim-visual-star-search'
    " }}}
    "
    " IndexedSearch - shows 'Nth match out of M' at every search {{{
        Plug 'vim-scripts/IndexedSearch'
    " }}}
    "
    " LargeFile - Edit large files quickly {{{
    if !has('ide')
        let g:LargeFile = 1
        Plug 'vim-scripts/LargeFile'
    endif
    " }}}
    if !has('ide')
      " vim-tmux-navigator - Seamless navigation between tmux panes and vim splits {{{
        Plug 'christoomey/vim-tmux-navigator'

        " seemless moving around between tmux panes and vim splits
        nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
        nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
        nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
        nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

      " }}}
    endif

        Plug 'prettier/vim-prettier'

    " indentLine - A vim plugin to display the indention levels with thin vertical lines {{{
        Plug 'Yggdroot/indentLine'

        " let g:indentLine_enabled = 0
        " " let g:indentline_faster = 1
        let g:indentline_char = '┊'
        let g:indentline_first_char = '┊'
        " let g:indentLine_char = '│'
        " let g:indentLine_first_char = '│'
        let g:indentLine_color_term = 237
        let g:indentLine_color_gui = '#333540'
        let g:indentLine_showfirstindentlevel = 1
    " }}}
    "
    " vim-smoothscroll {{{
        Plug 'terryma/vim-smooth-scroll'

        noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 4)<CR>
        noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 4)<CR>
        noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 8)<CR>
        noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 8)<CR>
    " }}}

    " vim-hardtime - Plugin to help you stop repeating the basic movement key {{{
        Plug 'takac/vim-hardtime'

        let g:hardtime_default_on = 0
        let g:hardtime_showmsg = 1
        let g:hardtime_allow_different_key = 1
        let g:hardtime_maxcount = 10

        map <F5> :HardTimeToggle<CR>
    " }}}
    "
    " quick-scope {{{
        Plug 'unblevable/quick-scope'
        " Trigger a highlight in the appropriate direction when pressing these keys:
        let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
        let g:qs_max_chars=150
    " }}}
    " quick-scope {{{
        Plug 'quixotique/vim-delta'
    " }}}
    "
    " icons for nerdtree {{{
        Plug 'ryanoasis/vim-devicons'
    " }}}
    " git status flag for nerdtree {{{
        Plug 'Xuyuanp/nerdtree-git-plugin'
    " }}}
    " state restoring for nerdtree {{{
        Plug 'scrooloose/nerdtree-project-plugin'
    " }}}
    " state restoring for nerdtree {{{
        Plug 'PhilRunninger/nerdtree-buffer-ops'
    " }}}
    " state restoring for nerdtree {{{
        Plug 'PhilRunninger/nerdtree-visual-selection'
    " }}}
    "
    " syntax-highlight for nerdtree {{{
        Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
          let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
          let w:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1

          let g:NERDTreeDisableFileExtensionHighlight = 1
          let g:NERDTreeDisableExactMatchHighlight = 1
          let g:NERDTreeDisablePatternMatchHighlight = 1

          let g:NERDTreeFileExtensionHighlightFullName = 1
          let g:NERDTreeExactMatchHighlightFullName = 1
          let g:NERDTreePatternMatchHighlightFullName = 1

          let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
          let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

          " you can add these colors to your .vimrc to help customizing
          let s:brown = "905532"
          let s:aqua =  "3AFFDB"
          let s:blue = "689FB6"
          let s:darkBlue = "44788E"
          let s:purple = "834F79"
          let s:lightPurple = "834F79"
          let s:red = "AE403F"
          let s:beige = "F5C06F"
          let s:yellow = "F09F17"
          let s:orange = "D4843E"
          let s:darkOrange = "F16529"
          let s:pink = "CB6F6F"
          let s:salmon = "EE6E73"
          let s:green = "8FAA54"
          let s:lightGreen = "31B53E"
          let s:white = "FFFFFF"
          let s:rspec_red = 'FE405F'
          let s:git_orange = 'F54D27'

          let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
          let g:NERDTreeExtensionHighlightColor['css'] = s:blue " sets the color of css files to blue

          let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
          let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files

          let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
          let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb

          let g:WebDevIconsDefaultFolderSymbolColor = s:beige " sets the color for folders that did not match any rule
          let g:WebDevIconsDefaultFileSymbolColor = s:blue " sets the color for files that did not match any rule

    " }}}
    " react snippets {{{
        Plug 'SirVer/ultisnips'
        Plug 'mlaursen/vim-react-snippets'
    " }}}
    " fzf {{{
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
          let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.9, 'height': 0.9, 'yoffset':0.5, 'xoffset': 0.5 } }
          let g:fzf_preview_window = 'right:50%'

          let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
          " let $FZF_DEFAULT_COMMAND="rg --files --hidden"

          " Customise the Files command to use rg for ignoring .gitignore files
          command! -bang -nargs=? -complete=dir Files
              \ call fzf#run(fzf#wrap('files', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden' }), <bang>0))

          " Add an AllFiles variation that ignores .gitignore files
          command! -bang -nargs=? -complete=dir AllFiles
              \ call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }), <bang>0))
          "" Search file in project
          set wildmode=list:longest,list:full
          set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
          let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path '**/node_modules/**' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

          " nmap <leader>f :GFiles --cached --others --exclude-standard<CR>
          nmap <leader>ff :Files<CR>
          nmap <leader>fF :AllFiles<CR>
          nmap <leader>fb :Buffers<CR>
          nmap <leader>, :Buffers<CR>
          nmap mr :Buffers<CR>
          " nmap <leader>fh :History<CR>
          " nmap <leader>t :BTags<CR>
          nmap <leader>fl :BLines<CR>
          nmap <leader>fL :Lines<CR>
          nmap <leader>f' :Marks<CR>
          nmap <leader>fa :AgRaw<space>
          nmap <leader>fr :Rg<space>
          nmap gh :Rg<space>
          nmap <leader>fH :Helptags!<CR>
          nmap <leader>fc :Commands<CR>
          nmap <leader>f: :History:<CR>
          nmap <leader>f/ :History/<CR>
          nmap <leader>fM :Maps<CR>
          nmap <leader>fs :Filetypes<CR>
          " command! -bang -nargs=* -complete=file Rg call fzf#vim#grep("rg --files --hidden --follow --smart-case --glob \"!.git/*\" --glob \"!node_modules/*\"" . <q-args>, 1, fzf#vim#with_preview(), <bang>0)
          command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
            \   fzf#vim#with_preview(), <bang>0)
          "
          " }}}
          function! s:getVisualSelection()
              let [line_start, column_start] = getpos("'<")[1:2]
              let [line_end, column_end] = getpos("'>")[1:2]
              let lines = getline(line_start, line_end)

              if len(lines) == 0
                  return ""
              endif

              let lines[-1] = lines[-1][:column_end - (&selection == "inclusive" ? 1 : 2)]
              let lines[0] = lines[0][column_start - 1:]

              return join(lines, "\n")
          endfunction
          vnoremap <leader>fr y:Rg <C-r>=escape(@+, '/\')<CR>
          vnoremap gh y:Rg <C-r>=escape(@+, '/\')<CR>
    " }}}

call plug#end()
set noshowmode

"" Searching {{{
" ==============================================================================

    " Highlight search matches
    " set hlsearch

    " Start searching while typing
    set incsearch

    " Show what substitutions will look like real-time
    " set inccommand=nosplit

    " Enable regex for searches
    set magic

    " Case insensitive searches...
    set ignorecase

    " ...unless specifically searching for something with uppercase characters
    set smartcase

" }}}


" set incsearch
" set ignorecase
" set smartcase

"" More for yank
" set highlight yanked text duration to infinite value
let g:highlightedyank_highlight_duration = 1000

" copy yanked text from unnamed register to clipboard
set clipboard^=unnamed,unnamedplus

" toggle highlight for searched text
nnoremap <F6> :set hls!<CR>


"" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
  " autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
  "     \ let buf=bufnr() | buffer# | execute "normal! \<leader>cw" | execute 'buffer'.buf | endif

  if !has('ide')
  " Maintain the cursor position when yanking a visual selection
    " http://ddrscott.github.io/blog/2016/yank-without-jank/
    vnoremap y myy`y
    vnoremap Y myY`y

    " Reselect visual selection after indenting
    vnoremap < <gv

    " Reselect visual selection after de-indenting
    vnoremap > >gv

    " inoremap <S-Tab> <C-d>

  endif

noremap <Leader>vsp :w<CR>:source ~/.vimrc<CR>:PlugInstall<CR>
noremap <Leader>vso :w<CR>:source ~/.vimrc<CR>
noremap <Leader>ss :w<CR>
cmap w!! %!sudo tee > /dev/null %
noremap <leader>df :w !git diff % - <CR>
noremap <Leader>rep :%s/\(<C-r>"\)/\1/gc
noremap <Leader>/ /\V<C-r>=escape(@+, '/\')<cr>:set hls<cr>N
vnoremap <Leader>/ y/\V<C-r>=escape(@+, '/\')<CR><CR>N:set hls<cr>

" Paste replace visual selection without copying it
vnoremap <leader>p "_dP

" Make Y behave like the other capitals
nnoremap Y y$
if !has('ide')
  " A simple remap of the * key in normal and visual modes.

  " Differences:

  " Does not jump to the next found instance
  " In normal mode, pressing * will search for the word the cursor is resting on, separated by word boundaries. (Meaning, if you hit * while resting on bar, it will not match with bartender.)
  " In visual mode, pressing * will search for the exact text that is selected (including special characters like spaces.)
  " To install:

  " Using vim-plug: Plug 'yogeshdhamija/better-asterisk-remap.vim'

  nnoremap * :let old=@"<CR>yiw:let @/="\\V\\C\\<".escape(@", '/\')."\\>"<CR>:set hlsearch<CR>:let @"=old<CR>:redraw!<CR>:echo "/".@/<CR>

  " <C-U> is used to clear the command line, for example, in following case, is:
  " :'<,'>
  vnoremap * :<C-U>let old=@"<CR>gvy:let @/="\\V\\C".escape(@", '/\')<CR>:set hlsearch<CR>:let @"=old<CR>:redraw!<CR>:echo "/".@/<CR>
endif

" Quicky escape to normal mode
imap jj <esc>

" Easy insertion of a trailing ; or , from insert mode
" nmap <leader>; A;<Esc>
" nmap <leader>, A,<Esc>

map mb <c-o>
map mf <c-i>
map mmd <c-d>
map md 4j
map mmu <c-u>
map mu 4k

nnoremap <leader>bd :bd<CR>
" Swap Files {{{
" ==============================================================================

    if !isdirectory($HOME . '/.vim/swaps')
        call mkdir($HOME . '/.vim/swaps', 'p')
    endif

    set directory=~/.vim/swaps

" }}}
" Swap Files {{{
    if has("persistent_undo")
       let target_path = expand('~/.undodir')

        " create the directory and any parent directories
        " if the location does not exist.
        if !isdirectory(target_path)
            call mkdir(target_path, "p", 0700)
        endif

        let &undodir=target_path
        set undofile
    endif
" }}}

" Splits {{{
" ==============================================================================

    " Open new split below rather than above
    set splitbelow

    " Open new vertical split to the right, rather than left
    set splitright

" }}}



" Buffers {{{
" ==============================================================================
    nnoremap L :bnext<CR>
    nnoremap H :bprevious<CR>
    nnoremap <leader>bb :b#<CR>

    nmap <leader>xa :xa<cr>
    nmap <leader>wa :wa<cr>
    nmap <leader>qq :qa<cr>
    nmap <leader>wd :q<cr>
    nnoremap <leader>ww <c-w>p

    " Allow unwritten buffers in the background
    set hidden
    " Move between buffers like tabs
    if !has('ide')
      nmap <c-n> <plug>(YoinkPostPasteSwapBack)
      nmap <c-p> <plug>(YoinkPostPasteSwapForward)

      nmap p <plug>(YoinkPaste_p)
      nmap P <plug>(YoinkPaste_P)

      " Also replace the default gp with yoink paste so we can toggle paste in this case too
      nmap gp <plug>(YoinkPaste_gp)
      nmap gP <plug>(YoinkPaste_gP)

    endif


    " nmap <C-n> :bnext<CR>
    " nmap <C-p> :bprev<CR>

" }}}


" Colors {{{
" ==============================================================================

    syntax on
    augroup ColorSchemeOverrides
        autocmd!
        autocmd ColorScheme * highlight SpellBad gui=undercurl
        autocmd ColorScheme * highlight SpellCap gui=undercurl
    augroup end

    augroup HighlightWhitespace
        autocmd!
        autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
        autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
        autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    augroup end

    " colorscheme dracula
    colorscheme tokyonight

    if &diff
        colorscheme dracula
    endif

" }}}
"
" custom functions
" function! Smart_dot() abort
"   if getcmdtype() =~# '[:]'
"     let l:cmd=getcmdline()
"     if match(l:cmd, '\.\.$') !=-1
"       return '/..'
"     else
"       return "."
"     endif
"   else
"     return getcmdline()
"   endif
" endfunction
" cnoremap . <c-r>=<sid>Smart_dot()<CR>
"
" %s/\(.\)noremap/vim.keymap.set("\1",/gc
