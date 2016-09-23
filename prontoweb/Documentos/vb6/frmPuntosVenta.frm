VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmPuntosVenta 
   Caption         =   "Puntos de venta"
   ClientHeight    =   7185
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8970
   Icon            =   "frmPuntosVenta.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7185
   ScaleWidth      =   8970
   StartUpPosition =   1  'CenterOwner
   Begin VB.Frame Frame1 
      Caption         =   "Tipo de registracion :"
      Height          =   1140
      Left            =   6030
      TabIndex        =   70
      Top             =   225
      Width           =   2580
      Begin VB.CheckBox Check1 
         Alignment       =   1  'Right Justify
         Caption         =   "Modo test :"
         Enabled         =   0   'False
         Height          =   195
         Left            =   1395
         TabIndex        =   74
         Top             =   900
         Width           =   1095
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Registro webservice (WSBFE)"
         Height          =   195
         Left            =   90
         TabIndex        =   73
         Top             =   675
         Width           =   2445
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Registro webservice (WSFE)"
         Height          =   195
         Left            =   90
         TabIndex        =   72
         Top             =   450
         Width           =   2400
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Normal"
         Height          =   195
         Left            =   90
         TabIndex        =   71
         Top             =   225
         Width           =   1635
      End
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   2205
      TabIndex        =   68
      Top             =   585
      Width           =   3720
   End
   Begin VB.TextBox txtProximoNumeroAd 
      Alignment       =   1  'Right Justify
      DataField       =   "ProximoNumero4"
      Height          =   285
      Index           =   2
      Left            =   7920
      TabIndex        =   66
      Top             =   1800
      Visible         =   0   'False
      Width           =   630
   End
   Begin VB.TextBox txtProximoNumeroAd 
      Alignment       =   1  'Right Justify
      DataField       =   "ProximoNumero3"
      Height          =   285
      Index           =   1
      Left            =   5310
      TabIndex        =   64
      Top             =   1800
      Visible         =   0   'False
      Width           =   630
   End
   Begin VB.TextBox txtProximoNumeroAd 
      Alignment       =   1  'Right Justify
      DataField       =   "ProximoNumero2"
      Height          =   285
      Index           =   0
      Left            =   7920
      TabIndex        =   62
      Top             =   1440
      Visible         =   0   'False
      Width           =   630
   End
   Begin VB.TextBox txtProximoNumero1 
      Alignment       =   1  'Right Justify
      DataField       =   "ProximoNumero1"
      Height          =   285
      Left            =   5310
      TabIndex        =   60
      Top             =   1440
      Visible         =   0   'False
      Width           =   630
   End
   Begin VB.TextBox txtNumeroCAI_R_A 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCAI_R_A"
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
      Left            =   2565
      TabIndex        =   22
      Top             =   2475
      Width           =   2445
   End
   Begin VB.TextBox txtNumeroCAI_F_A 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCAI_F_A"
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
      Left            =   2565
      TabIndex        =   21
      Top             =   2805
      Width           =   2445
   End
   Begin VB.TextBox txtNumeroCAI_D_A 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCAI_D_A"
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
      Left            =   2565
      TabIndex        =   20
      Top             =   3135
      Width           =   2445
   End
   Begin VB.TextBox txtNumeroCAI_C_A 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCAI_C_A"
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
      Left            =   2565
      TabIndex        =   19
      Top             =   3465
      Width           =   2445
   End
   Begin VB.TextBox txtNumeroCAI_R_B 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCAI_R_B"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
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
      Left            =   2565
      TabIndex        =   18
      Top             =   3795
      Width           =   2445
   End
   Begin VB.TextBox txtNumeroCAI_F_B 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCAI_F_B"
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
      Left            =   2565
      TabIndex        =   17
      Top             =   4140
      Width           =   2445
   End
   Begin VB.TextBox txtNumeroCAI_D_B 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCAI_D_B"
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
      Left            =   2565
      TabIndex        =   16
      Top             =   4455
      Width           =   2445
   End
   Begin VB.TextBox txtNumeroCAI_C_B 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCAI_C_B"
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
      Left            =   2565
      TabIndex        =   15
      Top             =   4785
      Width           =   2445
   End
   Begin VB.TextBox txtNumeroCAI_R_E 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCAI_R_E"
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
      Left            =   2565
      TabIndex        =   14
      Top             =   5115
      Width           =   2445
   End
   Begin VB.TextBox txtNumeroCAI_F_E 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCAI_F_E"
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
      Left            =   2565
      TabIndex        =   13
      Top             =   5445
      Width           =   2445
   End
   Begin VB.TextBox txtNumeroCAI_C_E 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCAI_C_E"
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
      Left            =   2565
      TabIndex        =   12
      Top             =   6105
      Width           =   2445
   End
   Begin VB.TextBox txtNumeroCAI_D_E 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroCAI_D_E"
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
      Left            =   2565
      TabIndex        =   11
      Top             =   5775
      Width           =   2445
   End
   Begin VB.TextBox txtProximoNumero 
      Alignment       =   1  'Right Justify
      DataField       =   "ProximoNumero"
      Height          =   285
      Left            =   2250
      TabIndex        =   3
      Top             =   1440
      Width           =   990
   End
   Begin VB.TextBox txtLetra 
      Alignment       =   2  'Center
      DataField       =   "Letra"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   2250
      TabIndex        =   0
      Top             =   180
      Width           =   300
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   2055
      TabIndex        =   4
      Top             =   6690
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   5475
      TabIndex        =   6
      Top             =   6690
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   3765
      TabIndex        =   5
      Top             =   6690
      Width           =   1485
   End
   Begin VB.TextBox txtPuntoVenta 
      Alignment       =   1  'Right Justify
      DataField       =   "PuntoVenta"
      Height          =   285
      Left            =   5070
      TabIndex        =   1
      Top             =   210
      Width           =   855
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdTipoComprobante"
      Height          =   315
      Index           =   1
      Left            =   2250
      TabIndex        =   2
      Tag             =   "TiposComprobante"
      Top             =   990
      Width           =   3690
      _ExtentX        =   6509
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipoComprobante"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields1 
      DataField       =   "FechaCAI_R_A"
      Height          =   330
      Index           =   0
      Left            =   7065
      TabIndex        =   35
      Top             =   2475
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   60358657
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields1 
      DataField       =   "FechaCAI_F_A"
      Height          =   330
      Index           =   1
      Left            =   7065
      TabIndex        =   36
      Top             =   2790
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   60358657
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields1 
      DataField       =   "FechaCAI_D_A"
      Height          =   330
      Index           =   2
      Left            =   7065
      TabIndex        =   37
      Top             =   3105
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   60358657
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields1 
      DataField       =   "FechaCAI_C_A"
      Height          =   330
      Index           =   3
      Left            =   7065
      TabIndex        =   38
      Top             =   3420
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   60358657
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields1 
      DataField       =   "FechaCAI_R_B"
      Height          =   330
      Index           =   4
      Left            =   7065
      TabIndex        =   39
      Top             =   3735
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   60358657
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields1 
      DataField       =   "FechaCAI_F_B"
      Height          =   330
      Index           =   5
      Left            =   7065
      TabIndex        =   40
      Top             =   4095
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   60358657
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields1 
      DataField       =   "FechaCAI_D_B"
      Height          =   330
      Index           =   6
      Left            =   7065
      TabIndex        =   41
      Top             =   4410
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   60358657
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields1 
      DataField       =   "FechaCAI_C_B"
      Height          =   330
      Index           =   7
      Left            =   7065
      TabIndex        =   42
      Top             =   4725
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   60358657
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields1 
      DataField       =   "FechaCAI_R_E"
      Height          =   330
      Index           =   8
      Left            =   7065
      TabIndex        =   43
      Top             =   5040
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   60358657
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields1 
      DataField       =   "FechaCAI_F_E"
      Height          =   330
      Index           =   9
      Left            =   7065
      TabIndex        =   44
      Top             =   5355
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   60358657
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields1 
      DataField       =   "FechaCAI_D_E"
      Height          =   330
      Index           =   10
      Left            =   7065
      TabIndex        =   45
      Top             =   5715
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   60358657
      CurrentDate     =   36377
   End
   Begin MSComCtl2.DTPicker DTFields1 
      DataField       =   "FechaCAI_C_E"
      Height          =   330
      Index           =   11
      Left            =   7065
      TabIndex        =   46
      Top             =   6030
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   582
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   60358657
      CurrentDate     =   36377
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripcion : "
      Height          =   300
      Index           =   8
      Left            =   270
      TabIndex        =   69
      Top             =   600
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Proximo numero : "
      Height          =   300
      Index           =   7
      Left            =   6030
      TabIndex        =   67
      Top             =   1800
      Visible         =   0   'False
      Width           =   1905
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Proximo numero : "
      Height          =   300
      Index           =   6
      Left            =   3375
      TabIndex        =   65
      Top             =   1800
      Visible         =   0   'False
      Width           =   1905
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Proximo numero : "
      Height          =   300
      Index           =   5
      Left            =   6030
      TabIndex        =   63
      Top             =   1440
      Visible         =   0   'False
      Width           =   1905
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Proximo numero : "
      Height          =   300
      Index           =   4
      Left            =   3330
      TabIndex        =   61
      Top             =   1410
      Visible         =   0   'False
      Width           =   1905
   End
   Begin VB.Label lblFieldLabel 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      Caption         =   "Datos del CAI y fechas de vencimiento"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Index           =   3
      Left            =   270
      TabIndex        =   59
      Top             =   2250
      Width           =   8295
   End
   Begin VB.Label Label54 
      Caption         =   "Fecha de vencimiento :"
      Height          =   240
      Left            =   5265
      TabIndex        =   58
      Top             =   2520
      Width           =   1725
   End
   Begin VB.Label Label53 
      Caption         =   "Fecha de vencimiento :"
      Height          =   240
      Left            =   5265
      TabIndex        =   57
      Top             =   3510
      Width           =   1725
   End
   Begin VB.Label Label52 
      Caption         =   "Fecha de vencimiento :"
      Height          =   240
      Left            =   5265
      TabIndex        =   56
      Top             =   3180
      Width           =   1725
   End
   Begin VB.Label Label55 
      Caption         =   "Fecha de vencimiento :"
      Height          =   240
      Left            =   5265
      TabIndex        =   55
      Top             =   2850
      Width           =   1725
   End
   Begin VB.Label Label56 
      Caption         =   "Fecha de vencimiento :"
      Height          =   240
      Left            =   5265
      TabIndex        =   54
      Top             =   6150
      Width           =   1725
   End
   Begin VB.Label Label69 
      Caption         =   "Fecha de vencimiento :"
      Height          =   240
      Left            =   5265
      TabIndex        =   53
      Top             =   5820
      Width           =   1725
   End
   Begin VB.Label Label70 
      Caption         =   "Fecha de vencimiento :"
      Height          =   240
      Left            =   5265
      TabIndex        =   52
      Top             =   5490
      Width           =   1725
   End
   Begin VB.Label Label71 
      Caption         =   "Fecha de vencimiento :"
      Height          =   240
      Left            =   5265
      TabIndex        =   51
      Top             =   5160
      Width           =   1725
   End
   Begin VB.Label Label72 
      Caption         =   "Fecha de vencimiento :"
      Height          =   240
      Left            =   5265
      TabIndex        =   50
      Top             =   4830
      Width           =   1725
   End
   Begin VB.Label Label73 
      Caption         =   "Fecha de vencimiento :"
      Height          =   240
      Left            =   5265
      TabIndex        =   49
      Top             =   4500
      Width           =   1725
   End
   Begin VB.Label Label74 
      Caption         =   "Fecha de vencimiento :"
      Height          =   240
      Left            =   5265
      TabIndex        =   48
      Top             =   4170
      Width           =   1725
   End
   Begin VB.Label Label75 
      Caption         =   "Fecha de vencimiento :"
      Height          =   240
      Left            =   5265
      TabIndex        =   47
      Top             =   3840
      Width           =   1725
   End
   Begin VB.Label Label68 
      Caption         =   "Numero CAI Remitos A :"
      Height          =   240
      Left            =   270
      TabIndex        =   34
      Top             =   2520
      Width           =   2220
   End
   Begin VB.Label Label67 
      Caption         =   "Numero CAI Facturas A :"
      Height          =   240
      Left            =   270
      TabIndex        =   33
      Top             =   2850
      Width           =   2220
   End
   Begin VB.Label Label66 
      Caption         =   "Numero CAI Notas Debito A :"
      Height          =   240
      Left            =   270
      TabIndex        =   32
      Top             =   3180
      Width           =   2220
   End
   Begin VB.Label Label65 
      Caption         =   "Numero CAI Notas Credito A :"
      Height          =   240
      Left            =   270
      TabIndex        =   31
      Top             =   3510
      Width           =   2220
   End
   Begin VB.Label Label64 
      Caption         =   "Numero CAI Remitos B :"
      Height          =   240
      Left            =   270
      TabIndex        =   30
      Top             =   3840
      Width           =   2220
   End
   Begin VB.Label Label63 
      Caption         =   "Numero CAI Facturas B :"
      Height          =   240
      Left            =   270
      TabIndex        =   29
      Top             =   4170
      Width           =   2220
   End
   Begin VB.Label Label62 
      Caption         =   "Numero CAI Notas Debito B :"
      Height          =   240
      Left            =   270
      TabIndex        =   28
      Top             =   4500
      Width           =   2220
   End
   Begin VB.Label Label61 
      Caption         =   "Numero CAI Notas Credito B :"
      Height          =   240
      Left            =   270
      TabIndex        =   27
      Top             =   4830
      Width           =   2220
   End
   Begin VB.Label Label60 
      Caption         =   "Numero CAI Remitos E :"
      Height          =   240
      Left            =   270
      TabIndex        =   26
      Top             =   5160
      Width           =   2220
   End
   Begin VB.Label Label59 
      Caption         =   "Numero CAI Facturas E :"
      Height          =   240
      Left            =   270
      TabIndex        =   25
      Top             =   5490
      Width           =   2220
   End
   Begin VB.Label Label58 
      Caption         =   "Numero CAI Notas Debito E :"
      Height          =   240
      Left            =   270
      TabIndex        =   24
      Top             =   5820
      Width           =   2220
   End
   Begin VB.Label Label57 
      Caption         =   "Numero CAI Notas Credito E :"
      Height          =   240
      Left            =   270
      TabIndex        =   23
      Top             =   6150
      Width           =   2220
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Proximo numero : "
      Height          =   255
      Index           =   0
      Left            =   270
      TabIndex        =   10
      Top             =   1440
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Letra : "
      Height          =   300
      Index           =   1
      Left            =   270
      TabIndex        =   9
      Top             =   195
      Width           =   1815
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Punto de venta : "
      Height          =   255
      Index           =   2
      Left            =   3690
      TabIndex        =   8
      Top             =   225
      Width           =   1275
   End
   Begin VB.Label lblData 
      Caption         =   "Tipo de comprobante :"
      Height          =   255
      Index           =   2
      Left            =   270
      TabIndex        =   7
      Top             =   1035
      Width           =   1815
   End
