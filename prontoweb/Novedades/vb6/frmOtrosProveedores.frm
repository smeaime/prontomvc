VERSION 5.00
Object = "{F09A78C8-7814-11D2-8355-4854E82A9183}#1.1#0"; "CUIT32.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmOtrosProveedores 
   Caption         =   "Otros proveedores"
   ClientHeight    =   4995
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6555
   Icon            =   "frmOtrosProveedores.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   4995
   ScaleWidth      =   6555
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Height          =   375
      Left            =   1260
      TabIndex        =   6
      Top             =   45
      Width           =   2355
      Begin VB.OptionButton Option2 
         Caption         =   "Todos"
         Height          =   195
         Left            =   1530
         TabIndex        =   8
         Top             =   135
         Width           =   825
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Solo eventuales"
         Height          =   195
         Left            =   45
         TabIndex        =   7
         Top             =   135
         Width           =   1455
      End
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   405
      Index           =   1
      Left            =   1890
      TabIndex        =   12
      Top             =   4500
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   180
      TabIndex        =   3
      Top             =   4500
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   3300
      Index           =   0
      Left            =   180
      TabIndex        =   1
      Top             =   450
      Width           =   3435
      _ExtentX        =   6059
      _ExtentY        =   5821
      _Version        =   393216
      Style           =   1
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   3300
      Index           =   1
      Left            =   3645
      TabIndex        =   4
      Top             =   450
      Width           =   2760
      _ExtentX        =   4868
      _ExtentY        =   5821
      _Version        =   393216
      Style           =   1
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin Control_CUIT.CUIT CUIT1 
      Height          =   285
      Left            =   945
      TabIndex        =   0
      Top             =   3915
      Width           =   1545
      _ExtentX        =   2725
      _ExtentY        =   503
      Text            =   ""
      MensajeErr      =   "CUIT incorrecto"
      otrosP          =   -1  'True
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCodigoIva"
      Height          =   315
      Index           =   2
      Left            =   3960
      TabIndex        =   2
      Tag             =   "DescripcionIva"
      Top             =   3915
      Width           =   2460
      _ExtentX        =   4339
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCodigoIva"
      Text            =   ""
   End
   Begin VB.Label lblData 
      Alignment       =   1  'Right Justify
      Caption         =   "Condicion de IVA :"
      Height          =   300
      Index           =   1
      Left            =   2565
      TabIndex        =   11
      Top             =   3930
      Width           =   1320
   End
   Begin VB.Label Label1 
      Caption         =   "Cuenta"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   2
      Left            =   3690
      TabIndex        =   10
      Top             =   225
      Width           =   690
   End
   Begin VB.Label Label1 
      Caption         =   "Proveedor"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   1
      Left            =   225
      TabIndex        =   9
      Top             =   180
      Width           =   915
   End
   Begin VB.Label Label1 
      Caption         =   "CUIT :"
      Height          =   195
      Index           =   0
      Left            =   225
      TabIndex        =   5
      Top             =   3960
      Width           =   600
   End
End
Attribute VB_Name = "frmOtrosProveedores"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mIdProveedor As Integer
Private mIdCuenta As Long
Private mOk As Boolean, mAlta As Boolean

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         If Len(Trim(DataCombo1(0).Text)) = 0 Then
            MsgBox "No indico un proveedor, elija uno o salga pulsando Cancelar", vbInformation
            Exit Sub
         End If
         If Len(Trim(DataCombo1(1).Text)) = 0 Then
            MsgBox "No indico una cuenta, elija una o salga pulsando Cancelar", vbInformation
            Exit Sub
         End If
         If Len(Trim(DataCombo1(2).Text)) = 0 Then
            MsgBox "No indico la condicion de iva, elija una o salga pulsando Cancelar", vbInformation
            Exit Sub
         End If
         Dim oRs As ADOR.Recordset
         If Len(Trim(CUIT1.Text)) = 0 Then
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DescripcionIva", "_PorId", DataCombo1(2).BoundText)
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("ExigirCUIT").Value) And _
                     oRs.Fields("ExigirCUIT").Value = "SI" Then
                  MsgBox "Debe ingresar el numero de CUIT para esta condicion", vbCritical
                  oRs.Close
                  Set oRs = Nothing
                  Exit Sub
               End If
            End If
            oRs.Close
            Set oRs = Nothing
         End If
         Me.Ok = True
      Case 1
   
   End Select
   
   Me.Hide
   
