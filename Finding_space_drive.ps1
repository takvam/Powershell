Get-CimInstance -Class Win32_LogicalDisk |
Select-Object -Property Name, @{
    label= 'FreeSpace'
    expression={
        ($_.FreeSpace/1GB).ToString('F2')
    }
}

#output:
#Name FreeSpace
#---- ---------
#C:   486,56
