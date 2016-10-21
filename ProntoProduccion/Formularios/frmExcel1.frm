VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.3#0"; "Controles1013.ocx"
Begin VB.Form frmExcel1 
   ClientHeight    =   3780
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6255
   Icon            =   "frmExcel1.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3780
   ScaleWidth      =   6255
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame10 
      Caption         =   "Pedidos :"
      Height          =   645
      Left            =   180
      TabIndex        =   63
      Top             =   8460
      Visible         =   0   'False
      Width           =   6090
      Begin VB.OptionButton Option26 
         Caption         =   "Elegir uno"
         Height          =   240
         Left            =   1170
         TabIndex        =   66
         Top             =   270
         Width           =   1005
      End
      Begin VB.OptionButton Option25 
         Caption         =   "Todos"
         Height          =   195
         Left            =   270
         TabIndex        =   65
         Top             =   270
         Width           =   825
      End
      Begin VB.TextBox txtNumero 
         Alignment       =   2  'Center
         Height          =   330
         Left            =   2385
         TabIndex        =   64
         Top             =   225
         Width           =   1410
      End
   End
   Begin VB.Frame Frame9 
      Caption         =   "Articulos :"
      Height          =   645
      Left            =   180
      TabIndex        =   58
      Top             =   7650
      Visible         =   0   'False
      Width           =   6090
      Begin VB.TextBox txtCodigoArticulo 
         Alignment       =   2  'Center
         Height          =   330
         Left            =   2385
         TabIndex        =   62
         Top             =   225
         Width           =   870
      End
      Begin VB.OptionButton Option23 
         Caption         =   "Todos"
         Height          =   195
         Left            =   270
         TabIndex        =   60
         Top             =   270
         Width           =   825
      End
      Begin VB.OptionButton Option24 
         Caption         =   "Elegir uno"
         Height          =   240
         Left            =   1170
         TabIndex        =   59
         Top             =   270
         Width           =   1005
      End
      Begin MSDataListLib.DataCombo dcfields 
         Height          =   315
         Index           =   6
         Left            =   3285
         TabIndex        =   61
         Tag             =   "Articulos"
         Top             =   225
         Width           =   2625
         _ExtentX        =   4630
         _ExtentY        =   556
         _Version        =   393216
         Enabled         =   0   'False
         ListField       =   "Titulo"
         BoundColumn     =   "IdArticulo"
         Text            =   ""
      End
   End
   Begin VB.CheckBox Check1 
      Height          =   195
      Left            =   2610
      TabIndex        =   56
      Top             =   1350
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.Frame Frame8 
      Height          =   645
      Left            =   180
      TabIndex        =   51
      Top             =   6840
      Visible         =   0   'False
      Width           =   2940
      Begin VB.OptionButton Option22 
         Height          =   240
         Left            =   2070
         TabIndex        =   57
         Top             =   270
         Visible         =   0   'False
         Width           =   780
      End
      Begin VB.OptionButton Option20 
         Height          =   195
         Left            =   135
         TabIndex        =   53
         Top             =   270
         Width           =   1185
      End
      Begin VB.OptionButton Option21 
         Height          =   240
         Left            =   1395
         TabIndex        =   52
         Top             =   270
         Width           =   1455
      End
   End
   Begin VB.Frame Frame7 
      Caption         =   "Subcontratos :"
      Height          =   645
      Left            =   180
      TabIndex        =   42
      Top             =   5175
      Visible         =   0   'False
      Width           =   6090
      Begin VB.OptionButton Option19 
         Caption         =   "Elegir uno"
         Height          =   240
         Left            =   1755
         TabIndex        =   44
         Top             =   270
         Width           =   1005
      End
      Begin VB.OptionButton Option18 
         Caption         =   "Todos"
         Height          =   195
         Left            =   360
         TabIndex        =   43
         Top             =   270
         Width           =   915
      End
      Begin MSDataListLib.DataCombo dcfields 
         Height          =   315
         Index           =   4
         Left            =   4455
         TabIndex        =   45
         Tag             =   "Pedidos"
         Top             =   225
         Width           =   1455
         _ExtentX        =   2566
         _ExtentY        =   556
         _Version        =   393216
         Enabled         =   0   'False
         ListField       =   "Titulo"
         BoundColumn     =   "IdPedido"
         Text            =   ""
      End
      Begin VB.Label Label3 
         Caption         =   "Subcontrato :"
         Height          =   255
         Left            =   3330
         TabIndex        =   46
         Top             =   270
         Width           =   1050
      End
   End
   Begin VB.Frame Frame6 
      Caption         =   "Proveedores :"
      Height          =   645
      Left            =   180
      TabIndex        =   37
      Top             =   4410
      Visible         =   0   'False
      Width           =   6090
      Begin VB.OptionButton Option16 
         Caption         =   "Todos"
         Height          =   195
         Left            =   360
         TabIndex        =   39
         Top             =   270
         Width           =   915
      End
      Begin VB.OptionButton Option17 
         Caption         =   "Elegir uno"
         Height          =   240
         Left            =   1440
         TabIndex        =   38
         Top             =   270
         Width           =   1005
      End
      Begin MSDataListLib.DataCombo dcfields 
         Height          =   315
         Index           =   3
         Left            =   3690
         TabIndex        =   40
         Tag             =   "Proveedores"
         Top             =   225
         Width           =   2220
         _ExtentX        =   3916
         _ExtentY        =   556
         _Version        =   393216
         Enabled         =   0   'False
         ListField       =   "Titulo"
         BoundColumn     =   "IdProveedor"
         Text            =   ""
      End
      Begin VB.Label Label2 
         Caption         =   "Proveedor :"
         Height          =   255
         Left            =   2790
         TabIndex        =   41
         Top             =   270
         Width           =   870
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Grupos de obras :"
      Height          =   645
      Left            =   180
      TabIndex        =   32
      Top             =   3645
      Visible         =   0   'False
      Width           =   6090
      Begin VB.OptionButton Option14 
         Caption         =   "Todos lo grupos"
         Height          =   195
         Left            =   360
         TabIndex        =   34
         Top             =   270
         Width           =   1635
      End
      Begin VB.OptionButton Option15 
         Caption         =   "Elegir un grupo"
         Height          =   240
         Left            =   2160
         TabIndex        =   33
         Top             =   270
         Width           =   1545
      End
      Begin MSDataListLib.DataCombo dcfields 
         Height          =   315
         Index           =   2
         Left            =   4680
         TabIndex        =   35
         Tag             =   "GruposObras"
         Top             =   225
         Width           =   1230
         _ExtentX        =   2170
         _ExtentY        =   556
         _Version        =   393216
         Enabled         =   0   'False
         ListField       =   "Titulo"
         BoundColumn     =   "IdGrupoObra"
         Text            =   ""
      End
      Begin VB.Label Label1 
         Caption         =   "Grupo :"
         Height          =   255
         Left            =   4005
         TabIndex        =   36
         Top             =   270
         Width           =   555
      End
   End
   Begin VB.TextBox Text2 
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
      Left            =   4275
      TabIndex        =   31
      Top             =   0
      Visible         =   0   'False
      Width           =   645
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   1
      Left            =   3330
      TabIndex        =   28
      Top             =   0
      Visible         =   0   'False
      Width           =   915
      _ExtentX        =   1614
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin VB.TextBox txtLetra 
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
      Height          =   330
      Left            =   1710
      TabIndex        =   30
      Top             =   0
      Visible         =   0   'False
      Width           =   300
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
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
      Left            =   2070
      TabIndex        =   29
      Top             =   0
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.Frame Frame4 
      Caption         =   "Tipo de destino : "
      Height          =   1410
      Left            =   1845
      TabIndex        =   20
      Top             =   2340
      Visible         =   0   'False
      Width           =   4335
      Begin VB.OptionButton Option13 
         Caption         =   "Salida de mat. a obra"
         Height          =   240
         Left            =   135
         TabIndex        =   27
         Top             =   1125
         Width           =   1995
      End
      Begin VB.OptionButton Option12 
         Caption         =   "Salida de mat. a fabrica"
         Height          =   240
         Left            =   2070
         TabIndex        =   26
         Top             =   855
         Width           =   1995
      End
      Begin VB.OptionButton Option7 
         Caption         =   "A Facturar"
         Height          =   240
         Left            =   135
         TabIndex        =   25
         Top             =   315
         Width           =   1230
      End
      Begin VB.OptionButton Option8 
         Caption         =   "A proveedor para fabricar"
         Height          =   240
         Left            =   2070
         TabIndex        =   24
         Top             =   315
         Width           =   2175
      End
      Begin VB.OptionButton Option9 
         Caption         =   "Con cargo devolución"
         Height          =   240
         Left            =   135
         TabIndex        =   23
         Top             =   585
         Width           =   1950
      End
      Begin VB.OptionButton Option10 
         Caption         =   "Muestra"
         Height          =   240
         Left            =   2070
         TabIndex        =   22
         Top             =   585
         Width           =   1230
      End
      Begin VB.OptionButton Option11 
         Caption         =   "A prestamo"
         Height          =   240
         Left            =   135
         TabIndex        =   21
         Top             =   855
         Width           =   1230
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Obras :"
      Height          =   645
      Left            =   90
      TabIndex        =   15
      Top             =   1575
      Width           =   6090
      Begin VB.OptionButton Option6 
         Caption         =   "Elegir una obra"
         Height          =   240
         Left            =   2160
         TabIndex        =   17
         Top             =   270
         Width           =   1545
      End
      Begin VB.OptionButton Option5 
         Caption         =   "Todas las obras"
         Height          =   195
         Left            =   360
         TabIndex        =   16
         Top             =   270
         Width           =   1635
      End
      Begin MSDataListLib.DataCombo dcfields 
         Height          =   315
         Index           =   0
         Left            =   4680
         TabIndex        =   18
         Tag             =   "Obras"
         Top             =   225
         Width           =   1230
         _ExtentX        =   2170
         _ExtentY        =   556
         _Version        =   393216
         Enabled         =   0   'False
         ListField       =   "Titulo"
         BoundColumn     =   "IdObra"
         Text            =   ""
      End
      Begin VB.Label lblObra 
         Caption         =   "Obra :"
         Height          =   255
         Left            =   4005
         TabIndex        =   19
         Top             =   270
         Width           =   555
      End
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   135
      TabIndex        =   4
      Top             =   3195
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   135
      TabIndex        =   3
      Top             =   2565
      Width           =   1485
   End
   Begin VB.TextBox txtCopias 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   330
      Left            =   5490
      TabIndex        =   2
      Top             =   945
      Width           =   645
   End
   Begin VB.Frame Frame2 
      Caption         =   "Informe :"
      Height          =   645
      Left            =   3240
      TabIndex        =   8
      Top             =   90
      Width           =   2940
      Begin VB.OptionButton Option3 
         Caption         =   "A Excel"
         Height          =   195
         Left            =   135
         TabIndex        =   10
         Top             =   315
         Width           =   1365
      End
      Begin VB.OptionButton Option4 
         Caption         =   "A impresora"
         Height          =   195
         Left            =   1530
         TabIndex        =   9
         Top             =   315
         Width           =   1320
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Tipo de emision :"
      Height          =   645
      Left            =   90
      TabIndex        =   5
      Top             =   90
      Width           =   2940
      Begin VB.OptionButton Option2 
         Caption         =   "Resumido"
         Height          =   240
         Left            =   1620
         TabIndex        =   7
         Top             =   270
         Width           =   1185
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Detallado"
         Height          =   195
         Left            =   360
         TabIndex        =   6
         Top             =   270
         Width           =   1095
      End
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaEntrega"
      Height          =   360
      Index           =   0
      Left            =   1035
      TabIndex        =   0
      Top             =   945
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   635
      _Version        =   393216
      Format          =   60489729
      CurrentDate     =   36526
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaEntrega"
      Height          =   360
      Index           =   1
      Left            =   3240
      TabIndex        =   1
      Top             =   945
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   635
      _Version        =   393216
      Format          =   60489729
      CurrentDate     =   36526
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   375
      Left            =   6030
      TabIndex        =   14
      Top             =   45
      Visible         =   0   'False
      Width           =   285
      _ExtentX        =   503
      _ExtentY        =   661
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmExcel1.frx":076A
   End
   Begin MSDataListLib.DataCombo dcfields1 
      Height          =   315
      Index           =   0
      Left            =   225
      TabIndex        =   47
      Top             =   5940
      Visible         =   0   'False
      Width           =   915
      _ExtentX        =   1614
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields1 
      Height          =   315
      Index           =   1
      Left            =   1215
      TabIndex        =   48
      Top             =   5940
      Visible         =   0   'False
      Width           =   915
      _ExtentX        =   1614
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin Controles1013.DbListView Lista 
      Height          =   825
      Left            =   2205
      TabIndex        =   50
      Top             =   5940
      Visible         =   0   'False
      Width           =   4065
      _ExtentX        =   7170
      _ExtentY        =   1455
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmExcel1.frx":07EC
      OLEDropMode     =   1
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo dcfields 
      Height          =   315
      Index           =   5
      Left            =   5445
      TabIndex        =   55
      Top             =   1305
      Visible         =   0   'False
      Width           =   915
      _ExtentX        =   1614
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin VB.Label Label4 
      Height          =   255
      Left            =   4680
      TabIndex        =   54
      Top             =   1395
      Visible         =   0   'False
      Width           =   555
   End
   Begin VB.Label lblEstado 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3690
      TabIndex        =   49
      Top             =   2250
      Visible         =   0   'False
      Width           =   2670
   End
   Begin VB.Label lblLabels 
      Caption         =   "Copias :"
      Height          =   300
      Index           =   2
      Left            =   4725
      TabIndex        =   13
      Top             =   990
      Width           =   690
   End
   Begin VB.Label lblLabels 
      Caption         =   "hasta el :"
      Height          =   300
      Index           =   0
      Left            =   2475
      TabIndex        =   12
      Top             =   990
      Width           =   690
   End
   Begin VB.Label lblLabels 
      Caption         =   "Desde el :"
      Height          =   300
      Index           =   1
      Left            =   135
      TabIndex        =   11
      Top             =   990
      Width           =   780
   End
