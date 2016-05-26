VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmAsignaProveedor 
   Caption         =   "Asignacion de proveedor"
   ClientHeight    =   4665
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9540
   Icon            =   "frmAsignaProveedor.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4665
   ScaleWidth      =   9540
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtRegistradoPor 
      Alignment       =   2  'Center
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
      Left            =   7245
      Locked          =   -1  'True
      TabIndex        =   18
      Top             =   4050
      Width           =   2085
   End
   Begin VB.TextBox txtFechaRegistracion 
      Alignment       =   2  'Center
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
      Left            =   7245
      Locked          =   -1  'True
      TabIndex        =   15
      Top             =   3645
      Width           =   2085
   End
   Begin VB.TextBox txtNumeroComprobante 
      Alignment       =   1  'Right Justify
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
      Height          =   330
      Left            =   1710
      Locked          =   -1  'True
      TabIndex        =   8
      Top             =   45
      Width           =   1410
   End
   Begin VB.TextBox txtFechaComprobante 
      Alignment       =   2  'Center
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
      Left            =   1710
      Locked          =   -1  'True
      TabIndex        =   7
      Top             =   400
      Width           =   1410
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancelar"
      Height          =   450
      Left            =   1620
      TabIndex        =   5
      Tag             =   "Cancelar"
      Top             =   3825
      Width           =   1410
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "Aceptar"
      Height          =   450
      Left            =   90
      TabIndex        =   4
      Tag             =   "Aceptar"
      Top             =   3825
      Width           =   1410
   End
   Begin VB.TextBox txtBusca 
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
      Left            =   7605
      TabIndex        =   0
      Top             =   855
      Width           =   1680
   End
   Begin VB.TextBox txtItemsSeleccionados 
      Alignment       =   1  'Right Justify
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
      Height          =   330
      Left            =   5220
      Locked          =   -1  'True
      TabIndex        =   6
      Top             =   405
      Width           =   4065
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   1710
      TabIndex        =   1
      Tag             =   "Proveedores"
      Top             =   1260
      Width           =   7620
      _ExtentX        =   13441
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   330
      Index           =   0
      Left            =   8055
      TabIndex        =   3
      Top             =   1665
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   63897601
      CurrentDate     =   36377
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   1
      Left            =   1710
      TabIndex        =   2
      Tag             =   "Empleados"
      Top             =   1665
      Width           =   3750
      _ExtentX        =   6615
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservacionesLlamada 
      Height          =   1095
      Left            =   1710
      TabIndex        =   21
      Top             =   2475
      Width           =   7620
      _ExtentX        =   13441
      _ExtentY        =   1931
      _Version        =   393217
      ScrollBars      =   2
      TextRTF         =   $"frmAsignaProveedor.frx":076A
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   330
      Index           =   1
      Left            =   1710
      TabIndex        =   23
      Top             =   2070
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   63897601
      CurrentDate     =   36377
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha de entrega :"
      Height          =   240
      Index           =   6
      Left            =   90
      TabIndex        =   24
      Top             =   2115
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      Caption         =   "Observaciones :"
      Height          =   240
      Index           =   5
      Left            =   90
      TabIndex        =   22
      Top             =   2520
      Width           =   1575
   End
   Begin VB.Label lblData 
      Caption         =   "Llamado por :"
      Height          =   240
      Index           =   1
      Left            =   90
      TabIndex        =   20
      Top             =   1710
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      Caption         =   "Registrado por :"
      Height          =   285
      Index           =   3
      Left            =   5355
      TabIndex        =   19
      Top             =   4095
      Width           =   1755
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha de llamado a proveedor :"
      Height          =   240
      Index           =   4
      Left            =   5670
      TabIndex        =   17
      Top             =   1710
      Width           =   2295
   End
   Begin VB.Label lblLabels 
      Caption         =   "Fecha de registracion :"
      Height          =   285
      Index           =   0
      Left            =   5355
      TabIndex        =   16
      Top             =   3690
      Width           =   1755
   End
   Begin VB.Label lblLabels 
      Caption         =   "Comprobante nro. :"
      Height          =   240
      Index           =   14
      Left            =   90
      TabIndex        =   14
      Top             =   90
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha comprobante :"
      Height          =   240
      Index           =   1
      Left            =   90
      TabIndex        =   13
      Top             =   450
      Width           =   1575
   End
   Begin VB.Label lblData 
      Caption         =   "Proveedor :"
      Height          =   240
      Index           =   0
      Left            =   90
      TabIndex        =   12
      Top             =   1305
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      Caption         =   "Buscar :"
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
      Index           =   8
      Left            =   6795
      TabIndex        =   11
      Top             =   900
      Width           =   735
   End
   Begin VB.Label lblTipo 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3600
      TabIndex        =   10
      Top             =   45
      Width           =   3510
   End
   Begin VB.Label lblLabels 
      Caption         =   "Items seleccionados :"
      Height          =   240
      Index           =   2
      Left            =   3600
      TabIndex        =   9
      Top             =   450
      Width           =   1575
   End
