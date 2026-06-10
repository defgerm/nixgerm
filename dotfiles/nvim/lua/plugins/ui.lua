return {
  {
    "folke/snacks.nvim",
    init = function()
      vim.api.nvim_create_autocmd("BufDelete", {
        callback = function(event)
          local listed = vim.fn.getbufinfo({ buflisted = 1 })
          local remaining = vim.tbl_filter(function(b)
            return b.bufnr ~= event.buf
          end, listed)
          if #remaining == 0 then
            vim.schedule(function()
              Snacks.dashboard()
            end)
          end
        end,
      })
    end,
  },
}
