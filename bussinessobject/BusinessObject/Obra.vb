Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class Obra
        Private _Id As Integer = -1
        Private _Codigo As String = String.Empty
        Private _IdCliente As Integer = 0
        Private _Cliente As String = String.Empty
        Private _FechaInicio As DateTime = DateTime.MinValue
        Private _FechaFinalizacion As DateTime = DateTime.MinValue
        Private _Observaciones As String = String.Empty
        Private _FechaEntrega As DateTime = DateTime.MinValue
        Private _Descripcion As String = String.Empty
        Private _IdJefe As Integer = 0
        Private _JefeObra As String = String.Empty
        Private _TipoObra As Integer = 0
        Private _HorasEstimadas As Integer = 0
        Private _Consorcial As String = String.Empty
        Private _EnviarEmail As Integer = 0
        Private _Activa As String = String.Empty
        Private _ParaInformes As String = String.Empty
        Private _IdUnidadOperativa As Integer = 0
        Private _UnidadOperativa As String = String.Empty
        Private _Jerarquia As String = String.Empty
        Private _ArchivoAdjunto1 As String = String.Empty
        Private _ArchivoAdjunto2 As String = String.Empty
        Private _ArchivoAdjunto3 As String = String.Empty
        Private _ArchivoAdjunto4 As String = String.Empty
        Private _ArchivoAdjunto5 As String = String.Empty
        Private _ArchivoAdjunto6 As String = String.Empty
        Private _ArchivoAdjunto7 As String = String.Empty
        Private _ArchivoAdjunto8 As String = String.Empty
        Private _ArchivoAdjunto9 As String = String.Empty
        Private _ArchivoAdjunto10 As String = String.Empty
        Private _GeneraReservaStock As String = String.Empty
        Private _IdGrupoObra As Integer = 0
        Private _GrupoObra As String = String.Empty
        Private _IdArticuloAsociado As Integer = 0
        Private _ArticuloAsociado As String = String.Empty
        Private _Observaciones2 As String = String.Empty
        Private _Observaciones3 As String = String.Empty
        Private _IdSubjefe As Integer = 0
        Private _SubjefeObra As String = String.Empty
        Private _Direccion As String = String.Empty
        Private _IdLocalidad As Integer = 0
        Private _Localidad As String = String.Empty
        Private _IdProvincia As Integer = 0
        Private _Provincia As String = String.Empty
        Private _IdPais As Integer = 0
        Private _Pais As String = String.Empty
        Private _CodigoPostal As String = String.Empty
        Private _Telefono As String = String.Empty
        Private _LugarPago As String = String.Empty
        Private _Responsable As String = String.Empty
        Private _Horario As String = String.Empty
        Private _Turnos As String = String.Empty
        Private _Operarios As Integer = 0
        Private _Zona As Integer = 0
        Private _Jurisdiccion As Integer = 0
        Private _IdCuentaContableFF As Integer = 0
        Private _CodigoCuentaFF As String = String.Empty
        Private _ValorObra As Double = 0
        Private _IdMonedaValorObra As Integer = 0
        Private _MonedaValorObra As String = String.Empty
        Private _IdJefeRegional As Integer = 0
        Private _JefeRegionalObra As String = String.Empty

        <DataObjectFieldAttribute(True, True, False)> _
        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property

        Public Property Codigo() As String
            Get
                Return _Codigo
            End Get
            Set(ByVal value As String)
                _Codigo = value
            End Set
        End Property

        Public Property IdCliente() As Integer
            Get
                Return _IdCliente
            End Get
            Set(ByVal value As Integer)
                _IdCliente = value
            End Set
        End Property

        Public Property Cliente() As String
            Get
                Return _Cliente
            End Get
            Set(ByVal value As String)
                _Cliente = value
            End Set
        End Property

        Public Property FechaInicio() As DateTime
            Get
                Return _FechaInicio
            End Get
            Set(ByVal value As DateTime)
                _FechaInicio = value
            End Set
        End Property

        Public Property FechaFinalizacion() As DateTime
            Get
                Return _FechaFinalizacion
            End Get
            Set(ByVal value As DateTime)
                _FechaFinalizacion = value
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

        Public Property FechaEntrega() As DateTime
            Get
                Return _FechaEntrega
            End Get
            Set(ByVal value As DateTime)
                _FechaEntrega = value
            End Set
        End Property

        Public Property Descripcion() As String
            Get
                Return _Descripcion
            End Get
            Set(ByVal value As String)
                _Descripcion = value
            End Set
        End Property

        Public Property IdJefe() As Integer
            Get
                Return _IdJefe
            End Get
            Set(ByVal value As Integer)
                _IdJefe = value
            End Set
        End Property

        Public Property JefeObra() As String
            Get
                Return _JefeObra
            End Get
            Set(ByVal value As String)
                _JefeObra = value
            End Set
        End Property

        Public Property TipoObra() As Integer
            Get
                Return _TipoObra
            End Get
            Set(ByVal value As Integer)
                _TipoObra = value
            End Set
        End Property

        Public Property HorasEstimadas() As Integer
            Get
                Return _HorasEstimadas
            End Get
            Set(ByVal value As Integer)
                _HorasEstimadas = value
            End Set
        End Property

        Public Property Consorcial() As String
            Get
                Return _Consorcial
            End Get
            Set(ByVal value As String)
                _Consorcial = value
            End Set
        End Property

        Public Property EnviarEmail() As Integer
            Get
                Return _EnviarEmail
            End Get
            Set(ByVal value As Integer)
                _EnviarEmail = value
            End Set
        End Property

        Public Property Activa() As String
            Get
                Return _Activa
            End Get
            Set(ByVal value As String)
                _Activa = value
            End Set
        End Property

        Public Property ParaInformes() As String
            Get
                Return _ParaInformes
            End Get
            Set(ByVal value As String)
                _ParaInformes = value
            End Set
        End Property

        Public Property IdUnidadOperativa() As Integer
            Get
                Return _IdUnidadOperativa
            End Get
            Set(ByVal value As Integer)
                _IdUnidadOperativa = value
            End Set
        End Property

        Public Property UnidadOperativa() As String
            Get
                Return _UnidadOperativa
            End Get
            Set(ByVal value As String)
                _UnidadOperativa = value
            End Set
        End Property

        Public Property Jerarquia() As String
            Get
                Return _Jerarquia
            End Get
            Set(ByVal value As String)
                _Jerarquia = value
            End Set
        End Property

        Public Property ArchivoAdjunto1() As String
            Get
                Return _ArchivoAdjunto1
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto1 = value
            End Set
        End Property

        Public Property ArchivoAdjunto2() As String
            Get
                Return _ArchivoAdjunto2
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto2 = value
            End Set
        End Property

        Public Property ArchivoAdjunto3() As String
            Get
                Return _ArchivoAdjunto3
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto3 = value
            End Set
        End Property

        Public Property ArchivoAdjunto4() As String
            Get
                Return _ArchivoAdjunto4
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto4 = value
            End Set
        End Property

        Public Property ArchivoAdjunto5() As String
            Get
                Return _ArchivoAdjunto5
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto5 = value
            End Set
        End Property

        Public Property ArchivoAdjunto6() As String
            Get
                Return _ArchivoAdjunto6
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto6 = value
            End Set
        End Property

        Public Property ArchivoAdjunto7() As String
            Get
                Return _ArchivoAdjunto7
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto7 = value
            End Set
        End Property

        Public Property ArchivoAdjunto8() As String
            Get
                Return _ArchivoAdjunto8
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto8 = value
            End Set
        End Property

        Public Property ArchivoAdjunto9() As String
            Get
                Return _ArchivoAdjunto9
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto9 = value
            End Set
        End Property

        Public Property ArchivoAdjunto10() As String
            Get
                Return _ArchivoAdjunto10
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto10 = value
            End Set
        End Property

        Public Property GeneraReservaStock() As String
            Get
                Return _GeneraReservaStock
            End Get
            Set(ByVal value As String)
                _GeneraReservaStock = value
            End Set
        End Property

        Public Property IdGrupoObra() As Integer
            Get
                Return _IdGrupoObra
            End Get
            Set(ByVal value As Integer)
                _IdGrupoObra = value
            End Set
        End Property

        Public Property GrupoObra() As String
            Get
                Return _GrupoObra
            End Get
            Set(ByVal value As String)
                _GrupoObra = value
            End Set
        End Property

        Public Property IdArticuloAsociado() As Integer
            Get
                Return _IdArticuloAsociado
            End Get
            Set(ByVal value As Integer)
                _IdArticuloAsociado = value
            End Set
        End Property

        Public Property ArticuloAsociado() As String
            Get
                Return _ArticuloAsociado
            End Get
            Set(ByVal value As String)
                _ArticuloAsociado = value
            End Set
        End Property

        Public Property Observaciones2() As String
            Get
                Return _Observaciones2
            End Get
            Set(ByVal value As String)
                _Observaciones2 = value
            End Set
        End Property

        Public Property Observaciones3() As String
            Get
                Return _Observaciones3
            End Get
            Set(ByVal value As String)
                _Observaciones3 = value
            End Set
        End Property

        Public Property IdSubjefe() As Integer
            Get
                Return _IdSubjefe
            End Get
            Set(ByVal value As Integer)
                _IdSubjefe = value
            End Set
        End Property

        Public Property SubjefeObra() As String
            Get
                Return _SubjefeObra
            End Get
            Set(ByVal value As String)
                _SubjefeObra = value
            End Set
        End Property

        Public Property Direccion() As String
            Get
                Return _Direccion
            End Get
            Set(ByVal value As String)
                _Direccion = value
            End Set
        End Property

        Public Property IdLocalidad() As Integer
            Get
                Return _IdLocalidad
            End Get
            Set(ByVal value As Integer)
                _IdLocalidad = value
            End Set
        End Property

        Public Property Localidad() As String
            Get
                Return _Localidad
            End Get
            Set(ByVal value As String)
                _Localidad = value
            End Set
        End Property

        Public Property IdProvincia() As Integer
            Get
                Return _IdProvincia
            End Get
            Set(ByVal value As Integer)
                _IdProvincia = value
            End Set
        End Property

        Public Property Provincia() As String
            Get
                Return _Provincia
            End Get
            Set(ByVal value As String)
                _Provincia = value
            End Set
        End Property

        Public Property IdPais() As Integer
            Get
                Return _IdPais
            End Get
            Set(ByVal value As Integer)
                _IdPais = value
            End Set
        End Property

        Public Property Pais() As String
            Get
                Return _Pais
            End Get
            Set(ByVal value As String)
                _Pais = value
            End Set
        End Property

        Public Property CodigoPostal() As String
            Get
                Return _CodigoPostal
            End Get
            Set(ByVal value As String)
                _CodigoPostal = value
            End Set
        End Property

        Public Property Telefono() As String
            Get
                Return _Telefono
            End Get
            Set(ByVal value As String)
                _Telefono = value
            End Set
        End Property

        Public Property LugarPago() As String
            Get
                Return _LugarPago
            End Get
            Set(ByVal value As String)
                _LugarPago = value
            End Set
        End Property

        Public Property Responsable() As String
            Get
                Return _Responsable
            End Get
            Set(ByVal value As String)
                _Responsable = value
            End Set
        End Property

        Public Property Horario() As String
            Get
                Return _Horario
            End Get
            Set(ByVal value As String)
                _Horario = value
            End Set
        End Property

        Public Property Turnos() As String
            Get
                Return _Turnos
            End Get
            Set(ByVal value As String)
                _Turnos = value
            End Set
        End Property

        Public Property Operarios() As Integer
            Get
                Return _Operarios
            End Get
            Set(ByVal value As Integer)
                _Operarios = value
            End Set
        End Property

        Public Property Zona() As Integer
            Get
                Return _Zona
            End Get
            Set(ByVal value As Integer)
                _Zona = value
            End Set
        End Property

        Public Property Jurisdiccion() As Integer
            Get
                Return _Jurisdiccion
            End Get
            Set(ByVal value As Integer)
                _Jurisdiccion = value
            End Set
        End Property

        Public Property IdCuentaContableFF() As Integer
            Get
                Return _IdCuentaContableFF
            End Get
            Set(ByVal value As Integer)
                _IdCuentaContableFF = value
            End Set
        End Property

        Public Property CodigoCuentaFF() As String
            Get
                Return _CodigoCuentaFF
            End Get
            Set(ByVal value As String)
                _CodigoCuentaFF = value
            End Set
        End Property

        Public Property ValorObra() As Double
            Get
                Return _ValorObra
            End Get
            Set(ByVal value As Double)
                _ValorObra = value
            End Set
        End Property

        Public Property IdMonedaValorObra() As Integer
            Get
                Return _IdMonedaValorObra
            End Get
            Set(ByVal value As Integer)
                _IdMonedaValorObra = value
            End Set
        End Property

        Public Property MonedaValorObra() As String
            Get
                Return _MonedaValorObra
            End Get
            Set(ByVal value As String)
                _MonedaValorObra = value
            End Set
        End Property

        Public Property IdJefeRegional() As Integer
            Get
                Return _IdJefeRegional
            End Get
            Set(ByVal value As Integer)
                _IdJefeRegional = value
            End Set
        End Property

        Public Property JefeRegionalObra() As String
            Get
                Return _JefeRegionalObra
            End Get
            Set(ByVal value As String)
                _JefeRegionalObra = value
            End Set
        End Property

    End Class

End Namespace