powershell -Command "Get-Process TinyWebServer -ErrorAction SilentlyContinue | Stop-Process; exit"
powershell -Command "cd..; Start-Process engacad/TinyWebServer.exe"