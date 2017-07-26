Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class NotaDeCreditoImpItem
        Private _Id As Integer = -1
        Private _IdNotaCredito As Integer = 0
        Private _IdImputacion As Integer = 0
        Private _Importe As Double = 0

        Private _TipoComprobanteImputado As String
        Private _NumeroComprobanteImputado As Integer
        Private _ComprobanteImputadoNumeroConDescripcionCompleta As String = ""


        Private _TotalComprobanteImputado As Double = 0
        Private _FechaComprobanteImputado As DateTime = DateTime.MinValue

        Private _SaldoParteEnPesosAnterior As Double = 0

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

        Public Property IdNotaCredito() As Integer
            Get
                Return _IdNotaCredito
            End Get
            Set(ByVal value As Integer)
                _IdNotaCredito = value
            End Set
        End Property


        Public Property IdImputacion() As Integer
            Get
                Return _IdImputacion
            End Get
            Set(ByVal value As Integer)
                _IdImputacion = value
            End Set
        End Property
 







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