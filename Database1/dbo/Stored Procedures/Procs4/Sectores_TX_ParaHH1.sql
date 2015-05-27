



CREATE Procedure [dbo].[Sectores_TX_ParaHH1]

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0133'
Set @vector_T='0400'

SELECT
 IdSector,
 Substring(Descripcion,1,32) as [Sectores],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Sectores
WHERE SeUsaEnPresupuestos='SI'
ORDER BY OrdenPresentacion,Descripcion



