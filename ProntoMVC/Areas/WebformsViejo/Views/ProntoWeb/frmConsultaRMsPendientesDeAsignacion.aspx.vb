Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports System
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.IO
Imports System.Web.UI.WebControls
Imports System.Data



Partial Class ProntoWeb_frmConsultaRMsPendientesDeAsignacion
    Inherits System.Web.UI.Page

    Private SC As String

    '///////////////////////////////////
    '///////////////////////////////////
    'load
    '///////////////////////////////////
    '///////////////////////////////////

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        HFSC.Value = GetConnectionString(Server, Session)
        SC = GetConnectionString(Server, Session)
        'HFIdObra.Value = IIf(IsDBNull(session(SESSIONPRONTO_glbIdObraAsignadaUsuario)), -1, session(SESSIONPRONTO_glbIdObraAsignadaUsuario))

        'oTab = Aplicacion.Requerimientos.TraerFiltrado("_PendientesDeAsignacion", DepositosPorUsuario())

    End Sub


    Public Function DepositosPorUsuario() As String

        Dim mAux As String, s As String
        Dim i As Integer, j As Integer
        Dim mVector1, mVector2

        'mAux = BuscarClaveINI("Depositos por usuario para requerimientos pendientes de asignacion")

        's = ""
        'If Len(mAux) > 0 Then
        '    If InStr(1, mAux, "|") > 0 Then
        '        mVector1 = VBA.Split(mAux, "|")
        '        For i = 0 To UBound(mVector1)
        '            mVector2 = VBA.Split(mVector1(i), ",")
        '            If "(" & glbIdUsuario & ")" = mVector2(0) Then
        '                s = mVector2(1)
        '                Exit For
        '            End If
        '        Next
        '    Else
        '        mVector2 = VBA.Split(mAux, ",")
        '        If "(" & glbIdUsuario & ")" = mVector2(0) Then s = mVector2(1)
        '    End If
        'End If

        'DepositosPorUsuario = s

    End Function

    Protected Sub ObjDsFirmas_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjDsFirmas.Selecting
        'e.InputParameters("Parametros") = New String() {""}
    End Sub



    Protected Sub btnMarcar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMarcar.Click
        Dim chkFirmar As CheckBox
        For Each fila As GridViewRow In GVFirmas.Rows
            Select Case fila.RowType
                Case DataControlRowType.DataRow
                    If TypeOf fila.FindControl("CheckBox1") Is CheckBox Then
                        chkFirmar = CType(fila.FindControl("CheckBox1"), CheckBox)
                        chkFirmar.Checked = True
                    End If
            End Select
        Next
    End Sub

    Protected Sub btnDesmarcar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDesmarcar.Click
        Dim chkFirmar As CheckBox
        For Each fila As GridViewRow In GVFirmas.Rows
            Select Case fila.RowType
                Case DataControlRowType.DataRow
                    If TypeOf fila.FindControl("CheckBox1") Is CheckBox Then
                        chkFirmar = CType(fila.FindControl("CheckBox1"), CheckBox)
                        chkFirmar.Checked = False
                    End If
            End Select
        Next
    End Sub


    Function FilasMarcadas() As GridViewRowCollection
        'Dim a As GridViewRowCollection
        'a.Item
        'Dim Fila As GridViewRow
        'Fila.

        'For Each fila As GridViewRow In GVFirmas.Rows
        '    If fila.RowType = DataControlRowType.DataRow AndAlso TypeOf fila.FindControl("CheckBox1") Is CheckBox Then
        '        chkFirmar = CType(fila.FindControl("CheckBox1"), CheckBox)
        '        If chkFirmar.Checked Then
        '            fila.FilasMarcadas()
        '            FilasMarcadas.Item

        '            GVFirmas.
        '        End If
        '    End If
        'Next
    End Function


    Protected Sub btnParaCompras_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnParaCompras.Click

        Dim chkFirmar As CheckBox
        Dim keys(3) As String

        For Each fila As GridViewRow In GVFirmas.Rows
            If fila.RowType = DataControlRowType.DataRow AndAlso TypeOf fila.FindControl("CheckBox1") Is CheckBox Then
                chkFirmar = CType(fila.FindControl("CheckBox1"), CheckBox)
                If chkFirmar.Checked Then
                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////
                    'Codigo extraido de funcion MODaPP.LiberarRMParaCompras()
                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////

                    'mSector = "Compras"
                    'mAux1 = TraerValorParametro2("IdSectorReasignador")
                    'If Not IsNull(mAux1) And IsNumeric(mAux1) Then
                    '    oRs = Aplicacion.Sectores.TraerFiltrado("_PorId", Val(mAux1))
                    '    If oRs.RecordCount > 0 Then mSector = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
                    '    oRs.Close()
                    'End If




                    'La coleccion Grilla.DataKeys(fila.RowIndex).Values.Item(0) tiene las keys de la grilla. 
                    'Para las columnas, usá Grilla.Rows(fila).Cells(col)
                    If IsNumeric(GVFirmas.Rows(fila.RowIndex).Cells(3).Text) And GVFirmas.DataKeys(fila.RowIndex).Values.Item("IdAux4") <> "REC" Then
                        Dim idRM As Integer = GVFirmas.DataKeys(fila.RowIndex).Values.Item("IdAux2")
                        Dim oRM As Pronto.ERP.BO.Requerimiento
                        oRM = RequerimientoManager.GetItem(SC, idRM, True)
                        Dim oDetRM As Pronto.ERP.BO.RequerimientoItem
                        Dim idDetRM As Integer = GVFirmas.DataKeys(fila.RowIndex).Values.Item("IdAux1")
                        'ObjDsFirmas.Select()
                        'List peoples = (List)this.ObjectDataSource1.Select();
                        'return peoples.Find(delegate(People p) {return p.Key == p_key;});


                        oDetRM = oRM.BuscarRenglonPorIdDetalle(idDetRM)
                        oDetRM.IdLiberoParaCompras = session(SESSIONPRONTO_glbIdUsuario)   'mvarIdAutorizo
                        oDetRM.FechaLiberacionParaCompras = Now

                        Dim p As Data.DataRow = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
                        If iisNull(p.Item("ActivarSolicitudMateriales"), "NO") = "SI" Then
                            oDetRM.TipoDesignacion = "CMP"
                        End If

                        RequerimientoManager.Save(SC, oRM)
                    End If



                End If
            End If
        Next

        GVFirmas.DataBind()

    End Sub

    Protected Sub btnGenerarVale_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerarVale.Click


        ''////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////
        ''Codigo extraido de funcion MODaPP.GenerarValesAlmacen()
        ''////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////

        'Dim mvarOK As Boolean
        'Dim mvarIdAutorizo As Long
        'Dim mSector As String
        'Dim mAux1 As Object
        'Dim oRs As adodb.Recordset

        'mSector = "Compras"
        'mAux1 = TraerValorParametro2("IdSectorReasignador")
        'If Not IsNull(mAux1) And IsNumeric(mAux1) Then
        '    oRs = Aplicacion.Sectores.TraerFiltrado("_PorId", Val(mAux1))
        '    If oRs.RecordCount > 0 Then mSector = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
        '    oRs.Close()
        'End If

        's = ""
        'Filas = VBA.Split(StringRequerimientos, vbCrLf)
        'For i = 1 To UBound(Filas)
        '    Columnas = VBA.Split(Filas(i), vbTab)
        '    If i = 1 Then mObra = Columnas(4)
        '    If mObra <> Columnas(4) Then
        '        MsgBox("Hay items con distinta Obra/C.Costos, deben ser iguales", vbExclamation)
        '        Exit Sub
        '    End If
        '    s = s & Columnas(2) & ","
        'Next
        'If Len(s) > 0 Then s = Mid(s, 1, Len(s) - 1)


        ''//////////////////////////////////////////
        ''Muestra un vale de salida para dar de alta. Si lo aprueba, hace la marca a la RM
        ''//////////////////////////////////////////
        'of1 = New frmValesSalida
        'With of1
        '    .DetalleRequerimientos = s
        '    .NivelAcceso = Alto
        '    .Id = -1
        '    .Show(vbModal)
        '    mvarOK = .Ok
        'End With
        'of1 = Nothing
        'If Not mvarOK Then Exit Sub
        ''//////////////////////////////////////////
        ''//////////////////////////////////////////

        Dim Aplicacion = ClaseMigrar.CrearAppCompronto(SC)
        Dim oAp = Aplicacion

        Dim chkFirmar As CheckBox
        Dim keys(3) As String

        For Each fila As GridViewRow In GVFirmas.Rows
            If fila.RowType = DataControlRowType.DataRow AndAlso TypeOf fila.FindControl("CheckBox1") Is CheckBox Then
                chkFirmar = CType(fila.FindControl("CheckBox1"), CheckBox)
                If chkFirmar.Checked Then


                    '///////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////
                    ''Como en ProntoWeb no tengo el ABM de vales, tengo que reemplazar el ABM con codigo
                    'Voy a crear un vale por item de RM, aun cuando esten en la misma RM
                    '///////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////
                    Dim mN As Long

                    Dim oPar = Aplicacion.Parametros.Item(1)
                    With oPar.Registro
                        mN = .Fields("ProximoNumeroValeSalida").Value
                        .Fields("ProximoNumeroValeSalida").Value = mN + 1
                    End With
                    oPar.Guardar()

                    'Encabezado
                    Dim Vale = Aplicacion.ValesSalida.Item(-1)
                    With Vale.Registro
                        .Fields("NumeroValeSalida").Value = mN
                        .Fields("FechaValeSalida").Value = Today
                        .Fields("IdObra").Value = GVFirmas.DataKeys(fila.RowIndex).Values.Item("IdAux3")
                        .Fields("Aprobo").Value = session(SESSIONPRONTO_glbIdUsuario)
                        .Fields("Observaciones").Value = "Creado por ProntoWEB. Generacion de vale desde consulta de RM pendientes, para RM" & GVFirmas.Rows(fila.RowIndex).Cells(1).Text
                    End With

                    'Detalle
                    Dim DetVale = Vale.DetValesSalida.Item(-1)
                    With DetVale.Registro
                        '.Fields("FechaNecesidad").Value = Today + 5

                        Dim oReq = oAp.Requerimientos.Item(GVFirmas.DataKeys(fila.RowIndex).Values.Item("IdAux2"))
                        Dim oDetR = oReq.DetRequerimientos.Item(GVFirmas.DataKeys(fila.RowIndex).Values.Item("IdAux1"))

                        .Fields("IdArticulo").Value = oDetR.Registro.Fields("IdArticulo")   'GVFirmas.DataKeys(fila.RowIndex).Values.Item("IdAux1")
                        .Fields("Cantidad").Value = ProntoFuncionesGenerales.StringToDecimal(GVFirmas.Rows(fila.RowIndex).Cells(3).Text)
                        .Fields("IdUnidad").Value = oDetR.Registro.Fields("IdUnidad") 'GVFirmas.Rows(fila.RowIndex).Cells(1).Text

                        .Fields("IdDetalleRequerimiento").Value = GVFirmas.DataKeys(fila.RowIndex).Values.Item("IdAux1")
                        .Fields("IdEquipoDestino").Value = 0
                        .Fields("Cantidad1").Value = 0
                        .Fields("Cantidad2").Value = 0

                    End With
                    DetVale.Modificado = True


                    Vale.Guardar()
                    'OC1 = Vale.Registro.Fields("IdOrdenCompra").Value
                    Vale = Nothing



                    '//////////////////////////////////////////
                    'hace modificaciones a las RM (creo)
                    '//////////////////////////////////////////
                    'Dim Filas = Split(StringRequerimientos, vbCrLf)
                    'For i = 1 To UBound(Filas)
                    '    Dim Columnas = Split(Filas(i), vbTab)
                    If IsNumeric(GVFirmas.DataKeys(fila.RowIndex).Values.Item("IdAux2")) Then
                        Dim oReq = oAp.Requerimientos.Item(GVFirmas.DataKeys(fila.RowIndex).Values.Item("IdAux2"))
                        Dim oDetR = oReq.DetRequerimientos.Item(GVFirmas.DataKeys(fila.RowIndex).Values.Item("IdAux1"))
                        oDetR.Registro.Fields("Cumplido").Value = "SI"
                        oDetR.Registro.Fields("IdAutorizoCumplido").Value = session(SESSIONPRONTO_glbIdUsuario)
                        oDetR.Registro.Fields("IdDioPorCumplido").Value = session(SESSIONPRONTO_glbIdUsuario)
                        oDetR.Registro.Fields("FechaDadoPorCumplido").Value = Now
                        oDetR.Registro.Fields("ObservacionesCumplido").Value = _
                                       "Generacion de vales de almacen - RM : " & GVFirmas.Rows(fila.RowIndex).Cells(1).Text & " " & _
                                       "item " & GVFirmas.DataKeys(fila.RowIndex).Values.Item("IdAux1")
                        oDetR.Modificado = True
                        Dim oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
                        If Not IsNull(oRs.Fields("ActivarSolicitudMateriales").Value) And _
                              oRs.Fields("ActivarSolicitudMateriales").Value = "SI" Then
                            oDetR.Registro.Fields("TipoDesignacion").Value = "STK"
                            oDetR.Modificado = True
                            oReq.Guardar()  'OJO QUE ESTA COMENTADO ABAJO
                        End If
                        oRs.Close()
                        '         oReq.Guardar
                        oDetR = Nothing
                        oReq = Nothing
                        oRs = Nothing

                        EntidadManager.Tarea(SC, "Requerimientos_ActualizarEstado", GVFirmas.DataKeys(fila.RowIndex).Values.Item("IdAux2"), 0)
                    End If
                    'Next





                End If
            End If
        Next

        oAp = Nothing


        GVFirmas.DataBind()


    End Sub


    Protected Sub btnDarPorCumplido_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDarPorCumplido.Click


        Dim chkFirmar As CheckBox
        Dim keys(3) As String

        For Each fila As GridViewRow In GVFirmas.Rows
            If fila.RowType = DataControlRowType.DataRow AndAlso TypeOf fila.FindControl("CheckBox1") Is CheckBox Then
                chkFirmar = CType(fila.FindControl("CheckBox1"), CheckBox)
                If chkFirmar.Checked Then

                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////
                    'Codigo extraido de funcion frmConsulta2.DarPorCumplido() (hay otro DarPorCumplido en el frmConsultaRMPendientes)
                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////

                    'La coleccion Grilla.DataKeys(fila.RowIndex).Values.Item(0) tiene las keys de la grilla. 
                    'Para las columnas, usá Grilla.Rows(fila).Cells(col)
                    If IsNumeric(GVFirmas.Rows(fila.RowIndex).Cells(3).Text) Then

                        Dim idRM As Integer = GVFirmas.DataKeys(fila.RowIndex).Values.Item("IdAux2")
                        Dim oRM As Pronto.ERP.BO.Requerimiento = RequerimientoManager.GetItem(SC, idRM, True)
                        Dim oDetRM As Pronto.ERP.BO.RequerimientoItem
                        Dim idDetRM As Integer = GVFirmas.DataKeys(fila.RowIndex).Values.Item("IdAux1")
                        'ObjDsFirmas.Select()
                        'List peoples = (List)this.ObjectDataSource1.Select();
                        'return peoples.Find(delegate(People p) {return p.Key == p_key;});


                        oDetRM = oRM.BuscarRenglonPorIdDetalle(idDetRM)
                        oDetRM.Cumplido = "SI"
                        oDetRM.IdAutorizoCumplido = session(SESSIONPRONTO_glbIdUsuario)
                        oDetRM.IdDioPorCumplido = session(SESSIONPRONTO_glbIdUsuario)
                        oDetRM.FechaDadoPorCumplido = Now
                        'oDetRM.ObservacionesCumplido = mObservacion
                        oDetRM.TipoDesignacion = "CMP"

                        RequerimientoManager.Save(SC, oRM)
                        EntidadManager.Tarea(SC, "Requerimientos_ActualizarEstado", idDetRM, 0)
                    End If



                End If
            End If
        Next

        GVFirmas.DataBind()


    End Sub

    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        Rebind()
        'ObjDsFirmas.FilterExpression = "Convert(Numero, 'System.String') LIKE '*" & txtBuscar.Text & "*'"

        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub




    Function GenerarWHERE() As String
        Return "Convert(Req_Nro_, 'System.String') LIKE '*" & txtBuscar.Text & "*'"
    End Function


    Sub Rebind()
        With GVFirmas
            Dim pageIndex = .PageIndex

            'chupo
            'Dim dt As DataTable = EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TX_Pendientes1).Tables(0)
            'Dim dt As DataTable = RequerimientoManager.GetListTXDetallesPendientes(SC).Tables(0) ' EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TX_Pendientes1).Tables(0)
            ObjDsFirmas.FilterExpression = GenerarWHERE()
            Dim dv As DataView = ObjDsFirmas.Select()

            'filtro
            'dt = DataTableWHERE(dt, GenerarWHERE)

            'ordeno
            Dim b As Data.DataView = DataTableORDER(dv.ToTable, "IdDetalleRequerimiento DESC")
            'b.Sort = "IdDetalleRequerimiento DESC"
            ViewState("Sort") = b.Sort

            .DataSourceID = ""
            .DataSource = b
            .DataBind()
            .PageIndex = pageIndex
        End With
    End Sub

    Protected Sub GVFirmas_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GVFirmas.PageIndexChanging
        GVFirmas.PageIndex = e.NewPageIndex
        Rebind()
    End Sub

    Protected Sub lnkActualizarPendientes_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkActualizarPendientes.Click
        RequerimientoManager.RecalcularPendientesDeAsignar(SC)
        Rebind()
    End Sub

End Class
