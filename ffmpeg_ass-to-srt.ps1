#script permettant de convertir les sous titre ASS/SSA en SRT, à placer dans le répertoire contenant les fichiers à modifier.
#NE PAS OUBLIER DE METTRE "ffmpeg.exe" au même endroit que le PS1

#recupération des chemins des fichiers
[System.Collections.ArrayList]$files = Get-ChildItem | foreach { $_.Name }

#exceptions à enlever du tableau 
$exceptions = @("ffmpeg_ass-to-srt.ps1","ffmpeg.exe")

#enleve les exceptions du tableau
foreach ($exception in $exceptions){
    $files.Remove($exception)
}

#traitement sur les fichiers
Foreach ($file in $files) {
	
	$path = [io.path]::GetFileNameWithoutExtension($file)
	$ext = ".mkv"
	$inputfile = ".\"+$path+$ext
	$outputfile = ".\"+$path+"-SRT"+$ext	

	& ".\ffmpeg.exe" -i $inputfile -map 0:v -map 0:a -map 0:s -c:v copy -c:a copy -c:s text $outputfile	
}