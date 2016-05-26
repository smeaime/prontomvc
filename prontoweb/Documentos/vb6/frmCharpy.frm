VERSION 5.00
Begin VB.Form frmCharpy 
   Caption         =   "Datos de ensayo Charpy"
   ClientHeight    =   2430
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6630
   Icon            =   "frmCharpy.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2430
   ScaleWidth      =   6630
   StartUpPosition =   2  'CenterScreen
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "frmCharpy.frx":076A
      Left            =   3960
      List            =   "frmCharpy.frx":0774
      TabIndex        =   1
      Top             =   675
      Width           =   2445
   End
   Begin VB.TextBox txtTemperatura 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   3960
      TabIndex        =   2
      Top             =   1035
      Width           =   1170
   End
   Begin VB.TextBox txtEnergia 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   3960
      TabIndex        =   0
      Top             =   315
      Width           =   1170
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   2595
      TabIndex        =   4
      Top             =   1740
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   4305
      TabIndex        =   5
      Top             =   1740
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   900
      TabIndex        =   3
      Top             =   1740
      Width           =   1485
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Temperatura de ensayo :"
      Height          =   255
      Index           =   2
      Left            =   270
      TabIndex        =   8
      Top             =   1050
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Orientación de la probeta :"
      Height          =   255
      Index           =   0
      Left            =   270
      TabIndex        =   7
      Top             =   690
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Mínima energía absorvida admisible :"
      Height          =   255
      Index           =   1
      Left            =   270
      TabIndex        =   6
      Top             =   330
      Width           =   3480
   End
End
Attribute VB_Name = "frmCharpy"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim WithEvents origen As ComPronto.ArticuloInformacionAdicional
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Public Aceptado As Boolean
Private mvarIdNuevo As Long, mvarId As Long
Dim oArticulo As ComPronto.Articulo
Private mvarCampo As String

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
         
         Set origen = oArticulo.ArticulosInformacionAdicional.Item(oArticulo.ArticulosInformacionAdicional.IdCampoItem(mvarCampo, "Energia"))
         With origen.Registro
            .Fields("Campo").Value = mvarCampo
            .Fields("CampoItem").Value = "Energia"
            .Fields("ValorCampoNum").Value = txtEnergia.Text
         End With
         origen.Modificado = True
         
         Set origen = oArticulo.ArticulosInformacionAdicional.Item(oArticulo.ArticulosInformacionAdicional.IdCampoItem(mvarCampo, "Temperatura"))
         With origen.Registro
            .Fields("Campo").Value = mvarCampo
            .Fields("CampoItem").Value = "Temperatura"
            .Fields("ValorCampoNum").Value = txtTemperatura.Text
         End With
         origen.Modificado = True
         
         Set origen = oArticulo.ArticulosInformacionAdicional.Item(oArticulo.ArticulosInformacionAdicional.IdCampoItem(mvarCampo, "Orientacion"))
         With origen.Registro
            .Fields("Campo").Value = mvarCampo
            .Fields("CampoItem").Value = "Orientacion"
            .Fields("ValorCampoChar").Value = Combo1.Text
         End With
         origen.Modificado = True
         
      Case 1
         
         Dim mBorra As Integer
         mBorra = MsgBox("Esta seguro de eliminar los datos definitivamente ?", vbYesNo, "Eliminar")
         If mBorra = vbNo Then
            Exit Sub
         End If
         
         oArticulo.ArticulosInformacionAdicional.BorrarRegistrosCampo (mvarCampo)
   
   End Select
   
   Me.Hide
   
End Sub

Public Property Get Articulo() As ComPronto.Articulo

   Set Articulo = oArticulo

End Property

Public Property Set Articulo(ByVal vnewvalue As ComPronto.Articulo)

   Set oArticulo = vnewvalue

   Dim oRsInf As ADOR.Recordset
   
   Set oRsInf = oArticulo.ArticulosInformacionAdicional.RegistrosCampo(mvarCampo)
   
   If oRsInf.Fields.Count > 0 Then
      If oRsInf.RecordCount > 0 Then
         oRsInf.MoveFirst
         Do While Not oRsInf.EOF
            Select Case oRsInf.Fields("CampoItem").Value
               Case "Energia"
                  Me.txtEnergia.Text = oRsInf.Fields("ValorCampoNum").Value
               Case "Temperatura"
                  Me.txtTemperatura.Text = oRsInf.Fields("ValorCampoNum").Value
               Case "Orientacion"
                  Me.Combo1.Text = oRsInf.Fields("ValorCampoChar").Value
            End Select
            oRsInf.MoveNext
         Loop
      End If
      oRsInf.Close
   End If
   
   Set oRsInf = Nothing

End Property

Private Sub Combo1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set origen = Nothing
   Set oBind = Nothing

End Sub

Private Sub txtEnergia_GotFocus()

   With txtEnergia
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtEnergia_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtTemperatura_GotFocus()

   With txtTemperatura
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTemperatura_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Property Let Campo(ByVal vnewvalue As String)

   mvarCampo = vnewvalue

End Property
