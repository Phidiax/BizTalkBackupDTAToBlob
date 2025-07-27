
# Configure the Backup BizTalk Server Job (Enhanced for Azure Blob Storage)

**Date:** 07/26/2025  
**Source:** BizTalk Server – Microsoft Learn, Updated by Tom Canter (<tcanter@ojmot.com>) & Sandro Pereira (<sandro.pereira@devscope.net>)

After you install and configure BizTalk Server, configure the Backup BizTalk Server job to back up your data. This update adds support for Azure Blob Storage using the new `CredentialName` parameter.

**Starting with BizTalk Server 2016 Feature Pack 2**, you can back up your databases and log files to an Azure blob storage account. This document explains how to use the enhanced stored procedures to support this feature.

---

## Overview

The **Backup BizTalk Server (BizTalkMgmtDb)** job includes the following steps:

1. **Set Compression Option** – Enable or disable compression during backup  
2. **BackupFull** – Runs full database backups of the BizTalk Server databases  
3. **MarkAndBackUpLog** – Backs up the BizTalk Server database logs  
4. **Clear Backup History** – Choose how long the backup history is kept  

To configure this job:

- Identify the primary and destination SQL Servers and other backup options
- Choose a Windows user account to back up your databases, and create a SQL Server login for this account
- Map SQL Server logins to the `BTS_BACKUP_USERS` database role in the BizTalk Server databases
- Ensure MSDTC service is active on all nodes

---

## Before You Begin

Certain configuration and backup operations require membership in the sysadmin SQL Server role. To back up your BizTalk Server databases, sign in the primary server with an account that is a member of the SQL Server sysadmin Server role. BizTalk Server configuration adds the BTS_BACKUP_USERS database role. The user account you use to back up your databases does not require System Administrator (sysadmin SQL Server role) permissions on all the SQL Servers that may be involved in a backup, except for the primary server.

Decide which sign in account you use to run your BizTalk Server database backups. You can use a local account, and you can use more than one account. But it is generally simpler and more secure to create one dedicated Windows domain user account specifically for this purpose. You must configure a SQL Server logon account for this user, and the user must be mapped to a SQL Server login for all of the SQL Servers that participate in the backup process, either as primary (source) or secondary (destination) servers. Assign this user to the BizTalk BTS_BACKUP_USERS database role for each of the BizTalk Server databases you back up.

The Backup BizTalk Server job does not delete outdated backup files, so you need to manually manage those backup files to conserve disk space. After you have created a new full backup of your databases, you should move the outdated backup files onto an archival storage device to reclaim space on the primary disk. See the SSIS packages to manage these files.

BizTalk Server does not write tracking data directly to the BizTalk Tracking database; rather it caches the data in the MessageBox database, and then moves it to the BizTalk Tracking database. If MessageBox data loss occurs, some tracking data may also be lost.

---

## Prerequisites

