VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmAsignaComprador 
   ClientHeight    =   1650
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7020
   Icon            =   "frmAsignaComprador.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1650
   ScaleWidth      =   7020
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancelar"
      Height          =   360
      Left            =   3615
      TabIndex        =   2
      Tag             =   "Cancelar"
      Top             =   1170
      Width           =   1140
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "Aceptar"
      Default         =   -1  'True
      Height          =   360
      Left            =   2250
      TabIndex        =   1
      Tag             =   "Aceptar"
      Top             =   1170
      Width           =   1140
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   1755
      TabIndex        =   0
      Top             =   405
      Width           =   5100
      _ExtentX        =   8996
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   ""
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   3
      Left            =   1755
      TabIndex        =   5
      Tag             =   "DefinicionArticulos"
      Top             =   810
      Visible         =   0   'False
      Width           =   5100
      _ExtentX        =   8996
      _ExtentY        =   556
      _Version        =   393216
      MatchEntry      =   -1  'True
      ListField       =   "Titulo"
      BoundColumn     =   "Clave"
      Text            =   ""
   End
   Begin VB.Label Label2 
      Height          =   300
      Left            =   180
      TabIndex        =   6
      Top             =   810
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
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
      Left            =   180
      TabIndex        =   4
      Top             =   90
      Visible         =   0   'False
      Width           =   6630
   End
   Begin VB.Label lblLabels 
      Height          =   300
      Left            =   180
      TabIndex        =   3
      Top             =   450
      Width           =   1500
   End
End
Attribute VB_Name = "frmAsignaComprador"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Ok As Boolean
Private mvarId As Integer

Private Sub cmdCancel_Click()
   
   Ok = False
   Me.Hide

End Sub

Private Sub cmdOk_Click()
   
   If Not IsNumeric(DataCombo1(0).BoundText) Then
      MsgBox "No ha ingresado informacion", vbExclamation
      Exit Sub
   End If
   
   Ok = True
   Me.Hide

End Sub

Private Sub Form_Load()

   If Me.Id = 1 Then
      'Asignacion de comprador
      Me.Caption = "Asignar comprador"
      With DataCombo1(0)
         .BoundColumn = "IdEmpleado"
         Set .RowSource = Aplicacion.Empleados.TraerFiltrado("_PorSector", "Compras")
      End With
      lblLabels.Caption = "Comprador :"
   ElseIf Me.Id = 2 Then
      'Asignacion de rubro financiero
      Me.Caption = "Asignar rubro financiero"
      With DataCombo1(0)
         .BoundColumn = "IdRubroContable"
         Set .RowSource = Aplicacion.RubrosContables.TraerFiltrado("_ParaComboFinancierosEgresos")
      End With
      lblLabels.Caption = "Rubro :"
   ElseIf Me.Id = 3 Then
      'Asignacion de destino
      Me.Caption = "Asignar destino"
      lblLabels.Caption = "Destino :"
   ElseIf Me.Id = 4 Then
      'Asignacion de subrubro para crear mascaras
      Me.Caption = "Asignacion de subrubro para crear mascaras"
      With DataCombo1(0)
         .BoundColumn = "IdSubrubro"
         Set .RowSource = Aplicacion.Subrubros.TraerLista
      End With
      lblLabels.Caption = "Subrubro:"
      With Label2
         .Caption = "Copiar desde:"
         .Visible = True
      End With
      With DataCombo1(3)
         Set .RowSource = Aplicacion.DefinicionesArt.TraerLista
         .Visible = True
      End With
   ElseIf Me.Id = 5 Then
      'Asignacion de rubro para crear mascaras
      Me.Caption = "Asignacion de rubro para crear mascaras"
      With DataCombo1(0)
         .BoundColumn = "IdRubro"
         Set .RowSource = Aplicacion.Rubros.TraerLista
      End With
      lblLabels.Caption = "Rubro:"
      With Label2
         .Caption = "Copiar desde:"
         .Visible = True
      End With
      With DataCombo1(3)
         Set .RowSource = Aplicacion.DefinicionesArt.TraerLista
         .Visible = True
      End With
   End If

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Property Get Id() As Integer

   Id = mvarId

End Property

Public Property Let Id(ByVal vnewvalue As Integer)

   mvarId = vnewvalue

End Property
