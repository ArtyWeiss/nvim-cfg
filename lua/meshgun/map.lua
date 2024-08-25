vim.g.mapleader = " "

-- move selected
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- comment rust line 
vim.keymap.set("v", "<leader>c", ":'<,'>norm i//<CR>")
vim.keymap.set("v", "<leader>cc", ":s#//#<CR>")
vim.keymap.set("n", "<leader>c", ":norm 0i//<CR>")
vim.keymap.set("n", "<leader>cc", ":s#//#<CR>")

-- paste without yanking
vim.keymap.set("x", "<A-p>", "\"_dP")

-- yank in system buffer
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- paste from system buffer
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("v", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")

-- quickfix
vim.keymap.set("n", "<A-]>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<A-[>", "<cmd>cprev<CR>zz")
