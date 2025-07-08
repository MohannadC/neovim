return { -- Language support
	"Wansmer/langmapper.nvim",
	lazy = false,
	priority = 1, -- High priority is needed if you will use `autoremap()`
	config = function()
		require("langmapper").setup({--[[ your config ]]
		})
	end,
}

-- vim: ts=2 sts=2 sw=2 et
