﻿





























CREATE Procedure [dbo].[Planos_TX_SetearComoTransmitido]
AS 
Update Planos
SET EnviarEmail=0
WHERE EnviarEmail<>0






























