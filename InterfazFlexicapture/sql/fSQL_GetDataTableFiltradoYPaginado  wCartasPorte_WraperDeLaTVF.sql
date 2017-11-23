

--https://blogs.msdn.microsoft.com/psssql/2010/10/28/query-performance-and-multi-statement-table-valued-functions/
--If you use inline TVF, it’s like you are just using a view and if it takes parameter, it’s like a parameterized view.   
--The final SQL plan will not have any reference to the TVF itself.  Instead, all the referenced objects will be in the final plan.


--sp_helptext  fSQL_GetDataTableFiltradoYPaginado


if OBJECT_ID ('fSQL_GetDataTableFiltradoYPaginado') is not null 
    drop function fSQL_GetDataTableFiltradoYPaginado 
go 

/*

This helped us trace the issue to this SQL Server issue https://msdn.microsoft.com/en-US/library/ms178653(SQL.90).aspx . Specifically see the section titled "Differences Between Lower Compatibility Levels and Level 90". @indigosquared had a database which was upgraded from an earlier version of SQL Server (rather than a new install) and hence that database was running with an old compatibility level. 

To diagnose this run: 

sp_dbcmptlevel '<your_database_name>' 

If it reports a value below 90 then running 

sp_dbcmptlevel '<your_database_name>', 90 

updates the compatibility level of the database and fixes the problem.

*/



create function fSQL_GetDataTableFiltradoYPaginado(
            @startRowIndex int ,
            @maximumRows int ,
            @estado int  ,
            @QueContenga  VARCHAR(50) ,
            @idVendedor int ,

            @idCorredor int  ,
            @idDestinatario int ,
            @idIntermediario int ,
            @idRemComercial int ,
            @idArticulo int  ,

            @idProcedencia int ,
            @idDestino int  ,
            @AplicarANDuORalFiltro int  ,
            @ModoExportacion  VARCHAR(20) ,
            @fechadesde As DateTime,
			
			@fechahasta As DateTime,
            @puntoventa int , 
            @IdAcopio int,
            
			@bTraerDuplicados bit ,
            
			@Contrato  VARCHAR(50) , 
            @QueContenga2  VARCHAR(50) ,
            
			@idClienteAuxiliarint int ,
            @AgrupadorDeTandaPeriodos int  ,
            @Vagon  int  ,
			@Patente VARCHAR(10) ,
            @optCamionVagon  VARCHAR(10) 
) 
returns table 
as 

/*

This helped us trace the issue to this SQL Server issue https://msdn.microsoft.com/en-US/library/ms178653(SQL.90).aspx . 
Specifically see the section titled "Differences Between Lower Compatibility Levels and Level 90". @indigosquared had a database which was upgraded from an earlier version of SQL Server (rather than a new install) and hence that database was running with an old compatibility level. 

To diagnose this run: 

sp_dbcmptlevel '<your_database_name>' 

If it reports a value below 90 then running 

sp_dbcmptlevel '<your_database_name>', 90 

updates the compatibility level of the database and fixes the problem.

*/

--SET @fechadesde = IsNull(@fechadesde, Convert(DATETIME, '1/1/2000'))
--SET @IdArticulo = IsNull(@IdArticulo, - 1)

/*
http://stackoverflow.com/questions/1462174/use-inline-table-valued-function-in-linq-compiled-query
http://weblogs.asp.net/zeeshanhirani/table-valued-functions-in-linq-to-sql
https://msdn.microsoft.com/en-us/data/hh859577.aspx
*/



return 

			--CalidadMermaVolatil hay que sacarlo de la tabla CartasDePorteDetalle
            --Dim oDet As ProntoMVC.Data.Models.CartasDePorteDetalle_EF = (From i In db.CartasDePorteDetalle_EF _
            --                                    Where i.IdCartaDePorte = id _
            --                                    And i.Campo = nombrecampo
            --                                ).SingleOrDefault
            --If IsNothing(oDet) Then
            --    oDet = New ProntoMVC.Data.Models.CartasDePorteDetalle_EF
            --    oDet.IdCartaDePorte = id
            --    oDet.Campo = nombrecampo
            --    oDet.Valor = valor
            --    'acá había un insertonsubmit
            --    db.CartasDePorteDetalle_EF.Add(oDet)



