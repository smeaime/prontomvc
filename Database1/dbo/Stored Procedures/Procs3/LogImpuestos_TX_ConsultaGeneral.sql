
CREATE Procedure [dbo].[LogImpuestos_TX_ConsultaGeneral]

@FechaDesde datetime,
@FechaHasta datetime,
@TipoLog varchar(1) = Null,
@TipoMovimiento varchar(5) = Null

AS 

SET @TipoLog=IsNull(@TipoLog,'I')
SET @TipoMovimiento=IsNull(@TipoMovimiento,'')

DECLARE @vector_X varchar(50),@vector_T varchar(50)

IF @TipoLog='I'
    BEGIN
	SET @vector_X='000000111111111111111D33'
	SET @vector_T='000000821105555556666800'
	
	SELECT 
	 0 as [Aux1],
	 Proveedores.RazonSocial as [Aux2],
	 1 as [Aux3],
	 Lg.FechaProceso as [Aux4],
	 Lg.FechaLog as [Aux5],
	 Clientes.RazonSocial as [Aux6],
	 Lg.FechaProceso as [Fecha proc.],
	 Lg.ArchivoProcesado as [Archivo],
	 Proveedores.RazonSocial as [Proveedor],
	 Clientes.RazonSocial as [Cliente],
	 Case When Lg.ArchivoProcesado='RG830' 
		Then IGCondiciones.Descripcion 
		Else Null 
	 End as [Estado ganancias],
	 Case When Lg.ArchivoProcesado='RG830' 
		Then Lg.FechaLimiteExentoGanancias 
		Else Null
	 End as [Fec.Lim.Ex.Gan.],
	 Case When Lg.ArchivoProcesado='RG17' or Lg.ArchivoProcesado='RG2226' 
		Then Lg.IvaExencionRetencion 
		Else Null
	 End as [Exento Ret.IVA?],
	 Case When Lg.ArchivoProcesado='RG17' or Lg.ArchivoProcesado='RG2226' 
		Then Lg.IvaPorcentajeExencion 
		Else Null
	 End as [% Exencion Ret.IVA ],
	 Case When Lg.ArchivoProcesado='RG17' or Lg.ArchivoProcesado='RG2226' 
		Then Lg.IvaFechaCaducidadExencion 
		Else Null
	 End as [Fec.Lim.Ex.IVA],
	 Case When Lg.ArchivoProcesado='ReproWeb' 
		Then Lg.CodigoSituacionRetencionIVA 
		Else Null 
	 End as [Cod.Sit.Ret.IVA],
	 Case When Lg.ArchivoProcesado='SUSS' 
		Then Lg.SUSSFechaCaducidadExencion 
		Else Null 
	 End as [Fec.Lim.Ex.100% SUSS],
	 Lg.PorcentajeIBDirecto as [% IIBB],
	 Lg.FechaInicioVigenciaIBDirecto as [Fecha inic.IIBB],
	 Lg.FechaFinVigenciaIBDirecto as [Fecha fin IIBB],
	 Lg.GrupoIIBB as [Grupo IIBB],
	 Lg.FechaLog as [Fecha registracion],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM LogImpuestos Lg
	LEFT OUTER JOIN Proveedores ON Lg.IdProveedor=Proveedores.IdProveedor
	LEFT OUTER JOIN Clientes ON Lg.IdCliente=Clientes.IdCliente
	LEFT OUTER JOIN IGCondiciones ON Lg.IGCondicion = IGCondiciones.IdIGCondicion
	WHERE Lg.FechaProceso Between @FechaDesde And @FechaHasta
	
	UNION ALL
	
	SELECT 
	 0 as [Aux1],
	 Proveedores.RazonSocial as [Aux2],
	 2 as [Aux3],
	 Null as [Aux4],
	 Null as [Aux5],
	 Clientes.RazonSocial as [Aux6],
	 Null as [Fecha proc.],
	 Null as [Archivo],
	 Null as [Proveedor],
	 Null as [Cliente],
	 Null as [Estado ganancias],
	 Null as [Fec.Lim.Ex.Gan.],
	 Null as [Exento Ret.IVA?],
	 Null as [% Exencion Ret.IVA ],
	 Null as [Fec.Lim.Ex.IVA],
	 Null as [Cod.Sit.Ret.IVA],
	 Null as [Fec.Lim.Ex.100% SUSS],
	 Null as [% IIBB],
	 Null as [Fecha inic.IIBB],
	 Null as [Fecha fin IIBB],
	 Null as [Grupo IIBB],
	 Null as [Fecha registracion],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM LogImpuestos Lg
	LEFT OUTER JOIN Proveedores ON Lg.IdProveedor=Proveedores.IdProveedor
	LEFT OUTER JOIN Clientes ON Lg.IdCliente=Clientes.IdCliente
	LEFT OUTER JOIN IGCondiciones ON Lg.IGCondicion = IGCondiciones.IdIGCondicion
	WHERE Lg.FechaProceso Between @FechaDesde And @FechaHasta
	GROUP BY Proveedores.RazonSocial, Clientes.RazonSocial 
	
	ORDER BY [Aux2], [Aux6], [Aux3], [Aux4], [Aux5]
    END

IF @TipoLog='M'
    BEGIN
	SET @vector_X='011111133'
	SET @vector_T='03E242200'
	
	SELECT 
	 0 as [Aux1],
	 Lg.Tipo as [Tipo],
	 Case When Lg.Tipo='PED'
		Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)
		Else ''
	 End as [Comprobante],
	 P1.RazonSocial as [Proveedor],
	 Lg.FechaRegistro as [Fecha mov.],
	 Lg.Detalle as [Detalle],
	 E1.Nombre as [Usuario],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM Log Lg	LEFT OUTER JOIN Pedidos ON Lg.Tipo='PED' and Pedidos.IdPedido=Lg.IdComprobante
	LEFT OUTER JOIN Proveedores P1 ON Lg.Tipo='PED' and P1.IdProveedor=Pedidos.IdProveedor
	LEFT OUTER JOIN Empleados E1 ON Lg.Tipo='PED' and E1.IdEmpleado=Lg.AuxNum1
	WHERE (@TipoMovimiento='' or Lg.Tipo=@TipoMovimiento) and Lg.FechaRegistro Between @FechaDesde And @FechaHasta
	ORDER BY Lg.Tipo, Lg.FechaRegistro, [Comprobante]
    END
