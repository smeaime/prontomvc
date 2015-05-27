CREATE Procedure [dbo].[_TempFICTEC_4_TX_PorArticulo]

@Articulo varchar(13)

AS 

SELECT *
FROM _TempFICTEC_4
WHERE FT4ART=@Articulo
