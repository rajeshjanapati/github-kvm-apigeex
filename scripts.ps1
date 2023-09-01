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
    Write-Host "Entered into foreach..."
    $jsonContent = Get-Content -Path $jsonFile -Raw
    # Parse the JSON content
    $jsonData = ConvertFrom-Json $jsonContent

    # Extract the value of the "name" key from the JSON data
    $kvmName = $jsonData.name

    # Print the extracted value
    Write-Host "KVM Name: $kvmName"

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", "Bearer ya29.a0AfB_byBVRRWv3j120nTXVXah3wvqwIpBIGNguhajsUiE87R496vX-zJEJrL3ZLCcGyBkxL5Ynuu61HEwz9nn6_evRSewYFWQT3gi4mrocvzdmo8odRtPVYeFMgXVk7lerSLLom8dDkKCWJCRcNq7yKKM_kIgl_JUZv_USetE1bmNWUwaCgYKAZQSARESFQHsvYlsDh3J5BDbCEj488voROYSPA0182")
    $headers.Add("Content-Type", "application/json")

    $body = @"
    {
        "name": "$kvmName",
        "encrypted": true  # Set to false if you don't want encryption
    }
"@

    $response = Invoke-RestMethod 'https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/environments/eval/keyvaluemaps' -Method 'POST' -Headers $headers -Body $body
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

