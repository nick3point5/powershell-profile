New-Alias mongo "C:\Program Files\MongoDB\Server\4.4\bin\mongo"
New-Alias mongod "C:\Program Files\MongoDB\Server\4.4\bin\mongod"
New-Alias postgres "C:\Program Files\PostgreSQL\13\scripts\runpsql.bat"

function exp {
    explorer.exe .   
}

function site {
    Copy-Item "C:\Users\ktt44\code\libraries\site\*" -Destination "." -Recurse
}

function meen {
    Copy-Item "C:\Users\ktt44\code\libraries\meen\*" -Destination "." -Recurse
}

function pg {
    param (
        $DB,
        $file
    )
    if ($file) {
        psql -f ($file) "user=postgres password=postgres dbname=$($DB)" 
    }elseif ($DB) {
        psql "user=postgres password=postgres dbname=$($DB)" 
    }else {
        psql "user=postgres password=postgres" 
    }
}

function py.env {
    py -m venv .env
    .env/Scripts/activate
}

function py.run {
    py manage.py runserver
}

function delete {
	param (
		$locked
	)

	$rootpath = Get-Location
	if ($locked[0] -match "^\.{1}") {
		$locked = $locked.substring(1)
		$filepath = $rootpath.tostring() + $locked
		$filepath = $filepath.Replace("\", "\\")
	}
	else{
		return Write-Output "incorrect path"
	}

	if(Test-Path -Path $filepath) {
		$handle = handle $filepath
		$split = $handle -Split "pid: "
		$P  =  -split $split[1]
		Stop-Process -Id $P[0] -Confirm -PassThru
	}			

	if ($filepath -match "\.[A-z]*$") {		
		Remove-Item -Path $filepath
	}
	else { 
		Remove-Item -Path $filepath -Recurse
	}
		
	
}

