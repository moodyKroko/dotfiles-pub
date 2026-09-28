if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "PowerShell version is older than 7.0. Profile will not load"
    Exit
}

#change for "robbyrussel.omp.json"
# $OhMyPosh = [System.IO.Path]::Combine($HOME, "Documents", "PowerShell", "robbyrussel.omp.json")
$OhMyPosh = [System.IO.Path]::Combine($HOME, "Documents", "PowerShell", "star.omp.json")

$PowerShell = [System.IO.Path]::Combine($HOME, "Documents", "PowerShell", "Microsoft.PowerShell_profile.ps1")
$Neovim = [System.IO.Path]::Combine($HOME, ".config", "nvim", "init.lua")
$Git = [System.IO.Path]::Combine($HOME, ".gitconfig")

$env:EDITOR = "notepad++"

$env:EZA_CONFIG_DIR = "$env:USERPROFILE\.config\eza"

# Import modules
Import-Module -Name Terminal-Icons
Import-Module PSReadLine
Import-Module PSFzf

## Configure PSReadLine after import
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Chord Tab -Function AcceptSuggestion

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Remove and set aliases - grouped for better performance
#Remove-Item alias:rm -ErrorAction SilentlyContinue
Remove-Item alias:man -ErrorAction SilentlyContinue
Remove-Item alias:reload -ErrorAction SilentlyContinue
Remove-Item alias:path -ErrorAction SilentlyContinue

# Optimize function definitions by using a hashtable
$functions = @{
    # app remaps
    'scp' = 'scoop'
    'vim' = 'nvim'
    'lg' = 'lazygit'
    'grep' = 'findstr'
    'g' = 'git'
    'ld' = 'lazydocker'
    'l' = 'ls'
    'pn' = 'pnpm'
    'cat' = 'bat'
    #'dot' = 'Invoke-Chezmoi'
    #'rm' = 'Invoke-RM'

    # sys remaps
    'cpcb' = { Set-Clipboard }
    'c' = { Clear-Host }
    'gs' = { git status }
    'gd' = { git diff }
    'xop' = { Start-Process . }
    'open' = { Start-Process }
    'll' = { eza -la --git --no-filesize --no-quotes --classify=always --color=always --icons=always --no-symlinks --no-user --group-directories-first --sort name --ignore-glob="*.DAT|*.dat.*|*.DAT*|*.ini" }
    'la'= { eza --color=always --color-scale-mode=gradient --icons=always --group-directories-first -a }
    'ell'= { eza --color=always --icons=always --git --no-quotes --group-directories-first -a -l --sort name --ignore-glob="*.DAT|*.dat.*|*.DAT*|*.ini" }
    'dot' = { chezmoi @args } # doesnt work
    'clone' = { param($gitRepo) git clone $gitRepo }
    'which' = { param($appName) scoop which $appName }
    'man' = { help -showWindow @args }
    #'Invoke-RM' = { Remove-Item @args -Confirm }
    'tig' = { & 'C:\Program Files\Git\usr\bin\tig.exe' }
    'npp' = { & 'C:\Program Files\Notepad++\notepad++.exe'}
    'omp-up' = { winget upgrade JanDeDobbeleer.OhMyPosh -s winget }
    'pconf' = { nvim $PowerShell }
    'vconf' = { nvim $Neovim }
    'gconf' = { nvim $Git }

    # docker aliases
    'dcu' = { docker compose up }
    'dcd' = { docker compose down }
    'dr' = { docker run }
    'dps' = { docker ps }
    'dpsa' = { docker ps -a }
    'dimg' = { docker images }
    'dex' = { docker exec -it }
    'dstp' = { docker stop }
    'dst' = { docker start }
    'dlg' = { docker logs }
}

# Register functions efficiently
$functions.GetEnumerator() | ForEach-Object {
    $name = $_.Key
    $value = $_.Value

    if ($value -match '\s') {
        Invoke-Expression "function global:$name { $value `@Args }"
      } else {
          Set-Alias -Name $name -Value $value -Scope Global -Option AllScope -ErrorAction SilentlyContinue
        }
}

# remove items 
function Remove-ItemsRecursivelyForce {
  [CmdletBinding()]
  param(
      [Parameter(ValueFromRemainingArguments = $true)]
      $Path
  )
  if ($pscmdlet.ShouldContinue("Delete '$Path' and all contents?", "Confirm")) {
      Remove-Item -Path $Path -Recurse -Force
    }
  }
New-Alias -Name rmrf -Value Remove-ItemsRecursivelyForce

function Get-PathElements {
    $delim = ";"

    $env:PATH -split $delim | ForEach-Object {
        Write-Output $_
    }
}
New-Alias -Name path -Value Get-PathElements

$Host.UI.RawUI.WindowTitle = "PowerShell"

# Always keep this as the last line
#oh-my-posh init pwsh --config 'https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/star.omp.json' | Invoke-Expression
oh-my-posh init pwsh --config $OhMyPosh | Invoke-Expression
