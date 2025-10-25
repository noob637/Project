# Important Variables
$searchFolders = @(
    "$env:USERPROFILE\Desktop",
    "$env:USERPROFILE\Downloads",
    "$env:USERPROFILE\Documents",
    "$env:USERPROFILE\Music",
    "$env:USERPROFILE\Pictures",
    "$env:USERPROFILE\Videos"
)

$jsonfile = $null

foreach ($folder in $searchFolders) {
    $found = Get-ChildItem -Path $folder -Recurse -File -Filter "extension&path.json" -ErrorAction SilentlyContinue |
             Select-Object -First 1
    if ($found) {
        try {
            $jsonfile = Get-Content -Path $found.FullName -Raw | ConvertFrom-Json
            break
        } catch {}
    }
}

if (-not $jsonfile) {
    $jsonfile = [PSCustomObject]@{ path = ""; extension = "" }
}
# Main
Clear-Host
$Host.UI.RawUI.ForegroundColor = 'green'
Add-Type -AssemblyName System.Windows.Forms
Write-Host "Choose The Mod." -ForegroundColor Blue
Write-Host "1. File Opener / 2. File Editor / 3. Taskkill & TaskSearch" -ForegroundColor Green
$answer = Read-Host "Enter Mod 1 / 2" 

function Task {
    C:\Users\Lenovo\Desktop\project1\taskfinder.bat
}
function FileEditor {
    Clear-Host
    Write-Host Select a File! -ForegroundColor Green
    $openfile = New-Object System.Windows.Forms.OpenFileDialog
    $openfile.InitialDirectory = [Environment]::GetFolderPath("Desktop")
    $openfile.Filter = "All files (*.*)|*.*"
    if ($openfile.ShowDialog() -eq "OK") {
        $Path = $openfile.FileName
            Write-Host "Type " -ForegroundColor Green -NoNewline; Write-Host "DCAF " -ForegroundColor Red -NoNewline; Write-Host "To Dont Change Anything" -ForegroundColor Green
    Write-Host "Editing: " -ForegroundColor Green -NoNewline; Write-Host "$Path" -ForegroundColor Red
    Write-Host "DCAF " -ForegroundColor Red -NoNewline; Write-Host "Was Set To Clip Board" -ForegroundColor Green
    $format = Read-Host "Change Format To"
    if ($null -ne $format -and $format.ToLower() -ne "dcaf") {
        $format = $format -replace "\.", ""
        $ext = ".$format"
        $base = [System.IO.Path]::GetFileNameWithoutExtension($Path)
        $dir = Split-Path $Path
        $newPath = Join-Path $dir "$base$ext"
        Rename-Item -Path $Path -NewName (Split-Path $newPath -Leaf)
        $Path = $newPath
        Write-Host "Changed format to $ext" -ForegroundColor Green
    } else {
        Write-Host "Did not change format" -ForegroundColor Red
    }
    $name = Read-Host "Change Name To"
    if ($null -ne $name -and $name.ToLower() -ne "dcaf") {
        $ext = [System.IO.Path]::GetExtension($Path)
        $dir = Split-Path $Path
        $newPath = Join-Path $dir "$name$ext"
        Rename-Item -Path $Path -NewName (Split-Path $newPath -Leaf)
        $Path = $newPath
        Write-Host "Changed name to $name$ext" -ForegroundColor Green
    } else {
        Write-Host "Did not change name" -ForegroundColor Red
    }
    $value = Read-Host "Change Value To"
    if ($value -eq "DCAF".ToLower()) {
        Write-Host "Did not change value" -ForegroundColor Red
    } else {
        Set-Content -Path $Path -Value $value
        Write-Host "Changed  $Path Value To $value" -ForegroundColor Green
    }
    } else {
        Write-Host "No file Selected." -ForegroundColor Red
    }
    Read-Host "Press Enter To Exit..."
}

function FileOpener {
    Clear-Host
    Write-Host Select a File! -ForegroundColor Green
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.InitialDirectory = [Environment]::GetFolderPath("Desktop")
    $OpenFileDialog.Filter = "All files (*.*)|*.*"
    if ($OpenFileDialog.ShowDialog() -eq "OK") {
        $Path = $OpenFileDialog.FileName
    } else {
        Write-Host "No file selected. Exiting..." -ForegroundColor Red
    }
    $Host.UI.RawUI.ForegroundColor = 'yellow'
    $extension = Read-Host "Enter Extension You Want To Open $Path With"
    if (Test-Path $Path) {
        $jsonfile.path = $Path
        $jsonfile.extension = $extension
        if ([System.IO.File]::Exists("$env:userprofile\desktop\fileopener.$($jsonfile.$extension)")) {
            $content = Get-Content -Raw $jsonfile.path
            $newfile1 = New-Item -Path "$env:userprofile\desktop\" -Name "$(Get-Random).$($jsonfile.extension)" -Value $content
            Start-Process $newfile1
            Start-Sleep 1
            Remove-Item $newfile1
        } else {
            $content = Get-Content -Raw $jsonfile.path
            $newfile2 = New-Item -Path "$env:userprofile\desktop\" -Name "fileopener.$($jsonfile.extension)" -Value $content
            Start-Process $newfile2
            Start-Sleep 1
            Remove-Item $newfile2
        }
    } else {
        Write-Host "Path Is Invalid: $Path" -ForegroundColor Red
    }
}

if ($answer -eq "1") {
    FileOpener
}
if ($answer -eq "2") {
    FileEditor    
}
if ($answer -eq "3") {
    Task
}