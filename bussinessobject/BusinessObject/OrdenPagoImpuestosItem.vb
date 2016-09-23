Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class OrdenPagoImpuestosItem
        Private _Id As Integer = -1


        Public IdOrdenPago As Integer = 0
        Public _TipoImpuesto As String = String.Empty
        Public IdTipoRetencionGanancia As Integer = 0
        Public _ImportePagado As Double = 0
        Public _ImpuestoRetenido As Double = 0
        Public IdIBCondicion As Integer = 0
        Public _NumeroCertificadoRetencionGanancias As Integer = 0
        Public _NumeroCertificadoRetencionIIBB As Integer = 0
        Public _AlicuotaAplicada As Double = 0
        Public _AlicuotaConvenioAplicada As Double = 0
        Public _PorcentajeATomarSobreBase As Double = 0
        Public _PorcentajeAdicional As Double = 0
        Public _ImpuestoAdicional As Double = 0
        Public _LeyendaPorcentajeAdicional As String
        Public _ImporteTotalFacturasMPagadasSujetasARetencion As Double = 0

        Public _Precio As Double = 0   '    Ehhhh? No puedo hacer bind desde la grilla a esto 
        '                                   porque no tiene property???? http://www.mikepope.com/blog/AddComment.aspx?blogid=1419
        Public _PrecioUnitarioTotal As Double = 0
        Public _PorcentajeBonificacion As Double = 0
        Public _ImporteBonificacion As Double = 0
        Public _PorcentajeIVA As Double = 0
        Public _ImporteIVA As Double = 0
        Public _ImporteTotalItem As Double = 0









        Public Property LeyendaPorcentajeAdicional() As String
            Get
                Return _LeyendaPorcentajeAdicional
            End Get
            Set(ByVal value As String)
                _LeyendaPorcentajeAdicional = value
            End Set
        End Property

        Public Property ImporteTotalFacturasMPagadasSujetasARetencion() As Double
            Get
                Return _ImporteTotalFacturasMPagadasSujetasARetencion
            End Get
            Set(ByVal value As Double)
                _ImporteTotalFacturasMPagadasSujetasARetencion = value
            End Set
        End Property

        Public Property PorcentajeAdicional() As Double
            Get
                Return _PorcentajeAdicional
            End Get
            Set(ByVal value As Double)
                _PorcentajeAdicional = value
            End Set
        End Property

        Public Property ImpuestoAdicional() As Double
            Get
                Return _ImpuestoAdicional
            End Get
            Set(ByVal value As Double)
                _ImpuestoAdicional = value
            End Set
        End Property

        Public Property PorcentajeATomarSobreBase() As Double
            Get
                Return _PorcentajeATomarSobreBase
            End Get
            Set(ByVal value As Double)
                _PorcentajeATomarSobreBase = value
            End Set
        End Property

        Public Property AlicuotaConvenioAplicada() As Double
            Get
                Return _AlicuotaConvenioAplicada
            End Get
            Set(ByVal value As Double)
                _AlicuotaConvenioAplicada = value
            End Set
        End Property



        Public Property AlicuotaAplicada() As Double
            Get
                Return _AlicuotaAplicada
            End Get
            Set(ByVal value As Double)
                _AlicuotaAplicada = value
            End Set
        End Property



        Public Property NumeroCertificadoRetencionIIBB() As Integer
            Get
                Return _NumeroCertificadoRetencionIIBB
            End Get
            Set(ByVal value As Integer)
                _NumeroCertificadoRetencionIIBB = value
            End Set
        End Property


        Public Property NumeroCertificadoRetencionGanancias() As Integer
            Get
                Return _NumeroCertificadoRetencionGanancias
            End Get
            Set(ByVal value As Integer)
                _NumeroCertificadoRetencionGanancias = value
            End Set
        End Property










        '///////////////////////////////////////
        'Ver qué conviene anexar al codigo generado
        '///////////////////////////////////////

        Public Property Precio() As Double
            Get
                Return _Precio
            End Get
            Set(ByVal value As Double)
                _Precio = value
            End Set
        End Property

        Public Property PrecioUnitarioTotal() As Double
            Get
                Return _PrecioUnitarioTotal
            End Get
            Set(ByVal value As Double)
                _PrecioUnitarioTotal = value
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



        '///////////////////////////////////////















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











        'creados porque RecalcularImpuestos no los encontraba. Quizas tienen otro nombre
        Public _Categoria As String
        Public _ImporteAcumulado As Double = 0
        Public _RetencionesMes As Double = 0
        Public _PagosMes As Double = 0
        Public _ImporteTopeMinimoIIBB As Double = 0
        Public _AlicuotaConvenioIIBB As Double = 0
        Public _AlicuotaIIBB As Double = 0
        Public _MinimoIIBB As Double = 0

        Public Property Categoria() As String
            Get
                Return _Categoria
            End Get
            Set(ByVal value As String)
                _Categoria = value
            End Set
        End Property

        Public Property ImporteAcumulado() As Double
            Get
                Return _ImporteAcumulado
            End Get
            Set(ByVal value As Double)
                _ImporteAcumulado = value
            End Set
        End Property



        Public Property RetencionesMes() As Double
            Get
                Return _RetencionesMes
            End Get
            Set(ByVal value As Double)
                _RetencionesMes = value
            End Set
        End Property

        Public Property PagosMes() As Double
            Get
                Return _PagosMes
            End Get
            Set(ByVal value As Double)
                _PagosMes = value
            End Set
        End Property

        Public Property ImporteTopeMinimoIIBB() As Double
            Get
                Return _ImporteTopeMinimoIIBB
            End Get
            Set(ByVal value As Double)
                _ImporteTopeMinimoIIBB = value
            End Set
        End Property

        Public Property AlicuotaConvenioIIBB() As Double
            Get
                Return _AlicuotaConvenioIIBB
            End Get
            Set(ByVal value As Double)
                _AlicuotaConvenioIIBB = value
            End Set
        End Property

        Public Property AlicuotaIIBB() As Double
            Get
                Return _AlicuotaIIBB
            End Get
            Set(ByVal value As Double)
                _AlicuotaIIBB = value
            End Set
        End Property

        Public Property MinimoIIBB() As Double
            Get
                Return _MinimoIIBB
            End Get
            Set(ByVal value As Double)
                _MinimoIIBB = value
            End Set
        End Property




        Public Property TipoImpuesto() As String
            Get
                Return _TipoImpuesto
            End Get
            Set(ByVal value As String)
                _TipoImpuesto = value
            End Set
        End Property

        Public Property ImportePagado() As Double
            Get
                Return _ImportePagado
            End Get
            Set(ByVal value As Double)
                _ImportePagado = value
            End Set
        End Property

        Public Property ImpuestoRetenido() As Double
            Get
                Return _ImpuestoRetenido
            End Get
            Set(ByVal value As Double)
                _ImpuestoRetenido = value
            End Set
        End Property


























    End Class
    
End Namespace