"-------------------------------------------------------------------------
"個人設定ファイル
"-------------------------------------------------------------------------
set number

" カッコの対応を一瞬取る
set showmatch

" Tabの移動をマッピング
"nnoremap <C-n> gt
"nnoremap <C-p> gT
" yankringに重複するためWindows標準に変更　→　Cnt-L/R
nnoremap <C-Left> gT
nnoremap <C-Right> gt

"------------------------------------------------------------------------
"バックアップファイル
"------------------------------------------------------------------------
"set backupdir=c:/tmp
"change 2010/12/28
set backupdir=c:/honda/tmp

"---------------------------------------------------------------------------
"タブの設定　2008/7/9
" タブ幅を2に変更 2012/04/05 13:55:14
"---------------------------------------------------------------------------
set sw=2
set ts=2

"---------------------------------------------------------------------------
"折り返し無し設定
"---------------------------------------------------------------------------
set nowrap

" ウインドウの幅
set columns=90

" ウインドウの高さ
set lines=100

"------------------------------------------------------------------------------
"改行文字とタブ文字を表示
"見にくいので削除 2013/04/03 16:44:38
"------------------------------------------------------------------------------
"set list
"set listchars=tab:>-,eol:<
"------------------------------------------------------------------------------
"改行文字とタブ文字の色設定（NonTextが改行、SpecialKeyがタブ）
"見にくいので削除 2013/04/03 16:44:38
"------------------------------------------------------------------------------
"hi NonText guibg=NONE guifg=lightgray
"hi SpecialKey guibg=NONE guifg=gray

"---------------------------------------------------------------------------
"clipboard
"---------------------------------------------------------------------------
set clipboard=unnamed

"---------------------------------------------------------------------------
" 色指定
"---------------------------------------------------------------------------
colorscheme delek

"目が疲れないが気分が沈むため止める
"colorscheme pyte 

"---------------------------------------------------------------------------
"環境変数
"---------------------------------------------------------------------------
let $MEMO="c:/honda/MyDocument/Memo"
let $WORK="c:/honda/MyDocument/FY2012"
let $VIM_DIR="c:/honda/Program/vim73-kaoriya-win32"
":let $VIMRC=${VIM_DIR}/_vimrc
let $MYVIMRC="c:/honda/Program/vim73-kaoriya-win32/_vimrc"
let $HOME="c:/honda/.vim/"

":echo $WORK_DIR 確認
"
"---------------------------------------------------------------------------
"ファイルを開いたディレクトリに移動する
"---------------------------------------------------------------------------
:au BufEnter * execute ":lcd " . expand("%:p:h")

"--------------------------------------------------------------------------
"ファイルを開く時にファイル名の補完をする
"--------------------------------------------------------------------------
:set wildmode=list:longest

"--------------------------------------------------------------------------
"ファイルを開く時にtabで開く
"　複数ファイルではＮＧ
"--------------------------------------------------------------------------

"autocmd VimEnter * tab all
"autocmd BufAdd * exe 'tablast | tabe "' . expand( "<afile") .'"'
"

" バッファを使わない bwでバッファを閉じないと駄目
"autocmd BufReadPost * tab ball
"

" タブを開く/閉じる
"nnoremap <C-T> :tabnew <CR>
nnoremap Alt-F4 :q <CR>

