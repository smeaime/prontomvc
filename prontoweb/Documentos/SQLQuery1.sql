

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





