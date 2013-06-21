"
" yossy_txt.vim
"
" 反映するには set filetype=txt_test
" vimrc にau BufRead,BufNewFile *.txt set syntax=yossy_txt

" | (進捗）を青色に
" ★(遅れ気味）を赤字に
" ☆（今日の予定）を青に
" ○(進行中）を緑に
" ●(終了）を灰色に
" 構文のマッチ　| 以降、行末までの範囲を指定
" 背景にも色つける
" カラーコード
"http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
"
syntax region weeklyUpdate start=+|+ end=+$+
syntax region BStar start=+★+ end=+$+
syntax region WStar start=+☆+ end=+$+
syntax region BCircle start=+●+ end=+$+
syntax region WCircle start=+○+ end=+$+
syntax region BRect start=+■+ end=+$+
syntax region Batsu start=+×+ end=+$+

" ハイライトの割当
"highlight     link weeklyUpdate Comment

" ハイライトの設定
highlight weeklyUpdate guifg=Blue
highlight BStar guifg=Red
highlight WStar guifg=Black
highlight BCircle guifg=Gray guibg=White
highlight WCircle guifg=DeepSkyBlue
"highlight WCircle guifg=SlateBlue
"highlight WCircle guifg=SpringGreen
highlight BRect guifg=White guibg=Gray
highlight Batsu guifg=Gray guibg = White

" ファイルタイプをtxt_test に
let b:current_syntax = "yossy_txt"
