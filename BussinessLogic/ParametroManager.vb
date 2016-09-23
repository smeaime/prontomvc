Imports System
Imports System.ComponentModel
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports Microsoft.VisualBasic
Imports System.Diagnostics

Namespace Pronto.ERP.Bll

    Public Class ParametrosOriginalesRenglon
        Friend datos As DataRow
        Property p(ByVal pParametro As ParametroManager.ePmOrg) As String
            Get
                Return datos(pParametro.ToString).ToString
            End Get
            Set(ByVal value As String)

            End Set
        End Property
    End Class


    <DataObjectAttribute()> _
    Public Class ParametroManager

        'El objeto Parametro original solo tiene el _M y el _T. Usa solo un renglon de la tabla Parametros

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Parametro
            'Return ParametroDB.GetItem(SC, id)
            Return Nothing
        End Function



        ''' <summary>
        ''' asoioiadiooadsihhoiadsh asdohadsoh  adsoidasho
        ''' </summary>
        ''' <param name="SC"></param>
        ''' <returns></returns>
        ''' <remarks></remarks>
        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function TraerRenglonUnicoDeTablaParametroOriginal(ByVal SC As String) As System.Data.DataRow
            Return GeneralDB.TraerDatos(SC, "Parametros_T", 1).Tables(0).Rows(0) 'necesita el 1 para saber que ID traer......
        End Function


        Public Shared Function TraerRenglonUnicoDeTablaParametroOriginal(ByVal SC As String, ByVal p As ePmOrg) As String
            Return GeneralDB.TraerDatos(SC, "Parametros_T", 1).Tables(0).Rows(0).Item(p.ToString) 'necesita el 1 para saber que ID traer......
        End Function

        Public Shared Function TraerRenglonUnicoDeTablaParametroOriginalClase(ByVal SC As String) As ParametrosOriginalesRenglon
            Dim o As New ParametrosOriginalesRenglon
            o.datos = GeneralDB.TraerDatos(SC, "Parametros_T", 1).Tables(0).Rows(0) 'necesita el 1 para saber que ID traer......
            Return o
        End Function



        Public Enum eParam2
            '////////////////////////////////////////////////////
            'especiales de web
            '////////////////////////////////////////////////////
            LogoArchivo
            HostProntoWeb
            ProntoWebVersionSQL
            WebConfiguracionEmpresa 'para saber de qué sitemap tengo que usar
            NotificacionesWeb
            NotificacionesWeb2
            NotificacionesWeb3
            NotificacionesWeb4
            NotificacionesWeb5


            '////////////////////////////////////////////////////
            'del Pronto
            '////////////////////////////////////////////////////
            IdUbicacionStockEnTransito
            GenerarSalidaDesdeRecepcionSAT
            NumeracionAutomaticaDeOrdenesDePago
            IdRubroAnticipos
            IdRubroDevolucionAnticipos
            AprobacionesRM
            SoloUsuarioConectadoEnArbolAutorizaciones
            'Ajustes y gastos_2
            'Mano de obra_2
            'Gastos indirectos_2
            LiberarRMCircuito
            IdTipoCuentaGrupoPercepciones
            SectorEmisorEnPedidos
            AsignarLiberadorComoCompradorEnRM
            IdRubroEquiposTerceros
            IdSubrubroEquiposTerceros
            IdObraParaOTOP
            ControlarRubrosContablesEnCP
            NumeracionIndependienteDeOrdenesDePagoFFyCTACTE
            IdCuentaAnticipoAProveedores
            IdCuentaDevolucionAnticipoAProveedores
            FacturarConsumosAObra
            IdSectorReasignador
            IdDepositoCentral
            IdEjercicioContableControlNumeracion
            DesactivarDarPorCumplidoPedidoSinRecepcionEnCP
            LimitarEquiposDestinoSegunEtapasDeObra
            Lenguaje
            RegistroContableComprasAlActivo
            ProximoNumeroProveedor
            ProximoNumeroCajaStock
            ProximoNumeroCliente
            IdObraDefault
            ProximoNumeroPartida
            AsignarPartidasAutomaticamente
            UsarPartidasParaStock
            TopeMonotributoAnual_Servicios
            TopeMonotributoAnual_Bienes
            CuentasBienesUsoDesde
            CuentasBienesUsoHasta
            Password
            BaseAS
            Servidor
            FechaEmisionDiarioIGJ
            ProximoNumeroSubcontrato
            IdCuentaSubcontratosAcopio
            FechaArranqueCalculoPPP
            ControlarCircuitoFirmasEnOP
            RegistroContableRecepcionesAProvision
            CostoReposicionPorComprobanteProveedor
            IdUnidadPorHora
            IdUnidadPorKilometro
            ModeloContableSinApertura
            IdTipoCuentaGrupoAportes
            ProximoNumeroLiquidacionFlete
            IdRubroActivoFijo
            IdSubrubroActivoFijo
            PaginaSolicitudesCotizacion
            IdArticuloParaImportacionFacturas
            IdConceptoParaImportacionNDNC
            IdCuentaAdicionalIVAVentas1
            IdCuentaAdicionalIVAVentas2
            IdCuentaAdicionalIVAVentas3
            IdCuentaAdicionalIVAVentas4
            IdCuentaAdicionalIVAVentas5
            CantidadToleranciaOrdenesCompra
            PorcentajeToleranciaOrdenesCompra
            IdTipoArticuloMateriales
            IdTipoArticuloEquipos
            IdTipoArticuloManoObra
            IdTipoArticuloSubcontratos
            ModulosWEB
            Pedidos_DescripcionOtrosConceptos1
            Pedidos_DescripcionOtrosConceptos2
            Pedidos_DescripcionOtrosConceptos3
            Pedidos_DescripcionOtrosConceptos4
            Pedidos_DescripcionOtrosConceptos5
            DebugFacturaElectronica
            BasePRONTOBALANZA
        End Enum


        Public Enum ePmOrg
            ProximoPresupuesto
            Iva1
            Iva2
            ProximaListaAcopio
            ProximaListaMateriales
            ProximoNumeroRequerimiento
            IdUnidadPorUnidad
            ProximoNumeroAjusteStock
            ProximoNumeroReservaStock
            ProximoNumeroPedido
            ControlCalidadDefault
            ProximoNumeroValeSalida
            ProximoNumeroSalidaMateriales
            ProximaComparativa
            PathAdjuntos
            IdUnidadPorKilo
            PedidosGarantia
            PedidosDocumentacion
            PedidosPlazoEntrega
            PedidosLugarEntrega
            PedidosFormaPago
            ProximoNumeroSalidaMaterialesAObra
            ProximoNumeroSalidaMaterialesParaFacturar
            ProximoNumeroSalidaMateriales2
            ProximoNumeroSalidaMaterialesAObra2
            ProximoNumeroSalidaMaterialesParaFacturar2
            PedidosInspecciones
            PedidosImportante
            PathEnvioEmails
            PathRecepcionEmails
            ProximoNumeroSalidaMaterialesAProveedor
            ProximoNumeroSalidaMaterialesAProveedor2
            ProximoNumeroDevolucionDeFabrica
            ProximoNumeroDevolucionDeFabrica2
            ArchivoAyuda
            PathArchivoExcelDatanet
            PathArchivoExcelProveedores
            Porc_IBrutos_Cap
            Tope_IBrutos_Cap
            Porc_IBrutos_BsAs
            Tope_IBrutos_BsAs
            Porc_IBrutos_BsAsM
            Tope_IBrutos_BsAsM
            Decimales
            AclaracionAlPieDeFactura
            CotizacionDolar
            ProximoAsiento
            ProximoNumeroInterno
            NumeracionUnica
            EjercicioActual
            IdCuentaVentas
            IdCuentaBonificaciones
            IdCuentaIvaInscripto
            IdCuentaIvaNoInscripto
            IdCuentaIvaSinDiscriminar
            IdCuentaRetencionIBrutosBsAs
            IdCuentaRetencionIBrutosCap
            IdCuentaReventas
            IdCuentaND
            IdCuentaNC
            IdCuentaCaja
            IdCuentaValores
            IdCuentaRetencionIva
            IdCuentaRetencionGanancias
            IdCuentaRetencionIBrutos
            IdCuentaDescuentos
            IdCuentaDescuentosyRetenciones
            IdUnidad
            IdMoneda
            IdCuentaCompras
            ProximoComprobanteProveedorReferencia
            ProximoNumeroInternoChequeEmitido
            ProximaNumeroOrdenPago
            IdCuentaIvaCompras
            CAI
            FechaCAI
            ClausulaDolar
            IdMonedaDolar
            NumeroCAI_R_A
            FechaCAI_R_A
            NumeroCAI_F_A
            FechaCAI_F_A
            NumeroCAI_D_A
            FechaCAI_D_A
            NumeroCAI_C_A
            FechaCAI_C_A
            NumeroCAI_R_B
            FechaCAI_R_B
            NumeroCAI_F_B
            FechaCAI_F_B
            NumeroCAI_D_B
            FechaCAI_D_B
            NumeroCAI_C_B
            FechaCAI_C_B
            NumeroCAI_R_E
            FechaCAI_R_E
            NumeroCAI_F_E
            FechaCAI_F_E
            NumeroCAI_D_E
            FechaCAI_D_E
            NumeroCAI_C_E
            FechaCAI_C_E
            NumeracionCorrelativa
            ProximoNumeroRefProveedores
            ProximoNumeroCuentaContable
            IdCuentaAcreedoresVarios
            IdCuentaDeudoresVarios
            ProximaOrdenPago
            IdCuentaIvaCompras1
            IVAComprasPorcentaje1
            IdCuentaIvaCompras2
            IVAComprasPorcentaje2
            IdCuentaIvaCompras3
            IVAComprasPorcentaje3
            IdCuentaIvaCompras4
            IVAComprasPorcentaje4
            IdCuentaIvaCompras5
            IVAComprasPorcentaje5
            ProximaOrdenPagoExterior
            MinimoNoImponible
            DeduccionEspecial
            ProximoNumeroCertificadoRetencionGanancias
            IdCuentaVentasTitulo
            IdCuentaNDTitulo
            IdCuentaNCTitulo
            IdCuentaCajaTitulo
            IdCuentaValoresTitulo
            IdCuentaDescuentosyRetencionesTitulo
            IdCuentaComprasTitulo
            IdCuentaIvaCompras6
            IVAComprasPorcentaje6
            IdCuentaIvaCompras7
            IVAComprasPorcentaje7
            IdCuentaIvaCompras8
            IVAComprasPorcentaje8
            IdCuentaIvaCompras9
            IVAComprasPorcentaje9
            IdCuentaIvaCompras10
            IVAComprasPorcentaje10
            ProximoNumeroOrdenCompra
            ProximoNumeroRemito
            IdCuentaRetencionGananciasCobros
            IdTipoCuentaGrupoIVA
            IGCondicionExcepcion
            IdCuentaIvaVentas1
            IVAVentasPorcentaje1
            IdCuentaIvaVentas2
            IVAVentasPorcentaje2
            IdCuentaIvaVentas3
            IVAVentasPorcentaje3
            IdCuentaIvaVentas4
            IVAVentasPorcentaje4
            ProximaOrdenPagoOtros
            IdTipoComprobanteEfectivo
            IdTipoComprobanteDeposito
            ProximaNotaDebitoInterna
            ProximaNotaCreditoInterna
            IdTipoComprobanteCajaIngresos
            IdTipoComprobanteCajaEgresos
            DirectorioDTS
            PathObra
            FechaUltimoCierre
            IdConceptoDiferenciaCambio
            IdTipoCuentaGrupoFF
            ProximoNumeroOtroIngresoAlmacen
            AgenteRetencionIVA
            ImporteTotalMinimoAplicacionRetencionIVA
            PorcentajeBaseRetencionIVABienes
            PorcentajeBaseRetencionIVAServicios
            ImporteMinimoRetencionIVA
            ProximoNumeroCertificadoRetencionIVA
            ProximoNumeroCertificadoRetencionIIBB
            IdTipoComprobanteFacturaCompra
            IdTipoComprobanteFacturaVenta
            IdTipoComprobanteDevoluciones
            IdTipoComprobanteNotaDebito
            IdTipoComprobanteNotaCredito
            IdTipoComprobanteRecibo
            IdControlCalidadStandar
            IdTipoCuentaGrupoAnticiposAlPersonal
            IdTipoComprobanteNDInternaAcreedores
            IdTipoComprobanteNCInternaAcreedores
            PercepcionIIBB
            OtrasPercepciones1
            OtrasPercepciones1Desc
            OtrasPercepciones2
            OtrasPercepciones2Desc
            IdCuentaDiferenciaCambio
            ProximoNumeroReciboPago
            NumeroReciboPagoAutomatico
            IdCuentaPercepcionIIBB
            IdCuentaOtrasPercepciones1
            IdCuentaOtrasPercepciones2
            ConfirmarClausulaDolar
            ProximoNumeroPedidoExterior
            ExigirTrasabilidad_RMLA_PE
            AgenteRetencionSUSS
            PorcentajeRetencionSUSS
            ProximoNumeroCertificadoRetencionSUSS
            IdCuentaRetencionSUSS
            IdCuentaPercepcionIVACompras
            IdPuntoVentaNumeracionUnica
            AgenteRetencionIIBB
            PathArchivosExportados
            IdObraStockDisponible
            IdTipoComprobanteOrdenPago
            ProximoNumeroInternoRecepcion
            IdCuentaRetencionSUSS_Recibida
            Plantilla_Factura_A
            Plantilla_Factura_B
            Plantilla_Factura_E
            Plantilla_Devoluciones_A
            Plantilla_Devoluciones_B
            Plantilla_Devoluciones_E
            Plantilla_NotasDebito_A
            Plantilla_NotasDebito_B
            Plantilla_NotasDebito_E
            Plantilla_NotasCredito_A
            Plantilla_NotasCredito_B
            Plantilla_NotasCredito_E
            FechaArranqueCajaYBancos
            IdRubroVentasEnCuotas
            IdConceptoVentasEnCuotas
            IdCuentaPlazosFijos
            IdCuentaInteresesPlazosFijos
            NumeroGeneracionVentaEnCuotas
            IdBancoGestionCobroCuotas
            PathArchivoCobranzaCuotas
            TipoAmortizacionContable
            FrecuenciaAmortizacionContable
            TipoAmortizacionImpositiva
            FrecuenciaAmortizacionImpositiva
            IdCuentaResultadosEjercicio
            IdCuentaResultadosAcumulados
            CuentasResultadoDesde
            CuentasResultadoHasta
            CuentasPatrimonialesDesde
            CuentasPatrimonialesHasta
            IdArticuloVariosParaPRESTO
            ControlarRubrosContablesEnOP
            IdObraActiva
            IdCuentaAdicionalIVACompras1
            IdCuentaAdicionalIVACompras2
            IdCuentaAdicionalIVACompras3
            IdCuentaAdicionalIVACompras4
            IdCuentaAdicionalIVACompras5
            FechaUltimoCierreEjercicio
            EmiteAsientoEnOP
            IdMonedaEuro
            LineasDiarioDetallado
            LineasDiarioResumido
            PathEnvioEmailsMANTENIMIENTO
            PathRecepcionEmailsMANTENIMIENTO
            ImporteComprobantesMParaRetencionIVA
            PorcentajeRetencionIVAComprobantesM
            ImporteComprobantesMParaRetencionGanancias
            PorcentajeRetencionGananciasComprobantesM
            IdTipoComprobanteFacturaCompraExportacion
            IvaCompras_DesglosarNOGRAVADOS
            IdCuentaImpuestosInternos
            Subdiarios_ResumirRegistros
            IdCajaEnPesosDefault
            ProximoNumeroGastoBancario
            ProximoNumeroSolicitudCompra
            IdCuentaReintegros
            IdArticuloPRONTO_MANTENIMIENTO
            ProximoCodigoArticulo
            FechaTimeStamp
            PathPlantillas
            OtrasPercepciones3
            OtrasPercepciones3Desc
            IdCuentaOtrasPercepciones3
            FechaArranqueMovimientosStock
            IdCuentaRetencionIvaComprobantesM
            IdJefeCompras
            ImporteMinimoRetencionIVAServicios
            IdCuentaPercepcionesIVA
            IdCuentaREI_Ganancia
            IdCuentaREI_Perdida
            ActivarCircuitoChequesDiferidos
            BasePRONTOSyJAsociada
            IdConceptoAnticiposSyJ
            IdConceptoRecuperoGastos
            BasePRONTOConsolidacion
            PorcentajeConsolidacion
            BasePRONTOConsolidacion2
            PorcentajeConsolidacion2
            BasePRONTOConsolidacion3
            PorcentajeConsolidacion3
            IdCuentaAjusteConsolidacion
            PathImportacionDatos
            ActivarSolicitudMateriales
            TopeMinimoRetencionIVA
            TopeMinimoRetencionIVAServicios
            IdMonedaPrincipal
            IdTipoComprobanteTarjetaCredito
            ProximoNumeroOrdenTrabajo
            BasePRONTOMantenimiento
            ProximaOrdenPagoFF
        End Enum


        Public Shared Function ParametroOriginal(ByVal SC As String, ByVal Campo As ePmOrg) As String
            Return TraerRenglonUnicoDeTablaParametroOriginal(SC).Item(Campo.ToString).ToString
        End Function






        Public Shared Function ParametroOriginal(ByVal SC As String, ByVal Campo As String) As String
            Return TraerRenglonUnicoDeTablaParametroOriginal(SC).Item(Campo).ToString
        End Function


        ''' <summary>
        ''' Tendría que estar incluida en una transaccion...
        ''' </summary>
        ''' <param name="SC"></param>
        ''' <param name="Campo"></param>
        ''' <param name="Valor"></param>
        ''' <returns></returns>
        ''' <remarks></remarks>
        Public Shared Function GrabarRenglonUnicoDeTablaParametroOriginal(ByVal SC As String, ByVal Campo As ePmOrg, ByVal Valor As String) As Integer
            Dim ds As New System.Data.DataSet
            Dim dr As System.Data.DataRow

            dr = TraerRenglonUnicoDeTablaParametroOriginal(SC)
            ds.Tables.Add(dr.Table.Clone())
            'ds.Tables(0) = dr.Table.Clone()
            'ds.Tables(0).Rows.Add(  .NewRow()
            ds.Tables(0).ImportRow(dr)
            'ds.Tables(0).Rows(0).me.Merge(


            'ds.Tables(0).LoadDataRow()

            Debug.Print(ds.Tables(0).Rows(0).Item("FechaTimeStamp").ToString)
            ds.Tables(0).Rows(0).Item(Campo.ToString) = Valor

            'Return GeneralDB.EjecutarSP(SC, "Parametros_M", ds)
            'devuelve -1 si hubo error, y el id del renglon si hubo exito
            Return ParametroDB.GrabaRenglonDirecto(SC, ds)

        End Function



        Public Shared Function AumentarEnUno() 'esto deberia ser incluido en una transaccion...
            'ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, ParametroManager.ePmOrg.ProximoComprobanteProveedorReferencia, (myComprobantePrv.NumeroReferencia + 1).ToString) = -1 Then
        End Function


        Public Shared Function TraerValorParametro2(ByVal SC As String, ByVal Campo As eParam2) As String
            Return TraerValorParametro2(SC, Campo.ToString).ToString
        End Function


        '<DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function TraerValorParametro2(ByVal SC As String, ByVal Campo As String) As Object
            If Campo.Length > 50 Then Throw New Exception("No puede ser mas largo de 50 caracteres")

            Dim mCampo As String
            Dim oRsParametros2 As System.Data.DataSet

            mCampo = Campo
            If Mid(Campo, 1, 1) = "_" Then mCampo = Mid(Campo, 2, 100)

            oRsParametros2 = GeneralDB.TraerDatos(SC, "Parametros_TX_Parametros2BuscarClave", mCampo)

            TraerValorParametro2 = DBNull.Value
            If oRsParametros2.Tables(0).Rows.Count > 0 Then
                With oRsParametros2.Tables(0).Rows(0)
                    If Len(IIf(IsNull(.Item("Valor")), "", .Item("Valor"))) = 0 Then
                        TraerValorParametro2 = DBNull.Value
                    Else
                        TraerValorParametro2 = .Item("Valor")
                    End If
                End With
            End If
            oRsParametros2 = Nothing
        End Function


        Public Shared Function GuardarValorParametro2(ByVal SC As String, ByVal Campo As eParam2, ByVal Valor As String) As String
            GuardarValorParametro2(SC, Campo.ToString, Valor)
        End Function

        Public Shared Sub GuardarValorParametro2(ByVal SC As String, ByVal Campo As String, ByVal Valor As String)
            If Campo.Length > 50 Then Throw New Exception("No puede ser mas largo de 50 caracteres")

            Dim mCampo As String

            mCampo = Campo
            If Mid(Campo, 1, 1) = "_" Then mCampo = Mid(Campo, 2, 100)

            GeneralDB.EjecutarSP(SC, "Parametros_RegistrarParametros2", mCampo, Valor)

        End Sub

    End Class

End Namespace
