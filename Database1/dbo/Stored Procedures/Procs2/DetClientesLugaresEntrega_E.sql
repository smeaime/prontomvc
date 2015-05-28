CREATE Procedure [dbo].[DetClientesLugaresEntrega_E]

@IdDetalleClienteLugarEntrega int  

AS

DELETE DetalleClientesLugaresEntrega
WHERE (IdDetalleClienteLugarEntrega=@IdDetalleClienteLugarEntrega)