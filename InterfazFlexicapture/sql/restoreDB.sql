[restoreDB] 'wDemoWilliams', 'ssss'
-- http://stackoverflow.com/questions/2510295/fully-automated-sql-server-restore

CREATE PROC [dbo].[restoreDB]
    @p_strDBNameTo SYSNAME,
    @p_strDBNameFrom SYSNAME,
    @p_strFQNRestoreFileName VARCHAR(255)
AS 
    DECLARE 
        @v_strDBFilename VARCHAR(100),
        @v_strDBLogFilename VARCHAR(100),
        @v_strDBDataFile VARCHAR(100),
        @v_strDBLogFile VARCHAR(100),
        @v_strExecSQL NVARCHAR(1000),
        @v_strExecSQL1 NVARCHAR(1000),
        @v_strMoveSQL NVARCHAR(4000),
        @v_strREPLACE NVARCHAR(50),
        @v_strTEMP NVARCHAR(1000),
        @v_strListSQL NVARCHAR(4000),
        @v_strServerVersion NVARCHAR(20)

    SET @v_strREPLACE = ''   
    IF exists (select name from sys.databases where name = @p_strDBNameTo)
        SET @v_strREPLACE = ', REPLACE'

    SET @v_strListSQL = ''
    SET @v_strListSQL = @v_strListSQL + 'IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = ''##FILE_LIST''))'
    SET @v_strListSQL = @v_strListSQL + 'BEGIN'
    SET @v_strListSQL = @v_strListSQL + '   DROP TABLE ##FILE_LIST '
    SET @v_strListSQL = @v_strListSQL + 'END '

    SET @v_strListSQL = @v_strListSQL + 'CREATE TABLE ##FILE_LIST ('
    SET @v_strListSQL = @v_strListSQL + '   LogicalName VARCHAR(64),'
    SET @v_strListSQL = @v_strListSQL + '   PhysicalName VARCHAR(130),'
    SET @v_strListSQL = @v_strListSQL + '   [Type] VARCHAR(1),'
    SET @v_strListSQL = @v_strListSQL + '   FileGroupName VARCHAR(64),'
    SET @v_strListSQL = @v_strListSQL + '   Size DECIMAL(20, 0),'
    SET @v_strListSQL = @v_strListSQL + '   MaxSize DECIMAL(25,0),'
    SET @v_strListSQL = @v_strListSQL + '   FileID bigint,'
    SET @v_strListSQL = @v_strListSQL + '   CreateLSN DECIMAL(25,0),'
    SET @v_strListSQL = @v_strListSQL + '   DropLSN DECIMAL(25,0),'
    SET @v_strListSQL = @v_strListSQL + '   UniqueID UNIQUEIDENTIFIER,'
    SET @v_strListSQL = @v_strListSQL + '   ReadOnlyLSN DECIMAL(25,0),'
    SET @v_strListSQL = @v_strListSQL + '   ReadWriteLSN DECIMAL(25,0),'
    SET @v_strListSQL = @v_strListSQL + '   BackupSizeInBytes DECIMAL(25,0),'
    SET @v_strListSQL = @v_strListSQL + '   SourceBlockSize INT,'
    SET @v_strListSQL = @v_strListSQL + '   filegroupid INT,'
    SET @v_strListSQL = @v_strListSQL + '   loggroupguid UNIQUEIDENTIFIER,'
    SET @v_strListSQL = @v_strListSQL + '   differentialbaseLSN DECIMAL(25,0),'
    SET @v_strListSQL = @v_strListSQL + '   differentialbaseGUID UNIQUEIDENTIFIER,'
    SET @v_strListSQL = @v_strListSQL + '   isreadonly BIT,'
    SET @v_strListSQL = @v_strListSQL + '   ispresent BIT'

    SELECT @v_strServerVersion = CAST(SERVERPROPERTY ('PRODUCTVERSION') AS NVARCHAR)

    IF @v_strServerVersion LIKE '10.%' 
        BEGIN
            SET @v_strListSQL = @v_strListSQL + ', TDEThumbpr DECIMAL'
            --PRINT @v_strServerVersion
        END

    SET @v_strListSQL = @v_strListSQL + ')'

    EXEC (@v_strListSQL)


    INSERT INTO ##FILE_LIST EXEC ('RESTORE FILELISTONLY FROM DISK = ''' + @p_strFQNRestoreFileName + '''')

    DECLARE curFileLIst CURSOR FOR 
        SELECT 'MOVE N''' + LogicalName + ''' TO N''' + replace(PhysicalName, @p_strDBNameFrom, @p_strDBNameTo) + ''''
          FROM ##FILE_LIST

    SET @v_strMoveSQL = ''

    OPEN curFileList 
    FETCH NEXT FROM curFileList into @v_strTEMP
    WHILE @@Fetch_Status = 0
    BEGIN
        SET @v_strMoveSQL = @v_strMoveSQL + @v_strTEMP + ', '
        FETCH NEXT FROM curFileList into @v_strTEMP
    END

    CLOSE curFileList
    DEALLOCATE curFileList

    PRINT 'Killing active connections to the "' + @p_strDBNameTo + '" database'

    -- Create the sql to kill the active database connections
    SET @v_strExecSQL = ''
    SELECT   @v_strExecSQL = @v_strExecSQL + 'kill ' + CONVERT(CHAR(10), spid) + ' '
    FROM     master.dbo.sysprocesses
    WHERE    DB_NAME(dbid) = @p_strDBNameTo AND DBID <> 0 AND spid <> @@spid

    EXEC (@v_strExecSQL)

    PRINT 'Restoring "' + @p_strDBNameTo + '" database from "' + @p_strFQNRestoreFileName + '" with '
    PRINT '  data file "' + @v_strDBDataFile + '" located at "' + @v_strDBFilename + '"'
    PRINT '  log file "' + @v_strDBLogFile + '" located at "' + @v_strDBLogFilename + '"'

    SET @v_strExecSQL = 'RESTORE DATABASE [' + @p_strDBNameTo + ']'
    SET @v_strExecSQL = @v_strExecSQL + ' FROM DISK = ''' + @p_strFQNRestoreFileName + ''''
    SET @v_strExecSQL = @v_strExecSQL + ' WITH FILE = 1,'
    SET @v_strExecSQL = @v_strExecSQL + @v_strMoveSQL
    SET @v_strExecSQL = @v_strExecSQL + ' NOREWIND, '
    SET @v_strExecSQL = @v_strExecSQL + ' NOUNLOAD '
    SET @v_strExecSQL = @v_strExecSQL + @v_strREPLACE


    --PRINT '---------------------------'
    --PRINT @v_strExecSQL
    --PRINT '---------------------------'


    EXEC sp_executesql @v_strExecSQL