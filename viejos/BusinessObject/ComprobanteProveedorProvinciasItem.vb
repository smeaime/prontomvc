Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class ComprobanteProveedorProvinciasItem
        Public Id As Integer = -1
        Public IdComprobanteProveedor As Integer = 0
        Public IdProvinciaDestino As Integer = 0
        Public Porcentaje As Double
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