VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmConsultaValesFaltantes 
   Caption         =   "Vales faltantes para retiro de materiales de almacenes ( por obra )"
   ClientHeight    =   5490
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11835
   Icon            =   "frmConsultaValesFaltantes.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5490
   ScaleWidth      =   11835
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtArticulo 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   90
      Locked          =   -1  'True
      TabIndex        =   7
      Top             =   4185
      Width           =   11670
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Buscar"
      Height          =   405
      Index           =   0
      Left            =   4230
      TabIndex        =   2
      Top             =   4635
      Width           =   1485
   End
   Begin VB.TextBox txtObra 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   2925
      Locked          =   -1  'True
      TabIndex        =   1
      Top             =   495
      Width           =   1185
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Salir"
      Height          =   405
      Index           =   1
      Left            =   6075
      TabIndex        =   0
      Top             =   4635
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   360
      Index           =   0
      Left            =   4230
      TabIndex        =   3
      Tag             =   "Obras"
      Top             =   495
      Width           =   3930
      _ExtentX        =   6932
      _ExtentY        =   635
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   390
      Left            =   0
      TabIndex        =   4
      Top             =   5100
      Width           =   11835
      _ExtentX        =   20876
      _ExtentY        =   688
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   5
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   8414
            Key             =   "Mensaje"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   8414
            Picture         =   "frmConsultaValesFaltantes.frx":076A
            Key             =   "Estado"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   1
            Alignment       =   1
            AutoSize        =   2
            Enabled         =   0   'False
            Object.Width           =   900
            MinWidth        =   18
            TextSave        =   "CAPS"
            Key             =   "Caps"
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   2
            AutoSize        =   2
            Object.Width           =   820
            MinWidth        =   18
            TextSave        =   "NUM"
            Key             =   "Num"
         EndProperty
         BeginProperty Panel5 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            Alignment       =   1
            AutoSize        =   2
            Object.Width           =   1693
            MinWidth        =   18
            TextSave        =   "01/09/2008"
            Key             =   "Fecha"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3255
      Left            =   45
      TabIndex        =   6
      Top             =   855
      Width           =   11760
      _ExtentX        =   20743
      _ExtentY        =   5741
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmConsultaValesFaltantes.frx":0A84
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   45
      Top             =   4545
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaValesFaltantes.frx":0AA0
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaValesFaltantes.frx":0BB2
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaValesFaltantes.frx":0CC4
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaValesFaltantes.frx":0DD6
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaValesFaltantes.frx":0EE8
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaValesFaltantes.frx":0FFA
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmConsultaValesFaltantes.frx":110C
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   11835
      _ExtentX        =   20876
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageKey        =   "Print"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel"
            Object.ToolTipText     =   "Salida a Excel"
            ImageKey        =   "Excel"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageKey        =   "Find"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Ayuda"
            Object.ToolTipText     =   "Ayuda"
            ImageKey        =   "Help"
         EndProperty
      EndProperty
   End
   Begin VB.Label Label1 
      Caption         =   "Numero de Obra :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   90
      TabIndex        =   5
      Top             =   540
      Width           =   2670
   End
End
Attribute VB_Name = "frmConsultaValesFaltantes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mvarIdObra As Long

Public Property Let Obra(ByVal vnewvalue As Long)

   mvarIdObra = vnewvalue
   Set dcfields(0).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasActivasParaCombo")
   
   If mvarIdObra <> 0 Then
      dcfields(0).Enabled = False
      cmd(0).Visible = False
   End If
   
End Property

Private Sub cmd_Click(Index As Integer)

   StatusBar1.Enabled = True
   
   Select Case Index
      
      Case 0
      
         If Len(Trim(txtObra.Text)) = 0 Then
            MsgBox "Debe ingresar una obra!", vbExclamation
            Exit Sub
         End If
      
         CalcularFaltante
         
      Case 1
         
         Me.Hide
   
   End Select
   
