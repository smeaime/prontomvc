





























CREATE Procedure [dbo].[ArticulosInformacionAdicional_TX_PorArticulo]
@IdArticulo int
AS 
Select *
FROM ArticulosInformacionAdicional
where IdArticulo=@IdArticulo






























