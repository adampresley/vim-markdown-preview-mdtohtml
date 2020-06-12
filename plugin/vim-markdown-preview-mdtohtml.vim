"============================================================
"              Vim Markdown Preview MDTOHTML
" git@github.com:adampresley/vim-markdown-preview-mdtohtml.git
"============================================================

let g:vmp_script_path = resolve(expand('<sfile>:p:h'))

let g:vmp_osname = 'Unidentified'

if has('win32') || has('win64')
  " Not yet used
  let g:vmp_osname = 'win32'
elseif has('unix')
  let s:uname = system("uname")

  if has('mac') || has('macunix') || has("gui_macvim") || s:uname == "Darwin\n"
    let g:vmp_osname = 'mac'
    let g:vmp_search_script = g:vmp_script_path . '/applescript/search-for-vmp.scpt'
    let g:vmp_activate_script = g:vmp_script_path . '/applescript/activate-vmp.scpt'
  else
    let g:vmp_osname = 'unix'
  endif
endif

if !exists("g:vim_markdown_preview_mdtohtml_browser")
  if g:vmp_osname == 'mac'
    let g:vim_markdown_preview_mdtohtml_browser = 'Safari'
  else
    let g:vim_markdown_preview_mdtohtml_browser = 'Google Chrome'
  endif
endif

if !exists("g:vim_markdown_preview_mdtohtml_use_xdg_open")
    let g:vim_markdown_preview_mdtohtml_use_xdg_open = 0
endif

if !exists("g:vim_markdown_preview_mdtohtml_css")
  let g:vim_markdown_preview_mdtohtml_css=expand("<sfile>:p:h")."/modest.css"
endif

if !exists("g:vim_markdown_preview_mdtohtml_hotkey")
    let g:vim_markdown_preview_mdtohtml_hotkey='<C-m>'
endif

function! Vim_Markdown_Preview()
  let b:curr_file = expand('%:p')
  call system('echo "<style type=\"text/css\">$(cat '. g:vim_markdown_preview_mdtohtml_css .')</style>\n$(mdtohtml '. b:curr_file .')" > /tmp/vim-markdown-preview.html')

  if v:shell_error
    echo 'Please install the necessary requirements: hhttps://github.com/adampresley/vim-markdown-preview-mdtohtml#requirements'
  endif

  if g:vmp_osname == 'unix'
    let chrome_wid = system("xdotool search --name 'vim-markdown-preview.html - " . g:vim_markdown_preview_mdtohtml_browser . "'")
    if !chrome_wid
      if g:vim_markdown_preview_mdtohtml_use_xdg_open == 1
        call system('xdg-open /tmp/vim-markdown-preview.html 1>/dev/null 2>/dev/null &')
      else
        call system('see /tmp/vim-markdown-preview.html 1>/dev/null 2>/dev/null &')
      endif
    else
      let curr_wid = system('xdotool getwindowfocus')
      call system('xdotool windowmap ' . chrome_wid)
      call system('xdotool windowactivate ' . chrome_wid)
      call system("xdotool key 'ctrl+r'")
      call system('xdotool windowactivate ' . curr_wid)
    endif
  endif

  if g:vmp_osname == 'mac'
    if g:vim_markdown_preview_mdtohtml_browser == "Google Chrome"
      let b:vmp_preview_in_browser = system('osascript "' . g:vmp_search_script . '"')
      if b:vmp_preview_in_browser == 1
        call system('open -g /tmp/vim-markdown-preview.html')
      else
        call system('osascript "' . g:vmp_activate_script . '"')
      endif
    else
      call system('open -a "' . g:vim_markdown_preview_mdtohtml_browser . '" -g /tmp/vim-markdown-preview.html')
    endif
  endif
endfunction

"Maps vim_markdown_preview_hotkey to Vim_Markdown_Preview()
:exec 'autocmd Filetype markdown,md map <buffer> ' . g:vim_markdown_preview_mdtohtml_hotkey . ' :call Vim_Markdown_Preview()<CR>'
