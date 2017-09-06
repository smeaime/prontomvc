



if OBJECT_ID ('fCalidadSerializada') is not null 
    drop function fCalidadSerializada
go 


create FUNCTION fCalidadSerializada
(
    @FK_ID INT -- The foreign key from TableA which is used 
               -- to fetch corresponding records
)
RETURNS VARCHAR(8000)
AS
BEGIN
DECLARE @SomeColumnList VARCHAR(4000);
DECLARE @SomeColumnList2 VARCHAR(4000);

SELECT @SomeColumnList =
    COALESCE(@SomeColumnList + '| ', '') + CAST(Campo AS varchar(100)) + ' '  + CAST(Valor AS varchar(20)) 
FROM CartasDePorteDetalle C
WHERE C.IdCartaDePorte= @FK_ID and valor<>0;



SELECT  
	@SomeColumnList2=
		case when CDP.NobleExtranos > 0 then '| Extraños '       + CAST(CDP.NobleExtranos AS varchar(20))   else  ''  end  + 
		case when CDP.NobleNegros   > 0 then '| Negros '         + CAST(CDP.NobleNegros AS varchar(20))     else  ''  end  +
		case when CDP.NobleQuebrados   > 0 then '| Quebrados '         + CAST(CDP.NobleQuebrados AS varchar(20))     else  ''  end  +
		case when CDP.NobleDaniados   > 0 then '| Dañados '         + CAST(CDP.NobleDaniados AS varchar(20))     else  ''  end  +
		case when CDP.NobleChamico   > 0 then '| Chamico '         + CAST(CDP.NobleChamico AS varchar(20))     else  ''  end  +
		case when CDP.NobleChamico2   > 0 then '| Chamico '         + CAST(CDP.NobleChamico2 AS varchar(20))     else  ''  end  +
		case when CDP.NobleRevolcado   > 0 then '| Revolcado '         + CAST(CDP.NobleRevolcado AS varchar(20))     else  ''  end  +
		case when CDP.NobleObjetables   > 0 then '| Objetables '         + CAST(CDP.NobleObjetables AS varchar(20))     else  ''  end  +
		case when CDP.NobleAmohosados   > 0 then '| Amohosados '         + CAST(CDP.NobleAmohosados AS varchar(20))     else  ''  end  +
		case when CDP.NobleHectolitrico   > 0 then '| Hectolitrico '         + CAST(CDP.NobleHectolitrico AS varchar(20))     else  ''  end  +
		case when CDP.NobleCarbon   > 0 then '| Carbon '         + CAST(CDP.NobleCarbon AS varchar(20))     else  ''  end  +
		case when CDP.NoblePanzaBlanca   > 0 then '| PanzaBlanca '         + CAST(CDP.NoblePanzaBlanca AS varchar(20))     else  ''  end  +
		case when CDP.NoblePicados   > 0 then '| Picados '         + CAST(CDP.NoblePicados AS varchar(20))     else  ''  end  +
		case when CDP.NobleMGrasa   > 0 then '| MGrasa '         + CAST(CDP.NobleMGrasa AS varchar(20))     else  ''  end  +
		case when CDP.NobleAcidezGrasa   > 0 then '| AcidezGrasa '         + CAST(CDP.NobleAcidezGrasa AS varchar(20))     else  ''  end  +
		case when CDP.NobleVerdes   > 0 then '| Verdes '         + CAST(CDP.NobleVerdes AS varchar(20))     else  ''  end  +
		case when CDP.NobleGrado   > 0 then '| Grado '         + CAST(CDP.NobleGrado AS varchar(20))     else  ''  end  +
		case when CDP.NobleConforme   > 0 then '| Conforme '         + CAST(CDP.NobleConforme AS varchar(20))     else  ''  end  +
		case when CDP.NobleACamara   > 0 then '| ACamara '         + CAST(CDP.NobleACamara AS varchar(20))     else  ''  end  +
		case when CDP.CalidadGranosQuemados   > 0 then '| Quemados '         + CAST(CDP.CalidadGranosQuemados AS varchar(20))     else  ''  end  +
		case when CDP.CalidadTierra   > 0 then '| Tierra '         + CAST(CDP.CalidadTierra AS varchar(20))     else  ''  end  



FROM CartasDePorte CDP
WHERE CDP.IdCartaDePorte= @FK_ID;


RETURN 
(
    SELECT  COALESCE(@SomeColumnList2+'','') + COALESCE(@SomeColumnList,'') + case when @SomeColumnList='' or @SomeColumnList2='' then  '' else '|' end
)
END

go



--select * from CartasDePorteDetalle where valor <> 0
--select NobleExtranos,idcartadeporte from CartasDePorte where NobleExtranos <> 0

