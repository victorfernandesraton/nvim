-- Inline Debug Text
return {
    -- https://github.com/theHamsta/nvim-dap-virtual-text
    'theHamsta/nvim-dap-virtual-text',
    opts = {
        -- Display debug text as a comment
        commented = true,
        -- Customize virtual text
        ---@diagnostic disable-next-line: unused-local
        display_callback = function(variable, _buf, _stackframe, _node, options)
            if options.virt_text_pos == 'inline' then
                return ' = ' .. variable.value
            else
                return variable.name .. ' = ' .. variable.value
            end
        end,
    }
}
