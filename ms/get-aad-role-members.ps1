import-module AzureAD
Connect-AzureAD

$DataPath = “C:\tmp\aad_role_members.csv”
$Results = @()
$azureadroles = Get-AzureADDirectoryRole
foreach($role in $azureadroles) {
  $rolename = $role.displayname
  $roleid = $role.objectid
  $rolemember = Get-AzureADDirectoryRoleMember -ObjectID $roleid
  foreach ($member in $rolemember) {
    $Properties = @{
      RoleName = $rolename
      ObjectType = $member.objecttype
      Enabled = $member.accountenabled
      GivenName = $member.givenname
      Surname = $member.surname
      DisplayName = $member.displayname
      UPN = $member.userprincipalname
    }
  
    $Results += New-Object psobject -Property $properties
  }
  
  $Results | Select-Object RoleName,UPN,DisplayName,ObjectType,Enabled,
    GivenName,Surname | Export-Csv -notypeinformation -Path $DataPath
}