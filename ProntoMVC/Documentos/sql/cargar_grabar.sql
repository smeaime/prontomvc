

bdlmaster.dbo.wResetearPass 'Mariano','pirulo!'



update Empleados
set UsuarioNT='Mariano',password=''
where 
UsuarioNT='administrator' 
or UsuarioNT='administrador'

update Empleados
set Administrador='SI'
where UsuarioNT='Mariano' 



update Empleados
set password=''

select * from empleados where  UsuarioNT='Mariano' 

update Empleados
set UsuarioNT='aaaa',password=''
where IdEmpleado=358 
--------------------------------------
--------------------------------------
--------------------------------------

    
--------------------------------------
--------------------------------------
    
declare @origen varchar(200)
set @origen='C:\Backup\BDL\bases\BDLMaster'


declare @dir varchar(200)
--set @dir='d:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\'
--set @dir='C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\'
set @dir='C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS64\MSSQL\DATA'
--set @dir='E:\Backup\BDL\Bases\'
declare @mdf varchar(200)
set @mdf=@dir+'BDLMaster.mdf'
declare @ldf varchar(200)
set @ldf=@dir+'BDLMaster.ldf'

    
--create database BDLMaster
--drop database BDLMaster

--RESTORE FILELISTONLY FROM disk  = @origen  

RESTORE DATABASE BDLMaster
from disk  = @origen 
with move 'BDLMaster' to @mdf,
     move 'BDLMaster_Log' to @ldf
     ,replace


--------------------------------------
--------------------------------------
--------------------------------------

declare @origen varchar(200)
--set @origen='E:\Backup\BDL\ProntoWeb\doc\williams\base\BK Williams 22-2-12.BAK'
--set @origen='E:\Backup\BDL\ProntoWeb\backups\bases\BK Williams 22-2-12.bak'
set @origen='E:\Backup\BDL\ProntoWeb\backups\bases\williams.bak'

declare @dir varchar(200)
--set @dir='d:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\'
set @dir='C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\'
--set @dir='E:\Backup\BDL\Bases\'
declare @mdf varchar(200)
set @mdf=@dir+'wDemoWilliams2.mdf'
declare @ldf varchar(200)
set @ldf=@dir+'wDemoWilliams2_1.ldf'

--create database wDemoWilliams2
--drop database wDemoWilliams2

--CREATE DATABASE wDemoWilliams ON 
--    (NAME='Pronto_data', FILENAME ='E:\Backup\BDL\Bases\wDemoWilliams2.mdf' ) 
--	LOG ON
--    (NAME='Pronto_Log' , FILENAME ='E:\Backup\BDL\Bases\wDemoWilliams2_1.ldf' )
    

--RESTORE FILELISTONLY FROM disk  = @origen  
--go

RESTORE DATABASE wDemoWilliams
from disk  = @origen
with move 'Pronto_data' to @mdf,
     move 'Pronto_Log' to @ldf,
     replace


--------------------------------------
--------------------------------------

create database Autotrol
--drop database Autotrol


CREATE DATABASE Autotrol ON 
    (NAME='Pronto_data', FILENAME ='C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\Autotrol.mdf' ) 
	LOG ON
    (NAME='Pronto_Log' , FILENAME ='C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\Autotrol.ldf' )




declare @origen varchar(200)
--set @origen='E:\Backup\BDL\ProntoWeb\doc\williams\base\BK Williams 22-2-12.BAK'
--set @origen='E:\Backup\BDL\ProntoWeb\backups\bases\BK Williams 22-2-12.bak'
set @origen='C:\Backup\BDL\otros\Bases\New folder\Autotrol.bak'

declare @dir varchar(200)
--set @dir='C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\'
set @dir='c:\Backup\BDL\Bases'
--set @dir='E:\Backup\BDL\Bases\'
--set @dir='E:\Backup\BDL\Bases\'
declare @mdf varchar(200)
set @mdf=@dir+'Autotrol.mdf'
declare @ldf varchar(200)
set @ldf=@dir+'Autotrol.ldf'


RESTORE DATABASE Autotrol
from disk  = @origen
with move 'Pronto_data' to @mdf,
     move 'Pronto_Log' to @ldf,
     replace


--------------------------------------




--------------------------------------
--------------------------------------

declare @origen varchar(200)
set @origen='c:\Backup\BDL\Bases\BK PruebaCapen 8-9-11.BAK'




declare @dir varchar(200)
--set @dir='d:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\'
set @dir='C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS64\MSSQL\DATA'
declare @mdf varchar(200)
set @mdf=@dir+'Capen.mdf'
declare @ldf varchar(200)
set @ldf=@dir+'Capen_1.ldf'




RESTORE DATABASE Capen
from disk  = @origen
with move 'Pronto_data' to  @mdf,
     move 'Pronto_Log' to @ldf
     ,replace --comentar el REPLACE si la estas creando....

 
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
BACKUP DATABASE ProntoSat
TO DISK = 'C:\ProntoSat\doc\ProntoSatBalance'    --WITH FORMAT,      MEDIANAME = 'Z_SQLServerBackups',      NAME = 'Full Backup of AdventureWorks';

create database ProntoSat

drop database ProntoSat





--------------------------------------
--------------------------------------

declare @origen varchar(200)
set @origen='E:\Backup\BDL\ProntoConsultas\Admin\AdministradorProyecto_backup_2011_10_12_000005_8020000.BAK'




declare @dir varchar(200)
--set @dir='d:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\'
--set @dir='C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS2\MSSQL\DATA\'
set @dir='E:\Backup\BDL\Bases\'
declare @mdf varchar(200)
set @mdf=@dir+'AdministradorProyecto.mdf'
declare @ldf varchar(200)
set @ldf=@dir+'AdministradorProyecto_1.ldf'




RESTORE DATABASE Capen
from disk  = @origen
with move 'AdministradorProyecto_data' to  @mdf,
     move 'AdministradorProyecto_Log' to @ldf
     ,replace --comentar el REPLACE si la estas creando....

 
--------------------------------------
--------------------------------------
