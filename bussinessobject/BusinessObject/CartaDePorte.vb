Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO
    <Serializable()> Public Class CartaDePorte

        Private _Id As Integer = -1

        Private _NumeroCartaDePorte As Long
        Public NumeroSubfijo As Integer


        Private _IdUsuarioIngreso As Integer = 0
        Private _FechaIngreso As DateTime = DateTime.MinValue
        Private _Anulada As String = String.Empty
        Private _IdUsuarioAnulo As Integer = 0
        Private _FechaAnulacion As DateTime = DateTime.MinValue
        Private _Observaciones As String = String.Empty
        Private _FechaTimeStamp As Long
        Private _Vendedor As Integer = 0
        Private _CuentaOrden1 As Integer = 0
        Private _CuentaOrden2 As Integer = 0
        Private _Corredor As Integer = 0
        Private _Procedencia As String = String.Empty
        Private _Patente As String = String.Empty

        Private _IdArticulo As Integer = 0
        Private _IdStock As Integer = 0

        Private _Partida As String = String.Empty
        Private _IdUnidad As Integer = 0

        Private _IdUbicacion As Integer = 0
        Private _Cantidad As Double = 0

        Private _Cupo As String = String.Empty
        Private _NetoProc As Double = 0
        Private _Calidad As String = String.Empty

        Private _BrutoPto As Double = 0

        Private _TaraPto As Double = 0

        Private _NetoPto As Double = 0

        Private _Acoplado As String = String.Empty

        Private _Humedad As Double = 0
        Private _Merma As Integer = 0

        Private _NetoFinal As Double = 0
        Private _FechaDeCarga As Date

        Private _FechaVencimiento As Date

        Private _CEE As String = String.Empty

        Private _IdTransportista As Integer = 0
        Private _IdChofer As Integer = 0

        Private _TransportistaCUIT As String = String.Empty
        Private _ChoferCUIT As String = String.Empty



        Public bSeLeFactura_a_SyngentaDivisionSeeds As Boolean
        Public bSeLeFactura_a_SyngentaDivisionAgro As Boolean
        Public EnumSyngentaDivision As String

        Public IdEstablecimiento As Integer = 0

        Public Corredor2 As Integer = 0

        Public CTG As Long

        Public Contrato As String

        Public Entregador As Integer = 0

        Public Destino As Integer = 0

        Public Subcontr1 As Integer = 0
        Public Subcontr2 As Integer = 0
        Public Contrato1 As Long = 0 'default es servicio de balanza
        Public Contrato2 As Long = 1 'default es servicio de descarga

        Public KmARecorrer As Double = 0
        Public TarifaTransportista As Double = 0
        Public FechaDescarga As Date
        Public Hora As Date
        Public NRecibo As Long
        Public CalidadDe As Integer = 0
        Public TaraFinal As Double = 0
        Public BrutoFinal As Double = 0



        Public Fumigada As Double = 0
        Public Secada As Double = 0

        Public Exporta As Boolean
        Public Cosecha As String

        'calidad noble
        Public NobleExtranos As Double = 0
        Public NobleNegros As Double = 0
        Public NobleQuebrados As Double = 0
        Public NobleDaniados As Double = 0
        Public NobleChamico As Double = 0
        Public NobleChamico2 As Double = 0
        Public NobleRevolcado As Double = 0
        Public NobleObjetables As Double = 0
        Public NobleAmohosados As Double = 0
        Public NobleHectolitrico As Double = 0
        Public NobleCarbon As Double = 0
        Public NoblePanzaBlanca As Double = 0
        Public NoblePicados As Double = 0
        Public NobleMGrasa As Double = 0
        Public NobleAcidezGrasa As Double = 0
        Public NobleVerdes As Double = 0
        Public NobleGrado As Integer = 0
        Public NobleConforme As Boolean
        Public NobleACamara As Boolean


        Public HumedadDesnormalizada As Double = 0
        Public Factor As Double = 0

        Public IdFacturaImputada As Long
        Public PuntoVenta As Long
        Public SubnumeroVagon As Long


        Public TarifaCobradaAlCliente As Double = 0
        Public TarifaSubcontratista1 As Double = 0
        Public TarifaSubcontratista2 As Double = 0


        Public FechaArribo As Date = DateTime.MinValue
        Public MotivoAnulacion As String = String.Empty






        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property

        Public Property NumeroCartaDePorte() As Long
            Get
                Return _NumeroCartaDePorte
            End Get
            Set(ByVal value As Long)
                _NumeroCartaDePorte = value
            End Set
        End Property

        Public Property IdUsuarioIngreso() As Integer
            Get
                Return _IdUsuarioIngreso
            End Get
            Set(ByVal value As Integer)
                _IdUsuarioIngreso = value
            End Set
        End Property

        Public Property FechaIngreso() As DateTime
            Get
                Return _FechaIngreso
            End Get
            Set(ByVal value As DateTime)
                _FechaIngreso = value
            End Set
        End Property
        Public Property Anulada() As String
            Get
                Return _Anulada
            End Get
            Set(ByVal value As String)
                _Anulada = value
            End Set
        End Property
        Public Property IdUsuarioAnulo() As Integer
            Get
                Return _IdUsuarioAnulo
            End Get
            Set(ByVal value As Integer)
                _IdUsuarioAnulo = value
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

        Public Property Observaciones() As String
            Get
                Return _Observaciones
            End Get
            Set(ByVal value As String)
                _Observaciones = value
            End Set
        End Property

        Public Property FechaTimeStamp() As Long 'As Byte()
            Get
                Return _FechaTimeStamp

            End Get
            Set(ByVal value As Long)
                _FechaTimeStamp = value
            End Set
        End Property

        Public Property Titular() As Integer
            Get
                Return _Vendedor
            End Get
            Set(ByVal value As Integer)
                _Vendedor = value
            End Set
        End Property

        Public Property CuentaOrden1() As Integer
            Get
                Return _CuentaOrden1
            End Get
            Set(ByVal value As Integer)
                _CuentaOrden1 = value
            End Set
        End Property

        Public Property CuentaOrden2() As Integer
            Get
                Return _CuentaOrden2
            End Get
            Set(ByVal value As Integer)
                _CuentaOrden2 = value
            End Set
        End Property
        Public Property Corredor() As Integer
            Get
                Return _Corredor
            End Get
            Set(ByVal value As Integer)
                _Corredor = value
            End Set
        End Property
        Public Property Procedencia() As String
            Get
                Return _Procedencia
            End Get
            Set(ByVal value As String)
                _Procedencia = value
            End Set
        End Property

        Public Property Patente() As String

            Get
                Return _Patente
            End Get
            Set(ByVal value As String)
                _Patente = value
            End Set
        End Property

        Public Property IdArticulo() As Integer
            Get
                Return _IdArticulo
            End Get
            Set(ByVal value As Integer)
                _IdArticulo = value
            End Set
        End Property

        Public Property IdStock() As Integer

            Get
                Return _IdStock
            End Get
            Set(ByVal value As Integer)
                _IdStock = value
            End Set
        End Property

        Public Property Partida() As String
            Get
                Return _Partida

            End Get
            Set(ByVal value As String)
                _Partida = value
            End Set
        End Property

        Public Property IdUnidad() As Integer

            Get
                Return _IdUnidad
            End Get
            Set(ByVal value As Integer)
                _IdUnidad = value
            End Set
        End Property

        Public Property IdUbicacion() As Integer
            Get
                Return _IdUbicacion
            End Get
            Set(ByVal value As Integer)
                _IdUbicacion = value
            End Set
        End Property

        Public Property Cantidad() As Double

            Get
                Return _Cantidad
            End Get
            Set(ByVal value As Double)
                _Cantidad = value
            End Set
        End Property

        Public Property Cupo() As String
            Get
                Return _Cupo
            End Get
            Set(ByVal value As String)
                _Cupo = value
            End Set
        End Property

        Public Property NetoProc() As Double
            Get
                Return _NetoProc
            End Get
            Set(ByVal value As Double)
                _NetoProc = value
            End Set
        End Property

        'Public Property Calidad() As String

        '    Get
        '        Return _Calidad
        '    End Get
        '    Set(ByVal value As String)
        '        _Calidad = value
        '    End Set
        'End Property

        Public Property BrutoPto() As Double
            Get
                Return _BrutoPto
            End Get
            Set(ByVal value As Double)
                _BrutoPto = value
            End Set
        End Property

        Public Property TaraPto() As Double

            Get
                Return _TaraPto
            End Get
            Set(ByVal value As Double)
                _TaraPto = value
            End Set
        End Property

        Public Property NetoPto() As Double
            Get
                Return _NetoPto
            End Get
            Set(ByVal value As Double)
                _NetoPto = value
            End Set
        End Property

        Public Property Acoplado() As String
            Get
                Return _Acoplado
            End Get
            Set(ByVal value As String)
                _Acoplado = value
            End Set
        End Property

        Public Property Humedad() As Double
            Get
                Return _Humedad
            End Get
            Set(ByVal value As Double)
                _Humedad = value
            End Set
        End Property

        Public Property Merma() As Integer

            Get
                Return _Merma
            End Get
            Set(ByVal value As Integer)
                _Merma = value
            End Set
        End Property

        Public Property NetoFinal() As Double
            Get
                Return _NetoFinal
            End Get
            Set(ByVal value As Double)
                _NetoFinal = value
            End Set
        End Property

        Public Property FechaDeCarga() As Date
            Get
                Return _FechaDeCarga
            End Get
            Set(ByVal value As Date)
                _FechaDeCarga = value
            End Set
        End Property

        Public Property FechaVencimiento() As Date
            Get
                Return _FechaVencimiento
            End Get
            Set(ByVal value As Date)
                _FechaVencimiento = value
            End Set

        End Property

        Public Property CEE() As String

            Get
                Return _CEE
            End Get
            Set(ByVal value As String)
                _CEE = value
            End Set
        End Property

        Public Property IdTransportista() As Integer

            Get
                Return _IdTransportista
            End Get
            Set(ByVal value As Integer)
                _IdTransportista = value
            End Set
        End Property

        Public Property TransportistaCUIT() As String
            Get
                Return _TransportistaCUIT
            End Get
            Set(ByVal value As String)
                _TransportistaCUIT = value
            End Set
        End Property

        Public Property IdChofer() As Integer

            Get
                Return _IdChofer
            End Get
            Set(ByVal value As Integer)
                _IdChofer = value
            End Set
        End Property

        Public Property ChoferCUIT() As String
            Get
                Return _ChoferCUIT
            End Get
            Set(ByVal value As String)
                _ChoferCUIT = value
            End Set
        End Property

    End Class

End Namespace