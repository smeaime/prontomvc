VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmEventosDelSistema 
   Caption         =   "Destinatarios de mensajes por eventos del sistema"
   ClientHeight    =   7110
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5820
   Icon            =   "frmEventosDelSistema.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7110
   ScaleWidth      =   5820
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Enabled         =   0   'False
      Height          =   405
      Index           =   0
      Left            =   1260
      TabIndex        =   9
      Top             =   6570
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   3060
      TabIndex        =   8
      Top             =   6570
      Width           =   1485
   End
   Begin VB.Frame Frame1 
      Enabled         =   0   'False
      Height          =   375
      Left            =   1530
      TabIndex        =   4
      Top             =   450
      Width           =   4020
      Begin VB.OptionButton Option1 
         Caption         =   "Alta"
         Height          =   195
         Left            =   135
         TabIndex        =   7
         Top             =   135
         Width           =   1095
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Regular"
         Height          =   195
         Left            =   1395
         TabIndex        =   6
         Top             =   135
         Width           =   1230
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Baja"
         Height          =   195
         Left            =   2700
         TabIndex        =   5
         Top             =   135
         Width           =   870
      End
   End
   Begin Controles1013.DbListView Lista 
      Height          =   5460
      Left            =   225
      TabIndex        =   0
      Top             =   945
      Width           =   5370
      _ExtentX        =   9472
      _ExtentY        =   9631
      Enabled         =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmEventosDelSistema.frx":076A
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   1485
      TabIndex        =   1
      Tag             =   "EventosDelSistema"
      Top             =   90
      Width           =   4065
      _ExtentX        =   7170
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdEventoDelSistema"
      Text            =   ""
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   4950
      Top             =   6480
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
            Picture         =   "frmEventosDelSistema.frx":0786
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmEventosDelSistema.frx":0898
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmEventosDelSistema.frx":0CEA
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmEventosDelSistema.frx":113C
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Importancia :"
      Height          =   285
      Index           =   0
      Left            =   270
      TabIndex        =   3
      Top             =   540
      Width           =   1005
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Evento :"
      Height          =   285
      Index           =   3
      Left            =   270
      TabIndex        =   2
      Top             =   120
      Width           =   1005
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   0
      End
   End
End
Attribute VB_Name = "frmEventosDelSistema"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.EventoDelSistema
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long
Private mvarPass As String
Private mNivelAcceso As Integer

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
   
         Dim est As EnumAcciones
         Dim oControl As Control
         Dim dtp As DTPicker
   
         With origen.Registro
            If Option1.Value Then
               .Fields("Importancia").Value = 1
            ElseIf Option2.Value Then
               .Fields("Importancia").Value = 2
            ElseIf Option3.Value Then
               .Fields("Importancia").Value = 3
            End If
         End With
         
         Select Case origen.Guardar
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
         Else
            est = Modificacion
         End If
            
      Case 1
   
   End Select
   
   Unload Me

   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case -2147217900
         mvarResp = MsgBox("No puede borrar este registro porque se esta" & vbCrLf & "utilizando en otros archivos. Desea ver detalles?", vbYesNo + vbCritical)
         If mvarResp = vbYes Then
            MsgBox "Detalle del error : " & vbCrLf & Err.Number & " -> " & Err.Description
         End If
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

End Sub

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) Then
   
      Dim oAp As ComPronto.Aplicacion
      Dim oRs As ADOR.Recordset
      Dim ListaVacia As Boolean
      
      mvarId = DataCombo1(Index).BoundText
      ListaVacia = False
      Set origen = Nothing
      Lista.Enabled = True
      Frame1.Enabled = True
      cmd(0).Enabled = True
      
      Set oAp = Aplicacion
      Set origen = oAp.EventosDelSistema.Item(mvarId)
      Set oRs = origen.DetEventosDelSistema.TraerTodos
      If oRs.RecordCount <> 0 Then
         Set Lista.DataSource = oRs
         ListaVacia = False
      Else
         Set Lista.DataSource = origen.DetEventosDelSistema.TraerMascara
         ListaVacia = True
      End If
      Set oAp = Nothing
   
      With origen.Registro
         Select Case .Fields("Importancia").Value
            Case 1
               Option1.Value = True
            Case 2
               Option2.Value = True
            Case 3
               Option3.Value = True
            Case Else
               Option1.Value = True
         End Select
      End With
         
      If ListaVacia Then
         Lista.ListItems.Clear
      End If
   
   End If

End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)
   
   SendKeys "%{DOWN}"

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   If mvarId < 0 Then
      cmd(1).Enabled = False
   End If
   
   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   Set DataCombo1(0).RowSource = Aplicacion.EventosDelSistema.TraerLista

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyDelete Then
      MnuDetA_Click 0
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Lista.ListItems.Count = 0 Then
      Else
         PopupMenu MnuDet, , , , MnuDetA(0)
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         With Lista.SelectedItem
            origen.DetEventosDelSistema.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub Lista_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas, iColumnas, i, NroItem As Long
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then ' si el dato es texto
      
      s = Data.GetData(ccCFText) ' tomo el dato
      
      Filas = Split(s, vbCrLf) ' armo un vector por filas
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 2), "Legajo") <> 0 Then
      
         Set oAp = Aplicacion
         
         For iFilas = LBound(Filas) + 1 To UBound(Filas) ' recorro las filas
            
            Columnas = Split(Filas(iFilas), vbTab) ' armo un vector con las columnas
            
            Set oRs = oAp.Empleados.Item(Columnas(0)).Registro
            
            Do While Not oRs.EOF
               With origen.DetEventosDelSistema.Item(-1)
                  .Registro.Fields("IdEmpleado").Value = oRs.Fields("IdEmpleado").Value
                  .Modificado = True
               End With
               Set oL = Lista.ListItems.Add
               oL.Tag = oRs.Fields("IdEmpleado").Value
               With oL
                  .SmallIcon = "Nuevo"
                  .Text = IIf(IsNull(oRs.Fields("Legajo").Value), "", oRs.Fields("Legajo").Value)
                  .SubItems(1) = "" & oRs.Fields("Nombre").Value
               End With
               oRs.MoveNext
            Loop
            
            Set oRs = Nothing
            
         Next
         
         Clipboard.Clear
      
      Else
         
         MsgBox "Objeto invalido!"
      
      End If

   End If
   
   Set oAp = Nothing
            
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


