
create procedure _AlterTable

@tabla Varchar(100),
@campo varchar(100),
@esta int output

AS
set nocount on

CREATE TABLE [dbo].[#Auxiliar] (
	[table_name] [nvarchar] (384) COLLATE Modern_Spanish_CI_AS NULL ,
	[table_owner] [nvarchar] (384) COLLATE Modern_Spanish_CI_AS NULL ,
	[table_qualifier] [varchar] (100) COLLATE Modern_Spanish_CI_AS NULL ,
	[column_name] [nvarchar] (384) COLLATE Modern_Spanish_CI_AS NULL 
) ON [PRIMARY]

insert into #Auxiliar exec BD_TX_Campos @tabla
set @esta =0
if exists (select Column_name from #Auxiliar where Column_name = @campo)
set @esta =1

drop table #Auxiliar
set nocount off
Return (@esta)

