require("config.lazy")

vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local bufs = vim.tbl_filter(function(b)
      return vim.bo[b].buflisted
    end, vim.api.nvim_list_bufs())
    if #bufs == 0 then
      Snacks.dashboard.open()
    end
  end,
})
