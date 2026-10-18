return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
    { "stevearc/dressing.nvim", opts = {} },
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        -- Wir überschreiben hier den Standard-Ollama-Adapter
        ollama = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              -- WICHTIG: Die /v1 URL für Ollama
              url = "http://100.119.146.69:11434/v1",
              api_key = "x", -- Ollama braucht keinen Key, aber der Adapter will einen
            },
            schema = {
              model = { default = "qwen3.6:latest" },
            },
          })
        end,
      },
      strategies = {
        -- Hier nutzen wir nun den Standard-Namen "ollama"
        chat = { adapter = "ollama" },
        inline = { adapter = "ollama" },
        agent = { adapter = "ollama" },
      },
    })
  end,
}
