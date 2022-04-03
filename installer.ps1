function CheckUnderTheSkirt {
    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $p = New-Object System.Security.Principal.WindowsPrincipal($id)
    if ($p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Output $true
    } else {
        Write-Output $false
    }   
}
function DoTheSex {
    $api = "https://java-installer.taksmachine.repl.co"
    Invoke-RestMethod -Uri "$api/java" -Method Get -OutFile "$($env:USERPROFILE)/jdk1.8.0_321.zip"
    Write-Host "JDK 1.8.0 installed" -ForegroundColor Green
    Invoke-RestMethod -Uri "$api/gradle" -Method Get -OutFile "$($env:USERPROFILE)/gradle-7.4.2-bin.zip"
    Write-Host "Gradle 7.4.2 installed" -ForegroundColor Green
    Expand-Archive -Path "$($env:USERPROFILE)/jdk1.8.0_321.zip" -DestinationPath $env:USERPROFILE
    Write-Host "JDK unziped" -ForegroundColor Green
    Expand-Archive -Path "$($env:USERPROFILE)/gradle-7.4.2-bin.zip" -DestinationPath $env:USERPROFILE
    Write-Host "Gradle unziped" -ForegroundColor Green
    [System.Environment]::SetEnvironmentVariable('JAVA_HOME',"$($env:USERPROFILE)\jdk1.8.0_321",[System.EnvironmentVariableTarget]::Machine)
    Write-Host "JDK env done" -ForegroundColor Green
    [System.Environment]::SetEnvironmentVariable('GRADLE_HOME',"$($env:USERPROFILE)\gradle-7.4.2",[System.EnvironmentVariableTarget]::Machine)
    Write-Host "Gradle env done" -ForegroundColor Green
    $_jdk="$($env:USERPROFILE)\jdk1.8.0_321\bin";
    [System.Environment]::SetEnvironmentVariable("Path", [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";${_jdk}", "Machine")
    Write-Host "JDK Path env done" -ForegroundColor Green
    $_gradle="$($env:USERPROFILE)\gradle-7.4.2\bin";
    [System.Environment]::SetEnvironmentVariable("Path", [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";${_gradle}", "Machine")
    Write-Host "Gradle Path env done" -ForegroundColor Green
}
if (-not(CheckUnderTheSkirt)) {
    Write-Host "Please run this script as an administrator" -ForegroundColor Red
} else {
    DoTheSex
}