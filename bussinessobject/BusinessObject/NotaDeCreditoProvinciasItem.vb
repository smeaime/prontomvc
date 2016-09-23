Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class NotaDeCreditoProvinciasItem
        Private _Id As Integer = -1

        Public IdNotaCredito As Integer = 0
        Public Importe As Double = 0
        Public IdDiferenciaCambio As Integer = 0
        Public IvaNoDiscriminado As Double = 0
        Public IdCuentaBancaria As Integer = 0
        Public IdCaja As Integer = 0


        Private _IdConcepto As Integer = 0
        Private _Concepto As String = String.Empty
        Private _Gravado As String = String.Empty


        Private _Cantidad As Double = 0
        Private _Precio As Double = 0
        Private _PorcentajeBonificacion As Double = 0
        Private _ImporteBonificacion As Double = 0
        Private _PorcentajeIVA As Double = 0
        Private _ImporteIVA As Double = 0
        Private _ImporteTotalItem As Double = 0




        Public Property Cantidad() As Double
            Get
                Return _Cantidad
            End Get
            Set(ByVal value As Double)
                _Cantidad = value
            End Set
        End Property

        Public Property Precio() As Double
            Get
                Return _Precio
            End Get
            Set(ByVal value As Double)
                _Precio = value
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

        Public Property IdConcepto() As Integer
            Get
                Return _IdConcepto
            End Get
            Set(ByVal value As Integer)
                _IdConcepto = value
            End Set
        End Property


        Public Property Concepto() As String
            Get
                Return _Concepto
            End Get
            Set(ByVal value As String)
                _Concepto = value
            End Set
        End Property

        Public Property Gravado() As String
            Get
                Return _Gravado
            End Get
            Set(ByVal value As String)
                _Gravado = value
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