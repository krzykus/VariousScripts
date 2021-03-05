param ([Parameter(Mandatory)] $FromSite,
	   [Parameter(Mandatory)] $ToSite,
	   [Parameter(Mandatory)] $HostIP,
	   [Parameter(Mandatory)] $LiveURL,
	   [Parameter(Mandatory)] $ToURL,
	   [Parameter(Mandatory)] $IncludeTLS)

##
# Move bindings from live to staging making the staging live
 #$FromSite ="Exmaple Live"; $ToSite ="Example Staging"

 # Website IP eg. "10.60.110.160" or "*"
 #$hostIp = "10.10.10.10"
 
 #$FromURL = "www.example.com" 
 #$ToURL = "staging.example.com"
 
 #should it include 443 port bindings, need to read it from input
 #$IncludeTLS = "y"

write-host  "===== move bindings from : $FromSite to $ToSite" 
"===== before ====="
"-- $FromSite--"
Get-WebBinding $FromSite | format-table -property bindingInformation , protocol
"-- $ToSite--"
Get-WebBinding $ToSite | format-table -property bindingInformation , protocol

# Move live bindings from live to staging
 Remove-WebBinding -Name $FromSite -Protocol "http" -Port 80 -IPAddress $hostIp  -HostHeader $liveURL  
 New-WebBinding    -Name $ToSite   -Protocol "http" -Port 80 -IPAddress $hostIp  -HostHeader $liveURL

 if($include443 -eq "y")
 {
	Remove-WebBinding -Name $FromSite -Protocol "https" -Port 443 -IPAddress $hostIp  -HostHeader $liveURL  
	New-WebBinding    -Name $ToSite   -Protocol "https" -Port 443 -IPAddress $hostIp  -HostHeader $liveURL
 }

# Move staging bindings from staging to live
 Remove-WebBinding -Name $ToSite -Protocol "http" -Port 80 -IPAddress $hostIp  -HostHeader $stagingURL
 New-WebBinding    -Name $FromSite   -Protocol "http" -Port 80 -IPAddress $hostIp  -HostHeader $stagingURL
 
 if($include443 -eq "y")
 {
	Remove-WebBinding -Name $ToSite -Protocol "http" -Port 443 -IPAddress $hostIp  -HostHeader $stagingURL
	New-WebBinding    -Name $FromSite   -Protocol "http" -Port 443 -IPAddress $hostIp  -HostHeader $stagingURL
 }

"===== after ====="
"-- $FromSite--"
Get-WebBinding $FromSite | format-table -property bindingInformation , protocol
"-- $ToSite--"
Get-WebBinding $ToSite | format-table -property bindingInformation , protocol