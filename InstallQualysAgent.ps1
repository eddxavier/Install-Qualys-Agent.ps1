$service = Get-Service -Name QualysAgent -ErrorAction SilentlyContinue
$filepath = "C:\Windows\Temp\QualysIntall\" ## Custom folder where packages should be downloaded to
$filename = "QualysCloudAgent.exe"
$fullfilepath = $filepath + $filename
$SharedFolder = "\\WIN-7QFNS730LHG\QualysAgent\"
$SharedFile = $SharedFolder + $filename
$CustomerID = "{857282f5-d79d-7dfa-81c2-223642cabb37}"
$ActivationID = "{86ec2475-57d6-4ec1-90a4-bc56abbfb3ad}"
$WebServiceUri = "https://qagpublic.qg3.apps.qualys.com/CloudAgent/"
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