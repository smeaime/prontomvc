Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Configuration
'Imports System.Linq   '"namespace or type specified in ... doesn't contain any " -Sorry Linq is only available in .net 3.5 http://forums.asp.net/t/1332780.aspx  Advanced Compile Options
Imports ADODB.DataTypeEnum
Imports System.Diagnostics
Imports System.IO
Imports Excel = Microsoft.Office.Interop.Excel


Imports System.Linq
Imports System.Data.SqlClient
Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging
Imports DocumentFormat.OpenXml.Wordprocessing
Imports OpenXmlPowerTools



Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class ComparativaManager
        Inherits ServicedComponent

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String, Optional ByVal IdObra As Integer = -1, Optional ByVal TipoFiltro As String = "", Optional ByVal IdProveedor As Integer = -1) As ComparativaList

            Dim Lista As ComparativaList = ComparativaDB.GetList(SC)

            If Lista Is Nothing Then Return Nothing



            'metodo 1: borro sobre la lista original
            Dim lstBorrar As New List(Of Integer)

            'metodo 2: hago una segunda lista sobre la que copio los objetos filtrados
            Dim Lista2 As New ComparativaList
            Try
                For Each cp As Comparativa In Lista
                    'If IIf(IdObra = -1, True, cp.IdObra = IdObra) And 
                    'If IIf(IdProveedor = -1, True, cp.Proveedor = IdProveedor) Then

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
                            If iisNull(cp.ConfirmadoPorWeb, "NO") = "SI" And iisNull(cp.IdAprobo, 0) = 0 Then
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

                    'End If
                Next
            Catch ex As Exception
                Debug.Print(ex.Message)
                Throw New ApplicationException("Error en la grabacion " + ex.Message, ex)
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
                ds = GeneralDB.TraerDatos(SC, "wComparativas_T", -1)
            Else
                Try
                    ds = GeneralDB.TraerDatos(SC, "wComparativas_TX" & TX)
                Catch ex As Exception
                    ds = GeneralDB.TraerDatos(SC, "Comparativas_TX" & TX)
                End Try
            End If


            ds.Tables(0).Columns.Add(dc)
            Return ds
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


            ds = GeneralDB.TraerDatos(SC, "wComparativas_T", -1)

            'Try
            '    ds = GeneralDB.TraerDatos(SC, "wComparativas_T", -1)
            'Catch ex As Exception
            '    ds = GeneralDB.TraerDatos(SC, "Comparativas_T", -1)
            'End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdComparativa").ColumnName = "Id"
                '.Columns("Numero").ColumnName = "Numero"
                '.Columns("FechaRequerimiento").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
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
                ds = GeneralDB.TraerDatos(SC, "wComparativas_TX" & TX, Parametros)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Comparativas_TX" & TX, Parametros)
            End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return ComparativaDB.GetList_fm(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Comparativa
            Return GetItem(SC, id, False)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, ByVal getComparativaDetalles As Boolean) As Comparativa
            Dim myComparativa As Comparativa
            myComparativa = ComparativaDB.GetItem(SC, id)
            If Not (myComparativa Is Nothing) AndAlso getComparativaDetalles Then
                myComparativa.Detalles = ComparativaItemDB.GetList(SC, id)
            End If
            Return myComparativa
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As ComparativaItemList
            Return ComparativaItemDB.GetList(SC, id)
        End Function





        Public Const kMaximoSubnumeroDePresupuestoAceptable As Integer = 12 'por ahora, como la grilla de comparativa es estatica y estoy usando el subnumero como columna, estoy frito
        Public Const ColumnasFijas = 2

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItemsParaGrilla(ByVal SC As String, ByVal id As Integer) As DataTable
            Dim myComparativa As Comparativa = GetItem(SC, id, True)
            GetListItemsParaGrilla = GUI_DeDetalleAGrilla(SC, myComparativa, False)

            'esta funcion devuelve la misma grilla simplificada para los listados, donde aparece anidada en cada renglon
            With GetListItemsParaGrilla
                '.Columns.Remove("Id") 'no puedo porque es la clave principal...
                .Columns.Remove("Item")
                .Columns.Remove("M1") 'no empieza desde cero, porque el indice es el subnumero del presupuesto
                .Columns.Remove("M2")
                .Columns.Remove("M3")
                .Columns.Remove("M4")
                .Columns.Remove("M5")
                .Columns.Remove("M6")
                .Columns.Remove("M7")
                .Columns.Remove("M8")
                .Columns.Remove("M9")
                .Columns.Remove("M10")
                .Columns.Remove("M11")
                .Columns.Remove("M12") 'kMaximoSubnumeroDePresupuestoAceptable
                .Columns.Remove("Total1")
                .Columns.Remove("Total2")
                .Columns.Remove("Total3")
                .Columns.Remove("Total4")
                .Columns.Remove("Total5")
                .Columns.Remove("Total6")
                .Columns.Remove("Total7")
                .Columns.Remove("Total8")
                .Columns.Remove("Total9")
                .Columns.Remove("Total10")
                .Columns.Remove("Total11")
                .Columns.Remove("Total12") 'kMaximoSubnumeroDePresupuestoAceptable
                .Columns.Remove("ColumnaConMenorPrecioDeLaFila")

                For c As Integer = .Columns.Count - 1 To 0 Step -1
                    If .Rows.Count < 1 OrElse iisNull(.Rows(0).Item(c), "") = "" Then 'menor que 2? supongo que es menor que 1, porque el nombre no viene en la row=0
                        Try
                            .Columns.RemoveAt(c)
                        Catch x As Exception
                        End Try
                    End If
                Next

                Try
                    .Columns("Producto").SetOrdinal(1) 'pongo la columna del producto al principio
                Catch ex As Exception
                End Try



                'como pongo los nombres de los proveedores?
                If myComparativa.Detalles IsNot Nothing Then
                    Dim p As Pronto.ERP.BO.ComparativaItem

                    For i As Integer = 1 To kMaximoSubnumeroDePresupuestoAceptable
                        Dim tempi = i
                        p = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)
                        Try
                            'Lo saco por problema de performance
                            If p IsNot Nothing Then .Columns("Precio" & i).ColumnName = p.ProveedorDelPresupuesto 'PresupuestoManager.GetItem(SC, p.IdPresupuesto).Proveedor

                        Catch x As Exception
                            'puede darse que se repita un titulo, y esssplota
                        End Try
                    Next

                End If
            End With




            Return GetListItemsParaGrilla
        End Function


        '///////////////////////////////////
        Public Class xTipo
            Public IdArticulo As Integer = -1
            Public Articulo As String = String.Empty
            Public Cantidad As Integer = 0
        End Class

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItemsArticulosDistintos(ByVal SC As String, ByVal id As Integer) As IEnumerable(Of xTipo)
            'LINQ http://www.elguille.info/colabora/2008/jpa_LINQVBNet.htm
            'Qué demonios devuelve esto? http://stackoverflow.com/questions/496195/
            'Anonymous Types (usando 'select new')
            'http://odetocode.com/blogs/scott/archive/2008/03/25/and-equality-for-all-anonymous-types.aspx
            'http://msdn.microsoft.com/en-us/library/bb384767.aspx
            'Pero no podes devolver un tipo anonimo!!!! (o mejor dicho, no debes)
            'http://msmvps.com/blogs/jon_skeet/archive/2009/01/09/horrible-grotty-hack-returning-an-anonymous-type-instance.aspx

            '101 LINQ samples
            'http://msdn.microsoft.com/en-us/vbasic/bb688088.aspx

            'Return (From p  In ComparativaItemDB.GetList(SC, id) Select New x ( p.Articulo, p.IdArticulo, p.Cantidad) )..Distinct
            'Return (From p In ComparativaItemDB.GetList(SC, id) Select New xTipo(p.Articulo, p.IdArticulo, p.Cantidad)).Distinct

            'Dim query = (From p In ComparativaItemDB.GetList(SC, id) Select p.IdArticulo, p.Articulo, p.Cantidad) '.Distinct
            'Dim lista = query.ToList() 'http://msdn.microsoft.com/en-us/vbasic/bb737905.aspx#tolist
            'Return query.ToList()

        End Function
        '//////////////////////////////////



        <DataObjectMethod(DataObjectMethodType.Update, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myComparativa As Comparativa) As Integer


            'Dim myTransactionScope As TransactionScope = New TransactionScope
            Try
                Dim ComparativaId As Integer = ComparativaDB.Save(SC, myComparativa)
                'For Each myComparativaItem As ComparativaItem In myComparativa.Detalles
                '    myComparativaItem.IdComparativa = ComparativaId
                '    ComparativaItemDB.Save(myComparativaItem)
                'Next
                myComparativa.Id = ComparativaId




                '//////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////
                'Mandar mails
                '//////////////////////////////////////////////////////////////
                'Try
                '    If myComparativa.ConfirmadoPorWeb = "SI" Then
                '        Dim Para As String
                '        Para = EmpleadoManager.GetItem(SC, myComparativa.IdComprador).Email
                '        If Not MandaEmail(Para, "Respuesta a Solicitud N°" & myComparativa.Numero & "/" & myComparativa.SubNumero, "El proveedor " & ProveedorManager.GetItem(SC, myComparativa.IdProveedor).RazonSocial & " respondió al Comparativa N°" & myComparativa.Numero & "/" & myComparativa.SubNumero, , ConfigurationManager.AppSettings("SmtpServer"), ConfigurationManager.AppSettings("SmtpUser"), ConfigurationManager.AppSettings("SmtpPass")) Then
                '        End If

                '        'tambien mandar otro mail si cerraron todos 

                '        If TodosRespondidos(SC, myComparativa.Numero) Then
                '            Para = EmpleadoManager.GetItem(SC, myComparativa.IdComprador).Email
                '            If Not MandaEmail(Para, "Respuesta a Solicitud N°" & myComparativa.Numero & " Completa", _
                '                    "Todas las solicitudes del Comparativa N°" & myComparativa.Numero & " han sido respondidos", , _
                '                    ConfigurationManager.AppSettings("SmtpServer"), _
                '                    ConfigurationManager.AppSettings("SmtpUser"), _
                '                    ConfigurationManager.AppSettings("SmtpPass")) Then
                '            End If
                '        End If

                '    End If
                'Catch ex As Exception
                '    Debug.Print("Error al mandar mail")
                'End Try

                '//////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////






                'myTransactionScope.Complete()
                'ContextUtil.SetComplete()
                Return ComparativaId
            Catch ex As Exception
                'ContextUtil.SetAbort()
                Debug.Print(ex.Message)
                Return -1
            Finally
                'CType(myTransactionScope, IDisposable).Dispose()
            End Try
            Return myComparativa.Id
        End Function


        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myComparativa As Comparativa) As Boolean
            Return ComparativaDB.Delete(SC, myComparativa.Id)
        End Function


        Private Shared Function TodosRespondidos(ByVal SC As String, ByVal NumeroComparativa As Integer) As Boolean 'Lo que diferencia a los Comparativas del mismo origen es el "Subnumero" ("Orden" en el ABM de Pronto)
            Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Comparativas", "TX_PorNumero", NumeroComparativa)
            If ds.Tables(0).Rows.Count > 0 Then
                For Each dr As Data.DataRow In ds.Tables(0).Rows
                    If iisNull(dr.Item("ConfirmadoPorWeb"), "NO") = "NO" Then Return False
                Next
            End If
            Return True
        End Function



        Public Shared Function IsValid(ByVal myComparativa As Comparativa) As Boolean

            Dim eliminados As Integer
            'verifico el detalle
            If myComparativa.Detalles IsNot Nothing Then
                For Each det As ComparativaItem In myComparativa.Detalles
                    If det.IdArticulo = 0 Then 'verifico que no pase un renglon en blanco
                        det.Eliminado = True
                    End If
                    If det.Eliminado Then eliminados = eliminados + 1
                Next

                If myComparativa.Detalles.Count = eliminados Or myComparativa.Detalles.Count = 0 Then
                    'Return False
                End If
            End If

            Return True
        End Function


        Sub DeDetalleAGrillaDLL(ByVal myComparativa As Pronto.ERP.BO.Comparativa)

            'Dim tab As DataTable
            'tab = ComparativaManager.GUI_DeDetalleAGrilla(SC, myComparativa)
            'gvCompara.DataSource = tab

            ''mPresups = From o In myComparativa.Detalles Select New With {Key o.SubNumero} Distinct.Count()

            'gvCompara.DataBind() 'fijate que este puesto el autogeneratecolumns


            ''escondo las columnas de la grilla
            'If myComparativa.Detalles IsNot Nothing Then
            '    For i = 1 To ComparativaManager.kMaximoSubnumeroDePresupuestoAceptable 'myComparativa.Detalles.Count - 1
            '        Dim p As Pronto.ERP.BO.ComparativaItem
            '        Dim tempi = i
            '        p = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)
            '        If p Is Nothing Then
            '            'http://social.msdn.microsoft.com/Forums/en-US/wpf/thread/30b7ed89-2ae1-451f-922a-b82078129a0c
            '            gvCompara.Columns.Item(i + 2).Visible = False '2 columnas fijas
            '        Else
            '            gvCompara.Columns.Item(i + 2).Visible = True
            '            'gvPie.Columns(i + 1).Width = gvCompara.Columns(i + 2).width
            '        End If
            '    Next
            'End If




        End Sub


        Private Function ImpresionDeComparativaPorDLLconXML(ByVal myComparativa As Pronto.ERP.BO.Comparativa, SC As String, Session As Object) As String 'Aunque la comparativa tiene plantilla, no llena los datos sola (de hecho, necesita de la gui de pronto)

            'debug:
            Debug.Print(Session("glbPathPlantillas"))
            'Session("glbPathPlantillas")="\\192.168.66.2\DocumentosPronto\Plantillas"


            'Dim xlt As String = Session("glbPathPlantillas") & "\Comparativa_" & session(SESSIONPRONTO_NombreEmpresa) & ".xlt" '"C:\ProntoWeb\Proyectos\Pronto\Documentos\ComprasTerceros.xlt"
            Dim xlt As String = Session("glbPathPlantillas") & "\Comparativa.xlt" '"C:\ProntoWeb\Proyectos\Pronto\Documentos\ComprasTerceros.xlt"
            Dim output As String = Session("glbPathPlantillas") & "\archivo.xls" 'no funciona bien si uso el raíz





            Dim MyFile1 As New FileInfo(xlt)


            Dim tab = ComparativaManager.GUI_DeDetalleAGrilla(SC, myComparativa, True)
            Dim gvcompara = tab
            Dim tabpie = TraerPieDLL(SC, myComparativa)

            '///////////////////////////////////////////
            '///////////////////////////////////////////



            Dim oEx As SpreadsheetDocument 'As Excel.Application
            'Dim oBooks As Excel.Workbooks 'haciendolo así, no queda abierto el proceso en el servidor http://support.microsoft.com/?kbid=317109
            Dim oBook As Object ' As Spreadsheet.Workbook



            oEx = SpreadsheetDocument.Open(xlt, True)
            Try

                Dim oAp
                Dim oRsPre As ADODB.Recordset
                Dim oRsEmp As ADODB.Recordset
                Dim i As Integer, cl As Integer, cl1 As Integer, fl As Integer
                Dim mvarPresu As Long, mvarSubNum As Long
                Dim mvarFecha As Date
                Dim mvarConfecciono As String, mvarAprobo As String, mvarMPrevisto As String, mvarMCompra As String, mvarMoneda As String
                Dim mvarLibero As String
                Dim mvarPrecioIdeal As Double, mvarPrecioReal As Double
                Dim mCabecera

                'oAp = CrearAppCompronto(SC)

                Dim desplaz = 10

                With myComparativa
                    mvarPresu = .Numero
                    mvarFecha = .Fecha
                    If IsNull(.IdConfecciono) Then
                        mvarConfecciono = ""
                    Else
                        mvarConfecciono = EmpleadoManager.GetItem(SC, .IdConfecciono).Nombre
                    End If
                    If iisNull(.IdAprobo, 0) = 0 Then
                        mvarAprobo = ""
                    Else
                        mvarAprobo = EmpleadoManager.GetItem(SC, .IdAprobo).Nombre
                    End If
                    If IsNull(.MontoPrevisto) Then
                        mvarMPrevisto = ""
                    Else
                        mvarMPrevisto = .MontoPrevisto 'Format(.MontoPrevisto, "Fixed")
                    End If
                    If IsNull(.MontoParaCompra) Then
                        mvarMCompra = ""
                    Else
                        mvarMCompra = .MontoParaCompra ' Format(.MontoParaCompra, "Fixed")
                    End If
                End With



                'oEx.Visible = False
                'oBooks = oEx.Workbooks
                'oBook = oEx.AddWorkbookPart(xlt)
                With oBook
                    'oEx.DisplayAlerts = False



                    With .ActiveSheet

                        .Name = "Comparativa"

                        cl1 = 0
                        For cl = 1 To gvcompara.Columns.Count - 1

                            cl1 = cl1 + 1
                            Dim subnumero As Integer = Int((cl1 - 3) / 2)

                            For fl = 0 To tab.Rows.Count - 1 + 7 + 1 '7 son los renglones adicionales del pie




                                If fl = 0 Then
                                    '////////////////////////////////////////////
                                    '////////////////////////////////////////////
                                    'Es la primera fila, le encajo los titulos
                                    '////////////////////////////////////////////
                                    '////////////////////////////////////////////

                                    'Ampliar altura de fila de cabeceras de columna
                                    If cl1 > 4 Then
                                        If cl1 Mod 2 = 1 Then
                                            'Dim p = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = subnumero) 'uso tempi por lo del lambda en el find
                                            'If p Is Nothing Then Continue For
                                            '.Cells(fl + 7, cl1) = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Proveedor

                                            '.Cells(fl + 7, cl1).Font.Bold = True
                                            '.Cells(fl + 9, cl1) = "Unitario "
                                            '.Cells(fl + 9, cl1 + 1) = "Total "
                                            '.Range(oEx.Cells(fl + 7, cl1), oEx.Cells(fl + 7, cl1 + 1)).Select()
                                            'With oEx.Selection
                                            '    .HorizontalAlignment = Excel.Constants.xlCenter
                                            '    .VerticalAlignment = Excel.Constants.xlCenter
                                            '    .WrapText = True
                                            '    .Orientation = 0
                                            '    .AddIndent = False
                                            '    .IndentLevel = 0
                                            '    .ShrinkToFit = False
                                            '    .MergeCells = True
                                            'End With
                                            '.Range(oEx.Cells(fl + 8, cl1), oEx.Cells(fl + 8, cl1 + 1)).Select()
                                            'With oEx.Selection
                                            '    .HorizontalAlignment = Excel.Constants.xlCenter
                                            '    .VerticalAlignment = Excel.Constants.xlCenter
                                            '    .WrapText = True
                                            '    .Orientation = 0
                                            '    .AddIndent = False
                                            '    .IndentLevel = 0
                                            '    .ShrinkToFit = False
                                            '    .MergeCells = True
                                            'End With
                                            'oEx.ActiveCell.FormulaR1C1 = "Precio"
                                        End If
                                    Else
                                        'cosas que voy agregandole al original de edu para adaptarlo
                                        Select Case cl1
                                            Case 1
                                                .Cells(fl + 7, cl1) = "Item"
                                            Case 2
                                                .Cells(fl + 7, cl1) = "Producto"
                                            Case 3
                                                .Cells(fl + 7, cl1) = "Cantidad"
                                            Case 4
                                                .Cells(fl + 7, cl1) = "Unidad"
                                        End Select
                                    End If
                                ElseIf fl > 0 And fl < tab.Rows.Count + 1 Then
                                    '////////////////////////////////////////////
                                    '////////////////////////////////////////////
                                    'NO es la primera fila, es un renglon comun 
                                    '////////////////////////////////////////////
                                    '////////////////////////////////////////////

                                    'If gvCompara.row = gvCompara.Rows - 2 Then
                                    'rchObservacionesItems.TextRTF = gvCompara.Text
                                    '.Cells(fl + 9, cl1) = rchObservacionesItems.Text
                                    'Else
                                    If cl1 > 4 And cl1 Mod 2 = 1 Then
                                        .Cells(fl + 9, cl1) = tab.Rows(fl - 1).Item("Precio" & subnumero)
                                        .Cells(fl + 9, cl1 + 1) = tab.Rows(fl - 1).Item("Total" & subnumero)
                                    Else
                                        Select Case cl1
                                            Case 1
                                                .Cells(fl + 9, cl1) = tab.Rows(fl - 1).Item("Item")
                                            Case 2
                                                .Cells(fl + 9, cl1) = tab.Rows(fl - 1).Item("Producto")
                                            Case 3
                                                .Cells(fl + 9, cl1) = tab.Rows(fl - 1).Item("Cantidad")
                                            Case 4
                                                .Cells(fl + 9, cl1) = tab.Rows(fl - 1).Item("Unidad")
                                        End Select
                                    End If
                                    '& (iisNull(tab.Rows(fl).Item("Precio" & cl1 - 4), 0) * tab.Rows(fl).Item("Cantidad"))
                                    'End If

                                Else
                                    '////////////////////////////////////////////
                                    '////////////////////////////////////////////
                                    'es una fila del pie
                                    '////////////////////////////////////////////
                                    '////////////////////////////////////////////
                                    If cl1 > 4 And cl1 Mod 2 = 1 Then
                                        'valor
                                        Dim p = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = subnumero) 'uso tempi por lo del lambda en el find
                                        If p Is Nothing Then Continue For
                                        Debug.Print(tabpie.Rows(fl - tab.Rows.Count - 1).Item(subnumero))
                                        .Cells(fl + desplaz, cl1 + 1) = tabpie.Rows(fl - tab.Rows.Count - 1).Item(subnumero)
                                    Else
                                        If cl1 = 4 Then
                                            'titulo
                                            Select Case fl - tab.Rows.Count
                                                Case 0
                                                    .Cells(fl + desplaz + 1, cl1) = "Subtotal"
                                                Case 1
                                                    .Cells(fl + desplaz + 1, cl1) = "Bonificacion"
                                                Case 2
                                                    .Cells(fl + desplaz + 1, cl1) = "TOTAL"
                                                Case 3
                                                    .Cells(fl + desplaz + 1, cl1) = "Plazo de entrega"
                                                Case 4
                                                    .Cells(fl + desplaz + 1, cl1) = "Condicion de pago"
                                                Case 5
                                                    .Cells(fl + desplaz + 1, cl1) = "Observaciones"
                                                Case 6
                                                    .Cells(fl + desplaz + 1, cl1) = "Solicitud de cotizacion nro."
                                            End Select
                                        End If
                                    End If
                                End If




                                '//////////////////////////////////////////////
                                'Modifica formato de celdas con precios comparados
                                If cl1 > 4 And fl > 0 And fl <= tab.Rows.Count Then 'And IsNumeric(gvCompara.Text) Then
                                    If iisNull(tab.Rows(fl - 1).Item("M" & subnumero), False) Then
                                        .Cells(fl + 9, cl1).Font.Bold = True
                                    End If

                                    'If fl >= gvCompara.Rows - 7 Then
                                    .Cells(fl + 9, cl1).NumberFormat = "#,##0.00"
                                    'Else
                                    '.Cells(fl + 9, cl1).NumberFormat = "#,##0.0000"
                                    'End If
                                End If
                                '//////////////////////////////////////////////


                            Next
                        Next



                        '//////////////////////////////////////////////
                        'Informacion en celdas sueltas
                        '//////////////////////////////////////////////
                        .Cells(2, 5) = "COMPARATIVA Nro. : " & mvarPresu
                        .Cells(3, 5) = "FECHA : " & mvarFecha
                        .Cells(4, 5) = "Comprador/a : " & mvarConfecciono
                        '.Cells(5, 2) = "Obra/s : " & txtObras.Text
                        '.Cells(6, 2) = "RM / LA : " & txtNumeroRequerimiento.Text

                        .Cells(gvcompara.Rows.Count + 13, 1).Select()
                        .Rows(gvcompara.Rows.Count + 13).RowHeight = 25
                        .Cells(gvcompara.Rows.Count + 13, 1) = "Obs.Grales. : " & myComparativa.Observaciones

                        .Cells(gvcompara.Rows.Count + 14, 1).Select()
                        .Rows(gvcompara.Rows.Count + 14).RowHeight = 10
                        .Cells(gvcompara.Rows.Count + 14, 1) = "Monto previsto : " & myComparativa.MontoPrevisto

                        .Cells(gvcompara.Rows.Count + 15, 1).Select()
                        .Rows(gvcompara.Rows.Count + 15).RowHeight = 10
                        .Cells(gvcompara.Rows.Count + 15, 1) = "Monto para compra : " & myComparativa.MontoParaCompra
                        '//////////////////////////////////////////////
                        '//////////////////////////////////////////////



                        '//////////////////////////////////////////////
                        '//////////////////////////////////////////////
                        '//////////////////////////////////////////////

                        mvarLibero = ""
                        If iisNull(myComparativa.IdAprobo, 0) <> 0 Then
                            mvarLibero = "" & EmpleadoManager.GetItem(SC, myComparativa.IdAprobo).Nombre
                            If Not IsNull(myComparativa.FechaAprobacion) Then
                                mvarLibero = mvarLibero & "  " & myComparativa.FechaAprobacion
                            End If
                        End If

                        'oEx.Rows(gvcompara.Rows.Count + 6).RowHeight = 25
                        'oEx.Rows(gvcompara.Rows.Count + 7).RowHeight = 25

                    End With





                    'oEx.Cells(fl + desplaz - 6, 4) = "Subtotal"
                    'oEx.Cells(fl + 5, 3) = "Bonificacion"
                    'oEx.Cells(fl + 6, 3) = "TOTAL"





                    '                   .SaveAs(output, 56) '= xlExcel8 (97-2003 format in Excel 2007-2010, xls) 'no te preocupes, que acá solo llega cuando terminó de ejecutar el script de excel

                    'oEx.DisplayAlerts = True
                End With

            Catch ex As Exception
            Finally
            End Try



            Return output


        End Function

        Public Shared Function TraerPieDLL(ByVal SC As String, ByVal myComparativa As Pronto.ERP.BO.Comparativa) As DataTable

            'Dim oRsFlex As ADODB.Recordset
            Dim oRs As DataTable
            'Dim oFld As ADODB.Field
            Dim Campo As String, CampoObs As String, CampoTot As String, mvarProv As String
            Dim mvarObservaciones As String, mvarPlazo As String, mvarCond As String
            Dim mvarArticulo As String, mvarArticuloConObs As String, mvarArticuloSinObs As String
            Dim mvarUnidad As String, mvarMoneda As String, mvarPrimerPresupuesto As String
            Dim mvarCol As Integer, i As Integer, mvarItem As Integer
            Dim mOrigenDescripcion As Integer
            Dim CampoExistente As Boolean, RegistroExistente As Boolean, FlagPrimerPresupuesto As Boolean
            Dim mvarIdPre As Long, mvarPresu As Long, mvarSubNum As Long, mvarIdCond As Long
            Dim mvarIdMoneda As Long
            Dim mvarFecha As Date
            Dim mvarCantidad As Double, mvarPrecio As Double, mvarBonificacionPorItem As Double
            Dim mvarCotizacionMoneda As Double


            Dim tab As Data.DataTable = New Data.DataTable()
            'COLUMNAS
            tab.Columns.Add("   ")
            tab.Columns.Add("prov1")
            tab.Columns.Add("prov2")
            tab.Columns.Add("prov3")
            tab.Columns.Add("prov4")
            tab.Columns.Add("prov5")
            tab.Columns.Add("prov6")
            tab.Columns.Add("prov7")
            tab.Columns.Add("prov8")
            tab.Columns.Add("prov9")
            tab.Columns.Add("prov10")
            tab.Columns.Add("prov11")
            tab.Columns.Add("prov12")



            ' RENGLONES DEL PIE
            ' "Subtotal"
            ' "Bonificacion"
            ' "TOTAL"
            ' "Plazo de entrega"
            ' "Condicion de pago"
            ' "Observaciones"
            ' "Solicitud de cotizacion nro."


            'If tab.Rows.Count > 0 Then

            Dim mvarSubtotal(100), mvarBonificacion(100), mvarIVA(100), mvarTotal(100), mvarPorcIva1(100), mvarPorcIva2(100) As Double
            Dim mPorcIva1 As Double

            With tab

                'Reinicio
                mPorcIva1 = 0
                For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                    mvarSubtotal(i) = 0
                    mvarBonificacion(i) = 0
                    mvarIVA(i) = 0
                    mvarTotal(i) = 0
                    mvarPorcIva1(i) = 0
                    mvarPorcIva2(i) = 0
                Next

                Dim r As DataRow

                '///////////////////////////////////////
                '///////////////////////////////////////
                '///////////////////////////////////////
                'exploro la tabla, y calculo los totales
                '///////////////////////////////////////
                '///////////////////////////////////////
                '///////////////////////////////////////
                Dim t = GUI_DeDetalleAGrilla(SC, myComparativa)

                For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                    Dim tempi = i
                    Dim p As ComparativaItem = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)
                    If p Is Nothing Then Continue For
                    mvarPresu = PresupuestoManager.GetItem(SC, p.IdPresupuesto, True).Numero
                    mvarSubNum = i
                    oRs = EntidadManager.GetListTX(SC, "Presupuestos", "TX_BonificacionesPorNumero", mvarPresu, mvarSubNum).Tables(0)
                    If oRs.Rows.Count > 0 Then
                        If Not IsNull(oRs(0).Item("Bonificaciones")) Then
                            mvarBonificacion(i) = oRs(0).Item("Bonificaciones")
                        End If

                    End If
                    For Each d As DataRow In t.Rows
                        mvarSubtotal(i) = mvarSubtotal(i) + iisNull(d.Item("Cantidad"), 0) * iisNull(d.Item("Precio" & i), 0)
                    Next
                Next


                '///////////////////////////////////////
                '///////////////////////////////////////
                '///////////////////////////////////////
                '///////////////////////////////////////
                'agrego los renglones
                '///////////////////////////////////////
                '///////////////////////////////////////
                '///////////////////////////////////////

                With r

                    r = tab.NewRow() 'los indices de IdArticulo y Cantidad, truchados para estos renglones adicionales (mmmmm)
                    r.Item(0) = "Subtotal"
                    For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                        r.Item(i) = "" & FormatVB6(mvarSubtotal(i), "#,##0.00")
                    Next
                    tab.Rows.Add(r)


                    r = tab.NewRow()
                    r.Item(0) = "Bonificacion"
                    For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                        Dim tempi = i
                        Dim p As ComparativaItem = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)
                        If p Is Nothing Then Continue For
                        mvarPresu = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Numero
                        mvarSubNum = i
                        oRs = EntidadManager.GetListTX(SC, "Presupuestos", "TX_PorNumero", mvarPresu, mvarSubNum).Tables(0)
                        If oRs.Rows.Count > 0 Then
                            mvarPorcIva1(i) = IIf(IsNull(oRs(0).Item("PorcentajeIva1")), 0, oRs(0).Item("PorcentajeIva1"))
                            mvarPorcIva2(i) = IIf(IsNull(oRs(0).Item("PorcentajeIva2")), 0, oRs(0).Item("PorcentajeIva2"))
                            If mvarPorcIva1(i) > 0 Then
                                mPorcIva1 = mvarPorcIva1(i)
                            End If
                            If Not IsNull(oRs(0).Item("Bonificacion")) Then
                                If mvarBonificacion(i) = 0 Then r.Item(i) = "" & oRs(0).Item("Bonificacion") & "%"
                                mvarBonificacion(i) = mvarBonificacion(i) + Math.Round(mvarSubtotal(i) * oRs(0).Item("Bonificacion") / 100, 2)
                            End If
                        End If

                        r.Item(i) = mvarBonificacion(i) * -1
                    Next
                    tab.Rows.Add(r)

                    r = tab.NewRow()
                    r.Item(0) = "TOTAL"
                    For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                        mvarTotal(i) = mvarSubtotal(i) - mvarBonificacion(i) + mvarIVA(i)
                        r.Item(i) = "" & FormatVB6(mvarTotal(i), "#,##0.00")
                    Next
                    tab.Rows.Add(r)


                    r = tab.NewRow()
                    r.Item(0) = "Plazo de entrega"
                    For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                        Dim tempi = i
                        Dim p As ComparativaItem = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)
                        If p Is Nothing Then Continue For
                        mvarPresu = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Numero
                        mvarSubNum = i
                        oRs = EntidadManager.GetListTX(SC, "Presupuestos", "TX_PorNumero", mvarPresu, mvarSubNum).Tables(0)
                        If oRs.Rows.Count > 0 Then
                            mvarPlazo = IIf(IsNull(oRs(0).Item("PlazoEntrega")), "", oRs(0).Item("PlazoEntrega"))
                        End If
                        r.Item(i) = mvarPlazo
                    Next
                    tab.Rows.Add(r)


                    r = tab.NewRow()
                    r.Item(0) = "Condicion de pago"
                    For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                        Dim tempi = i
                        Dim p As ComparativaItem = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)
                        If p Is Nothing Then Continue For
                        mvarPresu = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Numero
                        mvarSubNum = i
                        oRs = EntidadManager.GetListTX(SC, "Presupuestos", "TX_PorNumero", mvarPresu, mvarSubNum).Tables(0)
                        If oRs.Rows.Count > 0 Then
                            If iisNull(oRs(0).Item("DetalleCondicionCompra")) = "" Then
                                mvarIdCond = oRs(0).Item("IdCondicionCompra")

                                oRs = EntidadManager.GetListTX(SC, "CondicionesCompra", "TX_PorId", mvarIdCond).Tables(0)
                                If oRs.Rows.Count > 0 Then
                                    mvarCond = oRs(0).Item("Descripcion")
                                End If
                            Else
                                mvarCond = oRs(0).Item("DetalleCondicionCompra")
                            End If
                        End If

                        r.Item(i) = mvarCond
                    Next
                    tab.Rows.Add(r)


                    r = tab.NewRow()
                    r.Item(0) = "Observaciones"
                    For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                        Dim tempi = i
                        Dim p As ComparativaItem = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)
                        If p Is Nothing Then Continue For
                        mvarPresu = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Numero
                        mvarSubNum = i
                        oRs = EntidadManager.GetListTX(SC, "Presupuestos", "TX_PorNumero", mvarPresu, mvarSubNum).Tables(0)
                        If oRs.Rows.Count > 0 Then
                            mvarObservaciones = IIf(IsNull(oRs(0).Item("Observaciones")), "", oRs(0).Item("Observaciones"))
                        End If

                        r.Item(i) = Mid(mvarObservaciones, 1, 1000)
                    Next
                    tab.Rows.Add(r)


                    r = tab.NewRow()
                    r.Item(0) = "Solicitud de cotizacion nro."
                    For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                        Dim tempi = i
                        Dim p As ComparativaItem = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)
                        If p Is Nothing Then Continue For
                        mvarPresu = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Numero
                        mvarSubNum = i
                        r.Item(i) = FormatVB6(mvarPresu, "000000") & " / " & FormatVB6(mvarSubNum, "00")
                    Next
                    tab.Rows.Add(r)

                End With
            End With
            'End If
            Return tab
        End Function





        Public Shared Function GUI_DeDetalleAGrilla(ByVal SC As String, ByVal myComparativa As Comparativa, Optional ByVal MarcarMenorPrecio As Boolean = True) As DataTable
            'La comparativa no tiene un detalle en forma de tabla, sino puntos de un cubo. Así que tengo que
            'generar manualmente un DataSource para la grilla (que tiene columnas estáticas)

            '///////////////////////
            'usando LINQ
            '///////////////////////

            'c=cantidad de presupuestos distintos en el detalle
            'myComparativa.Detalles.
            'myComparativa.Detalles.Select("distinct count IdPresupuesto"
            '.Where()
            '.Distinct()


            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            'voy creando las columnas de tabla que usaré como datasource
            Dim tab As Data.DataTable = New Data.DataTable()
            tab.Columns.Add("Id")
            tab.Columns.Add("Cantidad")
            tab.Columns.Add("Item")
            tab.Columns.Add("Producto")
            tab.Columns.Add("Unidad")

            Dim i As Long
            For i = 1 To kMaximoSubnumeroDePresupuestoAceptable 'myComparativa.Detalles.Count - 1
                'tab.Columns.Add(myComparativa.Detalles(i).ToString())
                tab.Columns.Add("Precio" & i)
                tab.Columns.Add("Total" & i)
                tab.Columns.Add("M" & i, System.Type.GetType("System.Boolean"))
                'GridView1.Columns.Add(customField)
            Next
            tab.Columns.Add("ColumnaConMenorPrecioDeLaFila")


            'configuro la PrimaryKey de la tabla
            'ATENCION! Las keys tienen que agregarse al principio de la tabla (no puedo poner columnas entre las dos keys)
            Dim keys(1) As DataColumn
            keys(0) = tab.Columns("Id")
            keys(1) = tab.Columns("Cantidad")
            tab.PrimaryKey = keys
            tab.DefaultView.Sort = "Id" 'necesario


            'debug
            'Return tab

            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            'paso los datos del detalle del comprobante ----> a la datatable
            Dim j As DataRow
            If myComparativa.Detalles IsNot Nothing Then
                For i = 0 To myComparativa.Detalles.Count - 1


                    With myComparativa.Detalles(i)
                        If .SubNumero > kMaximoSubnumeroDePresupuestoAceptable Then Continue For 'por ahora tengo ese límito para los subnumeros

                        Dim Llave() As Object = {.IdArticulo, iisNull(.Cantidad, 0)}
                        'Llave(0) = .IdArticulo
                        'Llave(1) = iisNull(.Cantidad, 0)

                        j = tab.Rows.Find(Llave) 'veo si ya existe un renglon del articulo 
                        If IsNothing(j) Then 'tambien se puede buscar usando tab.Select("CompanyName Like 'A%'")
                            'es nuevo. lo agrego
                            j = tab.Rows.Add(.IdArticulo, iisNull(.Cantidad, 0))
                        Else
                            Debug.Print(.IdArticulo, j.Item("Id"))
                        End If



                        j.Item("Id") = .IdArticulo 'si esto explota porque se repite el ID, quiere decir que lo busco mal
                        'tab.Rows(j).Item("Item") = .
                        Try
                            'Lo saco por problema de performance
                            j.Item("Producto") = .Articulo ' EntidadManager.NombreArticulo(SC, .IdArticulo) & " [" & .IdArticulo & "] " & .Observaciones
                        Catch e As Exception
                        End Try

                        j.Item("Cantidad") = .Cantidad
                        'Lo saco por problema de performance
                        j.Item("Unidad") = .Unidad 'EntidadManager.NombreUnidad(SC, .IdUnidad)


                        'este calculo del precio del item de la comparativa..., debiera estar dentro de su manager
                        Dim mImporte = Val(.Precio)
                        Dim ImporteBonificacion = Math.Round(mImporte * Val(.PorcentajeBonificacion) / 100, 4)
                        Dim ImporteIVA '= Math.Round((mImporte - ImporteBonificacion) * Val(.PorcentajeIVA) / 100, 4)
                        Dim ImporteTotalItem = mImporte - ImporteBonificacion + ImporteIVA


                        Try
                            j.Item("Precio" & .SubNumero) = ImporteTotalItem ' .Precio.ToString()  
                            j.Item("Total" & .SubNumero) = ImporteTotalItem * .Cantidad
                            j.Item("M" & .SubNumero) = IIf(.Estado = "MR", True, False)

                        Catch ex As Exception
                            ErrHandler2.WriteError(ex)
                        End Try



                    End With
                Next
            End If


            If Not MarcarMenorPrecio Then Return tab


            '/////////////////////////////////////////////
            '/////////////////////////////////////////////
            'Busco el menor precio
            For Each j In tab.Rows
                Dim MenorPrecio As Double = 999999999999
                Dim MenorPrecioID As Long = -1
                For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                    If iisNull(j.Item("Precio" & i), 0) < MenorPrecio And iisNull(j.Item("Precio" & i), 0) > 0 Then
                        MenorPrecio = iisNull(j.Item("Precio" & i), 0)
                        MenorPrecioID = i
                    End If
                Next
                j.Item("ColumnaConMenorPrecioDeLaFila") = MenorPrecioID
            Next
            '/////////////////////////////////////////////
            '/////////////////////////////////////////////



            '/////////////////////////////////////////////
            '/////////////////////////////////////////////
            'Agrego info de pie de pagina
            'migrado de ComPronto.DetComparativas.TodosLosRegistrosConFormato()

            'TraerPie(SC, myComparativa, tab)
            '/////////////////////////////////////////////
            '/////////////////////////////////////////////


            Return tab
        End Function




    End Class
End Namespace