VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmRubros 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Rubros"
   ClientHeight    =   3000
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   7380
   Icon            =   "frmRubros.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3000
   ScaleWidth      =   7380
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtAbreviatura 
      DataField       =   "Abreviatura"
      Height          =   330
      Left            =   2445
      TabIndex        =   1
      Top             =   495
      Width           =   1890
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1260
      TabIndex        =   4
      Top             =   2295
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   4680
      TabIndex        =   6
      Top             =   2295
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   2970
      TabIndex        =   5
      Top             =   2295
      Width           =   1485
   End
   Begin VB.TextBox txtRubro 
      DataField       =   "Descripcion"
      Height          =   285
      Left            =   2460
      TabIndex        =   0
      Top             =   150
      Width           =   4500
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   0
      Left            =   2430
      TabIndex        =   2
      Tag             =   "Cuentas"
      Top             =   855
      Width           =   4500
      _ExtentX        =   7938
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaCompras"
      Height          =   315
      Index           =   1
      Left            =   2430
      TabIndex        =   3
      Tag             =   "Cuentas"
      Top             =   1215
      Width           =   4500
      _ExtentX        =   7938
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaComprasActivo"
      Height          =   315
      Index           =   2
      Left            =   2430
      TabIndex        =   11
      Tag             =   "Cuentas"
      Top             =   1575
      Width           =   4500
      _ExtentX        =   7938
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuenta para activo :"
      Height          =   255
      Index           =   4
      Left            =   405
      TabIndex        =   12
      Top             =   1620
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuenta para compras :"
      Height          =   255
      Index           =   3
      Left            =   405
      TabIndex        =   10
      Top             =   1260
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuenta para ventas :"
      Height          =   255
      Index           =   0
      Left            =   405
      TabIndex        =   9
      Top             =   900
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Abreviatura :"
      Height          =   255
      Index           =   2
      Left            =   405
      TabIndex        =   8
      Top             =   540
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Nombre : "
      Height          =   255
      Index           =   1
      Left            =   420
      TabIndex        =   7
      Top             =   165
      Width           =   1815
   End
End
Attribute VB_Name = "frmRubros"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Rubro
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

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
         If Len(txtRubro.Text) = 0 Then
            MsgBox "No puede grabar un rubro sin descripcion", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe indicar la cuenta contable", vbExclamation
            Exit Sub
         End If
            
         Dim est As EnumAcciones
         Dim oControl As Control
   
         For Each oControl In Me.Controls
            If TypeOf oControl Is DataCombo Then
               If Len(oControl.BoundText) <> 0 Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
               End If
            ElseIf TypeOf oControl Is DTPicker Then
               origen.Registro.Fields(oControl.DataField).Value = oControl.Value
            End If
         Next
      
         With origen.Registro
            .Fields("EnviarEmail").Value = 1
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
            est = EnumAcciones.alta
            mvarId = origen.Registro.Fields(0).Value
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("ALTA", mvarId, 0, Now, 0, "Tabla : Rubros", GetCompName(), glbNombreUsuario)
         Else
            est = EnumAcciones.Modificacion
            Aplicacion.Tarea "Log_InsertarRegistro", _
                  Array("MODIF", mvarId, 0, Now, 0, "Tabla : Rubros", GetCompName(), glbNombreUsuario)
         End If
            
         With actL2
            .ListaEditada = "Rubros"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
      Case 1
         Dim mBorra As Integer
         mBorra = MsgBox("Esta seguro de eliminar los datos definitivamente ?", vbYesNo, "Eliminar")
         If mBorra = vbNo Then
            Exit Sub
         End If
         
         origen.Eliminar
         
         est = baja
         Aplicacion.Tarea "Log_InsertarRegistro", Array("ELIM", mvarId, 0, Now, 0, "Tabla : Rubros", GetCompName(), glbNombreUsuario)
            
         With actL2
            .ListaEditada = "Rubros"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
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

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oAp.Rubros.Item(vnewvalue)
   Set oBind = New BindingCollection
   
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Cuentas" Then
                  'Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_SinObrasParaCombo")
                  Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_PorFechaParaCombo", Array(Date, 0))
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   End With
   
   cmd(1).Enabled = False
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      If mvarId > 0 Then cmd(1).Enabled = True
   End If
   
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub Form_Load()

   If mvarId < 0 Then cmd(1).Enabled = False
   
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

Private Sub txtAbreviatura_GotFocus()
   
   With txtAbreviatura
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAbreviatura_KeyPress(KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtAbreviatura
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtRubro_GotFocus()

   With txtRubro
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtRubro_KeyPress(KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtRubro
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
