local config = function()
    local crates = require 'crates'
    crates.setup()


    local map = vim.keymap.set

    map('n', '<leader>ct', crates.toggle, { silent = true, desc = 'toggle crates' })
    map('n', '<leader>cr', crates.reload, { silent = true, desc = 'reload crates' })
    map('n', '<leader>cv', crates.show_versions_popup, { silent = true, desc = 'version popup' })
    map('n', '<leader>cf', crates.show_features_popup, { silent = true, desc = 'feature popup' })
    map('n', '<leader>cd', crates.show_dependencies_popup, { silent = true, desc = 'dependencies popup' })

    map('n', '<leader>cu', crates.update_crate, { silent = true, desc = 'udate crate' })
    map('v', '<leader>cu', crates.update_crates, { silent = true, desc = 'udate selected crates' })
    map('n', '<leader>ca', crates.update_all_crates, { silent = true, desc = 'update all' })
    map('n', '<leader>cU', crates.upgrade_crate, { silent = true, desc = 'upgrade crate' })
    map('v', '<leader>cU', crates.upgrade_crates, { silent = true, desc = 'upgrade selected crates' })
    map('n', '<leader>cA', crates.upgrade_all_crates, { silent = true, desc = 'upgrade all' })

    map('n', '<leader>cH', crates.open_homepage, { silent = true, desc = 'open crate homepage' })
    map('n', '<leader>cR', crates.open_repository, { silent = true, desc = 'open crate repository' })
    map('n', '<leader>cD', crates.open_documentation, { silent = true, desc = 'open crates docs.rs' })
    map('n', '<leader>cC', crates.open_crates_io, { silent = true, desc = 'open crates.io' })
end

return {
    {
        'saecki/crates.nvim',
        tag = 'v0.3.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = config,
    }
}
