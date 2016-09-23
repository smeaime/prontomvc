VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDetPresupuestoObras 
   Caption         =   "Item de presupuesto de obra"
   ClientHeight    =   6450
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8670
   LinkTopic       =   "Form1"
   ScaleHeight     =   6450
   ScaleWidth      =   8670
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtCodigoPresupuesto 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      Height          =   330
      Left            =   7785
      TabIndex        =   88
      Top             =   495
      Width           =   690
   End
   Begin VB.TextBox txtCantidad 
      Alignment       =   1  'Right Justify
      Height          =   330
      Left            =   990
      TabIndex        =   85
      Top             =   495
      Width           =   600
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Distribuir"
      Height          =   330
      Index           =   2
      Left            =   3105
      TabIndex        =   84
      Top             =   5850
      Width           =   1140
   End
   Begin VB.TextBox txtControl 
      Alignment       =   1  'Right Justify
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
      Height          =   330
      Left            =   7335
      Locked          =   -1  'True
      TabIndex        =   83
      Top             =   5805
      Width           =   1140
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      Height          =   330
      Left            =   4545
      TabIndex        =   81
      Top             =   495
      Width           =   1095
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   330
      Index           =   1
      Left            =   1350
      TabIndex        =   79
      Top             =   5850
      Width           =   1140
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   330
      Index           =   0
      Left            =   90
      TabIndex        =   78
      Top             =   5850
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   35
      Left            =   7335
      TabIndex        =   77
      Top             =   5400
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   34
      Left            =   7335
      TabIndex        =   75
      Top             =   4995
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   33
      Left            =   7335
      TabIndex        =   73
      Top             =   4590
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   32
      Left            =   7335
      TabIndex        =   71
      Top             =   4185
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   31
      Left            =   7335
      TabIndex        =   69
      Top             =   3780
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   30
      Left            =   7335
      TabIndex        =   67
      Top             =   3375
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   29
      Left            =   7335
      TabIndex        =   65
      Top             =   2970
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   28
      Left            =   7335
      TabIndex        =   63
      Top             =   2565
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   27
      Left            =   7335
      TabIndex        =   61
      Top             =   2160
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   26
      Left            =   7335
      TabIndex        =   59
      Top             =   1755
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   25
      Left            =   7335
      TabIndex        =   57
      Top             =   1350
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   24
      Left            =   7335
      TabIndex        =   55
      Top             =   945
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   23
      Left            =   4365
      TabIndex        =   53
      Top             =   5400
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   22
      Left            =   4365
      TabIndex        =   51
      Top             =   4995
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   21
      Left            =   4365
      TabIndex        =   49
      Top             =   4590
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   20
      Left            =   4365
      TabIndex        =   47
      Top             =   4185
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   19
      Left            =   4365
      TabIndex        =   45
      Top             =   3780
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   18
      Left            =   4365
      TabIndex        =   43
      Top             =   3375
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   17
      Left            =   4365
      TabIndex        =   41
      Top             =   2970
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   16
      Left            =   4365
      TabIndex        =   39
      Top             =   2565
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   15
      Left            =   4365
      TabIndex        =   37
      Top             =   2160
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   14
      Left            =   4365
      TabIndex        =   35
      Top             =   1755
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   13
      Left            =   4365
      TabIndex        =   33
      Top             =   1350
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   12
      Left            =   4365
      TabIndex        =   31
      Top             =   945
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   11
      Left            =   1305
      TabIndex        =   29
      Top             =   5400
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   10
      Left            =   1305
      TabIndex        =   27
      Top             =   4995
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   9
      Left            =   1305
      TabIndex        =   25
      Top             =   4590
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   8
      Left            =   1305
      TabIndex        =   23
      Top             =   4185
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   7
      Left            =   1305
      TabIndex        =   21
      Top             =   3780
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   6
      Left            =   1305
      TabIndex        =   19
      Top             =   3375
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   5
      Left            =   1305
      TabIndex        =   17
      Top             =   2970
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   4
      Left            =   1305
      TabIndex        =   15
      Top             =   2565
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   3
      Left            =   1305
      TabIndex        =   13
      Top             =   2160
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   2
      Left            =   1305
      TabIndex        =   11
      Top             =   1755
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   1
      Left            =   1305
      TabIndex        =   9
      Top             =   1350
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   330
      Index           =   0
      Left            =   1305
      TabIndex        =   7
      Top             =   945
      Visible         =   0   'False
      Width           =   1140
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   990
      TabIndex        =   0
      Tag             =   "Obras"
      Top             =   135
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdObra"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   1
      Left            =   3780
      TabIndex        =   2
      Tag             =   "ObrasDestinos"
      Top             =   135
      Width           =   1860
      _ExtentX        =   3281
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdDetalleObraDestino"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   2
      Left            =   6660
      TabIndex        =   4
      Tag             =   "PresupuestoObrasRubros"
      Top             =   135
      Width           =   1860
      _ExtentX        =   3281
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdPresupuestoObraRubro"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   3
      Left            =   1665
      TabIndex        =   87
      Tag             =   "Unidades"
      Top             =   495
      Width           =   1140
      _ExtentX        =   2011
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo presupuesto : "
      Height          =   255
      Index           =   5
      Left            =   6030
      TabIndex        =   89
      Top             =   540
      Width           =   1680
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      X1              =   45
      X2              =   8460
      Y1              =   900
      Y2              =   900
   End
   Begin VB.Label lblLabels 
      Caption         =   "Cantidad :"
      Height          =   255
      Index           =   4
      Left            =   90
      TabIndex        =   86
      Top             =   540
      Width           =   825
   End
   Begin VB.Label lblLabels 
      Caption         =   "Total control :"
      Height          =   255
      Index           =   3
      Left            =   6120
      TabIndex        =   82
      Top             =   5850
      Width           =   1140
   End
   Begin VB.Label lblLabels 
      Caption         =   "Total presupuesto : "
      Height          =   255
      Index           =   2
      Left            =   3150
      TabIndex        =   80
      Top             =   540
      Width           =   1365
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   35
      Left            =   6120
      TabIndex        =   76
      Top             =   5445
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   34
      Left            =   6120
      TabIndex        =   74
      Top             =   5040
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   33
      Left            =   6120
      TabIndex        =   72
      Top             =   4635
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   32
      Left            =   6120
      TabIndex        =   70
      Top             =   4230
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   31
      Left            =   6120
      TabIndex        =   68
      Top             =   3825
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   30
      Left            =   6120
      TabIndex        =   66
      Top             =   3420
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   29
      Left            =   6120
      TabIndex        =   64
      Top             =   3015
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   28
      Left            =   6120
      TabIndex        =   62
      Top             =   2610
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   27
      Left            =   6120
      TabIndex        =   60
      Top             =   2205
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   26
      Left            =   6120
      TabIndex        =   58
      Top             =   1800
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   25
      Left            =   6120
      TabIndex        =   56
      Top             =   1395
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   24
      Left            =   6120
      TabIndex        =   54
      Top             =   990
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   23
      Left            =   3150
      TabIndex        =   52
      Top             =   5445
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   22
      Left            =   3150
      TabIndex        =   50
      Top             =   5040
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   21
      Left            =   3150
      TabIndex        =   48
      Top             =   4635
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   20
      Left            =   3150
      TabIndex        =   46
      Top             =   4230
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   19
      Left            =   3150
      TabIndex        =   44
      Top             =   3825
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   18
      Left            =   3150
      TabIndex        =   42
      Top             =   3420
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   17
      Left            =   3150
      TabIndex        =   40
      Top             =   3015
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   16
      Left            =   3150
      TabIndex        =   38
      Top             =   2610
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   15
      Left            =   3150
      TabIndex        =   36
      Top             =   2205
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   14
      Left            =   3150
      TabIndex        =   34
      Top             =   1800
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   13
      Left            =   3150
      TabIndex        =   32
      Top             =   1395
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   12
      Left            =   3150
      TabIndex        =   30
      Top             =   990
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   11
      Left            =   90
      TabIndex        =   28
      Top             =   5445
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   10
      Left            =   90
      TabIndex        =   26
      Top             =   5040
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   9
      Left            =   90
      TabIndex        =   24
      Top             =   4635
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   8
      Left            =   90
      TabIndex        =   22
      Top             =   4230
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   7
      Left            =   90
      TabIndex        =   20
      Top             =   3825
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   6
      Left            =   90
      TabIndex        =   18
      Top             =   3420
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   5
      Left            =   90
      TabIndex        =   16
      Top             =   3015
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   4
      Left            =   90
      TabIndex        =   14
      Top             =   2610
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   3
      Left            =   90
      TabIndex        =   12
      Top             =   2205
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   2
      Left            =   90
      TabIndex        =   10
      Top             =   1800
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   1
      Left            =   90
      TabIndex        =   8
      Top             =   1395
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblPresu 
      Height          =   255
      Index           =   0
      Left            =   90
      TabIndex        =   6
      Top             =   990
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Rubro :"
      Height          =   255
      Index           =   1
      Left            =   6030
      TabIndex        =   5
      Top             =   180
      Width           =   555
   End
   Begin VB.Label lblLabels 
      Caption         =   "Etapa :"
      Height          =   255
      Index           =   0
      Left            =   3150
      TabIndex        =   3
      Top             =   180
      Width           =   555
   End
   Begin VB.Label lblLabels 
      Caption         =   "Obra :"
      Height          =   255
      Index           =   11
      Left            =   90
      TabIndex        =   1
      Top             =   180
      Width           =   825
   End
