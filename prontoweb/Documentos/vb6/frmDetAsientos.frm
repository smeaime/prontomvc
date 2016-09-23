VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetAsientos 
   Caption         =   "Item de asiento contable"
   ClientHeight    =   4605
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8715
   Icon            =   "frmDetAsientos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4605
   ScaleWidth      =   8715
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtItem 
      Alignment       =   2  'Center
      DataField       =   "Item"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   8055
      TabIndex        =   58
      Top             =   135
      Width           =   600
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Registrar en analitico "
      Height          =   600
      Left            =   6660
      TabIndex        =   57
      Top             =   1350
      Width           =   1950
   End
   Begin VB.TextBox txtPorcentajeIVA 
      Alignment       =   1  'Right Justify
      DataField       =   "PorcentajeIVA"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   7335
      TabIndex        =   55
      Top             =   4185
      Width           =   1230
   End
   Begin VB.Frame Frame2 
      Caption         =   "El pase es : "
      Height          =   1005
      Left            =   4365
      TabIndex        =   51
      Top             =   3465
      Width           =   1365
      Begin VB.OptionButton Option5 
         Caption         =   "Gravado"
         Height          =   240
         Left            =   90
         TabIndex        =   54
         Top             =   450
         Width           =   960
      End
      Begin VB.OptionButton Option4 
         Caption         =   "IVA"
         Height          =   195
         Left            =   90
         TabIndex        =   53
         Top             =   225
         Width           =   960
      End
      Begin VB.OptionButton Option6 
         Caption         =   "No Gravado"
         Height          =   240
         Left            =   90
         TabIndex        =   52
         Top             =   675
         Width           =   1230
      End
   End
   Begin VB.TextBox txtImporteEnMonedaDestino 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteEnMonedaDestino"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   7155
      TabIndex        =   48
      Top             =   2520
      Width           =   1410
   End
   Begin VB.TextBox txtCotizacionMonedaDestino 
      Alignment       =   1  'Right Justify
      DataField       =   "CotizacionMonedaDestino"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   4545
      TabIndex        =   42
      Top             =   2520
      Width           =   825
   End
   Begin VB.TextBox txtCodigoCuenta 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   4215
      TabIndex        =   3
      Top             =   930
      Width           =   780
   End
   Begin VB.CheckBox Check2 
      Height          =   195
      Left            =   2190
      TabIndex        =   36
      Top             =   570
      Width           =   195
   End
   Begin VB.TextBox txtCodigoComprobante 
      Alignment       =   2  'Center
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   4230
      TabIndex        =   6
      Top             =   4635
      Visible         =   0   'False
      Width           =   555
   End
   Begin VB.TextBox txtSigno 
      Alignment       =   2  'Center
      DataField       =   "Signo"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   2340
      TabIndex        =   10
      Top             =   5310
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.TextBox txtCT 
      Height          =   330
      Left            =   4635
      TabIndex        =   34
      Top             =   6165
      Visible         =   0   'False
      Width           =   330
   End
   Begin VB.TextBox txtHaber 
      Alignment       =   1  'Right Justify
      DataField       =   "Haber"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   3330
      TabIndex        =   15
      Top             =   3015
      Width           =   1095
   End
   Begin VB.TextBox txtSI 
      Height          =   330
      Left            =   5040
      TabIndex        =   32
      Top             =   6165
      Visible         =   0   'False
      Width           =   330
   End
   Begin VB.TextBox txtTI 
      Height          =   330
      Left            =   5400
      TabIndex        =   31
      Top             =   5760
      Visible         =   0   'False
      Width           =   330
   End
   Begin VB.TextBox txtLI 
      Height          =   330
      Left            =   4995
      TabIndex        =   30
      Top             =   5760
      Visible         =   0   'False
      Width           =   330
   End
   Begin VB.TextBox txtTC 
      Height          =   330
      Left            =   4590
      TabIndex        =   29
      Top             =   5760
      Visible         =   0   'False
      Width           =   330
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   1
      ItemData        =   "frmDetAsientos.frx":076A
      Left            =   2295
      List            =   "frmDetAsientos.frx":077A
      TabIndex        =   12
      Top             =   5910
      Visible         =   0   'False
      Width           =   2040
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Index           =   0
      ItemData        =   "frmDetAsientos.frx":07BC
      Left            =   2295
      List            =   "frmDetAsientos.frx":07C9
      TabIndex        =   11
      Top             =   5580
      Visible         =   0   'False
      Width           =   2040
   End
   Begin VB.TextBox txtCuit 
      DataField       =   "Cuit"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   2295
      TabIndex        =   13
      Top             =   6255
      Visible         =   0   'False
      Width           =   2040
   End
   Begin VB.TextBox txtNumeroComprobante 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroComprobante"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   7335
      TabIndex        =   9
      Top             =   3465
      Width           =   1230
   End
   Begin VB.Frame Frame1 
      Height          =   1005
      Left            =   1890
      TabIndex        =   18
      Top             =   3465
      Width           =   2400
      Begin VB.OptionButton Option3 
         Caption         =   "Enviar al libro IVA Compras"
         Height          =   240
         Left            =   90
         TabIndex        =   50
         Top             =   675
         Width           =   2220
      End
      Begin VB.OptionButton Option1 
         Caption         =   "No enviar a los libros"
         Height          =   195
         Left            =   90
         TabIndex        =   22
         Top             =   180
         Width           =   1860
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Enviar al libro IVA Ventas"
         Enabled         =   0   'False
         Height          =   240
         Left            =   90
         TabIndex        =   21
         Top             =   405
         Width           =   2130
      End
   End
   Begin VB.TextBox txtDebe 
      Alignment       =   1  'Right Justify
      DataField       =   "Debe"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1034
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1035
      TabIndex        =   14
      Top             =   3015
      Width           =   1095
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   480
      Index           =   0
      Left            =   135
      TabIndex        =   16
      Top             =   3465
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   495
      Index           =   1
      Left            =   135
      TabIndex        =   17
      Top             =   4005
      Width           =   1485
   End
   Begin VB.TextBox txtDetalle 
      DataField       =   "Detalle"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1530
      TabIndex        =   5
      Top             =   2160
      Width           =   7035
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      DataField       =   "IdTipoComprobante"
      Height          =   1935
      Index           =   0
      Left            =   5805
      TabIndex        =   7
      Tag             =   "TiposComprobante"
      Top             =   4680
      Visible         =   0   'False
      Width           =   2985
      _ExtentX        =   5265
      _ExtentY        =   3413
      _Version        =   393216
      Style           =   1
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoComprobante"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaComprobante"
      Height          =   330
      Index           =   0
      Left            =   7335
      TabIndex        =   8
      Top             =   3825
      Width           =   1245
      _ExtentX        =   2196
      _ExtentY        =   582
      _Version        =   393216
      Format          =   59310081
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuenta"
      Height          =   315
      Index           =   0
      Left            =   5040
      TabIndex        =   4
      Tag             =   "Cuentas"
      Top             =   945
      Width           =   3585
      _ExtentX        =   6324
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuenta"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaGasto"
      Height          =   315
      Index           =   1
      Left            =   2430
      TabIndex        =   1
      Tag             =   "CuentasGastos"
      Top             =   525
      Width           =   6210
      _ExtentX        =   10954
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaGasto"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdObra"
      Height          =   315
      Index           =   2
      Left            =   2160
      TabIndex        =   0
      Tag             =   "Obras"
      Top             =   135
      Width           =   5340
      _ExtentX        =   9419
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   3
      Left            =   2160
      TabIndex        =   2
      Tag             =   "TiposCuentaGrupos"
      Top             =   930
      Width           =   1995
      _ExtentX        =   3519
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoCuentaGrupo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCuentaBancaria"
      Height          =   315
      Index           =   4
      Left            =   2160
      TabIndex        =   40
      Tag             =   "CuentasBancarias"
      Top             =   1305
      Width           =   4350
      _ExtentX        =   7673
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdCuentaBancaria"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCaja"
      Height          =   315
      Index           =   5
      Left            =   2160
      TabIndex        =   43
      Tag             =   "Cajas"
      Top             =   1665
      Width           =   4335
      _ExtentX        =   7646
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCaja"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdMonedaDestino"
      Height          =   315
      Index           =   6
      Left            =   1530
      TabIndex        =   44
      Tag             =   "Monedas"
      Top             =   2520
      Width           =   1440
      _ExtentX        =   2540
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdMoneda"
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
      DataField       =   "IdProvinciaDestino"
      Height          =   315
      Index           =   7
      Left            =   6075
      TabIndex        =   60
      Tag             =   "Provincias"
      Top             =   3015
      Visible         =   0   'False
      Width           =   2505
      _ExtentX        =   4419
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProvincia"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Prov.destino :"
      Height          =   255
      Index           =   19
      Left            =   4860
      TabIndex        =   61
      Top             =   3060
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Item :"
      Height          =   300
      Index           =   18
      Left            =   7605
      TabIndex        =   59
      Top             =   135
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Caption         =   "Porcentaje de IVA :"
      Height          =   255
      Index           =   17
      Left            =   5850
      TabIndex        =   56
      Top             =   4230
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Importe mon.destino : "
      Height          =   255
      Index           =   16
      Left            =   5535
      TabIndex        =   49
      Top             =   2565
      Width           =   1545
   End
   Begin VB.Label lblLabels 
      Caption         =   "Caja :"
      Height          =   300
      Index           =   15
      Left            =   180
      TabIndex        =   47
      Top             =   1680
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Moneda destino :"
      Height          =   255
      Index           =   23
      Left            =   180
      TabIndex        =   46
      Top             =   2565
      Width           =   1275
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cotiz.mon.destino : "
      Height          =   255
      Index           =   14
      Left            =   3105
      TabIndex        =   45
      Top             =   2565
      Width           =   1365
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta banco :"
      Height          =   300
      Index           =   6
      Left            =   180
      TabIndex        =   41
      Top             =   1305
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Todas las cuentas :"
      Height          =   300
      Index           =   13
      Left            =   180
      TabIndex        =   39
      Top             =   915
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cuenta de gasto :"
      Height          =   300
      Index           =   12
      Left            =   180
      TabIndex        =   38
      Top             =   525
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obra : "
      Height          =   255
      Index           =   2
      Left            =   180
      TabIndex        =   37
      Top             =   165
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Signo ( +  - ) :"
      Height          =   300
      Index           =   11
      Left            =   360
      TabIndex        =   35
      Top             =   5310
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      X1              =   -45
      X2              =   8685
      Y1              =   2070
      Y2              =   2070
   End
   Begin VB.Label lblLabels 
      Caption         =   "Haber :"
      Height          =   255
      Index           =   10
      Left            =   2430
      TabIndex        =   33
      Top             =   3060
      Width           =   735
   End
   Begin VB.Label lblLabels 
      Caption         =   "C.U.I.T. :"
      Height          =   300
      Index           =   9
      Left            =   315
      TabIndex        =   28
      Top             =   6270
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tipo de pase :"
      Height          =   300
      Index           =   7
      Left            =   315
      TabIndex        =   27
      Top             =   5940
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Va al libro ?  :"
      Height          =   300
      Index           =   5
      Left            =   315
      TabIndex        =   26
      Top             =   5580
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro. comprobante :"
      Height          =   255
      Index           =   4
      Left            =   5850
      TabIndex        =   25
      Top             =   3510
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha :"
      Height          =   255
      Index           =   3
      Left            =   5850
      TabIndex        =   24
      Top             =   3870
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tipo de comprobante :"
      Height          =   300
      Index           =   0
      Left            =   2250
      TabIndex        =   23
      Top             =   4635
      Visible         =   0   'False
      Width           =   1905
   End
   Begin VB.Label lblLabels 
      Caption         =   "Debe :"
      Height          =   255
      Index           =   8
      Left            =   180
      TabIndex        =   20
      Top             =   3060
      Width           =   735
   End
   Begin VB.Label lblLabels 
      Caption         =   "Detalle :"
      Height          =   255
      Index           =   1
      Left            =   180
      TabIndex        =   19
      Top             =   2205
      Width           =   1275
   End
