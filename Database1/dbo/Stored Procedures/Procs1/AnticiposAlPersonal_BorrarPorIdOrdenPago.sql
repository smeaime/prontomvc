




CREATE Procedure [dbo].[AnticiposAlPersonal_BorrarPorIdOrdenPago]
@IdOrdenPago int  
AS 
DELETE AnticiposAlPersonal
WHERE (IdOrdenPago=@IdOrdenPago)




