﻿





























CREATE Procedure [dbo].[DetAcopiosRevisiones_TX_ParaTransmitir]
AS 
SELECT * 
FROM DetalleAcopiosRevisiones
WHERE EnviarEmail=1






























