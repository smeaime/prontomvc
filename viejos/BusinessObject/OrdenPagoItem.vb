Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class OrdenPagoItem
        Private _Id As Integer = -1

        Public IdOrdenPago As Integer = 0
        Public IdImputacion As Integer = 0
        Private _Importe As Double = 0
        Private _Saldo As Double = 0
        Public SaldoParteEnDolaresAnterior As Double = 0
        Public PagadoParteEnDolares As Double = 0
        Public NuevoSaldoParteEnDolares As Double = 0
        Private _SaldoParteEnPesosAnterior As Double = 0
        Public PagadoParteEnPesos As Double = 0
        Public NuevoSaldoParteEnPesos As Double = 0
        Public EnviarEmail As Integer = 0
        Public IdOrigenTransmision As Integer = 0
        Public IdOrdenPagoOriginal As Integer = 0
        Public IdDetalleOrdenPagoOriginal As Integer = 0
        Public FechaImportacionTransmision As DateTime = DateTime.MinValue

        Public _GravadoIVA As Double = 0
        Public _IVA As Double = 0
        Public _ImporteRetencionIVA As Double = 0
        Public _ImporteRetencionIngresosBrutos As Double = 0
        Public _ImportePagadoSinImpuestos As Double = 0

        Public Property GravadoIVA() As Double
            Get
                Return _GravadoIVA
            End Get
            Set(ByVal value As Double)
                _GravadoIVA = value
            End Set
        End Property

        Public Property IVA() As Double
            Get
                Return _IVA
            End Get
            Set(ByVal value As Double)
                _IVA = value
            End Set
        End Property


        Public Property Saldo() As Double
            Get
                Return _Saldo
            End Get
            Set(ByVal value As Double)
                _Saldo = value
            End Set
        End Property

        Public Property ImporteRetencionIVA() As Double
            Get
                Return _ImporteRetencionIVA
            End Get
            Set(ByVal value As Double)
                _ImporteRetencionIVA = value
            End Set
        End Property

        Public Property ImporteRetencionIngresosBrutos() As Double
            Get
                Return _ImporteRetencionIngresosBrutos
            End Get
            Set(ByVal value As Double)
                _ImporteRetencionIngresosBrutos = value
            End Set
        End Property
        Public Property ImportePagadoSinImpuestos() As Double
            Get
                Return _ImportePagadoSinImpuestos
            End Get
            Set(ByVal value As Double)
                _ImportePagadoSinImpuestos = value
            End Set
        End Property

        Public IdTipoRetencionGanancia As Integer = 0
        Public IdIBCondicion As Integer = 0
        Public Numero
        Public BaseCalculoIIBB As String

        Public Imp 'Qué diferencia hay entre este dichoso "Imp." y "Importe" (en la grilla de imputaciones de la OP de Pronto)

        Public Bien_o_Servicio As String = "B"
        Public RetIVAenOP As String 'este es un numero de op
        Public PorcentajeIVAParaMonotributistas As Double

        Private _TipoComprobanteImputado As String
        Private _NumeroComprobanteImputado As Integer
        Private _ComprobanteImputadoNumeroConDescripcionCompleta As String = ""


        Private _TotalComprobanteImputado As Double = 0
        Private _FechaComprobanteImputado As DateTime = DateTime.MinValue



        Public Property Importe() As Double
            Get
                Return _Importe
            End Get
            Set(ByVal value As Double)
                _Importe = value
            End Set
        End Property

        Public Property SaldoParteEnPesosAnterior() As Double
            Get
                Return _SaldoParteEnPesosAnterior
            End Get
            Set(ByVal value As Double)
                _SaldoParteEnPesosAnterior = value
            End Set
        End Property
        Public Property TipoComprobanteImputado() As String
            Get
                Return _TipoComprobanteImputado
            End Get
            Set(ByVal value As String)
                _TipoComprobanteImputado = value
            End Set
        End Property
        Public Property NumeroComprobanteImputado() As Integer
            Get
                Return _NumeroComprobanteImputado
            End Get
            Set(ByVal value As Integer)
                _NumeroComprobanteImputado = value
            End Set
        End Property





        Public Property FechaComprobanteImputado() As Date
            Get
                Return _FechaComprobanteImputado
            End Get
            Set(ByVal value As Date)
                _FechaComprobanteImputado = value
            End Set
        End Property


        Public Property TotalComprobanteImputado() As Double
            Get
                Return _TotalComprobanteImputado
            End Get
            Set(ByVal value As Double)
                _TotalComprobanteImputado = value
            End Set
        End Property






        Public Property ComprobanteImputadoNumeroConDescripcionCompleta() As String
            Get
                '.ComprobanteImputadoNumeroConDescripcionCompleta = .TipoComprobanteImputado & " " &  & "-" & Format(.NumeroComprobanteImputado, "00000000")
                If _ComprobanteImputadoNumeroConDescripcionCompleta = "" Then
                    Return TipoComprobanteImputado & " " & NumeroComprobanteImputado
                Else
                    Return _ComprobanteImputadoNumeroConDescripcionCompleta
                End If


            End Get

            Set(ByVal value As String)
                _ComprobanteImputadoNumeroConDescripcionCompleta = value
            End Set
        End Property





        Public _Precio As Double = 0   'Ehhhh? No puedo hacer bind desde la grilla a esto porque no tiene property???? http://www.mikepope.com/blog/AddComment.aspx?blogid=1419
        Public _PrecioUnitarioTotal As Double = 0
        Public _PorcentajeBonificacion As Double = 0
        Public _ImporteBonificacion As Double = 0
        Public _PorcentajeIVA As Double = 0
        Public _ImporteIVA As Double = 0
        Public _ImporteTotalItem As Double = 0







        '///////////////////////////////////////
        'Ver qué conviene anexar al codigo generado
        '///////////////////////////////////////

        Public Property Precio() As Double
            Get
                Return _Precio
            End Get
            Set(ByVal value As Double)
                _Precio = value
            End Set
        End Property

        Public Property PrecioUnitarioTotal() As Double
            Get
                Return _PrecioUnitarioTotal
            End Get
            Set(ByVal value As Double)
                _PrecioUnitarioTotal = value
            End Set
        End Property


        Public Property ImporteTotalItem() As Double
            Get
                Return _ImporteTotalItem
            End Get
            Set(ByVal value As Double)
                _ImporteTotalItem = value
            End Set
        End Property

        '///////////////////////////////////////















        Private _Eliminado As Boolean = False
        Private _Nuevo As Boolean = False

        <DataObjectFieldAttribute(True, True, False)> _
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