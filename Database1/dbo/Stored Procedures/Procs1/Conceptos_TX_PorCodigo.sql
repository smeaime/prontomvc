CREATE  Procedure [dbo].[Conceptos_TX_PorCodigo]

@CodigoConcepto int

AS 

SELECT *
FROM Conceptos 
WHERE (@CodigoConcepto=-1 or CodigoConcepto=@CodigoConcepto)