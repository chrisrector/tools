# Minimum token age
[int]$StaleAge = 180

# connect to tenant
# ccnnect-AzureAD

# Get guest users
$Filter = "UserType eq 'Guest'"
$Guests = Get-AzureADUser -All $true -Filter $Filter


# Find users whose last refresh token was issued more than $StaleAge days ago
$Today = (Get-Date)
$Global:StaleUsers = $Guests | ForEach-Object {
	$TimeStamp = $_.RefreshTokensValidFromDateTime
	$TimeStampString = $TimeStamp.ToString()
	[int]$LogonAge = [math]::Round(($Today - $TimeStamp).TotalDays)

	$User = $($_.Mail)
	If ($LogonAge -ge $StaleAge)
	{
		[pscustomobject]@{
      UserPrincipalName = $_.UserPrincipalName
			User		= $($User)
			ObjectID 	= $_.ObjectID
			LastLogon	= $TimeStamp
			DaysSinceLastLogon = $LogonAge
			UserIsStaleAfterThisManyDays = $StaleAge
		}
	}
}
$StaleUsers