End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   If IsNumeric(dcfields(Index).BoundText) Then
      If Index = 0 Then
         Dim oAp As Aplicacion
         Set oAp = Aplicacion
         txtObra.Text = oAp.Obras.Item(dcfields(Index).BoundText).Registro.Fields("NumeroObra").Value
         Set oAp = Nothing
         mvarIdObra = dcfields(Index).BoundText
      End If
   End If

End Sub

Private Sub Form_Activate()

   If Not cmd(0).Visible Then
      Me.Refresh
      CalcularFaltante
   End If

End Sub

Private Sub Form_Load()

   StatusBar1.Enabled = False
   ReemplazarEtiquetas Me
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()
    
   Degradado Me

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_ItemClick(ByVal Item As MSComctlLib.IListItem)

   txtArticulo.Text = Lista.SelectedItem.SubItems(7)

End Sub

Private Sub Lista_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long
   Dim iColumnas As Long
   Dim oL As ListItem

   If State = vbEnter Then
      If Data.GetFormat(ccCFText) Then ' si el dato es texto
         s = Data.GetData(ccCFText) ' tomo el dato
         Filas = Split(s, vbCrLf) ' armo un vector por filas
         Columnas = Split(Filas(LBound(Filas)), vbTab)
         Effect = vbDropEffectCopy
      End If
   End If

End Sub

