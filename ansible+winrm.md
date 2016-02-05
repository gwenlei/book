#win7\win2008r2(win8\win2012以上都是powershell3.0不需要升级，只要设置winrm)
##升级networkframe4.6
双击安装NDP46-KB3045557-x86-x64-AllOS-ENU.exe
##升级powershell3.0
powershell设置脚本执行权限
```
powershell Set-ExecutionPolicy Unrestricted
```
powershell里面执行 .\uppowershell.ps1
```
# Powershell script to upgrade a PowerShell 2.0 system to PowerShell 3.0
# based on http://occasionalutility.blogspot.com/2013/11/everyday-powershell-part-7-powershell.html
#
# some Ansible modules that may use Powershell 3 features, so systems may need
# to be upgraded.  This may be used by a sample playbook.  Refer to the windows
# documentation on docs.ansible.com for details.
# 
# - hosts: windows
#   tasks:
#     - script: upgrade_to_ps3.ps1
 
# Get version of OS
 
# 6.0 is 2008
# 6.1 is 2008 R2
# 6.2 is 2012
# 6.3 is 2012 R2
 
 
if ($PSVersionTable.psversion.Major -ge 3)
{
    write-host "Powershell 3 Installed already; You don't need this"
    Exit
}
 
$powershellpath = "C:\powershell"
 
function download-file
{
    param ([string]$path, [string]$local)
    $client = new-object system.net.WebClient
    $client.Headers.Add("user-agent", "PowerShell")
    $client.downloadfile($path, $local)
}
 
if (!(test-path $powershellpath))
{
    New-Item -ItemType directory -Path $powershellpath
}
 
 
# .NET Framework 4.0 is necessary.
 
#if (($PSVersionTable.CLRVersion.Major) -lt 2)
#{
#    $DownloadUrl = "http://download.microsoft.com/download/B/A/4/BA4A7E71-2906-4B2D-A0E1-80CF16844F5F/dotNetFx45_Full_x86_x64.exe"
#    $FileName = $DownLoadUrl.Split('/')[-1]
#    download-file $downloadurl "$powershellpath\$filename"
#    ."$powershellpath\$filename" /quiet /norestart
#}
 
#You may need to reboot after the .NET install if so just run the script again.
 
# If the Operating System is above 6.2, then you already have PowerShell Version > 3
if ([Environment]::OSVersion.Version.Major -gt 6)
{
    write-host "OS is new; upgrade not needed."
    Exit
}
 
 
$osminor = [environment]::OSVersion.Version.Minor
 
$architecture = $ENV:PROCESSOR_ARCHITECTURE
 
if ($architecture -eq "AMD64")
{
    $architecture = "x64"
}  
else
{
    $architecture = "x86"
} 
 
if ($osminor -eq 1)
{
    $DownloadUrl = "http://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.1-KB2506143-" + $architecture + ".msu"
}
elseif ($osminor -eq 0)
{
    $DownloadUrl = "http://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.0-KB2506146-" + $architecture + ".msu"
}
else
{
    # Nothing to do; In theory this point will never be reached.
    Exit
}
 
$FileName = $DownLoadUrl.Split('/')[-1]
download-file $downloadurl "$powershellpath\$filename"
 
Start-Process -FilePath "$powershellpath\$filename" -ArgumentList /quiet
```
##设置winrm
powershell里面执行 .\winrm.ps1
```
# Configure a Windows host for remote management with Ansible
# -----------------------------------------------------------
#
# This script checks the current WinRM/PSRemoting configuration and makes the
# necessary changes to allow Ansible to connect, authenticate and execute
# PowerShell commands.
# 
# Set $VerbosePreference = "Continue" before running the script in order to
# see the output messages.
#
# Written by Trond Hindenes <trond@hindenes.com>
# Updated by Chris Church <cchurch@ansible.com>
#
# Version 1.0 - July 6th, 2014
# Version 1.1 - November 11th, 2014
 
Param (
    [string]$SubjectName = $env:COMPUTERNAME,
    [int]$CertValidityDays = 365,
    $CreateSelfSignedCert = $true
)
 
 
Function New-LegacySelfSignedCert
{
    Param (
        [string]$SubjectName,
        [int]$ValidDays = 365
    )
     
    $name = New-Object -COM "X509Enrollment.CX500DistinguishedName.1"
    $name.Encode("CN=$SubjectName", 0)
 
    $key = New-Object -COM "X509Enrollment.CX509PrivateKey.1"
    $key.ProviderName = "Microsoft RSA SChannel Cryptographic Provider"
    $key.KeySpec = 1
    $key.Length = 1024
    $key.SecurityDescriptor = "D:PAI(A;;0xd01f01ff;;;SY)(A;;0xd01f01ff;;;BA)(A;;0x80120089;;;NS)"
    $key.MachineContext = 1
    $key.Create()
 
    $serverauthoid = New-Object -COM "X509Enrollment.CObjectId.1"
    $serverauthoid.InitializeFromValue("1.3.6.1.5.5.7.3.1")
    $ekuoids = New-Object -COM "X509Enrollment.CObjectIds.1"
    $ekuoids.Add($serverauthoid)
    $ekuext = New-Object -COM "X509Enrollment.CX509ExtensionEnhancedKeyUsage.1"
    $ekuext.InitializeEncode($ekuoids)
 
    $cert = New-Object -COM "X509Enrollment.CX509CertificateRequestCertificate.1"
    $cert.InitializeFromPrivateKey(2, $key, "")
    $cert.Subject = $name
    $cert.Issuer = $cert.Subject
    $cert.NotBefore = (Get-Date).AddDays(-1)
    $cert.NotAfter = $cert.NotBefore.AddDays($ValidDays)
    $cert.X509Extensions.Add($ekuext)
    $cert.Encode()
 
    $enrollment = New-Object -COM "X509Enrollment.CX509Enrollment.1"
    $enrollment.InitializeFromRequest($cert)
    $certdata = $enrollment.CreateRequest(0)
    $enrollment.InstallResponse(2, $certdata, 0, "")
 
    # Return the thumbprint of the last installed cert.
    Get-ChildItem "Cert:\LocalMachine\my"| Sort-Object NotBefore -Descending | Select -First 1 | Select -Expand Thumbprint
}
 
 
# Setup error handling.
Trap
{
    $_
    Exit 1
}
$ErrorActionPreference = "Stop"
 
 
# Detect PowerShell version.
If ($PSVersionTable.PSVersion.Major -lt 3)
{
    Throw "PowerShell version 3 or higher is required."
}
 
 
# Find and start the WinRM service.
Write-Verbose "Verifying WinRM service."
If (!(Get-Service "WinRM"))
{
    Throw "Unable to find the WinRM service."
}
ElseIf ((Get-Service "WinRM").Status -ne "Running")
{
    Write-Verbose "Starting WinRM service."
    Start-Service -Name "WinRM" -ErrorAction Stop
}
 
 
# WinRM should be running; check that we have a PS session config.
If (!(Get-PSSessionConfiguration -Verbose:$false) -or (!(Get-ChildItem WSMan:\localhost\Listener)))
{
    Write-Verbose "Enabling PS Remoting."
    Enable-PSRemoting -Force -ErrorAction Stop
}
Else
{
    Write-Verbose "PS Remoting is already enabled."
}
 
 
# Test a remoting connection to localhost, which should work.
$httpResult = Invoke-Command -ComputerName "localhost" -ScriptBlock {$env:COMPUTERNAME} -ErrorVariable httpError -ErrorAction SilentlyContinue
$httpsOptions = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck
 
$httpsResult = New-PSSession -UseSSL -ComputerName "localhost" -SessionOption $httpsOptions -ErrorVariable httpsError -ErrorAction SilentlyContinue
 
If ($httpResult -and $httpsResult)
{
    Write-Verbose "HTTP and HTTPS sessions are enabled."
}
ElseIf ($httpsResult -and !$httpResult)
{
    Write-Verbose "HTTP sessions are disabled, HTTPS session are enabled."
}
ElseIf ($httpResult -and !$httpsResult)
{
    Write-Verbose "HTTPS sessions are disabled, HTTP session are enabled."
}
Else
{
    Throw "Unable to establish an HTTP or HTTPS remoting session."
}
 
 
# Make sure there is a SSL listener.
$listeners = Get-ChildItem WSMan:\localhost\Listener
If (!($listeners | Where {$_.Keys -like "TRANSPORT=HTTPS"}))
{
    # HTTPS-based endpoint does not exist.
    If (Get-Command "New-SelfSignedCertificate" -ErrorAction SilentlyContinue)
    {
        $cert = New-SelfSignedCertificate -DnsName $env:COMPUTERNAME -CertStoreLocation "Cert:\LocalMachine\My"
        $thumbprint = $cert.Thumbprint
    }
    Else
    {
        $thumbprint = New-LegacySelfSignedCert -SubjectName $env:COMPUTERNAME
    }
 
    # Create the hashtables of settings to be used.
    $valueset = @{}
    $valueset.Add('Hostname', $env:COMPUTERNAME)
    $valueset.Add('CertificateThumbprint', $thumbprint)
 
    $selectorset = @{}
    $selectorset.Add('Transport', 'HTTPS')
    $selectorset.Add('Address', '*')
 
    Write-Verbose "Enabling SSL listener."
    New-WSManInstance -ResourceURI 'winrm/config/Listener' -SelectorSet $selectorset -ValueSet $valueset
}
Else
{
    Write-Verbose "SSL listener is already active."
}
 
 
# Check for basic authentication.
$basicAuthSetting = Get-ChildItem WSMan:\localhost\Service\Auth | Where {$_.Name -eq "Basic"}
If (($basicAuthSetting.Value) -eq $false)
{
    Write-Verbose "Enabling basic auth support."
    Set-Item -Path "WSMan:\localhost\Service\Auth\Basic" -Value $true
}
Else
{
    Write-Verbose "Basic auth is already enabled."
}
 
 
# Configure firewall to allow WinRM HTTPS connections.
$fwtest1 = netsh advfirewall firewall show rule name="Allow WinRM HTTPS"
$fwtest2 = netsh advfirewall firewall show rule name="Allow WinRM HTTPS" profile=any
If ($fwtest1.count -lt 5)
{
    Write-Verbose "Adding firewall rule to allow WinRM HTTPS."
    netsh advfirewall firewall add rule profile=any name="Allow WinRM HTTPS" dir=in localport=5986 protocol=TCP action=allow
}
ElseIf (($fwtest1.count -ge 5) -and ($fwtest2.count -lt 5))
{
    Write-Verbose "Updating firewall rule to allow WinRM HTTPS for any profile."
    netsh advfirewall firewall set rule name="Allow WinRM HTTPS" new profile=any
}
Else
{
    Write-Verbose "Firewall rule already exists to allow WinRM HTTPS."
}
 
 
Write-Verbose "PS Remoting has been successfully configured for Ansible."
```
#ansible设置
##hosts
```
[windows]
192.168.122.114

[windows:vars]
ansible_ssh_user=clouder
ansible_ssh_pass=engine
ansible_ssh_port=5986
ansible_connection=winrm
```
##ansible.cfg
```
[defaults]
hostfile       = /home/code/mycode/ansible/qga/hosts
```


