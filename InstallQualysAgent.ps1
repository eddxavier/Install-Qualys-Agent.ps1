$service = Get-Service -Name QualysAgent -ErrorAction SilentlyContinue
$filepath = "C:\Windows\Temp\QualysIntall\" ## Custom folder where packages should be downloaded to
$filename = "QualysCloudAgent.exe"
$fullfilepath = $filepath + $filename
$SharedFolder = "" ## Shared folder where file is located
$SharedFile = $SharedFolder + $filename
$CustomerID = "" ##CustomerID from your key, from the Platform, go to the Cloud Agent app and locate the Agent Key to get CustomerID
$ActivationID = "" ##ActivationID from your key, from the Platform, go to the Cloud Agent app and locate the Agent Key to get ActivationID
$WebServiceUri = ""
if ($service -eq $null) {
 ## Copies Qualys Agent from shared folder
 function CopyQualysAgent {
 Copy-Item "$SharedFile" -Destination $fullfilepath
}
 ## Initiates installation
 function InstallQualysAgent {
 Start-Process -FilePath $fullfilepath -ArgumentList "CustomerId=$CustomerID ActivationId=$ActivationID WebServiceUri=$webServiceUri"
 }
 if (Test-Path $fullfilepath) {
 InstallQualysAgent
 }
 if (-not (Test-Path $filepath)) {
 New-Item -Path $filepath -ItemType Directory
 }
 if (-not (Test-Path $fullfilepath)) {
 CopyQualysAgent
 InstallQualysAgent
 }
}
