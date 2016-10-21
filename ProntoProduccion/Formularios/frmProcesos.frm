VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "msdatlst.ocx"
Begin VB.Form frmProduccionProceso 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Procesos"
   ClientHeight    =   6420
   ClientLeft      =   45
   ClientTop       =   405
   ClientWidth     =   5370
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6420
   ScaleWidth      =   5370
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox chkValidaFinal 
      Caption         =   "Valida Final  del Proceso Anterior"
      Height          =   255
      Left            =   1440
      TabIndex        =   14
      Top             =   3360
      Width           =   3015
   End
   Begin VB.CheckBox chkIncorpora 
      Caption         =   "Incorpora Material"
      Height          =   255
      Left            =   1440
      TabIndex        =   11
      Top             =   2640
      Width           =   2175
   End
   Begin VB.CheckBox chkValida 
      Caption         =   "Valida Inicio del Proceso Anterior"
      Height          =   255
      Left            =   1440
      TabIndex        =   10
      Top             =   3000
      Width           =   3015
   End
   Begin VB.CheckBox chkObligatorio 
      Caption         =   "Es punto de control obligatorio"
      Height          =   255
      Left            =   1440
      TabIndex        =   9
      Top             =   2280
      Width           =   2535
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "idProduccionSector"
      Height          =   315
      Index           =   0
      Left            =   1440
      TabIndex        =   8
      Top             =   240
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "idProduccionSector"
      Text            =   "Selecciones Sector"
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Cancelar"
      CausesValidation=   0   'False
      Height          =   495
      Index           =   2
      Left            =   4080
      TabIndex        =   7
      Top             =   5520
      Width           =   1095
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Eliminar"
      Height          =   495
      Index           =   1
      Left            =   2760
      TabIndex        =   6
      Top             =   5520
      Width           =   1095
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Aceptar"
      Height          =   495
      Index           =   0
      Left            =   1440
      TabIndex        =   5
      Top             =   5520
      Width           =   1095
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   735
      Left            =   1440
      TabIndex        =   3
      Top             =   1320
      Width           =   3735
   End
   Begin VB.TextBox txtCodigo 
      DataField       =   "Codigo"
      Height          =   375
      Left            =   1440
      TabIndex        =   2
      Top             =   720
      Width           =   2055
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUbicacion"
      Height          =   315
      Index           =   2
      Left            =   1440
      TabIndex        =   12
      Tag             =   "Ubicaciones"
      Top             =   4200
      Width           =   3765
      _ExtentX        =   6641
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUbicacion"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUbicacion"
      Height          =   315
      Index           =   1
      Left            =   1440
      TabIndex        =   15
      Tag             =   "Ubicaciones"
      Top             =   4800
      Visible         =   0   'False
      Width           =   3765
      _ExtentX        =   6641
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUbicacion"
      Text            =   ""
   End
   Begin VB.Label lblUbicaciónDe 
      Caption         =   "Ubicación de Producción:"
      Height          =   255
      Index           =   0
      Left            =   360
      TabIndex        =   16
      Top             =   4920
      Visible         =   0   'False
      Width           =   1875
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ubicación "
      Height          =   255
      Index           =   16
      Left            =   360
      TabIndex        =   13
      Top             =   4320
      Width           =   795
   End
   Begin VB.Label Label3 
      Caption         =   "Sector"
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   360
      Width           =   975
   End
   Begin VB.Label Label2 
      Caption         =   "Descripción"
      Height          =   375
      Left            =   240
      TabIndex        =   1
      Top             =   1440
      Width           =   975
   End
   Begin VB.Label Label1 
      Caption         =   "Código"
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   840
      Width           =   975
   End
End
Attribute VB_Name = "frmProduccionProceso"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.proceso
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

Public Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
   
         'If Len(txtRubro.Text) = 0 Then
         '   MsgBox "No puede grabar un rubro sin descripcion", vbExclamation
         '   Exit Sub
         'End If

         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Debe indicar el sector", vbExclamation
            Exit Sub
        End If
            
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
      
         
        With origen.Registro
            If chkObligatorio.Value Then
               .Fields("Obligatorio").Value = "SI"
            Else
               .Fields("Obligatorio").Value = "NO"
            End If
           
            If chkIncorpora.Value Then
               .Fields("Incorpora").Value = "SI"
            Else
               .Fields("Incorpora").Value = "NO"
            End If
           
            If chkValida.Value Then
               .Fields("Valida").Value = "SI"
            Else
               .Fields("Valida").Value = "NO"
            End If
         
            If chkValidaFinal.Value Then
               .Fields("ValidaFinal").Value = "SI"
            Else
               .Fields("ValidaFinal").Value = "NO"
            End If
         
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
      
         
            
         With actL2
            .ListaEditada = "Procesos"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
        'Aplicacion.Tarea "ProduccionProcesos_A", Array(0, DataCombo1(0).BoundText, txtCodigo, txtDescripcion)
   
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



Private Sub Cmd1_Click()

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
   Dim oControl As Control
   
   mvarId = vnewvalue
   
   Set oAp = AplicacionProd
   Set origen = oAp.Procesos.Item(vnewvalue)
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
     
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
  
   
   With origen.Registro
    
      If IsNull(.Fields("Obligatorio").Value) Or .Fields("Obligatorio").Value = "SI" Then
         chkObligatorio.Value = 1
      Else
         chkObligatorio.Value = 0
      End If
    
      If IsNull(.Fields("Incorpora").Value) Or .Fields("Incorpora").Value = "SI" Then
         chkIncorpora.Value = 1
      Else
         chkIncorpora.Value = 0
      End If
    
      If IsNull(.Fields("Valida").Value) Or .Fields("Valida").Value = "SI" Then
         chkValida.Value = 1
      Else
         chkValida.Value = 0
      End If
      
      If IsNull(.Fields("ValidaFinal").Value) Or .Fields("ValidaFinal").Value = "SI" Then
         chkValidaFinal.Value = 1
      Else
         chkValidaFinal.Value = 0
      End If
    End With
  
  
   Set DataCombo1(0).RowSource = Aplicacion.TablasGenerales.TraerLista("ProduccionSectores")
   Set DataCombo1(2).RowSource = Aplicacion.CargarLista("Ubicaciones") '.TraerTodos
   
   
   cmd(1).Enabled = True
   cmd(0).Enabled = True
   
   
   Set oAp = Nothing

End Property

Private Sub txtDescripcion_GotFocus()
   
   With txtDescripcion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub



