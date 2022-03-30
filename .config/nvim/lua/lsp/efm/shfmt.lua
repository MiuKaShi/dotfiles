return {
    formatCommand = 'shfmt -filename ${INPUT}',
    formatStdin = true,
    lintCommand = 'shellcheck -f gcc -x',
    lintSource = 'shellcheck'
}
