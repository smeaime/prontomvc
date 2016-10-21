VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form frmConexionBalanza 
   Caption         =   "Lectura"
   ClientHeight    =   1695
   ClientLeft      =   13200
   ClientTop       =   11190
   ClientWidth     =   3135
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1695
   ScaleWidth      =   3135
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtLectura 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   360
      TabIndex        =   1
      Top             =   240
      Width           =   2415
   End
   Begin VB.CommandButton cmdCommand1 
      Caption         =   "Salir"
      Height          =   495
      Left            =   360
      TabIndex        =   0
      Top             =   1080
      Width           =   2415
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   120
      Top             =   240
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
      BaudRate        =   2400
      ParitySetting   =   2
      DataBits        =   7
      StopBits        =   2
   End
   Begin VB.CommandButton cmdEmpezar 
      Caption         =   "Conectar"
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Top             =   840
      Visible         =   0   'False
      Width           =   855
   End
End
Attribute VB_Name = "frmConexionBalanza"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
   
Private FlagPoolear As Boolean
Private mDecimales As Integer

Private Sub cmdCommand1_Click()
    
    FlagPoolear = False
    If MSComm1.PortOpen Then MSComm1.PortOpen = False
    Me.Hide

End Sub

Function Poolear()

   On Error Resume Next
    
    Dim sInput As String
    Dim buffer As String
    Dim pos As Long
    Dim pos2 As Long
    
    Dim Paridad
    Dim Databits
    Dim Stopbits
    Dim Puerto
    Dim Baudios
    Dim txtMascara
    Dim txtDelimitador
    
    cmdEmpezar.Enabled = False
    FlagPoolear = True
    
    Paridad = TraerValorParametro2("BalanzaCommParidad")
    Databits = TraerValorParametro2("BalanzaCommDatabits")
    Stopbits = TraerValorParametro2("BalanzaCommStopbits")
    Puerto = TraerValorParametro2("BalanzaCommNumero")
    Baudios = TraerValorParametro2("BalanzaCommBaudios")
    txtMascara = TraerValorParametro2("BalanzaCommMascara")
    txtDelimitador = TraerValorParametro2("BalanzaCommDelimitador")
    
    'MSComm1.Settings = "9600,n,8,1"  'baudios, paridad, databits, stopbits
    'La balanza Moreti si está conectada a una etiquetadora, está en modo continuo a 2400,e,7,2.
    
    MSComm1.Settings = Baudios & "," & Paridad & "," & Databits & "," & Stopbits
    MSComm1.CommPort = Val(Puerto) 'puerto COMM
    MSComm1.PortOpen = True
    
    While (FlagPoolear)
        DoEvents
        If FlagPoolear Then sInput = MSComm1.Input
        
        '//////////////////////////
        '//////////////////////////
        ''PseudoSimuleitor
        'If FlagPoolear Then
        '    sInput = "Ñ)2 " & Format(Rnd * 1000, "000000") & "012345" & vbCrLf
        '    sInput = sInput & Chr(Rnd * 250) 'generar basura
        '    sInput = sInput & sInput
        'End If
        '//////////////////////////
        '//////////////////////////
        
        buffer = buffer & sInput
        pos2 = InStrRev(buffer, vbLf) 'ultima aparicion del delimitador
        pos = InStrRev(buffer, vbLf, pos2 - 1) 'penultima aparicion del delimitador
        'Debug.Print buffer, Len(buffer)
        
        If (pos > 0) Then
            'txtLectura = Left$(buffer, pos)
            txtLectura.Text = CDbl(Mid$(buffer, pos + 6, 6)) / 100
            If mDecimales > 0 Then txtLectura.Text = Val(txtLectura.Text) / (10 ^ mDecimales)
            buffer = Mid$(buffer, pos2 + 1)
            'mids(5,6) 'Peso
            'mids(11,6) 'Tara
        Else
        End If
    Wend
    
    'NO uses timers. Pooleá

End Function

Private Sub Form_Activate()
    
    If Not FlagPoolear Then Poolear

End Sub

Private Sub Form_Load()

   Dim Arch As String, s As String
   Dim nArch As Long
   Dim i As Integer
   Dim Filas, Columnas
   
   mDecimales = 2
   
   nArch = FreeFile
   Arch = App.Path & "\Balanza.ini"
   If Len(Trim(Dir(Arch))) = 0 Then Exit Sub
   Open Arch For Binary As nArch
   s = String$(LOF(nArch), 0)
   Get nArch, 1, s
   Close nArch
   
   If Len(s) > 0 Then
      Filas = VBA.Split(s, vbCrLf)
      For i = 0 To UBound(Filas)
         Columnas = VBA.Split(Filas(i), "=")
         If UBound(Columnas) = 1 Then
            If UCase(Columnas(0)) = "DECIMALES" Then mDecimales = Val(Columnas(1))
         End If
      Next
   End If
   
   Me.Caption = "Lectura (" & mDecimales & ")"

End Sub

Private Sub Form_Unload(Cancel As Integer)
    
    FlagPoolear = False
    If MSComm1.PortOpen Then MSComm1.PortOpen = False

End Sub

