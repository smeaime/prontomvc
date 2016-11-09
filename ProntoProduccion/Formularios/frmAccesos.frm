VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.3#0"; "Controles1013.ocx"
Begin VB.Form frmAccesos 
   Caption         =   "Accesos"
   ClientHeight    =   7425
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10965
   Icon            =   "frmAccesos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7425
   ScaleWidth      =   10965
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "Indicar BD's"
      Height          =   405
      Index           =   8
      Left            =   9135
      TabIndex        =   23
      Top             =   3780
      Width           =   1755
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Marcar acceso maximo a todos los nodos"
      Height          =   405
      Index           =   7
      Left            =   7560
      TabIndex        =   15
      Top             =   5580
      Width           =   3330
   End
   Begin VB.PictureBox Picture1 
      Height          =   420
      Left            =   7875
      ScaleHeight     =   360
      ScaleWidth      =   495
      TabIndex        =   13
      Top             =   0
      Visible         =   0   'False
      Width           =   555
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Planilla de accesos (Por sector)"
      Height          =   405
      Index           =   6
      Left            =   7560
      TabIndex        =   10
      Top             =   5130
      Width           =   3330
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Planilla de accesos (solo usuario)"
      Height          =   405
      Index           =   5
      Left            =   7560
      TabIndex        =   9
      Top             =   4680
      Width           =   3330
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Planilla de accesos (Todos)"
      Height          =   405
      Index           =   4
      Left            =   7560
      TabIndex        =   8
      Top             =   4230
      Width           =   3330
   End
   Begin VB.CommandButton cmd 
      Caption         =   "COPIAR"
      Height          =   495
      Index           =   3
      Left            =   8730
      TabIndex        =   7
      Top             =   2250
      Visible         =   0   'False
      Width           =   990
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Salir"
      Height          =   405
      Index           =   1
      Left            =   7560
      TabIndex        =   5
      Top             =   3330
      Width           =   3330
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   7560
      TabIndex        =   2
      Top             =   2880
      Width           =   3330
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Copiar &PERFIL"
      Height          =   405
      Index           =   2
      Left            =   7560
      TabIndex        =   1
      Top             =   3780
      Width           =   1530
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdEmpleado"
      Height          =   315
      Index           =   0
      Left            =   7515
      TabIndex        =   0
      Tag             =   "Empleados"
      Top             =   990
      Width           =   3300
      _ExtentX        =   5821
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdEmpleado"
      Height          =   315
      Index           =   1
      Left            =   7515
      TabIndex        =   4
      Tag             =   "Empleados"
      Top             =   1845
      Visible         =   0   'False
      Width           =   3300
      _ExtentX        =   5821
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   2
      Left            =   7515
      TabIndex        =   11
      Tag             =   "Sectores"
      Top             =   6570
      Visible         =   0   'False
      Width           =   3300
      _ExtentX        =   5821
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdSector"
      Text            =   ""
   End
   Begin MSComctlLib.ImageList img16 
      Left            =   10305
      Top             =   5985
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   11
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAccesos.frx":076A
            Key             =   "Cerrado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAccesos.frx":15BC
            Key             =   "SinDefinicion"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAccesos.frx":18D6
            Key             =   "Abierto_1"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAccesos.frx":1BF0
            Key             =   "Abierto_2"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAccesos.frx":2042
            Key             =   "Abierto_3"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAccesos.frx":2494
            Key             =   "Abierto_4"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAccesos.frx":27AE
            Key             =   "Abierto_5"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAccesos.frx":2C00
            Key             =   "Abierto_6"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAccesos.frx":2F1A
            Key             =   "Abierto_7"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAccesos.frx":3234
            Key             =   "Abierto_8"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAccesos.frx":354E
            Key             =   "Abierto_9"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.TreeView Arbol 
      Height          =   3795
      Left            =   45
      TabIndex        =   16
      Top             =   225
      Width           =   7425
      _ExtentX        =   13097
      _ExtentY        =   6694
      _Version        =   393217
      Indentation     =   18
      LabelEdit       =   1
      LineStyle       =   1
      Style           =   7
      ImageList       =   "img16"
      Appearance      =   1
      OLEDropMode     =   1
   End
   Begin MSComctlLib.TreeView ArbolMenu 
      Height          =   3120
      Left            =   45
      TabIndex        =   17
      Top             =   4230
      Width           =   4320
      _ExtentX        =   7620
      _ExtentY        =   5503
      _Version        =   393217
      Indentation     =   18
      LabelEdit       =   1
      LineStyle       =   1
      Style           =   7
      ImageList       =   "img16"
      Appearance      =   1
      OLEDropMode     =   1
   End
   Begin MSComctlLib.TreeView ArbolBotones 
      Height          =   3120
      Left            =   4410
      TabIndex        =   18
      Top             =   4230
      Width           =   3060
      _ExtentX        =   5398
      _ExtentY        =   5503
      _Version        =   393217
      Indentation     =   18
      LabelEdit       =   1
      LineStyle       =   1
      Style           =   7
      ImageList       =   "img16"
      Appearance      =   1
      OLEDropMode     =   1
   End
   Begin Controles1013.DbListView Lista 
      Height          =   1185
      Left            =   9270
      TabIndex        =   22
      Top             =   1575
      Visible         =   0   'False
      Width           =   1680
      _ExtentX        =   2963
      _ExtentY        =   2090
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmAccesos.frx":3868
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin VB.Label lblLabels 
      Caption         =   "Bases de datos :"
      Height          =   210
      Index           =   5
      Left            =   4545
      TabIndex        =   24
      Top             =   45
      Visible         =   0   'False
      Width           =   1230
   End
   Begin VB.Label lblLabels 
      Caption         =   "Opciones generales :"
      Height          =   210
      Index           =   1
      Left            =   90
      TabIndex        =   21
      Top             =   45
      Width           =   1590
   End
   Begin VB.Label lblLabels 
      Caption         =   "Menu descolgable :"
      Height          =   210
      Index           =   3
      Left            =   45
      TabIndex        =   20
      Top             =   4050
      Width           =   1500
   End
   Begin VB.Label lblLabels 
      Caption         =   "Botones principal :"
      Height          =   210
      Index           =   4
      Left            =   4455
      TabIndex        =   19
      Top             =   4050
      Width           =   1365
   End
   Begin VB.Image Image1 
      Height          =   735
      Left            =   8550
      Stretch         =   -1  'True
      Top             =   45
      Width           =   2220
   End
   Begin VB.Label lblSuperAdministrador 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "Modo SuperAdministrador"
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
      Left            =   7560
      TabIndex        =   14
      Top             =   6975
      Visible         =   0   'False
      Width           =   3225
   End
   Begin VB.Label lblSector 
      Caption         =   "Sector a emitir :"
      Height          =   300
      Left            =   7560
      TabIndex        =   12
      Top             =   6210
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.Label lblLabels 
      Caption         =   "Usuario destino :"
      Height          =   255
      Index           =   0
      Left            =   7515
      TabIndex        =   6
      Top             =   1620
      Visible         =   0   'False
      Width           =   1275
   End
   Begin VB.Label lblLabels 
      Caption         =   "Usuario :"
      Height          =   255
      Index           =   2
      Left            =   7515
      TabIndex        =   3
      Top             =   765
      Width           =   825
   End
   Begin VB.Menu MnuDet1 
      Caption         =   "Detalle 1"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Nivel 1 (alto)"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Nivel 2"
         Index           =   1
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Nivel 3"
         Index           =   2
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Nivel 4"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Nivel 5 (medio)"
         Index           =   4
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Nivel 6"
         Index           =   5
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Nivel 7"
         Index           =   6
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Nivel 8"
         Index           =   7
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Nivel 9 (bajo)"
         Index           =   8
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Definir permiso de modificacion de comprobantes"
         Index           =   9
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar permiso de modificacion de comprobantes"
         Index           =   10
      End
   End
   Begin VB.Menu MnuDet2 
      Caption         =   "Detalle 2"
      Visible         =   0   'False
      Begin VB.Menu MnuDetB 
         Caption         =   "Nivel 1 (alto)"
         Index           =   0
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Nivel 2"
         Index           =   1
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Nivel 3"
         Index           =   2
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Nivel 4"
         Index           =   3
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Nivel 5 (medio)"
         Index           =   4
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Nivel 6"
         Index           =   5
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Nivel 7"
         Index           =   6
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Nivel 8"
         Index           =   7
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Nivel 9 (bajo)"
         Index           =   8
      End
   End
End
Attribute VB_Name = "frmAccesos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Empleado
Attribute origen.VB_VarHelpID = -1
Private mvarId As Long
Private mvarSuperAdministrador As Boolean
Private oRsAcc As ADOR.Recordset
Private oArbol As Object, oForm As Object

Private Sub Arbol_DblClick()

   If Not Arbol.SelectedItem Is Nothing Then
      If mId(Arbol.SelectedItem.Image, 1, 7) = "Abierto" Then
         Arbol.SelectedItem.Image = "Cerrado"
         RegistrarAcceso Arbol.SelectedItem.Key, False, 0, ""
      Else
         Arbol.SelectedItem.Image = "Abierto_2"
         RegistrarAcceso Arbol.SelectedItem.Key, True, 5, Arbol.SelectedItem.Tag
      End If
   End If

End Sub

Private Sub Arbol_MouseUp(Button As Integer, Shift As Integer, X As Single, y As Single)

   If Button = vbRightButton And Not mvarSuperAdministrador Then
      If Not Arbol.SelectedItem Is Nothing Then
         PopupMenu MnuDet1, , , , MnuDetA(0)
      End If
   End If

End Sub

Private Sub Arbol_NodeClick(ByVal Node As MSComctlLib.Node)

   If Node.Children > 0 Then
      If Not Node.Expanded Then
         Node.Expanded = True
      Else
         Node.Expanded = False
      End If
   End If
   
End Sub

Private Sub ArbolBotones_DblClick()

   If Not ArbolBotones.SelectedItem Is Nothing Then
      If mId(ArbolBotones.SelectedItem.Image, 1, 7) = "Abierto" Then
         ArbolBotones.SelectedItem.Image = "Cerrado"
         RegistrarAcceso ArbolBotones.SelectedItem.Key, False, 0, ""
      Else
         ArbolBotones.SelectedItem.Image = "Abierto_1"
         RegistrarAcceso ArbolBotones.SelectedItem.Key, True, 1, ""
      End If
   End If

End Sub

Private Sub ArbolMenu_DblClick()

   If Not ArbolMenu.SelectedItem Is Nothing Then
      If mId(ArbolMenu.SelectedItem.Image, 1, 7) = "Abierto" Then
         ArbolMenu.SelectedItem.Image = "Cerrado"
         RegistrarAcceso ArbolMenu.SelectedItem.Key, False, 0, ""
      Else
         ArbolMenu.SelectedItem.Image = "Abierto_2"
         RegistrarAcceso ArbolMenu.SelectedItem.Key, True, 5, ""
      End If
   End If

