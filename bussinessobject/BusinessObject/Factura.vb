Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class Factura
        Private _Id As Integer = -1
        Private _Numero As Integer = 0
        Private _Fecha As DateTime = DateTime.MinValue
        Private _IdObra As Integer = 0
        Private _Obra As String = String.Empty
        Private _IdSolicito As Integer = 0
        Private _Solicito As String = String.Empty
        Private _LugarEntrega As String = String.Empty
        Private _Observaciones As String = String.Empty
        Private _IdSector As Integer = 0
        Private _Sector As String = String.Empty
        Private _IdComprador As Integer = 0
        Private _Comprador As String = String.Empty
        Private _IdAprobo As Integer = 0
        Private _Aprobo As String = String.Empty
        Private _FechaAprobacion As DateTime = DateTime.MinValue
        Private _MontoPrevisto As Double = 0
        Private _MontoParaCompra As Double = 0
        Private _Cumplido As String = String.Empty
        Private _UsuarioAnulacion As String = String.Empty
        Private _FechaAnulacion As DateTime = DateTime.MinValue
        Private _MotivoAnulacion As String = String.Empty
        Private _IdFacturaOriginal As Integer = 0
        Private _IdOrigenTransmision As Integer = 0
        Private _FechaImportacionTransmision As DateTime = DateTime.MinValue
        Private _IdImporto As Integer = 0
        Private _FechaLlegadaImportacion As DateTime = DateTime.MinValue
        Private _IdAutorizoCumplido As Integer = 0
        Private _IdDioPorCumplido As Integer = 0
        Private _FechaDadoPorCumplido As DateTime = DateTime.MinValue
        Private _ObservacionesCumplido As String = String.Empty
        Private _IdMoneda As Integer = 0
        Private _Detalle As String = String.Empty
        Private _Confirmado As String = String.Empty
        Private _IdEquipoDestino As Integer = 0
        Private _Impresa As String = String.Empty
        Private _Recepcionado As String = String.Empty
        Private _Entregado As String = String.Empty
        Private _TipoFactura As String = String.Empty
        Private _IdOrdenTrabajo As Integer = 0
        Private _IdTipoCompra As Integer = 0
        Private _CircuitoFirmasCompleto As String = String.Empty
        Private _Detalles As FacturaItemList = New FacturaItemList
        Private _DirectoACompras As String = String.Empty


        Public IdCliente As Integer = 0
        Public IdPuntoVenta As Integer = 0
        Public IdCondicionVenta As Integer = 0

        Public Bonificacion As Double = 0
        Public ImporteIva1 As Double = 0

        Public Anulada As String
        Public IdAutorizaAnulacion As Long

        Public PorcentajeBonificacion As Double = 0

        Public PorcentajeIva1 As Double = 0
        Public PorcentajeIva2 As Double = 0

        Public Cotizacion As Double = 0

        Public IBrutos As Double = 0
        Public NumeroCertificadoPercepcionIIBB As Long = 0


        Public SubTotal, TotalBonifEnItems, TotalBonifSobreElTotal, TotalSubGravado, Total As Double 'estos no los tiene el objeto?



        Public OtrasPercepciones1 As Double = 0
        Public OtrasPercepciones2 As Double = 0
        Public OtrasPercepciones3 As Double = 0

        Public __COMPRONTO_Factura 'As compronto.factura




        'Agregado para web
        Private _FechaCierreCompulsa As DateTime = DateTime.MinValue
        Private _ConfirmadoPorWeb As String = String.Empty
        Private _FechaRespuestaWeb As DateTime = DateTime.MinValue
        Private _NombreUsuarioWeb As String = String.Empty

        Public CotizacionMoneda As Double = 0
        Public CotizacionDolar As Double = 0
        Public FechaVencimiento As DateTime = DateTime.MinValue


        Public DetallesProvincias As FacturaProvinciasItemList = New FacturaProvinciasItemList
        Public DetallesRemitos As FacturaRemitosItemList = New FacturaRemitosItemList
        Public DetallesOrdenesCompra As FacturaOrdenesCompraItemList = New FacturaOrdenesCompraItemList




        Public TipoABC As String = String.Empty
        Public PuntoVenta As Integer = 0
        Public FechaFactura As DateTime = DateTime.MinValue
        Public IdVendedor As Integer = 0
        Public IdTransportista1 As Integer = 0
        Public IdTransportista2 As Integer = 0
        Public ItemDireccion
        Public OrdenCompra
        Public TipoPedidoConsignacion
        Public IdRemito As Integer = 0
        Public NumeroRemito As Integer = 0
        Public IdPedido As Integer = 0
        Public NumeroPedido As Integer = 0
        Public ImporteIva2 As Double = 0
        Public ImporteBonificacion As Double = 0
        Public RetencionIBrutos1 As Double = 0
        Public PorcentajeIBrutos1 As Double = 0
        Public RetencionIBrutos2 As Double = 0
        Public PorcentajeIBrutos2 As Double = 0
        Public ConvenioMultilateral
        Public RetencionIBrutos3 As Double = 0
        Public PorcentajeIBrutos3 As Double = 0
        Public IdTipoVentaC As Integer = 0
        Public ImporteIvaIncluido
        Public EsMuestra As String = String.Empty
        Public CotizacionADolarFijo As Double = 0
        Public ImporteParteEnDolares As Double = 0
        Public ImporteParteEnPesos As Double = 0
        Public IVANoDiscriminado As Double = 0
        Public OtrasPercepciones1Desc As String = String.Empty
        Public OtrasPercepciones2Desc As String = String.Empty
        Public IdProvinciaDestino As Integer = 0
        Public IdIBCondicion As Integer = 0
        Public NumeroCAI As Long = 0
        Public FechaVencimientoCAI As DateTime = DateTime.MinValue
        Public NumeroTicketInicial As Integer = 0
        Public NumeroTicketFinal As Integer = 0
        Public IdUsuarioIngreso As Integer = 0
        Public FechaIngreso As DateTime = DateTime.MinValue
        Public IdIBCondicion2 As Integer = 0
        Public IdIBCondicion3 As Integer = 0
        Public IdCodigoIva As Integer = 0
        Public Exportacion_FOB
        Public Exportacion_PosicionAduana
        Public Exportacion_Despacho
        Public Exportacion_Guia
        Public Exportacion_IdPaisDestino As Integer = 0
        Public Exportacion_FechaEmbarque As DateTime = DateTime.MinValue
        Public Exportacion_FechaOficializacion As DateTime = DateTime.MinValue
        Public OtrasPercepciones3Desc As String = String.Empty
        Public NoIncluirEnCubos
        Public PercepcionIVA As Double = 0
        Public PorcentajePercepcionIVA As Double = 0
        Public ActivarRecuperoGastos
        Public IdAutorizoRecuperoGastos As Integer = 0
        Public ContabilizarAFechaVencimiento
        Public FacturaContado
        Public IdReciboContado As Integer = 0
        Public EnviarEmail As String = String.Empty
        Public CuitClienteTransmision
        Public IdReciboContadoOriginal As Integer = 0
        Public DevolucionAnticipo As Double = 0
        Public PorcentajeDevolucionAnticipo As Double = 0
        Public CAE
        Public RechazoCAE
        Public FechaVencimientoORechazoCAE As DateTime = DateTime.MinValue
        Public IdListaPrecios As Integer = 0
        Public IdIdentificacionCAE As Integer = 0

        Public AjusteIva As Double = 0
        Public TipoExportacion As Integer = 0
        Public PermisoEmbarque As String = String.Empty
        Public NumeroFacturaInicial As Integer = 0
        Public NumeroFacturaFinal As Integer = 0
        Public CodigoIdAuxiliar As Integer = 0
        Public NumeroCertificadoObra As Integer = 0
        Public ImporteCertificacionObra As Double = 0
        Public FondoReparoCertificacionObra As Double = 0
        Public PorcentajeRetencionesEstimadasCertificacionObra As Double = 0
        Public NumeroExpedienteCertificacionObra As String = String.Empty


        <DataObjectFieldAttribute(True, True, False)> _
        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property

        'Public Property Numero() As Integer
        '    Get
        '        Return __COMPRONTO_Factura.Registro.Fields("NumeroFactura").Value
        '    End Get
        '    Set(ByVal value As Integer)
        '        __COMPRONTO_Factura.Registro.Fields("NumeroFactura").Value = value
        '    End Set
        'End Property

        Public Property Numero() As Integer
            Get
                Return _Numero
            End Get
            Set(ByVal value As Integer)
                _Numero = value
            End Set
        End Property

        Public Property Fecha() As DateTime
            Get
                Return _Fecha
            End Get
            Set(ByVal value As DateTime)
                _Fecha = value
            End Set
        End Property

        Public Property IdObra() As Integer
            Get
                Return _IdObra
            End Get
            Set(ByVal value As Integer)
                _IdObra = value
            End Set
        End Property

        Public Property Obra() As String
            Get
                Return _Obra
            End Get
            Set(ByVal value As String)
                _Obra = value
            End Set
        End Property

        Public Property IdSolicito() As Integer
            Get
                Return _IdSolicito
            End Get
            Set(ByVal value As Integer)
                _IdSolicito = value
            End Set
        End Property

        Public Property Solicito() As String
            Get
                Return _Solicito
            End Get
            Set(ByVal value As String)
                _Solicito = value
            End Set
        End Property

        Public Property LugarEntrega() As String
            Get
                Return _LugarEntrega
            End Get
            Set(ByVal value As String)
                _LugarEntrega = value
            End Set
        End Property

        Public Property Observaciones() As String
            Get
                Return _Observaciones
            End Get
            Set(ByVal value As String)
                _Observaciones = value
            End Set
        End Property

        Public Property IdSector() As Integer
            Get
                Return _IdSector
            End Get
            Set(ByVal value As Integer)
                _IdSector = value
            End Set
        End Property

        Public Property Sector() As String
            Get
                Return _Sector
            End Get
            Set(ByVal value As String)
                _Sector = value
            End Set
        End Property

        Public Property IdComprador() As Integer
            Get
                Return _IdComprador
            End Get
            Set(ByVal value As Integer)
                _IdComprador = value
            End Set
        End Property

        Public Property Comprador() As String
            Get
                Return _Comprador
            End Get
            Set(ByVal value As String)
                _Comprador = value
            End Set
        End Property

        Public Property IdAprobo() As Integer
            Get
                Return _IdAprobo
            End Get
            Set(ByVal value As Integer)
                _IdAprobo = value
            End Set
        End Property

        Public Property Aprobo() As String
            Get
                Return _Aprobo
            End Get
            Set(ByVal value As String)
                _Aprobo = value
            End Set
        End Property

        Public Property FechaAprobacion() As DateTime
            Get
                Return _FechaAprobacion
            End Get
            Set(ByVal value As DateTime)
                _FechaAprobacion = value
            End Set
        End Property

        Public Property MontoPrevisto() As Double
            Get
                Return _MontoPrevisto
            End Get
            Set(ByVal value As Double)
                _MontoPrevisto = value
            End Set
        End Property

        Public Property MontoParaCompra() As Double
            Get
                Return _MontoParaCompra
            End Get
            Set(ByVal value As Double)
                _MontoParaCompra = value
            End Set
        End Property

        Public Property Cumplido() As String
            Get
                Return _Cumplido
            End Get
            Set(ByVal value As String)
                _Cumplido = value
            End Set
        End Property

        Public Property UsuarioAnulacion() As String
            Get
                Return _UsuarioAnulacion
            End Get
            Set(ByVal value As String)
                _UsuarioAnulacion = value
            End Set
        End Property

        Public Property FechaAnulacion() As DateTime
            Get
                Return _FechaAnulacion
            End Get
            Set(ByVal value As DateTime)
                _FechaAnulacion = value
            End Set
        End Property

        Public Property MotivoAnulacion() As String
            Get
                Return _MotivoAnulacion
            End Get
            Set(ByVal value As String)
                _MotivoAnulacion = value
            End Set
        End Property

        Public Property IdFacturaOriginal() As Integer
            Get
                Return _IdFacturaOriginal
            End Get
            Set(ByVal value As Integer)
                _IdFacturaOriginal = value
            End Set
        End Property

        Public Property IdOrigenTransmision() As Integer
            Get
                Return _IdOrigenTransmision
            End Get
            Set(ByVal value As Integer)
                _IdOrigenTransmision = value
            End Set
        End Property

        Public Property FechaImportacionTransmision() As DateTime
            Get
                Return _FechaImportacionTransmision
            End Get
            Set(ByVal value As DateTime)
                _FechaImportacionTransmision = value
            End Set
        End Property

        Public Property IdImporto() As Integer
            Get
                Return _IdImporto
            End Get
            Set(ByVal value As Integer)
                _IdImporto = value
            End Set
        End Property

        Public Property FechaLlegadaImportacion() As DateTime
            Get
                Return _FechaLlegadaImportacion
            End Get
            Set(ByVal value As DateTime)
                _FechaLlegadaImportacion = value
            End Set
        End Property

        Public Property IdAutorizoCumplido() As Integer
            Get
                Return _IdAutorizoCumplido
            End Get
            Set(ByVal value As Integer)
                _IdAutorizoCumplido = value
            End Set
        End Property

        Public Property IdDioPorCumplido() As Integer
            Get
                Return _IdDioPorCumplido
            End Get
            Set(ByVal value As Integer)
                _IdDioPorCumplido = value
            End Set
        End Property

        Public Property FechaDadoPorCumplido() As DateTime
            Get
                Return _FechaDadoPorCumplido
            End Get
            Set(ByVal value As DateTime)
                _FechaDadoPorCumplido = value
            End Set
        End Property

        Public Property ObservacionesCumplido() As String
            Get
                Return _ObservacionesCumplido
            End Get
            Set(ByVal value As String)
                _ObservacionesCumplido = value
            End Set
        End Property

        Public Property IdMoneda() As Integer
            Get
                Return _IdMoneda
            End Get
            Set(ByVal value As Integer)
                _IdMoneda = value
            End Set
        End Property

        Public Property Detalle() As String
            Get
                Return _Detalle
            End Get
            Set(ByVal value As String)
                _Detalle = value
            End Set
        End Property

        Public Property Confirmado() As String
            Get
                Return _Confirmado
            End Get
            Set(ByVal value As String)
                _Confirmado = value
            End Set
        End Property

        Public Property IdEquipoDestino() As Integer
            Get
                Return _IdEquipoDestino
            End Get
            Set(ByVal value As Integer)
                _IdEquipoDestino = value
            End Set
        End Property

        Public Property Impresa() As String
            Get
                Return _Impresa
            End Get
            Set(ByVal value As String)
                _Impresa = value
            End Set
        End Property

        Public Property Recepcionado() As String
            Get
                Return _Recepcionado
            End Get
            Set(ByVal value As String)
                _Recepcionado = value
            End Set
        End Property

        Public Property Entregado() As String
            Get
                Return _Entregado
            End Get
            Set(ByVal value As String)
                _Entregado = value
            End Set
        End Property

        Public Property TipoFactura() As String
            Get
                Return _TipoFactura
            End Get
            Set(ByVal value As String)
                _TipoFactura = value
            End Set
        End Property

        Public Property IdOrdenTrabajo() As Integer
            Get
                Return _IdOrdenTrabajo
            End Get
            Set(ByVal value As Integer)
                _IdOrdenTrabajo = value
            End Set
        End Property

        Public Property IdTipoCompra() As Integer
            Get
                Return _IdTipoCompra
            End Get
            Set(ByVal value As Integer)
                _IdTipoCompra = value
            End Set
        End Property

        Public Property CircuitoFirmasCompleto() As String
            Get
                Return _CircuitoFirmasCompleto
            End Get
            Set(ByVal value As String)
                _CircuitoFirmasCompleto = value
            End Set
        End Property


        Public Property ConfirmadoPorWeb() As String
            Get
                Return _ConfirmadoPorWeb
            End Get
            Set(ByVal value As String)
                _ConfirmadoPorWeb = value
            End Set
        End Property

        Public Property DirectoACompras() As String
            Get
                Return _DirectoACompras
            End Get
            Set(ByVal value As String)
                _DirectoACompras = value
            End Set
        End Property





        Public Property Detalles() As FacturaItemList
            Get
                Return _Detalles
            End Get
            Set(ByVal value As FacturaItemList)
                _Detalles = value
            End Set
        End Property


        Public Function BuscarRenglonPorIdDetalle(ByVal id As Integer) As FacturaItem
            If _Detalles.Count = 0 Then
                Throw New ApplicationException("No hay detalle. Verificar que el objeto fue cargado con el parametro TraerDetalle en True")
            Else
                Return _Detalles.Find(Function(obj) obj.Id = id)
            End If
        End Function

    End Class

End Namespace