SELECT 
	-- TOP (@maximumRows)  --creo que no puedo usar top con parametros en una TVF

 CDP.IdCartaDePorte, CDP.NumeroCartaDePorte, CDP.IdUsuarioIngreso, CDP.FechaIngreso, 
 CDP.Anulada, CDP.IdUsuarioAnulo, CDP.FechaAnulacion, CDP.Observaciones, CDP.FechaTimeStamp, CDP.Vendedor, CDP.CuentaOrden1, 
 CDP.CuentaOrden2, CDP.Corredor, CDP.Entregador, CDP.Procedencia, CDP.Patente, CDP.IdArticulo, CDP.IdStock, CDP.Partida, CDP.IdUnidad, 
 CDP.IdUbicacion, CDP.Cantidad, CDP.Cupo, CDP.NetoProc, CDP.Calidad       ,CDP.BrutoPto      ,CDP.TaraPto      ,CDP.NetoPto      
,CDP.Acoplado      ,CDP.Humedad      ,CDP.Merma      ,CDP.NetoFinal      ,CDP.FechaDeCarga      ,CDP.FechaVencimiento      ,CDP.CEE  
,CDP.IdTransportista      ,CDP.TransportistaCUITdesnormalizado      ,CDP.IdChofer      ,CDP.ChoferCUITdesnormalizado      ,CDP.CTG  
,CDP.Contrato      ,CDP.Destino      ,CDP.Subcontr1      ,CDP.Subcontr2      ,CDP.Contrato1       ,CDP.contrato2      ,CDP.KmARecorrer
,CDP.Tarifa      ,CDP.FechaDescarga      ,CDP.Hora      ,CDP.NRecibo      ,CDP.CalidadDe      ,CDP.TaraFinal     
,CDP.BrutoFinal      ,CDP.Fumigada      ,CDP.Secada      


--truco hasta resolver este asunto del @ModoExportacion y @bTraerDuplicados 
--Si solo piden originales, truchea el original para que cumpla con el filtro
,  CASE 
		--WHEN  @ModoExportacion is null or (@ModoExportacion = 'Ambos' or @ModoExportacion = 'Ambas') Or (@ModoExportacion = 'Todos')  THEN CDP.Exporta
		WHEN  (@bTraerDuplicados='FALSE' AND @ModoExportacion = 'Entregas')  then 'NO'
		WHEN  (@bTraerDuplicados='FALSE' AND @ModoExportacion = 'Export') then 'SI'
		ELSE  CDP.Exporta
   END as Exporta



   ,CDP.NobleExtranos      ,CDP.NobleNegros
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
,CDP.CalidadGranosDanadosRebaja      ,CDP.CalidadGranosExtranosRebaja 
,CDP.ConDuplicados
,CDP.TieneRecibidorOficial
,CDP.EstadoRecibidor
,CDP.ClienteAcondicionador
,CDP.MotivoRechazo
,CDP.FacturarA_Manual
--,CDP.CalidadPuntaSobreadaMerma
--,CDP.CalidadPuntaSobreadaRebaja
,CDP.EntregaSAP
,CDP.Situacion
,CDP.SituacionAntesDeEditarManualmente
,CDP.FechaActualizacionAutomatica
,CDP.FechaAutorizacion
,CDP.ObservacionesSituacion
,CDP.SituacionLog
,CDP.Turno
,CDP.FechaEnvioASyngenta

-- select top 1 * from cartasdeporte
-- sp_help cartasdeporte

,			
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
isnull(PROVORI.Codigo2,'') AS ProcedenciaProvinciaCodigo,    
isnull(LOCORI.Partido,'') AS ProcedenciaProvinciaPartido, 
isnull(PARTORI.Nombre,'') AS ProcedenciaPartidoNormalizada   , 	
isnull(PARTORI.Codigo,'') AS ProcedenciaPartidoNormalizadaCodigo,    


isnull(LOCDES.Descripcion,'') AS DestinoDesc, 
isnull(LOCDES.CodigoPostal,'')  AS  DestinoCodigoPostal, 	
isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA,
isnull(LOCDES.CUIT,'') 	 AS  DestinoCUIT,
isnull(LOCDES2.CodigoAFIP,'') 	 AS  DestinoLocalidadAFIP,
isnull(LOCDES2.CodigoONCAA,'') 	 AS  DestinoLocalidadCodigoONCAA,
isnull(LOCDES2.Nombre,'') 	 AS  DestinoLocalidadDesc,
isnull(PROVDEST.Nombre,'') AS DestinoProvinciaDesc,  
isnull(PROVDEST.Codigo2,'') AS DestinoProvinciaCodigo,    




