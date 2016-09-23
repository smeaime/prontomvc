VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{F7D972E3-E925-4183-AB00-B6A253442139}#1.0#0"; "FileBrowser1.ocx"
Begin VB.Form frmPathPresto 
   ClientHeight    =   1410
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8985
   Icon            =   "frmPathPresto.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1410
   ScaleWidth      =   8985
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   7875
      TabIndex        =   13
      Text            =   "Text1"
      Top             =   1080
      Visible         =   0   'False
      Width           =   1050
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   315
      Index           =   1
      Left            =   135
      TabIndex        =   1
      Top             =   945
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   360
      Index           =   0
      Left            =   135
      TabIndex        =   0
      Top             =   540
      Width           =   1485
   End
   Begin FileBrowser1.FileBrowser FileBrowser1 
      Height          =   330
      Index           =   0
      Left            =   2790
      TabIndex        =   8
      Top             =   135
      Width           =   6045
      _ExtentX        =   10663
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
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   0
      Left            =   6435
      TabIndex        =   9
      Tag             =   "Obras"
      Top             =   630
      Visible         =   0   'False
      Width           =   2400
      _ExtentX        =   4233
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin VB.Frame Frame1 
      Caption         =   "Procesos a realizar :"
      Enabled         =   0   'False
      Height          =   1500
      Left            =   1710
      TabIndex        =   3
      Top             =   1035
      Visible         =   0   'False
      Width           =   5865
      Begin VB.CheckBox Check1 
         Alignment       =   1  'Right Justify
         Caption         =   "Pasar facturas de Presto como comprobantes de proveedores en Pronto :"
         Height          =   240
         Index           =   3
         Left            =   135
         TabIndex        =   7
         Top             =   1125
         Width           =   5640
      End
      Begin VB.CheckBox Check1 
         Alignment       =   1  'Right Justify
         Caption         =   "Pasar contratos de Presto como requerimientos en Pronto :"
         Height          =   240
         Index           =   2
         Left            =   135
         TabIndex        =   6
         Top             =   855
         Width           =   5640
      End
      Begin VB.CheckBox Check1 
         Alignment       =   1  'Right Justify
         Caption         =   "Actualizar clientes desde Presto hacia Pronto :"
         Height          =   240
         Index           =   1
         Left            =   135
         TabIndex        =   5
         Top             =   585
         Width           =   5640
      End
      Begin VB.CheckBox Check1 
         Alignment       =   1  'Right Justify
         Caption         =   "Actualizar proveedores desde Presto hacia Pronto :"
         Height          =   240
         Index           =   0
         Left            =   135
         TabIndex        =   4
         Top             =   315
         Width           =   5640
      End
   End
   Begin MSComCtl2.DTPicker DTFields 
      Height          =   330
      Index           =   0
      Left            =   4005
      TabIndex        =   11
      Top             =   630
      Visible         =   0   'False
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   57475073
      CurrentDate     =   36377
   End
   Begin VB.Label Label3 
      Height          =   240
      Left            =   6615
      TabIndex        =   14
      Top             =   900
      Visible         =   0   'False
      Width           =   2205
   End
   Begin VB.Label Label2 
      Height          =   240
      Left            =   1755
      TabIndex        =   12
      Top             =   675
      Visible         =   0   'False
      Width           =   2205
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Obra :"
      Height          =   285
      Index           =   0
      Left            =   5805
      TabIndex        =   10
      Top             =   645
      Visible         =   0   'False
      Width           =   585
   End
   Begin VB.Label Label1 
      Height          =   240
      Left            =   180
      TabIndex        =   2
      Top             =   180
      Width           =   2535
   End
End
Attribute VB_Name = "frmPathPresto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Ok As Boolean
Private mvarId As Integer

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then
      
      If Not Len(Trim(Dir(FileBrowser1(0).Text))) <> 0 Then
         MsgBox "El archivo indicado no existe!", vbExclamation
         Exit Sub
      End If
      
      If (Me.Id = 2 Or Me.Id = 4) And Not IsNumeric(dcfields(0).BoundText) Then
         MsgBox "Debe indicar la obra origen del excel!", vbExclamation
         Exit Sub
      End If
      
      On Error Resume Next
      
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Parametros.TraerTodos
      oRs.Fields("PathObra").Value = FileBrowser1(0).Text
'      Aplicacion.Parametros.Guardar
      oRs.Close
      Set oRs = Nothing
      
      Ok = True
      
   Else
   
      Ok = False
      
   End If
   
   Me.Hide

End Sub

Private Sub FileBrowser1_Change(Index As Integer)

   If Len(Trim(FileBrowser1(Index).Text)) > 0 Then
      FileBrowser1(Index).InitDir = FileBrowser1(Index).Text
   End If
   
End Sub

