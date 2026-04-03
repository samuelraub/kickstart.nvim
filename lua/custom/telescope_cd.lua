local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

local M = {}

M.directories = function(opts)
  opts = opts or {}
  local cwd = vim.fn.expand '~/'
  pickers
    .new(opts, {
      prompt_title = 'Directories',
      finder = finders.new_oneshot_job({
        'fd',
        '--type',
        'directory',
        '--max-depth',
        '2',
        '--hidden',
        '--exclude',
        '{Library,Pictures,Applications,Movies,Downloads,Desktop,Music,.cache,.Trash,.docker,.claude,.android,.audible,.battery,.bundle,.cargo,.cups,.devpod,.dropbox,.local,.orbstack,.gem}',
      }, {
        cwd = cwd,
        entry_maker = function(entry)
          return {
            value = cwd .. '/' .. entry,
            display = entry,
            ordinal = entry,
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          vim.cmd('lcd ' .. selection['value'])
          print('Switched to ' .. selection['display'])
        end)
        return true
      end,
    })
    :find()
end

return M