isnull(ESTAB.Descripcion,'') COLLATE SQL_Latin1_General_CP1_CI_AS +' '
	+ isnull(ESTAB.AuxiliarString1,'') COLLATE SQL_Latin1_General_CP1_CI_AS+ ' '
	+ isnull(ESTAB.AuxiliarString2,'') COLLATE SQL_Latin1_General_CP1_CI_AS as EstablecimientoDesc, 			
ESTAB.Descripcion  as EstablecimientoCodigo,
ESTAB.AuxiliarString2  as EstablecimientoCUIT,
ESTAB.AuxiliarString1 as EstablecimientoNombre,




DATENAME(month, FechaDescarga) AS Mes,          
DATEPART(year, FechaDescarga) AS Ano,        	
FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,
FAC.FechaFactura,         
isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado,          
isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT, 		
Calidades.Descripcion AS CalidadDesc, 	    
E1.Nombre as UsuarioIngreso,



isnull(CLIENTFLET.Razonsocial,'') AS ClientePagadorFleteDesc,
isnull(CLICOR2.Nombre,'') AS CorredorDesc2,    
isnull(CLICOR2.cuit,'') AS CorredorCUIT2,
isnull(CLIENTREG.cuit,'') AS EntregadorCUIT, 		
isnull(LOCORI.CodigoAFIP,'') AS CodigoAFIP

--,CDPDET.Valor as CalidadMermaVolatilMerma











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
LEFT OUTER JOIN Provincias PROVDEST ON LOCDES2.IdProvincia = PROVDEST.IdProvincia  

LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento        

LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura            
LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente             
LEFT OUTER JOIN Partidos PARTORI ON LOCORI.IdPartido = PARTORI.IdPartido          
LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado  

--LEFT OUTER JOIN CartasDePorteDetalle CALIDAD ON CDP.IdCartaDePorte = CALIDAD.IdCartaDePorte  




--LEFT OUTER JOIN CartasDePorteDetalle CDPDET ON CDP.IdCartaDePorte = CDPDET.IdCartaDePorte And CDPDET.Campo = 'CalidadMermaVolatilMerma'   -- Return oDet.Valor
-- http://stackoverflow.com/questions/958949/difference-between-select-and-selectmany
		 --.CalidadMermaVolatil = GetDetalle("CalidadMermaVolatil", db, id)
   --             .CalidadMermaVolatilRebaja = GetDetalle("CalidadMermaVolatilRebaja", db, id)
   --             .CalidadMermaVolatilMerma = GetDetalle("CalidadMermaVolatilMerma", db, id)


