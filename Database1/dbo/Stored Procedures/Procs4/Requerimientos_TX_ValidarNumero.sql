


















CREATE Procedure [dbo].[Requerimientos_TX_ValidarNumero]
@NumeroRequerimiento int,
@IdRequerimiento int
AS 
SELECT * 
FROM Requerimientos
WHERE (@IdRequerimiento<=0 or Requerimientos.IdRequerimiento<>@IdRequerimiento) and 
	 (NumeroRequerimiento=@NumeroRequerimiento)



















