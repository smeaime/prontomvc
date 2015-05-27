CREATE Procedure [dbo].[DetRecibosRubrosContables_BorrarPorIdRecibo]

@IdRecibo int  

AS

DELETE DetalleRecibosRubrosContables
WHERE (IdRecibo=@IdRecibo)