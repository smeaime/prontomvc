VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmIBCondiciones 
   Caption         =   "Condiciones ( Impuesto a los ingresos brutos )"
   ClientHeight    =   6240
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8595
   Icon            =   "frmIBCondiciones.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6240
   ScaleWidth      =   8595
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtInformacionAuxiliar 
      DataField       =   "InformacionAuxiliar"
      Height          =   285
      Left            =   2520
      TabIndex        =   42
      Top             =   1305
      Width           =   1575
   End
   Begin VB.TextBox txtCodigoAFIP 
      DataField       =   "CodigoAFIP"
      Height          =   285
      Left            =   7830
      TabIndex        =   40
      Top             =   1305
      Width           =   585
   End
   Begin VB.TextBox txtCodigo 
      DataField       =   "Codigo"
      Height          =   285
      Left            =   7830
      TabIndex        =   38
      Top             =   945
      Width           =   585
   End
   Begin VB.Frame Frame4 
      Caption         =   "Percepciones : "
      Height          =   2085
      Left            =   135
      TabIndex        =   18
      Top             =   2745
      Width           =   8295
      Begin VB.TextBox txtAlicuotaPercepcionConvenio 
         Alignment       =   1  'Right Justify
         DataField       =   "AlicuotaPercepcionConvenio"
         Height          =   330
         Left            =   2565
         TabIndex        =   27
         Top             =   855
         Width           =   1095
      End
      Begin VB.TextBox txtAlicuotaPercepcion 
         Alignment       =   1  'Right Justify
         DataField       =   "AlicuotaPercepcion"
         Height          =   330
         Left            =   2565
         TabIndex        =   24
         Top             =   450
         Width           =   1095
      End
      Begin VB.TextBox txtImporteTopeMinimoPercepcion 
         Alignment       =   1  'Right Justify
         DataField       =   "ImporteTopeMinimoPercepcion"
         Height          =   330
         Left            =   135
         TabIndex        =   23
         Top             =   855
         Width           =   1095
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdCuentaPercepcionIIBB"
         Height          =   315
         Index           =   1
         Left            =   3780
         TabIndex        =   29
         Tag             =   "Cuentas"
         Top             =   450
         Width           =   4380
         _ExtentX        =   7726
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdCuenta"
         Text            =   ""
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdCuentaPercepcionIIBBConvenio"
         Height          =   315
         Index           =   2
         Left            =   3780
         TabIndex        =   31
         Tag             =   "Cuentas"
         Top             =   855
         Width           =   4380
         _ExtentX        =   7726
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdCuenta"
         Text            =   ""
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin MSDataListLib.DataCombo DataCombo1 
         DataField       =   "IdCuentaPercepcionIIBBCompras"
         Height          =   315
         Index           =   3
         Left            =   2565
         TabIndex        =   47
         Tag             =   "Cuentas"
         Top             =   1620
         Visible         =   0   'False
         Width           =   5595
         _ExtentX        =   9869
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "Titulo"
         BoundColumn     =   "IdCuenta"
         Text            =   ""
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label lblLabels 
         Caption         =   "Cuenta contable :"
         Height          =   240
         Index           =   12
         Left            =   1170
         TabIndex        =   48
         Top             =   1665
         Visible         =   0   'False
         Width           =   1320
      End
      Begin VB.Label lblLabels 
         Caption         =   "Alicuotas :"
         Height          =   195
         Index           =   11
         Left            =   2565
         TabIndex        =   46
         Top             =   270
         Width           =   840
      End
      Begin VB.Label lblLabels 
         Caption         =   "Compras :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   10
         Left            =   135
         TabIndex        =   45
         Top             =   1395
         Visible         =   0   'False
         Width           =   960
      End
      Begin VB.Label lblLabels 
         Caption         =   "Ventas :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   9
         Left            =   135
         TabIndex        =   44
         Top             =   225
         Width           =   960
      End
      Begin VB.Line Line1 
         BorderColor     =   &H80000005&
         X1              =   45
         X2              =   8280
         Y1              =   1305
         Y2              =   1305
      End
      Begin VB.Label lblLabels 
         Caption         =   "Cuentas contables :"
         Height          =   240
         Index           =   62
         Left            =   3780
         TabIndex        =   30
         Top             =   270
         Width           =   1455
      End
      Begin VB.Label lblLabels 
         Caption         =   "Conv. Multilat. :"
         Height          =   195
         Index           =   5
         Left            =   1350
         TabIndex        =   28
         Top             =   900
         Width           =   1110
      End
      Begin VB.Label lblLabels 
         Caption         =   "Cond. normal :"
         Height          =   195
         Index           =   1
         Left            =   1350
         TabIndex        =   26
         Top             =   495
         Width           =   1110
      End
      Begin VB.Label lblLabels 
         Caption         =   "Tope minimo :"
         Height          =   240
         Index           =   4
         Left            =   135
         TabIndex        =   25
         Top             =   675
         Width           =   1110
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Retenciones : "
      Height          =   1005
      Left            =   135
      TabIndex        =   17
      Top             =   1665
      Width           =   8295
      Begin VB.TextBox txtLeyendaPorcentajeAdicional 
         DataField       =   "LeyendaPorcentajeAdicional"
         Height          =   285
         Left            =   5580
         TabIndex        =   36
         Top             =   630
         Width           =   2580
      End
      Begin VB.TextBox txtPorcentajeAdicional 
         Alignment       =   1  'Right Justify
         DataField       =   "PorcentajeAdicional"
         Height          =   285
         Left            =   3330
         TabIndex        =   34
         Top             =   630
         Width           =   735
      End
      Begin VB.TextBox txtPorcentajeATomarSobreBase 
         Alignment       =   1  'Right Justify
         DataField       =   "PorcentajeATomarSobreBase"
         Height          =   285
         Left            =   7335
         TabIndex        =   32
         Top             =   270
         Width           =   825
      End
      Begin VB.TextBox txtAlicuota 
         Alignment       =   1  'Right Justify
         DataField       =   "Alicuota"
         Height          =   285
         Left            =   3330
         TabIndex        =   20
         Top             =   270
         Width           =   735
      End
      Begin VB.TextBox txtImporteTopeMinimo 
         Alignment       =   1  'Right Justify
         DataField       =   "ImporteTopeMinimo"
         Height          =   285
         Left            =   1215
         TabIndex        =   19
         Top             =   270
         Width           =   1095
      End
      Begin VB.Label lblLabels 
         Caption         =   "Leyenda % adic. :"
         Height          =   195
         Index           =   8
         Left            =   4185
         TabIndex        =   37
         Top             =   675
         Width           =   1290
      End
      Begin VB.Label lblLabels 
         Caption         =   "% adicional sobre impuesto calculado :"
         Height          =   195
         Index           =   7
         Left            =   90
         TabIndex        =   35
         Top             =   675
         Width           =   3180
      End
      Begin VB.Label lblLabels 
         Caption         =   "Porcentaje a tomar sobre base imponible : "
         Height          =   195
         Index           =   6
         Left            =   4185
         TabIndex        =   33
         Top             =   315
         Width           =   3045
      End
      Begin VB.Label lblLabels 
         Caption         =   "Alicuota :"
         Height          =   195
         Index           =   3
         Left            =   2430
         TabIndex        =   22
         Top             =   315
         Width           =   840
      End
      Begin VB.Label lblLabels 
         Caption         =   "Tope minimo :"
         Height          =   195
         Index           =   2
         Left            =   90
         TabIndex        =   21
         Top             =   315
         Width           =   1065
      End
   End
   Begin VB.Frame Frame2 
      Height          =   690
      Left            =   1440
      TabIndex        =   4
      Top             =   5400
      Width           =   6990
      Begin VB.OptionButton Option3 
         Caption         =   "Importe sin impuestos"
         Height          =   195
         Left            =   4545
         TabIndex        =   14
         Top             =   135
         Width           =   1815
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Importe total "
         Height          =   195
         Left            =   4545
         TabIndex        =   13
         Top             =   405
         Width           =   1770
      End
      Begin VB.Label Label2 
         Caption         =   "Base sobre la que se aplicara la alicuota del impuesto :"
         Height          =   240
         Left            =   90
         TabIndex        =   15
         Top             =   270
         Width           =   4290
      End
   End
   Begin VB.Frame Frame1 
      Height          =   420
      Left            =   1440
      TabIndex        =   3
      Top             =   4905
      Width           =   6990
      Begin VB.OptionButton Option2 
         Caption         =   "NO"
         Height          =   195
         Left            =   6300
         TabIndex        =   9
         Top             =   135
         Width           =   600
      End
      Begin VB.OptionButton Option1 
         Caption         =   "SI"
         Height          =   195
         Left            =   5625
         TabIndex        =   8
         Top             =   135
         Width           =   555
      End
      Begin VB.Label Label1 
         Caption         =   "Acumula mensualmente los importes pagados para el calculo del impuesto ? :"
         Height          =   195
         Left            =   90
         TabIndex        =   12
         Top             =   135
         Width           =   5550
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   345
      Index           =   0
      Left            =   135
      TabIndex        =   5
      Top             =   4950
      Width           =   1215
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   345
      Index           =   2
      Left            =   135
      TabIndex        =   7
      Top             =   5760
      Width           =   1215
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   345
      Index           =   1
      Left            =   135
      TabIndex        =   6
      Top             =   5355
      Width           =   1215
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   285
      Left            =   2520
      TabIndex        =   0
      Top             =   225
      Width           =   5895
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaVigencia"
      Height          =   330
      Index           =   0
      Left            =   2520
      TabIndex        =   2
      Top             =   945
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   582
      _Version        =   393216
      Format          =   64094209
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProvincia"
      Height          =   315
      Index           =   0
      Left            =   2520
      TabIndex        =   1
      Tag             =   "Provincias"
      Top             =   585
      Width           =   2835
      _ExtentX        =   5001
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProvincia"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProvinciaReal"
      Height          =   315
      Index           =   4
      Left            =   6525
      TabIndex        =   49
      Tag             =   "Provincias"
      Top             =   585
      Width           =   1890
      _ExtentX        =   3334
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProvincia"
      Text            =   ""
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Provincia real :"
      Height          =   240
      Index           =   5
      Left            =   5400
      TabIndex        =   50
      Top             =   630
      Width           =   1065
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Informacion auxiliar :"
      Height          =   240
      Index           =   4
      Left            =   180
      TabIndex        =   43
      Top             =   1320
      Width           =   2235
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo segun AFIP :"
      Height          =   240
      Index           =   3
      Left            =   4815
      TabIndex        =   41
      Top             =   1350
      Width           =   2910
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo interno del impuesto (opcional) : "
      Height          =   240
      Index           =   2
      Left            =   4815
      TabIndex        =   39
      Top             =   990
      Width           =   2910
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Provincia (aplicacion contable) :"
      Height          =   240
      Index           =   0
      Left            =   180
      TabIndex        =   16
      Top             =   630
      Width           =   2235
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de vigencia :"
      Height          =   240
      Index           =   0
      Left            =   180
      TabIndex        =   11
      Top             =   990
      Width           =   2235
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Jurisdiccion : "
      Height          =   285
      Index           =   1
      Left            =   180
      TabIndex        =   10
      Top             =   225
      Width           =   2235
   End