End
Attribute VB_Name = "frmDetAsientos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DetAsiento
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim oAsiento As ComPronto.Asiento
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long, mvarIdObra As Long, mvarIdMoneda As Long
Private mvarIdTipoCuentaGrupoIVA As Long, mvarIdMonedaPesos As Long
Private mvarCotizacionMonedaDestino As Double
Private mvarJerarquia As String
Private mFechaAsiento As Date

Private Sub Check2_Click()

   If Check2.Value = 0 Then
      Dim mIdCuenta As Long
      origen.Registro.Fields(DataCombo1(1).DataField).Value = Null
      origen.Registro.Fields(DataCombo1(2).DataField).Value = Null
      txtCodigoCuenta.Enabled = True
      mIdCuenta = 0
      With DataCombo1(0)
         If IsNumeric(.BoundText) Then mIdCuenta = .BoundText
         Set .RowSource = Aplicacion.Cuentas.TraerLista
         origen.Registro.Fields(.DataField).Value = mIdCuenta
         .Enabled = True
      End With
      With DataCombo1(3)
         .BoundText = 0
         .Enabled = True
      End With
   End If
   
End Sub

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then
      
      If Not IsNumeric(DataCombo1(0).BoundText) Then
         MsgBox "Debe indicar la cuenta", vbExclamation
         Exit Sub
      End If
      
      If DataCombo1(4).Enabled And Not IsNumeric(DataCombo1(4).BoundText) Then
         MsgBox "Debe indicar la cuenta banco", vbExclamation
         Exit Sub
      End If
         
      If DataCombo1(5).Enabled And Not IsNumeric(DataCombo1(5).BoundText) Then
         MsgBox "Debe indicar la cuenta caja", vbExclamation
         Exit Sub
      End If
         
      If (DataCombo1(4).Enabled Or DataCombo1(5).Enabled) And _
            Not IsNumeric(DataCombo1(6).BoundText) Then
         MsgBox "Debe indicar la moneda", vbExclamation
         Exit Sub
      End If
         
      If Len(txtDebe.Text) = 0 Or Not IsNumeric(txtDebe.Text) Then
         origen.Registro.Fields("Debe").Value = Null
      End If
      If Len(txtHaber.Text) = 0 Or Not IsNumeric(txtHaber.Text) Then
         origen.Registro.Fields("Haber").Value = Null
      End If
      
      If (Len(txtDebe.Text) = 0 Or Not IsNumeric(txtDebe.Text)) And _
            (Len(txtHaber.Text) = 0 Or Not IsNumeric(txtHaber.Text)) Then
         MsgBox "Debe indicar el importe (Debe o Haber)", vbExclamation
         Exit Sub
      End If
      
      If Not Option1.Value Then
         If Len(txtNumeroComprobante.Text) = 0 Then
            MsgBox "Debe indicar el numero de comprobante", vbExclamation
            Exit Sub
         End If
         If Not Option4.Value And Not Option5.Value And Not Option6.Value Then
            MsgBox "Debe indicar el tipo de pase", vbExclamation
            Exit Sub
         End If
         If Len(txtPorcentajeIVA.Text) = 0 Then
            MsgBox "Debe indicar el porcentaje de iva o cero", vbExclamation
            Exit Sub
         End If
      End If
      
      Dim dtp As DTPicker
      Dim dc As DataCombo
      
      With origen.Registro
         For Each dtp In DTFields
            .Fields(dtp.DataField).Value = dtp.Value
         Next
         For Each dc In DataCombo1
            If dc.Enabled And dc.Visible And Len(dc.DataField) > 0 Then
               If Not IsNumeric(dc.BoundText) And dc.Index <> 1 And dc.Index <> 2 Then
                  If dc.Index <> 7 Or _
                        (dc.Index = 7 And mId(mvarJerarquia, 1, 1) = "6") Then
                     MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                     Exit Sub
                  End If
               End If
               If IsNumeric(dc.BoundText) Then
                  origen.Registro.Fields(dc.DataField).Value = dc.BoundText
               End If
            End If
         Next
         If Not Option1.Value Then
            .Fields("FechaComprobante").Value = DTFields(0).Value
            If Option2.Value Then .Fields("Libro").Value = "V"
            If Option3.Value Then .Fields("Libro").Value = "C"
            If Option4.Value Then .Fields("TipoImporte").Value = "I"
            If Option5.Value Then .Fields("TipoImporte").Value = "G"
            If Option6.Value Then .Fields("TipoImporte").Value = "N"
         Else
            .Fields("IdTipoComprobante").Value = Null
            .Fields("FechaComprobante").Value = Null
            .Fields("NumeroComprobante").Value = Null
            .Fields("TipoImporte").Value = Null
            .Fields("Libro").Value = Null
         End If
         If Check1.Enabled Then
            If Check1.Value = 1 Then
               .Fields("RegistrarEnAnalitico").Value = "SI"
            Else
               .Fields("RegistrarEnAnalitico").Value = "NO"
            End If
         End If
      End With
      
      origen.Modificado = True
      Aceptado = True
   
   End If
   
   Me.Hide

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   
   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oAsiento.DetAsientos.Item(vNewValue)
   Me.IdNuevo = origen.Id
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      mvarIdMonedaPesos = .Fields("IdMoneda").Value
   End With
   oRs.Close
   
   Set oBind = New BindingCollection
   
   With oBind
      Set .DataSource = origen
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "CuentasBancarias" Or oControl.Tag = "Cajas" Then
'                  Set oControl.RowSource = oAp.CuentasBancarias.TraerFiltrado("_TodasParaCombo")
               ElseIf oControl.Tag = "Obras" Then
                  If glbSeñal1 Then
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo", Array("SI", Me.FechaAsiento))
                  Else
                     Set oControl.RowSource = oAp.Obras.TraerFiltrado("_TodasActivasParaCombo")
                  End If
               ElseIf oControl.Tag = "Cuentas" Then
                  If glbSeñal1 Then
                     Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_PorFechaParaCombo", Me.FechaAsiento)
                  Else
                     Set oControl.RowSource = oAp.Cuentas.TraerLista
                  End If
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            .Add oControl, "text", oControl.DataField
         End If
      Next
   End With
   
   Combo1(0).ListIndex = 0
   Combo1(1).ListIndex = 0
   DTFields(0).Value = Date
   Option1.Value = True
   
   If mvarId = -1 Then
      With origen.Registro
         If IsNull(.Fields("IdMonedaDestino").Value) Then
            .Fields("IdMonedaDestino").Value = mvarIdMonedaPesos
         End If
         .Fields("Item").Value = oAsiento.DetAsientos.ProximoItem
      End With
      Option1.Value = True
   Else
      With origen.Registro
         If IsNull(.Fields("Libro").Value) Then
            Option1.Value = True
         Else
            If .Fields("Libro").Value = "V" Then
               Option2.Value = True
            ElseIf .Fields("Libro").Value = "C" Then
               Option3.Value = True
            End If
            If .Fields("TipoImporte").Value = "I" Then
               Option4.Value = True
            ElseIf .Fields("TipoImporte").Value = "G" Then
               Option5.Value = True
            ElseIf .Fields("TipoImporte").Value = "E" Then
               Option6.Value = True
            End If
            DTFields(0).Value = .Fields("FechaComprobante").Value
         End If
         If IsNull(.Fields("RegistrarEnAnalitico").Value) Or _
               .Fields("RegistrarEnAnalitico").Value = "SI" Then
            Check1.Value = 1
         End If
      End With
   End If
   
   CalcularImporteEnMonedaDestino
   
   Set oAp = Nothing
   
   If BuscarClaveINI("Requerir provincia destino en asientos") = "SI" Then
      lblLabels(19).Visible = True
      DataCombo1(7).Visible = True
   End If

