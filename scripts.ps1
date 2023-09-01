# write-output Apigee Artifacts
$token = $env:TOKEN
$org = $env:ORG
# $baseURL = "https://apigee.googleapis.com/v1/organizations/"
# $headers = @{Authorization = "Bearer $token"}

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
    Write-Host "entered into foreach..."
    $jsonContent = Get-Content -Path $jsonFile -Raw
    $apiUrl = "https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/environments/eval/keyvaluemaps"
    $headers = @{
        "Authorization" = "Bearer $token"
        "Content-Type" = "application/json"
    }

     # Use the JSON data as the KVM name and create the KVM
    $kvmName = $jsonData.name  # Assuming "name" is the key in your JSON
    $body = @{
        "name" = $kvmName,
        "encrypted" = $true  # Set to $false if you don't want encryption
    } | ConvertTo-Json

    $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body

    # Check the response for success or handle errors
    Write-Host "Created KVM: $kvmName"
    $response | ConvertTo-Json
    }
    
    # $jsonData = ConvertFrom-Json $jsonContent
    # Write-Host $jsonData
    # foreach ($name in $($jsonData)) {
    #     Write-Host $name
    #     $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    #     $headers.Add("Authorization", "Bearer ya29.a0AfB_byDVwfNZVNiTBsatmu7gJEQyPExZ3TBhYONcediO5NcqjC6jf1o34DmhvKWHc999CUnVFJfjfjkELG3OFRGebsOAPMvoJmLsRccgc4gbDtwqWfVbrI_1STm9yQhpoxFpnPKLZQY5K0YCu9U0sNZaeRnz31PTu-vWYR5Px7HKYXkaCgYKAaISARESFQHsvYls6LkmPwzCEYsHSFPkVZQVDA0182")
    #     $headers.Add("Content-Type", "application/json")
        
    #     $body = @"
    #     {
    #         `"name`":`"test-pst11`",
    #         `"encrypted`":`"true`"
    #     }
    #     "@
        
    #     $response = Invoke-RestMethod 'https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/environments/eval/keyvaluemaps' -Method 'POST' -Headers $headers -Body $body
    #     $response | ConvertTo-Json
    # }


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


# $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
# $headers.Add("Authorization", "Bearer ya29.a0AfB_byDVwfNZVNiTBsatmu7gJEQyPExZ3TBhYONcediO5NcqjC6jf1o34DmhvKWHc999CUnVFJfjfjkELG3OFRGebsOAPMvoJmLsRccgc4gbDtwqWfVbrI_1STm9yQhpoxFpnPKLZQY5K0YCu9U0sNZaeRnz31PTu-vWYR5Px7HKYXkaCgYKAaISARESFQHsvYls6LkmPwzCEYsHSFPkVZQVDA0182")
# $headers.Add("Content-Type", "application/json")

# $body = @"
# {
#     `"name`":`"test`",
#     `"value`":`"12345`"
# }
# "@

# $response = Invoke-RestMethod 'https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/environments/eval/keyvaluemaps/github-KVM/entries' -Method 'POST' -Headers $headers -Body $body
# $response | ConvertTo-Json

