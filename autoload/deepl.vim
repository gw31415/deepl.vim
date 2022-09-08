fu! deepl#translate(text, target_lang) abort
	if !exists('g:deepl_authkey')
		th 'You should set your `g:deepl_authkey` first.'
	en
	let text = system(['curl', '-X', 'POST', g:deepl_endpoint, '-s', '--max-time', g:deepl_timeout,
				\ '-H', 'Authorization: DeepL-Auth-Key ' .. g:deepl_authkey,
				\ '--data-urlencode', 'text=' .. a:text, '-d', 'target_lang=' .. a:target_lang,
				\ '-w', '\n%{http_code}'])
	if v:shell_error == 0
		let tmp = matchstr(text, '\v\n\d+$')
		let [text, http_code] = [ text[:-(len(tmp) + 1)], str2nr(tmp[1:])]
		if http_code == 200
			try
				return json_decode(text)['translations'][0]['text']
			catch
				th 'Parse error. Please contact the developer.'
			endt
		elsei http_code == 403
			th 'Authentication error. Check `g:deepl_authkey`.'
		el
			th get(json_decode(text), 'message', printf('Unknown error. HTTP Code: %d; %s', http_code, text))
		en
	elsei v:shell_error == 28
		th 'Operation timed out.'
	elsei v:shell_error == 6
		th 'Could not access the endpoint. Please check `g:deepl_endpoint` or Internet connection.'
	el
		th printf('cURL error: %d. Please see https://curl.se/libcurl/c/libcurl-errors.html', v:shell_error)
	en
endfu
