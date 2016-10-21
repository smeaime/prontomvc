VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmProduccionSector 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Sectores"
   ClientHeight    =   2550
   ClientLeft      =   45
   ClientTop       =   405
   ClientWidth     =   4740
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2550
   ScaleWidth      =   4740
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   735
      Left            =   1320
      TabIndex        =   8
      Top             =   600
      Width           =   3255
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Bindings        =   "frmSectores.frx":0000
      DataField       =   "idProduccionArea"
      Height          =   315
      Left            =   1320
      TabIndex        =   7
      Tag             =   "ProduccionAreas"
      Top             =   1440
      Width           =   1695
      _ExtentX        =   2990
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProduccionArea"
      Text            =   "Seleccione Area"
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Aceptar"
      Height          =   375
      Index           =   0
      Left            =   480
      TabIndex        =   6
      Top             =   2040
      Width           =   1215
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Eliminar"
      Height          =   375
      Index           =   1
      Left            =   1920
      TabIndex        =   5
      Top             =   2040
      Width           =   1215
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Cancelar"
      CausesValidation=   0   'False
      Height          =   375
      Index           =   2
      Left            =   3360
      TabIndex        =   4
      Top             =   2040
      Width           =   1215
   End
   Begin VB.TextBox txtCodigo 
      DataField       =   "Codigo"
      Height          =   375
      Left            =   1320
      TabIndex        =   3
      Top             =   120
      Width           =   1695
   End
   Begin VB.Label Label2 
      Caption         =   "Descripción"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   720
      Width           =   975
   End
   Begin VB.Label Label1 
      Caption         =   "Código"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   240
      Width           =   975
   End
   Begin VB.Label Label3 
      Caption         =   "Area"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   1560
      Width           =   975
   End
End
Attribute VB_Name = "frmProduccionSector"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.ProduccionSector
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
      
        'no me tenes que dejar dar de alta un sector si no tiene area
        If Not IsNumeric(DataCombo1.BoundText) Then
            MsgBox "Debe indicar el area", vbExclamation
            Exit Sub
        End If
   
        
        
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

Public Property Let Id(ByVal vNewValue As Long)



   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   
   mvarId = vNewValue
   
   Set oAp = AplicacionProd
   Set origen = oAp.ProduccionSectores.Item(vNewValue)
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
            If oControl.Tag = "Maquinas" Then
                Set oControl.RowSource = Aplicacion.TablasGenerales.TraerFiltrado("Articulos", "_PorDescripcionTipoParaCombo", Array(0, "Equipo"))
            ElseIf Len(oControl.Tag) Then
                Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
   
   'Set DataCombo1.RowSource = Aplicacion.TablasGenerales.TraerLista("ProduccionAreas")

   Cmd(1).Enabled = True
   Cmd(0).Enabled = True
   
   
   Set oAp = Nothing

End Property

Private Sub txtDescripcion_GotFocus()
   
   With txtDescripcion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

