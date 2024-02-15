return {
  "schrieveslaach/sonarlint.nvim",
  config = function()
    local sonar_java = vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar")
    print(sonar_java)
    require('sonarlint').setup({
      server = {
        cmd = {
          'sonarlint-language-server',
          -- Ensure that sonarlint-language-server uses stdio channel
          '-stdio',
          '-analyzers',
          sonar_java,
        }
      },
      filetypes = {
        -- Tested and working
        'python',
        'cpp',
        'java',
      }
    })
  end
}
