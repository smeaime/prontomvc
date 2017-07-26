Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class Asiento

        Private _Id As Integer = -1
        Private _NumeroAsiento As Integer
        Private _FechaAsiento As DateTime = DateTime.MinValue
        Private _Ejercicio As Integer
        Private _IdCuentaSubdiario As Integer
        Private _Concepto As String
        Private _Tipo As String
        Private _IdIngreso As Integer
        Private _FechaIngreso As DateTime = DateTime.MinValue
        Private _IdModifico As Integer
        Private _FechaUltimaModificacion As DateTime = DateTime.MinValue
        Private _AsientoApertura As String = "NO"
        Private _BaseConsolidadaHija As String
        Private _FechaGeneracionConsolidado As DateTime = DateTime.MinValue
        Private _ArchivoImportacion As String
        Private _AsignarAPresupuestoObra As String = "NO"


        Public TotalHaber, TotalDebe As Decimal
        '
        'This is the NumeroAsiento property.
        '
        Public Property NumeroAsiento() As Integer
            Get
                Return _NumeroAsiento
            End Get
            Set(ByVal Value As Integer)
                _NumeroAsiento = Value
            End Set
        End Property

        '
        'This is the FechaAsiento property.
        '
        Public Property FechaAsiento() As DateTime
            Get
                Return _FechaAsiento
            End Get
            Set(ByVal Value As DateTime)
                _FechaAsiento = Value
            End Set
        End Property

        '
        'This is the Ejercicio property.
        '
        Public Property Ejercicio() As Integer
            Get
                Return _Ejercicio
            End Get
            Set(ByVal Value As Integer)
                _Ejercicio = Value
            End Set
        End Property

        '
        'This is the IdCuentaSubdiario property.
        '
        Public Property IdCuentaSubdiario() As Integer
            Get
                Return _IdCuentaSubdiario
            End Get
            Set(ByVal Value As Integer)
                _IdCuentaSubdiario = Value
            End Set
        End Property

        '
        'This is the Concepto property.
        '
        Public Property Concepto() As String
            Get
                Return _Concepto
            End Get
            Set(ByVal Value As String)
                _Concepto = Value
            End Set
        End Property

        '
        'This is the Tipo property.
        '
        Public Property Tipo() As String
            Get
                Return _Tipo
            End Get
            Set(ByVal Value As String)
                _Tipo = Value
            End Set
        End Property

        '
        'This is the IdIngreso property.
        '
        Public Property IdIngreso() As Integer
            Get
                Return _IdIngreso
            End Get
            Set(ByVal Value As Integer)
                _IdIngreso = Value
            End Set
        End Property

        '
        'This is the FechaIngreso property.
        '
        Public Property FechaIngreso() As DateTime
            Get
                Return _FechaIngreso
            End Get
            Set(ByVal Value As DateTime)
                _FechaIngreso = Value
            End Set
        End Property

        '
        'This is the IdModifico property.
        '
        Public Property IdModifico() As Integer
            Get
                Return _IdModifico
            End Get
            Set(ByVal Value As Integer)
                _IdModifico = Value
            End Set
        End Property

        '
        'This is the FechaUltimaModificacion property.
        '
        Public Property FechaUltimaModificacion() As DateTime
            Get
                Return _FechaUltimaModificacion
            End Get
            Set(ByVal Value As DateTime)
                _FechaUltimaModificacion = Value
            End Set
        End Property

        '
        'This is the AsientoApertura property.
        '
        Public Property AsientoApertura() As String
            Get
                Return _AsientoApertura
            End Get
            Set(ByVal Value As String)
                _AsientoApertura = Value
            End Set
        End Property

        '
        'This is the BaseConsolidadaHija property.
        '
        Public Property BaseConsolidadaHija() As String
            Get
                Return _BaseConsolidadaHija
            End Get
            Set(ByVal Value As String)
                _BaseConsolidadaHija = Value
            End Set
        End Property

        '
        'This is the FechaGeneracionConsolidado property.
        '
        Public Property FechaGeneracionConsolidado() As DateTime
            Get
                Return _FechaGeneracionConsolidado
            End Get
            Set(ByVal Value As DateTime)
                _FechaGeneracionConsolidado = Value
            End Set
        End Property

        '
        'This is the ArchivoImportacion property.
        '
        Public Property ArchivoImportacion() As String
            Get
                Return _ArchivoImportacion
            End Get
            Set(ByVal Value As String)
                _ArchivoImportacion = Value
            End Set
        End Property

        '
        'This is the AsignarAPresupuestoObra property.
        '
        Public Property AsignarAPresupuestoObra() As String
            Get
                Return _AsignarAPresupuestoObra
            End Get
            Set(ByVal Value As String)
                _AsignarAPresupuestoObra = Value
            End Set
        End Property




        Private _Detalles As AsientoItemList = New AsientoItemList
        Public DetallesAnticipos As AsientoAnticiposItemList = New AsientoAnticiposItemList





        <DataObjectFieldAttribute(True, True, False)> _
        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property

        'Public Property Numero() As Integer
        '    Get
        '        Return __COMPRONTO_Asiento.Registro.Fields("NumeroAsiento").Value
        '    End Get
        '    Set(ByVal value As Integer)
        '        __COMPRONTO_Asiento.Registro.Fields("NumeroAsiento").Value = value
        '    End Set
        'End Property




        Public Property Detalles() As AsientoItemList
            Get
                Return _Detalles
            End Get
            Set(ByVal value As AsientoItemList)
                _Detalles = value
            End Set
        End Property


        Public Function BuscarRenglonPorIdDetalle(ByVal id As Integer) As AsientoItem
            If _Detalles.Count = 0 Then
                Throw New ApplicationException("No hay detalle. Verificar que el objeto fue cargado con el parametro TraerDetalle en True")
            Else
                Return _Detalles.Find(Function(obj) obj.Id = id)
            End If
        End Function

    End Class

End Namespace