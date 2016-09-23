Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class FacturaRemitosItem
        Public Id As Integer = -1
        Public IdFactura As Integer = 0
        Public IdDetalleFactura As Integer = 0
        Public IdDetalleRemito As Integer = 0
        Public EnviarEmail As String = String.Empty


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