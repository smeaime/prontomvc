VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.1#0"; "Controles1013.ocx"
Begin VB.Form frmCopiaDefArt 
   Caption         =   "Copia parcial o total de un campo de materiales al resto de las mascaras"
   ClientHeight    =   6300
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7530
   Icon            =   "frmCopiaDefArt.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6300
   ScaleWidth      =   7530
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Height          =   420
      Index           =   4
      Left            =   5985
      Picture         =   "frmCopiaDefArt.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   5490
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Desmarcar todo"
      Height          =   420
      Index           =   3
      Left            =   4545
      TabIndex        =   8
      Top             =   5490
      Width           =   1335
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Marcar todo"
      Height          =   420
      Index           =   2
      Left            =   3105
      TabIndex        =   7
      Top             =   5490
      Width           =   1335
   End
   Begin VB.TextBox Text2 
      Enabled         =   0   'False
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
      Left            =   4770
      TabIndex        =   4
      Top             =   360
      Width           =   2625
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
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
      Left            =   135
      TabIndex        =   3
      Top             =   360
      Width           =   4515
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   420
      Index           =   1
      Left            =   1665
      TabIndex        =   1
      Top             =   5490
      Width           =   1335
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Comenzar copia"
      Height          =   420
      Index           =   0
      Left            =   225
      TabIndex        =   0
      Top             =   5490
      Width           =   1335
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   2
      Top             =   6015
      Width           =   7530
      _ExtentX        =   13282
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   7020
      Top             =   5400
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCopiaDefArt.frx":0A74
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCopiaDefArt.frx":0B86
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCopiaDefArt.frx":0FD8
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCopiaDefArt.frx":142A
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin Controles1013.DbListView Lista 
      Height          =   4605
      Left            =   135
      TabIndex        =   9
      Top             =   810
      Width           =   7260
      _ExtentX        =   12806
      _ExtentY        =   8123
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmCopiaDefArt.frx":187C
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Label Label1 
      Caption         =   "Campo a copiar :"
      Height          =   240
      Index           =   1
      Left            =   4815
      TabIndex        =   6
      Top             =   45
      Width           =   1680
   End
   Begin VB.Label Label1 
      Caption         =   "Grupo :"
      Height          =   240
      Index           =   0
      Left            =   180
      TabIndex        =   5
      Top             =   45
      Width           =   1680
   End
End
Attribute VB_Name = "frmCopiaDefArt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim oRsDefArt As ADOR.Recordset
Dim mvarId As Long
Dim mvarGrupo As String, mvarNombreCampo As String

Private Sub cmd_Click(Index As Integer)

   Dim i, j As Integer
   
   Select Case Index
   
      Case 0
      
         Me.MousePointer = vbHourglass
         
         Dim oAp As Aplicacion
         Dim origen As ComPronto.DefinicionArt
         Dim oRsOri As ADOR.Recordset
         Dim oRsDef As ADOR.Recordset
         Dim mvarR As Long, mvarS As Long, mvarF As Long, mvarOrden As Long
         Dim mvarCampo As String
         Dim Existe As Boolean
         Dim mClave
         
         Set oAp = Aplicacion
         
         Set oRsOri = oAp.DefinicionesArt.Item(mvarId).Registro
         
         If oRsOri.RecordCount > 0 Then
            mvarCampo = oRsOri.Fields("Campo").Value
            For i = 1 To Lista.ListItems.Count
               If Lista.ListItems(i).ListSubItems(1).Text = "*" Then
                  mClave = Split(Lista.ListItems(i).Tag, "|")
                  mvarR = CInt(mClave(0))
                  mvarS = CInt(mClave(1))
                  mvarF = CInt(mClave(2))
                  mvarOrden = 0
                  Existe = False
                  Set oRsDef = oAp.DefinicionesArt.TraerFiltrado("_Art", Array(mvarR, mvarS))
                  If oRsDef.RecordCount > 0 Then
                     oRsDef.MoveFirst
                     Do While Not oRsDef.EOF
                        If oRsDef.Fields("Orden").Value > mvarOrden Then
                           mvarOrden = oRsDef.Fields("Orden").Value
                        End If
                        If oRsDef.Fields("Campo").Value = mvarCampo Then
                           Existe = True
                           Exit Do
                        End If
                        oRsDef.MoveNext
                     Loop
                     If Not Existe Then
                        oRsDef.MoveFirst
                        Set origen = oAp.DefinicionesArt.Item(-1)
                        With origen.Registro
                           For j = 1 To .Fields.Count - 1
                              .Fields(j).Value = oRsOri.Fields(j).Value
                           Next
                           .Fields("IdRubro").Value = oRsDef.Fields("IdRubro").Value
                           .Fields("IdSubrubro").Value = oRsDef.Fields("IdSubrubro").Value
                           .Fields("IdFamilia").Value = oRsDef.Fields("IdFamilia").Value
                           .Fields("Orden").Value = mvarOrden + 10
                        End With
                        origen.Guardar
                     End If
                     oRsDef.Close
                  End If
               End If
            Next
         End If
         
         oRsOri.Close
         Set oRsOri = Nothing
         Set oRsDef = Nothing
         
         Set oAp = Nothing
   
         Me.MousePointer = vbDefault
   
         Unload Me

      Case 1
      
         Unload Me
         
      Case 2
      
         Me.MousePointer = vbHourglass
         
         For i = 1 To Lista.ListItems.Count
            Lista.ListItems(i).ListSubItems(1).Text = "*"
         Next
   
         Me.MousePointer = vbDefault
   
      Case 3
      
         Me.MousePointer = vbHourglass
         
         For i = 1 To Lista.ListItems.Count
            Lista.ListItems(i).ListSubItems(1).Text = " "
         Next
   
         Me.MousePointer = vbDefault
   
      Case 4
      
         BuscarEnLista
   
   End Select
   
