VERSION 5.00
Begin VB.Form frmPresupuestoEconomico 
   Caption         =   "Presupuesto economico (Teorico)"
   ClientHeight    =   4170
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4905
   Icon            =   "frmPresupuestoEconomico.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4170
   ScaleWidth      =   4905
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtEjercicio 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      Height          =   285
      Left            =   1215
      Locked          =   -1  'True
      TabIndex        =   31
      Top             =   90
      Width           =   3555
   End
   Begin VB.TextBox txtDescripcion 
      Enabled         =   0   'False
      Height          =   285
      Left            =   1215
      Locked          =   -1  'True
      TabIndex        =   16
      Top             =   450
      Width           =   3555
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   1710
      TabIndex        =   14
      Top             =   3600
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   13
      Top             =   3600
      Width           =   1485
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      DataField       =   "PresupuestoTeoricoMes01"
      Height          =   285
      Index           =   0
      Left            =   1215
      TabIndex        =   1
      Top             =   1350
      Width           =   1170
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      DataField       =   "PresupuestoTeoricoMes02"
      Height          =   285
      Index           =   1
      Left            =   1215
      TabIndex        =   2
      Top             =   1710
      Width           =   1170
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      DataField       =   "PresupuestoTeoricoMes03"
      Height          =   285
      Index           =   2
      Left            =   1215
      TabIndex        =   3
      Top             =   2070
      Width           =   1170
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      DataField       =   "PresupuestoTeoricoMes04"
      Height          =   285
      Index           =   3
      Left            =   1215
      TabIndex        =   4
      Top             =   2430
      Width           =   1170
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      DataField       =   "PresupuestoTeoricoMes05"
      Height          =   285
      Index           =   4
      Left            =   1215
      TabIndex        =   5
      Top             =   2790
      Width           =   1170
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      DataField       =   "PresupuestoTeoricoMes06"
      Height          =   285
      Index           =   5
      Left            =   1215
      TabIndex        =   6
      Top             =   3150
      Width           =   1170
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      DataField       =   "PresupuestoTeoricoMes07"
      Height          =   285
      Index           =   6
      Left            =   3600
      TabIndex        =   7
      Top             =   1350
      Width           =   1170
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      DataField       =   "PresupuestoTeoricoMes08"
      Height          =   285
      Index           =   7
      Left            =   3600
      TabIndex        =   8
      Top             =   1710
      Width           =   1170
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      DataField       =   "PresupuestoTeoricoMes09"
      Height          =   285
      Index           =   8
      Left            =   3600
      TabIndex        =   9
      Top             =   2070
      Width           =   1170
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      DataField       =   "PresupuestoTeoricoMes10"
      Height          =   285
      Index           =   9
      Left            =   3600
      TabIndex        =   10
      Top             =   2430
      Width           =   1170
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      DataField       =   "PresupuestoTeoricoMes11"
      Height          =   285
      Index           =   10
      Left            =   3600
      TabIndex        =   11
      Top             =   2790
      Width           =   1170
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      DataField       =   "PresupuestoTeoricoMes12"
      Height          =   285
      Index           =   11
      Left            =   3600
      TabIndex        =   12
      Top             =   3150
      Width           =   1170
   End
   Begin VB.TextBox txtAnual 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   1755
      TabIndex        =   0
      Top             =   810
      Width           =   1170
   End
   Begin VB.CommandButton cmdDistribucion 
      Caption         =   "Distribuir por mes"
      Height          =   285
      Left            =   3015
      TabIndex        =   15
      Top             =   810
      Width           =   1770
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Ejercicio :"
      Height          =   255
      Index           =   0
      Left            =   135
      TabIndex        =   32
      Top             =   105
      Width           =   1005
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Cuenta :"
      Height          =   255
      Index           =   1
      Left            =   135
      TabIndex        =   30
      Top             =   465
      Width           =   1005
   End
   Begin VB.Label lblMes 
      Caption         =   "Enero :"
      Height          =   255
      Index           =   0
      Left            =   135
      TabIndex        =   29
      Top             =   1365
      Width           =   1005
   End
   Begin VB.Label lblMes 
      Caption         =   "Febrero :"
      Height          =   255
      Index           =   1
      Left            =   135
      TabIndex        =   28
      Top             =   1725
      Width           =   1005
   End
   Begin VB.Label lblMes 
      Caption         =   "Marzo :"
      Height          =   255
      Index           =   2
      Left            =   135
      TabIndex        =   27
      Top             =   2085
      Width           =   1005
   End
   Begin VB.Label lblMes 
      Caption         =   "Abril :"
      Height          =   255
      Index           =   3
      Left            =   135
      TabIndex        =   26
      Top             =   2445
      Width           =   1005
   End
   Begin VB.Label lblMes 
      Caption         =   "Mayo :"
      Height          =   255
      Index           =   4
      Left            =   135
      TabIndex        =   25
      Top             =   2805
      Width           =   1005
   End
   Begin VB.Label lblMes 
      Caption         =   "Junio :"
      Height          =   255
      Index           =   5
      Left            =   135
      TabIndex        =   24
      Top             =   3165
      Width           =   1005
   End
   Begin VB.Label lblMes 
      Caption         =   "Julio :"
      Height          =   255
      Index           =   6
      Left            =   2520
      TabIndex        =   23
      Top             =   1365
      Width           =   1005
   End
   Begin VB.Label lblMes 
      Caption         =   "Agosto :"
      Height          =   255
      Index           =   7
      Left            =   2520
      TabIndex        =   22
      Top             =   1725
      Width           =   1005
   End
   Begin VB.Label lblMes 
      Caption         =   "Setiembre :"
      Height          =   255
      Index           =   8
      Left            =   2520
      TabIndex        =   21
      Top             =   2085
      Width           =   1005
   End
   Begin VB.Label lblMes 
      Caption         =   "Octubre :"
      Height          =   255
      Index           =   9
      Left            =   2520
      TabIndex        =   20
      Top             =   2445
      Width           =   1005
   End
   Begin VB.Label lblMes 
      Caption         =   "Noviembre :"
      Height          =   255
      Index           =   10
      Left            =   2520
      TabIndex        =   19
      Top             =   2805
      Width           =   1005
   End
   Begin VB.Label lblMes 
      Caption         =   "Diciembre :"
      Height          =   255
      Index           =   11
      Left            =   2520
      TabIndex        =   18
      Top             =   3165
      Width           =   1005
   End
   Begin VB.Label lblMes 
      Caption         =   "Presupuesto anual : "
      Height          =   255
      Index           =   12
      Left            =   135
      TabIndex        =   17
      Top             =   825
      Width           =   1500
   End
