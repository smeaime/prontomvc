

CREATE  Procedure [dbo].[BZ_Pesadas_T]
@idPesada int
AS 

--SET @CodigoPresupuesto=IsNull(@CodigoPresupuesto,0)

SELECT *
FROM BZ_Pesadas p
WHERE (p.IdPesada=@IdPesada)

