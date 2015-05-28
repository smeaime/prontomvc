


CREATE Procedure [dbo].[OrdenesTrabajo_T]
@IdOrdenTrabajo int
AS 
SELECT *
FROM OrdenesTrabajo
WHERE (IdOrdenTrabajo=@IdOrdenTrabajo)