End
Attribute VB_Name = "frmAsignaProveedor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Ok As Boolean
Private mIdComprobante, mNumeroComprobante, mIdAutorizo, mIdProveedor, mIdLlamadoAProveedor As Long
Private mItemsSeleccionados, mIdItemsSeleccionados As String
Private mFechaComprobante, mFechaLlamadoAProveedor, mFechaEntrega As Date

Private Sub cmdCancel_Click()
   
   Ok = False
   Me.Hide

End Sub

Private Sub cmdOk_Click()
   
   Dim dc As DataCombo
   
   For Each dc In dcfields
      If dc.Enabled Then
         If Not IsNumeric(dc.BoundText) Then
            MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
            Exit Sub
         End If
      End If
   Next
         
   If DTFields(1).Value < mFechaComprobante Then
      MsgBox "La fecha de entrega no puede ser anterior a la del comprobante!", vbExclamation
      Exit Sub
   End If
   
   Ok = True
   Me.Hide

End Sub

Private Sub dcfields_GotFocus(Index As Integer)

   If Len(dcfields(Index).Text) = 0 Then SendKeys "%{DOWN}"

End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Let TipoComprobante(ByVal vnewvalue As EnumFormularios)

   mTipoComprobante = vnewvalue

   Select Case mTipoComprobante
      Case EnumFormularios.RequerimientoMateriales
         lblTipo.Caption = "REQUERIMIENTO"
      Case EnumFormularios.ListaAcopio
         lblTipo.Caption = "LISTA DE ACOPIO"
   End Select

End Property

Public Property Let IdComprobante(ByVal vnewvalue As Long)

   mIdComprobante = vnewvalue

End Property

Public Property Let IdLlamadoAProveedor(ByVal vnewvalue As Long)

   mIdLlamadoAProveedor = vnewvalue

End Property

Public Property Let FechaLlamadoAProveedor(ByVal vnewvalue As Date)

   mFechaLlamadoAProveedor = vnewvalue

End Property

Public Property Let FechaEntrega(ByVal vnewvalue As Date)

   mFechaEntrega = vnewvalue

End Property

Public Property Let IdProveedor(ByVal vnewvalue As Long)

   mIdProveedor = vnewvalue

End Property

Public Property Let NumeroComprobante(ByVal vnewvalue As Long)

   mNumeroComprobante = vnewvalue

End Property

Public Property Let FechaComprobante(ByVal vnewvalue As Date)

   mFechaComprobante = vnewvalue

End Property

Public Property Let IdAutorizo(ByVal vnewvalue As Long)

   mIdAutorizo = vnewvalue

End Property

Public Property Let ItemsSeleccionados(ByVal vnewvalue As String)

   mItemsSeleccionados = vnewvalue

End Property

Public Property Let IdItemsSeleccionados(ByVal vnewvalue As String)

   mIdItemsSeleccionados = vnewvalue

   Dim dc As DataCombo
   
   txtNumeroComprobante.Text = mNumeroComprobante
   txtFechaComprobante.Text = mFechaComprobante
   txtItemsSeleccionados.Text = mItemsSeleccionados
   
   Set dcfields(0).RowSource = Aplicacion.CargarLista(dcfields(0).Tag)
'   Set dcfields(1).RowSource = Aplicacion.Empleados.TraerFiltrado("_PorSector", "Compras")
   Set dcfields(1).RowSource = Aplicacion.Empleados.TraerLista
   
   If mIdProveedor > 0 Then
      dcfields(0).BoundText = mIdProveedor
   End If
   If mIdLlamadoAProveedor > 0 Then
      dcfields(1).BoundText = mIdLlamadoAProveedor
   End If
   
   DTFields(0).Value = mFechaLlamadoAProveedor
   DTFields(1).Value = mFechaEntrega
   
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

Private Sub txtBusca_GotFocus()

   With txtBusca
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBusca_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      If KeyAscii = 13 Then
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set dcfields(0).RowSource = Aplicacion.Proveedores.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set dcfields(0).RowSource = Aplicacion.Proveedores.TraerLista
         End If
      End If
      dcfields(0).SetFocus
'      SendKeys "%{DOWN}"
   End If

End Sub