End Sub

Private Sub ArbolMenu_MouseUp(Button As Integer, Shift As Integer, X As Single, y As Single)

   If Button = vbRightButton And Not mvarSuperAdministrador Then
      If Not ArbolMenu.SelectedItem Is Nothing Then
         PopupMenu MnuDet2, , , , MnuDetB(0)
      End If
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   Dim est As EnumAcciones
         
   Select Case Index
   
      Case 0
   
         Me.MousePointer = vbHourglass
         DoEvents
      
         If mvarSuperAdministrador Then
            
            Dim mString As String, mPath As String
            Dim MydsEncrypt As dsEncrypt
            
            Set MydsEncrypt = New dsEncrypt
            MydsEncrypt.KeyString = ("EDS")
            
            mString = ""
            If Not oRsAcc Is Nothing Then
               With oRsAcc
                  If .Fields.Count > 0 Then
                     If .RecordCount > 0 Then
                        .MoveFirst
                        Do While Not .EOF
                           If .Fields("Acceso").Value Then
                              mString = mString & .Fields("Nodo").Value & "|"
                           Else
                              Aplicacion.Tarea "EmpleadosAccesos_InhabilitarAccesosPorNodo", Array(.Fields("Nodo").Value)
                           End If
                           .MoveNext
                        Loop
                     End If
                  End If
               End With
            End If
            
            If Len(mString) > 0 Then mString = mId(mString, 1, Len(mString) - 1)
            mString = MydsEncrypt.Encrypt(mString)
            
            If Dir(glbPathPlantillas & "\..\app\*.app", vbArchive) <> "" Then
               GuardarArchivoSecuencial glbPathPlantillas & "\..\app\" & glbEmpresaSegunString & ".app", mString
            Else
               GuardarArchivoSecuencial app.Path & "\" & glbEmpresaSegunString & ".app", mString
            End If
            
            Set MydsEncrypt = Nothing
         
         Else
            
            Dim mEstado As MisEstados
            Dim mBD As String
            Dim oL As ListItem
            
            If Not Lista.Visible Then
               mEstado = origen.GuardarAccesos(oRsAcc)
            Else
               mBD = ""
               For Each oL In Lista.ListItems
                  If oL.Checked Then mBD = mBD & oL.Text & ","
               Next
               If Len(mBD) > 0 Then
                  mBD = mId(mBD, 1, Len(mBD) - 1)
                  mEstado = origen.GuardarAccesosPorBD(oRsAcc, gblBD, mBD)
               Else
                  mEstado = ErrorDeDatos
               End If
            End If
            
            Select Case mEstado
               Case ComPronto.MisEstados.Correcto
               Case ComPronto.MisEstados.ModificadoPorOtro
                  MsgBox "El Regsitro ha sido modificado"
               Case ComPronto.MisEstados.NoExiste
                  MsgBox "El registro ha sido eliminado"
               Case ComPronto.MisEstados.ErrorDeDatos
                  MsgBox "Error de ingreso de datos"
            End Select
         
         End If
         
         Me.MousePointer = vbDefault
         DoEvents
         
         MsgBox "ATENCION : " & vbCrLf & _
               "Los cambios en los permisos que acaba de registrar tendran" & vbCrLf & _
               "efecto la proxima vez que el o los usuarios involucrados" & vbCrLf & _
               "ingresen al sistema, si dichos usuarios se encuantran conectados" & vbCrLf & _
               "ahora seguiran teniendo los accesos anteriores.", vbInformation
      
         Unload Me

      Case 1
   
         Unload Me

      Case 2
   
         lblLabels(0).Visible = True
         DataCombo1(1).Visible = True
         Cmd(0).Enabled = False
         Cmd(2).Enabled = False
         Cmd(3).Visible = True
         
      Case 3
   
         If Not IsNumeric(DataCombo1(1).BoundText) Then
            MsgBox "Falta indicar el usuario al que va a copiar el perfil", vbCritical
            Exit Sub
         End If
   
         If DataCombo1(1).BoundText = mvarId Then
            MsgBox "No puede elegir el mismo usuario", vbCritical
            Exit Sub
         End If
   
         Me.MousePointer = vbHourglass
      
         mvarId = DataCombo1(1).BoundText
         
         Dim oAp As ComPronto.Aplicacion
         Dim oRsAcc1 As ADOR.Recordset
         Dim oEmp As ComPronto.Empleado
         Dim i As Integer
         Dim Existe As Boolean
   
         Set oAp = Aplicacion
         Set oEmp = oAp.Empleados.Item(mvarId)
         
         Set oRsAcc1 = oEmp.Accesos
   
         With oRsAcc
            If .Fields.Count > 0 Then
               If .RecordCount > 0 Then
                  .MoveFirst
                  Do While Not .EOF
                     Existe = False
                     If oRsAcc1.Fields.Count > 0 Then
                        If oRsAcc1.RecordCount > 0 Then
                           oRsAcc1.MoveFirst
                           Do While Not oRsAcc1.EOF
                              If .Fields("Nodo").Value = oRsAcc1.Fields("Nodo").Value Then
                                 Existe = True
                                 Exit Do
                              End If
                              oRsAcc1.MoveNext
                           Loop
                        End If
                     End If
                     If Not Existe Then
                        oRsAcc1.AddNew
                        oRsAcc1.Fields("IdEmpleado").Value = mvarId
                        oRsAcc1.Fields("Nodo").Value = .Fields("Nodo").Value
                     End If
                     oRsAcc1.Fields("Acceso").Value = .Fields("Acceso").Value
                     oRsAcc1.Fields("Nivel").Value = .Fields("Nivel").Value
                     oRsAcc1.Update
                     .MoveNext
                  Loop
               End If
            End If
         End With
   
         Select Case origen.GuardarAccesos(oRsAcc1)
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
'         oRsAcc.Close
'         oRsAcc1.Close
         
         Set oRsAcc = Nothing
         Set oRsAcc1 = Nothing
         Set oEmp = Nothing
         Set oAp = Nothing
         
         Me.MousePointer = vbDefault
      
         Unload Me

      Case 4
   
         ImprimirAccesos -1
         
      Case 5
   
         ImprimirAccesos mvarId
         
      Case 6
   
         ImprimirAccesos -2
         
      Case 7
   
         GenerarAccesos
         
      Case 8
      
         Arbol.Width = ArbolMenu.Width
         With Lista
            .TOp = Arbol.TOp
            .Left = ArbolBotones.Left
            .Height = Arbol.Height
            .Width = ArbolBotones.Width
            .CheckBoxes = True
            Set .DataSource = Aplicacion.TablasGenerales.TraerFiltrado("BD", "_BasesInstaladas")
            .Visible = True
         End With
         With lblLabels(5)
            .TOp = lblLabels(1).TOp
            .Left = lblLabels(4).Left
            .Visible = True
         End With
         Cmd(8).Enabled = False
   
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim dc As DataCombo
   
   On Error Resume Next
   
   mvarId = vNewValue
   mvarSuperAdministrador = False
   
   Set oAp = Aplicacion
   
   For Each dc In DataCombo1
      Set dc.RowSource = oAp.CargarLista(dc.Tag)
   Next
   
   DataCombo1(0).BoundText = mvarId
   
   Set oAp = Nothing

   Dim mLogo As String
   mLogo = "" & glbPathPlantillas & "\..\Imagenes\" & glbEmpresaSegunString & "_Logo.jpg"
   If Len(Trim(Dir(mLogo))) <> 0 Then
'      Me.Picture1 = LoadPicture(mLogo)
'      With Picture1
'         .Top = Arbol.Top
'         .Left = Me.Width - .Width - 10
'         .Visible = True
'      End With
      Me.Image1 = LoadPicture(mLogo)
   End If

End Property

Public Property Let ParentArbol(ByVal vNewValue As Object)

   Set oArbol = vNewValue
   
End Property

Public Property Set ParentForm(ByVal vForm As Form)

   Set oForm = vForm
   
   ArmarArboles
   
End Property

Private Sub DataCombo1_Change(Index As Integer)

   If Index = 0 Then
      If IsNumeric(DataCombo1(Index).BoundText) Then
         mvarId = DataCombo1(Index).BoundText
         DefinirOrigen
      End If
   End If

End Sub

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual
   
End Sub

Private Sub Form_Paint()

   'Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set oRsAcc = Nothing
   Set oArbol = Nothing
   Set oForm = Nothing
   Set origen = Nothing
   
End Sub

Public Sub DefinirOrigen()

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim i As Integer, j As Integer
   Dim mDetalle As String
   Dim mVector
   
   If Not origen Is Nothing Then
      oRsAcc.Close
      Set oRsAcc = Nothing
      Set origen = Nothing
   End If
   
   If mvarSuperAdministrador Then
   
      Dim mString As String, mArchivoDefinicionAccesos As String
      Dim Esta As Boolean
      Dim MydsEncrypt As dsEncrypt
      Dim mVectorAccesos
      
      Set MydsEncrypt = New dsEncrypt
      MydsEncrypt.KeyString = ("EDS")
      
      If Dir(glbPathPlantillas & "\..\app\*.app", vbArchive) <> "" Then
         mArchivoDefinicionAccesos = glbPathPlantillas & "\..\app\" & glbEmpresaSegunString & ".app"
      Else
         mArchivoDefinicionAccesos = app.Path & "\" & glbEmpresaSegunString & ".app"
      End If
      mString = LeerArchivoSecuencial(mArchivoDefinicionAccesos)
      If Len(mString) > 0 Then
         mString = mId(mString, 1, Len(mString) - 2)
      End If
      mString = MydsEncrypt.Encrypt(mString)
      mVectorAccesos = VBA.Split(mString, "|")
      
      Set MydsEncrypt = Nothing
         
      Set oRsAcc = Nothing
      Set oRsAcc = CreateObject("ADOR.Recordset")
      With oRsAcc
         .Fields.Append "IdEmpleado", adInteger, , adFldIsNullable
         .Fields.Append "Nodo", adVarChar, 50, adFldIsNullable
         .Fields.Append "Acceso", adInteger, , adFldIsNullable
         .Fields.Append "Nivel", adInteger, , adFldIsNullable
      End With
      oRsAcc.Open
         
      For i = 1 To Arbol.Nodes.Count
         Esta = False
         For j = 0 To UBound(mVectorAccesos)
            If mVectorAccesos(j) = oArbol.Nodes(i).Key Then
               Esta = True
               Exit For
            End If
         Next
         With oRsAcc
            .AddNew
            .Fields("IdEmpleado").Value = 0
            .Fields("Nodo").Value = oArbol.Nodes(i).Key
            .Fields("Nivel").Value = 1
            If Esta Then
               Arbol.Nodes(i).Image = "Abierto_1"
               .Fields("Acceso").Value = 1
            Else
               Arbol.Nodes(i).Image = "Cerrado"
               .Fields("Acceso").Value = 0
            End If
            .Update
         End With
      Next
         
      For i = 1 To ArbolMenu.Nodes.Count
         Esta = False
         For j = 0 To UBound(mVectorAccesos)
            If mVectorAccesos(j) = ArbolMenu.Nodes(i).Key Then
               Esta = True
               Exit For
            End If
         Next
         With oRsAcc
            .AddNew
            .Fields("IdEmpleado").Value = 0
            .Fields("Nodo").Value = ArbolMenu.Nodes(i).Key
            .Fields("Nivel").Value = 1
            If Esta Then
               ArbolMenu.Nodes(i).Image = "Abierto_1"
               .Fields("Acceso").Value = 1
            Else
               ArbolMenu.Nodes(i).Image = "Cerrado"
               .Fields("Acceso").Value = 0
            End If
            .Update
         End With
      Next
         
   Else
   
      Set oAp = Aplicacion
      Set origen = oAp.Empleados.Item(mvarId)
      
      Set oRsAcc = origen.Accesos
      
      For i = 1 To Arbol.Nodes.Count
         Arbol.Nodes(i).Image = "SinDefinicion"
         With oRsAcc
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  If .Fields("Nodo").Value = Arbol.Nodes(i).Key Then
                     If Len(Arbol.Nodes(i).Tag) > 0 Then
                        mVector = VBA.Split(Arbol.Nodes(i).Tag, ":")
                        Arbol.Nodes(i).Tag = mVector(0)
                        Arbol.Nodes(i).Text = mVector(0)
                     Else
                        Arbol.Nodes(i).Tag = Arbol.Nodes(i).Text
                     End If
                     If .Fields("Acceso").Value Then
                        If Not IsNull(.Fields("Nivel").Value) Then
                           Select Case .Fields("Nivel").Value
                              Case 1, 2, 3, 4, 5, 6, 7, 8, 9
                                 Arbol.Nodes(i).Image = "Abierto_" & .Fields("Nivel").Value
                                 If Not IsNull(.Fields("FechaInicialHabilitacion").Value) And _
                                       .Fields("FechaInicialHabilitacion").Value <= Date And _
                                       Not IsNull(.Fields("FechaFinalHabilitacion").Value) And _
                                       .Fields("FechaFinalHabilitacion").Value >= Date Then
                                    mDetalle = "" & .Fields("FechaInicialHabilitacion").Value & "|" & _
                                          .Fields("FechaFinalHabilitacion").Value & "|" & _
                                          .Fields("FechaDesdeParaModificacion").Value & "|"
                                    If Not IsNull(.Fields("CantidadAccesos").Value) Then
                                       mDetalle = mDetalle & .Fields("CantidadAccesos").Value
                                    End If
                                    Arbol.Nodes(i).Tag = Arbol.Nodes(i).Tag & ":" & mDetalle
                                    Arbol.Nodes(i).Text = ArmarDetalleAccesos(Arbol.Nodes(i).Tag)
                                 End If
                           End Select
                        Else
                           .Fields("Nivel").Value = 5
                           Arbol.Nodes(i).Image = "Abierto_5"
                        End If
                     Else
                        .Fields("Nivel").Value = 0
                        Arbol.Nodes(i).Image = "Cerrado"
                     End If
                     Exit Do
                  End If
                  .MoveNext
               Loop
            End If
         End With
      Next
         
      For i = 1 To ArbolMenu.Nodes.Count
         ArbolMenu.Nodes(i).Image = "SinDefinicion"
         With oRsAcc
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  If .Fields("Nodo").Value = ArbolMenu.Nodes(i).Key Then
                     If .Fields("Acceso").Value Then
                        If Not IsNull(.Fields("Nivel").Value) Then
                           Select Case .Fields("Nivel").Value
                              Case 1, 2, 3, 4, 5, 6, 7, 8, 9
                                 ArbolMenu.Nodes(i).Image = "Abierto_" & .Fields("Nivel").Value
                           End Select
                        Else
                           .Fields("Nivel").Value = 5
                           ArbolMenu.Nodes(i).Image = "Abierto_5"
                        End If
                     Else
                        .Fields("Nivel").Value = 0
                        ArbolMenu.Nodes(i).Image = "Cerrado"
                     End If
                     Exit Do
                  End If
                  .MoveNext
               Loop
            End If
         End With
      Next
   
      For i = 1 To ArbolBotones.Nodes.Count
         ArbolBotones.Nodes(i).Image = "SinDefinicion"
         With oRsAcc
            If .RecordCount > 0 Then
               .MoveFirst
               Do While Not .EOF
                  If .Fields("Nodo").Value = ArbolBotones.Nodes(i).Key Then
                     If .Fields("Acceso").Value Then
                        If Not IsNull(.Fields("Nivel").Value) Then
                           Select Case .Fields("Nivel").Value
                              Case 1, 2, 3, 4, 5, 6, 7, 8, 9
                                 ArbolBotones.Nodes(i).Image = "Abierto_" & .Fields("Nivel").Value
                           End Select
                        Else
                           .Fields("Nivel").Value = 5
                           ArbolBotones.Nodes(i).Image = "Abierto_5"
                        End If
                     Else
                        .Fields("Nivel").Value = 0
                        ArbolBotones.Nodes(i).Image = "Cerrado"
                     End If
                     Exit Do
                  End If
                  .MoveNext
               Loop
            End If
         End With
      Next
      
      Set oAp = Nothing
      
   End If

End Sub

Public Sub RegistrarAcceso(Key As String, Valor As Boolean, Nivel As Integer, Datos As String)

   If oRsAcc Is Nothing Then
      Exit Sub
   End If
   
   Dim Existe As Boolean, mGrabarDatos As Boolean
   Dim mVector1, mVector2
   
   mGrabarDatos = False
   If Len(Datos) > 0 Then
      mVector1 = VBA.Split(Datos, ":")
      If UBound(mVector1) > 0 Then
         mVector2 = VBA.Split(mVector1(1), "|")
         mGrabarDatos = True
      End If
   End If
   
   With oRsAcc
      Existe = False
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               If .Fields("Nodo").Value = Key Then
                  .Fields("Acceso").Value = Valor
                  If Nivel >= 0 Then .Fields("Nivel").Value = Nivel
                  If Not mvarSuperAdministrador Then
                     If mGrabarDatos Then
                        .Fields("FechaInicialHabilitacion").Value = CDate(mVector2(0))
                        .Fields("FechaFinalHabilitacion").Value = CDate(mVector2(1))
                        .Fields("FechaDesdeParaModificacion").Value = CDate(mVector2(2))
                        If Len(mVector2(3)) > 0 Then
                           .Fields("CantidadAccesos").Value = CInt(mVector2(3))
                        Else
                           .Fields("CantidadAccesos").Value = Null
                        End If
                     Else
                        .Fields("FechaInicialHabilitacion").Value = Null
                        .Fields("FechaFinalHabilitacion").Value = Null
                        .Fields("FechaDesdeParaModificacion").Value = Null
                        .Fields("CantidadAccesos").Value = Null
                     End If
                  End If
                  Existe = True
                  Exit Do
               End If
               .MoveNext
            Loop
         End If
      End If
   End With
   
   If Not Existe Then
      With oRsAcc
         .AddNew
         .Fields("IdEmpleado").Value = mvarId
         .Fields("Nodo").Value = Key
         .Fields("Acceso").Value = Valor
         If Nivel >= 0 Then
            .Fields("Nivel").Value = Nivel
         Else
            .Fields("Nivel").Value = 5
         End If
         If mGrabarDatos Then
            .Fields("FechaInicialHabilitacion").Value = CDate(mVector2(0))
            .Fields("FechaFinalHabilitacion").Value = CDate(mVector2(1))
            .Fields("FechaDesdeParaModificacion").Value = CDate(mVector2(2))
            If Len(mVector2(3)) > 0 Then
               .Fields("CantidadAccesos").Value = CInt(mVector2(3))
            End If
         End If
         .Update
      End With
   End If
         
