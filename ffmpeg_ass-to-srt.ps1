#script to convert ASS/SSA subtitles to SRT, to be placed in the directory containing the files to be modified.
#DO NOT FORGET TO PLACE "ffmpeg.exe" in the same place as the PS1

#get file paths
[System.Collections.ArrayList]$files = Get-ChildItem | foreach { $_.Name }

#exceptions to be removed from the table
$exceptions = @("ffmpeg_ass-to-srt.ps1","ffmpeg.exe")

#remove the exceptions from the table
foreach ($exception in $exceptions){
    $files.Remove($exception)
}

#processing on files
Foreach ($file in $files) {
	
	$path = [io.path]::GetFileNameWithoutExtension($file)
	$ext = ".mkv"
	$inputfile = ".\"+$path+$ext
	$outputfile = ".\"+$path+"-SRT"+$ext	

	& ".\ffmpeg.exe" -i $inputfile -map 0:v -map 0:a -map 0:s -c:v copy -c:a copy -c:s text $outputfile	
}
