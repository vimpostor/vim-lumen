let s:socket = "/tmp/socket"

func Test_loaded()
	call assert_equal(1, g:loaded_lumen)
endfunc

func Change_system_dark_mode(value)
	call writefile([a:value], s:socket)
	sleep 200m
endfunc

func Test_changes()
	" light mode
	call Change_system_dark_mode(2)
	call assert_equal("light", &background)

	" dark mode
	call Change_system_dark_mode(1)
	call assert_equal("dark", &background)
endfunc

func Test_autocmds()
	call Change_system_dark_mode(1)
	let g:test_var = 2
	let g:count = 0

	" Make sure that no duplicate autocommands are fired
	au User LumenLight let g:count += 1
	au User LumenDark let g:count += 1

	au User LumenLight let g:test_var = 2
	call Change_system_dark_mode(2)
	call assert_equal(2, g:test_var)
	call assert_equal(1, g:count)

	au User LumenDark let g:test_var = 1
	call Change_system_dark_mode(1)
	call assert_equal(1, g:test_var)
	call assert_equal(2, g:count)

	au! User LumenLight
	au! User LumenDark
endfunc
