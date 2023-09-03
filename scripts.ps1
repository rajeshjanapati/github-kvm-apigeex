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
    $jsonContent = Get-Content -Path $jsonFile -Raw
    # Parse the JSON content
    $jsonData = ConvertFrom-Json $jsonContent

    # Extract the value of the "name" key from the JSON data
    $kvmName = $jsonData.name

    # Print the extracted value
    Write-Host "KVM Name: $kvmName"

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", "Bearer $token")
    $headers.Add("Content-Type", "application/json")

    $body1 =@{
        "name"=$kvmName;
        "encrypted"=true;
        }
    Write-Host $body1

    $kvmcreate = Invoke-RestMethod 'https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/environments/eval/keyvaluemaps' -Method 'POST' -Headers $headers -Body ($body1|ConvertTo-Json)
    $kvmcreate | ConvertTo-Json

    # Now, create KVM entries for each value in your KVM (assuming you have an array of values)
    $kvmValues = $jsonData.entry  # Replace 'values' with the actual key in your JSON
    Write-Host $kvmValues

    # $jsonObject = ConvertFrom-Json $jsonData.entry
    $entries = $jsonObject.entry
    # Write-Host $jsonObject
    # Write-Host $entries
    Write-Host "step-1"
    # Write-Host "Entries: $($entries | Out-String)"
    # Write-Host "KVM Values: $($kvmValues | Out-String)"
    $entries = $jsonData.entry
    Write-Host "Values: $vlaues"

    foreach ($entry in $entries) {
        Write-Host "step-2"
        $name = $entry.key
        $value = $entry.value
        Write-Host "Key: $name, Value: $value"
        @body2 = {
            "name" = $name;
            "value" = $value;
        }
        $entryObject = @{
            "entry" = $body2
        }
        
        Write-Host "body1: $entryObject"
        Write-Host "body2: $body2"
        
        $kvmentry = Invoke-RestMethod "https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/environments/eval/keyvaluemaps/$kvmName/entries" -Method 'POST' -Headers $headers -Body ($body2|ConvertTo-Json)
        $kvmentry | ConvertTo-Json
    }
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

