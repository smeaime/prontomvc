CREATE Procedure [dbo].[DetConciliaciones_T]

@IdDetalleConciliacion int

AS 

SELECT *
FROM [DetalleConciliaciones]
WHERE (IdDetalleConciliacion=@IdDetalleConciliacion)