﻿





























CREATE Procedure [dbo].[DetAcopios_TX_SetearComoTransmitido]
AS 
Update DetalleAcopios
SET EnviarEmail=0
WHERE EnviarEmail<>0






