End
Attribute VB_Name = "frmExcel1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mPlanilla As String, mTitulo As String, mCodigo As String

Private Sub Check1_Click()

   If Check1.Value = 1 Then
      dcfields(5).Enabled = True
   Else
      dcfields(5).Enabled = False
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
      
      Case 0
         
         Dim mDesde As Date, mHasta As Date
         Dim mTipo As String, mResDet As String, mImprime As String
         Dim mArgL2 As String, mArgL3 As String, mArgL4 As String, mArgL5 As String
         Dim mArgL6 As String, mArgL7 As String, mArticulo As String
         Dim mObra As Long, mIdProveedor As Long, mIdPedido As Long
         Dim mArgL1 As Long, mNumero As Long, mIdArticulo As Long
         Dim mSalida As Integer, mGrupo As Integer
         Dim mAux1
         Dim oEx As Excel.Application
         Dim oRs As ADOR.Recordset
         
         If mCodigo = "AnuFac" Then
            If Len(txtLetra.Text) = 0 Then
               MsgBox "No indico la letra de las facturas a anular", vbExclamation
               Exit Sub
            End If
            If Len(dcfields(1).Text) = 0 Then
               MsgBox "No indico el punto de venta de las facturas a anular", vbExclamation
               Exit Sub
            End If
            If Val(text1.Text) <= 0 Then
               MsgBox "No indico el numero inicial de factura a anular", vbExclamation
               Exit Sub
            End If
            If Val(Text2.Text) <= 0 Then
               MsgBox "No indico la cantidad de facturas a anular", vbExclamation
               Exit Sub
            End If
            AnularFacturas
            Unload Me
            Exit Sub
         
         ElseIf mCodigo = "AnuFac1" Then
            If Len(txtLetra.Text) = 0 Then
               MsgBox "No indico la letra de las facturas a anular", vbExclamation
               Exit Sub
            End If
            If Len(dcfields(1).Text) = 0 Then
               MsgBox "No indico el punto de venta de las facturas a anular", vbExclamation
               Exit Sub
            End If
            If Val(text1.Text) <= 0 Then
               MsgBox "No indico el numero inicial de factura a anular", vbExclamation
               Exit Sub
            End If
            If Val(Text2.Text) <= 0 Then
               MsgBox "No indico el numero de factura final", vbExclamation
               Exit Sub
            End If
            If Val(text1.Text) > Val(Text2.Text) Then
               MsgBox "El numero de factura inicial debe ser " & vbCrLf & _
                        "menor o igual al numero de factura final", vbExclamation
               Exit Sub
            End If
            AnularFacturasExistentes
            Unload Me
            Exit Sub
         
         ElseIf mCodigo = "GenFac" Then
            If Len(dcfields1(0).Text) = 0 Then
               MsgBox "No indico el punto de venta de las facturas A a generar", vbExclamation
               Exit Sub
            End If
            If Len(dcfields1(1).Text) = 0 Then
               MsgBox "No indico el punto de venta de las facturas B a generar", vbExclamation
               Exit Sub
            End If
            mGrupo = -1
            If Frame2.Visible Then
               If Option3.Value Then
                  mGrupo = 1
               ElseIf Option4.Value Then
                  mGrupo = 2
               End If
            End If
            GenerarFacturasAutomaticas Option1.Value, mGrupo
            Unload Me
            Exit Sub
         
         ElseIf mCodigo = "ResFF" Then
            If Len(text1.Text) = 0 Then
               MsgBox "No indico el numero de rendicion", vbExclamation
               Exit Sub
            End If
            If Not IsNumeric(dcfields(1).BoundText) Then
               MsgBox "No definio la obra", vbExclamation
               Exit Sub
            End If
         End If
         
         mDesde = DTFields(0).Value
         mHasta = DTFields(1).Value
      
         If Option1.Value Then
            mResDet = "D"
         Else
            mResDet = "R"
         End If
            
         If Option3.Value Then
            mImprime = "N"
         Else
            mImprime = "S"
         End If
         
         If Option5.Value Then
            mObra = -1
            mArgL7 = "TODAS"
         Else
            If Not IsNumeric(dcfields(0).BoundText) Then
               MsgBox "Debe indicar la obra a procesar!", vbExclamation
               Exit Sub
            End If
            mObra = dcfields(0).BoundText
            mArgL7 = dcfields(0).Text
         End If
         
         If Option14.Value Then
            mGrupo = -1
         Else
            If Not IsNumeric(dcfields(2).BoundText) Then
               MsgBox "Debe indicar el grupo de obra a procesar!", vbExclamation
               Exit Sub
            End If
            mGrupo = dcfields(2).BoundText
         End If
         
         If Option16.Value Then
            mIdProveedor = -1
         Else
            If Not IsNumeric(dcfields(3).BoundText) Then
               MsgBox "Debe indicar el proveedor a procesar!", vbExclamation
               Exit Sub
            End If
            mIdProveedor = dcfields(3).BoundText
         End If
         
         If Option18.Value Then
            mIdPedido = -1
         Else
            If Not IsNumeric(dcfields(4).BoundText) Then
               MsgBox "Debe indicar el subcontrato a procesar!", vbExclamation
               Exit Sub
            End If
            mIdPedido = dcfields(4).BoundText
         End If
         
         If Option23.Value Then
            mIdArticulo = -1
            mArticulo = ""
         Else
            If Not IsNumeric(dcfields(6).BoundText) Then
               MsgBox "Debe indicar el articulo a procesar!", vbExclamation
               Exit Sub
            End If
            mIdArticulo = dcfields(6).BoundText
            mArticulo = dcfields(6).Text
         End If
         
         If mCodigo <> "InformeOTs" Then
            If Option25.Value Then
               mNumero = -1
            Else
               If Not IsNumeric(txtNumero.Text) Or Len(txtNumero.Text) = 0 Then
                  MsgBox "Debe indicar el numero a procesar!", vbExclamation
                  Exit Sub
               End If
               mNumero = txtNumero.Text
            End If
         Else
            mArgL2 = "OP"
            If Option25.Value Then mArgL2 = "OT"
         End If
         
         If mImprime = "S" And Val(txtCopias.Text) = 0 Then
            MsgBox "No indico la cantidad de copias", vbExclamation
            Exit Sub
         End If
         
         If Option7.Value Then
            mSalida = 1
         ElseIf Option8.Value Then
            mSalida = 2
         ElseIf Option9.Value Then
            mSalida = 3
         ElseIf Option10.Value Then
            mSalida = 4
         ElseIf Option11.Value Then
            mSalida = 5
         ElseIf Option12.Value Then
            mSalida = 6
         ElseIf Option13.Value Then
            mSalida = 7
         End If
         
         Me.MousePointer = vbHourglass
         
         Dim oAp As ComPronto.Aplicacion
   
         Set oAp = Aplicacion
         
         Set oEx = CreateObject("Excel.Application")
         
         With oEx
            
            .Visible = True
            
            With .Workbooks.Add(glbPathPlantillas & "\" & mPlanilla & ".xlt")
               
               Select Case mCodigo
                  
                  Case "ComTer"
                     If mResDet = "D" Then
                        oEx.Run "GenerarDetallado", glbStringConexion, mDesde, mHasta, mImprime, Val(txtCopias.Text)
                     Else
                        oEx.Run "GenerarResumido", glbStringConexion, mDesde, mHasta, mImprime, Val(txtCopias.Text)
                     End If
                  
                  Case "RemProv"
                     oEx.Run "GenerarRemitoDeProveedores", glbStringConexion, mDesde, mHasta, mImprime, Val(txtCopias.Text), mObra
                  
                  Case "ValCons"
                     oEx.Run "GenerarValesDeConsumo", glbStringConexion, mDesde, mHasta, mImprime, Val(txtCopias.Text)
                  
                  Case "RegPed"
                     'Set oRs = CopiarTodosLosRegistros(oAp.Pedidos.TraerFiltrado("_RegistroDePedidos", Array(mDesde, mHasta, mObra)))
                     With oRs
                        If .RecordCount > 0 Then
                           .MoveFirst
                           Do While Not .EOF
                              If Not IsNull(.Fields("Forma de pago").Value) Then
                                 rchObservaciones.TextRTF = .Fields("Forma de pago").Value
                                 .Fields("Forma de pago").Value = rchObservaciones.Text
                              End If
                              .MoveNext
                           Loop
                           .MoveFirst
                        End If
                     End With
                     oEx.Run "RegistroDePedidos", oRs, mImprime, Val(txtCopias.Text), mDesde, mHasta
                     oRs.Close
                     Set oRs = Nothing
                  
                  Case "MatRec"
                     mArgL2 = BuscarClaveINI("Mostrar costos en recepcion de materiales")
                     'Set oRs = CopiarTodosLosRegistros(oAp.TablasGenerales.TraerFiltrado("Recepciones", _
                                 "_MaterialesRecibidos", Array(mDesde, mHasta, mObra, mIdArticulo, mNumero)))
                     With oRs
                        If .RecordCount > 0 Then
                           .MoveFirst
                           Do While Not .EOF
                              If mArgL2 = "NO" Then
                                 .Fields("Costo").Value = 0
                                 .Fields("TotalItem").Value = 0
                              End If
                              If Not IsNull(.Fields("Observaciones").Value) Then
                                 rchObservaciones.TextRTF = .Fields("Observaciones").Value
                                 If Len(LTrim(RTrim(rchObservaciones.Text))) > 2 Then
                                    .Fields("Observaciones").Value = .Fields("Material").Value & vbCrLf & rchObservaciones.Text
                                 Else
                                    .Fields("Observaciones").Value = .Fields("Material").Value
                                 End If
                              Else
                                 .Fields("Observaciones").Value = .Fields("Material").Value
                              End If
                              .MoveNext
                           Loop
                           .MoveFirst
                        End If
                     End With
                     oEx.Run "GenerarMaterialesRecibidos", oRs, mImprime, Val(txtCopias.Text), mDesde, mHasta, mArticulo, mNumero
                     oRs.Close
                     Set oRs = Nothing
                  
                  Case "MatRecAprob"
                     mArgL2 = BuscarClaveINI("Mostrar costos en recepcion de materiales")
                     'Set oRs = CopiarTodosLosRegistros(oAp.TablasGenerales.TraerFiltrado("Recepciones", "_MaterialesRecibidosAprobados", Array(mDesde, mHasta, mObra)))
                     With oRs
                        If .RecordCount > 0 Then
                           .MoveFirst
                           Do While Not .EOF
                              If mArgL2 = "NO" Then
                                 .Fields("Costo").Value = 0
                                 .Fields("TotalItem").Value = 0
                              End If
                              If Not IsNull(.Fields("Observaciones").Value) Then
                                 rchObservaciones.TextRTF = .Fields("Observaciones").Value
                                 If Len(rchObservaciones.Text) > 2 Then
                                    .Fields("Observaciones").Value = .Fields("Material").Value & vbCrLf & rchObservaciones.Text
                                 Else
                                    .Fields("Observaciones").Value = .Fields("Material").Value
                                 End If
                              Else
                                 .Fields("Observaciones").Value = .Fields("Material").Value
                              End If
                              .MoveNext
                           Loop
                           .MoveFirst
                        End If
                     End With
                     oEx.Run "GenerarMaterialesRecibidosAprobados", oRs, mImprime, Val(txtCopias.Text), mDesde, mHasta
                     oRs.Close
                     Set oRs = Nothing
                  
                  Case "PosFin"
                     oEx.Run "GenerarPosicionFinanciera", glbStringConexion, mDesde, mImprime, Val(txtCopias.Text), glbEmpresaSegunString, glbPathPlantillas
                  
                  Case "Amortizaciones"
                     oEx.Run "GenerarAmortizaciones", glbStringConexion, mDesde, mHasta, mImprime, Val(txtCopias.Text), glbEmpresaSegunString, glbPathPlantillas

                  Case "Salidas"
                     oEx.Run "GenerarSalidas", glbStringConexion, mDesde, mHasta, mImprime, Val(txtCopias.Text), mObra, mSalida, mGrupo
                     oEx.Run "InicializarEncabezados", glbEmpresa, glbDireccion & " " & glbLocalidad, glbTelefono1, glbDatosAdicionales1
                  
                  Case "Subcontratos"
                     oEx.Run "Subcontratos", glbStringConexion, mIdProveedor, mIdPedido, mImprime, 1
                     oEx.Run "InicializarEncabezados", glbEmpresa, glbDireccion & " " & glbLocalidad, glbTelefono1, glbDatosAdicionales1
                  
                  Case "AVL"
                     mArgL1 = Val(BuscarClaveINI("IdTipo para filtrar equipos instalados"))
                     mArgL2 = BuscarClaveINI("IdAbonos")
                     mArgL3 = BuscarClaveINI("IdSeguros")
                     mArgL4 = BuscarClaveINI("IdGastos")
                     mArgL5 = BuscarClaveINI("IdVoiceAccess")
                     mArgL6 = BuscarClaveINI("IdGeolocalizador")
                     oEx.Run "GenerarAVL", glbStringConexion, _
                              "" & mDesde & "|" & mArgL1 & "|" & mArgL2 & "|" & mArgL3 & "|" & mArgL4 & "|" & mArgL5 & "|" & mArgL6, _
                              mImprime, Val(txtCopias.Text), glbEmpresaSegunString, _
                              glbPathPlantillas
                  
                  Case "CashFlow"
                     oEx.Run "GenerarCashFlow", glbStringConexion, text1.Text, Text2.Text, _
                                          glbEmpresa, mImprime, Val(txtCopias.Text)
               
                  Case "CashFlow2"
                     oEx.Run "Generar", glbStringConexion, text1.Text, Text2.Text, _
                                       glbEmpresa, mImprime, Val(txtCopias.Text)
               
                  Case "CashFlow3"
                     oEx.Run "Generar", glbStringConexion, text1.Text, Text2.Text, _
                                       glbEmpresa, mImprime, Val(txtCopias.Text)
               
                  Case "CashFlow4"
                     oEx.Run "GenerarCashFlow", glbStringConexion, text1.Text, Text2.Text, _
                                       glbEmpresa, mImprime, Val(txtCopias.Text)
               
                  Case "CashFlow5"
                     oEx.Run "Generar", glbStringConexion, text1.Text, Text2.Text, _
                                       glbEmpresa, mImprime, Val(txtCopias.Text)
               
                  Case "EstadoResultado1"
                     oEx.Run "Generar", glbStringConexion, text1.Text, Text2.Text, _
                                       glbEmpresa, mImprime, Val(txtCopias.Text)
               
                  Case "EstadoResultado2"
                     oEx.Run "Generar", glbStringConexion, text1.Text, Text2.Text, _
                                       glbEmpresa, mImprime, Val(txtCopias.Text)
               
                  Case "EstadoResultado3"
                     oEx.Run "Generar", glbStringConexion, text1.Text, Text2.Text, _
                                       glbEmpresa, mImprime, Val(txtCopias.Text)
               
                  Case "EstadoResultado4"
                     oEx.Run "GenerarEstadoResultado4", glbStringConexion, text1.Text, _
                                       Text2.Text, glbEmpresa, mImprime, Val(txtCopias.Text)
               
                  Case "EstadoResultado5"
                     oEx.Run "GenerarEstadoResultado5", glbStringConexion, text1.Text, _
                                       Text2.Text, glbEmpresa, mImprime, Val(txtCopias.Text)
               
                  Case "ResFF"
                     mObra = -1
                     If dcfields(5).Enabled Then
                        If Not IsNumeric(dcfields(5).BoundText) Then
                           MsgBox "Falta indicar la obra", vbExclamation
                           Exit Sub
                        End If
                        mObra = dcfields(5).BoundText
                     End If
                     oEx.Run "GenerarResFF", glbStringConexion, text1.Text, _
                                       dcfields(1).BoundText, glbEmpresa, mImprime, _
                                       Val(txtCopias.Text), mObra
               
                  Case "InformeOTs"
                     mAux1 = BuscarClaveINI("Agregar columnas adicionales en informe de OT-OP")
                     If IsNull(mAux1) Then mAux1 = "NO"
                     If Option20.Value Then
                        mArgL5 = "*"
                     ElseIf Option21.Value Then
                        mArgL5 = "M"
                     Else
                        mArgL5 = "P"
                     End If
                     oEx.Run "InformeOTs", glbStringConexion, mDesde, mHasta, mImprime, _
                                           Val(txtCopias.Text), Trim(txtNumero.Text), mArgL5 & "|" & mArgL2 & "|" & mAux1
                  
                  Case "MatRecTransp"
                     Set oRs = oAp.TablasGenerales.TraerFiltrado("Recepciones", "_MaterialesRecibidosDatosTransporte", _
                                    Array(mDesde, mHasta, mObra))
                     oEx.Run "GenerarMaterialesRecibidosDatosTransporte", _
                              oRs, mImprime, Val(txtCopias.Text), mDesde, mHasta, mArgL7, glbEmpresaSegunString, glbPathPlantillas
                     oRs.Close
                     Set oRs = Nothing
                  
                  Case "SalMatTransp"
                     Set oRs = oAp.TablasGenerales.TraerFiltrado("SalidasMateriales", "_DatosTransporte", _
                                    Array(mDesde, mHasta, mObra))
                     oEx.Run "GenerarSalidaMaterialesDatosTransporte", _
                              oRs, mImprime, Val(txtCopias.Text), mDesde, mHasta, mArgL7, glbEmpresaSegunString, glbPathPlantillas
                     oRs.Close
                     Set oRs = Nothing
                  
               End Select
               If mImprime = "S" Then
                  .Close False
                  oEx.Quit
               End If
            
            End With
         
         End With
         
         Set oEx = Nothing
         Set oAp = Nothing
         
         Me.MousePointer = vbDefault

      Case 1
         
         Unload Me
   
   End Select

