﻿





























CREATE Procedure [dbo].[Familias_TX_SetearComoTransmitido]
AS 
Update Familias
SET EnviarEmail=0
WHERE EnviarEmail<>0






























