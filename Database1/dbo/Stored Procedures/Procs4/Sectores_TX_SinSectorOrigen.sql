





























CREATE Procedure [dbo].[Sectores_TX_SinSectorOrigen]
@IdSectorOrigen int
AS 
Select IdSector,Descripcion as Titulo
FROM Sectores
Where SeUsaEnPresupuestos='SI' and IdSector<>@IdSectorOrigen
order by Descripcion






