Salida:

   Set oEx = Nothing
   Set oAp = Nothing
   
   Me.MousePointer = vbDefault
   
   Exit Sub
   
Mal:

   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error al procesar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select
   Resume Salida

End Sub

Private Sub dcfields_Change(Index As Integer)

   If IsNumeric(dcfields(Index).BoundText) Then
      Select Case Index
         Case 6
            Dim oRs As ADOR.Recordset
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", dcfields(Index).BoundText)
            If oRs.RecordCount > 0 Then
               txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
            End If
            oRs.Close
            Set oRs = Nothing
      End Select
   End If

End Sub

Private Sub Form_Load()

   Option1.Value = True
   Option3.Value = True
   Option5.Value = True
   Option14.Value = True
   Option16.Value = True
   Option18.Value = True
   Option23.Value = True
   Option25.Value = True
   DTFields(0).Value = DateSerial(Year(Date), Month(Date), 1)
   DTFields(1).Value = Date
   txtCopias.Enabled = False
   Frame3.Enabled = False
   Set dcfields(0).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasParaCombo")
   Set dcfields(2).RowSource = Aplicacion.CargarLista(dcfields(2).Tag)
   Set dcfields(3).RowSource = Aplicacion.CargarLista(dcfields(3).Tag)
   Set dcfields(4).RowSource = Aplicacion.Pedidos.TraerFiltrado("_SubcontratosParaCombo")
   Set dcfields(6).RowSource = Aplicacion.CargarLista(dcfields(6).Tag)

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   'Degradado Me
   
