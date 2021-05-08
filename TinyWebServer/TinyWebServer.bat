@set script=^
Write-Host; ^
Write-Host Working Directory: $PWD; ^
$host.ui.RawUI.WindowTitle = 'TinyWebServer : ' + $PWD; ^
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
	$localURL = Convert-Path ('TmpPsDrive:' + $URL); ^
	if ($localURL) { ^
		$mime = [System.Web.MimeMapping]::GetMimeMapping($localURL); ^
		$Context.Response.ContentType = $mime; ^
		$FileStream = New-Object IO.FileStream $localURL, 'Open'; ^
		$FileStream.CopyTo($Context.Response.OutputStream); ^
		$FileStream.Close(); ^
	} ^
	$Context.Response.Close(); ^
	Write-Host 'Served URL' $localURL; ^
}

powershell -Command "%script%"
pause