End
Attribute VB_Name = "frmDetPresupuestoObras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mvarIdObra As Long, mvarIdDetalleObraDestino As Long, mvarIdPresupuestoObraRubro As Long
Private mvarLinea As String
Private mvarFechaFin As Date
Public Aceptado As Boolean

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         Dim i As Integer, mIdUnidad As Integer
         Dim mTotal As Double, mSuma As Double
         
         If Not IsNumeric(DataCombo1(1).BoundText) Then
            MsgBox "Debe ingresar una etapa", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(DataCombo1(2).BoundText) Then
            MsgBox "Debe ingresar un rubro", vbExclamation
            Exit Sub
         End If
         
         mTotal = Round(Val(txtTotal.Text), 2)
         mSuma = 0
         For i = 0 To 35
            If lblPresu(i).Visible Then
               mSuma = mSuma + Round(Val(Text1(i).Text), 2)
            End If
         Next
         If mTotal <> 0 And mSuma <> 0 And Round(mTotal, 2) <> Round(mSuma, 2) Then
            MsgBox "La suma del proyectado no coincide con el total presupuestado", vbInformation
            Exit Sub
         End If
         
         mIdUnidad = 0
         If IsNumeric(DataCombo1(3).BoundText) Then mIdUnidad = DataCombo1(3).BoundText
         
         Aplicacion.Tarea "PresupuestoObras_Borrar", Array(Me.IdDetalleObraDestino, Me.IdPresupuestoObraRubro)
         Me.IdDetalleObraDestino = DataCombo1(1).BoundText
         Me.IdPresupuestoObraRubro = DataCombo1(2).BoundText
         Aplicacion.Tarea "PresupuestoObras_Borrar", Array(Me.IdDetalleObraDestino, Me.IdPresupuestoObraRubro)
         
         Aplicacion.Tarea "PresupuestoObras_Actualizar", _
                  Array(Me.IdDetalleObraDestino, Me.IdPresupuestoObraRubro, 0, 0, _
                        Val(txtCantidad.Text), Val(txtTotal.Text), mIdUnidad, Val(txtCodigoPresupuesto.Text))
         For i = 0 To 35
            If lblPresu(i).Visible Then
               If Val(Text1(i).Text) <> 0 Then
                  Aplicacion.Tarea "PresupuestoObras_Actualizar", _
                           Array(Me.IdDetalleObraDestino, Me.IdPresupuestoObraRubro, _
                                 Val(mId(lblPresu(i).Caption, 5, 4)), _
                                 NombreMesCortoRev(mId(lblPresu(i).Caption, 1, 3)), _
                                 0, Val(Text1(i).Text), 0, Val(txtCodigoPresupuesto.Text))
               End If
            End If
         Next
         
         Aceptado = True
      
      Case 1
      
      Case 2
      
         Distribuir
         Exit Sub
      
   End Select
   Me.Hide
   