End Property

Public Property Get Asiento() As ComPronto.Asiento

   Set Asiento = oAsiento

End Property

Public Property Set Asiento(ByVal vNewValue As ComPronto.Asiento)

   Set oAsiento = vNewValue

End Property

Private Sub Combo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DataCombo1_Change(Index As Integer)

   If IsNumeric(DataCombo1(Index).BoundText) And _
         DataCombo1(Index).Text <> DataCombo1(Index).BoundText Then
      Dim oRs As ADOR.Recordset
      Dim oRsAux As ADOR.Recordset
      Dim i As Integer, mIdBanco As Integer
      Dim mIdAux As Long
      Select Case Index
         Case 0
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorIdConDatos", Array(DataCombo1(Index).BoundText, Me.FechaAsiento))
            If oRs.RecordCount > 0 Then
               With origen.Registro
                  .Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
                  txtCodigoCuenta.Text = oRs.Fields("Codigo1").Value
                  If Not IsNull(oRs.Fields("IdObra").Value) Then
                     .Fields("IdObra").Value = oRs.Fields("IdObra").Value
                  Else
'                    .Fields("IdObra").Value = Null
                  End If
                  mvarJerarquia = IIf(IsNull(oRs.Fields("Jerarquia").Value), "", oRs.Fields("Jerarquia").Value)
               End With
               
               mIdBanco = IIf(IsNull(oRs.Fields("IdBanco").Value), 0, oRs.Fields("IdBanco").Value)
               If Not IsNull(oRs.Fields("EsCajaBanco").Value) And _
                     oRs.Fields("EsCajaBanco").Value = "BA" Then
                  With DataCombo1(4)
                     If mIdBanco <> 0 Then
                        Set oRsAux = Aplicacion.CuentasBancarias.TraerFiltrado("_PorIdBanco", mIdBanco)
                        Set .RowSource = oRsAux
                        If Not IsNumeric(.BoundText) Then
                           origen.Registro.Fields(.DataField).Value = Null
                           If oRsAux.RecordCount = 1 Then
                              origen.Registro.Fields(.DataField).Value = oRsAux.Fields(0).Value
                           End If
                        End If
                        Set oRsAux = Nothing
                     Else
                        Set .RowSource = Aplicacion.CuentasBancarias.TraerFiltrado("_TodasParaCombo")
                     End If
                     .Enabled = True
                  End With
               Else
                  origen.Registro.Fields("IdCuentaBancaria").Value = Null
                  DataCombo1(4).Enabled = False
               End If
               
               If Not IsNull(oRs.Fields("EsCajaBanco").Value) And _
                     oRs.Fields("EsCajaBanco").Value = "CA" Then
                  With DataCombo1(5)
                     Set oRsAux = Aplicacion.Cajas.TraerFiltrado("_PorIdCuentaParaCombo", oRs.Fields(0).Value)
                     Set .RowSource = oRsAux
                     If Not IsNumeric(.BoundText) Then
                        origen.Registro.Fields(.DataField).Value = Null
                        If oRsAux.RecordCount = 1 Then
                           origen.Registro.Fields(.DataField).Value = oRsAux.Fields(0).Value
                        End If
                     End If
                     Set oRsAux = Nothing
                     .Enabled = True
                  End With
               Else
                  origen.Registro.Fields("IdCaja").Value = Null
                  DataCombo1(5).Enabled = False
               End If
            End If

            If DataCombo1(4).Enabled Or DataCombo1(5).Enabled Then
               With Check1
                  .Enabled = True
                  If mvarId = -1 Then .Value = 1
               End With
            Else
               Check1.Enabled = False
            End If