End Sub

Public Property Let Codigo(ByVal vNewValue As String)

   Dim oRs As ADOR.Recordset
   Dim mAux As String
   Dim mVector
   
   mCodigo = vNewValue

   Select Case mCodigo
      Case "ComTer"
         With Cmd(1)
            .TOp = Cmd(0).TOp
            .Left = Cmd(0).Left + Cmd(0).Width + 100
         End With
         Me.Height = Me.Height * 0.8
      Case "ValCons"
         Frame1.Visible = False
         With Cmd(1)
            .TOp = Cmd(0).TOp
            .Left = Cmd(0).Left + Cmd(0).Width + 100
         End With
         Me.Height = Me.Height * 0.8
      Case "RegPed"
         Frame1.Visible = False
         Frame3.Enabled = True
         With Cmd(1)
            .TOp = Cmd(0).TOp
            .Left = Cmd(0).Left + Cmd(0).Width + 100
         End With
         Me.Height = Me.Height * 0.8
      Case "MatRec"
         Frame1.Visible = False
         Frame3.Enabled = True
         With Frame9
            .TOp = Frame3.TOp + Frame3.Height + 100
            .Left = Frame3.Left
            .Visible = True
         End With
         Option23.Value = True
         With Frame10
            .TOp = Frame9.TOp + Frame9.Height + 100
            .Left = Frame3.Left
            .Visible = True
         End With
         Option25.Value = True
         With Cmd(0)
            .TOp = Frame10.TOp + Frame10.Height + 100
         End With
         With Cmd(1)
            .TOp = Cmd(0).TOp
            .Left = Cmd(0).Left + Cmd(0).Width + 100
         End With
         Me.Height = Me.Height * 1.15
      Case "MatRecAprob"
         Frame1.Visible = False
         Frame3.Enabled = True
         With Cmd(1)
            .TOp = Cmd(0).TOp
            .Left = Cmd(0).Left + Cmd(0).Width + 100
         End With
         Me.Height = Me.Height * 0.9
      Case "PosFin"
         Frame1.Visible = False
         Frame3.Visible = False
         lblLabels(0).Visible = False
         DTFields(1).Visible = False
         DTFields(0).Left = lblLabels(0).Left
         DTFields(0).Value = Date
         With lblLabels(1)
            .Width = .Width * 2.95
            .Caption = "Resumen posicion financiera al :"
         End With
         With Cmd(1)
            .TOp = Cmd(0).TOp
            .Left = Cmd(0).Left + Cmd(0).Width + 100
         End With
         Me.Height = Me.Height * 0.82
      Case "Amortizaciones"
         Frame1.Visible = False
         Frame3.Visible = False
         With lblLabels(1)
            .Width = .Width * 2.5
            .Caption = "Amortizaciones desde el :"
         End With
         With DTFields(0)
            .Left = lblLabels(1).Left + lblLabels(1).Width + 10
            .Value = DateAdd("yyyy", -1, Date)
         End With
         With lblLabels(0)
            .Left = lblLabels(1).Left
            .TOp = lblLabels(1).TOp + lblLabels(1).Height + 100
            .Caption = "Hasta el :"
         End With
         With DTFields(1)
            .Left = DTFields(0).Left
            .TOp = DTFields(0).TOp + DTFields(0).Height + 100
            .Value = Date
         End With
         With Cmd(1)
            .TOp = Cmd(0).TOp
            .Left = Cmd(0).Left + Cmd(0).Width + 100
         End With
         Me.Height = Me.Height * 0.85
      Case "Salidas"
         Frame1.Visible = False
         Frame3.Enabled = True
         With Frame4
            .TOp = .TOp + Frame5.Height + 200
            .Visible = True
         End With
         Cmd(0).TOp = Cmd(0).TOp + Frame5.Height + 200
         Cmd(1).TOp = Cmd(1).TOp + Frame5.Height + 200
         With Frame5
            .TOp = Frame3.TOp + Frame3.Height + 100
            .Left = Frame3.Left
            .Visible = True
         End With
         Me.Height = Me.Height * 1.3
         Option7.Value = True
      Case "AnuFac"
         Frame1.Visible = False
         Frame2.Visible = False
         Frame3.Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
         lblLabels(2).Visible = False
         txtCopias.Visible = False
         With lblLabels(0)
            .TOp = Frame1.TOp
            .Left = Frame1.Left
            .Width = .Width * 4
            .Caption = "Indicar factura inicial :"
            .Visible = True
         End With
         With txtLetra
            .TOp = Frame1.TOp
            .Left = lblLabels(0).Left + lblLabels(0).Width + 100
            .Visible = True
         End With
         With dcfields(1)
            .TOp = Frame2.TOp
            .Left = txtLetra.Left + txtLetra.Width + 100
            .BoundColumn = "IdPuntoVenta"
            .Visible = True
         End With
         With text1
            .TOp = Frame2.TOp
            .Left = dcfields(1).Left + dcfields(1).Width + 100
            .Visible = True
         End With
         With lblLabels(1)
            .TOp = lblLabels(0).TOp + lblLabels(0).Height + 100
            .Left = Frame1.Left
            .Width = lblLabels(0).Width
            .Caption = "Cantidad de facturas a anular :"
            .Visible = True
         End With
         With Text2
            .TOp = lblLabels(1).TOp
            .Left = lblLabels(1).Left + lblLabels(1).Width + 100
            .Enabled = True
            .Visible = True
         End With
         With Cmd(0)
            .TOp = lblLabels(1).TOp + lblLabels(1).Height + 200
            .Left = Frame1.Left
         End With
         With Cmd(1)
            .TOp = Cmd(0).TOp
            .Left = Cmd(0).Left + Cmd(0).Width + 100
         End With
         Me.Height = Me.Height / 2
   
      Case "AnuFac1"
         Frame1.Visible = False
         Frame2.Visible = False
         Frame3.Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
         lblLabels(2).Visible = False
         txtCopias.Visible = False
         With lblLabels(0)
            .TOp = Frame1.TOp
            .Left = Frame1.Left
            .Width = .Width * 4
            .Caption = "Indicar factura inicial :"
            .Visible = True
         End With
         With txtLetra
            .TOp = Frame1.TOp
            .Left = lblLabels(0).Left + lblLabels(0).Width + 100
            .Visible = True
         End With
         With dcfields(1)
            .TOp = Frame2.TOp
            .Left = txtLetra.Left + txtLetra.Width + 100
            .BoundColumn = "IdPuntoVenta"
            .Visible = True
         End With
         With text1
            .TOp = Frame2.TOp
            .Left = dcfields(1).Left + dcfields(1).Width + 100
            .Visible = True
         End With
         With lblLabels(1)
            .TOp = lblLabels(0).TOp + lblLabels(0).Height + 100
            .Left = Frame1.Left
            .Width = lblLabels(0).Width
            .Caption = "Indicar factura final :"
            .Visible = True
         End With
         With Text2
            .TOp = lblLabels(1).TOp
            .Left = lblLabels(1).Left + lblLabels(1).Width + 100
            .Enabled = True
            .Visible = True
         End With
         With Cmd(0)
            .TOp = lblLabels(1).TOp + lblLabels(1).Height + 200
            .Left = Frame1.Left
         End With
         With Cmd(1)
            .TOp = Cmd(0).TOp
            .Left = Cmd(0).Left + Cmd(0).Width + 100
         End With
         Me.Height = Me.Height / 2
   
      Case "Subcontratos"
         Frame1.Visible = False
         Frame3.Visible = False
         lblLabels(0).Visible = False
         lblLabels(1).Visible = False
         lblLabels(2).Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
         txtCopias.Visible = False
         With Frame6
            .TOp = Frame1.TOp + Frame1.Height + 100
            .Left = Frame1.Left
            .Visible = True
         End With
         With Frame7
            .TOp = Frame3.TOp
            .Left = Frame3.Left
            .Visible = True
         End With
         
      Case "GenFac"
         Frame2.Visible = False
         Frame3.Visible = False
         DTFields(1).Visible = False
         dcfields(1).Visible = False
         lblLabels(2).Visible = False
         txtCopias.Visible = False
         txtLetra.Visible = False
         text1.Visible = False
         Text2.Visible = False
         Frame1.Caption = "Facturacion a generar :"
         With Option1
            .Caption = "Abonos"
            .Value = True
         End With
         Option2.Caption = "Otros"
         mAux = BuscarClaveINI("Activar grupo para facturacion automatica")
         If Len(mAux) > 0 Then
            mVector = VBA.Split(mAux, ",")
            With Frame2
               .Caption = "Grupo a facturar :"
               .TOp = DTFields(0).TOp
               .Visible = True
            End With
            With Option3
               .Caption = mVector(0)
               .Value = True
            End With
            Option4.Caption = mVector(1)
            With lblEstado
               .TOp = Frame2.TOp + Frame2.Height + 100
               .Left = Frame2.Left
               .Width = DTFields(0).Width * 4.5
               .Height = Cmd(0).Height * 2.5
            End With
            Me.Height = Me.Height / 1.3
            Me.Width = Me.Width * 1.5
            With Cmd(0)
               .TOp = Frame3.TOp
               .Left = Frame3.Left
            End With
            With Cmd(1)
               .TOp = Cmd(0).TOp + Cmd(0).Height + 100
               .Left = Cmd(0).Left
            End With
         Else
            With lblEstado
               .TOp = DTFields(0).TOp
               .Left = DTFields(0).Left + DTFields(0).Width + 500
               .Width = DTFields(0).Width * 4.5
               .Height = Cmd(0).Height * 2.5
            End With
            Me.Height = Me.Height / 1.6
            Me.Width = Me.Width * 1.5
            With Cmd(0)
               .TOp = Frame3.TOp
               .Left = Frame3.Left
            End With
            With Cmd(1)
               .TOp = Cmd(0).TOp
               .Left = Cmd(0).Left + Cmd(0).Width + 100
            End With
         End If
         With lblLabels(0)
            .TOp = Frame1.TOp
            .Left = Frame1.Left + Frame1.Width + 200
            .Width = .Width * 3
            .Caption = "Punto de venta (Fact.A):"
            .Visible = True
         End With
         With dcfields1(0)
            .TOp = lblLabels(0).TOp
            .Left = lblLabels(0).Left + lblLabels(0).Width + 100
            .Width = lblLabels(0).Width * 1.5
            .BoundColumn = "IdPuntoVenta"
            Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, "A"))
            Set .RowSource = oRs
            If oRs.RecordCount = 1 Then .BoundText = oRs.Fields(0).Value
            Set oRs = Nothing
            .Visible = True
         End With
         With lblLabels(2)
            .TOp = lblLabels(0).TOp + lblLabels(0).Height + 100
            .Left = lblLabels(0).Left
            .Width = lblLabels(0).Width
            .Caption = "Punto de venta (Fact.B):"
            .Visible = True
         End With
         With dcfields1(1)
            .TOp = lblLabels(2).TOp
            .Left = dcfields1(0).Left
            .Width = lblLabels(2).Width * 1.5
            .BoundColumn = "IdPuntoVenta"
            Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, "B"))
            Set .RowSource = oRs
            If oRs.RecordCount = 1 Then .BoundText = oRs.Fields(0).Value
            Set oRs = Nothing
            .Visible = True
         End With
         With lblLabels(1)
            .TOp = lblLabels(2).TOp + lblLabels(2).Height + 200
            .Left = Frame1.Left
            .Width = .Width * 2
            .Caption = "Fecha facturas :"
         End With
         With Frame8
            .TOp = DTFields(0).TOp
            .Left = Me.Width / 3 * 2
            .Caption = "O.C. a procesar : "
            .Visible = True
         End With
         With Option20
            .Caption = "Todas"
            .Value = True
         End With
         Option21.Caption = "Seleccionadas"
         With DTFields(0)
            .Left = lblLabels(1).Left + lblLabels(1).Width + 100
            .TOp = lblLabels(1).TOp
            .Value = Date
         End With
   
      Case "AVL"
         Frame1.Visible = False
         Frame3.Visible = False
         DTFields(1).Visible = False
         lblLabels(0).Visible = False
         lblLabels(1).Caption = "Emision al:"
         With Cmd(0)
            .TOp = Frame3.TOp
            .Left = Frame3.Left
         End With
         With Cmd(1)
            .TOp = Cmd(0).TOp
            .Left = Cmd(0).Left + Cmd(0).Width + 100
         End With
         Me.Height = Me.Height / 1.5
         
      Case "CashFlow", "CashFlow2", "CashFlow3", "CashFlow4", "CashFlow5", _
            "EstadoResultado1", "EstadoResultado2", "EstadoResultado3", _
            "EstadoResultado4", "EstadoResultado5"
         Frame1.Visible = False
         Frame3.Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
         lblLabels(0).Visible = False
         lblLabels(1).Caption = "Mes y año :"
         With text1
            .TOp = DTFields(0).TOp
            .Left = DTFields(0).Left
            .Width = Cmd(0).Width / 2
            .Alignment = 2
            .Text = Month(Date)
            .Enabled = True
            .Visible = True
         End With
         With Text2
            .TOp = text1.TOp
            .Left = text1.Left + text1.Width + 100
            .Width = text1.Width
            .Alignment = 2
            .Text = Year(Date)
            .Enabled = True
            .Visible = True
         End With
         With Cmd(0)
            .TOp = Frame3.TOp
            .Left = Frame3.Left
         End With
         With Cmd(1)
            .TOp = Cmd(0).TOp
            .Left = Cmd(0).Left + Cmd(0).Width + 100
         End With
         Me.Height = Me.Height / 1.5
   
      Case "ResFF"
         Frame1.Visible = False
         Frame3.Visible = False
         DTFields(0).Visible = False
         DTFields(1).Visible = False
         lblLabels(1).Caption = "Cuenta FF :"
         With dcfields(1)
            .TOp = DTFields(0).TOp
            .Left = DTFields(0).Left
            .Width = DTFields(0).Width * 2
            .BoundColumn = "IdCuenta"
            Set .RowSource = Aplicacion.Cuentas.TraerFiltrado("_FondosFijos")
            .Visible = True
            If glbIdCuentaFFUsuario <> -1 Then
               .BoundText = glbIdCuentaFFUsuario
               .Enabled = False
            End If
         End With
         With lblLabels(0)
            .TOp = lblLabels(1).TOp + lblLabels(1).Height + 50
            .Left = lblLabels(1).Left
            .Width = lblLabels(1).Width
            .Caption = "Obra : "
            .Visible = True
         End With
         With Check1
            .TOp = lblLabels(0).TOp
            .Left = dcfields(1).Left
            .Visible = True
         End With
         With dcfields(5)
            .TOp = lblLabels(0).TOp
            .Left = Check1.Width + dcfields(1).Left + 10
            .Width = dcfields(1).Width - Check1.Width - 10
            .BoundColumn = "IdObra"
            Set .RowSource = Aplicacion.Obras.TraerLista
            .Enabled = False
            .Visible = True
            If glbIdObraAsignadaUsuario <> -1 Then
               .BoundText = glbIdObraAsignadaUsuario
               Check1.Value = 1
               Check1.Enabled = False
               .Enabled = False
            End If
         End With
         With Label4
            .TOp = lblLabels(0).TOp + lblLabels(0).Height + 50
            .Left = lblLabels(0).Left
            .Width = Cmd(0).Width
            .Caption = "Nro. rendicion :"
            .Visible = True
         End With
         With text1
            .TOp = Label4.TOp
            .Left = Label4.Left + Label4.Width + 100
            .Alignment = 2
            .Visible = True
         End With
         With Cmd(1)
            .TOp = Cmd(0).TOp
            .Left = Cmd(0).Left + Cmd(0).Width + 100
         End With
         Me.Height = Me.Height / 1.2
         
      Case "InformeOTs"
         Frame1.Visible = False
         Frame3.Visible = False
         With Frame10
            .TOp = lblLabels(1).TOp + lblLabels(1).Height + 200
            .Left = lblLabels(1).Left
            .Caption = "Seleccion por : "
            .Visible = True
         End With
         With Option25
            .Caption = "OT"
            .Value = True
         End With
         Option26.Caption = "OP"
         With Frame8
            .TOp = Frame10.TOp + Frame10.Height + 100
            .Left = Me.Width / 2 + 100
            .Caption = "Tipo de OT : "
            .Visible = True
         End With
         With Option20
            .Caption = "Todas"
            .Value = True
         End With
         Option21.Caption = "M"
         With Option22
            .Caption = "P"
            .Visible = True
         End With
         Cmd(0).TOp = Frame8.TOp
         With Cmd(1)
            .TOp = Cmd(0).TOp
            .Left = Cmd(0).Left + Cmd(0).Width + 100
         End With
         Me.Height = Me.Height * 0.8
         
      Case "MatRecTransp"
         Frame1.Visible = False
         Frame3.Enabled = True
         With Cmd(1)
            .TOp = Cmd(0).TOp
            .Left = Cmd(0).Left + Cmd(0).Width + 100
         End With
         Me.Height = Me.Height * 0.9
   
      Case "SalMatTransp"
         Frame1.Visible = False
         Frame3.Enabled = True
         With Cmd(1)
            .TOp = Cmd(0).TOp
            .Left = Cmd(0).Left + Cmd(0).Width + 100
         End With
         Me.Height = Me.Height * 0.9
   
   End Select

