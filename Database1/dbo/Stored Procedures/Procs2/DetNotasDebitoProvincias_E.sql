




CREATE Procedure [dbo].[DetNotasDebitoProvincias_E]
@IdDetalleNotaDebitoProvincias int  
AS 
DELETE [DetalleNotasDebitoProvincias]
WHERE (IdDetalleNotaDebitoProvincias=@IdDetalleNotaDebitoProvincias)





