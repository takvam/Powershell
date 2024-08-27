## Adding AD users

$customernumber = Read-Host "Enter the customernumber for the customer"
##Filtering on the customernumber-name as provided above
$OrganisationNumber = Get-ADOrganizationalUnit -Filter "Name -like '$customerNumber*'" 
$users = Get-ADUser -filter * -SearchBase $OU
$securityGroup = get-adobject -Filter 'ObjectClass -eq "group"' -SearchBase $OU
$first = Read-Host "Enter First Name"
$last = Read-Host "Enter Last Name"
$username = Read-Host "Enter username"
$email = Read-Host "Enter Email"

##Call on method Password genertator with provided parameters 
$password = New-RandomPassword -MinimumPasswordLength 10 -MaximumPasswordLength 15 -NumberOfAlphaNumericCharacters 6 -ConvertToSecureString


try {
    Get-ADUser -Identity $username.Text
    $UserExists = $true
}
catch [Microsoft.ActiveDirectory.Management.ADIdentityResolutionException] {
    Write-Host "User does not exist."
    $UserExists = $false
    New-ADUser -DisplayName $username -UserPrincipalName $username -Surname $last -GivenName $first -EmailAddress $email -Name "$first $last" -Instance $users
    Get-ADPrincipalGroupMembership $users[0]
}

## Create a function to generate a random pw
function New-RandomPassword {
    param(
        [Parameter()]
        [int]$MinimumPasswordLength = 5,
        [Parameter()]
        [int]$MaximumPasswordLength = 10,
        [Parameter()]
        [int]$NumberOfAlphaNumericCharacters = 5,
        [Parameter()]
        [switch]$ConvertToSecureString
    )
    
    Add-Type -AssemblyName 'System.Web'
    $length = Get-Random -Minimum $MinimumPasswordLength -Maximum $MaximumPasswordLength
    $password = [System.Web.Security.Membership]::GeneratePassword($length,$NumberOfAlphaNumericCharacters)
    if ($ConvertToSecureString.IsPresent) {
        ConvertTo-SecureString -String $password -AsPlainText -Force
    } else {
        $password
    }
}