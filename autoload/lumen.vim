func lumen#init()
	let s:is_nvim = has('nvim')

	augroup lumeni
		if v:vim_did_enter
			call lumen#fork_job()
		else
			au VimEnter * call lumen#fork_job()
		endif
	augroup END
endfunc

func lumen#parse_output(line)
	" we trust that vim's initial background detection is working correctly, thus we only have to listen to changes
	if match(a:line, "/org/freedesktop/portal/desktop: org.freedesktop.portal.Settings.SettingChanged ('org.freedesktop.appearance', 'color-scheme', <uint32 ") == 0
		" 0 is ASCII 48
		let val = strgetchar(a:line, strchars(a:line) - 3) - 48
		if val == 2
			set background=light
		elseif val == 1
			set background=dark
		endif
	endif
endfunc

func lumen#on_stdout(chan_id, data, name)
	let s:lines[-1] .= a:data[0]
	call extend(s:lines, a:data[1:])
	while len(s:lines) > 1
		let line = remove(s:lines, 0)
		call lumen#parse_output(line)
	endwhile
endfunc

func lumen#out_cb(channel, msg)
	call lumen#parse_output(a:msg)
endfunc

func lumen#fork_job()
	au! lumeni

	" TODO: Add qdbus fallback if gdbus is not installed
	let command = "gdbus monitor --session --dest org.freedesktop.portal.Desktop --object-path /org/freedesktop/portal/desktop"->split()
	if s:is_nvim
		let s:lines = ['']
		let options = {"on_stdout": function('lumen#on_stdout')}
		let s:job = jobstart(command, options)
	else
		let options = {"out_cb": function('lumen#out_cb')}
		let s:job = job_start(command, options)
	endif
endfunc
