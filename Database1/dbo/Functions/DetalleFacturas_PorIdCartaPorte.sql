
CREATE FUNCTION [dbo].[DetalleFacturas_PorIdCartaPorte]
(
	@IdCartaPorte int
)

RETURNS int
AS
BEGIN

declare @id int



declare @IdFacturaImputada int
select 	@IdFacturaImputada=IdFacturaImputada from cartasdeporte where IdCartaDePorte = @IdCartaPorte 
if isnull(@IdFacturaImputada,0)=0 return 0






	select 
		@id= 	DETFAC.IdDetalleFactura


from detallefacturas DETFAC  
inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
inner  join CartasDePorte CDP on CDP.IdFacturaImputada=CABFAC.IdFactura  
LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
inner  join Articulos ON CDP.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Log PRONTOLOG ON CABFAC.Idfactura = PRONTOLOG.Idcomprobante and prontolog.Detalle like 'Factura de CartasPorte%'
where				
(			
CDP.IdCartaDePorte = @IdCartaPorte and
	CABFAC.IdFactura=DETFAC.idFactura 
	and CDP.IdArticulo = DETFAC.IdArticulo
	and  charindex(Articulos.Descripcion, 'CAMBIO DE CARTA')=0 					 --
	and  charindex(LOCDES.Descripcion  COLLATE SQL_Latin1_General_CP1_CI_AS, detfac.Observaciones)>0  --el destino
	and 
	(
		(				
			--substring(cabfac.NumeroExpedienteCertificacionObra,4,1)<>'4' --no es CANJE
			--AND
			(
				LOCDES.Descripcion = cast(detfac.Observaciones as nvarchar(300)) + ' '
				or 
				charindex(CLIVEN.Razonsocial  COLLATE SQL_Latin1_General_CP1_CI_AS, detfac.Observaciones)>0
			)
		)
		or
		(
			----es canje (se agrupa por CLICO1 y CLICO2)
			--substring(cabfac.NumeroExpedienteCertificacionObra,4,1)='4' --es CANJE
			--AND
			charindex( CAST( isnull(CLICO1.IdCliente,-1) as varchar)  +  ' ' + CAST( isnull(CLICO2.IdCliente,-1) as varchar)     , detfac.Observaciones)>0
		)
		--or 1=1
	)
)	



	set @id=ISNULL(@id, 0)


	if @id=0 
	begin   
		-- me resigno con menos condiciones	

			select 
				@id= 	DETFAC.IdDetalleFactura


		from detallefacturas DETFAC  
		inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
		inner  join CartasDePorte CDP on CDP.IdFacturaImputada=CABFAC.IdFactura  
		LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
		LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
		LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
		LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
		LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
		LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
		LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
		LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
		inner  join Articulos ON CDP.IdArticulo = Articulos.IdArticulo
		LEFT OUTER JOIN Log PRONTOLOG ON CABFAC.Idfactura = PRONTOLOG.Idcomprobante and prontolog.Detalle like 'Factura de CartasPorte%'
		where				
		(			
		CDP.IdCartaDePorte = @IdCartaPorte and
			CABFAC.IdFactura=DETFAC.idFactura 
			and CDP.IdArticulo = DETFAC.IdArticulo
			and  charindex(Articulos.Descripcion, 'CAMBIO DE CARTA')=0 					 --
			and  charindex(LOCDES.Descripcion  COLLATE SQL_Latin1_General_CP1_CI_AS, detfac.Observaciones)>0  --el destino
		)	


	
	end
	
	
	if @id=0 
	begin   
		-- me resigno con menos condiciones	aun (de todas maneras, siempre respetando el IdFacturaImputada)

			select 
				@id= 	DETFAC.IdDetalleFactura


		from detallefacturas DETFAC  
		inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
		inner  join CartasDePorte CDP on CDP.IdFacturaImputada=CABFAC.IdFactura  
		LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
		LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
		LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
		LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
		LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
		LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
		LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
		LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
		inner  join Articulos ON CDP.IdArticulo = Articulos.IdArticulo
		LEFT OUTER JOIN Log PRONTOLOG ON CABFAC.Idfactura = PRONTOLOG.Idcomprobante and prontolog.Detalle like 'Factura de CartasPorte%'
		where				
		(			
		CDP.IdCartaDePorte = @IdCartaPorte and
			CABFAC.IdFactura=DETFAC.idFactura 
			and CDP.IdArticulo = DETFAC.IdArticulo
			and  charindex(Articulos.Descripcion, 'CAMBIO DE CARTA')=0 					 --
			--and  charindex(LOCDES.Descripcion  COLLATE SQL_Latin1_General_CP1_CI_AS, detfac.Observaciones)>0  --el destino
		)	


	
	end
	





	return ISNULL(@id, 0)
	
	end

