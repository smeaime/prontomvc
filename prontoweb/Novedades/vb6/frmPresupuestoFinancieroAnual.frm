VERSION 5.00
Begin VB.Form frmPresupuestoFinancieroAnual 
   Caption         =   "Presupuesto financiero anual"
   ClientHeight    =   3120
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7125
   Icon            =   "frmPresupuestoFinancieroAnual.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3120
   ScaleWidth      =   7125
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   11
      Left            =   5850
      TabIndex        =   14
      Top             =   2025
      Width           =   1110
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   10
      Left            =   4725
      TabIndex        =   13
      Top             =   2025
      Width           =   1110
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   9
      Left            =   3600
      TabIndex        =   12
      Top             =   2025
      Width           =   1110
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   8
      Left            =   2430
      TabIndex        =   11
      Top             =   2025
      Width           =   1110
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   7
      Left            =   1305
      TabIndex        =   10
      Top             =   2025
      Width           =   1110
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   6
      Left            =   180
      TabIndex        =   9
      Top             =   2025
      Width           =   1110
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   5
      Left            =   5850
      TabIndex        =   8
      Top             =   1170
      Width           =   1110
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   4
      Left            =   4725
      TabIndex        =   7
      Top             =   1170
      Width           =   1110
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   3
      Left            =   3600
      TabIndex        =   6
      Top             =   1170
      Width           =   1110
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   2
      Left            =   2430
      TabIndex        =   5
      Top             =   1170
      Width           =   1110
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   1
      Left            =   1305
      TabIndex        =   4
      Top             =   1170
      Width           =   1110
   End
   Begin VB.TextBox txtDescripcion 
      Enabled         =   0   'False
      Height          =   285
      Left            =   990
      Locked          =   -1  'True
      TabIndex        =   0
      Top             =   90
      Width           =   3690
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1755
      TabIndex        =   16
      Top             =   2520
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   180
      TabIndex        =   15
      Top             =   2520
      Width           =   1485
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   0
      Left            =   180
      TabIndex        =   3
      Top             =   1170
      Width           =   1110
   End
   Begin VB.TextBox txtAnual 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   1800
      TabIndex        =   2
      Top             =   450
      Visible         =   0   'False
      Width           =   1170
   End
   Begin VB.CommandButton cmdDistribucion 
      Caption         =   "Distribuir por mes"
      Height          =   285
      Left            =   3060
      TabIndex        =   17
      Top             =   450
      Visible         =   0   'False
      Width           =   1590
   End
   Begin VB.TextBox txtAño 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   5400
      TabIndex        =   1
      Top             =   90
      Width           =   720
   End
   Begin VB.Label lblTipo 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   4770
      TabIndex        =   33
      Top             =   450
      Width           =   1365
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Rubro :"
      Height          =   255
      Index           =   1
      Left            =   225
      TabIndex        =   32
      Top             =   105
      Width           =   690
   End
   Begin VB.Label lblMes 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      Caption         =   "Enero"
      Height          =   255
      Index           =   0
      Left            =   180
      TabIndex        =   31
      Top             =   855
      Width           =   1095
   End
   Begin VB.Label lblMes 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      Caption         =   "Febrero"
      Height          =   255
      Index           =   1
      Left            =   1320
      TabIndex        =   30
      Top             =   855
      Width           =   1095
   End
   Begin VB.Label lblMes 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      Caption         =   "Marzo"
      Height          =   255
      Index           =   2
      Left            =   2460
      TabIndex        =   29
      Top             =   855
      Width           =   1095
   End
   Begin VB.Label lblMes 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      Caption         =   "Abril"
      Height          =   255
      Index           =   3
      Left            =   3600
      TabIndex        =   28
      Top             =   855
      Width           =   1095
   End
   Begin VB.Label lblMes 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      Caption         =   "Mayo"
      Height          =   255
      Index           =   4
      Left            =   4740
      TabIndex        =   27
      Top             =   855
      Width           =   1095
   End
   Begin VB.Label lblMes 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      Caption         =   "Junio"
      Height          =   255
      Index           =   5
      Left            =   5880
      TabIndex        =   26
      Top             =   855
      Width           =   1095
   End
   Begin VB.Label lblMes 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      Caption         =   "Julio"
      Height          =   255
      Index           =   6
      Left            =   180
      TabIndex        =   25
      Top             =   1710
      Width           =   1095
   End
   Begin VB.Label lblMes 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      Caption         =   "Agosto"
      Height          =   255
      Index           =   7
      Left            =   1320
      TabIndex        =   24
      Top             =   1710
      Width           =   1095
   End
   Begin VB.Label lblMes 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      Caption         =   "Setiembre"
      Height          =   255
      Index           =   8
      Left            =   2460
      TabIndex        =   23
      Top             =   1710
      Width           =   1095
   End
   Begin VB.Label lblMes 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      Caption         =   "Octubre :"
      Height          =   255
      Index           =   9
      Left            =   3600
      TabIndex        =   22
      Top             =   1710
      Width           =   1095
   End
   Begin VB.Label lblMes 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      Caption         =   "Noviembre :"
      Height          =   255
      Index           =   10
      Left            =   4740
      TabIndex        =   21
      Top             =   1710
      Width           =   1095
   End
   Begin VB.Label lblMes 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      Caption         =   "Diciembre :"
      Height          =   255
      Index           =   11
      Left            =   5880
      TabIndex        =   20
      Top             =   1710
      Width           =   1095
   End
   Begin VB.Label lblMes 
      Caption         =   "Presupuesto anual : "
      Height          =   255
      Index           =   12
      Left            =   180
      TabIndex        =   19
      Top             =   465
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.Label lblMes 
      Caption         =   "Año :"
      Height          =   255
      Index           =   13
      Left            =   4815
      TabIndex        =   18
      Top             =   90
      Width           =   510
   End
