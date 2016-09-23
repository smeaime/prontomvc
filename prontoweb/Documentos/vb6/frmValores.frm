VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmValores 
   Caption         =   "Valores"
   ClientHeight    =   4695
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11355
   Icon            =   "frmValores.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4695
   ScaleWidth      =   11355
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroDeposito"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   1
      EndProperty
      Height          =   360
      Left            =   7110
      TabIndex        =   29
      Top             =   2970
      Width           =   1455
   End
   Begin VB.Frame Frame1 
      Height          =   510
      Left            =   180
      TabIndex        =   24
      Top             =   1890
      Width           =   6000
      Begin VB.CheckBox Check3 
         Caption         =   "Entregado"
         Height          =   240
         Left            =   4185
         TabIndex        =   27
         Top             =   180
         Width           =   1320
      End
      Begin VB.CheckBox Check2 
         Caption         =   "Endosado"
         Height          =   240
         Left            =   2385
         TabIndex        =   26
         Top             =   180
         Width           =   1545
      End
      Begin VB.CheckBox Check1 
         Caption         =   "Depositado"
         Height          =   195
         Left            =   405
         TabIndex        =   25
         Top             =   180
         Width           =   1545
      End
   End
   Begin VB.TextBox txtFechaValor 
      Alignment       =   1  'Right Justify
      DataField       =   "FechaValor"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   360
      Left            =   2160
      TabIndex        =   23
      Top             =   1350
      Width           =   1320
   End
   Begin VB.TextBox txtTipoValor 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   360
      Left            =   2160
      TabIndex        =   22
      Top             =   585
      Width           =   1995
   End
   Begin VB.TextBox txtFechaComprobante 
      Alignment       =   1  'Right Justify
      DataField       =   "FechaComprobante"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   360
      Left            =   9225
      TabIndex        =   21
      Top             =   1035
      Width           =   1140
   End
   Begin VB.TextBox txtNumeroComprobante 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroComprobante"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   360
      Left            =   7245
      TabIndex        =   20
      Top             =   1035
      Width           =   1320
   End
   Begin VB.TextBox txtTipoComprobante 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   360
      Left            =   6435
      TabIndex        =   17
      Top             =   1035
      Width           =   690
   End
   Begin VB.TextBox txtBancoOrigen 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   360
      Left            =   6435
      TabIndex        =   15
      Top             =   630
      Width           =   4650
   End
   Begin VB.TextBox txtCliente 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   360
      Left            =   6435
      TabIndex        =   13
      Top             =   225
      Width           =   4650
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Enabled         =   0   'False
      Height          =   405
      Index           =   0
      Left            =   4095
      TabIndex        =   4
      Top             =   4095
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   5805
      TabIndex        =   3
      Top             =   4095
      Width           =   1485
   End
   Begin VB.TextBox txtNumeroDeposito 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroDeposito"
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   1
      EndProperty
      Height          =   360
      Left            =   1485
      TabIndex        =   2
      Top             =   2970
      Width           =   1455
   End
   Begin VB.TextBox txtNumeroValor 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroValor"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   360
      Left            =   2160
      TabIndex        =   1
      Top             =   960
      Width           =   1995
   End
   Begin VB.TextBox txtNumeroInterno 
      DataField       =   "NumeroInterno"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   2160
      TabIndex        =   0
      Top             =   180
      Width           =   735
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdBancoDeposito"
      Height          =   315
      Index           =   0
      Left            =   1485
      TabIndex        =   5
      Tag             =   "Bancos"
      Top             =   2655
      Width           =   4065
      _ExtentX        =   7170
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdBanco"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaDeposito"
      Height          =   330
      Index           =   0
      Left            =   1485
      TabIndex        =   6
      Top             =   3375
      Width           =   1470
      _ExtentX        =   2593
      _ExtentY        =   582
      _Version        =   393216
      Format          =   64421889
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   1
      Left            =   7110
      TabIndex        =   30
      Tag             =   "Proveedores"
      Top             =   2655
      Width           =   4065
      _ExtentX        =   7170
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdBanco"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaOrdenPago"
      Height          =   330
      Index           =   1
      Left            =   7110
      TabIndex        =   31
      Top             =   3375
      Width           =   1470
      _ExtentX        =   2593
      _ExtentY        =   582
      _Version        =   393216
      Format          =   64421889
      CurrentDate     =   36377
   End
   Begin VB.Label lblLabels 
      Caption         =   "Orden de  pago :"
      Height          =   300
      Index           =   12
      Left            =   5760
      TabIndex        =   34
      Top             =   3015
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "Proveedor :"
      Height          =   300
      Index           =   11
      Left            =   5760
      TabIndex        =   33
      Top             =   2655
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha pago :"
      Height          =   300
      Index           =   10
      Left            =   5760
      TabIndex        =   32
      Top             =   3375
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nro. deposito :"
      Height          =   300
      Index           =   9
      Left            =   135
      TabIndex        =   28
      Top             =   3015
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "del"
      Height          =   300
      Index           =   8
      Left            =   8730
      TabIndex        =   19
      Top             =   1080
      Width           =   330
   End
   Begin VB.Label lblLabels 
      Caption         =   "Comprobante :"
      Height          =   300
      Index           =   7
      Left            =   4860
      TabIndex        =   18
      Top             =   1065
      Width           =   1455
   End
   Begin VB.Label lblLabels 
      Caption         =   "Banco origen :"
      Height          =   300
      Index           =   6
      Left            =   4860
      TabIndex        =   16
      Top             =   660
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cliente :"
      Height          =   300
      Index           =   4
      Left            =   4860
      TabIndex        =   14
      Top             =   255
      Width           =   1410
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha deposito :"
      Height          =   300
      Index           =   5
      Left            =   135
      TabIndex        =   12
      Top             =   3375
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tipo de valor :"
      Height          =   300
      Index           =   2
      Left            =   180
      TabIndex        =   11
      Top             =   600
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero del valor :"
      Height          =   300
      Index           =   0
      Left            =   180
      TabIndex        =   10
      Top             =   990
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero interno :"
      Height          =   300
      Index           =   3
      Left            =   180
      TabIndex        =   9
      Top             =   225
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Banco :"
      Height          =   300
      Index           =   1
      Left            =   135
      TabIndex        =   8
      Top             =   2655
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha de vencimiento :"
      Height          =   300
      Index           =   22
      Left            =   180
      TabIndex        =   7
      Top             =   1395
      Width           =   1815
   End
End
Attribute VB_Name = "frmValores"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Valor
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

   Select Case Index
   
      Case 0
   
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
            .ListaEditada = "+SubVl1"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
'      Case 1
'
'         origen.Eliminar
'
'         est = baja
'
'         With actL2
'            .ListaEditada = "+SubVl1"
'            .AccionRegistro = est
'            .Disparador = mvarId
'         End With
   
   End Select
   
   Unload Me

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oAp.Valores.Item(vnewvalue)
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
   
'   cmd(0).Enabled = False
'   If Me.NivelAcceso = Medio Then
'      If mvarId <= 0 Then cmd(0).Enabled = True
'   ElseIf Me.NivelAcceso = Alto Then
'      cmd(0).Enabled = True
'   End If
   
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

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

