;WITH cte AS (        SELECT *,              ROW_NUMBER() OVER (PARTITION BY NumeroCartaDePorte,SubnumeroVagon ORDER BY IdCartaDePorte DESC) AS rn        FROM (   SELECT TOP 999999999  CDP.IdCartaDePorte, CDP.NumeroCartaDePorte, CDP.IdUsuarioIngreso, CDP.FechaIngreso, CDP.Anulada, CDP.IdUsuarioAnulo, CDP.FechaAnulacion, CDP.Observaciones, CDP.FechaTimeStamp, CDP.Vendedor, CDP.CuentaOrden1, CDP.CuentaOrden2, CDP.Corredor, CDP.Entregador, CDP.Procedencia, CDP.Patente, CDP.IdArticulo, CDP.IdStock, CDP.Partida, CDP.IdUnidad, CDP.IdUbicacion, CDP.Cantidad, CDP.Cupo, CDP.NetoProc, CDP.Calidad       ,CDP.BrutoPto      ,CDP.TaraPto      ,CDP.NetoPto      ,CDP.Acoplado      ,CDP.Humedad      ,CDP.Merma      ,CDP.NetoFinal      ,CDP.FechaDeCarga      ,CDP.FechaVencimiento      ,CDP.CEE      ,CDP.IdTransportista      ,CDP.TransportistaCUITdesnormalizado      ,CDP.IdChofer      ,CDP.ChoferCUITdesnormalizado      ,CDP.CTG      ,CDP.Contrato      ,CDP.Destino      ,CDP.Subcontr1      ,CDP.Subcontr2      ,CDP.Contrato1       ,CDP.contrato2      ,CDP.KmARecorrer      ,CDP.Tarifa      ,CDP.FechaDescarga      ,CDP.Hora      ,CDP.NRecibo      ,CDP.CalidadDe      ,CDP.TaraFinal      ,CDP.BrutoFinal      ,CDP.Fumigada      ,CDP.Secada      ,CDP.Exporta      ,CDP.NobleExtranos      ,CDP.NobleNegros      ,CDP.NobleQuebrados      ,CDP.NobleDaniados      ,CDP.NobleChamico      ,CDP.NobleChamico2      ,CDP.NobleRevolcado      ,CDP.NobleObjetables      ,CDP.NobleAmohosados      ,CDP.NobleHectolitrico      ,CDP.NobleCarbon       ,CDP.NoblePanzaBlanca      ,CDP.NoblePicados      ,CDP.NobleMGrasa      ,CDP.NobleAcidezGrasa      ,CDP.NobleVerdes      ,CDP.NobleGrado      ,CDP.NobleConforme      ,CDP.NobleACamara      ,CDP.Cosecha      ,CDP.HumedadDesnormalizada      ,CDP.Factor      ,CDP.IdFacturaImputada      ,CDP.PuntoVenta      ,CDP.SubnumeroVagon      ,CDP.TarifaFacturada      ,CDP.TarifaSubcontratista1      ,CDP.TarifaSubcontratista2      ,CDP.FechaArribo      ,CDP.Version      ,CDP.MotivoAnulacion       ,CDP.NumeroSubfijo      ,CDP.IdEstablecimiento      ,CDP.EnumSyngentaDivision      ,CDP.Corredor2      ,CDP.IdUsuarioModifico      ,CDP.FechaModificacion      ,CDP.FechaEmision      ,CDP.EstaArchivada      ,CDP.ExcluirDeSubcontratistas      ,CDP.IdTipoMovimiento      ,CDP.IdClienteAFacturarle      ,CDP.SubnumeroDeFacturacion      ,CDP.AgregaItemDeGastosAdministrativos      ,CDP.CalidadGranosQuemados      ,CDP.CalidadGranosQuemadosBonifica_o_Rebaja      ,CDP.CalidadTierra      ,CDP.CalidadTierraBonifica_o_Rebaja      ,CDP.CalidadMermaChamico       ,CDP.CalidadMermaChamicoBonifica_o_Rebaja      ,CDP.CalidadMermaZarandeo      ,CDP.CalidadMermaZarandeoBonifica_o_Rebaja      ,CDP.FueraDeEstandar      ,CDP.CalidadPuntaSombreada      ,CDP.CobraAcarreo      ,CDP.LiquidaViaje      ,CDP.IdClienteAuxiliar      ,CDP.CalidadDescuentoFinal      ,CDP.PathImagen      ,CDP.PathImagen2       ,CDP.AgrupadorDeTandaPeriodos      ,CDP.ClaveEncriptada      ,CDP.NumeroCartaEnTextoParaBusqueda      ,CDP.IdClienteEntregador      ,CDP.IdDetalleFactura      ,CDP.SojaSustentableCodCondicion      ,CDP.SojaSustentableCondicion      ,CDP.SojaSustentableNroEstablecimientoDeProduccion      ,CDP.IdClientePagadorFlete      ,CDP.SubnumeroVagonEnTextoParaBusqueda      ,CDP.IdCorredor2       ,CDP.Acopio1      ,CDP.Acopio2      ,CDP.Acopio3      ,CDP.Acopio4      ,CDP.Acopio5 ,CDP.Acopio6        ,CDP.AcopioFacturarleA      ,CDP.CalidadGranosDanadosRebaja      ,CDP.CalidadGranosExtranosRebaja , 			cast (cdp.NumeroCartaDePorte as varchar) +					CASE WHEN cdp.numerosubfijo<>0 OR cdp.subnumerovagon<>0 THEN            '  ' + cast (cdp.numerosubfijo as varchar) + '/' +cast (cdp.subnumerovagon as varchar) 						ELSE             ''            End				as NumeroCompleto,			datediff(minute,cdp.FechaModificacion,GETDATE()) as MinutosModifico,  			ISNULL(Articulos.AuxiliarString5,'') AS EspecieONCAA,	  			ISNULL(Articulos.AuxiliarString6,'') AS CodigoSAJPYA,	  			ISNULL(Articulos.AuxiliarString7,'') AS txtCodigoZeni,	 			isnull(CLIVEN.Razonsocial,'') AS TitularDesc,             isnull(CLIVEN.cuit,'') AS TitularCUIT, 			isnull(CLICO1.Razonsocial,'') AS IntermediarioDesc,             isnull(CLICO1.cuit,'') AS IntermediarioCUIT, 			isnull(CLICO2.Razonsocial,'') AS RComercialDesc,             isnull(CLICO2.cuit,'') AS RComercialCUIT, 			isnull(CLICOR.Nombre,'') AS CorredorDesc,             isnull(CLICOR.cuit,'') AS CorredorCUIT, 			isnull(CLIENT.Razonsocial,'') AS DestinatarioDesc, 			isnull(CLIENTREG.Razonsocial,'') AS EntregadorDesc,             isnull(CLIENT.cuit,'') AS DestinatarioCUIT, 			isnull(CLIAUX.Razonsocial,'') AS ClienteAuxiliarDesc, 			isnull(CLIAUX.cuit,'') AS ClienteAuxiliarCUIT, 			isnull(CLISC1.Razonsocial,'') AS Subcontr1Desc,             isnull(CLISC2.Razonsocial,'') AS Subcontr2Desc,              isnull(Articulos.Descripcion,'') AS Producto, 			 Transportistas.cuit as  TransportistaCUIT,             isnull(Transportistas.RazonSocial,'') AS TransportistaDesc, 			choferes.cuil as  ChoferCUIT, 			choferes.Nombre as  ChoferDesc,            isnull(LOCORI.Nombre,'') AS ProcedenciaDesc, 		isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal, 		isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,            isnull(PROVORI.Nombre,'') AS ProcedenciaProvinciaDesc,        isnull(LOCDES.Descripcion,'') AS DestinoDesc,             '' AS  DestinoCodigoPostal, 			isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA,            DATENAME(month, FechaDescarga) AS Mes,           DATEPART(year, FechaDescarga) AS Ano,        	FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,            FAC.FechaFactura,           isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado,          isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT, 		Calidades.Descripcion AS CalidadDesc, 	    E1.Nombre as UsuarioIngreso,isnull(ESTAB.Descripcion,'') COLLATE SQL_Latin1_General_CP1_CI_AS +' '+ isnull(ESTAB.AuxiliarString1,'') COLLATE SQL_Latin1_General_CP1_CI_AS+ ' '+ isnull(ESTAB.AuxiliarString2,'') COLLATE SQL_Latin1_General_CP1_CI_AS                                                                                                 as EstablecimientoDesc, 			isnull(CLIENTFLET.Razonsocial,'') AS ClientePagadorFleteDesc ,           isnull(LOCORI.Partido,'') AS ProcedenciaProvinciaPartido,      isnull(PARTORI.Codigo,'') AS ProcedenciaPartidoNormalizadaCodigo,    isnull(PROVDEST.Nombre,'') AS DestinoProvinciaDesc,   isnull(PARTORI.Nombre,'') AS ProcedenciaPartidoNormalizada   , 			isnull(CLICOR2.Nombre,'') AS CorredorDesc2,             isnull(CLICOR2.cuit,'') AS CorredorCUIT2, 			isnull(CLIENTREG.cuit,'') AS EntregadorCUIT, 		isnull(LOCORI.CodigoAFIP,'') AS CodigoAFIP, 		CDPDET.Valor as MermaVolatil   FROM    CartasDePorte CDP           LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente        LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente        LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente        LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar= CLIAUX.IdCliente        LEFT OUTER JOIN Clientes CLIENTREG ON CDP.IdClienteEntregador= CLIENTREG.IdCliente        LEFT OUTER JOIN Clientes CLIENTFLET ON CDP.IdClientePagadorFlete= CLIENTFLET.IdCliente        LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor        LEFT OUTER JOIN Vendedores CLICOR2 ON CDP.Corredor2 = CLICOR2.IdVendedor        LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente         LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente          LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente          LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo           LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista 			LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad            LEFT OUTER JOIN Provincias PROVORI ON LOCORI.IdProvincia = PROVORI.IdProvincia            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino            LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento             LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura             LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente             LEFT OUTER JOIN Partidos PARTORI ON LOCORI.IdPartido = PARTORI.IdPartido             LEFT OUTER JOIN Provincias PROVDEST ON LOCDES.IdProvincia = PROVDEST.IdProvincia   LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado  LEFT OUTER JOIN CartasDePorteDetalle CDPDET ON CDP.IdCartaDePorte = CDPDET.IdCartaDePorte And CDPDET.Campo = 'CalidadMermaVolatilMerma'   WHERE 1=1     AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') >= '20161001'     AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') <= '20171101'  and EXISTS ( SELECT * FROM CartasDePorte COPIAS  where COPIAS.NumeroCartaDePorte=CDP.NumeroCartaDePorte and COPIAS.SubnumeroVagon=CDP.SubnumeroVagon   AND ISNULL(COPIAS.Anulada,'NO')<>'SI'  )  AND ISNULL(CDP.SubnumeroDeFacturacion, 0) <= 0        ) as cartas ) SELECT * FROM cte WHERE rn = 1  AND  ( replace(TitularCUIT,'-','')  IN ('20268165178','20081166383','20237107870','20179767326','30707451013','30669360750','30712119698','30712362819','23230854149','xxxxxxxxxxx','27147533174','27126988066','20207552489','20249152553','20176398397','30712353097','30510718441','20131091355','20360613993','20247000802','20236840442','20147000465','20084947025','23341768993','30712420029','20345673513','20121201225' )  OR replace(IntermediarioCUIT,'-','') IN ('20268165178','20081166383','20237107870','20179767326','30707451013','30669360750','30712119698','30712362819','23230854149','xxxxxxxxxxx','27147533174','27126988066','20207552489','20249152553','20176398397','30712353097','30510718441','20131091355','20360613993','20247000802','20236840442','20147000465','20084947025','23341768993','30712420029','20345673513','20121201225' )  OR replace(RComercialCUIT,'-','') IN ('20268165178','20081166383','20237107870','20179767326','30707451013','30669360750','30712119698','30712362819','23230854149','xxxxxxxxxxx','27147533174','27126988066','20207552489','20249152553','20176398397','30712353097','30510718441','20131091355','20360613993','20247000802','20236840442','20147000465','20084947025','23341768993','30712420029','20345673513','20121201225' ) )


