local M = {}

function M.jump(next, severity)
    local jump = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil

    return function()
        jump({ severity = severity })
    end
end

return M
