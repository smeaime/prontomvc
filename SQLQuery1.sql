SELECT DISTINCT    0 as ColumnaTilde,IdCartaDePorte, CDP.IdArticulo,      NumeroCartaDePorte, SubNumeroVagon, CDP.SubNumerodeFacturacion   , FechaArribo,        FechaDescarga  , CLICORCLI.Razonsocial as FacturarselaA, CLICORCLI.IdCliente as IdFacturarselaA,          isnull(CLICORCLI.Confirmado,'NO') as Confirmado,           CLICORCLI.IdCodigoIVA,           CLICORCLI.CUIT,           '' as ClienteSeparado,     ISNULL(dbo.wTarifaWilliams( CLICORCLI.IdCliente  ,CDP.IdArticulo,CDP.Destino , case when isnull(Exporta,'NO')='SI' then 1 else 0 end ,0  ),0) as TarifaFacturada  ,          Articulos.Descripcion as  Producto,         NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,  CuentaOrden1 as IdIntermediario, CuentaOrden2 as IdRComercial, Entregador as IdDestinatario,             CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,        CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],        CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc,         LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino, CDP.AgregaItemDeGastosAdministrativos,CDP.Exporta,IdClienteAFacturarle,IdClienteEntregador,ConDuplicados  FROM CartasDePorte CDP  LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente  LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente  LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente  LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor  LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)  LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente  LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo  LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista  LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer  LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad  LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino  LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICORCLI.idListaPrecios = LPD.idListaPrecios	AND LPD.idArticulo=CDP.IdArticulo 	AND isnull(LPD.IdDestinoDeCartaDePorte,isnull(CDP.Destino,''))=isnull(CDP.Destino,'')  JOIN wGrillaPersistencia as TEMPORAL ON (CDP.IdCartaDePorte = TEMPORAL.IdRenglon)              AND TEMPORAL.Sesion='1203617606'    WHERE 1=1  AND (  1=0       OR ( 1=1  ) )      AND    NetoProc>0 AND ( isnull(FechaDescarga,FechaArribo) Between convert(datetime,'1900/01/31',111)  AND convert(datetime,'2100/01/31',111)  )          AND (isnull(CDP.PuntoVenta,1)=1 OR CDP.PuntoVenta = 0)  AND (ISNULL(IdFacturaImputada,-1)=0 OR ISNULL(IdFacturaImputada,-1)=-1)    AND NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR CDP.IdArticulo IS NULL) AND ISNULL(NetoProc,0)>0 AND ISNULL(CDP.Anulada,'NO')<>'SI' group by IdCartaDePorte, CDP.IdArticulo,      NumeroCartaDePorte ,SubNumeroVagon ,CDP.SubNumeroDeFacturacion , FechaArribo,  FechaDescarga  , CLICORCLI.Razonsocial, CLICORCLI.IdCliente,  Articulos.Descripcion,         NetoFinal   ,  Corredor, Vendedor,  CuentaOrden1 , CuentaOrden2 , Entregador ,           CLIVEN.Razonsocial   ,         CLICO1.Razonsocial  ,        CLICO2.Razonsocial  ,         CLICOR.Nombre ,        CLIENT.Razonsocial  ,           LOCDES.Descripcion  ,         LOCORI.Nombre  , CDP.Exporta,                 CDP.Destino, CDP.AgregaItemDeGastosAdministrativos, TarifaFacturada,IdClienteAFacturarle, IdClienteEntregador, ConDuplicados,          CLICORCLI.Confirmado,           CLICORCLI.IdCodigoIVA,             CLICORCLI.CUIT   