'            DataCombo1(6).Enabled = DataCombo1(4).Enabled Or DataCombo1(5).Enabled
'            txtCotizacionMonedaDestino.Enabled = DataCombo1(6).Enabled
            oRs.Close
         Case 1
            If DataCombo1(Index).Enabled Then
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorObraCuentaGasto", _
                        Array(IIf(Len(DataCombo1(2).BoundText) = 0, 0, DataCombo1(2).BoundText), _
                              DataCombo1(1).BoundText, Me.FechaAsiento))
               If oRs.RecordCount > 0 Then
                  If Len(DataCombo1(3).Text) > 0 Then
                     DataCombo1(3).BoundText = 0
                     If glbSeñal1 Then
                        Set DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorFechaParaCombo", Me.FechaAsiento)
                     Else
                        Set DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerLista
                     End If
                  End If
                  With origen.Registro
                     .Fields(DataCombo1(Index).DataField).Value = oRs.Fields("IdCuentaGasto").Value
                     .Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
                     txtCodigoCuenta.Text = oRs.Fields("Codigo").Value
                  End With
               End If
               oRs.Close
            Else
               With origen.Registro
                  .Fields(DataCombo1(Index).DataField).Value = Null
               End With
            End If
            txtCodigoCuenta.Enabled = False
            DataCombo1(0).Enabled = False
            DataCombo1(3).Enabled = False
            Check2.Value = 1
         Case 2
            If Not DataCombo1(1).Enabled Then
               DataCombo1(1).Enabled = True
            End If
            If DataCombo1(Index).Text <> DataCombo1(Index).BoundText Then
               With origen.Registro
                  .Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
                  
                  mIdAux = 0
                  If IsNumeric(DataCombo1(1).BoundText) Then mIdAux = DataCombo1(1).BoundText
                  Set oRs = Aplicacion.Cuentas.TraerFiltrado("_CuentasGastoPorObraParaCombo", _
                              DataCombo1(Index).BoundText)
                  Set DataCombo1(1).RowSource = oRs
                  Set oRs = Nothing
                  DataCombo1(1).BoundText = mIdAux
               
               End With
               If IsNumeric(DataCombo1(0).BoundText) Then
                  Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorId", DataCombo1(0).BoundText)
                  If oRs.RecordCount > 0 Then
                     If Not IsNull(oRs.Fields("IdObra").Value) Then
                        If oRs.Fields("IdObra").Value <> DataCombo1(Index).BoundText Then
                           DataCombo1(0).BoundText = 0
                           DataCombo1(0).Text = ""
                           txtCodigoCuenta.Text = ""
                           DataCombo1(1).BoundText = 0
                           DataCombo1(1).Text = ""
                        End If
                     End If
                  End If
                  oRs.Close
               End If
            End If
         Case 3
            If IsNumeric(DataCombo1(Index).BoundText) Then
               txtCodigoCuenta.Text = ""
               Dim mIdCuenta As Long
               If IsNumeric(DataCombo1(0).BoundText) Then
                  mIdCuenta = DataCombo1(0).BoundText
               Else
                  mIdCuenta = 0
               End If
               Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorGrupoParaCombo", _
                           Array(DataCombo1(Index).BoundText, Me.FechaAsiento))
               Set DataCombo1(0).RowSource = oRs
               origen.Registro.Fields(DataCombo1(0).DataField).Value = mIdCuenta
               Set oRs = Nothing
            End If
         Case 6
            If (IsNull(origen.Registro.Fields("CotizacionMonedaDestino").Value) Or _
                  origen.Registro.Fields("CotizacionMonedaDestino").Value = 0 Or _
                  mvarId = -1) And Me.Visible Then
               mvarCotizacionMonedaDestino = Cotizacion(Me.FechaAsiento, DataCombo1(6).BoundText)
               origen.Registro.Fields("CotizacionMonedaDestino").Value = mvarCotizacionMonedaDestino
               CalcularImporteEnMonedaDestino
            End If
      End Select
      Set oRs = Nothing
   End If

