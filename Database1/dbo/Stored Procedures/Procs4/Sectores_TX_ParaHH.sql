



CREATE Procedure [dbo].[Sectores_TX_ParaHH]
AS 
SELECT 
 IdSector,
 Descripcion as Titulo
FROM Sectores
WHERE IsNull(SeUsaEnPresupuestos,'NO')='SI'
ORDER BY OrdenPresentacion,Descripcion



