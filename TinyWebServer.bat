@set script=^
Write-Host; ^
Write-Host Working Directory: $PWD; ^
Add-Type -AssemblyName System.Web; ^
$listener = New-Object System.Net.HttpListener; ^
$prefix = 'http://localhost:8080/'; ^
$listener.Prefixes.Add($prefix); ^
Write-Host 'Prefix Registered:' $prefix; ^
$listener.Start(); ^
New-PSDrive -Name TmpPsDrive -PSProvider FileSystem -Root $PWD.Path; ^
while ($listener.IsListening) { ^
	Write-Host; ^
	Write-Host 'Waiting for connection' ; ^
	$Context = $listener.GetContext(); ^
	Write-Host 'Connected to ' $Context.Request.RemoteEndPoint.ToString(); ^
	$URL = $Context.Request.Url.LocalPath; ^
	Write-Host 'Requested URL' $URL; ^
	if ($URL -eq '/') {$URL = '/index.html';} ^
	$localURL = 'TmpPsDrive:' + $URL; ^
	$Content = Get-Content -Encoding Byte -Path $localURL; ^
	if ($Content) { ^
		$mime = [System.Web.MimeMapping]::GetMimeMapping($localURL); ^
		$Context.Response.ContentType = $mime; ^
		$Context.Response.OutputStream.Write($Content, 0, $Content.Length); ^
	} ^
	$Context.Response.Close(); ^
	Write-Host 'Served URL' $localURL; ^
}

powershell -Command "%script%"
pause