End Sub

Private Sub Form_Load()

   Dim i As Integer, j As Integer, mIdUnidad As Integer
   Dim mFecha As Date
   Dim mCantidad As Double, mTotal As Double
   Dim mVector, mVector1, mVector2
   Dim oRs As ADOR.Recordset
   
   mCantidad = 0
   mTotal = 0
   mIdUnidad = 0
   
   Set oRs = Aplicacion.PresupuestoObras.TraerFiltrado("_PorDestinoRubro", _
               Array(Me.IdDetalleObraDestino, Me.IdPresupuestoObraRubro))
   If oRs.RecordCount > 0 Then
      mCantidad = IIf(IsNull(oRs.Fields("Cantidad").Value), 0, oRs.Fields("Cantidad").Value)
      mTotal = IIf(IsNull(oRs.Fields("Importe").Value), 0, oRs.Fields("Importe").Value)
      mIdUnidad = IIf(IsNull(oRs.Fields("IdUnidad").Value), 0, oRs.Fields("IdUnidad").Value)
      txtCodigoPresupuesto.Text = IIf(IsNull(oRs.Fields("CodigoPresupuesto").Value), 0, oRs.Fields("CodigoPresupuesto").Value)
   End If
   oRs.Close
      
   Set DataCombo1(0).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasParaCombo")
   DataCombo1(0).BoundText = Me.IdObra
   Set DataCombo1(1).RowSource = Aplicacion.Obras.TraerFiltrado("_DestinosParaComboPorIdObra", Me.IdObra)
   DataCombo1(1).BoundText = Me.IdDetalleObraDestino
   Set DataCombo1(2).RowSource = Aplicacion.TablasGenerales.TraerLista("PresupuestoObrasRubros")
   DataCombo1(2).BoundText = Me.IdPresupuestoObraRubro
   Set DataCombo1(3).RowSource = Aplicacion.Unidades.TraerLista
   DataCombo1(3).BoundText = mIdUnidad
   
   txtTotal.Text = mTotal
   txtCantidad.Text = mCantidad
   
   mVector = VBA.Split(Me.Linea, vbCrLf)
   mVector1 = VBA.Split(mVector(0), vbTab)
   If UBound(mVector) > 0 Then mVector2 = VBA.Split(mVector(1), vbTab)
   'txtTotal.Text = mVector2(5)
   j = 0
   For i = 0 To UBound(mVector1) - 1
      If mId(mVector1(i), Len(mVector1(i)), 1) = "I" Then
         mFecha = DateSerial(Val(mId(mVector1(i), 5, 4)), NombreMesCortoRev(mId(mVector1(i), 1, 3)), 1)
         If mFecha <= Me.FechaFin Then
            With lblPresu(j)
               .Caption = mVector1(i)
               .Visible = True
            End With
            With Text1(j)
               If Me.IdDetalleObraDestino > 0 And UBound(mVector) > 0 Then .Text = mVector2(i)
               .Visible = True
            End With
            j = j + 1
         End If
      End If
   Next
   
   Set oRs = Nothing

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Property Get IdObra() As Long

   IdObra = mvarIdObra

