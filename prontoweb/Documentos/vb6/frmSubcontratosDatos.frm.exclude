VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Object = "{126E538A-EE41-4B22-A045-F8D5538F5D2B}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmSubcontratosDatos 
   Caption         =   "Datos del subcontrato"
   ClientHeight    =   6270
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10920
   LinkTopic       =   "Form1"
   ScaleHeight     =   6270
   ScaleWidth      =   10920
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtFondoReparo 
      Alignment       =   2  'Center
      DataField       =   "FondoReparo"
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
      Left            =   7830
      TabIndex        =   41
      Top             =   1845
      Width           =   1050
   End
   Begin VB.TextBox txtAcopio 
      DataField       =   "Acopio"
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
      Left            =   1485
      TabIndex        =   39
      Top             =   1845
      Width           =   3705
   End
   Begin VB.TextBox txtAnticipoFinanciero 
      DataField       =   "AnticipoFinanciero"
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
      Left            =   7065
      TabIndex        =   37
      Top             =   1440
      Width           =   3705
   End
   Begin VB.TextBox txtCondicionPago 
      DataField       =   "CondicionPago"
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
      Left            =   1485
      TabIndex        =   34
      Top             =   1440
      Width           =   3705
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   330
      Index           =   1
      Left            =   90
      TabIndex        =   16
      Top             =   5805
      Width           =   1140
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   330
      Index           =   0
      Left            =   90
      TabIndex        =   15
      Top             =   5355
      Width           =   1140
   End
   Begin VB.TextBox txtNumeroSubcontrato 
      Alignment       =   2  'Center
      Enabled         =   0   'False
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
      Left            =   1485
      TabIndex        =   0
      Top             =   225
      Width           =   1590
   End
   Begin VB.TextBox txtDetalle 
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
      Left            =   1485
      TabIndex        =   5
      Top             =   1035
      Width           =   7170
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   1
      Left            =   1485
      TabIndex        =   4
      Tag             =   "Proveedores"
      Top             =   630
      Width           =   7170
      _ExtentX        =   12647
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   330
      Index           =   0
      Left            =   4095
      TabIndex        =   1
      Top             =   180
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Enabled         =   0   'False
      Format          =   59441153
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   330
      Index           =   1
      Left            =   6525
      TabIndex        =   2
      Top             =   180
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   59441153
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   330
      Index           =   2
      Left            =   9450
      TabIndex        =   3
      Top             =   180
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   59441153
      CurrentDate     =   36377
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   1485
      TabIndex        =   6
      Top             =   2340
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   1
      Left            =   1485
      TabIndex        =   7
      Top             =   2745
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   2
      Left            =   1485
      TabIndex        =   8
      Top             =   3150
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   3
      Left            =   1485
      TabIndex        =   9
      Top             =   3555
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   4
      Left            =   1485
      TabIndex        =   10
      Top             =   3960
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   6
      Left            =   7065
      TabIndex        =   11
      Top             =   2745
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   7
      Left            =   7065
      TabIndex        =   12
      Top             =   3150
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   8
      Left            =   7065
      TabIndex        =   13
      Top             =   3555
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   9
      Left            =   7065
      TabIndex        =   14
      Top             =   3960
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   5
      Left            =   7065
      TabIndex        =   36
      Top             =   2340
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   582
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
   Begin Controles1013.DbListView Lista 
      Height          =   1590
      Left            =   1485
      TabIndex        =   42
      Top             =   4545
      Width           =   9285
      _ExtentX        =   16378
      _ExtentY        =   2805
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmSubcontratosDatos.frx":0000
      OLEDragMode     =   1
      OLEDropMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Label lblLabels 
      Caption         =   "Pedidos imputados al subcontrato :"
      Height          =   195
      Index           =   10
      Left            =   1530
      TabIndex        =   43
      Top             =   4365
      Width           =   2535
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fondo de reparo (garantia) : "
      Height          =   240
      Index           =   9
      Left            =   5715
      TabIndex        =   40
      Top             =   1890
      Width           =   2040
   End
   Begin VB.Label lblLabels 
      Caption         =   "Acopio :"
      Height          =   240
      Index           =   8
      Left            =   135
      TabIndex        =   38
      Top             =   1890
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "Anticipo financ. :"
      Height          =   240
      Index           =   7
      Left            =   5715
      TabIndex        =   35
      Top             =   1485
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cond. pago :"
      Height          =   240
      Index           =   6
      Left            =   135
      TabIndex        =   33
      Top             =   1485
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 10 :"
      Height          =   300
      Index           =   9
      Left            =   5715
      TabIndex        =   32
      Top             =   4005
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 9 :"
      Height          =   300
      Index           =   8
      Left            =   5715
      TabIndex        =   31
      Top             =   3600
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 8 :"
      Height          =   300
      Index           =   7
      Left            =   5715
      TabIndex        =   30
      Top             =   3195
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 7 :"
      Height          =   300
      Index           =   6
      Left            =   5715
      TabIndex        =   29
      Top             =   2790
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 6 :"
      Height          =   300
      Index           =   5
      Left            =   5715
      TabIndex        =   28
      Top             =   2385
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 5 :"
      Height          =   300
      Index           =   4
      Left            =   135
      TabIndex        =   27
      Top             =   3960
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 4 :"
      Height          =   300
      Index           =   3
      Left            =   135
      TabIndex        =   26
      Top             =   3555
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 3 :"
      Height          =   300
      Index           =   2
      Left            =   135
      TabIndex        =   25
      Top             =   3150
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 2 :"
      Height          =   300
      Index           =   1
      Left            =   135
      TabIndex        =   24
      Top             =   2745
      Width           =   1230
   End
   Begin VB.Label lblAdjuntos 
      Caption         =   "Adjunto nro. 1 :"
      Height          =   300
      Index           =   0
      Left            =   135
      TabIndex        =   23
      Top             =   2340
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha finalizacion :"
      Height          =   240
      Index           =   5
      Left            =   7920
      TabIndex        =   22
      Top             =   225
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha inico :"
      Height          =   240
      Index           =   4
      Left            =   5490
      TabIndex        =   21
      Top             =   225
      Width           =   960
   End
   Begin VB.Label lblLabels 
      Caption         =   "Subcontrato :"
      Height          =   240
      Index           =   1
      Left            =   135
      TabIndex        =   20
      Top             =   1080
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "No.Subcontrato :"
      Height          =   240
      Index           =   0
      Left            =   135
      TabIndex        =   19
      Top             =   225
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "Proveedor :"
      Height          =   240
      Index           =   2
      Left            =   135
      TabIndex        =   18
      Top             =   675
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha :"
      Height          =   240
      Index           =   3
      Left            =   3240
      TabIndex        =   17
      Top             =   225
      Width           =   735
   End
