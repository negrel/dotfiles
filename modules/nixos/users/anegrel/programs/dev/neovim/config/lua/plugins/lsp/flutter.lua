local lsp = require("plugins.lsp")
require("flutter-tools").setup({
		decorations = {
				statusline = {
						-- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
						-- this will show the current version of the flutter app from the pubspec.yaml file
						app_version = true,
						-- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
						-- this will show the currently running device if an application was started with a specific
						-- device
						device = true,
				},
		},
		widget_guides = {
				enabled = true,
		},
		lsp = {
				color = { enabled = true },
				on_attach = lsp.on_attach,
				capabilities = lsp.capabilities,
				settings = {
						showTodos = false,
						completeFunctionCalls = true,
						renameFilesWithClasses = "prompt",
						enableSnippets = true,
				},
		},
})
