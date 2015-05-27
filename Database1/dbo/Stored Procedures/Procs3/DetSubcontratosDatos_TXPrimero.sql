﻿
CREATE PROCEDURE [dbo].[DetSubcontratosDatos_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0011133'
SET @vector_T='0034100'

SELECT TOP 1
 Det.IdDetalleSubcontratoDatos,
 Det.IdSubcontratoDatos,
 Det.NumeroCertificado as [Nro.Certificado],
 Det.FechaCertificado as [Fecha certificado],
 Det.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleSubcontratosDatos Det
