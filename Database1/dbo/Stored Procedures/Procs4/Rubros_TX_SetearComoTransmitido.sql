﻿






























CREATE Procedure [dbo].[Rubros_TX_SetearComoTransmitido]
AS 
Update Rubros
SET EnviarEmail=0
WHERE EnviarEmail<>0































