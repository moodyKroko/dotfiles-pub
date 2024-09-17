# Load prompt config
$prompt_theme = [System.IO.Path]::Combine($HOME, "Documents", "PowerShell", "robbyrussel.omp.json")
oh-my-posh init pwsh --config $prompt_theme | Invoke-Expression

## Icons
Import-Module -Name Terminal-Icons

## PSRreadLine
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
#Set-PSReadLineOption -PredictionViewStyle ListView
#Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
# Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
# Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord Tab -Function AcceptSuggestion
## Fzf (fuzzy file finder)
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChfordReverseHist 'Ctrl+r'

# Undo some alias
Remove-Item alias:rm

# Alias
Set-Alias scp scoop
Set-Alias vim nvim
Set-Alias grep findstr
Set-Alias g git
Set-Alias l ls

function Invoke-Chezmoi {
  chezmoi $args
}

Set-Alias -Name dot -Value Invoke-Chezmoi

function clone {
  param (
    $gitRepo
  )

  git clone $gitRepo
}

function gs {
  git status
}

function gd {
  git diff
}

function which {
  param (
    $appName
  )
  scoop which $appName
}

function tig
{
  'C:\Program Files\Git\usr\bin\tig.exe'
}

#function less
#{
#  'C:\Program Files\Git\usr\bin\less.exe'
#}

function c
{
  Clear-Host
}

# function ll
# {
#   Get-ChildItem -Force -File
# }

function ll {
  eza --color=always --long --git --no-filesize --icons=always --no-user --all --group-directories-first --sort name
}

function rm {
  param (
    $1
  )
  Remove-Item -Confirm $1
}

function xop
{
  Start-Process .
}

function open {
  Start-Process
}

function ..
{
    cd ..
}

# Edit powershell profile
function pconf
{
  $shell_config = [System.IO.Path]::Combine($HOME, "Documents\PowerShell\Microsoft.PowerShell_profile.ps1")
  nvim $shell_config
}

## edit wezterm
function wezconf {
  $wezterm_config = [System.IO.Path]::Combine($HOME, ".wezterm.lua")
  nvim $wezterm_config
}

# edit vim setting
function vconf
{
  $nvim_config = [System.IO.Path]::Combine($HOME, ".config\nvim\init.lua")
  nvim $nvim_config
}

# edit git config
function gconf
{
  $git_conf = [System.IO.Path]::Combine($HOME, ".gitconfig")
  nvim $git_conf
}

function LinkTo {
  param (
    [Parameter(Position=0, Mandatory)][String] $linkType,
    [Parameter(Position=1, Mandatory)][String] $from,
    [Parameter(Position=2, Mandatory)][String] $target
  )
  # TODO: implement the command depending on the type of link
  # New-Item -ItemType $linkType -Path $from -Target $target
  
  # link types
  # HardLink
  # SymbolicLink
  # Junction
  
}

function Compare-Checksum
{
  Param (
    [Parameter(Position=0, Mandatory)][String] $FileHashDir,
    [Parameter(Position=1, Mandatory)][String] $CheckHashDir,
    [Parameter(Position=2)][String] $Algorithm = "SHA256"
  )

  [string] $fileHash = (Get-FileHash $FileHashDir -Algorithm $Algorithm).Hash
  [string] $checkHash = Get-Content $CheckHashDir

  [switch] $result = $fileHash -eq $checkHash

  if (-not $result)
  {
    return Write-Host $result -ForegroundColor Red
  }

  return Write-Host $result -ForegroundColor Green
}

