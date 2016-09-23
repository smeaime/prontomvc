VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmItemsPopUpMateriales 
   Caption         =   "Definicion de items para menu desplegable de materiales"
   ClientHeight    =   5685
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9195
   Icon            =   "frmItemsPopUpMateriales.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5685
   ScaleWidth      =   9195
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   3870
      TabIndex        =   44
      Top             =   5130
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   5580
      TabIndex        =   43
      Top             =   5130
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   2160
      TabIndex        =   42
      Top             =   5130
      Width           =   1485
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   285
      Index           =   10
      Left            =   6570
      TabIndex        =   40
      Top             =   4500
      Width           =   2400
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Activar campo 10 :"
      Height          =   285
      Index           =   10
      Left            =   225
      TabIndex        =   38
      Top             =   4500
      Width           =   1680
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   285
      Index           =   9
      Left            =   6570
      TabIndex        =   36
      Top             =   4095
      Width           =   2400
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Activar campo 9 :"
      Height          =   285
      Index           =   9
      Left            =   225
      TabIndex        =   34
      Top             =   4095
      Width           =   1680
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   285
      Index           =   8
      Left            =   6570
      TabIndex        =   32
      Top             =   3690
      Width           =   2400
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Activar campo 8 :"
      Height          =   285
      Index           =   8
      Left            =   225
      TabIndex        =   30
      Top             =   3690
      Width           =   1680
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   285
      Index           =   7
      Left            =   6570
      TabIndex        =   28
      Top             =   3285
      Width           =   2400
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Activar campo 7 :"
      Height          =   285
      Index           =   7
      Left            =   225
      TabIndex        =   26
      Top             =   3285
      Width           =   1680
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   285
      Index           =   6
      Left            =   6570
      TabIndex        =   24
      Top             =   2880
      Width           =   2400
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Activar campo 6 :"
      Height          =   285
      Index           =   6
      Left            =   225
      TabIndex        =   22
      Top             =   2880
      Width           =   1680
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   285
      Index           =   5
      Left            =   6570
      TabIndex        =   20
      Top             =   2475
      Width           =   2400
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Activar campo 5 :"
      Height          =   285
      Index           =   5
      Left            =   225
      TabIndex        =   18
      Top             =   2475
      Width           =   1680
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   285
      Index           =   4
      Left            =   6570
      TabIndex        =   16
      Top             =   2070
      Width           =   2400
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Activar campo 4 :"
      Height          =   285
      Index           =   4
      Left            =   225
      TabIndex        =   14
      Top             =   2070
      Width           =   1680
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   285
      Index           =   3
      Left            =   6570
      TabIndex        =   12
      Top             =   1665
      Width           =   2400
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Activar campo 3 :"
      Height          =   285
      Index           =   3
      Left            =   225
      TabIndex        =   10
      Top             =   1665
      Width           =   1680
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   285
      Index           =   2
      Left            =   6570
      TabIndex        =   8
      Top             =   1260
      Width           =   2400
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Activar campo 2 :"
      Height          =   285
      Index           =   2
      Left            =   225
      TabIndex        =   6
      Top             =   1260
      Width           =   1680
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   285
      Index           =   1
      Left            =   6570
      TabIndex        =   4
      Top             =   855
      Width           =   2400
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Activar campo 1 :"
      Height          =   285
      Index           =   1
      Left            =   225
      TabIndex        =   2
      Top             =   855
      Width           =   1680
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   2925
      TabIndex        =   0
      Tag             =   "DefinicionArticulos"
      Top             =   225
      Width           =   5325
      _ExtentX        =   9393
      _ExtentY        =   556
      _Version        =   393216
      MatchEntry      =   -1  'True
      ListField       =   "Titulo"
      BoundColumn     =   "Clave"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   1
      Left            =   2025
      TabIndex        =   3
      Top             =   855
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Campo"
      BoundColumn     =   "Campo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   2
      Left            =   2025
      TabIndex        =   7
      Top             =   1260
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Campo"
      BoundColumn     =   "Campo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   3
      Left            =   2025
      TabIndex        =   11
      Top             =   1665
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Campo"
      BoundColumn     =   "Campo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   4
      Left            =   2025
      TabIndex        =   15
      Top             =   2070
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Campo"
      BoundColumn     =   "Campo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   5
      Left            =   2025
      TabIndex        =   19
      Top             =   2475
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Campo"
      BoundColumn     =   "Campo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   6
      Left            =   2025
      TabIndex        =   23
      Top             =   2880
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Campo"
      BoundColumn     =   "Campo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   7
      Left            =   2025
      TabIndex        =   27
      Top             =   3285
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Campo"
      BoundColumn     =   "Campo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   8
      Left            =   2025
      TabIndex        =   31
      Top             =   3690
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Campo"
      BoundColumn     =   "Campo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   9
      Left            =   2025
      TabIndex        =   35
      Top             =   4095
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Campo"
      BoundColumn     =   "Campo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   10
      Left            =   2025
      TabIndex        =   39
      Top             =   4500
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Campo"
      BoundColumn     =   "Campo"
      Text            =   ""
   End
   Begin VB.Label lbl 
      AutoSize        =   -1  'True
      Caption         =   "Tabla asociada :"
      Height          =   240
      Index           =   9
      Left            =   5310
      TabIndex        =   41
      Top             =   4545
      Width           =   1185
   End
   Begin VB.Label lbl 
      AutoSize        =   -1  'True
      Caption         =   "Tabla asociada :"
      Height          =   240
      Index           =   8
      Left            =   5310
      TabIndex        =   37
      Top             =   4140
      Width           =   1185
   End
   Begin VB.Label lbl 
      AutoSize        =   -1  'True
      Caption         =   "Tabla asociada :"
      Height          =   240
      Index           =   7
      Left            =   5310
      TabIndex        =   33
      Top             =   3735
      Width           =   1185
   End
   Begin VB.Label lbl 
      AutoSize        =   -1  'True
      Caption         =   "Tabla asociada :"
      Height          =   240
      Index           =   6
      Left            =   5310
      TabIndex        =   29
      Top             =   3330
      Width           =   1185
   End
   Begin VB.Label lbl 
      AutoSize        =   -1  'True
      Caption         =   "Tabla asociada :"
      Height          =   240
      Index           =   5
      Left            =   5310
      TabIndex        =   25
      Top             =   2925
      Width           =   1185
   End
   Begin VB.Label lbl 
      AutoSize        =   -1  'True
      Caption         =   "Tabla asociada :"
      Height          =   240
      Index           =   4
      Left            =   5310
      TabIndex        =   21
      Top             =   2520
      Width           =   1185
   End
   Begin VB.Label lbl 
      AutoSize        =   -1  'True
      Caption         =   "Tabla asociada :"
      Height          =   240
      Index           =   3
      Left            =   5310
      TabIndex        =   17
      Top             =   2115
      Width           =   1185
   End
   Begin VB.Label lbl 
      AutoSize        =   -1  'True
      Caption         =   "Tabla asociada :"
      Height          =   240
      Index           =   2
      Left            =   5310
      TabIndex        =   13
      Top             =   1710
      Width           =   1185
   End
   Begin VB.Label lbl 
      AutoSize        =   -1  'True
      Caption         =   "Tabla asociada :"
      Height          =   240
      Index           =   0
      Left            =   5310
      TabIndex        =   9
      Top             =   1305
      Width           =   1185
   End
   Begin VB.Label lbl 
      AutoSize        =   -1  'True
      Caption         =   "Tabla asociada :"
      Height          =   240
      Index           =   1
      Left            =   5310
      TabIndex        =   5
      Top             =   900
      Width           =   1185
   End
   Begin VB.Label label1 
      AutoSize        =   -1  'True
      Caption         =   "Rubro - Subrubro - Familia : "
      Height          =   240
      Index           =   1
      Left            =   675
      TabIndex        =   1
      Top             =   270
      Width           =   2145
   End
