$Regex="(.+)\s>"
$news=Invoke-WebRequest -UseBasicParsing -Uri https://news.google.com
$bodies = (($news.content |select-string -Pattern $regex -AllMatches | % {$_.Matches} | % {$_.Value}).Replace("title=","")).Replace("'","")


<#
53 $news=Invoke-WebRequest -UseBasicParsing -Uri https://memeorandum.com/river
54 $news
55 $news.RawContent
56 Get-History
57 $newscontent=$news.content
58 $newscontent
76 $regex='head="(.+?)(")\s'
77 $newscontent |select-string -Pattern $regex -AllMatches | % {$_.Matches} | % {$_.Value}
78 $newscontent |select-string -Pattern $regex -AllMatches | % {$_.Matches} | % {$_.Value} |measure
81 $heads=$newscontent |select-string -Pattern $regex -AllMatches | % {$_.Matches} | % {$_.Value}
82 $heads.Substring(15,5)
83 $heads.Substring(15,3)
84 $headbits=$heads.Substring(15,3)
85 $headbits.Count
86 $headbits |where {$_ -not -like "* *"}
87 $headbits |where {$_ -notlike "* *"}
88 $headbits |where {$_ -notlike "* *"} |measure
89 $length=12
90 $grabs=4
91 $headbits=$headbits |where {$_ -notlike "* *"}
92 $headbits
93 $headbits[10]
94 $headbits[10]+$headbits[30]+$headbits[40]+$headbits[280]
#>