return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = {
        sources = {
          explorer = {
            -- Schließt den Explorer automatisch, sobald eine Datei ausgewählt/geöffnet wird
            auto_close = true,

            -- Optional, aber oft gewünscht: Startet direkt im Suchmodus (Input-Feld)
            -- focus = "input",
          },
        },
      },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
}