End Sub

Private Sub DataCombo1_Click(Index As Integer, Area As Integer)

   SetDataComboDropdownListWidth 400

End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)

'   SendKeys "%{DOWN}"

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub DataCombo1_Validate(Index As Integer, Cancel As Boolean)

   If Index = 2 Then
      If Len(DataCombo1(Index).Text) = 0 Then
         origen.Registro.Fields(DataCombo1(Index).DataField).Value = Null
         If IsNumeric(DataCombo1(0).BoundText) Then
            Dim oRs As ADOR.Recordset
            Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorId", DataCombo1(0).BoundText)
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("IdObra").Value) Then
                  origen.Registro.Fields(DataCombo1(Index).DataField).Value = oRs.Fields("IdObra").Value
               End If
            End If
            oRs.Close
            Set oRs = Nothing
         End If
      End If
   End If

End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Load()

   DisableCloseButton Me
   ReemplazarEtiquetas Me
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Property Get IdNuevo() As Variant

   IdNuevo = mvarIdNuevo

End Property

Public Property Let IdNuevo(ByVal vNewValue As Variant)

   mvarIdNuevo = vNewValue

End Property

Private Sub Form_Unload(Cancel As Integer)

   Set oAsiento = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub Option1_Click()

   If Option1.Value Then
      DTFields(0).Enabled = False
      txtNumeroComprobante.Enabled = False
      Frame2.Enabled = False
      txtPorcentajeIVA.Enabled = False
   End If
   
