return {
  {
    "antigravity-custom",
    dir = vim.fn.stdpath("config"),
    config = function()
      -- 1. Enable auto-read and setup automatic disk change checks
      -- This ensures that any files edited by agy (or any external tool) are refreshed in real-time!
      vim.opt.autoread = true

      -- Reduce updatetime for faster feedback (default is 4000ms)
      -- This makes CursorHold trigger after 300ms of inactivity, refreshing edits almost instantly!
      vim.opt.updatetime = 300

      -- Trigger checktime on various events to detect disk changes
      vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
        pattern = "*",
        callback = function()
          if vim.fn.mode() ~= "c" then
            vim.cmd("checktime")
          end
        end,
      })

      local gemini_buf = nil
      local gemini_win = nil

      -- The main logic to open/hide/resume the AI
      local function toggle_gemini()
        -- 1. Check if the window is already open and valid
        if gemini_win and vim.api.nvim_win_is_valid(gemini_win) then
          -- If we are currently inside the AI window, hide it
          if vim.api.nvim_get_current_win() == gemini_win then
            vim.api.nvim_win_hide(gemini_win)
            gemini_win = nil
            return
          else
            -- If we are in another window, switch focus to it
            vim.api.nvim_set_current_win(gemini_win)
            vim.cmd("startinsert")
            return
          end
        end

        -- 2. Open a vertical split on the far right with a clean default width
        vim.cmd("botright vertical 50split")

        -- 3. If a buffer already exists (AI is still running), switch to it
        if gemini_buf and vim.api.nvim_buf_is_valid(gemini_buf) then
          vim.api.nvim_win_set_buf(0, gemini_buf)
        else
          -- 4. Start a fresh Antigravity CLI session (agy)
          vim.cmd("term agy")
          gemini_buf = vim.api.nvim_get_current_buf()

          -- Set premium buffer options for the terminal
          vim.bo[gemini_buf].buflisted = false
          vim.bo[gemini_buf].filetype = "antigravity"

          -- 5. Safe auto-delete when you quit the CLI
          vim.api.nvim_create_autocmd("TermClose", {
            buffer = gemini_buf,
            callback = function()
              vim.schedule(function()
                if gemini_buf and vim.api.nvim_buf_is_valid(gemini_buf) then
                  vim.cmd("bdelete!")
                end
                gemini_buf = nil
                gemini_win = nil
              end)
            end,
          })
        end

        -- Save current window context and enter terminal mode
        gemini_win = vim.api.nvim_get_current_win()
        vim.cmd("startinsert")
      end

      -- Set the keymap for Normal and Terminal mode to toggle the AI split
      vim.keymap.set({ "n", "t" }, "<C-g>", toggle_gemini, { desc = "Toggle Antigravity AI" })
    end,
  },
}
