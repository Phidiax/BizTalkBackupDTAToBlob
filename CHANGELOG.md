
<p align="center">
	<a href="https://www.phidiax.com/" target="_blank"><img src="https://static.wixstatic.com/media/f9592c_36f18dd9f56d463cb8dcc9ae97d69ac4~mv2.png/v1/crop/x_93,y_20,w_316,h_85/fill/w_442,h_112,al_c,lg_1,q_85,enc_avif,quality_auto/logo_icon_w500_h125_transparent_white.png" alt="Phidiax Logo" width="300" /></a>
	<br>
	<strong>Phidiax: Architected for Excellence. Engineered for Impact.</strong>
</p>
# Changelog

## [Unreleased]

### Added
- Added logic to `dtasp_PurgeTrackingDatabase_BLOB.sql` to automatically back up the existing `dtasp_PurgeTrackingDatabase` procedure to `dtasp_PurgeTrackingDatabase_ORG` before installing the new version. **This enhancement is specific to the BizTalk Tracking (DTA) database; all other BizTalk databases already support backup to Azure Blob Storage.**
- The script now renames `dtasp_PurgeTrackingDatabase_BLOB` to `dtasp_PurgeTrackingDatabase` and grants execute permissions to `BTS_BACKUP_USERS`.
- Improved backup path logic to trim a trailing path separator (either `\` or `/`) from `@nvcFolder` before constructing the backup file path.
- The backup path logic now uses the correct separator for file system or Azure Blob Storage URLs.
- Updated documentation in [INSTALLATION.md](INSTALLATION.md) to explain the backup and replacement process for the stored procedure and clarify DTA-only enhancement.
- Added the "BTS2020WithBlob\BTS_Tracking_Logic.sql" file, which was previously referenced in the installation guide but missing from the release. This file is now included for completeness.

### Changed
- No other changes recorded yet.


---
<p align="center">
	<strong>Phidiax | Smarter Systems. Smarter Decisions.</strong><br>
	1550 Larimer St #314, Denver CO 80202 &nbsp;|&nbsp; 720-310-0161 &nbsp;|&nbsp; <a href="mailto:support@phidiax.com">support@phidiax.com</a><br>
	<a href="https://www.phidiax.com">www.phidiax.com</a> &nbsp;|&nbsp; <a href="https://www.facebook.com/Phidiax">LinkedIn</a> &nbsp;|&nbsp; <a href="https://twitter.com/phidiax">X</a> &nbsp;|&nbsp; <a href="https://facebook.com/phidiax">Facebook</a><br>
	<em>© 2025 Phidiax, LLC &nbsp;|&nbsp; <a href="https://www.phidiax.com/privacy-policy">Privacy Policy</a> &nbsp;|&nbsp; <a href="https://www.phidiax.com/terms-and-conditions">Terms &amp; Conditions</a> &nbsp;|&nbsp; <a href="https://www.phidiax.com/accessibility-statement">Accessibility</a></em>
</p>
