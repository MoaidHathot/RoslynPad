Add-Type -A 'System.IO.Compression'
Add-Type -A 'System.IO.Compression.FileSystem'

$location = Get-Location
$archiveFile = "$location\RoslynPad.zip"
Remove-Item $archiveFile -ErrorAction Ignore

. .\GetFiles.ps1

try
{
	$archive = [System.IO.Compression.ZipFile]::Open($archiveFile, [System.IO.Compression.ZipArchiveMode]::Create)

	foreach ($file in $files)
	{
		[System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($archive, $file, $file.Substring($rootPath.Length)) | Out-Null
		$file
	}
}
finally
{
	$archive.Dispose()
}