End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      DTFields(0).Enabled = True
      If IsNull(origen.Registro.Fields("FechaComprobante").Value) Then
         DTFields(0).Value = Date
      End If
      txtNumeroComprobante.Enabled = True
      Frame2.Enabled = True
   End If
   
End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      DTFields(0).Enabled = True
      If IsNull(origen.Registro.Fields("FechaComprobante").Value) Then
         DTFields(0).Value = Date
      End If
      txtNumeroComprobante.Enabled = True
      Frame2.Enabled = True
   End If
   
End Sub

Private Sub Option4_Click()

   txtPorcentajeIVA.Enabled = True

End Sub

Private Sub Option5_Click()

   With txtPorcentajeIVA
      .Text = 0
      .Enabled = False
   End With

End Sub

Private Sub Option6_Click()

   With txtPorcentajeIVA
      .Text = 0
      .Enabled = False
   End With

End Sub

Private Sub txtCodigoComprobante_GotFocus()

   With txtCodigoComprobante
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoComprobante_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   ElseIf KeyAscii >= 97 And KeyAscii <= 122 Then
      KeyAscii = KeyAscii - 32
   End If
   
End Sub

Private Sub txtCodigoComprobante_Validate(Cancel As Boolean)

   Dim oRs As ADOR.Recordset
   Set oRs = Aplicacion.TiposComprobante.TraerFiltrado("_PorAbreviatura", txtCodigoComprobante.Text)
   If oRs.RecordCount = 0 Then
      MsgBox "Comprobante inexistente", vbExclamation
      txtCodigoComprobante.Text = ""
      Cancel = True
   Else
      DataCombo1(1).BoundText = oRs.Fields(0).Value
   End If
   oRs.Close
   Set oRs = Nothing