End Property

Public Property Let IdObra(ByVal vnewvalue As Long)

   mvarIdObra = vnewvalue

End Property

Public Property Get IdDetalleObraDestino() As Long

   IdDetalleObraDestino = mvarIdDetalleObraDestino

End Property

Public Property Let IdDetalleObraDestino(ByVal vnewvalue As Long)

   mvarIdDetalleObraDestino = vnewvalue

End Property

Public Property Get IdPresupuestoObraRubro() As Long

   IdPresupuestoObraRubro = mvarIdPresupuestoObraRubro

End Property

Public Property Let IdPresupuestoObraRubro(ByVal vnewvalue As Long)

   mvarIdPresupuestoObraRubro = vnewvalue

End Property

Public Property Get Linea() As String

   Linea = mvarLinea

End Property

Public Property Let Linea(ByVal vnewvalue As String)

   mvarLinea = vnewvalue

End Property

Public Property Get FechaFin() As Date

   FechaFin = mvarFechaFin

End Property

Public Property Let FechaFin(ByVal vnewvalue As Date)

   mvarFechaFin = vnewvalue

End Property

Private Sub Text1_Change(Index As Integer)

   Dim mTotal As Double
   Dim i As Integer
   
   mTotal = 0
   For i = 0 To 35
      If lblPresu(i).Visible Then
         mTotal = mTotal + Val(Text1(i).Text)
      End If
   Next
   txtControl.Text = mTotal

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

Public Sub Distribuir()

   Dim i As Integer, j As Integer, k As Integer
   Dim mTotal As Double, mSuma As Double, mItem As Double
   
   i = MsgBox("Esta seguro de redistribuir ?", vbYesNo)
   If i = vbNo Then Exit Sub
   
   mTotal = Val(txtTotal.Text)
   mSuma = 0
   
   j = 0
   k = 0
   For i = 0 To 35
      If lblPresu(i).Visible Then
         j = j + 1
         k = i
      End If
   Next

   If j > 0 Then
      For i = 0 To 35
         If lblPresu(i).Visible Then
            mItem = Round(mTotal / j, 2)
            Text1(i).Text = mItem
            mSuma = mSuma + mItem
         End If
      Next
   End If
   
   If mSuma <> mTotal And k > 0 Then
      Text1(k).Text = Val(Text1(k).Text) + Round(mTotal - mSuma, 2)
   End If

End Sub
