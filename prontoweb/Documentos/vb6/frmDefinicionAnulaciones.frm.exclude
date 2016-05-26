VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmDefinicionAnulaciones 
   Caption         =   "Definicion de anulacion de comprobantes"
   ClientHeight    =   4110
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7950
   Icon            =   "frmDefinicionAnulaciones.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4110
   ScaleWidth      =   7950
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   420
      Index           =   1
      Left            =   1575
      TabIndex        =   1
      Top             =   3555
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   45
      TabIndex        =   0
      Top             =   3555
      Width           =   1470
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdFormulario"
      Height          =   315
      Index           =   0
      Left            =   1080
      TabIndex        =   2
      Tag             =   "Formularios"
      Top             =   90
      Width           =   3795
      _ExtentX        =   6694
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdFormulario"
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   2895
      Left            =   90
      TabIndex        =   3
      Top             =   495
      Width           =   7755
      _ExtentX        =   13679
      _ExtentY        =   5106
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmDefinicionAnulaciones.frx":076A
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   4230
      Top             =   3105
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDefinicionAnulaciones.frx":0786
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDefinicionAnulaciones.frx":0898
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDefinicionAnulaciones.frx":0CEA
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDefinicionAnulaciones.frx":113C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Formulario : "
      Height          =   240
      Index           =   7
      Left            =   135
      TabIndex        =   4
      Top             =   135
      Width           =   855
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar administradores"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   1
      End
   End
End
Attribute VB_Name = "frmDefinicionAnulaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DefinicionAnulacion
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long

Private Sub cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
      
         Dim dc As DataCombo
         Dim dtp As DTPicker
         Dim est As EnumAcciones
      
         If Lista.ListItems.Count = 0 Then
            MsgBox "No hay detalles a registrar", vbExclamation
            Exit Sub
         End If
         
         For Each dc In dcfields
            If Len(Trim(dc.BoundText)) = 0 Then
               MsgBox "Falta completar el campo " & dc.Tag, vbCritical
               Exit Sub
            End If
            origen.Registro.Fields(dc.DataField).Value = dc.BoundText
         Next
      
         Select Case origen.Guardar
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
   End Select
   
   Unload Me

End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   If IsNumeric(dcfields(Index).BoundText) Then
   
      Dim oAp As ComPronto.Aplicacion
      Dim oRs As ADOR.Recordset
      
      Set origen = Nothing
      Set oBind = Nothing
      
      Set oAp = Aplicacion
      Set oRs = oAp.DefinicionAnulaciones.TraerFiltrado("_PorIdFormulario", dcfields(Index).BoundText)
      
      If oRs.RecordCount > 0 Then
         Set origen = oAp.DefinicionAnulaciones.Item(oRs.Fields(0).Value)
      Else
         Set origen = oAp.DefinicionAnulaciones.Item(-1)
      End If
      oRs.Close
      
      Set oBind = New BindingCollection
      Set oBind.DataSource = origen
      
      Lista.ListItems.Clear
      
      Set oRs = origen.DetDefinicionAnulaciones.TraerTodos
      
      If oRs.RecordCount > 0 Then
         Set Lista.DataSource = oRs
      Else
         Set Lista.DataSource = origen.DetDefinicionAnulaciones.TraerMascara
         Lista.ListItems.Clear
      End If
      oRs.Close
      
      Set oRs = Nothing
      Set oAp = Nothing

   End If

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   Set dcfields(0).RowSource = Aplicacion.Formularios.TraerLista
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()
    
   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set origen = Nothing
   Set oBind = Nothing

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyDelete Then
      MnuDetA_Click 1
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count = 0 Then
         MnuDetA(1).Enabled = False
         PopupMenu MnuDet, , , , MnuDetA(0)
      Else
         MnuDetA(1).Enabled = True
         PopupMenu MnuDet, , , , MnuDetA(1)
      End If
   End If

End Sub

Private Sub Lista_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim Filas, Columnas
   Dim iFilas As Long
   Dim iColumnas As Long
   Dim oL As ListItem

   If Data.GetFormat(ccCFText) Then
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If InStr(1, Columnas(LBound(Columnas) + 1), "Cargo") <> 0 Then
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            Set oL = Lista.ListItems.Add()
            With origen.DetDefinicionAnulaciones.Item(-1)
               .Registro.Fields("IdCargo").Value = Columnas(0)
               oL.Tag = .Id
               oL.SubItems(1) = Columnas(1)
               oL.SmallIcon = "Nuevo"
               .Modificado = True
            End With
         Next
      ElseIf InStr(1, Columnas(LBound(Columnas) + 1), "Sector") <> 0 Then
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            Set oL = Lista.ListItems.Add()
            With origen.DetDefinicionAnulaciones.Item(-1)
               .Registro.Fields("IdSector").Value = Columnas(0)
               oL.Tag = .Id
               oL.SubItems(2) = Columnas(1)
               oL.SmallIcon = "Nuevo"
               .Modificado = True
            End With
         Next
      ElseIf InStr(1, Columnas(LBound(Columnas) + 3), "Legajo") <> 0 Then
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            Set oL = Lista.ListItems.Add()
            With origen.DetDefinicionAnulaciones.Item(-1)
               .Registro.Fields("IdEmpleado").Value = Columnas(2)
               oL.Tag = .Id
               oL.Text = Columnas(1)
               oL.SmallIcon = "Nuevo"
               .Modificado = True
            End With
         Next
      Else
         MsgBox "Sólo puede arrastrar aqui empleado, cargos o sectores", vbExclamation
         Exit Sub
      End If
   End If

End Sub

Private Sub Lista_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long
   Dim iColumnas As Long
   Dim oL As ListItem

   If State = vbEnter Then
      If Data.GetFormat(ccCFText) Then
         s = Data.GetData(ccCFText)
         Filas = Split(s, vbCrLf)
         Columnas = Split(Filas(LBound(Filas)), vbTab)
         If Columnas(LBound(Columnas) + 1) <> "Descripcion" Then
            Effect = vbDropEffectNone
         Else
            Effect = vbDropEffectCopy
         End If
      End If
   End If

End Sub

Private Sub Lista_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Dim oL As ListItem
         Set oL = Lista.ListItems.Add()
         With origen.DetDefinicionAnulaciones.Item(-1)
            .Registro.Fields("Administradores").Value = "SI"
            oL.Tag = .Id
            oL.SubItems(3) = "SI"
            oL.SmallIcon = "Nuevo"
            .Modificado = True
         End With
      Case 1
         With Lista.SelectedItem
            origen.DetDefinicionAnulaciones.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub
