VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form frmDetAccesos 
   Caption         =   "Definir permiso de modificacion de comprobantes"
   ClientHeight    =   2115
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5430
   Icon            =   "frmDetAccesos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2115
   ScaleWidth      =   5430
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtAccesos 
      Height          =   285
      Left            =   4410
      TabIndex        =   4
      Top             =   1260
      Visible         =   0   'False
      Width           =   420
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Activar limite de accesos"
      Height          =   240
      Left            =   180
      TabIndex        =   3
      Top             =   1305
      Visible         =   0   'False
      Width           =   2130
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   1
      Left            =   2835
      TabIndex        =   6
      Top             =   1575
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1125
      TabIndex        =   5
      Top             =   1575
      Width           =   1485
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      Height          =   285
      Index           =   1
      Left            =   135
      TabIndex        =   1
      Top             =   855
      Width           =   1230
      _ExtentX        =   2170
      _ExtentY        =   503
      _Version        =   393216
      Format          =   64552961
      CurrentDate     =   36526
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      Height          =   285
      Index           =   0
      Left            =   990
      TabIndex        =   0
      Top             =   495
      Width           =   1230
      _ExtentX        =   2170
      _ExtentY        =   503
      _Version        =   393216
      Format          =   64552961
      CurrentDate     =   36526
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      Height          =   285
      Index           =   2
      Left            =   1800
      TabIndex        =   2
      Top             =   855
      Width           =   1230
      _ExtentX        =   2170
      _ExtentY        =   503
      _Version        =   393216
      Format          =   64552961
      CurrentDate     =   36526
   End
   Begin VB.Label lblLabel 
      AutoSize        =   -1  'True
      Caption         =   "veces en el periodo indicado arriba."
      Height          =   240
      Index           =   5
      Left            =   2475
      TabIndex        =   12
      Top             =   1620
      Visible         =   0   'False
      Width           =   2520
   End
   Begin VB.Label lblLabel 
      AutoSize        =   -1  'True
      Caption         =   "permitir al usuario acceder "
      Height          =   240
      Index           =   4
      Left            =   2475
      TabIndex        =   11
      Top             =   1305
      Visible         =   0   'False
      Width           =   1890
   End
   Begin VB.Label lblLabel 
      AutoSize        =   -1  'True
      Caption         =   " y el "
      Height          =   240
      Index           =   3
      Left            =   1395
      TabIndex        =   10
      Top             =   900
      Width           =   330
   End
   Begin VB.Label lblLabel 
      AutoSize        =   -1  'True
      Caption         =   ". Solo podra realizar esta tarea entre el "
      Height          =   240
      Index           =   2
      Left            =   2295
      TabIndex        =   9
      Top             =   540
      Width           =   2760
   End
   Begin VB.Label lblLabel 
      AutoSize        =   -1  'True
      Caption         =   "posterior al "
      Height          =   195
      Index           =   1
      Left            =   135
      TabIndex        =   8
      Top             =   540
      Width           =   810
   End
   Begin VB.Label lblLabel 
      AutoSize        =   -1  'True
      Caption         =   "Permitir al usuario acceder a la opcion para editar movimientos con fecha "
      Height          =   240
      Index           =   0
      Left            =   135
      TabIndex        =   7
      Top             =   180
      Width           =   5205
   End
End
Attribute VB_Name = "frmDetAccesos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mFechaDesdeParaModificacion As Date
Private mFechaInicialHabilitacion As Date
Private mFechaFinalHabilitacion As Date
Private mCantidadAccesos As Date
Public Ok As Boolean

Private Sub Check1_Click()

   If Check1.Value = 1 Then
      txtAccesos.Enabled = True
      txtAccesos.Text = 1
   Else
      txtAccesos.Enabled = False
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   If Index = 0 Then
      If DTPicker1(1).Value > DTPicker1(2).Value Then
         MsgBox "La fecha desde no puede ser mayor a la fecha hasta", vbExclamation
         Exit Sub
      End If
      If Check1.Value = 1 And (Len(txtAccesos.Text) = 0 Or Val(txtAccesos.Text) = 0) Then
         MsgBox "No indico la cantidad de accesos", vbExclamation
         Exit Sub
      End If
      Me.FechaDesdeParaModificacion = DTPicker1(0).Value
      Me.FechaInicialHabilitacion = DTPicker1(1).Value
      Me.FechaFinalHabilitacion = DTPicker1(2).Value
      If Check1.Value = 1 Then
         Me.CantidadAccesos = Val(txtAccesos.Text)
      Else
         Me.CantidadAccesos = -1
      End If
      Ok = True
   End If
   
   Unload Me
   
End Sub

Private Sub DTPicker1_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTPicker1(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Load()

   DTPicker1(0).Value = Me.FechaDesdeParaModificacion
   DTPicker1(1).Value = Me.FechaInicialHabilitacion
   DTPicker1(2).Value = Me.FechaFinalHabilitacion
   If Me.CantidadAccesos = -1 Then
      Check1.Value = 0
      With txtAccesos
         .Text = ""
         .Enabled = False
      End With
   Else
      Check1.Value = 1
      With txtAccesos
         .Text = Me.CantidadAccesos
         .Enabled = True
      End With
   End If
   Ok = False
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Public Property Get FechaDesdeParaModificacion() As Date

   FechaDesdeParaModificacion = mFechaDesdeParaModificacion
   
End Property

Public Property Let FechaDesdeParaModificacion(ByVal vnewvalue As Date)

   mFechaDesdeParaModificacion = vnewvalue
   
End Property

Public Property Get FechaInicialHabilitacion() As Date

   FechaInicialHabilitacion = mFechaInicialHabilitacion
   
End Property

Public Property Let FechaInicialHabilitacion(ByVal vnewvalue As Date)

   mFechaInicialHabilitacion = vnewvalue
   
End Property

Public Property Get FechaFinalHabilitacion() As Date

   FechaFinalHabilitacion = mFechaFinalHabilitacion
   
End Property

Public Property Let FechaFinalHabilitacion(ByVal vnewvalue As Date)

   mFechaFinalHabilitacion = vnewvalue
   
End Property

Public Property Get CantidadAccesos() As Integer

   CantidadAccesos = mCantidadAccesos
   
End Property

Public Property Let CantidadAccesos(ByVal vnewvalue As Integer)

   mCantidadAccesos = vnewvalue

End Property

Public Sub DefinirParametros(ByVal mParametros As String)

   If Len(mParametros) = 0 Then
      Me.FechaInicialHabilitacion = Date
      Me.FechaFinalHabilitacion = Date
      Me.FechaDesdeParaModificacion = Date
      Me.CantidadAccesos = -1
   Else
      Dim mVector
      mVector = VBA.Split(mParametros, "|")
      If IsDate(mVector(0)) Then
         Me.FechaInicialHabilitacion = CDate(mVector(0))
      Else
         Me.FechaInicialHabilitacion = Date
      End If
      If IsDate(mVector(1)) Then
         Me.FechaFinalHabilitacion = CDate(mVector(1))
      Else
         Me.FechaFinalHabilitacion = Date
      End If
      If IsDate(mVector(2)) Then
         Me.FechaDesdeParaModificacion = CDate(mVector(2))
      Else
         Me.FechaDesdeParaModificacion = Date
      End If
      If Len(mVector(3)) <> 0 Then
         Me.CantidadAccesos = CInt(mVector(3))
      Else
         Me.CantidadAccesos = -1
      End If
   End If
   
End Sub

