local M = {}

local java_utils = require("configs.lsp.custom.java.utils")
local map = java_utils.map

local function get_spring_boot_runner(profile, debug, more_params)
  if not more_params then
    more_params = ""
  end
  local debug_param = ""
  if debug then
    debug_param =
    ' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=127.0.0.1:5005" '
  end

  local profile_param = ""
  if profile then
    profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
  end

  return 'mvn spring-boot:run -Dspring.config.additional-location=file:.local-config/' ..
      profile_param .. debug_param .. " " .. more_params
end

local function get_spring_boot_builder(more_params)
  if not more_params then
    more_params = ""
  end
  return 'mvn clean install ' .. more_params
end

local function get_env_command()
  local java_configurations = require("configs.lsp.custom.java.configuration")
  local env_command = java_configurations.get_env_command() or ''
  return env_command ~= '' and env_command .. ' && ' or ''
end

function M.map_functions()
  map(
    { "n", "v" },
    "<leader>sr",
    function()
      local spring_boot_run = get_spring_boot_runner(nil, false, vim.fn.input("spring-boot run args: "))
      local root = require("jdtls.setup").find_root({ "pom.xml" })

      local command = string.format(
        [[execute 'term cd %s && %s']],
        root,
        get_env_command() .. 'echo ' .. spring_boot_run .. ' && ' .. spring_boot_run
      )
      vim.cmd(command)
    end,
    "Execute spring boot project"
  )
  map(
    { "n", "v" },
    "<F5>",
    function()
      local spring_boot_run = get_spring_boot_runner(nil, false, vim.fn.input("spring-boot run args: "))
      local root = require("jdtls.setup").find_root({ "pom.xml" })

      local command = string.format(
        [[execute 'term cd %s && %s']],
        root,
        get_env_command() .. 'echo ' .. spring_boot_run .. ' && ' .. spring_boot_run
      )
      vim.cmd(command)
    end,
    "Execute spring boot project"
  )
  map(
    { "n", "v" },
    "<leader>sd",
    function()
      local spring_boot_debug = get_spring_boot_runner(nil, true, vim.fn.input("spring-boot debug args: "))
      local root = require("jdtls.setup").find_root({ "pom.xml" })

      local command = string.format(
        [[execute 'term cd %s && %s']],
        root,
        get_env_command() .. 'echo ' .. spring_boot_debug .. ' && ' .. spring_boot_debug
      )
      vim.cmd(command)
    end,
    "Debug spring boot project"
  )
  map(
    { "n", "v" },
    "<F10>",
    function()
      local spring_boot_debug = get_spring_boot_runner(nil, true, vim.fn.input("spring-boot debug args: "))
      local root = require("jdtls.setup").find_root({ "pom.xml" })

      local command = string.format(
        [[execute 'term cd %s && %s']],
        root,
        get_env_command() .. 'echo ' .. spring_boot_debug .. ' && ' .. spring_boot_debug
      )
      vim.cmd(command)
    end,
    "Debug spring boot project"
  )
  map(
    { "n", "v" },
    "<C-b>",
    function()
      local spring_boot_build = get_spring_boot_builder(vim.fn.input("maven build args: "))
      local root = require("jdtls.setup").find_root({ "pom.xml" })

      local command = string.format(
        [[execute 'term cd %s && %s']],
        root,
        'echo ' .. spring_boot_build .. ' && ' .. spring_boot_build
      )
      vim.cmd(command)
    end,
    "Build spring boot project"
  )
end

return M
