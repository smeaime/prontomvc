VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmEnviarASat 
   Caption         =   "Transmision manual de datos a PRONTO SAT"
   ClientHeight    =   4755
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6015
   Icon            =   "frmEnviarASat.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4755
   ScaleWidth      =   6015
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Usar OUTLOOK :"
      Height          =   240
      Left            =   4275
      TabIndex        =   5
      Top             =   4320
      Width           =   1590
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1440
      TabIndex        =   4
      Top             =   4185
      Width           =   1260
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   3
      Top             =   4185
      Width           =   1260
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3390
      Left            =   135
      TabIndex        =   0
      Top             =   675
      Width           =   5775
      _ExtentX        =   10186
      _ExtentY        =   5980
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmEnviarASat.frx":076A
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   1710
      TabIndex        =   1
      Tag             =   "ArchivosATransmitirDestinos"
      Top             =   180
      Width           =   4200
      _ExtentX        =   7408
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdArchivoATransmitirDestino"
      Text            =   ""
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label Label1 
      Caption         =   "Destino a transmitir : "
      Height          =   285
      Left            =   135
      TabIndex        =   2
      Top             =   180
      Width           =   1515
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Marcar todo"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Desmarcar todo"
         Index           =   1
      End
   End
End
Attribute VB_Name = "frmEnviarASat"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         If Not IsNumeric(dcfields(0).BoundText) Then
            MsgBox "No eligio un destino para el envio de informacion!", vbExclamation
            Exit Sub
         End If
         EnviarCorreoCompleto
   End Select
   
   Unload Me

End Sub

