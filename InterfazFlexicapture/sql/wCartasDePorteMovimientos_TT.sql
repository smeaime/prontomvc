--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorteMovimientos_TT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wCartasDePorteMovimientos_TT
go


CREATE  PROCEDURE [dbo].wCartasDePorteMovimientos_TT
    
AS 
    SET NOCOUNT ON

    
      
    SELECT  * from vistaCartasPorteMovimientos 
			
GO

--select * from CartasPorteMovimientos
--exec wCartasDePorteMovimientos_TT

--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////


--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[VistaCartasPorteMovimientos]')
                    AND OBJECTPROPERTY(id, N'IsView') = 1 ) 
    DROP VIEW [VistaCartasPorteMovimientos]
go


CREATE VIEW [dbo].[VistaCartasPorteMovimientos]
as	      
    SELECT  --CDP.*,
			--movs.Anulada,
			movs.*,
			--movs.Contrato,
			--movs.Entrada_o_Salida,
		
			--movs.FechaAnulacion,
			--movs.FechaIngreso,
			--movs.IdAjusteStock,
			--movs.IdCDPMovimiento,
			--movs.Observaciones,
			--movs.Puerto,
			--movs.Tipo,
			--movs.Vapor,
			--movs.Partida,
			
			CDP.NetoPto,
			CDP.Humedad,
			CDP.Calidad,
			CDP.Merma,
			CDP.NetoFinal,
			--CDP.ProcedenciaDesc,
			CDP.NRecibo,
			'' as SubtotalPorRecibo,
			CDP.Patente,
			CDP.NumeroCartadePorte,
			--CDP.FechaIngreso,
			--CDP.CorredorDesc as CDPCorredorDesc,
			--CDP.VendedorDesc as CDPVendedorDesc,
			CDP.exporta,

			MOVSVEN.Razonsocial AS ExportadorOrigen,
            MOVSCORR.Razonsocial AS ExportadorDestino,
            Articulos.Descripcion AS MovProductoDesc,
            MOVSDES.Descripcion AS MovDestinoDesc,

			FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,
	     	FAC.fechafactura,
			CLIFAC.razonsocial  AS ClienteFacturado          

			
			--agregar primary keys para que el EF pueda importar la vista
			,clifac.idcliente,fac.idfactura,movsven.IdCliente as c1,movscorr.IdCliente as c2,movsdes.IdWilliamsDestino,Articulos.IdArticulo as a


    FROM    CartasPorteMovimientos MOVS
			LEFT OUTER JOIN cartasdeporte CDP ON MOVS.idcartadeporte=CDP.idcartadeporte

            LEFT OUTER JOIN Clientes MOVSVEN ON MOVS.IdExportadorOrigen = MOVSVEN.IdCliente
            LEFT OUTER JOIN Clientes MOVSCORR ON MOVS.IdExportadorDestino = MOVSCORR.IdCliente
            LEFT OUTER JOIN WilliamsDestinos MOVSDES ON MOVS.Puerto = MOVSDES.IdWilliamsDestino
            LEFT OUTER JOIN Articulos ON MOVS.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN FACTURAS FAC ON FAC.idfactura= MOVS.idfacturaimputada
             LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente
           
   


GO


--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////


exec wCartasDePorteMovimientos_TT