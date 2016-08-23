

--https://blogs.msdn.microsoft.com/psssql/2010/10/28/query-performance-and-multi-statement-table-valued-functions/
--If you use inline TVF, it�s like you are just using a view and if it takes parameter, it�s like a parameterized view.   
--The final SQL plan will not have any reference to the TVF itself.  Instead, all the referenced objects will be in the final plan.



if OBJECT_ID ('fSQL_GetDataTableFiltradoYPaginado') is not null 
    drop function fSQL_GetDataTableFiltradoYPaginado 
go 


create function fSQL_GetDataTableFiltradoYPaginado(
            @startRowIndex int  = NULL,
            @maximumRows int  = NULL,
            @estado int  = NULL,
            @QueContenga  VARCHAR(50) = NULL,
            @idVendedor int  = NULL,
            @idCorredor int  = NULL,
            @idDestinatario int  = NULL,
            @idIntermediario int  = NULL,
            @idRemComercial int  = NULL,
            @idArticulo int  = NULL,
            @idProcedencia int  = NULL,
            @idDestino int  = NULL,
            @AplicarANDuORalFiltro int  = NULL,
            @ModoExportacion  VARCHAR(20) = NULL,
            @fechadesde As DateTime= NULL,
			@fechahasta As DateTime= NULL,
            @puntoventa int  = NULL, 
            @optDivisionSyngenta  VARCHAR(50) = NULL,
            --@bTraerDuplicados As Boolean = False,
            @Contrato  VARCHAR(50) = NULL, 
            @QueContenga2  VARCHAR(50) = NULL,
            @idClienteAuxiliarint int  = NULL,
            @AgrupadorDeTandaPeriodos int  = NULL,
            @Vagon  int  = NULL,
			@Patente VARCHAR(10) = NULL,
            @optCamionVagon  VARCHAR(10) = NULL
) 
returns table 
as 

--SET @fechadesde = IsNull(@fechadesde, Convert(DATETIME, '1/1/2000'))
--SET @IdArticulo = IsNull(@IdArticulo, - 1)

/*
http://stackoverflow.com/questions/1462174/use-inline-table-valued-function-in-linq-compiled-query
http://weblogs.asp.net/zeeshanhirani/table-valued-functions-in-linq-to-sql
https://msdn.microsoft.com/en-us/data/hh859577.aspx
*/

return 

SELECT 
--TOP 10000000  
 CDP.IdCartaDePorte, CDP.NumeroCartaDePorte, CDP.IdUsuarioIngreso, CDP.FechaIngreso, 
 CDP.Anulada, CDP.IdUsuarioAnulo, CDP.FechaAnulacion, CDP.Observaciones, CDP.FechaTimeStamp, CDP.Vendedor, CDP.CuentaOrden1, 
 CDP.CuentaOrden2, CDP.Corredor, CDP.Entregador, CDP.Procedencia, CDP.Patente, CDP.IdArticulo, CDP.IdStock, CDP.Partida, CDP.IdUnidad, 
 CDP.IdUbicacion, CDP.Cantidad, CDP.Cupo, CDP.NetoProc, CDP.Calidad       ,CDP.BrutoPto      ,CDP.TaraPto      ,CDP.NetoPto      
