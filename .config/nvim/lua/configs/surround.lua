local surround = require 'nvim-surround'

-- Surrounds a text object with a delimiter pair, i.e. ysiw]
vim.keymap.set('n', 'ys',
	function()
		surround.insert_surround()
	end,
	{ desc = 'Surrounds a text object with a delimiter pair' })
-- Delete a surrounding delimiter, i.e. ds(
vim.keymap.set('n', 'ds',
	function() surround.delete_surround()
	end,
	{ desc = 'Delete a surrounding delimiter' })
-- Changes the surrounding delimiter, i.e. cs'"
vim.keymap.set('n', 'cs',
	function() surround.change_surround()
	end,
	{ desc = 'Changes the surrounding delimiter' })
-- Surrounds a visual selection with a delimiter, i.e. S{
vim.keymap.set('x', 'S',
	function() surround.insert_surround()
	end,
	{ desc = 'Surrounds a visual selection with a delimiter' })
