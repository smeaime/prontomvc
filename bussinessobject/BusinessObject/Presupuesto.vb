Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class Presupuesto


        '///////////////////////////////////////
        '///////////////////////////////////////
        '///////////////////////////////////////
        'Ver qué conviene anexar al codigo generado
        '///////////////////////////////////////

        Private _Proveedor As String = String.Empty    ' lo agregué a mano


        Public Property Proveedor() As String
            Get
                Return _Proveedor
            End Get
            Set(ByVal value As String)
                _Proveedor = value
            End Set
        End Property


        Public SubTotal, TotalBonifEnItems, TotalBonifSobreElTotal, TotalSubGravado, Total As Double 'estos no los tiene el objeto?

        '///////////////////////////////////////
        '///////////////////////////////////////
        '///////////////////////////////////////










        Private _Id As Integer = -1
        Private _Numero As Integer = 0
        Private _IdProveedor As Integer = 0
        Private _FechaIngreso As DateTime = DateTime.MinValue
        Private _Observaciones As String = String.Empty
        Private _Bonificacion As Double = 0
        Private _Plazo As String = String.Empty
        Private _validez As String = String.Empty
        Private _IdCondicionCompra As Integer = 0
        Private _Garantia As String = String.Empty
        Private _LugarEntrega As String = String.Empty
        Private _IdComprador As Integer = 0
        Private _Referencia As String = String.Empty
        Private _PorcentajeIva1 As Double = 0
        Private _PorcentajeIva2 As Double = 0
        Private _Detalle As String = String.Empty
        Private _Contacto As String = String.Empty
        Private _ImporteBonificacion As Double = 0
        Private _ImporteIva1 As Double = 0
        Private _ImporteTotal As Double = 0
        Private _SubNumero As Integer = 0
        Private _Aprobo As Integer = 0
        Private _IdMoneda As Integer = 0
        Private _FechaAprobacion As DateTime = DateTime.MinValue
        Private _DetalleCondicionCompra As String = String.Empty
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
        Private _IdPlazoEntrega As Integer = 0
        Private _CotizacionMoneda As Double = 0
        Private _CircuitoFirmasCompleto As String = String.Empty
        Private _Detalles As PresupuestoItemList = New PresupuestoItemList

        'Agregado para web
        Private _FechaCierreCompulsa As DateTime = DateTime.MinValue
        Private _ConfirmadoPorWeb As String = String.Empty
        Private _FechaRespuestaWeb As DateTime = DateTime.MinValue
        Private _NombreUsuarioWeb As String = String.Empty




        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property
        Public Property Numero() As Integer
            Get
                Return _Numero
            End Get
            Set(ByVal value As Integer)
                _Numero = value
            End Set
        End Property
        Public Property IdProveedor() As Integer
            Get
                Return _IdProveedor
            End Get
            Set(ByVal value As Integer)
                _IdProveedor = value
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
        Public Property Observaciones() As String
            Get
                Return _Observaciones
            End Get
            Set(ByVal value As String)
                _Observaciones = value
            End Set
        End Property
        Public Property Bonificacion() As Double
            Get
                Return _Bonificacion
            End Get
            Set(ByVal value As Double)
                _Bonificacion = value
            End Set
        End Property
        Public Property Plazo() As String
            Get
                Return _Plazo
            End Get
            Set(ByVal value As String)
                _Plazo = value
            End Set
        End Property
        Public Property Validez() As String
            Get
                Return _validez
            End Get
            Set(ByVal value As String)
                _validez = value
            End Set
        End Property
        Public Property IdCondicionCompra() As Integer
            Get
                Return _IdCondicionCompra
            End Get
            Set(ByVal value As Integer)
                _IdCondicionCompra = value
            End Set
        End Property
        Public Property Garantia() As String
            Get
                Return _Garantia
            End Get
            Set(ByVal value As String)
                _Garantia = value
            End Set
        End Property
        Public Property LugarEntrega() As String
            Get
                Return _LugarEntrega
            End Get
            Set(ByVal value As String)
                _LugarEntrega = value
            End Set
        End Property
        Public Property IdComprador() As Integer
            Get
                Return _IdComprador
            End Get
            Set(ByVal value As Integer)
                _IdComprador = value
            End Set
        End Property
        Public Property Referencia() As String
            Get
                Return _Referencia
            End Get
            Set(ByVal value As String)
                _Referencia = value
            End Set
        End Property
        Public Property PorcentajeIva1() As Double
            Get
                Return _PorcentajeIva1
            End Get
            Set(ByVal value As Double)
                _PorcentajeIva1 = value
            End Set
        End Property
        Public Property PorcentajeIva2() As Double
            Get
                Return _PorcentajeIva2
            End Get
            Set(ByVal value As Double)
                _PorcentajeIva2 = value
            End Set
        End Property
        Public Property Detalle() As String
            Get
                Return _Detalle
            End Get
            Set(ByVal value As String)
                _Detalle = value
            End Set
        End Property
        Public Property Contacto() As String
            Get
                Return _Contacto
            End Get
            Set(ByVal value As String)
                _Contacto = value
            End Set
        End Property
        Public Property ImporteBonificacion() As Double

            Get
                Return _ImporteBonificacion
            End Get
            Set(ByVal value As Double)
                _ImporteBonificacion = value
            End Set
        End Property
        Public Property ImporteIva1() As Double

            Get
                Return _ImporteIva1
            End Get
            Set(ByVal value As Double)
                _ImporteIva1 = value
            End Set
        End Property
        Public Property ImporteTotal() As Double

            Get
                Return _ImporteTotal
            End Get
            Set(ByVal value As Double)
                _ImporteTotal = value
            End Set
        End Property
        Public Property SubNumero() As Integer
            Get
                Return _SubNumero
            End Get
            Set(ByVal value As Integer)
                _SubNumero = value
            End Set
        End Property
        Public Property Aprobo() As Integer
            Get
                Return _Aprobo
            End Get
            Set(ByVal value As Integer)
                _Aprobo = value
            End Set
        End Property
        Public Property IdMoneda() As Integer
            Get
                Return _IdMoneda
            End Get
            Set(ByVal value As Integer)
                _IdMoneda = value
            End Set
        End Property
        Public Property FechaAprobacion() As DateTime
            Get
                Return _FechaAprobacion
            End Get
            Set(ByVal value As DateTime)
                _FechaAprobacion = value
            End Set
        End Property
        Public Property DetalleCondicionCompra() As String
            Get
                Return _DetalleCondicionCompra
            End Get
            Set(ByVal value As String)
                _DetalleCondicionCompra = value
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
        Public Property IdPlazoEntrega() As Integer
            Get
                Return _IdPlazoEntrega
            End Get
            Set(ByVal value As Integer)
                _IdPlazoEntrega = value
            End Set
        End Property
        Public Property CotizacionMoneda() As Double
            Get
                Return _CotizacionMoneda
            End Get
            Set(ByVal value As Double)
                _CotizacionMoneda = value
            End Set
        End Property
        Public Property CircuitoFirmasCompleto() As String
            Get
                Return _CircuitoFirmasCompleto
            End Get
            Set(ByVal value As String)
                _CircuitoFirmasCompleto = value
            End Set
        End Property

        Public Property FechaCierreCompulsa() As DateTime
            Get
                Return _FechaCierreCompulsa
            End Get
            Set(ByVal value As DateTime)
                _FechaCierreCompulsa = value
            End Set
        End Property

        Public Property ConfirmadoPorWeb() As String
            Get
                Return _ConfirmadoPorWeb
            End Get
            Set(ByVal value As String)
                _ConfirmadoPorWeb = value
            End Set
        End Property

        Public Property NombreUsuarioWeb() As String
            Get
                Return _NombreUsuarioWeb
            End Get
            Set(ByVal value As String)
                _NombreUsuarioWeb = value
            End Set
        End Property

        Public Property FechaRespuestaWeb() As DateTime
            Get
                Return _FechaRespuestaWeb
            End Get
            Set(ByVal value As DateTime)
                _FechaRespuestaWeb = value
            End Set
        End Property

        Public Property Detalles() As PresupuestoItemList
            Get
                Return _Detalles
            End Get
            Set(ByVal value As PresupuestoItemList)
                _Detalles = value
            End Set
        End Property

    End Class

End Namespace