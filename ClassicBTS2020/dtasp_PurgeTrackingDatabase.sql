if exists (select * from sysobjects where id = object_id(N'[dbo].[dtasp_BackupTrackingDatabase]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[dtasp_BackupTrackingDatabase]
GO

CREATE PROCEDURE [dbo].[dtasp_BackupTrackingDatabase]
@nvcFolder nvarchar(1024),
@nRetryRowID int,
@fSuccess int OUTPUT
AS
	declare @dtNow datetime
	declare @localized_string_BackupFailed nvarchar(256)
	set @localized_string_BackupFailed = N'A failure occurred while backing up the database.'

	set @dtNow = GetUTCDate()
	set @fSuccess = 0 --this means failure.
	
	--we need to do a backup of the database
	declare @DBName nvarchar(128), @ServerName nvarchar(256), @nvcDT nvarchar(32), @BackupLocation nvarchar(2000)
	set @nvcDT = replace(@dtNow, ' ', '_')
	set @nvcDT = replace(@nvcDT, ':', '_')
	select @DBName = db_name(), @ServerName = replace( cast( isnull( serverproperty('servername'), '' ) as nvarchar ), '\', '_' ) /* this will be a file path */
	if right( @nvcFolder, 1 ) = '\'
		SET @BackupLocation=@nvcFolder + @ServerName + N'_' + @DBName + N'_' + @nvcDT + N'.bak'
	else
		SET @BackupLocation=@nvcFolder + N'\' + @ServerName + N'_' + @DBName + N'_' + @nvcDT + N'.bak'
	--select @BackupLocation
	Backup Database @DBName to DISK=@BackupLocation
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

GO

GRANT EXEC ON [dbo].[dtasp_PurgeTrackingDatabase] TO BTS_BACKUP_USERS
GO