local jdtls_ok, _ = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify "JDTLS not found, install with `:LspInstall jdtls`"
  print "JDTLS not found, install with `:LspInstall jdtls`"
  return
end

local java_utils = require("configs.lsp.custom.java.utils")
local spring = require("configs.lsp.custom.java.spring")
local configurations = require("configs.lsp.custom.java.configuration")
local test = require("configs.lsp.custom.java.test")
local java_dap = require("configs.lsp.custom.java.dap")
local home = vim.fn.expand("$HOME")
local general_opts = require("configs.lsp.custom.general-opts").default

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java" },
  callback = function()
    -- LSP capabilities
    local jdtls = require("jdtls")

    local default_capabilities = vim.lsp.protocol.make_client_capabilities()
    default_capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local capabilities = general_opts.capabilities
    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    local launcher, os_config, lombok = java_utils.get_jdtls()
    local workspace_dir = java_utils.get_workspace()
    local bundles = java_utils.get_bundles()

    local on_attach = function(client, bufnr)
      general_opts.on_attach(client, bufnr)
      --
      -- require("lsp_signature").on_attach({
      --   bind = true,
      --   padding = '',
      --   handler_opts = {
      --     border = "rounded"
      --   },
      -- }, bufnr)

      jdtls.setup_dap({
        config_overrides = {
          noDebug = false
        },
        hotcodereplace = "auto"
      })
      require("jdtls.dap").setup_dap_main_class_configs()
      -- require("jdtls.setup").add_commands()

      print("workspace_dir: " .. workspace_dir)
      print("launcher: " .. launcher)
      print("os_config: " .. os_config)
      print("lombok: " .. lombok)

      java_utils.registerKeyMappings(bufnr)
      configurations.map_functions()
      spring.map_functions()
      java_dap.keymap_setup()
      test.map_functions()

      local root = require("jdtls.setup").find_root({ "pom.xml" })
      print("root: " .. root)
      vim.keymap.set("n", "<leader>run", function()
        -- raw_run()
        java_utils.maven_run()
      end)

      vim.api.nvim_create_autocmd("java-fmt", {
        { "BufWritePre", "*.java", "undojoin | Neoformat" },
      })
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   pattern = { "*.java" },
      --   callback = function()
      --     local _, _ = pcall(vim.lsp.codelens.refresh)
      --   end,
      -- })

      vim.cmd([[
      set foldmethod=syntax
      set foldenable
      syn region foldBraces start=/\{/ end=/\}/ transparent fold keepend extend
      syn region foldJavadoc start=+/\*+ end=+\*/+ transparent fold keepend extend
      ]])
    end

    local config = {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
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

      root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
      capabilities = capabilities,
      on_attach = on_attach,

      settings = {
        java = {
          home = home .. "/workspace/program/java-sdk/main-sdk",
          autobuild = { enabled = false },
          signatureHelp = { enabled = true },
          contentProvider = { preferred = "fernflower" },
          saveActions = {
            organizeImports = false,
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
            runtimes = {
              {
                name = "JavaSE-17",
                path = home .. "/workspace/program/java-sdk/zulu17",
              },
            }
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
            includeOverridden = true,
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
              url = home .. "/.config/mvim/lang-servers/intellij-java-google-style.xml",
              profile = "GoogleStyle",
            },
          },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
            importOrder = {
              "java",
              "javax",
              "com",
              "org"
            },
          },
        },
      },
      init_options = {
        bundles = bundles,
        extendedClientCapabilities = extendedClientCapabilities,
      },
    }
    vim.cmd([[
    " Enable comment beautification for nvim-jdtls
    let g:jdtls_formatter_config = {
        \ 'eclipse.jdt.ls.core.formatter.comment.format_line_comment': 'enabled',
        \ 'eclipse.jdt.ls.core.formatter.comment.format_block_comment': 'enabled'
        \ }
    ]])
    require("jdtls").start_or_attach(config)
  end,
})

-- vim.env.JAVA_HOME = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
vim.env.JAVA_HOME = home .. "/workspace/program/java-sdk/main-sdk"

local lombok_jar = home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar"
vim.env.JAVA_TOOL_OPTIONS = "-javaagent:" .. lombok_jar

vim.g.jdtls_workspace = {
  data = vim.fn.expand("~/jdtls_data"),
}
