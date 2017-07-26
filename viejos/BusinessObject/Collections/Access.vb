Imports System
Imports System.ComponentModel
Imports System.Diagnostics
Namespace Pronto.ERP.BO

    <Serializable()> Public Class Access
        Private _IdEmpleadoAcceso As Integer = -1
        Private _IdEmpleado As Integer = -1
        Private _Nodo As String = String.Empty
        Private _Acceso As Boolean = False
        Private _Nivel As Integer = -1
        Private _FechaDesdeParaModificacion As DateTime = DateTime.MinValue
        Private _FechaInicialHabilitacion As DateTime = DateTime.MinValue
        Private _FechaFinalHabilitacion As DateTime = DateTime.MinValue
        Private _CantidadAccesos As Integer = -1

        <DataObjectFieldAttribute(True, True, False)> _
        Public Property Id() As Integer
            Get
                Return _IdEmpleadoAcceso
            End Get
            Set(ByVal value As Integer)
                _IdEmpleadoAcceso = value
            End Set
        End Property

        Public Property Numero() As Integer
            Get
                Return _IdEmpleado
            End Get
            Set(ByVal value As Integer)
                _IdEmpleado = value
            End Set
        End Property

        Public Property Nodo() As String
            Get
                Return _Nodo
            End Get
            Set(ByVal value As String)
                _Nodo = value
            End Set
        End Property
    End Class
End Namespace