End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   mvarId = vnewvalue
   
   Set oRsDefArt = Aplicacion.DefinicionesArt.TraerFiltrado("_Seleccion")
   Set Lista.DataSource = oRsDefArt
   
   Text1.Text = mvarGrupo
   Text2.Text = mvarNombreCampo
   
End Property

Public Property Let Grupo(ByVal vnewvalue As String)

   mvarGrupo = vnewvalue
   
End Property

Public Property Let NombreCampo(ByVal vnewvalue As String)

   mvarNombreCampo = vnewvalue
   
End Property

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   For Each oI In Img16.ListImages
      With Estado.Panels.Add(, , oI.Key)
         .Picture = oI.Picture
      End With
   Next

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()
    
   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   oRsDefArt.Close
   Set oRsDefArt = Nothing
   
End Sub

Private Sub Lista_Click()

   If Not Lista.SelectedItem Is Nothing Then
      If Lista.SelectedItem.ListSubItems(1).Text = "*" Then
         Lista.SelectedItem.ListSubItems(1).Text = ""
      Else
         Lista.SelectedItem.ListSubItems(1).Text = "*"
      End If
   End If

End Sub

Public Sub BuscarEnLista()

   Dim oF As frmBusqueda
   Dim col As ColumnHeader
   Dim filtro As String, filtro_add As String, filtro_like As String
   Dim oper(5) As String
   Dim i As Integer
   
   oper(0) = "="
   oper(1) = "LIKE"
   oper(2) = ">"
   oper(3) = "<"
   oper(4) = "<>"
   
   filtro = ""
   filtro_add = ""
   filtro_like = ""
   
   Set oF = New frmBusqueda
   
   For Each col In Lista.ColumnHeaders
      oF.Combo1(0).AddItem col.Text
      oF.Combo1(1).AddItem col.Text
      oF.Combo1(2).AddItem col.Text
   Next
   
   oF.Combo1(0).ListIndex = 0
   oF.Combo1(1).ListIndex = 0
   oF.Combo1(2).ListIndex = 0
   oF.Combo2(0).ListIndex = 1
   oF.Combo2(1).ListIndex = 1
   oF.Combo2(2).ListIndex = 1
   
   oF.Show vbModal, Me
   
   If IsNumeric(oF.txtControl.Text) Then
      If oF.txtControl.Text = 0 Then
         For i = 0 To 2
            If Len(Trim(oF.Combo1(i).Text)) <> 0 And Len(Trim(oF.Text1(i).Text)) <> 0 Then
               If oF.Combo2(i).ListIndex = 1 Then
                  filtro_like = "*"
               Else
                  filtro_like = ""
               End If
               filtro = filtro & filtro_add & "[" & oF.Combo1(i).Text & "] " & oper(oF.Combo2(i).ListIndex) & " '" & filtro_like & oF.Text1(i).Text & filtro_like & "'"
               filtro_add = " and "
            Else
               filtro_add = " "
            End If
         Next
         Lista.Filtrado = filtro
      End If
   End If
   
   Unload oF
   Set oF = Nothing
   
End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub
