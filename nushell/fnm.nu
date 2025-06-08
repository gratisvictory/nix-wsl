use std "path add"
fnm env --json | from json | load-env
path add ($env.FNM_MULTISHELL_PATH | path join "bin")
