<p align="center">
	<a href="https://www.phidiax.com/" target="_blank"><img src="https://static.wixstatic.com/media/f9592c_36f18dd9f56d463cb8dcc9ae97d69ac4~mv2.png/v1/crop/x_93,y_20,w_316,h_85/fill/w_442,h_112,al_c,lg_1,q_85,enc_avif,quality_auto/logo_icon_w500_h125_transparent_white.png" alt="Phidiax Logo" width="300" /></a>
	<br>
	<strong>Smarter Systems. Smarter Decisions.</strong>
</p>

**Configure the DTA Purge and Archive Job**

- 07/28/2025

Before you can archive or purge data from the BizTalk Tracking
(BizTalkDTADb) database, you must configure the DTA Purge and Archive
(BizTalkDTADb) job. This job is configured to call the
dtasp_BackupAndPurgeTrackingDatabase stored procedure, which uses six
parameters you must configure. **Note:** The Azure BLOB backup enhancement described here is specific to the DTA database; all other BizTalk databases already support backup to Azure BLOB storage using built-in features.

**Prerequisites**

Sign in with an account that is a member of the SQL Server sysadmin
fixed server role.

**Configure the DTA purge and archive job**

1.  On the SQL Server that hosts the BizTalk Tracking (BizTalkDTADb)
    database, open **SQL Server Management Studio**.

2.  In **Connect to Server**, enter the name of the SQL server where the
    BizTalk Tracking (BizTalkDTADb) database resides, enter the
    authentication type, and then select **Connect** to connect to the
    SQL server.

3.  Double-click **SQL Server Agent**, and then select **Jobs**.

4.  In **Object Explorer Details**, right-click **DTA Purge and Archive
    (BizTalkDTADb)**, and then select **Properties**.

5.  In **Job Properties - DTA Purge and Archive (BizTalkDTADb)**,
    under **Select a page**, select **Steps**.

6.  In the **Job step list**, select **Archive and Purge**, and then
    select **Edit**.

7.  In **General**, in the **Command** box, update the following
    parameters, and then select **OK**.

    - \@nLiveHours tinyint --- Any completed instance older than the
      (live hours) + (live days) will be deleted along with all
      associated data. This is a required parameter with no default
      value.

    <!-- -->

    - \@nLiveDays tinyint --- Any completed instance older than the
      (live hours) + (live days) will be deleted along with all
      associated data. Default interval is 0 days.

** Note**

For the purposes of the BizTalk Tracking (BizTalkDTADb) database, the
sum of LiveHours plus LiveDays is the live window of data you want to
maintain in your BizTalk Server environment. All data associated with a
completed instance older than the live window of data is deleted.

- \@nHardDeleteDays tinyint --- All data (even if incomplete) older than
  this will be deleted. The time interval specified for HardDeleteDays
  should be greater than the live window of data. The live window of
  data is the interval of time for which you want to maintain tracking
  data in the BizTalk Tracking (BizTalkDTADb) database. Anything older
  than this interval is eligible to be archived at the next archive and
  then purged. Default is 0 days.

<!-- -->

- \@nvcFolder nvarchar(1024) --- Folder in which to put the backup
  files. This is a required parameter with no default value. NEW
  FEATURE: Either a file path or Azure Blob URL plus container.

<!-- -->

- \@nvcValidatingServer sysname --- Server on which validation will be
  done. NULL value indicates no validation is being done. Default is
  NULL.

<!-- -->

- \@fForceBackup int --- Default is 0. This is reserved for future use.

<!-- -->

- \@fHardDeleteRunningInstances int - Default is 0. When set to 1, it
  deletes all running service instances older than
  the @nHardDeleteDays value.

** Note**

The @fHardDeleteRunningInstances property is available starting
with [**BizTalk Server 2016 Cumulative Update
1**](https://support.microsoft.com/help/3208238/cumulative-update-1-for-microsoft-biztalk-server-2016), [**BizTalk
Server 2013 R2 Cumulative Update
6**](https://support.microsoft.com/en-us/help/4020020/cumulative-update-package-6-for-biztalk-server-2013-r2),
and [**BizTalk Server 2013 Cumulative Update
5**](https://support.microsoft.com/help/3194301/cumulative-update-5-for-biztalk-server-2013).

> Your edited command should look similar to the following. In the
> following example, there is a live window of 1 hour, a hard purge of 1
> day, and deletes all running service instances older than 1 day:

COPY the appropriate example

<button onclick="navigator.clipboard.writeText(document.getElementById('CopyUNC').innerText)">CopyUNC</button>
<pre><code id="Backup to UNC">exec dtasp_BackupAndPurgeTrackingDatabase 1, 0, 1, '\\MyBizTalkServer\backup', null, 0, 1</code></pre>

<button onclick="navigator.clipboard.writeText(document.getElementById('CopyBLOB').innerText)">CopyBLOB</button>
<pre><code id="Backup to BLOB">exec dtasp_BackupAndPurgeTrackingDatabase 1, 0, 1,
'https://3709backup.blob.core.windows.net/biztalktestbackup', null, 0,
1</code></pre>

8.  On the **Job Properties - DTA Purge and Archive
    (BizTalkDTADb)** dialog box, under **Select a page**,
    select **General**, select the **Enabled** check box, and then
    select **OK**.

**See Also**

[Archiving and Purging the BizTalk Tracking
Database](https://learn.microsoft.com/en-us/biztalk/core/archiving-and-purging-the-biztalk-tracking-database)

------------------------------------------------------------------------

**Additional resources**

**Documentation**

- [**Purge Data from the BizTalk Tracking Database - BizTalk
  Server**](https://learn.microsoft.com/en-us/biztalk/core/how-to-purge-data-from-the-biztalk-tracking-database?source=recommendations)

Configure the dtasp_PurgeTrackingDatabase stored procedure to purge the
tracking database (BizTalkDTADB) in BizTalk Server

- [**How to Manually Purge Data from the BizTalk Tracking Database -
  BizTalk
  Server**](https://learn.microsoft.com/en-us/biztalk/core/how-to-manually-purge-data-from-the-biztalk-tracking-database?source=recommendations)

Learn more about: How to Manually Purge Data from the BizTalk Tracking
Database

- [**Archive and Purge the Tracking Database - BizTalk
  Server**](https://learn.microsoft.com/en-us/biztalk/core/archiving-and-purging-the-biztalk-tracking-database?source=recommendations)

Learn more about: Archive and Purge the BizTalkDTADb Database

Show 2 more

**Training**

**Module**

[**Create and manage SQL Agent jobs -
Training**](https://learn.microsoft.com/en-us/training/modules/schedule-tasks-using-sql-server-agent/?source=recommendations)

Create and manage SQL Agent jobs

**Certification**

[**Microsoft Certified: Azure Database Administrator Associate -
Certifications**](https://learn.microsoft.com/en-us/credentials/certifications/azure-database-administrator-associate/?source=recommendations)

Administer an SQL Server database infrastructure for cloud, on-premises
and hybrid relational databases using the Microsoft PaaS relational
database offerings.

**In this article**

1.  [Prerequisites](https://learn.microsoft.com/en-us/biztalk/core/how-to-configure-the-dta-purge-and-archive-job#prerequisites)

2.  [Configure the DTA purge and archive
    job](https://learn.microsoft.com/en-us/biztalk/core/how-to-configure-the-dta-purge-and-archive-job#configure-the-dta-purge-and-archive-job-1)

3.  [**See
    Also**](https://learn.microsoft.com/en-us/biztalk/core/how-to-configure-the-dta-purge-and-archive-job#see-also)