End
Attribute VB_Name = "frmItemsPopUpMateriales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.ItemPopUpMateriales
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long, mIdRubro As Long, mIdSubrubro As Long, mIdFamilia As Long
Private mNivelAcceso As Integer, mOpcionesAcceso As String

Public Property Let NivelAcceso(ByVal mNivelA As EnumAccesos)
   
   mNivelAcceso = mNivelA
   
End Property

Public Property Get NivelAcceso() As EnumAccesos

   NivelAcceso = mNivelAcceso
   
End Property

Public Property Let OpcionesAcceso(ByVal mOpcionesA As String)
   
   mOpcionesAcceso = mOpcionesA
   
End Property

Public Property Get OpcionesAcceso() As String

   OpcionesAcceso = mOpcionesAcceso
   
End Property

Private Sub Check1_Click(Index As Integer)

   If Len(DataCombo1(0).Text) = 0 Then
      MsgBox "Defina primero el rubro - sububro - familia del material", vbExclamation
      Check1(Index).Value = 0
   End If

   If Check1(Index).Value = 0 Then
      With origen.Registro
         .Fields("Campo" & Format(Index, "00") & "_Nombre").Value = Null
         .Fields("Campo" & Format(Index, "00") & "_Tabla").Value = Null
      End With
      DataCombo1(Index).Text = ""
      DataCombo1(Index).Enabled = False
      Text1(Index).Text = ""
   Else
      DataCombo1(Index).Enabled = True
      With origen.Registro
         If Not IsNull(.Fields("Campo" & Format(Index, "00") & "_Nombre").Value) Then
            DataCombo1(Index).BoundText = .Fields("Campo" & Format(Index, "00") & "_Nombre").Value
         End If
      End With
   End If

