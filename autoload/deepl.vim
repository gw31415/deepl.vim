fu! deepl#translate(text, target_lang) abort
	if g:deepl_authkey == ''
		th 'You should set your `g:deepl_authkey` first.'
	en
	let text = system(['curl', '-X', 'POST', g:deepl_endpoint, '-s',
				\ '-H', 'Authorization: DeepL-Auth-Key ' .. g:deepl_authkey,
				\ '--data-urlencode', 'text=' .. a:text, '-d', 'target_lang=' .. a:target_lang])
	if text == ''
		th 'Your `g:deepl_authkey` is incorrect.'
	en
	try
		return json_decode(text)['translations'][0]['text']
	fina
		th get(json_decode(text), 'message', text)
	endt
endfu