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


    $kvmget = Invoke-RestMethod 'https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/environments/eval/keyvaluemaps' -Method 'GET' -Headers $headers
    $kvmget | ConvertTo-Json
    Write-Host $kvmget

    $url = "https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/environments/eval/keyvaluemaps/$kvmName/entries"

    $kvmgetentries = Invoke-RestMethod -Uri $url -Method 'GET' -Headers $headers
    $kvmgetentriesvalues = $kvmgetentries | ConvertTo-Json
    Write-Host $kvmgetentriesvalues
    
    
    # Output the KVM entries for debugging
    $kvmgetentriesvalues | Format-Table
    
    # Your JSON data as a PowerShell object
    $jsonData1 = @{
        "keyValueEntries" = $kvmgetentriesvalues.keyValueEntries
    }
    
    # Prompt the user for entry values to check (comma-separated)
    $entryValues = Read-Host "Enter the entry values to check (comma-separated)"
    $valuesToCheck = $entryValues -split ',' | ForEach-Object { $_.Trim() }
    
    # Initialize an array to store the results
    $results = @()
    
    # Check each value in the list
    foreach ($valueToCheck in $valuesToCheck) {
        Write-Host "step1..."
        # Create an entry to check based on the current value
        $entryToCheck = @{
            "name" = $valueToCheck
        }
        
        # Check if the entry exists in the array
        $entryExists = $jsonData1.keyValueEntries -contains $entryToCheck
    
        # Add the result to the results array
        $results += @{
            "Value" = $valueToCheck
            "Exists" = $entryExists
        }
    }
    
    # Output the results
    $results | ForEach-Object {
        if ($_.Exists) {
            Write-Host "Entry with value $($_.Value) exists in the array."
        } else {
            Write-Host "Entry with value $($_.Value) does not exist in the array."
        }
    }

    # Your array
    $array = $kvmget
    
    # foreach ($valueToCheck in $array) {
    #     if ($array -contains $valueToCheck) {
    #         Write-Host "$valueToCheck is present in the array."
    #         $entries = $jsonData.entry
    #         Write-Host "Values: $vlaues"
        
    #         foreach ($entry in $entries) {
    #             Write-Host "step-2"
    #             $name = $entry.key
    #             $value = $entry.value
    #             Write-Host "Key: $name, Value: $value"
    #             $body2 = @{
    #                 "name" = $name;
    #                 "value" = $value;
    #             }
    #             Write-Host "body2: $body2"
                
    #             $kvmentry = Invoke-RestMethod "https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/environments/eval/keyvaluemaps/$kvmName/entries" -Method 'POST' -Headers $headers -Body ($body2|ConvertTo-Json)
    #             $kvmentry | ConvertTo-Json
    #         }
    #     } else {
    #         $body1 =@{
    #             "name"=$kvmName;
    #             "encrypted"=true;
    #             }
    #         Write-Host $body1
    #         Write-Host "$valueToCheck is not present in the array."
    #         $kvmcreate = Invoke-RestMethod 'https://apigee.googleapis.com/v1/organizations/esi-apigee-x-394004/environments/eval/keyvaluemaps' -Method 'POST' -Headers $headers -Body ($body1|ConvertTo-Json)
    #         $kvmcreate | ConvertTo-Json
    #     }
    # }
    
    }
