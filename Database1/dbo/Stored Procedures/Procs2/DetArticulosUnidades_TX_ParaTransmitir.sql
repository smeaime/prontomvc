
CREATE Procedure [dbo].[DetArticulosUnidades_TX_ParaTransmitir]

@Cuales varchar(1) = Null

AS 

SET @Cuales=IsNull(@Cuales,'T')

SELECT *
FROM DetalleArticulosUnidades
WHERE @Cuales='T' or (@Cuales<>'T' and IsNull(EnviarEmail,1)=1)