End
Attribute VB_Name = "frmSubcontratosDatos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim actL2 As ControlForm

Private mvarNumeroSubcontrato As Long, mvarIdProveedor As Long, mvarIdSubcontratoDatos As Long
Private mvarDescripcionSubcontrato As String
Private mFechaInicial As Date, mFechaFinalizacion As Date
Public NodoPadre As Long, Tipo As Long, CodigoPresupuesto As Long
Public Aceptado As Boolean

Private Sub cmd_Click(Index As Integer)

   Dim oRs As ADOR.Recordset
   Dim mAux1 As Variant
   Dim mSP As String
   
   Select Case Index
      Case 0
         If Len(txtNumeroSubcontrato.Text) = 0 Then
            MsgBox "Debe ingresar un numero de subcontrato", vbExclamation
            Exit Sub
         End If
         
         If Len(txtDetalle.Text) = 0 Then
            MsgBox "Debe ingresar el nombre del subcontrato", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(DataCombo1(1).BoundText) Then
            MsgBox "Debe ingresar un proveedor", vbExclamation
            Exit Sub
         End If
         
         If Me.NumeroSubcontrato < 0 Then
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("SubcontratosDatos", "_PorNumeroSubcontrato", txtNumeroSubcontrato.Text)
            If oRs.RecordCount > 0 Then
               oRs.Close
               Set oRs = Nothing
               MsgBox "Este numero de subcontrato ya existe", vbExclamation
               Exit Sub
            End If
            oRs.Close
            
            mAux1 = TraerValorParametro2("ProximoNumeroSubcontrato")
            txtNumeroSubcontrato.Text = IIf(IsNull(mAux1), 1, mAux1)
            GuardarValorParametro2 "ProximoNumeroSubcontrato", "" & txtNumeroSubcontrato.Text + 1
            
            mSP = "SubcontratosDatos_A"
         Else
            mSP = "SubcontratosDatos_M"
         End If
         
         Aplicacion.Tarea mSP, Array(Me.IdSubcontratoDatos, Val(txtNumeroSubcontrato.Text), txtDetalle.Text, DataCombo1(1).BoundText, _
                                    DTFields(0).Value, DTFields(1).Value, DTFields(2).Value, _
                                    FileBrowser1(0).Text, FileBrowser1(1).Text, FileBrowser1(2).Text, FileBrowser1(3).Text, _
                                    FileBrowser1(4).Text, FileBrowser1(5).Text, FileBrowser1(6).Text, FileBrowser1(7).Text, _
                                    FileBrowser1(8).Text, FileBrowser1(9).Text, txtCondicionPago.Text, txtAnticipoFinanciero.Text, _
                                    txtAcopio.Text, Val(txtFondoReparo.Text))
         
         Me.NumeroSubcontrato = Val(txtNumeroSubcontrato.Text)
         Me.IdProveedor = DataCombo1(1).BoundText
         Me.DescripcionSubcontrato = txtDetalle.Text
         Me.FechaInicial = DTFields(1).Value
         Me.FechaFinalizacion = DTFields(2).Value
         
         Aceptado = True
      
      Case 1
         Aceptado = False
      
   End Select
   
   Me.Hide
   
   Set oRs = Nothing

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub FileBrowser1_Change(Index As Integer)

   If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
      If Len(Trim(FileBrowser1(Index).Text)) > gblMaximaLongitudAdjuntos Then
         MsgBox "La longitud maxima para un archivo adjunto es de " & gblMaximaLongitudAdjuntos & " caracteres", vbInformation
         FileBrowser1(Index).Text = ""
      Else
         FileBrowser1(Index).InitDir = FileBrowser1(Index).Text
      End If
   End If
   
