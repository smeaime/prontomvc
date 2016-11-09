Attribute VB_Name = "ProduccionModulo"
Option Explicit














Public Enum enumSPs
        wRequerimientos_TTpaginado
        wComprobantesProveedores_TXFecha
        '_AlterTable
        '_TempBasesConciliacion_BorrarTabla
        '_TempBasesConciliacion_InsertarRegistro
        '_TempBasesConciliacion_TX_TraerTodo
        '_TempCondicionesCompra_A
        '_TempCondicionesCompra_BorrarTabla
        '_TempCondicionesCompra_Generar
        '_TempCondicionesCompra_T
        '_TempCuboCostosImportacion_TX_VerificarSiHayRegistros
        '_TempCuboIngresoEgresosPorObra_TX_EgresosPorObra
        '_TempCuboIngresoEgresosPorObra_TX_ObrasProcesadas
        '_TempCuboIngresoEgresosPorObra_TX_VerificarSiHayRegistros
        '_TempCuboReservaPresupuestaria_TX_VerificarSiHayRegistros
        '_TempCuboVentasEnCuotas_TX_VerificarSiHayRegistros
        '_TempCuentasCorrientesAcreedores_A
        '_TempCuentasCorrientesAcreedores_BorrarTabla
        '_TempCuentasCorrientesAcreedores_Generar
        '_TempCuentasCorrientesAcreedores_T
        '_TempSAP_TX_CAI
        '_TempSAP_TX_Partidas
        '_TempSAP_TX_Proveedores
        Acabados_A
        Acabados_E
        Acabados_M
        Acabados_T
        Acabados_TL
        Acabados_TT
        Acabados_TX_TT
        AcoAcabados_A
        AcoAcabados_E
        AcoAcabados_M
        AcoAcabados_T
        AcoAcabados_TT
        AcoAcabados_TX_TT
        AcoAcabados_TXTL
        AcoBiselados_A
        AcoBiselados_E
        AcoBiselados_M
        AcoBiselados_T
        AcoBiselados_TT
        AcoBiselados_TX_TT
        AcoBiselados_TXTL
        AcoCalidades_A
        AcoCalidades_E
        AcoCalidades_M
        AcoCalidades_T
        AcoCalidades_TT
        AcoCalidades_TX_TT
        AcoCalidades_TXTL
        AcoCodigos_A
        AcoCodigos_E
        AcoCodigos_M
        AcoCodigos_T
        AcoCodigos_TT
        AcoCodigos_TX_TT
        AcoCodigos_TXTL
        AcoColores_A
        AcoColores_E
        AcoColores_M
        AcoColores_T
        AcoColores_TT
        AcoColores_TX_TT
        AcoColores_TXTL
        AcoFormas_A
        AcoFormas_E
        AcoFormas_M
        AcoFormas_T
        AcoFormas_TT
        AcoFormas_TX_TT
        AcoFormas_TXTL
        AcoGrados_A
        AcoGrados_E
        AcoGrados_M
        AcoGrados_T
        AcoGrados_TT
        AcoGrados_TX_TT
        AcoGrados_TXTL
        AcoHHItemsDocumentacion_A
        AcoHHItemsDocumentacion_E
        AcoHHItemsDocumentacion_M
        AcoHHItemsDocumentacion_T
        AcoHHItemsDocumentacion_TT
        AcoHHItemsDocumentacion_TX_PorGrupo
        AcoHHItemsDocumentacion_TX_TT
        AcoHHTareas_A
        AcoHHTareas_E
        AcoHHTareas_M
        AcoHHTareas_T
        AcoHHTareas_TT
        AcoHHTareas_TX_TodosLosGrupos
        AcoHHTareas_TX_TT
        AcoMarcas_A
        AcoMarcas_E
        AcoMarcas_M
        AcoMarcas_T
        AcoMarcas_TT
        AcoMarcas_TX_TT
        AcoMarcas_TXTL
        AcoMateriales_A
        AcoMateriales_E
        AcoMateriales_M
        AcoMateriales_T
        AcoMateriales_TT
        AcoMateriales_TX_TT
        AcoMateriales_TXTL
        AcoModelos_A
        AcoModelos_E
        AcoModelos_M
        AcoModelos_T
        AcoModelos_TT
        AcoModelos_TX_TT
        AcoModelos_TXTL
        AcoNormas_A
        AcoNormas_E
        AcoNormas_M
        AcoNormas_T
        AcoNormas_TT
        AcoNormas_TX_TT
        AcoNormas_TXTL
        Acopios_A
        Acopios_ActualizarEstado
        Acopios_BorrarAutorizaciones
        Acopios_E
        Acopios_M
        Acopios_T
        Acopios_TL
        Acopios_TT
        Acopios_TX_Cumplidos
        Acopios_TX_DatosAcopio
        Acopios_TX_DetallesAgrupadosPorComprador
        Acopios_TX_ItemsPorObra
        Acopios_TX_ItemsPorObra1
        Acopios_TX_ParaTransmitir
        Acopios_TX_ParaTransmitir_Todos
        Acopios_TX_Pendientes
        Acopios_TX_Pendientes1
        Acopios_TX_PendientesPorLA
        Acopios_TX_PendientesPorLA1
        Acopios_TX_PorEquipo
        Acopios_TX_PorEquipo_Todo
        Acopios_TX_SetearComoTransmitido
        Acopios_TX_SinControl
        Acopios_TX_SinFechaNecesidad
        Acopios_TX_Sumarizadas
        Acopios_TX_TodasLasRevisiones
        Acopios_TX_TodosLosDetalles
        Acopios_TX_TT
        Acopios_TXItems
        Acopios_TXItems1
        Acopios_TXNombre
        Acopios_TXNro
        Acopios_TXPorObra
        Acopios_TXTLObra
        AcoSchedulers_A
        AcoSchedulers_E
        AcoSchedulers_M
        AcoSchedulers_T
        AcoSchedulers_TT
        AcoSchedulers_TX_TT
        AcoSchedulers_TXTL
        AcoSeries_A
        AcoSeries_E
        AcoSeries_M
        AcoSeries_T
        AcoSeries_TT
        AcoSeries_TX_TT
        AcoSeries_TXTL
        AcoTipos_A
        AcoTipos_E
        AcoTipos_M
        AcoTipos_T
        AcoTipos_TT
        AcoTipos_TX_TT
        AcoTipos_TXTL
        AcoTiposRosca_A
        AcoTiposRosca_E
        AcoTiposRosca_M
        AcoTiposRosca_T
        AcoTiposRosca_TT
        AcoTiposRosca_TX_TT
        AcoTiposRosca_TXTL
        AcoTratamientos_A
        AcoTratamientos_E
        AcoTratamientos_M
        AcoTratamientos_T
        AcoTratamientos_TT
        AcoTratamientos_TX_TT
        AcoTratamientos_TXTL
        ActividadesProveedores_A
        ActividadesProveedores_E
        ActividadesProveedores_M
        ActividadesProveedores_T
        ActividadesProveedores_TL
        ActividadesProveedores_TT
        ActividadesProveedores_TX_TT
        AjustesStock_A
        AjustesStock_ActualizarDetalles
        AjustesStock_E
        AjustesStock_M
        AjustesStock_T
        AjustesStock_TT
        AjustesStock_TX_PorIdOrigen
        AjustesStock_TX_PorIdOrigenDetalle
        AjustesStock_TX_PorMarbete
        AjustesStock_TX_Todos
        AjustesStock_TX_TT
        AjustesStock_TXAnio
        AjustesStock_TXFecha
        AjustesStock_TXMes
        AjustesStockSAT_A
        AjustesStockSAT_ActualizarDetalles
        AjustesStockSAT_M
        AjustesStockSAT_T
        AjustesStockSAT_TX_PorIdOrigen
        AjustesStockSAT_TX_PorIdOrigenDetalle
        AjustesStockSAT_TX_Todos
        AjustesStockSAT_TXAnio
        AjustesStockSAT_TXFecha
        AjustesStockSAT_TXMes
        AlimentacionesElectricas_A
        AlimentacionesElectricas_E
        AlimentacionesElectricas_M
        AlimentacionesElectricas_T
        AlimentacionesElectricas_TL
        AlimentacionesElectricas_TT
        AlimentacionesElectricas_TX_TT
        AnexosEquipos_A
        AnexosEquipos_E
        AnexosEquipos_M
        AnexosEquipos_T
        AnexosEquipos_TL
        AnexosEquipos_TT
        AnexosEquipos_TX_TT
        AniosNorma_A
        AniosNorma_E
        AniosNorma_M
        AniosNorma_T
        AniosNorma_TL
        AniosNorma_TT
        AniosNorma_TX_TT
        AnticiposAlPersonal_A
        AnticiposAlPersonal_BorrarPorIdOrdenPago
        AnticiposAlPersonal_BorrarPorIdRecibo
        AnticiposAlPersonal_E
        AnticiposAlPersonal_M
        AnticiposAlPersonal_T
        AnticiposAlPersonal_TT
        AnticiposAlPersonal_TX_Asiento
        AnticiposAlPersonal_TX_Detallado
        AnticiposAlPersonal_TX_Estructura
        AnticiposAlPersonal_TX_OPago
        AnticiposAlPersonal_TX_Recibo
        AnticiposAlPersonal_TX_Resumido
        AnticiposAlPersonal_TX_Todos
        AnticiposAlPersonal_TXPrimero
        AnticiposAlPersonal_TXPrimeroRecibo
        AnticiposAlPersonalSyJ_A
        AnticiposAlPersonalSyJ_E
        AnticiposAlPersonalSyJ_M
        AnticiposAlPersonalSyJ_T
        AnticiposAlPersonalSyJ_TransferirAnticiposAlSyJ
        AnticiposAlPersonalSyJ_TT
        AnticiposAlPersonalSyJ_TX_Conceptos
        AnticiposAlPersonalSyJ_TX_EmpleadosActivos
        AnticiposAlPersonalSyJ_TX_ParametrosLiquidaciones
        ArchivosATransmitir_TT
        ArchivosATransmitir_TX_PorSistema
        ArchivosATransmitirDestinos_A
        ArchivosATransmitirDestinos_E
        ArchivosATransmitirDestinos_M
        ArchivosATransmitirDestinos_T
        ArchivosATransmitirDestinos_TL
        ArchivosATransmitirDestinos_TT
        ArchivosATransmitirDestinos_TX_Activos
        ArchivosATransmitirDestinos_TX_ActivosPorSistema
        ArchivosATransmitirDestinos_TX_ActivosPorSistemaParaCombo
        ArchivosATransmitirDestinos_TX_Todos
        ArchivosATransmitirDestinos_TX_TT
        ArchivosATransmitirLoteo_A
        ArchivosATransmitirLoteo_E
        ArchivosATransmitirLoteo_M
        ArchivosATransmitirLoteo_T
        ArchivosATransmitirLoteo_TT
        ArchivosATransmitirLoteo_TX_EstadoGeneral
        ArchivosATransmitirLoteo_TX_PorArchivoLote
        ArchivosATransmitirLoteo_TX_UltimoLote
        Articulos_A
        Articulos_BorrarPorIdRubro
        Articulos_C
        Articulos_E
        Articulos_M
        Articulos_RecalcularCostoPPP_PorIdArticulo
        Articulos_RecalcularStock
        Articulos_RegistrarAlicuotaIVA
        Articulos_T
        Articulos_TL
        Articulos_TT
        Articulos_TX_AgrupadoPorFamilia
        Articulos_TX_AgrupadoPorRubro
        Articulos_TX_AgrupadoPorSubrubro
        Articulos_TX_AmortizacionesAFecha
        Articulos_TX_AmortizacionesAFechaPorRevaluo
        Articulos_TX_AmortizacionesAFechaPorRevaluoArticulo
        Articulos_TX_AVL
        Articulos_TX_BD_ProntoMantenimiento
        Articulos_TX_BD_ProntoMantenimientoExiste
        Articulos_TX_BD_ProntoMantenimientoPorId
        Articulos_TX_BD_ProntoMantenimientoPorNumeroInventario
        Articulos_TX_BD_ProntoMantenimientoTodos
        Articulos_TX_Busca
        Articulos_TX_BuscaConFormato
        Articulos_TX_Cardex
        Articulos_TX_Clave
        Articulos_TX_CostosImportacionAAsignar
        Articulos_TX_CostosPorEquipo
        Articulos_TX_DatosConCuenta
        Articulos_TX_EquiposTerceros
        Articulos_TX_HistoriaEquiposInstalados
        Articulos_TX_Inactivos
        Articulos_TX_ListaParaCardex
        Articulos_TX_ModificacionActivoFijo
        Articulos_TX_ModificacionActivoFijo_TT
        Articulos_TX_ParaMantenimiento_ParaCombo
        Articulos_TX_ParaMenu
        Articulos_TX_ParaMenu1
        Articulos_TX_ParaTransmitir
        Articulos_TX_ParaTransmitir_Todos
        Articulos_TX_ParaTransmitirPorIdRubros
        Articulos_TX_ParaTransmitirPRONTO_MANTENIMIENTO
        Articulos_TX_PorCodigo
        Articulos_TX_PorDescripcion
        Articulos_TX_PorDescripcionTipoParaCombo
        Articulos_TX_PorFechaAlta
        Articulos_TX_PorGrupo
        Articulos_TX_PorId
        Articulos_TX_PorIdConDatos
        Articulos_TX_PorIdRubro
        Articulos_TX_PorIdRubroParaCombo
        Articulos_TX_PorIdTipoParaCombo
        Articulos_TX_PorIdTipoParaLista
        Articulos_TX_PorIdTransportista
        Articulos_TX_PorNumeroInventario
        Articulos_TX_PorNumeroInventarioIdTransportista
        Articulos_TX_ProduciblesParaCombo
        Articulos_TX_ResumenRemitosPorRubro
        Articulos_TX_ResumenVentasPorRubro
        Articulos_TX_Resumidos
        Articulos_TX_RevaluosAFechaResumido
        Articulos_TX_SaldosDeStockAFecha
        Articulos_TX_SetearComoTransmitido
        Articulos_TX_Stock
        Articulos_TX_StockDet
        Articulos_TX_StockDetSinPartida
        Articulos_TX_StockPorArticuloPartidaUnidadUbicacionObra
        Articulos_TX_StockPorPartida
        Articulos_TX_StockTotalPorArticulo
        Articulos_TX_TodosParaCostos
        Articulos_TX_TT
        Articulos_TX_UnidadesHabilitadas
        Articulos_TX_ValidarCodigo
        Articulos_TX_ValidarNumeroInventario
        Articulos_TX_xDetLMat
        ArticulosInformacionAdicional_A
        ArticulosInformacionAdicional_E
        ArticulosInformacionAdicional_M
        ArticulosInformacionAdicional_T
        ArticulosInformacionAdicional_TX_PorArticulo
        Asientos_A
        Asientos_BorrarEntreFechas
        Asientos_CambiarNumero
        Asientos_E
        Asientos_Eliminar
        Asientos_EliminarDetalles
        Asientos_EliminarItemChequePagoDiferido
        Asientos_GenerarAsientoChequesDiferidos
        Asientos_M
        Asientos_T
        Asientos_TT
        Asientos_TX_DetallesPorIdAsiento
        Asientos_TX_EntreFechas
        Asientos_TX_PorArchivoImportacion
        Asientos_TX_PorNumero
        Asientos_TX_PorSubdiario
        Asientos_TX_TT
        Asientos_TXAnio
        Asientos_TXAsientosxAnio
        Asientos_TXCod
        Asientos_TXFecha
        Asientos_TXMes
        Asientos_TXMesAnio
        AsignacionesCostos_A
        AsignacionesCostos_E
        AsignacionesCostos_M
        AsignacionesCostos_T
        AsignacionesCostos_TT
        AsignacionesCostos_TX_PorIdCosto
        AsignacionesCostos_TX_TT
        Autorizaciones_A
        Autorizaciones_E
        Autorizaciones_M
        Autorizaciones_T
        Autorizaciones_TT
        Autorizaciones_TX_CantidadAutorizaciones
        Autorizaciones_TX_PorFormulario
        Autorizaciones_TX_PorIdFormulario
        Autorizaciones_TX_TT
        AutorizacionesPorComprobante_A
        AutorizacionesPorComprobante_DarPorVisto
        AutorizacionesPorComprobante_E
        AutorizacionesPorComprobante_Generar
        AutorizacionesPorComprobante_GenerarFirmas
        AutorizacionesPorComprobante_M
        AutorizacionesPorComprobante_T
        AutorizacionesPorComprobante_TT
        AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante
        AutorizacionesPorComprobante_TX_AutorizaPorSector
        AutorizacionesPorComprobante_TX_ComprobantesSinFirmar
        AutorizacionesPorComprobante_TX_DocumentosPorAutoriza
        AutorizacionesPorComprobante_TX_DocumentosPorAutorizaSuplentes
        AutorizacionesPorComprobante_TX_FirmasPendientes
        AutorizacionesPorComprobante_TX_PorIdPedido
        AutorizacionesPorComprobante_TX_PorIdRM
        AutorizacionesPorComprobante_TX_Sectores
        AutorizacionesPorComprobante_TX_SuplenteDelTitular
        BancoChequeras_A
        BancoChequeras_E
        BancoChequeras_M
        BancoChequeras_T
        BancoChequeras_TL
        BancoChequeras_TT
        BancoChequeras_TX_ActivasParaCombo
        BancoChequeras_TX_ActivasPorIdCuentaBancariaParaCombo
        BancoChequeras_TX_Inactivas
        BancoChequeras_TX_PorId
        BancoChequeras_TX_PorIdCuentaBancaria
        BancoChequeras_TX_TT
        Bancos_A
        Bancos_E
        Bancos_M
        Bancos_T
        Bancos_TL
        Bancos_TT
        Bancos_TX_ChequesDiferidosPendientesPorIdBanco
        Bancos_TX_ConCuenta
        Bancos_TX_ConCuenta1
        Bancos_TX_CuentasPorIdBanco
        Bancos_TX_HabilitadosParaCobroCuotas
        Bancos_TX_InformeChequesAnulados
        Bancos_TX_InformeChequesDiferidos
        Bancos_TX_InformeChequesDiferidos1
        Bancos_TX_InformeChequesDiferidosResumen
        Bancos_TX_MonedasParaPosicionFinanciera
        Bancos_TX_Movimientos
        Bancos_TX_MovimientosAnio
        Bancos_TX_MovimientosMes
        Bancos_TX_MovimientosPorCuenta
        Bancos_TX_MovimientosPorCuenta_Viejo
        Bancos_TX_PorCodigo
        Bancos_TX_PorCodigoUnico
        Bancos_TX_PorCuentasBancarias
        Bancos_TX_PorCuentasBancariasIdCuenta
        Bancos_TX_PorCuentasBancariasIdCuentaIdMoneda
        Bancos_TX_PorCuentasBancariasIdMoneda
        Bancos_TX_PorId
        Bancos_TX_PosicionBancariaAFecha
        Bancos_TX_PosicionFinancieraAFecha
        Bancos_TX_PosicionFinancieraAFechaPorIdCuentaBancaria
        Bancos_TX_PosicionFinancieraAFechaPorIdCuentaBancariaEnPesos
        Bancos_TX_Retenciones
        Bancos_TX_SaldosAFecha
        Bancos_TX_TT
        BD_TX_BaseDeDatos
        BD_TX_BasesInstaladas
        BD_TX_Campos
        BD_TX_Host
        BD_TX_Tablas
        Biselados_A
        Biselados_E
        Biselados_M
        Biselados_T
        Biselados_TL
        Biselados_TT
        Biselados_TX_TT
        BZ_Pesadas_A
        BZ_Pesadas_M
        BZ_Pesadas_T
        BZ_Pesadas_TL
        BZ_Pesadas_TT
        BZ_Pesadas_TX_Pendientes
        BZ_Pesadas_TX_TT
        Cajas_A
        Cajas_E
        Cajas_M
        Cajas_T
        Cajas_TL
        Cajas_TT
        Cajas_TX_PorCuentaContable
        Cajas_TX_PorDescripcion
        Cajas_TX_PorId
        Cajas_TX_PorIdCuenta
        Cajas_TX_PorIdCuentaParaCombo
        Cajas_TX_PorIdMoneda
        Cajas_TX_PosicionFinancieraAFecha
        Cajas_TX_PosicionFinancieraAFechaPorIdCaja
        Cajas_TX_PosicionFinancieraAFechaPorIdCajaEnPesos
        Cajas_TX_TodosSF
        Cajas_TX_TT
        Calidades_A
        Calidades_E
        Calidades_M
        Calidades_T
        Calidades_TL
        Calidades_TT
        Calidades_TX_TT
        CalidadesClad_A
        CalidadesClad_E
        CalidadesClad_M
        CalidadesClad_T
        CalidadesClad_TL
        CalidadesClad_TT
        CalidadesClad_TX_TT
        Cargos_A
        Cargos_E
        Cargos_M
        Cargos_T
        Cargos_TL
        Cargos_TT
        Cargos_TX_TT
        CashFlow
        CentrosCosto_A
        CentrosCosto_E
        CentrosCosto_M
        CentrosCosto_T
        CentrosCosto_TL
        CentrosCosto_TT
        CentrosCosto_TX_TT
        CertificacionesObras_A
        CertificacionesObras_ActualizarDetalles
        CertificacionesObras_ActualizarPorNumeroCertificado
        CertificacionesObras_E
        CertificacionesObras_M
        CertificacionesObras_Recalcular
        CertificacionesObras_T
        CertificacionesObras_TT
        CertificacionesObras_TX_DetallePxQ
        CertificacionesObras_TX_EtapasPorNumeroCertificado
        CertificacionesObras_TX_Ordenado
        CertificacionesObras_TX_ParaArbol
        CertificacionesObras_TX_PorNodo
        CertificacionesObras_TX_PorNumeroCertificado
        CertificacionesObras_TX_TT
        Choferes_A
        Choferes_E
        Choferes_M
        Choferes_T
        Choferes_TL
        Choferes_TT
        Choferes_TX_TT
        Clausulas_A
        Clausulas_E
        Clausulas_M
        Clausulas_T
        Clausulas_TL
        Clausulas_TT
        Clausulas_TX_PorId
        Clausulas_TX_TT
        Clientes_A
        Clientes_ActualizarComprobantes
        Clientes_ActualizarDatosIIBB
        Clientes_E
        Clientes_M
        Clientes_T
        Clientes_TL
        Clientes_TT
        Clientes_TX_AConfirmar
        Clientes_TX_AnalisisCobranzaFacturacion
        Clientes_TX_Busca
        Clientes_TX_Busca1
        Clientes_TX_Comprobantes
        Clientes_TX_Comprobantes_Modelo2
        Clientes_TX_Detallado
        Clientes_TX_Entregas
        Clientes_TX_LugaresEntrega
        Clientes_TX_ParaTransmitir
        Clientes_TX_ParaTransmitir_Todos
        Clientes_TX_PercepcionesIIBB
        Clientes_TX_PercepcionesIVA
        Clientes_TX_PorCodigo
        Clientes_TX_PorCodigoCliente
        Clientes_TX_PorCuit
        Clientes_TX_PorId
        Clientes_TX_PorIdConDatos
        Clientes_TX_PorRazonSocial
        Clientes_TX_RankingVentas
        Clientes_TX_RankingVentasCantidades
        Clientes_TX_RankingVentasPorVendedor
        Clientes_TX_ResumenVentas
        Clientes_TX_Resumido
        Clientes_TX_RetencionesGanancias
        Clientes_TX_RetencionesIIBB_Cobranzas
        Clientes_TX_RetencionesIVA
        Clientes_TX_RetencionesSUSS
        Clientes_TX_SetearComoTransmitido
        Clientes_TX_SoloCuit
        Clientes_TX_TT
        Clientes_TX_ValidarCodigo
        Codigos_A
        Codigos_E
        Codigos_M
        Codigos_T
        Codigos_TL
        Codigos_TT
        Codigos_TX_TT
        CodigosUniversales_A
        CodigosUniversales_E
        CodigosUniversales_M
        CodigosUniversales_T
        CodigosUniversales_TL
        CodigosUniversales_TT
        CodigosUniversales_TX_TT
        CoeficientesContables_A
        CoeficientesContables_E
        CoeficientesContables_M
        CoeficientesContables_T
        CoeficientesContables_TT
        CoeficientesContables_TX_TT
        CoeficientesImpositivos_A
        CoeficientesImpositivos_E
        CoeficientesImpositivos_M
        CoeficientesImpositivos_T
        CoeficientesImpositivos_TT
        CoeficientesImpositivos_TX_TT
        Colores_A
        Colores_E
        Colores_M
        Colores_T
        Colores_TL
        Colores_TT
        Colores_TX_TT
        Comparativas_A
        Comparativas_E
        Comparativas_M
        Comparativas_T
        Comparativas_TL
        Comparativas_TT
        Comparativas_TX_ItemsSeleccionados
        Comparativas_TX_PorNumero
        Comparativas_TX_PorPresupuesto
        Comparativas_TX_PorPresupuestoSoloSeleccionados
        Comparativas_TX_TT
        Comparativas_TXAnio
        Comparativas_TXFecha
        Comparativas_TXMes
        Comparativas_TXMesAnio
        ComprobantesProveedores_A
        ComprobantesProveedores_AnularVale
        ComprobantesProveedores_E
        ComprobantesProveedores_EliminarComprobante
        ComprobantesProveedores_EliminarComprobanteAConfirmar
        ComprobantesProveedores_GrabarDestinoPago
        ComprobantesProveedores_GrabarVale
        ComprobantesProveedores_ImputarOPRetencionIVAAplicada
        ComprobantesProveedores_M
        ComprobantesProveedores_T
        ComprobantesProveedores_TT
        ComprobantesProveedores_TX_AConfirmar
        ComprobantesProveedores_TX_AnticiposPorIdPedido
        ComprobantesProveedores_TX_ConAnticipoPorIdComprobanteProveedor
        ComprobantesProveedores_TX_DatosPorIdDetalleRecepcion
        ComprobantesProveedores_TX_DetallePorIdCabecera
        ComprobantesProveedores_TX_DetallePorIdDetalleRecepcion
        ComprobantesProveedores_TX_DetallePorRendicionFF
        ComprobantesProveedores_TX_DistribucionPorIdPedido
        ComprobantesProveedores_TX_PorId
        ComprobantesProveedores_TX_PorIdConDatos
        ComprobantesProveedores_TX_PorIdOrdenPago
        ComprobantesProveedores_TX_PorNumeroComprobante
        ComprobantesProveedores_TX_PorNumeroReferencia
        ComprobantesProveedores_TX_PorPRESTOFactura
        ComprobantesProveedores_TX_ReintegrosDetallados
        ComprobantesProveedores_TX_ResumenPorRendicionFF
        ComprobantesProveedores_TX_RubrosFinancierosAgrupados
        ComprobantesProveedores_TX_Todos
        ComprobantesProveedores_TX_TodosSF_HastaFecha
        ComprobantesProveedores_TX_TotalBSUltimoAño
        ComprobantesProveedores_TX_TT
        ComprobantesProveedores_TX_UltimoComprobantePorIdProveedor
        ComprobantesProveedores_TX_VerificarProveedor
        ComprobantesProveedores_TX_VerificarProveedorNoConfirmado
        ComprobantesProveedores_TXAnio
        ComprobantesProveedores_TXFecha
        ComprobantesProveedores_TXMes
        Conceptos_A
        Conceptos_E
        Conceptos_M
        Conceptos_T
        Conceptos_TL
        Conceptos_TT
        Conceptos_TX_PorGrupo
        Conceptos_TX_PorGrupoParaCombo
        Conceptos_TX_PorIdConDatos
        Conceptos_TX_TT
        Conciliaciones_A
        Conciliaciones_BorrarPorIdValor
        Conciliaciones_E
        Conciliaciones_M
        Conciliaciones_QuitarMarcaAprobacion
        Conciliaciones_T
        Conciliaciones_TT
        Conciliaciones_TX_DetallePorIdValor_ConFormato
        Conciliaciones_TX_NoConciliadosAnterior
        Conciliaciones_TX_SaldoFinalResumenAnterior
        Conciliaciones_TX_SaldosSegunExtractos
        Conciliaciones_TX_TT
        Conciliaciones_TX_ValidarNumeroResumen
        Conciliaciones_TXAnio
        Conciliaciones_TXFecha
        Conciliaciones_TXMes
        CondicionesCompra_A
        CondicionesCompra_E
        CondicionesCompra_M
        CondicionesCompra_T
        CondicionesCompra_TL
        CondicionesCompra_TT
        CondicionesCompra_TX_PorId
        CondicionesCompra_TX_TodosSF
        CondicionesCompra_TX_TT
        Conjuntos_A
        Conjuntos_CalcularCostoConjunto_Todos
        Conjuntos_CalcularCostoConjuntoDesdeComponente
        Conjuntos_E
        Conjuntos_Eliminar
        Conjuntos_M
        Conjuntos_T
        Conjuntos_TT
        Conjuntos_TX_DetallesPorId
        Conjuntos_TX_DetallesPorIdArticulo
        Conjuntos_TX_Finales
        Conjuntos_TX_PorIdArticulo
        Conjuntos_TX_PorIdConDatos
        Conjuntos_TX_Subconjuntos
        Conjuntos_TX_Todos
        Conjuntos_TX_TT
        Consulta_TX_PorSQL
        ConsultaStockCompleto_TX1
        ConsultaStockCompleto_TX2
        ControlCalidad_M
        ControlCalidad_T
        ControlCalidad_TT
        ControlCalidad_TX_Controlados
        ControlCalidad_TX_PorRemito
        ControlCalidad_TX_Todos
        ControlCalidad_TX_TT
        ControlCalidad_TX_Ultimos3Meses
        ControlesCalidad_A
        ControlesCalidad_E
        ControlesCalidad_M
        ControlesCalidad_T
        ControlesCalidad_TL
        ControlesCalidad_TT
        ControlesCalidad_TX_Alfabetico
        ControlesCalidad_TX_PorId
        ControlesCalidad_TX_TT
        CostosImportacion_A
        CostosImportacion_E
        CostosImportacion_M
        CostosImportacion_T
        CostosImportacion_TT
        CostosImportacion_TX_PorArticulo
        CostosImportacion_TX_PorId
        CostosImportacion_TX_TT
        CostosImportacion_TXCos
        CostosPromedios_A
        CostosPromedios_M
        CostosPromedios_TX_DetalladoPorIdArticulo
        CostosPromedios_TX_Estructura
        CostosPromedios_TX_PorArticulo
        CostosPromedios_TX_PorArticuloEnDolares
        CostosPromedios_TX_PorIdDetalleAjusteStock
        CostosPromedios_TX_PorIdDetalleDevolucion
        CostosPromedios_TX_PorIdDetalleOtroIngresoAlmacen
        CostosPromedios_TX_PorIdDetalleRecepcion
        CostosPromedios_TX_PorIdDetalleRemito
        CostosPromedios_TX_PorIdDetalleSalidaMateriales
        CostosPromedios_TX_PorIdDetalleValeSalida
        Cotizaciones_A
        Cotizaciones_E
        Cotizaciones_M
        Cotizaciones_T
        Cotizaciones_TT
        Cotizaciones_TX_ParaTransmitir
        Cotizaciones_TX_PorFechaMoneda
        Cotizaciones_TX_TT
        Cotizaciones_TXAnio
        Cotizaciones_TXFecha
        Cotizaciones_TXMes
        CtasCtesA_A
        CtasCtesA_CrearTransaccion
        CtasCtesA_E
        CtasCtesA_M
        CtasCtesA_ProyeccionEgresosParaCubo
        CtasCtesA_ProyeccionEgresosParaCubo1
        CtasCtesA_ReimputarComprobante
        CtasCtesA_T
        CtasCtesA_TT
        CtasCtesA_TX_ACancelar
        CtasCtesA_TX_BuscarComprobante
        CtasCtesA_TX_DetallePorTipoDeProveedor
        CtasCtesA_TX_DeudaVencida
        CtasCtesA_TX_DeudaVencidaPorMesCalendario
        CtasCtesA_TX_Imputacion
        CtasCtesA_TX_PendientesDeImputacion
        CtasCtesA_TX_PorDetalleOrdenPago
        CtasCtesA_TX_PorIdConSigno
        CtasCtesA_TX_PorNumeroInterno
        CtasCtesA_TX_PorTrsParaCubo
        CtasCtesA_TX_SaldosAFecha
        CtasCtesA_TX_SaldosAFechaDetallado
        CtasCtesA_TX_SaldosEntreFechas
        CtasCtesA_TX_SaldosEntreFechasResumido
        CtasCtesA_TX_Struc
        CtasCtesA_TX_TT
        CtasCtesA_TXParaImputar
        CtasCtesA_TXParaImputar_Dolares
        CtasCtesA_TXParaImputar_Euros
        CtasCtesA_TXPorMayor
        CtasCtesA_TXPorMayor_Dolares
        CtasCtesA_TXPorMayor_Euros
        CtasCtesA_TXPorMayor_OtrasMonedas
        CtasCtesA_TXPorTrs
        CtasCtesA_TXPorTrs_Dolares
        CtasCtesA_TXPorTrs_Euros
        CtasCtesA_TXPorTrs_MonedaOriginal
        CtasCtesA_TXTotal
        CtasCtesA_TXTotal_Dolares
        CtasCtesA_TXTotal_Euros
        CtasCtesD_A
        CtasCtesD_ActualizarComprobantes
        CtasCtesD_CrearTransaccion
        CtasCtesD_E
        CtasCtesD_M
        CtasCtesD_ReimputarComprobante
        CtasCtesD_T
        CtasCtesD_TT
        CtasCtesD_TX_ACancelar
        CtasCtesD_TX_BuscarComprobante
        CtasCtesD_TX_CreditosVencidos
        CtasCtesD_TX_DeudaVencida
        CtasCtesD_TX_Imputacion
        CtasCtesD_TX_ParaGeneracionDePagos
        CtasCtesD_TX_ParaTransmitir
        CtasCtesD_TX_PorDetalleRecibo
        CtasCtesD_TX_PorId
        CtasCtesD_TX_PorIdComprobanteIdCliente
        CtasCtesD_TX_PorIdConSigno
        CtasCtesD_TX_PorIdDetalleNotaCreditoImputaciones
        CtasCtesD_TX_PorIdOrigen
        CtasCtesD_TX_SaldosAFecha
        CtasCtesD_TX_SaldosAFechaDetallado
        CtasCtesD_TX_SetearComoTransmitido
        CtasCtesD_TX_Struc
        CtasCtesD_TX_TT
        CtasCtesD_TXParaImputar
        CtasCtesD_TXParaImputar_Dolares
        CtasCtesD_TXPorMayor
        CtasCtesD_TXPorMayor_Dolares
        CtasCtesD_TXPorMayor_OtrasMonedas
        CtasCtesD_TXPorTrs
        CtasCtesD_TXPorTrs_Dolares
        CtasCtesD_TXPorTrs_MonedaOriginal
        CtasCtesD_TXTotal
        CtasCtesD_TXTotal_Dolares
        Cuantificacion_TL
        CuboComparativas
        CuboCostosImportacion
        CuboDeVentas
        CuboDeVentasDetalladas
        CuboIngresoEgresosPorObra
        CuboIngresoEgresosPorObra1
        CuboIVAPorObra
        CuboPedidos
        CuboPosicionFinanciera
        CuboPresupuestoFinanciero
        CuboPresupuestoFinanciero2
        CuboPresupuestoFinanciero3
        CuboPresupuestoFinancieroTeorico
        CuboPresupuestoFinancieroTeoricoA
        CuboReservaPresupuestaria
        Cubos_TX_ControlarContenidoDeDatos
        CuboSaldosComprobantesPorObraProveedor
        CuboSaldosComprobantesPorObraProveedorA
        CuboStock
        CuboVentasEnCuotas
        Cuentas_A
        Cuentas_Consolidacion
        Cuentas_CuadroGastosPorObra
        Cuentas_CuadroGastosPorObraDetallado
        Cuentas_DistribuirPresupuestoEconomicoPorMatriz
        Cuentas_E
        Cuentas_IncrementarRendicionFF
        Cuentas_M
        Cuentas_T
        Cuentas_TL
        Cuentas_TT
        Cuentas_TX_AsientoAperturaEjercicio
        Cuentas_TX_AsientoCierreEjercicio
        Cuentas_TX_AsientoCierreEjercicio1
        Cuentas_TX_BalanceConApertura
        Cuentas_TX_BalanceConAperturaParaCubo
        Cuentas_TX_BalanceConAperturaResumen
        Cuentas_TX_ConMovimientos
        Cuentas_TX_CuentaCajaBanco
        Cuentas_TX_CuentaParaAjusteSubdiario
        Cuentas_TX_CuentasConsolidacionParaCombo
        Cuentas_TX_CuentasConsolidacionPorCodigo
        Cuentas_TX_CuentasConsolidacionPorIdCuenta
        Cuentas_TX_CuentasDependientesPorIdCuenta
        Cuentas_TX_CuentasGastoPorObraParaCombo
        Cuentas_TX_DesdeHasta
        Cuentas_TX_DesdeHastaConSaldos
        Cuentas_TX_DesdeHastaConSaldosConGastosTotalizados
        Cuentas_TX_EstadoResultados1
        Cuentas_TX_FondosFijos
        Cuentas_TX_MayorPorIdCuentaEntreFechas
        Cuentas_TX_MayorPorIdCuentaEntreFechasSinCIE
        Cuentas_TX_ParaComprobantesProveedores
        Cuentas_TX_ParaTransmitir
        Cuentas_TX_ParaTransmitir_Todos
        Cuentas_TX_PorCodigo
        Cuentas_TX_PorCodigoDescripcionParaCombo
        Cuentas_TX_PorCodigoJerarquia
        Cuentas_TX_PorCodigoSecundario
        Cuentas_TX_PorDescripcionCodigoParaCombo
        Cuentas_TX_PorFechaParaCombo
        Cuentas_TX_PorGrupoParaCombo
        Cuentas_TX_PorGruposParaCombo
        Cuentas_TX_PorId
        Cuentas_TX_PorIdConDatos
        Cuentas_TX_PorIdPorFecha
        Cuentas_TX_PorJerarquia
        Cuentas_TX_PorObraCuentaGasto
        Cuentas_TX_PorObraCuentaMadre
        Cuentas_TX_PorRubrosContables
        Cuentas_TX_PresupuestoEconomico
        Cuentas_TX_PresupuestoEconomicoParaCubo
        Cuentas_TX_PresupuestoEconomicoPorIdCuentaMesAño
        Cuentas_TX_PresupuestoEconomicoPorTipoCuenta
        Cuentas_TX_PresupuestoEconomicoResumidoParaCubo
        Cuentas_TX_PrimerCodigo
        Cuentas_TX_ProximoCodigoLibre
        Cuentas_TX_ResultadoCierreAnterior
        Cuentas_TX_SetearComoTransmitido
        Cuentas_TX_SinCuentasGastosObras
        Cuentas_TX_SinObrasParaCombo
        Cuentas_TX_TT
        Cuentas_TX_TT_PresupuestoEconomico
        Cuentas_TX_UltimoCodigo
        Cuentas_TXCod
        CuentasBancarias_A
        CuentasBancarias_E
        CuentasBancarias_M
        CuentasBancarias_T
        CuentasBancarias_TT
        CuentasBancarias_TX_PorCuenta
        CuentasBancarias_TX_PorId
        CuentasBancarias_TX_PorIdBanco
        CuentasBancarias_TX_PorIdConCuenta
        CuentasBancarias_TX_TodasParaCombo
        CuentasBancarias_TX_TodosSF
        CuentasBancarias_TX_TT
        CuentasEjerciciosContables_A
        CuentasEjerciciosContables_E
        CuentasEjerciciosContables_M
        CuentasEjerciciosContables_T
        CuentasGastos_A
        CuentasGastos_E
        CuentasGastos_M
        CuentasGastos_MarcarComoActiva
        CuentasGastos_T
        CuentasGastos_TL
        CuentasGastos_TT
        CuentasGastos_TX_PorCodigo
        CuentasGastos_TX_PorCodigo2
        CuentasGastos_TX_PorId
        CuentasGastos_TX_PorIdCuentaMadre
        CuentasGastos_TX_TodasActivas
        CuentasGastos_TX_Todos
        CuentasGastos_TX_TT
        DefinicionAnulaciones_A
        DefinicionAnulaciones_M
        DefinicionAnulaciones_T
        DefinicionAnulaciones_TX_PorIdFormulario
        DefinicionArticulos_A
        DefinicionArticulos_E
        DefinicionArticulos_M
        DefinicionArticulos_T
        DefinicionArticulos_TL
        DefinicionArticulos_TT
        DefinicionArticulos_TX_AgrupadoPorRubro
        DefinicionArticulos_TX_Art
        DefinicionArticulos_TX_CamposPorGrupo
        DefinicionArticulos_TX_CamposPorIdRubro
        DefinicionArticulos_TX_Copia
        DefinicionArticulos_TX_Copiar
        DefinicionArticulos_TX_Grupos
        DefinicionArticulos_TX_PorIdRubro
        DefinicionArticulos_TX_PorRubro
        DefinicionArticulos_TX_Seleccion
        DefinicionArticulos_TX_TablaComboPorGrupoCampo
        DefinicionArticulos_TX_TT
        DefinicionesCuadrosContables_AgregarUnRegistro
        DefinicionesCuadrosContables_BorrarAsignacion
        DefinicionesCuadrosContables_Eliminar
        DefinicionesCuadrosContables_TX_DetalladoEntreFechas
        DefinicionesCuadrosContables_TX_Egresos
        DefinicionesCuadrosContables_TX_Ingresos
        DefinicionesCuadrosContables_TX_UnRegistro
        DefinicionesFlujoCaja_A
        DefinicionesFlujoCaja_M
        DefinicionesFlujoCaja_T
        DefinicionesFlujoCaja_TT
        DefinicionesFlujoCaja_TX_ControlDeItems
        DefinicionesFlujoCaja_TX_DetallesPorCodigo
        DefinicionesFlujoCaja_TX_PorCodigo
        DefinicionesFlujoCaja_TX_PresupuestosPorMesAño
        DefinicionesFlujoCaja_TX_TT
        Densidades_A
        Densidades_E
        Densidades_M
        Densidades_T
        Densidades_TL
        Densidades_TT
        Densidades_TX_TT
        Depositos_A
        Depositos_E
        Depositos_M
        Depositos_T
        Depositos_TL
        Depositos_TT
        Depositos_TX_ParaTransmitir
        Depositos_TX_PorIdObraParaCombo
        Depositos_TX_TT
        DepositosBancarios_A
        DepositosBancarios_E
        DepositosBancarios_M
        DepositosBancarios_T
        DepositosBancarios_TT
        DepositosBancarios_TX_DepositosEntreFechasParaExcel
        DepositosBancarios_TX_DetallesPorIdValor
        DepositosBancarios_TX_EntreFechas
        DepositosBancarios_TX_PorId
        DepositosBancarios_TX_TodosSF_HastaFecha
        DepositosBancarios_TX_TT
        DepositosBancarios_TX_Validar
        DepositosBancarios_TXAnio
        DepositosBancarios_TXFecha
        DepositosBancarios_TXMes
        DescripcionIva_T
        DescripcionIva_TL
        DescripcionIva_TT
        DescripcionIva_TX_PorId
        DescripcionIva_TX_TT
        DetAcoAcabados_A
        DetAcoAcabados_E
        DetAcoAcabados_T
        DetAcoAcabados_TT
        DetAcoAcabados_TXDetAco
        DetAcoAcabados_TXPrimero
        DetAcoBiselados_A
        DetAcoBiselados_E
        DetAcoBiselados_T
        DetAcoBiselados_TT
        DetAcoBiselados_TXDetAco
        DetAcoBiselados_TXPrimero
        DetAcoCalidades_A
        DetAcoCalidades_E
        DetAcoCalidades_T
        DetAcoCalidades_TT
        DetAcoCalidades_TXDetAco
        DetAcoCalidades_TXPrimero
        DetAcoCodigos_A
        DetAcoCodigos_E
        DetAcoCodigos_T
        DetAcoCodigos_TT
        DetAcoCodigos_TXDetAco
        DetAcoCodigos_TXPrimero
        DetAcoColores_A
        DetAcoColores_E
        DetAcoColores_T
        DetAcoColores_TT
        DetAcoColores_TXDetColor
        DetAcoColores_TXPrimero
        DetAcoFormas_A
        DetAcoFormas_E
        DetAcoFormas_T
        DetAcoFormas_TT
        DetAcoFormas_TXDetForma
        DetAcoFormas_TXPrimero
        DetAcoGrados_A
        DetAcoGrados_E
        DetAcoGrados_T
        DetAcoGrados_TT
        DetAcoGrados_TXDetAco
        DetAcoGrados_TXPrimero
        DetAcoHHItemsDocumentacion_A
        DetAcoHHItemsDocumentacion_E
        DetAcoHHItemsDocumentacion_T
        DetAcoHHItemsDocumentacion_TT
        DetAcoHHItemsDocumentacion_TXDetHHItemDocumentacion
        DetAcoHHItemsDocumentacion_TXPrimero
        DetAcoHHTareas_A
        DetAcoHHTareas_E
        DetAcoHHTareas_M
        DetAcoHHTareas_T
        DetAcoHHTareas_TT
        DetAcoHHTareas_TX_TodasLasTareas
        DetAcoHHTareas_TXDetHHTarea
        DetAcoMarcas_A
        DetAcoMarcas_E
        DetAcoMarcas_T
        DetAcoMarcas_TT
        DetAcoMarcas_TXDetMarca
        DetAcoMarcas_TXPrimero
        DetAcoMateriales_A
        DetAcoMateriales_E
        DetAcoMateriales_T
        DetAcoMateriales_TT
        DetAcoMateriales_TXDetAco
        DetAcoMateriales_TXPrimero
        DetAcoModelos_A
        DetAcoModelos_E
        DetAcoModelos_T
        DetAcoModelos_TT
        DetAcoModelos_TXDetModelo
        DetAcoModelos_TXPrimero
        DetAcoNormas_A
        DetAcoNormas_E
        DetAcoNormas_T
        DetAcoNormas_TT
        DetAcoNormas_TXDetAco
        DetAcoNormas_TXPrimero
        DetAcopios_A
        DetAcopios_E
        DetAcopios_M
        DetAcopios_T
        DetAcopios_TX_ParaTransmitir
        DetAcopios_TX_ParaTransmitir_Todos
        DetAcopios_TX_SetearComoTransmitido
        DetAcopios_TX_UnItem
        DetAcopios_TXAco
        DetAcopios_TXAcoSF
        DetAcopios_TXPrimero
        DetAcopiosEquipos_A
        DetAcopiosEquipos_E
        DetAcopiosEquipos_M
        DetAcopiosEquipos_T
        DetAcopiosEquipos_TX_ParaTransmitir
        DetAcopiosEquipos_TX_ParaTransmitir_Todos
        DetAcopiosEquipos_TX_SetearComoTransmitido
        DetAcopiosEquipos_TXAcoEqu
        DetAcopiosEquipos_TXPrimero
        DetAcopiosRevisiones_A
        DetAcopiosRevisiones_E
        DetAcopiosRevisiones_M
        DetAcopiosRevisiones_T
        DetAcopiosRevisiones_TX_ParaTransmitir
        DetAcopiosRevisiones_TX_ParaTransmitir_Todos
        DetAcopiosRevisiones_TX_SetearComoTransmitido
        DetAcopiosRevisiones_TXAcoRev
        DetAcopiosRevisiones_TXAcoRevTodos
        DetAcopiosRevisiones_TXPrimero
        DetAcoSchedulers_A
        DetAcoSchedulers_E
        DetAcoSchedulers_T
        DetAcoSchedulers_TT
        DetAcoSchedulers_TXDetAco
        DetAcoSchedulers_TXPrimero
        DetAcoSeries_A
        DetAcoSeries_E
        DetAcoSeries_T
        DetAcoSeries_TT
        DetAcoSeries_TXDetAco
        DetAcoSeries_TXPrimero
        DetAcoTipos_A
        DetAcoTipos_E
        DetAcoTipos_T
        DetAcoTipos_TT
        DetAcoTipos_TXDetAco
        DetAcoTipos_TXPrimero
        DetAcoTiposRosca_A
        DetAcoTiposRosca_E
        DetAcoTiposRosca_T
        DetAcoTiposRosca_TT
        DetAcoTiposRosca_TXDetAco
        DetAcoTiposRosca_TXPrimero
        DetAcoTratamientos_A
        DetAcoTratamientos_E
        DetAcoTratamientos_T
        DetAcoTratamientos_TT
        DetAcoTratamientos_TXDetAco
        DetAcoTratamientos_TXPrimero
        DetAjustesStock_A
        DetAjustesStock_E
        DetAjustesStock_M
        DetAjustesStock_T
        DetAjustesStock_TXAjStk
        DetAjustesStock_TXPrimero
        DetAjustesStockSAT_A
        DetAjustesStockSAT_M
        DetAjustesStockSAT_T
        DetArticulosActivosFijos_A
        DetArticulosActivosFijos_E
        DetArticulosActivosFijos_M
        DetArticulosActivosFijos_T
        DetArticulosActivosFijos_TX_AFijos
        DetArticulosActivosFijos_TXPrimero
        DetArticulosDocumentos_A
        DetArticulosDocumentos_E
        DetArticulosDocumentos_M
        DetArticulosDocumentos_T
        DetArticulosDocumentos_TX_Doc
        DetArticulosDocumentos_TXPrimero
        DetArticulosImagenes_A
        DetArticulosImagenes_E
        DetArticulosImagenes_M
        DetArticulosImagenes_T
        DetArticulosImagenes_TX_Img
        DetArticulosImagenes_TXPrimero
        DetArticulosUnidades_A
        DetArticulosUnidades_E
        DetArticulosUnidades_M
        DetArticulosUnidades_T
        DetArticulosUnidades_TX_ParaTransmitir
        DetArticulosUnidades_TX_Uni
        DetArticulosUnidades_TXPrimero
        DetAsientos_A
        DetAsientos_E
        DetAsientos_M
        DetAsientos_T
        DetAsientos_TT
        DetAsientos_TX_Estructura
        DetAsientos_TX_PorIdDetalleAsiento
        DetAsientos_TX_PorIdValor
        DetAsientos_TX_PorSubdiario
        DetAsientos_TXAsi
        DetAsientos_TXPrimero
        DetAutorizaciones_A
        DetAutorizaciones_E
        DetAutorizaciones_M
        DetAutorizaciones_T
        DetAutorizaciones_TXAut
        DetAutorizaciones_TXPrimero
        DetClientes_A
        DetClientes_E
        DetClientes_M
        DetClientes_T
        DetClientes_TX_TodosSinFormato
        DetClientes_TXDetCli
        DetClientes_TXPrimero
        DetClientesLugaresEntrega_A
        DetClientesLugaresEntrega_E
        DetClientesLugaresEntrega_M
        DetClientesLugaresEntrega_T
        DetClientesLugaresEntrega_TX_TodosSinFormato
        DetClientesLugaresEntrega_TXDet
        DetClientesLugaresEntrega_TXPrimero
        DetComparativas_A
        DetComparativas_E
        DetComparativas_M
        DetComparativas_T
        DetComparativas_TXCom
        DetComprobantesProveedores_A
        DetComprobantesProveedores_E
        DetComprobantesProveedores_M
        DetComprobantesProveedores_T
        DetComprobantesProveedores_TT
        DetComprobantesProveedores_TX_Estructura
        DetComprobantesProveedores_TX_PorIdCabecera
        DetComprobantesProveedores_TXComp
        DetComprobantesProveedores_TXPrimero
        DetComprobantesProveedoresPrv_A
        DetComprobantesProveedoresPrv_E
        DetComprobantesProveedoresPrv_M
        DetComprobantesProveedoresPrv_T
        DetComprobantesProveedoresPrv_TX_Estructura
        DetComprobantesProveedoresPrv_TXComp
        DetComprobantesProveedoresPrv_TXPrimero
        DetConciliaciones_A
        DetConciliaciones_E
        DetConciliaciones_M
        DetConciliaciones_T
        DetConciliaciones_TX_Conciliados
        DetConciliaciones_TX_ConfirmadoPorIdValor
        DetConciliaciones_TX_NoConciliados
        DetConciliaciones_TX_PorIdValorConFormato
        DetConciliaciones_TXConc
        DetConciliaciones_TXPrimero
        DetConciliacionesNoContables_A
        DetConciliacionesNoContables_E
        DetConciliacionesNoContables_M
        DetConciliacionesNoContables_T
        DetConciliacionesNoContables_TX_NoCaducados
        DetConciliacionesNoContables_TX_UltimoResumen
        DetConciliacionesNoContables_TXConc
        DetConciliacionesNoContables_TXPrimero
        DetConjuntos_A
        DetConjuntos_E
        DetConjuntos_M
        DetConjuntos_T
        DetConjuntos_TX_Todos
        DetConjuntos_TXConj
        DetConjuntos_TXPrimero
        DetControlesCalidad_A
        DetControlesCalidad_E
        DetControlesCalidad_GrabarRemitoRechazo
        DetControlesCalidad_M
        DetControlesCalidad_T
        DetControlesCalidad_TX_ConDatos
        DetControlesCalidad_TX_Controlados
        DetControlesCalidad_TXCal
        DetControlesCalidad_TXPrimero
        DetCuentas_A
        DetCuentas_E
        DetCuentas_M
        DetCuentas_T
        DetCuentas_TXDet
        DetCuentas_TXPrimero
        DetDefinicionAnulaciones_A
        DetDefinicionAnulaciones_E
        DetDefinicionAnulaciones_M
        DetDefinicionAnulaciones_T
        DetDefinicionAnulaciones_TXDet
        DetDefinicionAnulaciones_TXPrimero
        DetDefinicionesFlujoCajaCtas_A
        DetDefinicionesFlujoCajaCtas_E
        DetDefinicionesFlujoCajaCtas_M
        DetDefinicionesFlujoCajaCtas_T
        DetDefinicionesFlujoCajaCtas_TXDet
        DetDefinicionesFlujoCajaCtas_TXPrimero
        DetDefinicionesFlujoCajaPresu_A
        DetDefinicionesFlujoCajaPresu_E
        DetDefinicionesFlujoCajaPresu_M
        DetDefinicionesFlujoCajaPresu_T
        DetDefinicionesFlujoCajaPresu_TXDet
        DetDefinicionesFlujoCajaPresu_TXPrimero
        DetDepositosBancarios_A
        DetDepositosBancarios_E
        DetDepositosBancarios_M
        DetDepositosBancarios_T
        DetDepositosBancarios_TT
        DetDepositosBancarios_TX_Estructura
        DetDepositosBancarios_TX_PorIdCabecera
        DetDepositosBancarios_TXDep
        DetDepositosBancarios_TXPrimero
        DetDevoluciones_A
        DetDevoluciones_E
        DetDevoluciones_M
        DetDevoluciones_T
        DetDevoluciones_TT
        DetDevoluciones_TX_ConDatos
        DetDevoluciones_TX_Estructura
        DetDevoluciones_TX_PorIdCabecera
        DetDevoluciones_TXDev
        DetDevoluciones_TXPrimero
        DetDistribucionesObras_A
        DetDistribucionesObras_E
        DetDistribucionesObras_M
        DetDistribucionesObras_T
        DetDistribucionesObras_TXDet
        DetDistribucionesObras_TXPrimero
        DetEmpleados_A
        DetEmpleados_E
        DetEmpleados_M
        DetEmpleados_T
        DetEmpleados_TX_Emp
        DetEmpleados_TXPrimero
        DetEmpleadosJornadas_A
        DetEmpleadosJornadas_E
        DetEmpleadosJornadas_M
        DetEmpleadosJornadas_T
        DetEmpleadosJornadas_TX_EmpJor
        DetEmpleadosJornadas_TXPrimero
        DetEmpleadosSectores_A
        DetEmpleadosSectores_E
        DetEmpleadosSectores_M
        DetEmpleadosSectores_T
        DetEmpleadosSectores_TX_EmpSec
        DetEmpleadosSectores_TXPrimero
        DetEquipos_A
        DetEquipos_E
        DetEquipos_M
        DetEquipos_T
        DetEquipos_TX_ParaTransmitir
        DetEquipos_TX_ParaTransmitir_Todos
        DetEquipos_TX_SetearComoTransmitido
        DetEquipos_TXEquipo
        DetEquipos_TXPrimero
        DetEventosDelSistema_A
        DetEventosDelSistema_E
        DetEventosDelSistema_M
        DetEventosDelSistema_T
        DetEventosDelSistema_TX_PorEvento
        DetEventosDelSistema_TXPrimero
        DetFacturas_A
        DetFacturas_E
        DetFacturas_M
        DetFacturas_T
        DetFacturas_TT
        DetFacturas_TX_ConDatos
        DetFacturas_TX_ConDatosAgrupados
        DetFacturas_TX_Estructura
        DetFacturas_TX_ParaTransmitir
        DetFacturas_TX_PorIdCabecera
        DetFacturas_TX_SetearComoTransmitido
        DetFacturas_TXFac
        DetFacturas_TXPrimero
        DetFacturasClientesPRESTO_A
        DetFacturasClientesPRESTO_E
        DetFacturasClientesPRESTO_M
        DetFacturasClientesPRESTO_T
        DetFacturasClientesPRESTO_TT
        DetFacturasClientesPRESTO_TX_Estructura
        DetFacturasClientesPRESTO_TX_PorIdCabecera
        DetFacturasClientesPRESTO_TXFac
        DetFacturasClientesPRESTO_TXPrimero
        DetFacturasOrdenesCompra_A
        DetFacturasOrdenesCompra_E
        DetFacturasOrdenesCompra_M
        DetFacturasOrdenesCompra_T
        DetFacturasOrdenesCompra_TT
        DetFacturasOrdenesCompra_TX_Estructura
        DetFacturasOrdenesCompra_TXOrdenesCompra
        DetFacturasOrdenesCompra_TXPrimero
        DetFacturasProvincias_A
        DetFacturasProvincias_E
        DetFacturasProvincias_M
        DetFacturasProvincias_T
        DetFacturasProvincias_TX_Estructura
        DetFacturasProvincias_TXFac
        DetFacturasProvincias_TXPrimero
        DetFacturasRemitos_A
        DetFacturasRemitos_E
        DetFacturasRemitos_M
        DetFacturasRemitos_T
        DetFacturasRemitos_TT
        DetFacturasRemitos_TX_Estructura
        DetFacturasRemitos_TX_RemitosUnItemConFormato
        DetFacturasRemitos_TXPrimero
        DetFacturasRemitos_TXRemitos
        DetLMateriales_A
        DetLMateriales_E
        DetLMateriales_M
        DetLMateriales_T
        DetLMateriales_TX_PorLMat
        DetLMateriales_TX_UnItem
        DetLMateriales_TXLMat
        DetLMateriales_TXPrimero
        DetLMaterialesRevisiones_A
        DetLMaterialesRevisiones_E
        DetLMaterialesRevisiones_M
        DetLMaterialesRevisiones_T
        DetLMaterialesRevisiones_TX_Avances
        DetLMaterialesRevisiones_TX_Revisiones
        DetLMaterialesRevisiones_TXAcoRev
        DetLMaterialesRevisiones_TXPrimero
        DetLMaterialesRevisiones_TXPrimeroAvances
        DetNotasCredito_A
        DetNotasCredito_E
        DetNotasCredito_M
        DetNotasCredito_T
        DetNotasCredito_TT
        DetNotasCredito_TX_Estructura
        DetNotasCredito_TX_PorIdCabecera
        DetNotasCredito_TXCre
        DetNotasCredito_TXPrimero
        DetNotasCreditoImp_A
        DetNotasCreditoImp_E
        DetNotasCreditoImp_M
        DetNotasCreditoImp_T
        DetNotasCreditoImp_TT
        DetNotasCreditoImp_TX_Estructura
        DetNotasCreditoImp_TX_PorIdCabecera
        DetNotasCreditoImp_TX_PorIdDetalleNotaCreditoImputaciones
        DetNotasCreditoImp_TXCre
        DetNotasCreditoImp_TXPrimero
        DetNotasCreditoOC_A
        DetNotasCreditoOC_E
        DetNotasCreditoOC_M
        DetNotasCreditoOC_T
        DetNotasCreditoOC_TT
        DetNotasCreditoOC_TX_Estructura
        DetNotasCreditoOC_TX_PorIdNotasCredito
        DetNotasCreditoOC_TXCre
        DetNotasCreditoOC_TXPrimero
        DetNotasCreditoProvincias_A
        DetNotasCreditoProvincias_E
        DetNotasCreditoProvincias_M
        DetNotasCreditoProvincias_T
        DetNotasCreditoProvincias_TX_Estructura
        DetNotasCreditoProvincias_TXCre
        DetNotasCreditoProvincias_TXPrimero
        DetNotasDebito_A
        DetNotasDebito_E
        DetNotasDebito_M
        DetNotasDebito_T
        DetNotasDebito_TT
        DetNotasDebito_TX_Estructura
        DetNotasDebito_TX_PorIdCabecera
        DetNotasDebito_TXDeb
        DetNotasDebito_TXPrimero
        DetNotasDebitoProvincias_A
        DetNotasDebitoProvincias_E
        DetNotasDebitoProvincias_M
        DetNotasDebitoProvincias_T
        DetNotasDebitoProvincias_TX_Estructura
        DetNotasDebitoProvincias_TXDeb
        DetNotasDebitoProvincias_TXPrimero
        DetObrasDestinos_A
        DetObrasDestinos_E
        DetObrasDestinos_M
        DetObrasDestinos_T
        DetObrasDestinos_TX_ParaTransmitir_Todos
        DetObrasDestinos_TX_PorCodigo
        DetObrasDestinos_TXDestinos
        DetObrasDestinos_TXPrimero
        DetObrasEquiposInstalados_A
        DetObrasEquiposInstalados_E
        DetObrasEquiposInstalados_M
        DetObrasEquiposInstalados_T
        DetObrasEquiposInstalados_TX_PorIdObra
        DetObrasEquiposInstalados_TXEquipos
        DetObrasEquiposInstalados_TXPrimero
        DetObrasPolizas_A
        DetObrasPolizas_E
        DetObrasPolizas_M
        DetObrasPolizas_T
        DetObrasPolizas_TX_PorIdObra
        DetObrasPolizas_TXPolizas
        DetObrasPolizas_TXPrimero
        DetObrasRecepciones_A
        DetObrasRecepciones_E
        DetObrasRecepciones_M
        DetObrasRecepciones_T
        DetObrasRecepciones_TX_PorIdObra
        DetObrasRecepciones_TXPrimero
        DetObrasRecepciones_TXRecepciones
        DetObrasSectores_A
        DetObrasSectores_E
        DetObrasSectores_M
        DetObrasSectores_T
        DetObrasSectores_TX_Det
        DetObrasSectores_TXPrimero
        DetOrdenesCompra_A
        DetOrdenesCompra_E
        DetOrdenesCompra_M
        DetOrdenesCompra_T
        DetOrdenesCompra_TX_PorIdDetalleOrdenCompraConDatos
        DetOrdenesCompra_TX_PorIdOrdenPago
        DetOrdenesCompra_TXOCompra
        DetOrdenesCompra_TXPrimero
        DetOrdenesPago_A
        DetOrdenesPago_E
        DetOrdenesPago_M
        DetOrdenesPago_T
        DetOrdenesPago_TT
        DetOrdenesPago_TX_Estructura
        DetOrdenesPago_TX_PorIdDetalleOrdenPago
        DetOrdenesPago_TX_PorIdImputacionOtrasOP
        DetOrdenesPago_TX_PorIdOrdenPago
        DetOrdenesPago_TXOrdenPago
        DetOrdenesPago_TXPrimero
        DetOrdenesPagoCuentas_A
        DetOrdenesPagoCuentas_E
        DetOrdenesPagoCuentas_M
        DetOrdenesPagoCuentas_T
        DetOrdenesPagoCuentas_TT
        DetOrdenesPagoCuentas_TX_Estructura
        DetOrdenesPagoCuentas_TX_PorIdOrdenPago
        DetOrdenesPagoCuentas_TXOrdenPago
        DetOrdenesPagoCuentas_TXPrimero
        DetOrdenesPagoImpuestos_A
        DetOrdenesPagoImpuestos_BorrarPorIdOrdenPago
        DetOrdenesPagoImpuestos_E
        DetOrdenesPagoImpuestos_M
        DetOrdenesPagoImpuestos_T
        DetOrdenesPagoImpuestos_TT
        DetOrdenesPagoImpuestos_TX_Estructura
        DetOrdenesPagoImpuestos_TXOrdenPago
        DetOrdenesPagoImpuestos_TXPrimero
        DetOrdenesPagoRubrosContables_A
        DetOrdenesPagoRubrosContables_BorrarPorIdOrdenPago
        DetOrdenesPagoRubrosContables_E
        DetOrdenesPagoRubrosContables_M
        DetOrdenesPagoRubrosContables_T
        DetOrdenesPagoRubrosContables_TT
        DetOrdenesPagoRubrosContables_TX_Estructura
        DetOrdenesPagoRubrosContables_TX_PorIdOrdenPago
        DetOrdenesPagoRubrosContables_TXOrdenPago
        DetOrdenesPagoRubrosContables_TXPrimero
        DetOrdenesPagoValores_A
        DetOrdenesPagoValores_E
        DetOrdenesPagoValores_M
        DetOrdenesPagoValores_T
        DetOrdenesPagoValores_TT
        DetOrdenesPagoValores_TX_Control
        DetOrdenesPagoValores_TX_Estructura
        DetOrdenesPagoValores_TX_PorIdCabecera
        DetOrdenesPagoValores_TXOrdenPago
        DetOrdenesPagoValores_TXPrimero
        DetOtrosIngresosAlmacen_A
        DetOtrosIngresosAlmacen_E
        DetOtrosIngresosAlmacen_M
        DetOtrosIngresosAlmacen_T
        DetOtrosIngresosAlmacen_TX_DetallesParametrizados
        DetOtrosIngresosAlmacen_TX_Todos
        DetOtrosIngresosAlmacen_TXOtros
        DetOtrosIngresosAlmacen_TXPrimero
        DetOtrosIngresosAlmacenSAT_A
        DetOtrosIngresosAlmacenSAT_M
        DetOtrosIngresosAlmacenSAT_T
        DetOtrosIngresosAlmacenSAT_TXOtros
        DetPatronesGPS_A
        DetPatronesGPS_E
        DetPatronesGPS_M
        DetPatronesGPS_T
        DetPatronesGPS_TX_Det
        DetPatronesGPS_TXPrimero
        DetPedidos_A
        DetPedidos_E
        DetPedidos_M
        DetPedidos_SetearPedidoPresto
        DetPedidos_T
        DetPedidos_TX_BuscarItemAco
        DetPedidos_TX_BuscarItemRM
        DetPedidos_TX_DetallesParametrizados
        DetPedidos_TX_ParaTransmitir
        DetPedidos_TX_ParaTransmitir_Todos
        DetPedidos_TX_SetearComoTransmitido
        DetPedidos_TX_Simplificados
        DetPedidos_TX_T
        DetPedidos_TX_TodosSinPrecios
        DetPedidos_TXPed
        DetPedidos_TXPedSF
        DetPedidos_TXPrimero
        DetPedidosSAT_A
        DetPedidosSAT_M
        DetPedidosSAT_T
        DetPedidosSAT_TXPed
        DetPresupuestos_A
        DetPresupuestos_E
        DetPresupuestos_M
        DetPresupuestos_T
        DetPresupuestos_TX_DetallesParametrizados
        DetPresupuestos_TX_PreSF
        DetPresupuestos_TX_UnItem
        DetPresupuestos_TXPre
        DetPresupuestos_TXPrimero
        DetPresupuestosHHObras_A
        DetPresupuestosHHObras_E
        DetPresupuestosHHObras_M
        DetPresupuestosHHObras_T
        DetPresupuestosHHObras_TX_PorEquipoObra
        DetPresupuestosHHObras_TX_PorObra
        DetPresupuestosHHObras_TX_PorSectorEquipoObra
        DetPresupuestosHHObras_TX_PorSectorObra
        DetPresupuestosHHObras_TXPre
        DetPresupuestosHHObras_TXPrimero
        DetPresupuestosHHObrasPorMes_A
        DetPresupuestosHHObrasPorMes_E
        DetPresupuestosHHObrasPorMes_M
        DetPresupuestosHHObrasPorMes_T
        DetPresupuestosHHObrasPorMes_TX_PorObra
        DetProduccionFichaProcesos_TX_PorIdConDatos
        DetProduccionFichas_A
        DetProduccionFichas_E
        DetProduccionFichas_M
        DetProduccionFichas_T
        DetProduccionFichas_TX_DetallesParametrizados
        DetProduccionFichas_TX_PorIdConDatos
        DetProduccionFichas_TX_Todos
        DetProduccionFichas_TXPrimero
        DetProduccionFichas_TXSal
        DetProduccionFichasProcesos_A
        DetProduccionFichasProcesos_E
        DetProduccionFichasProcesos_M
        DetProduccionFichasProcesos_T
        DetProduccionFichasProcesos_TX_DetallesParametrizados
        DetProduccionFichasProcesos_TX_Todos
        DetProduccionFichasProcesos_TX_Uni
        DetProduccionFichasProcesos_TXPrimero
        DetProduccionOrdenes_A
        DetProduccionOrdenes_E
        DetProduccionOrdenes_M
        DetProduccionOrdenes_T
        DetProduccionOrdenes_TX_DetallesParametrizados
        DetProduccionOrdenes_TX_PorIdConDatos
        DetProduccionOrdenes_TX_PorIdOrdenParaCombo
        DetProduccionOrdenes_TX_Todos
        DetProduccionOrdenes_TXPrimero
        DetProduccionOrdenes_TXSal
        DetProduccionOrdenesProcesos_A
        DetProduccionOrdenesProcesos_E
        DetProduccionOrdenesProcesos_M
        DetProduccionOrdenesProcesos_T
        DetProduccionOrdenesProcesos_TX_DetallesParametrizados
        DetProduccionOrdenesProcesos_TX_PorFechaParaProgramadorDeRecursos
        DetProduccionOrdenesProcesos_TX_PorIdConDatos
        DetProduccionOrdenesProcesos_TX_Todos
        DetProduccionOrdenesProcesos_TX_Uni
        DetProduccionOrdenesProcesos_TXPrimero
        DetProduccionOrdenProcesos_A
        DetProduccionOrdenProcesos_E
        DetProduccionOrdenProcesos_M
        DetProduccionOrdenProcesos_T
        DetProduccionOrdenProcesos_TX_PorIdOrdenParaCombo
        DetProduccionOrdenProcesos_TX_Uni
        DetProduccionOrdenProcesos_TXPrimero
        DetProveedores_A
        DetProveedores_E
        DetProveedores_M
        DetProveedores_T
        DetProveedores_TX_TodosSinFormato
        DetProveedores_TXDetPrv
        DetProveedores_TXPrimero
        DetProveedoresIB_A
        DetProveedoresIB_E
        DetProveedoresIB_M
        DetProveedoresIB_T
        DetProveedoresIB_TX_PorIdProveedorIdIBCondicion
        DetProveedoresIB_TX_TodosSinFormato
        DetProveedoresIB_TXDetPrv
        DetProveedoresIB_TXPrimero
        DetProveedoresRubros_A
        DetProveedoresRubros_E
        DetProveedoresRubros_M
        DetProveedoresRubros_T
        DetProveedoresRubros_TX_TodosSinFormato
        DetProveedoresRubros_TXDetPrv
        DetProveedoresRubros_TXPrimero
        DetRecepciones_A
        DetRecepciones_E
        DetRecepciones_M
        DetRecepciones_T
        DetRecepciones_TX_DetallesParametrizados
        DetRecepciones_TXPrimero
        DetRecepciones_TXRec
        DetRecepcionesSAT_A
        DetRecepcionesSAT_M
        DetRecepcionesSAT_T
        DetRecepcionesSAT_TXRec
        DetRecibos_A
        DetRecibos_E
        DetRecibos_M
        DetRecibos_T
        DetRecibos_TT
        DetRecibos_TX_Estructura
        DetRecibos_TX_ParaTransmitir
        DetRecibos_TX_PorIdDetalleRecibo
        DetRecibos_TX_PorIdRecibo
        DetRecibos_TX_SetearComoTransmitido
        DetRecibos_TXPrimero
        DetRecibos_TXRecibo
        DetRecibosCuentas_A
        DetRecibosCuentas_E
        DetRecibosCuentas_M
        DetRecibosCuentas_T
        DetRecibosCuentas_TT
        DetRecibosCuentas_TX_Estructura
        DetRecibosCuentas_TX_ParaTransmitir
        DetRecibosCuentas_TX_PorIdRecibo
        DetRecibosCuentas_TX_SetearComoTransmitido
        DetRecibosCuentas_TXPrimero
        DetRecibosCuentas_TXRecibo
        DetRecibosRubrosContables_A
        DetRecibosRubrosContables_BorrarPorIdRecibo
        DetRecibosRubrosContables_E
        DetRecibosRubrosContables_M
        DetRecibosRubrosContables_T
        DetRecibosRubrosContables_TT
        DetRecibosRubrosContables_TX_Estructura
        DetRecibosRubrosContables_TX_ParaTransmitir
        DetRecibosRubrosContables_TX_PorIdRecibo
        DetRecibosRubrosContables_TX_SetearComoTransmitido
        DetRecibosRubrosContables_TXPrimero
        DetRecibosRubrosContables_TXRecibo
        DetRecibosValores_A
        DetRecibosValores_E
        DetRecibosValores_M
        DetRecibosValores_T
        DetRecibosValores_TT
        DetRecibosValores_TX_Estructura
        DetRecibosValores_TX_ParaTransmitir
        DetRecibosValores_TX_PorIdCabecera
        DetRecibosValores_TX_SetearComoTransmitido
        DetRecibosValores_TX_ValidarCheque
        DetRecibosValores_TXPrimero
        DetRecibosValores_TXRecibo
        DetRemitos_A
        DetRemitos_E
        DetRemitos_M
        DetRemitos_T
        DetRemitos_TX_ConDatos
        DetRemitos_TX_ConDatosResumido
        DetRemitos_TXPrimero
        DetRemitos_TXRem
        DetRequerimientos_A
        DetRequerimientos_E
        DetRequerimientos_M
        DetRequerimientos_T
        DetRequerimientos_TX_DetallesParametrizados
        DetRequerimientos_TX_ParaTransmitir
        DetRequerimientos_TX_SetearComoTransmitido
        DetRequerimientos_TX_Todos
        DetRequerimientos_TX_TodosConDatos
        DetRequerimientos_TX_UnItem
        DetRequerimientos_TX_UnItemConFormato
        DetRequerimientos_TXPrimero
        DetRequerimientos_TXReq
        DetReservas_A
        DetReservas_E
        DetReservas_M
        DetReservas_T
        DetReservas_TXPrimero
        DetReservas_TXRes
        DetSalidasMateriales_A
        DetSalidasMateriales_AnularConsumos
        DetSalidasMateriales_E
        DetSalidasMateriales_M
        DetSalidasMateriales_T
        DetSalidasMateriales_TX_DetallesParametrizados
        DetSalidasMateriales_TX_Todos
        DetSalidasMateriales_TXPrimero
        DetSalidasMateriales_TXSal
        DetSalidasMaterialesSAT_A
        DetSalidasMaterialesSAT_M
        DetSalidasMaterialesSAT_T
        DetSalidasMaterialesSAT_TXSal
        DetSolicitudesCompra_A
        DetSolicitudesCompra_E
        DetSolicitudesCompra_M
        DetSolicitudesCompra_T
        DetSolicitudesCompra_TX_Datos
        DetSolicitudesCompra_TXPrimero
        DetSolicitudesCompra_TXSol
        DetValesSalida_A
        DetValesSalida_E
        DetValesSalida_M
        DetValesSalida_T
        DetValesSalida_TX_DetallesParametrizados
        DetValesSalida_TX_TodoMasPendientePorIdDetalle
        DetValesSalida_TX_TodosLosItemsConFormato
        DetValesSalida_TX_UnItem
        DetValesSalida_TX_UnItemConFormato
        DetValesSalida_TXPrimero
        DetValesSalida_TXRes
        DetValores_A
        DetValores_E
        DetValores_M
        DetValores_T
        DetValores_TXPrimero
        DetValores_TXVal
        DetValoresCuentas_A
        DetValoresCuentas_BorrarPorIdValor
        DetValoresCuentas_E
        DetValoresCuentas_M
        DetValoresCuentas_T
        DetValoresCuentas_TT
        DetValoresCuentas_TX_Estructura
        DetValoresCuentas_TXPrimero
        DetValoresCuentas_TXValor
        DetValoresProvincias_A
        DetValoresProvincias_BorrarPorIdValor
        DetValoresProvincias_E
        DetValoresProvincias_M
        DetValoresProvincias_T
        DetValoresProvincias_TT
        DetValoresProvincias_TX_Estructura
        DetValoresProvincias_TX_PorIdValor
        DetValoresProvincias_TXPrimero
        DetValoresProvincias_TXValor
        DetValoresRubrosContables_A
        DetValoresRubrosContables_BorrarPorIdValor
        DetValoresRubrosContables_E
        DetValoresRubrosContables_M
        DetValoresRubrosContables_T
        DetValoresRubrosContables_TT
        DetValoresRubrosContables_TX_Estructura
        DetValoresRubrosContables_TX_PorIdValor
        DetValoresRubrosContables_TXPrimero
        DetValoresRubrosContables_TXValor
        DetVentasEnCuotas_A
        DetVentasEnCuotas_E
        DetVentasEnCuotas_M
        DetVentasEnCuotas_T
        DetVentasEnCuotas_TX_PorIdVentaEnCuotas
        DetVentasEnCuotas_TXPrimero
        Devoluciones_A
        Devoluciones_E
        Devoluciones_M
        Devoluciones_T
        Devoluciones_TT
        Devoluciones_TX_EntreFechasParaGeneracionContable
        Devoluciones_TX_PorId
        Devoluciones_TX_TodosSF_HastaFecha
        Devoluciones_TX_TT
        Devoluciones_TXAnio
        Devoluciones_TXCod
        Devoluciones_TXFecha
        Devoluciones_TXMes
        Devoluciones_TXMesAnio
        DiferenciasCambio_A
        DiferenciasCambio_E
        DiferenciasCambio_Eliminar
        DiferenciasCambio_M
        DiferenciasCambio_MarcarComoGenerada
        DiferenciasCambio_T
        DiferenciasCambio_TX_DatosDelComprobantePorCobranza
        DiferenciasCambio_TX_ParaCalculoIndividual
        DiferenciasCambio_TX_ParaCalculoIndividualCobranzas
        DiferenciasCambio_TX_PorCobranzasGeneradas
        DiferenciasCambio_TX_PorCobranzasPendientes
        DiferenciasCambio_TX_PorCobranzasTodas
        DiferenciasCambio_TX_PorPagosGeneradas
        DiferenciasCambio_TX_PorPagosPendientes
        DiferenciasCambio_TX_PorPagosTodos
        DiferenciasCambio_TX_Struc
        DispositivosGPS_A
        DispositivosGPS_E
        DispositivosGPS_M
        DispositivosGPS_T
        DispositivosGPS_TL
        DispositivosGPS_TT
        DispositivosGPS_TX_PorDescripcion
        DispositivosGPS_TX_TT
        DistribucionesObras_A
        DistribucionesObras_E
        DistribucionesObras_M
        DistribucionesObras_T
        DistribucionesObras_TL
        DistribucionesObras_TT
        DistribucionesObras_TX_TT
        dropFK
        Ejercicios_TX_Uno
        EjerciciosContables_A
        EjerciciosContables_E
        EjerciciosContables_M
        EjerciciosContables_T
        EjerciciosContables_TL
        EjerciciosContables_TT
        EjerciciosContables_TX_PorId
        EjerciciosContables_TX_TodosSF
        EjerciciosContables_TX_TT
        EjerciciosContables_TX_Ultimo
        EjerciciosPeriodos_TX_PorEjercicio
        EjerciciosPeriodos_TX_Uno
        Empleados_A
        Empleados_E
        Empleados_M
        Empleados_T
        Empleados_TL
        Empleados_TT
        Empleados_TX_AccesosPorItemArbol
        Empleados_TX_Administradores
        Empleados_TX_AdministradoresMasJefeCompras
        Empleados_TX_ConEventosPendientes
        Empleados_TX_ParaAnularPorFormulario
        Empleados_TX_ParaHH
        Empleados_TX_ParaMensajes
        Empleados_TX_ParaTransmitir_Todos
        Empleados_TX_PorEmpleado
        Empleados_TX_PorEnumeracionIds
        Empleados_TX_PorGruposDelSector
        Empleados_TX_PorId
        Empleados_TX_PorIdSector
        Empleados_TX_PorIdSectorParaHH
        Empleados_TX_PorIdSectorParaHHSinBajas
        Empleados_TX_PorLegajo
        Empleados_TX_PorNombre
        Empleados_TX_PorObraAsignada
        Empleados_TX_PorSector
        Empleados_TX_TLParaHH
        Empleados_TX_TodosLosAccesos
        Empleados_TX_TT
        Empleados_TX_UnUsuario
        Empleados_TX_UsuarioNT
        EmpleadosAccesos_A
        EmpleadosAccesos_Actualizar
        EmpleadosAccesos_ActualizarPorBD
        EmpleadosAccesos_E
        EmpleadosAccesos_InhabilitarAccesosPorNodo
        EmpleadosAccesos_M
        Empresa_M
        Empresa_T
        Empresa_TT
        Empresa_TX_Datos
        Equipos_A
        Equipos_E
        Equipos_M
        Equipos_T
        Equipos_TL
        Equipos_TT
        Equipos_TX_ParaTransmitir
        Equipos_TX_ParaTransmitir_Todos
        Equipos_TX_PorcentajesStandar
        Equipos_TX_PorObra1
        Equipos_TX_PorObraParaCombo
        Equipos_TX_SetearComoTransmitido
        Equipos_TX_TT
        Equipos_TXPlanos
        Equipos_TXPorObra
        EstadoPedidos_A
        EstadoPedidos_M
        EstadoPedidos_T
        EstadoPedidos_TT
        EstadoPedidos_TX_ACancelar
        EstadoPedidos_TX_BuscarComprobante
        EstadoPedidos_TX_Imputacion
        EstadoPedidos_TX_PorNumeroComprobante
        EstadoPedidos_TX_PorNumeroPedido
        EstadoPedidos_TX_Struc
        EstadoPedidos_TX_TT
        EstadoPedidos_TXParaImputar
        EstadoPedidos_TXPorMayor
        EstadoPedidos_TXPorTrs
        EstadoPedidos_TXTotal
        EstadosProveedores_A
        EstadosProveedores_E
        EstadosProveedores_M
        EstadosProveedores_T
        EstadosProveedores_TL
        EstadosProveedores_TT
        EstadosProveedores_TX_TT
        EstadosVentasEnCuotas_TX_ParaCombo
        EventosDelSistema_A
        EventosDelSistema_E
        EventosDelSistema_M
        EventosDelSistema_T
        EventosDelSistema_TL
        EventosDelSistema_TT
        EventosDelSistema_TX_IdEmpleadosPorIdEvento
        EventosDelSistema_TX_TT
        Facturas_A
        Facturas_ActualizarCampos
        Facturas_ActualizarCamposDetalle
        Facturas_ActualizarDatosCAE
        Facturas_ActualizarDetalles
        Facturas_ActualizarIdReciboContado
        Facturas_E
        Facturas_EliminarFacturaAnulada
        Facturas_M
        Facturas_T
        Facturas_TT
        Facturas_TX_DevolucionAnticipo
        Facturas_TX_EntreFechasParaGeneracionContable
        Facturas_TX_FacturasContadoTodas
        Facturas_TX_NCs_RecuperoGastos
        Facturas_TX_OrdenCompraPorIdFactura
        Facturas_TX_ParaDebitoBancario
        Facturas_TX_ParaTransmitir
        Facturas_TX_PorComprobanteCliente
        Facturas_TX_PorId
        Facturas_TX_PorIdConDatos
        Facturas_TX_PorIdOrigen
        Facturas_TX_PorIdOrigenDetalle
        Facturas_TX_PorNumeroComprobante
        Facturas_TX_PorNumeroDesdeHasta
        Facturas_TX_SetearComoTransmitido
        Facturas_TX_TodosSF_HastaFecha
        Facturas_TX_TraerIdObraDesdeIdDetalleFactura
        Facturas_TX_TT
        Facturas_TX_TT_Contado
        Facturas_TX_UltimaPorIdPuntoVenta
        Facturas_TX_UltimoAnteriorAFecha
        Facturas_TXAnio
        Facturas_TXAnio_Contado
        Facturas_TXCod
        Facturas_TXFecha
        Facturas_TXFecha_Contado
        Facturas_TXMes
        Facturas_TXMes_Contado
        Facturas_TXMesAnio
        FacturasClientesPRESTO_A
        FacturasClientesPRESTO_E
        FacturasClientesPRESTO_M
        FacturasClientesPRESTO_T
        FacturasClientesPRESTO_TT
        FacturasClientesPRESTO_TX_PorId
        FacturasClientesPRESTO_TX_TT
        FacturasCompra_A
        FacturasCompra_E
        FacturasCompra_M
        FacturasCompra_T
        FacturasCompra_TX_DetallePorComprobante
        FacturasCompra_TX_DetallePorComprobanteSinFormato
        FacturasCompra_TX_DetallePorDetalleComprobante
        FacturasCompra_TXPrimero
        Familias_A
        Familias_E
        Familias_M
        Familias_T
        Familias_TL
        Familias_TT
        Familias_TX_ParaTransmitir
        Familias_TX_ParaTransmitir_Todos
        Familias_TX_SetearComoTransmitido
        Familias_TX_TT
        Feriados_A
        Feriados_E
        Feriados_M
        Feriados_T
        Feriados_TT
        Feriados_TX_ConsultaFeriado
        Feriados_TX_FeriadosPorMes
        Feriados_TX_TT
        Fletes_A
        Fletes_E
        Fletes_M
        Fletes_T
        Fletes_TL
        Fletes_TT
        Fletes_TX_PorTouch
        Fletes_TX_TT
        FletesPartesDiarios_A
        FletesPartesDiarios_E
        FletesPartesDiarios_M
        FletesPartesDiarios_T
        FletesPartesDiarios_TT
        FletesPartesDiarios_TX_Fecha
        FletesPartesDiarios_TX_TT
        FletesPartesDiarios_TXAnio
        FletesPartesDiarios_TXMes
        FondosFijos_TX_Resumen
        Formas_A
        Formas_E
        Formas_M
        Formas_T
        Formas_TL
        Formas_TT
        Formas_TX_TT
        Formularios_A
        Formularios_E
        Formularios_M
        Formularios_T
        Formularios_TL
        Formularios_TT
        Formularios_TX_TT
        FormulariosTabIndex_Agregar
        FormulariosTabIndex_BorrarRegistrosDeUnFormulario
        FormulariosTabIndex_TX_PorFormulario
        FormulariosTabIndex_TX_PorFormularioControl
        Ganacias_AsignarMinimos
        Ganancias_A
        Ganancias_E
        Ganancias_M
        Ganancias_T
        Ganancias_TT
        Ganancias_TX_Desarrollo
        Ganancias_TX_DesarrolloResumido
        Ganancias_TX_ImpuestoPorIdTipoRetencionGanancia
        Ganancias_TX_RetenidoMes
        Ganancias_TX_TT
        GastosFletes_A
        GastosFletes_E
        GastosFletes_M
        GastosFletes_T
        GastosFletes_TX_Fecha
        GastosFletes_TX_TT
        GastosFletes_TXAnio
        GastosFletes_TXMes
        GetCountRequemientoForEmployee
        GetEmployeeByName
        Grados_A
        Grados_E
        Grados_M
        Grados_T
        Grados_TL
        Grados_TT
        Grados_TX_PorDescripcion
        Grados_TX_TT
        GruposActivosFijos_A
        GruposActivosFijos_E
        GruposActivosFijos_M
        GruposActivosFijos_T
        GruposActivosFijos_TL
        GruposActivosFijos_TT
        GruposActivosFijos_TX_TT
        GruposObras_A
        GruposObras_E
        GruposObras_M
        GruposObras_T
        GruposObras_TL
        GruposObras_TT
        GruposObras_TX_TT
        GruposTareasHH_A
        GruposTareasHH_E
        GruposTareasHH_M
        GruposTareasHH_T
        GruposTareasHH_TL
        GruposTareasHH_TT
        GruposTareasHH_TX_PorObra
        GruposTareasHH_TX_TT
        HaveEmployeeAccess
        HorasJornadas_A
        HorasJornadas_E
        HorasJornadas_M
        HorasJornadas_T
        IBCondiciones_A
        IBCondiciones_E
        IBCondiciones_M
        IBCondiciones_T
        IBCondiciones_TL
        IBCondiciones_TT
        IBCondiciones_TX_AcumuladosPorIdProveedorIdIBCondicion
        IBCondiciones_TX_IdCuentaPorProvincia
        IBCondiciones_TX_PorId
        IBCondiciones_TX_TT
        IGCondiciones_A
        IGCondiciones_E
        IGCondiciones_M
        IGCondiciones_T
        IGCondiciones_TL
        IGCondiciones_TT
        IGCondiciones_TX_PorId
        IGCondiciones_TX_TT
        ImpuestosDirectos_A
        ImpuestosDirectos_E
        ImpuestosDirectos_M
        ImpuestosDirectos_T
        ImpuestosDirectos_TL
        ImpuestosDirectos_TT
        ImpuestosDirectos_TX_PorGrupoConCertificado
        ImpuestosDirectos_TX_PorId
        ImpuestosDirectos_TX_PorTipoParaCombo
        ImpuestosDirectos_TX_TT
        InformeBalance_TX_1
        InformeDeDiario_TX_1
        InformeDeDiario_TX_2
        InformeDeDiario_TX_2_Modelo_IGJ
        InformeDeDiario_TX_2_Modelo2
        InformeDeDiario_TX_2_Modelo3
        InformeDeDiario_TX_2_Modelo4
        InformeDeDiario_TX_2_Resumido
        InformeDeDiario_TX_2_Resumido_Modelo2
        InformeMayorDetallado_TX_1
        InformeMayorResumido_TX_1
        InformesContables_TX_1361
        InformesContables_TX_1361_CabeceraFacturas
        InformesContables_TX_1361_Compras
        InformesContables_TX_1361_DetalleFacturas
        InformesContables_TX_1361_OtrasPercepciones
        InformesContables_TX_1361_Ventas
        InformesContables_TX_ComercioExterior
        InformesContables_TX_IVACompras
        InformesContables_TX_IVACompras_Modelo2
        InformesContables_TX_IVACompras_Modelo3
        InformesContables_TX_IVACompras_Modelo4
        InformesContables_TX_IVACompras_Modelo5
        InformesContables_TX_IVACompras_Modelo6
        InformesContables_TX_IVAComprasDetallado
        InformesContables_TX_IVAVentas
        InformesContables_TX_IVAVentas_Modelo2
        InformesContables_TX_IVAVentas_Modelo3
        InformesContables_TX_IVAVentas_Modelo4
        InformesContables_TX_IVAVentas_Modelo5
        InformesContables_TX_SubdiarioCajaYBancos
        InformesContables_TX_SubdiarioClientes
        InformesContables_TX_SubdiarioCobranzas
        InformesContables_TX_SubdiarioPagos
        InformesContables_TX_SubdiarioProveedores
        InformesContables_TX_T
        InformesContables_TX_Todos
        Inventarios_TL
        ItemsDocumentacion_A
        ItemsDocumentacion_E
        ItemsDocumentacion_M
        ItemsDocumentacion_T
        ItemsDocumentacion_TL
        ItemsDocumentacion_TT
        ItemsDocumentacion_TX_TT
        ItemsPopUpMateriales_A
        ItemsPopUpMateriales_E
        ItemsPopUpMateriales_M
        ItemsPopUpMateriales_T
        ItemsPopUpMateriales_TT
        ItemsPopUpMateriales_TX_CamposConTablas
        ItemsPopUpMateriales_TX_Existente
        ItemsPopUpMateriales_TX_ParaMenu
        ItemsPopUpMateriales_TX_Todos
        ItemsPopUpMateriales_TX_TT
        ItemsProduccion_A
        ItemsProduccion_E
        ItemsProduccion_M
        ItemsProduccion_T
        ItemsProduccion_TL
        ItemsProduccion_TT
        ItemsProduccion_TX_TT
        LecturasGPS_A
        LecturasGPS_E
        LecturasGPS_M
        LecturasGPS_T
        LecturasGPS_TT
        LecturasGPS_TX_Fecha
        LecturasGPS_TX_PorCoincidenciaConPatron
        LecturasGPS_TX_PorFecha
        LecturasGPS_TXAnio
        LecturasGPS_TXMes
        ListasPrecios_A
        ListasPrecios_E
        ListasPrecios_M
        ListasPrecios_T
        ListasPrecios_TL
        ListasPrecios_TT
        ListasPrecios_TX_DetallesPorId
        ListasPrecios_TX_NuevoPrecio
        ListasPrecios_TX_ParaArbol
        ListasPrecios_TX_TT
        ListasPrecios_TX_UltimoPorIdArticulo
        ListasPreciosDetalle_A
        ListasPreciosDetalle_E
        ListasPreciosDetalle_M
        ListasPreciosDetalle_T
        LMateriales_A
        LMateriales_ActualizarDetalles
        LMateriales_CalcularDisponibilidadesPorLM
        LMateriales_CalcularFaltantes
        LMateriales_E
        LMateriales_M
        LMateriales_T
        LMateriales_TL
        LMateriales_TT
        LMateriales_TX_CantidadPorDestinoArticulo
        LMateriales_TX_DesdeDetalle
        LMateriales_TX_DetallesAReservar
        LMateriales_TX_Disponibilidades
        LMateriales_TX_DisponibilidadesCal
        LMateriales_TX_DisponibilidadesPed
        LMateriales_TX_DisponibilidadesPorLM
        LMateriales_TX_DisponibilidadesRec
        LMateriales_TX_DisponibilidadesRes
        LMateriales_TX_DisponibilidadesSal
        LMateriales_TX_DisponibilidadesVal
        LMateriales_TX_Faltantes
        LMateriales_TX_ParaListaPorObra
        LMateriales_TX_PorIdOrigen
        LMateriales_TX_PorIdOrigenDetalle
        LMateriales_TX_PorIdOrigenDetalleRevisiones
        LMateriales_TX_PorLMat
        LMateriales_TX_SaldosPorDestino
        LMateriales_TX_Sumarizadas
        LMateriales_TX_TodasLasRevisiones
        LMateriales_TX_TodasLasRevisiones_AcopiosYLMateriales
        LMateriales_TX_TT
        LMateriales_TXNombre
        LMateriales_TXPorEquipo
        LMateriales_TXPorLAcopio
        Localidades_A
        Localidades_E
        Localidades_M
        Localidades_T
        Localidades_TL
        Localidades_TT
        Localidades_TX_ParaTransmitir
        Localidades_TX_ParaTransmitir_Todos
        Localidades_TX_PorId
        Localidades_TX_PorNombre
        Localidades_TX_SetearComoTransmitido
        Localidades_TX_TT
        Log_InsertarRegistro
        LogImpuestos_A
        LogImpuestos_TX_ConsultaGeneral
        LugaresEntrega_A
        LugaresEntrega_E
        LugaresEntrega_M
        LugaresEntrega_T
        LugaresEntrega_TL
        LugaresEntrega_TT
        LugaresEntrega_TX_PorId
        LugaresEntrega_TX_TT
        Maquinas_TX_PorAreaSectorLineaProcesoMaquina
        Marcas_A
        Marcas_E
        Marcas_M
        Marcas_T
        Marcas_TL
        Marcas_TT
        Marcas_TX_TT
        Materiales_A
        Materiales_E
        Materiales_M
        Materiales_T
        Materiales_TL
        Materiales_TT
        Materiales_TX_TT
        Modelos_A
        Modelos_E
        Modelos_M
        Modelos_T
        Modelos_TL
        Modelos_TT
        Modelos_TX_TT
        Monedas_A
        Monedas_E
        Monedas_M
        Monedas_T
        Monedas_TL
        Monedas_TT
        Monedas_TX_MonedasStandarParaCombo
        Monedas_TX_ParaTransmitir
        Monedas_TX_ParaTransmitir_Todos
        Monedas_TX_PorId
        Monedas_TX_Resto
        Monedas_TX_SetearComoTransmitido
        Monedas_TX_TT
        Monedas_TX_VerificarAbreviatura
        MotivosRechazo_A
        MotivosRechazo_E
        MotivosRechazo_M
        MotivosRechazo_T
        MotivosRechazo_TL
        MotivosRechazo_TT
        MotivosRechazo_TX_TT
        MovimientosFletes_A
        MovimientosFletes_Actualizar
        MovimientosFletes_ActualizarLecturasGPS
        MovimientosFletes_E
        MovimientosFletes_M
        MovimientosFletes_T
        MovimientosFletes_TX_EntreFechasSinFormato
        MovimientosFletes_TX_Fecha
        MovimientosFletes_TX_Liquidacion
        MovimientosFletes_TX_MovimientoAnteriorCarga
        MovimientosFletes_TXAnio
        MovimientosFletes_TXMes
        Normas_A
        Normas_E
        Normas_M
        Normas_T
        Normas_TL
        Normas_TT
        Normas_TX_TT
        NotasCredito_A
        NotasCredito_ActualizarCampos
        NotasCredito_E
        NotasCredito_M
        NotasCredito_T
        NotasCredito_TT
        NotasCredito_TX_EntreFechasParaGeneracionContable
        NotasCredito_TX_NDs_RecuperoGastos
        NotasCredito_TX_PorId
        NotasCredito_TX_PorNumeroComprobante
        NotasCredito_TX_TodosSF_HastaFecha
        NotasCredito_TX_TT
        NotasCredito_TX_UltimaPorIdPuntoVenta
        NotasCredito_TXAnio
        NotasCredito_TXCod
        NotasCredito_TXFecha
        NotasCredito_TXMes
        NotasCredito_TXMesAnio
        NotasDebito_A
        NotasDebito_ActualizarCampos
        NotasDebito_E
        NotasDebito_M
        NotasDebito_T
        NotasDebito_TT
        NotasDebito_TX_EntreFechasParaGeneracionContable
        NotasDebito_TX_PorId
        NotasDebito_TX_PorNumeroComprobante
        NotasDebito_TX_TodosSF_HastaFecha
        NotasDebito_TX_TT
        NotasDebito_TX_UltimaPorIdPuntoVenta
        NotasDebito_TXAnio
        NotasDebito_TXCod
        NotasDebito_TXFecha
        NotasDebito_TXMes
        NotasDebito_TXMesAnio
        NovedadesUsuarios_A
        NovedadesUsuarios_E
        NovedadesUsuarios_GrabarNovedadNueva
        NovedadesUsuarios_M
        NovedadesUsuarios_T
        NovedadesUsuarios_TX_Estructura
        NovedadesUsuarios_TX_PorIdEmpleadoConEventosPendientes
        Obras_A
        Obras_E
        Obras_EliminarCuentasNoUsadasPorIdObra
        Obras_GenerarActivacionCompraMateriales
        Obras_GenerarEstado
        Obras_M
        Obras_T
        Obras_TL
        Obras_TT
        Obras_TX_ActivacionCompra
        Obras_TX_Activas
        Obras_TX_ActivasConDatos
        Obras_TX_ConDetallePolizas
        Obras_TX_ConPolizasVencidas
        Obras_TX_ControlDominioEnObra
        Obras_TX_ControlEquipoEnDominio
        Obras_TX_DatosDeLaObra
        Obras_TX_DatosParaProgramacionHoras
        Obras_TX_DestinosParaComboPorIdObra
        Obras_TX_DestinosParaPresupuesto
        Obras_TX_DetalladosPorEquiposPlanos
        Obras_TX_DetallesParametrizados
        Obras_TX_EquiposInstaladosPorFecha
        Obras_TX_EstadoObras
        Obras_TX_EstadoObras_Acopios
        Obras_TX_EstadoObras_DetalleComprobantesProveedoresAsignados
        Obras_TX_EstadoObras_DetalleFacturasAsignadas
        Obras_TX_EstadoObras_DetallePedidosDesdeAcopio
        Obras_TX_EstadoObras_DetallePedidosDesdeRM
        Obras_TX_EstadoObras_DetallePresupuestosDesdeRM
        Obras_TX_EstadoObras_DetalleRecepcionesDesdeAcopio
        Obras_TX_EstadoObras_DetalleRecepcionesDesdeRM
        Obras_TX_EstadoObras_DetalleSalidasDesdeRM
        Obras_TX_EstadoObras_RM
        Obras_TX_EstadoObrasPorObra
        Obras_TX_Habilitadas
        Obras_TX_HabilitadasExcel
        Obras_TX_Inactivas
        Obras_TX_ItemsDocumentacion
        Obras_TX_ObrasMasOT
        Obras_TX_ObrasMasOTParaCombo
        Obras_TX_ParaInformes
        Obras_TX_ParaPopUp
        Obras_TX_ParaPopUp1
        Obras_TX_ParaTransmitir
        Obras_TX_ParaTransmitir_Todos
        Obras_TX_PolizasPorIdObraConDatos
        Obras_TX_PorId
        Obras_TX_PorIdClienteParaCombo
        Obras_TX_PorIdCuentaFF
        Obras_TX_PorIdObraConDatos
        Obras_TX_PorNumero
        Obras_TX_Presupuesto
        Obras_TX_Presupuesto_OT
        Obras_TX_SetearComoTransmitido
        Obras_TX_TodasActivasParaCombo
        Obras_TX_TodasActivasParaComboConDescripcion
        Obras_TX_TodasParaCombo
        Obras_TX_TodosLosItems
        Obras_TX_TT
        Obras_TX_TT_DetallesParametrizados
        Obras_TX_ValidarParaBaja
        Obras_TXEquipos
        Obras_TXEquiposPorGrupo
        OrdenesCompra_A
        OrdenesCompra_ActualizarEstadoDetalles
        OrdenesCompra_E
        OrdenesCompra_M
        OrdenesCompra_MarcarComoCumplidas
        OrdenesCompra_MarcarParaFacturacionAutomatica
        OrdenesCompra_T
        OrdenesCompra_TT
        OrdenesCompra_TX_DesarrolloPorItem
        OrdenesCompra_TX_DetalladoEntreFechas
        OrdenesCompra_TX_DetallePorId
        OrdenesCompra_TX_DetallePorIdDetalle
        OrdenesCompra_TX_DetallesPendientesDeFacturarPorIdCliente
        OrdenesCompra_TX_DetallesPendientesDeFacturarPorIdDetalleOrdenCompra
        OrdenesCompra_TX_ItemsApuntadosPorIdOrdenCompra
        OrdenesCompra_TX_ItemsPendientesDeFacturar
        OrdenesCompra_TX_ItemsPendientesDeFacturarPorIdOrdenCompra
        OrdenesCompra_TX_ItemsPendientesDeProducir
        OrdenesCompra_TX_ItemsPendientesDeProducirModuloProduccion
        OrdenesCompra_TX_ItemsPendientesDeRemitir
        OrdenesCompra_TX_ItemsPendientesDeRemitirPorIdCliente
        OrdenesCompra_TX_ItemsPendientesDeRemitirPorIdClienteParaCombo
        OrdenesCompra_TX_OrdenesAFacturarAutomaticas_DetallesPorIdCliente
        OrdenesCompra_TX_OrdenesAFacturarAutomaticas_PorCliente
        OrdenesCompra_TX_OrdenesAutomaticasPrefacturacion
        OrdenesCompra_TX_PorId
        OrdenesCompra_TX_PorIdClienteTodosParaCredito
        OrdenesCompra_TX_PorIdParaCombo
        OrdenesCompra_TX_RemitosFacturasPorIdDetalleOrdenCompra
        OrdenesCompra_TX_Todas
        OrdenesCompra_TX_TT
        OrdenesCompra_TXAnio
        OrdenesCompra_TXFecha
        OrdenesCompra_TXMes
        OrdenesPago_A
        OrdenesPago_ActualizarDiferenciaBalanceo
        OrdenesPago_ActualizarIdOrdenPagoComplementaria
        OrdenesPago_BorrarValores
        OrdenesPago_ConfirmarAcreditacionFF
        OrdenesPago_E
        OrdenesPago_EliminarOrdenesDePagoAConfirmar
        OrdenesPago_LiberarGastosPorAnulacionOP
        OrdenesPago_M
        OrdenesPago_MarcarComoEnCaja
        OrdenesPago_MarcarComoEntregado
        OrdenesPago_MarcarComoPendiente
        OrdenesPago_T
        OrdenesPago_TT
        OrdenesPago_TX_AConfirmar
        OrdenesPago_TX_AcumuladoParaIIBB
        OrdenesPago_TX_ALaFirma
        OrdenesPago_TX_CajaEgresos
        OrdenesPago_TX_DatosDeLaImputacion
        OrdenesPago_TX_DetallePorRubroContable
        OrdenesPago_TX_EnCaja
        OrdenesPago_TX_EntreFechasParaGeneracionContable
        OrdenesPago_TX_FFPendientesControl
        OrdenesPago_TX_ParaListadoDetallado
        OrdenesPago_TX_PorId
        OrdenesPago_TX_PorIdDetalleOrdenPago
        OrdenesPago_TX_PorNumero
        OrdenesPago_TX_PorNumeroFF
        OrdenesPago_TX_PorNumeroIdObraOrigen
        OrdenesPago_TX_ResumenPorRendicionFF
        OrdenesPago_TX_Todas
        OrdenesPago_TX_TodosSF_HastaFecha
        OrdenesPago_TX_TraerGastosPendientes
        OrdenesPago_TX_TraerGastosPorOrdenPago
        OrdenesPago_TX_TraerGastosPorOrdenPagoParaAnular
        OrdenesPago_TX_TT
        OrdenesPago_TX_ValidarNumero
        OrdenesPago_TX_ValoresEnConciliacionesPorIdOrdenPago
        OrdenesPago_TX_ValoresPorIdOrdenPago
        OrdenesPago_TXAnio
        OrdenesPago_TXCod
        OrdenesPago_TXFecha
        OrdenesPago_TXMes
        OrdenesPago_TXMesAnio
        OrdenesPago_TXOrdenesPagoxAnio
        OrdenesProduccion_TX_ItemsPendientesDeProducir
        OrdenesTrabajo_A
        OrdenesTrabajo_E
        OrdenesTrabajo_M
        OrdenesTrabajo_T
        OrdenesTrabajo_TL
        OrdenesTrabajo_TT
        OrdenesTrabajo_TX_ParaCombo
        OrdenesTrabajo_TX_PorNumero
        OrdenesTrabajo_TX_SegunFechaFinalizacion
        OrdenesTrabajo_TX_TT
        OrdenesTrabajo_TXAnio
        OrdenesTrabajo_TXFecha
        OrdenesTrabajo_TXMes
        Origen_TL
        OtrosIngresosAlmacen_A
        OtrosIngresosAlmacen_ActualizarDetalles
        OtrosIngresosAlmacen_AjustarStockPorAnulacion
        OtrosIngresosAlmacen_E
        OtrosIngresosAlmacen_M
        OtrosIngresosAlmacen_T
        OtrosIngresosAlmacen_TT
        OtrosIngresosAlmacen_TX_DetallesParametrizados
        OtrosIngresosAlmacen_TX_PorId
        OtrosIngresosAlmacen_TX_PorIdOrigen
        OtrosIngresosAlmacen_TX_PorIdOrigenDetalle
        OtrosIngresosAlmacen_TX_Todos
        OtrosIngresosAlmacen_TX_TT
        OtrosIngresosAlmacen_TX_TT_DetallesParametrizados
        OtrosIngresosAlmacen_TXAnio
        OtrosIngresosAlmacen_TXFecha
        OtrosIngresosAlmacen_TXMes
        OtrosIngresosAlmacenSAT_A
        OtrosIngresosAlmacenSAT_ActualizarDetalles
        OtrosIngresosAlmacenSAT_M
        OtrosIngresosAlmacenSAT_T
        OtrosIngresosAlmacenSAT_TX_PorIdOrigen
        OtrosIngresosAlmacenSAT_TX_PorIdOrigenDetalle
        OtrosIngresosAlmacenSAT_TX_Todos
        OtrosIngresosAlmacenSAT_TXAnio
        OtrosIngresosAlmacenSAT_TXFecha
        OtrosIngresosAlmacenSAT_TXMes
        Paises_A
        Paises_E
        Paises_M
        Paises_T
        Paises_TL
        Paises_TT
        Paises_TX_ParaTransmitir
        Paises_TX_ParaTransmitir_Todos
        Paises_TX_PorCodigo
        Paises_TX_PorNombre
        Paises_TX_SetearComoTransmitido
        Paises_TX_TT
        Parametros_M
        Parametros_RegistrarParametros2
        Parametros_T
        Parametros_TT
        Parametros_TX_Parametros2
        Parametros_TX_Parametros2BuscarClave
        Parametros_TX_PorId
        Parametros_TX_PorIdConTimeStamp
        Partidas_TX_ComprobantesDetalladosPorPartida
        PatronesGPS_A
        PatronesGPS_E
        PatronesGPS_M
        PatronesGPS_T
        PatronesGPS_TT
        PatronesGPS_TX_TT
        Pedidos_A
        Pedidos_ActualizarCosto
        Pedidos_ActualizarEstadoPorIdPedido
        Pedidos_AsignarCostoImportacion
        Pedidos_BorrarAsignacionCosto
        Pedidos_E
        Pedidos_M
        Pedidos_RegistrarFechaSalida
        Pedidos_RegistrarImpresion
        Pedidos_SetearPedidoPresto
        Pedidos_T
        Pedidos_TT
        Pedidos_TX_AdjuntosPorPedido
        Pedidos_TX_AnticipoAProveedores
        Pedidos_TX_ComprasTercerosDetalladas
        Pedidos_TX_ComprasTercerosResumidaServicios
        Pedidos_TX_ComprasTercerosResumidaTaller
        Pedidos_TX_CuentasContablesPorIdPedido
        Pedidos_TX_Cumplidos
        Pedidos_TX_DatosPorIdDetalle
        Pedidos_TX_DetallePorNumeroItem
        Pedidos_TX_DetallesParaComprobantesProveedores
        Pedidos_TX_DetallesPedidosRecepcionesLMaterialesPorObra
        Pedidos_TX_DetallesPorId
        Pedidos_TX_DetallesPorIdPedido
        Pedidos_TX_DetallesPorIdPedidoAgrupados
        Pedidos_TX_DetallesPorIdPedidoAgrupadosPorObra
        Pedidos_TX_DetPendientes
        Pedidos_TX_DetPendientesTodos
        Pedidos_TX_DetPendientesTodosVencidos
        Pedidos_TX_EstadoSubcontratos
        Pedidos_TX_Exterior
        Pedidos_TX_HabilitadosParaWeb
        Pedidos_TX_ParaComboAsignacionImportacion
        Pedidos_TX_ParaPasarAPrestoCabeceras
        Pedidos_TX_ParaPasarAPrestoDetalles
        Pedidos_TX_ParaTransmitir
        Pedidos_TX_ParaTransmitir_Todos
        Pedidos_TX_Pendientes
        Pedidos_TX_PendientesParaArbol
        Pedidos_TX_PendientesParaLista
        Pedidos_TX_PendientesPorIdDetallePedido
        Pedidos_TX_PorArticuloRubro
        Pedidos_TX_PorFechaVencimiento
        Pedidos_TX_PorId
        Pedidos_TX_PorIdDetallePedido
        Pedidos_TX_PorIdParaCOMEX
        Pedidos_TX_PorIdParaCOMEXDetalles
        Pedidos_TX_PorItemRequerimiento
        Pedidos_TX_PorNumero
        Pedidos_TX_PorNumeroBis
        Pedidos_TX_PorNumeroSubcontrato
        Pedidos_TX_PorObra
        Pedidos_TX_PorObraParaCombo
        Pedidos_TX_Precios
        Pedidos_TX_RecepcionesPorIdDetallePedido
        Pedidos_TX_RecepcionesPorIdPedido
        Pedidos_TX_RegistroDePedidos
        Pedidos_TX_SetearComoTransmitido
        Pedidos_TX_SubcontratosEntreFecha
        Pedidos_TX_SubcontratosParaCombo
        Pedidos_TX_SubContratosPorAnio
        Pedidos_TX_SubContratosPorMes
        Pedidos_TX_SubcontratosTodos
        Pedidos_TX_SumaItemAco
        Pedidos_TX_SumaItemRM
        Pedidos_TX_TodosConCodigoSAP
        Pedidos_TX_TodosLosDetalles
        Pedidos_TX_TT
        Pedidos_TXAnio
        Pedidos_TXFecha
        Pedidos_TXMes
        PedidosAbiertos_A
        PedidosAbiertos_E
        PedidosAbiertos_M
        PedidosAbiertos_T
        PedidosAbiertos_TL
        PedidosAbiertos_TT
        PedidosAbiertos_TX_Control
        PedidosAbiertos_TX_EstadoPedidos
        PedidosAbiertos_TX_PedidosHijos
        PedidosAbiertos_TX_PorProveedorParaCombo
        PedidosAbiertos_TX_TT
        PedidosSAT_A
        PedidosSAT_ActualizarDetalles
        PedidosSAT_M
        PedidosSAT_T
        PedidosSAT_TT
        PedidosSAT_TX_PorIdOrigen
        PedidosSAT_TX_PorIdOrigenDetalle
        PedidosSAT_TX_PorOrigen
        PedidosSAT_TXAnio
        PedidosSAT_TXFecha
        PedidosSAT_TXMes
        Planos_A
        Planos_E
        Planos_M
        Planos_T
        Planos_TL
        Planos_TT
        Planos_TX_ParaTransmitir
        Planos_TX_ParaTransmitir_Todos
        Planos_TX_SetearComoTransmitido
        Planos_TX_TT
        PlazosEntrega_A
        PlazosEntrega_E
        PlazosEntrega_M
        PlazosEntrega_T
        PlazosEntrega_TL
        PlazosEntrega_TT
        PlazosEntrega_TX_PorId
        PlazosEntrega_TX_TT
        PlazosFijos_A
        PlazosFijos_E
        PlazosFijos_M
        PlazosFijos_T
        PlazosFijos_TL
        PlazosFijos_TT
        PlazosFijos_TX_AVencer
        PlazosFijos_TX_EntreFechasParaGeneracionContable
        PlazosFijos_TX_EstructuraConFormato
        PlazosFijos_TX_ParaPosicionFinancieraAFecha
        PlazosFijos_TX_PorId
        PlazosFijos_TX_TodosSF_HastaFecha_Inicio
        PlazosFijos_TX_TT
        PlazosFijos_TX_Vencidos
        PosicionesImportacion_A
        PosicionesImportacion_E
        PosicionesImportacion_M
        PosicionesImportacion_T
        PosicionesImportacion_TL
        PosicionesImportacion_TT
        PosicionesImportacion_TX_Existente
        PosicionesImportacion_TX_TT
        Presto_SetearMovimientosComoProcesados
        Presto_TX_ParaMDB
        PresupuestoFinanciero_A
        PresupuestoFinanciero_M
        PresupuestoFinanciero_T
        PresupuestoFinanciero_TX_DetalladoPorAño
        PresupuestoFinanciero_TX_DetalladoPorAño_A
        PresupuestoFinanciero_TX_DetallePorRubroContable
        PresupuestoFinanciero_TX_Estructura
        PresupuestoFinanciero_TX_PorAño
        PresupuestoFinanciero_TX_PorIdRubroContable
        PresupuestoFinanciero_TX_PorIdRubroContableAño
        PresupuestoFinanciero_TX_PorIdRubroContableMesAño
        PresupuestoObras_A
        PresupuestoObras_Actualizar
        PresupuestoObras_ActualizarCosto
        PresupuestoObras_ActualizarTeoricos
        PresupuestoObras_ActualizarTotalPresupuesto
        PresupuestoObras_Borrar
        PresupuestoObras_BorrarBase
        PresupuestoObras_BorrarTeoricos
        PresupuestoObras_E
        PresupuestoObras_ImportarHH
        PresupuestoObras_M
        PresupuestoObras_NuevaBase
        PresupuestoObras_T
        PresupuestoObras_TX_Pedidos
        PresupuestoObras_TX_PorDestinoRubro
        PresupuestoObras_TX_PorObra
        PresupuestoObras_TX_PorObraCodigoPresupuesto
        PresupuestoObras_TX_PorObraComparativa
        PresupuestoObras_TX_PorObraComparativa_Detalles
        PresupuestoObras_TX_PorObraConsumos
        PresupuestoObras_TX_PorObraConsumos_Detalles
        PresupuestoObras_TX_PorObraConsumosParaInforme
        PresupuestoObras_TX_PorObraConsumosTeoricos_Detalles
        PresupuestoObras_TX_PorObraConsumosTeoricos_Detalles_T
        PresupuestoObras_TX_PorObraPedidos
        PresupuestoObrasConsumos_A
        PresupuestoObrasConsumos_Actualizar
        PresupuestoObrasConsumos_E
        PresupuestoObrasConsumos_M
        PresupuestoObrasConsumos_T
        PresupuestoObrasNodos_A
        PresupuestoObrasNodos_ActualizarDetalles
        PresupuestoObrasNodos_ArreglaDirectorio
        PresupuestoObrasNodos_CrearPresupuesto
        PresupuestoObrasNodos_E
        PresupuestoObrasNodos_Inicializar
        PresupuestoObrasNodos_M
        PresupuestoObrasNodos_Recalcular
        PresupuestoObrasNodos_T
        PresupuestoObrasNodos_TT
        PresupuestoObrasNodos_TX_Consumos
        PresupuestoObrasNodos_TX_DetallePxQ
        PresupuestoObrasNodos_TX_EtapasImputablesPorObraParaCombo
        PresupuestoObrasNodos_TX_ParaArbol
        PresupuestoObrasNodos_TX_ParaInforme
        PresupuestoObrasNodos_TX_PorCodigoPresupuesto
        PresupuestoObrasNodos_TX_PorItem
        PresupuestoObrasNodos_TX_PorNodo
        PresupuestoObrasNodos_TX_PorNodoPadre
        PresupuestoObrasNodos_TX_PorObraCodigoPresupuesto
        PresupuestoObrasNodos_TX_PorObraComparativa
        PresupuestoObrasNodos_TX_PorObraComparativa_Detalles
        PresupuestoObrasNodos_TX_PorObraConsumos
        PresupuestoObrasNodosConsumos_A
        PresupuestoObrasNodosConsumos_E
        PresupuestoObrasNodosConsumos_M
        PresupuestoObrasNodosConsumos_T
        PresupuestoObrasRubros_A
        PresupuestoObrasRubros_E
        PresupuestoObrasRubros_M
        PresupuestoObrasRubros_T
        PresupuestoObrasRubros_TL
        PresupuestoObrasRubros_TT
        PresupuestoObrasRubros_TX_ParaComboPorTipoConsumo
        PresupuestoObrasRubros_TX_PorDescripcion
        PresupuestoObrasRubros_TX_TT
        Presupuestos_A
        Presupuestos_E
        Presupuestos_M
        Presupuestos_T
        Presupuestos_TT
        Presupuestos_TX_AdjuntosPorPresupuesto
        Presupuestos_TX_BonificacionesPorNumero
        Presupuestos_TX_DatosRMLAPorItem
        Presupuestos_TX_Detalles
        Presupuestos_TX_DetallesPorIdPresupuesto
        Presupuestos_TX_DetallesPorIdPresupuestoAgrupados
        Presupuestos_TX_DetallesPorIdPresupuestoIdComparativa
        Presupuestos_TX_PorId
        Presupuestos_TX_PorNumero
        Presupuestos_TX_PorNumeroBis
        Presupuestos_TX_PorNumeroConDatos
        Presupuestos_TX_TT
        Presupuestos_TXAnio
        Presupuestos_TXFecha
        Presupuestos_TXMes
        Presupuestos_TXMesAnio
        PROD_Maquinas_A
        PROD_Maquinas_E
        PROD_Maquinas_M
        PROD_Maquinas_T
        PROD_Maquinas_TL
        PROD_Maquinas_TT
        PROD_Maquinas_TX_PorIdArticulo
        PROD_Maquinas_TX_TT
        PROD_TiposControlCalidad_A
        PROD_TiposControlCalidad_M
        PROD_TiposControlCalidad_T
        PROD_TiposControlCalidad_TL
        PROD_TiposControlCalidad_TT
        PROD_TiposControlCalidad_TX_TT
        ProduccionAreas_A
        ProduccionAreas_E
        ProduccionAreas_M
        ProduccionAreas_T
        ProduccionAreas_TL
        ProduccionAreas_TT
        ProduccionFicha_TX_DatosPorFicha
        ProduccionFicha_TX_PorIdParaCombo
        ProduccionFichas_A
        ProduccionFichas_ActualizarEstadoRM
        ProduccionFichas_AjustarStockSalidaMaterialesAnulada
        ProduccionFichas_E
        ProduccionFichas_M
        ProduccionFichas_T
        ProduccionFichas_TT
        ProduccionFichas_TX_ArticuloAsociado
        ProduccionFichas_TX_MaterialesPorArticuloAsociadoParaCombo
        ProduccionFichas_TX_PorId
        ProduccionFichas_TX_PorIdConDatos
        ProduccionFichas_TX_PorIdDetalle
        ProduccionFichas_TX_PorIdOrigen
        ProduccionFichas_TX_ProporcionEntreProducidoyMaterial
        ProduccionFichas_TX_TT
        ProduccionLineas_A
        ProduccionLineas_E
        ProduccionLineas_M
        ProduccionLineas_T
        ProduccionLineas_TL
        ProduccionLineas_TT
        ProduccionOrdenes_A
        ProduccionOrdenes_ActualizarEstadoRM
        ProduccionOrdenes_AjustarStockSalidaMaterialesAnulada
        ProduccionOrdenes_AnularAjustarStock
        ProduccionOrdenes_CerrarAjustarStock
        ProduccionOrdenes_E
        ProduccionOrdenes_M
        ProduccionOrdenes_T
        ProduccionOrdenes_TT
        ProduccionOrdenes_TX_AbiertasParaCombo
        ProduccionOrdenes_TX_CostosPorOP
        ProduccionOrdenes_TX_DetalleDeFicha
        ProduccionOrdenes_TX_DetalleProcesosDeFicha
        ProduccionOrdenes_TX_FiltradoPorProceso
        ProduccionOrdenes_TX_PartidasQueLoUsan
        ProduccionOrdenes_TX_PartidasUsadas
        ProduccionOrdenes_TX_PorId
        ProduccionOrdenes_TX_PorIdConDatos
        ProduccionOrdenes_TX_PorIdDetalle
        ProduccionOrdenes_TX_PorIdOrigen
        ProduccionOrdenes_TX_PorProceso
        ProduccionOrdenes_TX_Producidos
        ProduccionOrdenes_TX_SinCerrarParaCombo
        ProduccionOrdenes_TX_SinCerrarParaLista
        ProduccionOrdenes_TX_TienePartesAbiertosAsociados
        ProduccionOrdenes_TX_TieneProcesosObligatoriosSinCumplir
        ProduccionOrdenes_TX_TT
        ProduccionOrdenes_TXAnio
        ProduccionOrdenes_TXFecha
        ProduccionOrdenes_TXMes
        ProduccionParte_TX_ArticulosPorOrdenPorProcesoParaCombo
        ProduccionParte_TX_ArticulosPorOrdenPorProcesoParaComboSinFiltrarStock
        ProduccionParte_TX_PartidasDisponiblesPorOrdenProcesoParaCombo
        ProduccionPartes_A
        ProduccionPartes_M
        ProduccionPartes_T
        ProduccionPartes_TL
        ProduccionPartes_TT
        ProduccionPartes_TX_Anio
        ProduccionPartes_TX_FiltradoPorProceso
        ProduccionPartes_TX_Mes
        ProduccionPartes_TX_PorIdOrden
        ProduccionPartes_TX_PorProceso
        ProduccionPartes_TX_ProcesoAnteriorCerrado
        ProduccionPartes_TX_ProcesoAnteriorIniciado
        ProduccionPartes_TX_ProcesoAnteriorObligatorioSinRendir
        ProduccionPartes_TX_ProcesoIdenticoEnMarcha
        ProduccionPartes_TX_ProximoNumeroEsperado
        ProduccionPartes_TX_TotalProducidoporOP
        ProduccionPartes_TX_TT
        ProduccionPartes_TX_UltimoPartePorEmpleado
        ProduccionPartes_TXAnio
        ProduccionPartes_TXFecha
        ProduccionPartes_TXMes
        ProduccionPlanes_A
        ProduccionPlanes_E
        ProduccionPlanes_M
        ProduccionPlanes_T
        ProduccionPlanes_TL
        ProduccionPlanes_TT
        ProduccionPlanes_TX_Periodo
        ProduccionProcesos_A
        ProduccionProcesos_E
        ProduccionProcesos_M
        ProduccionProcesos_T
        ProduccionProcesos_TL
        ProduccionProcesos_TT
        ProduccionProcesos_TX_IncorporanMaterialParaCombo
        ProduccionProcesos_TX_TT
        ProduccionProgRecursos_A
        ProduccionProgRecursos_E
        ProduccionProgRecursos_M
        ProduccionProgRecursos_T
        ProduccionProgRecursos_TL
        ProduccionProgRecursos_TT
        ProduccionSectores_A
        ProduccionSectores_E
        ProduccionSectores_M
        ProduccionSectores_T
        ProduccionSectores_TL
        ProduccionSectores_TT
        ProntoIni_Actualizar
        ProntoIni_Eliminar
        ProntoIni_T
        ProntoIni_TX_PorClave
        ProntoIni_TX_T
        ProntoIni_TX_Todo
        ProntoIniClaves_Actualizar
        ProntoIniClaves_Eliminar
        ProntoIniClaves_T
        ProntoIniClaves_TX_PorClave
        ProntoIniClaves_TX_Todo
        ProntoMantenimiento_TX_OTsPorEquipo
        ProntoMantenimiento_TX_VerificarArticulo
        ProntoWeb_CargaComprobantes
        ProntoWeb_CargaOrdenesPagoEnCaja
        ProntoWeb_CargaTablas
        ProntoWeb_CargaTodosLosUsuarios
        ProntoWeb_CertificadoGanancias_DatosPorIdOrdenPago
        ProntoWeb_CertificadoIIBB_DatosPorIdOrdenPago
        ProntoWeb_CertificadoRetencionIVA_DatosPorIdOrdenPago
        ProntoWeb_CertificadoSUSS_DatosPorIdOrdenPago
        ProntoWeb_DebeHaberSaldo
        ProntoWeb_OrdenesPagoEnCaja
        ProntoWeb_TodosLosUsuarios
        Proveedores_A
        Proveedores_ActualizarDatosIIBB
        Proveedores_BorrarEmbargos
        Proveedores_E
        Proveedores_EstadoInicialImpositivo
        Proveedores_M
        Proveedores_T
        Proveedores_TL
        Proveedores_TT
        Proveedores_TX_AConfirmar
        Proveedores_TX_Busca
        Proveedores_TX_Busca_NormalesYEventualesParaCombo
        Proveedores_TX_Busca1
        Proveedores_TX_CITI
        Proveedores_TX_Comprobantes
        Proveedores_TX_Comprobantes_Modelo2
        Proveedores_TX_ConDatos
        Proveedores_TX_Contactos
        Proveedores_TX_ControlPorCodigoEmpresa
        Proveedores_TX_Emails
        Proveedores_TX_Eventuales
        Proveedores_TX_EventualesParaCombo
        Proveedores_TX_Fax
        Proveedores_TX_NormalesYEventualesParaCombo
        Proveedores_TX_ParaTransmitir
        Proveedores_TX_ParaTransmitir_Todos
        Proveedores_TX_PercepcionesIIBB
        Proveedores_TX_PercepcionesIIBB_SIRCREB
        Proveedores_TX_PercepcionesIVA
        Proveedores_TX_PorCodigo
        Proveedores_TX_PorCodigoEmpresa
        Proveedores_TX_PorCodigoPresto
        Proveedores_TX_PorCodigoSAP
        Proveedores_TX_PorCodigoSAPParaCombo
        Proveedores_TX_PorCuit
        Proveedores_TX_PorCuitNoEventual
        Proveedores_TX_PorCuitParcial
        Proveedores_TX_PorId
        Proveedores_TX_PorRubrosProvistos
        Proveedores_TX_RankingCompras
        Proveedores_TX_ResumenCompras
        Proveedores_TX_Resumido
        Proveedores_TX_RetencionesGanancias
        Proveedores_TX_RetencionesIIBB
        Proveedores_TX_RetencionesIIBB_DatosProveedores
        Proveedores_TX_RetencionesIVA
        Proveedores_TX_SetearComoTransmitido
        Proveedores_TX_SICORE
        Proveedores_TX_SoloCuit
        Proveedores_TX_SUSS
        Proveedores_TX_TodosParaCombo
        Proveedores_TX_TT
        Proveedores_TX_TT_Eventual
        Proveedores_TX_UnRegistroResumen
        Proveedores_TX_ValidarPorCuit
        ProveedoresRubros_A
        ProveedoresRubros_E
        ProveedoresRubros_M
        ProveedoresRubros_T
        ProveedoresRubros_TT
        ProveedoresRubros_TX_TT
        ProveedoresRubros_TXPrimero
        ProveedoresRubros_TXProv
        Provincias_A
        Provincias_E
        Provincias_M
        Provincias_T
        Provincias_TL
        Provincias_TT
        Provincias_TX_ParaTransmitir
        Provincias_TX_ParaTransmitir_Todos
        Provincias_TX_PorId
        Provincias_TX_PorNombre
        Provincias_TX_SetearComoTransmitido
        Provincias_TX_TT
        PuntosVenta_A
        PuntosVenta_E
        PuntosVenta_M
        PuntosVenta_T
        PuntosVenta_TL
        PuntosVenta_TT
        PuntosVenta_TX_Duplicados
        PuntosVenta_TX_PorId
        PuntosVenta_TX_PorIdTipoComprobante
        PuntosVenta_TX_PorIdTipoComprobantePuntoVenta
        PuntosVenta_TX_PuntosVentaPorIdTipoComprobanteLetra
        PuntosVenta_TX_PuntosVentaTodos
        PuntosVenta_TX_TT
        Rangos_A
        Rangos_E
        Rangos_M
        Rangos_T
        Rangos_TL
        Rangos_TT
        Rangos_TX_TT
        Recepciones_A
        Recepciones_ActualizarDetalles
        Recepciones_ActualizarEstadoPedidos
        Recepciones_AjustarStockRecepcionAnulada
        Recepciones_E
        Recepciones_M
        Recepciones_MarcarComoProcesadoCP
        Recepciones_T
        Recepciones_TT
        Recepciones_TX_ComprobantesProveedoresPorIdRecepcion
        Recepciones_TX_DatosPorIdDetalleRecepcion
        Recepciones_TX_DetallesParaBienesDeUso
        Recepciones_TX_DetallesParaComprobantesProveedores
        Recepciones_TX_DetallesPorIdRecepcion
        Recepciones_TX_EntreFechas
        Recepciones_TX_MaterialesRecibidos
        Recepciones_TX_MaterialesRecibidosAprobados
        Recepciones_TX_MaterialesRecibidosDatosTransporte
        Recepciones_TX_PendientesDeComprobante
        Recepciones_TX_PendientesDeComprobanteDetallado
        Recepciones_TX_PendientesPorIdDetalle
        Recepciones_TX_PorId
        Recepciones_TX_PorIdOrigen
        Recepciones_TX_PorIdOrigenDetalle
        Recepciones_TX_PorNumeroInterno
        Recepciones_TX_Todos
        Recepciones_TX_TT
        Recepciones_TX_Ultimos3Meses
        Recepciones_TX_xNro
        Recepciones_TX_xNroLetra
        Recepciones_TXAnio
        Recepciones_TXFecha
        Recepciones_TXMes
        RecepcionesSAT_A
        RecepcionesSAT_ActualizarDetalles
        RecepcionesSAT_M
        RecepcionesSAT_T
        RecepcionesSAT_TT
        RecepcionesSAT_TX_EntreFechas
        RecepcionesSAT_TX_PorIdOrigen
        RecepcionesSAT_TX_PorIdOrigenDetalle
        RecepcionesSAT_TXAnio
        RecepcionesSAT_TXFecha
        RecepcionesSAT_TXMes
        Recibos_A
        Recibos_ActualizarDetalles
        Recibos_E
        Recibos_M
        Recibos_T
        Recibos_TT
        Recibos_TX_AnalisisCobranzas
        Recibos_TX_CajaIngresos
        Recibos_TX_EntreFechasParaGeneracionContable
        Recibos_TX_LoteSublote
        Recibos_TX_ParaTransmitir
        Recibos_TX_PorCobrador
        Recibos_TX_PorEstadoValores
        Recibos_TX_PorId
        Recibos_TX_PorIdOrigen
        Recibos_TX_PorIdOrigenDetalle
        Recibos_TX_PorIdOrigenDetalleCuentas
        Recibos_TX_PorIdOrigenDetalleRubrosContables
        Recibos_TX_PorIdOrigenDetalleValores
        Recibos_TX_PorIdPuntoVenta_Numero
        Recibos_TX_PorServicioCobro
        Recibos_TX_SetearComoTransmitido
        Recibos_TX_TodosSF_HastaFecha
        Recibos_TX_TT
        Recibos_TX_ValoresEnConciliacionesPorIdRecibo
        Recibos_TXAnio
        Recibos_TXCod
        Recibos_TXFecha
        Recibos_TXMes
        Recibos_TXMesAnio
        Recibos_TXRecibosxAnio
        Relaciones_A
        Relaciones_E
        Relaciones_M
        Relaciones_T
        Relaciones_TL
        Relaciones_TT
        Relaciones_TX_TT
        Remitos_A
        Remitos_AjustarStockRemitoAnulado
        Remitos_E
        Remitos_M
        Remitos_T
        Remitos_TT
        Remitos_TX_DetalladoPorFechas
        Remitos_TX_DetallesPendientesDeFacturarPorIdCliente
        Remitos_TX_DetallesPendientesDeFacturarPorIdDetalleOrdenCompra
        Remitos_TX_DetallesPorIdRemito
        Remitos_TX_FacturasPorIdRemito
        Remitos_TX_ItemsPendientesDeFacturar
        Remitos_TX_ItemsPendientesDeFacturarPorFechaCliente
        Remitos_TX_OrdenCompraPorIdRemito
        Remitos_TX_PorId
        Remitos_TX_TT
        Remitos_TXAnio
        Remitos_TXFecha
        Remitos_TXMes
        REP_COTIZACION_MARK
        REP_COTIZACION_SEL
        REP_CTAPRO_MARK
        REP_CTAPRO_SEL
        REP_CUENTAS
        REP_IMPUTAC_MARK
        REP_IMPUTAC_SEL
        REP_OBRAS
        REP_PROVEEDO_MARK
        REP_PROVEEDO_SEL
        Requerimientos_A
        Requerimientos_ActualizarDetalles
        Requerimientos_ActualizarEstado
        Requerimientos_AnularItem
        Requerimientos_E
        Requerimientos_EliminarRequerimientosAConfirmar
        Requerimientos_M
        Requerimientos_RegistrarImpresion
        Requerimientos_T
        Requerimientos_TT
        Requerimientos_TX_AConfirmar
        Requerimientos_TX_ALiberar
        Requerimientos_TX_Cumplidos
        Requerimientos_TX_DadosPorCumplidos
        Requerimientos_TX_DatosObra
        Requerimientos_TX_DatosRequerimiento
        Requerimientos_TX_DesarrolloItems1
        Requerimientos_TX_DesarrolloItems2
        Requerimientos_TX_EntregasConcretadas
        Requerimientos_TX_ItemsPorObra
        Requerimientos_TX_ItemsPorObra1
        Requerimientos_TX_ItemsPorObra2
        Requerimientos_TX_ItemsPorObra3
        Requerimientos_TX_Pendientes
        Requerimientos_TX_Pendientes1
        Requerimientos_TX_PendientesDeAsignacion
        Requerimientos_TX_PendientesDeFirma
        Requerimientos_TX_PendientesPlaneamiento
        Requerimientos_TX_PendientesPorIdRM
        Requerimientos_TX_PendientesPorRM
        Requerimientos_TX_PendientesPorRM1
        Requerimientos_TX_PendientesPorSolicitud
        Requerimientos_TX_PorCC
        Requerimientos_TX_PorDetLmat
        Requerimientos_TX_PorId
        Requerimientos_TX_PorIdObra
        Requerimientos_TX_PorIdOrigen
        Requerimientos_TX_PorIdOrigenDetalle
        Requerimientos_TX_PorIdSectorFecha
        Requerimientos_TX_PorNumero
        Requerimientos_TX_PorObra
        Requerimientos_TX_PorPRESTOContrato
        Requerimientos_TX_SinControl
        Requerimientos_TX_SinFechaNecesidad
        Requerimientos_TX_Sumarizadas
        Requerimientos_TX_TodosLosDetalles
        Requerimientos_TX_TodosPorIdSector
        Requerimientos_TX_TT
        Requerimientos_TX_ValidarNumero
        Requerimientos_TXAnio
        Requerimientos_TXFecha
        Requerimientos_TXMes
        Requerimientos_TXPorNumeroObra
        Requerimientos_TXPorObra
        Reservas_A
        Reservas_E
        Reservas_Generar
        Reservas_M
        Reservas_T
        Reservas_TT
        Reservas_TX_DesdeDetalle
        Reservas_TX_PorObra
        Reservas_TX_Reservar
        Reservas_TX_Reservar_Acopios
        Reservas_TX_Reservar_PorObra
        Reservas_TX_Reservar_RM
        Reservas_TX_Sumarizadas
        Reservas_TX_Todas
        Reservas_TX_TT
        Revaluos_A
        Revaluos_E
        Revaluos_M
        Revaluos_T
        Revaluos_TL
        Revaluos_TT
        Revaluos_TX_TT
        Rubros_A
        Rubros_E
        Rubros_M
        Rubros_T
        Rubros_TL
        Rubros_TT
        Rubros_TX_ParaTransmitir
        Rubros_TX_ParaTransmitir_Todos
        Rubros_TX_PorId
        Rubros_TX_SetearComoTransmitido
        Rubros_TX_TT
        RubrosContables_A
        RubrosContables_E
        RubrosContables_M
        RubrosContables_T
        RubrosContables_TL
        RubrosContables_TT
        RubrosContables_TX_EntreFechas
        RubrosContables_TX_Financieros
        RubrosContables_TX_ParaCombo
        RubrosContables_TX_ParaComboFinancierosEgresos
        RubrosContables_TX_ParaComboFinancierosIngresos
        RubrosContables_TX_ParaComboFinancierosTodos
        RubrosContables_TX_ParaGastosPorObra
        RubrosContables_TX_PorCodigo
        RubrosContables_TX_PorId
        RubrosContables_TX_TT
        RubrosContables_TX_TT_Financieros
        RubrosValores_A
        RubrosValores_E
        RubrosValores_M
        RubrosValores_T
        RubrosValores_TL
        RubrosValores_TT
        RubrosValores_TX_TT
        SalidasMateriales_A
        SalidasMateriales_ActualizarDetalles
        SalidasMateriales_ActualizarEstadoRM
        SalidasMateriales_AjustarStockSalidaMaterialesAnulada
        SalidasMateriales_E
        SalidasMateriales_M
        SalidasMateriales_T
        SalidasMateriales_TT
        SalidasMateriales_TX_ControlarParteDiarioEquipoDestino
        SalidasMateriales_TX_DatosPorIdDetalle
        SalidasMateriales_TX_DatosTransporte
        SalidasMateriales_TX_DetalladoPorFechas
        SalidasMateriales_TX_DetallesParametrizados
        SalidasMateriales_TX_DetallesPorNumero
        SalidasMateriales_TX_EntreFechas
        SalidasMateriales_TX_OTsOPs
        SalidasMateriales_TX_ParaTransmitir
        SalidasMateriales_TX_PendientesSAT
        SalidasMateriales_TX_PorId
        SalidasMateriales_TX_PorIdDetalle
        SalidasMateriales_TX_PorIdOrdenTrabajo_TipoSalida
        SalidasMateriales_TX_PorIdOrigen
        SalidasMateriales_TX_PorIdOrigenDetalle
        SalidasMateriales_TX_Recepciones_y_Envios
        SalidasMateriales_TX_SetearComoTransmitido
        SalidasMateriales_TX_Todas
        SalidasMateriales_TX_Todos
        SalidasMateriales_TX_TraerVale
        SalidasMateriales_TX_TT
        SalidasMateriales_TX_TT_DetallesParametrizados
        SalidasMateriales_TXAnio
        SalidasMateriales_TXFecha
        SalidasMateriales_TXMes
        SalidasMaterialesSAT_A
        SalidasMaterialesSAT_ActualizarDetalles
        SalidasMaterialesSAT_M
        SalidasMaterialesSAT_T
        SalidasMaterialesSAT_TX_PorIdOrigen
        SalidasMaterialesSAT_TX_PorIdOrigenDetalle
        SalidasMaterialesSAT_TX_Todas
        SalidasMaterialesSAT_TXAnio
        SalidasMaterialesSAT_TXFecha
        SalidasMaterialesSAT_TXMes
        Schedulers_A
        Schedulers_E
        Schedulers_M
        Schedulers_T
        Schedulers_TL
        Schedulers_TT
        Schedulers_TX_TT
        Sectores_A
        Sectores_E
        Sectores_M
        Sectores_T
        Sectores_TL
        Sectores_TT
        Sectores_TX_ParaHH
        Sectores_TX_ParaHH1
        Sectores_TX_ParaTransmitir
        Sectores_TX_ParaTransmitir_Todos
        Sectores_TX_PorDescripcion
        Sectores_TX_PorId
        Sectores_TX_SetearComoTransmitido
        Sectores_TX_SinSectorOrigen
        Sectores_TX_TT
        Series_A
        Series_E
        Series_M
        Series_T
        Series_TL
        Series_TT
        Series_TX_TT
        SiNo_T
        SiNo_TL
        SiNo_TT
        SiNo_TX_TT
        SISTEMA_TX_1
        SolicitudesCompra_A
        SolicitudesCompra_E
        SolicitudesCompra_M
        SolicitudesCompra_T
        SolicitudesCompra_TT
        SolicitudesCompra_TX_TT
        SolicitudesCompra_TXAnio
        SolicitudesCompra_TXFecha
        SolicitudesCompra_TXMes
        Stock_A
        Stock_ActualizarDesdeSAT
        Stock_M
        Stock_TX_CompletoPorArticulo
        Stock_TX_Control_Reposicion_Minimo
        Stock_TX_ControlContraCardex
        Stock_TX_ExistenciaPorArticulo
        Stock_TX_ExistenciaPorIdArticulo
        Stock_TX_PartidasDisponibles
        Stock_TX_PorIdArticuloUbicacion
        Stock_TX_PorNumeroCaja
        Stock_TX_RegistrosConStockDisponiblePorIdArticulo
        Stock_TX_RegistrosConStockNegativo
        Stock_TX_STK
        Subcontratos_A
        Subcontratos_ActualizarDetalles
        Subcontratos_E
        Subcontratos_M
        Subcontratos_Recalcular
        Subcontratos_T
        Subcontratos_TT
        Subcontratos_TX_Consumos
        Subcontratos_TX_DatosParaCombo
        Subcontratos_TX_DetallePxQ
        Subcontratos_TX_EtapasConConsumos
        Subcontratos_TX_EtapasParaCombo
        Subcontratos_TX_HojaRuta
        Subcontratos_TX_Ordenado
        Subcontratos_TX_ParaArbol
        Subcontratos_TX_PorNodo
        Subcontratos_TX_PorNodoPadre
        Subcontratos_TX_PorNumeroSubcontrato
        Subcontratos_TX_TT
        SubcontratosDatos_A
        SubcontratosDatos_M
        SubcontratosDatos_TX_PorNumeroSubcontrato
        Subdiarios_A
        Subdiarios_ActualizarComprobantes
        Subdiarios_BorrarComprasEntreFechas
        Subdiarios_BorrarEntreFechas
        Subdiarios_E
        Subdiarios_M
        Subdiarios_T
        Subdiarios_TT
        Subdiarios_TX_AgrupadosPorMesAño
        Subdiarios_TX_Estructura
        Subdiarios_TX_ParaTransmitir
        Subdiarios_TX_PorId
        Subdiarios_TX_PorIdComprobante
        Subdiarios_TX_PorIdOrigen
        Subdiarios_TX_ResumenPorIdCuentaSubdiario
        Subdiarios_TX_SetearComoTransmitido
        Subdiarios_TX_TodosSF_HastaFecha
        Subdiarios_TX_TotalesPorIdCuentaSubdiario
        Subdiarios_TX_TT
        Subdiarios_TXAnio
        Subdiarios_TXFecha
        Subdiarios_TXMes
        Subdiarios_TXSub
        Subrubros_A
        Subrubros_E
        Subrubros_M
        Subrubros_T
        Subrubros_TL
        Subrubros_TT
        Subrubros_TX_ParaTransmitir
        Subrubros_TX_ParaTransmitir_Todos
        Subrubros_TX_PorId
        Subrubros_TX_SetearComoTransmitido
        Subrubros_TX_TT
        Tareas_A
        Tareas_E
        Tareas_M
        Tareas_T
        Tareas_TL
        Tareas_TT
        Tareas_TX_PorId
        Tareas_TX_PorTipo
        Tareas_TX_PorTipoParaCombo
        Tareas_TX_TareasPorEquipo
        Tareas_TX_TareasPorEquipoSector
        Tareas_TX_TT
        TareasFijas_A
        TareasFijas_E
        TareasFijas_M
        TareasFijas_T
        TareasFijas_TT
        TareasFijas_TX_TT
        TarifasFletes_A
        TarifasFletes_E
        TarifasFletes_M
        TarifasFletes_T
        TarifasFletes_TL
        TarifasFletes_TT
        TarifasFletes_TX_TT
        TarjetasCredito_A
        TarjetasCredito_E
        TarjetasCredito_M
        TarjetasCredito_T
        TarjetasCredito_TL
        TarjetasCredito_TT
        TarjetasCredito_TX_PorId
        TarjetasCredito_TX_TT
        Tipos_A
        Tipos_E
        Tipos_M
        Tipos_T
        Tipos_TL
        Tipos_TT
        Tipos_TX_PorGrupo
        Tipos_TX_PorGrupoParaCombo
        Tipos_TX_TT
        Tipos_TX_TT_PorGrupo
        TiposCompra_TX_ParaCombo
        TiposCompra_TX_PorId
        TiposComprobante_A
        TiposComprobante_E
        TiposComprobante_M
        TiposComprobante_ModificarNumerador
        TiposComprobante_T
        TiposComprobante_TL
        TiposComprobante_TT
        TiposComprobante_TX_Buscar
        TiposComprobante_TX_ParaComboGastosBancarios
        TiposComprobante_TX_ParaComboProveedores
        TiposComprobante_TX_ParaComboVentas
        TiposComprobante_TX_PorAbreviatura
        TiposComprobante_TX_PorId
        TiposComprobante_TX_TT
        TiposCuenta_TL
        TiposCuentaGrupos_A
        TiposCuentaGrupos_ActualizarAjusteASubdiarios
        TiposCuentaGrupos_E
        TiposCuentaGrupos_M
        TiposCuentaGrupos_T
        TiposCuentaGrupos_TL
        TiposCuentaGrupos_TT
        TiposCuentaGrupos_TX_TT
        TiposEquipo_TL
        TiposImpuesto_TL
        TiposPoliza_TL
        TiposPoliza_TX_PorId
        TiposRetencionGanancia_A
        TiposRetencionGanancia_E
        TiposRetencionGanancia_M
        TiposRetencionGanancia_T
        TiposRetencionGanancia_TL
        TiposRetencionGanancia_TT
        TiposRetencionGanancia_TX_MaximoId
        TiposRetencionGanancia_TX_PorId
        TiposRetencionGanancia_TX_TT
        TiposRosca_A
        TiposRosca_E
        TiposRosca_M
        TiposRosca_T
        TiposRosca_TL
        TiposRosca_TT
        TiposRosca_TX_TT
        TiposValor_TL
        Titulos_TL
        Titulos_TX_PorId
        Traducciones_A
        Traducciones_E
        Traducciones_M
        Traducciones_T
        Traducciones_TT
        Traducciones_TX_TodosSinFormato
        Traducciones_TX_TT
        Transportistas_A
        Transportistas_E
        Transportistas_M
        Transportistas_T
        Transportistas_TL
        Transportistas_TT
        Transportistas_TX_ConDatos
        Transportistas_TX_ParaTransmitir
        Transportistas_TX_ParaTransmitir_Todos
        Transportistas_TX_PorId
        Transportistas_TX_SetearComoTransmitido
        Transportistas_TX_TT
        TTermicos_A
        TTermicos_E
        TTermicos_M
        TTermicos_T
        TTermicos_TL
        TTermicos_TT
        TTermicos_TX_TT
        Ubicaciones_A
        Ubicaciones_E
        Ubicaciones_M
        Ubicaciones_T
        Ubicaciones_TL
        Ubicaciones_TT
        Ubicaciones_TX_AbreviadoParaCombo
        Ubicaciones_TX_ParaTransmitir
        Ubicaciones_TX_PorId
        Ubicaciones_TX_PorObra
        Ubicaciones_TX_TT
        Unidades_A
        Unidades_E
        Unidades_M
        Unidades_T
        Unidades_TL
        Unidades_TT
        Unidades_TX_ParaTransmitir_Todos
        Unidades_TX_PorAbreviatura
        Unidades_TX_PorId
        Unidades_TX_TT
        UnidadesEmpaque_A
        UnidadesEmpaque_E
        UnidadesEmpaque_M
        UnidadesEmpaque_T
        UnidadesEmpaque_TT
        UnidadesEmpaque_TX_NetoPorPartidaConsolidada
        UnidadesEmpaque_TX_PorNumero
        UnidadesEmpaque_TX_TT
        UnidadesOperativas_A
        UnidadesOperativas_E
        UnidadesOperativas_M
        UnidadesOperativas_T
        UnidadesOperativas_TL
        UnidadesOperativas_TT
        UnidadesOperativas_TX_ParaTransmitir
        UnidadesOperativas_TX_ParaTransmitir_Todos
        UnidadesOperativas_TX_SetearComoTransmitido
        UnidadesOperativas_TX_TT
        ValesSalida_A
        ValesSalida_ActualizarDetalles
        ValesSalida_ActualizarEstado
        ValesSalida_AsignarEntrega
        ValesSalida_E
        ValesSalida_M
        ValesSalida_T
        ValesSalida_TT
        ValesSalida_TX_DetalladoPorFechas
        ValesSalida_TX_DetallesParametrizados
        ValesSalida_TX_DetallesPorIdValeSalida
        ValesSalida_TX_ItemsPorObra
        ValesSalida_TX_ItemsPorObra1
        ValesSalida_TX_ItemsPorObra2
        ValesSalida_TX_ItemsPorObra3
        ValesSalida_TX_PendientesDetallado
        ValesSalida_TX_PendientesResumido
        ValesSalida_TX_PorId
        ValesSalida_TX_PorIdOrigen
        ValesSalida_TX_PorIdOrigenDetalle
        ValesSalida_TX_SalidasPorIdValeSalida
        ValesSalida_TX_Todos
        ValesSalida_TX_TodosLosItems
        ValesSalida_TX_TT
        ValesSalida_TX_TT_DetallesParametrizados
        ValesSalida_TXAnio
        ValesSalida_TXFecha
        ValesSalida_TXMes
        Valores_A
        Valores_ActualizarComprobantes
        Valores_BorrarDepositoEfectivo
        Valores_BorrarPorIdDetalleAsiento
        Valores_BorrarPorIdDetalleComprobanteProveedor
        Valores_BorrarPorIdDetalleNotaCredito
        Valores_BorrarPorIdDetalleNotaDebito
        Valores_BorrarPorIdDetalleOrdenPagoCuentas
        Valores_BorrarPorIdDetalleOrdenPagoValores
        Valores_BorrarPorIdDetalleReciboCuentas
        Valores_BorrarPorIdDetalleReciboValores
        Valores_BorrarPorIdPlazoFijo
        Valores_BorrarPorIdPlazoFijoFin
        Valores_DesmarcarComoEmitido
        Valores_DesmarcarConciliacion
        Valores_DesmarcarConfirmacion
        Valores_E
        Valores_M
        Valores_MarcarComoConciliado
        Valores_MarcarComoConfirmado
        Valores_MarcarComoEmitido
        Valores_ModificarBeneficiario
        Valores_T
        Valores_TT
        Valores_TX_ADepositar
        Valores_TX_CajasConMovimientos
        Valores_TX_CajasConMovimientosPorAnio
        Valores_TX_CajasConMovimientosPorAnioMes
        Valores_TX_ChequesPendientes
        Valores_TX_DatosParaEmisionDeCheque
        Valores_TX_DepositadosNoAcreditadosAFecha
        Valores_TX_DepositoDelValorPorIdDetalleReciboValores
        Valores_TX_EmitidosNoAcreditadosAFecha
        Valores_TX_EnCartera
        Valores_TX_EnCarteraAFecha
        Valores_TX_EntreFechasSoloGastos
        Valores_TX_GastosEntreFechas
        Valores_TX_GastosPorAnio
        Valores_TX_GastosPorAnioMes
        Valores_TX_GastosPorIdConDatos
        Valores_TX_Headers
        Valores_TX_MovimientosPorIdCaja
        Valores_TX_MovimientosPorIdTarjetaCredito
        Valores_TX_NoEmitidosPorCuenta
        Valores_TX_OtrosIngresos
        Valores_TX_OtrosIngresosEntreFecha
        Valores_TX_ParaTransmitir
        Valores_TX_PorBancoAgrupado
        Valores_TX_PorId
        Valores_TX_PorIdCuentaBancariaNumeroValor
        Valores_TX_PorIdDetalleAsiento
        Valores_TX_PorIdDetalleComprobanteProveedor
        Valores_TX_PorIdDetalleNotaCredito
        Valores_TX_PorIdDetalleNotaDebito
        Valores_TX_PorIdDetalleOrdenPagoCuentas
        Valores_TX_PorIdDetalleOrdenPagoValores
        Valores_TX_PorIdDetalleReciboCuentas
        Valores_TX_PorIdDetalleReciboValores
        Valores_TX_PorIdOrigen
        Valores_TX_PorIdPlazoFijoFin
        Valores_TX_PorIdPlazoFijoInicio
        Valores_TX_PorNumero
        Valores_TX_PorNumeroInterno
        Valores_TX_PorNumeroValorIdBanco
        Valores_TX_Resolucion1547
        Valores_TX_SetearComoTransmitido
        Valores_TX_Struc
        Valores_TX_TarjetasConMovimientos
        Valores_TX_TarjetasConMovimientosPorAnio
        Valores_TX_TarjetasConMovimientosPorAnioMes
        Valores_TX_TodosEmitidos
        Valores_TX_TodosNoEmitidos
        Valores_TX_TodosSF_HastaFecha_DebitosYCreditos
        Valores_TX_TT
        Valores_TX_TT_OtrosIngresos
        Valores_TX_VencidosAFecha
        Valores_TXAnio
        Valores_TXFecha
        Valores_TXFecha1
        Valores_TXMes
        Valores_TXMes1
        ValoresIngresos_A
        ValoresIngresos_E
        ValoresIngresos_M
        ValoresIngresos_T
        ValoresIngresos_TT
        ValoresIngresos_TX_PorDatos
        ValoresIngresos_TX_TT
        ValoresIngresos_TXAnio
        ValoresIngresos_TXFecha
        ValoresIngresos_TXMes
        Vendedores_A
        Vendedores_E
        Vendedores_M
        Vendedores_T
        Vendedores_TL
        Vendedores_TT
        Vendedores_TX_PorCodigo
        Vendedores_TX_PorCuit
        Vendedores_TX_PorNombre
        Vendedores_TX_PorUsuario
        Vendedores_TX_TT
        Vendedores_TXCod
        VentasEnCuotas_A
        VentasEnCuotas_AnulacionDePago
        VentasEnCuotas_E
        VentasEnCuotas_Eliminar
        VentasEnCuotas_M
        VentasEnCuotas_ModificarVencimientos
        VentasEnCuotas_RegistrarIdNotaDebitoEnDetalle
        VentasEnCuotas_T
        VentasEnCuotas_TT
        VentasEnCuotas_TX_CuotasAGenerar
        VentasEnCuotas_TX_CuotasCobradasAgrupadasPorBancoFecha
        VentasEnCuotas_TX_CuotasGeneradas_UnNumero
        VentasEnCuotas_TX_CuotasGeneradasAgrupadasPorNumero
        VentasEnCuotas_TX_CuotasGeneradasDetalladasPorNumero
        VentasEnCuotas_TX_CuotasGeneradasParaModificarVencimientos
        VentasEnCuotas_TX_CuotasPorIdOperacion
        VentasEnCuotas_TX_CuotasPorIdVentaEnCuotas
        VentasEnCuotas_TX_DatosPorIdDetalleVentaEnCuotas
        VentasEnCuotas_TX_DetallesPorIdVentaEnCuotasYCuota
        VentasEnCuotas_TX_NotasDebitoGeneradasPorIdVentaEnCuotas
        VentasEnCuotas_TX_PorId
        VentasEnCuotas_TX_PorIdCliente
        VentasEnCuotas_TX_PorIdClienteParaCombo
        VentasEnCuotas_TX_TT
        ViasPago_A
        ViasPago_E
        ViasPago_M
        ViasPago_T
        ViasPago_TL
        ViasPago_TT
        ViasPago_TX_TT
        wActividadesProveedores_TL
        wArticulos_A
        wArticulos_E
        wArticulos_PorCodigo
        wArticulos_PorId
        wArticulos_T
        wArticulos_TL
        wArticulos_TX_Busqueda
        wCartasDePorte_E
        wClientes_TT
        wClientes_TX_Busqueda
        wComparativas_A
        wComparativas_E
        wComparativas_T
        wComparativas_TL
        wComprobantesProveedores_A
        wComprobantesProveedores_E
        wComprobantesProveedores_T
        wComprobantesProveedores_TX_FondosFijos
        wComprobantesProveedores_TX_UltimoComprobantePorIdProveedor
        wCondicionesCompra_TL
        wCotizaciones_TX_PorFechaMoneda
        wCtasCtesA_TXPorMayorParaInfoProv
        wCuentas_TL
        wCuentas_TX_CuentasGastoPorObraParaCombo
        wCuentas_TX_FondosFijos
        wCuentas_TX_PorCodigo
        wCuentas_TX_PorId
        wCuentas_TX_PorObraCuentaGasto
        wCuentasGastos_TL
        wDescripcionIva_TL
        wDetComparativas_A
        wDetComparativas_E
        wDetComparativas_T
        wDetComparativas_TT
        wDetComprobantesProveedores_A
        wDetComprobantesProveedores_E
        wDetComprobantesProveedores_T
        wDetComprobantesProveedores_TT
        wDetComprobantesProveedoresPrv_A
        wDetComprobantesProveedoresPrv_E
        wDetComprobantesProveedoresPrv_T
        wDetOrdenesCompra_T
        wDetPedidos_A
        wDetPedidos_E
        wDetPedidos_T
        wDetPedidos_TT
        wDetPresupuestos_A
        wDetPresupuestos_E
        wDetPresupuestos_T
        wDetPresupuestos_TT
        wDetProveedoresContactos_A
        wDetProveedoresContactos_E
        wDetProveedoresContactos_T
        wDetProveedoresContactos_TT
        wDetRemitos_A
        wDetRemitos_M
        wDetRequerimientos_A
        wDetRequerimientos_E
        wDetRequerimientos_T
        wDetRequerimientos_TT
        wEmpleados_A
        wEmpleados_E
        wEmpleados_T
        wEmpleados_TL
        wEmpleados_TX_UsuarioNT
        wEstadosProveedores_TL
        wFacturas_A
        wFacturas_M
        wFacturas_TT
        wFondosFijos_A
        wFondosFijos_E
        wFondosFijos_T
        wFondosFijos_TX_RendicionesPorIdCuentaParaCombo
        wFondosFijos_TX_ResumenPorIdCuenta
        wIBCondiciones_TL
        wImpuestosDirectos_TL
        wLocalidades_E
        wLocalidades_T
        wLocalidades_TL
        wLocalidades_TX_Busqueda
        wMonedas_TL
        wNotasCredito_TT
        wObras_A
        wObras_E
        wObras_T
        wObras_TL
        wObras_TX_DestinosParaComboPorIdObra
        wObras_TX_PorIdCuentaFFParaCombo
        wOrdenesCompra_TX_DetallesPendientesDeFacturarPorIdCliente
        wOrdenesCompra_TX_ItemsPendientesDeRemitirPorIdCliente
        wOrdenesPago_TX_EnCajaPorProveedor
        wPaises_A
        wPaises_E
        wPaises_T
        wPaises_TL
        wParametros_T
        wPedidos_A
        wPedidos_E
        wPedidos_T
        wPedidos_T_ByEmployee
        wPlazosEntrega_TL
        wPresupuestos_A
        wPresupuestos_E
        wPresupuestos_T
        wPresupuestos_TX_PorNumero
        wProveedores_A
        wProveedores_E
        wProveedores_T
        wProveedores_TL
        wProveedores_TX_Busqueda
        wProveedores_TX_PorCuit
        wProvincias_A
        wProvincias_E
        wProvincias_T
        wProvincias_TL
        wRemitos_A
        wRemitos_M
        wRemitos_TT
        wRequerimientos_A
        wRequerimientos_E
        wRequerimientos_N
        wRequerimientos_T
        wRequerimientos_T_ByEmployee
        wRequerimientos_TX_PendientesDeAsignacion
        wRubros_A
        wRubros_E
        wRubros_T
        wRubros_TL
        wSectores_TL
        wSubrubros_A
        wSubrubros_E
        wSubrubros_T
        wSubrubros_TL
        wTablasGenerales_ParaCombo
        wTiposComprobante_TX_ParaComboProveedores
        wTiposRetencionGanancia_TL
        wUnidades_TL
        wRequerimientos_TXFecha

        OrdenesCompra_TX_ImputadasConOrdenesDeProduccion
    End Enum















Function TraerRsConEmpleadosConCargoDeSupervisor(ByRef app As Aplicacion) As Recordset
    'traer los procesos pendientes
    'como hago para q los q tienen articulo asociado aparezcan repetidos?
    'TraerRecordsetConLosProcesosPendientes = app.TablasGenerales.TraerFiltrado("ProduccionOrdenes", "_SinCerrarParaLista", Array(Val(FiltroArticulo), Val(FiltroMaterial)))
    
    Dim rs As Recordset
    
   
    'traigo los procesos
    Set rs = app.TablasGenerales.TraerFiltrado("Empleados", "_TT2")
    'Set rs = app.TablasGenerales.TraerTodos("Empleados")
    rs.Filter = "Cargo='Supervisor/a' OR Cargo='Jefe/a'"
    
    Set TraerRsConEmpleadosConCargoDeSupervisor = rs
    
End Function


Function PedirPermisosDeSuperAdministrador(NivelAcceso As Integer) As Boolean
    Dim mvarSale As Integer
    Dim mIdAutorizo As Long
    
    'mvarSale = MsgBox("Esta seguro de anular la OP ?", vbYesNo, "Anulacion")
    'If mvarSale = vbNo Then
    '   Exit Sub
    'End If
    
    If NivelAcceso = 1 Then 'ya tengo permisos
        PedirPermisosDeSuperAdministrador = True
        Exit Function
    End If
    
    Dim oF As Form
    Set oF = New frmAutorizacion

    With oF
        .Empleado = 0
        .SuperAdministrador = True
        '.IdFormulario = 70
        .IdFormulario = 0 'EnumFormularios.Remitos '.OrdenesCompra

        .Show vbModal
    End With

    'If Not oF.Ok Then
    '    MsgBox "No puede anular la OP!", vbExclamation
    '    Set oF = Nothing
    '    Exit Sub
    'End If
    
    PedirPermisosDeSuperAdministrador = oF.Ok
    
    Unload oF
    Set oF = Nothing
End Function

Function PedirPermisosDeSupervisorCapen(NivelAcceso As Integer) As Boolean
    Dim mvarSale As Integer
    Dim mIdAutorizo As Long
    
    'mvarSale = MsgBox("Esta seguro de anular la OP ?", vbYesNo, "Anulacion")
    'If mvarSale = vbNo Then
    '   Exit Sub
    'End If
    

    Dim oF As Form
    Set oF = New frmAutorizacion

    With oF
        .Empleado = 0
         .mvarSupervisores = True
        .Administradores = False
        '.SuperAdministrador = True
        '.IdFormulario = 70
        .IdFormulario = 0 'EnumFormularios.Remitos '.OrdenesCompra

        .Show vbModal
    End With

    'If Not oF.Ok Then
    '    MsgBox "No puede anular la OP!", vbExclamation
    '    Set oF = Nothing
    '    Exit Sub
    'End If
    
    PedirPermisosDeSupervisorCapen = oF.Ok
    
    Unload oF
    Set oF = Nothing
End Function

Function TraerParteActivoQueEstaUsandoEstaMaquina(IdMaquina As Long) As Long
    Dim rs As Recordset
    Set rs = Aplicacion.ProduccionPartes.TraerTodos
    
    
    rs.Filter = "Estado='ABIERTO' AND Maquina='" & NombreMaquina(IdMaquina) & "'"
    
    If rs.RecordCount > 1 Then
        TraerParteActivoQueEstaUsandoEstaMaquina = rs!parte ' -1 'esto es un error. Hay mas de un parte usando la maquina
    ElseIf rs.RecordCount = 1 Then
        TraerParteActivoQueEstaUsandoEstaMaquina = rs!parte
    Else
        TraerParteActivoQueEstaUsandoEstaMaquina = 0 'la maquina está libre
    End If
End Function

Function EstanPermitidosPartesConConsumosParciales() As Boolean
    EstanPermitidosPartesConConsumosParciales = True
End Function

Function TraerIdUnidadDelIdStockElegido(IdStock As Long) As Long
    Dim rs As ADOR.Recordset
    Set rs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", IdStock)
    
    If rs.RecordCount = 0 Then
        'MsgBox ("No se encuentra el artículo")
        TraerIdUnidadDelIdStockElegido = -1
        'Stop
    ElseIf rs.RecordCount > 1 Then
        TraerIdUnidadDelIdStockElegido = rs!IdUnidad
        'Debug.Print rs!IdArticulo, rs.Fields(1)
        'Stop
    Else

        'Do While repeticion > 0
        '    rs.MoveNext
        '    repeticion = repeticion - 1
        'Wend
        If IsNull(rs!IdUnidad) Then
            Dim mvarIdUnidadCU
    Dim oRs As ADOR.Recordset
    If IsNull(rs!IdArticulo) Then
       Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
        If oRs.RecordCount > 0 Then
            ' mvarIdUnidadCU = IIf(IsNull(oRs.Fields("IdUnidadPorUnidad").Value), 0, oRs.Fields("IdUnidadPorUnidad").Value)
        End If
    oRs.Close
   
   End If
            TraerIdUnidadDelIdStockElegido = iisNull(mvarIdUnidadCU, 1)
            'Set rs = Aplicacion.TablasGenerales.TraerFiltrado("UnidadesEmpaque", "_PorNumero", rs.Fields("NumeroCaja"))
            'TraerIdColorDelIdStockElegido = iisNull(rs!IdColor, -1)
        Else
            TraerIdUnidadDelIdStockElegido = rs!IdUnidad
        End If
    End If
    
    Set rs = Nothing
End Function

Function TraerIdColorDelIdStockElegido(IdStock As Long) As Long
    Dim rs As ADOR.Recordset
    Set rs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", IdStock)
    
    If rs.RecordCount = 0 Then
        'MsgBox ("No se encuentra el artículo")
        TraerIdColorDelIdStockElegido = -1
        'Stop
    ElseIf rs.RecordCount > 1 Then
        TraerIdColorDelIdStockElegido = rs!IdColor
        'Debug.Print rs!IdArticulo, rs.Fields(1)
        'Stop
    Else

        'Do While repeticion > 0
        '    rs.MoveNext
        '    repeticion = repeticion - 1
        'Wend
        If IsNull(rs!IdColor) Then
            Set rs = Aplicacion.TablasGenerales.TraerFiltrado("UnidadesEmpaque", "_PorNumero", rs.Fields("NumeroCaja"))
            TraerIdColorDelIdStockElegido = iisNull(rs!IdColor, -1)
        Else
            TraerIdColorDelIdStockElegido = rs!IdColor
        End If
    End If
    
    Set rs = Nothing
End Function

Function TraerNumeroCajaDeIdStock(IdStock As Long) As Long
    Dim rs As ADOR.Recordset
    Set rs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", IdStock)

    If rs.RecordCount = 0 Then
        TraerNumeroCajaDeIdStock = 0
    Else
        TraerNumeroCajaDeIdStock = iisNull(rs.Fields("NumeroCaja"), 0)
    End If
    
    Set rs = Nothing
End Function

Function TraerRegistroStock(IdStock As Long) As ADOR.Recordset
    Set TraerRegistroStock = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", IdStock)
End Function


'//////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////
' COPIAS
'//////////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////////

Function CrearCopiaDeOP(Id)
    
    'Usar el metodo frmProduccionOrden.DuplicarOP(idOP)
    
End Function

Function CrearCopiaDeFicha(IdFicha_a_Copiar) As Long
    'devuelve el Id de la ficha generada.duplicar en pronto no es facil
    Dim oFichaOrigen As ComPronto.ProduccionFicha
    Dim oFichaDestino As ComPronto.ProduccionFicha
    Dim rs As ADOR.Recordset
    Dim oDetFicha As ComPronto.DetProduccionFicha
    Dim oDetFichaProc As ComPronto.DetProdFichaProceso
    
    Dim oDetFichaOriginal  As ComPronto.DetProduccionFicha
    Dim oDetFichaProcOriginal As ComPronto.DetProdFichaProceso
    
    Set oFichaOrigen = Aplicacion.ProduccionFichas.Item(IdFicha_a_Copiar)
    Set oFichaDestino = Aplicacion.ProduccionFichas.Item(-1)
    
    'copio el encabezado
    With oFichaDestino.Registro
        !Observaciones = oFichaOrigen.Registro!Observaciones
        !IdColor = oFichaOrigen.Registro!IdColor
        !Codigo = oFichaOrigen.Registro!Codigo
        !descripcion = Null
        !Cantidad = oFichaOrigen.Registro!Cantidad
        !IdUnidad = oFichaOrigen.Registro!IdUnidad
               
        !Minimo = oFichaOrigen.Registro!Minimo
        !IdArticuloAsociado = oFichaOrigen.Registro!IdArticuloAsociado
        !EstaActiva = "NO"
    End With
        
    'copio los procesos
    Set rs = oFichaOrigen.DetProduccionFichas.TraerTodos
         
    Do While Not rs.EOF
                      
        Set oDetFicha = oFichaDestino.DetProduccionFichas.Item(-1)
        Set oDetFichaOriginal = oFichaDestino.DetProduccionFichas.Item(rs!IdDetalleProduccionFicha)
        
        With oDetFicha.Registro
            !IdArticulo = rs!IdArticulo
            '!IdStock = rs!IdStock
            '!Partida = rs!Partida
            !Cantidad = rs.Fields("Cant.")
            '!CantidadAdicional = rs!CantidadAdicional
            !IdUnidad = rs!IdUnidad
            '!Cantidad1 = rs!Cantidad1
            '!Cantidad2 = rs!Cantidad2
            '!Observaciones = rs!Observaciones
            !Porcentaje = rs.Fields("%")
            !Tolerancia = rs!Tolerancia
            !IdProduccionProceso = oDetFichaOriginal.Registro!IdProduccionProceso
            !IdColor = oDetFichaOriginal.Registro!IdColor
            
            oDetFicha.Modificado = True
            Set oDetFicha = Nothing
            rs.MoveNext
        End With

    Loop
    
    'copio los procesos
    Set rs = oFichaOrigen.DetProduccionFichasProcesos.TraerTodos
         
    Do While Not rs.EOF
                      
        Set oDetFichaProc = oFichaDestino.DetProduccionFichasProcesos.Item(-1)
        Set oDetFichaProcOriginal = oFichaDestino.DetProduccionFichasProcesos.Item(rs!IdDetalleProduccionFichaProceso)
        
        With oDetFichaProc.Registro
            !IdProduccionProceso = rs!IdProduccionProceso
            !Horas = rs!Horas
            
            oDetFichaProc.Modificado = True
            Set oDetFichaProc = Nothing
            rs.MoveNext
        End With

    Loop
    
    'Grabo
    oFichaDestino.Guardar
    CrearCopiaDeFicha = oFichaDestino.Registro.Fields("IdProduccionFicha")
    Set oFichaDestino = Nothing
    
    EditarFicha CrearCopiaDeFicha, True
    
End Function

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////

Private Sub EditarOP(Index As Integer)
    Dim oF As frmProduccionOrden

    Set oF = New frmProduccionOrden

    With oF
      
        .NivelAcceso = frmPrincipal.ControlAccesoNivel("OrdendeProduccion")
        .OpcionesAcceso = frmPrincipal.ControlAccesoOpciones("OrdendeProduccion")

        .Id = -1

        If Not glbPermitirModificacionTabulados Then
            If ExisteControlEnFormulario(oF, "lblTabIndex") Then
                '.lblTabIndex.Visible = False
            End If
        End If
 
        'dcfields(dcf_ARTICULOPRODUCIDO).BoundText =
        'dcfields(dcf_COLORPRODUCIDO).BoundText =
        oF.CargarFicha
       
        '.Disparar = ActL
        'Me.MousePointer = vbDefault
        .Show
    End With

Salida:

    Set oF = Nothing

    'Me.MousePointer = vbDefault
End Sub

Sub NuevoParte()
    EditarParte (-1)
End Sub

Sub EditarParte(Id As Long, Optional X As Long, Optional Y As Long)

    Dim oF As Form

    Set oF = New frmProduccionParte

    With oF

        .NivelAcceso = frmPrincipal.ControlAccesoNivel("PartedeProduccion")
        .OpcionesAcceso = frmPrincipal.ControlAccesoOpciones("PartedeProduccion")
      
        .Id = Id

        If Not glbPermitirModificacionTabulados Then
            If ExisteControlEnFormulario(oF, "lblTabIndex") Then
                .lblTabIndex.Visible = False
            End If
        End If

        If oF.habilitado Then
            '.Disparar = ActL
            'Me.MousePointer = vbDefault
            If Not IsMissing(Y) Then oF.top = Y
            If Not IsMissing(X) Then oF.left = X
            .Show ', Me
            .top = .top + 500
            .left = .left + 500
        End If

    End With

Salida:

    Set oF = Nothing

    'Me.MousePointer = vbDefault
End Sub

Sub EditarFicha(Id, Optional BorroSiCancela As Boolean = False)
    Dim oF As frmProduccionFicha

    Set oF = New frmProduccionFicha

    With oF
   
        .NivelAcceso = frmPrincipal.ControlAccesoNivel("FichaTecnica")
        .OpcionesAcceso = frmPrincipal.ControlAccesoOpciones("FichaTecnica")
      
        .Id = Id
        .BorroSiCancela = BorroSiCancela

        If Not glbPermitirModificacionTabulados Then
            'If ExisteControlEnFormulario(oF, "lblTabIndex") Then
            '   .lblTabIndex.Visible = False
            'End If
        End If

        'If oF.habilitado Then
        '.Disparar = ActL
        'Me.MousePointer = vbDefault
        .Show ', Me
        .top = .top + 500
        .left = .left + 500
        'End If
    End With

Salida:

    Set oF = Nothing

    'Me.MousePointer = vbDefault
End Sub

Sub EditarOrdenCompra(Id)

    Dim oF As Form

    Set oF = New frmOrdenesCompra

    With oF

        .NivelAcceso = 9 'frmPrincipal.ControlAccesoNivel("PartedeProduccion")
        .OpcionesAcceso = 9 ' frmPrincipal.ControlAccesoOpciones("PartedeProduccion")
      
        .Id = Id

        If Not glbPermitirModificacionTabulados Then
            If ExisteControlEnFormulario(oF, "lblTabIndex") Then
                .lblTabIndex.Visible = False
            End If
        End If

        .Show

    End With

Salida:

    Set oF = Nothing

    'Me.MousePointer = vbDefault
End Sub

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////

Function TraerRecordsetConLosProcesosPendientes(ByRef app As Aplicacion) As Recordset
    'traer los procesos pendientes
    'como hago para q los q tienen articulo asociado aparezcan repetidos?
    'TraerRecordsetConLosProcesosPendientes = app.TablasGenerales.TraerFiltrado("ProduccionOrdenes", "_SinCerrarParaLista", Array(Val(FiltroArticulo), Val(FiltroMaterial)))
    
    Dim rs As Recordset
    
    'traigo los procesos
    Set rs = app.TablasGenerales.TraerFiltrado("ProduccionOrdenes", "_ProcesosArticulosPendientes")
    
    Set TraerRecordsetConLosProcesosPendientes = rs
    
End Function

Sub CierroElProceso(ByRef oOF As ComPronto.ProduccionOrden, _
                    IdProduccionProceso As Long, _
                    IdParte As Long)
    Dim rs As ADOR.Recordset
    
    Set rs = oOF.DetProduccionOrdenesProcesos.TraerTodos
    
    Do While Not rs.EOF
                     
        Dim oOFproceso As ComPronto.DetProdOrdenProceso
        Set oOFproceso = oOF.DetProduccionOrdenesProcesos.Item(rs!IdDetalleProduccionOrdenProceso)

        With oOFproceso.Registro

            If !IdProduccionProceso = IdProduccionProceso Then
                !IdProduccionParteQueCerroEsteProceso = IIf(IdParte = 0, 1, IdParte) 'arreglar
                oOFproceso.Modificado = True
                Exit Do
            End If

        End With
        
        rs.MoveNext
    Loop

End Sub

Sub ReasignoFechasDelProceso(ByRef oOF As ComPronto.ProduccionOrden, _
                    IdProduccionProceso As Long, _
                    FechaInicio As Date)
    Dim rs As ADOR.Recordset
    
    Set rs = oOF.DetProduccionOrdenesProcesos.TraerTodos
    
    Do While Not rs.EOF
                     
        Dim oOFproceso As ComPronto.DetProdOrdenProceso
        Set oOFproceso = oOF.DetProduccionOrdenesProcesos.Item(rs!IdDetalleProduccionOrdenProceso)

        With oOFproceso.Registro

            If !IdProduccionProceso = IdProduccionProceso Then
                !FechaInicio = FechaInicio
                oOFproceso.Modificado = True
                Exit Do
            End If

        End With
        
        rs.MoveNext
    Loop

End Sub

Function EstanListosLosDemasArticulosAsociadosAesteProceso(ByRef oOF As ComPronto.ProduccionOrden, IdProduccionProceso As Long) As Boolean
    
    EstanListosLosDemasArticulosAsociadosAesteProceso = False
    Dim rs As Recordset
    Set rs = oOF.DetProduccionOrdenes.TraerTodos
    
    Do While Not rs.EOF
                     
        Dim oOFarticulo As ComPronto.DetProduccionOrden
        Set oOFarticulo = oOF.DetProduccionOrdenes.Item(rs!IdDetalleProduccionOrden)

        With oOFarticulo.Registro

            If !IdProduccionProceso = IdProduccionProceso Then
                
                If IsNull(!IdProduccionParteQueCerroEsteInsumo) Then Exit Function 'un articulo asociado a este proceso no está terminado
                
            End If

        End With
        
        rs.MoveNext
    Loop
    
    EstanListosLosDemasArticulosAsociadosAesteProceso = True
    
End Function



'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
' etiquetar material creado sobrante
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////


Function EtiquetarMaterialCreado(IdArt, IdColor, IdUnidad, idUbicacion, Cantidad, IdObra, NumeroCaja, partida As String) As Boolean
    
    '-a diferencia de ReetiquetarElSobranteCreandoUnaNuevaPartida(), EtiquetarMaterialCreado() no debe
    '  crear stock nuevo, sino que simplemente debe....
    '-Debe qué? Solo dejar registro de la etiqueta? Pero la salida que crea el ParteDeProduccion no está
    '  ya asignandole el numero de la OP en el número de la partida? Es por el número de caja, quizás?
    '-Bueno, no sé... pero cómo hacemos para no dar de alta el stock otra vez? Quién de los dos
    '  va a dejar de dar de alta el stock?: el frmEtiquetas o el frmParteProduccion?
    
    
    Dim oF As New frmEtiquetas
        
    oF.Init IdArt, IdColor, IdUnidad, idUbicacion, Cantidad, IdObra, NumeroCaja, partida
    oF.bSaltarseAjuste = True
    
    oF.Show vbModal


    If oF.mIdUnidadEmpaque = -2 Then
        EtiquetarMaterialCreado = False 'el tipo no reetiquetó
    Else
        EtiquetarMaterialCreado = True
    End If
        
End Function





'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
' material sobrante despues de un consumo
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////

Function ReetiquetarElSobranteCreandoUnaNuevaPartida(IdArt, IdColor, IdUnidad, idUbicacion, Cantidad, IdObra, NumeroCaja, partida As String) As Boolean
    'lo que sobró se pone en cero. Así que esta funcion crea el stock nuevo, solo con el articulo y el color fijos
    
    Dim oF As New frmEtiquetas
'quizas te tira un "Permiso Denegado" por el acceso a la impresora
    oF.Init IdArt, IdColor, IdUnidad, idUbicacion, Cantidad, IdObra, NumeroCaja, partida
    
    oF.Show vbModal

    If oF.mIdUnidadEmpaque = -2 Then
        ReetiquetarElSobranteCreandoUnaNuevaPartida = False 'el tipo no reetiquetó
    Else
        ReetiquetarElSobranteCreandoUnaNuevaPartida = True
    End If
        
End Function





Function SobraMaterial() As Boolean
    SobraMaterial = True
End Function

Sub PonerEnCeroElStockOriginalSobrante(IdArticulo As Long, _
                                       partida As String, _
                                       IdColor As Long, _
                                       Cantidad As Double, _
                                       IdUnidad As Long, _
                                       idUbicacion As Long, _
                                       IdObra As Long, _
                                       IdStock As Long, _
                                       oParte As ComPronto.ProduccionParte)
    
    'uso un ajuste de stock para poner en 0 el stock (el mismo metodo que el etiquetador
    'para crear el stock). Creo que va a convenir hacerlo DESPUES de haber llamado al etiquetador

    Dim oRs As ADOR.Recordset
    Dim mZebra As String, mCodigo As String, mDescripcion As String, mPartida As String, mPeso1 As String
    Dim mNumeroCaja As String, mPesoBruto As String, mTara As String, mUnidades As String, mSP As String
    Dim mColor As String
    Dim mIdStock As Long, mIdUnidadEmpaque As Long, mNumeroAjusteStock As Long, mIdObraDefault As Long
    Dim mIdAjusteStock As Long, mIdDetalleAjusteStock As Long, mNumeroCaja1 As Long, mIdColor As Long
    Dim mPeso As Long
    Dim mAux1
    Dim oAju As ComPronto.AjusteStock
    Dim oPar As ComPronto.Parametro
    Dim mN As Long
    Dim SM As ComPronto.SalidaMateriales
    Dim DetSM As ComPronto.DetSalidaMateriales
    Dim art As ComPronto.Articulo
    Dim proceso As ComPronto.proceso
    Set proceso = AplicacionProd.Procesos.Item(oParte.Registro!IdProduccionProceso)

    mIdColor = 0
    
    Set oPar = Aplicacion.Parametros.Item(1) 'me traigo el renglon de parámetros
    
    With oPar.Registro
        mN = .Fields("ProximoNumeroSalidaMateriales").Value
        .Fields("ProximoNumeroSalidaMateriales").Value = mN + 1
    End With
                
    Set SM = Aplicacion.SalidasMateriales.Item(-1)

    Dim op As ComPronto.ProduccionOrden

    Set op = Aplicacion.ProduccionOrdenes.Item(oParte.Registro!IdProduccionOrden)

    With SM.Registro
        !NumeroSalidaMateriales = mN
        !TipoSalida = 1 'Salida a Fabrica
        !Cliente = op.Registro!Cliente   'Registro!Cliente
        !FechaSalidaMateriales = Date
        '!IdColor = Registro!Color
        !IdObra = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", IdStock).Fields("IdObra") ' TraerValorParametro2("IdObraDefault") ' TraerValorParametro2("IdObraDefault")
        .Fields("Observaciones").Value = "Egreso por RE-etiquetado de material sobrante del modulo de Produccion (por la tara, la cantidad que se resta puede ser distinta de la generada al etiquetar)"
                    
        '!IdDepositoOrigen =
        'acá qué se carga???? el deposito o la ubicacion???? se carga la ubicacion en el detalle
                
        !Emitio = oParte.Registro!IdEmpleado
        !Aprobo = oParte.Registro!IdEmpleado
    End With
            
    Set DetSM = SM.DetSalidasMateriales.Item(-1)

    With DetSM
        .Registro!IdArticulo = oParte.Registro!IdArticulo
        .Registro!Cantidad = Cantidad
                                             
        Set art = Aplicacion.Articulos.Item(oParte.Registro!IdArticulo)
        .Registro!IdUnidad = art.Registro!IdUnidad
                                             
        .Registro!IdObra = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", oParte.Registro!IdStock).Fields("IdObra") ' TraerValorParametro2("IdObraDefault")
        .Registro!IdStock = oParte.Registro!IdStock
        .Registro!partida = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", oParte.Registro!IdStock).Fields("Partida") ' oParte.Registro!Partida
        .Registro!idUbicacion = proceso.Registro!idUbicacion
                                        
        Set art = Aplicacion.Articulos.Item(oParte.Registro!IdArticulo)
         
        .Registro!CostoUnitario = iisNull(art.Registro!CostoReposicion, 0)
        .Registro!Adjunto = "NO"
        .Registro!CotizacionDolar = Cotizacion(Date, glbIdMonedaDolar)
        .Registro!IdMoneda = oPar.Registro!IdMoneda.Value
                                             
        Dim num As Long
        num = TraerNumeroCajaDeIdStock(oParte.Registro!IdStock)

        If num > 0 Then .Registro!NumeroCaja = num
        
        
        
        .Registro!IdColor = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", oParte.Registro!IdStock).Fields("IdColor") ' TraerValorParametro2("IdObraDefault")
        
        
        'verificar que no Idobra y idcolor sea ni null ni 0 -pero idcolor no puede ser null?
        If .Registro!IdColor <= 0 Or iisNull(.Registro!IdObra, 0) <= 0 Then
            Err.Raise 22000 Or vbObjectError, "PonerEnCeroElStockOriginalSobrante", "IdColor o IdObra invalidos"
        End If
                                                            
                                                            
                                        
        '!Observaciones = "Egreso por RE-etiquetado de material sobrante del modulo de Produccion"
    End With

    DetSM.Modificado = True
                    
    oPar.Guardar
    SM.Guardar

    Set SM = Nothing
         
    'oRs.Close
         
    Set oRs = Nothing

End Sub

'Sub PonerEnCeroElStockOriginalSobranteOBSOLETO_USABAAJUSTEENLUGARDESALIDAMATERIAL(IdArticulo As Long, _
'                                                                                  partida As String, _
'                                                                                  IdColor As Long, _
'                                                                                  Cantidad As Long, _
'                                                                                  IdUnidad As Long, _
'                                                                                  idUbicacion As Long, _
'                                                                                  IdObra As Long)
'
'    'uso un ajuste de stock para poner en 0 el stock (el mismo metodo que el etiquetador
'    'para crear el stock). Creo que va a convenir hacerlo DESPUES de haber llamado al etiquetador''
'
'    Dim oRs As ADOR.Recordset
'    Dim mZebra As String, mCodigo As String, mDescripcion As String, mPartida As String, mPeso1 As String
'    Dim mNumeroCaja As String, mPesoBruto As String, mTara As String, mUnidades As String, mSP As String
'    Dim mColor As String
'    Dim mIdStock As Long, mIdUnidadEmpaque As Long, mNumeroAjusteStock As Long, mIdObraDefault As Long
'    Dim mIdAjusteStock As Long, mIdDetalleAjusteStock As Long, mNumeroCaja1 As Long, mIdColor As Long
'    Dim mPeso As Long
'    Dim mAux1
'    Dim oAju As ComPronto.AjusteStock
'    Dim oPar As ComPronto.Parametro
'
'    mIdColor = 0
'
'    '    mPeso1 = txtPesoNeto.Text
'    '    mPeso = Val(txtPesoNeto.Text * 100)
'    '    mPesoBruto = txtPesoBruto.Text
'    '    mTara = txtTara.Text
'    '    mDescripcion = txtCaracteristicas.Text
'    '    mPartida = txtPartida.Text
'    '    mUnidades = txtUnidades.Text
'    '    mColor = DataCombo1(3).Text
'
'    mIdAjusteStock = -1
'    mIdDetalleAjusteStock = -1
'    Set oRs = Aplicacion.AjustesStock.TraerFiltrado("_PorMarbete", mNumeroCaja1)'''

'    If oRs.RecordCount > 0 Then
'        mIdAjusteStock = oRs.Fields(0).Value
'        mNumeroAjusteStock = oRs.Fields("NumeroAjusteStock").Value
'    End If'
'
'    oRs.Close
'
'    Set oPar = Aplicacion.Parametros.Item(1)''''
'
'    With oPar.Registro
'        mNumeroAjusteStock = .Fields("ProximoNumeroAjusteStock").Value
'        .Fields("ProximoNumeroAjusteStock").Value = mNumeroAjusteStock + 1
'    End With''

'    oPar.Guardar
'    Set oPar = Nothing
'
'    Set oAju = Aplicacion.AjustesStock.Item(mIdAjusteStock)'

'    With oAju
'        With .Registro
'            .Fields("NumeroAjusteStock").Value = mNumeroAjusteStock
'            .Fields("FechaAjuste").Value = Date
'            .Fields("Observaciones").Value = "Egreso por RE-etiquetado de material sobrante del modulo de Produccion"
'            .Fields("IdRealizo").Value = glbIdUsuario
'            .Fields("FechaRegistro").Value = Now
'            .Fields("NumeroMarbete").Value = mNumeroCaja1
'            .Fields("TipoAjuste").Value = ""
'            .Fields("IdUsuarioIngreso").Value = glbIdUsuario
'            .Fields("FechaIngreso").Value = Now
'        End With''

'        With .DetAjustesStock.Item(mIdDetalleAjusteStock)
'            With .Registro
'                .Fields("IdArticulo").Value = IdArticulo
'                .Fields("Partida").Value = partida
'                .Fields("CantidadUnidades").Value = Cantidad
'                .Fields("IdUnidad").Value = IdUnidad
'                .Fields("IdUbicacion").Value = idUbicacion
'                .Fields("IdObra").Value = IdObra
'                .Fields("NumeroCaja").Value = mNumeroCaja1 'sdfgsdfgsdfg
'
'                .Fields("Observaciones").Value = "Egreso por RE-etiquetado de material sobrante del modulo de Produccion"
'            End With

'            .Modificado = True
'        End With

'        .Guardar
'    End With'

'    Set oAju = Nothing
'
'    'oRs.Close
'
'    Set oRs = Nothing

'End Sub

Function MostrarFichasDisponibles() As Recordset
    Dim rs As Recordset
    Set rs = Aplicacion.ProduccionFichas.TraerTodos
    rs.Filter = "ACTIVA='SI'"
    
    Set MostrarFichasDisponibles = rs
End Function

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////

Sub ImputarItemsDePedidosDeClienteALaOrdenDeProduccion(Lista, _
                                                       ByRef oOP As ProduccionOrden)
    
    Dim Columnas() As String
    Columnas = VBA.Split(Lista(1), vbTab) 'split del primer renglon, que usaré como referencia para ver que no haya distintos
    
    Dim Cantidad As Double
    Dim IdArticulo As Long
    Dim IdColor As Long
    Dim IdCliente As Long
       
    IdArticulo = Columnas(21)
    IdColor = Columnas(19)
    IdCliente = BuscaIdCliente(Columnas(5))
    
    'verificar que no sean distintos articulos
    Dim i

    For i = 1 To UBound(Lista)
        Columnas = VBA.Split(Lista(i), vbTab)
        
        If IdArticulo <> Columnas(21) Or IdColor <> Columnas(19) Then
            MsgBox "Los items deben ser del mismo articulo y color"
            Exit Sub
        End If
        
        AgregarAListaDeImputacionDePedidosEnLaOrdenDeProduccion Lista(i), oOP
                
        Cantidad = Cantidad + Columnas(9)
    Next
      
    oOP.Registro!Cantidad = Cantidad
    oOP.Registro!idArticuloGenerado = IdArticulo
    oOP.Registro!IdColor = IdColor
    oOP.Registro!Cliente = IdCliente
         
    'AgregarAListaDeImputacionDePedidosEnLaOrdenDeProduccion Lista(0), oOP
    For i = 1 To UBound(Lista)
        AgregarAListaDeImputacionDePedidosEnLaOrdenDeProduccion Lista(i), oOP
    Next
   
End Sub

Sub AgregarAListaDeImputacionDePedidosEnLaOrdenDeProduccion(Fila, _
                                                            ByRef oOP As ProduccionOrden)
    
    Dim Columnas
    Columnas = VBA.Split(Fila, vbTab)
    Dim idDetOC
    idDetOC = Columnas(20)
    
    If IsNull(oOP.Registro!IdDetalleOrdenCompraImputado1) Or oOP.Registro!IdDetalleOrdenCompraImputado1 = idDetOC Then
        oOP.Registro!IdDetalleOrdenCompraImputado1 = idDetOC
    ElseIf IsNull(oOP.Registro!IdDetalleOrdenCompraImputado2) Or oOP.Registro!IdDetalleOrdenCompraImputado2 = idDetOC Then
        oOP.Registro!IdDetalleOrdenCompraImputado2 = idDetOC
    ElseIf IsNull(oOP.Registro!IdDetalleOrdenCompraImputado3) Or oOP.Registro!IdDetalleOrdenCompraImputado3 = idDetOC Then
        oOP.Registro!IdDetalleOrdenCompraImputado3 = idDetOC
    ElseIf IsNull(oOP.Registro!IdDetalleOrdenCompraImputado4) Or oOP.Registro!IdDetalleOrdenCompraImputado4 = idDetOC Then
        oOP.Registro!IdDetalleOrdenCompraImputado4 = idDetOC
    ElseIf IsNull(oOP.Registro!IdDetalleOrdenCompraImputado5) Or oOP.Registro!IdDetalleOrdenCompraImputado5 = idDetOC Then
        oOP.Registro!IdDetalleOrdenCompraImputado5 = idDetOC
    End If

End Sub

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////

Sub DesactivarElRestoDeLasFichasQueUsenElMismoArticulo(IdArticulo, _
                                                       IdColor)
    Dim rs As Recordset
    
    Set rs = Aplicacion.ProduccionFichas.TraerTodos
    rs.Filter = "IdArticuloAsociado=" & IdArticulo & " and IdColor=" & IdColor
    
    Dim oFicha As ComPronto.ProduccionFicha
    
    Do While Not rs.EOF
        Set oFicha = Aplicacion.ProduccionFichas.Item(rs!idProduccionFicha)
        oFicha.Registro!EstaActiva = "NO"
        oFicha.Guardar
         
        rs.MoveNext
    Loop

End Sub

Sub ForzarCierrePartesYProcesos(ByRef AplicacionProd As Aplicacion, _
                                origen As ComPronto.ProduccionOrden)

    'CerrarParte
    Dim xrs As ADOR.Recordset
    Set xrs = AplicacionProd.ProduccionOrdenes.TraerFiltrado("_TienePartesAbiertosAsociados", origen.Registro!IdProduccionOrden)

    If xrs.RecordCount > 0 Then
        Dim o As ComPronto.ProduccionParte
        Set o = Aplicacion.ProduccionPartes.Item(xrs!idProduccionParte)
        
        With o
            .Registro.Fields("IdUsuarioCerro").Value = glbIdUsuario
            .Guardar
        End With
       
        'ProduccionWrapper.CerrarPartesDeLaOP
    End If
    
    '////////////////////////
    '////////////////////////
    'Cierro el proceso
    '////////////////////////
    '////////////////////////
    Dim rs As ADOR.Recordset
    Set rs = origen.DetProduccionOrdenesProcesos.TraerTodos
    
    Set rs = origen.DetProduccionOrdenesProcesos.TraerTodos
     
    'ahora me fijo si los procesos anteriores estan cumplidos
    Do While Not rs.EOF
                      
        Dim oOFproceso As ComPronto.DetProdOrdenProceso
        Set oOFproceso = origen.DetProduccionOrdenesProcesos.Item(rs!IdDetalleProduccionOrdenProceso)

        With oOFproceso.Registro

            If IsNull(!IdProduccionParteQueCerroEsteProceso) Then
                !IdProduccionParteQueCerroEsteProceso = -1
            End If

        End With
         
        rs.MoveNext
    Loop

End Sub

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////

Sub CambiaDcfields(oF As Object, _
                   Index As Integer, _
                   Id, _
                   Optional Texto As String = "") 'Finge clicks sobre combo
    'Si viene texto
    On Error Resume Next
    Dim X As DataCombo

    With oF
        CallByName oF, "dcfields_Click", VbMethod, Index, dbcAreaList
        CallByName oF, "dcfields_Change", VbMethod, Index
        
        If Texto = "" Then
            .dcfields(Index).BoundText = Id
        Else
            Set X = .dcfields(Index)

            With X
                Dim i As Integer
                Dim rs As ADOR.Recordset
                Set rs = .RowSource
                
                rs.MoveFirst

                Do While Not rs.EOF

                    If InStr(rs(1), Texto) > 0 Then
                        Exit Do
                    End If

                    rs.MoveNext
                Loop
                
                '.BoundText = rs(0)
                .Text = rs(1)
                Set rs = Nothing
            End With

        End If
        
        CallByName oF, "dcfields_Click", VbMethod, Index, dbcAreaList
        CallByName oF, "dcfields_Validate", VbMethod, Index, False
        '.dcfields_Click index, dbcAreaList
        '.dcfields(index).BoundText = id
        '.dcfields_Change index
        '.dcfields_Click index, dbcAreaList
        '.dcfields_Validate index, False
    End With

End Sub

Sub CambiaDatacombo(oF As Form, _
                    Index As Long, _
                    Id As Long) 'Finge clicks sobre combo
    On Error Resume Next

    With oF
        .datacombo_Click Index, dbcAreaList
        .DataCombo(Index).BoundText = Id
        .datacombo_Change Index
        .datacombo_Click Index, dbcAreaList
        .datacombo_Validate Index, False
    End With

End Sub

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////

Public Function TraerDirecto(ByVal NombreSP, _
                             Optional ByVal Args As Variant) As ADOR.Recordset
    'Traido de MTSpronto.GralLector.TraerDirecto
    Dim QueServidor As String
    QueServidor = "SrvDatos"

    Dim oSrv 'As InterfazDatos.IDatos
    Dim oCont 'As ObjectContext
   
    'Set oCont = GetObjectContext
   
    'If oCont Is Nothing Then
    Set oSrv = CreateObject(QueServidor & ".Servidor")
    'Else
    '   Set oSrv = oCont.CreateInstance(QueServidor & ".Servidor")
    'End If
   
    'If Len(DefinicionConexion) = 0 Then DefinicionConexion = CargarStringConexion1
   
      
    Set TraerDirecto = oSrv.LeerRecordset(glbStringConexion, NombreSP, Args)
   
    If Not oCont Is Nothing Then

        With oCont

            If .IsInTransaction Then .SetComplete
        End With

    End If
   
    Set oSrv = Nothing
    Set oCont = Nothing

End Function

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////

Function FichasActivas(ByRef app As Aplicacion) As Recordset
    'traer los procesos pendientes
    'como hago para q los q tienen articulo asociado aparezcan repetidos?
    'TraerRecordsetConLosProcesosPendientes = app.TablasGenerales.TraerFiltrado("ProduccionOrdenes", "_SinCerrarParaLista", Array(Val(FiltroArticulo), Val(FiltroMaterial)))
    
    Dim rs As ADOR.Recordset
    
    'traigo los procesos
    Set rs = app.ProduccionFichas.TraerTodos
    'rs.Filter = "Activa'NO' OR Activa IS NULL"
    rs.Filter = "Activa IS NULL"
    
    Set FichasActivas = rs
    
End Function

Function FichasInactivas(ByRef app As Aplicacion) As Recordset
    'traer los procesos pendientes
    'como hago para q los q tienen articulo asociado aparezcan repetidos?
    'TraerRecordsetConLosProcesosPendientes = app.TablasGenerales.TraerFiltrado("ProduccionOrdenes", "_SinCerrarParaLista", Array(Val(FiltroArticulo), Val(FiltroMaterial)))
    
    Dim rs As Recordset
    
    'traigo los procesos
    Set rs = app.TablasGenerales.TraerFiltrado("ProduccionOrdenes", "_ProcesosArticulosPendientes")
    rs.Filter = "Activa='NO'"
    
    Set FichasInactivas = rs

End Function

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////

Function ConsultaSimple(ByRef rs As Recordset, Optional ByRef oL As ListItem, Optional vectorT As String = "") As Long
    'con 9 en el vectorT se pone en ancho 0
    'con D no queda tan ancho
    
    Dim oF As frmConsultaSimple
    Set oF = New frmConsultaSimple

    With oF

        .Id = rs
                        
        '.MousePointer = vbDefault
        .Show vbModal
                   
    End With
    
    'podría devolver el recordset posicionado en el registro elegido, no?
    If oF.oL Is Nothing Then
        Exit Function
    End If

    ConsultaSimple = oF.oL.Tag
    Set oL = oF.oL
    'return rs(0)
End Function

Function ConsultaSimpleConCheck(ByRef rs As Recordset, Optional ByRef oL As ListItem, Optional vectorT As String = "")
    
    'con 9 en el vectorT se pone en ancho 0
    '-GUARDA!!!! que si es 9 la primera columna visible, te va a quedar oculto el check!!!!!!
    'con D no queda tan ancho
    
    Dim oF As frmConsultaSimpleConCheck
    Set oF = New frmConsultaSimpleConCheck

    'Dim oF As frm_Aux
    'Set oF = New frm_Aux
    With oF
   
        .MousePointer = vbHourglass
   
        .Caption = "Enviar solicitud a proveedores"
        .text1.Visible = False
        .Label1.Visible = False
        .Width = 16000
        .Height = 6000

        With .Lista
            .left = oF.Label1.left
            .top = 500
            .Width = oF.Width - 500
            .Height = 4000
            .Checkboxes = True
            .Visible = True
        End With

        With .Cmd(0)
            .top = oF.Lista.Height + oF.Lista.top + 150
            .left = oF.Lista.left
            .Caption = "Aceptar"
        End With

        .Cmd(1).top = .Cmd(0).top
        .Parametros = "" & 20
        .IdProveedor = -1
        'Set .mRecordset = rs
        .Id = rs
        '.mRecordset = rs
      
        .MousePointer = vbDefault
      
        .Show vbModal
    End With

    If oF.Ok Then
        ConsultaSimpleConCheck = oF.Filas
    Else
        'Set ConsultaSimpleConCheck = Nothing
    End If
    
    Unload oF
    Set oF = Nothing
    
    'podría devolver el recordset posicionado en el registro elegido, no?
    'If oF.oL Is Nothing Then Exit Function
    'ConsultaSimpleConCheck = oF.oL.Tag
    'Set oL = oF.oL
    'return rs(0)
End Function

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////

Function NombreProceso(IdProceso As Long) As String
    Dim X As ComPronto.proceso
    Set X = AplicacionProd.Procesos.Item(IdProceso)
        
    NombreProceso = X.Registro!descripcion

End Function

Function NombreColor(IdColor As Long) As String

    If IdColor = -1 Then
        NombreColor = ""
        Exit Function
    End If

    Dim X As ComPronto.Color
    Set X = AplicacionProd.Colores.Item(IdColor)
        
    NombreColor = X.Registro!descripcion

End Function


Function NombreArticulo(IdArticulo As Long) As String

    If IdArticulo = -1 Then
        NombreArticulo = ""
        Exit Function
    End If

    Dim X As ComPronto.Articulo
    Set X = AplicacionProd.Articulos.Item(IdArticulo)
        
    NombreArticulo = X.Registro!descripcion

End Function

Function NombreMaquina(IdMaquina As Long) As String
    NombreMaquina = NombreArticulo(IdMaquina)
    Exit Function
    
'    If IdCliente = -1 Then
'        NombreCliente = ""
'        Exit Function
'    End If
'
'    Dim X As ComPronto.Cliente
'    Set X = AplicacionProd.Clientes.Item(IdCliente)
'
'    NombreCliente = X.Registro!RazonSocial

End Function

Function NombreCliente(IdCliente As Long) As String

    If IdCliente = -1 Then
        NombreCliente = ""
        Exit Function
    End If

    Dim X As ComPronto.Cliente
    Set X = AplicacionProd.Clientes.Item(IdCliente)
        
    NombreCliente = X.Registro!RazonSocial

End Function


Function NombreEmpleado(IdEmpleado As Long) As String

    If IdEmpleado = -1 Then
        NombreEmpleado = ""
        Exit Function
    End If

    Dim X As ComPronto.Empleado
    Set X = AplicacionProd.Empleados.Item(IdEmpleado)
        
    NombreEmpleado = X.Registro!Nombre

End Function

'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////
'///////////////////////////////////////////////////////////////////////////////////////////////////////////

Function BuscaIdArticulo(descripcion As String, Optional repeticion As Long = 0) As Long
    Dim rs As ADOR.Recordset
    Set rs = Aplicacion.Articulos.TraerFiltrado("_Busca", left(descripcion, 50))
    
    If rs.RecordCount = 0 Then
        'MsgBox ("No se encuentra el artículo")
        BuscaIdArticulo = -1
        'Stop
    ElseIf rs.RecordCount > 1 Then
        BuscaIdArticulo = rs!IdArticulo
        'Debug.Print rs!IdArticulo, rs.Fields(1)
        'Stop
    Else
        'Do While repeticion > 0
        '    rs.MoveNext
        '    repeticion = repeticion - 1
        'Wend
        BuscaIdArticulo = rs!IdArticulo
    End If
    
    Set rs = Nothing
End Function

Function BuscaIdStock(descripcion As String, Optional Ubicacion As String = "", Optional partida As String = "") As Long
    Dim rs As ADOR.Recordset
    Set rs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_CompletoPorArticulo", Array(BuscaIdArticulo(descripcion), 0, 0, 0, 0, 0))
    
    'rs.Filter = "Partida=Partida"
    If partida <> "" Then rs.Filter = "Partida='" & partida & "'"
    If Ubicacion <> "" Then
        Dim idUbicacion As Long
        idUbicacion = BuscaIdUbicacion(Ubicacion)

        If idUbicacion = -1 Then idUbicacion = BuscaIdUbicacionDescripcionLarga(Ubicacion)
           
        rs.Filter = rs.Filter & "and IdUbicacion=" & idUbicacion
    
    End If

    If rs.RecordCount > 1 Then Stop 'Encuentra más de uno
    If rs.RecordCount < 1 Then Stop 'No encuentra ninguno!
    
    BuscaIdStock = rs!IdStock
    Set rs = Nothing
End Function

Function BuscaIdProveedor(descripcion As String) As Long
    Dim rs As ADOR.Recordset

    Set rs = Aplicacion.Proveedores.TraerTodos
    rs.Filter = "[Razon Social]='" & descripcion & "'"

    If rs.RecordCount = 0 Then
        Stop
        BuscaIdProveedor = -1
    Else
        BuscaIdProveedor = rs!IdProveedor
    End If
    
    Set rs = Nothing
End Function

Function BuscaIdColor(descripcion As String) As Long
    Dim rs As ADOR.Recordset
    
    Set rs = Aplicacion.Colores.TraerTodos
    rs.Filter = "COLOR='" & descripcion & "'"
    
    If rs.RecordCount = 0 Then
        'Stop
        BuscaIdColor = -1
    Else
        BuscaIdColor = rs!IdColor
    End If

    Set rs = Nothing
End Function

Function BuscaIdUnidad(descripcion As String) As Long
    Dim rs As ADOR.Recordset
    Set rs = Aplicacion.Unidades.TraerTodos
    rs.Filter = "DESCRIPCION='" & descripcion & "'"
    
    If rs.RecordCount = 0 Then
        Stop
        BuscaIdUnidad = -1
    Else
        BuscaIdUnidad = rs!IdUnidad
    End If

    Set rs = Nothing
End Function

Function BuscaIdCliente(descripcion As String) As Long
    Dim rs As ADOR.Recordset
    Set rs = Aplicacion.Clientes.TraerTodos
    rs.Filter = "[Razon social]='" & descripcion & "'"
    
    If rs.RecordCount = 0 Then
        Stop
        BuscaIdCliente = -1
    Else
        BuscaIdCliente = rs!IdCliente
    End If

    Set rs = Nothing
End Function

Function BuscaIdMaquina(descripcion As String) As Long
    Dim rs As ADOR.Recordset
    Set rs = AplicacionProd.Maquinas.TraerTodos
    rs.Filter = "DESCRIPCION='" & descripcion & "'"
    
    Dim art As ComPronto.Articulo
    'set art=aplicacion.Articulos.Item(rs!idarticulo
    
    'If rs.RecordCount = 0 Then Stop
    
    BuscaIdMaquina = BuscaIdArticulo(descripcion)  'rs!IdMaquina
    Set rs = Nothing
End Function

Function BuscaIdProceso(descripcion As String) As Long
    Dim rs As ADOR.Recordset
    Set rs = AplicacionProd.Procesos.TraerTodos
    rs.Filter = "DESCRIPCION='" & descripcion & "'"
    
    If rs.RecordCount = 0 Then Stop
    BuscaIdProceso = rs!IdProduccionProceso
    Set rs = Nothing
End Function

Function BuscaIdUbicacion(descripcion As String) As Long
    Dim rs As ADOR.Recordset
    Set rs = Aplicacion.Ubicaciones.TraerTodos
    rs.Filter = "Ubicacion='" & descripcion & "'"
    
    If rs.RecordCount = 0 Then
        'Stop
        BuscaIdUbicacion = -1
    Else
        BuscaIdUbicacion = rs!idUbicacion
    End If
    
    Set rs = Nothing
End Function

Function BuscaIdUbicacionDescripcionLarga(descripcion As String) As Long
    Dim rs As ADOR.Recordset
    Set rs = Aplicacion.TablasGenerales.TraerLista("Ubicaciones") 'esta en la descripcion trae el nombre del deposito, NO el alias de la ubicacion
    rs.Filter = "Titulo ='" & descripcion & "'"

    '
    '
    '    'busco el idDeposito asociado a la ubicacion
    '    Set rs = Aplicacion.Ubicaciones.TraerTodos
    '    rs.Filter = "Titulo = '%" & Left(descripcion, InStr(descripcion, "-")) & "%'"
    '    idDepositoDeLaUbicacion = rs.Fields(0)
    '
    '    'traigo el nombre del deposito
    '
    '    'finalmente, busco la ubicacion
    '    dep=instr()
    '    est
    '    mod
    '    gab
    '
    '    'rs.Filter = "Deposito+' - Est.:'+Estanteria+' - Mod.:'+Modulo+' - Gab.:'+Gabeta='" & descripcion & "'"
    '    rs.Filter = "Deposito+' - Est.:'='" & descripcion & "'"
    '
    If rs.RecordCount = 0 Then
        Stop
        BuscaIdUbicacionDescripcionLarga = -1
    Else
        BuscaIdUbicacionDescripcionLarga = rs!idUbicacion
    End If

    Set rs = Nothing
End Function

Function BuscaIdDeposito(descripcion As String) As Long
    Dim rs As ADOR.Recordset
    Set rs = Aplicacion.Depositos.TraerTodos
    rs.Filter = "Descripcion='" & descripcion & "'"
    
    If rs.RecordCount = 0 Then
        Stop
        BuscaIdDeposito = -1
    Else
        BuscaIdDeposito = rs!IdDeposito
    End If
    
    Set rs = Nothing
End Function


Public Function GuardarOrdenDesdeGUI(ByRef oOP As ComPronto.ProduccionOrden) As MisEstados
    'Para independizarme de la compilacion del COM
    
    'Dim Aplicacion As ComPronto.Aplicacion
    'Dim oGeneral 'As InterFazMTS.iCompMTS
    
    'Set Aplicacion = New ComPronto.Aplicacion
    'Set oGeneral = CreateObject("MTSPronto.General")
   
    'Dim oSrv As InterFazMTS.iCompMTS
    'Set oSrv = CreateObject("MTSPronto.General")
   
       Dim oSrv 'As MTSPronto.ProduccionOrden
   
   Set oSrv = CreateObject("MTSPronto.ProduccionOrden")

    
    On Error GoTo MalGuardar


   
   oOP.Registro.Update
   
   
   GuardarOrdenDesdeGUI = ProduccionOrden_MTSGuardar(oOP.Registro, oOP.DetProduccionOrdenes.Registros, oOP.DetProduccionOrdenesProcesos.Registros)
   Set oSrv = Nothing
   
   
   '///////////////////////////////////////////////
   'MARIANO: CIERRE A través de BUS
   '///////////////////////////////////////////////
    Dim oGeneral As InterFazMTS.iCompMTS
    
    Set oGeneral = CreateObject("MTSPronto.General")
         
     
   
     Dim xrs As ADOR.Recordset
     Set xrs = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionOrdenes", "_TienePartesAbiertosAsociados", oOP.Registro!IdProduccionOrden)
     Dim yRs As ADOR.Recordset
     Set yRs = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionOrdenes", "_TieneProcesosObligatoriosSinCumplir", oOP.Registro!IdProduccionOrden)
     
     
     
     If oOP.Registro.Fields("Confirmado").Value = "SI" _
        And Not oOP.Registro.Fields("Cerro").Value = "SI" _
        And Not xrs.RecordCount = 0 _
        And Not yRs.RecordCount = 0 Then 'para no grabar dos veces
        
     
     
     
        oOP.Registro.Fields("Cerro").Value = "SI"
        oOP.Registro.Update
     End If
     
     
    
    
    
    If oOP.Registro.Fields("Anulada") = "SI" Then
         'no señor!!!!! lo que tenes que hacer es llamar a todos los PP de esta OP,
         'y es el PP el que sabrá anularse  !!!!! Porque es él el que tiene el
         '    IdSMConsumo, el IdOIProducto y el IdOISubProducto!!!
        
        
        Dim rs As ADOR.Recordset
        Set rs = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionPartes", "_PorIdOrden", oOP.Registro!IdProduccionOrden)
        
        Dim PP As ComPronto.ProduccionParte
        
        While Not rs.EOF
            Set PP = Aplicacion.ProduccionPartes.Item(rs!idProduccionParte)
            If iisNull(PP.Registro!Anulada, "NO") <> "SI" Then
                PP.Registro!Anulada = "SI"
                PP.Guardar
            End If
            rs.MoveNext
        Wend
        Set rs = Nothing
    End If
     
     
     
     
   Set oGeneral = Nothing
   '///////////////////////////////////////////////
   'MARIANO: FIN
   '///////////////////////////////////////////////
         
   
   
   Exit Function

MalGuardar:
   Err.Raise Err.Number, Err.Source, Err.Description
   Resume

End Function

Private Function OP_iCompMTS_GuardarPorRef(ByVal NombreTabla As String, ByRef vData As ADOR.Recordset) As InterFazMTS.MisEstados
'
'   Dim oCont 'As ObjectContext
'   Dim oA As GralUpd
'   Dim lErr As Long, sSource As String, sDesc As String
'
'   On Error GoTo Mal
'
'   Set oCont = GetObjectContext
'
'   If oCont Is Nothing Then
'      Set oA = CreateObject("MTSPronto.GralUpd")
'   Else
'      Set oA = oCont.CreateInstance("MTSPronto.GralUpd")
'   End If
'
'   iCompMTS_GuardarPorRef = oA.GuardarPorRef(NombreTabla, vData)
'   If Not oCont Is Nothing Then
'      With oCont
'         If .IsInTransaction Then .SetComplete
'      End With
'   End If
'
'Salir:
'   Set oA = Nothing
'   Set oCont = Nothing
'   On Error GoTo 0
'   If lErr Then
'      Err.Raise lErr, sSource, sDesc
'   End If
'   Exit Function
'
'Mal:
'   If Not oCont Is Nothing Then
'      With oCont
'         If .IsInTransaction Then .SetAbort
'      End With
'   End If
'   With Err
'      lErr = .Number
'      sSource = .Source
'      sDesc = .Description
'   End With
'   Resume Salir

End Function


Public Function ProduccionOrden_MTSGuardar(ByRef ProduccionOrden As ADOR.Recordset, _
                        ByVal Detalles As ADOR.Recordset, _
                        ByVal Detalles2 As ADOR.Recordset) As InterFazMTS.MisEstados

   Dim oCont 'As ObjectContext
   Dim oDet As iCompMTS
   Dim Resp As InterFazMTS.MisEstados
   Dim lErr As Long, sSource As String, sDesc As String
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim Datos As ADOR.Recordset
   Dim DatosStock As ADOR.Recordset
   Dim oRsCostos As ADOR.Recordset
   Dim oRsCostosDolares As ADOR.Recordset
   Dim oFld As ADOR.Field
   Dim i As Integer
   Dim mvarStockActual As Double, mvarStockTotal As Double, mvarCantidad As Double
   Dim mvarUltimoCosto As Double, mvarUltimoCostoDolares As Double
   Dim mvarCantidadAnterior As Double, mvarCantidadComponente As Double
   Dim mvarIdCosto As Long, mvarIdDetalleProduccionOrden As Long
   Dim mvarIdentificador As Long, mvarIdDetalleProduccionOrdenAnt As Long
   Dim mvarIdArticuloAnt As Long, mvarIdUbicacionAnt As Long, mvarIdObraAnt As Long
   Dim mvarPartidaAnt As Long, mvarIdUnidadAnt As Long, mIdArticulo As Long, mPartida As Long
   Dim mvarDescargaPorKitAnt As String, mvarDescargaPorKit As String
   Dim mvarAnulada As String
   
   On Error GoTo Mal
   
   
      Set oDet = CreateObject("MTSPronto.General")
   
   mvarIdentificador = ProduccionOrden.Fields(0).Value
   mvarAnulada = IIf(IsNull(ProduccionOrden.Fields("Anulada").Value), "NO", ProduccionOrden.Fields("Anulada").Value)
   
   Resp = OP_iCompMTS_GuardarPorRef("ProduccionOrdenes", ProduccionOrden)
   
   If mvarIdentificador > 0 Then
      Set oRs = oDet.TraerFiltrado("DetProduccionOrdenes", "_Todos", mvarIdentificador)
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            mIdArticulo = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
            'mPartida = IIf(IsNull(oRs.Fields("Partida").Value), 0, oRs.Fields("Partida").Value)
            mvarDescargaPorKit = IIf(IsNull(oRs.Fields("DescargaPorKit").Value), "NO", oRs.Fields("DescargaPorKit").Value)

            If mvarAnulada = "SI" Then
               


            End If
            oRs.MoveNext
         Loop
      End If
      oRs.Close
   End If
   
   With Detalles
      
      If .State <> adStateClosed Then
      
         If Not .EOF Then
            .Update
            .MoveFirst
         End If
         
         Do While Not .EOF
            
            .Fields("IdProduccionOrden").Value = ProduccionOrden.Fields(0).Value
            .Update
            
            mvarIdDetalleProduccionOrdenAnt = IIf(IsNull(.Fields(0).Value), 0, .Fields(0).Value)
            mvarCantidad = IIf(IsNull(.Fields("Cantidad").Value), 0, .Fields("Cantidad").Value)
            
            mvarCantidadAnterior = 0
            mvarIdArticuloAnt = 0
            mvarIdUbicacionAnt = 1
            mvarIdObraAnt = 0
            mvarPartidaAnt = 0
            mvarIdUnidadAnt = 0
            mvarDescargaPorKitAnt = "NO"
            If mvarIdDetalleProduccionOrdenAnt > 0 Then
               Set oRs = oDet.LeerUno("DetProduccionOrdenes", .Fields(0).Value)
               If oRs.RecordCount > 0 Then
                  mvarCantidadAnterior = IIf(IsNull(oRs.Fields("Cantidad").Value), 0, oRs.Fields("Cantidad").Value)
                  mvarIdArticuloAnt = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
                  mvarIdUbicacionAnt = IIf(IsNull(oRs.Fields("IdUbicacion").Value), 1, oRs.Fields("IdUbicacion").Value)
                  mvarIdObraAnt = IIf(IsNull(oRs.Fields("IdObra").Value), 0, oRs.Fields("IdObra").Value)
                  'mvarPartidaAnt = IIf(IsNull(oRs.Fields("Partida").Value), 0, oRs.Fields("Partida").Value)
                  mvarIdUnidadAnt = IIf(IsNull(oRs.Fields("IdUnidad").Value), 0, oRs.Fields("IdUnidad").Value)
                  mvarDescargaPorKitAnt = IIf(IsNull(oRs.Fields("DescargaPorKit").Value), "NO", oRs.Fields("DescargaPorKit").Value)
               End If
               oRs.Close
               Set oRs = Nothing
            End If
            
            If .Fields("Eliminado").Value Then
               
               oDet.Eliminar "DetProduccionOrdenes", .Fields(0).Value
               mvarCantidad = 0
            
            Else
               
               Set Datos = CreateObject("ADOR.Recordset")
               For i = 0 To .Fields.Count - 2
                  With .Fields(i)
                     Datos.Fields.Append .Name, .type, .DefinedSize, .Attributes
                     Datos.Fields(.Name).Precision = .Precision
                     Datos.Fields(.Name).NumericScale = .NumericScale
                  End With
               Next
               Datos.Open
               Datos.AddNew
               For i = 0 To .Fields.Count - 2
                  With .Fields(i)
                     Datos.Fields(i).Value = .Value
                  End With
               Next
               Datos.Update
               Resp = oDet.Guardar("DetProduccionOrdenes", Datos)
               mvarIdDetalleProduccionOrden = Datos.Fields(0).Value
               Datos.Close
               Set Datos = Nothing
            
               'Log
               oDet.Tarea "Log_InsertarRegistro", _
                  Array("OP", ProduccionOrden.Fields(0).Value, _
                        mvarIdDetalleProduccionOrden, Now, mvarCantidad * -1, "")
            End If
            
'            If mvarIdDetalleProduccionOrdenAnt <= 0 And mvarAnulada <> "SI" Then
'               'Registro de costo promedio ponderado
'               Set DatosStock = oDet.TraerFiltrado("Stock", "_ExistenciaPorArticulo", .Fields("IdArticulo").Value)
'               mvarStockActual = 0
'               If DatosStock.RecordCount > 0 Then
'                  mvarStockActual = DatosStock.Fields("Stock actual").Value
'               End If
'               mvarStockTotal = mvarStockActual - mvarCantidad
'               DatosStock.Close
'               Set DatosStock = Nothing
'
'            End If
            
            
            
'            If Not IsNull(.Fields("IdDetalleValeSalida").Value) Then
'               oDet.Tarea "ValesSalida_AsignarEntrega", .Fields("IdDetalleValeSalida").Value
'            End If
            
            .MoveNext
         
         Loop
      
      End If
   
   End With
   
   
   With Detalles2
      
      If .State <> adStateClosed Then
      
         If Not .EOF Then
            .Update
            .MoveFirst
         End If
         
         Do While Not .EOF
            
            .Fields("IdProduccionOrden").Value = ProduccionOrden.Fields(0).Value
            .Update
            
            mvarIdDetalleProduccionOrdenAnt = IIf(IsNull(.Fields(0).Value), 0, .Fields(0).Value)
            
            If .Fields("Eliminado").Value Then
               
               oDet.Eliminar "DetProduccionOrdenProcesos", .Fields(0).Value
               mvarCantidad = 0
            
            Else
               
               Resp = oDet.Guardar("DetProduccionOrdenesProcesos", Detalles2)
               mvarIdDetalleProduccionOrden = .Fields(0).Value
            
               'Log
               oDet.Tarea "Log_InsertarRegistro", _
                  Array("SA", ProduccionOrden.Fields(0).Value, _
                        mvarIdDetalleProduccionOrden, Now, mvarCantidad * -1, "")
            End If
            
            
            .MoveNext
         
         Loop
      
      End If
   
   End With
   
   
   
   
   'Log
   'oDet.Tarea "Log_InsertarRegistro", Array("ProduccionOrden", ProduccionOrden.Fields(0).Value, 0, Now, 0, "Fin")
   
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetComplete
      End With
   End If
   
Salir:
   ProduccionOrden_MTSGuardar = Resp
   Set oRs = Nothing
   Set oRs1 = Nothing
   Set oDet = Nothing
   Set oCont = Nothing
   On Error GoTo 0
   If lErr Then
      Err.Raise lErr, sSource, sDesc
   End If
   Exit Function
   
Mal:
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetAbort
      End With
   End If
   With Err
      lErr = .Number
      sSource = .Source
      sDesc = .Description
   End With
   oDet.Tarea "Log_InsertarRegistro", Array("MTSSA", ProduccionOrden.Fields(0).Value, 0, Now, 0, _
         "Error " & Err.Number & Err.Description & ", " & Err.Source, _
         "MTSPronto " & app.Major & " " & app.Minor & " " & app.Revision)
   Resume Salir

End Function

Sub BuscarDetProduccionOrdenesCerradosPorEsteParteYLiberarlos(IdParte)
  On Error GoTo Mal
       
    Dim sSQL As String
    
    sSQL = " Update DetalleProduccionOrdenes" & _
           " Set IdProduccionParteQueCerroEsteInsumo = NULL" & _
           " Where IdProduccionParteQueCerroEsteInsumo=" & IdParte
   
    
    execSQL sSQL
    'Aplicacion.Tarea sSQL vvvvvv
    'Aplicacion.Tarea "SalidasMateriales_AjustarStockSalidaMaterialesAnulada", 22
    
       Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case -2147217900, -2147217873
         mvarResp = MsgBox("Se ha producido un error en BuscarDetProduccionOrdenesCerradosPorEsteParteYLiberarlos. No puede borrar este registro porque se esta" & vbCrLf & "utilizando en otros archivos. Desea ver detalles?", vbYesNo + vbCritical)
         If mvarResp = vbYes Then
            MsgBox "Detalle del error : " & vbCrLf & Err.Number & " -> " & Err.Description
         End If
      Case Else
         MsgBox "Se ha producido un error en BuscarDetProduccionOrdenesCerradosPorEsteParteYLiberarlos. " & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select
   
   'Aplicacion.Tarea "Log_InsertarRegistro", Array("ANUL", mvarId, 0, Now, 0, "Tabla : PartesProduccion", GetCompName(), glbNombreUsuario)
    
   
End Sub


Public Function GuardarParteDesdeGUI(ByRef oParte As ComPronto.ProduccionParte) As MisEstados
    'Para independizarme de la compilacion del COM
    
    'Dim Aplicacion As ComPronto.Aplicacion
    'Dim oGeneral 'As InterFazMTS.iCompMTS
    
    'Set Aplicacion = New ComPronto.Aplicacion
    'Set oGeneral = CreateObject("MTSPronto.General")
   
    Dim oSrv As InterFazMTS.iCompMTS
    Set oSrv = CreateObject("MTSPronto.General")
   
    On Error GoTo MalGuardar
   
    'se cerró el proceso anterior?
    Dim xrs As ADOR.Recordset
    Dim Prod As ProduccionPartes
    'Set Prod = New ProduccionPartes
    Set xrs = Aplicacion.ProduccionPartes.TraerFiltrado("_ProcesoAnteriorCerrado", Array(oParte.Registro!IdProduccionOrden, oParte.Registro!IdProduccionProceso))
    Set Prod = Nothing
    
    Dim op As ComPronto.ProduccionOrden
    Set op = AplicacionProd.ProduccionOrdenes.Item(oParte.Registro!IdProduccionOrden)

    Dim proceso As ComPronto.proceso
    Set proceso = AplicacionProd.Procesos.Item(oParte.Registro!IdProduccionProceso)
    
    Dim oI As ComPronto.OtroIngresoAlmacen
    Dim DetOI As ComPronto.DetOtroIngresoAlmacen

    Dim SM As ComPronto.SalidaMateriales
    Dim DetSM As ComPronto.DetSalidaMateriales
    
    
    
    
   
    
    
    '////////////////////////////////////////////////
    '////////////////////////////////////////////////
    'ANULACION!!!!!
    '////////////////////////////////////////////////
    '////////////////////////////////////////////////
    If iisNull(oParte.Registro!Anulada, "NO") = "SI" Then
       
       
       
       'hay que marcar el item de la OP para que ya no diga "LISTO! insumo cerrado en parte n°XXX"
       
       BuscarDetProduccionOrdenesCerradosPorEsteParteYLiberarlos (oParte.Registro!idProduccionParte)
             
       
       
        If IsNumeric(oParte.Registro!IdSMConsumo) Then
    
            Set SM = Aplicacion.SalidasMateriales.Item(oParte.Registro!IdSMConsumo)

            With SM.Registro

                .Fields("Anulada").Value = "SI"
                .Fields("IdUsuarioAnulo").Value = oParte.Registro!IdEmpleado
                .Fields("FechaAnulacion").Value = Now
                .Fields("MotivoAnulacion").Value = "MODULO PRODUCCION: anulación automática"
               
            End With

            SM.Guardar
            Aplicacion.Tarea "SalidasMateriales_AjustarStockSalidaMaterialesAnulada", oParte.Registro!IdSMConsumo
            'oDet.Tarea "DetSalidasMateriales_AnularConsumos", oRs.Fields(0).Value
        End If
     
        '////////////////////////////////////////////////
        '////////////////////////////////////////////////
         
        If IsNumeric(oParte.Registro!idoiproducto) Then
            Set oI = Aplicacion.OtrosIngresosAlmacen.Item(oParte.Registro!idoiproducto)

            With oI.Registro
                .Fields("Anulado").Value = "SI"
                .Fields("IdAutorizaAnulacion").Value = oParte.Registro!IdEmpleado
                .Fields("FechaAnulacion").Value = Now
                .Fields("Observaciones").Value = .Fields("Observaciones").Value & "  MODULO PRODUCCION: anulación automática"
            End With

            oI.Guardar
            Aplicacion.Tarea "OtrosIngresosAlmacen_AjustarStockPorAnulacion", oParte.Registro!idoiproducto
        End If
         
        '////////////////////////////////////////////////
        '////////////////////////////////////////////////
         
        If IsNumeric(oParte.Registro!idoisubproducto) Then
            Set oI = Aplicacion.OtrosIngresosAlmacen.Item(oParte.Registro!idoisubproducto)

            With oI.Registro
                .Fields("Anulado").Value = "SI"
                .Fields("IdAutorizaAnulacion").Value = oParte.Registro!IdEmpleado
                .Fields("FechaAnulacion").Value = Now
                .Fields("Observaciones").Value = .Fields("Observaciones").Value & "  MODULO PRODUCCION: anulación automática"
            End With

            oI.Guardar
            Aplicacion.Tarea "OtrosIngresosAlmacen_AjustarStockPorAnulacion", oParte.Registro!idoisubproducto
        End If
     
    Else
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
            
        If xrs.RecordCount > 0 Then
            '    Err.Raise vbObjectError + 513, "ProduccionParte", "El proceso anterior no está cerrado"
            '    Set oSrv = Nothing
            '    Exit Function
        End If
            
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
            
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '·          Cuando se trate de la fabricación de un “semi-elaborado”, en el
        '    Parte de Producción ser realizará el Pesaje del Artículo Producido y se generará un movimiento en stock de “otros ingresos almacén”.
            
        Dim mN
        Dim oPar As ComPronto.Parametro
        
        Set oPar = Aplicacion.Parametros.Item(1) 'me traigo el renglon de parámetros
        Dim art As ComPronto.Articulo
            
        If IsNumeric(oParte.Registro!CantidadGenerado) And Not IsNumeric(oParte.Registro!idoiproducto) Then
                
            Set op = AplicacionProd.ProduccionOrdenes.Item(oParte.Registro!IdProduccionOrden)
            Set art = Aplicacion.Articulos.Item(op.Registro!idArticuloGenerado)
                
            Dim oRsTipo As ADOR.Recordset
            Set oRsTipo = Aplicacion.Tipos.TraerTodos
            oRsTipo.Filter = "Descripcion='Terminado'"
                
            If True Or oRsTipo.RecordCount > 0 Then
                If True Or art.Registro!Idtipo <> oRsTipo!Idtipo Then 'agruegué un True para obviar la verificacion de Terminado
                       
                    '///////////////////////////////////////////////
                    '///////////////////////////////////////////////
                    '///////////////////////////////////////////////
                    '///////////////////////////////////////////////
                    'Hago el ingreso del producido
                    '///////////////////////////////////////////////
                    '///////////////////////////////////////////////
                
                    'Traigo proximos numeros
                    
                    With oPar.Registro
                        mN = .Fields("ProximoNumeroOtroIngresoAlmacen").Value
                        .Fields("ProximoNumeroOtroIngresoAlmacen").Value = mN + 1
                    End With
                    
                    '////////////////////
                    
                    'encabezado
                    Set oI = Aplicacion.OtrosIngresosAlmacen.Item(-1)

                    With oI.Registro
                        !NumeroOtroIngresoAlmacen = mN
                        '!Cliente = op.Registro!Cliente
                        !FechaOtroIngresoAlmacen = Date
                        '!IdColor = 33
                        !TipoIngreso = 4          ' este tipo esta apareciendo como "devolucion"... de donde salen?
                        !IdObra = TraerValorParametro2("IdObraDefault")
        
                        !Observaciones = "MODULO PRODUCCION: Creado por Parte de Produccion " & oParte.Registro!idProduccionParte & " para OP " & op.Registro!NumeroOrdenProduccion
                        '"MODULO PRODUCCION: Creado por Parte de Produccion " & oParte.Registro!idProduccionParte & " para OP " & oParte.Registro!IdProduccionOrden
                        'acá qué se carga???? el deposito o la ubicacion???? se carga la ubicacion en el detalle
                    
                        !Emitio = oParte.Registro!IdEmpleado
                        !Aprobo = oParte.Registro!IdEmpleado
                    End With
                
                    'cuerpo
                    Set DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)

                    With DetOI.Registro
                        !IdArticulo = op.Registro!idArticuloGenerado
                        !Cantidad = oParte.Registro!CantidadGenerado
                        !IdUnidad = art.Registro!IdUnidad

                        '!IdStock = Registro!IdUnidad
                        
                        
                    
                        
                        
                        
           
                 
                        
                        
                        !IdObra = TraerValorParametro2("IdObraDefault")
                        !partida = op.Registro!NumeroOrdenProduccion
                        !idUbicacion = proceso.Registro!idUbicacion ' TraerValorParametro2("IdUbicacionDestinoProduccionGenerico")
                        !Observaciones = "MODULO PRODUCCION: Creado por Parte de Produccion " & oParte.Registro!idProduccionParte & " para OP " & op.Registro!NumeroOrdenProduccion
                        
                        
                        
                        
                    '    If False Then 'revisar foreign key
                    '        If Not IsNull(op.Registro!IdColor) Then !IdColor = op.Registro!IdColor
                    '    Else
                    '        !IdColor = 2 '1 se puede, pero 822 no????? -encima el idcolor 1 no existe!!! y el 822 sí!!!
                    ' esto es porque estaba al reves el orden de talle y idcolor?????? -creo que sí
                    '    End If
                        
                        !IdColor = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", oParte.Registro!IdStock).Fields("IdColor") ' TraerValorParametro2("IdObraDefault")
                        '!IdColor = 2 ' esto es porque estaba al reves el orden de talle y idcolor?????? -creo que sí
                        'verificar que no Idobra y idcolor sea ni null ni 0 -pero idcolor no puede ser null?
                        If !IdColor <= 0 Or iisNull(!IdObra, 0) <= 0 Then
                            Err.Raise 22000 Or vbObjectError, "PonerEnCeroElStockOriginalSobrante", "IdColor o IdObra invalidos"
                        End If
                        
                        '"MODULO PRODUCCION: Creado por Parte de Produccion " & oParte.Registro!idProduccionParte & " para OP " & oParte.Registro!IdProduccionOrden
                    End With

                    DetOI.Modificado = True
                
                    oI.Guardar
                    oParte.Registro!idoiproducto = oI.Registro.Fields(0)
                
                End If
            End If
        End If

        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
                 
        If iisNull(oParte.Registro!Cantidaddeshecho, 0) <> 0 And Not IsNumeric(oParte.Registro!idoisubproducto) Then
                
            Set op = AplicacionProd.ProduccionOrdenes.Item(oParte.Registro!IdProduccionOrden)
            Set art = Aplicacion.Articulos.Item(oParte.Registro!idArticulodeshecho)
                
            Set oRsTipo = Aplicacion.Tipos.TraerTodos
            oRsTipo.Filter = "Descripcion='Terminado'"
                
            'If art.Registro!idTipo <> oRsTipo!idTipo Then
                       
            '///////////////////////////////////////////////
            '///////////////////////////////////////////////
            '///////////////////////////////////////////////
            '///////////////////////////////////////////////
            'Hago el ingreso del producido
            '///////////////////////////////////////////////
            '///////////////////////////////////////////////
                
            'Traigo proximos numeros
                    
            With oPar.Registro
                mN = .Fields("ProximoNumeroOtroIngresoAlmacen").Value
                .Fields("ProximoNumeroOtroIngresoAlmacen").Value = mN + 1
            End With
                    
            '////////////////////
                    
            'encabezado
            Set oI = Aplicacion.OtrosIngresosAlmacen.Item(-1)

            With oI.Registro
                !NumeroOtroIngresoAlmacen = mN
                '!Cliente = op.Registro!Cliente
                !FechaOtroIngresoAlmacen = Date
                '!IdColor = 33
                !TipoIngreso = 4          ' este tipo esta apareciendo como "devolucion"... de donde salen?
                !IdObra = TraerValorParametro2("IdObraDefault")
        
                !Observaciones = "MODULO PRODUCCION: Creado por Parte de Produccion " & oParte.Registro!idProduccionParte & " para OP " & op.Registro!NumeroOrdenProduccion
                '"MODULO PRODUCCION: Creado por Parte de Produccion " & oParte.Registro!idProduccionParte & " para OP " & oParte.Registro!IdProduccionOrden
                'acá qué se carga???? el deposito o la ubicacion???? se carga la ubicacion en el detalle
                    
                !Emitio = oParte.Registro!IdEmpleado
                !Aprobo = oParte.Registro!IdEmpleado
            End With
                
            'cuerpo
            Set DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)

            With DetOI.Registro
                !IdArticulo = oParte.Registro!idArticulodeshecho
                !Cantidad = oParte.Registro!Cantidaddeshecho
                !IdUnidad = art.Registro!IdUnidad
                '!IdStock = Registro!IdUnidad
                !partida = op.Registro!NumeroOrdenProduccion
                !idUbicacion = proceso.Registro!idUbicacion 'el deshecho queda en la misma ubicacion que el consumo?
                !Observaciones = "MODULO PRODUCCION: Creado por Parte de Produccion " & oParte.Registro!idProduccionParte & " para OP " & op.Registro!NumeroOrdenProduccion
                '"MODULO PRODUCCION: Creado por Parte de Produccion " & oParte.Registro!idProduccionParte & " para OP " & oParte.Registro!IdProduccionOrden
                !IdObra = TraerValorParametro2("IdObraDefault")
            End With

            DetOI.Modificado = True
                
            oI.Guardar
                    
            oParte.Registro!idoisubproducto = oI.Registro.Fields(0)
                
            'End If
        End If

        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
                 
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        
        If IsNumeric(oParte.Registro!IdArticulo) And Not IsNumeric(oParte.Registro!IdSMConsumo) And iisNull(oParte.Registro!Cantidad, 0) > 0 Then
            '·          Con el Parte de Producción (Pesaje), se incorporar los
            'materiales a la Orden de Producción y se generará un movimiento de “Salida de Materiales” en el depósito asociado al proceso en el cual se incorporaron.
        
            '///////////////////////////////////////////////
            'Hago el egreso del material usado
             
            With oPar.Registro
                mN = .Fields("ProximoNumeroSalidaMateriales").Value
                .Fields("ProximoNumeroSalidaMateriales").Value = mN + 1
            End With
                
            Set SM = Aplicacion.SalidasMateriales.Item(-1)

            With SM.Registro
                !NumeroSalidaMateriales = mN
                !TipoSalida = 1 'Salida a Fabrica
                !Cliente = op.Registro!Cliente   'Registro!Cliente
                !FechaSalidaMateriales = Date
                '!IdColor = Registro!Color
                !IdObra = TraerValorParametro2("IdObraDefault")
                !Observaciones = "MODULO PRODUCCION: Creado por Parte de Produccion " & oParte.Registro!idProduccionParte & " para OP " & op.Registro!NumeroOrdenProduccion
                '"MODULO PRODUCCION: Creado por Parte de Produccion " & oParte.Registro!idProduccionParte & " para OP " & oParte.Registro!IdProduccionOrden
                '!IdDepositoOrigen =
                'acá qué se carga???? el deposito o la ubicacion???? se carga la ubicacion en el detalle
                
                !Emitio = oParte.Registro!IdEmpleado
                !Aprobo = oParte.Registro!IdEmpleado
            End With
                
            '//////////////
            'OPCION 1 'usando lo mostrado en la listview para chupar los datos
            'Dim i As Integer
            'For i = 1 To Lista.ListItems.Count
            '    Set DetSM = SM.DetSalidasMateriales.Item(-1)
            '    With DetSM.Registro
            '        origen.DetProduccionOrdenes.Item(Lista.ListItems(i).Tag
            '        Set origen = oProduccionOrden.DetProduccionOrdenes.Item(IdArticulo)
            '        !IdArticulo = Lista.ListItems(i).Tag
            '        !cantidad = Lista.ListItems(i).SubItems(5)
            '
            '        ##
            '        !IdUnidad =
            '    End With
            '    DetSM.Modificado = True
            'Next i
                    
            '//////////////
            'OPCION 2 'usando recordset en lugar de la listview para chupar los datos
            'Dim oRsT As ador.Recordset
            'Set oRsT = DetProduccionOrdenes.Registros
            'If oRsT.State <> 0 Then
            '    If oRsT.RecordCount > 0 Then
            '        With oRsT
            '            .MoveFirst
            '            Do While Not .EOF
            '                If Not .Fields("Eliminado").Value Then
            Set DetSM = SM.DetSalidasMateriales.Item(-1)

            With DetSM
                .Registro!IdArticulo = oParte.Registro!IdArticulo
                .Registro!Cantidad = oParte.Registro!Cantidad
                                             
                Set art = Aplicacion.Articulos.Item(oParte.Registro!IdArticulo)
                .Registro!IdUnidad = art.Registro!IdUnidad
                                             
                .Registro!IdObra = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", oParte.Registro!IdStock).Fields("IdObra") ' TraerValorParametro2("IdObraDefault")
                .Registro!IdStock = oParte.Registro!IdStock
                .Registro!partida = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", oParte.Registro!IdStock).Fields("Partida") ' oParte.Registro!Partida
                .Registro!idUbicacion = proceso.Registro!idUbicacion
                                        
                Set art = Aplicacion.Articulos.Item(oParte.Registro!IdArticulo)
         
                .Registro!CostoUnitario = iisNull(art.Registro!CostoReposicion, 0)
                .Registro!Adjunto = "NO"
                .Registro!CotizacionDolar = Cotizacion(Date, glbIdMonedaDolar)
                .Registro!IdMoneda = oPar.Registro!IdMoneda.Value
                                             
                Dim num As Long
                num = TraerNumeroCajaDeIdStock(oParte.Registro!IdStock)


    .Registro!IdColor = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", oParte.Registro!IdStock).Fields("IdColor") ' TraerValorParametro2("IdObraDefault")
                        
                        'verificar que no Idobra y idcolor sea ni null ni 0 -pero idcolor no puede ser null?
                        If .Registro!IdColor <= 0 Or iisNull(.Registro!IdObra, 0) <= 0 Then
                            Err.Raise 22000 Or vbObjectError, "PonerEnCeroElStockOriginalSobrante", "IdColor o IdObra invalidos"
                        End If

                    
                If num > 0 Then .Registro!NumeroCaja = num
                                             
            End With

            DetSM.Modificado = True
            '                End If
            '                .MoveNext
            '            Loop
            '        End With
            '    End If
            'End If
            '///////////////
                    
            oPar.Guardar
            SM.Guardar
            
            oParte.Registro!IdSMConsumo = SM.Registro.Fields(0)
        End If

        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
    End If
   
    oParte.Registro.Update
    GuardarParteDesdeGUI = oSrv.Guardar("ProduccionPartes", oParte.Registro)
   
    'Set Aplicacion = Nothing
    Set op = Nothing
    Set oPar = Nothing
   
    Set oSrv = Nothing
    Exit Function
   
MalGuardar:
    Err.Raise Err.Number, Err.Source, Err.Description
    Resume

End Function


Public Sub CerrarPartePorId(IdParte)
    Dim mvarSale As Integer
    Dim mIdAutorizo As Long

    Dim oParte As ProduccionParte
    Set oParte = Aplicacion.ProduccionPartes.Item(IdParte)
        
  
    With oParte
        .Registro.Fields("IdUsuarioCerro").Value = glbIdUsuario ' mIdAutorizo ' "SI"
        .Registro!fechafinal = Now
       
        GuardarParteDesdeGUI oParte
    End With
         
End Sub





Public Function Test_GenerarOtroIngreso()
    'Para independizarme de la compilacion del COM
    
    'Dim Aplicacion As ComPronto.Aplicacion
    'Dim oGeneral 'As InterFazMTS.iCompMTS
    
    'Set Aplicacion = New ComPronto.Aplicacion
    'Set oGeneral = CreateObject("MTSPronto.General")
   
    Dim oSrv As InterFazMTS.iCompMTS
    Set oSrv = CreateObject("MTSPronto.General")
   
    'On Error GoTo MalGuardar
   
    'se cerró el proceso anterior?
    Dim xrs As ADOR.Recordset
    Dim Prod As ProduccionPartes
    'Set Prod = New ProduccionPartes
    'Set xrs = Aplicacion.ProduccionPartes.TraerFiltrado("_ProcesoAnteriorCerrado", Array(oParte.Registro!IdProduccionOrden, oParte.Registro!IdProduccionProceso))
    Set Prod = Nothing
    
    Dim op As ComPronto.ProduccionOrden
    'Set op = AplicacionProd.ProduccionOrdenes.Item(oParte.Registro!IdProduccionOrden)

    Dim proceso As ComPronto.proceso
    'Set proceso = AplicacionProd.Procesos.Item(oParte.Registro!IdProduccionProceso)
    
    Dim oI As ComPronto.OtroIngresoAlmacen
    Dim DetOI As ComPronto.DetOtroIngresoAlmacen

    Dim SM As ComPronto.SalidaMateriales
    Dim DetSM As ComPronto.DetSalidaMateriales
    
        Dim mN
        Dim oPar As ComPronto.Parametro
        
        Set oPar = Aplicacion.Parametros.Item(1) 'me traigo el renglon de parámetros
        Dim art As ComPronto.Articulo
        
        
        
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
        
        
        
                    '///////////////////////////////////////////////
            'Hago el egreso del material usado
             
            With oPar.Registro
                mN = .Fields("ProximoNumeroSalidaMateriales").Value
                .Fields("ProximoNumeroSalidaMateriales").Value = mN + 1
            End With
                
            Set SM = Aplicacion.SalidasMateriales.Item(-1)

            With SM.Registro
                !NumeroSalidaMateriales = mN
                !TipoSalida = 1 'Salida a Fabrica
                !Cliente = 1 'op.Registro!Cliente   'Registro!Cliente
                !FechaSalidaMateriales = Date
                '!IdColor = Registro!Color
                !IdObra = TraerValorParametro2("IdObraDefault")
                !Observaciones = "MODULO PRODUCCION: Creado por Parte de Produccion " '& oParte.Registro!idProduccionParte & " para OP " & op.Registro!NumeroOrdenProduccion
                '"MODULO PRODUCCION: Creado por Parte de Produccion " & oParte.Registro!idProduccionParte & " para OP " & oParte.Registro!IdProduccionOrden
                '!IdDepositoOrigen =
                'acá qué se carga???? el deposito o la ubicacion???? se carga la ubicacion en el detalle
                
                !Emitio = 1 ' oParte.Registro!IdEmpleado
                !Aprobo = 1 'oParte.Registro!IdEmpleado
            End With
                
            '//////////////
            'OPCION 1 'usando lo mostrado en la listview para chupar los datos
            'Dim i As Integer
            'For i = 1 To Lista.ListItems.Count
            '    Set DetSM = SM.DetSalidasMateriales.Item(-1)
            '    With DetSM.Registro
            '        origen.DetProduccionOrdenes.Item(Lista.ListItems(i).Tag
            '        Set origen = oProduccionOrden.DetProduccionOrdenes.Item(IdArticulo)
            '        !IdArticulo = Lista.ListItems(i).Tag
            '        !cantidad = Lista.ListItems(i).SubItems(5)
            '
            '        ##
            '        !IdUnidad =
            '    End With
            '    DetSM.Modificado = True
            'Next i
                    
            '//////////////
            'OPCION 2 'usando recordset en lugar de la listview para chupar los datos
            'Dim oRsT As ador.Recordset
            'Set oRsT = DetProduccionOrdenes.Registros
            'If oRsT.State <> 0 Then
            '    If oRsT.RecordCount > 0 Then
            '        With oRsT
            '            .MoveFirst
            '            Do While Not .EOF
            '                If Not .Fields("Eliminado").Value Then
            Set DetSM = SM.DetSalidasMateriales.Item(-1)

            With DetSM
                .Registro!IdArticulo = 100 ' oParte.Registro!IdArticulo
                .Registro!Cantidad = 1 ' oParte.Registro!Cantidad
                                             
                'Set art = Aplicacion.Articulos.Item(oParte.Registro!IdArticulo)
                .Registro!IdUnidad = 1 ' art.Registro!IdUnidad
                                             
                .Registro!IdObra = 1 'Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", oParte.Registro!IdStock).Fields("IdObra") ' TraerValorParametro2("IdObraDefault")
                .Registro!IdStock = 1 'oParte.Registro!IdStock
                .Registro!partida = 1 'Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", oParte.Registro!IdStock).Fields("Partida") ' oParte.Registro!Partida
                .Registro!idUbicacion = 1 'proceso.Registro!idUbicacion
                                        
                'Set art = Aplicacion.Articulos.Item(oParte.Registro!IdArticulo)
         
                .Registro!CostoUnitario = 1 'iisNull(art.Registro!CostoReposicion, 0)
                .Registro!Adjunto = "NO"
                .Registro!CotizacionDolar = Cotizacion(Date, glbIdMonedaDolar)
                .Registro!IdMoneda = oPar.Registro!IdMoneda.Value
                                             
                Dim num As Long
                num = 1 'TraerNumeroCajaDeIdStock(oParte.Registro!IdStock)



    .Registro!IdColor = 1 'Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorId", oParte.Registro!IdStock).Fields("IdColor") ' TraerValorParametro2("IdObraDefault")
                        
                        'verificar que no Idobra y idcolor sea ni null ni 0 -pero idcolor no puede ser null?
                        If .Registro!IdColor <= 0 Or iisNull(.Registro!IdObra, 0) <= 0 Then
                            Err.Raise 22000 Or vbObjectError, "PonerEnCeroElStockOriginalSobrante", "IdColor o IdObra invalidos"
                        End If


                If num > 0 Then .Registro!NumeroCaja = num
                                             
            End With

            DetSM.Modificado = True
            '                End If
            '                .MoveNext
            '            Loop
            '        End With
            '    End If
            'End If
            '///////////////
                    
            oPar.Guardar
            SM.Guardar
            

        
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////
            '///////////////////////////////////////////////           ///////////////////////////////////////////////

        
        
    
            '///////////////////////////////////////////////
            'Hago el ingreso del producido
            '///////////////////////////////////////////////
            '///////////////////////////////////////////////
                
            'Traigo proximos numeros
                    
            With oPar.Registro
                mN = .Fields("ProximoNumeroOtroIngresoAlmacen").Value
                .Fields("ProximoNumeroOtroIngresoAlmacen").Value = mN + 1
            End With
                    
            '////////////////////
                    
            'encabezado
            Set oI = Aplicacion.OtrosIngresosAlmacen.Item(-1)

            With oI.Registro
                !NumeroOtroIngresoAlmacen = mN
                '!Cliente = op.Registro!Cliente
                !FechaOtroIngresoAlmacen = Date
                '!IdColor = 33
                !TipoIngreso = 4          ' este tipo esta apareciendo como "devolucion"... de donde salen?
                !IdObra = TraerValorParametro2("IdObraDefault")
        
                !Observaciones = "MODULO PRODUCCION: Creado por Parte de Produccion " '& oParte.Registro!idProduccionParte & " para OP " & op.Registro!NumeroOrdenProduccion
                '"MODULO PRODUCCION: Creado por Parte de Produccion " & oParte.Registro!idProduccionParte & " para OP " & oParte.Registro!IdProduccionOrden
                'acá qué se carga???? el deposito o la ubicacion???? se carga la ubicacion en el detalle
                    
                !Emitio = 1 'oParte.Registro!IdEmpleado
                !Aprobo = 1 'oParte.Registro!IdEmpleado
            End With
                
            'cuerpo
            Set DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)

            With DetOI.Registro
                !IdArticulo = 100 'oParte.Registro!idArticulodeshecho
                !Cantidad = 1 ' oParte.Registro!Cantidaddeshecho
                !IdUnidad = 1 'art.Registro!IdUnidad
                !IdStock = 1 'Registro!IdUnidad
                !partida = "123123" 'op.Registro!NumeroOrdenProduccion
                !idUbicacion = 1 'proceso.Registro!idUbicacion 'el deshecho queda en la misma ubicacion que el consumo?
                !Observaciones = "MODULO PRODUCCION: Creado por Parte de Produccion " '& oParte.Registro!idProduccionParte & " para OP " & op.Registro!NumeroOrdenProduccion
                '"MODULO PRODUCCION: Creado por Parte de Produccion " & oParte.Registro!idProduccionParte & " para OP " & oParte.Registro!IdProduccionOrden
                !IdObra = TraerValorParametro2("IdObraDefault")
                
                !CostoUnitario = 0
                !IdMoneda = 1
                !IdControlCalidad = 1
                !CantidadAdicional = 0
                !Adjunto = "NO"
                !Controlado = "DI"
                !CantidadCC = 0
                
                !Cantidad2 = 0
                !Cantidad1 = 0
                
                !EnviarEmail = 0 'mmmmmmmmm
                
                
'                @IdArticulo int,
'@IdStock int,
'@Partida varchar(20),
'@Cantidad numeric(12,2),
'@CantidadAdicional numeric(12,2),
'@IdUnidad int,
'@Cantidad1 numeric(12,2),
'@Cantidad2 numeric(12,2),
'@Adjunto varchar(2),
!ArchivoAdjunto1 = ""
!ArchivoAdjunto2 = ""
!ArchivoAdjunto3 = ""
!ArchivoAdjunto4 = ""
!ArchivoAdjunto5 = ""
!ArchivoAdjunto6 = ""
!ArchivoAdjunto7 = ""
!ArchivoAdjunto8 = ""
!ArchivoAdjunto9 = ""
!ArchivoAdjunto10 = ""
'@Observaciones ntext,
'@IdUbicacion int,
'@IdObra int,
'@EnviarEmail tinyint,
!IdDetalleOtroIngresoAlmacenOriginal = 1
!IdOtroIngresoAlmacenOriginal = 1
!IdOrigenTransmision = 1
'@CostoUnitario numeric(18,2),
'@IdMoneda int,
'@IdControlCalidad int,
'@Controlado varchar(2),
'@CantidadCC numeric(18,2),
'@CantidadRechazadaCC numeric(18,2),
!IdDetalleSalidaMateriales = 1
!IdEquipoDestino = 1
!IdOrdenTrabajo = 1
!IdDetalleObraDestino = 1
!Talle = "2"

!IdColor = 100


            End With

            DetOI.Modificado = True
                
            oI.Guardar
                    
            'oParte.Registro!idoisubproducto = oI.Registro.Fields(0)
                
            'End If

End Function

'Public Function GetStoreProcedure(ByVal enumNombreSP_Completo As clsNum2Let.enumSPs, Optional ByVal Args As Variant) As Recordset

'End Function
 
   
'End Function





Private Sub execSQL(comando As String)
    Dim cnn As ADODB.Connection
    Dim rst As ADODB.Recordset
    
    Dim tField As ADODB.Field
    '
    ' Por si ya estaba abierta...
    Set cnn = Nothing
    Set rst = Nothing
    '
    ' Crear los objetos
    Set cnn = New ADODB.Connection
    Set rst = New ADODB.Recordset
    '
    
    Dim SC As String
    Dim MydsEncrypt As dsEncrypt
    Set MydsEncrypt = New dsEncrypt
    MydsEncrypt.KeyString = ("EDS")
    SC = MydsEncrypt.Encrypt(glbStringConexion)
    'AnalizarStringConnection
    
    
    ' abrir la base usando las credenciales de Windows
    cnn.Open SC
    '
    
    
    ' abrir el recordset indicando la tabla a la que queremos acceder
    rst.Open comando, cnn, adOpenDynamic, adLockOptimistic
    '
    ' Asignar los nombres de los campos al combo

    '
    ' Cerrar el recordset y la conexión
    'rst.Close
    cnn.Close

End Sub
































'modificacion de mariano
'IMPORTADOR DESARROLLADO PARA CORREDOR CENTRAL, SON LOS COMPROBANTES QUE HACEN POR CUENTA Y ORDEN DE CORREDOR
Public Sub ImportacionComprobantesVenta4()

   Dim oAp As ComPronto.Aplicacion
   Dim oEx As Excel.Application
   
   Dim oFac As ComPronto.Factura
   Dim oCre As ComPronto.NotaCredito
   Dim oDeb As ComPronto.NotaDebito
   Dim oCli As ComPronto.Cliente
   Dim oArt As ComPronto.Articulo
   Dim oCOn As ComPronto.Concepto
   Dim oRec As ComPronto.Recibo
   
   Dim oRs As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim oRsErrores As ADOR.Recordset
   Dim oF As Form
   
   Dim mArchivo As String, mTipo As String, mLetra As String, mCliente As String, mCorredor As String, mCuit As String, mObservaciones As String, mCAI As String
   Dim mComprobante As String, mNumeroObra As String, mPathEntrante As String, mPathBackup As String, mCodigo As String, mDescripcion As String, mArchivoResultados As String
   Dim mCodigoDocumento As String, mDireccion As String, mCodigoPostal As String, mCodigosArticulosPercepcionIIBB As String, mCodigosConceptosPercepcionIIBB As String
   
   Dim fl As Integer, mContador As Integer, mIdMonedaPesos As Integer, mPuntoVenta As Integer, mIdPuntoVenta As Integer, mIdTipoComprobante As Integer, mIdCodigoIva As Integer
   Dim mCodigoIva As Integer, mTipoIIBB As Integer, mIBCondicion As Integer, mCodigoComprobante As Integer, mIdPuntoVentaRecibosContado As Integer, mPuntoVentaRecibo As Integer
   
   Dim mIdArticuloParaImportacionFacturas As Long, mIdArticuloParaImportacionFacturasNoGravado As Long, mNumero As Long, mIdCliente As Long, mIdVendedor As Long
   Dim mIdConceptoParaImportacionNDNC As Long, mIdConceptoParaImportacionNDNCNoGravado As Long, mNumeroCliente As Long, mIdCuenta As Long, mNumeroInicial As Long
   Dim mNumeroFinal As Long, mCodigoId As Long, mIdObra As Long, mIdRubro As Long, mIdSubrubro As Long, mCodigoCliente As Long, mCodigoLocalidad As Long, mIdLocalidad As Long
   Dim mIdProvincia As Long, mIdPais As Long, mIdListaPrecios As Long, mIdCondicionVenta As Long, mIdArticulo As Long, mIdConcepto As Long, mIdComprobante As Long
   Dim mIdImputacion As Long, mNumeroRecibo As Long, mIdCuentaValoresParaReciboVentaContado As Long, mIdCuentaConceptos As Long, mIdIBCondicionPorDefecto As Long
   Dim mIdCuentaPercepcionIIBB As Long
   
   Dim mSubtotal As Double, mIva As Double, mTotal As Double, mNoGravado As Double, mCantidad As Double, mPrecio As Double, mTotalItem As Double, mIvaItem As Double
   Dim mGravadoItem As Double, mNoGravadoItem As Double, mIVANoDiscriminado As Double, mPercepcionIIBB As Double
   Dim mTasa As Single, mCotizacionDolar As Single
   
   Dim mFecha As Date, mFechaCAI As Date
   
   Dim mOk As Boolean, mConProblemas As Boolean
   
   Dim mAux1

   On Error GoTo Mal

   mPathEntrante = "C:\"
   Set oRsAux = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   If oRsAux.RecordCount > 0 Then
      mPathEntrante = IIf(IsNull(oRsAux.Fields("PathImportacionDatos").Value), "C:\", oRsAux.Fields("PathImportacionDatos").Value)
      mPathEntrante = "C:\Backup\BDL\TEMP\"
      mIdMonedaPesos = IIf(IsNull(oRsAux.Fields("IdMoneda").Value), 1, oRsAux.Fields("IdMoneda").Value)
      mIdCuenta = IIf(IsNull(oRsAux.Fields("IdCuentaDeudoresVarios").Value), 0, oRsAux.Fields("IdCuentaDeudoresVarios").Value)
      mTasa = IIf(IsNull(oRsAux.Fields("Iva1").Value), 0, oRsAux.Fields("Iva1").Value)
   End If
   
   
   
   oRsAux.Close
   mPathBackup = mPathEntrante & "Backup\"
   
   mAux1 = TraerValorParametro2("IdRubroDefault")
   mIdRubro = IIf(IsNull(mAux1), 0, mAux1)
   
   mAux1 = TraerValorParametro2("IdSubrubroDefault")
   mIdSubrubro = IIf(IsNull(mAux1), 0, mAux1)
   
   mAux1 = TraerValorParametro2("IdListaPrecios")
   mIdListaPrecios = IIf(IsNull(mAux1), 0, mAux1)
   
   mAux1 = TraerValorParametro2("IdCondicionCompraVentaDefault")
   mIdCondicionVenta = IIf(IsNull(mAux1), 0, mAux1)
   
   mAux1 = TraerValorParametro2("IdConceptoParaImportacionNDNC")
   mIdConceptoParaImportacionNDNC = IIf(IsNull(mAux1), 0, mAux1)
   
   mAux1 = TraerValorParametro2("IdPuntoVentaRecibosContado")
   mIdPuntoVentaRecibosContado = IIf(IsNull(mAux1), 0, mAux1)
   
   mAux1 = TraerValorParametro2("IdCuentaValoresParaReciboVentaContado")
   mIdCuentaValoresParaReciboVentaContado = IIf(IsNull(mAux1), 0, mAux1)
   
   mCodigosArticulosPercepcionIIBB = BuscarClaveINI("Codigos de articulos para percepcion IIBB", -1)
   mCodigosConceptosPercepcionIIBB = BuscarClaveINI("Codigos de conceptos para percepcion IIBB", -1)
   
   If mIdCuenta = 0 Then
      MsgBox "No definio en parametros la cuenta contable deudores varios", vbExclamation
      Exit Sub
   End If
   
   mIdRubro = 1
   If mIdRubro = 0 Then
      MsgBox "No definio en parametros el rubro default para importacion de articulos", vbExclamation
      Exit Sub
   End If
   
   mIdSubrubro = 1
   If mIdSubrubro = 0 Then
      MsgBox "No definio en parametros el subrubro default para importacion de articulos", vbExclamation
      Exit Sub
   End If
   
   mIdCuentaValoresParaReciboVentaContado = 1
   If mIdCuentaValoresParaReciboVentaContado = 0 Then
      MsgBox "No definio en parametros la cuenta default para valores en recibos de venta contado", vbExclamation
      Exit Sub
   End If
   
   
   If mIdPuntoVentaRecibosContado = 0 Then
      Set oRsAux = Aplicacion.PuntosVenta.TraerFiltrado("_PorIdTipoComprobante", 2)
      If oRsAux.RecordCount > 0 Then mIdPuntoVentaRecibosContado = oRsAux.Fields(0).Value
      oRsAux.Close
   End If
   
   Set oAp = Aplicacion

   Set oRsErrores = CreateObject("ADOR.Recordset")
   With oRsErrores
      .Fields.Append "Id", adInteger
      .Fields.Append "Detalle", adVarChar, 1000
   End With
   oRsErrores.Open

   Set oF = New frmAviso
   With oF
      .Label1 = "Abriendo planilla Excel ..."
      .Show
      .Refresh
      DoEvents
   End With

   Set oEx = CreateObject("Excel.Application")
   
   ' ARTICULOS
   mArchivo = Dir(mPathEntrante & "Items.xls", vbArchive)
   If Len(mArchivo) > 0 Then
      fl = 2
      mContador = 0
      
      oF.Label1 = oF.Label1 & vbCrLf & "Procesando articulos ..."
      oF.Label2 = ""
      oF.Label3 = ""
      DoEvents
      
      With oEx
         .Visible = True
         .WindowState = xlMinimized
         Me.Refresh
         With .Workbooks.Open(mPathEntrante & mArchivo)
            '.Sheets("Hoja1").Select
            With .ActiveSheet
               Do While True
                  If Len(Trim(.Cells(fl, 1))) = 0 Then Exit Do
   
                  mConProblemas = False
                  
                  mCodigo = .Cells(fl, 1)
                  mDescripcion = .Cells(fl, 2)
                  
                  mContador = mContador + 1
                  oF.Label2 = "" & mCodigo & " " & mDescripcion
                  oF.Label3 = "" & mContador
                  DoEvents
                  
                  Set oRsAux = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", mCodigo)
                  If oRsAux.RecordCount = 0 Then
                     Set oArt = oAp.Articulos.Item(-1)
                     With oArt
                        With .Registro
                           .Fields("Codigo").Value = mCodigo
                           .Fields("Descripcion").Value = mDescripcion
                           .Fields("IdRubro").Value = mIdRubro
                           .Fields("IdSubrubro").Value = mIdSubrubro
                           .Fields("IdCuantificacion").Value = 1
                           .Fields("FechaAlta").Value = Now
                           .Fields("Observaciones").Value = "Alta automatica por importacion de datos"
                        End With
                        .Guardar
                     End With
                     Set oArt = Nothing
                  End If
                  oRsAux.Close
                  
                  Set oRsAux = Aplicacion.Conceptos.TraerFiltrado("_PorCodigo", mCodigo)
                  If oRsAux.RecordCount = 0 Then
                     Set oCOn = oAp.Conceptos.Item(-1)
                     With oCOn
                        With .Registro
                           .Fields("CodigoConcepto").Value = mCodigo
                           .Fields("Descripcion").Value = mDescripcion
                           .Fields("GravadoDefault").Value = "SI"
                        End With
                        .Guardar
                     End With
                     Set oCOn = Nothing
                  End If
                  oRsAux.Close
                  fl = fl + 1
               Loop
            End With
            If Not mConProblemas Then
               mArchivoResultados = mPathBackup & UCase(mId(mArchivo, 1, Len(mArchivo) - 4)) & " - Correctamente " & Year(Now) & "-" & Format(Month(Now), "00") & "-" & Format(Day(Now), "00") & " " & Format(Hour(Now), "00") & "." & Format(Minute(Now), "00") & "." & Format(Second(Now), "00") & ".xls"
               .ActiveSheet.SaveAs mArchivoResultados
               .Close False
               Kill mPathEntrante & mArchivo
            Else
               .Close False
            End If
         End With
         .Quit
      End With
   End If

   ' CLIENTES
   mArchivo = Dir(mPathEntrante & "Clientes.xls", vbArchive)
   If Len(mArchivo) > 0 Then
      fl = 2
      mContador = 0
      
      oF.Label1 = oF.Label1 & vbCrLf & "Procesando clientes ..."
      oF.Label2 = ""
      oF.Label3 = ""
      DoEvents
      
      With oEx
         .Visible = True
         .WindowState = xlMinimized
         Me.Refresh
         With .Workbooks.Open(mPathEntrante & mArchivo)
            '.Sheets("Hoja1").Select
            With .ActiveSheet
               Do While True
                  If Len(Trim(.Cells(fl, 1))) = 0 Then Exit Do
   
                  mConProblemas = False
                  
                  mCodigoCliente = CLng(.Cells(fl, 1))
                  mCliente = .Cells(fl, 2)
                  mObservaciones = .Cells(fl, 3)
                  mCodigoDocumento = .Cells(fl, 4)
                  mCodigoIva = CInt(.Cells(fl, 7))
                  mTipoIIBB = CInt(.Cells(fl, 9))
                  mDireccion = .Cells(fl, 11)
                  If Len(Trim(.Cells(fl, 12))) > 0 Then mDireccion = mDireccion & " " & .Cells(fl, 12)
                  If Len(Trim(.Cells(fl, 13))) > 0 Then mDireccion = mDireccion & " Piso " & .Cells(fl, 13)
                  If Len(Trim(.Cells(fl, 14))) > 0 Then mDireccion = mDireccion & " Dto. " & .Cells(fl, 14)
                  mCodigoPostal = .Cells(fl, 15)
                  mCodigoLocalidad = CLng(.Cells(fl, 16))
                  
                  mCuit = ""
                  If mCodigoDocumento = "80" Then
                     mCuit = .Cells(fl, 6)
                     If Len(mCuit) <> 13 Then mCuit = mId(mCuit, 1, 2) & "-" & mId(mCuit, 3, 8) & "-" & mId(mCuit, 11, 1)
                  Else
                     If Len(mObservaciones) > 0 Then mObservaciones = mObservaciones & vbCrLf
                     mObservaciones = mObservaciones & .Cells(fl, 4) & " " & .Cells(fl, 6)
                  End If
                  
                  If Len(mCuit) > 0 And Len(mCuit) <> 13 Then
                     AgregarMensajeProcesoPresto oRsErrores, "Clientes : Fila " & fl & ", el cuit " & mCuit & " es incorrecto y el cliente no fue importado."
                     mConProblemas = True
                  End If
                  
                  mIBCondicion = 1
                  If mTipoIIBB = 1 Then mIBCondicion = 3
                  If mTipoIIBB = 2 Then mIBCondicion = 2
                  If mTipoIIBB = 3 Then mIBCondicion = 1
                  If mTipoIIBB = 4 Then mIBCondicion = 1
                  If mTipoIIBB = 5 Then mIBCondicion = 4
                  
                  mContador = mContador + 1
                  oF.Label2 = "" & mCodigo & " " & mCliente
                  oF.Label3 = "" & mContador
                  DoEvents
                  
                  mIdCodigoIva = 0
                  Set oRsAux = oAp.TablasGenerales.TraerFiltrado("DescripcionIva", "_PorCodigoAFIP", mCodigoIva)
                  If oRsAux.RecordCount > 0 Then
                     mIdCodigoIva = oRsAux.Fields(0).Value
                  Else
                     AgregarMensajeProcesoPresto oRsErrores, "Clientes : Fila " & fl & ", el codigo de iva " & mCodigoIva & " es incorrecto y el cliente no fue importado."
                     mConProblemas = True
                  End If
                  oRsAux.Close
                  
                  mIdLocalidad = 0
                  mIdProvincia = 0
                  mIdPais = 0
                  Set oRsAux = oAp.Localidades.TraerFiltrado("_PorCodigo", mCodigoLocalidad)
                  If oRsAux.RecordCount > 0 Then
                     mIdLocalidad = oRsAux.Fields(0).Value
                     mIdProvincia = IIf(IsNull(oRsAux.Fields("IdProvincia").Value), 0, oRsAux.Fields("IdProvincia").Value)
                  Else
                     AgregarMensajeProcesoPresto oRsErrores, "Clientes : Fila " & fl & ", el codigo de localidad " & mCodigoLocalidad & " es incorrecto y el cliente no fue importado."
                     mConProblemas = True
                  End If
                  oRsAux.Close
                  
                  Set oRsAux = oAp.Provincias.TraerFiltrado("_PorId", mIdProvincia)
                  If oRsAux.RecordCount > 0 Then
                     mIdPais = IIf(IsNull(oRsAux.Fields("IdPais").Value), 0, oRsAux.Fields("IdPais").Value)
                  Else
                     AgregarMensajeProcesoPresto oRsErrores, "Clientes : Fila " & fl & ", no se encontro la provincia."
                     mConProblemas = True
                  End If
                  oRsAux.Close
                  
                  If mIdPais = 0 Then
                     AgregarMensajeProcesoPresto oRsErrores, "Clientes : Fila " & fl & ", no se encontro el pais."
                     mConProblemas = True
                  End If
                  
                  If Not mConProblemas Then
                     Set oRsAux = oAp.Clientes.TraerFiltrado("_PorCodigoCliente", mCodigoCliente)
                     If oRsAux.RecordCount = 0 Then
                        Set oCli = oAp.Clientes.Item(-1)
                        With oCli
                           With .Registro
                              .Fields("RazonSocial").Value = mCliente
                              .Fields("Direccion").Value = mDireccion
                              .Fields("CodigoPostal").Value = mCodigoPostal
                              .Fields("IdLocalidad").Value = mIdLocalidad
                              .Fields("IdProvincia").Value = mIdProvincia
                              .Fields("IdPais").Value = mIdPais
                              .Fields("Cuit").Value = mCuit
                              .Fields("IdCodigoIva").Value = mIdCodigoIva
                              .Fields("CodigoCliente").Value = mCodigoCliente
                              .Fields("IdCondicionVenta").Value = 0
                              .Fields("IdMoneda").Value = mIdMonedaPesos
                              .Fields("TipoCliente").Value = 1
                              .Fields("Confirmado").Value = "NO"
                              .Fields("IdEstado").Value = 1
                              .Fields("EsAgenteRetencionIVA").Value = "NO"
                              .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                              .Fields("FechaIngreso").Value = Now
                              .Fields("Codigo").Value = "CL" & Format(mCodigoCliente, "000000")
                              .Fields("Observaciones").Value = mObservaciones
                              .Fields("IBCondicion").Value = mIBCondicion
                              .Fields("IdCuenta").Value = mIdCuenta
                              .Fields("IdCuentaMonedaExt").Value = mIdCuenta
                              .Fields("IGCondicion").Value = 4
                              .Fields("Vendedor1").Value = 1
                              .Fields("IdListaPrecios").Value = mIdListaPrecios
                              .Fields("IdCondicionVenta").Value = mIdCondicionVenta
                           End With
                           .Guardar
                        End With
                        Set oCli = Nothing
                     End If
                     oRsAux.Close
                  End If
                  fl = fl + 1
               Loop
            End With
            If Not mConProblemas Then
               mArchivoResultados = mPathBackup & UCase(mId(mArchivo, 1, Len(mArchivo) - 4)) & " - Correctamente " & Year(Now) & "-" & Format(Month(Now), "00") & "-" & Format(Day(Now), "00") & " " & Format(Hour(Now), "00") & "." & Format(Minute(Now), "00") & "." & Format(Second(Now), "00") & ".xls"
               .ActiveSheet.SaveAs mArchivoResultados
               .Close False
               Kill mPathEntrante & mArchivo
            Else
               .Close False
            End If
         End With
         .Quit
      End With
   End If
   
   ' COMPROBANTES
   mArchivo = Dir(mPathEntrante & "Comprobantes.xls", vbArchive)
   If Len(mArchivo) > 0 Then
      fl = 2
      mContador = 0
      
      oF.Label1 = oF.Label1 & vbCrLf & "Procesando comprobantes ( verificacion ) ..."
      oF.Label2 = ""
      oF.Label3 = ""
      DoEvents
      
      With oEx
         .Visible = True
         .WindowState = xlMinimized
         Me.Refresh
         With .Workbooks.Open(mPathEntrante & mArchivo)
            '.Sheets("Hoja1").Select
            mConProblemas = False
            With .ActiveSheet
               Do While True
                  If Len(Trim(.Cells(fl, 1))) = 0 Then Exit Do
   
                  mCodigoCliente = CLng(.Cells(fl, 1))
                  mFecha = 0
                  If IsDate(.Cells(fl, 2)) Then mFecha = CDate(.Cells(fl, 2))
                  mPuntoVenta = CInt(.Cells(fl, 3))
                  mCodigoComprobante = CInt(.Cells(fl, 4))
                  mNumero = CLng(.Cells(fl, 6))
                  mCodigo = .Cells(fl, 8)
                  
                  mContador = mContador + 1
                  oF.Label2 = "Comprobante " & mNumero & " del " & mFecha
                  oF.Label3 = "" & mContador
                  DoEvents
                  
                  mIdCliente = 0
                  mIdIBCondicionPorDefecto = 0
                  mIBCondicion = 0
                  mCliente = ""
                  Set oRsAux = oAp.Clientes.TraerFiltrado("_PorCodigoCliente", mCodigoCliente)
                  If oRsAux.RecordCount > 0 Then
                     mIdCliente = oRsAux.Fields(0).Value
                     mIdIBCondicionPorDefecto = IIf(IsNull(oRsAux.Fields("IdIBCondicionPorDefecto").Value), 0, oRsAux.Fields("IdIBCondicionPorDefecto").Value)
                     mIBCondicion = IIf(IsNull(oRsAux.Fields("IBCondicion").Value), 0, oRsAux.Fields("IBCondicion").Value)
                     mCliente = IIf(IsNull(oRsAux.Fields("RazonSocial").Value), "", oRsAux.Fields("RazonSocial").Value)
                     If IIf(IsNull(oRsAux.Fields("Confirmado").Value), "", oRsAux.Fields("Confirmado").Value) = "NO" Then
                        AgregarMensajeProcesoPresto oRsErrores, "Comprobantes : Fila " & fl & ", el codigo de cliente " & mCodigoCliente & " esta a confirmas y la importacion fue abortada."
                        mConProblemas = True
                     End If
                  Else
                     AgregarMensajeProcesoPresto oRsErrores, "Comprobantes : Fila " & fl & ", el codigo de cliente " & mCodigoCliente & " es incorrecto y la importacion fue abortada."
                     mConProblemas = True
                  End If
                  oRsAux.Close
                  
                  If mFecha = 0 Then
                     AgregarMensajeProcesoPresto oRsErrores, "Comprobantes : Fila " & fl & ", la fecha del comprobante es incorrecta y la importacion fue abortada."
                     mConProblemas = True
                  End If
                  
                  mIdTipoComprobante = 0
                  If mCodigoComprobante = 1 Then
                     mIdTipoComprobante = 1
                     mLetra = "A"
                  ElseIf mCodigoComprobante = 2 Then
                     mIdTipoComprobante = 3
                     mLetra = "A"
                  ElseIf mCodigoComprobante = 7 Then
                     mIdTipoComprobante = 3
                     mLetra = "B"
                     
                  ElseIf mCodigoComprobante = 6 Then
                     mIdTipoComprobante = 1
                     mLetra = "B"
                  ElseIf mCodigoComprobante = 3 Then
                     mIdTipoComprobante = 4
                     mLetra = "A"
                  ElseIf mCodigoComprobante = 8 Then
                     mIdTipoComprobante = 4
                     mLetra = "B"
                  End If
   
                  If mIdTipoComprobante = 0 Then
                     AgregarMensajeProcesoPresto oRsErrores, "Comprobantes : Fila " & fl & ", no se encontro el tipo de comprobante y la importacion fue abortada."
                     mConProblemas = True
                  End If
   
                  mIdArticulo = 0
                  mIdConcepto = 0
                  mIdProvincia = 0
                  If mIdTipoComprobante = 1 Then
                     If InStr(1, mCodigosArticulosPercepcionIIBB, "(" & mCodigo & ")") > 0 Then
                        Set oRsAux = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", mIdIBCondicionPorDefecto)
                        If oRsAux.RecordCount > 0 Then
                           mIdCuentaPercepcionIIBB = IIf(IsNull(oRsAux.Fields("IdCuentaPercepcionIIBB").Value), 0, oRsAux.Fields("IdCuentaPercepcionIIBB").Value)
                           mIdProvincia = IIf(IsNull(oRsAux.Fields("IdProvincia").Value), 0, oRsAux.Fields("IdProvincia").Value)
                        End If
                        oRsAux.Close
                        
                        If mIdProvincia > 0 Then
                           Set oRsAux = Aplicacion.TablasGenerales.TraerUno("Provincias", mIdProvincia)
                           If oRsAux.RecordCount > 0 Then
                              mIdCuentaPercepcionIIBB = IIf(IsNull(oRsAux.Fields("IdCuentaPercepcionIBrutos").Value), 0, oRsAux.Fields("IdCuentaPercepcionIBrutos").Value)
                              If mIBCondicion = 2 And Not IsNull(oRsAux.Fields("IdCuentaPercepcionIIBBConvenio").Value) Then
                                 mIdCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIIBBConvenio").Value
                              End If
                           End If
                           oRsAux.Close
                        End If
                        
                        If mIdCuentaPercepcionIIBB = 0 Or (mIBCondicion <> 2 And mIBCondicion <> 3) Then
                           AgregarMensajeProcesoPresto oRsErrores, "Comprobantes : Fila " & fl & ", cliente : " & mCliente & ", el comprobante tiene percepcion IIBB y el cliente no tiene habilitada la cuenta contable, la importacion fue abortada."
                           mConProblemas = True
                        End If
                     Else
                        Set oRsAux = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", mCodigo)
                        If oRsAux.RecordCount > 0 Then
                           mIdArticulo = oRsAux.Fields(0).Value
                        Else
                           AgregarMensajeProcesoPresto oRsErrores, "Comprobantes : Fila " & fl & ", el codigo de articulo " & mCodigo & " es incorrecto y la importacion fue abortada."
                           mConProblemas = True
                        End If
                        oRsAux.Close
                     End If
                  ElseIf mIdTipoComprobante = 4 Then
                     If InStr(1, mCodigosConceptosPercepcionIIBB, "(" & mCodigo & ")") > 0 Then
                        Set oRsAux = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", mIdIBCondicionPorDefecto)
                        If oRsAux.RecordCount > 0 Then
                           mIdCuentaPercepcionIIBB = IIf(IsNull(oRsAux.Fields("IdCuentaPercepcionIIBB").Value), 0, oRsAux.Fields("IdCuentaPercepcionIIBB").Value)
                           mIdProvincia = IIf(IsNull(oRsAux.Fields("IdProvincia").Value), 0, oRsAux.Fields("IdProvincia").Value)
                        End If
                        oRsAux.Close
                        
                        If mIdProvincia > 0 Then
                           Set oRsAux = Aplicacion.TablasGenerales.TraerUno("Provincias", mIdProvincia)
                           If oRsAux.RecordCount > 0 Then
                              mIdCuentaPercepcionIIBB = IIf(IsNull(oRsAux.Fields("IdCuentaPercepcionIBrutos").Value), 0, oRsAux.Fields("IdCuentaPercepcionIBrutos").Value)
                              If mIBCondicion = 2 And Not IsNull(oRsAux.Fields("IdCuentaPercepcionIIBBConvenio").Value) Then
                                 mIdCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIIBBConvenio").Value
                              End If
                           End If
                           oRsAux.Close
                        End If
                        
                        If mIdCuentaPercepcionIIBB = 0 Or (mIBCondicion <> 2 And mIBCondicion <> 3) Then
                           AgregarMensajeProcesoPresto oRsErrores, "Comprobantes : Fila " & fl & ", cliente : " & mCliente & ", el comprobante tiene percepcion IIBB y el cliente no tiene habilitada la cuenta contable, la importacion fue abortada."
                           mConProblemas = True
                        End If
                     Else
                        mIdCuentaConceptos = 0
                        Set oRsAux = Aplicacion.Conceptos.TraerFiltrado("_PorCodigo", mCodigo)
                        If oRsAux.RecordCount > 0 Then
                           mIdConcepto = oRsAux.Fields(0).Value
                           mIdCuentaConceptos = IIf(IsNull(oRsAux.Fields("IdCuenta").Value), 0, oRsAux.Fields("IdCuenta").Value)
                        Else
                           AgregarMensajeProcesoPresto oRsErrores, "Comprobantes : Fila " & fl & ", el codigo de concepto " & mCodigo & " es incorrecto y la importacion fue abortada."
                           mConProblemas = True
                        End If
                        oRsAux.Close
                        If mIdCuentaConceptos = 0 Then
                           AgregarMensajeProcesoPresto oRsErrores, "Comprobantes : Fila " & fl & ", el codigo de concepto " & mCodigo & " no tiene cuenta contable y la importacion fue abortada."
                           mConProblemas = True
                        End If
                     End If
                  
                    ElseIf mIdTipoComprobante = 3 Then
                     
                     If InStr(1, mCodigosConceptosPercepcionIIBB, "(" & mCodigo & ")") > 0 Then
                        Set oRsAux = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", mIdIBCondicionPorDefecto)
                        If oRsAux.RecordCount > 0 Then
                           mIdCuentaPercepcionIIBB = IIf(IsNull(oRsAux.Fields("IdCuentaPercepcionIIBB").Value), 0, oRsAux.Fields("IdCuentaPercepcionIIBB").Value)
                           mIdProvincia = IIf(IsNull(oRsAux.Fields("IdProvincia").Value), 0, oRsAux.Fields("IdProvincia").Value)
                        End If
                        oRsAux.Close
                        
                        If mIdProvincia > 0 Then
                           Set oRsAux = Aplicacion.TablasGenerales.TraerUno("Provincias", mIdProvincia)
                           If oRsAux.RecordCount > 0 Then
                              mIdCuentaPercepcionIIBB = IIf(IsNull(oRsAux.Fields("IdCuentaPercepcionIBrutos").Value), 0, oRsAux.Fields("IdCuentaPercepcionIBrutos").Value)
                              If mIBCondicion = 2 And Not IsNull(oRsAux.Fields("IdCuentaPercepcionIIBBConvenio").Value) Then
                                 mIdCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIIBBConvenio").Value
                              End If
                           End If
                           oRsAux.Close
                        End If
                        
                        If mIdCuentaPercepcionIIBB = 0 Or (mIBCondicion <> 2 And mIBCondicion <> 3) Then
                           AgregarMensajeProcesoPresto oRsErrores, "Comprobantes : Fila " & fl & ", cliente : " & mCliente & ", el comprobante tiene percepcion IIBB y el cliente no tiene habilitada la cuenta contable, la importacion fue abortada."
                           mConProblemas = True
                        End If
                     Else
                        mIdCuentaConceptos = 0
                        Set oRsAux = Aplicacion.Conceptos.TraerFiltrado("_PorCodigo", mCodigo)
                        If oRsAux.RecordCount > 0 Then
                           mIdConcepto = oRsAux.Fields(0).Value
                           mIdCuentaConceptos = IIf(IsNull(oRsAux.Fields("IdCuenta").Value), 0, oRsAux.Fields("IdCuenta").Value)
                        Else
                           AgregarMensajeProcesoPresto oRsErrores, "Comprobantes : Fila " & fl & ", el codigo de concepto " & mCodigo & " es incorrecto y la importacion fue abortada."
                           mConProblemas = True
                        End If
                        oRsAux.Close
                        If mIdCuentaConceptos = 0 Then
                           AgregarMensajeProcesoPresto oRsErrores, "Comprobantes : Fila " & fl & ", el codigo de concepto " & mCodigo & " no tiene cuenta contable y la importacion fue abortada."
                           mConProblemas = True
                        End If
                     End If

                  End If
                  
                  
                  
                  mCotizacionDolar = Cotizacion(mFecha, glbIdMonedaDolar)
                  mCotizacionDolar = 6
                  If mCotizacionDolar = 0 Then
                     AgregarMensajeProcesoPresto oRsErrores, "Comprobantes : Fila " & fl & ", no hay cotizacion dolar para el dia " & mFecha & " es incorrecto y la importacion fue abortada."
                     mConProblemas = True
                  End If
               
                  fl = fl + 1
               Loop
               
               If Not mConProblemas Then
                  fl = 2
                  mContador = 0
                  
                  oF.Label1 = oF.Label1 & vbCrLf & "Procesando comprobantes ( registracion ) ..."
                  oF.Label2 = ""
                  oF.Label3 = ""
                  DoEvents
                  
                  Do While True
                     If Len(Trim(.Cells(fl, 1))) = 0 Then Exit Do
      
                     mCodigoCliente = CLng(.Cells(fl, 1))
                     mFecha = 0
                     If IsDate(.Cells(fl, 2)) Then mFecha = CDate(.Cells(fl, 2))
                     mPuntoVenta = CInt(.Cells(fl, 3))
                     mCodigoComprobante = CInt(.Cells(fl, 4))
                     mNumero = CLng(.Cells(fl, 6))
                     mCodigo = .Cells(fl, 8)
                     
                     mContador = mContador + 1
                     oF.Label2 = "Comprobante " & mNumero & " del " & mFecha
                     oF.Label3 = "" & mContador
                     DoEvents
                     
                     mIdCliente = 0
                     mIdIBCondicionPorDefecto = 0
                     mIBCondicion = 0
                     Set oRsAux = oAp.Clientes.TraerFiltrado("_PorCodigoCliente", mCodigoCliente)
                     If oRsAux.RecordCount > 0 Then
                        mIdCliente = oRsAux.Fields(0).Value
                        mIdCodigoIva = oRsAux.Fields("IdCodigoIva").Value
                        mIdVendedor = IIf(IsNull(oRsAux.Fields("Vendedor1").Value), 0, oRsAux.Fields("Vendedor1").Value)
                        mIdIBCondicionPorDefecto = IIf(IsNull(oRsAux.Fields("IdIBCondicionPorDefecto").Value), 0, oRsAux.Fields("IdIBCondicionPorDefecto").Value)
                        mIBCondicion = IIf(IsNull(oRsAux.Fields("IBCondicion").Value), 0, oRsAux.Fields("IBCondicion").Value)
                     End If
                     oRsAux.Close
                     
                     mIdTipoComprobante = 0
                     
                     
                  mIdTipoComprobante = 0
                  If mCodigoComprobante = 1 Then
                     mIdTipoComprobante = 1
                     mLetra = "A"
                  ElseIf mCodigoComprobante = 2 Then
                     mIdTipoComprobante = 3
                     mLetra = "A"
                  ElseIf mCodigoComprobante = 7 Then
                     mIdTipoComprobante = 3
                     mLetra = "B"
                     
                  ElseIf mCodigoComprobante = 6 Then
                     mIdTipoComprobante = 1
                     mLetra = "B"
                  ElseIf mCodigoComprobante = 3 Then
                     mIdTipoComprobante = 4
                     mLetra = "A"
                  ElseIf mCodigoComprobante = 8 Then
                     mIdTipoComprobante = 4
                     mLetra = "B"
                  End If
                  
                     
      
                     mIdPuntoVenta = 0
                     mCAI = ""
                     mFechaCAI = 0
                     Set oRsAux = oAp.PuntosVenta.TraerFiltrado("_Duplicados", Array(mLetra, mIdTipoComprobante, mPuntoVenta, -1))
                     If oRsAux.RecordCount > 0 Then
                        mIdPuntoVenta = oRsAux.Fields(0).Value
                        Select Case mLetra
                           Case "A"
                              If mIdTipoComprobante = 1 Then
                                 If IsNull(oRsAux.Fields("NumeroCAI_F_A").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_F_A").Value)) = 0 Then
                                    AgregarMensajeProcesoPresto oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
                                          " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado."
                                    mConProblemas = True
                                 Else
                                    If IsNumeric(oRsAux.Fields("NumeroCAI_F_A").Value) Then mCAI = oRsAux.Fields("NumeroCAI_F_A").Value
                                    If IsDate(oRsAux.Fields("FechaCAI_F_A").Value) Then mFechaCAI = IIf(IsNull(oRsAux.Fields("FechaCAI_F_A").Value), Date, oRsAux.Fields("FechaCAI_F_A").Value)
                                 End If
                              ElseIf mIdTipoComprobante = 3 Then
                                 If IsNull(oRsAux.Fields("NumeroCAI_D_A").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_D_A").Value)) = 0 Then
                                    AgregarMensajeProcesoPresto oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
                                          " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado."
                                    mConProblemas = True
                                 Else
                                    If IsNumeric(oRsAux.Fields("NumeroCAI_D_A").Value) Then mCAI = oRsAux.Fields("NumeroCAI_D_A").Value
                                    If IsDate(oRsAux.Fields("FechaCAI_D_A").Value) Then mFechaCAI = IIf(IsNull(oRsAux.Fields("FechaCAI_D_A").Value), Date, oRsAux.Fields("FechaCAI_D_A").Value)
                                 End If
                              ElseIf mIdTipoComprobante = 4 Then
                                 If IsNull(oRsAux.Fields("NumeroCAI_C_A").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_C_A").Value)) = 0 Then
                                    AgregarMensajeProcesoPresto oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
                                          " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado."
                                    mConProblemas = True
                                 Else
                                    If IsNumeric(oRsAux.Fields("NumeroCAI_C_A").Value) Then mCAI = oRsAux.Fields("NumeroCAI_C_A").Value
                                    If IsDate(oRsAux.Fields("FechaCAI_C_A").Value) Then mFechaCAI = IIf(IsNull(oRsAux.Fields("FechaCAI_C_A").Value), Date, oRsAux.Fields("FechaCAI_C_A").Value)
                                 End If
                              End If
                           Case "B"
                              If mIdTipoComprobante = 1 Then
                                 If IsNull(oRsAux.Fields("NumeroCAI_F_B").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_F_B").Value)) = 0 Then
                                    AgregarMensajeProcesoPresto oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
                                          " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado."
                                    mConProblemas = True
                                 Else
                                    If IsNumeric(oRsAux.Fields("NumeroCAI_F_B").Value) Then mCAI = oRsAux.Fields("NumeroCAI_F_B").Value
                                    If IsDate(oRsAux.Fields("FechaCAI_F_B").Value) Then mFechaCAI = IIf(IsNull(oRsAux.Fields("FechaCAI_F_B").Value), Date, oRsAux.Fields("FechaCAI_F_B").Value)
                                 End If
                              ElseIf mIdTipoComprobante = 3 Then
                                 If IsNull(oRsAux.Fields("NumeroCAI_D_B").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_D_B").Value)) = 0 Then
                                    AgregarMensajeProcesoPresto oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
                                          " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado."
                                    mConProblemas = True
                                 Else
                                    If IsNumeric(oRsAux.Fields("NumeroCAI_D_B").Value) Then mCAI = oRsAux.Fields("NumeroCAI_D_B").Value
                                    If IsDate(oRsAux.Fields("FechaCAI_D_B").Value) Then mFechaCAI = IIf(IsNull(oRsAux.Fields("FechaCAI_D_B").Value), Date, oRsAux.Fields("FechaCAI_D_B").Value)
                                 End If
                              ElseIf mIdTipoComprobante = 4 Then
                                 If IsNull(oRsAux.Fields("NumeroCAI_C_B").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_C_B").Value)) = 0 Then
                                    AgregarMensajeProcesoPresto oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
                                          " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado."
                                    mConProblemas = True
                                 Else
                                    If IsNumeric(oRsAux.Fields("NumeroCAI_C_B").Value) Then mCAI = oRsAux.Fields("NumeroCAI_C_B").Value
                                    If IsDate(oRsAux.Fields("FechaCAI_C_B").Value) Then mFechaCAI = IIf(IsNull(oRsAux.Fields("FechaCAI_C_B").Value), Date, oRsAux.Fields("FechaCAI_C_B").Value)
                                 End If
                              End If
                           Case "E"
                              If mIdTipoComprobante = 1 Then
                                 If IsNull(oRsAux.Fields("NumeroCAI_F_E").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_F_E").Value)) = 0 Then
                                    AgregarMensajeProcesoPresto oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
                                          " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado."
                                    mConProblemas = True
                                 Else
                                    If IsNumeric(oRsAux.Fields("NumeroCAI_F_E").Value) Then mCAI = oRsAux.Fields("NumeroCAI_F_E").Value
                                    If IsDate(oRsAux.Fields("FechaCAI_F_E").Value) Then mFechaCAI = IIf(IsNull(oRsAux.Fields("FechaCAI_F_E").Value), Date, oRsAux.Fields("FechaCAI_F_E").Value)
                                 End If
                              ElseIf mIdTipoComprobante = 3 Then
                                 If IsNull(oRsAux.Fields("NumeroCAI_D_E").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_D_E").Value)) = 0 Then
                                    AgregarMensajeProcesoPresto oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
                                          " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado."
                                    mConProblemas = True
                                 Else
                                    If IsNumeric(oRsAux.Fields("NumeroCAI_D_E").Value) Then mCAI = oRsAux.Fields("NumeroCAI_D_E").Value
                                    If IsDate(oRsAux.Fields("FechaCAI_D_E").Value) Then mFechaCAI = IIf(IsNull(oRsAux.Fields("FechaCAI_D_E").Value), Date, oRsAux.Fields("FechaCAI_D_E").Value)
                                 End If
                              ElseIf mIdTipoComprobante = 4 Then
                                 If IsNull(oRsAux.Fields("NumeroCAI_C_E").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_C_E").Value)) = 0 Then
                                    AgregarMensajeProcesoPresto oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
                                          " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado."
                                    mConProblemas = True
                                 Else
                                    If IsNumeric(oRsAux.Fields("NumeroCAI_C_E").Value) Then mCAI = oRsAux.Fields("NumeroCAI_C_E").Value
                                    If IsDate(oRsAux.Fields("FechaCAI_C_E").Value) Then mFechaCAI = IIf(IsNull(oRsAux.Fields("FechaCAI_C_E").Value), Date, oRsAux.Fields("FechaCAI_C_E").Value)
                                 End If
                              End If
                        End Select
                     End If
                     oRsAux.Close
      
                     mCotizacionDolar = Cotizacion(mFecha, glbIdMonedaDolar)
      If mCotizacionDolar = 0 Then
'        Stop
        mCotizacionDolar = 6
      End If
      
                     Select Case mIdTipoComprobante
                        Case 1
                           Set oFac = oAp.Facturas.Item(-1)
                           With oFac
                              With .Registro
                                 .Fields("NumeroFactura").Value = mNumero
                                 .Fields("TipoABC").Value = mLetra
                                 .Fields("PuntoVenta").Value = mPuntoVenta
                                 .Fields("IdCliente").Value = mIdCliente
                                 .Fields("FechaFactura").Value = mFecha
                                 .Fields("IdVendedor").Value = mIdVendedor
                                 .Fields("ConvenioMultilateral").Value = "NO"
                                 .Fields("CotizacionDolar").Value = mCotizacionDolar
                                 .Fields("PorcentajeIva1").Value = mTasa
                                 .Fields("PorcentajeIva2").Value = 0
                                 .Fields("FechaVencimiento").Value = mFecha
                                 .Fields("IdMoneda").Value = mIdMonedaPesos
                                 .Fields("CotizacionMoneda").Value = 1
                                 .Fields("IdPuntoVenta").Value = mIdPuntoVenta
                                 .Fields("NumeroCAI").Value = Val(mCAI)
                                 .Fields("FechaVencimientoCAI").Value = mFechaCAI
                                 .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                                 .Fields("FechaIngreso").Value = Now
                                 .Fields("IdCodigoIva").Value = mIdCodigoIva
                                 If mIdIBCondicionPorDefecto > 0 Then .Fields("IdIBCondicion").Value = mIdIBCondicionPorDefecto
                              End With
                           End With
                        Case 4
                           Set oCre = oAp.NotasCredito.Item(-1)
                           With oCre
                              With .Registro
                                 .Fields("NumeroNotaCredito").Value = mNumero
                                 .Fields("TipoABC").Value = mLetra
                                 .Fields("PuntoVenta").Value = mPuntoVenta
                                 .Fields("IdCliente").Value = mIdCliente
                                 .Fields("FechaNotaCredito").Value = mFecha
                                 .Fields("IdVendedor").Value = mIdVendedor
                                 .Fields("IdCodigoIva").Value = mIdCodigoIva
                                 .Fields("PorcentajeIva1").Value = mTasa
                                 .Fields("PorcentajeIva2").Value = 0
                                 .Fields("CotizacionDolar").Value = mCotizacionDolar
                                 .Fields("CtaCte").Value = "SI"
                                 .Fields("IdMoneda").Value = mIdMonedaPesos
                                 .Fields("CotizacionMoneda").Value = 1
                                 .Fields("ConvenioMultilateral").Value = "NO"
                                 .Fields("IdPuntoVenta").Value = mIdPuntoVenta
                                 '.Fields("NumeroCAI").Value = mCAI
                                 .Fields("FechaVencimientoCAI").Value = mFechaCAI
                                 .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                                 .Fields("FechaIngreso").Value = Now
                                 .Fields("AplicarEnCtaCte").Value = "SI"
                                 If mIdIBCondicionPorDefecto > 0 Then .Fields("IdIBCondicion").Value = mIdIBCondicionPorDefecto
                              End With
                           End With
                        Case 3
                           Set oDeb = oAp.NotasDebito.Item(-1)
                           With oDeb
                              With .Registro
                                 .Fields("NumeroNotaDebito").Value = mNumero
                                 .Fields("TipoABC").Value = mLetra
                                 .Fields("PuntoVenta").Value = mPuntoVenta
                                 .Fields("IdCliente").Value = mIdCliente
                                 .Fields("FechaNotaDebito").Value = mFecha
                                 .Fields("IdVendedor").Value = mIdVendedor
                                 .Fields("IdCodigoIva").Value = mIdCodigoIva
                                 .Fields("PorcentajeIva1").Value = mTasa
                                 .Fields("PorcentajeIva2").Value = 0
                                 .Fields("CotizacionDolar").Value = mCotizacionDolar
                                 .Fields("CtaCte").Value = "SI"
                                 .Fields("IdMoneda").Value = mIdMonedaPesos
                                 .Fields("CotizacionMoneda").Value = 1
                                 .Fields("ConvenioMultilateral").Value = "NO"
                                 .Fields("IdPuntoVenta").Value = mIdPuntoVenta
                                 '.Fields("NumeroCAI").Value = mCAI
                                 .Fields("FechaVencimientoCAI").Value = mFechaCAI
                                 .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                                 .Fields("FechaIngreso").Value = Now
                                 .Fields("AplicarEnCtaCte").Value = "SI"
                                 If mIdIBCondicionPorDefecto > 0 Then .Fields("IdIBCondicion").Value = mIdIBCondicionPorDefecto
                              End With
                           End With
                           
                           
                     End Select
                     
                     mTotal = 0
                     mIva = 0
                     mIVANoDiscriminado = 0
                     mPercepcionIIBB = 0
                     
                     Do While Len(Trim(.Cells(fl, 1))) <> 0 And mCodigoCliente = CLng(.Cells(fl, 1)) And mFecha = CDate(.Cells(fl, 2)) And _
                              mPuntoVenta = CInt(.Cells(fl, 3)) And mCodigoComprobante = CInt(.Cells(fl, 4)) And mNumero = CLng(.Cells(fl, 6))
                        mCodigo = .Cells(fl, 8)
                        mCantidad = CDbl(.Cells(fl, 7))
                        mDescripcion = .Cells(fl, 9)
                        mGravadoItem = CDbl(.Cells(fl, 11))
                        mIvaItem = CDbl(.Cells(fl, 12))
                        mNoGravadoItem = 0
                        If mIvaItem = 0 Then mNoGravadoItem = CDbl(.Cells(fl, 10))
                     
                        If mLetra = "A" Then
                           mIva = mIva + mIvaItem
                           mTotalItem = mGravadoItem + mNoGravadoItem
                        Else
                           mIVANoDiscriminado = mIVANoDiscriminado + mIvaItem
                           mTotalItem = mGravadoItem + mIvaItem + mNoGravadoItem
                        End If
                        If mCantidad <> 0 Then
                           mPrecio = mTotalItem / mCantidad
                        Else
                           mPrecio = mTotalItem
                        End If
                        mTotal = mTotal + (mGravadoItem + mIvaItem + mNoGravadoItem)
                        
                        Select Case mIdTipoComprobante
                           Case 1
                              mIdArticulo = 0
                              Set oRsAux = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", mCodigo)
                              If oRsAux.RecordCount > 0 Then mIdArticulo = oRsAux.Fields(0).Value
                              oRsAux.Close
                              
                              If InStr(1, mCodigosArticulosPercepcionIIBB, "(" & mCodigo & ")") > 0 Then
                                 mPercepcionIIBB = mPercepcionIIBB + mTotalItem
                              Else
                                 With oFac.DetFacturas.Item(-1)
                                    With .Registro
                                       .Fields("NumeroFactura").Value = mNumero
                                       .Fields("TipoABC").Value = mLetra
                                       .Fields("PuntoVenta").Value = mPuntoVenta
                                       .Fields("IdArticulo").Value = mIdArticulo
                                       .Fields("Cantidad").Value = mCantidad
                                       .Fields("Costo").Value = 0
                                       .Fields("PrecioUnitario").Value = mPrecio
                                       .Fields("Bonificacion").Value = 0
                                       .Fields("OrigenDescripcion").Value = 1
                                       .Fields("PrecioUnitarioTotal").Value = mPrecio
                                       .Fields("Observaciones").Value = mDescripcion
                                    End With
                                    .Modificado = True
                                 End With
                              End If
      
                           Case 4
                              mIdConcepto = 0
                              Set oRsAux = Aplicacion.Conceptos.TraerFiltrado("_PorCodigo", mCodigo)
                              If oRsAux.RecordCount > 0 Then mIdConcepto = oRsAux.Fields(0).Value
                              oRsAux.Close
                              
                              If InStr(1, mCodigosConceptosPercepcionIIBB, "(" & mCodigo & ")") > 0 Then
                                 mPercepcionIIBB = mPercepcionIIBB + mTotalItem
                              Else
                                 With oCre.DetNotasCredito.Item(-1)
                                    With .Registro
                                       .Fields("IdConcepto").Value = mIdConcepto
                                       .Fields("Importe").Value = mTotalItem
                                       If mIvaItem <> 0 Then
                                          .Fields("Gravado").Value = "SI"
                                       Else
                                          .Fields("Gravado").Value = "NO"
                                       End If
                                       .Fields("IvaNoDiscriminado").Value = 0
                                    End With
                                    .Modificado = True
                                 End With
                              End If
                              
                              
                              
                           Case 3
                              mIdConcepto = 0
                              Set oRsAux = Aplicacion.Conceptos.TraerFiltrado("_PorCodigo", mCodigo)
                              If oRsAux.RecordCount > 0 Then mIdConcepto = oRsAux.Fields(0).Value
                              oRsAux.Close
                              
                              If InStr(1, mCodigosConceptosPercepcionIIBB, "(" & mCodigo & ")") > 0 Then
                                 mPercepcionIIBB = mPercepcionIIBB + mTotalItem
                              Else
                                 With oDeb.DetNotasDebito.Item(-1)
                                    With .Registro
                                       .Fields("IdConcepto").Value = mIdConcepto
                                       .Fields("Importe").Value = mTotalItem
                                       If mIvaItem <> 0 Then
                                          .Fields("Gravado").Value = "SI"
                                       Else
                                          .Fields("Gravado").Value = "NO"
                                       End If
                                       .Fields("IvaNoDiscriminado").Value = 0
                                    End With
                                    .Modificado = True
                                 End With
                              End If
                              
                              
                        End Select
                        
                        fl = fl + 1
                     Loop
                        
                     Select Case mIdTipoComprobante
                        Case 1
                           mOk = True
                           Set oRsAux = Aplicacion.Facturas.TraerFiltrado("_PorNumeroComprobante", Array(mLetra, mPuntoVenta, mNumero))
                           If oRsAux.RecordCount > 0 Then mOk = False
                           oRsAux.Close
                           
                           If mOk Then
                              With oFac
                                 With .Registro
                                    .Fields("ImporteTotal").Value = mTotal
                                    .Fields("ImporteIva1").Value = mIva
                                    .Fields("ImporteIva2").Value = 0
                                    .Fields("AjusteIva").Value = 0
                                    .Fields("ImporteBonificacion").Value = 0
                                    .Fields("RetencionIBrutos1").Value = mPercepcionIIBB
                                    .Fields("PorcentajeIBrutos1").Value = 0
                                    .Fields("RetencionIBrutos2").Value = 0
                                    .Fields("PorcentajeIBrutos2").Value = 0
                                    .Fields("RetencionIBrutos3").Value = 0
                                    .Fields("PorcentajeIBrutos3").Value = 0
                                    .Fields("IVANoDiscriminado").Value = mIVANoDiscriminado
                                    .Fields("PorcentajeBonificacion").Value = 0
                                    .Fields("OtrasPercepciones1").Value = 0
                                    .Fields("OtrasPercepciones1Desc").Value = ""
                                    .Fields("OtrasPercepciones2").Value = 0
                                    .Fields("OtrasPercepciones2Desc").Value = ""
                                    .Fields("PercepcionIVA").Value = 0
                                    .Fields("PorcentajePercepcionIVA").Value = 0
                                 End With
                                 .Guardar
                                 mIdComprobante = .Registro.Fields(0).Value
                              End With
            
                              mPuntoVentaRecibo = 0
                              mNumeroRecibo = 0
                              Set oRsAux = Aplicacion.TablasGenerales.TraerUno("PuntosVenta", CLng(mIdPuntoVentaRecibosContado))
                              If oRsAux.RecordCount > 0 Then
                                 mNumeroRecibo = IIf(IsNull(oRsAux.Fields("ProximoNumero").Value), 1, oRsAux.Fields("ProximoNumero").Value)
                                 mPuntoVentaRecibo = IIf(IsNull(oRsAux.Fields("PuntoVenta").Value), 0, oRsAux.Fields("PuntoVenta").Value)
                              End If
                              oRsAux.Close
                           
                              Set oRec = oAp.Recibos.Item(-1)
                              With oRec
                                 With .Registro
                                    .Fields("FechaRecibo").Value = mFecha
                                    .Fields("IdPuntoVenta").Value = mIdPuntoVentaRecibosContado
                                    .Fields("PuntoVenta").Value = mPuntoVentaRecibo
                                    .Fields("Tipo").Value = "CC"
                                    .Fields("NumeroRecibo").Value = mNumeroRecibo
                                    .Fields("IdCliente").Value = mIdCliente
                                    .Fields("IdVendedor").Value = mIdVendedor
                                    .Fields("IdCobrador").Value = mIdVendedor
                                    .Fields("Documentos").Value = 0
                                    .Fields("Otros1").Value = 0
                                    .Fields("Otros2").Value = 0
                                    .Fields("Otros3").Value = 0
                                    .Fields("Otros4").Value = 0
                                    .Fields("Otros5").Value = 0
                                    .Fields("RetencionIVA").Value = 0
                                    .Fields("RetencionGanancias").Value = 0
                                    .Fields("RetencionIBrutos").Value = 0
                                    .Fields("GastosGenerales").Value = 0
                                    .Fields("Cotizacion").Value = mCotizacionDolar
                                    .Fields("IdMoneda").Value = mIdMonedaPesos
                                    .Fields("Dolarizada").Value = "NO"
                                    .Fields("AsientoManual").Value = "NO"
                                    .Fields("CotizacionMoneda").Value = 1
                                    .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                                    .Fields("Valores").Value = mTotal
                                    .Fields("Deudores").Value = mTotal
                                    .Fields("FechaIngreso").Value = Now
                                 
                                    'With oRec.DetRecibosRubrosContables.Item(-1)
                                    '   With .Registro
                                    '      .Fields("IdRubroContable").Value = mIdRubroContable
                                    '      .Fields("Importe").Value = mImporte
                                    '   End With
                                    '   .Modificado = True
                                    'End With
                                    
                                    mIdImputacion = 0
                                    Set oRsAux = oAp.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(mIdComprobante, mIdTipoComprobante))
                                    If oRsAux.RecordCount > 0 Then mIdImputacion = oRsAux.Fields(0).Value
                                    oRsAux.Close
                                    With oRec.DetRecibos.Item(-1)
                                       With .Registro
                                          .Fields("IdImputacion").Value = mIdImputacion
                                          .Fields("Importe").Value = mTotal
                                       End With
                                       .Modificado = True
                                    End With
                                    
                                    With oRec.DetRecibosValores.Item(-1)
                                       With .Registro
                                          .Fields("IdTipoValor").Value = 22
                                          .Fields("FechaVencimiento").Value = mFecha
                                          .Fields("Importe").Value = mTotal
                                          .Fields("IdCuenta").Value = mIdCuentaValoresParaReciboVentaContado
                                       End With
                                       .Modificado = True
                                    End With
                                 End With
                                 Set oRsAux = .RegistroContableForm
                                 Set oRsAux = Nothing
                                 .Guardar
                              End With
                              Set oRec = Nothing
                           End If
                           Set oFac = Nothing
                        
                        Case 4
                           mOk = True
                           Set oRsAux = Aplicacion.NotasCredito.TraerFiltrado("_PorNumeroComprobante", Array(mLetra, mPuntoVenta, mNumero))
                           If oRsAux.RecordCount > 0 Then mOk = False
                           oRsAux.Close
                           
                           If mOk Then
                              With oCre
                                 With .Registro
                                    .Fields("ImporteTotal").Value = mTotal
                                    .Fields("ImporteIva1").Value = mIva
                                    .Fields("ImporteIva2").Value = 0
                                    .Fields("RetencionIBrutos1").Value = mPercepcionIIBB
                                    .Fields("PorcentajeIBrutos1").Value = 0
                                    .Fields("RetencionIBrutos2").Value = 0
                                    .Fields("PorcentajeIBrutos2").Value = 0
                                    .Fields("IVANoDiscriminado").Value = mIVANoDiscriminado
                                    .Fields("OtrasPercepciones1").Value = 0
                                    .Fields("OtrasPercepciones1Desc").Value = ""
                                    .Fields("OtrasPercepciones2").Value = 0
                                    .Fields("OtrasPercepciones2Desc").Value = ""
                                    .Fields("OtrasPercepciones3").Value = 0
                                    .Fields("OtrasPercepciones3Desc").Value = ""
                                    .Fields("RetencionIBrutos3").Value = 0
                                    .Fields("PorcentajeIBrutos3").Value = 0
                                 End With
                                 With .DetNotasCreditoImp.Item(-1)
                                    With .Registro
                                       .Fields("IdImputacion").Value = -1
                                       .Fields("Importe").Value = mTotal
                                    End With
                                    .Modificado = True
                                 End With
                                 .Guardar
                                 mIdComprobante = .Registro.Fields(0).Value
                              End With
                           
                              mPuntoVentaRecibo = 0
                              mNumeroRecibo = 0
                              Set oRsAux = Aplicacion.TablasGenerales.TraerUno("PuntosVenta", CLng(mIdPuntoVentaRecibosContado))
                              If oRsAux.RecordCount > 0 Then
                                 mNumeroRecibo = IIf(IsNull(oRsAux.Fields("ProximoNumero").Value), 1, oRsAux.Fields("ProximoNumero").Value)
                                 mPuntoVentaRecibo = IIf(IsNull(oRsAux.Fields("PuntoVenta").Value), 0, oRsAux.Fields("PuntoVenta").Value)
                              End If
                              oRsAux.Close
                           
                              Set oRec = oAp.Recibos.Item(-1)
                              With oRec
                                 With .Registro
                                    .Fields("FechaRecibo").Value = mFecha
                                    .Fields("IdPuntoVenta").Value = mIdPuntoVentaRecibosContado
                                    .Fields("PuntoVenta").Value = mPuntoVentaRecibo
                                    .Fields("Tipo").Value = "CC"
                                    .Fields("NumeroRecibo").Value = mNumeroRecibo
                                    .Fields("IdCliente").Value = mIdCliente
                                    .Fields("IdVendedor").Value = mIdVendedor
                                    .Fields("IdCobrador").Value = mIdVendedor
                                    .Fields("Documentos").Value = 0
                                    .Fields("Otros1").Value = 0
                                    .Fields("Otros2").Value = 0
                                    .Fields("Otros3").Value = 0
                                    .Fields("Otros4").Value = 0
                                    .Fields("Otros5").Value = 0
                                    .Fields("RetencionIVA").Value = 0
                                    .Fields("RetencionGanancias").Value = 0
                                    .Fields("RetencionIBrutos").Value = 0
                                    .Fields("GastosGenerales").Value = 0
                                    .Fields("Cotizacion").Value = mCotizacionDolar
                                    .Fields("IdMoneda").Value = mIdMonedaPesos
                                    .Fields("Dolarizada").Value = "NO"
                                    .Fields("AsientoManual").Value = "NO"
                                    .Fields("CotizacionMoneda").Value = 1
                                    .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                                    .Fields("Valores").Value = mTotal * -1
                                    .Fields("Deudores").Value = mTotal * -1
                                    .Fields("FechaIngreso").Value = Now
                                 
                                    'With oRec.DetRecibosRubrosContables.Item(-1)
                                    '   With .Registro
                                    '      .Fields("IdRubroContable").Value = mIdRubroContable
                                    '      .Fields("Importe").Value = mImporte
                                    '   End With
                                    '   .Modificado = True
                                    'End With
                                    
                                    mIdImputacion = 0
                                    Set oRsAux = oAp.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(mIdComprobante, mIdTipoComprobante))
                                    If oRsAux.RecordCount > 0 Then mIdImputacion = oRsAux.Fields(0).Value
                                    oRsAux.Close
                                    With oRec.DetRecibos.Item(-1)
                                       With .Registro
                                          .Fields("IdImputacion").Value = mIdImputacion
                                          .Fields("Importe").Value = mTotal * -1
                                       End With
                                       .Modificado = True
                                    End With
                                    
                                    With oRec.DetRecibosValores.Item(-1)
                                       With .Registro
                                          .Fields("IdTipoValor").Value = 22
                                          .Fields("FechaVencimiento").Value = mFecha
                                          .Fields("Importe").Value = mTotal * -1
                                          .Fields("IdCuenta").Value = mIdCuentaValoresParaReciboVentaContado
                                       End With
                                       .Modificado = True
                                    End With
                                 End With
                                 Set oRsAux = .RegistroContableForm
                                 Set oRsAux = Nothing
                                 .Guardar
                              End With
                              Set oRec = Nothing
                           End If
                           Set oCre = Nothing
                           
                           
                                                   
                        Case 3
                           mOk = True
                           Set oRsAux = Aplicacion.NotasDebito.TraerFiltrado("_PorNumeroComprobante", Array(mLetra, mPuntoVenta, mNumero))
                           If oRsAux.RecordCount > 0 Then mOk = False
                           oRsAux.Close
                           
                           If mOk Then
                              With oDeb
                                 With .Registro
                                    .Fields("ImporteTotal").Value = mTotal
                                    .Fields("ImporteIva1").Value = mIva
                                    .Fields("ImporteIva2").Value = 0
                                    .Fields("RetencionIBrutos1").Value = mPercepcionIIBB
                                    .Fields("PorcentajeIBrutos1").Value = 0
                                    .Fields("RetencionIBrutos2").Value = 0
                                    .Fields("PorcentajeIBrutos2").Value = 0
                                    .Fields("IVANoDiscriminado").Value = mIVANoDiscriminado
                                    .Fields("OtrasPercepciones1").Value = 0
                                    .Fields("OtrasPercepciones1Desc").Value = ""
                                    .Fields("OtrasPercepciones2").Value = 0
                                    .Fields("OtrasPercepciones2Desc").Value = ""
                                    .Fields("OtrasPercepciones3").Value = 0
                                    .Fields("OtrasPercepciones3Desc").Value = ""
                                    .Fields("RetencionIBrutos3").Value = 0
                                    .Fields("PorcentajeIBrutos3").Value = 0
                                 End With
                                 'With .DetNotasDebitoImp.Item(-1)
                                 '   With .Registro
                                 '      .Fields("IdImputacion").Value = -1
                                 '      .Fields("Importe").Value = mTotal
                                 '   End With
                                 '   .Modificado = True
                                 'End With
                                 .Guardar
                                 mIdComprobante = .Registro.Fields(0).Value
                              End With
                           
                              mPuntoVentaRecibo = 0
                              mNumeroRecibo = 0
                              Set oRsAux = Aplicacion.TablasGenerales.TraerUno("PuntosVenta", CLng(mIdPuntoVentaRecibosContado))
                              If oRsAux.RecordCount > 0 Then
                                 mNumeroRecibo = IIf(IsNull(oRsAux.Fields("ProximoNumero").Value), 1, oRsAux.Fields("ProximoNumero").Value)
                                 mPuntoVentaRecibo = IIf(IsNull(oRsAux.Fields("PuntoVenta").Value), 0, oRsAux.Fields("PuntoVenta").Value)
                              End If
                              oRsAux.Close
                           
                              Set oRec = oAp.Recibos.Item(-1)
                              With oRec
                                 With .Registro
                                    .Fields("FechaRecibo").Value = mFecha
                                    .Fields("IdPuntoVenta").Value = mIdPuntoVentaRecibosContado
                                    .Fields("PuntoVenta").Value = mPuntoVentaRecibo
                                    .Fields("Tipo").Value = "CC"
                                    .Fields("NumeroRecibo").Value = mNumeroRecibo
                                    .Fields("IdCliente").Value = mIdCliente
                                    .Fields("IdVendedor").Value = mIdVendedor
                                    .Fields("IdCobrador").Value = mIdVendedor
                                    .Fields("Documentos").Value = 0
                                    .Fields("Otros1").Value = 0
                                    .Fields("Otros2").Value = 0
                                    .Fields("Otros3").Value = 0
                                    .Fields("Otros4").Value = 0
                                    .Fields("Otros5").Value = 0
                                    .Fields("RetencionIVA").Value = 0
                                    .Fields("RetencionGanancias").Value = 0
                                    .Fields("RetencionIBrutos").Value = 0
                                    .Fields("GastosGenerales").Value = 0
                                    .Fields("Cotizacion").Value = mCotizacionDolar
                                    .Fields("IdMoneda").Value = mIdMonedaPesos
                                    .Fields("Dolarizada").Value = "NO"
                                    .Fields("AsientoManual").Value = "NO"
                                    .Fields("CotizacionMoneda").Value = 1
                                    .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                                    .Fields("Valores").Value = mTotal * -1
                                    .Fields("Deudores").Value = mTotal * -1
                                    .Fields("FechaIngreso").Value = Now
                                 
                                    'With oRec.DetRecibosRubrosContables.Item(-1)
                                    '   With .Registro
                                    '      .Fields("IdRubroContable").Value = mIdRubroContable
                                    '      .Fields("Importe").Value = mImporte
                                    '   End With
                                    '   .Modificado = True
                                    'End With
                                    
                                    mIdImputacion = 0
                                    Set oRsAux = oAp.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(mIdComprobante, mIdTipoComprobante))
                                    If oRsAux.RecordCount > 0 Then mIdImputacion = oRsAux.Fields(0).Value
                                    oRsAux.Close
                                    With oRec.DetRecibos.Item(-1)
                                       With .Registro
                                          .Fields("IdImputacion").Value = mIdImputacion
                                          .Fields("Importe").Value = mTotal * -1
                                       End With
                                       .Modificado = True
                                    End With
                                    
                                    With oRec.DetRecibosValores.Item(-1)
                                       With .Registro
                                          .Fields("IdTipoValor").Value = 22
                                          .Fields("FechaVencimiento").Value = mFecha
                                          .Fields("Importe").Value = mTotal * -1
                                          .Fields("IdCuenta").Value = mIdCuentaValoresParaReciboVentaContado
                                       End With
                                       .Modificado = True
                                    End With
                                 End With
                                 Set oRsAux = .RegistroContableForm
                                 Set oRsAux = Nothing
                                 .Guardar
                              End With
                              Set oRec = Nothing
                           End If
                           Set oDeb = Nothing

                     End Select
                  Loop
               End If
            End With
            If Not mConProblemas Then
               mArchivoResultados = mPathBackup & UCase(mId(mArchivo, 1, Len(mArchivo) - 4)) & " - Correctamente " & Year(Now) & "-" & Format(Month(Now), "00") & "-" & Format(Day(Now), "00") & " " & Format(Hour(Now), "00") & "." & Format(Minute(Now), "00") & "." & Format(Second(Now), "00") & ".xls"
               .ActiveSheet.SaveAs mArchivoResultados
               .Close False
               Kill mPathEntrante & mArchivo
            Else
               .Close False
            End If
         End With
         .Quit
      End With
   End If
   
   Unload oF
   Set oF = Nothing

   If Not oRsErrores Is Nothing Then
      If oRsErrores.RecordCount > 0 Then
         Set oF = New frmConsulta1
         With oF
            Set .RecordsetFuente = oRsErrores
            .Id = 13
            .Show vbModal, Me
         End With
      Else
         MsgBox "Proceso completo", vbInformation
      End If
      Set oRsErrores = Nothing
   End If

Salida:
   On Error Resume Next
   oEx.ActiveWorkbook.Close False
   oEx.Quit

   Unload oF
   Set oF = Nothing

   Set oRs = Nothing
   Set oRsErrores = Nothing
   Set oRsAux = Nothing
   
   Set oFac = Nothing
   Set oCre = Nothing
   Set oCli = Nothing
   Set oArt = Nothing
   Set oCOn = Nothing
   Set oRec = Nothing

   Set oEx = Nothing
   Set oAp = Nothing

   Exit Sub

Mal:
   MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   Resume Salida
   
End Sub
























