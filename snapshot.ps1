# Get VM 
#Hostname to be unique 
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$VmNames = Get-Content $scriptPath\snapshotVMs.txt # Input File
foreach ($VmName in $VmNames) {

    $vm = get-azvm -Name $VmName 
    if($null -eq $vm){
        Write-Error "Error retriving VM : $VMName "
        continue
    }
else {
$VmResourceGroup = $Vm.ResourceGroupName

#VM Snapshot

Write-Output "VM $($vm.name) OS Disk Snapshot Begin"
$snapshotdisk = $vm.StorageProfile
 

    $OSDiskSnapshotConfig = New-AzSnapshotConfig -SourceUri $snapshotdisk.OsDisk.ManagedDisk.id -CreateOption Copy -Location $vm.Location -OsType $snapshotdisk.OsDisk.OsType -Tag @{"AutoSnap"="True"}
    $snapshotNameOS = "$($snapshotdisk.OsDisk.Name)_snapshot_$(Get-Date -Format ddMMyy)"

    # OS Disk Snapshot

        try {
            New-AzSnapshot -ResourceGroupName $VmResourceGroup -SnapshotName $snapshotNameOS -Snapshot $OSDiskSnapshotConfig -ErrorAction Stop
        } catch {
            $_
        }
 
        Write-Output "VM $($vm.name) OS Disk Snapshot End"

# Data Disk Snapshots 

Write-Output "VM $($vm.name) Data Disk Snapshots Begin"

$dataDisks = ($snapshotdisk.DataDisks).name

    foreach ($datadisk in $datadisks) {

        $dataDisk = Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $datadisk

        Write-Output "VM $($vm.name) data Disk $($datadisk.Name) Snapshot Begin"

        $DataDiskSnapshotConfig = New-AzSnapshotConfig -SourceUri $dataDisk.Id -CreateOption Copy -Location $vm.Location -Tag @{"AutoSnap"="True"}
        $snapshotNameData = "$($datadisk.name)_snapshot_$(Get-Date -Format ddMMyy)"

            New-AzSnapshot -ResourceGroupName $VmResourceGroup -SnapshotName $snapshotNameData -Snapshot $DataDiskSnapshotConfig -ErrorAction Stop
      
        Write-Output "VM $($vm.name) data Disk $($datadisk.Name) Snapshot End"   
        }
    Write-Output "VM $($vm.name) Data Disk Snapshots End" 
    }

}