End Sub

Private Sub txtCodigoCuenta_Change()

   If IsNumeric(txtCodigoCuenta.Text) Then
      On Error GoTo SalidaConError
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorCodigo", Array(txtCodigoCuenta.Text, Me.FechaAsiento))
      If oRs.RecordCount > 0 Then
         origen.Registro.Fields("IdCuenta").Value = oRs.Fields(0).Value
      Else
         origen.Registro.Fields("IdCuenta").Value = Null
      End If
      oRs.Close
      Set oRs = Nothing
      Exit Sub
SalidaConError:
      Set oRs = Nothing
      origen.Registro.Fields(DataCombo1(0).DataField).Value = Null
   End If

End Sub

Private Sub txtCodigoCuenta_GotFocus()

   With txtCodigoCuenta
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoCuenta_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCotizacionMonedaDestino_Change()

   CalcularImporteEnMonedaDestino
   
End Sub

Private Sub txtCotizacionMonedaDestino_GotFocus()

   With txtCotizacionMonedaDestino
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCotizacionMonedaDestino_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCuit_GotFocus()

   With txtCuit
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCuit_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtDebe_Change()

   CalcularImporteEnMonedaDestino
   
End Sub

Private Sub txtDebe_GotFocus()

   With txtDebe
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDebe_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtDetalle_GotFocus()

   With txtDetalle
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDetalle_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtHaber_Change()

   CalcularImporteEnMonedaDestino
   