,CDP.Acoplado      ,CDP.Humedad      ,CDP.Merma      ,CDP.NetoFinal      ,CDP.FechaDeCarga      ,CDP.FechaVencimiento      ,CDP.CEE  
,CDP.IdTransportista      ,CDP.TransportistaCUITdesnormalizado      ,CDP.IdChofer      ,CDP.ChoferCUITdesnormalizado      ,CDP.CTG  
,CDP.Contrato      ,CDP.Destino      ,CDP.Subcontr1      ,CDP.Subcontr2      ,CDP.Contrato1       ,CDP.contrato2      ,CDP.KmARecorrer
,CDP.Tarifa      ,CDP.FechaDescarga      ,CDP.Hora      ,CDP.NRecibo      ,CDP.CalidadDe      ,CDP.TaraFinal     
,CDP.BrutoFinal      ,CDP.Fumigada      ,CDP.Secada      ,CDP.Exporta      ,CDP.NobleExtranos      ,CDP.NobleNegros
,CDP.NobleQuebrados      ,CDP.NobleDaniados      ,CDP.NobleChamico      ,CDP.NobleChamico2      ,CDP.NobleRevolcado
,CDP.NobleObjetables      ,CDP.NobleAmohosados      ,CDP.NobleHectolitrico      ,CDP.NobleCarbon      
,CDP.NoblePanzaBlanca      ,CDP.NoblePicados      ,CDP.NobleMGrasa      ,CDP.NobleAcidezGrasa     
,CDP.NobleVerdes      ,CDP.NobleGrado      ,CDP.NobleConforme      ,CDP.NobleACamara      ,CDP.Cosecha 
,CDP.HumedadDesnormalizada      ,CDP.Factor      ,CDP.IdFacturaImputada      ,CDP.PuntoVenta   
,CDP.SubnumeroVagon      ,CDP.TarifaFacturada      ,CDP.TarifaSubcontratista1     
,CDP.TarifaSubcontratista2      ,CDP.FechaArribo      ,CDP.[Version]      ,CDP.MotivoAnulacion 
,CDP.NumeroSubfijo      ,CDP.IdEstablecimiento      ,CDP.EnumSyngentaDivision   
,CDP.Corredor2      ,CDP.IdUsuarioModifico      ,CDP.FechaModificacion      
,CDP.FechaEmision      ,CDP.EstaArchivada      ,CDP.ExcluirDeSubcontratistas   
,CDP.IdTipoMovimiento      ,CDP.IdClienteAFacturarle      ,CDP.SubnumeroDeFacturacion   
,CDP.AgregaItemDeGastosAdministrativos      ,CDP.CalidadGranosQuemados      ,CDP.CalidadGranosQuemadosBonifica_o_Rebaja      
,CDP.CalidadTierra      ,CDP.CalidadTierraBonifica_o_Rebaja      ,CDP.CalidadMermaChamico       
,CDP.CalidadMermaChamicoBonifica_o_Rebaja      ,CDP.CalidadMermaZarandeo      
,CDP.CalidadMermaZarandeoBonifica_o_Rebaja      ,CDP.FueraDeEstandar      ,CDP.CalidadPuntaSombreada    
,CDP.CobraAcarreo      ,CDP.LiquidaViaje      ,CDP.IdClienteAuxiliar      ,CDP.CalidadDescuentoFinal   
,CDP.PathImagen      ,CDP.PathImagen2       ,CDP.AgrupadorDeTandaPeriodos      ,CDP.ClaveEncriptada     
,CDP.NumeroCartaEnTextoParaBusqueda      ,CDP.IdClienteEntregador      ,CDP.IdDetalleFactura     
,CDP.SojaSustentableCodCondicion      ,CDP.SojaSustentableCondicion     
,CDP.SojaSustentableNroEstablecimientoDeProduccion      ,CDP.IdClientePagadorFlete     
,CDP.SubnumeroVagonEnTextoParaBusqueda      ,CDP.IdCorredor2       ,CDP.Acopio1      ,CDP.Acopio2    
,CDP.Acopio3      ,CDP.Acopio4      ,CDP.Acopio5 ,CDP.Acopio6        ,CDP.AcopioFacturarleA      
,CDP.CalidadGranosDanadosRebaja      ,CDP.CalidadGranosExtranosRebaja , 			
cast (cdp.NumeroCartaDePorte as varchar) +					
				CASE WHEN cdp.numerosubfijo<>0 OR cdp.subnumerovagon<>0 
					THEN            '  ' + cast (cdp.numerosubfijo as varchar) + '/' +cast (cdp.subnumerovagon as varchar) 						
					ELSE             ''            End				as NumeroCompleto,
