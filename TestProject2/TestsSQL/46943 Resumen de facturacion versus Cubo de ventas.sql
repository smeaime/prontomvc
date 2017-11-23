declare @CLIENTETEST int  = 4424 --NULL -- 2871





declare @startRowIndex int  = NULL
declare @maximumRows int  = NULL
declare @estado int  = NULL
declare @QueContenga  VARCHAR(50) = NULL
declare @idVendedor int  = @CLIENTETEST --LOS GROBO
declare @idCorredor int  = NULL
declare @idDestinatario int  = NULL
declare @idIntermediario int = @CLIENTETEST  --LOS GROBO
declare @idRemComercial int =@CLIENTETEST   --LOS GROBO
declare @idArticulo int  = NULL
declare @idProcedencia int  = NULL
declare @idDestino int  = NULL
declare @AplicarANDuORalFiltro int  = NULL
declare @ModoExportacion  VARCHAR(20) = NULL
declare @fechadesde datetime
declare @fechahasta datetime
declare @puntoventa int  = NULL
declare @optDivisionSyngenta  VARCHAR(50) = NULL
declare @Contrato  VARCHAR(50) = NULL
declare @QueContenga2  VARCHAR(50) = NULL
declare @idClienteAuxiliarint int  = NULL
declare @AgrupadorDeTandaPeriodos int  = NULL
declare @Vagon  int  = NULL
declare @Patente VARCHAR(10) = NULL
declare @optCamionVagon  VARCHAR(10) = NULL
declare @fechadesdeAnterior As DateTime= NULL
declare @fechahastaAnterior As DateTime= NULL



set @FechaDesdeAnterior ='20160601'
set @FechaHastaAnterior='20160630'
set @FechaDesde='20170101'
set @FechaHasta='20170130'








select

			cdp.numerocartadeporte,vendedor,
                   cdp.puntoventa as Sucursal,
			Exporta as Modo,
		
				case when FechaDescarga between @FechaDesde and @FechaHasta
				then NetoFinal/1000
				else 0 	end
			    as NetoFinal,
			
				case when FechaDescarga between @FechaDesdeAnterior and @FechaHastaAnterior  
				then NetoFinal/1000
				else 0 	end
			    as PeriodoAnterior  ,
			   
			
			  
				case when FechaDescarga between @FechaDesde and @FechaHasta
				then DETFAC.PrecioUnitario * NetoFinal / 1000
				else 0 	end
			   
			    as Facturado,
			
			
			  
				case when FechaDescarga between @FechaDesdeAnterior and @FechaHastaAnterior  
				then DETFAC.PrecioUnitario * NetoFinal / 1000
				else 0 	end
			   
			    as FacturadoAnterior
			


from 
 dbo.fSQL_GetDataTableFiltradoYPaginado  
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
				
							@FechaDesdeAnterior,

							@FechaHasta,
				
							@puntoventa, 
							NULL,
							 'FALSE',--duplicados?
							@Contrato, 

							@QueContenga2, 
							@idClienteAuxiliarint, 
							@AgrupadorDeTandaPeriodos, 
							@Vagon,
							@Patente, 

							@optCamionVagon
					)
    
 as CDP

left join detallefacturas DETFAC on CDP.IdDetalleFactura=DETFAC.IdDetalleFactura

 