End Sub

Private Sub CUIT1_LostFocus()

   RegistrarProveedor Me.IdProveedor

End Sub

Private Sub CUIT1_Validate(Cancel As Boolean)

   If Len(CUIT1.Text) > 0 Then
      Dim oRs As ADOR.Recordset
      Dim mvarSeguro As Integer
      If Not IsNumeric(DataCombo1(0).BoundText) Then
         Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorCuit", CUIT1.Text)
         If oRs.RecordCount > 0 Then
            DataCombo1(0).BoundText = oRs.Fields(0).Value
            DataCombo1(0).Enabled = False
            DataCombo1(2).Enabled = False
            CUIT1.Enabled = False
         Else
            DataCombo1(0).Enabled = True
            DataCombo1(2).Enabled = True
            CUIT1.Enabled = True
            If mAlta Then Exit Sub
            mvarSeguro = MsgBox("Cuit inexistente, desea dar el alta?", vbYesNo, "Alta de proveedor")
            If mvarSeguro = vbYes Then
               mAlta = True
            Else
               Cancel = True
            End If
         End If
         oRs.Close
      Else
         Dim s As String
         Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ValidarPorCuit", Array(DataCombo1(0).BoundText, CUIT1.Text))
         s = ""
         With oRs
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  s = s & .Fields("RazonSocial").Value & vbCrLf
                  .MoveNext
               Loop
            End If
            .Close
         End With
         If Len(s) > 0 Then
            mvarSeguro = MsgBox("El CUIT lo tienen los siguientes proveedores :" & vbCrLf & s & "Desea continuar ?", vbYesNo, "CUIT")
            If mvarSeguro = vbNo Then
               Cancel = True
            Else
               DataCombo1(0).Enabled = False
               DataCombo1(2).Enabled = False
            End If
         End If
      End If
      Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorCuit", CUIT1.Text)
      If oRs.RecordCount > 0 Then
         DataCombo1(0).BoundText = oRs.Fields(0).Value
         DataCombo1(0).Enabled = False
         DataCombo1(2).Enabled = False
         CUIT1.Enabled = False
      Else
         DataCombo1(0).Enabled = True
         DataCombo1(2).Enabled = True
         CUIT1.Enabled = True
         mvarSeguro = MsgBox("Cuit inexistente, desea dar el alta?", vbYesNo, "Alta de proveedor")
         If mvarSeguro = vbYes Then
            mAlta = True
         Else
            Cancel = True
         End If
      End If
      oRs.Close
      Set oRs = Nothing
      
      If BuscarClaveINI("Permitir modificar proveedor FF") = "SI" Then
         DataCombo1(0).Enabled = True
         DataCombo1(2).Enabled = True
         CUIT1.Enabled = True
      End If
      
      If Not DataCombo1(0).Enabled Then cmd(0).SetFocus
   End If

End Sub

Private Sub DataCombo1_Change(Index As Integer)

   Select Case Index
      Case 0
         CUIT1.Enabled = True
         DataCombo1(2).Enabled = True
         If mAlta Then Exit Sub
         If IsNumeric(DataCombo1(0).BoundText) And DataCombo1(0).BoundText <> DataCombo1(0).Text Then
            Dim oRs As ADOR.Recordset
            Me.IdProveedor = DataCombo1(0).BoundText
            Set oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", DataCombo1(0).BoundText)
            If oRs.RecordCount > 0 Then
               CUIT1.Text = oRs.Fields("Cuit").Value
               CUIT1.Enabled = False
               DataCombo1(2).BoundText = IIf(IsNull(oRs.Fields("IdCodigoIva").Value), 0, oRs.Fields("IdCodigoIva").Value)
               If IsNumeric(DataCombo1(2).BoundText) Then DataCombo1(2).Enabled = False
            End If
            oRs.Close
            Set oRs = Nothing
         Else
            If Not mAlta Then CUIT1.Text = ""
         End If
      Case 2
         If IsNumeric(DataCombo1(0).BoundText) Then
            RegistrarProveedor DataCombo1(0).BoundText
         End If
   End Select
   
