VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{298EA83C-2DFB-45A7-BDDB-96DB4254DB87}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmProveedoresRubros 
   Caption         =   "Relacion proveedores - grupos de articulos"
   ClientHeight    =   6525
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11505
   Icon            =   "frmProveedoresRubros.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6525
   ScaleWidth      =   11505
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1935
      TabIndex        =   2
      Top             =   5940
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Carga &Datos"
      Height          =   405
      Index           =   2
      Left            =   3780
      TabIndex        =   3
      Top             =   5940
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   90
      TabIndex        =   1
      Top             =   5940
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   0
      Left            =   2085
      TabIndex        =   0
      Tag             =   "Proveedores"
      Top             =   315
      Width           =   8055
      _ExtentX        =   14208
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   5010
      Left            =   45
      TabIndex        =   5
      Top             =   765
      Width           =   11445
      _ExtentX        =   20188
      _ExtentY        =   8837
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmProveedoresRubros.frx":076A
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Proveedor :"
      Height          =   195
      Index           =   4
      Left            =   135
      TabIndex        =   4
      Top             =   360
      Width           =   1815
   End
End
Attribute VB_Name = "frmProveedoresRubros"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.ProveedorRubro
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long
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

Private Sub Cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
   
         Dim est As EnumAcciones
         Dim oControl As Control
         Dim dc As DataCombo
         
         For Each dc In DataCombo1
            If Len(Trim(dc.BoundText)) = 0 Then
               MsgBox "Falta completar el campo " & dc.Tag, vbCritical
               Exit Sub
            End If
            origen.Registro.Fields(dc.DataField).Value = dc.BoundText
         Next

         For Each oControl In Me.Controls
            If TypeOf oControl Is DataCombo Then
               If Len(oControl.BoundText) <> 0 Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
               End If
            ElseIf TypeOf oControl Is DTPicker Then
               origen.Registro.Fields(oControl.DataField).Value = oControl.Value
            End If
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
      
         est = alta

         With actL2
            .ListaEditada = "ProveedoresRubros"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
         Unload Me

      Case 1
   
         Unload Me

      Case 2
      
'         Dim oAp As ComPronto.Aplicacion
'         Dim oRs, oRsConjunto, oRsActu As ADOR.Recordset
'         Dim Existe As Boolean
'         Dim VectorX, VectorT As String
'         Dim Contador As Integer
'
'         If Len(DataCombo1(0).BoundText) = 0 Then
'            MsgBox "Debe indicar un proveedor!", vbCritical
'            Exit Sub
'         End If
'
'         Contador = 1
'
'         Set oAp = Aplicacion
'         Set oRs = oAp.DefinicionesArt.TraerFiltrado("_Grupos")
'         Set oRsConjunto = origen.Conjunto
'
'         If oRsConjunto.RecordCount > 0 Then
'            oRsConjunto.MoveFirst
'            VectorX = oRsConjunto.Fields("Vector_X").Value
'            VectorT = oRsConjunto.Fields("Vector_T").Value
'         Else
'            Set oRsActu = oAp.ProveedoresRubros.TraerFiltrado("Primero")
'            If oRsActu.RecordCount > 0 Then
'               VectorX = oRsActu.Fields("Vector_X").Value
'               VectorT = oRsActu.Fields("Vector_T").Value
'            Else
'               Set oRsConjunto = CopiarEstructuraSinAtributos(oRsConjunto)
'            End If
'            oRsActu.Close
'            Set oRsActu = Nothing
'         End If
'
'         If oRs.RecordCount > 0 Then
'            Do While Not oRs.EOF
'               Existe = False
'               With oRsConjunto
'                  If .RecordCount > 0 Then
'                     .MoveFirst
'                  End If
'                  Do While Not .EOF
'                     If .Fields("IdRubro").Value = oRs.Fields(0).Value And .Fields("IdSubrubro").Value = oRs.Fields(2).Value And .Fields("IdFamilia").Value = oRs.Fields(4).Value Then
'                        Existe = True
'                        Exit Do
'                     End If
'                     .MoveNext
'                  Loop
'                  If Not Existe Then
'                     .AddNew
'                     .Fields(0).Value = Contador * -1
'                     .Fields("Proveedor").Value = DataCombo1(0).Text
'                     .Fields("IdProveedor").Value = DataCombo1(0).BoundText
'                     .Fields("Rubro").Value = oRs.Fields("Rubro").Value
'                     .Fields("IdRubro").Value = oRs.Fields("IdRubro").Value
'                     .Fields("Subrubro").Value = oRs.Fields("Subrubro").Value
'                     .Fields("IdSubrubro").Value = oRs.Fields("IdSubrubro").Value
'                     .Fields("Familia").Value = oRs.Fields("Familia").Value
'                     .Fields("IdFamilia").Value = oRs.Fields("IdFamilia").Value
'                     .Fields("*").Value = ""
'                     .Update
'                     Contador = Contador + 1
'                     Set oRsActu = CopiarUnRegistro(oRsConjunto)
'                     oRsActu.Fields("Vector_X").Value = VectorX
'                     oRsActu.Fields("Vector_T").Value = VectorT
'                     Lista.UltimaAccion = alta
'                     Set Lista.RecordSource = oRsActu
'                     oRsActu.Close
'                     Set oRsActu = Nothing
'                  End If
'               End With
'               oRs.MoveNext
'            Loop
'         End If
'
'         Set oRs = Nothing
'         Set oRsConjunto = Nothing
'         Set oAp = Nothing
'
'         cmd(2).Enabled = False
         
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   
   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oAp.ProveedoresRubros.Item(vNewValue)
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            If vNewValue < 0 Then
               Set oControl.DataSource = origen.ConjuntoVacio
            Else
               Set oControl.DataSource = origen.Conjunto
            End If
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
   
   If vNewValue < 0 Then
      Lista.ListItems.Clear
   End If
   
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
   End If
   
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub DataCombo1_GotFocus(Index As Integer)
   
   With DataCombo1(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
'   SendKeys "%{DOWN}"
   
End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DataCombo1_Validate(Index As Integer, Cancel As Boolean)

   If Index = 0 Then
      
      If mvarId < 0 And Len(DataCombo1(0).BoundText) Then
         
         Dim oAp As ComPronto.Aplicacion
         Dim oRs As ADOR.Recordset
         
         Set oAp = Aplicacion
         Set oRs = oAp.ProveedoresRubros.TraerFiltrado("Prov", DataCombo1(0).BoundText)

         If oRs.RecordCount > 0 Then
            MsgBox "Este proveedor ya tiene registros cargados, accedalos por modificacion.", vbCritical
            Cancel = True
         End If
      
         oRs.Close
         Set oRs = Nothing
         Set oAp = Nothing
         
      End If
   
   End If
   
End Sub

Private Sub Form_Load()

   If mvarId < 0 Then
      cmd(1).Enabled = False
   End If
   
End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub Lista_Click()

   If Not Lista.SelectedItem Is Nothing Then
      If Lista.SelectedItem.ListSubItems(4).Text = "*" Then
         Lista.SelectedItem.ListSubItems(4).Text = ""
      Else
         Lista.SelectedItem.ListSubItems(4).Text = "*"
      End If
      With origen.Conjunto
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               If .Fields(0).Value = Lista.SelectedItem.Tag Then
                  .Fields("*").Value = Lista.SelectedItem.ListSubItems(4).Text
                  Exit Do
               End If
               .MoveNext
            Loop
         End If
      End With
   End If

End Sub
