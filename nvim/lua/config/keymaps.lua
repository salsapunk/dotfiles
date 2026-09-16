local keymap = vim.keymap

keymap.set('n', '<leader>L', vim.cmd.Lazy)

-- x dont yank
keymap.set('n', 'x', '"_x')

-- increment and decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- delete a word backwards
keymap.set('n', 'db', 'vb"_d')

-- select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- tabs
keymap.set('n', '<leader>s', ':tabedit<Return>', { silent = true })
keymap.set('n', 'ss', ':split<Return><C-w>w', { silent = true })
keymap.set('n', 'sv', ':vsplit<Return><C-w>w', { silent = true })
keymap.set('n', 'sc', '<C-w>c', { silent = true })

-- move between tabs
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

-- resize
keymap.set('n', 'swh', '<C-w><')
keymap.set('n', 'swj', '<C-w>-')
keymap.set('n', 'swk', '<C-w>+')
keymap.set('n', 'swl', '<C-w>>')

-- find and replace
keymap.set('n', '<Leader>ro', ":vimgrep /search_term/gj **/*", { noremap = true, silent = true })
keymap.set('n', '<Leader>rp', ":cfdo %s/foo/bar/gc | update", { noremap = true, silent = true })

-- text editing
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")