End Sub

Private Sub FileBrowser1_DblClick(Index As Integer)

   If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
      If Not Len(Trim(Dir(FileBrowser1(Index).Text))) <> 0 Then
         MsgBox "El archivo indicado no existe!", vbExclamation
         Exit Sub
      End If
      Call ShellExecute(Me.hwnd, "open", FileBrowser1(Index).Text, vbNullString, vbNullString, SW_SHOWNORMAL)
   End If

End Sub

Private Sub Form_Load()

   Dim oRs As ADOR.Recordset
   Dim mAux1 As Variant
   
   Set DataCombo1(1).RowSource = Aplicacion.Proveedores.TraerLista
   
   If Me.NumeroSubcontrato > 0 Then
      Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("SubcontratosDatos", "_PorNumeroSubcontrato", Me.NumeroSubcontrato)
      If oRs.RecordCount > 0 Then
         Me.IdSubcontratoDatos = IIf(IsNull(oRs.Fields("IdSubcontratoDatos").Value), 0, oRs.Fields("IdSubcontratoDatos").Value)
         Me.IdProveedor = IIf(IsNull(oRs.Fields("IdProveedor").Value), 0, oRs.Fields("IdProveedor").Value)
         Me.DescripcionSubcontrato = IIf(IsNull(oRs.Fields("DescripcionSubcontrato").Value), "", oRs.Fields("DescripcionSubcontrato").Value)
         DTFields(0).Value = IIf(IsNull(oRs.Fields("Fecha").Value), Date, oRs.Fields("Fecha").Value)
         DTFields(1).Value = IIf(IsNull(oRs.Fields("FechaInicio").Value), Date, oRs.Fields("FechaInicio").Value)
         DTFields(2).Value = IIf(IsNull(oRs.Fields("FechaFinalizacion").Value), Date, oRs.Fields("FechaFinalizacion").Value)
         FileBrowser1(0).Text = IIf(IsNull(oRs.Fields("Adjunto1").Value), "", oRs.Fields("Adjunto1").Value)
         FileBrowser1(1).Text = IIf(IsNull(oRs.Fields("Adjunto2").Value), "", oRs.Fields("Adjunto2").Value)
         FileBrowser1(2).Text = IIf(IsNull(oRs.Fields("Adjunto3").Value), "", oRs.Fields("Adjunto3").Value)
         FileBrowser1(3).Text = IIf(IsNull(oRs.Fields("Adjunto4").Value), "", oRs.Fields("Adjunto4").Value)
         FileBrowser1(4).Text = IIf(IsNull(oRs.Fields("Adjunto5").Value), "", oRs.Fields("Adjunto5").Value)
         FileBrowser1(5).Text = IIf(IsNull(oRs.Fields("Adjunto6").Value), "", oRs.Fields("Adjunto6").Value)
         FileBrowser1(6).Text = IIf(IsNull(oRs.Fields("Adjunto7").Value), "", oRs.Fields("Adjunto7").Value)
         FileBrowser1(7).Text = IIf(IsNull(oRs.Fields("Adjunto8").Value), "", oRs.Fields("Adjunto8").Value)
         FileBrowser1(8).Text = IIf(IsNull(oRs.Fields("Adjunto9").Value), "", oRs.Fields("Adjunto9").Value)
         FileBrowser1(9).Text = IIf(IsNull(oRs.Fields("Adjunto10").Value), "", oRs.Fields("Adjunto10").Value)
         txtCondicionPago.Text = IIf(IsNull(oRs.Fields("CondicionPago").Value), "", oRs.Fields("CondicionPago").Value)
         txtAnticipoFinanciero.Text = IIf(IsNull(oRs.Fields("AnticipoFinanciero").Value), "", oRs.Fields("AnticipoFinanciero").Value)
         txtAcopio.Text = IIf(IsNull(oRs.Fields("Acopio").Value), "", oRs.Fields("Acopio").Value)
         txtFondoReparo.Text = IIf(IsNull(oRs.Fields("FondoReparo").Value), 0, oRs.Fields("FondoReparo").Value)
      End If
      oRs.Close
      Set oRs = Nothing
      
      DataCombo1(1).BoundText = Me.IdProveedor
      txtDetalle.Text = Me.DescripcionSubcontrato
      txtNumeroSubcontrato.Text = Me.NumeroSubcontrato
   Else
      Me.IdSubcontratoDatos = 0
      mAux1 = TraerValorParametro2("ProximoNumeroSubcontrato")
      txtNumeroSubcontrato.Text = IIf(IsNull(mAux1), 1, mAux1)
      DTFields(0).Value = Date
      DTFields(1).Value = Date
      DTFields(2).Value = Date
   End If
   
   Set Lista.DataSource = Aplicacion.Pedidos.TraerFiltrado("_PorNumeroSubcontrato", Me.NumeroSubcontrato)

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Property Get NumeroSubcontrato() As Long

   NumeroSubcontrato = mvarNumeroSubcontrato

