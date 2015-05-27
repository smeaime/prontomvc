
CREATE Procedure [dbo].[wArticulos_PorCodigo]
@Codigo varchar(20)
AS 
SELECT *
FROM Articulos
WHERE IsNull(Articulos.Activo,'')<>'NO' and Codigo=@Codigo

