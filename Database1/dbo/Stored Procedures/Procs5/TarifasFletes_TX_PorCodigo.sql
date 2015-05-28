CREATE Procedure [dbo].[TarifasFletes_TX_PorCodigo]

@Codigo varchar(10),
@IdTarifaFlete int = Null

AS 

SET @IdTarifaFlete=IsNull(@IdTarifaFlete,-1)

SELECT *
FROM TarifasFletes
WHERE Codigo=@Codigo and (@IdTarifaFlete<=0 or IdTarifaFlete<>@IdTarifaFlete)