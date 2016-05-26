IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_Todas]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wCartasDePorte_TX_Todas
go


CREATE  PROCEDURE [dbo].wCartasDePorte_TX_Todas
    @IdCartaDePorte INT = NULL,
    @FechaDesde DATETIME = NULL,
    @FechaHasta DATETIME = NULL
AS 
    SET NOCOUNT ON

    SET @IdCartaDePorte = ISNULL(@IdCartaDePorte, -1)
    SET @FechaDesde = ISNULL(@FechaDesde, CONVERT(DATETIME, '1/1/1753'))
    SET @FechaHasta = ISNULL(@FechaHasta, CONVERT(DATETIME, '1/1/2100'))

      
    SELECT  
			CDP.*,
 			ISNULL(CodigoSAJPYA,'') AS CodigoSAJPYA,	
            
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
--Choferes.RazonSocial,
            


            isnull(LOCORI.Nombre,'') AS ProcedenciaDesc,
			isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal,
		isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,

            isnull(LOCDES.Descripcion,'') AS DestinoDesc,
			--LOCDES.CodigoPostal AS  DestinoCodigoPostal,
			'' AS  DestinoCodigoPostal,
			LOCDES.codigoONCAA AS  DestinoCodigoONCAA,

  
              
            DATENAME(month, FechaDescarga) AS Mes,
            DATEPART(year, FechaDescarga) AS Ano, 

--null as TarifaSubcontratista1,
--null as TarifaSubcontratista2,
            
         	FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,
            FAC.FechaFactura,
            isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado,
            isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT,

            
            			Calidades.Descripcion AS CalidadDesc


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
--LEFT OUTER JOIN Choferes ON CDP.IdCliente = Choferes.IdCliente
            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad
            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
            LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura
            LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente
  
  
  

                    
    WHERE   1=1
		--@IdCartaDePorte=-1 or 
		--(IdCartaDePorte=@IdCartaDePorte) AND 
          
            AND ( ISNULL(FechaArribo, '1/1/1753') BETWEEN @FechaDesde
                                                    AND     @FechaHasta )

--solo incluir las descargas (tambien las descargas facturadas
    ORDER BY IdCartaDePorte DESC




GO