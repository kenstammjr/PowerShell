
$computerName = "SP16_SEARCHSVR_01", "SP16_SEARCHSVR_02"
[int[]]$ports = 443

$socket = New-Object -TypeName Net.Sockets.TCPClient
$ErrorActionPreference = 'SilentlyContinue'

foreach ($computer in $computerName){
    foreach($port in $ports){
        $socket.Connect($computer, $port)
        if($socket.Connected){
            "${computer}: Port $port is open"
            $socket.Close()
        }else{
            "${computer}: Port $port is closed or filtered"
        }
        $socket.Dispose()
    }
}