﻿





























CREATE Procedure [dbo].[Subrubros_TX_SetearComoTransmitido]
AS 
Update Subrubros
SET EnviarEmail=0
WHERE EnviarEmail<>0






