End Property

Public Property Let Planilla(ByVal vNewValue As String)

   mPlanilla = vNewValue

End Property

Public Property Let Titulo(ByVal vNewValue As String)

   mTitulo = vNewValue
   Me.Caption = mTitulo

End Property

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Option14_Click()

   If Option14.Value Then
      dcfields(2).Enabled = False
   End If

End Sub

Private Sub Option15_Click()

   If Option15.Value Then
      dcfields(2).Enabled = True
   End If

End Sub

Private Sub Option16_Click()

   If Option16.Value Then
      dcfields(3).Enabled = False
   End If

End Sub

Private Sub Option17_Click()

   If Option17.Value Then
      dcfields(3).Enabled = True
   End If

End Sub

Private Sub Option18_Click()

   If Option18.Value Then
      dcfields(4).Enabled = False
   End If

End Sub

Private Sub Option19_Click()

   If Option19.Value Then
      dcfields(4).Enabled = True
   End If

End Sub

Private Sub Option23_Click()

   If Option23.Value Then
      dcfields(6).Enabled = False
      txtCodigoArticulo.Enabled = False
   End If

End Sub

Private Sub Option24_Click()

   If Option24.Value Then
      dcfields(6).Enabled = True
      txtCodigoArticulo.Enabled = True
   End If

