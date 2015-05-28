




CREATE Procedure [dbo].[AnticiposAlPersonal_BorrarPorIdRecibo]
@IdRecibo int  
AS 
DELETE AnticiposAlPersonal
WHERE (IdRecibo=@IdRecibo)




