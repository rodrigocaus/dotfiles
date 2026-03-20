return {
  {
    "gemini-custom",
    dir = vim.fn.stdpath("config"),
    config = function()
      local gemini_buf = nil
      local gemini_win = nil

      -- The main logic to open/hide/resume the AI
      local function toggle_gemini()
        -- 1. Check if the window is already open and valid
        if gemini_win and vim.api.nvim_win_is_valid(gemini_win) then
          vim.api.nvim_win_hide(gemini_win)
          gemini_win = nil
          return
        end

        -- 2. If it's closed, open a vertical split on the right
        vim.cmd("vsplit | wincmd l")
        
        -- 3. If a buffer already exists (AI is still running), just switch to it
        if gemini_buf and vim.api.nvim_buf_is_valid(gemini_buf) then
          vim.api.nvim_win_set_buf(0, gemini_buf)
        else
          -- 4. Otherwise, start a fresh Gemini CLI session
          vim.cmd("term gemini")
          gemini_buf = vim.api.nvim_get_current_buf()

          -- 5. Auto-delete the buffer when you finally quit the CLI
          vim.api.nvim_create_autocmd("TermClose", {
            buffer = gemini_buf,
            callback = function()
              vim.cmd("bdelete!")
              gemini_buf = nil
              gemini_win = nil
            end,
          })
        end

        -- Save the current window ID so we know where to find it later
        gemini_win = vim.api.nvim_get_current_win()
        vim.cmd("startinsert")
      end

      -- Set the keymap for Normal and Terminal mode
      -- This lets you hit Ctrl-g to open it, and Ctrl-g again to hide it!
      vim.keymap.set({ "n", "t" }, "<C-g>", toggle_gemini, { desc = "Toggle Gemini AI" })
    end,
  },
}