End Sub

Private Sub Image1_MouseUp(Button As Integer, Shift As Integer, X As Single, y As Single)

   If Button = vbRightButton And Shift = 2 Then 'Control
      Dim oF As frmAutorizacion
      Set oF = New frmAutorizacion
      With oF
         .Empleado = 0
         .Administradores = False
         .SuperAdministrador = True
         .Show vbModal
      End With
      mvarSuperAdministrador = oF.Ok
      Unload oF
      Set oF = Nothing
      If mvarSuperAdministrador Then
         lblLabels(2).Visible = False
         DataCombo1(0).Visible = False
         Cmd(2).Visible = False
         Cmd(4).Visible = False
         Cmd(5).Visible = False
         Cmd(6).Visible = False
         With lblSuperAdministrador
            .Left = lblLabels(0).Left
            .TOp = lblLabels(0).TOp
            .Caption = "Modo SuperAdministrador"
            .Visible = True
         End With
         ArbolBotones.Visible = False
         lblLabels(4).Visible = False
         ArbolMenu.Width = Arbol.Width
         ArmarArboles
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Dim mDatos As String
   Dim mVector
   
   Select Case Index
      Case 0, 1, 2, 3, 4, 5, 6, 7, 8
         Arbol.SelectedItem.Image = "Abierto_" & Index + 1
         RegistrarAcceso Arbol.SelectedItem.Key, True, Index + 1, Arbol.SelectedItem.Tag
      Case 9
         Dim oF As frmDetAccesos
         mVector = VBA.Split(Arbol.SelectedItem.Tag, ":")
         Set frmDetAccesos = New frmDetAccesos
         With frmDetAccesos
            If UBound(mVector) > 0 Then
               .DefinirParametros mVector(1)
            Else
               .DefinirParametros ""
            End If
            .Show vbModal, Me
            mDatos = "" & .FechaInicialHabilitacion & "|" & _
                     .FechaFinalHabilitacion & "|" & _
                     .FechaDesdeParaModificacion & "|"
            If .CantidadAccesos > 0 Then
               mDatos = mDatos & .CantidadAccesos
            End If
         End With
         Set oF = Nothing
         Arbol.SelectedItem.Tag = mVector(0) & ":" & mDatos
         Arbol.SelectedItem.Text = ArmarDetalleAccesos(Arbol.SelectedItem.Tag)
         RegistrarAcceso Arbol.SelectedItem.Key, True, -1, Arbol.SelectedItem.Tag
      Case 10
         mVector = VBA.Split(Arbol.SelectedItem.Tag, ":")
         Arbol.SelectedItem.Tag = mVector(0)
         Arbol.SelectedItem.Text = ArmarDetalleAccesos(Arbol.SelectedItem.Tag)
         RegistrarAcceso Arbol.SelectedItem.Key, True, -1, Arbol.SelectedItem.Tag
   End Select

