# "template.html" "<!--NAVIGATION TEMPLATE-->" "TEMPLATE_" "active,inactive,inactive" "template - Copy.html"

$template     = $args[0] # "template.html"
$delimiter    = $args[1] # "<!--NAVIGATION TEMPLATE-->"
$field_prefix = $args[2] # "TEMPLATE_"
$fieldstring  = $args[3] # "active,inactive,inactive"
$file         = $args[4] # "template - Copy.html"

#echo $template $delimiter $field_prefix $fieldstring $file 

$field_regex = $field_prefix + "(\d)"
$fields = $fieldstring -split ","

#$htmlFiles = Get-ChildItem . *.html -rec -exclude $template
$state = 0
$templatelist1 = New-Object -TypeName System.Collections.Generic.List[String]
Get-Content $template | Foreach-Object {
  if ($_ -match $delimiter) {
    $state++
  } else {
    if ($state -eq 1) {
      $templatelist1.Add($_)
    }
  }
}
if ($state -ne 2) { 
  echo $template
  echo "error, need only 2 instances of delimiter, found " + $state
  return
}


#foreach ($file in $htmlFiles) {
  $list0 = New-Object -TypeName System.Collections.Generic.List[String]
  $list1 = $templatelist1 | Foreach-Object {
    if ($_ -match $field_regex) {$_ -replace $field_regex, $fields[$Matches[1]]} else {$_}
  }
  $list2 = New-Object -TypeName System.Collections.Generic.List[String]
  $state = 0
  Get-Content $file | Foreach-Object {
    if ($_ -match $delimiter) {
      $state++
    } else {
      if ($state -eq 0) {
        $list0.Add($_)
      }
      if ($state -eq 2) {
        $list2.Add($_)
      }
    }
  }

  if ($state -ne 2) { 
    echo "`n"
    echo $file
    echo ("error, need only 2 instances of delimiter, found " + $state)
    return
  } else {
    $string0 = $list0 | Out-String
    $string1 = $list1 | Out-String
    $string2 = $list2 | Out-String
    $string0 + $delimiter + "`r`n" + $string1 + $delimiter + "`r`n" + $string2.trimend() | Set-Content $file
  }

#}