where 1=1              


			
    And (@IdArticulo IS NULL Or @IdArticulo=-1 Or cdp.IdArticulo = @IdArticulo)
    And (@IdDestino IS NULL Or @IdDestino=-1  Or cdp.Destino = @IdDestino)
    And (@idDestinatario IS NULL Or @idDestinatario=-1   Or cdp.Entregador = @idDestinatario)
    And (@idProcedencia IS NULL Or @idProcedencia=-1   Or cdp.Procedencia = @idProcedencia)
	And (@idCorredor IS NULL Or @idCorredor=-1   Or cdp.Corredor = @idCorredor Or cdp.Corredor2 = @idCorredor)
	
	And (
			(isnull(@idVendedor,-1)=-1 AND isnull(@idIntermediario,-1)=-1  AND  isnull(@idRemComercial,-1)=-1  AND  isnull(@idClienteAuxiliarint,-1)=-1 )

			OR

			(@AplicarANDuORalFiltro = 1 and
					(
						(cdp.Vendedor = @idVendedor  Or isnull(@idVendedor,-1)=-1) AND  
						(cdp.CuentaOrden1= @idIntermediario  Or isnull(@idIntermediario,-1)=-1) AND  
						(cdp.CuentaOrden2 = @idRemComercial  Or isnull(@idRemComercial,-1)=-1) AND  
						(cdp.idClienteAuxiliar = @idClienteAuxiliarint  Or isnull(@idClienteAuxiliarint,-1)=-1) 
					)
 			)
			
			OR
 		
			(isnull(@AplicarANDuORalFiltro,0) = 0 and
				(
						(cdp.Vendedor = @idVendedor  ) Or  
						(cdp.CuentaOrden1= @idIntermediario ) Or  
						(cdp.CuentaOrden2 = @idRemComercial ) Or  
						(cdp.idClienteAuxiliar = @idClienteAuxiliarint)
				)
			)
	)

	
	AND ISNULL(CDP.Anulada,'NO')<>'SI'    
	AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') >= @fechadesde
	AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') <= @fechahasta

	AND (  
			(@optCamionVagon = 'Camiones' AND isnull(CDP.SubNumeroVagon,'')='' )
			OR 
			(@optCamionVagon = 'Vagones' AND isnull(CDP.SubNumeroVagon,'')<>'')
			OR 
			@optCamionVagon = 'Todos' OR  @optCamionVagon = 'Ambas'  OR @optCamionVagon  IS NULL
		)

	




	


	  and	
	  (


	  --Enum enumCDPestado
   --     Todas
   --     TodasMenosLasRechazadas 1
   --     Incompletas 2
   --     Posicion 3
   --     DescargasMasFacturadas 4 
   --     DescargasSinFacturar 5
   --     Facturadas 6
   --     NoFacturadas 7
   --     Rechazadas 8
   --     FacturadaPeroEnNotaCredito 9
   --     DescargasDeHoyMasTodasLasPosiciones 10 
   --     DescargasDeHoyMasTodasLasPosicionesEnRangoFecha 11


			@estado=0 OR @estado is null
			OR
			(@estado=1 AND  	 ISNULL(cdp.Anulada,'NO')<>'SI'  )
			OR
			(
			@estado=2  AND (cdp.Vendedor IS NULL OR cdp.Corredor IS NULL OR cdp.Entregador IS NULL OR cdp.IdArticulo IS NULL) 
			AND ISNULL(IdFacturaImputada,0)=0 AND ISNULL(cdp.Anulada,'NO')<>'SI'
			)
            OR
			(
				@estado=3  --posicion
				 AND NOT (cdp.Vendedor IS NULL OR cdp.Corredor IS NULL OR cdp.Entregador IS NULL OR cdp.IdArticulo IS NULL) 
				 AND ISNULL(cdp.NetoProc,0)=0 AND ISNULL(cdp.IdFacturaImputada,0)=0 AND ISNULL(cdp.Anulada,'NO')<>'SI' 
			)
			OR
			(
				@estado=10 --Case enumCDPestado.DescargasDeHoyMasTodasLasPosiciones
						 AND 
                                 (                                              
                                       ( NOT (cdp.Vendedor IS NULL OR cdp.Corredor IS NULL OR cdp.Entregador IS NULL OR cdp.IdArticulo IS NULL) 
											AND ISNULL(NetoProc,0)=0 AND ISNULL(cdp.IdFacturaImputada,0)=0 AND ISNULL(cdp.Anulada,'NO')<>'SI' ) 
                                   OR                                           
                                       ( ISNULL(cdp.NetoProc,0)>0 AND cdp.fechadescarga >=CONVERT (date, GETDATE())   )
                                 ) 
			
			)
			OR
			(
				@estado=11 -- Case enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha
                  AND 
                                 (                                             
                                       ( NOT (cdp.Vendedor IS NULL OR cdp.Corredor IS NULL OR cdp.Entregador IS NULL OR 
                                cdp.IdArticulo IS NULL) AND ISNULL(cdp.NetoProc,0)=0 AND ISNULL(IdFacturaImputada,0)=0 AND 
                                      ISNULL(cdp.Anulada,'NO')<>'SI' ) 
                                   OR                                            
                                       ( ISNULL(NetoProc,0)>0 AND fechadescarga >= CONVERT (date, GETDATE())    )
                                ) 

			)
			OR
			(
				@estado=4 --Case enumCDPestado.DescargasMasFacturadas
                AND NOT (cdp.Vendedor IS NULL OR cdp.Corredor IS NULL OR cdp.Entregador IS NULL OR cdp.IdArticulo IS NULL) AND 
							ISNULL(cdp.NetoProc,0)>0 AND ISNULL(cdp.Anulada,'NO')<>'SI'
			)
			OR
			(
				@estado=5 --  Case enumCDPestado.DescargasSinFacturar
                 AND NOT (cdp.Vendedor IS NULL OR cdp.Corredor IS NULL OR cdp.Entregador IS NULL OR cdp.IdArticulo IS NULL) AND 
						ISNULL(cdp.NetoProc,0)>0 AND ISNULL(cdp.Anulada,'NO')<>'SI' AND ISNULL(cdp.IdFacturaImputada,0)=0 
			)
			OR
			(
				@estado=6 -- Case enumCDPestado.Facturadas
                 AND ISNULL(cdp.IdFacturaImputada,0)>0 AND ISNULL(cdp.Anulada,'NO')<>'SI'
			)
			OR
			(
				@estado=7 -- Case enumCDPestado.NoFacturadas
                 AND NOT(ISNULL(cdp.IdFacturaImputada,0)>0 AND ISNULL(cdp.Anulada,'NO')<>'SI')
			)
			OR
			(
				@estado=8 -- Case enumCDPestado.Rechazadas
                 AND ISNULL(cdp.Anulada,'NO')='SI'
			)
			OR
			(
			  
				@estado=9 --  Case enumCDPestado.FacturadaPeroEnNotaCredito
						 AND 0=1
						 						  --Select distinct  
               --            "               CuentasCorrientesDeudores.idcomprobante 
               --            "               FROM DetalleNotasCreditoImputaciones DetCre
               --            "               LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=DetCre.IdNotaCredito
               --            "               LEFT OUTER JOIN CuentasCorrientesDeudores ON CuentasCorrientesDeudores.IdCtaCte=DetCre.IdImputacion 
               --            "               LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CuentasCorrientesDeudores.IdTipoComp 
               --            "               where TiposComprobante.DescripcionAB='FA' and CuentasCorrientesDeudores.idcomprobante <>0 
               --            "              ")
						   
			)
		)         
  


	
    AND (@Patente IS NULL OR @Patente ='' Or cdp.Patente = @Patente)




	AND (@bTraerDuplicados='TRUE' OR 
			(
				ISNULL(CDP.SubnumeroDeFacturacion, 0) <= 0
			)
	)  --solo trae el original de una familia
	--deberia traer solo uno de la familia, pero uno que cumpla la condicion de @ModoExportacion


	------------------------------------------------
	--                  FILTROS LENTOS  (faltan indices?)
	------------------------------------------------

	/*
	si no pide duplicados, debería hacer el favor de devolver uno de la familia que 
	AND (
			@bTraerDuplicados='' OR 

				@ModoExportacion is null or (@ModoExportacion = 'Ambos' or @ModoExportacion = 'Ambas') Or (@ModoExportacion = 'Todos') 
				Or (@ModoExportacion = 'Entregas' And isnull(CDP.Exporta, 'NO') = 'NO' )  
				Or (@ModoExportacion = 'Export' And isnull(CDP.Exporta, 'NO') = 'SI' )
			) 
	*/

	AND 
	(
		(	
			@bTraerDuplicados='TRUE' AND 
			(
				(@ModoExportacion = 'Entregas' And isnull(CDP.Exporta, 'NO') = 'NO')  
				OR
				(@ModoExportacion = 'Export' And isnull(CDP.Exporta, 'NO') = 'SI')
				OR
				@ModoExportacion is null or (@ModoExportacion = 'Ambos' or @ModoExportacion = 'Ambas') Or (@ModoExportacion = 'Todos') 
			)
		)

		OR

		(
			@bTraerDuplicados='FALSE'
			AND
			EXISTS ( SELECT * FROM CartasDePorte COPIAS  
				where COPIAS.NumeroCartaDePorte=CDP.NumeroCartaDePorte
				and COPIAS.SubnumeroVagon=CDP.SubnumeroVagon    
				and (
					@ModoExportacion is null or (@ModoExportacion = 'Ambos' or @ModoExportacion = 'Ambas') Or (@ModoExportacion = 'Todos') 
					Or (@ModoExportacion = 'EntregasExcluyente' And isnull(CDP.Exporta, 'NO') = 'NO')  
					Or (@ModoExportacion = 'ExportExcluyente' And isnull(CDP.Exporta, 'NO') = 'SI')
					Or (@ModoExportacion = 'Entregas' And isnull(COPIAS.Exporta, 'NO') = 'NO' AND ISNULL(COPIAS.Anulada,'NO')<>'SI')  
					Or (@ModoExportacion = 'Export' And isnull(COPIAS.Exporta, 'NO') = 'SI' AND ISNULL(COPIAS.Anulada,'NO')<>'SI')
				) 
			)
		)
	)


    AND (@Contrato IS NULL OR @Contrato ='' OR @Contrato ='-1' Or cdp.Contrato = @Contrato)
	AND	(@Vagon IS NULL OR  @Vagon=0 or CDP.SubnumeroVagon=@Vagon) 
    AND (@puntoventa IS NULL OR @puntoventa <=0 Or cdp.PuntoVenta = @puntoventa)
	AND (		
			isnull(@IdAcopio,-1)=-1
			OR CDP.Acopio1=@IdAcopio 
			OR CDP.Acopio2=@IdAcopio 
			OR CDP.Acopio3=@IdAcopio 
			OR CDP.Acopio4=@IdAcopio 
			OR CDP.Acopio5=@IdAcopio 
			OR CDP.Acopio6=@IdAcopio 
		)



	--FIN LENTOS

		

	

		

