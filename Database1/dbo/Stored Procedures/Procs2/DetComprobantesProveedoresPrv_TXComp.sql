﻿
CREATE PROCEDURE [dbo].[DetComprobantesProveedoresPrv_TXComp]

@IdComprobanteProveedor int

AS

Declare @vector_X varchar(60),@vector_T varchar(60)
Set @vector_X='001133'
Set @vector_T='001400'

SELECT 
 DetCom.IdDetalleComprobanteProveedorProvincias,
 DetCom.IdComprobanteProveedor,
 Provincias.Nombre as [Provincia destino],
 DetCom.Porcentaje as [Porcentaje],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleComprobantesProveedoresProvincias DetCom
LEFT OUTER JOIN Provincias ON DetCom.IdProvinciaDestino = Provincias.IdProvincia
WHERE DetCom.IdComprobanteProveedor=@IdComprobanteProveedor
