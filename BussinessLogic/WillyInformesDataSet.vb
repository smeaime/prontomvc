Imports System.Data.SqlClient

Partial Class WillyInformesDataSet



    Partial Class wCartasDePorte_TX_InformesCorregidoDataTable

        Private Sub wCartasDePorte_TX_InformesCorregidoDataTable_ColumnChanging(ByVal sender As System.Object, ByVal e As System.Data.DataColumnChangeEventArgs) Handles Me.ColumnChanging
            If (e.Column.ColumnName = Me.DestinoCodigoONCAAColumn.ColumnName) Then
                'Add user code here
            End If

        End Sub

        Private Sub wCartasDePorte_TX_InformesCorregidoDataTable_wCartasDePorte_TX_InformesCorregidoRowChanging(ByVal sender As System.Object, ByVal e As wCartasDePorte_TX_InformesCorregidoRowChangeEvent) Handles Me.wCartasDePorte_TX_InformesCorregidoRowChanging

        End Sub

    End Class

End Class


Namespace WillyInformesDataSetTableAdapters
    'http://blogs.msdn.com/b/smartclientdata/archive/2005/08/16/increasetableadapterquerytimeout.aspx    Partial Class wCartasDePorte_TX_InformesCorregidoTableAdapter
        Public Sub SetCommandTimeOut(ByVal timeOut As Integer)
            For Each command As SqlCommand In Me.CommandCollection
                '                Valor de propiedad
                'Tiempo, expresado en segundos, que se debe esperar para que se ejecute el comando. El valor predeterminado es 30 segundos.
                command.CommandTimeout = timeOut
            Next
        End Sub
    End Class


End Namespace



