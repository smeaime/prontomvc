--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_PorIdFactura]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wCartasDePorte_TX_PorIdFactura
go




CREATE  PROCEDURE [dbo].wCartasDePorte_TX_PorIdFactura
    @IdFactura INT 
AS 

select 


			CDP.IdCartaDePorte,
			CDP.NumeroCartaDePorte,
			detfac.iddetallefactura,
			detfac.observaciones as detobs,
			
			isnull(LOCDES.Descripcion,'') AS DestinoDesc,
			CDP.destino,
			CDP.entregador as destinatario,
			
			CDP.IdArticulo, 
			CDP.NetoFinal as Cantidad, --uso el de antes de quitarle las mermas

			
			CDP.Contrato,
			CDP.NetoFinal,
			CDP.FechaDescarga,
			CDP.AgregaItemDeGastosAdministrativos,


			CABFAC.IdFactura, 
			CABFAC.NumeroFactura,
			CABFAC.FechaFactura,
			CLIFAC.RazonSocial,
			CLIFAC.Direccion,
			CLIFAC.CodigoPostal,
			CABFAC.IdCodigoIva,
			CABFAC.Observaciones,

		
			/*
			DETFAC.IdArticulo,
			DETFAC.Observaciones as DetObservaciones,
			DETFAC.PrecioUnitario,
			DETFAC.Cantidad,
			DETFAC.PrecioUnitarioTotal,
			*/
         
			isnull(CLIVEN.Razonsocial,'') AS TitularDesc,
            isnull(CLIVEN.cuit,'') AS TitularCUIT,
        	isnull(CLICO1.Razonsocial,'') AS IntermediarioDesc,
            isnull(CLICO1.cuit,'') AS IntermediarioCUIT,
        	isnull(CLICO2.Razonsocial,'') AS RComercialDesc,
            isnull(CLICO2.cuit,'') AS RComercialCUIT,
        	isnull(CLICOR.Nombre,'') AS CorredorDesc,
            isnull(CLICOR.cuit,'') AS CorredorCUIT,
        	isnull(CLIENT.Razonsocial,'') AS DestinatarioDesc,
            isnull(CLIENT.cuit,'') AS DestinatarioCUIT,
			isnull(Articulos.Descripcion,'') AS Producto,
		 	'' AS  DestinoCodigoPostal,
			isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA,

substring(cabfac.NumeroExpedienteCertificacionObra,4,1) as AgrupacionUsada,


     CLIVEN.EsAcondicionadoraDeCartaPorte   as Acond1 ,
     CLICO1.EsAcondicionadoraDeCartaPorte    as Acond2  ,
     CLICO2.EsAcondicionadoraDeCartaPorte   as Acond3 ,
     CLIENT.EsAcondicionadoraDeCartaPorte as Acond4 ,


	 isnull(ESTAB.Descripcion,'') COLLATE SQL_Latin1_General_CP1_CI_AS +' '+ isnull(ESTAB.AuxiliarString1,'') COLLATE SQL_Latin1_General_CP1_CI_AS+ ' '+ isnull(ESTAB.AuxiliarString2,'') COLLATE SQL_Latin1_General_CP1_CI_AS
			as Establecimiento,


			isnull(LOCDES.CUIT,'') 	 AS  DestinoCUIT


from facturas CABFAC
left join CartasDePorte CDP on CDP.IdFacturaImputada=CABFAC.IdFactura  
LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento 
LEFT OUTER JOIN Log PRONTOLOG ON CABFAC.Idfactura = PRONTOLOG.Idcomprobante and prontolog.Detalle like 'Factura de CartasPorte%'
left OUTER  join detallefacturas DETFAC 
				on
				( 
					CABFAC.IdFactura=DETFAC.idFactura 
					and CDP.IdArticulo = DETFAC.IdArticulo
					and  charindex(Articulos.Descripcion, 'CAMBIO DE CARTA')=0 					 --
					and  charindex(LOCDES.Descripcion  COLLATE SQL_Latin1_General_CP1_CI_AS, detfac.Observaciones)>0  --el destino
					and 
					(
						(				
							substring(cabfac.NumeroExpedienteCertificacionObra,4,1)<>'4' --no es CANJE
							AND
							(
								LOCDES.Descripcion = cast(detfac.Observaciones as nvarchar(300)) + ' '
								or 
								charindex(CLIVEN.Razonsocial  COLLATE SQL_Latin1_General_CP1_CI_AS, detfac.Observaciones)>0
							)
						)
						or
						(
							--es canje (se agrupa por CLICO1 y CLICO2)
							substring(cabfac.NumeroExpedienteCertificacionObra,4,1)='4' --es CANJE
							AND
							charindex( CAST( isnull(CLICO1.IdCliente,-1) as varchar)  +  ' ' + CAST( isnull(CLICO2.IdCliente,-1) as varchar)     , detfac.Observaciones)>0
							--charindex(CLICO1.Razonsocial  COLLATE SQL_Latin1_General_CP1_CI_AS, PRONTOLOG.detalle )>0
							--or
							--charindex(CLICO2.Razonsocial  COLLATE SQL_Latin1_General_CP1_CI_AS, PRONTOLOG.detalle)>0
						)
					)
				)	
--cómo sé a qué item del detalle de la factura le corresponde cuál carta?
--qué agrupamientos de cartas son posibles en la factura?
-- -en las observaciones del item pongo la agrupacion (destino-destinatario/titular-etc) separando solamente con un espacio,asi
-- q no puedo saber 

LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad
LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista
LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer
LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad
LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = CABFAC.IdCliente


where CABFAC.idFactura=@idFactura
order by DETFAC.IdDetalleFactura --para q esten ordenados como en la factura    NumeroCartaDePorte






GO



--wCartasDePorte_TX_PorIdFactura 40000

--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////

