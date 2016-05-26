VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmDistribucionesObras 
   Caption         =   "Matriz de distribucion por obra"
   ClientHeight    =   4995
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6810
   Icon            =   "frmDistribucionesObras.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4995
   ScaleWidth      =   6810
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "Aplicar"
      Height          =   420
      Index           =   2
      Left            =   1935
      TabIndex        =   8
      Top             =   4770
      Visible         =   0   'False
      Width           =   1470
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Ver solo obras afectadas :"
      Height          =   150
      Left            =   3600
      TabIndex        =   7
      Top             =   4770
      Width           =   2805
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1845
      TabIndex        =   5
      Top             =   90
      Width           =   4830
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   0
      Left            =   5625
      Locked          =   -1  'True
      TabIndex        =   3
      Top             =   4410
      Width           =   780
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   420
      Index           =   1
      Left            =   1620
      TabIndex        =   1
      Top             =   4500
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   90
      TabIndex        =   0
      Top             =   4500
      Width           =   1470
   End
   Begin Controles1013.DbListView Lista 
      Height          =   3930
      Left            =   90
      TabIndex        =   2
      Top             =   450
      Width           =   6630
      _ExtentX        =   11695
      _ExtentY        =   6932
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Checkboxes      =   -1  'True
      MouseIcon       =   "frmDistribucionesObras.frx":076A
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   1845
      TabIndex        =   9
      Tag             =   "DistribucionesObras"
      Top             =   270
      Visible         =   0   'False
      Width           =   4830
      _ExtentX        =   8520
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdDistribucionObra"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nombre de la matriz :"
      Height          =   255
      Index           =   4
      Left            =   135
      TabIndex        =   6
      Top             =   135
      Width           =   1590
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      Caption         =   "Total distribucion :"
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
      Index           =   3
      Left            =   3600
      TabIndex        =   4
      Top             =   4455
      Width           =   1935
   End
End
Attribute VB_Name = "frmDistribucionesObras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DistribucionObra
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Public mOk As Boolean
Private mvarId As Long, mIdAprobo As Long
Dim actL2 As ControlForm
Private mNivelAcceso As Integer, mOpcionesAcceso As String

Public Property Let NivelAcceso(ByVal mNivelA As EnumAccesos)
   
   mNivelAcceso = mNivelA
   
End Property

Public Property Get NivelAcceso() As EnumAccesos

   NivelAcceso = mNivelAcceso
   
End Property

Public Property Let OpcionesAcceso(ByVal mOpcionesA As String)
   
   mOpcionesAcceso = mOpcionesA
   
End Property

Public Property Get OpcionesAcceso() As String

   OpcionesAcceso = mOpcionesAcceso
   
End Property

Sub Editar(ByVal Cual As Long)

   On Error Resume Next
   
   Dim oF As frm_Aux
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Item matriz"
      .Label1.Caption = "Porcentaje :"
      .Text1.Text = Val(Lista.SelectedItem.SubItems(4))
      .Show vbModal, Me
      If .Ok Then
         With origen.DetDistribucionesObras.Item(Lista.SelectedItem.SubItems(1))
            .Registro.Fields("Porcentaje").Value = Val(oF.Text1.Text)
            .Modificado = True
         End With
         Set oL = Lista.SelectedItem
         With oL
            .SubItems(4) = "" & Format(oF.Text1.Text, "##0.00")
         End With
      End If
   End With
   
Salida:
   Unload oF
   Set oF = Nothing
   
   CalcularTotal
   
End Sub

