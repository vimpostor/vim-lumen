let s:socket = "/tmp/socket"

func Test_loaded()
	call assert_equal(1, g:loaded_lumen)
endfunc

func Check_dark_mode_pref(value, bg)
	call writefile([a:value], s:socket)
	sleep 200m
	call assert_equal(a:bg, &background)
endfunc

func Test_changes()
	" light mode
	call Check_dark_mode_pref(2, "light")
	" dark mode
	call Check_dark_mode_pref(1, "dark")
endfunc
