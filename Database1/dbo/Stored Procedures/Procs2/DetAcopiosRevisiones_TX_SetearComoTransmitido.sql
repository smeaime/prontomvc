﻿





























CREATE Procedure [dbo].[DetAcopiosRevisiones_TX_SetearComoTransmitido]
AS 
Update DetalleAcopiosRevisiones
SET EnviarEmail=0
WHERE EnviarEmail<>0






