End Sub

Private Sub DataCombo1_Validate(Index As Integer, Cancel As Boolean)

   Dim mvarSeguro As Integer
   If Index = 0 Then
      If Not IsNumeric(DataCombo1(0).BoundText) And Len(DataCombo1(0).Text) > 0 Then
         If Not mAlta Then
            mvarSeguro = MsgBox("Proveedor inexistente, desea ingresarlo ?", vbYesNo, "Proveedores")
         Else
            mvarSeguro = vbYes
         End If
         If mvarSeguro = vbYes Then
            mAlta = True
            RegistrarProveedor -1
         Else
            Cancel = True
         End If
      End If
   ElseIf Index = 1 Then
      If Not IsNumeric(DataCombo1(1).BoundText) Then
         MsgBox "Cuenta inexistente", vbExclamation
         Cancel = True
      Else
         Me.IdCuenta = DataCombo1(1).BoundText
      End If
   End If

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   Me.Ok = False
   mAlta = False
   Option2.Value = True
   
   With DataCombo1(1)
      Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_FondosFijos")
      .BoundText = Me.IdCuenta
   End With
   Set DataCombo1(2).RowSource = Aplicacion.TablasGenerales.TraerLista("DescripcionIva")
   
   If glbIdCuentaFFUsuario <> -1 Then
      Option2.Value = True
      Frame1.Enabled = False
   End If
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Public Sub RegistrarProveedor(ByVal mvarId As Integer)

   Dim oAp As ComPronto.Aplicacion
   Dim oProv As ComPronto.Proveedor
   Dim oRs As ADOR.Recordset
   Dim mProcesar As Boolean
   
   If Len(Trim(DataCombo1(0).Text)) > 0 And Len(CUIT1.Text) > 0 Then
      Set oAp = Aplicacion
      mProcesar = True
      If mvarId <= 0 Then
         Set oRs = oAp.Proveedores.TraerFiltrado("_PorCuit", CUIT1.Text)
         If oRs.RecordCount > 0 Then
            Me.IdProveedor = oRs.Fields(0).Value
            mProcesar = False
         End If
         oRs.Close
      End If
      If mProcesar Then
         Set oProv = oAp.Proveedores.Item(mvarId)
         With oProv
            With .Registro
               .Fields("RazonSocial").Value = DataCombo1(0).Text
               If IsNumeric(DataCombo1(2).BoundText) Then
                  .Fields("IdCodigoIva").Value = DataCombo1(2).BoundText
               End If
               .Fields("Cuit").Value = CUIT1.Text
               If mvarId <= 0 Then
                  .Fields("Eventual").Value = "SI"
               End If
               .Fields("EnviarEmail").Value = 1
            End With
            .Guardar
            Me.IdProveedor = .Registro.Fields(0).Value
         End With
         Set oProv = Nothing
      End If
      Set oRs = Nothing
      Set oAp = Nothing
      CargarDatacombo
      mAlta = False
   End If
   
End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Option1_Click()

   CargarDatacombo

End Sub

Private Sub Option2_Click()

   CargarDatacombo

End Sub

Public Property Get IdProveedor() As Integer

   IdProveedor = mIdProveedor
   
End Property

Public Property Let IdProveedor(ByVal vNewValue As Integer)

   mIdProveedor = vNewValue
   
End Property

Public Property Get IdCuenta() As Long

   IdCuenta = mIdCuenta
   
End Property

Public Property Let IdCuenta(ByVal vNewValue As Long)

   mIdCuenta = vNewValue
   
End Property

Public Property Get Ok() As Boolean

   Ok = mOk
   
End Property

Public Property Let Ok(ByVal vNewValue As Boolean)

   mOk = vNewValue
   
End Property

Public Sub CargarDatacombo()

   With DataCombo1(0)
      Set .RowSource = Nothing
      If Option1.Value Then
         Set .RowSource = Aplicacion.Proveedores.TraerFiltrado("_EventualesParaCombo")
      Else
         Set .RowSource = Aplicacion.Proveedores.TraerFiltrado("_TodosParaCombo")
      End If
      If Me.IdProveedor > 0 Then .BoundText = Me.IdProveedor
   End With

End Sub
