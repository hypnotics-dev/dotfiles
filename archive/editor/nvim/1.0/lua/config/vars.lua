return {
    sys = {
        confPath = "~/.config/nvim/",
        deps = {
            arch = {
                "fd",
                "ripgrep",
                "luarocks",
                "ttf-jetbrains-mono",
                "curl",
                "unzip",
                "tar",
                "gzip",
                "gcc",
                "gcc-libs",
            },
            void = {

            },
        },
    },
    hw = require("config.hardware"),

}