Private Sub Form_Load()

   Set dcfields(0).RowSource = Aplicacion.ArchivosATransmitirDestinos.TraerFiltrado("_ActivosPorSistemaParaCombo", "SAT")
   
   Lista.CheckBoxes = True
   Set Lista.DataSource = Aplicacion.TablasGenerales.TraerFiltrado("ArchivosATransmitir", "_PorSistema", "SAT")
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Sub EnviarCorreoCompleto()

   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim oRsArch As ADOR.Recordset
   Dim oRsDest As ADOR.Recordset
   Dim oRsLote As ADOR.Recordset
   Dim goMailOL As CEmailOL
   Dim oTransmision As ComPronto.ArchivoATransmitirLoteo
   Dim oF As Form
   Dim oL As ListItem
   Dim mCheck As Boolean
   Dim sXML As String, mLista As String, mSubject As String, mBody As String, mAttachment As String, mPathSaliente As String
   Dim mLote As String
   Dim mArchivo As String
   Dim lStatus As Long, mNumeroLote As Long
   Dim mConfirma As Integer, mIdObra As Integer
   Dim oXML As MSXML.DOMDocument
   
   On Error GoTo Mal
   
   mConfirma = MsgBox("Esta seguro de procesar la informacion ?", vbYesNo, "Confirmacion y generacion de reenvios")
   If mConfirma = vbNo Then Exit Sub
   
   mCheck = False
   
   If Lista.ListItems.Count > 0 Then
      For Each oL In Lista.ListItems
         If oL.Checked Then
            mCheck = True
            Exit For
         End If
      Next
   End If
   
   If Not mCheck Then
      MsgBox "No hay informacion a procesar!", vbExclamation
      Exit Sub
   End If
         
   Set oF = New frmInformacion
   oF.Label1.Caption = "PROCESAMIENTO DE INFORMACION PARA TRANSMISION DE DATOS"
   oF.Show , Me
   
   Set oAp = Aplicacion
   
   Set oPar = Aplicacion.Parametros.Item(1)
   mPathSaliente = oPar.Registro.Fields("PathEnvioEmails").Value
   Set oPar = Nothing
   
   Set oRsDest = oAp.ArchivosATransmitirDestinos.Item(dcfields(0).BoundText).Registro
   
   mIdObra = 0
   If Not IsNull(oRsDest.Fields("IdObra").Value) Then
      mIdObra = oRsDest.Fields("IdObra").Value
   End If
   
   If Check1.Value = 1 Then Set goMailOL = New CEmailOL
      
   For Each oL In Lista.ListItems
      If oL.Checked Then
         mArchivo = oL.Text
         oF.Label2.Caption = "Procesando archivo : " & mArchivo
         DoEvents
         
         Select Case mArchivo
            Case "Articulos"
               Set oRsArch = oAp.Articulos.TraerFiltrado("_ParaTransmitir_Todos")
            Case "DetArticulosUnidades"
               Set oRsArch = CopiarTodosLosRegistros(oAp.TablasGenerales.TraerFiltrado("DetArticulosUnidades", "_ParaTransmitir", "T"))
               With oRsArch
                  If .RecordCount > 0 Then
                     .MoveFirst
                     Do While Not .EOF
                        .Fields("IdDetalleArticuloUnidadesOriginal").Value = .Fields(0).Value
                        .Fields("IdArticuloOriginal").Value = .Fields("IdArticulo").Value
                        .Fields("IdOrigenTransmision").Value = 0
                        .MoveNext
                     Loop
                     .MoveFirst
                  End If
               End With
            Case "Rubros"
               Set oRsArch = oAp.Rubros.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Subrubros"
               Set oRsArch = oAp.Subrubros.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Familias"
               Set oRsArch = oAp.Familias.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Obras"
               Set oRsArch = oAp.Obras.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Equipos"
               Set oRsArch = oAp.Equipos.TraerFiltrado("_ParaTransmitir_Todos")
            Case "DetEquipos"
               Set oRsArch = oAp.Equipos.Item(0).DetEquipos.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Planos"
               Set oRsArch = oAp.Planos.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Clientes"
               Set oRsArch = oAp.Clientes.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Acopios"
               Set oRsArch = CopiarTodosLosRegistros(oAp.Acopios.TraerFiltrado("_ParaTransmitir_Todos"))
               With oRsArch
                  If .RecordCount > 0 Then
                     .MoveFirst
                     Do While Not .EOF
                        .Fields("IdAcopioOriginal").Value = .Fields(0).Value
                        .Fields("IdOrigenTransmision").Value = 0
                        .MoveNext
                     Loop
                     .MoveFirst
                  End If
               End With
            Case "DetAcopios"
               Set oRsArch = CopiarTodosLosRegistros(oAp.Acopios.Item(0).DetAcopios.TraerFiltrado("_ParaTransmitir_Todos"))
               With oRsArch
                  If .RecordCount > 0 Then
                     .MoveFirst
                     Do While Not .EOF
                        .Fields("IdDetalleAcopiosOriginal").Value = .Fields(0).Value
                        .Fields("IdAcopioOriginal").Value = .Fields("IdAcopio").Value
                        .Fields("IdOrigenTransmision").Value = 0
                        .MoveNext
                     Loop
                     .MoveFirst
                  End If
               End With
            Case "DetAcopiosEquipos"
               Set oRsArch = CopiarTodosLosRegistros(oAp.Acopios.Item(0).DetAcopiosEquipos.TraerFiltrado("_ParaTransmitir_Todos"))
               With oRsArch
                  If .RecordCount > 0 Then
                     .MoveFirst
                     Do While Not .EOF
                        .Fields("IdDetalleAcopioEquipoOriginal").Value = .Fields(0).Value
                        .Fields("IdAcopioOriginal").Value = .Fields("IdAcopio").Value
                        .Fields("IdOrigenTransmision").Value = 0
                        .MoveNext
                     Loop
                     .MoveFirst
                  End If
               End With
            Case "DetAcopiosRevisiones"
               Set oRsArch = CopiarTodosLosRegistros(oAp.Acopios.Item(0).DetAcopiosRevisiones.TraerFiltrado("_ParaTransmitir_Todos"))
               With oRsArch
                  If .RecordCount > 0 Then
                     .MoveFirst
                     Do While Not .EOF
                        .Fields("IdDetalleAcopiosRevisionesOriginal").Value = .Fields(0).Value
                        .Fields("IdAcopioOriginal").Value = .Fields("IdAcopio").Value
                        .Fields("IdOrigenTransmision").Value = 0
                        .MoveNext
                     Loop
                     .MoveFirst
                  End If
               End With
            Case "ArchivosATransmitirDestinos"
               Set oRsArch = oAp.ArchivosATransmitirDestinos.TraerFiltrado("_Todos")
            Case "Ubicaciones"
               Set oRsArch = oAp.Ubicaciones.TraerFiltrado("_ParaTransmitir", mIdObra)
            Case "Depositos"
               Set oRsArch = oAp.Depositos.TraerFiltrado("_ParaTransmitir", mIdObra)
            Case "Proveedores"
               Set oRsArch = oAp.Proveedores.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Transportistas"
               Set oRsArch = oAp.Transportistas.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Pedidos"
               Set oRsArch = CopiarTodosLosRegistros(oAp.Pedidos.TraerFiltrado("_ParaTransmitir_Todos", mIdObra))
               With oRsArch
                  If .RecordCount > 0 Then
                     .MoveFirst
                     Do While Not .EOF
                        .Fields("IdPedidoOriginal").Value = .Fields(0).Value
                        .Fields("IdOrigenTransmision").Value = 0
                        .Fields("FechaImportacionTransmision").Value = Now
                        .MoveNext
                     Loop
                     .MoveFirst
                  End If
               End With
            Case "DetPedidos"
               Set oRsArch = CopiarTodosLosRegistros(oAp.TablasGenerales.TraerFiltrado("DetPedidos", "_ParaTransmitir_Todos", mIdObra))
               With oRsArch
                  If .RecordCount > 0 Then
                     .MoveFirst
                     Do While Not .EOF
                        .Fields("IdDetallePedidoOriginal").Value = .Fields(0).Value
                        .Fields("IdPedidoOriginal").Value = .Fields("IdPedido").Value
                        .Fields("IdOrigenTransmision").Value = 0
                        .MoveNext
                     Loop
                     .MoveFirst
                  End If
               End With
            Case "Localidades"
               Set oRsArch = oAp.Localidades.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Provincias"
               Set oRsArch = oAp.Provincias.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Paises"
               Set oRsArch = oAp.Paises.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Monedas"
               Set oRsArch = oAp.Monedas.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Sectores"
               Set oRsArch = oAp.Sectores.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Cuentas"
               Set oRsArch = oAp.Cuentas.TraerFiltrado("_ParaTransmitir_Todos")
            Case "UnidadesOperativas"
               Set oRsArch = oAp.UnidadesOperativas.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Unidades"
               Set oRsArch = oAp.Unidades.TraerFiltrado("_ParaTransmitir_Todos")
            Case "Empleados"
               Set oRsArch = oAp.Empleados.TraerFiltrado("_ParaTransmitir_Todos")
            Case "SalidasMateriales"
               Set oRsArch = oAp.SalidasMateriales.TraerFiltrado("_ParaTransmitir", mIdObra)
            Case "DetRequerimientos"
               Set oRsArch = oAp.TablasGenerales.TraerFiltrado("DetRequerimientos", "_ParaTransmitir", mIdObra)
            Case "CondicionesCompra"
               Set oRsArch = oAp.CondicionesCompra.TraerFiltrado("_TodosSF")
            Case "DescripcionIva"
               Set oRsArch = oAp.TablasGenerales.TraerTodos("DescripcionIva")
            Case "Cotizaciones"
               Set oRsArch = oAp.Cotizaciones.TraerFiltrado("_ParaTransmitir")
            Case "Conjuntos"
               Set oRsArch = oAp.Conjuntos.TraerFiltrado("_Todos")
            Case "DetConjuntos"
               Set oRsArch = oAp.TablasGenerales.TraerFiltrado("DetConjuntos", "_Todos")
            
            Case Else
               MsgBox "Archivo : " & mArchivo & ", no definido!", vbExclamation
               GoTo Salida
         End Select
      
         If oRsArch.RecordCount > 0 Then
            sXML = ArmarXML(oRsArch)
            
            Set oRsLote = oAp.ArchivosATransmitirLoteo.TraerFiltrado("_UltimoLote", Array(dcfields(0).BoundText, oL.Tag))
            mNumeroLote = 1
            If oRsLote.RecordCount > 0 Then
               If Not IsNull(oRsLote.Fields("Lote").Value) Then
                  mNumeroLote = oRsLote.Fields("Lote").Value + 1
               End If
            End If
            oRsLote.Close
            
            mLote = Format(mNumeroLote, "00000")
            mLista = IIf(IsNull(oRsDest.Fields("Email").Value), "", oRsDest.Fields("Email").Value)
            mSubject = glbEmpresaSegunString & "_" & _
                     IIf(IsNull(oRsDest.Fields("Email").Value), "", oRsDest.Fields("Email").Value) & "_" & mArchivo & "_L" & mLote
            mBody = "" & vbCrLf & mArchivo & "."
            mAttachment = mPathSaliente & mSubject & ".XML"
            
            Set oXML = CreateObject("MSXML.DOMDocument")
            oXML.loadXML sXML
            oXML.Save mAttachment
            Set oXML = Nothing
         
            If Check1.Value = 1 Then
               lStatus = goMailOL.Send(mLista, True, mSubject, mBody, mAttachment)
            End If
            
            Set oTransmision = oAp.ArchivosATransmitirLoteo.Item(-1)
            With oTransmision.Registro
               .Fields("IdArchivoATransmitir").Value = oL.Tag
               .Fields("FechaTransmision").Value = Now
               .Fields("IdArchivoATransmitirDestino").Value = dcfields(0).BoundText
               .Fields("NumeroLote").Value = mNumeroLote
               .Fields("Confirmado").Value = "NO"
            End With
            oTransmision.Guardar
            Set oTransmision = Nothing
         End If
      End If
   Next

Salida:
   
   Unload oF
   Set oF = Nothing
   Set oRs = Nothing
   Set oRsArch = Nothing
   Set oRsDest = Nothing
   Set oRsLote = Nothing
   Set oAp = Nothing
   Set goMailOL = Nothing

   Exit Sub

Mal:

   MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   Resume Salida

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      PopupMenu MnuDet
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Dim oL As ListItem
   
   Select Case Index
      Case 0
         For Each oL In Lista.ListItems
            oL.Checked = True
         Next
      Case 1
         For Each oL In Lista.ListItems
            oL.Checked = False
         Next
   End Select

End Sub
