#Get list of all db's
$databases = Invoke-Sqlcmd -Query 'SELECT name FROM master.sys.databases' -ServerInstance 'DEA1CPSSQX-0101'
#Declaring variables to check for dbs with name AMA or AMR
$AMA = $databases | Where-Object {$_.name -like "AMA*"}
$AMR = $databases | Where-Object {$_.name -like "AMR*"}
$AMAAMR = $AMA+$AMR
#iterate through all AMA/AMR-dbs
foreach ($item in $AMAAMR)
{
    $dbName = $item.name
    #sqlcmd connects to server
    $query = Invoke-Sqlcmd -Query 'Select * FROM dbo.Operator' -Database $dbName -ServerInstance 'DEA1CPSSQX-0101'
    foreach($row in $query)
    {
        $inUse = $row.InUse
        $userName = $row.userName
        $email = $row.Email
        $isAdmin = $row.Admin
        #If admin and inuse is 1 = true, prints result to a file output.txt
        if(($isAdmin -eq 1) -and ($inUse -eq 1))
        {
            Add-Content -Path 'C:\scripts\Output\output.txt' -Value "$dbName,$userName,$email"
        }

    }
}