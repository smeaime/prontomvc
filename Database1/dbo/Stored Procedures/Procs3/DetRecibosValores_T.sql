﻿































CREATE Procedure [dbo].[DetRecibosValores_T]
@IdDetalleReciboValores int
AS 
SELECT *
FROM DetalleRecibosValores
where (IdDetalleReciboValores=@IdDetalleReciboValores)
