datediff(minute,cdp.FechaModificacion,GETDATE()) as MinutosModifico,  		
ISNULL(Articulos.AuxiliarString5,'') AS EspecieONCAA,	  	
ISNULL(Articulos.AuxiliarString6,'') AS CodigoSAJPYA,	  			
ISNULL(Articulos.AuxiliarString7,'') AS txtCodigoZeni,	 		
isnull(CLIVEN.Razonsocial,'') AS TitularDesc,             isnull(CLIVEN.cuit,'') AS TitularCUIT,
isnull(CLICO1.Razonsocial,'') AS IntermediarioDesc,             isnull(CLICO1.cuit,'') AS IntermediarioCUIT, 			isnull(CLICO2.Razonsocial,'') AS RComercialDesc,             isnull(CLICO2.cuit,'') AS RComercialCUIT, 			isnull(CLICOR.Nombre,'') AS CorredorDesc,             
isnull(CLICOR.cuit,'') AS CorredorCUIT, 			isnull(CLIENT.Razonsocial,'') AS DestinatarioDesc, 			isnull(CLIENTREG.Razonsocial,'') AS EntregadorDesc,             isnull(CLIENT.cuit,'') AS DestinatarioCUIT, 			isnull(CLIAUX.Razonsocial,'') AS ClienteAuxiliarDesc, 		
isnull(CLIAUX.cuit,'') AS ClienteAuxiliarCUIT, 			isnull(CLISC1.Razonsocial,'') AS Subcontr1Desc,             isnull(CLISC2.Razonsocial,'') AS Subcontr2Desc,              isnull(Articulos.Descripcion,'') AS Producto, 			 Transportistas.cuit as  TransportistaCUIT,         
isnull(Transportistas.RazonSocial,'') AS TransportistaDesc, 		
choferes.cuil as  ChoferCUIT, 			choferes.Nombre as  ChoferDesc,            isnull(LOCORI.Nombre,'') AS ProcedenciaDesc, 		isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal, 		isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,            isnull(PROVORI.Nombre,'') AS ProcedenciaProvinciaDesc,    
isnull(LOCDES.Descripcion,'') AS DestinoDesc,             '' AS  DestinoCodigoPostal, 	
isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA,            DATENAME(month, FechaDescarga) AS Mes,           DATEPART(year, FechaDescarga) AS Ano,        	FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,            FAC.FechaFactura,         
isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado,          isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT, 		
Calidades.Descripcion AS CalidadDesc, 	    
E1.Nombre as UsuarioIngreso,isnull(ESTAB.Descripcion,'') COLLATE SQL_Latin1_General_CP1_CI_AS +' '+ isnull(ESTAB.AuxiliarString1,'') COLLATE SQL_Latin1_General_CP1_CI_AS+ ' '+ isnull(ESTAB.AuxiliarString2,'') COLLATE SQL_Latin1_General_CP1_CI_AS as EstablecimientoDesc, 			
isnull(CLIENTFLET.Razonsocial,'') AS ClientePagadorFleteDesc ,           isnull(LOCORI.Partido,'') AS ProcedenciaProvinciaPartido, 
isnull(PARTORI.Codigo,'') AS ProcedenciaPartidoNormalizadaCodigo,    isnull(PROVDEST.Nombre,'') AS DestinoProvinciaDesc,   isnull(PARTORI.Nombre,'') AS ProcedenciaPartidoNormalizada   , 			isnull(CLICOR2.Nombre,'') AS CorredorDesc2,             isnull(CLICOR2.cuit,'') AS CorredorCUIT2, 			isnull(CLIENTREG.cuit,'') AS EntregadorCUIT, 		isnull(LOCORI.CodigoAFIP,'') AS CodigoAFIP    



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
LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento        
LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura            
LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente             
LEFT OUTER JOIN Partidos PARTORI ON LOCORI.IdPartido = PARTORI.IdPartido          
LEFT OUTER JOIN Provincias PROVDEST ON LOCDES.IdProvincia = PROVDEST.IdProvincia  
LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado  
			

where 1=1              


			
    And (@IdArticulo IS NULL Or @IdArticulo=-1 Or cdp.IdArticulo = @IdArticulo)
    And (@IdDestino IS NULL Or @IdDestino=-1  Or cdp.Destino = @IdDestino)
    And (@idDestinatario IS NULL Or @idDestinatario=-1   Or cdp.Entregador = @idDestinatario)
	AND ISNULL(CDP.Anulada,'NO')<>'SI'    
	AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') >= @fechadesde
	AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') <= @fechahasta
 
    And (@puntoventa IS NULL OR @puntoventa = -1 Or cdp.PuntoVenta = @puntoventa)
	


	AND EXISTS ( SELECT * FROM CartasDePorte COPIAS  
					where COPIAS.NumeroCartaDePorte=CDP.NumeroCartaDePorte
					and COPIAS.SubnumeroVagon=CDP.SubnumeroVagon    
					and (
						@ModoExportacion is null
						or (@ModoExportacion = 'Ambos') 
						Or (@ModoExportacion = 'Todos') 
						Or (@ModoExportacion = 'Entregas' And isnull(COPIAS.Exporta, 'NO') = 'NO' AND ISNULL(COPIAS.Anulada,'NO')<>'SI') 
						Or (@ModoExportacion = 'Export' And isnull(COPIAS.Exporta, 'NO') = 'SI' AND ISNULL(COPIAS.Anulada,'NO')<>'SI')
						
					) 
				)

	AND ISNULL(CDP.SubnumeroDeFacturacion, 0) <= 0  
	       

go






select  * --count(*)
from dbo.fSQL_GetDataTableFiltradoYPaginado  
				( 
					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL, 

					NULL, 
					32, 
					NULL,
				 	'Entregas', 
					'2016-01-07 00:00:00',

					'2016-31-07 00:00:00',
					NULL, 
					NULL,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL

					) as cdp
            
go


--[wCartasDePorte_TX_EstadisticasDeDescarga] 'Buques',-1,'2014-01-06 00:00:00','2015-21-06 00:00:00','2013-01-06 00:00:00','2013-21-06 00:00:00'
go


