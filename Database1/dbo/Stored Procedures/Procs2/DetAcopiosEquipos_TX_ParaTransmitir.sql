﻿





























CREATE Procedure [dbo].[DetAcopiosEquipos_TX_ParaTransmitir]
AS 
SELECT * 
FROM DetalleAcopiosEquipos
WHERE EnviarEmail=1






























