local mvn_path = vim.fn.expand("$HOME") .. "/.m2/repository"
local function get_jdtls()
  local mason_registry = require "mason-registry"
  local jdtls = mason_registry.get_package "jdtls"
  local jdtls_path = jdtls:get_install_path()
  local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  local SYSTEM = "linux"
  if vim.fn.has "mac" == 1 then
    SYSTEM = "mac"
  end
  local config = jdtls_path .. "/config_" .. SYSTEM
  local lombok = jdtls_path .. "/lombok.jar"
  return launcher, config, lombok
end

local function get_bundles()
  local mason_registry = require "mason-registry"
  local java_debug = mason_registry.get_package "java-debug-adapter"
  local java_test = mason_registry.get_package "java-test"
  local java_debug_path = java_debug:get_install_path()
  local java_test_path = java_test:get_install_path()
  local bundles = {}
  vim.list_extend(bundles,
    vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n"))
  vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n"))
  return bundles
end

local function get_workspace()
  local home = os.getenv "HOME"
  local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = workspace_path .. project_name
  return workspace_dir
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java" },
  callback = function()
    -- LSP capabilities
    local jdtls = require "jdtls"
    local capabilities = require("base.lsp.utility").capabilities()
    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    local launcher, os_config, lombok = get_jdtls()
    local workspace_dir = get_workspace()
    local bundles = get_bundles()

    local on_attach = function(_, bufnr)
      vim.lsp.codelens.refresh()
      jdtls.setup_dap { hotcodereplace = "auto" }
      require("jdtls.dap").setup_dap_main_class_configs()
      require("jdtls.setup").add_commands()

      print("workspace_dir: " .. workspace_dir)
      print("launcher: " .. launcher)
      print("os_config: " .. os_config)
      print("lombok: " .. lombok)

      local map = function(mode, lhs, rhs, desc)
        if desc then
          desc = desc
        end
        vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
      end

      -- Register keymappings
      local wk = require "which-key"
      local keys = { mode = { "n", "v" }, ["<leader>lj"] = { name = "+Java" } }
      wk.register(keys)

      map("n", "mcl", '/\\(public\\|private\\|protected\\)\\( class \\| interface \\)<cr>',
        "Move to class")
      map("n", "mpm", 'k/\\(public\\|private\\|protected\\).*\\((\\)<cr>Nf(b:nohlsearch<Bar><CR>',
        "Move to last function")
      map("n", "mnm", '?\\(public\\|private\\|protected\\).*\\((\\)<cr>Nf(b:nohlsearch<Bar><CR>',
        "Move to next function")
      map("n", "<leader>vb", '[{vo%', "Visualize whole block")
      map("n", "<leader>vf", '/\\(public\\|private\\|protected\\).*\\((\\)<cr>Nf(b:nohlsearch<Bar><CR>/{<CR>v%',
        "Visualize whole function")
      map("n", "<leader>go", jdtls.organize_imports, "Organize Imports")
      map("n", "<leader>gl", jdtls.extract_variable, "Extract Variable")
      map("n", "<leader>gs", jdtls.extract_constant, "Extract Constant")
      map("n", "<leader>ljt", jdtls.test_nearest_method, "Test Nearest Method")
      map("n", "<leader>ljT", jdtls.test_class, "Test Class")
      map("n", "<leader>lju", "<cmd>JdtUpdateConfig<cr>", "Update Config")
      map("v", "<leader>gl", "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable")
      map("v", "<leader>gs", "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant")
      map("v", "gm", "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method")

      local root = require("jdtls.setup").find_root { "pom.xml" }
      print("root: " .. root)
      -- Set the individual classpaths as environment variables
      vim.env.LOG4J_CLASSPATH = mvn_path .. "/org/slf4j/slf4j-api/1.7.36/slf4j-api-1.7.36.jar:" ..
          mvn_path .. "/ch/qos/logback/logback-classic/1.2.12/logback-classic-1.2.12.jar:" ..
          mvn_path .. "/ch/qos/logback/logback-core/1.2.12/logback-core-1.2.12.jar:" ..
          mvn_path .. "/org/apache/logging/log4j/log4j-to-slf4j/2.17.2/log4j-to-slf4j-2.17.2.jar:" ..
          mvn_path .. "/org/apache/logging/log4j/log4j-api/2.17.2/log4j-api-2.17.2.jar:" ..
          mvn_path .. "/org/slf4j/jul-to-slf4j/1.7.36/jul-to-slf4j-1.7.36.jar"

      vim.env.JACKSON_CLASSPATH =
          mvn_path .. "/com/fasterxml/jackson/core/jackson-databind/2.13.5/jackson-databind-2.13.5.jar:" ..
          mvn_path .. "/com/fasterxml/jackson/core/jackson-annotations/2.13.5/jackson-annotations-2.13.5.jar:" ..
          mvn_path .. "/com/fasterxml/jackson/core/jackson-core/2.13.5/jackson-core-2.13.5.jar:" ..
          mvn_path .. "/com/fasterxml/jackson/datatype/jackson-datatype-jdk8/2.13.5/jackson-datatype-jdk8-2.13.5.jar:" ..
          mvn_path .. "/com/fasterxml/jackson/datatype/jackson-datatype-jsr310/2.13.5/jackson-datatype-jsr310-2.13.5.jar:" ..
          mvn_path .. "/com/fasterxml/jackson/module/jackson-module-parameter-names/2.13.5/jackson-module-parameter-names-2.13.5.jar"

      vim.env.ROOT_CLASSPATH = root .. "/target/classes"
      vim.env.LOMBOK_CP = lombok

      vim.keymap.set("n", "<leader>run", function()
        vim.cmd('let @+=expand("%:p")')
        local filename = vim.fn.getreg("+")
        local io_utils = require("utils.io")
        local regex_pattern = '^package%s*(%S+);'
        local extracted_text = io_utils.extract_text_using_regex(filename, regex_pattern)
        if extracted_text then
          print("Found text:", extracted_text)
          local package_name = extracted_text
          regex_pattern = 'public%s+class%s+(%w+)%s*'
          extracted_text = io_utils.extract_text_using_regex(filename, regex_pattern)
          if extracted_text then
            local class_name = extracted_text
            local main_class = package_name .. "." .. class_name
            print("Class Name:", class_name)
            local command = string.format(
              [[execute 'term java -classpath $LOG4J_CLASSPATH:$JACKSON_CLASSPATH:$ROOT_CLASSPATH %s']], main_class)
            print("cmd: ", command)
            vim.cmd(command)
          else
            print("Class Name not found in the file or the file couldn't be read.")
          end
        else
          print("package name not found in the file or the file couldn't be read.")
        end
      end)

      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.java" },
        callback = function()
          local _, _ = pcall(vim.lsp.codelens.refresh)
        end,
      })

      vim.cmd [[
      set foldmethod=syntax
      set foldenable
      syn region foldBraces start=/\{/ end=/\}/ transparent fold keepend extend
      syn region foldJavadoc start=+/\*+ end=+\*/+ transparent fold keepend extend
      ]]
    end

    local config = {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms2g",
        "-Xmx4g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:" .. lombok,
        "-jar",
        launcher,
        "-configuration",
        os_config,
        "-data",
        workspace_dir,
      },
      root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
      capabilities = capabilities,
      on_attach = on_attach,

      settings = {
        java = {
          autobuild = { enabled = false },
          signatureHelp = { enabled = true },
          contentProvider = { preferred = "fernflower" },
          saveActions = {
            organizeImports = true,
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            hashCodeEquals = {
              useJava7Objects = true,
            },
            useBlocks = true,
          },
          eclipse = {
            downloadSources = true,
          },
          configuration = {
            updateBuildConfiguration = "interactive",
            -- NOTE: Add the available runtimes here
            -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            -- runtimes = {
            --   {
            --     name = "JavaSE-18",
            --     path = "~/.sdkman/candidates/java/18.0.2-sem",
            --   },
            -- },
          },
          maven = {
            downloadSources = true,
          },
          implementationsCodeLens = {
            enabled = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
          references = {
            includeDecompiledSources = true,
            includeAllProjectSources = true,
            includeComments = true,
            includeOverridden = true
          },
          inlayHints = {
            parameterNames = {
              enabled = "all", -- literals, all, none
            },
          },
          -- format = {
          --   enabled = false,
          -- },
          -- NOTE: We can set the formatter to use different styles
          format = {
            enabled = true,
            settings = {
              url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
              profile = "google-style",
            },
          },
        },
      },
      init_options = {
        bundles = bundles,
        extendedClientCapabilities = extendedClientCapabilities,
      },
    }
    vim.cmd [[
    " Enable comment beautification for nvim-jdtls
    let g:jdtls_formatter_config = {
        \ 'eclipse.jdt.ls.core.formatter.comment.format_line_comment': 'enabled',
        \ 'eclipse.jdt.ls.core.formatter.comment.format_block_comment': 'enabled'
        \ }
    ]]
    require("jdtls").start_or_attach(config)
  end,
})
