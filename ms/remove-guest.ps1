# script to remove a SharePoint Online external user

$upn = $args[0]
$site = $args[1]
write-output "UPN: $upn"

$u = Get-SPOExternalUser -Filter $upn
write-output "SPO external user: $u.email"
write-output "removing..."
Remove-SPOExternalUser -UniqueIDs @($u.UniqueId)
write-output "removing SPO user from site..."
Remove-SPOUser -site $site -LoginName $upn
write-output "done."
