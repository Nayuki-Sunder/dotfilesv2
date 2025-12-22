-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

local M = require("util")

keymap.set("n", "x", '"_x')
-- Do things without affecting the registers
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')

keymap.set("n", "<ESC>", M.save_file)

-- move line up down
keymap.set({ "n", "i", "v" }, "<A-j>", "<esc>jj", { desc = "Move down" })
keymap.set({ "n", "i", "v" }, "<A-k>", "<esc>kk", { desc = "Move up" })

keymap.set("i", "<ESC>", "<ESC>:lua require('util').save_file()<CR>")
-- Map q/Q to exit/quit
keymap.set("n", "q", ":exit<CR>")
keymap.set("n", "Q", ":qa!<CR>")

-- Delete from line start to end of previous line
keymap.set("n", "dk", "^hvk$d")

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")
-- Disable continuations
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

keymap.set("n", "<TAB>", ":bn<CR>")
keymap.set("n", "<Left>", ":bp<CR>")
keymap.set("n", "<Right>", ":bn<CR>")
keymap.set("n", "<Leader>bw", ":<C-u>bp <BAR> bd #<CR>") -- quit current buffer
keymap.set("n", "<Leader>bo", M.buf_only)
keymap.set("n", "<Leader>bb", M.move_buf_vsp)
keymap.set("n", "B", ":BufferLinePick<CR>")

-- Beginning and end of the line
keymap.set({ "n", "v" }, "<S-h>", "^")
keymap.set({ "n", "v" }, "<S-l>", "$")
