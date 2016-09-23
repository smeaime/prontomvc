Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class ComprobanteProveedorItem
        Private _Id As Integer = -1
        Private _IdComprobanteProveedor As Integer = -1
        Private _IdArticulo As Integer = 0
        Private _CodigoArticulo As String = String.Empty
        Private _IdCuenta As Integer = 0
        Private _CodigoCuenta As String = String.Empty
        Private _PorcentajeIvaAplicado As Double = 0
        Private _Importe As Double = 0
        Private _IdCuentaGasto As Integer = 0
        Private _CuentaGastoDescripcion As String = String.Empty 'desnormalizado
        Private _IdCuentaIvaCompras1 As Integer = 0
        Private _IVAComprasPorcentaje1 As Double = 0
        Private _ImporteIVA1 As Double = 0
        Private _AplicarIVA1 As String = String.Empty
        Private _IdCuentaIvaCompras2 As Integer = 0
        Private _IVAComprasPorcentaje2 As Double = 0
        Private _ImporteIVA2 As Double = 0
        Private _AplicarIVA2 As String = String.Empty
        Private _IdCuentaIvaCompras3 As Integer = 0
        Private _IVAComprasPorcentaje3 As Double = 0
        Private _ImporteIVA3 As Double = 0
        Private _AplicarIVA3 As String = String.Empty
        Private _IdCuentaIvaCompras4 As Integer = 0
        Private _IVAComprasPorcentaje4 As Double = 0
        Private _ImporteIVA4 As Double = 0
        Private _AplicarIVA4 As String = String.Empty
        Private _IdCuentaIvaCompras5 As Integer = 0
        Private _IVAComprasPorcentaje5 As Double = 0
        Private _ImporteIVA5 As Double = 0
        Private _AplicarIVA5 As String = String.Empty
        Private _IdObra As Integer = 0
        Private _Item As Integer = 0
        Private _IdCuentaIvaCompras6 As Integer = 0
        Private _IVAComprasPorcentaje6 As Double = 0
        Private _ImporteIVA6 As Double = 0
        Private _AplicarIVA6 As String = String.Empty
        Private _IdCuentaIvaCompras7 As Integer = 0
        Private _IVAComprasPorcentaje7 As Double = 0
        Private _ImporteIVA7 As Double = 0
        Private _AplicarIVA7 As String = String.Empty
        Private _IdCuentaIvaCompras8 As Integer = 0
        Private _IVAComprasPorcentaje8 As Double = 0
        Private _ImporteIVA8 As Double = 0
        Private _AplicarIVA8 As String = String.Empty
        Private _IdCuentaIvaCompras9 As Integer = 0
        Private _IVAComprasPorcentaje9 As Double = 0
        Private _ImporteIVA9 As Double = 0
        Private _AplicarIVA9 As String = String.Empty
        Private _IdCuentaIvaCompras10 As Integer = 0
        Private _IVAComprasPorcentaje10 As Double = 0
        Private _ImporteIVA10 As Double = 0
        Private _AplicarIVA10 As String = String.Empty
        Private _IVAComprasPorcentajeDirecto As Double = 0
        Private _IdCuentaBancaria As Integer = 0
        Private _PRESTOConcepto As String = String.Empty
        Private _PRESTOObra As String = String.Empty
        Private _IdDetalleRecepcion As Integer = 0
        Private _TomarEnCalculoDeImpuestos As String = String.Empty
        Private _IdRubroContable As Integer = 0
        Private _IdPedido As Integer = 0
        Private _IdDetallePedido As Integer = 0
        Private _Importacion_FOB As Double = 0
        Private _Importacion_PosicionAduana As String = String.Empty
        Private _Importacion_Despacho As String = String.Empty
        Private _Importacion_Guia As String = String.Empty
        Private _Importacion_IdPaisOrigen As Integer = 0
        Private _Importacion_FechaEmbarque As DateTime = DateTime.MinValue
        Private _Importacion_FechaOficializacion As DateTime = DateTime.MinValue
        Private _IdProvinciaDestino1 As Integer = 0
        Private _PorcentajeProvinciaDestino1 As Double = 0
        Private _IdProvinciaDestino2 As Integer = 0
        Private _PorcentajeProvinciaDestino2 As Double = 0
        Private _IdDistribucionObra As Integer = 0
        Private _Cantidad As Double = 0
        Private _IdDetalleObraDestino As Integer = 0
        Private _IdPresupuestoObraRubro As Integer = 0
        Private _IdPedidoAnticipo As Integer = 0
        Private _PorcentajeAnticipo As Double = 0
        Private _PorcentajeCertificacion As Double = 0
        Private _IdPresupuestoObrasNodo As Integer = 0
        Private _IdDetalleComprobanteProveedorOriginal As Integer = 0


        Public NumeroSubcontrato As Integer = 0
        Public IdSubcontrato As Integer = 0
        Public AmpliacionSubcontrato As String = String.Empty
        Public IdDetalleSubcontratoDatos As Integer = 0
        Public IdEquipoDestino As Integer = 0





        Private _Eliminado As Boolean = False
        Private _Nuevo As Boolean = False





        Private _Obra As String
        Private _Articulo As String
        Private _NumeroPedido As String
        Private _PedidoItem As String
        Private _RubroContable As String

        Public Property Obra() As String
            Get
                Return _Obra
            End Get
            Set(ByVal value As String)
                _Obra = value
            End Set
        End Property

        Public Property Articulo() As String
            Get
                Return _Articulo
            End Get
            Set(ByVal value As String)
                _Articulo = value
            End Set
        End Property

        Public Property NumeroPedido() As String
            Get
                Return _NumeroPedido
            End Get
            Set(ByVal value As String)
                _NumeroPedido = value
            End Set
        End Property

        Public Property PedidoItem() As String
            Get
                Return _PedidoItem
            End Get
            Set(ByVal value As String)
                _PedidoItem = value
            End Set
        End Property

        Public Property RubroContable() As String
            Get
                Return _RubroContable
            End Get
            Set(ByVal value As String)
                _RubroContable = value
            End Set
        End Property






        <DataObjectFieldAttribute(True, True, False)> _
        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property

        Public Property IdComprobanteProveedor() As Integer
            Get
                Return _IdComprobanteProveedor
            End Get
            Set(ByVal value As Integer)
                _IdComprobanteProveedor = value
            End Set
        End Property

        Public Property IdArticulo() As Integer
            Get
                Return _IdArticulo
            End Get
            Set(ByVal value As Integer)
                _IdArticulo = value
            End Set
        End Property
        Public Property CodigoArticulo() As String
            Get
                Return _CodigoArticulo
            End Get
            Set(ByVal value As String)
                _CodigoArticulo = value
            End Set
        End Property
        Public Property IdCuenta() As Integer
            Get
                Return _IdCuenta
            End Get
            Set(ByVal value As Integer)
                _IdCuenta = value
            End Set
        End Property
        Public Property CodigoCuenta() As String
            Get
                Return _CodigoCuenta
            End Get
            Set(ByVal value As String)
                _CodigoCuenta = value
            End Set
        End Property
        Public Property PorcentajeIvaAplicado() As Double
            Get
                Return _PorcentajeIvaAplicado
            End Get
            Set(ByVal value As Double)
                _PorcentajeIvaAplicado = value
            End Set
        End Property
        Public Property Importe() As Double
            Get
                Return _Importe
            End Get
            Set(ByVal value As Double)
                _Importe = value
            End Set
        End Property
        Public Property IdCuentaGasto() As Integer
            Get
                Return _IdCuentaGasto
            End Get
            Set(ByVal value As Integer)
                _IdCuentaGasto = value
            End Set
        End Property

        Public Property Cuenta() As String
            Get
                Return _CuentaGastoDescripcion
            End Get
            Set(ByVal value As String)
                _CuentaGastoDescripcion = value
            End Set
        End Property


        Public Property CuentaGastoDescripcion() As String
            Get
                Return _CuentaGastoDescripcion
            End Get
            Set(ByVal value As String)
                _CuentaGastoDescripcion = value
            End Set
        End Property

        Public Property IdCuentaIvaCompras1() As Integer
            Get
                Return _IdCuentaIvaCompras1
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras1 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje1() As Double
            Get
                Return _IVAComprasPorcentaje1
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje1 = value
            End Set
        End Property
        Public Property ImporteIVA1() As Double
            Get
                Return _ImporteIVA1
            End Get
            Set(ByVal value As Double)
                _ImporteIVA1 = value
            End Set
        End Property
        Public Property AplicarIVA1() As String
            Get
                Return _AplicarIVA1
            End Get
            Set(ByVal value As String)
                _AplicarIVA1 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras2() As Integer
            Get
                Return _IdCuentaIvaCompras2
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras2 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje2() As Double
            Get
                Return _IVAComprasPorcentaje2
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje2 = value
            End Set
        End Property
        Public Property ImporteIVA2() As Double
            Get
                Return _ImporteIVA2
            End Get
            Set(ByVal value As Double)
                _ImporteIVA2 = value
            End Set
        End Property
        Public Property AplicarIVA2() As String
            Get
                Return _AplicarIVA2
            End Get
            Set(ByVal value As String)
                _AplicarIVA2 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras3() As Integer
            Get
                Return _IdCuentaIvaCompras3
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras3 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje3() As Double
            Get
                Return _IVAComprasPorcentaje3
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje3 = value
            End Set
        End Property
        Public Property ImporteIVA3() As Double
            Get
                Return _ImporteIVA3
            End Get
            Set(ByVal value As Double)
                _ImporteIVA3 = value
            End Set
        End Property
        Public Property AplicarIVA3() As String
            Get
                Return _AplicarIVA3
            End Get
            Set(ByVal value As String)
                _AplicarIVA3 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras4() As Integer
            Get
                Return _IdCuentaIvaCompras4
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras4 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje4() As Double
            Get
                Return _IVAComprasPorcentaje4
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje4 = value
            End Set
        End Property
        Public Property ImporteIVA4() As Double
            Get
                Return _ImporteIVA4
            End Get
            Set(ByVal value As Double)
                _ImporteIVA4 = value
            End Set
        End Property
        Public Property AplicarIVA4() As String
            Get
                Return _AplicarIVA4
            End Get
            Set(ByVal value As String)
                _AplicarIVA4 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras5() As Integer
            Get
                Return _IdCuentaIvaCompras5
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras5 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje5() As Double
            Get
                Return _IVAComprasPorcentaje5
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje5 = value
            End Set
        End Property
        Public Property ImporteIVA5() As Double
            Get
                Return _ImporteIVA5
            End Get
            Set(ByVal value As Double)
                _ImporteIVA5 = value
            End Set
        End Property
        Public Property AplicarIVA5() As String
            Get
                Return _AplicarIVA5
            End Get
            Set(ByVal value As String)
                _AplicarIVA5 = value
            End Set
        End Property
        Public Property IdObra() As Integer
            Get
                Return _IdObra
            End Get
            Set(ByVal value As Integer)
                _IdObra = value
            End Set
        End Property
        Public Property Item() As Integer
            Get
                Return _Item
            End Get
            Set(ByVal value As Integer)
                _Item = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras6() As Integer
            Get
                Return _IdCuentaIvaCompras6
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras6 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje6() As Double
            Get
                Return _IVAComprasPorcentaje6
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje6 = value
            End Set
        End Property
        Public Property ImporteIVA6() As Double
            Get
                Return _ImporteIVA6
            End Get
            Set(ByVal value As Double)
                _ImporteIVA6 = value
            End Set
        End Property
        Public Property AplicarIVA6() As String
            Get
                Return _AplicarIVA6
            End Get
            Set(ByVal value As String)
                _AplicarIVA6 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras7() As Integer
            Get
                Return _IdCuentaIvaCompras7
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras7 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje7() As Double
            Get
                Return _IVAComprasPorcentaje7
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje7 = value
            End Set
        End Property
        Public Property ImporteIVA7() As Double
            Get
                Return _ImporteIVA7
            End Get
            Set(ByVal value As Double)
                _ImporteIVA7 = value
            End Set
        End Property
        Public Property AplicarIVA7() As String
            Get
                Return _AplicarIVA7
            End Get
            Set(ByVal value As String)
                _AplicarIVA7 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras8() As Integer
            Get
                Return _IdCuentaIvaCompras8
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras8 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje8() As Double
            Get
                Return _IVAComprasPorcentaje8
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje8 = value
            End Set
        End Property
        Public Property ImporteIVA8() As Double
            Get
                Return _ImporteIVA8
            End Get
            Set(ByVal value As Double)
                _ImporteIVA8 = value
            End Set
        End Property
        Public Property AplicarIVA8() As String
            Get
                Return _AplicarIVA8
            End Get
            Set(ByVal value As String)
                _AplicarIVA8 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras9() As Integer
            Get
                Return _IdCuentaIvaCompras9
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras9 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje9() As Double
            Get
                Return _IVAComprasPorcentaje9
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje9 = value
            End Set
        End Property
        Public Property ImporteIVA9() As Double
            Get
                Return _ImporteIVA9
            End Get
            Set(ByVal value As Double)
                _ImporteIVA9 = value
            End Set
        End Property
        Public Property AplicarIVA9() As String
            Get
                Return _AplicarIVA9
            End Get
            Set(ByVal value As String)
                _AplicarIVA9 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras10() As Integer
            Get
                Return _IdCuentaIvaCompras10
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras10 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje10() As Double
            Get
                Return _IVAComprasPorcentaje10
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje10 = value
            End Set
        End Property
        Public Property ImporteIVA10() As Double
            Get
                Return _ImporteIVA10
            End Get
            Set(ByVal value As Double)
                _ImporteIVA10 = value
            End Set
        End Property
        Public Property AplicarIVA10() As String
            Get
                Return _AplicarIVA10
            End Get
            Set(ByVal value As String)
                _AplicarIVA10 = value
            End Set
        End Property
        Public Property IVAComprasPorcentajeDirecto() As Double
            Get
                Return _IVAComprasPorcentajeDirecto
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentajeDirecto = value
            End Set
        End Property
        Public Property IdCuentaBancaria() As Integer
            Get
                Return _IdCuentaBancaria
            End Get
            Set(ByVal value As Integer)
                _IdCuentaBancaria = value
            End Set
        End Property
        Public Property PRESTOConcepto() As String
            Get
                Return _PRESTOConcepto
            End Get
            Set(ByVal value As String)
                _PRESTOConcepto = value
            End Set
        End Property
        Public Property PRESTOObra() As String
            Get
                Return _PRESTOObra
            End Get
            Set(ByVal value As String)
                _PRESTOObra = value
            End Set
        End Property
        Public Property IdDetalleRecepcion() As Integer
            Get
                Return _IdDetalleRecepcion
            End Get
            Set(ByVal value As Integer)
                _IdDetalleRecepcion = value
            End Set
        End Property
        Public Property TomarEnCalculoDeImpuestos() As String
            Get
                Return _TomarEnCalculoDeImpuestos
            End Get
            Set(ByVal value As String)
                _TomarEnCalculoDeImpuestos = value
            End Set
        End Property
        Public Property IdRubroContable() As Integer
            Get
                Return _IdRubroContable
            End Get
            Set(ByVal value As Integer)
                _IdRubroContable = value
            End Set
        End Property
        Public Property IdPedido() As Integer
            Get
                Return _IdPedido
            End Get
            Set(ByVal value As Integer)
                _IdPedido = value
            End Set
        End Property
        Public Property IdDetallePedido() As Integer
            Get
                Return _IdDetallePedido
            End Get
            Set(ByVal value As Integer)
                _IdDetallePedido = value
            End Set
        End Property
        Public Property Importacion_FOB() As Double
            Get
                Return _Importacion_FOB
            End Get
            Set(ByVal value As Double)
                _Importacion_FOB = value
            End Set
        End Property
        Public Property Importacion_PosicionAduana() As String
            Get
                Return _Importacion_PosicionAduana
            End Get
            Set(ByVal value As String)
                _Importacion_PosicionAduana = value
            End Set
        End Property
        Public Property Importacion_Despacho() As String
            Get
                Return _Importacion_Despacho
            End Get
            Set(ByVal value As String)
                _Importacion_Despacho = value
            End Set
        End Property
        Public Property Importacion_Guia() As String
            Get
                Return _Importacion_Guia
            End Get
            Set(ByVal value As String)
                _Importacion_Guia = value
            End Set
        End Property
        Public Property Importacion_IdPaisOrigen() As Integer
            Get
                Return _Importacion_IdPaisOrigen
            End Get
            Set(ByVal value As Integer)
                _Importacion_IdPaisOrigen = value
            End Set
        End Property
        Public Property Importacion_FechaEmbarque() As DateTime
            Get
                Return _Importacion_FechaEmbarque
            End Get
            Set(ByVal value As DateTime)
                _Importacion_FechaEmbarque = value
            End Set
        End Property
        Public Property Importacion_FechaOficializacion() As DateTime
            Get
                Return _Importacion_FechaOficializacion
            End Get
            Set(ByVal value As DateTime)
                _Importacion_FechaOficializacion = value
            End Set
        End Property
        Public Property IdProvinciaDestino1() As Integer
            Get
                Return _IdProvinciaDestino1
            End Get
            Set(ByVal value As Integer)
                _IdProvinciaDestino1 = value
            End Set
        End Property
        Public Property PorcentajeProvinciaDestino1() As Double
            Get
                Return _PorcentajeProvinciaDestino1
            End Get
            Set(ByVal value As Double)
                _PorcentajeProvinciaDestino1 = value
            End Set
        End Property
        Public Property IdProvinciaDestino2() As Integer
            Get
                Return _IdProvinciaDestino2
            End Get
            Set(ByVal value As Integer)
                _IdProvinciaDestino2 = value
            End Set
        End Property
        Public Property PorcentajeProvinciaDestino2() As Double
            Get
                Return _PorcentajeProvinciaDestino2
            End Get
            Set(ByVal value As Double)
                _PorcentajeProvinciaDestino2 = value
            End Set
        End Property
        Public Property IdDistribucionObra() As Integer
            Get
                Return _IdDistribucionObra
            End Get
            Set(ByVal value As Integer)
                _IdDistribucionObra = value
            End Set
        End Property
        Public Property Cantidad() As Double
            Get
                Return _Cantidad
            End Get
            Set(ByVal value As Double)
                _Cantidad = value
            End Set
        End Property
        Public Property IdDetalleObraDestino() As Integer
            Get
                Return _IdDetalleObraDestino
            End Get
            Set(ByVal value As Integer)
                _IdDetalleObraDestino = value
            End Set
        End Property
        Public Property IdPresupuestoObraRubro() As Integer
            Get
                Return _IdPresupuestoObraRubro
            End Get
            Set(ByVal value As Integer)
                _IdPresupuestoObraRubro = value
            End Set
        End Property
        Public Property IdPedidoAnticipo() As Integer
            Get
                Return _IdPedidoAnticipo
            End Get
            Set(ByVal value As Integer)
                _IdPedidoAnticipo = value
            End Set
        End Property
        Public Property PorcentajeAnticipo() As Double
            Get
                Return _PorcentajeAnticipo
            End Get
            Set(ByVal value As Double)
                _PorcentajeAnticipo = value
            End Set
        End Property
        Public Property PorcentajeCertificacion() As Double
            Get
                Return _PorcentajeCertificacion
            End Get
            Set(ByVal value As Double)
                _PorcentajeCertificacion = value
            End Set
        End Property
        Public Property IdPresupuestoObrasNodo() As Integer
            Get
                Return _IdPresupuestoObrasNodo
            End Get
            Set(ByVal value As Integer)
                _IdPresupuestoObrasNodo = value
            End Set
        End Property
        Public Property IdDetalleComprobanteProveedorOriginal() As Integer
            Get
                Return _IdDetalleComprobanteProveedorOriginal
            End Get
            Set(ByVal value As Integer)
                _IdDetalleComprobanteProveedorOriginal = value
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