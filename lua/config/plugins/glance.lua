return {
    "DNLHC/glance.nvim",
    event = "LspAttach",
    config = function ()
        require("glance").setup()
    end
}
