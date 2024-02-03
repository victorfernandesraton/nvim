return { "nxstynate/rosePine.nvim", priority = 1000 , 
    config = function(_, opts)
        vim.cmd([[colorscheme rosePine]])   
	vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
	vim.api.nvim_set_hl(0, "Normal", {bg = "none"})

    end
}

