# Specify the root directory paths
$rootDirectories = @("E:\Schedulers\EDS\ACSR_CM_EDS_Scheduler\output\processed",
"E:\Schedulers\EDS\ACSR_CM_EDS_Scheduler\output\error",
"E:\Schedulers\EDS\ACSR_DFCR_EDS_Scheduler\output\processed",
"E:\Schedulers\EDS\ACSR_DFCR_EDS_Scheduler\output\error",
"E:\Schedulers\EDS\ACSR_DTE_EDS_Scheduler\output\processed",
"E:\Schedulers\EDS\ACSR_DTE_EDS_Scheduler\output\error",
"E:\Schedulers\EDS\ACSR_FCR_EDS_Scheduler\output\processed",
"E:\Schedulers\EDS\ACSR_FCR_EDS_Scheduler\output\error",
"E:\Schedulers\EDS\ACSR_OTHER_EDS_Scheduler\output\processed",
"E:\Schedulers\EDS\ACSR_OTHER_EDS_Scheduler\output\error")

# Get the current date and calculate the date 1 months ago
$today = Get-Date
$oneMonthAgo = $today.AddMonths(-1)

# Create a log file with the current date in its name
$logFile = "E:\Schedulers\processed_error_folder_CleanUp\logs\deleted_directories_$($today.ToString('yyyyMMdd')).log"

# Create the log file if it doesn't exist
if (!(Test-Path $logFile)) {
    New-Item -ItemType File -Path $logFile
}

# Iterate through each specified root directory
foreach ($rootDirectory in $rootDirectories) {
    # Get all directories recursively
    $directories = Get-ChildItem -Path $rootDirectory -Recurse -Directory

    # Iterate through each directory and check its creation time
    foreach ($directory in $directories) {
        $creationTime = $directory.CreationTime
        if ($creationTime -lt $oneMonthAgo) {
            Write-Warning "Deleting directory: $($directory.FullName)"
            
            # Prepare a log entry for the directory and its files
            $logEntry = "$($today.ToString('yyyy-MM-dd HH:mm:ss')) Deleted directory: $($directory.FullName)"
            $files = Get-ChildItem -Path $directory.FullName -Recurse -File
            foreach ($file in $files) {
                $logEntry += "`n   Deleted file: $($file.FullName)"
            }

            # Log the directory and its files
            Add-Content -Path $logFile -Value $logEntry

            # Delete the directory
            Remove-Item -Path $directory.FullName -Recurse -Force
        }
    }
}