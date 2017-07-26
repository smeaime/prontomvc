Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO


    <Serializable()> Public Class AsientoItem
        Private _Id As Integer = -1
        Private _IdAsiento As Integer
        Private _IdCuenta As Integer = -1
        Private _IdTipoComprobante As Integer = -1
        Private _NumeroComprobante As Integer = Nothing
        Private _FechaComprobante As DateTime = DateTime.MinValue
        Private _Libro As String
        Private _Signo As String
        Private _TipoImporte As String
        Private _Cuit As String
        Private _Detalle As String
        Private _Debe As Double = 0
        Private _Haber As Double = 0
        Private _IdObra As Integer = -1
        Private _IdCuentaGasto As Integer = -1
        Private _IdMoneda As Integer = -1
        Private _CotizacionMoneda As Double = 0
        Private _IdCuentaBancaria As Integer = -1
        Private _IdCaja As Integer = -1
        Private _IdMonedaDestino As Integer = -1
        Private _CotizacionMonedaDestino As Double = 0
        Private _ImporteEnMonedaDestino As Double = 0
        Private _PorcentajeIVA As Double = 0
        Private _RegistrarEnAnalitico As String = "NO"
        Private _Item As Integer = -1
        Private _IdValor As Integer = -1
        Private _IdProvinciaDestino As Integer = -1

        '
        'This is the IdAsiento property.
        '
        Public Property IdAsiento() As Integer
            Get
                Return _IdAsiento
            End Get
            Set(ByVal Value As Integer)
                _IdAsiento = Value
            End Set
        End Property

        '
        'This is the IdCuenta property.
        '
        Public Property IdCuenta() As Integer
            Get
                Return _IdCuenta
            End Get
            Set(ByVal Value As Integer)
                _IdCuenta = Value
            End Set
        End Property

        '
        'This is the IdTipoComprobante property.
        '
        Public Property IdTipoComprobante() As Integer
            Get
                Return _IdTipoComprobante
            End Get
            Set(ByVal Value As Integer)
                _IdTipoComprobante = Value
            End Set
        End Property

        '
        'This is the NumeroComprobante property.
        '
        Public Property NumeroComprobante() As Integer
            Get
                Return _NumeroComprobante
            End Get
            Set(ByVal Value As Integer)
                _NumeroComprobante = Value
            End Set
        End Property

        '
        'This is the FechaComprobante property.
        '
        Public Property FechaComprobante() As DateTime
            Get
                Return _FechaComprobante
            End Get
            Set(ByVal Value As DateTime)
                _FechaComprobante = Value
            End Set
        End Property

        '
        'This is the Libro property.
        '
        Public Property Libro() As String
            Get
                Return _Libro
            End Get
            Set(ByVal Value As String)
                _Libro = Value
            End Set
        End Property

        '
        'This is the Signo property.
        '
        Public Property Signo() As String
            Get
                Return _Signo
            End Get
            Set(ByVal Value As String)
                _Signo = Value
            End Set
        End Property

        '
        'This is the TipoImporte property.
        '
        Public Property TipoImporte() As String
            Get
                Return _TipoImporte
            End Get
            Set(ByVal Value As String)
                _TipoImporte = Value
            End Set
        End Property

        '
        'This is the Cuit property.
        '
        Public Property Cuit() As String
            Get
                Return _Cuit
            End Get
            Set(ByVal Value As String)
                _Cuit = Value
            End Set
        End Property

        '
        'This is the Detalle property.
        '
        Public Property Detalle() As String
            Get
                Return _Detalle
            End Get
            Set(ByVal Value As String)
                _Detalle = Value
            End Set
        End Property

        '

        '


        '
        'This is the IdObra property.
        '
        Public Property IdObra() As Integer
            Get
                Return _IdObra
            End Get
            Set(ByVal Value As Integer)
                _IdObra = Value
            End Set
        End Property

        '
        'This is the IdCuentaGasto property.
        '
        Public Property IdCuentaGasto() As Integer
            Get
                Return _IdCuentaGasto
            End Get
            Set(ByVal Value As Integer)
                _IdCuentaGasto = Value
            End Set
        End Property

        '
        'This is the IdMoneda property.
        '
        Public Property IdMoneda() As Integer
            Get
                Return _IdMoneda
            End Get
            Set(ByVal Value As Integer)
                _IdMoneda = Value
            End Set
        End Property

        '
        'This is the CotizacionMoneda property.
        '
        Public Property CotizacionMoneda() As Double
            Get
                Return _CotizacionMoneda
            End Get
            Set(ByVal Value As Double)
                _CotizacionMoneda = Value
            End Set
        End Property

        '
        'This is the IdCuentaBancaria property.
        '
        Public Property IdCuentaBancaria() As Integer
            Get
                Return _IdCuentaBancaria
            End Get
            Set(ByVal Value As Integer)
                _IdCuentaBancaria = Value
            End Set
        End Property

        '
        'This is the IdCaja property.
        '
        Public Property IdCaja() As Integer
            Get
                Return _IdCaja
            End Get
            Set(ByVal Value As Integer)
                _IdCaja = Value
            End Set
        End Property

        '
        'This is the IdMonedaDestino property.
        '
        Public Property IdMonedaDestino() As Integer
            Get
                Return _IdMonedaDestino
            End Get
            Set(ByVal Value As Integer)
                _IdMonedaDestino = Value
            End Set
        End Property

        '
        'This is the CotizacionMonedaDestino property.
        '
        Public Property CotizacionMonedaDestino() As Double
            Get
                Return _CotizacionMonedaDestino
            End Get
            Set(ByVal Value As Double)
                _CotizacionMonedaDestino = Value
            End Set
        End Property

        '
        'This is the ImporteEnMonedaDestino property.
        '
        Public Property ImporteEnMonedaDestino() As Double
            Get
                Return _ImporteEnMonedaDestino
            End Get
            Set(ByVal Value As Double)
                _ImporteEnMonedaDestino = Value
            End Set
        End Property

        '
        'This is the PorcentajeIVA property.
        '
        Public Property PorcentajeIVA() As Double
            Get
                Return _PorcentajeIVA
            End Get
            Set(ByVal Value As Double)
                _PorcentajeIVA = Value
            End Set
        End Property

        '
        'This is the RegistrarEnAnalitico property.
        '
        Public Property RegistrarEnAnalitico() As String
            Get
                Return _RegistrarEnAnalitico
            End Get
            Set(ByVal Value As String)
                _RegistrarEnAnalitico = Value
            End Set
        End Property

        '
        'This is the Item property.
        '
        Public Property Item() As Integer
            Get
                Return _Item
            End Get
            Set(ByVal Value As Integer)
                _Item = Value
            End Set
        End Property

        '
        'This is the IdValor property.
        '
        Public Property IdValor() As Integer
            Get
                Return _IdValor
            End Get
            Set(ByVal Value As Integer)
                _IdValor = Value
            End Set
        End Property

        '
        'This is the IdProvinciaDestino property.
        '
        Public Property IdProvinciaDestino() As Integer
            Get
                Return _IdProvinciaDestino
            End Get
            Set(ByVal Value As Integer)
                _IdProvinciaDestino = Value
            End Set
        End Property


        Public _CodigoCuenta As String = String.Empty
        Public _DescripcionCuenta As String = String.Empty
        Public _CentroCosto As String = String.Empty


        Private _Eliminado As Boolean = False
        Private _Nuevo As Boolean = False


        Public Property NumeroItem() As String
            Get
                Return _Item
            End Get
            Set(ByVal value As String)
                _Item = value
            End Set
        End Property


        Public Property DescripcionCuenta() As String
            Get
                Return _DescripcionCuenta
            End Get
            Set(ByVal value As String)
                _DescripcionCuenta = value
            End Set
        End Property

        Public Property CentroCosto() As String
            Get
                Return _CentroCosto
            End Get
            Set(ByVal value As String)
                _CentroCosto = value
            End Set
        End Property




        Public Property CodigoCuenta() As String
            Get
                Return _CodigoCuenta
            End Get
            Set(ByVal value As String)
                _CodigoCuenta = value
            End Set
        End Property



        Public Property Debe() As Double
            Get
                Return _Debe
            End Get
            Set(ByVal value As Double)
                _Debe = value
            End Set
        End Property
        Public Property Haber() As Double
            Get
                Return _Haber
            End Get
            Set(ByVal value As Double)
                _Haber = value
            End Set
        End Property





        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property





        Public Property Eliminado() As Boolean
            Get
                Return _Eliminado
            End Get
            Set(ByVal value As Boolean)
                _Eliminado = value
            End Set
        End Property

        Public Property Nuevo() As Boolean
            Get
                Return _Nuevo
            End Get
            Set(ByVal value As Boolean)
                _Nuevo = value
            End Set
        End Property

    End Class

End Namespace