;WITH cte AS (        SELECT *,              ROW_NUMBER() OVER (PARTITION BY NumeroCartaDePorte,SubnumeroVagon ORDER BY IdCartaDePorte DESC) AS rn        FROM (   SELECT TOP 100000  
CDP.IdCartaDePorte, CDP.NumeroCartaDePorte, CDP.IdUsuarioIngreso, CDP.FechaIngreso, CDP.Anulada, CDP.IdUsuarioAnulo, CDP.FechaAnulacion, CDP.Observaciones, CDP.FechaTimeStamp, CDP.Vendedor, CDP.CuentaOrden1, CDP.CuentaOrden2, CDP.Corredor, CDP.Entregador, CDP.Procedencia, CDP.Patente, CDP.IdArticulo, CDP.IdStock, CDP.Partida, CDP.IdUnidad, CDP.IdUbicacion, CDP.Cantidad, CDP.Cupo, CDP.NetoProc, CDP.Calidad       ,CDP.BrutoPto      ,CDP.TaraPto      ,CDP.NetoPto      ,CDP.Acoplado      ,CDP.Humedad      ,CDP.Merma      ,CDP.NetoFinal      ,CDP.FechaDeCarga      ,CDP.FechaVencimiento      ,CDP.CEE      ,CDP.IdTransportista      ,CDP.TransportistaCUITdesnormalizado      ,CDP.IdChofer      ,CDP.ChoferCUITdesnormalizado      ,CDP.CTG      ,CDP.Contrato      ,CDP.Destino      ,CDP.Subcontr1      ,CDP.Subcontr2      ,CDP.Contrato1       ,CDP.contrato2      ,CDP.KmARecorrer      ,CDP.Tarifa      ,CDP.FechaDescarga      ,CDP.Hora      ,CDP.NRecibo      ,CDP.CalidadDe      ,CDP.TaraFinal      ,CDP.BrutoFinal      ,CDP.Fumigada      ,CDP.Secada      ,CDP.Exporta      ,CDP.NobleExtranos      ,CDP.NobleNegros      ,CDP.NobleQuebrados      ,CDP.NobleDaniados      ,CDP.NobleChamico      ,CDP.NobleChamico2      ,CDP.NobleRevolcado      ,CDP.NobleObjetables      ,CDP.NobleAmohosados      ,CDP.NobleHectolitrico      ,CDP.NobleCarbon       ,CDP.NoblePanzaBlanca      ,CDP.NoblePicados      ,CDP.NobleMGrasa      ,CDP.NobleAcidezGrasa      ,CDP.NobleVerdes      ,CDP.NobleGrado      ,CDP.NobleConforme      ,
CDP.NobleACamara      ,CDP.Cosecha      ,CDP.HumedadDesnormalizada      ,CDP.Factor      ,CDP.IdFacturaImputada      ,CDP.PuntoVenta      ,CDP.SubnumeroVagon      ,CDP.TarifaFacturada      ,CDP.TarifaSubcontratista1      ,CDP.TarifaSubcontratista2      ,CDP.FechaArribo      ,CDP.Version      ,CDP.MotivoAnulacion       ,CDP.NumeroSubfijo      ,CDP.IdEstablecimiento      ,CDP.EnumSyngentaDivision      ,CDP.Corredor2      ,CDP.IdUsuarioModifico      ,CDP.FechaModificacion      ,CDP.FechaEmision      ,CDP.EstaArchivada      ,CDP.ExcluirDeSubcontratistas      ,CDP.IdTipoMovimiento      ,CDP.IdClienteAFacturarle      ,CDP.SubnumeroDeFacturacion      ,CDP.AgregaItemDeGastosAdministrativos      ,CDP.CalidadGranosQuemados      ,CDP.CalidadGranosQuemadosBonifica_o_Rebaja      ,CDP.CalidadTierra      ,CDP.CalidadTierraBonifica_o_Rebaja      ,CDP.CalidadMermaChamico       ,CDP.CalidadMermaChamicoBonifica_o_Rebaja      ,CDP.CalidadMermaZarandeo      ,CDP.CalidadMermaZarandeoBonifica_o_Rebaja      ,CDP.FueraDeEstandar      ,CDP.CalidadPuntaSombreada      ,CDP.CobraAcarreo      ,CDP.LiquidaViaje      ,CDP.IdClienteAuxiliar      ,CDP.CalidadDescuentoFinal      ,CDP.PathImagen      ,CDP.PathImagen2       ,CDP.AgrupadorDeTandaPeriodos      ,CDP.ClaveEncriptada      ,CDP.NumeroCartaEnTextoParaBusqueda      ,CDP.IdClienteEntregador      ,CDP.IdDetalleFactura      ,CDP.SojaSustentableCodCondicion      ,CDP.SojaSustentableCondicion      ,CDP.SojaSustentableNroEstablecimientoDeProduccion      ,CDP.IdClientePagadorFlete      ,CDP.SubnumeroVagonEnTextoParaBusqueda      ,CDP.IdCorredor2       ,CDP.Acopio1      ,CDP.Acopio2      ,CDP.Acopio3      ,CDP.Acopio4      ,CDP.Acopio5 ,CDP.Acopio6        ,CDP.AcopioFacturarleA      ,CDP.CalidadGranosDanadosRebaja      ,CDP.CalidadGranosExtranosRebaja , 			cast (cdp.NumeroCartaDePorte as varchar) +					CASE WHEN cdp.numerosubfijo<>0 OR cdp.subnumerovagon<>0 THEN            '  ' + cast (cdp.numerosubfijo as varchar) + '/' +cast (cdp.subnumerovagon as varchar) 		
				ELSE             ''            End				as NumeroCompleto,			datediff(minute,cdp.FechaModificacion,GETDATE()) as MinutosModifico,  			ISNULL(Articulos.AuxiliarString5,'') AS EspecieONCAA,	  			ISNULL(Articulos.AuxiliarString6,'') AS CodigoSAJPYA,	  			ISNULL(Articulos.AuxiliarString7,'') AS txtCodigoZeni,	 			isnull(CLIVEN.Razonsocial,'') AS TitularDesc,             isnull(CLIVEN.cuit,'') AS TitularCUIT, 			isnull(CLICO1.Razonsocial,'') AS IntermediarioDesc,             isnull(CLICO1.cuit,'') AS IntermediarioCUIT, 			isnull(CLICO2.Razonsocial,'') AS RComercialDesc,             isnull(CLICO2.cuit,'') AS RComercialCUIT, 			isnull(CLICOR.Nombre,'') AS CorredorDesc,             isnull(CLICOR.cuit,'') AS CorredorCUIT, 			isnull(CLIENT.Razonsocial,'') AS DestinatarioDesc, 			isnull(CLIENTREG.Razonsocial,'') AS EntregadorDesc,             isnull(CLIENT.cuit,'') AS DestinatarioCUIT, 			isnull(CLIAUX.Razonsocial,'') AS ClienteAuxiliarDesc, 			isnull(CLIAUX.cuit,'') AS ClienteAuxiliarCUIT, 			isnull(CLISC1.Razonsocial,'') AS Subcontr1Desc,             isnull(CLISC2.Razonsocial,'') AS Subcontr2Desc,              isnull(Articulos.Descripcion,'') AS Producto, 			 Transportistas.cuit as  TransportistaCUIT,             isnull(Transportistas.RazonSocial,'') AS TransportistaDesc, 			choferes.cuil as  ChoferCUIT, 			choferes.Nombre as  ChoferDesc,            isnull(LOCORI.Nombre,'') AS ProcedenciaDesc, 		isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal, 		isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,            isnull(PROVORI.Nombre,'') AS ProcedenciaProvinciaDesc,        isnull(LOCDES.Descripcion,'') AS DestinoDesc,             '' AS  DestinoCodigoPostal, 			isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA,            DATENAME(month, FechaDescarga) AS Mes,           DATEPART(year, FechaDescarga) AS Ano,        	FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,            FAC.FechaFactura,           isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado,          isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT, 		Calidades.Descripcion AS CalidadDesc, 	    E1.Nombre as UsuarioIngreso,isnull(ESTAB.Descripcion,'') COLLATE SQL_Latin1_General_CP1_CI_AS +' '+ isnull(ESTAB.AuxiliarString1,'') COLLATE SQL_Latin1_General_CP1_CI_AS+ ' '+ isnull(ESTAB.AuxiliarString2,'') COLLATE SQL_Latin1_General_CP1_CI_AS                                                                                                 as EstablecimientoDesc, 			isnull(CLIENTFLET.Razonsocial,'') AS ClientePagadorFleteDesc ,           isnull(LOCORI.Partido,'') AS ProcedenciaProvinciaPartido,      isnull(PARTORI.Codigo,'') AS ProcedenciaPartidoNormalizadaCodigo,    isnull(PROVDEST.Nombre,'') AS DestinoProvinciaDesc,   isnull(PARTORI.Nombre,'') AS ProcedenciaPartidoNormalizada   , 			isnull(CLICOR2.Nombre,'') AS CorredorDesc2,             isnull(CLICOR2.cuit,'') AS CorredorCUIT2, 			isnull(CLIENTREG.cuit,'') AS EntregadorCUIT, 		isnull(LOCORI.CodigoAFIP,'') AS CodigoAFIP, 		CDPDET.Valor as MermaVolatil   FROM    CartasDePorte CDP           LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente        LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente        LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente        LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar= CLIAUX.IdCliente        LEFT OUTER JOIN Clientes CLIENTREG ON CDP.IdClienteEntregador= CLIENTREG.IdCliente        LEFT OUTER JOIN Clientes CLIENTFLET ON CDP.IdClientePagadorFlete= CLIENTFLET.IdCliente        LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor        LEFT OUTER JOIN Vendedores CLICOR2 ON CDP.Corredor2 = CLICOR2.IdVendedor        LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente         LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente          LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente          LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo           LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista 			LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad            LEFT OUTER JOIN Provincias PROVORI ON LOCORI.IdProvincia = PROVORI.IdProvincia            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino            LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento             LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura             LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente             LEFT OUTER JOIN Partidos PARTORI ON LOCORI.IdPartido = PARTORI.IdPartido             LEFT OUTER JOIN Provincias PROVDEST ON LOCDES.IdProvincia = PROVDEST.IdProvincia   LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado  LEFT OUTER JOIN CartasDePorteDetalle CDPDET ON CDP.IdCartaDePorte = CDPDET.IdCartaDePorte And CDPDET.Campo = 'CalidadMermaVolatilMerma'   WHERE 1=1     AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') >= '20161001'     AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') <= '20161101'  and EXISTS ( SELECT * FROM CartasDePorte COPIAS  where COPIAS.NumeroCartaDePorte=CDP.NumeroCartaDePorte and COPIAS.SubnumeroVagon=CDP.SubnumeroVagon   AND ISNULL(COPIAS.Anulada,'NO')<>'SI'  )  AND ISNULL(CDP.SubnumeroDeFacturacion, 0) <= 0        ) as cartas ) SELECT * FROM cte WHERE rn = 1  AND  ( replace(TitularCUIT,'-','')  IN ('20268165178','20081166383','20237107870','20179767326','30707451013','30669360750','30712119698','30712362819','23230854149','xxxxxxxxxxx','27147533174','27126988066','20207552489','20249152553','20176398397','30712353097','30510718441','20131091355','20360613993','20247000802','20236840442','20147000465','20084947025','23341768993','30712420029','20345673513','20121201225' )  OR replace(IntermediarioCUIT,'-','') IN ('20268165178','20081166383','20237107870','20179767326','30707451013','30669360750','30712119698','30712362819','23230854149','xxxxxxxxxxx','27147533174','27126988066','20207552489','20249152553','20176398397','30712353097','30510718441','20131091355','20360613993','20247000802','20236840442','20147000465','20084947025','23341768993','30712420029','20345673513','20121201225' )  OR replace(RComercialCUIT,'-','') IN ('20268165178','20081166383','20237107870','20179767326','30707451013','30669360750','30712119698','30712362819','23230854149','xxxxxxxxxxx','27147533174','27126988066','20207552489','20249152553','20176398397','30712353097','30510718441','20131091355','20360613993','20247000802','20236840442','20147000465','20084947025','23341768993','30712420029','20345673513','20121201225' ) )

select cuit from clientes
where replace(cuit,'-','')= '20287880430'



select top 10 * from cartasdeporte where fechaactualizacionautomatica is not null




select top 10 * from cartasdeporte order by fechadescarga desc

select max(fechamodificacion) from cartasdeporte 


	declare @startRowIndex int,@maximumRows int,@estado int,@QueContenga nvarchar(4000),@idVendedor int,@idCorredor int,@idDestinatario int,@idIntermediario int,@idRemComercial int,@idArticulo int,@idProcedencia int,@idDestino int,@AplicarANDuORalFiltro int,@ModoExportacion nvarchar(4000),@fechadesde datetime2(7),@fechahasta datetime2(7),@puntoventa int,@IdAcopio int,@Contrato nvarchar(4000),@QueContenga2 nvarchar(4000),@idClienteAuxiliarint int,@AgrupadorDeTandaPeriodos int,@Vagon int,@Patente nvarchar(4000),@optCamionVagon nvarchar(4000)
	
	
	select @startRowIndex=0,@maximumRows=9999999,@estado=0,@QueContenga=N'',@idVendedor=-1,@idCorredor=-1,@idDestinatario=-1,
	@idIntermediario=-1,@idRemComercial=-1,@idArticulo=-1,@idProcedencia=-1,@idDestino=-1,@AplicarANDuORalFiltro=0,@ModoExportacion=N'Ambas',
	@fechadesde='2016-12-29 00:00:00',@fechahasta='2050-01-01 00:00:00',
	@puntoventa=0,@IdAcopio=NULL,@Contrato=N'',@QueContenga2=N'',@idClienteAuxiliarint=-1,@AgrupadorDeTandaPeriodos=NULL,@Vagon=0,@Patente=N'',@optCamionVagon=N'Todos'


	select * from fSQL_GetDataTableFiltradoYPaginado(@startRowIndex, @maximumRows, @estado, @QueContenga, @idVendedor, @idCorredor, @idDestinatario, @idIntermediario, @idRemComercial, @idArticulo, @idProcedencia, @idDestino, @AplicarANDuORalFiltro, @ModoExportacion, @fechadesde, @fechahasta, @puntoventa, @IdAcopio, @Contrato, @QueContenga2, @idClienteAuxiliarint, @AgrupadorDeTandaPeriodos, @Vagon, @Patente, @optCamionVagon)



