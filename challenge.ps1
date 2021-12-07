
## Query 2 ##

## This challenge is being solved for querying the metadata of an Azure VM. 
## Azure Instance Metadata Service(IMDS) provides information about currently running VM instances. 
## IMDS is a REST API that's available on a well known, non routable IP Address 169.254.169.254
## 
$ImdsServer = "http://169.254.169.254"
$InstanceEndpoint = $ImdsServer + "/metadata/instance"

## Modify the above InstanceEndpoint if we want to filter down to a nested property or specific array element by appending keys. For example
## $InstanceEndpoint = $ImdsServer + "/metadata/instance/network/interface/0"
## would filter to the first element from the Network.interface property

function Query-InstanceEndpoint
{
    $uri = $InstanceEndpoint + "?api-version=2021-02-01"
    $result = Invoke-RestMethod -Method GET -NoProxy -Uri $uri -Headers @{"Metadata"="True"}
    return $result
}

# Make Instance call and print the response
$result = Query-InstanceEndpoint
$result | ConvertTo-JSON -Depth 64

## Another way to achievethe above i.e 1 liner

Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -NoProxy -Uri "http://169.254.169.254/metadata/instance/network/interface/0?api-version=2021-02-01" `
| ConvertTo-Json -Depth 64

## End Query 2 ##

## Query 3 ##
## Below is a nested JSON object. In PowerShell, we can query for a value using the keys as follows:

$jsonObject = @'
{
  "a" : {
      "b": {
        "c": "d"
      }
    }
}
'@
## The ConvertFrom-Json cmdlet converts a JSON formatted string to a custom
## PSCustomObject object that has a property for each field in the JSON string.

$customObject = $jsonObject | ConvertFrom-Json
write-output $customObject.a.b.c

## End Query 3 ##

