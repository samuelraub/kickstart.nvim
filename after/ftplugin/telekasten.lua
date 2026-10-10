vim.opt_local.shiftwidth = 2

-- Markdown list handling: continuation and gq wrapping
vim.opt_local.comments = 'fb:*,fb:-,fb:+,n:>'
vim.opt_local.commentstring = '<!--%s-->'
vim.opt_local.formatoptions:append 'tcqln'
vim.opt_local.formatoptions:remove { 'r', 'o' }
vim.opt_local.formatlistpat = [=[^\s*\d\+\.\s\+\|^[-*+]\s\+\|^\[^\ze[^\]]\+\]:]=]
