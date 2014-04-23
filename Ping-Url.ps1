function Ping-Url {
    param(
        [Parameter(ValueFromPipeline=$true)][string] $url
    )
    process {
        $request = [System.Net.WebRequest]::Create( $url )
        $request.UseDefaultCredentials = $true
        $request.Timeout = 90000;

        $startTime = Get-Date
        $request.GetResponse() > $null
        $stopTime = Get-Date

        $object = New-Object PSObject -Property @{
            Url           = $request.RequestUri
            Duration      = $stopTime-$startTime
            StartTime     = $startTime
            EndTime       = $stopTime
        } | Select-Object Url, Duration, StartTime, EndTime  # to ensure order
        
        $object
    }
} 