Private Sub Lista_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Public Sub CalcularFaltante()

   Dim oAp As Aplicacion
   Dim oRsLMat, oRsRes, oRsSal, oRsPre As ADOR.Recordset
   Dim mvarNroLM, mvarItem, Saldo As Long
   
   Me.MousePointer = vbHourglass
   
   Set oAp = Aplicacion
   dcfields(0).BoundText = mvarIdObra
   txtObra.Text = oAp.Obras.Item(mvarIdObra).Registro.Fields("NumeroObra").Value
   Set oRsLMat = CopiarTodosLosRegistros(oAp.TablasGenerales.TraerFiltrado("ValesSalida", "_ItemsPorObra", mvarIdObra))
   Set oRsRes = oAp.TablasGenerales.TraerFiltrado("ValesSalida", "_ItemsPorObra1", mvarIdObra)
   Set oRsSal = oAp.TablasGenerales.TraerFiltrado("ValesSalida", "_ItemsPorObra2", mvarIdObra)
   Set oRsPre = oAp.TablasGenerales.TraerFiltrado("ValesSalida", "_ItemsPorObra3", mvarIdObra)
   
   With oRsLMat
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If Not IsNull(.Fields("Med.1").Value) And .Fields("Med.1").Value = 0 Then
               .Fields("Med.1").Value = Null
            End If
            If Not IsNull(.Fields("Med.2").Value) And .Fields("Med.2").Value = 0 Then
               .Fields("Med.2").Value = Null
            End If
            .MoveNext
         Loop
      End If
   End With
   
   'Agrego a los detalle de listas de materiales las reservas
   'de stock en renglones aparte.
   
   If oRsRes.RecordCount > 0 Then
      oRsRes.MoveFirst
      Do While Not oRsRes.EOF
         With oRsLMat
            .AddNew
            .Fields("IdDetalleReserva").Value = oRsRes.Fields("IdDetalleReserva").Value
            .Fields("Reser.").Value = oRsRes.Fields("NumeroReserva").Value
            .Fields("IdArticulo").Value = oRsRes.Fields("IdArticulo").Value
            .Fields("Codigo").Value = oAp.Articulos.Item(oRsRes.Fields("IdArticulo").Value).Registro.Fields("Codigo").Value
            .Fields("Articulo").Value = mId(oAp.Articulos.Item(oRsRes.Fields("IdArticulo").Value).Registro.Fields("Descripcion").Value, 1, .Fields("Articulo").DefinedSize)
            .Fields("Cant.").Value = oRsRes.Fields("CantidadUnidades").Value
            .Fields("Med.1").Value = oRsRes.Fields("Cantidad1").Value
            .Fields("Med.2").Value = oRsRes.Fields("Cantidad2").Value
            .Fields("Total").Value = oRsRes.Fields("Cargado").Value
            If Not IsNull(.Fields("Med.1").Value) And .Fields("Med.1").Value = 0 Then
               .Fields("Med.1").Value = Null
            End If
            If Not IsNull(.Fields("Med.2").Value) And .Fields("Med.2").Value = 0 Then
               .Fields("Med.2").Value = Null
            End If
            .Update
         End With
         oRsRes.MoveNext
      Loop
   End If
   
   'Descuento las entregas hechas por almacenes que
   'tienen Id del detalle de las listas de materiales
   
   If oRsSal.RecordCount > 0 Then
      oRsSal.MoveFirst
      Do While Not oRsSal.EOF
         If Not IsNull(oRsSal.Fields("IdDetalleLMateriales").Value) Then
            With oRsLMat
               If .RecordCount > 0 Then
                  .MoveFirst
                  Do While Not .EOF
                     If .Fields("IdDetalleLMateriales").Value = oRsSal.Fields("IdDetalleLMateriales").Value Then
                        If IsNull(.Fields("Tot. Ent.").Value) Then
                           .Fields("Cant.Ent.").Value = oRsSal.Fields("Cantidad").Value
                           .Fields("Med.1 Ent.").Value = oRsSal.Fields("Cantidad1").Value
                           .Fields("Med.2 Ent.").Value = oRsSal.Fields("Cantidad2").Value
                           .Fields("Tot. Ent.").Value = oRsSal.Fields("Entregado").Value
                        Else
                           .Fields("Cant.Ent.").Value = .Fields("Cant.Ent.").Value + oRsSal.Fields("Cantidad").Value
                           .Fields("Med.1 Ent.").Value = Null
                           .Fields("Med.2 Ent.").Value = Null
                           .Fields("Tot. Ent.").Value = .Fields("Tot. Ent.").Value + oRsSal.Fields("Entregado").Value
                        End If
                        If .Fields("Tot. Ent.").Value >= .Fields("Total").Value Then
                           .Delete
                           .Update
                        End If
                        Exit Do
                     End If
                     .MoveNext
                  Loop
               End If
            End With
         End If
         oRsSal.MoveNext
      Loop
   End If
   
   'Descuento los vales de retiro de materiales que todavia
   'no entregadas. Solo las que tengan Id de detalle de listas
   'de materiales o de reserva de stock.
   
   If oRsPre.RecordCount > 0 Then
      oRsPre.MoveFirst
      Do While Not oRsPre.EOF
         With oRsLMat
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  If Not IsNull(oRsPre.Fields("IdDetalleLMateriales").Value) Then
                     If .Fields("IdDetalleLMateriales").Value = oRsPre.Fields("IdDetalleLMateriales").Value Then
                        If oRsPre.Fields("Preparado").Value >= .Fields("Total").Value Then
                           .Delete
                           .Update
                        Else
                           .Fields("Cant.").Value = .Fields("Cant.").Value - oRsPre.Fields("Cantidad").Value
                           .Fields("Med.1").Value = Null
                           .Fields("Med.2").Value = Null
                           .Fields("Total").Value = .Fields("Total").Value - oRsPre.Fields("Preparado").Value
                        End If
                     End If
                     Exit Do
                  Else
                     If Not IsNull(oRsPre.Fields("IdDetalleReserva").Value) Then
                        If .Fields("IdDetalleReserva").Value = oRsPre.Fields("IdDetalleReserva").Value Then
                           If oRsPre.Fields("Preparado").Value >= .Fields("Total").Value Then
                              .Delete
                              .Update
                           Else
                              .Fields("Cant.").Value = .Fields("Cant.").Value - oRsPre.Fields("Cantidad").Value
                              .Fields("Med.1").Value = Null
                              .Fields("Med.2").Value = Null
                              .Fields("Total").Value = .Fields("Total").Value - oRsPre.Fields("Preparado").Value
                           End If
                        End If
                        Exit Do
                     End If
                  End If
                  .MoveNext
               Loop
            End If
         End With
         oRsPre.MoveNext
      Loop
   End If
   
   'Descuento las entregas hechas por almacenes que NO
   'tienen Id del detalle de las listas de materiales
   
   If oRsSal.RecordCount > 0 Then
      oRsSal.MoveFirst
      Do While Not oRsSal.EOF
         If IsNull(oRsSal.Fields("IdDetalleLMateriales").Value) Then
            With oRsLMat
               If .RecordCount > 0 Then
                  .MoveFirst
                  Do While Not .EOF
                     If .Fields("IdArticulo").Value = oRsSal.Fields("IdArticulo").Value Then
                        If IsNull(.Fields("Tot. Ent.").Value) Then
                           .Fields("Cant.Ent.").Value = oRsSal.Fields("Cantidad").Value
                           .Fields("Med.1 Ent.").Value = oRsSal.Fields("Cantidad1").Value
                           .Fields("Med.2 Ent.").Value = oRsSal.Fields("Cantidad2").Value
                           .Fields("Tot. Ent.").Value = oRsSal.Fields("Entregado").Value
                        Else
                           .Fields("Cant.Ent.").Value = .Fields("Cant.Ent.").Value + oRsSal.Fields("Cantidad").Value
                           .Fields("Med.1 Ent.").Value = Null
                           .Fields("Med.2 Ent.").Value = Null
                           .Fields("Tot. Ent.").Value = .Fields("Tot. Ent.").Value + oRsSal.Fields("Entregado").Value
                        End If
                        If .Fields("Tot. Ent.").Value >= .Fields("Total").Value Then
                           .Delete
                           .Update
                        End If
                     End If
                     .MoveNext
                  Loop
               End If
            End With
         End If
         oRsSal.MoveNext
      Loop
   End If
   
   'Descuento los vales de retiro de materiales que todavia
   'no entregadas. Solo las que NO tengan Id de detalle de listas
   'de materiales NI de reserva de stock.
   
   If oRsPre.RecordCount > 0 Then
      oRsPre.MoveFirst
      Do While Not oRsPre.EOF
         If IsNull(oRsPre.Fields("IdDetalleLMateriales").Value) And IsNull(oRsPre.Fields("IdDetalleReserva").Value) Then
            With oRsLMat
               If .RecordCount > 0 Then
                  .MoveFirst
                  Do While Not .EOF
                     If .Fields("IdArticulo").Value = oRsPre.Fields("IdArticulo").Value Then
                        If IsNull(.Fields("Tot. Ent.").Value) Then
                           If oRsPre.Fields("Preparado").Value >= .Fields("Total").Value Then
                              .Delete
                              .Update
                              Exit Do
                           End If
                        Else
                           If oRsPre.Fields("Preparado").Value + .Fields("Tot. Ent.").Value >= .Fields("Total").Value Then
                              .Delete
                              .Update
                              Exit Do
                           End If
                        End If
                        .Fields("Cant.").Value = .Fields("Cant.").Value - oRsPre.Fields("Cantidad").Value
                        .Fields("Med.1").Value = Null
                        .Fields("Med.2").Value = Null
                        .Fields("Total").Value = .Fields("Total").Value - oRsPre.Fields("Preparado").Value
                     End If
                     .MoveNext
                  Loop
               End If
            End With
         End If
         oRsPre.MoveNext
      Loop
   End If
   
   Me.MousePointer = vbDefault
   
   If oRsLMat.RecordCount > 0 Then
      oRsLMat.MoveFirst
'      Lista.SortKey = 5
      Set Lista.DataSource = oRsLMat
      ReemplazarEtiquetasListas Lista
   End If
   
   oRsRes.Close
   Set oRsRes = Nothing
   oRsLMat.Close
   Set oRsLMat = Nothing
   oRsSal.Close
   Set oRsSal = Nothing
   oRsPre.Close
   Set oRsPre = Nothing
   Set oAp = Nothing

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Key
      
      Case "Imprimir"
         
         ImprimirConExcel Lista, Me.Caption
      
      Case "Buscar"
         
         FiltradoLista Lista
         StatusBar1.Panels(2).Text = " " & Lista.ListItems.Count & " elementos en la lista"

      Case "Excel"
         
         ExportarAExcel Lista, Me.Caption
      
   End Select

End Sub


