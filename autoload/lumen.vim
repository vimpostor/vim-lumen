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

func lumen#parse_output(channel, msg)
	" we trust that vim's initial background detection is working correctly, thus we only have to listen to changes
	if match(a:msg, "/org/freedesktop/portal/desktop: org.freedesktop.portal.Settings.SettingChanged ('org.freedesktop.appearance', 'color-scheme', <uint32 ") == 0
		" 48 is ASCII 0
		let val = strgetchar(a:msg, strchars(a:msg) - 3) - 48
		if val == 2
			set background=light
		elseif val == 1
			set background=dark
		endif
	endif
endfunc

func lumen#job_exit(job, status)
	echom 'job exit' . a:status
endfunc

func lumen#fork_job()
	au! lumeni

	" TODO: Add qdbus fallback if gdbus is not installed
	let command = "gdbus monitor --session --dest org.freedesktop.portal.Desktop --object-path /org/freedesktop/portal/desktop"->split()
	if s:is_nvim
		let s:job = jobstart(command)
	else
		let options = {"out_cb": function('lumen#parse_output'), "exit_cb": function('lumen#job_exit')}
		let s:job = job_start(command, options)
	endif
endfunc