End
Attribute VB_Name = "frmPresupuestoFinancieroAnual"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim actL2 As ControlForm
Private oRs As ADOR.Recordset
Private mvarId As Long
Private Año As Integer
Private mTipo As String
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
   
         Dim est As EnumAcciones
         Dim Mes As Integer, mSeguro As Integer, i As Integer
         Dim oControl As Control
         
         If txtAño.Text <> Año Then
            mSeguro = MsgBox("Ha cambiado el año, esta seguro de continuar ?", vbYesNo, "Cambio de año")
            If mSeguro = vbNo Then
               Exit Sub
            Else
               With oRs
                  If .RecordCount > 0 Then
                     .MoveFirst
                     Do While Not .EOF
                        .Fields("IdPresupuestoFinanciero").Value = 0
                        .Fields("Año").Value = txtAño.Text
                        .Update
                        .MoveNext
                     Loop
                  End If
               End With
            End If
         End If
         
         With oRs
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  .Fields("Tipo").Value = "A"
                  Mes = .Fields("Mes").Value
                  For Each oControl In Me.Controls
                     If oControl.Name = "Text1" Then
                        If oControl.Index = Mes - 1 Then
                           If mTipo = "I" Then
                              .Fields("PresupuestoIngresos").Value = Val(oControl.Text)
                              .Fields("PresupuestoEgresos").Value = 0
                           Else
                              .Fields("PresupuestoEgresos").Value = Val(oControl.Text)
                              .Fields("PresupuestoIngresos").Value = 0
                           End If
                           Exit For
                        End If
                     End If
                  Next
                  .Update
                  .MoveNext
               Loop
               .MoveFirst
            End If
         End With
         
         est = Aplicacion.TablasGenerales.ActualizacionEnLotes("PresupuestoFinanciero", oRs)
         
         If mvarId < 0 Then
            est = alta
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "PresupuestoFinanciero"
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

Private Sub cmdDistribucion_Click()

'   Dim mAnual As Double, i As Integer
'   If IsNumeric(txtAnual.Text) Then
'      mAnual = txtAnual.Text
'      With origen.Registro
'         For i = 1 To 12
'            .Fields("PresupuestoTeoricoMes" & Format(i, "00")).Value = Round(mAnual / 12, 2)
'         Next
'      End With
'   End If
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim Mes As Integer, mIdRubroContable As Integer
   Dim oControl As Control
   
   mvarId = vnewvalue
   Año = CInt(VBA.Left(CStr(mvarId), 4))
   mIdRubroContable = CInt(VBA.mId(CStr(mvarId), 5))
   
   Set oRs = Aplicacion.RubrosContables.TraerFiltrado("_PorId", mIdRubroContable)
   
   txtDescripcion.Text = oRs.Fields("Descripcion").Value
   txtAño.Text = Año
   mTipo = IIf(IsNull(oRs.Fields("IngresoEgreso").Value), "E", oRs.Fields("IngresoEgreso").Value)
   oRs.Close
   
   If mTipo = "I" Then
      lblTipo.Caption = "Ingresos"
   Else
      lblTipo.Caption = "Egresos"
   End If
   
   Set oRs = CopiarTodosLosRegistros(Aplicacion.TablasGenerales.TraerFiltrado("PresupuestoFinanciero", "_PorIdRubroContableAño", Array(mIdRubroContable, Año, "A")))
   With oRs
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            Mes = oRs.Fields("Mes").Value
            For Each oControl In Me.Controls
               If oControl.Name = "Text1" Then
                  If oControl.Index = Mes - 1 Then
                     If mTipo = "I" Then
                        oControl.Text = .Fields("PresupuestoIngresos").Value
                     Else
                        oControl.Text = .Fields("PresupuestoEgresos").Value
                     End If
                     Exit For
                  End If
               End If
            Next
            .MoveNext
         Loop
      Else
         For Mes = 1 To 12
            .AddNew
            .Fields("IdPresupuestoFinanciero").Value = 0
            .Fields("Año").Value = Año
            .Fields("Mes").Value = Mes
            .Fields("Semana").Value = 0
            .Fields("IdRubroContable").Value = mIdRubroContable
            .Fields("PresupuestoIngresos").Value = 0
            .Fields("PresupuestoEgresos").Value = 0
            .Update
         Next
      End If
   End With
   
   cmd(1).Enabled = False
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      If mvarId > 0 Then cmd(1).Enabled = True
   End If
   
End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Form_Load()

   If mvarId < 0 Then cmd(1).Enabled = False
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set oRs = Nothing
   
End Sub

Private Sub Text1_GotFocus(Index As Integer)

   With Text1(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub Text1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub Text1_LostFocus(Index As Integer)

'   txtAnual.Text = PresupuestoAnual
   
End Sub

Private Sub txtAnual_GotFocus()

   With txtAnual
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAnual_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtAño_GotFocus()

   With txtAño
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAño_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