select SubnumeroVagon,* from cartasdeporte where fechaarribo> (getdate()-15)

--update cartasdeporte
--set SubnumeroVagon=0
-- where fechaarribo> (getdate()-10)
	

SELECT 
	-- TOP (@maximumRows)  --creo que no puedo usar top con parametros en una TVF
	 CDP.*,
-- CDP.IdCartaDePorte, CDP.NumeroCartaDePorte, CDP.IdUsuarioIngreso, CDP.FechaIngreso, 
-- CDP.Anulada, CDP.IdUsuarioAnulo, CDP.FechaAnulacion, CDP.Observaciones, CDP.FechaTimeStamp, CDP.Vendedor, CDP.CuentaOrden1, 
-- CDP.CuentaOrden2, CDP.Corredor, CDP.Entregador, CDP.Procedencia, CDP.Patente, CDP.IdArticulo, CDP.IdStock, CDP.Partida, CDP.IdUnidad, 
-- CDP.IdUbicacion, CDP.Cantidad, CDP.Cupo, CDP.NetoProc, CDP.Calidad       ,CDP.BrutoPto      ,CDP.TaraPto      ,CDP.NetoPto      
--,CDP.Acoplado      ,CDP.Humedad      ,CDP.Merma      ,CDP.NetoFinal      ,CDP.FechaDeCarga      ,CDP.FechaVencimiento      ,CDP.CEE  
--,CDP.IdTransportista      ,CDP.TransportistaCUITdesnormalizado      ,CDP.IdChofer      ,CDP.ChoferCUITdesnormalizado      ,CDP.CTG  
--,CDP.Contrato      ,CDP.Destino      ,CDP.Subcontr1      ,CDP.Subcontr2      ,CDP.Contrato1       ,CDP.contrato2      ,CDP.KmARecorrer
--,CDP.Tarifa      ,CDP.FechaDescarga      ,CDP.Hora      ,CDP.NRecibo      ,CDP.CalidadDe      ,CDP.TaraFinal     
--,CDP.BrutoFinal      ,CDP.Fumigada      ,CDP.Secada      ,CDP.Exporta      ,CDP.NobleExtranos      ,CDP.NobleNegros
--,CDP.NobleQuebrados      ,CDP.NobleDaniados      ,CDP.NobleChamico      ,CDP.NobleChamico2      ,CDP.NobleRevolcado
--,CDP.NobleObjetables      ,CDP.NobleAmohosados      ,CDP.NobleHectolitrico      ,CDP.NobleCarbon      
--,CDP.NoblePanzaBlanca      ,CDP.NoblePicados      ,CDP.NobleMGrasa      ,CDP.NobleAcidezGrasa     
--,CDP.NobleVerdes      ,CDP.NobleGrado      ,CDP.NobleConforme      ,CDP.NobleACamara      ,CDP.Cosecha 
--,CDP.HumedadDesnormalizada      ,CDP.Factor      ,CDP.IdFacturaImputada      ,CDP.PuntoVenta   
--,CDP.SubnumeroVagon      ,CDP.TarifaFacturada      ,CDP.TarifaSubcontratista1     
--,CDP.TarifaSubcontratista2      ,CDP.FechaArribo      ,CDP.[Version]      ,CDP.MotivoAnulacion 
--,CDP.NumeroSubfijo      ,CDP.IdEstablecimiento      ,CDP.EnumSyngentaDivision   
--,CDP.Corredor2      ,CDP.IdUsuarioModifico      ,CDP.FechaModificacion      
--,CDP.FechaEmision      ,CDP.EstaArchivada      ,CDP.ExcluirDeSubcontratistas   
--,CDP.IdTipoMovimiento      ,CDP.IdClienteAFacturarle      ,CDP.SubnumeroDeFacturacion   
--,CDP.AgregaItemDeGastosAdministrativos      ,CDP.CalidadGranosQuemados      ,CDP.CalidadGranosQuemadosBonifica_o_Rebaja      
--,CDP.CalidadTierra      ,CDP.CalidadTierraBonifica_o_Rebaja      ,CDP.CalidadMermaChamico       
--,CDP.CalidadMermaChamicoBonifica_o_Rebaja      ,CDP.CalidadMermaZarandeo      
--,CDP.CalidadMermaZarandeoBonifica_o_Rebaja      ,CDP.FueraDeEstandar      ,CDP.CalidadPuntaSombreada    
--,CDP.CobraAcarreo      ,CDP.LiquidaViaje      ,CDP.IdClienteAuxiliar      ,CDP.CalidadDescuentoFinal   
--,CDP.PathImagen      ,CDP.PathImagen2       ,CDP.AgrupadorDeTandaPeriodos      ,CDP.ClaveEncriptada     
--,CDP.NumeroCartaEnTextoParaBusqueda      ,CDP.IdClienteEntregador      ,CDP.IdDetalleFactura     
--,CDP.SojaSustentableCodCondicion      ,CDP.SojaSustentableCondicion     
--,CDP.SojaSustentableNroEstablecimientoDeProduccion      ,CDP.IdClientePagadorFlete     
--,CDP.SubnumeroVagonEnTextoParaBusqueda      ,CDP.IdCorredor2       ,CDP.Acopio1      ,CDP.Acopio2    
--,CDP.Acopio3      ,CDP.Acopio4      ,CDP.Acopio5 ,CDP.Acopio6        ,CDP.AcopioFacturarleA      
--,CDP.CalidadGranosDanadosRebaja      ,CDP.CalidadGranosExtranosRebaja , 			
cast (cdp.NumeroCartaDePorte as varchar) +					
				CASE WHEN cdp.numerosubfijo<>0 OR cdp.subnumerovagon<>0 
					THEN            '  ' + cast (cdp.numerosubfijo as varchar) + '/' +cast (cdp.subnumerovagon as varchar) 						
					ELSE             ''            
				End	
	as NumeroCompleto,
