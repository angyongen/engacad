update_nav_command = -File 'template_update.ps1' 'template.html' '<!--NAVIGATION TEMPLATE-->' 'TEMPLATE_'
update_header_command = -File 'template_update.ps1' 'template.html' '<!--HEADER TEMPLATE-->' 'TEMPLATE_'

update_all: template_update.ps1 template.html index.html projects.html about.html projects/navbar/index.html
	powershell Set-ExecutionPolicy -Scope CurrentUser Unrestricted
	powershell -Command "Get-Process TinyWebServer -ErrorAction SilentlyContinue | Stop-Process; exit"
	powershell $(update_header_command) 'Home' 'index.html'
	powershell $(update_nav_command) 'active,inactive,inactive' 'index.html'

	powershell $(update_header_command) 'Projects' 'projects.html'
	powershell $(update_nav_command) 'inactive,active,inactive' 'projects.html'

	powershell $(update_header_command) 'About' 'about.html'
	powershell $(update_nav_command) 'inactive,inactive,active' 'about.html'
	
	powershell $(update_header_command) 'Projects - Navigation Bar' 'projects/navbar/index.html'
	powershell $(update_nav_command) 'inactive,active,inactive' 'projects/navbar/index.html'
	powershell -Command "cd..; Start-Process engacad/TinyWebServer.exe"

