
CREATE Procedure [dbo].[Facturas_TX_PorCodigoIdAuxiliar]

@CodigoIdAuxiliar int

AS 

SELECT *
FROM Facturas
WHERE IsNull(CodigoIdAuxiliar,0)=@CodigoIdAuxiliar
