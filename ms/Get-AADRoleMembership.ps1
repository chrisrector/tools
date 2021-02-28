
write-host "starting script to grab AAD role membership..."

$output = New-Object System.Collections.ArrayList;

$AzureADRoles = @(Get-AzureADDirectoryRole -ErrorAction Stop)

foreach ($AzureADRole in $AzureADRoles) {

    $RoleMembers = @(Get-AzureADDirectoryRoleMember -ObjectId $AzureADRole.ObjectId)

    $counter = 0;
    foreach ($RoleMember in $RoleMembers) {
        $ObjectProperties = [Ordered]@{
            "Role" = $AzureADRole.DisplayName
            "Display Name" = $RoleMember.DisplayName
            "Object Type" = $RoleMember.ObjectType
            "Account Enabled" = $RoleMember.AccountEnabled
            "User Principal Name" = $RoleMember.UserPrincipalName
            "Password Policies" = $RoleMember.PasswordPolicies
            "HomePage" = $RoleMember.HomePage
        }

        $RoleMemberObject = New-Object -TypeName PSObject -Property $ObjectProperties
        [void]$output.Add($RoleMemberObject)
    }
};

write-host "exiting"

return $output