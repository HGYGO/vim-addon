if exists('vim_tabs__loaded') | finish | endif | let vim_tabs__loaded = 1

set showtabline=2
set tabline=%!MyTabLine()

"function MyTabLine()
  "let line = ''

  "for i in range(tabpagenr('$'))
    "let line .= (i + 1 == tabpagenr()? '%#TabLineSel#': '%#TabLine#') .'%{MyTabLabel('. (i + 1) .')}'
  "endfor

  "return line .'%#TabLineFill#'
"endfunction

"function MyTabLabel(n)
  "let buflist = tabpagebuflist(a:n)
  "let index   = 0
  "let tabname = []

  "while index < len(buflist)
    "let bindx = buflist[index]
    "let index = index + 1
    "let bname = bufname(bindx)
    "let bname = (bname != '')? fnamemodify(bname, ':t'): 'new'
    "let bname = getbufvar(bindx, "&mod")? '+'. bname .'+': bname

    "if bname !~ '^__Tagbar__\.' && bname !~ '^NERD_tree_' && !count(tabname, bname) && getbufvar(bindx, "&ft") != 'qf'
      "let win = bufwinnr(bindx)

      "if win == -1 || !getwinvar(win, '&previewwindow')
        "call add(tabname, bname)
      "endif
    "endif
  "endwhile

  "if len(tabname) == 0
    "return ''
  "endif

  "return "[ ". join(tabname, ' | ') ." ]"
"endfunction


"  TabLineFill  tab pages line, where there are no labels
hi TabLineFill1 term=bold
hi TabLineFill1 ctermfg=white ctermbg=DarkMagenta
hi TabLineFill1 guifg=#777777

hi TabLineFill2 term=none
hi TabLineFill2 ctermfg=white ctermbg=DarkCyan
hi TabLineFill2 guifg=#777777
"  TabLineSel   tab pages line, active tab page label
hi TabLineSel term=inverse
"hi TabLineSel term=none
hi TabLineSel cterm=none ctermfg=yellow "ctermbg=White
"hi TabLineSel ctermfg=yellow
hi TabLineSel gui=none guifg=yellow guibg=Black

hi TabLineOther term=none
hi TabLineOther ctermfg=black ctermbg=black
hi TabLineOther guifg=#777777



function! MyTabLine()
	let s = ''
	let a = 0
	for i in range(tabpagenr('$'))
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			if a == 0
				let s .= '%#TabLineFill1#'
				let a = 1
			else
				let s .= '%#TabLineFill2#'
				let a = 0
			endif
		endif
		let s .= '%' . (i + 1) . 'T'
		let s .= ' %{MyShortTabLabel(' . (i + 1) . ')} '
	endfor

	let s .= '%#TabLineOther#%T'
	if tabpagenr('$') > 1
		let s .= '%=%#TabLine#%999Xclose'
	endif
	echomsg "Tabline: " . s
	return s
endfunction

function! MyShortTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  "let label = '<'
  let label = bufname (buflist[tabpagewinnr (a:n) -1])
  "let label .= '>'
  if getbufvar(buflist[tabpagewinnr (a:n) -1], '&modified')
	let label .= '[+]'
  endif
  let filename = fnamemodify (label, ':t')
  return filename
endfunction

"function! MyTabLabel(n)
  "let buflist = tabpagebuflist(a:n)
  "let winnr = tabpagewinnr(a:n)
  "return bufname(buflist[winnr - 1])
"endfunction



