Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class Pedido
        Private _Id As Integer = -1
        Private _Numero As Integer = 0
        Private _Fecha As DateTime = DateTime.MinValue
        Private _IdProveedor As Integer = 0
        Private _Proveedor As String = String.Empty
        Private _LugarEntrega As String = String.Empty
        Private _FormaPago As String = String.Empty
        Private _Observaciones As String = String.Empty
        Private _NetoGravado As Double = 0
        Private _Bonificacion As Double = 0
        Private _TotalIva1 As Double = 0
        Private _TotalPedido As Double = 0
        Private _PorcentajeIva1 As Double = 0
        Private _IdComprador As Integer = 0
        Private _Comprador As String = String.Empty
        Private _PorcentajeBonificacion As Double = 0
        Private _NumeroComparativa As Integer = 0
        Private _Contacto As String = String.Empty
        Private _PlazoEntrega As String = String.Empty
        Private _Garantia As String = String.Empty
        Private _Documentacion As String = String.Empty
        Private _IdAprobo As Integer = 0
        Private _Aprobo As String = String.Empty
        Private _IdMoneda As Integer = 0
        Private _Moneda As String = String.Empty
        Private _FechaAprobacion As DateTime = DateTime.MinValue
        Private _Importante As String = String.Empty
        Private _TipoCompra As Integer = 0
        Private _Cumplido As String = String.Empty
        Private _DetalleCondicionCompra As String = String.Empty
        Private _IdAutorizoCumplido As Integer = 0
        Private _IdDioPorCumplido As Integer = 0
        Private _FechaDadoPorCumplido As DateTime = DateTime.MinValue
        Private _ObservacionesCumplido As String = String.Empty
        Private _SubNumero As Integer = 0
        Private _UsuarioAnulacion As String = String.Empty
        Private _FechaAnulacion As DateTime = DateTime.MinValue
        Private _MotivoAnulacion As String = String.Empty
        Private _ImprimeImportante As String = String.Empty
        Private _ImprimePlazoEntrega As String = String.Empty
        Private _ImprimeLugarEntrega As String = String.Empty
        Private _ImprimeFormaPago As String = String.Empty
        Private _ImprimeImputaciones As String = String.Empty
        Private _ImprimeInspecciones As String = String.Empty
        Private _ImprimeGarantia As String = String.Empty
        Private _ImprimeDocumentacion As String = String.Empty
        Private _CotizacionDolar As Double = 0
        Private _CotizacionMoneda As Double = 0
        Private _PedidoExterior As String = String.Empty
        Private _IdCondicionCompra As Integer = 0
        Private _CondicionCompra As String = String.Empty
        Private _IdPedidoOriginal As Integer = 0
        Private _IdOrigenTransmision As Integer = 0
        Private _FechaImportacionTransmision As DateTime = DateTime.MinValue
        Private _Subcontrato As String = String.Empty
        Private _IdPedidoAbierto As Integer = 0
        Private _NumeroLicitacion As String = String.Empty
        Private _Transmitir_a_SAT As String = String.Empty
        Private _NumeracionAutomatica As String = String.Empty
        Private _Impresa As String = String.Empty
        Private _EmbarcadoA As String = String.Empty
        Private _FacturarA As String = String.Empty
        Private _ProveedorExt As String = String.Empty
        Private _ImpuestosInternos As Double = 0
        Private _FechaSalida As DateTime = DateTime.MinValue
        Private _CodigoControl As Double = 0
        Private _CircuitoFirmasCompleto As String = String.Empty
        Private _RMs As String = String.Empty
        Private _Obras As String = String.Empty
		Private _CantidadItems As Integer = 0
		Private _Presupuestos As String = String.Empty
		Private _Comparativa As String = String.Empty
        Private _Detalles As PedidoItemList = New PedidoItemList

        <DataObjectFieldAttribute(True, True, False)> _
        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property

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

        Public Property IdProveedor() As Integer
            Get
                Return _IdProveedor
            End Get
            Set(ByVal value As Integer)
                _IdProveedor = value
            End Set
        End Property

        Public Property Proveedor() As String
            Get
                Return _Proveedor
            End Get
            Set(ByVal value As String)
                _Proveedor = value
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

        Public Property FormaPago() As String
            Get
                Return _FormaPago
            End Get
            Set(ByVal value As String)
                _FormaPago = value
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

        Public ReadOnly Property NetoGravado() As Double
            Get
                Return _NetoGravado
            End Get
        End Property

        Public Property Bonificacion() As Double
            Get
                Return _Bonificacion
            End Get
            Set(ByVal value As Double)
                _Bonificacion = value
            End Set
        End Property

        Public Property TotalIva1() As Double
            Get
                Return _TotalIva1
            End Get
            Set(ByVal value As Double)
                _TotalIva1 = value
            End Set
        End Property

        Public Property TotalPedido() As Double
            Get
                Return _TotalPedido
            End Get
            Set(ByVal value As Double)
                _TotalPedido = value
            End Set
        End Property

        Public Property PorcentajeIva1() As Double
            Get
                Return _PorcentajeIva1
            End Get
            Set(ByVal value As Double)
                _PorcentajeIva1 = value
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

        Public Property PorcentajeBonificacion() As Double
            Get
                Return _PorcentajeBonificacion
            End Get
            Set(ByVal value As Double)
                _PorcentajeBonificacion = value
            End Set
        End Property

        Public Property NumeroComparativa() As Integer
            Get
                Return _NumeroComparativa
            End Get
            Set(ByVal value As Integer)
                _NumeroComparativa = value
            End Set
        End Property

        Public Property Contacto() As String
            Get
                Return _Contacto
            End Get
            Set(ByVal value As String)
                _Contacto = value
            End Set
        End Property

        Public Property PlazoEntrega() As String
            Get
                Return _PlazoEntrega
            End Get
            Set(ByVal value As String)
                _PlazoEntrega = value
            End Set
        End Property

        Public Property Garantia() As String
            Get
                Return _Garantia
            End Get
            Set(ByVal value As String)
                _Garantia = value
            End Set
        End Property

        Public Property Documentacion() As String
            Get
                Return _Documentacion
            End Get
            Set(ByVal value As String)
                _Documentacion = value
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

        Public Property IdMoneda() As Integer
            Get
                Return _IdMoneda
            End Get
            Set(ByVal value As Integer)
                _IdMoneda = value
            End Set
        End Property

        Public Property Moneda() As String
            Get
                Return _Moneda
            End Get
            Set(ByVal value As String)
                _Moneda = value
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

        Public Property Importante() As String
            Get
                Return _Importante
            End Get
            Set(ByVal value As String)
                _Importante = value
            End Set
        End Property

        Public Property TipoCompra() As Integer
            Get
                Return _TipoCompra
            End Get
            Set(ByVal value As Integer)
                _TipoCompra = value
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

        Public Property DetalleCondicionCompra() As String
            Get
                Return _DetalleCondicionCompra
            End Get
            Set(ByVal value As String)
                _DetalleCondicionCompra = value
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

        Public Property SubNumero() As Integer
            Get
                Return _SubNumero
            End Get
            Set(ByVal value As Integer)
                _SubNumero = value
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

        Public Property ImprimeImportante() As String
            Get
                Return _ImprimeImportante
            End Get
            Set(ByVal value As String)
                _ImprimeImportante = value
            End Set
        End Property

        Public Property ImprimePlazoEntrega() As String
            Get
                Return _ImprimePlazoEntrega
            End Get
            Set(ByVal value As String)
                _ImprimePlazoEntrega = value
            End Set
        End Property

        Public Property ImprimeLugarEntrega() As String
            Get
                Return _ImprimeLugarEntrega
            End Get
            Set(ByVal value As String)
                _ImprimeLugarEntrega = value
            End Set
        End Property

        Public Property ImprimeFormaPago() As String
            Get
                Return _ImprimeFormaPago
            End Get
            Set(ByVal value As String)
                _ImprimeFormaPago = value
            End Set
        End Property

        Public Property ImprimeImputaciones() As String
            Get
                Return _ImprimeImputaciones
            End Get
            Set(ByVal value As String)
                _ImprimeImputaciones = value
            End Set
        End Property

        Public Property ImprimeInspecciones() As String
            Get
                Return _ImprimeInspecciones
            End Get
            Set(ByVal value As String)
                _ImprimeInspecciones = value
            End Set
        End Property

        Public Property ImprimeGarantia() As String
            Get
                Return _ImprimeGarantia
            End Get
            Set(ByVal value As String)
                _ImprimeGarantia = value
            End Set
        End Property

        Public Property ImprimeDocumentacion() As String
            Get
                Return _ImprimeDocumentacion
            End Get
            Set(ByVal value As String)
                _ImprimeDocumentacion = value
            End Set
        End Property

        Public Property CotizacionDolar() As Double
            Get
                Return _CotizacionDolar
            End Get
            Set(ByVal value As Double)
                _CotizacionDolar = value
            End Set
        End Property

        Public Property CotizacionMoneda() As Double
            Get
                Return _CotizacionMoneda
            End Get
            Set(ByVal value As Double)
                _CotizacionMoneda = value
            End Set
        End Property

        Public Property PedidoExterior() As String
            Get
                Return _PedidoExterior
            End Get
            Set(ByVal value As String)
                _PedidoExterior = value
            End Set
        End Property

        Public Property IdCondicionCompra() As Integer
            Get
                Return _IdCondicionCompra
            End Get
            Set(ByVal value As Integer)
                _IdCondicionCompra = value
            End Set
        End Property

        Public Property CondicionCompra() As String
            Get
                Return _CondicionCompra
            End Get
            Set(ByVal value As String)
                _CondicionCompra = value
            End Set
        End Property

        Public Property IdPedidoOriginal() As Integer
            Get
                Return _IdPedidoOriginal
            End Get
            Set(ByVal value As Integer)
                _IdPedidoOriginal = value
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

        Public Property Subcontrato() As String
            Get
                Return _Subcontrato
            End Get
            Set(ByVal value As String)
                _Subcontrato = value
            End Set
        End Property

        Public Property IdPedidoAbierto() As Integer
            Get
                Return _IdPedidoAbierto
            End Get
            Set(ByVal value As Integer)
                _IdPedidoAbierto = value
            End Set
        End Property

        Public Property NumeroLicitacion() As String
            Get
                Return _NumeroLicitacion
            End Get
            Set(ByVal value As String)
                _NumeroLicitacion = value
            End Set
        End Property

        Public Property Transmitir_a_SAT() As String
            Get
                Return _Transmitir_a_SAT
            End Get
            Set(ByVal value As String)
                _Transmitir_a_SAT = value
            End Set
        End Property

        Public Property NumeracionAutomatica() As String
            Get
                Return _NumeracionAutomatica
            End Get
            Set(ByVal value As String)
                _NumeracionAutomatica = value
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

        Public Property EmbarcadoA() As String
            Get
                Return _EmbarcadoA
            End Get
            Set(ByVal value As String)
                _EmbarcadoA = value
            End Set
        End Property

        Public Property FacturarA() As String
            Get
                Return _FacturarA
            End Get
            Set(ByVal value As String)
                _FacturarA = value
            End Set
        End Property

        Public Property ProveedorExt() As String
            Get
                Return _ProveedorExt
            End Get
            Set(ByVal value As String)
                _ProveedorExt = value
            End Set
        End Property

        Public Property ImpuestosInternos() As Double
            Get
                Return _ImpuestosInternos
            End Get
            Set(ByVal value As Double)
                _ImpuestosInternos = value
            End Set
        End Property

        Public Property FechaSalida() As DateTime
            Get
                Return _FechaSalida
            End Get
            Set(ByVal value As DateTime)
                _FechaSalida = value
            End Set
        End Property

        Public Property CodigoControl() As Double
            Get
                Return _CodigoControl
            End Get
            Set(ByVal value As Double)
                _CodigoControl = value
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

		Public Property RMs() As String
			Get
				Return _RMs
			End Get
			Set(ByVal value As String)
				_RMs = value
			End Set
		End Property

        Public Property Obras() As String
            Get
                Return _Obras
            End Get
            Set(ByVal value As String)
                _Obras = value
            End Set
        End Property

        Public Property CantidadItems() As Integer
            Get
                Return _CantidadItems
            End Get
            Set(ByVal value As Integer)
                _CantidadItems = value
            End Set
        End Property

		Public Property Presupuestos() As String
			Get
				Return _Presupuestos
			End Get
			Set(ByVal value As String)
				_Presupuestos = value
			End Set
		End Property

		Public Property Comparativa() As String
			Get
				Return _Comparativa
			End Get
			Set(ByVal value As String)
				_Comparativa = value
			End Set
		End Property

        Public Property Detalles() As PedidoItemList
            Get
                Return _Detalles
            End Get
            Set(ByVal value As PedidoItemList)
                _Detalles = value
            End Set
        End Property

    End Class

End Namespace