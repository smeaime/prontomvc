
CREATE Procedure [dbo].[OrdenesTrabajo_TX_PorNumero]

@NumeroOrdenTrabajo varchar(20),
@IdOrdenTrabajo int = Null

AS 

SET @IdOrdenTrabajo=IsNull(@IdOrdenTrabajo,-1)

SELECT *
FROM OrdenesTrabajo
WHERE NumeroOrdenTrabajo=@NumeroOrdenTrabajo and 
	(@IdOrdenTrabajo=-1 or IdOrdenTrabajo<>@IdOrdenTrabajo)