" 現在の場所でgrep
" <cword> 現在の単語をあらわす
" vimgrep 結果の移動 F3で次へ F2で前へ
nnoremap <F2> :cp<CR>
nnoremap <F3> :cn<CR>
nnoremap <F7> :cp<CR>
nnoremap <F8> :cn<CR>
nnoremap <F4> :vimgrep <cword> **/*.c **/*.h \| cw 
nnoremap <F5> :vimgrep <cword> **/* \| cw 
" 裏バッファ
nnoremap <F6> :vimgrep /xxx/j # | cwin 
nnoremap <F9> :NERDTree <cr>


"リターンでファイルを開く　誤って開くことが多いのでコメントアウト
"nnoremap <silent> <cr> :silent exe 'Utl'<cr><cr>

"CapsをCntに変更に伴いCnt-jをESCに変更　2013/02/20 08:52:28
inoremap <C-j> <ESC>
inoremap <C-k> <ESC>

nnoremap <C-j> <ESC>

"打ち間違いが多いので変更
"Cnt-G -> shift->G
nnoremap <C-g> <S-g>

" 全部を選択
nnoremap <C-a> gg<S-v><S-g>

" 2012/10/09 14:24:05
" jj を<ESC>
"
imap jj <ESC>

"\{, \(で括弧を入力して編集モードに変更 2013/02/21 18:27:27
noremap <Leader>{ i{}<ESC>i
noremap <Leader>( i()<ESC>i

"文字コード、改行コード
"todo マクロの改行コードが不正となってしまう
"ファイル名も化ける・・・
":set encoding=utf-8
":set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
":set fileformats=unix,dos,mac

"--------------------------------------------------
"外部grep
"https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-grep#TOC-Windows-grep-
"

set grepprg=c:/honda/program/cygwingrep/bin/grep\ -nH

"grep-----------------------------------------------
"毎回「| cw」を付けるのが面倒な場合は、以下のautocmd設定で自動化することも可能。
au QuickfixCmdPost vimgrep cw

" CTRL-hjklでウィンドウ移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" space でページ移動
nnoremap <Space> <C-f>
nnoremap <S-Space> <C-b>

" 挿入モードでCtrl+kを押すとクリップボードの内容を貼り付けられるようにする "
"imap <C-K> <ESC>"*pa

" インサートモードでもhjklで移動（Ctrl押すけどね）
"imap <C-j> <Down>
"imap <C-k> <Up>
""imap <C-h> <Left>
"imap <C-l> <Right>

"insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
"set vb t_vb= " ビープをならさない

"pathogen の有効化

execute pathogen#infect()
" pathogen.vim のために一時的にOFFにする
filetype off
" pathogen.vim を有効にする
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" helpfileの設定
set helpfile=$VIMRUNTIME/doc/help.txt
" filetypeの有効化 
filetype on

noremap ctag :! ctags -R <CR>

"タグ戻る
nnoremap <C-]> :pop

"---------------------------------------------------------------------------------
"unite  
"---------------------------------------------------------------------------------
"unite prefix key.
nnoremap [unite] <Nop>
nmap <Space>f [unite]
 
"unite general settings
"インサートモードで開始
let g:unite_enable_start_insert = 1
"最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 100

".uniteファイルの保存場所！ 重要!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
"これを設定しないと$HOME ー＞Zドライブなどになっており遅くなる原因！！！
let g:unite_data_directory='c:\honda\.vim\.unite'

"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''
 
"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
"レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
"ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"uniteを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  "ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
  "入力モードのときjjでノーマルモードに移動
  imap <buffer> jj <Plug>(unite_insert_leave)
  "入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  "ctrl+jで縦に分割して開く
  nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  "ctrl+jで横に分割して開く
  nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  "ctrl+oでその場所に開く
  nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
  inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
endfunction"}}}


"------------------------------------------------------------------------------------
"カレントディレクトリ移動
"<SP> CD
"------------------------------------------------------------------------------------
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>') 
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>

"------------------------------------------------------------------------------------
" neocomplcache 補完機能
"------------------------------------------------------------------------------------
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化


"------------------------------------------------------------------------------------
"カーソルカスタマイズ 2013/04/05 18:12:23
"どうもブルーにならないので没
"------------------------------------------------------------------------------------
"set cursorline  "カーソル行をライン          
"highlight CursorLine ctermfg=Blue
"
"インサートモードに入った時にカーソル行の色を変更する
"augroup vimrc_change_cursorline_color
"  autocmd!
"  " インサートモードに入った時にカーソル行の色をブルーグリーンにする
"  autocmd InsertEnter * highlight CursorLine ctermbg=24 guibg=#005f87 | highlight CursorColumn ctermbg=24 guibg=#005f87
"  " インサートモードを抜けた時にカーソル行の色を黒に近いダークグレーにする
"  autocmd InsertLeave * highlight CursorLine ctermbg=236 guibg=#303030 | highlight CursorColumn ctermbg=236 guibg=#303030
"augroup END
"
"
"------------------------------------------------------------------------------------
" vimrc に 設定できないのは以下に設定されているから？
"C:\honda\Program\vim73-kaoriya-win32\vim73\filetype.vim
au BufNewFile,BufRead *.txt,*.text setf yossy_txt
"------------------------------------------------------------------------------------
"
"
"yankring.vim
"
let g:yankring_history_dir = expand('$HOME')
let g:yanking_hitory_file = '.yankring_history'
let g:yanking_max_history = 18
let g:yankring_enabled = 1

"畳み込みの有効化 {{{ hoge }}}
"za, zf, zm/zr
set foldmethod=marker 

"open-browzer
nmap gW <Plug>(openbrowser-open)

"-----------------------------------------------------------------------------------
"ファイルリネーム :e Rename newfilename 2013/06/21 11:46:50
"http://vim-users.jp/2009/05/hack17/
":file newfilename.txt // 編集中のバッファの保存先を変更 :w で保存
":call delete(expand('#')) //前の編集ファイルを削除
"-----------------------------------------------------------------------------------
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

