

Create Proc [dbo].[dropFK](@TableName sysname,@TablaReferenciada sysname,@CampoHijo sysname)
as
Begin

Declare @FK sysname
Declare @SQL nvarchar(4000)
Declare crsFK cursor for

select tu.Constraint_Name
--,SO.id,FK.*,REFSO.name 
from information_schema.constraint_table_usage TU
LEFT JOIN SYSOBJECTS SO ON TU.Constraint_NAME = SO.NAME
left join sysforeignkeys FK ON SO.id = constid   
LEFT JOIN SYSOBJECTS REFSO ON FK.rkeyid = REFSO.id
LEFT JOIN syscolumns col on col.id=FK.fkeyid and col.colid=fk.fkey

where so.xtype = 'F'
	and Table_Name = @TableName
	and refso.name = @TablaReferenciada
	and col.name=@Campohijo
order by TABLE_NAME


open crsFK
fetch next from crsFK into @FK
While (@@Fetch_Status = 0)
Begin
    Set @SQL = 'Alter table ' + @TableName + ' Drop Constraint ' + @FK
    Print 'Dropping ' + @FK
    exec sp_executesql  @SQL
    fetch next from crsFK into @FK
End
Close crsFK
Deallocate crsFK
End


