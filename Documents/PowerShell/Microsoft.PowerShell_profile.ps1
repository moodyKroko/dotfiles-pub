if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "PowerShell version is older than 7.0. Profile will not load"
    Exit
}

#change for "robbyrussel.omp.json"
$OhMyPosh = [System.IO.Path]::Combine($HOME, "Documents", "PowerShell", "star.omp.json")
$PowerShell = [System.IO.Path]::Combine($HOME, "Documents", "PowerShell", "Microsoft.PowerShell_profile.ps1")
$Neovim = [System.IO.Path]::Combine($HOME, ".config", "nvim", "init.lua")
$Git = [System.IO.Path]::Combine($HOME, ".gitconfig")

$env:EDITOR = "notepad++"

# Import modules
Import-Module -Name Terminal-Icons
Import-Module PSReadLine
Import-Module PSFzf

## Configure PSReadLine after import
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Chord Tab -Function AcceptSuggestion

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChfordReverseHist 'Ctrl+r'

# Remove and set aliases - grouped for better performance
Remove-Item alias:rm -ErrorAction SilentlyContinue
Remove-Item alias:man -ErrorAction SilentlyContinue

$aliasMap = @{
    'scp' = 'scoop'
    'vim' = 'nvim'
    'grep' = 'findstr'
    'g' = 'git'
    'l' = 'ls'
    #'dot' = 'Invoke-Chezmoi'
    'rm' = 'Invoke-RM'
}
$aliasMap.GetEnumerator() | ForEach-Object { Set-Alias -Name $_.Key -Value $_.Value }

# Optimize function definitions by using a hashtable
$functions = @{
    'cpcb' = { Set-Clipboard }
    'c' = { Clear-Host }
    'gs' = { git status }
    'gd' = { git diff }
    'xop' = { Start-Process . }
    'open' = { Start-Process }
    'll' = { eza -la --git --no-filesize --no-quotes --classify=always --color=always --icons=always --no-symlinks --no-user --group-directories-first --sort name --ignore-glob="*.DAT|*.dat.*|*.DAT*|*.ini" }
    'dot' = { chezmoi @args } # doesnt work
    'clone' = { param($gitRepo) git clone $gitRepo }
    'which' = { param($appName) scoop which $appName }
    'man' = { help -showWindow @args }
    'Invoke-RM' = { Remove-Item @args -Confirm }
    'tig' = { & 'C:\Program Files\Git\usr\bin\tig.exe' }
    'npp' = { & 'C:\Program Files\Notepad++\notepad++.exe'}
    'omp-up' = { winget upgrade JanDeDobbeleer.OhMyPosh -s winget }
    'pconf' = { nvim $PowerShell }
    'vconf' = { nvim $Neovim }
    'gconf' = { nvim $Git }
}

# Register functions efficiently
$functions.GetEnumerator() | ForEach-Object {
    $name = $_.Key
    $value = $_.Value

    if (-not (Test-Path Function:$name)) {
        Set-Item -Path "function:\$name" -Value $value
    }
}

function Invoke-ProfileReload {
    . $PROFILE
}
# Reloading is a bad idea because of aliases...
New-Alias -Name reload -Value Invoke-ProfileReload

function Get-PathElements {
    $delim = ";"

    $env:PATH -split $delim | ForEach-Object {
        Write-Output $_
    }
}
New-Alias -Name path -Value Get-PathElements

# Always keep this as the last line
#oh-my-posh init pwsh --config 'https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/star.omp.json' | Invoke-Expression
oh-my-posh init pwsh --config $OhMyPosh | Invoke-Expression
