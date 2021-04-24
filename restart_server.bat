powershell -Command "Get-Process TinyWebServer -ErrorAction SilentlyContinue | Stop-Process; exit"
cd ..
powershell -Command "Start-Process engacad/TinyWebServer"