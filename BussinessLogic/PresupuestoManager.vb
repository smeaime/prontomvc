Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Configuration
Imports System.Diagnostics

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class PresupuestoManager
        Inherits ServicedComponent

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String, Optional ByVal IdObra As Integer = -1, Optional ByVal TipoFiltro As String = "", Optional ByVal IdProveedor As Integer = -1) As PresupuestoList

            Dim Lista As PresupuestoList = PresupuestoDB.GetList(SC)

            If Lista Is Nothing Then Return Nothing



            'metodo 1: borro sobre la lista original
            Dim lstBorrar As New List(Of Integer)

            'metodo 2: hago una segunda lista sobre la que copio los objetos filtrados
            Dim Lista2 As New PresupuestoList
            Try
                For Each cp As Presupuesto In Lista
                    'If IIf(IdObra = -1, True, cp.IdObra = IdObra) And 
                    If IIf(IdProveedor = -1, True, cp.IdProveedor = IdProveedor) Then

                        Select Case TipoFiltro
                            Case "", "AConfirmarEnObra"
                                If iisNull(cp.ConfirmadoPorWeb, "NO") = "NO" Then 'And iisNull(cp.Aprobo, 0) = 0 Then


                                    'Lista.Remove(cp)  'http://www.velocityreviews.com/forums/t104020-how-can-i-delete-a-item-in-foreach-loop.html
                                    'metodo 1 
                                    'lstBorrar.Add(Lista.IndexOf(cp))
                                    'metodo 2

                                    Lista2.Add(cp)

                                End If
                            Case "AConfirmarEnCentral"
                                If iisNull(cp.ConfirmadoPorWeb, "NO") = "SI" And iisNull(cp.Aprobo, 0) = 0 Then
                                    'lstBorrar.Add(Lista.IndexOf(cp))

                                    Lista2.Add(cp)
                                End If
                            Case "Confirmados"
                                'If iisNull(cp.Aprobo, 0) <> 0 Then
                                If iisNull(cp.ConfirmadoPorWeb, "NO") = "SI" Then 'And iisNull(cp.Aprobo, 0) = 0 Then
                                    'lstBorrar.Add(Lista.IndexOf(cp))

                                    Lista2.Add(cp)
                                End If
                            Case Else
                                Err.Raise(222222222)
                        End Select

                    End If
                Next
            Catch ex As Exception
                Debug.Print(ex.Message)
            End Try



            ''metodo 1: 'borrar marcha atras porque si no cambia el indice!!!!
            'For Each i As Integer In New ReverseIterator(lstBorrar)
            '    Lista.RemoveAt(i) 'al final se trula y se excede del indice
            'Next

            'Return Lista



            'metodo 2 
            Return Lista2

        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListDataset(ByVal SC As String) As System.Data.DataSet

            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            'With dc
            '    .ColumnName = "ColumnaTilde"
            '    .DataType = System.Type.GetType("System.Int32")
            '    .DefaultValue = 0
            'End With

            ds = GeneralDB.TraerDatos(SC, "wPresupuestos_TT")

            'Try
            '    ds = GeneralDB.TraerDatos(SC, "wPresupuestos_T", -1)
            'Catch ex As Exception
            '    ds = GeneralDB.TraerDatos(SC, "Presupuestos_T", -1)
            'End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdPresupuesto").ColumnName = "Id"
                '.Columns("Numero").ColumnName = "Numero"
                '.Columns("FechaRequerimiento").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
            Return ds

        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function TraerFiltrado(ByVal SC As String, ByVal TX As String) As System.Data.DataSet
            Return GetListTX(SC, TX)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListTX(ByVal SC As String, ByVal TX As String) As System.Data.DataSet
            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox


            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            With dc
                .ColumnName = "ColumnaTilde"
                .DataType = System.Type.GetType("System.Int32")
                .DefaultValue = 0
            End With


            If TX = "" Then
                ds = GeneralDB.TraerDatos(SC, "wPresupuestos_T", -1)
            Else
                Try
                    ds = GeneralDB.TraerDatos(SC, "wPresupuestos_TX" & TX)
                Catch ex As Exception
                    ds = GeneralDB.TraerDatos(SC, "Presupuestos_TX" & TX)
                End Try
            End If


            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListTX(ByVal SC As String, ByVal TX As String, ByVal ParamArray Parametros() As Object) As System.Data.DataSet
            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            With dc
                .ColumnName = "ColumnaTilde"
                .DataType = System.Type.GetType("System.Int32")
                .DefaultValue = 0
            End With


            Try
                ds = GeneralDB.TraerDatos(SC, "wPresupuestos_TX" & TX, Parametros)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Presupuestos_TX" & TX, Parametros)
            End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function



        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return PresupuestoDB.GetList_fm(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Presupuesto
            Return GetItem(SC, id, False)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetCopyOfItem(ByVal SC As String, ByVal id As Integer) As Presupuesto
            If id <= 0 Then Return Nothing

            GetCopyOfItem = GetItem(SC, id, True)
            'me trigo el mismo item, pero lo marco como nuevo -pero no deberías hacer lo mismo con el detalle?
            GetCopyOfItem.Id = -1
            For Each item As PresupuestoItem In GetCopyOfItem.Detalles
                item.Id = -1
                item.Unidad = EntidadManager.NombreUnidad(SC, item.IdUnidad)
            Next
        End Function


        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, ByVal getPresupuestoDetalles As Boolean) As Presupuesto
            Dim myPresupuesto As Presupuesto
            myPresupuesto = PresupuestoDB.GetItem(SC, id)
            If Not (myPresupuesto Is Nothing) AndAlso getPresupuestoDetalles Then
                myPresupuesto.Detalles = PresupuestoItemDB.GetList(SC, id)
            End If
            Return myPresupuesto
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As PresupuestoItemList
            Return PresupuestoItemDB.GetList(SC, id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Update, True)> _
         Public Shared Function Save(ByVal SC As String, ByVal myPresupuesto As Presupuesto) As Integer


            'Dim myTransactionScope As TransactionScope = New TransactionScope
            Try
                Dim PresupuestoId As Integer = PresupuestoDB.Save(SC, myPresupuesto)
                'For Each myPresupuestoItem As PresupuestoItem In myPresupuesto.Detalles
                '    myPresupuestoItem.IdPresupuesto = PresupuestoId
                '    PresupuestoItemDB.Save(myPresupuestoItem)
                'Next
                myPresupuesto.Id = PresupuestoId




                '//////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////
                'Mandar mails
                '//////////////////////////////////////////////////////////////
                Try
                    If myPresupuesto.ConfirmadoPorWeb = "SI" Then
                        'Dim De As String
                        Dim Para As String
                        'De = "ProntoWebMail@gmail.com"
                        'De = ProveedorManager.GetItem(SC, myPresupuesto.IdProveedor).Email
                        'Para = "mscalella911@gmail.com"
                        Para = EmpleadoManager.GetItem(SC, myPresupuesto.IdComprador).Email
                        If Not MandaEmail(Para, "Respuesta a Solicitud N°" & myPresupuesto.Numero & "/" & myPresupuesto.SubNumero, "El proveedor " & ProveedorManager.GetItem(SC, myPresupuesto.IdProveedor).RazonSocial & " respondió al presupuesto N°" & myPresupuesto.Numero & "/" & myPresupuesto.SubNumero, "ProntoWebMail@gmail.com", ConfigurationManager.AppSettings("SmtpServer"), ConfigurationManager.AppSettings("SmtpUser"), ConfigurationManager.AppSettings("SmtpPass")) Then
                        End If

                        'tambien mandar otro mail si cerraron todos 

                        If TodosRespondidos(SC, myPresupuesto.Numero) Then
                            Para = EmpleadoManager.GetItem(SC, myPresupuesto.IdComprador).Email
                            If Not MandaEmail(Para, _
                                                "Respuesta a Solicitud N°" & myPresupuesto.Numero & " Completa", _
                                                "Todas las solicitudes del presupuesto N°" & myPresupuesto.Numero & " han sido respondidos", _
                                                "ProntoWebMail@gmail.com", _
                                                ConfigurationManager.AppSettings("SmtpServer"), _
                                                ConfigurationManager.AppSettings("SmtpUser"), _
                                                ConfigurationManager.AppSettings("SmtpPass")) Then
                            End If
                        End If

                    End If
                Catch ex As Exception
                    Debug.Print("Error al mandar mail")
                End Try

                '//////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////






                'myTransactionScope.Complete()
                'ContextUtil.SetComplete()
                Return PresupuestoId
            Catch ex As Exception
                'ContextUtil.SetAbort()
                Debug.Print(ex.Message)
                Return -1
            Finally
                'CType(myTransactionScope, IDisposable).Dispose()
            End Try
            Return myPresupuesto.Id
        End Function


        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myPresupuesto As Presupuesto) As Boolean
            Return PresupuestoDB.Delete(SC, myPresupuesto.Id)
        End Function


        Private Shared Function TodosRespondidos(ByVal SC As String, ByVal NumeroPresupuesto As Integer) As Boolean 'Lo que diferencia a los presupuestos del mismo origen es el "Subnumero" ("Orden" en el ABM de Pronto)
            Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Presupuestos", "TX_PorNumero", NumeroPresupuesto)
            If ds.Tables(0).Rows.Count > 0 Then
                For Each dr As Data.DataRow In ds.Tables(0).Rows
                    If iisNull(dr.Item("ConfirmadoPorWeb"), "NO") = "NO" Then Return False
                Next
            End If
            Return True
        End Function



        Public Shared Function IsValid(ByVal myPresupuesto As Presupuesto) As Boolean

            Dim eliminados As Integer
            'verifico el detalle
            For Each det As PresupuestoItem In myPresupuesto.Detalles
                If det.IdArticulo = 0 Then 'verifico que no pase un renglon en blanco
                    det.Eliminado = True
                End If
                If det.Eliminado Then eliminados = eliminados + 1
            Next

            If myPresupuesto.Detalles.Count = eliminados Or myPresupuesto.Detalles.Count = 0 Then
                Return False
            End If


            Return True
        End Function


        Public Shared Sub RecalcularTotales(ByRef myPresupuesto As Presupuesto)

            Dim mvarSubTotal, mvarIVA1 As Single

            With myPresupuesto

                'tendrías que dejarlo como en pronto, donde se usan las variables locales para los calculos
                .TotalBonifEnItems = 0
                .ImporteIva1 = 0


                For Each det As PresupuestoItem In .Detalles
                    With det
                        '////////////////////////
                        'codigo comentado: así lo hacía antes de mover todo al manager
                        'Dim temp As Decimal
                        'txtSubtotal.Text = StringToDecimal(txtSubtotal.Text) + det.Cantidad * det.Precio
                        'temp = (det.Cantidad * det.Precio * ((100 + det.PorcentajeIVA) / 100) * ((100 + det.PorcentajeBonificacion) / 100))
                        'temp = temp + txtTotal.Text 'StringToDecimal(txtTotal.Text)
                        'Debug.Print(temp)
                        'txtTotal.Text = temp
                        '////////////////////////


                        '////////////////////////
                        'Cálculo del item
                        Dim mImporte = Val(.Precio) * Val(.Cantidad)
                        .ImporteBonificacion = Math.Round(mImporte * Val(.PorcentajeBonificacion) / 100, 4)
                        .ImporteIVA = Math.Round((mImporte - .ImporteBonificacion) * Val(.PorcentajeIVA) / 100, 4)
                        .ImporteTotalItem = mImporte - .ImporteBonificacion + .ImporteIVA
                        '////////////////////////


                        '////////////////////////
                        'Sumador de totales
                        mvarSubTotal += mImporte
                        myPresupuesto.TotalBonifEnItems += .ImporteBonificacion
                        mvarIVA1 += .ImporteIVA
                        '////////////////////////
                    End With
                Next


                '////////////////////////
                'Asigno totales generales
                .SubTotal = mvarSubTotal '+ .TotalBonifEnItems - mvarIVA1 'no sé en qué casos va esto
                .TotalBonifSobreElTotal = Math.Round((mvarSubTotal - .TotalBonifEnItems) * Val(.Bonificacion) / 100, 2)
                .TotalSubGravado = mvarSubTotal - .TotalBonifSobreElTotal - .TotalBonifEnItems
                .ImporteIva1 = mvarIVA1
                .Total = .TotalSubGravado + mvarIVA1 '+ mvarIVA2
            End With
        End Sub


        Public Shared Function ProximoSubNumero(ByVal SC As String, ByVal PresupuestoNumero As Long) As Long
            Dim mSubNumero As Integer = 0
            Dim ds As Data.DataSet = PresupuestoManager.GetListTX(SC, "_PorNumeroBis", PresupuestoNumero)
            If ds.Tables(0).Rows.Count > 0 Then
                For Each dr As Data.DataRow In ds.Tables(0).Rows
                    If Not IsNull(dr.Item("SubNumero")) Then
                        mSubNumero = System.Math.Max(mSubNumero, dr.Item("SubNumero"))
                    End If
                Next
            End If
            mSubNumero = mSubNumero + 1
            Return mSubNumero
        End Function


    End Class



End Namespace