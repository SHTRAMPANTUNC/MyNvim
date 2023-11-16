return {
    cmd = {
        "clangd",
        "--clang-tidy",
        "--background-index",
        "--pch-storage=memory",
        "--fallback-style=llvm",
        "--header-insertion=never",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--compile-commands-dir=./build",
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true
    },
    filetypes = { "c", "cpp", "h", "hpp" },
    init_option = { fallbackFlags = { "-std=c++17" } },
}