End Sub

Private Sub txtHaber_GotFocus()

   With txtHaber
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtHaber_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtNumeroComprobante_GotFocus()

   With txtNumeroComprobante
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroComprobante_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtSigno_GotFocus()

   With txtSigno
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtSigno_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtSigno_Validate(Cancel As Boolean)

   If txtSigno.Text <> "+" And txtSigno.Text <> "-" Then
      Cancel = True
      txtSigno.Text = ""
   End If
   
End Sub

Public Property Get FechaAsiento() As Date

   FechaAsiento = mFechaAsiento
   
End Property

Public Property Let FechaAsiento(ByVal vNewValue As Date)

   mFechaAsiento = vNewValue
   
End Property

Public Sub CalcularImporteEnMonedaDestino()

   Dim mImporte As Double
   
'   If IsNull(origen.Registro.Fields("ImporteEnMonedaDestino").Value) Or _
'         mvarId <= 0 Then
      If Val(txtCotizacionMonedaDestino.Text) <> 0 Then
         If Val(txtDebe.Text) <> 0 Then
            mImporte = Val(txtDebe.Text)
         ElseIf Val(txtHaber.Text) <> 0 Then
            mImporte = Val(txtHaber.Text)
         Else
            mImporte = 0
         End If
         origen.Registro.Fields("ImporteEnMonedaDestino").Value = _
            Round(mImporte / Val(txtCotizacionMonedaDestino.Text), 2)
      End If
'   End If

End Sub