End Property

Public Property Let NumeroSubcontrato(ByVal vNewValue As Long)

   mvarNumeroSubcontrato = vNewValue

End Property

Public Property Get IdSubcontratoDatos() As Long

   IdSubcontratoDatos = mvarIdSubcontratoDatos

End Property

Public Property Let IdSubcontratoDatos(ByVal vNewValue As Long)

   mvarIdSubcontratoDatos = vNewValue

End Property

Public Property Get DescripcionSubcontrato() As String

   DescripcionSubcontrato = mvarDescripcionSubcontrato

End Property

Public Property Let DescripcionSubcontrato(ByVal vNewValue As String)

   mvarDescripcionSubcontrato = vNewValue

End Property

Public Property Get FechaInicial() As Date

   FechaInicial = mFechaInicial

End Property

Public Property Let FechaInicial(ByVal vNewValue As Date)

   mFechaInicial = vNewValue

End Property

Public Property Get FechaFinalizacion() As Date

   FechaFinalizacion = mFechaFinalizacion

End Property

Public Property Let FechaFinalizacion(ByVal vNewValue As Date)

   mFechaFinalizacion = vNewValue

End Property

Public Property Get IdProveedor() As Long

   IdProveedor = mvarIdProveedor

End Property

Public Property Let IdProveedor(ByVal vNewValue As Long)

   mvarIdProveedor = vNewValue

End Property

Private Sub Lista_DblClick()

   If Len(Lista.SelectedItem.SubItems(1)) > 0 Then
      Dim oF As frmPedidos
      Set oF = New frmPedidos
      With oF
         .Id = Lista.SelectedItem.SubItems(1)
         .Disparar = actL2
         .Show vbModal, Me
      End With
      Set oF = Nothing
   End If

End Sub

Private Sub txtAcopio_GotFocus()

   With txtAcopio
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAcopio_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtAcopio
         If Len(Trim(.Text)) >= 50 And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtAnticipoFinanciero_GotFocus()

   With txtAnticipoFinanciero
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAnticipoFinanciero_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtAnticipoFinanciero
         If Len(Trim(.Text)) >= 50 And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtCondicionPago_GotFocus()

   With txtCondicionPago
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCondicionPago_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCondicionPago
         If Len(Trim(.Text)) >= 50 And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtDetalle_GotFocus()

   With txtDetalle
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDetalle_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDetalle
         If Len(Trim(.Text)) >= 50 And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
