
function gitMuteList {
	git ls-files -v | Select-String "^[a-z]" -CaseSensitive
}

function gitMute {
	git update-index --assume-unchanged $args[0]
}

function gitUnMute {
	git update-index --no-assume-unchanged $args[0]
}

function listFiles([string] $file){

    $(
        gitMuteList
    )| foreach {
        $found = $_ -match "^[a-z]\s+(.*?)$"
        if ($found -and $matches[1].StartsWith($file, "CurrentCultureIgnoreCase")){
            @($matches[1])
        }elseif ($file -eq '' -and $matches.count -ge 1 ){
            @($matches[1])
        }
    }

}


if ((Test-Path Function:\TabExpansion) -and (-not(Test-Path Function:\TabExpansionBackup))) {
    Write-Host 'Renaming TabExpansion function to TabExpansionBackup'
    Rename-Item Function:\TabExpansion TabExpansionBackup
}

function TabExpansion([string]$line, [string]$lastWord){
    $lastBlock = [regex]::Split($line, '[|;]')[-1].TrimStart()
    if ( $lastBlock -match "^git-mute-off\b"){

		listFiles $lastWord
		
	}
     
	if (Test-Path Function:\TabExpansionBackup) { 
		TabExpansionBackup $line $lastWord
	}

}



