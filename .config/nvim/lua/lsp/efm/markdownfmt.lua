return {
    formatCommand = 'prettier --stdin-filepath ${INPUT} ',
    formatStdin = true,
    lintCommand = 'markdownlint -s -c ${HOME}/.config/.markdownlintrc',
    lintStdin = true,
    lintFormats = {'%f:%l %m', '%f:%l:%c %m', '%f: %l: %m'}
}