Private Sub Form_Load()

   Dim oRs As ADOR.Recordset
   
   Set oRs = Aplicacion.Parametros.TraerTodos
   
   Select Case Me.Id
      Case 1
         If Not IsNull(oRs.Fields("PathObra").Value) Then
            FileBrowser1(0).Text = oRs.Fields("PathObra").Value
         End If
         Me.Caption = "Archivo Presto"
         Label1.Caption = "Ubicacion del archivo PRESTO :"
      Case 2
         Me.Caption = "Archivo de importacion de comprobantes (FF)"
         Label1.Caption = "Ubicacion del archivo excel :"
         Set dcfields(0).RowSource = Aplicacion.Obras.TraerLista
         lblData(0).Visible = True
         dcfields(0).Visible = True
         With Label2
            .Caption = "Fecha de contabilizacion :"
            .Visible = True
         End With
         With DTFields(0)
            .Value = Date
            .Visible = True
         End With
         With Label3
            .Top = Me.Label2.Top + Me.Label2.Height + 100
            .Left = Me.Label2.Left
            .Caption = "Nro. comprobante inicial :"
            .Visible = True
         End With
         With Text1
            .Top = Me.Label3.Top
            .Left = Me.DTFields(0).Left
            .Text = oRs.Fields("ProximoComprobanteProveedorReferencia").Value
            .Visible = True
         End With
      Case 3
         Me.Caption = "Archivo de importacion de conjuntos"
         Label1.Caption = "Ubicacion del archivo excel :"
      Case 4
         Me.Caption = "Archivo de importacion de ordenes de pago"
         Label1.Caption = "Ubicacion del archivo excel :"
         Set dcfields(0).RowSource = Aplicacion.Obras.TraerLista
         lblData(0).Visible = True
         dcfields(0).Visible = True
      Case 5
         Me.Caption = "Importacion de cobranzas ( valores )"
         Label1.Caption = "Ubicacion del archivo :"
      Case 6
         Me.Caption = "Importacion de cobranzas ( efectivo )"
         Label1.Caption = "Ubicacion del archivo :"
      Case 7
         Me.Caption = "Importacion de requerimientos"
         Label1.Caption = "Ubicacion del archivo :"
      Case 8
         Me.Caption = "Importacion de cobranzas ( PagoFacil )"
         Label1.Caption = "Ubicacion del archivo :"
      Case 9
         Me.Caption = "Importacion de articulos"
         Label1.Caption = "Ubicacion del archivo :"
      Case 10
         Me.Caption = "Archivo de importacion de comprobantes"
         Label1.Caption = "Ubicacion del archivo excel :"
         lblData(0).Visible = False
         dcfields(0).Visible = False
         Label2.Visible = False
         DTFields(0).Visible = False
         With Label3
            .Top = Me.Label2.Top + Me.Label2.Height + 100
            .Left = Me.Label2.Left
            .Caption = "Nro. comprobante inicial :"
            .Visible = True
         End With
         With Text1
            .Top = Me.Label3.Top
            .Left = Me.DTFields(0).Left
            .Text = oRs.Fields("ProximoComprobanteProveedorReferencia").Value
            .Visible = True
         End With
      Case 11
         Me.Caption = "Importacion de datos"
         Label1.Caption = "Ubicacion del archivo :"
         With Label2
            .Caption = "Fecha de contabilizacion :"
            .Visible = True
         End With
         With DTFields(0)
            .Value = Date
            .Visible = True
         End With
      Case 12
         Me.Caption = "Archivo de importacion de presupuesto de obra"
         Label1.Caption = "Ubicacion del archivo excel :"
         With Label3
            .Top = Me.Label2.Top + Me.Label2.Height + 100
            .Left = Me.Label2.Left
            .Caption = "Codigo de presupuesto :"
            .Visible = True
         End With
         With Text1
            .Top = Me.Label3.Top
            .Left = Me.DTFields(0).Left
            .Width = Me.DTFields(0).Width / 3
            .Text = 0
            .Visible = True
         End With
      Case 13
         Me.Caption = "Importacion de notas de debito"
         Label1.Caption = "Ubicacion del archivo :"
      Case 14
         Me.Caption = "Archivo de importacion de comprobantes (FF Modelo 2)"
         Label1.Caption = "Ubicacion del archivo excel :"
         With Label2
            .Caption = "Fecha de contabilizacion :"
            .Visible = True
         End With
         With DTFields(0)
            .Value = Date
            .Visible = True
         End With
         With Label3
            .Top = Me.Label2.Top + Me.Label2.Height + 100
            .Left = Me.Label2.Left
            .Caption = "Nro. comprobante inicial :"
            .Visible = True
         End With
         With Text1
            .Top = Me.Label3.Top
            .Left = Me.DTFields(0).Left
            .Text = oRs.Fields("ProximoComprobanteProveedorReferencia").Value
            .Visible = True
         End With
      Case 15
         Me.Caption = "Importacion de cobranzas ( Santander Rio )"
         Label1.Caption = "Ubicacion del archivo :"
      Case 16
         Me.Caption = "Importacion de comprobantes de venta"
         Label1.Caption = "Ubicacion del archivo :"
      Case 17
         Me.Caption = "Importacion de extracto bancario"
         Label1.Caption = "Ubicacion del archivo :"
      Case 18
         Me.Caption = "Importacion de certificado de obra"
         Label1.Caption = "Ubicacion del archivo :"
   
   End Select
   
   oRs.Close
   Set oRs = Nothing
   
   Ok = False

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Property Get Id() As Integer

   Id = mvarId

End Property

Public Property Let Id(ByVal vNewValue As Integer)

   mvarId = vNewValue

End Property

Private Sub Text1_GotFocus()

   With Text1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
