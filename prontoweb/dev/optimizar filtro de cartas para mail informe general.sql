SET SHOWPLAN_ALL ON
GO

-- FMTONLY will not exec stored proc
SET FMTONLY ON
GO



  SELECT TOP 15000  CDP.*, 			cast (cdp.NumeroCartaDePorte as varchar) +					CASE WHEN cdp.numerosubfijo<>0 OR cdp.subnumerovagon<>0 THEN            '  ' + cast (cdp.numerosubfijo as varchar) + '/' +cast (cdp.subnumerovagon as varchar) 						ELSE             ''            End				as NumeroCompleto,			datediff(minute,cdp.FechaModificacion,GETDATE()) as MinutosModifico,  			ISNULL(Articulos.AuxiliarString5,'') AS EspecieONCAA,	  			ISNULL(Articulos.AuxiliarString6,'') AS CodigoSAJPYA,	  			ISNULL(Articulos.AuxiliarString7,'') AS txtCodigoZeni,	 			isnull(CLIVEN.Razonsocial,'') AS TitularDesc,             isnull(CLIVEN.cuit,'') AS TitularCUIT, 			isnull(CLICO1.Razonsocial,'') AS IntermediarioDesc,             isnull(CLICO1.cuit,'') AS IntermediarioCUIT, 			isnull(CLICO2.Razonsocial,'') AS RComercialDesc,             isnull(CLICO2.cuit,'') AS RComercialCUIT, 			isnull(CLICOR.Nombre,'') AS CorredorDesc,             isnull(CLICOR.cuit,'') AS CorredorCUIT, 			isnull(CLIENT.Razonsocial,'') AS DestinatarioDesc, 			isnull(CLIENTREG.Razonsocial,'') AS EntregadorDesc,             isnull(CLIENT.cuit,'') AS DestinatarioCUIT, 			isnull(CLIAUX.Razonsocial,'') AS ClienteAuxiliarDesc, 			isnull(CLISC1.Razonsocial,'') AS Subcontr1Desc,             isnull(CLISC2.Razonsocial,'') AS Subcontr2Desc,              isnull(Articulos.Descripcion,'') AS Producto, 			 Transportistas.cuit as  TransportistaCUIT,             isnull(Transportistas.RazonSocial,'') AS TransportistaDesc, 			choferes.cuil as  ChoferCUIT, 			choferes.Nombre as  ChoferDesc,            isnull(LOCORI.Nombre,'') AS ProcedenciaDesc, 		isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal, 		isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,            isnull(PROVORI.Nombre,'') AS ProcedenciaProvinciaDesc,        isnull(LOCDES.Descripcion,'') AS DestinoDesc,             '' AS  DestinoCodigoPostal, 			isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA,            DATENAME(month, FechaDescarga) AS Mes,           DATEPART(year, FechaDescarga) AS Ano,        	FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,            FAC.FechaFactura,           isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado,          isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT, 		Calidades.Descripcion AS CalidadDesc, 					E1.Nombre as UsuarioIngreso,isnull(ESTAB.Descripcion,'') COLLATE SQL_Latin1_General_CP1_CI_AS +' '+ isnull(ESTAB.AuxiliarString1,'') COLLATE SQL_Latin1_General_CP1_CI_AS+ ' '+ isnull(ESTAB.AuxiliarString2,'') COLLATE SQL_Latin1_General_CP1_CI_AS as EstablecimientoDesc    
  FROM    CartasDePorte CDP          
   INNER JOIN CartasDePorteMailClusters CLUST ON CDP.IdCartaDePorte = CLUST.IdCartaDePorte 
   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente        LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente        LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente        LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar= CLIAUX.IdCliente        LEFT OUTER JOIN Clientes CLIENTREG ON CDP.IdClienteEntregador= CLIENTREG.IdCliente        LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor        LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente         LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente          LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente          LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo           LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista 			LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad            LEFT OUTER JOIN Provincias PROVORI ON LOCORI.IdProvincia = PROVORI.IdProvincia            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino            LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento             LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura             LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente   LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado 
  
 
  --AND  CLUST.AgrupadorDeTandaPeriodos=5123

  WHERE 1=1              
  AND (Vendedor = 668           OR CuentaOrden1 = 668           
  OR CuentaOrden2 = 668             OR Corredor=-1             OR Entregador=668           OR idClienteAuxiliar = 668           ) 
   AND NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR CDP.IdArticulo IS NULL) 
   AND ISNULL(NetoProc,0)>0 AND ISNULL(CDP.Anulada,'NO')<>'SI'    
   AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') >= '20130101'     
   AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') <= '20130530'  
   AND ISNULL(CDP.SubnumeroDeFacturacion, 0) <= 0  
   AND NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR CDP.IdArticulo IS NULL) 
   AND ISNULL(NetoProc,0)>0 AND ISNULL(CDP.Anulada,'NO')<>'SI'