- Sign in to SQL Server using an account that is a member of the sysadmin SQL Server role.
- Configure the SQL Server Agent service to run under a domain account (recommended, although local accounts can be used), with a mapped user login on each instance of SQL Server.
- To use an Azure blob storage account, you need:
  - A general purpose storage account
  - A container within your blob storage account
  - A shared access signature (SAS)
  - A SQL credential using the SAS
  - The blob service endpoint URL, e.g. [`https://yourstorageaccount.blob.core.windows.net/containername`](https://yourstorageaccount.blob.core.windows.net/containername)

> **Tip:**
> If you don't have an existing blob storage account configured with a SAS, then the SAS PowerShell script can create it, and the container. SQL Server Backup to URL provides an overview, and the specific steps.

---

## Configure the Job

On the SQL Server that hosts the BizTalk Management database, open SQL Server Management Studio, and connect to your SQL Server.

Expand SQL Server Agent, and expand Jobs.

Right-click Backup BizTalk Server (BizTalkMgmtDb) and select Properties. In the job properties, select Steps.

### Step 1 – Set Compression Option

This step calls the `sp_SetBackupCompression` stored procedure in the BizTalk management database (BizTalkMgmtDb) to set the value on the adm_BackupSettings table. The stored procedure has one parameter: `@bCompression`. By default, it is set to 0 (backup compression is off). To apply compression, change the value to 1:

```sql
exec [dbo].[sp_SetBackupCompression] @bCompression = 1 /*0 - Do not use Compression, 1 - Use Compression */
```

Select OK.

### Step 2 – BackupFull

Select the BackupFull step, and select Edit. In the Command box, update the parameter values:

- **Frequency**: The default is d (daily); recommended. Other values: h (hourly), w (weekly), m (monthly), y (yearly).
- **Name**: The default is BTS. Used as part of the backup file name.
- **Location of backup files**: Replace `<destination path>` with the full path (must include single quotes) to the computer and folder where you want to back up the BizTalk Server databases, or the blob service endpoint URL to an Azure blob storage account.
- **CredentialName**: For Azure Blob Storage, specify the SQL Credential name. For classic backups, set to NULL or omit.

> **Important:**
> If you enter a local path, manually copy all files to the same folder on the destination system whenever the Backup BizTalk Server job creates new files.
>
> To use a remote path, enter a UNC share such as `\\<ServerName>\<SharedDrive>\`.
>
> For Azure Blob Storage, enter the Blob service endpoint URL and container name, e.g. [`https://yourstorageaccount.blob.core.windows.net/yourcontainer/`](https://yourstorageaccount.blob.core.windows.net/yourcontainer/).

Optional parameters:

- **@ForceFullBackupAfterPartialSetFailure**: Default is 0. Set to 1 to force a full backup after a log backup failure.
- **@BackupHour**: Default is NULL. Set to an integer (0-23) for local time hour.
- **@UseLocalTime**: Default is 0 (UTC). Set to 1 to use local time.

#### Example: Daily backup to local disk

```sql
exec [dbo].[sp_BackupAllFull_Schedule]
    'd',
    'BTS',
    'm:\BizTalkBackups',
    '0',
    '2'
```

#### Example: Weekly backup to Azure Blob Storage

```sql
exec [dbo].[sp_BackupAllFull_Schedule]
    'w',
    'BTS',
    '[https://yourstorageaccount.blob.core.windows.net/yourcontainer/](https://yourstorageaccount.blob.core.windows.net/yourcontainer/)',
    '1',
    '2',
    '1',
    'MyBlobCredential'
```

Select OK.

### Step 3 – MarkAndBackUpLog

Select the MarkAndBackUpLog step, and select Edit. In the Command box, update the parameter values:

- **@MarkName**: Naming convention for backup files: `<Server Name>_<Database Name>_Log_<Log Mark Name>_<Timestamp>`
- **@BackupPath**: Full destination path (including single quotes) to the computer and folder to store the BizTalk Server database logs, or the Azure blob storage account and container.
- **@CredentialName**: For Azure Blob Storage, specify the SQL Credential name. For classic backups, set to NULL or omit.

> **Important:**
> For performance and data safety, set the destination path to a different computer or disk than the database logs.

Select OK.

### Step 4 – Clear Backup History

Select the Clear Backup History step, and select Edit. In the Command box, update the parameter values:

- **@DaysToKeep**: Default is 14 days. Determines how long backup history is kept in the Adm_BackupHistory table.
- **@UseLocalTime**: Default is 0 (UTC). Set to 1 to use local time.

```sql
exec [dbo].[sp_DeleteBackupHistory] @DaysToKeep=14, @UseLocalTime=1
```

> **Note:** This step does not delete backup files from the destination path.

Select OK and close all property windows.

---

## Optional: Change the Backup Schedule

See official documentation for scheduling options.

> The Backup BizTalk Server job runs the first time you configure it. By default, on subsequent runs, the job completes a full backup once a day, and log backups every 15 minutes.

Right-click the Backup BizTalk Server job, and select Enable. The status should change to Success.

---

## Execute Backup_Setup_All_Procs.sql and LogShipping_Destination_Logic.sql

After switching to Azure Blob Storage, execute the `Backup_Setup_All_Procs.sql` script against all custom databases being backed up by the job. By default, FP2 automatically updates BizTalk databases; it does not update custom databases (those in the adm_OtherBackupDatabases table in BizTalkMgmtDb).

If you use log shipping, execute the `LogShipping_Destination_Logic.sql` script on the destination system within SQL Server. If you don't use log shipping, skip this step.

---

## sp_ForceFullBackup Stored Procedure

The `sp_ForceFullBackup` stored procedure in the BizTalkMgmtDb database can be used to run an ad-hoc full backup. The stored procedure updates the adm_ForceFullBackup table with a value 1. The next time the Backup BizTalk Server job runs, a full database backup set is created.

---

## Next Steps

- Configure the Destination System for Log Shipping
- Schedule the Backup BizTalk Server Job
- Azure storage accounts
- SQL Server Backup

---

## References

- [CREATE CREDENTIAL (Transact-SQL) - Microsoft Learn](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-credential-transact-sql)
- [BizTalk Server Backup and Restore](https://learn.microsoft.com/en-us/biztalk/core/backup-and-restore)
