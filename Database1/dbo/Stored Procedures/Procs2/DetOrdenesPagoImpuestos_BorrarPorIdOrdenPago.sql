CREATE Procedure [dbo].[DetOrdenesPagoImpuestos_BorrarPorIdOrdenPago]

@IdOrdenPago int  

AS

Delete DetalleOrdenesPagoImpuestos
Where (IdOrdenPago=@IdOrdenPago)