go



SET FMTONLY OFF
GO

SET SHOWPLAN_ALL OFF
GO



--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

select * from CartasDePorteMailClusters

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   --ver cómo hacer con el agrupador de envío de mails
   UPDATE CartasDePorte  SET AgrupadorDeTandaPeriodos=NULL  where  AgrupadorDeTandaPeriodos is NULL

   -- pero hace falta hacer un update en la misma tabla? no puedo apartar los id en una tabla temporal aparte??????


   CREATE NONCLUSTERED INDEX IDX_cartasdeporte_AgrupadorDeTandaPeriodos3
ON [dbo].cartasdeporte (AgrupadorDeTandaPeriodos)
GO





create table CartasDePorteMailClusters
(	
	IdCartaDePorte  int REFERENCES CartasDePorte(IdCartaDePorte),
	AgrupadorDeTandaPeriodos  int 
)
go

insert into CartasDePorteMailClusters
select idcartadeporte,AgrupadorDeTandaPeriodos=44444
FROM    CartasDePorte CDP           LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente        LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente        LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente        LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar= CLIAUX.IdCliente        LEFT OUTER JOIN Clientes CLIENTREG ON CDP.IdClienteEntregador= CLIENTREG.IdCliente        LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor        LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente         LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente          LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente          LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo           LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista 			LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad            LEFT OUTER JOIN Provincias PROVORI ON LOCORI.IdProvincia = PROVORI.IdProvincia            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino            LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento             LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura             LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente   LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado 
 WHERE 1=1              
  --AND (Vendedor = 668           OR CuentaOrden1 = 668           
  --OR CuentaOrden2 = 668             OR Corredor=-1             OR Entregador=668           OR idClienteAuxiliar = 668           ) 
   
   AND NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR CDP.IdArticulo IS NULL) 
   AND ISNULL(NetoProc,0)>0 AND ISNULL(CDP.Anulada,'NO')<>'SI'    
   AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') >= '20130101'     
   AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') <= '20130430'  
   AND ISNULL(CDP.SubnumeroDeFacturacion, 0) <= 0  
   AND NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR CDP.IdArticulo IS NULL) 
   AND ISNULL(NetoProc,0)>0 AND ISNULL(CDP.Anulada,'NO')<>'SI'

   go





   update CartasDePorte
   set AgrupadorDeTandaPeriodos=5123
FROM    CartasDePorte CDP           LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente        LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente        LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente        LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar= CLIAUX.IdCliente        LEFT OUTER JOIN Clientes CLIENTREG ON CDP.IdClienteEntregador= CLIENTREG.IdCliente        LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor        LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente         LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente          LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente          LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo           LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista 			LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad            LEFT OUTER JOIN Provincias PROVORI ON LOCORI.IdProvincia = PROVORI.IdProvincia            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino            LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento             LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura             LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente   LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado 
   WHERE 1=1              
     AND NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR CDP.IdArticulo IS NULL) 
   AND ISNULL(NetoProc,0)>0 AND ISNULL(CDP.Anulada,'NO')<>'SI'    
   AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') >= '20130101'     
   AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') <= '20130530'  
   AND ISNULL(CDP.SubnumeroDeFacturacion, 0) <= 0  
   AND NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR CDP.IdArticulo IS NULL) 
   AND ISNULL(NetoProc,0)>0 AND ISNULL(CDP.Anulada,'NO')<>'SI'

   go

     
	  update CartasDePorte   set AgrupadorDeTandaPeriodos=null  where not AgrupadorDeTandaPeriodos is null
	  go