End Sub

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
   
         Dim est As EnumAcciones
         Dim dc As DataCombo
         Dim i As Integer, X As Integer
   
         If Len(DataCombo1(0).Text) = 0 Then
            MsgBox "Defina primero el rubro - sububro - familia del material", vbExclamation
            Exit Sub
         End If

         For Each dc In DataCombo1
            If dc.Enabled Then
               If Len(Trim(dc.BoundText)) = 0 Then
                  MsgBox "Falta completar el campo " & Check1(dc.Index).Caption, vbCritical
                  Exit Sub
               End If
            End If
         Next
         
         X = 1
         With origen.Registro
            .Fields("IdRubro").Value = mIdRubro
            .Fields("IdSubrubro").Value = mIdSubrubro
            .Fields("IdFamilia").Value = mIdFamilia
            For i = 1 To 10
               .Fields("Campo" & Format(i, "00") & "_Nombre").Value = Null
               .Fields("Campo" & Format(i, "00") & "_Tabla").Value = Null
            Next
            For i = 1 To 10
               If Check1(i).Value = 1 Then
                  .Fields("Campo" & Format(X, "00") & "_Nombre").Value = DataCombo1(i).BoundText
                  .Fields("Campo" & Format(X, "00") & "_Tabla").Value = Text1(i).Text
                  X = X + 1
               End If
            Next
         End With
         
         Select Case origen.Guardar
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "ItemsPopUpMateriales"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
      Case 1
   
         Dim mBorra As Integer
         mBorra = MsgBox("Esta seguro de eliminar los datos definitivamente ?", vbYesNo, "Eliminar")
         If mBorra = vbNo Then
            Exit Sub
         End If
         
         origen.Eliminar
         
         est = baja
            
         With actL2
            .ListaEditada = "ItemsPopUpMateriales"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
   End Select
   
   Unload Me

   Exit Sub

Mal:
   
   Dim mvarResp As Integer
   Select Case Err.Number
      Case -2147217900
         mvarResp = MsgBox("No puede borrar este registro porque se esta" & vbCrLf & "utilizando en otros archivos. Desea ver detalles?", vbYesNo + vbCritical)
         If mvarResp = vbYes Then
            MsgBox "Detalle del error : " & vbCrLf & Err.Number & " -> " & Err.Description
         End If
      Case Else
         MsgBox "Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical
   End Select

End Sub

Public Property Let Id(ByVal vnewvalue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   Dim i As Integer
   
   mvarId = vnewvalue
   
   mIdRubro = 0
   mIdSubrubro = 0
   mIdFamilia = 0
   
   Set oAp = Aplicacion
   Set origen = oAp.ItemsPopUpMateriales.Item(vnewvalue)
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
   
   If mvarId = -1 Then
   
   Else
      With origen.Registro
         DataCombo1(0).BoundText = "" & .Fields("IdRubro").Value & "|" & .Fields("IdSubrubro").Value & "|" & .Fields("IdFamilia").Value & "|"
         For i = 1 To 10
            If Not IsNull(.Fields("Campo" & Format(i, "00") & "_Nombre").Value) Then
               Check1(i).Value = 1
            Else
               Check1(i).Value = 0
            End If
         Next
      End With
   End If
   
   cmd(1).Enabled = False
   cmd(0).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      If mvarId > 0 Then cmd(1).Enabled = True
   End If
   
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub DataCombo1_Change(Index As Integer)

   Dim oRs As ADOR.Recordset
   Dim i As Integer
   Dim mTabla As String
   
   Select Case Index
      Case 0
         If Len(DataCombo1(0).BoundText) > 0 Then
            Dim mClave
            mClave = VBA.Split(DataCombo1(0).BoundText, "|")
            mIdRubro = CLng(mClave(0))
            mIdSubrubro = CLng(mClave(1))
            mIdFamilia = CLng(mClave(2))
            If mvarId = -1 Then
               Set oRs = Aplicacion.ItemsPopUpMateriales.TraerFiltrado("_Existente", Array(mIdRubro, mIdSubrubro, mIdFamilia))
               If oRs.RecordCount > 0 Then
                  oRs.Close
                  Set oRs = Nothing
                  MsgBox "Ya existe este grupo en la lista", vbExclamation
                  DataCombo1(0).BoundText = ""
                  Exit Sub
               End If
               oRs.Close
               Set oRs = Nothing
            End If
            For i = 1 To 10
               Set DataCombo1(i).RowSource = Aplicacion.DefinicionesArt.TraerFiltrado("_CamposPorGrupo", Array(mIdRubro, mIdSubrubro, mIdFamilia))
            Next
         End If
      Case Else
         For i = 1 To 10
            Set oRs = Aplicacion.DefinicionesArt.TraerFiltrado("_TablaComboPorGrupoCampo", Array(mIdRubro, mIdSubrubro, mIdFamilia, DataCombo1(i).BoundText))
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("TablaCombo").Value) Then
                  mTabla = oRs.Fields("TablaCombo").Value
                  If mId(mTabla, 1, 3) = "Aco" Then
                     mTabla = Right(mTabla, Len(mTabla) - 3)
                     If mTabla = "Schedulers" Then mTabla = "Scheduler"
                  End If
                  Text1(i).Text = mTabla
               End If
            End If
            oRs.Close
         Next
         Set oRs = Nothing
   End Select
      
End Sub

Private Sub Form_Load()

   If mvarId < 0 Then cmd(1).Enabled = False
   
   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

