
CREATE Procedure [dbo].[DetValoresCuentas_BorrarPorIdValor]
@IdValor int  
AS 
DELETE DetalleValoresCuentas
WHERE (IdValor=@IdValor)
