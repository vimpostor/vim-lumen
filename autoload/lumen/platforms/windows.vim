func lumen#platforms#windows#watch_cmd()
	return ["PowerShell", "-ExecutionPolicy", "Unrestricted", "-File", resolve(expand('<script>:p:h')) . '\windows\watcher.ps1']
endfunc

func lumen#platforms#windows#parse_line(line)
	let r = trim(a:line)
	if match(r, "AppsUseLightTheme") == 0
		let v = str2nr(r[-1:])
		if v == 1
			call lumen#light_hook()
		elseif v == 0
			call lumen#dark_hook()
		endif
	endif
endfunc

func lumen#platforms#windows#oneshot()
	let out = system('reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme')->split('\r\n')
	if len(out)
		call lumen#platforms#windows#parse_line(out[-1])
	endif
endfunc