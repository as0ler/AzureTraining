#Variables
$keypath = "C:\Users\asoler\Desktop\PassEncryptKey.key"
$AESKey = New-Object Byte[] 32
$Password = "th1s1s4s4f3p4ss!"

#Keys
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($AESKey) 
Set-Content $keypath $AESKey

#Get encrypted password
$secPw = ConvertTo-SecureString -AsPlainText $Password -Force
$AESKey = Get-content $KeyPath
$Encryptedpassword = $secPw | ConvertFrom-SecureString -Key $AESKey
$Encryptedpassword