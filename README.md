# DeepL.vim

Provides functions to wrap the [DeepL API](https://www.deepl.com/en/docs-api/).

This plugin provides only simple functions. If you need commands, see
[gw31415/deepl-commands.nvim](https://github.com/gw31415/deepl-commands.nvim).

## Installation

### 1. Installation of this plugin

[Plug.vim](https://github.com/junegunn/vim-plug)
```vim
Plug 'gw31415/deepl.vim'
```

[dein.vim](https://github.com/Shougo/dein.vim)
```vim
call dein#add('gw31415/deepl.vim')
```

[packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use 'gw31415/deepl.vim'
```

### 2. Configuration of Auth Key

```vim
let g:deepl_auth_key = '{Your auth key of DeepL API}'
```

## Example
In the example below, the command `:{range}DeepL` is created that translates
the selected lines and adds the translation just below the selection. If the
command called with a exclamation mark ( `:{range}DeepL!` ), the lines will be
replaced with the translation.

```vim
fu! s:deepl(l1, l2, bang) abort
	let in = join(getline(a:l1, a:l2), "\n")
	try
		let out = split(deepl#translate(in, 'EN'), "\n")
	catch
		echoh ErrorMsg | ec v:exception | echoh None
		retu
	endt
	if a:bang == ''
		cal append(a:l2, out)
	el
		cal setline(a:l1, out)
	en
endfu
com! -range -bang DeepL cal s:deepl(<line1>, <line2>, '<bang>')
```

## Related Projects
- [deepl-commands.nvim](https://github.com/gw31415/deepl-commands.nvim): Provides the DeepL command using this deepl.vim plugin.
