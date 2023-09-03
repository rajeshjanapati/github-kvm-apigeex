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

    $kvmcreate = Invoke-RestMethod 'https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/environments/eval/keyvaluemaps' -Method 'POST' -Headers $headers -Body ($body1|ConvertTo-Json)
    $kvmcreate | ConvertTo-Json

    # Now, create KVM entries for each value in your KVM (assuming you have an array of values)
    $kvmValues = $jsonData.entry  # Replace 'values' with the actual key in your JSON
    Write-Host $kvmValues

    foreach ($entry in $kvmValues) {
        Write-Host $kvmName
        $body2 = @{
            "key" = "rajesh;
            "value" = "topper";
        }
        Write-Host $body2
        Write-Host "Creating KVM entry for value: $($entry[name])"
        $kvmentry = Invoke-RestMethod "https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/environments/eval/keyvaluemaps/$kvmName/entries" -Method 'POST' -Headers $headers -Body ($body2|ConvertTo-Json)
        $kvmentry | ConvertTo-Json
        }




        
    # Check the HTTP status code and handle errors
    if ($response.StatusCode -eq 200) {
        Write-Host "KVM created successfully."
    } else {
        Write-Host "Error creating KVM. Status Code: $($response.StatusCode)"
        Write-Host "Response Content: $($response.Content)"
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

