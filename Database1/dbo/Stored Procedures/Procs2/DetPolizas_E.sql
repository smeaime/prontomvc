CREATE Procedure [dbo].[DetPolizas_E]

@IdDetallePoliza int  

AS

DELETE DetallePolizas
WHERE (IdDetallePoliza=@IdDetallePoliza)