go







declare @startRowIndex int,@maximumRows int,@estado int,@QueContenga nvarchar(4000),@idVendedor int,@idCorredor int,@idDestinatario int,@idIntermediario int,@idRemComercial int,@idArticulo int,@idProcedencia int,@idDestino int,@AplicarANDuORalFiltro int,@ModoExportacion nvarchar(4000),@fechadesde datetime2(7),@fechahasta datetime2(7),@puntoventa int,@IdAcopio int,@Contrato nvarchar(4000),@QueContenga2 nvarchar(4000),@idClienteAuxiliarint int,@AgrupadorDeTandaPeriodos int,@Vagon int,@Patente nvarchar(4000),@optCamionVagon nvarchar(4000)

select @startRowIndex=0,@maximumRows=9999999,@estado=0,@QueContenga=N'',@idVendedor=-1,@idCorredor=-1,@idDestinatario=-1,@idIntermediario=-1,@idRemComercial=-1,
@idArticulo=-1,@idProcedencia=-1,@idDestino=-1,@AplicarANDuORalFiltro=0,@ModoExportacion=N'Ambas',
@fechadesde='2015-01-01 00:00:00',@fechahasta='2016-01-01 00:00:00'
,@puntoventa=0,@IdAcopio=null,@Contrato=N''
,@QueContenga2=N'',@idClienteAuxiliarint=-1,@AgrupadorDeTandaPeriodos=NULL,@Vagon=0,@Patente=N'',@optCamionVagon=N'Todos'


