CREATE Procedure [dbo].[DetFletes_T]

@IdDetalleFlete int

AS 

SELECT *
FROM DetalleFletes
WHERE (IdDetalleFlete=@IdDetalleFlete)