--update CartasDePorte  set NobleExtranos=2.5, noblenegros=6.8  where  IdCartaDePorte= 2054771

print dbo.fCalidadSerializada(2054771)
print dbo.fCalidadSerializada(20091)
print dbo.fCalidadSerializada(20090)











/*


SELECT CDP.IdCartaDePorte, CDP.NumeroCartaDePorte, CDP.IdUsuarioIngreso, CDP.FechaIngreso, CDP.Anulada, CDP.FechaAnulacion, 
                                       dbo.fCalidadSerializada( CDP.IdCartaDePorte)  +  CDP.Observaciones   as Observaciones, 
                            CDP.Cantidad, CDP.Cupo, CDP.NetoProc, CDP.BrutoPto, CDP.TaraPto, CDP.NetoPto, CDP.Acoplado, CDP.Humedad, CDP.Merma,HumedadDesnormalizada, CDP.NetoFinal, CDP.CTG   ,Patente   ,CDP.Contrato , 
CDP.FechaDeCarga, CDP.FechaVencimiento,  CDP.SubnumeroVagon , CDP.FechaArribo  , CDP.CEE     ,CDP.FechaDescarga      ,CDP.Hora      ,CDP.NRecibo      ,CDP.CalidadDe      ,CDP.TaraFinal      ,CDP.BrutoFinal , TitularDesc, TitularCUIT, 	
IntermediarioDesc,              IntermediarioCUIT, 		RComercialDesc,             RComercialCUIT, 		CorredorDesc,              CorredorCUIT, DestinatarioDesc,DestinatarioCUIT             ,Producto, 			TransportistaCUIT,             
TransportistaDesc, 			ChoferCUIT, 			ChoferDesc,            ProcedenciaDesc, 		ProcedenciaCodigoPostal, 		ProcedenciaCodigoONCAA,           ProcedenciaProvinciaDesc,       DestinoDesc   ,  
EntregadorDesc,Cosecha, CalidadDesc,  DestinoCodigoONCAA, KmARecorrer	,Tarifa ,EstablecimientoDesc    ,CDP.PathImagen      ,CDP.PathImagen2     ,ClienteAuxiliarDesc,CorredorDesc2  CorredorCUIT2,ClientePagadorFleteDesc, 
ProcedenciaProvinciaPartido, ProcedenciaPartidoNormalizadaCodigo, DestinoProvinciaDesc, ProcedenciaPartidoNormalizada, EntregadorCUIT, CodigoAFIP, MermaVolatil,ClaveEncriptada          FROM (  SELECT TOP 10000  CDP.IdCartaDePorte, CDP.NumeroCartaDePorte, CDP.IdUsuarioIngreso, CDP.FechaIngreso, CDP.Anulada, CDP.IdUsuarioAnulo, CDP.FechaAnulacion, CDP.Observaciones, CDP.FechaTimeStamp, CDP.Vendedor, CDP.CuentaOrden1, CDP.CuentaOrden2, CDP.Corredor, CDP.Entregador, CDP.Procedencia, CDP.Patente, CDP.IdArticulo, CDP.IdStock, CDP.Partida, CDP.IdUnidad, CDP.IdUbicacion, CDP.Cantidad, CDP.Cupo, CDP.NetoProc, CDP.Calidad       ,CDP.BrutoPto      ,CDP.TaraPto      ,CDP.NetoPto      ,CDP.Acoplado      ,CDP.Humedad      ,CDP.Merma      ,CDP.NetoFinal      ,CDP.FechaDeCarga      ,CDP.FechaVencimiento      ,CDP.CEE      ,CDP.IdTransportista      ,CDP.TransportistaCUITdesnormalizado      ,CDP.IdChofer      ,CDP.ChoferCUITdesnormalizado      ,CDP.CTG      ,CDP.Contrato      ,CDP.Destino      ,CDP.Subcontr1      ,CDP.Subcontr2      ,CDP.Contrato1       ,CDP.contrato2      ,CDP.KmARecorrer      ,CDP.Tarifa      ,CDP.FechaDescarga      ,CDP.Hora      ,CDP.NRecibo      ,CDP.CalidadDe      ,CDP.TaraFinal      ,CDP.BrutoFinal      ,CDP.Fumigada      ,CDP.Secada      ,CDP.Exporta      ,CDP.NobleExtranos      ,CDP.NobleNegros      ,CDP.NobleQuebrados      ,CDP.NobleDaniados      ,CDP.NobleChamico      ,CDP.NobleChamico2      ,CDP.NobleRevolcado      ,CDP.NobleObjetables      ,CDP.NobleAmohosados      ,CDP.NobleHectolitrico      ,CDP.NobleCarbon       ,CDP.NoblePanzaBlanca      ,CDP.NoblePicados      ,CDP.NobleMGrasa      ,CDP.NobleAcidezGrasa      ,CDP.NobleVerdes      ,CDP.NobleGrado      ,CDP.NobleConforme      ,CDP.NobleACamara      ,CDP.Cosecha      ,CDP.HumedadDesnormalizada      ,CDP.Factor      ,CDP.IdFacturaImputada      ,CDP.PuntoVenta      ,CDP.SubnumeroVagon      ,CDP.TarifaFacturada      ,CDP.TarifaSubcontratista1      ,CDP.TarifaSubcontratista2      ,CDP.FechaArribo      ,CDP.Version      ,CDP.MotivoAnulacion       ,CDP.NumeroSubfijo      ,CDP.IdEstablecimiento      ,CDP.EnumSyngentaDivision      ,CDP.Corredor2      ,CDP.IdUsuarioModifico      ,CDP.FechaModificacion      ,CDP.FechaEmision      ,CDP.EstaArchivada      ,CDP.ExcluirDeSubcontratistas      ,CDP.IdTipoMovimiento      ,CDP.IdClienteAFacturarle      ,CDP.SubnumeroDeFacturacion      ,CDP.AgregaItemDeGastosAdministrativos      ,CDP.CalidadGranosQuemados      ,CDP.CalidadGranosQuemadosBonifica_o_Rebaja      ,CDP.CalidadTierra      ,CDP.CalidadTierraBonifica_o_Rebaja      ,CDP.CalidadMermaChamico       ,CDP.CalidadMermaChamicoBonifica_o_Rebaja      ,CDP.CalidadMermaZarandeo      ,CDP.CalidadMermaZarandeoBonifica_o_Rebaja      ,CDP.FueraDeEstandar      ,CDP.CalidadPuntaSombreada      ,CDP.CobraAcarreo      ,CDP.LiquidaViaje      ,CDP.IdClienteAuxiliar      ,CDP.CalidadDescuentoFinal      ,CDP.PathImagen      ,CDP.PathImagen2       ,CDP.AgrupadorDeTandaPeriodos      ,CDP.ClaveEncriptada      ,CDP.NumeroCartaEnTextoParaBusqueda      ,CDP.IdClienteEntregador      ,CDP.IdDetalleFactura      ,CDP.SojaSustentableCodCondicion      ,CDP.SojaSustentableCondicion      ,CDP.SojaSustentableNroEstablecimientoDeProduccion      ,CDP.IdClientePagadorFlete      ,CDP.SubnumeroVagonEnTextoParaBusqueda      ,CDP.IdCorredor2       ,CDP.Acopio1      ,CDP.Acopio2      ,CDP.Acopio3      ,CDP.Acopio4      ,CDP.Acopio5 ,CDP.Acopio6        ,CDP.AcopioFacturarleA      ,CDP.CalidadGranosDanadosRebaja      ,CDP.CalidadGranosExtranosRebaja , 			cast (cdp.NumeroCartaDePorte as varchar) +					CASE WHEN cdp.numerosubfijo<>0 OR cdp.subnumerovagon<>0 THEN            '  ' + cast (cdp.numerosubfijo as varchar) + '/' +cast (cdp.subnumerovagon as varchar) 						ELSE             ''            End				as NumeroCompleto,			datediff(minute,cdp.FechaModificacion,GETDATE()) as MinutosModifico,  			ISNULL(Articulos.AuxiliarString5,'') AS EspecieONCAA,	  			ISNULL(Articulos.AuxiliarString6,'') AS CodigoSAJPYA,	  			ISNULL(Articulos.AuxiliarString7,'') AS txtCodigoZeni,	 			isnull(CLIVEN.Razonsocial,'') AS TitularDesc,             isnull(CLIVEN.cuit,'') AS TitularCUIT, 			isnull(CLICO1.Razonsocial,'') AS IntermediarioDesc,             isnull(CLICO1.cuit,'') AS IntermediarioCUIT, 			isnull(CLICO2.Razonsocial,'') AS RComercialDesc,             isnull(CLICO2.cuit,'') AS RComercialCUIT, 			isnull(CLICOR.Nombre,'') AS CorredorDesc,             isnull(CLICOR.cuit,'') AS CorredorCUIT, 			isnull(CLIENT.Razonsocial,'') AS DestinatarioDesc, 			isnull(CLIENTREG.Razonsocial,'') AS EntregadorDesc,             isnull(CLIENT.cuit,'') AS DestinatarioCUIT, 			isnull(CLIAUX.Razonsocial,'') AS ClienteAuxiliarDesc, 			isnull(CLIAUX.cuit,'') AS ClienteAuxiliarCUIT, 			isnull(CLISC1.Razonsocial,'') AS Subcontr1Desc,             isnull(CLISC2.Razonsocial,'') AS Subcontr2Desc,              isnull(Articulos.Descripcion,'') AS Producto, 			 Transportistas.cuit as  TransportistaCUIT,             isnull(Transportistas.RazonSocial,'') AS TransportistaDesc, 			choferes.cuil as  ChoferCUIT, 			choferes.Nombre as  ChoferDesc,            isnull(LOCORI.Nombre,'') AS ProcedenciaDesc, 		isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal, 		isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,            isnull(PROVORI.Nombre,'') AS ProcedenciaProvinciaDesc,        isnull(LOCDES.Descripcion,'') AS DestinoDesc,             '' AS  DestinoCodigoPostal, 			isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA,            DATENAME(month, FechaDescarga) AS Mes,           DATEPART(year, FechaDescarga) AS Ano,        	FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,            FAC.FechaFactura,           isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado,          isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT, 		Calidades.Descripcion AS CalidadDesc, 	    E1.Nombre as UsuarioIngreso,isnull(ESTAB.Descripcion,'') COLLATE SQL_Latin1_General_CP1_CI_AS +' '+ isnull(ESTAB.AuxiliarString1,'') COLLATE SQL_Latin1_General_CP1_CI_AS+ ' '+ isnull(ESTAB.AuxiliarString2,'') COLLATE SQL_Latin1_General_CP1_CI_AS                                                                                                 as EstablecimientoDesc, 			isnull(CLIENTFLET.Razonsocial,'') AS ClientePagadorFleteDesc ,           isnull(LOCORI.Partido,'') AS ProcedenciaProvinciaPartido,      isnull(PARTORI.Codigo,'') AS ProcedenciaPartidoNormalizadaCodigo,    isnull(PROVDEST.Nombre,'') AS DestinoProvinciaDesc,   isnull(PARTORI.Nombre,'') AS ProcedenciaPartidoNormalizada   , 			isnull(CLICOR2.Nombre,'') AS CorredorDesc2,             isnull(CLICOR2.cuit,'') AS CorredorCUIT2, 			isnull(CLIENTREG.cuit,'') AS EntregadorCUIT, 		isnull(LOCORI.CodigoAFIP,'') AS CodigoAFIP, 		CDPDET.Valor as MermaVolatil   FROM    CartasDePorte CDP           LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente        LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente        LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente        LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar= CLIAUX.IdCliente        LEFT OUTER JOIN Clientes CLIENTREG ON CDP.IdClienteEntregador= CLIENTREG.IdCliente        LEFT OUTER JOIN Clientes CLIENTFLET ON CDP.IdClientePagadorFlete= CLIENTFLET.IdCliente        LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor        LEFT OUTER JOIN Vendedores CLICOR2 ON CDP.Corredor2 = CLICOR2.IdVendedor        LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente         LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente          LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente          LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo           LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista 			LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad            LEFT OUTER JOIN Provincias PROVORI ON LOCORI.IdProvincia = PROVORI.IdProvincia            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino            LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento             LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura             LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente             LEFT OUTER JOIN Partidos PARTORI ON LOCORI.IdPartido = PARTORI.IdPartido             LEFT OUTER JOIN Provincias PROVDEST ON LOCDES.IdProvincia = PROVDEST.IdProvincia   LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado  LEFT OUTER JOIN CartasDePorteDetalle CDPDET ON CDP.IdCartaDePorte = CDPDET.IdCartaDePorte And CDPDET.Campo = 'CalidadMermaVolatilMerma'   WHERE 1=1  AND NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR CDP.IdArticulo IS NULL) AND ISNULL(NetoProc,0)>0 AND ISNULL(CDP.Anulada,'NO')<>'SI'    AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') >= '20140101'     AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') <= '20140102'  and EXISTS ( SELECT * FROM CartasDePorte COPIAS  where COPIAS.NumeroCartaDePorte=CDP.NumeroCartaDePorte and COPIAS.SubnumeroVagon=CDP.SubnumeroVagon   AND ISNULL(COPIAS.Anulada,'NO')<>'SI'  )  AND ISNULL(CDP.SubnumeroDeFacturacion, 0) <= 0  AND NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR CDP.IdArticulo IS NULL) AND ISNULL(NetoProc,0)>0 AND ISNULL(CDP.Anulada,'NO')<>'SI') AS CDP


*/