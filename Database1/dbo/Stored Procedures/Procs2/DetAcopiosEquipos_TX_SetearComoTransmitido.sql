﻿





























CREATE Procedure [dbo].[DetAcopiosEquipos_TX_SetearComoTransmitido]
AS 
Update DetalleAcopiosEquipos
SET EnviarEmail=0
WHERE EnviarEmail<>0






