End
Attribute VB_Name = "frmPuntosVenta"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.PuntoVenta
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
   
         Dim est As EnumAcciones
         Dim oControl As Control
   
         If Not IsNumeric(dcfields(1).BoundText) Then
            MsgBox "Debe indicar el comprobante", vbExclamation
            Exit Sub
         End If
         
         If Len(txtLetra.Text) = 0 Then
            MsgBox "No ingreso la letra del tipo de comprobante", vbExclamation
            Exit Sub
         End If
         
         If Len(txtPuntoVenta.Text) = 0 Then
            MsgBox "No ingreso el punto de venta para el tipo de comprobante", vbExclamation
            Exit Sub
         End If
         
         If Len(txtProximoNumero.Text) = 0 Or Not IsNumeric(txtProximoNumero.Text) Then
            MsgBox "El proximo numero de comprobante no es correcto", vbExclamation
            Exit Sub
         End If
         
         Dim oRs As ADOR.Recordset
         Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_Duplicados", Array(txtLetra.Text, dcfields(1).BoundText, txtPuntoVenta.Text, mvarId))
         If oRs.RecordCount > 0 Then
            oRs.Close
            Set oRs = Nothing
            MsgBox "Punto de venta ya ingresado. Reingrese.", vbCritical
            Exit Sub
         End If
         oRs.Close
         Set oRs = Nothing
         
         With origen.Registro
            For Each oControl In Me.Controls
               If TypeOf oControl Is DataCombo Then
                  If Len(oControl.BoundText) <> 0 Then
                     .Fields(oControl.DataField).Value = oControl.BoundText
                  End If
               ElseIf TypeOf oControl Is DTPicker Then
                  .Fields(oControl.DataField).Value = oControl.Value
               ElseIf TypeOf oControl Is TextBox Then
                  If mId(oControl.Name, 1, 9) = "txtNumero" Then
                     If Len(oControl.Text) > 0 And Not IsNumeric(oControl.Text) Then
                        MsgBox "Uno de los numeros de CAI tiene caracteres no numericos, eliminelos", vbExclamation
                        Exit Sub
                     End If
                  End If
               End If
            Next
            If Option1.Value Then
               .Fields("WebService").Value = Null
            ElseIf Option2.Value Then
               .Fields("WebService").Value = "WSFE"
            ElseIf Option3.Value Then
               .Fields("WebService").Value = "WSBFE"
            End If
            If Check1.Value = 0 Then
               .Fields("WebServiceModoTest").Value = Null
            Else
               .Fields("WebServiceModoTest").Value = "SI"
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
            .ListaEditada = "PuntosVenta"
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
            .ListaEditada = "PuntosVenta"
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

