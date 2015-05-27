﻿




CREATE PROCEDURE [dbo].[DetNotasDebitoProvincias_TXDeb]

@IdNotaDebito int

AS

Declare @vector_X varchar(60),@vector_T varchar(60)
Set @vector_X='001133'
Set @vector_T='001400'

SELECT 
 DetDeb.IdDetalleNotaDebitoProvincias,
 DetDeb.IdNotaDebito,
 Provincias.Nombre as [Provincia destino],
 DetDeb.Porcentaje as [Porcentaje],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleNotasDebitoProvincias DetDeb
LEFT OUTER JOIN Provincias ON DetDeb.IdProvinciaDestino = Provincias.IdProvincia
WHERE DetDeb.IdNotaDebito=@IdNotaDebito