select top 50 * FROM [dbo].[fSQL_GetDataTableFiltradoYPaginado](@startRowIndex, @maximumRows, @estado, @QueContenga, @idVendedor, @idCorredor, @idDestinatario, @idIntermediario, @idRemComercial, @idArticulo, @idProcedencia, @idDestino, @AplicarANDuORalFiltro, @ModoExportacion, @fechadesde, @fechahasta, @puntoventa, @IdAcopio, 'FALSE', @Contrato, @QueContenga2, @idClienteAuxiliarint, @AgrupadorDeTandaPeriodos, @Vagon, @Patente, @optCamionVagon)
ORDER BY IdCartaDePorte DESC
--ORDER BY NumeroCartaDePorte DESC

go

--CREATE NONCLUSTERED INDEX IDX_CartasDePorte_filtros
--ON CartasDePorte (NumeroCartaDePorte,Patente,Contrato,PuntoVenta,Acopio1,Acopio2,Acopio3,Acopio4,Acopio5,Acopio6, SubnumeroVagon)
--GO



go









--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------



			--@startRowIndex int ,
   --         @maximumRows int ,
   --         @estado int  ,
   --         @QueContenga  VARCHAR(50) ,
   --         @idVendedor int ,
            
			--@idCorredor int  ,
   --         @idDestinatario int ,
   --         @idIntermediario int ,
   --         @idRemComercial int ,
   --         @idArticulo int  ,

   --         @idProcedencia int ,
   --         @idDestino int  ,
   --         @AplicarANDuORalFiltro int  ,
   --         @ModoExportacion  VARCHAR(20) ,
   --         @fechadesde As DateTime,
			
			--@fechahasta As DateTime,
   --         @puntoventa int , 
   --         @optDivisionSyngenta  VARCHAR(50) ,
   --         @Contrato  VARCHAR(50) , 
   --         @QueContenga2  VARCHAR(50) ,
            
			--@idClienteAuxiliarint int ,
   --         @AgrupadorDeTandaPeriodos int  ,
   --         @Vagon  int  ,
			--@Patente VARCHAR(10) ,
   --         @optCamionVagon  VARCHAR(10) 





