--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_InformesCorregido]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wCartasDePorte_TX_InformesCorregido
go


CREATE  PROCEDURE [dbo].wCartasDePorte_TX_InformesCorregido
    @IdCartaDePorte INT = NULL,
    @FechaDesde DATETIME = NULL,
    @FechaHasta DATETIME = NULL,

@idVendedor  INT = NULL,
@idCorredor INT = NULL, 
@idDestinatario INT = NULL, 
@idIntermediario INT = NULL,
@idRComercial INT = NULL, 
@idArticulo INT = NULL, 
@idProcedencia INT = NULL,
@idDestino INT = NULL

AS 
    SET NOCOUNT ON

    SET @IdCartaDePorte = ISNULL(@IdCartaDePorte, -1)
    SET @FechaDesde = ISNULL(@FechaDesde, CONVERT(DATETIME, '1/1/1900'))
    SET @FechaHasta = ISNULL(@FechaHasta, CONVERT(DATETIME, '1/1/2100'))
    SET @idVendedor = ISNULL(@idVendedor, -1)
    SET @idCorredor = ISNULL(@idCorredor, -1)
    SET @idDestinatario = ISNULL(@idDestinatario, -1)
    SET @idIntermediario = ISNULL(@idIntermediario, -1)
    SET @idRComercial = ISNULL(@idRComercial, -1)
    SET @idArticulo = ISNULL(@idArticulo, -1)
    SET @idProcedencia = ISNULL(@idProcedencia, -1)
    SET @idDestino = ISNULL(@idDestino, -1)

      
    SELECT  
			CDP.*,

			ISNULL(Articulos.AuxiliarString5,'') AS EspecieONCAA,	
 			ISNULL(Articulos.AuxiliarString6,'') AS CodigoSAJPYA,	
 			ISNULL(Articulos.AuxiliarString7,'') AS txtCodigoZeni,	

            
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
            


			isnull(CLISC1.Razonsocial,'') AS Subcontr1Desc,
            isnull(CLISC2.Razonsocial,'') AS Subcontr2Desc,
   
               isnull(Articulos.Descripcion,'') AS Producto,
            isnull(Transportistas.RazonSocial,'') AS TransportistaDesc,
            isnull(Choferes.Nombre,'') AS ChoferDesc,

--Choferes.RazonSocial,
            


            isnull(LOCORI.Nombre,'') AS ProcedenciaDesc,
			isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal,
		isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,
		isnull(LOCORI.CodigoWilliams,'') AS ProcedenciaCodigoWilliams,

            isnull(LOCDES.Descripcion,'') AS DestinoDesc,
			--LOCDES.CodigoPostal AS  DestinoCodigoPostal,
			isnull(LOCDES.CodigoPostal,'') AS  DestinoCodigoPostal,
			isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA, 
		isnull(LOCDES.CodigoWilliams,'') 	 AS  DestinoCodigoWilliams, 
		isnull(LOCDES.CUIT,'') 	 AS  DestinoCUIT, 

 choferes.cuil as  choferCUIT,
 Transportistas.cuit as  TransportistaCUIT,
              
            DATENAME(month, FechaDescarga) AS Mes,
            DATEPART(year, FechaDescarga) AS Ano, 

--null as TarifaSubcontratista1,
--null as TarifaSubcontratista2,
            
         	FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,
            FAC.FechaFactura,
            isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado,
            isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT,

            
            Calidades.Descripcion AS CalidadDesc,
			ExcluirDeSubcontratistas


--IdCartaDePorte,NumeroCartaDePorte,Arribo,Hora,Exporta,Producto, 
    FROM    CartasDePorte CDP
            LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
            LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
            LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
            LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
            LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
            LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
            LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
            LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad
            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista
			LEFT OUTER JOIN Choferes ON CDP.Idchofer = Choferes.Idchofer
            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad
            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
            LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura
            LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente
  
  
  

                    
    WHERE   --@IdCartaDePorte=-1 or 
		--(IdCartaDePorte=@IdCartaDePorte) AND 
            NOT ( Vendedor IS NULL
                  OR CLIVEN.Razonsocial = ''
                  OR Corredor IS NULL
                  OR Entregador IS NULL
                  OR CDP.IdArticulo IS NULL
                )
            AND ISNULL(NetoFinal, 0) > 0
            AND ISNULL(CDP.Anulada, 'NO') <> 'SI'
            AND ( ISNULL(FechaDescarga, '1/1/1753') BETWEEN @FechaDesde
                                                    AND     @FechaHasta )

and (
	(@idVendedor=Vendedor or @idIntermediario=CuentaOrden1 or  @idRComercial=CuentaOrden2)
       or 
	(@idVendedor=-1 and  @idIntermediario=-1  and @idRComercial=-1)
)

and (@idDestinatario=-1 or @idDestinatario=Entregador)
and (@idCorredor=-1 or @idCorredor=Corredor)
and (@idArticulo=-1 or @idArticulo=CDP.IdArticulo )
and (@idProcedencia=-1 or @idProcedencia=Procedencia)
and (@idDestino=-1 or @idDestino=Destino)


      

--solo incluir las descargas (tambien las descargas facturadas
    ORDER BY IdCartaDePorte DESC




GO



--exec wCartasDePorte_TX_InformesCorregido @IdCartaDePorte = -1
--exec wCartasDePorte_TX_Informes @IdCartaDePorte = -1, @FechaDesde = 'Ene  1 1753 12:00AM', @FechaHasta = 'Ene  1 2100 12:00AM'

--exec wCartasDePorte_TX_Informes @IdCartaDePorte = -1, @FechaDesde = 'Ene 31 2000 12:00AM', @FechaHasta = 'Ago 28 2010 12:00AM'
--wCartasDePorte_TX_InformesCorregido -1

--exec wCartasDePorte_TX_Informes @IdCartaDePorte = -1, @FechaDesde = 'Ene  1 1753 12:00AM', @FechaHasta = 'Ene  1 2100 12:00AM'


-- select * from facturas
--exec wCartasDePorte_T 
-- select * from vendedores
--select * from WilliamsDestinos

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