End Sub

Private Sub Option25_Click()

   If Option25.Value Then
      If mCodigo <> "InformeOTs" Then
         txtNumero.Enabled = False
      End If
   End If

End Sub

Private Sub Option26_Click()

   If Option26.Value Then
      If mCodigo <> "InformeOTs" Then
         txtNumero.Enabled = True
      End If
   End If

End Sub

Private Sub Option3_Click()

   If Option3.Value Then
      txtCopias.Text = ""
      txtCopias.Enabled = False
   End If

End Sub

Private Sub Option4_Click()

   If Option4.Value Then
      txtCopias.Enabled = True
      txtCopias.Text = 1
   End If

End Sub

Private Sub Option5_Click()

   If Option5.Value Then
      dcfields(0).Enabled = False
   End If

End Sub

Private Sub Option6_Click()

   If Option6.Value Then
      dcfields(0).Enabled = True
   End If

End Sub

Private Sub txtCodigoArticulo_GotFocus()

   With txtCodigoArticulo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoArticulo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoArticulo_Validate(Cancel As Boolean)

   If Len(txtCodigoArticulo.Text) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo.Text)
      If oRs.RecordCount > 0 Then
         dcfields(6).BoundText = oRs.Fields(0).Value
      Else
         MsgBox "Codigo de material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo.Text = ""
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

Private Sub txtLetra_Change()

   With dcfields(1)
      Set .RowSource = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, txtLetra.Text))
      .Text = ""
   End With

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
      If InStr(1, "A B C E a b c e", Chr(KeyAscii)) = 0 And KeyAscii <> vbKeyBack Then
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

Public Sub AnularFacturas()

   Dim i As Integer
   Dim oAp As ComPronto.Aplicacion
   Dim oFac As ComPronto.Factura
   Dim oPto As ComPronto.PuntoVenta
   
   Me.MousePointer = vbHourglass
   DoEvents
   
   Set oAp = Aplicacion
   
   For i = Val(text1.Text) To Val(text1.Text) + Val(Text2.Text)
      Set oFac = oAp.Facturas.Item(-1)
      With oFac
         With .Registro
            .Fields("NumeroFactura").Value = i
            .Fields("IdPuntoVenta").Value = dcfields(1).BoundText
            .Fields("TipoABC").Value = txtLetra.Text
            .Fields("PuntoVenta").Value = Val(dcfields(1).Text)
            .Fields("IdMoneda").Value = 1
            .Fields("ImporteTotal").Value = 0
            .Fields("ImporteIva1").Value = 0
            .Fields("ImporteIva2").Value = 0
            .Fields("RetencionIBrutos1").Value = 0
            .Fields("PorcentajeIBrutos1").Value = 0
            .Fields("RetencionIBrutos2").Value = 0
            .Fields("PorcentajeIBrutos2").Value = 0
            .Fields("ConvenioMultilateral").Value = 0
            .Fields("RetencionIBrutos3").Value = 0
            .Fields("PorcentajeIBrutos3").Value = 0
            .Fields("ImporteParteEnDolares").Value = 0
            .Fields("ImporteParteEnPesos").Value = 0
            .Fields("PorcentajeIva1").Value = 0
            .Fields("PorcentajeIva2").Value = 0
            .Fields("PorcentajeBonificacion").Value = 0
            .Fields("ImporteBonificacion").Value = 0
            .Fields("IVANoDiscriminado").Value = 0
            .Fields("FechaFactura").Value = Date
            .Fields("FechaVencimiento").Value = Date
            .Fields("CotizacionMoneda").Value = 1
            .Fields("CotizacionDolar").Value = 1
            .Fields("OtrasPercepciones1").Value = 0
            .Fields("OtrasPercepciones1Desc").Value = ""
            .Fields("OtrasPercepciones2").Value = 0
            .Fields("OtrasPercepciones2Desc").Value = ""
            .Fields("IdUsuarioIngreso").Value = glbIdUsuario
            .Fields("FechaIngreso").Value = Now
            .Fields("Anulada").Value = "SI"
            .Fields("FechaAnulacion").Value = Now
            .Fields("IdAutorizaAnulacion").Value = glbIdUsuario
         End With
         .Guardar
      End With
      Set oFac = Nothing
   Next
   
   Set oPto = oAp.PuntosVenta.Item(dcfields(1).BoundText)
   With oPto.Registro
      mvarNumero = .Fields("ProximoNumero").Value
      .Fields("ProximoNumero").Value = i
   End With
   oPto.Guardar
   Set oPto = Nothing
   
   Set oAp = Nothing

   Me.MousePointer = vbDefault
   DoEvents

End Sub