End
Attribute VB_Name = "frmPresupuestoEconomico"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.CuentaEjercicioContable
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long, mIdCuenta As Long
Private mMesInicial As Integer, mIdEjercicioContable As Integer
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
         Dim oControl As Control
   
         With origen.Registro
            For Each oControl In Me.Controls
               If TypeOf oControl Is DataCombo Then
                  If Len(oControl.BoundText) <> 0 Then
                     origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
                  End If
               ElseIf TypeOf oControl Is DTPicker Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.Value
               End If
            Next
            .Fields("IdCuenta").Value = Me.IdCuenta
            .Fields("IdEjercicioContable").Value = Me.IdEjercicioContable
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
            est = Modificacion
            mvarId = origen.Registro.Fields(0).Value
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "+SubPEb"
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
   Dim oRs As ADOR.Recordset
   
   If vnewvalue < 0 Then
      Me.IdCuenta = Abs(vnewvalue)
      vnewvalue = -1
   End If
   mvarId = vnewvalue
   
   mMesInicial = 1
   
   Set oAp = Aplicacion
   Set origen = oAp.CuentasEjerciciosContables.Item(mvarId)
   Set oBind = New BindingCollection
   
   Set oRs = oAp.EjerciciosContables.TraerFiltrado("_PorId", Me.IdEjercicioContable)
   If oRs.RecordCount > 0 Then
      mMesInicial = Month(oRs.Fields("FechaInicio").Value)
      txtEjercicio.Text = "" & IIf(IsNull(oRs.Fields("NumeroEjercicio").Value), "", oRs.Fields("NumeroEjercicio").Value) & " " & _
               "del " & IIf(IsNull(oRs.Fields("FechaInicio").Value), "", oRs.Fields("FechaInicio").Value) & " " & _
               "al " & IIf(IsNull(oRs.Fields("FechaFinalizacion").Value), "", oRs.Fields("FechaFinalizacion").Value)
   End If
   oRs.Close
   
   CargarControles
   
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
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
   
   If mvarId > 0 Then
      With origen.Registro
         Me.IdCuenta = .Fields("IdCuenta").Value
      End With
      txtAnual.Text = PresupuestoAnual
   End If
   
   Set oRs = oAp.Cuentas.TraerFiltrado("_PorId", Me.IdCuenta)
   If oRs.RecordCount > 0 Then
      txtDescripcion.Text = "" & IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value) & " " & _
               " " & IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
   End If
   oRs.Close
   
'   cmd(1).Enabled = False
'   cmd(0).Enabled = False
'   If Me.NivelAcceso = Medio Then
'      If mvarId <= 0 Then cmd(0).Enabled = True
'   ElseIf Me.NivelAcceso = Alto Then
'      cmd(0).Enabled = True
'      If mvarId > 0 Then cmd(1).Enabled = True
'   End If
   
   Set oRs = Nothing
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub cmdDistribucion_Click()

   Dim mAnual As Double, i As Integer
   If IsNumeric(txtAnual.Text) Then
      mAnual = txtAnual.Text
      With origen.Registro
         For i = 1 To 12
            .Fields("PresupuestoTeoricoMes" & Format(i, "00")).Value = Round(mAnual / 12, 2)
         Next
      End With
   End If
   
End Sub

Private Sub Form_Load()

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

   txtAnual.Text = PresupuestoAnual
   
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

Public Function PresupuestoAnual() As Double

   Dim mAnual As Double, i As Integer
   
   With origen.Registro
      For i = 1 To 12
         mAnual = mAnual + IIf(IsNull(.Fields("PresupuestoTeoricoMes" & Format(i, "00")).Value), 0, .Fields("PresupuestoTeoricoMes" & Format(i, "00")).Value)
      Next
   End With
   PresupuestoAnual = mAnual

End Function

Public Sub CargarControles()

   Dim i As Integer, Mes As Integer
   
   Mes = mMesInicial
   For i = 0 To 11
      lblMes(i).Caption = NombreMes(Mes) & " :"
      Text1(i).DataField = "PresupuestoTeoricoMes" & Format(Mes, "00")
      Mes = Mes + 1
      If Mes > 12 Then Mes = 1
   Next

End Sub

Public Property Get IdEjercicioContable() As Integer

   IdEjercicioContable = mIdEjercicioContable

End Property

Public Property Let IdEjercicioContable(ByVal vnewvalue As Integer)

   mIdEjercicioContable = vnewvalue

End Property

Public Property Get IdCuenta() As Long

   IdCuenta = mIdCuenta

End Property

Public Property Let IdCuenta(ByVal vnewvalue As Long)

   mIdCuenta = vnewvalue

End Property
