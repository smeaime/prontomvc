 declare @f varchar(100) 
 set  @f='"C:\Inetpub\wwwroot\pronto\Novedades\Nuevos_SP WEB.sql"'
 declare @s varchar(300) 
 set @s='sqlcmd -S ''192.168.66.123'' -d  ''Autotrol'' -i ' + @f 
  EXEC xp_cmdshell @s 