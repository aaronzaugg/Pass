Function New-NewsPassword {
    [CmdletBinding()]

    Param(
        [parameter (Mandatory = $true)]
        [int] $length,
        [parameter (Mandatory = $false)]
        [Alias ('ToClip', 'Clip')]
        [switch] $ToClipBoard,
        [parameter (Mandatory=$false)]
        [Alias ('ShowBad')]
        [switch] $ShowExclusions
    )

    $news = Invoke-WebRequest -UseBasicParsing -Uri https://memeorandum.com/river
    $newnews = $news.content -split '\n'
    $regex = 'head="(.*)\s+\('
    $pool = ($newnews|select-string -AllMatches -pattern $regex | % {$_.Matches} | % {$_.Value}) -join '' #% {$_.Replace('head="', '')}) -join ''
    $poolwords = $pool -split ' '
    $poolcount=$poolwords.Count
    $i=0
    if ($ShowExclusions.IsPresent){
        foreach ($poolword in $poolwords){
            if ($poolword -cmatch "['|\.|\(|\)|\||\-|\?|>|<|,|&|:]" )
            {
                $i++
                $l=$poolword.Length
                Write-Output "$i : $l : $poolword"
                
            }
        }
    }
    Write-Verbose "($Poolcount) words before cleaning"
    $poolwords = $poolwords | where-object {$_ -cnotmatch "['|\.|\(|\)|\||\-|\?|>|<|,|&|:]"} #"['|\.|\(|\)|\||\-|\?|>|<|,|&quot;|&amp;|&lt;|&gt;|:]" Ampersand section matched too much
    $poolwords = $poolwords|where-Object {$_.Length -gt 3 }
    $poolcount=$poolwords.Count
    Write-Verbose "($PoolCount) words after cleaning"
    $password = ''
    do {
        $wordpick = get-random -Maximum ($poolwords.Count - 1)
        Write-Verbose $wordpick
        $thisword = $poolwords[$wordpick]
        $thisword = $thisword.Substring(0, 1).ToUpper() + $thisword.Substring(1)
        $password += $thisword
    } while ($password.Length -lt $length)
    if ($ToClipBoard.IsPresent) {
        $password |Set-ClipBoard 
    }
    else {
        $password
    }
 New-NewsPassword -length $LambdaInput.Length
}