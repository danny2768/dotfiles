# NvChad configuration

Once installed NvChad review the file located in `~/.config/nvim/init.lua` if you are like me you'll use 4 indent spaces.

Add these line at the end of the file:
`
-- Change indentation to 4 spaces
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces in
`

Then go to `~/.config/nvim/lua/custom/` 

## chadrc.lua 
Feel free to copy the whole file, there is not much aside standar config.

## mappings.lua
In this file you'll find the standard keybindings plus a binding to toggle transparency using: `space + tt`

## init.lua
In this file I configured my custom snippets for different languages in vscode/json format.
The file references the path where you are going to save your snippets. 

Which should be: `~/.config/nvim/lua/custom/my_snippets/`

This path should containg a package.json referencing the snippet language and json file.

Feel free to copy my_snippets folder.

Attributions: 
    - [Jhonpapa: vscode-angular-snippets](https://github.com/johnpapa/vscode-angular-snippets)
    - [charalampos karypidis: JavaScript (ES6) code snippets](https://marketplace.visualstudio.com/items?itemName=xabikos.JavaScriptSnippets)
