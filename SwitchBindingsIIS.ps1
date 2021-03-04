##
# Move bindings from live to staging making the staging live
 $FromSite ="Exmaple Live"; $ToSite ="Example Staging"

 # Website IP eg. "10.60.110.160" or "*"
 $hostIp = "10.10.10.10"
 

write-host  "===== move bindings from : $FromSite to $ToSite" 
"===== before ====="
"-- $FromSite--"
Get-WebBinding $FromSite | format-table -property bindingInformation , protocol
"-- $ToSite--"
Get-WebBinding $ToSite | format-table -property bindingInformation , protocol


 Remove-WebBinding -Name $FromSite -Protocol "http" -Port 80 -IPAddress $hostIp  -HostHeader "www.example.com"  
 New-WebBinding    -Name $ToSite   -Protocol "http" -Port 80 -IPAddress $hostIp  -HostHeader "www.example.com"  

 Remove-WebBinding -Name $FromSite -Protocol "http" -Port 80 -IPAddress $hostIp  -HostHeader ""  
 New-WebBinding    -Name $ToSite   -Protocol "http" -Port 80 -IPAddress $hostIp  -HostHeader ""  

 Remove-WebBinding -Name $FromSite -Protocol "https" -Port 443 -IPAddress $hostIp  -HostHeader ""  
 New-WebBinding    -Name $ToSite   -Protocol "https" -Port 443 -IPAddress $hostIp  -HostHeader ""  
 

"===== after ====="
"-- $FromSite--"
Get-WebBinding $FromSite | format-table -property bindingInformation , protocol
"-- $ToSite--"
Get-WebBinding $ToSite | format-table -property bindingInformation , protocol