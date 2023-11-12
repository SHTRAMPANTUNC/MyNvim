return {
    cmd = {
        "clangd",
        "--completion-style=detailed",
        "--background-index",
        "--pch-storage=memory",
        "--header-insertion=never",
        "--log=verbose",
        "--compile-commands-dir=./build",
    },
    init_options = {
        usePlaceholders = false,
        completeUnimported = true,
        clangdFileStatus = true
    },
    filetypes = { "c", "cpp", "h", "hpp" },
    init_option = { fallbackFlags = { "-std=c++17" } },
}