Public Property Let Id(ByVal vNewValue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   
   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oAp.PuntosVenta.Item(vNewValue)
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
               If oControl.Tag = "TiposComprobante" Then
                  Set oControl.RowSource = oAp.TiposComprobante.TraerFiltrado("_ParaComboVentas")
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
   
   If mvarId <= 0 Then
      With origen.Registro
         .Fields("Letra").Value = "A"
         .Fields("PuntoVenta").Value = 1
         .Fields("ProximoNumero").Value = 1
      End With
      Option1.Value = True
   Else
      With origen.Registro
         If IIf(IsNull(.Fields("WebService").Value), "", .Fields("WebService").Value) = "" Then
            Option1.Value = True
         ElseIf IIf(IsNull(.Fields("WebService").Value), "", .Fields("WebService").Value) = "WSFE" Then
            Option2.Value = True
            Check1.Enabled = glbAdministrador
            If IIf(IsNull(.Fields("WebServiceModoTest").Value), "", .Fields("WebServiceModoTest").Value) = "SI" Then Check1.Value = 1
         ElseIf IIf(IsNull(.Fields("WebService").Value), "", .Fields("WebService").Value) = "WSBFE" Then
            Option3.Value = True
            Check1.Enabled = glbAdministrador
            If IIf(IsNull(.Fields("WebServiceModoTest").Value), "", .Fields("WebServiceModoTest").Value) = "SI" Then Check1.Value = 1
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

Private Sub dcfields_Change(Index As Integer)

   Dim mAuxS1 As String
   Dim i As Integer
   Dim mVector
   
   If IsNumeric(dcfields(Index).BoundText) Then
      Select Case Index
         Case 1
            If dcfields(Index).BoundText = 50 Then
               lblFieldLabel(0).Caption = "Prox. Salida Fabrica :"
               With lblFieldLabel(4)
                  .Caption = "Prox.Sal.Obra.:"
                  .Visible = True
               End With
               txtProximoNumero1.Visible = True
               
               mAuxS1 = BuscarClaveINI("Opciones adicionales para salida de materiales")
               If Len(mAuxS1) > 0 Then
                  mVector = VBA.Split(mAuxS1, ",")
                  For i = 0 To UBound(mVector)
                     With lblFieldLabel(i + 5)
                        .Caption = "Prox." & mVector(i) & ":"
                        .Visible = True
                     End With
                     txtProximoNumeroAd(i).Visible = True
                  Next
               End If
            Else
               lblFieldLabel(0).Caption = "Proximo numero : "
               lblFieldLabel(4).Visible = False
               txtProximoNumero1.Visible = False
               lblFieldLabel(5).Visible = False
               txtProximoNumeroAd(0).Visible = False
               lblFieldLabel(6).Visible = False
               txtProximoNumeroAd(1).Visible = False
               lblFieldLabel(7).Visible = False
               txtProximoNumeroAd(2).Visible = False
            End If
            Select Case dcfields(Index).BoundText
               Case 2, 41, 50, 51
                  origen.Registro.Fields("Letra").Value = "X"
                  txtLetra.Enabled = False
               Case Else
                  txtLetra.Enabled = True
            End Select
      End Select
   End If

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

Private Sub Option1_Click()

   If Option1.Value Then
      With Check1
         .Value = 0
         .Enabled = False
      End With
   End If

End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      Check1.Enabled = glbAdministrador
   End If

End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      Check1.Enabled = glbAdministrador
   End If

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

Private Sub txtLetra_GotFocus()

   If Len(txtLetra.Text) = 0 Then txtLetra.Text = "A"
   With txtLetra
      .SelStart = 0
      .SelLength = Len(.Text)
   End With
   
End Sub

Private Sub txtLetra_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      If InStr(1, "A B C E X a b c e x", Chr(KeyAscii)) = 0 And KeyAscii <> vbKeyBack Then
         KeyAscii = 0
      Else
         If KeyAscii >= 97 And KeyAscii <= 122 Then
            KeyAscii = KeyAscii - 32
         End If
         If Len(txtLetra.Text) >= 1 Then txtLetra.Text = ""
      End If
   End If

End Sub

Private Sub txtLetra_Validate(Cancel As Boolean)

   If Len(txtLetra.Text) <> 1 Then
      MsgBox "La letra del comprobante es invalida!"
      Cancel = True
   End If
   
End Sub

Private Sub txtProximoNumero_GotFocus()

   With txtProximoNumero
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProximoNumero_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub txtPuntoVenta_GotFocus()

   With txtPuntoVenta
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPuntoVenta_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub
