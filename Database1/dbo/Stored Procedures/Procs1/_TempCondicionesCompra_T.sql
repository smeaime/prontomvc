






CREATE Procedure [dbo].[_TempCondicionesCompra_T]
@IdAux int
AS 
SELECT *
FROM _TempCondicionesCompra
WHERE (IdAux=@IdAux)