End
Attribute VB_Name = "frmIBCondiciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.IBCondicion
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
   
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe indicar la provincia", vbExclamation
            Exit Sub
         End If
         
         If Val(txtPorcentajeAdicional.Text) <> 0 And _
               Len(txtLeyendaPorcentajeAdicional.Text) = 0 Then
            MsgBox "Debe indicar la leyenda para el porcentaje adicional", vbExclamation
            Exit Sub
         End If
         
         Dim est As EnumAcciones
         Dim oControl As Control
   
         With origen.Registro
            For Each oControl In Me.Controls
               If TypeOf oControl Is DataCombo Then
                  If Len(oControl.BoundText) <> 0 Then
                     .Fields(oControl.DataField).Value = oControl.BoundText
                  End If
               ElseIf TypeOf oControl Is DTPicker Then
                  .Fields(oControl.DataField).Value = oControl.Value
               End If
            Next
            If Option1.Value = True Then
               .Fields("AcumulaMensualmente").Value = "SI"
            Else
               .Fields("AcumulaMensualmente").Value = "NO"
            End If
            If Option3.Value = True Then
               .Fields("BaseCalculo").Value = "SIN IMPUESTOS"
            Else
               .Fields("BaseCalculo").Value = "TOTAL PAGADO"
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
            
         With actL2
            .ListaEditada = "IBCondiciones1,IBCondiciones2"
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
            
         With actL2
            .ListaEditada = "IBCondiciones1,IBCondiciones2"
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
   Set origen = oAp.IBCondiciones.Item(vnewvalue)
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
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
   
   If mvarId <= 0 Then
      Option2.Value = True
      Option3.Value = True
      DTFields(0).Value = Date
      With origen.Registro
         .Fields("FechaVigencia").Value = Date
         .Fields("PorcentajeATomarSobreBase").Value = 100
         .Fields("PorcentajeAdicional").Value = 0
      End With
   Else
      With origen.Registro
         If IsNull(.Fields("AcumulaMensualmente").Value) Or _
               .Fields("AcumulaMensualmente").Value = "NO" Then
            Option2.Value = True
         Else
            Option1.Value = True
         End If
         If IsNull(.Fields("BaseCalculo").Value) Or _
               .Fields("BaseCalculo").Value = "SIN IMPUESTOS" Then
            Option3.Value = True
         Else
            Option4.Value = True
         End If
         If IsNull(.Fields("PorcentajeATomarSobreBase").Value) Then
            .Fields("PorcentajeATomarSobreBase").Value = 100
         End If
         If IsNull(.Fields("PorcentajeAdicional").Value) Then
            .Fields("PorcentajeAdicional").Value = 0
         End If
      End With
   End If
   
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

Private Sub DataCombo1_GotFocus(Index As Integer)

   SendKeys "%{DOWN}"
   
End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

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

Private Sub txtAlicuota_GotFocus()

   With txtAlicuota
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAlicuota_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtAlicuotaPercepcion_GotFocus()

   With txtAlicuotaPercepcion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAlicuotaPercepcion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoAFIP_GotFocus()

   With txtCodigoAFIP
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoAFIP_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtDescripcion_GotFocus()

   With txtDescripcion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDescripcion
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtImporteTopeMinimo_GotFocus()

   With txtImporteTopeMinimo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImporteTopeMinimo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtImporteTopeMinimoPercepcion_GotFocus()

   With txtImporteTopeMinimoPercepcion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtImporteTopeMinimoPercepcion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtInformacionAuxiliar_GotFocus()

   With txtInformacionAuxiliar
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtInformacionAuxiliar_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtInformacionAuxiliar
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

