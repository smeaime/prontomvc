CREATE Procedure [dbo].[Articulos_TX_PorCodigo]

@Codigo varchar(20)

AS 

SELECT *
FROM Articulos
WHERE IsNull(Articulos.Activo,'')<>'NO' and Codigo=@Codigo