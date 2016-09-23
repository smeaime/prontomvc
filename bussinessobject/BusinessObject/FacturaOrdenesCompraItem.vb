Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class FacturaOrdenesCompraItem
        Public Id As Integer = -1
        Public IdDetalleFactura As Integer = 0
        Public IdFactura As Integer = 0
        Public IdDetalleOrdenCompra As Integer = 0
        Public EnviarEmail As String = String.Empty


        Public PorcentajeBonificacion As Double = 0
        Public PorcentajeCertificacion As Double = 0
        Public ImporteBonificacion As Double = 0
        Public PorcentajeIVA As Double = 0
        Public ImporteIVA As Double = 0
        Public ImporteTotalItem As Double = 0

        Private _Eliminado As Boolean = False
        Private _Nuevo As Boolean = False






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