# Common Settings =============================================================

# List of dotfiles to create symbolic links for
$DOT_FILES = @(".tigrc", ".gitignore_global", "_vimrc", ".ideavimrc")

foreach ($file in $DOT_FILES) {
    $source = "$HOME\dotfiles\$file"
    $destination = "$HOME\$file"

    if (Test-Path -Path $destination -PathType Leaf -Or (Get-Item $destination).LinkType -eq "SymbolicLink") {
        Write-Output "$file already exists."
    } else {
        New-Item -ItemType SymbolicLink -Path $destination -Target $source | Out-Null
        Write-Output "Made symbolic link $destination"
    }
}

# List of dotfiles to copy
$DOT_FILES_TO_COPY = @(".gitconfig")

foreach ($file_to_copy in $DOT_FILES_TO_COPY) {
    $source = "$HOME\dotfiles\$file_to_copy"
    $destination = "$HOME\$file_to_copy"

    if (Test-Path -Path $destination) {
        Write-Output "$file_to_copy already exists."
    } else {
        Copy-Item -Path $source -Destination $destination
        Write-Output "Made copy $destination"
    }
}
