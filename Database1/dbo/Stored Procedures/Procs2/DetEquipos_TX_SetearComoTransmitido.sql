﻿





























CREATE Procedure [dbo].[DetEquipos_TX_SetearComoTransmitido]
AS 
Update DetalleEquipos
SET EnviarEmail=0
WHERE EnviarEmail<>0






























