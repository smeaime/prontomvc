﻿CREATE Procedure [dbo].[OrdenesCompra_M]

@IdOrdenCompra int,
@NumeroOrdenCompra int,
@IdCliente int,
@FechaOrdenCompra datetime,
@IdCondicionVenta int,
@Anulada varchar(2),
@FechaAnulacion datetime,
@Observaciones ntext,
@ImporteTotal numeric(18,2),
@ArchivoAdjunto1 varchar(100),
@ArchivoAdjunto2 varchar(100),
@ArchivoAdjunto3 varchar(100),
@ArchivoAdjunto4 varchar(100),
@ArchivoAdjunto5 varchar(100),
@ArchivoAdjunto6 varchar(100),
@ArchivoAdjunto7 varchar(100),
@ArchivoAdjunto8 varchar(100),
@ArchivoAdjunto9 varchar(100),
@ArchivoAdjunto10 varchar(100),
@NumeroOrdenCompraCliente varchar(20),
@IdObra int,
@IdMoneda int,
@IdUsuarioAnulacion int,
@AgrupacionFacturacion int,
@Agrupacion2Facturacion int,
@SeleccionadaParaFacturacion varchar(2),
@PorcentajeBonificacion numeric(6,2),
@IdListaPrecios int,
@IdUsuarioIngreso int,
@FechaIngreso datetime,
@IdUsuarioModifico int,
@FechaModifico datetime,
@Aprobo int,
@FechaAprobacion datetime,
@CircuitoFirmasCompleto varchar(2),
@IdDetalleClienteLugarEntrega int,
@Estado varchar(2),
@IdUsuarioCambioEstado int,
@FechaCambioEstado datetime

AS

UPDATE OrdenesCompra
SET 
 NumeroOrdenCompra=@NumeroOrdenCompra,
 IdCliente=@IdCliente,
 FechaOrdenCompra=@FechaOrdenCompra,
 IdCondicionVenta=@IdCondicionVenta,
 Anulada=@Anulada,
 FechaAnulacion=@FechaAnulacion,
 Observaciones=@Observaciones,
 ImporteTotal=@ImporteTotal,
 ArchivoAdjunto1=@ArchivoAdjunto1,
 ArchivoAdjunto2=@ArchivoAdjunto2,
 ArchivoAdjunto3=@ArchivoAdjunto3,
 ArchivoAdjunto4=@ArchivoAdjunto4,
 ArchivoAdjunto5=@ArchivoAdjunto5,
 ArchivoAdjunto6=@ArchivoAdjunto6,
 ArchivoAdjunto7=@ArchivoAdjunto7,
 ArchivoAdjunto8=@ArchivoAdjunto8,
 ArchivoAdjunto9=@ArchivoAdjunto9,
 ArchivoAdjunto10=@ArchivoAdjunto10,
 NumeroOrdenCompraCliente=@NumeroOrdenCompraCliente,
 IdObra=@IdObra,
 IdMoneda=@IdMoneda,
 IdUsuarioAnulacion=@IdUsuarioAnulacion,
 AgrupacionFacturacion=@AgrupacionFacturacion,
 Agrupacion2Facturacion=@Agrupacion2Facturacion,
 SeleccionadaParaFacturacion=@SeleccionadaParaFacturacion,
 PorcentajeBonificacion=@PorcentajeBonificacion,
 IdListaPrecios=@IdListaPrecios,
 IdUsuarioIngreso=@IdUsuarioIngreso,
 FechaIngreso=@FechaIngreso,
 IdUsuarioModifico=@IdUsuarioModifico,
 FechaModifico=@FechaModifico,
 Aprobo=@Aprobo,
 FechaAprobacion=@FechaAprobacion,
 CircuitoFirmasCompleto=@CircuitoFirmasCompleto,
 IdDetalleClienteLugarEntrega=@IdDetalleClienteLugarEntrega,
 Estado=@Estado,
 IdUsuarioCambioEstado=@IdUsuarioCambioEstado,
 FechaCambioEstado=@FechaCambioEstado
WHERE (IdOrdenCompra=@IdOrdenCompra)

RETURN(@IdOrdenCompra)