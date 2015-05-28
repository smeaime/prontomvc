






























/* 
 Procedimiento de borrado de Registro 
 Tabla: Vendedores
 Creado: 3/3/1999 19.44.57
*/
CREATE Procedure [dbo].[Vendedores_E]
@IdVendedor tinyint  AS 
 Delete Vendedores
 where (IdVendedor=@IdVendedor)































