if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[wDuplicarBase]') 
and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].wDuplicarBase
GO


CREATE Procedure [dbo].wDuplicarBase
@YourDatabaseName varchar(60),
@YourNewDatabaseName varchar(60),
@dir varchar(200)=NULL
as



SET @dir=IsNull(@dir,'C:\')

declare @fback varchar(260)
set @fback=@dir+'BackupFile.bak'


backup database @YourDatabaseName
to disk = @fback
with COPY_ONLY, INIT;
--http://stackoverflow.com/questions/13709830/override-file-while-backup-database


declare @mdf varchar(200)
set @mdf=@dir+@YourNewDatabaseName+'.mdf'
declare @ldf varchar(200)
set @ldf=@dir+@YourNewDatabaseName+'.ldf'



--////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////

DECLARE @TibetanYaks TABLE ( YakID int, YakName char(30) ) 

DECLARE @LogicalNameData varchar(128),@LogicalNameLog varchar(128)
INSERT INTO @table
EXEC('
RESTORE FILELISTONLY 
   FROM DISK=''' +@Path+ '''
   ')

   SET @LogicalNameData=(SELECT LogicalName FROM @Table WHERE Type='D')
   SET @LogicalNameLog=(SELECT LogicalName FROM @Table WHERE Type='L')

SELECT @LogicalNameData,@LogicalNameLog


--////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////


restore database @YourNewDatabaseName
from disk = @fback
with
	move 'Pronto_data' to  @mdf,
    move 'Pronto_Log' to  @ldf;

--with move;
    



--bdlmaster.dbo.wResetearPass 'Mariano','pirulo!'

--update Empleados
--set UsuarioNT='Mariano',password=''
--where 
--UsuarioNT='administrator' 
--or UsuarioNT='administrador'

--update Empleados
--set Administrador='SI'
--where UsuarioNT='Mariano' 


go


--sp_helptext 'wDuplicarBase'

--wDuplicarBase 'BDLMaster','BDLMaster2'
--wDuplicarBase 'Capen','Capen2'

--create database ProntoSat
--drop database ProntoSat

--restore filelistonly from disk = 'C:\BackupFile.bak'

--restore database Capen2
--from disk = 'C:\BackupFile.bak'
--with move;
drop  table #filelistinfo

create table #filelistinfo
(LogicalName sysname null,
PhysicalName sysname null,
Type varchar(20) null,
FileGroupName sysname null,
FileSize bigint null ,
FileMaxSize Bigint null)


INSERT INTO #filelistinfo 

select logicalname from
EXEC (' RESTORE FILELISTONLY    FROM DISK=''C:\Backup\BDL\otros\Bases\New folder\autotrol.bak''')

;




RESTORE FILELISTONLY    FROM DISK='C:\Backup\BDL\otros\Bases\New folder\autotrol.bak'



SELECT  * 
INTO    #tmp FROM    
OPENQUERY('mariano-pc', 'EXEC   RESTORE FILELISTONLY    FROM DISK=''C:\Backup\BDL\otros\Bases\New folder\autotrol.bak''          ')
