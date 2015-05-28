/* 
 Procedimiento de obtención de Registro 
 Tabla: Vendedores
 Creado: 3/3/1999 19.44.57
*/
CREATE Procedure [dbo].[Vendedores_T]

@IdVendedor int

AS 

SELECT *
FROM Vendedores
WHERE (IdVendedor=@IdVendedor)