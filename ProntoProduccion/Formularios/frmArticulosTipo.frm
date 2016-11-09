VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "msdatlst.ocx"
Begin VB.Form frmArticulosTipo 
   Caption         =   "Articulos"
   ClientHeight    =   2175
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9855
   LinkTopic       =   "Form1"
   ScaleHeight     =   2175
   ScaleWidth      =   9855
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Enabled         =   0   'False
      Height          =   600
      Left            =   2010
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   4
      Top             =   120
      Width           =   7575
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   480
      Index           =   2
      Left            =   8400
      TabIndex        =   2
      Top             =   1560
      Width           =   1215
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   480
      Index           =   0
      Left            =   6960
      TabIndex        =   1
      Top             =   1560
      Width           =   1215
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdTipo"
      Height          =   315
      Index           =   0
      Left            =   2040
      TabIndex        =   0
      Tag             =   "Tipos"
      Top             =   840
      Width           =   3345
      _ExtentX        =   5900
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdTipo"
      Text            =   "DataCombo1"
   End
   Begin VB.Label lblCódigoDescripcion 
      Caption         =   "Código - Descripcion :"
      Height          =   255
      Index           =   0
      Left            =   120
      TabIndex        =   5
      Top             =   165
      Width           =   1815
   End
   Begin VB.Label lblTipo 
      Caption         =   "Tipo :"
      Height          =   225
      Index           =   0
      Left            =   120
      TabIndex        =   3
      Top             =   960
      Width           =   1815
   End
End
Attribute VB_Name = "frmArticulosTipo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Articulo
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long
Private mNivelAcceso As Integer, mOpcionesAcceso As String
Dim WithEvents ActL As ControlForm
Attribute ActL.VB_VarHelpID = -1


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


Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
   
         'If Len(txtRubro.Text) = 0 Then
         '   MsgBox "No puede grabar un rubro sin descripcion", vbExclamation
         '   Exit Sub
         'End If

         'If Not IsNumeric(DataCombo1(0).BoundText) Then
         '   MsgBox "Debe indicar la cuenta contable", vbExclamation
         '   Exit Sub
        'End If
            
         Dim est As EnumAcciones
         Dim oControl As Control
   
         For Each oControl In Me.Controls
            If TypeOf oControl Is DataCombo Then
               If Len(oControl.BoundText) <> 0 Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
               End If
            ElseIf TypeOf oControl Is DTPicker Then
               origen.Registro.Fields(oControl.DataField).Value = oControl.Value
            End If
         Next
      
         
         Select Case origen.Guardar
            Case ComPronto.MisEstados.Correcto
            Case ComPronto.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComPronto.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComPronto.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
         
            
         With actL2

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
         Aplicacion.Tarea "Log_InsertarRegistro", _
               Array("ELIM", mvarId, 0, Now, 0, "Tabla : Rubros", GetCompName(), glbNombreUsuario)
            
         With actL2
        
            .AccionRegistro = est
            .Disparador = mvarId
         End With

    Case 2
    
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



Private Sub Form_Paint()

   ''Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)


   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   

End Sub

Private Sub ActL_ActLista(ByVal IdRegistro As Long, _
                          ByVal TipoAccion As EnumAcciones, _
                          ByVal NombreListaEditada As String, _
                          ByVal IdRegistroOriginal As Long)

'   ActualizarLista IdRegistro, TipoAccion, NombreListaEditada, IdRegistroOriginal

End Sub
Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Public Property Let Id(ByVal vnewvalue As Long)



   Dim oAp As ComPronto.Aplicacion
   Dim oApProd As ComPronto.Aplicacion
   Dim oControl As Control
   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set oApProd = AplicacionProd
   
   If vnewvalue = -1 Then
        MsgBox "No se pueden dar altas de artículos desde este módulo"
        Unload Me
        Exit Property
   End If
   



   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oAp.Articulos.Item(vnewvalue)
   Set oBind = New BindingCollection



   
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
   
         ElseIf TypeOf oControl Is DbListView Then
         ElseIf TypeOf oControl Is label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
   
   'Set DataCombo1(2).RowSource = Aplicacion.TablasGenerales.TraerLista("ProduccionLineas")
   Set DataCombo1(0).RowSource = oAp.Tipos.TraerFiltrado("_PorGrupoParaCombo") ', 2)
   DataCombo1(0).BoundColumn = "IdTipo"
   DataCombo1(0).BoundText = origen.Registro!Idtipo

   cmd(1).Enabled = True
   cmd(0).Enabled = True
   
   
   Set oAp = Nothing

End Property

Private Sub txtDescripcion_GotFocus()
   
   'With txtDescripcion
   '   .SelStart = 0
   '   .SelLength = Len(.Text)
   'End With

End Sub







