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
        Private _Anulada As String = "NO" 'String.Empty
        Private _IdUsuarioAnulo As Integer = 0
        Private _FechaAnulacion As DateTime = DateTime.MinValue
        Private _Observaciones As String = String.Empty
        Private _FechaTimeStamp As Long
        Private _Vendedor As Integer = 0
        Private _CuentaOrden1 As Integer = 0
        Private _CuentaOrden2 As Integer = 0
        Private _Corredor As Integer = 0
        Private _Procedencia As Integer = 0
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

        Public IdUsuarioModifico As Integer = 0
        Public FechaModificacion As Date
        Public FechaEmision As Date


        Public IdEstablecimiento As Integer = 0
        Public IdTipoMovimiento As Integer = 0

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
        Public NRecibo As String
        Public CalidadDe As Integer = 0
        Public TaraFinal As Double = 0
        Public BrutoFinal As Double = 0



        Public Fumigada As Double = 0
        Public Secada As Double = 0

        Public Exporta As Boolean
        Public Cosecha As String

        Public ObviarAdvertencias As Boolean = False


        Public ExcluirDeSubcontratistas As Boolean


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



        Public CalidadPuntaSombreada As Double = 0
        Public CalidadDescuentoFinal As Double = 0


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


        Public AgregaItemDeGastosAdministrativos As Boolean


        Public CalidadGranosQuemados As Double = 0
        Public CalidadGranosQuemadosBonifRebaja As Integer
        Public CalidadTierra As Double = 0
        Public CalidadTierraBonifRebaja As Integer
        Public CalidadMermaChamico As Double = 0
        Public CalidadMermaChamicoBonifRebaja As Integer
        Public CalidadMermaZarandeo As Double = 0
        Public CalidadMermaZarandeoBonifRebaja As Integer
        Public FueraDeEstandar As Boolean

        Public CobraAcarreo As Boolean = True
        Public LiquidaViaje As Boolean = False

        Public SubnumeroDeFacturacion As Integer = 0
        Public IdClienteAFacturarle As Integer = 0

        Public IdClienteAuxiliar As Integer? = 0
        Public IdClienteEntregador As Integer? = 0
        Public IdClientePagadorFlete As Integer? = 0



        Public SojaSustentableCodCondicion As String
        Public SojaSustentableCondicion As String
        Public SojaSustentableNroEstablecimientoDeProduccion As String


        Public TitularDesc As String
        Public IntermediarioDesc As String
        Public RComercialDesc As String
        Public CorredorDesc As String
        Public DestinatarioDesc As String
        Public Producto As String
        Public ProcedenciaDesc As String
        Public DestinoDesc As String
        Public CalidadDesc As String

        Public UsuarioIngreso As String





        Public PathImagen As String
        Public PathImagen2 As String


        Public Acopio1 As Integer
        Public Acopio2 As Integer
        Public Acopio3 As Integer
        Public Acopio4 As Integer
        Public Acopio5 As Integer
        Public Acopio6 As Integer


        Public AcopioFacturarleA As Integer



        Public CalidadGranosExtranosRebaja As Double = 0
        Public CalidadGranosDanadosRebaja As Double = 0



        Public CalidadGranosExtranosMerma As Double = 0
        Public CalidadQuebradosMerma As Double = 0
        Public CalidadDanadosMerma As Double = 0
        Public CalidadChamicoMerma As Double = 0
        Public CalidadRevolcadosMerma As Double = 0
        Public CalidadObjetablesMerma As Double = 0
        Public CalidadAmohosadosMerma As Double = 0
        Public CalidadPuntaSombreadaMerma As Double = 0
        Public CalidadHectolitricoMerma As Double = 0
        Public CalidadCarbonMerma As Double = 0
        Public CalidadPanzaBlancaMerma As Double = 0
        Public CalidadPicadosMerma As Double = 0
        Public CalidadVerdesMerma As Double = 0
        Public CalidadQuemadosMerma As Double = 0
        Public CalidadTierraMerma As Double = 0
        Public CalidadZarandeoMerma As Double = 0
        Public CalidadDescuentoFinalMerma As Double = 0
        Public CalidadHumedadMerma As Double = 0
        Public CalidadGastosFumigacionMerma As Double = 0


        Public CalidadQuebradosRebaja As Double = 0
        Public CalidadChamicoRebaja As Double = 0
        Public CalidadRevolcadosRebaja As Double = 0
        Public CalidadObjetablesRebaja As Double = 0
        Public CalidadAmohosadosRebaja As Double = 0
        Public CalidadPuntaSombreadaRebaja As Double = 0
        Public CalidadHectolitricoRebaja As Double = 0
        Public CalidadCarbonRebaja As Double = 0
        Public CalidadPanzaBlancaRebaja As Double = 0
        Public CalidadPicadosRebaja As Double = 0
        Public CalidadVerdesRebaja As Double = 0
        Public CalidadQuemadosRebaja As Double = 0
        Public CalidadTierraRebaja As Double = 0
        Public CalidadZarandeoRebaja As Double = 0
        Public CalidadDescuentoFinalRebaja As Double = 0
        Public CalidadHumedadRebaja As Double = 0
        Public CalidadGastosFumigacionRebaja As Double = 0

        Public CalidadGastosFumigacionResultado As Double = 0
        Public CalidadHumedadResultado As Double = 0



        Public TipoMermaGastoDeSecada As Double = 0
        Public TipoMermaVolatil As Double = 0
        Public TipoMermaFondoNidera As Double = 0
        Public TipoMermaConvenida As Double = 0
        Public TipoMermaTalCualVicentin As Double = 0


        Public CalidadGastoDeSecada As Double = 0
        Public CalidadGastoDeSecadaMerma As Double = 0
        Public CalidadGastoDeSecadaRebaja As Double = 0

        Public CalidadMermaVolatil As Double = 0
        Public CalidadMermaVolatilMerma As Double = 0
        Public CalidadMermaVolatilRebaja As Double = 0

        Public CalidadFondoNidera As Double = 0
        Public CalidadFondoNideraMerma As Double = 0
        Public CalidadFondoNideraRebaja As Double = 0

        Public CalidadMermaConvenida As Double = 0
        Public CalidadMermaConvenidaMerma As Double = 0
        Public CalidadMermaConvenidaRebaja As Double = 0

        Public CalidadTalCualVicentin As Double = 0
        Public CalidadTalCualVicentinMerma As Double = 0
        Public CalidadTalCualVicentinRebaja As Double = 0


        Public TieneRecibidorOficial As Boolean = False
        Public EstadoRecibidor As enumEstadosDeRecibidor
        Public MotivoRechazo As enumRechazosDeRecibidor
        Public ClienteAcondicionador As Integer? = 0


        Public FacturarAManual As Boolean = False

        Public EntregaSAP As String

        Public Situacion As Integer? = 2 '"en posicion" como default
        Public SituacionAntesDeEditarManualmente As Integer? = 0
        Public FechaActualizacionAutomatica As DateTime = DateTime.MinValue
        Public FechaAutorizacion As DateTime = DateTime.MinValue
        Public ObservacionesSituacion As String
        Public SituacionLog As String





        'Public CartaLINQ As New CartasDePorte 'probar poniendo el "Serialization Mode" del .dbml en "Unidirectional" (porque explota al intentar meterlo en el Viewstate)
        '-no... parecería no bastar.... probaré agregando un  " <Serializable()> _ Partial Class CartasDePorte " en un archivo aparte
        '-sigo teniendo problemas. Al final, Mark Gravell me desanima:
        'If this is profile serialization.... I honestly don't know if you can write your own plugin 
        'serialization layer - I've never had need to look; but in this case I would write a 
        'simple, non-LINQ object (a DTO) for the object properties that I actually need in my profile, and 
        'just populate that object from LINQ, and serialize that.



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
        Public Property Procedencia() As Integer
            Get
                Return _Procedencia
            End Get
            Set(ByVal value As Integer)
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

        Public Property NetoFinalDespuesDeRestadasMermas() As Double
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

        Public Property NetoFinalAntesDeRestarMermas() As Double
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


    Public Enum enumEstadosDeRecibidor
        Recibo
        Rechazo
    End Enum

    Public Enum enumRechazosDeRecibidor
        VACIO
        REGRESA_ORIGEN
        ACONDICIONA
        CAMBIA_CP
    End Enum

End Namespace