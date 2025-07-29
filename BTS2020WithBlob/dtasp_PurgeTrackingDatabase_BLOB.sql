if exists (select * from sysobjects where id = object_id(N'[dbo].[dtasp_BackupTrackingDatabase_BLOB]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[dtasp_BackupTrackingDatabase_BLOB]
GO

CREATE PROCEDURE [dbo].[dtasp_BackupTrackingDatabase_BLOB]
@nvcFolder nvarchar(1024),
@nRetryRowID int,
@fSuccess int OUTPUT
AS
	declare @dtNow datetime
	declare @localized_string_BackupFailed nvarchar(256)
	declare @DestinationType nvarchar(10)=N'DISK'
	set @localized_string_BackupFailed = N'A failure occurred while backing up the database.'
	set @dtNow = GetUTCDate()
	set @fSuccess = 0 --this means failure.
	
	--we need to do a backup of the database
	declare @DBName nvarchar(128), @ServerName nvarchar(256), @nvcDT nvarchar(32), @BackupLocation nvarchar(2000)

	declare @pathSep nvarchar(1) = '\'

	IF left( ltrim( @nvcFolder ), 4 ) = N'http'
	BEGIN
		SET @DestinationType=N'URL'
		SET @pathSep = '/'
	END

	set @nvcDT = replace(@dtNow, ' ', '_')
	set @nvcDT = replace(@nvcDT, ':', '_')

	select @DBName = db_name(), @ServerName = replace( cast( isnull( serverproperty('servername'), '' ) as nvarchar ), '\', '_' ) /* this will be a file path */

	-- Trim trailing @pathSep if present
	if right(@nvcFolder, 1) = @pathSep
		set @nvcFolder = left(@nvcFolder, len(@nvcFolder) - 1)

	set @BackupLocation = @nvcFolder + @pathSep + @ServerName + N'_' + @DBName + N'_' + @nvcDT + N'.bak'
	EXEC ('Backup Database [' + @DBName + '] to ' + @DestinationType + '=N''' + @BackupLocation + '''')

	if @@ERROR <> 0
	BEGIN
		if (@nRetryRowID = -1) --this is not a retry of a previously failed backup
			INSERT INTO dta_ArchiveHistory (dtTimeStamp, dtLastFailure, nFailureCount, nSuccess, nvcBackupLocation) VALUES (@dtNow, @dtNow, 1, -1, @BackupLocation)
		else
			UPDATE dta_ArchiveHistory set dtLastFailure = @dtNow, nFailureCount = nFailureCount + 1, nSuccess = -1, nvcBackupLocation = @BackupLocation WHERE nID = @nRetryRowID
		RAISERROR(@localized_string_BackupFailed, 16, 1)
	END
	else
	BEGIN
		if (@nRetryRowID = -1)
			INSERT INTO dta_ArchiveHistory (dtTimeStamp, nvcBackupLocation) VALUES (@dtNow, @BackupLocation)
		else
			UPDATE dta_ArchiveHistory set dtTimeStamp = @dtNow, dtLastFailure = null, nFailureCount = 0, nSuccess = 0, nvcBackupLocation = @BackupLocation WHERE nID = @nRetryRowID
	
		set @fSuccess = 1 --we successfully backed up the database
	END


-- Backup the original dtasp_PurgeTrackingDatabase if it exists
IF OBJECT_ID(N'[dbo].[dtasp_PurgeTrackingDatabase]', N'P') IS NOT NULL
BEGIN
	IF OBJECT_ID(N'[dbo].[dtasp_PurgeTrackingDatabase_ORG]', N'P') IS NOT NULL
		DROP PROCEDURE [dbo].[dtasp_PurgeTrackingDatabase_ORG]
	EXEC sp_rename '[dbo].[dtasp_PurgeTrackingDatabase]', 'dtasp_PurgeTrackingDatabase_ORG'
END

-- Rename this procedure to dtasp_PurgeTrackingDatabase
IF OBJECT_ID(N'[dbo].[dtasp_PurgeTrackingDatabase_BLOB]', N'P') IS NOT NULL
BEGIN
	IF OBJECT_ID(N'[dbo].[dtasp_PurgeTrackingDatabase]', N'P') IS NOT NULL
		DROP PROCEDURE [dbo].[dtasp_PurgeTrackingDatabase]
	EXEC sp_rename '[dbo].[dtasp_PurgeTrackingDatabase_BLOB]', 'dtasp_PurgeTrackingDatabase'
	GRANT EXEC ON [dbo].[dtasp_PurgeTrackingDatabase] TO BTS_BACKUP_USERS
END

GO