datediff(minute,cdp.FechaModificacion,GETDATE()) as MinutosModifico,  		
ISNULL(Articulos.AuxiliarString5,'') AS EspecieONCAA,	  	
ISNULL(Articulos.AuxiliarString6,'') AS CodigoSAJPYA,	  			
ISNULL(Articulos.AuxiliarString7,'') AS txtCodigoZeni,	 		

isnull(CLIVEN.Razonsocial,'') AS TitularDesc,             isnull(CLIVEN.cuit,'') AS TitularCUIT,
isnull(CLICO1.Razonsocial,'') AS IntermediarioDesc,             isnull(CLICO1.cuit,'') AS IntermediarioCUIT, 		
isnull(CLICO2.Razonsocial,'') AS RComercialDesc,             isnull(CLICO2.cuit,'') AS RComercialCUIT, 			
isnull(CLICOR.Nombre,'') AS CorredorDesc,             
isnull(CLICOR.cuit,'') AS CorredorCUIT, 			isnull(CLIENT.Razonsocial,'') AS DestinatarioDesc, 		
isnull(CLIENTREG.Razonsocial,'') AS EntregadorDesc,             isnull(CLIENT.cuit,'') AS DestinatarioCUIT, 		
isnull(CLIAUX.Razonsocial,'') AS ClienteAuxiliarDesc, 		
isnull(CLIAUX.cuit,'') AS ClienteAuxiliarCUIT, 			isnull(CLISC1.Razonsocial,'') AS Subcontr1Desc,        
isnull(CLISC2.Razonsocial,'') AS Subcontr2Desc,              isnull(Articulos.Descripcion,'') AS Producto, 			

Transportistas.cuit as  TransportistaCUIT,         
isnull(Transportistas.RazonSocial,'') AS TransportistaDesc, 		
choferes.cuil as  ChoferCUIT, 			
choferes.Nombre as  ChoferDesc,

isnull(LOCORI.Nombre,'') AS ProcedenciaDesc, 	
isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal, 		
isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,      
isnull(PROVORI.Nombre,'') AS ProcedenciaProvinciaDesc,    

isnull(LOCDES.Descripcion,'') AS DestinoDesc, 
isnull(LOCDES.CodigoPostal,'')  AS  DestinoCodigoPostal, 	
isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA,
isnull(LOCDES.CUIT,'') 	 AS  DestinoCUIT,
isnull(LOCDES2.CodigoAFIP,'') 	 AS  DestinoLocalidadAFIP,


DATENAME(month, FechaDescarga) AS Mes,          
DATEPART(year, FechaDescarga) AS Ano,        	
FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,
FAC.FechaFactura,         
isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado,          
isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT, 		
Calidades.Descripcion AS CalidadDesc, 	    
E1.Nombre as UsuarioIngreso,


isnull(ESTAB.Descripcion,'') COLLATE SQL_Latin1_General_CP1_CI_AS +' '
	+ isnull(ESTAB.AuxiliarString1,'') COLLATE SQL_Latin1_General_CP1_CI_AS+ ' '
	+ isnull(ESTAB.AuxiliarString2,'') COLLATE SQL_Latin1_General_CP1_CI_AS as EstablecimientoDesc, 			
ESTAB.Descripcion  as EstablecimientoCodigo,
ESTAB.AuxiliarString2  as EstablecimientoCUIT,
ESTAB.AuxiliarString1 as EstablecimientoNombre,


isnull(CLIENTFLET.Razonsocial,'') AS ClientePagadorFleteDesc ,           isnull(LOCORI.Partido,'') AS ProcedenciaProvinciaPartido, 
isnull(PARTORI.Codigo,'') AS ProcedenciaPartidoNormalizadaCodigo,    isnull(PROVDEST.Nombre,'') AS DestinoProvinciaDesc,  
isnull(PARTORI.Nombre,'') AS ProcedenciaPartidoNormalizada   , 			isnull(CLICOR2.Nombre,'') AS CorredorDesc2,    
isnull(CLICOR2.cuit,'') AS CorredorCUIT2, 			isnull(CLIENTREG.cuit,'') AS EntregadorCUIT, 		
isnull(LOCORI.CodigoAFIP,'') AS CodigoAFIP



FROM    CartasDePorte CDP          
LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente       
LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente   
LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente       
LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar= CLIAUX.IdCliente     
LEFT OUTER JOIN Clientes CLIENTREG ON CDP.IdClienteEntregador= CLIENTREG.IdCliente  
LEFT OUTER JOIN Clientes CLIENTFLET ON CDP.IdClientePagadorFlete= CLIENTFLET.IdCliente        
LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor       
LEFT OUTER JOIN Vendedores CLICOR2 ON CDP.Corredor2 = CLICOR2.IdVendedor       
LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente         
LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente         
LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente         
LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo         
LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad        
LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista 			
LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer            
LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad          
LEFT OUTER JOIN Provincias PROVORI ON LOCORI.IdProvincia = PROVORI.IdProvincia           

LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
LEFT OUTER JOIN Localidades LOCDES2 ON LOCDES.IdLocalidad = LOCDES2.IdLocalidad          

LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento        
LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura            
LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente             
LEFT OUTER JOIN Partidos PARTORI ON LOCORI.IdPartido = PARTORI.IdPartido          
LEFT OUTER JOIN Provincias PROVDEST ON LOCDES.IdProvincia = PROVDEST.IdProvincia  
LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado  
			

where 1=1              


			
	
	AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') >= @fechadesde
	AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') <= @fechahasta







	--LENTOS




	AND EXISTS ( SELECT * FROM CartasDePorte COPIAS  
			where COPIAS.NumeroCartaDePorte=CDP.NumeroCartaDePorte
			and COPIAS.SubnumeroVagon=CDP.SubnumeroVagon    
			and (
				@ModoExportacion is null
				or (@ModoExportacion = 'Ambos' or @ModoExportacion = 'Ambas') 
				Or (@ModoExportacion = 'Todos') 
				Or (@ModoExportacion = 'Entregas' And isnull(COPIAS.Exporta, 'NO') = 'NO' AND ISNULL(COPIAS.Anulada,'NO')<>'SI') 
				Or (@ModoExportacion = 'Export' And isnull(COPIAS.Exporta, 'NO') = 'SI' AND ISNULL(COPIAS.Anulada,'NO')<>'SI')
						
			) 
		)
	--FIN LENTOS

		

	

		

go


























