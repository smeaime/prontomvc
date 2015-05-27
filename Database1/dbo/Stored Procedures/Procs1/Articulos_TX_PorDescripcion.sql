



CREATE Procedure [dbo].[Articulos_TX_PorDescripcion]
@Buscar varchar(250)
AS 
SELECT IdArticulo
FROM Articulos
WHERE UPPER(descripcion)=UPPER(@Buscar)



