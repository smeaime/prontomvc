



CREATE Procedure [dbo].[Grados_TX_PorDescripcion]
@Buscar varchar(250)
AS 
SELECT IdGrado
FROM Grados
WHERE UPPER(Descripcion)=UPPER(@Buscar)



