






























CREATE Procedure [dbo].[Requerimientos_TX_PorNumero]
@NumeroRequerimiento int
AS 
SELECT * 
FROM Requerimientos
WHERE (NumeroRequerimiento=@NumeroRequerimiento)































