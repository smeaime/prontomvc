


CREATE Procedure [dbo].[DetObrasRecepciones_TX_PorIdObra]
@IdObra int
AS 
SELECT *
FROM [DetalleObrasRecepciones]
WHERE (IdObra=@IdObra)


