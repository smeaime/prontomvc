﻿























CREATE Procedure [dbo].[DetOtrosIngresosAlmacen_E]
@IdDetalleOtroIngresoAlmacen int  AS 
Delete [DetalleOtrosIngresosAlmacen]
Where (IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen)
