End Sub

Private Sub MnuDetB_Click(Index As Integer)

   Select Case Index
      Case 0, 1, 2, 3, 4, 5, 6, 7, 8
         ArbolMenu.SelectedItem.Image = "Abierto_" & Index + 1
         RegistrarAcceso ArbolMenu.SelectedItem.Key, True, Index + 1, ""
   End Select

End Sub

Public Sub ImprimirAccesos(ByVal Quienes As Long)

   Dim oEx As Excel.Application
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim s As String, clave As String
   Dim fl As Integer, cl As Integer, i As Integer, j As Integer
   Dim mId As Long
   Dim mNodos() As String
   Dim nodo As Object

   Set oAp = Aplicacion
   
   Select Case Quienes
      Case -1
         Set oRs = oAp.Empleados.TraerFiltrado("_TodosLosAccesos")
      Case -2
         If Not DataCombo1(2).Visible Then
            DataCombo1(2).Visible = True
            lblSector.Visible = True
            DataCombo1(2).SetFocus
            Exit Sub
         End If
         If Not IsNumeric(DataCombo1(2).BoundText) Then
            MsgBox "Debe definir un sector valido", vbExclamation
            DataCombo1(2).SetFocus
            Exit Sub
         End If
         Set oRs = oAp.Empleados.TraerFiltrado("_PorIdSector", DataCombo1(2).BoundText)
      Case Else
         Set oRs = oAp.Empleados.TraerFiltrado("_UnUsuario", Quienes)
   End Select
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      
      .Visible = True
      
      With .Workbooks.Add(glbPathPlantillas & "\Planilla.xlt")
         
         With .ActiveSheet

'            .Name = "Accesos al SISTEMA DE MATERIALES"
            
            .Cells(1, 1) = "Nodos de acceso : "
            .Cells(2, 1) = "Sector : "
            
            For i = 1 To Arbol.Nodes.Count
               ReDim Preserve mNodos(i)
               mNodos(i) = Arbol.Nodes(i).Key
               Set nodo = Arbol.Nodes(i)
               j = 1
               Do While True
                  Set nodo = nodo.Parent
                  If Not nodo Is Nothing Then
                     j = j + 1
                  Else
                     Exit Do
                  End If
               Loop
               Set nodo = Nothing
               .Cells(i + 2, 1) = "" & Space((j - 1) * 5) & Arbol.Nodes(i).Key
            Next
            
            cl = 1
            
            If oRs.RecordCount > 0 Then
               oRs.MoveFirst
               Do While Not oRs.EOF
                  cl = cl + 1
                  .Cells(1, cl) = oRs.Fields("Empleado").Value
                  .Cells(2, cl) = oRs.Fields("Sector").Value
                  mId = oRs.Fields("IdEmpleado").Value
                  Do While mId = oRs.Fields("IdEmpleado").Value
                     For i = 1 To Arbol.Nodes.Count
                        If mNodos(i) = oRs.Fields("Nodo").Value Then
                           If oRs.Fields("Acceso").Value Then
                              s = "Ok.  "
                              If Not IsNull(oRs.Fields("Nivel").Value) Then
                                 s = s & "[ " & oRs.Fields("Nivel").Value & " ]"
                              Else
                                 s = s & "[N/A]"
                              End If
                           Else
                              s = ""
                           End If
                           .Cells(i + 2, cl) = s
                           Exit For
                        End If
                     Next
                     oRs.MoveNext
                     If oRs.EOF Then Exit Do
                  Loop
               Loop
            End If
            oRs.Close
                     
            .Range("A1").Select

         End With
         
         oEx.Run "ArmarFormato"
      
      End With
      
   End With
   
   Set oEx = Nothing
   Set oRs = Nothing
   Set oAp = Nothing

   DataCombo1(2).Visible = False
   lblSector.Visible = False

End Sub

Private Sub Picture1_MouseUp(Button As Integer, Shift As Integer, X As Single, y As Single)

   If Button = vbRightButton And Shift = 2 Then 'Control
      Dim oF As frmAutorizacion
      Set oF = New frmAutorizacion
      With oF
         .Empleado = 0
         .Administradores = False
         .SuperAdministrador = True
         .Show vbModal
      End With
      mvarSuperAdministrador = oF.Ok
      Unload oF
      Set oF = Nothing
      If mvarSuperAdministrador Then
         lblLabels(2).Visible = False
         DataCombo1(0).Visible = False
         Cmd(2).Visible = False
         Cmd(4).Visible = False
         Cmd(5).Visible = False
         Cmd(6).Visible = False
         With lblSuperAdministrador
            .Left = lblLabels(0).Left
            .TOp = lblLabels(0).TOp
            .Caption = "Modo SuperAdministrador"
            .Visible = True
         End With
         ArbolBotones.Visible = False
         lblLabels(4).Visible = False
         ArbolMenu.Width = Arbol.Width
         ArmarArboles
      End If
   End If

End Sub

