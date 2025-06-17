local M = {
  ["*.js"] = {
    files = { "%1.js.map", "%1.min.js", "%1.min.js.map" },
    pattern = "(.*)%.js$",
  },
  ["*.ts"] = {
    files = { "%1.js", "%1.d.ts", "%1.js.map", "%1.test.ts", "%1.spec.ts" },
    pattern = "(.*)%.ts$",
  },
  ["*.css"] = {
    files = { "%1.css.map", "%1.min.css", "%1.min.css.map" },
    pattern = "(.*)%.css$",
  },
  ["*.jsx"] = {
    files = { "%1.js", "%1.js.map" },
    pattern = "(.*)%.jsx$",
  },
  ["*.tsx"] = {
    files = { "%1.js", "%1.js.map", "%1.d.ts", "%1.test.tsx", "%1.spec.tsx" },
    pattern = "(.*)%.tsx$",
  },
  ["*.cjs"] = {
    files = { "%1.cjs.map" },
    pattern = "(.*)%.cjs$",
  },
  ["*.mjs"] = {
    files = { "%1.mjs.map" },
    pattern = "(.*)%.mjs$",
  },
}

return M
