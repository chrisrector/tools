# Various M365 Powershell commands. A cheat sheet.

# create safe attachments policy and rule
New-SafeAttachmentPolicy -Name "Marketing Block Attachments" -Enable $true -Redirec
t $true -RedirectAddress admin@contoso.com
New-SafeAttachmentRule -Name "Marketing Department Attachment Rule" -SafeAttachment
Policy "Marketing Block Attachments" -SentTo "nowitcanbetold@gmail.com"

# list policies
Get-SafeAttachmentPolicy


# safe links
Get-SafeLinksPolicy
#View your safe links policy settings	Get-SafeLinksPolicy
#Edit an existing safe links policy	Set-SafeLinksPolicy
#Create a new custom safe links policy	New-SafeLinksPolicy
#Remove a custom safe links policy	Remove-SafeLinksPolicy
#View your safe links rule settings	Get-SafeLinksRule
#Edit an existing safe links rule	Set-SafeLinksRule
#Create a new custom safe links rule	New-SafeLinksRule
#Remove a custom safe links rule	Remove-SafeLinksRule

New-SafeLinksPolicy -Name "Marketing Block URL" -IsEnabled $true -TrackClicks $true
New-SafeLinksRule -Name "Marketing Department URL Rule" -SafeLinksPolicy "Marketing
 Block URL" -SentTo "abc@gmail.com"
 
## mailbox auditing
Get-Mailbox "Chris Smith" | FL Audit*
 Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -eq "UserMailbox"}
| FL Name,Audit*
#check what is on
Get-OrganizationConfig | Format-List AuditDisabled
Get-Mailbox "Chris Smith" | FL DefaultAuditSet
Get-Mailbox "Chris Smith" | Select-Object -ExpandProperty AuditOwner
Get-Mailbox "Chris Smith" | Select-Object -ExpandProperty AuditDelegate
Get-Mailbox "Chris Smith" | Select-Object -ExpandProperty AuditAdmin
