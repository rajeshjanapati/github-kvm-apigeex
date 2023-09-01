# write-output Apigee Artifacts
$token = $env:TOKEN
$org = $env:ORG
$baseURL = "https://apigee.googleapis.com/v1/organizations/"
$headers = @{Authorization = "Bearer $token"}

# Set your GitHub repository information
$repositoryOwner = "rajeshjanapati@gmail.com"
$repositoryName = "github-kvm-apigeex"
$branchName = "main"

# Clone the repository
git clone https://github.com/rajeshjanapati/github-kvm-apigeex.git
cd $repositoryName
cd kvms

# Read JSON files
$jsonFiles = Get-ChildItem -Filter *.json -Recurse

# Loop through each JSON file and make POST requests
# foreach ($jsonFile in $jsonFiles) {
#     Write-Host "entered into foreach..."
#     $jsonContent = Get-Content -Path $jsonFile -Raw
#     # $apiUrl = "https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/environments/eval/keyvaluemaps"
#     $headers = @{
#         "Authorization" = "Bearer $token"
#         "Content-Type" = "application/json"
#     }
#     $kvmData = $jsonContent | ConvertFrom-Json
#     Write-Host $kvmData
#     foreach ($entry in $kvmData) {
#         $key = $entry.Key
#         $value = $entry.Value
    
#         $kvmEntry = @{
#             "name" = $key
#             "encrypted" = "false"
#             "entry" = $value
#         } | ConvertTo-Json
#     $baseUrl = "https://api.enterprise.apigee.com/v1/organizations/esi-apigee-x-394004/environments/eval/keyvaluemaps"

#     $kvmUrl = $baseUrl+$key+"/entries"
#     Invoke-RestMethod -Uri $kvmUrl -Method Post -Headers $headers -Body $kvmEntry
# }
    
# }

# Define the API endpoint
$apiUrl = "https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/environments/eval/keyvaluemaps/github-te/entries"

# Define the KVM entry data (key and value)
$kvmData = @{
    "key" = "github-test"
    "value" = "1234"
} | ConvertTo-Json

# Set up the request headers
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}

# Make the POST request to create the KVM entry
$response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $kvmData
Write-Host $response

