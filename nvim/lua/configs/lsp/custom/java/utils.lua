local m_utils = require "m_utils"
local M = {}

function M.map(mode, lhs, rhs, desc, buffer)
  if buffer then
    desc = desc
  else
    buffer = 0 -- 0 represents the current buffer
  end

  if desc then
    desc = desc
  end

  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = buffer, noremap = true })
end

function M.mvn_path()
  return vim.fn.expand("$HOME") .. "/.m2/repository"
end

function M.get_jdtls()
  local mason_registry = require("mason-registry")
  local jdtls = mason_registry.get_package("jdtls")
  local jdtls_path = jdtls:get_install_path()
  local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  local SYSTEM = "linux"
  if vim.fn.has("mac") == 1 then
    SYSTEM = "mac"
  end
  local config = jdtls_path .. "/config_" .. SYSTEM
  local lombok = jdtls_path .. "/lombok.jar"
  return launcher, config, lombok
end

function M.maven_run()
  local io_utils = require("m_utils.io")

  -- get filename
  vim.cmd('let @+=expand("%:p")')
  local filename = vim.fn.getreg("+")

  local regex_pattern = "^package%s*(%S+);"
  local package_name = io_utils.extract_text_using_regex(filename, regex_pattern)

  if package_name then
    print("Found package:", package_name)

    regex_pattern = "public%s+class%s+(%w+)%s*"
    local class_name = io_utils.extract_text_using_regex(filename, regex_pattern)

    if class_name then
      local main_class = package_name .. "." .. class_name
      print("Class Name:", class_name)
      print("Main Class:", main_class)

      local command = string.format(
        [[execute 'term mvn clean compile exec:java -Dexec.mainClass="%s"']],
        main_class
      )
      print("cmd: ", command)
      vim.cmd(command)
    else
      print("Class Name not found in the file or the file couldn't be read.")
    end
  else
    print("package name not found in the file or the file couldn't be read.")
  end
end

function M.get_bundles()
  local mason_registry = require("mason-registry")
  local java_debug = mason_registry.get_package("java-debug-adapter")
  local java_test = mason_registry.get_package("java-test")
  local java_debug_path = java_debug:get_install_path()
  print("java_debug_path " .. java_debug_path)
  local java_test_path = java_test:get_install_path()
  print("java_test_path " .. java_test_path)
  local bundles = {}
  vim.list_extend(
    bundles,
    vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n")
  )
  vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n"))
  -- print("bundles: ")
  -- printers.printNestedTable(bundles)
  return bundles
end

function M.get_workspace()
  local home = os.getenv("HOME")
  local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = workspace_path .. project_name
  return workspace_dir
end

function M.registerKeyMappings(bufnr)
  -- Register keymappings
  local wk = require("which-key")
  local keys = { mode = { "n", "v" }, ["<leader>lj"] = { name = "+Java" } }
  wk.register(keys)

  local map = function(mode, lhs, rhs, desc)
    M.map(mode, lhs, rhs, desc, bufnr)
  end

  map(
    "n",
    "mcl",
    "/\\(public\\|private\\|protected\\)\\( class \\| abstract class \\| interface \\)<cr>:nohlsearch<Bar>:echo<CR>ww",
    "Move to class"
  )
  map(
    "n",
    "mpm",
    "k/\\(public\\|private\\|protected\\).*\\((\\)<cr>Nf(b:nohlsearch<Bar><CR>",
    "Move to last function"
  )
  map(
    "n",
    "mnm",
    "?\\(public\\|private\\|protected\\).*\\((\\)<cr>Nf(b:nohlsearch<Bar><CR>",
    "Move to next function"
  )

  map("n", "<leader>vb", "[{vo%", "Visualize whole block")

  map(
    "n",
    "<leader>vf",
    "/\\(public\\|private\\|protected\\).*\\((\\)<cr>Nf(b:nohlsearch<Bar><CR>/{<CR>v%",
    "Visualize whole function"
  )
  local jdtls = require("jdtls")

  map("n", "go", function()
    jdtls.organize_imports()
    m_utils.save_this_buffer()
  end, "Organize Imports")

  map("v", "gl", function()
    local name = vim.fn.input("Variable Name: ")
    jdtls.extract_variable({ visual = true, name = name })
  end, "Extract Variable")
  map("n", "gl", function()
    jdtls.extract_variable()
  end, "Extract Variable")

  map("v", "gs", function()
    local name = vim.fn.input("Constant Name: ")
    jdtls.extract_constant({ visual = true, name = name })
  end, "Extract Constant")
  map("n", "gs", function()
    jdtls.extract_constant()
  end, "Extract Constant")
  map("n", "<leader>ljt", jdtls.test_nearest_method, "Test Nearest Method")
  map("n", "<leader>ljT", jdtls.test_class, "Test Class")
  -- map("n", "<leader>lju", "<cmd>JdtUpdateConfig<cr>", "Update Config")
  -- map("v", "gl", "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable")
  -- map("v", "gs", "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant")
  map({ "v" }, "gm", function()
    local name = vim.fn.input("Method Name: ")
    jdtls.extract_method({ visual = true, name = name })
  end, "Extract Method")

  map({ "v" }, "<leader>gm", function()
    local name = vim.fn.input("Method Name: ")
    jdtls.extract_method({ visual = true, name = name })
  end, "Extract Method")
end

return M
