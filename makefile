update_nav_command = -File 'template_update.ps1' 'template.html' '<!--NAVIGATION TEMPLATE-->' 'TEMPLATE_'
update_header_command = -File 'template_update.ps1' 'template.html' '<!--HEADER TEMPLATE-->' 'TEMPLATE_'

update_all: template_update.ps1 template.html index.html projects.html about.html projects/navbar/index.html
	powershell Set-ExecutionPolicy -Scope CurrentUser Unrestricted
	
	stop_server.bat

	powershell $(update_header_command) 'Home' 'index.html'
	powershell $(update_nav_command) 'active,inactive,inactive' 'index.html'

	powershell $(update_header_command) 'Projects' 'projects.html'
	powershell $(update_nav_command) 'inactive,active,inactive' 'projects.html'

	powershell $(update_header_command) 'About' 'about.html'
	powershell $(update_nav_command) 'inactive,inactive,active' 'about.html'
	
	powershell $(update_header_command) 'Projects - Navigation Bar' 'projects/navbar/index.html'
	powershell $(update_nav_command) 'inactive,active,inactive' 'projects/navbar/index.html'
	
	powershell $(update_header_command) 'Projects - Creating Github Repository' 'projects/github/index.html'
	powershell $(update_nav_command) 'inactive,active,inactive' 'projects/github/index.html'

	powershell $(update_header_command) 'Projects - TinyWebServer' 'projects/tinywebserver/index.html'
	powershell $(update_nav_command) 'inactive,active,inactive' 'projects/tinywebserver/index.html'

	powershell $(update_header_command) 'Projects - CA1a (How Stuff Works)' 'projects/ca1a/index.html'
	powershell $(update_nav_command) 'inactive,active,inactive' 'projects/ca1a/index.html'
	restart_server.bat


