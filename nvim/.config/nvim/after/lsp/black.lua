return {
  settings = {
    python = {
      formatting = {
        provider = "black",
      },
      black = {
        args = { "--fast" },
        config = true, -- Use pyproject.toml if available
      },
    },
  },
}