Private Sub Check1_Click()

   Dim oL As ListItem
   If Check1.Value = 0 Then
      Set Lista.DataSource = origen.DetDistribucionesObras.RegistrosConFormatoTodasLasObras
      For Each oL In Lista.ListItems
         If Len(oL.SubItems(1)) > 0 Then oL.Checked = True
      Next
   Else
      Set Lista.DataSource = origen.DetDistribucionesObras.RegistrosConFormato
      For Each oL In Lista.ListItems
         oL.Checked = True
      Next
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
      
         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar una matriz sin detalles"
            Exit Sub
         End If
         
         If Len(txtDescripcion.Text) = 0 Then
            MsgBox "Debe ingresar el nombre de la matriz de distribucion"
            Exit Sub
         End If
         
         If Val(txtTotal(0).Text) <> 100 Then
            MsgBox "La suma de los porcentajes debe ser 100"
            Exit Sub
         End If
         
         Dim est As EnumAcciones
         
         With origen.Registro
            
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
            
         With actL2
            .ListaEditada = "DistribucionesObras"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
         
         mOk = True
         Unload Me

      Case 1
      
         mOk = False
         Unload Me

      Case 2
      
         If Not IsNumeric(dcfields(0).BoundText) Then
            MsgBox "No eligio una matriz"
            Exit Sub
         End If
         
         If Lista.ListItems.Count = 0 Then
            MsgBox "No hay obras en la matriz"
            Exit Sub
         End If
         
         If Val(txtTotal(0).Text) <> 100 Then
            MsgBox "La suma de los porcentajes debe ser 100"
            Exit Sub
         End If
         
         mOk = True
         Me.Hide

   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oDet As ComPronto.DetDistribucionObra
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   Dim ListaVacia As Boolean
   Dim i As Integer
   Dim oL As ListItem
   
   mvarId = vnewvalue
   ListaVacia = False
   
   Set oAp = Aplicacion
   Set origen = oAp.DistribucionesObras.Item(vnewvalue)
   
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vnewvalue < 0 Then
                     Set oControl.DataSource = origen.DetDistribucionesObras.TraerMascara
                     ListaVacia = True
                  Else
                     Set oRs = origen.DetDistribucionesObras.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           Set oDet = origen.DetDistribucionesObras.Item(oRs.Fields(0).Value)
                           oDet.Modificado = True
                           Set oDet = Nothing
                           oRs.MoveNext
                        Loop
                        ListaVacia = False
                     Else
                        Set oControl.DataSource = origen.DetDistribucionesObras.TraerMascara
                        ListaVacia = True
                     End If
                     oRs.Close
                  End If
            End Select
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
   
   If mvarId = -1 Then
      With origen.Registro
      
      End With
   Else
      With origen.Registro
      
      End With
   End If
   
   If ListaVacia Then
      Lista.ListItems.Clear
   End If
   Check1.Value = 1
   
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing
   
   CalcularTotal
   
End Property

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   If IsNumeric(dcfields(Index).BoundText) Then
      If Index = 0 Then
         Dim oRs As ADOR.Recordset
         Dim oL As ListItem
         Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetDistribucionesObras", "Det", dcfields(Index).BoundText)
         Set Lista.DataSource = oRs
         For Each oL In Lista.ListItems
            oL.Checked = True
         Next
         Lista.Refresh
         oRs.Close
         Set oRs = Nothing
         CalcularTotal
         DoEvents
      End If
   End If

End Sub

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Lista_DblClick()

   If Lista.ListItems.Count > 0 Then
      If Len(Lista.SelectedItem.SubItems(1)) > 0 Then
         Editar Lista.SelectedItem.SubItems(1)
      End If
   End If

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_ItemCheck(ByVal Item As MSComctlLib.IListItem)

   If Not cmd(0).Visible Then
      Item.Checked = True
      Exit Sub
   End If
   
   If Len(Item.SubItems(1)) = 0 Then
      With origen.DetDistribucionesObras.Item(-1)
         With .Registro
            .Fields("IdObra").Value = Item.SubItems(2)
         End With
         .Modificado = True
         Item.Tag = .Id
         Item.SubItems(1) = .Id
      End With
   Else
      origen.DetDistribucionesObras.Item(Item.SubItems(1)).Eliminado = True
      Item.SubItems(1) = ""
      Item.SubItems(4) = ""
   End If

End Sub

Private Sub Lista_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 And Not Lista.SelectedItem Is Nothing Then
      If Len(Lista.SelectedItem.SubItems(1)) > 0 Then
         Editar Lista.SelectedItem.SubItems(1)
      End If
   End If

End Sub

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Public Sub CalcularTotal()

   Dim oL As ListItem
   Dim mTotal As Double
   
   mTotal = 0
   For Each oL In Lista.ListItems
      If oL.Checked Then
         mTotal = mTotal + Val(oL.SubItems(4))
      End If
   Next
   
   txtTotal(0).Text = Format(mTotal, "#,##0.00")

End Sub

