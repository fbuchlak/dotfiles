local util = require("util")

local M = {}

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            on_attach(client, args.buf)
        end,
    })
end

function M.attach_keymaps(_, buffer)
    local lsp = vim.lsp.buf

    local ts = function(builtin, opts)
        opts = opts or {}
        opts.reuse_win = opts.reuse_win ~= false

        return function()
            require("telescope.builtin")[builtin](opts)
        end
    end

    local opts = function(desc)
        return { desc = desc, buffer = buffer }
    end

    local source_action = function()
        lsp.code_action({
            context = {
                only = { "source" },
                diagnostics = {},
            },
        })
    end

    local lsp_ts_opts = {
        symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
        },
    }

    M
        -- Actions
        .map({ "n", "v" }, "<Leader>ga", lsp.code_action, opts("[LSP] Code Action"), "codeAction")
        .map("n", "<Leader>gA", source_action, opts("[LSP] Source Action"), "codeAction")
        .map("n", "<Leader>gr", lsp.rename, opts("[LSP] Rename"))
        .map("n", "gR", lsp.rename, opts("[LSP] Rename"))
        -- Hints
        .map("n", "K", lsp.hover, opts("[LSP] Hover"))
        .map("n", "gK", lsp.signature_help, opts("[LSP] Signature Help"))
        .map("i", "<C-k>", lsp.signature_help, opts("[LSP] Signature Help"))
        -- Navigation
        .map("n", "gD", lsp.declaration, opts("[LSP] Declaration"), "declaration")
        .map("n", "gd", ts("lsp_definitions"), opts("[LSP] Definition"), "definition")
        .map("n", "gr", ts("lsp_references"), opts("[LSP] References"))
        .map("n", "gI", ts("lsp_implementations"), opts("[LSP] Implementation"), "implementation")
        .map("n", "gy", ts("lsp_type_definitions"), opts("[LSP] Type Definition"))
        .map("n", "<Leader>sls", ts("lsp_document_symbols", lsp_ts_opts), opts("[Search][LSP] Document Symbol"))
        .map("n", "<Leader>slw", ts("lsp_dynamic_workspace_symbols", lsp_ts_opts), opts("[Search][LSP] Workspace Symbol"))
        -- Diagnostics
        .map("n", "<Leader>hd", vim.diagnostic.open_float, opts("[Diagnostic] Show Message"))
        .map_diagnostic_jumps("d", opts("Message"))
        .map_diagnostic_jumps("e", opts("Error Message"), "ERROR")
        .map_diagnostic_jumps("w", opts("Warning Message"), "WARNING")
end

function M.format()
    local buffer = vim.api.nvim_get_current_buf()

    local filetype = vim.bo[buffer].filetype
    local null_ls = require("null-ls.sources").get_available(filetype, "NULL_LS_FORMATTING") or {}
    local eslint = nil
    local client_ids = {}
    for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = buffer })) do
        if
            (0 == #null_ls or (client.name == "null-ls"))
            and (
                client.supports_method(M.get_method("formatting"))
                or client.supports_method(M.get_method("rangeFormatting"))
            )
        then
            table.insert(client_ids, client.id)
        elseif "eslint" == client.name then
            eslint = client
        end
    end

    if 0 == #client_ids and not eslint then
        print("No available formatters found!")
        return
    end

    vim.lsp.buf.format({
        bufnr = buffer,
        filter = function(client)
            return vim.tbl_contains(client_ids, client.id)
        end,
    })

    -- if there are any errors provided by eslint, fix them
    if eslint and #vim.diagnostic.get(buffer, { namespace = vim.lsp.diagnostic.get_namespace(eslint.id) }) > 0 then
        vim.cmd("EslintFixAll")
    end
end

function M.map(mode, lhs, rhs, opts, method)
    if not method or M.supports_method(method, opts.buffer or vim.api.nvim_get_current_buf()) then
        util.map(mode, lhs, rhs, opts)
    else
        opts.desc = "[!Disabled] " .. (opts.desc or "")

        util.map(mode, lhs, function()
            print("Mapping " .. lhs .. " disabled! LSP does not support method " .. method)
        end, opts)
    end

    return M
end

function M.map_diagnostic_jumps(key, opts, severity)
    local jump = require("util.diagnostic").jump

    local jump_next, jump_prev = require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair(
        jump(true, severity),
        jump(false, severity)
    )

    local next_opts = vim.deepcopy(opts)
    next_opts.desc = "[Diagnostic] Next " .. next_opts.desc
    M.map("n", "<Leader>j" .. key, jump_next, next_opts)

    opts.desc = "[Diagnostic] Prev " .. opts.desc
    M.map("n", "<Leader>k" .. key, jump_prev, opts)

    return M
end

function M.get_method(method)
    return method:find("/") and method or "textDocument/" .. method
end

function M.supports_method(method, buffer)
    for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = buffer or vim.api.nvim_get_current_buf() })) do
        if client.supports_method(M.get_method(method)) then
            return true
        end
    end

    return false
end

return M
