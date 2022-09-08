fu! deepl#translate(text, target_lang) abort
	if g:deepl_authkey == ''
		th 'You should set your `g:deepl_authkey` first.'
	en
	let text = system(['curl', '-X', 'POST', g:deepl_endpoint, '-s',
				\ '-H', 'Authorization: DeepL-Auth-Key ' .. g:deepl_authkey,
				\ '--data-urlencode', 'text=' .. a:text, '-d', 'target_lang=' .. a:target_lang])
	if text == ''
		th 'Could not access the endpoint. Please check `g:deepl_authkey` or Internet connection.'
	en
	try
		return json_decode(text)['translations'][0]['text']
	catch
		th get(json_decode(text), 'message', text)
	endt
endfu
