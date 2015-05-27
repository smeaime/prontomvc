
CREATE Procedure [dbo].[CondicionesCompra_TL]
AS 
SELECT IdCondicionCompra, Descripcion as [Titulo]
FROM [Condiciones Compra]
ORDER BY Descripcion