Private Sub ArmarArboles()

   Dim i As Integer, j As Integer
   Dim mKey(9) As String
   Dim mKey1 As String
   Dim Esta As Boolean
   Dim oCtrl As Control
   Dim oNodo As Node
   
   On Error Resume Next
   
   Dim mString As String, mArchivoDefinicionAccesos As String
   Dim MydsEncrypt As dsEncrypt
   Dim mVectorAccesos
   
   Set MydsEncrypt = New dsEncrypt
   MydsEncrypt.KeyString = ("EDS")
   
   If Dir(glbPathPlantillas & "\..\app\*.app", vbArchive) <> "" Then
      mArchivoDefinicionAccesos = glbPathPlantillas & "\..\app\" & glbEmpresaSegunString & ".app"
   Else
      mArchivoDefinicionAccesos = app.Path & "\APP\" & glbEmpresaSegunString & ".app"
   End If
   mString = LeerArchivoSecuencial(mArchivoDefinicionAccesos)
   If Len(mString) > 0 Then
      mString = mId(mString, 1, Len(mString) - 2)
   Else
      MsgBox "El archivo " & mArchivoDefinicionAccesos & " no se encuentra o está corrupto"
   End If
   
   mString = MydsEncrypt.Encrypt(mString)
   
   '///////////
   'MARIANO: Acá agrego haciendo trampa al .app los nodos del modulo de produccion
   mString = mString & "|Ingenieria|FichaTecnica|Materiales|MateriaPrima|Semielaborado|Terminado|" & _
                "Recursos|Maquinas|ManodeObra|Area|Sector|Linea|Procesos|ControlCalidad|" & _
                "OrdendeProduccion|OrdendeProduccionAgrupadas|OrdendeProduccionTodas|OrdendeProduccionPorProceso|" & _
                "PartedeProduccion|PartesAgrupadas|PartesTodas|PartedeProduccionPorProceso|" & _
                "PlanificaciondeMateriales|ProgramaciondeRecursos|MnuSub100|MnuSub101|MnuSub102|MnuSub103|MnuSub104|MnuSub105|MnuSub106|MnuSub107"
   '/////////////
   
   
   mVectorAccesos = VBA.Split(mString, "|")
   
   Set MydsEncrypt = Nothing
         
   'Arbol de objetos del formulario principal
   If Arbol.Nodes.Count > 0 Then Arbol.Nodes.Remove oArbol.Nodes(1).Key
   
   Arbol.Nodes.Add , , oArbol.Nodes(1).Key, oArbol.Nodes(1).Text

   For i = 2 To oArbol.Nodes.Count
      If mvarSuperAdministrador Then
         Esta = True
      Else
         Esta = False
         For j = 0 To UBound(mVectorAccesos)
            If mVectorAccesos(j) = oArbol.Nodes(i).Key Then
               Esta = True
               Exit For
            End If
         Next
      End If
      If Esta Then
         Arbol.Nodes.Add oArbol.Nodes(i).Parent.Key, tvwChild, oArbol.Nodes(i).Key, oArbol.Nodes(i).Text
      End If
   Next

   'Arbol de menus descolgables
   mKey(0) = "Menus"
   If ArbolMenu.Nodes.Count > 0 Then ArbolMenu.Nodes.Remove mKey(0)
   
   ArbolMenu.Nodes.Add , , mKey(0), "Menus descolgables"
   For Each oCtrl In oForm.Controls
      If TypeOf oCtrl Is Menu Then
         If oCtrl.Tag <> "" Then
            If mvarSuperAdministrador Then
               Esta = True
            Else
               Esta = False
               For j = 0 To UBound(mVectorAccesos)
                  If mVectorAccesos(j) = oCtrl.Name & oCtrl.Index Then
                     Esta = True
                     Exit For
                  End If
               Next
            End If
            If Esta Then
               ArbolMenu.Nodes.Add mKey(oCtrl.Tag - 1), tvwChild, oCtrl.Name & oCtrl.Index, Replace(oCtrl.Caption, "&", "")
               mKey(oCtrl.Tag) = oCtrl.Name & oCtrl.Index
            End If
         End If
      End If
   Next

   mKey(0) = "Botones"
   ArbolBotones.Nodes.Add , , mKey(0), "Botones principal"
   For i = 1 To oForm.Toolbar1.Buttons.Count
      mKey1 = oForm.Toolbar1.Buttons.Item(i).Key
      If Len(mKey1) > 0 Then ArbolBotones.Nodes.Add mKey(0), tvwChild, "btn_" & mKey1, mKey1
   Next

   DefinirOrigen

End Sub

Public Function ArmarDetalleAccesos(ByVal Tag As String) As String

   If Len(Tag) = 0 Then
      ArmarDetalleAccesos = ""
   Else
      Dim mDetalle As String
      Dim mVector1, mVector2
      mVector1 = VBA.Split(Tag, ":")
      mDetalle = mVector1(0)
      If UBound(mVector1) > 0 Then
         mVector2 = VBA.Split(mVector1(1), "|")
         mDetalle = mDetalle & " - Del " & mVector2(0) & " al " & mVector2(1) & _
               " puede modificar informacion desde el " & mVector2(2)
         If Len(mVector2(3)) > 0 Then
            mDetalle = mDetalle & " (" & mVector2(3) & " accesos)"
         End If
      End If
      ArmarDetalleAccesos = mDetalle
   End If

End Function

Public Sub GenerarAccesos()

   Dim mNode As Node
   
   For Each mNode In Arbol.Nodes
      mNode.Image = "Abierto_1"
      RegistrarAcceso mNode.Key, True, 1, mNode.Tag
   Next

   For Each mNode In ArbolMenu.Nodes
      mNode.Image = "Abierto_1"
      RegistrarAcceso mNode.Key, True, 1, ""
   Next

   For Each mNode In ArbolBotones.Nodes
      mNode.Image = "Abierto_1"
      RegistrarAcceso mNode.Key, True, 1, ""
   Next

End Sub

