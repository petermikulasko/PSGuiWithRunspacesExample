function Get-Logresults{
    Param 
        (
            [String]
                $Computername = $env:COMPUTERNAME,
            [String]
                $LogName,
            [int[]]
                $EventID,
            [String[]]
                $EntryType,
            [DateTime]
                $Time = (Get-Date).AddDays(-2),
            [String[]]
                $Source,
            [String[]]
                $Keyword                           

        )

        #Build query
        $Params = @{}
        if($EventID) { 
            $Params["InstanceID"] = $EventID 
        }
        if($EntryType) { 
            $Params["EntryType"] = $EntryType 
        }
        if($Source) { 
            $Params["Source"] = $Source 
        }
        if($Keyword) { 
            $Params["Message"] = $Keyword 
        }

        Get-EventLog -ComputerName $ComputerName -LogName $LogName -After $Time @Params        
}

function Save-Results{
    if($Script:Results -ne $null){
        $SavePath = Select-FolderDialog

        if($SavePath){
            $Script:Results | Export-Csv "$SavePath\EventViewerResults.csv" -NoTypeInformation
        }
    }
}

function Start-BackgroundJob {

}


#Form Events
$Form.Add_FormClosing({ })

$ButtonSubmit.Add_Click({ })

$TextBoxMachine.Add_Enter({ })

$TextBoxMachine.Add_Leave({ })

$TextBoxFind.Add_TextChanged{ }

$ButtonSave.Add_Click({ })

$ListViewLogResults.Add_SelectionChanged({ })

$ListViewLogResults.Add_CellPainting()

$ButtonView2.Add_Click({  })

$ButtonView1.Add_Click({  })