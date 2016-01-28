Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Data
Imports Pronto.ERP.Bll.EntidadManager
'sss
Imports System.Linq
Imports System.Linq.Expressions
Imports System.Linq.Dynamic
Imports System.Collections.Generic


Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Partial Public Class RequerimientoManager
        Inherits ServicedComponent

  

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String, ByVal orderBy As String) As RequerimientoList
            Dim requerimientoList As Pronto.ERP.BO.RequerimientoList = RequerimientoDB.GetListByEmployee(SC, IdSolicito)
            If requerimientoList IsNot Nothing Then
                Select Case orderBy
                    Case "Fecha"
                        requerimientoList.Sort(AddressOf Pronto.ERP.BO.RequerimientoList.CompareFecha)
                    Case "Obra"
                        requerimientoList.Sort(AddressOf Pronto.ERP.BO.RequerimientoList.CompareObra)
                    Case "Sector"
                        requerimientoList.Sort(AddressOf Pronto.ERP.BO.RequerimientoList.CompareSector)
                    Case Else 'Ordena por id
                        requerimientoList.Sort(AddressOf Pronto.ERP.BO.RequerimientoList.CompareId)
                End Select
            End If
            Return requerimientoList
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return RequerimientoDB.GetList_fm(SC)
        End Function





        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListDatasetPaginado_obsoleta(ByVal SC As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable

            If startRowIndex = 0 Then startRowIndex = 1
            Dim dt As DataTable = GetStoreProcedure(SC, enumSPs.wRequerimientos_TTpaginado, startRowIndex, maximumRows)


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With dt
                .Columns("IdRequerimiento").ColumnName = "Id"
                .Columns("NumeroRequerimiento").ColumnName = "Numero"
                '.Columns("FechaRequerimiento").ColumnName = "Fecha"
            End With

            Return dt

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


            Try
                ds = GeneralDB.TraerDatos(SC, "wRequerimientos_T", -1)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Requerimientos_T", -1)
            End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdRequerimiento").ColumnName = "Id"
                .Columns("NumeroRequerimiento").ColumnName = "Numero"
                '.Columns("FechaRequerimiento").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
            Return ds

        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListTXDetallesPendientes1(ByVal SC As String, Optional ByVal bForzarRecalculoDeRMsPendientes As Boolean = False) As System.Data.DataTable
            If bForzarRecalculoDeRMsPendientes Then
                RecalcularPendientes1(SC)
            End If
            Return GetListTX(SC, "_Pendientes1", "P").Tables(0)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListTXDetallesPendientesDeAsignacion(ByVal SC As String) As System.Data.DataTable
            Return GetListTX(SC, "_PendientesDeAsignacion").Tables(0)
        End Function


        Public Shared Sub RecalcularPendientes1(ByVal SC As String)
            EntidadManager.Tarea(SC, "wRequerimientos_TX_Pendientes1_SubRecalculoRM")
        End Sub

        Public Shared Sub RecalcularPendientesDeAsignar(ByVal SC As String)
            EntidadManager.Tarea(SC, "wRequerimientos_TX_PendientesDeAsignacion_SubRecalculoRM")
        End Sub



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
                ds = GeneralDB.TraerDatos(SC, "wRequerimientos_TX" & TX, Parametros)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Requerimientos_TX" & TX, Parametros)
            End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListTX(ByVal SC As String, ByVal TX As String) As System.Data.DataSet
            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox


            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta
            With dc
                .ColumnName = "ColumnaTilde"
                .DataType = System.Type.GetType("System.Int32")
                .DefaultValue = 0
            End With


            Try
                ds = GeneralDB.TraerDatos(SC, "wRequerimientos_TX" & TX)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Requerimientos_TX" & TX)
            End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function



        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Requerimiento
            Return GetItem(SC, id, False)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, ByVal getRequerimientoDetalles As Boolean) As Requerimiento
            Dim myRequerimiento As Requerimiento
            myRequerimiento = RequerimientoDB.GetItem(SC, id)
            If Not (myRequerimiento Is Nothing) AndAlso getRequerimientoDetalles Then
                myRequerimiento.Detalles = RequerimientoItemDB.GetList(SC, id)




                '///////////////////////////////////////////
                '///////////////////////////////////////////
                '///////////////////////////////////////////
                'parche con LINQ de columnas extra
                '///////////////////////////////////////////
                '///////////////////////////////////////////
                'Generic.Dictionary(Of

                Using db As New DataClassesRequerimientoDataContext(Encriptar(SC))
                    ' http://stackoverflow.com/questions/9708266/assign-values-from-one-list-to-another-using-linq

                    Dim detalleslinq As List(Of DetalleRequerimiento) = (From i In db.DetalleRequerimientos Where i.IdRequerimiento = id).ToList

                    For Each i As RequerimientoItem In myRequerimiento.Detalles
                        Dim iddet = i.Id
                        Dim o = (From u In detalleslinq Where u.IdDetalleRequerimiento = iddet).FirstOrDefault
                        With i
                            Try
                                .bien_o_uso = iisNull(o.EsBienDeUso, "NO") <> "NO"
                                .ControlDeCalidad = o.IdControlCalidad
                            Catch ex As Exception
                                ErrHandler2.WriteError(ex)
                            End Try
                        End With

                    Next

                End Using
                '///////////////////////////////////////////
                '///////////////////////////////////////////
                '///////////////////////////////////////////


            End If
            Return myRequerimiento
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As RequerimientoItemList
            Return RequerimientoItemDB.GetList(SC, id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Update, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myRequerimiento As Requerimiento) As Integer
            'Dim myTransactionScope As TransactionScope = New TransactionScope
            Try
                Dim RequerimientoId As Integer = RequerimientoDB.Save(SC, myRequerimiento)
                'For Each myRequerimientoItem As RequerimientoItem In myRequerimiento.Detalles
                '    myRequerimientoItem.IdRequerimiento = RequerimientoId
                '    RequerimientoItemDB.Save(myRequerimientoItem)
                'Next


                Try

                    Using db As New DataClassesRequerimientoDataContext(Encriptar(SC))
                        ' http://stackoverflow.com/questions/9708266/assign-values-from-one-list-to-another-using-linq


                        Dim cab = (From i In db.linqRequerimientos Where i.IdRequerimiento = RequerimientoId).Single
                        With cab
                            .Adjuntos = IIf(.Adjuntos = "SI", "SI", "NO")
                            .RequisitosSeguridad = If(.RequisitosSeguridad, "")
                            .LugarEntrega = If(.LugarEntrega, "")
                            .Observaciones = If(.Observaciones, "")
                            .MontoPrevisto = IIf(.MontoPrevisto <= 0, Nothing, .MontoPrevisto)
                            .MontoParaCompra = IIf(.MontoParaCompra <= 0, Nothing, .MontoParaCompra)

                        End With

                        Dim detalleslinq As List(Of DetalleRequerimiento) = (From i In db.DetalleRequerimientos Where i.IdRequerimiento = RequerimientoId).ToList


                        For Each i As RequerimientoItem In myRequerimiento.Detalles
                            Dim iddet = i.Id
                            Dim o = (From u In detalleslinq Where u.IdDetalleRequerimiento = iddet).FirstOrDefault
                            With i
                                Try
                                    o.EsBienDeUso = IIf(.bien_o_uso, "SI", "NO")
                                    o.IdControlCalidad = IIf(.ControlDeCalidad <= 0, Nothing, .ControlDeCalidad)

                                    o.NumeroFacturaCompra2 = Nothing
                                    o.Descripcionmanual = Nothing
                                    o.IdAutorizoCumplido = Nothing
                                    o.ObservacionesCumplido = Nothing

                                    o.ArchivoAdjunto1 = ""
                                    o.ArchivoAdjunto2 = ""
                                    o.ArchivoAdjunto3 = ""
                                    o.ArchivoAdjunto4 = ""
                                    o.ArchivoAdjunto5 = ""
                                    o.ArchivoAdjunto6 = ""
                                    o.ArchivoAdjunto7 = ""
                                    o.ArchivoAdjunto8 = ""
                                    o.ArchivoAdjunto9 = ""
                                    o.ArchivoAdjunto10 = ""
                                Catch ex As Exception
                                    ErrHandler2.WriteError(ex)
                                End Try
                            End With

                        Next


                        db.SubmitChanges()
                    End Using
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try





                myRequerimiento.Id = RequerimientoId
                'myTransactionScope.Complete()
                'ContextUtil.SetComplete()
                Return RequerimientoId
            Catch ex As Exception
                'ContextUtil.SetAbort()
                ErrHandler2.WriteError(ex.Message)
                Return -1
            Finally
                'CType(myTransactionScope, IDisposable).Dispose()
            End Try
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myRequerimiento As Requerimiento) As Boolean
            Return RequerimientoDB.Delete(SC, myRequerimiento.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal empleado As Empleado) As Integer
            Return RequerimientoDB.GetCountRequemientoForEmployee(SC, empleado.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Anular(ByVal SC As String, ByVal IdRequerimiento As Integer) As Integer
            Return RequerimientoDB.Anular(SC, IdRequerimiento)
        End Function


        Public Shared Function GetCountRequemientoForEmployee(ByVal SC As String, ByVal IdEmpleado As Integer) As Integer
            Return RequerimientoDB.GetCountRequemientoForEmployee(SC, IdEmpleado)
        End Function


        Public Shared Function IsValid(ByVal myRequerimiento As Requerimiento) As Boolean

            Dim eliminados As Integer
            'verifico el detalle
            For Each det As RequerimientoItem In myRequerimiento.Detalles
                If det.IdArticulo <= 0 Then 'verifico que no pase un renglon en blanco
                    det.Eliminado = True
                End If
                If det.Eliminado Then eliminados = eliminados + 1
            Next

            If myRequerimiento.Detalles.Count = eliminados Or myRequerimiento.Detalles.Count = 0 Then
                Return False
            End If


            Return True
        End Function




        Public Shared Function UltimoItemDetalle(ByVal myRequerimiento As Requerimiento) As Integer

            For Each i As RequerimientoItem In myRequerimiento.Detalles
                If UltimoItemDetalle < i.NumeroItem And Not i.Eliminado Then UltimoItemDetalle = i.NumeroItem
            Next

        End Function






        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Anular(ByVal SC As String, ByVal IdRequerimiento As Integer, ByVal IdUsuario As Long, ByVal motivo As String) As String

            Dim myRequerimiento As Pronto.ERP.BO.Requerimiento = RequerimientoManager.GetItem(SC, IdRequerimiento, True)
            With myRequerimiento

                If .Cumplido = "SI" Then
                    Return "La RM está cumplida (puede haberse dado cumplida manualmente, por estar en un pedido, o por estar en una recepcion"
                End If

                'esto tiene que estar en el manager, dios!
                .MotivoAnulacion = motivo
                .FechaAnulacion = Today
                .UsuarioAnulacion = IdUsuario
                .Cumplido = "AN"
                For Each i As RequerimientoItem In .Detalles
                    With i
                        .Cumplido = "AN"
                        '.EnviarEmail = 1
                    End With
                Next


            End With

            RequerimientoManager.Save(SC, myRequerimiento)
            Return ""
        End Function
















        '<DataObjectMethod(DataObjectMethodType.Select, True)> _
        'Public Shared Function GetItemsRequerimientoPendientes(ByVal SC As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, txtBuscar As String) As Object
        '    Return GetItemsRequerimientoPendientes(SC, startRowIndex, maximumRows, "", "", #1/1/1900#, #1/18/2100#)
        'End Function



        




        Public Shared Function GetList_Count(ByVal SC As String, Optional txtBuscar As String = "", Optional cmbBuscarEsteCampo As String = "", Optional fDesde As Date = #1/1/1900#, Optional fHasta As Date = #1/1/2100#) As Integer '   List(Of DataRow) As Integer 'es importante que sea un Integer y no un Long
            Dim i As Long = EntidadManager.ExecDinamico(SC, "select count(*) from Pedidos").Rows(0).Item(0)
            Return i
        End Function



        



        Public Shared Function GetTotalNumberOfRMs(ByVal SC As String) As Integer
            Return GetStoreProcedureTop1(SC, "wRequerimientos_TTpaginadoTotalCount").Item(0)
        End Function

        






        

      

    End Class



End Namespace