select top 20  EstablecimientoCodigo,EstablecimientoNombre,ProcedenciaProvinciaDesc, DestinoProvinciaDesc, exporta, situacion, * --count(*)
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
					NULL, 
					NULL,
				 	'Ambas', 
					'2016-01-09 00:00:00',

			
					'2016-01-09 00:00:00',
								NULL, 
					NULL,
					'FALSE',
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL

					) as cdp
            
go









declare @ModoExportacion  VARCHAR(20)
set  @ModoExportacion ='Export' --'Entregas'

WITH summary AS (
    SELECT cdp.numerocartadeporte,cdp.subnumerovagon, exporta, --*,
           ROW_NUMBER() OVER(PARTITION BY cdp.numerocartadeporte,cdp.subnumerovagon
									ORDER BY cdp.idcartadeporte
							) AS rk
      FROM 
	  dbo.fSQL_GetDataTableFiltradoYPaginado  
				(  
					NULL, 
					NULL, 
					0,
					NULL, 
					-1,
					 
					-1,-1,-1,-1,-1,

					NULL, 
					NULL, 
					NULL,
					'Ambas',
					'2016-01-01 00:00:00',

					'2016-04-01 00:00:00',
					NULL, 
					NULL,
					'TRUE', --tengo que traer los duplicados
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL

					) as cdp
					where
						@ModoExportacion is null
						or (@ModoExportacion = 'Ambos' or @ModoExportacion = 'Ambas') 
						Or (@ModoExportacion = 'Todos') 
						Or (@ModoExportacion = 'Entregas' And isnull(cdp.Exporta, 'NO') = 'NO')  
						Or (@ModoExportacion = 'Export' And isnull(cdp.Exporta, 'NO') = 'SI' )

	  )
SELECT s.*
  FROM summary s
 --WHERE s.rk = 1







