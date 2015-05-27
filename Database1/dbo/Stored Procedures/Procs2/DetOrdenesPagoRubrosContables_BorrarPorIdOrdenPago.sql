CREATE Procedure [dbo].[DetOrdenesPagoRubrosContables_BorrarPorIdOrdenPago]

@IdOrdenPago int  

AS

DELETE DetalleOrdenesPagoRubrosContables
WHERE (IdOrdenPago=@IdOrdenPago)