exec sp_executesql N'SELECT 
    1 AS [C1], 
    [Project3].[NumeroCartaDePorte] AS [NumeroCartaDePorte], 
    [Project3].[IdCartaDePorte] AS [IdCartaDePorte], 
    [Project3].[FechaDescarga] AS [FechaDescarga], 
    [Project3].[NetoFinal] AS [NetoFinal], 
    CASE WHEN ([Project3].[Subcontr1] IS NULL) THEN [Project3].[Subcontratista1] ELSE [Project3].[Subcontr1] END AS [C2], 
    CASE WHEN ([Project3].[Subcontr2] IS NULL) THEN [Project3].[Subcontratista2] ELSE [Project3].[Subcontr2] END AS [C3], 
    CASE WHEN (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)) THEN CASE WHEN ((CASE WHEN (CASE WHEN (0 = [Project3].[SubnumeroVagon]) THEN cast(1 as bit) WHEN ( NOT ((0 = [Project3].[SubnumeroVagon]) AND ([Project3].[SubnumeroVagon] IS NOT NULL))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (0 = [Project3].[SubnumeroVagon]) THEN cast(1 as bit) WHEN ( NOT ((0 = [Project3].[SubnumeroVagon]) AND ([Project3].[SubnumeroVagon] IS NOT NULL))) THEN cast(0 as bit) END) = 1) THEN N''Camiones'' ELSE N''Vagones'' END ELSE N'''' END AS [C4], 
    [Project3].[ExcluirDeSubcontratistas] AS [ExcluirDeSubcontratistas], 
    [Project3].[SubnumeroDeFacturacion] AS [SubnumeroDeFacturacion], 
    [Project3].[TitularDesc] AS [TitularDesc], 
    [Project3].[IntermediarioDesc] AS [IntermediarioDesc], 
    [Project3].[RComercialDesc] AS [RComercialDesc], 
    [Project3].[CorredorDesc] AS [CorredorDesc], 
    [Project3].[EntregadorDesc] AS [EntregadorDesc], 
    [Project3].[ProcedenciaDesc] AS [ProcedenciaDesc], 
    [Project3].[Descripcion] AS [Descripcion], 
    [Project3].[RazonSocial] AS [RazonSocial], 
    [Project3].[RazonSocial1] AS [RazonSocial1], 
    CASE WHEN (CASE WHEN (''SI'' = [Project3].[Exporta]) THEN CASE WHEN ((CASE WHEN (CASE WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END) = 1) THEN [Project3].[PrecioCaladaExportacion] ELSE [Project3].[PrecioVagonesCaladaExportacion] END WHEN ((CASE WHEN (CASE WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END) = 1) THEN [Project3].[PrecioCaladaLocal] ELSE [Project3].[PrecioVagonesCalada] END IS NULL) THEN cast(0 as decimal(18)) WHEN (''SI'' = [Project3].[Exporta]) THEN CASE WHEN ((CASE WHEN (CASE WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END) = 1) THEN [Project3].[PrecioCaladaExportacion] ELSE [Project3].[PrecioVagonesCaladaExportacion] END WHEN ((CASE WHEN (CASE WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END) = 1) THEN [Project3].[PrecioCaladaLocal] ELSE [Project3].[PrecioVagonesCalada] END AS [C5], 
    CASE WHEN (CASE WHEN (''SI'' = [Project3].[Exporta]) THEN CASE WHEN ((CASE WHEN (CASE WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END) = 1) THEN CASE WHEN ((CASE WHEN (CASE WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioDescargaExportacion]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioDescargaExportacion]) AND ([Limit2].[PrecioDescargaExportacion] IS NOT NULL))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioDescargaExportacion]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioDescargaExportacion]) AND ([Limit2].[PrecioDescargaExportacion] IS NOT NULL))) THEN cast(0 as bit) END) = 1) THEN [Limit2].[PrecioCaladaExportacion] ELSE [Limit2].[PrecioDescargaExportacion] END WHEN ((CASE WHEN (CASE WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanzaExportacion]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanzaExportacion]) AND ([Limit2].[PrecioVagonesBalanzaExportacion] IS NOT NULL))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanzaExportacion]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanzaExportacion]) AND ([Limit2].[PrecioVagonesBalanzaExportacion] IS NOT NULL))) THEN cast(0 as bit) END) = 1) THEN [Limit2].[PrecioVagonesCaladaExportacion] ELSE [Limit2].[PrecioVagonesBalanzaExportacion] END WHEN ((CASE WHEN (CASE WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END) = 1) THEN CASE WHEN ((CASE WHEN (CASE WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioDescargaLocal]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioDescargaLocal]) AND ([Limit2].[PrecioDescargaLocal] IS NOT NULL))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioDescargaLocal]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioDescargaLocal]) AND ([Limit2].[PrecioDescargaLocal] IS NOT NULL))) THEN cast(0 as bit) END) = 1) THEN [Limit2].[PrecioCaladaLocal] ELSE [Limit2].[PrecioDescargaLocal] END WHEN ((CASE WHEN (CASE WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanza]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanza]) AND ([Limit2].[PrecioVagonesBalanza] IS NOT NULL))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanza]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanza]) AND ([Limit2].[PrecioVagonesBalanza] IS NOT NULL))) THEN cast(0 as bit) END) = 1) THEN [Limit2].[PrecioVagonesCalada] ELSE [Limit2].[PrecioVagonesBalanza] END IS NULL) THEN cast(0 as decimal(18)) WHEN (''SI'' = [Project3].[Exporta]) THEN CASE WHEN ((CASE WHEN (CASE WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END) = 1) THEN CASE WHEN ((CASE WHEN (CASE WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioDescargaExportacion]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioDescargaExportacion]) AND ([Limit2].[PrecioDescargaExportacion] IS NOT NULL))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioDescargaExportacion]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioDescargaExportacion]) AND ([Limit2].[PrecioDescargaExportacion] IS NOT NULL))) THEN cast(0 as bit) END) = 1) THEN [Limit2].[PrecioCaladaExportacion] ELSE [Limit2].[PrecioDescargaExportacion] END WHEN ((CASE WHEN (CASE WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanzaExportacion]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanzaExportacion]) AND ([Limit2].[PrecioVagonesBalanzaExportacion] IS NOT NULL))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanzaExportacion]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanzaExportacion]) AND ([Limit2].[PrecioVagonesBalanzaExportacion] IS NOT NULL))) THEN cast(0 as bit) END) = 1) THEN [Limit2].[PrecioVagonesCaladaExportacion] ELSE [Limit2].[PrecioVagonesBalanzaExportacion] END WHEN ((CASE WHEN (CASE WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL)))) THEN cast(1 as bit) WHEN ( NOT (([Project3].[SubnumeroVagon] <= 0) OR ( NOT (([Project3].[Destino] IN (54, 55, 58, 62, 69)) AND ([Project3].[Destino] IS NOT NULL))))) THEN cast(0 as bit) END) = 1) THEN CASE WHEN ((CASE WHEN (CASE WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioDescargaLocal]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioDescargaLocal]) AND ([Limit2].[PrecioDescargaLocal] IS NOT NULL))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioDescargaLocal]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioDescargaLocal]) AND ([Limit2].[PrecioDescargaLocal] IS NOT NULL))) THEN cast(0 as bit) END) = 1) THEN [Limit2].[PrecioCaladaLocal] ELSE [Limit2].[PrecioDescargaLocal] END WHEN ((CASE WHEN (CASE WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanza]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanza]) AND ([Limit2].[PrecioVagonesBalanza] IS NOT NULL))) THEN cast(0 as bit) END IS NULL) THEN cast(0 as bit) WHEN (cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanza]) THEN cast(1 as bit) WHEN ( NOT ((cast(0 as decimal(18)) = [Limit2].[PrecioVagonesBalanza]) AND ([Limit2].[PrecioVagonesBalanza] IS NOT NULL))) THEN cast(0 as bit) END) = 1) THEN [Limit2].[PrecioVagonesCalada] ELSE [Limit2].[PrecioVagonesBalanza] END AS [C6], 
    [Project3].[Exporta] AS [Exporta], 
    [Project3].[Corredor] AS [Corredor], 
    CASE WHEN ([Project3].[IdClienteEntregador] IS NULL) THEN 0 ELSE [Project3].[IdClienteEntregador] END AS [C7]
    FROM   (SELECT 
        [Project1].[IdCartaDePorte] AS [IdCartaDePorte], 
        [Project1].[NumeroCartaDePorte] AS [NumeroCartaDePorte], 
        [Project1].[Vendedor] AS [Vendedor], 
        [Project1].[CuentaOrden1] AS [CuentaOrden1], 
        [Project1].[CuentaOrden2] AS [CuentaOrden2], 
        [Project1].[Corredor] AS [Corredor], 
        [Project1].[Entregador] AS [Entregador], 
        [Project1].[IdArticulo] AS [IdArticulo], 
        [Project1].[NetoFinal] AS [NetoFinal], 
        [Project1].[Destino] AS [Destino], 
        [Project1].[Subcontr1] AS [Subcontr1], 
        [Project1].[Subcontr2] AS [Subcontr2], 
        [Project1].[FechaDescarga] AS [FechaDescarga], 
        [Project1].[Exporta] AS [Exporta], 
        [Project1].[PuntoVenta] AS [PuntoVenta], 
        [Project1].[SubnumeroVagon] AS [SubnumeroVagon], 
        [Project1].[ExcluirDeSubcontratistas] AS [ExcluirDeSubcontratistas], 
        [Project1].[SubnumeroDeFacturacion] AS [SubnumeroDeFacturacion], 
        [Project1].[IdClienteEntregador] AS [IdClienteEntregador], 
        [Project1].[TitularDesc] AS [TitularDesc], 
        [Project1].[IntermediarioDesc] AS [IntermediarioDesc], 
        [Project1].[RComercialDesc] AS [RComercialDesc], 
        [Project1].[CorredorDesc] AS [CorredorDesc], 
        [Project1].[EntregadorDesc] AS [EntregadorDesc], 
        [Project1].[ProcedenciaDesc] AS [ProcedenciaDesc], 
        [Project1].[Descripcion] AS [Descripcion], 
        [Project1].[Subcontratista1] AS [Subcontratista1], 
        [Project1].[Subcontratista2] AS [Subcontratista2], 
        [Project1].[RazonSocial] AS [RazonSocial], 
        [Project1].[RazonSocial1] AS [RazonSocial1], 
        [Limit1].[PrecioCaladaLocal] AS [PrecioCaladaLocal], 
        [Limit1].[PrecioCaladaExportacion] AS [PrecioCaladaExportacion], 
        [Limit1].[PrecioVagonesCalada] AS [PrecioVagonesCalada], 
        [Limit1].[PrecioVagonesCaladaExportacion] AS [PrecioVagonesCaladaExportacion], 
        [Extent7].[IdListaPrecios] AS [IdListaPrecios]
        FROM    (SELECT 
            [Extent1].[IdCartaDePorte] AS [IdCartaDePorte], 
            [Extent1].[NumeroCartaDePorte] AS [NumeroCartaDePorte], 
            [Extent1].[Vendedor] AS [Vendedor], 
            [Extent1].[CuentaOrden1] AS [CuentaOrden1], 
            [Extent1].[CuentaOrden2] AS [CuentaOrden2], 
            [Extent1].[Corredor] AS [Corredor], 
            [Extent1].[Entregador] AS [Entregador], 
            [Extent1].[IdArticulo] AS [IdArticulo], 
            [Extent1].[NetoFinal] AS [NetoFinal], 
            [Extent1].[Destino] AS [Destino], 
            [Extent1].[Subcontr1] AS [Subcontr1], 
            [Extent1].[Subcontr2] AS [Subcontr2], 
            [Extent1].[FechaDescarga] AS [FechaDescarga], 
            [Extent1].[Exporta] AS [Exporta], 
            [Extent1].[PuntoVenta] AS [PuntoVenta], 
            [Extent1].[SubnumeroVagon] AS [SubnumeroVagon], 
            [Extent1].[ExcluirDeSubcontratistas] AS [ExcluirDeSubcontratistas], 
            [Extent1].[SubnumeroDeFacturacion] AS [SubnumeroDeFacturacion], 
            [Extent1].[IdClienteEntregador] AS [IdClienteEntregador], 
            [Extent1].[TitularDesc] AS [TitularDesc], 
            [Extent1].[IntermediarioDesc] AS [IntermediarioDesc], 
            [Extent1].[RComercialDesc] AS [RComercialDesc], 
            [Extent1].[CorredorDesc] AS [CorredorDesc], 
            [Extent1].[EntregadorDesc] AS [EntregadorDesc], 
            [Extent1].[ProcedenciaDesc] AS [ProcedenciaDesc], 
            [Extent2].[Descripcion] AS [Descripcion], 
            [Extent2].[Subcontratista1] AS [Subcontratista1], 
            [Extent2].[Subcontratista2] AS [Subcontratista2], 
            [Extent3].[RazonSocial] AS [RazonSocial], 
            [Extent4].[RazonSocial] AS [RazonSocial1], 
            [Extent4].[IdListaPrecios] AS [IdListaPrecios], 
            [Extent5].[IdListaPrecios] AS [IdListaPrecios1]
            FROM     [dbo].[fSQL_GetDataTableFiltradoYPaginado](@startRowIndex, @maximumRows, @estado, @QueContenga, @idVendedor, @idCorredor, @idDestinatario, @idIntermediario, @idRemComercial, @idArticulo, @idProcedencia, @idDestino, @AplicarANDuORalFiltro, @ModoExportacion, @fechadesde, @fechahasta, @puntoventa, @IdAcopio, @bTraerDuplicados, @Contrato, @QueContenga2, @idClienteAuxiliarint, @AgrupadorDeTandaPeriodos, @Vagon, @Patente, @optCamionVagon) AS [Extent1]
            LEFT OUTER JOIN [dbo].[WilliamsDestinos] AS [Extent2] ON [Extent2].[IdWilliamsDestino] = (CASE WHEN ([Extent1].[Destino] IS NULL) THEN 0 ELSE [Extent1].[Destino] END)
            LEFT OUTER JOIN [dbo].[Clientes] AS [Extent3] ON [Extent3].[IdCliente] = (CASE WHEN ([Extent1].[Subcontr1] IS NULL) THEN [Extent2].[Subcontratista1] ELSE [Extent1].[Subcontr1] END)
            LEFT OUTER JOIN [dbo].[Clientes] AS [Extent4] ON [Extent4].[IdCliente] = (CASE WHEN ([Extent1].[Subcontr2] IS NULL) THEN [Extent2].[Subcontratista2] ELSE [Extent1].[Subcontr2] END)
            LEFT OUTER JOIN [dbo].[ListasPrecios] AS [Extent5] ON [Extent5].[IdListaPrecios] = [Extent3].[IdListaPrecios] ) AS [Project1]
        OUTER APPLY  (SELECT TOP (1) [Project2].[PrecioCaladaLocal] AS [PrecioCaladaLocal], [Project2].[PrecioCaladaExportacion] AS [PrecioCaladaExportacion], [Project2].[PrecioVagonesCalada] AS [PrecioVagonesCalada], [Project2].[PrecioVagonesCaladaExportacion] AS [PrecioVagonesCaladaExportacion]
            FROM ( SELECT 
                [Extent6].[PrecioCaladaLocal] AS [PrecioCaladaLocal], 
                [Extent6].[PrecioCaladaExportacion] AS [PrecioCaladaExportacion], 
                [Extent6].[IdCliente] AS [IdCliente], 
                [Extent6].[PrecioVagonesCalada] AS [PrecioVagonesCalada], 
                [Extent6].[PrecioVagonesCaladaExportacion] AS [PrecioVagonesCaladaExportacion]
                FROM [dbo].[ListasPreciosDetalle] AS [Extent6]
                WHERE (([Extent6].[IdListaPrecios] = [Project1].[IdListaPrecios1]) OR (([Extent6].[IdListaPrecios] IS NULL) AND ([Project1].[IdListaPrecios1] IS NULL))) AND (([Extent6].[IdArticulo] = [Project1].[IdArticulo]) OR (([Extent6].[IdArticulo] IS NULL) AND ([Project1].[IdArticulo] IS NULL))) AND (([Extent6].[IdCliente] IS NULL) OR ([Extent6].[IdCliente] = [Project1].[Vendedor]) OR (([Extent6].[IdCliente] IS NULL) AND ([Project1].[Vendedor] IS NULL)) OR ([Extent6].[IdCliente] = [Project1].[Entregador]) OR (([Extent6].[IdCliente] IS NULL) AND ([Project1].[Entregador] IS NULL)) OR ([Extent6].[IdCliente] = [Project1].[CuentaOrden1]) OR (([Extent6].[IdCliente] IS NULL) AND ([Project1].[CuentaOrden1] IS NULL)) OR ([Extent6].[IdCliente] = [Project1].[CuentaOrden2]) OR (([Extent6].[IdCliente] IS NULL) AND ([Project1].[CuentaOrden2] IS NULL)))
            )  AS [Project2]
            ORDER BY [Project2].[IdCliente] DESC ) AS [Limit1]
        LEFT OUTER JOIN [dbo].[ListasPrecios] AS [Extent7] ON [Extent7].[IdListaPrecios] = [Project1].[IdListaPrecios] ) AS [Project3]
    OUTER APPLY  (SELECT TOP (1) [Project4].[PrecioDescargaLocal] AS [PrecioDescargaLocal], [Project4].[PrecioDescargaExportacion] AS [PrecioDescargaExportacion], [Project4].[PrecioCaladaLocal] AS [PrecioCaladaLocal], [Project4].[PrecioCaladaExportacion] AS [PrecioCaladaExportacion], [Project4].[PrecioVagonesBalanza] AS [PrecioVagonesBalanza], [Project4].[PrecioVagonesCalada] AS [PrecioVagonesCalada], [Project4].[PrecioVagonesBalanzaExportacion] AS [PrecioVagonesBalanzaExportacion], [Project4].[PrecioVagonesCaladaExportacion] AS [PrecioVagonesCaladaExportacion]
        FROM ( SELECT 
            [Extent8].[PrecioDescargaLocal] AS [PrecioDescargaLocal], 
            [Extent8].[PrecioDescargaExportacion] AS [PrecioDescargaExportacion], 
            [Extent8].[PrecioCaladaLocal] AS [PrecioCaladaLocal], 
            [Extent8].[PrecioCaladaExportacion] AS [PrecioCaladaExportacion], 
            [Extent8].[IdCliente] AS [IdCliente], 
            [Extent8].[PrecioVagonesBalanza] AS [PrecioVagonesBalanza], 
            [Extent8].[PrecioVagonesCalada] AS [PrecioVagonesCalada], 
            [Extent8].[PrecioVagonesBalanzaExportacion] AS [PrecioVagonesBalanzaExportacion], 
            [Extent8].[PrecioVagonesCaladaExportacion] AS [PrecioVagonesCaladaExportacion]
            FROM [dbo].[ListasPreciosDetalle] AS [Extent8]
            WHERE (([Extent8].[IdListaPrecios] = [Project3].[IdListaPrecios]) OR (([Extent8].[IdListaPrecios] IS NULL) AND ([Project3].[IdListaPrecios] IS NULL))) AND (([Extent8].[IdArticulo] = [Project3].[IdArticulo]) OR (([Extent8].[IdArticulo] IS NULL) AND ([Project3].[IdArticulo] IS NULL))) AND (([Extent8].[IdCliente] IS NULL) OR ([Extent8].[IdCliente] = [Project3].[Vendedor]) OR (([Extent8].[IdCliente] IS NULL) AND ([Project3].[Vendedor] IS NULL)) OR ([Extent8].[IdCliente] = [Project3].[Entregador]) OR (([Extent8].[IdCliente] IS NULL) AND ([Project3].[Entregador] IS NULL)) OR ([Extent8].[IdCliente] = [Project3].[CuentaOrden1]) OR (([Extent8].[IdCliente] IS NULL) AND ([Project3].[CuentaOrden1] IS NULL)) OR ([Extent8].[IdCliente] = [Project3].[CuentaOrden2]) OR (([Extent8].[IdCliente] IS NULL) AND ([Project3].[CuentaOrden2] IS NULL)))
        )  AS [Project4]
        ORDER BY [Project4].[IdCliente] DESC ) AS [Limit2]
    --WHERE (@p__linq__0 = -1 OR @p__linq__1 = (CASE WHEN ([Project3].[Subcontr1] IS NULL) THEN [Project3].[Subcontratista1] ELSE [Project3].[Subcontr1] END) OR @p__linq__2 = (CASE WHEN ([Project3].[Subcontr2] IS NULL) THEN [Project3].[Subcontratista2] ELSE [Project3].[Subcontr2] END)) AND (@p__linq__3 = -1 OR [Project3].[PuntoVenta] = @p__linq__4)',
	
	
	
	--declare @startRowIndex int,@maximumRows int,@estado int,@QueContenga nvarchar(4000),@idVendedor int,@idCorredor int,@idDestinatario int,@idIntermediario int,@idRemComercial int,@idArticulo int,@idProcedencia int,@idDestino int,@AplicarANDuORalFiltro int,@ModoExportacion nvarchar(4000),@fechadesde datetime2(7),@fechahasta datetime2(7),@puntoventa int,@IdAcopio int,@bTraerDuplicados bit,@Contrato nvarchar(4000),@QueContenga2 nvarchar(4000),@idClienteAuxiliarint int,@AgrupadorDeTandaPeriodos int,@Vagon int,@Patente nvarchar(4000),@optCamionVagon nvarchar(4000),@p__linq__0 int,@p__linq__1 int,@p__linq__2 int,@p__linq__3 int,@p__linq__4 int
	--select 	@startRowIndex=NULL,@maximumRows=NULL,@estado=NULL,@QueContenga=NULL,@idVendedor=-1,@idCorredor=-1,@idDestinatario=-1,@idIntermediario=-1,@idRemComercial=-1,@idArticulo=-1,@idProcedencia=-1,@idDestino=90,@AplicarANDuORalFiltro=1,@ModoExportacion=N'Ambos',@fechadesde='2016-12-01 00:00:00',@fechahasta='2016-12-31 00:00:00',@puntoventa=-1,@IdAcopio=NULL,@bTraerDuplicados=0,@Contrato=NULL,@QueContenga2=NULL,@idClienteAuxiliarint=NULL,@AgrupadorDeTandaPeriodos=NULL,@Vagon=NULL,@Patente=NULL,@optCamionVagon=NULL,@p__linq__0=-1,@p__linq__1=-1,@p__linq__2=-1,@p__linq__3=-1,@p__linq__4=-1

	--select * from [dbo].[fSQL_GetDataTableFiltradoYPaginado](@startRowIndex, @maximumRows, @estado, @QueContenga, @idVendedor, @idCorredor, @idDestinatario, @idIntermediario, @idRemComercial, @idArticulo, @idProcedencia, @idDestino, @AplicarANDuORalFiltro, @ModoExportacion, @fechadesde, @fechahasta, @puntoventa, @IdAcopio, @bTraerDuplicados, @Contrato, @QueContenga2, @idClienteAuxiliarint, @AgrupadorDeTandaPeriodos, @Vagon, @Patente, @optCamionVagon) AS [Extent1] order by numerocartadeporte
            