select  exporta --count(*)
from dbo.fSQL_GetDataTableFiltradoYPaginado  
				(  

 NULL, 
					10, 
					11,
					NULL, 
					-1,
					 
-1,-1,-1,-1,-1,

	NULL, 
					NULL, 
					NULL,
					'Ambas',
					'2016-01-01 00:00:00',

					'2016-02-01 00:00:00',
					NULL, 
					NULL,
					 'FALSE',
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




--sp_dbcmptlevel 'Williams2' , 90 
--sp_dbcmptlevel 'Williams2' 

--sp_dbcmptlevel 'Pronto' , 90 
--sp_dbcmptlevel 'Pronto' 





if OBJECT_ID ('wCartasPorte_WraperDeLaTVF') is not null 
    drop procedure wCartasPorte_WraperDeLaTVF 
go 


create procedure  wCartasPorte_WraperDeLaTVF
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

			@fechadesde datetime,
			@fechahasta datetime,

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

		AS



		declare @IdAcopio int
		select top 1 @IdAcopio=IdAcopio from CartasPorteAcopios   where Descripcion = @optDivisionSyngenta


		SELECT  
		TOP (@maximumRows)  --quizas usando el TOP sin ORDERBY no haya diferencia de performance

		*

    	from dbo.fSQL_GetDataTableFiltradoYPaginado
		( 
							@startRowIndex, 
							@maximumRows, 
							@estado,
							@QueContenga, 
							@idVendedor, 

							@idCorredor, 
							@idDestinatario, 
							@idIntermediario,
							@idRemComercial, 
							@idArticulo,

							@idProcedencia,
							@idDestino,
					
							@AplicarANDuORalFiltro,
							@ModoExportacion,
							@fechadesde,

							@fechahasta, 
							@puntoventa, 
							@IdAcopio,
							 'FALSE',
							@Contrato, 
							@QueContenga2, 

							@idClienteAuxiliarint, 
							@AgrupadorDeTandaPeriodos, 
							@Vagon,
							@Patente, 
							@optCamionVagon

							) as cdp

go




wCartasPorte_WraperDeLaTVF 
					NULL, 
					100, 
					NULL,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL, --@idArticulo,

					NULL, --@idProcedencia,
					NULL,---1, --@idDestino,
					0, --@AplicarANDuORalFiltro,
					'Ambos', --'Buques',
					'2016-03-30 00:00:00',
					
					'2016-03-30 00:00:00',
					NULL, 
					NULL,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL

go



GRANT EXECUTE ON wCartasPorte_WraperDeLaTVF to [NT AUTHORITY\ANONYMOUS LOGON]
go



/*

exec wCartasPorte_WraperDeLaTVF @startRowIndex=NULL,@fechadesde='2000-01-01 00:00:00',@maximumRows=100,@fechahasta='2100-01-01 00:00:00'
,@estado=NULL,@idDestino=-1,@QueContenga=NULL,@idVendedor=NULL,@idCorredor=NULL,@idDestinatario=NULL,
@idIntermediario=NULL,@idRemComercial=NULL,@idArticulo=NULL,@idProcedencia=NULL,@AplicarANDuORalFiltro=NULL,@ModoExportacion='Ambos',
@puntoventa=0,
@optDivisionSyngenta=NULL,@Contrato=NULL,@QueContenga2=NULL,@idClienteAuxiliarint=NULL,@AgrupadorDeTandaPeriodos=NULL,@Vagon=NULL,
@Patente=NULL,@optCamionVagon=NULL
go



exec wCartasPorte_WraperDeLaTVF @startRowIndex=NULL,@fechadesde='2015-01-01 00:00:00',@maximumRows=40,@fechahasta='2016-01-01 00:00:00',
@estado=4,@idDestino=-1,@QueContenga=NULL,@idVendedor=-1,@idCorredor=-1,@idDestinatario=-1,
@idIntermediario=-1,@idRemComercial=-1,@idArticulo=-1,@idProcedencia=-1,@AplicarANDuORalFiltro=0,@ModoExportacion=N'Ambos',
@puntoventa=-1,@optDivisionSyngenta=N'Ambas',@Contrato=NULL,@QueContenga2=N'-1',@idClienteAuxiliarint=-1,
@AgrupadorDeTandaPeriodos=NULL,@Vagon=NULL,@Patente=NULL,@optCamionVagon=N'Todos'
go


exec wCartasPorte_WraperDeLaTVF @startRowIndex=0,@fechadesde='2016-01-01 00:00:00',@maximumRows=40,@fechahasta='2016-01-01 00:00:00',@estado=4,@idDestino=-1,@QueContenga=N'0',
@idVendedor=-1,@idCorredor=-1,@idDestinatario=-1,@idIntermediario=-1,@idRemComercial=-1,@idArticulo=-1,@idProcedencia=-1,@AplicarANDuORalFiltro=0,@ModoExportacion=N'Ambas',@puntoventa=-1,@optDivisionSyngenta=N'Ambas',@Contrato=N'-1',@QueContenga2=N'-1',@idClienteAuxiliarint=-1,@AgrupadorDeTandaPeriodos=-1,@Vagon=0,@Patente=N'',@optCamionVagon=N'Todos'



exec wCartasPorte_WraperDeLaTVF @startRowIndex=0,@fechadesde='2016-01-10 00:00:00',@maximumRows=3000,
@fechahasta='2016-31-10 00:00:00',@estado=4,@idDestino=-1,@QueContenga=N'0',@idVendedor=6762,@idCorredor=-1,
@idDestinatario=-1,@idIntermediario=6762,@idRemComercial=6762,@idArticulo=-1,@idProcedencia=-1,@AplicarANDuORalFiltro=0,
@ModoExportacion=N'Entregas',@puntoventa=-1,@optDivisionSyngenta=N'BANDERA',@Contrato=N'-1',@QueContenga2=N'-1',
@idClienteAuxiliarint=6762,@AgrupadorDeTandaPeriodos=-1,@Vagon=0,@Patente=N'',@optCamionVagon=N'Todos'


*/




















