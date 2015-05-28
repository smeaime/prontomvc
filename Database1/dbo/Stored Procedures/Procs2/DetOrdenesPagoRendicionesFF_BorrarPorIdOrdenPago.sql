CREATE Procedure [dbo].[DetOrdenesPagoRendicionesFF_BorrarPorIdOrdenPago]

@IdOrdenPago int  

AS

DELETE DetalleOrdenesPagoRendicionesFF
WHERE (IdOrdenPago=@IdOrdenPago)