 Write-Host (ConvertTo-Json -InputObject $LambdaInput -Compress -Depth 5)
 Write-Host (ConvertTo-Json -InputObject $LambdaContext -compress -Depth 5)
 Write-Host (ConvertTo-Json -InputObject $args -Compress -Depth 5)

    $length=$LambdaInput.Len
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
 
<#
@{Name=?; Value=True} 
@{Name=^; Value=} 
@{Name=$; Value=} 
@{Name=args; Value=System.Object[]} 
@{Name=ConfirmPreference; Value=High} 
@{Name=DebugPreference; Value=SilentlyContinue} 
@{Name=EnabledExperimentalFeatures; Value=System.Collections.Immutable.ImmutableHashSet`1[System.String]} 
@{Name=Error; Value=System.Collections.ArrayList} 
@{Name=ErrorActionPreference; Value=Continue}
@{Name=ErrorView; Value=NormalView} 
@{Name=ExecutionContext; Value=System.Management.Automation.EngineIntrinsics} 
@{Name=false; Value=False} 
@{Name=FormatEnumerationLimit; Value=4} 
@{Name=HOME; Value=} 
@{Name=Host; Value=System.Management.Automation.Internal.Host.InternalHost} 
@{Name=InformationPreference; Value=SilentlyContinue} 
@{Name=input; Value=System.Collections.ArrayList+ArrayListEnumeratorSimple} 
@{Name=IsCoreCLR; Value=True} 
@{Name=IsLinux; Value=True} 
@{Name=IsMacOS; Value=False} 
@{Name=IsWindows; Value=False} 
@{Name=LambdaContext; Value=AWSLambda.Internal.Bootstrap.Context.LambdaContext} 
@{Name=LambdaInput; Value=} 
@{Name=LambdaInputString; Value={}} 
@{Name=length; Value=0} 
@{Name=MaximumHistoryCount; Value=4096} 
@{Name=MyInvocation; Value=System.Management.Automation.InvocationInfo} 
@{Name=NestedPromptLevel; Value=0} 
@{Name=null; Value=} 
@{Name=OutputEncoding; Value=System.Text.UTF8Encoding} 
@{Name=PID; Value=2} 
@{Name=ProgressPreference; Value=Continue} 
@{Name=PSBoundParameters; Value=System.Management.Automation.PSBoundParametersDictionary} 
@{Name=PSCommandPath; Value=} 
@{Name=PSCulture; Value=en-US} 
@{Name=PSDefaultParameterValues; Value=System.Management.Automation.DefaultParameterDictionary} 
@{Name=PSEdition; Value=Core} 
@{Name=PSEmailServer; Value=} 
@{Name=PSHOME; Value=/var/task} 
@{Name=PSScriptRoot; Value=} 
@{Name=PSSessionApplicationName; Value=wsman} 
@{Name=PSSessionConfigurationName; Value=http://schemas.microsoft.com/powershell/Microsoft.PowerShell} 
@{Name=PSSessionOption; Value=System.Management.Automation.Remoting.PSSessionOption} 
@{Name=PSUICulture; Value=en-US} 
@{Name=PSVersionTable; Value=System.Management.Automation.PSVersionHashTable} 
@{Name=PWD; Value=/var/task} 
@{Name=ShellId; Value=Microsoft.PowerShell} 
@{Name=StackTrace; Value=} 
@{Name=true; Value=True} 
@{Name=VerbosePreference; Value=SilentlyContinue} 
@{Name=WarningPreference; Value=Continue} 
@{Name=WhatIfPreference; Value=False}
#>