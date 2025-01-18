# Core

## Keymaps

- [S]earch: For fuzzy finding things
	- [b] search buffers
	- [c] search commands
	- [C] search cheatsheat
	- [d] search diagnostics
	- [f] search files
	- [g] Git search
		- [b] search branches
		- [c] search commits
		- [t] search buffer commits
		- [f] search git files 
		- [s] search status
		- [a] search stash
	- [h] search help files
	- [k] search keymaps
	- [M] search man files
	- [m] search workspace marks
	- [n] search neovim config files
	- [o] search old files
	- [p] resume previous search
	- [R] search registers
	- [s] search by grep
	- [t] search all todo
	- [T] search treesitter
	- [w] search word in ?cwd?
	- [.] search in recent files
	- [/] search in open files
- [C]ode: For lsp actions and formatting
	- [a] lsp code actions
	- [f] format buffer
	- [h] display in lay hints
	- [p] peek X definition in overlay
		- [c] peek class
		- [f] peek at function
		- [v] peek at variable
		- [e] peek at enum
		- [s] peek at struct
	- [r] display references 
	- [w] turn on workspace for current session
	- [?] swap paramatters to the left
	- [?] swap paramatters to the right
- [F]ile: For file stuff
	- [a] add file to harpoon
	- [c] close buffer, but preserve window it is in
	- [h] open harpoon window
	- [n] create new file
	- [o] open oil
	- [r] remove file from harpoon
	- [s] save file
	- [u] open current file undo history 
	- [,] previous harpoon buffer
	- [.] next harpoon buffer
- [G]it: For git related keybinds
	- [b] blame line
	- [B] toggle blame for each line
	- [d] diffing maps TODO
	- [h] git toggle highlight and deleted lines
	- [n] next hunk
	- [p] previous hunk
	- [r] reset hunk
	- [s] stage hunk
	- [u] undo staging of hunk
	- [v] preview hunk
	- [%] reset buffer
- [<Space>]Language: For language specific keybinds
	- This will not have a standardised keymap as it is language specific
- [D]iagnostics: For debugging and diagnostics
	- [b] Toggle break point
	- [i] step into 
	- [o] step over
	- [<Space>] continue
	- [t] step out
	- [c] set conditional breakpoint
- [U]i: Modifying ui elements
	- [c] set colorschemes
- [T]reesitter: commands for using treesitter
	- [c] Jump to context window
	- [n] navigate using hydra treesitter
- [<TAB>]:search tabs
- [e]rrors: lsp inspect error 
- [q]uickfix: open quickfix list
- [l]ocaltion: open location list

## Workspace
Quickly set up project specific tabs and files.
### Keybinds

- <A-1>: Main edit tab
- <A-2>: Terminal
- <A-3>: Open debug tab


# Look into
## vim.lsp.diagnostic
vim.lsp.diagnostics could be builtin linting?
basically the stuff that controlls error information
