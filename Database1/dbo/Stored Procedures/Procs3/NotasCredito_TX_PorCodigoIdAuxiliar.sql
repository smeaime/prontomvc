CREATE Procedure [dbo].[NotasCredito_TX_PorCodigoIdAuxiliar]

@CodigoIdAuxiliar int

AS 

SELECT *
FROM NotasCredito
WHERE IsNull(CodigoIdAuxiliar,0)=@CodigoIdAuxiliar