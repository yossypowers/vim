"----------------------------------------------------------------------
"
" 編集したら source $VIM/
"----------------------------------------------------------------------
" Toodledo Todo メールから締め切り一覧を抽出する
"   					2010/12/29 Y.Honda
"
" ex) 
"
" ITEM A
"       Low Priority
"       Due: 2010-12-31
"
" ITEM B
"       Low Priority
"       Due: 2010-12-31
" ->
"
" ○ ITEM A 	2010-12-31
" ○ ITEM B 	2010-12-31
"
" Change History --------------------------------------------------
" 2010/12/28	--
" 2011/02/15 Past Due対応
" 2012/02/01 ■変更
" 2012/03/23 19:57:36　format change

:function! Todo()

	" 検索キーワードを設定 
	":let key = "Due:"	" 締め切り検索キーワード
	:let key = "Due"	" 締め切り検索キーワード(Past Due対応）
	:let key_past = "Past Due!"	" 締め切り検索キーワード(Past Due対応）
	:let key_today = "Today"	" 締め切り検索キーワード(Past Due対応）
	:let key_tommorow = "Tomorrow"	" 締め切り検索キーワード(Past Due対応）
	:let due_offset = 5 	"Due: 行の日付までのオフセット
	:let date_size	= 10	"日付の文字数 

	"行数を抽出
	:let endline =  line("$")

	" Headerを追加
	" 本日の日付
	:let today = strftime("%Y/%m/%d")." ".strftime("%A")
	":call append(line("$"), strftime("%Y/%m/%d").strftime("%A")
	:call append(line("$"), printf("%s------------------------------------------------------",today))
	:call append(line("$"),"■TODO 今日実施するものには T でマークし　TTでソート実行")
	":call append(line("$"),"■TODO　★：期限切れ：○(maru)：未実施、☆(star):実施予定 ●(DONE)：実施済")
	:call append(line("$"), " <Due Date>\t<Item>")

	:let i = 0
	:while i < endline
		: let i= i + 1
		" Due　があれば TODO と締切日を1行にマージ
		" Due: の位置を抽出（なければ -1)	
		: let due_pos = match(getline(i), key) 
		: if due_pos != -1 	" Due行を見つけた
			" 締切日とITEM(２行前）を抽出
			: let due_date = strpart(getline(i), due_pos + due_offset, date_size)
			: let todo_item = getline(i-2)
			
			" Past Due!の場合は特別処理
			: let past_pos = match(getline(i), key_past) 
			: if past_pos != -1 	" Due行を見つけた
				" 締め切りすぎた
				" 2行のTODO ITEM と締切日を結合し最終行に追加
				": echo getline(i-2).due_date "これでも連結可能
				": echo printf("  %s\t%s",due_date, getline(i-2))
				": call append(line("$"),printf("○ PAST DUE ! \t\t\t\t\t%s", todo_item))
				": call append(line("$"),printf("○ PAST DUE ! \t\t\t\t\t%s", todo_item))
				" 2012/6/4 変更
				: call append(line("$"),printf("★%s　\t\t\t\t\t\tPAST DUE!!", todo_item))

			: else
				" 2行のTODO ITEM と締切日を結合し最終行に追加
				": echo getline(i-2).due_date "これでも連結可能
				": echo printf("  %s\t%s",due_date, getline(i-2))
				": call append(line("$"),printf("○ %s\t%s",due_date, todo_item))
				" 2012/6/4 変更
				: call append(line("$"),printf("○%s\t\t\t\t\t\t%s", todo_item,due_date))

			: endif
		: endif

	:endwhile
	" Footer
	:call append(line("$"),"")
"	:call append(line("$"),"■会議予定")
"	:call append(line("$"),"")
"	:call append(line("$"),"■作業ログ")
:endfunction



"-------------------------------------------
" ☆の項目のソート
" 入力：
"○ PAST DUE ! 	不具合：FrameGap問題
"☆ 2012-04-20	HDCOM 大連引継ぎ計画見直し
"○ 2012-04-20	HDCOM　AVQoS引継ぎ計画
"☆ 2012-04-20	ｴｺｷｬﾝHCM:外部仕様RV日程調整 4/23
"○ 2012-04-20	UIの変革
"○ 2012-04-20	日程調整：AVIO外部仕様RV
"○ 2012-04-20	システム設計書：遅延時間ユースケース毎
"
"出力：
"☆ 2012-04-20	HDCOM 大連引継ぎ計画見直し
"☆ 2012-04-20	ｴｺｷｬﾝHCM:外部仕様RV日程調整 4/23
"

