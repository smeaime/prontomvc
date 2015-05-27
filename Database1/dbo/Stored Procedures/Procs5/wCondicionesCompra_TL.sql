
CREATE Procedure [dbo].[wCondicionesCompra_TL]
AS 
SELECT IdCondicionCompra, Descripcion as [Titulo]
FROM [Condiciones Compra]
ORDER BY Descripcion

