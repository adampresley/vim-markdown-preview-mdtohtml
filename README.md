# Vim Markdown Preview MDTOHTML
A markdown previewer using Golang mdtohtml

- [Intro](#intro)
- [Installation](#installation)
- [Usage](#usage)
- [Requirements](#requirements)
    - [Mac OS X](#mac-os-x)
    - [Unix](#unix)
- [Options](#options)
    - [Image rendering & save on buffer write](#toggle)
    - [Hotkey](#hotkey)
    - [Browser](#browser)
    - [Temp File](#temp)
    - [Github Flavoured Markdown](#github)
    - [Markdown.pl](#perl)
    - [Pandoc](#pandoc)
    - [Use xdg-open](#xdg)
- [Behind the Scenes](#behind-the-scenes)

## Intro

A small Vim plugin for previewing markdown files in a browser using the [mdtohtml](https://github.com/gomarkdown/mdtohtml) tool. It opens whatever browser is set as your system default.

The aim of this plugin is to be light weight with minimal dependencies. Thus, there is *no* polling engine or webserver involved.

## Installation

* With [Pathogen](https://github.com/tpope/vim-pathogen): Place `vim-markdown-preview/` in `.vim/bundle/`.
* With [Vundle](https://github.com/VundleVim/Vundle.vim):
    * Add `Plugin 'JamshedVesuna/vim-markdown-preview'` to your `.vimrc`.
    * Launch `vim` and run `:PluginInstall`
* With [Plug](https://github.com/junegunn/vim-plug):
	 * Add `Plug 'adampresley/vim-markdown-preview-mdtohtml'` to your `.vimrc`.
	 * Launch `vim` and run `:PlugInstall`

## Usage

By default, when in a `.markdown` or `.md` file, and  `Ctrl-m` is pressed, this plugin will either open a preview in your browser, or refresh your current preview.

Your cursor will remain in Vim.

## Requirements

This tool requires [mdtohtml](https://github.com/gomarkdown/mdtohtml). To install it you must have [Go](https://golang.org) installed first. Once you have Go installed execute the following on your command line:

```
go get -u github.com/gomarkdown/mdtohmtl
```

### Mac OS X:

* [Safari](https://www.apple.com/safari/)

### Unix:

* [xdotool](https://github.com/jordansissel/xdotool)
* [Google Chrome](https://www.google.com/chrome/browser/) or [other browser](https://github.com/JamshedVesuna/vim-markdown-preview/wiki/Use-other-browser-to-preview-markdown#ubuntu-or-debian)

## Options

All options have default values and work out of the box. If you prefer to change these, just add the following lines to your [.vimrc](http://vim.wikia.com/wiki/Open_vimrc_file) file.
Note that after changing an option, you have to restart Vim for the change to take effect.

<a name='hotkey'></a>
### The `vim_markdown_preview_mdtohtml_hotkey` option

By default, this plugin maps `<C-m>` (Control m) to activate the preview. To remap Control m to a different hotkey, change the binding. Don't forget to add the single quotation marks.

Default: `'<C-m>'`

Example: Mapping Control M.
```vim
let vim_markdown_preview_hotkey='<C-p>'
```

<a name='xdg'></a>
### The `vim_markdown_preview_mdtohtml_use_xdg_open` option

If your system does not come with `see`, and you would like to use `xdg-open` to view your rendered html in the browser, set the following flag:

Default: `0`

Example: Use `xdg-open`.
```vim
let vim_markdown_preview_mdtohtml_use_xdg_open=1
```

## Behind The Scenes

1. First, this plugin renders your markdown as html and creates a temporary html file in `/tmp`.
2. Next, this plugin either opens the html file or refreshes the Google Chrome or Safari tab.