:function! SortStar()

	" Headerを追加
	" 本日の日付

	"1.☆をソートして出力
	"検索キーワードを設定 
	:let key = "☆"	" 締め切り検索キーワード(Past Due対応）

	"行数を抽出
	:let endline =  line("$")

	:let today = strftime("%Y/%m/%d")." ".strftime("%A")
	:call append(line("$"), printf("■%s------------------------------------------------------",today))

	:call append(line("$"), printf("■%s -----------------------------------------------------{{{",today))
	" Header
	:call append(line("$"),"■--本日の作業計画>>　☆(T):実施予定 ●(bl)：実施済 サマリのみ--------------")
	:call append(line("$"),"☆ 9:00-10:30")
	:call append(line("$"),"☆10:30-12:00")
	:call append(line("$"),"☆13:00-15:00")
	:call append(line("$"),"☆15:00-17:45")
	:call append(line("$"),"")
	:call append(line("$"),"■-作業メモ>>　詳細メモ ----------------------------------------------------")
	:call append(line("$"),"■-----------------------------------------------------------------------}}}")

	:let i = 0
	:while i < endline
		: let i= i + 1
		" Due　があれば TODO と締切日を1行にマージ
		" Due: の位置を抽出（なければ -1)	
		: let star_pos = match(getline(i), key) 
		: if star_pos != -1 	" KEYを見つけた pos: 位置
				" 最終行に現在の行を追加
				": echo printf("  %s\t%s",due_date, getline(i-2))
				": echo printf("%s",getline(i))
				: call append(line("$"),printf("%s",getline(i)))

		: endif

	:endwhile

	"2.次に○をソートして出力
	" 検索キーワードを設定 
	:let key = "○"	" 締め切り検索キーワード(Past Due対応）

	:let i = 0
	:while i < endline
		: let i= i + 1
		" Due　があれば TODO と締切日を1行にマージ
		" Due: の位置を抽出（なければ -1)	
		: let star_pos = match(getline(i), key) 
		: if star_pos != -1 	" KEYを見つけた pos: 位置
				" 最終行に現在の行を追加
				": echo printf("  %s\t%s",due_date, getline(i-2))
				": echo printf("%s",getline(i))
				: call append(line("$"),printf("%s",getline(i)))

		: endif

	:endwhile


:endfunction

:function! WriteSchedule()

	" Headerを追加
	" 本日の日付

	:let today = strftime("%Y/%m/%d")." ".strftime("%A")
	:call append(line("$"), printf("■%s -----------------------------------------------------{{{",today))
	" Header
	:call append(line("$"),"■--本日の作業計画>>　☆(T):実施予定 ●(bl)：実施済 サマリのみ--------------")
	:call append(line("$"),"☆ 9:00-10:30")
	:call append(line("$"),"☆10:30-12:00")
	:call append(line("$"),"☆13:00-15:00")
	:call append(line("$"),"☆15:00-17:45")
	:call append(line("$"),"")
	:call append(line("$"),"■-作業メモ>>　詳細メモ ----------------------------------------------------")
	:call append(line("$"),"■-----------------------------------------------------------------------}}}")
:endfunction
"
"---------------------------------------------------------------------------------
" 日付入力系
"
"---------------------------------------------------------------------------------

" 日付と曜日を現在位置に挿入する
:function! Today()
	" 日付と曜日
	:let input = strftime(" %Y/%m/%d")." ".strftime("%A")
	:let pos = getpos(".")	" 現在の場所
	:execute ":normal a" . input
	:call setpos('.', pos)	" 現在の場所に戻す
:endfunction

" 日付と時刻を現在位置に挿入する
:function! Now()
	" 日付と時刻
	:let input = strftime(" %Y/%m/%d %H:%M:%S")
	:let pos = getpos(".")	" 現在の場所
	:execute ":normal a" . input
	:call setpos('.', pos)	" 現在の場所に戻す
:endfunction

" 日付と時刻を現在位置に挿入する

" 白星に変更する
:function! WhiteStar()
	" 日付と時刻
	:let input = strftime("☆")
	:let pos = getpos(".")	" 現在の場所
	:execute ":normal 1s" . input
	:call setpos('.', pos)	" 現在の場所に戻す
:endfunction

" 白星に変更する
:function! BlackStar()
	" 日付と時刻
	:let input = strftime("★")
	:let pos = getpos(".")	" 現在の場所
	:execute ":normal 1s" . input
	:call setpos('.', pos)	" 現在の場所に戻す
:endfunction

" 白○に変更する
:function! WhiteCircle()
	" 日付と時刻
	:let input = strftime("○")
	:let pos = getpos(".")	" 現在の場所
	:execute ":normal 1s" . input
	:call setpos('.', pos)	" 現在の場所に戻す
:endfunction
"
" ●に変更する
:function! BlackCircle()
	" 日付と時刻
	:let input = strftime("●")
	:let pos = getpos(".")	" 現在の場所
	:execute ":normal 1s" . input
	:call setpos('.', pos)	" 現在の場所に戻す
:endfunction

"  tabを半角スペースに変換
"  :set expandtab
"  :%retab  "%は全行の意味
:function! ChangeTabToSpace()
	:execute ":set expandtab" 
	:execute ":%retab"
:endfunction

"----------------------------------------------------------------------------
" key mapping
"
" today
" now
" todo
"----------------------------------------------------------------------------

nmap todo	:call Todo()<CR>
nmap today	:call Today()<CR>
nmap time	:call Now()<CR>

nmap T :call WhiteStar()<CR>
nmap AI		:call BlackStar()<CR>
nmap maru	:call WhiteCircle()<CR>
nmap bl :call BlackCircle()<CR>
nmap cgtab	:call ChangeTabToSpace()<CR>
nmap TT	: call SortStar()<CR>
nnoremap table :call WriteSchedule()<CR>
