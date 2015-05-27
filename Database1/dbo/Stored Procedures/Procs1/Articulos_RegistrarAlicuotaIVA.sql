






























CREATE PROCEDURE [dbo].[Articulos_RegistrarAlicuotaIVA]

@IdArticulo int,
@AlicuotaIVA numeric(6,2)

As

Update Articulos
Set AlicuotaIVA=@AlicuotaIVA
Where IdArticulo=@IdArticulo































