﻿





























CREATE Procedure [dbo].[Equipos_TX_SetearComoTransmitido]
AS 
Update Equipos
SET EnviarEmail=0
WHERE EnviarEmail<>0






























