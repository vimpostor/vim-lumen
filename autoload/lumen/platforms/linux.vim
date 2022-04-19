func lumen#platforms#linux#watch_cmd()
	" TODO: Implement our own dbus client to get rid of the gdbus dependency
	" dbus is just communicating with an Unix socket after all
	return "gdbus monitor --session --dest org.freedesktop.portal.Desktop --object-path /org/freedesktop/portal/desktop"->split()
endfunc

func lumen#platforms#linux#parse_line(line)
	if match(a:line, "/org/freedesktop/portal/desktop: org.freedesktop.portal.Settings.SettingChanged ('org.freedesktop.appearance', 'color-scheme', <uint32 ") == 0
		" 0 is ASCII 48
		let val = strgetchar(a:line, strchars(a:line) - 3) - 48
		" 0 = No preference
		" 1 = Prefer Dark
		" 2 = Prefer Light
		if val == 2
			call lumen#light_hook()
		elseif val == 1
			call lumen#dark_hook()
		endif
	endif
endfunc
