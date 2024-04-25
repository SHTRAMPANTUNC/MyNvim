return {
    cmd = {
        "clangd",
        "--clang-tidy",
        "--background-index",
        "--pch-storage=memory",
        "--header-insertion=never",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--compile-commands-dir=./build",
    },
    init_options = {
        usePlaceholders = true,
        restartAfterCrash = true,
        completeUnimported = true,
        clangdFileStatus = true,
        semanticHighlighting = true,
        fallbackFlags = { "-std=c++20", "-Wextra", "-Wall", "-Wpedantic" }
    },
    filetypes = { "c", "cpp", "h" },
}
