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
foreach ($jsonFile in $jsonFiles) {
    $jsonContent = Get-Content -Path $jsonFile.FullName -Raw

    https://apigee.googleapis.com/v1/organizations/$org/environments/eval/keyvaluemaps

    $apiUrl = "https://apigee.googleapis.com/v1/organizations/$org/environments/eval/keyvaluemaps"
    $headers = @{
        "Authorization" = "Bearer $token"
        "Content-Type" = "application/json"
    }

    $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $jsonContent

    Write-Host "File $($jsonFile.Name) uploaded. Response: $($response | ConvertTo-Json -Depth 2)"
}
