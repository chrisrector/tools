# Script to create a set of test users in Azure AD from an input CSV.
# Users will be given the same password. For testing only.
# CSV header: UserPrincipalName,GivenName,Surname,DisplayName,MailNickName,JobTitle

# choose a password for all users in advance, if desired
$userPw = ""

if ([string]::IsNullOrWhiteSpace($userPw)) {
  #Read-Host -Prompt ‘Enter password’
  $x = Read-Host "Enter password" -AsSecureString
  $userPw = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($x))
}

#Connect-AzureAD

Import-Csv -Path ".\users.csv" |
foreach {

$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile

$PasswordProfile.Password = $userPw

New-AzureADUser -DisplayName $_.DisplayName -GivenName $_.GivenName -Surname $_.Surname -UserPrincipalName $_.UserPrincipalName -JobTitle $_.JobTitle -PasswordProfile $PasswordProfile -AccountEnabled $true -MailNickName $_.MailNickName

} | Export-Csv -Path ".\NewAccountResults.csv"
