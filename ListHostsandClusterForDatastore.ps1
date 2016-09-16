Add-PSSnapin VMware.VimAutomation.Core

#Check status of vCenter server and connect if disconnected
if($global:DefaultVIServer.IsConnected){
    Write-Host "Connected to vCenter"
    }else{
    Connect-VIServer (Read-Host "Enter vCenter Server")}


#prompt for Datastore to investigate
$ds = Get-Datastore (Read-Host "Enter Datastore")

#Get Disk Identifier for a given Datastore Name#
$ds.ExtensionData.Info.Vmfs.Extent.DiskName

#Get Hosts accessing Datastore and output to a CSV File#
$ds.ExtensionData.Host.Key | Get-VIObjectByVIView | Select Name, @{N=”Cluster”;E={Get-Cluster -VMHost $_}}| Export-CSV $ds-Hosts.csv
$Filepath = Get-Location
Write-Host File $ds-Hosts.csv written to $Filepath.Path