Public Sub GenerarFacturasAutomaticas(ByVal SoloAbonos As Boolean, _
                                      ByVal Grupo As Integer)

   Dim oAp As ComPronto.Aplicacion
   Dim oFac As ComPronto.Factura
   Dim oPto As ComPronto.PuntoVenta
   Dim oPrv As ComPronto.Provincia
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim i As Integer, mvarIdPuntoVenta As Integer, mIdProvinciaIIBB As Integer
   Dim mvarIBCondicion As Integer, mvarIdIBCondicion As Integer
   Dim mvarIdIBCondicion2 As Integer, mvarIdIBCondicion3 As Integer
   Dim mvarIdDetalleFactura As Long, mNumeroCertificadoPercepcionIIBB As Long
   Dim mvarNumero As Long, mNum As Long
   Dim mvarSubtotalFactura As Double, mvarIVA1 As Double, mvarCantidad As Double
   Dim mvarPrecio As Double, mvarIVANoDiscriminado As Double, mTopeIIBB As Double
   Dim mvarIBrutos As Double, mvarIBrutos2 As Double, mvarIBrutos3 As Double
   Dim mvarTotalFactura As Double, mPorcB As Double
   Dim mvarP_IVA1 As Single, mvarCotizacion As Single, mvarPorcentajeIBrutos As Single
   Dim mvarPorcentajeIBrutos2 As Single, mvarPorcentajeIBrutos3 As Single, mAlicuotaDirecta As Single
   Dim mvarProcesar As Boolean
   Dim mConceptosAbono As String, mSoloAbonos As String, mNota As String
   Dim mvarFacturacionCompletaMensual As String, mOCSeleccionadas As String
   Dim mFechaInicioVigenciaIBDirecto As Date, mFechaFinVigenciaIBDirecto As Date, mFecha1 As Date
   
   On Error GoTo Mal
   
   lblEstado.Visible = True
   If SoloAbonos Then mSoloAbonos = "SI" Else mSoloAbonos = "NO"
   
   mOCSeleccionadas = "*"
   If Frame8.Visible Then
      If Option21.Value Then
         mOCSeleccionadas = "S"
      End If
   End If
   
   mvarCotizacion = Cotizacion(DTFields(0).Value, glbIdMonedaDolar)
   If mvarCotizacion = 0 Then
      MsgBox "No hay registrada una cotizacion dolar para el dia " & DTFields(0).Value, vbExclamation
      Exit Sub
   End If
   
   Me.MousePointer = vbHourglass
   DoEvents
   
   Set oAp = Aplicacion
   
   Set oRs = oAp.Parametros.Item(1).Registro
   mvarP_IVA1 = IIf(IsNull(oRs.Fields("Iva1").Value), 0, oRs.Fields("Iva1").Value)
   oRs.Close
   
   mConceptosAbono = BuscarClaveINI("Conceptos para facturar abonos")
   If Len(mConceptosAbono) = 0 Or Grupo > 1 Then mConceptosAbono = "*"
   
   Set oRs = oAp.OrdenesCompra.TraerFiltrado("_OrdenesAFacturarAutomaticas_PorCliente", _
                        Array(DTFields(0).Value, mConceptosAbono, mSoloAbonos, _
                        Grupo, mOCSeleccionadas))
   
   If oRs.RecordCount > 0 Then
      oRs.MoveFirst
      Do While Not oRs.EOF
   
         lblEstado.Caption = "Procesando cliente : " & oRs.AbsolutePosition & " de " & _
                           oRs.RecordCount & vbCrLf & oRs.Fields("RazonSocial").Value
         DoEvents
         
         If Not IsNull(oRs.Fields("IdCodigoIva").Value) And _
               (oRs.Fields("IdCodigoIva").Value <= 2 Or _
                oRs.Fields("IdCodigoIva").Value = 9) Then
            mvarIdPuntoVenta = dcfields1(0).BoundText
         Else
            mvarIdPuntoVenta = dcfields1(1).BoundText
         End If
         Set oPto = oAp.PuntosVenta.Item(mvarIdPuntoVenta)
         mvarNumero = oPto.Registro.Fields("ProximoNumero").Value
         
         mvarIBCondicion = IIf(IsNull(oRs.Fields("IBCondicion").Value), 1, oRs.Fields("IBCondicion").Value)
         mvarIdIBCondicion = IIf(IsNull(oRs.Fields("IdIBCondicionPorDefecto").Value), 0, oRs.Fields("IdIBCondicionPorDefecto").Value)
         mvarIdIBCondicion2 = IIf(IsNull(oRs.Fields("IdIBCondicionPorDefecto2").Value), 0, oRs.Fields("IdIBCondicionPorDefecto2").Value)
         mvarIdIBCondicion3 = IIf(IsNull(oRs.Fields("IdIBCondicionPorDefecto3").Value), 0, oRs.Fields("IdIBCondicionPorDefecto3").Value)
         mAlicuotaDirecta = IIf(IsNull(oRs.Fields("PorcentajeIBDirecto").Value), 0, oRs.Fields("PorcentajeIBDirecto").Value)
         mFechaInicioVigenciaIBDirecto = IIf(IsNull(oRs.Fields("FechaInicioVigenciaIBDirecto").Value), 0, oRs.Fields("FechaInicioVigenciaIBDirecto").Value)
         mFechaFinVigenciaIBDirecto = IIf(IsNull(oRs.Fields("FechaFinVigenciaIBDirecto").Value), 0, oRs.Fields("FechaFinVigenciaIBDirecto").Value)
         
         mvarProcesar = True
      
         Set oFac = oAp.Facturas.Item(-1)
         With oFac
            
            mvarSubtotalFactura = 0
            mvarIVA1 = 0
            mvarIVANoDiscriminado = 0
            
            Set oRsDet = oAp.OrdenesCompra.TraerFiltrado("_OrdenesAFacturarAutomaticas_DetallesPorIdCliente", _
                           Array(oRs.Fields("IdCliente").Value, _
                                 oRs.Fields("IdObra").Value, _
                                 oRs.Fields("IdUnidadOperativa").Value, _
                                 DTFields(0).Value, mConceptosAbono, mSoloAbonos, _
                                 Grupo, mOCSeleccionadas))
            If oRsDet.RecordCount > 0 Then
               oRsDet.MoveFirst
               Do While Not oRsDet.EOF
                  mNota = ""
                  
                  rchObservaciones.TextRTF = IIf(IsNull(oRsDet.Fields("Observaciones").Value), "", oRsDet.Fields("Observaciones").Value)
                  mObservaciones = Trim(rchObservaciones.Text)
                  If Len(mObservaciones) > 0 Then
                     mObservaciones = mObservaciones & vbCrLf
                     mObservaciones = Replace(mObservaciones, "&Mes", NombreMes(Month(DTFields(0).Value)))
                     mObservaciones = Replace(mObservaciones, "&Año", Year(DTFields(0).Value))
                  End If
                  
                  mvarCantidad = IIf(IsNull(oRsDet.Fields("Cantidad").Value), 0, oRsDet.Fields("Cantidad").Value)
                  mvarPrecio = IIf(IsNull(oRsDet.Fields("Precio").Value), 0, oRsDet.Fields("Precio").Value)
                  mPorcB = IIf(IsNull(oRsDet.Fields("PorcentajeBonificacion").Value), 0, oRsDet.Fields("PorcentajeBonificacion").Value)
                  mvarFacturacionCompletaMensual = IIf(IsNull(oRsDet.Fields("FacturacionCompletaMensual").Value), "NO", oRsDet.Fields("FacturacionCompletaMensual").Value)
                  If Year(oRsDet.Fields("FechaComienzoFacturacion").Value) = Year(DTFields(0).Value) And _
                        Month(oRsDet.Fields("FechaComienzoFacturacion").Value) = Month(DTFields(0).Value) And _
                        SoloAbonos And mvarFacturacionCompletaMensual <> "SI" Then
                     If UltimoDiaDelMes(DTFields(0).Value) <> 0 Then
                        mvarPrecio = Round(mvarPrecio / UltimoDiaDelMes(DTFields(0).Value) * _
                                             (UltimoDiaDelMes(DTFields(0).Value) - Day(oRsDet.Fields("FechaComienzoFacturacion").Value) + 1), 2)
                        If Day(oRsDet.Fields("FechaComienzoFacturacion").Value) > 1 Then
                           mNota = "Proporcional por " & _
                                    (UltimoDiaDelMes(DTFields(0).Value) - Day(oRsDet.Fields("FechaComienzoFacturacion").Value) + 1) & " dias."
                        End If
                     End If
                  End If
                  If oPto.Registro.Fields("Letra").Value = "B" And _
                        oRs.Fields("IdCodigoIva").Value <> 8 Then
                     mvarIVANoDiscriminado = mvarIVANoDiscriminado + Round(mvarPrecio * mvarP_IVA1 / 100, 2)
                     mvarPrecio = mvarPrecio + Round(mvarPrecio * mvarP_IVA1 / 100, 2)
                  End If
                  
                  With oFac.DetFacturas.Item(-1)
                     With .Registro
                        .Fields("NumeroFactura").Value = mvarNumero
                        .Fields("TipoABC").Value = oPto.Registro.Fields("Letra").Value
                        .Fields("PuntoVenta").Value = oPto.Registro.Fields("PuntoVenta").Value
                        .Fields("IdArticulo").Value = oRsDet.Fields("IdArticulo").Value
                        .Fields("CodigoArticulo").Value = oRsDet.Fields("CodigoArticulo").Value
                        .Fields("Cantidad").Value = mvarCantidad
                        .Fields("PrecioUnitario").Value = mvarPrecio
                        .Fields("OrigenDescripcion").Value = oRsDet.Fields("OrigenDescripcion").Value
                        .Fields("TipoCancelacion").Value = oRsDet.Fields("TipoCancelacion").Value
                        .Fields("IdUnidad").Value = oRsDet.Fields("IdUnidad").Value
                        .Fields("PrecioUnitarioTotal").Value = mvarPrecio
                        .Fields("Observaciones").Value = mObservaciones
                        .Fields("Bonificacion").Value = mPorcB
                        .Fields("NotaAclaracion").Value = mNota
                     End With
                     .Modificado = True
                     mvarIdDetalleFactura = .Id
                     With .DetFacturasOrdenesCompra.Item(-1)
                        With .Registro
                           .Fields("IdDetalleFactura").Value = mvarIdDetalleFactura
                           .Fields("IdDetalleOrdenCompra").Value = oRsDet.Fields("IdDetalleOrdenCompra").Value
                        End With
                        .Modificado = True
                     End With
                     .Modificado = True
                  End With
                  mvarSubtotalFactura = mvarSubtotalFactura + (mvarCantidad * mvarPrecio * (1 - mPorcB / 100))
                  oRsDet.MoveNext
               Loop
            Else
               mvarProcesar = False
            End If
            oRsDet.Close
            
            If mvarProcesar Then
               If oPto.Registro.Fields("Letra").Value = "A" And _
                     oRs.Fields("IdCodigoIva").Value <> 9 Then
                  mvarIVA1 = Round(mvarSubtotalFactura * mvarP_IVA1 / 100, 2)
               End If
               
               mvarPorcentajeIBrutos = 0
               mvarPorcentajeIBrutos2 = 0
               mvarPorcentajeIBrutos3 = 0
               mvarIBrutos = 0
               mvarIBrutos2 = 0
               mvarIBrutos3 = 0
               If mvarIBCondicion = 2 Or mvarIBCondicion = 3 Then
                  Set oRsAux = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", mvarIdIBCondicion)
                  If oRsAux.RecordCount > 0 Then
                     mTopeIIBB = IIf(IsNull(oRsAux.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRsAux.Fields("ImporteTopeMinimoPercepcion").Value)
                     mIdProvinciaIIBB = IIf(IsNull(oRsAux.Fields("IdProvincia").Value), 0, oRsAux.Fields("IdProvincia").Value)
                     mFecha1 = IIf(IsNull(oRsAux.Fields("FechaVigencia").Value), Date, oRsAux.Fields("FechaVigencia").Value)
                     If IIf(IsNull(oRsAux.Fields("IdProvinciaReal").Value), oRsAux.Fields("IdProvincia").Value, oRsAux.Fields("IdProvinciaReal").Value) = 2 And _
                           DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And _
                           DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
                        mvarPorcentajeIBrutos = mAlicuotaDirecta
                     Else
                        If mvarSubtotalFactura > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
                           If mvarIBCondicion = 2 Then
                              mvarPorcentajeIBrutos = IIf(IsNull(oRsAux.Fields("AlicuotaPercepcionConvenio").Value), 0, oRsAux.Fields("AlicuotaPercepcionConvenio").Value)
                           Else
                              mvarPorcentajeIBrutos = IIf(IsNull(oRsAux.Fields("AlicuotaPercepcion").Value), 0, oRsAux.Fields("AlicuotaPercepcion").Value)
                           End If
                        End If
                     End If
                     mvarIBrutos = Round((mvarSubtotalFactura - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos / 100, 2)
                  End If
                  oRsAux.Close
                  If mvarIBrutos <> 0 Then
                     Set oRsAux = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaIIBB)
                     If oRsAux.RecordCount > 0 Then
                        mNumeroCertificadoPercepcionIIBB = _
                              IIf(IsNull(oRsAux.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value), 1, _
                                  oRsAux.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value)
                     End If
                     oRsAux.Close
                     If mIdProvinciaIIBB <> 0 Then
                        Set oPrv = Aplicacion.Provincias.Item(mIdProvinciaIIBB)
                        With oPrv.Registro
                           mNum = IIf(IsNull(.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value), 1, .Fields("ProximoNumeroCertificadoPercepcionIIBB").Value)
                           .Fields("ProximoNumeroCertificadoPercepcionIIBB").Value = mNum + 1
                        End With
                        oPrv.Guardar
                        Set oPrv = Nothing
                     End If
                  End If
                  If mvarIdIBCondicion2 <> 0 Then
                     Set oRsAux = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", mvarIdIBCondicion2)
                     If oRsAux.RecordCount > 0 Then
                        mTopeIIBB = IIf(IsNull(oRsAux.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRsAux.Fields("ImporteTopeMinimoPercepcion").Value)
                        mIdProvinciaIIBB = IIf(IsNull(oRsAux.Fields("IdProvincia").Value), 0, oRsAux.Fields("IdProvincia").Value)
                        If mvarSubtotalFactura > mTopeIIBB Then
                           If mvarIBCondicion = 2 Then
                              mvarPorcentajeIBrutos2 = IIf(IsNull(oRsAux.Fields("AlicuotaPercepcionConvenio").Value), 0, oRsAux.Fields("AlicuotaPercepcionConvenio").Value)
                           Else
                              mvarPorcentajeIBrutos2 = IIf(IsNull(oRsAux.Fields("AlicuotaPercepcion").Value), 0, oRsAux.Fields("AlicuotaPercepcion").Value)
                           End If
                           mvarIBrutos2 = Round(mvarSubtotalFactura * mvarPorcentajeIBrutos2 / 100, 2)
                        End If
                     End If
                     oRsAux.Close
                  End If
                  If mvarIdIBCondicion3 <> 0 Then
                     Set oRsAux = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", mvarIdIBCondicion3)
                     If oRsAux.RecordCount > 0 Then
                        mTopeIIBB = IIf(IsNull(oRsAux.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRsAux.Fields("ImporteTopeMinimoPercepcion").Value)
                        mIdProvinciaIIBB = IIf(IsNull(oRsAux.Fields("IdProvincia").Value), 0, oRsAux.Fields("IdProvincia").Value)
                        If mvarSubtotalFactura > mTopeIIBB Then
                           If mvarIBCondicion = 2 Then
                              mvarPorcentajeIBrutos3 = IIf(IsNull(oRsAux.Fields("AlicuotaPercepcionConvenio").Value), 0, oRsAux.Fields("AlicuotaPercepcionConvenio").Value)
                           Else
                              mvarPorcentajeIBrutos3 = IIf(IsNull(oRsAux.Fields("AlicuotaPercepcion").Value), 0, oRsAux.Fields("AlicuotaPercepcion").Value)
                           End If
                           mvarIBrutos3 = Round(mvarSubtotalFactura * mvarPorcentajeIBrutos3 / 100, 2)
                        End If
                     End If
                     oRsAux.Close
                  End If
                  Set oRsAux = Nothing
               End If
               
               mvarTotalFactura = mvarSubtotalFactura + mvarIVA1 + mvarIBrutos + _
                                    mvarIBrutos2 + mvarIBrutos3
               
               With .Registro
                  .Fields("NumeroFactura").Value = mvarNumero
                  .Fields("IdPuntoVenta").Value = mvarIdPuntoVenta
                  .Fields("TipoABC").Value = oPto.Registro.Fields("Letra").Value
                  .Fields("PuntoVenta").Value = oPto.Registro.Fields("PuntoVenta").Value
                  .Fields("IdCliente").Value = oRs.Fields("IdCliente").Value
                  .Fields("IdMoneda").Value = 1
                  .Fields("ImporteTotal").Value = mvarTotalFactura
                  .Fields("ImporteIva1").Value = mvarIVA1
                  .Fields("ImporteIva2").Value = 0
                  .Fields("RetencionIBrutos1").Value = mvarIBrutos
                  .Fields("PorcentajeIBrutos1").Value = mvarPorcentajeIBrutos
                  .Fields("IdIBCondicion").Value = mvarIdIBCondicion
                  .Fields("RetencionIBrutos2").Value = mvarIBrutos2
                  .Fields("PorcentajeIBrutos2").Value = mvarPorcentajeIBrutos2
                  If mvarIdIBCondicion2 <> 0 Then
                     .Fields("IdIBCondicion2").Value = mvarIdIBCondicion2
                  End If
                  .Fields("ConvenioMultilateral").Value = 0
                  .Fields("RetencionIBrutos3").Value = mvarIBrutos3
                  .Fields("PorcentajeIBrutos3").Value = mvarPorcentajeIBrutos3
                  If mvarIdIBCondicion3 <> 0 Then
                     .Fields("IdIBCondicion3").Value = mvarIdIBCondicion3
                  End If
                  .Fields("ImporteParteEnDolares").Value = 0
                  .Fields("ImporteParteEnPesos").Value = 0
                  .Fields("PorcentajeIva1").Value = mvarP_IVA1
                  .Fields("PorcentajeIva2").Value = 0
                  .Fields("PorcentajeBonificacion").Value = 0
                  .Fields("ImporteBonificacion").Value = 0
                  .Fields("IVANoDiscriminado").Value = mvarIVANoDiscriminado
                  .Fields("FechaFactura").Value = DTFields(0).Value
                  .Fields("FechaVencimiento").Value = DTFields(0).Value
                  .Fields("CotizacionMoneda").Value = 1
                  .Fields("CotizacionDolar").Value = mvarCotizacion
                  .Fields("OtrasPercepciones1").Value = 0
                  .Fields("OtrasPercepciones1Desc").Value = ""
                  .Fields("OtrasPercepciones2").Value = 0
                  .Fields("OtrasPercepciones2Desc").Value = ""
                  .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                  .Fields("FechaIngreso").Value = Now
                  .Fields("Anulada").Value = Null
                  .Fields("FechaAnulacion").Value = Null
                  .Fields("IdAutorizaAnulacion").Value = Null
                  .Fields("IdCondicionVenta").Value = oRs.Fields("IdCondicionVenta").Value
                  .Fields("NumeroCertificadoPercepcionIIBB").Value = mNumeroCertificadoPercepcionIIBB
               End With
               .Guardar
            End If
         End With
         Set oFac = Nothing
   
         If mvarProcesar Then
            With oPto
               .Registro.Fields("ProximoNumero").Value = mvarNumero + 1
               .Guardar
            End With
         End If
         Set oPto = Nothing
         
         oRs.MoveNext
      Loop
   End If
   oRs.Close

Salida:

   Set oRs = Nothing
   Set oRsDet = Nothing
   Set oAp = Nothing

   Me.MousePointer = vbDefault
   DoEvents
   
   Exit Sub
   
Mal:

   Select Case Err.Number
      Case Else
         MsgBox "Se ha producido un error al procesar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select
   Resume Salida

End Sub

Public Sub AnularFacturasExistentes()

   Dim i As Integer
   Dim oAp As ComPronto.Aplicacion
   Dim oFac As ComPronto.Factura
   Dim oRs As ADOR.Recordset
   Dim oRs1 As ADOR.Recordset
   Dim mErrores As String
   Dim mConError As Boolean
   
   Me.MousePointer = vbHourglass
   DoEvents
   
   mErrores = ""
   
   Set oAp = Aplicacion
   
   Set oRs = oAp.Facturas.TraerFiltrado("_PorNumeroDesdeHasta", _
         Array(txtLetra.Text, Val(dcfields(1).Text), Val(text1.Text), Val(Text2.Text)))
   If oRs.RecordCount > 0 Then
      oRs.MoveFirst
      Do While Not oRs.EOF
         mConError = False
         Set oRs1 = Aplicacion.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(oRs.Fields(0).Value, 1))
         If oRs1.RecordCount > 0 Then
            If oRs1.Fields("ImporteTotal").Value <> oRs1.Fields("Saldo").Value Then
               mErrores = mErrores & vbCrLf & oRs1.Fields("NumeroComprobante").Value & " del " & _
                           oRs1.Fields("Fecha").Value
               mConError = True
            End If
         End If
         oRs1.Close
         If Not mConError Then
            Set oFac = oAp.Facturas.Item(oRs.Fields(0).Value)
            With oFac
               With .Registro
                  .Fields("Anulada").Value = "SI"
                  .Fields("FechaAnulacion").Value = Now
                  .Fields("IdAutorizaAnulacion").Value = glbIdUsuario
               End With
               .Guardar
            End With
            Set oFac = Nothing
         End If
         oRs.MoveNext
      Loop
   End If
   oRs.Close
   
   If Len(mErrores) > 0 Then
      MsgBox "El proceso reporta que las siguientes facturas" & vbCrLf & _
             "no pudieron anularse por estar parcial o" & vbCrLf & _
             "totalmente canceladas en cuenta corriente :" & mErrores
   End If
   
   Set oRs = Nothing
   Set oRs1 = Nothing
   Set oAp = Nothing

   Me.MousePointer = vbDefault
   DoEvents

End Sub
