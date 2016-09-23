Imports System
Imports System.Collections.Generic

Namespace Pronto.ERP.BO

    <Serializable()> Public Class PedidoList
        Inherits List(Of Pedido)

        Public Sub New()
        End Sub

    End Class

End Namespace