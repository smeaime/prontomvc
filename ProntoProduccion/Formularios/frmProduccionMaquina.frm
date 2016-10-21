VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmProduccionMaquina 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Máquina"
   ClientHeight    =   2280
   ClientLeft      =   -15
   ClientTop       =   375
   ClientWidth     =   6915
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2280
   ScaleWidth      =   6915
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text9 
      Alignment       =   1  'Right Justify
      DataField       =   "ParoFrecuencia"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   6000
      TabIndex        =   3
      Top             =   3480
      Width           =   615
   End
   Begin VB.CheckBox chkFueraDe 
      Caption         =   "Fuera de Servicio"
      DataField       =   "FueraDeServicio"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   4920
      Width           =   1935
   End
   Begin VB.TextBox Text8 
      Alignment       =   1  'Right Justify
      DataField       =   "CapacidadMaxima"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1800
      TabIndex        =   17
      Top             =   8400
      Width           =   870
   End
   Begin VB.TextBox Text7 
      Alignment       =   1  'Right Justify
      DataField       =   "CapacidadNormal"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1800
      TabIndex        =   15
      Top             =   8040
      Width           =   870
   End
   Begin VB.TextBox Text6 
      Alignment       =   1  'Right Justify
      DataField       =   "CapacidadMinima"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1800
      TabIndex        =   12
      Top             =   7680
      Width           =   870
   End
   Begin VB.TextBox Text5 
      DataField       =   "FueraDeServicioConcepto"
      Height          =   315
      Left            =   1800
      TabIndex        =   7
      Top             =   5280
      Width           =   3375
   End
   Begin VB.TextBox Text4 
      Alignment       =   1  'Right Justify
      DataField       =   "Cantidad"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   6000
      TabIndex        =   11
      Top             =   5760
      Visible         =   0   'False
      Width           =   870
   End
   Begin VB.TextBox Text3 
      Alignment       =   1  'Right Justify
      DataField       =   "TiempoApagado"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1800
      TabIndex        =   5
      Top             =   4200
      Width           =   735
   End
   Begin VB.TextBox txtCantidad 
      Alignment       =   1  'Right Justify
      DataField       =   "TiempoArranque"
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   315
      Left            =   1800
      TabIndex        =   1
      Top             =   3840
      Width           =   735
   End
   Begin VB.TextBox Text2 
      DataField       =   "ParoConcepto"
      Height          =   315
      Left            =   1800
      TabIndex        =   0
      Top             =   3480
      Width           =   3495
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   3720
      TabIndex        =   19
      Top             =   1680
      Width           =   1215
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      CausesValidation=   0   'False
      Height          =   420
      Index           =   2
      Left            =   5160
      TabIndex        =   20
      Top             =   1680
      Width           =   1215
   End
   Begin VB.TextBox txtOrden 
      CausesValidation=   0   'False
      DataField       =   "LineaOrden"
      Height          =   315
      Left            =   5520
      TabIndex        =   18
      Top             =   720
      Width           =   615
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdProduccionProceso"
      Height          =   315
      Index           =   1
      Left            =   1440
      TabIndex        =   14
      Tag             =   "ProduccionProcesos"
      Top             =   720
      Width           =   2850
      _ExtentX        =   5027
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProduccionProceso"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      CausesValidation=   0   'False
      DataField       =   "IdProduccionLinea"
      Height          =   315
      Index           =   2
      Left            =   1440
      TabIndex        =   16
      Tag             =   "ProduccionProcesos"
      Top             =   1080
      Width           =   2850
      _ExtentX        =   5027
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProduccionLinea"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FueraDeServicioFechaInicio"
      Height          =   315
      Left            =   1800
      TabIndex        =   8
      Top             =   5640
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   556
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   97648641
      CurrentDate     =   39785
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "ParoIdUnidad"
      Height          =   315
      Index           =   4
      Left            =   6720
      TabIndex        =   4
      Tag             =   "Unidades"
      Top             =   3480
      Width           =   945
      _ExtentX        =   1667
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTPicker2 
      DataField       =   "FueraDeServicioRetornoEstimado"
      Height          =   315
      Left            =   1800
      TabIndex        =   9
      Top             =   6000
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   556
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   97648641
      CurrentDate     =   39785
   End
   Begin MSComCtl2.DTPicker DTPicker3 
      DataField       =   "FueraDeServicioRetornoEfectivo"
      Height          =   315
      Left            =   1800
      TabIndex        =   10
      Top             =   6360
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   556
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   97648641
      CurrentDate     =   39785
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUnidadTiempo"
      Height          =   315
      Index           =   6
      Left            =   2640
      TabIndex        =   2
      Tag             =   "Unidades"
      Top             =   3840
      Width           =   1545
      _ExtentX        =   2725
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdUnidadCapacidad"
      Height          =   315
      Index           =   9
      Left            =   2760
      TabIndex        =   13
      Tag             =   "Unidades"
      Top             =   7680
      Width           =   1545
      _ExtentX        =   2725
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin VB.Line Line3 
      X1              =   120
      X2              =   8880
      Y1              =   7200
      Y2              =   7200
   End
   Begin VB.Line Line2 
      X1              =   0
      X2              =   8880
      Y1              =   4800
      Y2              =   4800
   End
   Begin VB.Label lblLabels 
      Caption         =   "Minima"
      Height          =   225
      Index           =   8
      Left            =   240
      TabIndex        =   38
      Top             =   8520
      Width           =   1335
   End
   Begin VB.Label lblLabels 
      Caption         =   "Normal"
      Height          =   225
      Index           =   6
      Left            =   240
      TabIndex        =   37
      Top             =   8160
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Máxima"
      Height          =   225
      Index           =   5
      Left            =   240
      TabIndex        =   36
      Top             =   7770
      Width           =   1335
   End
   Begin VB.Label lblEmpleado 
      Caption         =   "Concepto"
      Height          =   225
      Index           =   7
      Left            =   240
      TabIndex        =   35
      Top             =   5400
      Width           =   1200
   End
   Begin VB.Label lblLabels 
      Caption         =   "Diferencia en Días"
      Height          =   225
      Index           =   4
      Left            =   4800
      TabIndex        =   34
      Top             =   5880
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Line Line1 
      X1              =   120
      X2              =   8880
      Y1              =   480
      Y2              =   480
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tiempo de Apagado"
      Height          =   225
      Index           =   3
      Left            =   240
      TabIndex        =   33
      Top             =   4290
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tiempo de Arranque"
      Height          =   225
      Index           =   7
      Left            =   240
      TabIndex        =   32
      Top             =   3930
      Width           =   1815
   End
   Begin VB.Label lblEmpleado 
      Caption         =   "Frecuencia"
      Height          =   225
      Index           =   6
      Left            =   5160
      TabIndex        =   31
      Top             =   4200
      Width           =   960
   End
   Begin VB.Label lblFecha 
      Caption         =   "Fecha Efectiva"
      Height          =   225
      Index           =   2
      Left            =   240
      TabIndex        =   30
      Top             =   6480
      Width           =   1080
   End
   Begin VB.Label lblFecha 
      Caption         =   "Fecha Estimada"
      Height          =   225
      Index           =   0
      Left            =   240
      TabIndex        =   29
      Top             =   6120
      Width           =   1320
   End
   Begin VB.Label lblFecha 
      Caption         =   "Fecha de Salida"
      Height          =   225
      Index           =   1
      Left            =   240
      TabIndex        =   28
      Top             =   5760
      Width           =   1320
   End
   Begin VB.Label lblEmpleado 
      Caption         =   "Concepto"
      Height          =   225
      Index           =   3
      Left            =   240
      TabIndex        =   27
      Top             =   3600
      Width           =   1200
   End
   Begin VB.Label lblEmpleado 
      Caption         =   "Capacidad de Produccion"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Index           =   0
      Left            =   240
      TabIndex        =   26
      Top             =   7320
      Width           =   2760
   End
   Begin VB.Label lblLabels 
      Caption         =   "Linea"
      Height          =   225
      Index           =   0
      Left            =   240
      TabIndex        =   25
      Top             =   1200
      Width           =   720
   End
   Begin VB.Label lblLabels 
      Caption         =   "Proceso"
      Height          =   225
      Index           =   2
      Left            =   240
      TabIndex        =   24
      Top             =   840
      Width           =   720
   End
   Begin VB.Label lblEmpleado 
      Caption         =   "Máquina"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   225
      Index           =   1
      Left            =   240
      TabIndex        =   23
      Top             =   120
      Width           =   1080
   End
   Begin VB.Label lblEmpleado 
      Caption         =   "Tiempos de Paro"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   225
      Index           =   2
      Left            =   240
      TabIndex        =   22
      Top             =   3120
      Width           =   1680
   End
   Begin VB.Label lblPeso 
      Caption         =   "Orden"
      Height          =   225
      Index           =   3
      Left            =   4920
      TabIndex        =   21
      Top             =   840
      Width           =   1080
   End
   Begin VB.Label lblLabel1 
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   1440
      TabIndex        =   39
      Top             =   120
      Width           =   3135
   End
End
Attribute VB_Name = "frmProduccionMaquina"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Maquina
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
            
    ' Verificar, dentro de la misma LINEA de maquinarias, que no se repita el número de orden.
    If IsNumeric(txtOrden) And IsNumeric(origen.Registro!idProd_Maquina) And IsNumeric(DataCombo1(2).BoundText) Then
        Dim rs As ADOR.Recordset
        Set rs = AplicacionProd.Maquinas.TraerTodos
        rs.Filter = "LineaOrden=" & Val(txtOrden) & " and idProd_Maquina<>" & iisNull(origen.Registro!idProd_Maquina, 0) & " and idProduccionLinea=" & DataCombo1(2).BoundText
        If rs.RecordCount > 0 Then
            MsgBox "El numero de orden esta siendo usado por la maquina " & rs!descripcion & "-" & origen.Registro!idProd_Maquina
            Exit Sub
        End If
    End If
    
    If chkFueraDe.Value Then
       origen.Registro.Fields("FueraDeServicio").Value = "SI"
    Else
       origen.Registro.Fields("FueraDeServicio").Value = "NO"
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
      
      
        origen.Registro!lineaorden = Val(txtOrden)
         
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
   Dim oApProd As ComPronto.Aplicacion
   Dim oControl As Control
   
   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set oApProd = AplicacionProd
   
   If vNewValue = -1 Then
        MsgBox "No se pueden dar altas de máquinas desde este módulo"
        Unload Me
        Exit Property
   End If
   
   Dim rs As ADOR.Recordset
   Dim IdMaquina As Integer
   
   Dim art As ComPronto.Articulo
   Set art = Aplicacion.Articulos.Item(vNewValue)
   lblLabel1 = art.Registro!descripcion
   
   
   Set rs = AplicacionProd.Maquinas.TraerFiltrado("_PorIdArticulo", vNewValue)
   
   
   If rs.RecordCount = 0 Then
        Set origen = oApProd.Maquinas.Item(-1)
        origen.Registro!IdArticulo = vNewValue
   Else
        IdMaquina = rs!idProd_Maquina
        Set origen = oApProd.Maquinas.Item(IdMaquina)
   End If
   
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
            If Len(oControl.Tag) Then Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
   
   Set DataCombo1(2).RowSource = Aplicacion.TablasGenerales.TraerLista("ProduccionLineas")
   Set DataCombo1(1).RowSource = Aplicacion.TablasGenerales.TraerLista("ProduccionProcesos")


      If IsNull(origen.Registro.Fields("FueraDeServicio").Value) Or origen.Registro.Fields("FueraDeServicio").Value = "SI" Then
         chkFueraDe.Value = 1
      Else
         chkFueraDe.Value = 0
      End If



   Cmd(1).Enabled = True
   Cmd(0).Enabled = True
   
   
   Set oAp = Nothing

End Property

Private Sub txtDescripcion_GotFocus()
   
   'With txtDescripcion
   '   .SelStart = 0
   '   .SelLength = Len(.Text)
   'End With

End Sub

Private Sub DataCombo1_Validate(Index As Integer, Cancel As Boolean)
    On Error Resume Next
    Cancel = False
    If Index = 2 Then 'linea de produccion
        If IsNumeric(DataCombo1(2).BoundText) Then
            Dim rs As ADOR.Recordset
            Set rs = AplicacionProd.Maquinas.TraerTodos
            rs.Filter = "LineaOrden=" & Val(txtOrden) & " and idProd_Maquina<>" & origen.Registro!idProd_Maquina & " and idProduccionLinea=" & DataCombo1(2).BoundText
            
            If rs.RecordCount > 0 Then
                Cancel = True
                MsgBox "El numero de orden esta siendo usado por la maquina " & rs!descripcion & "-" & origen.Registro!idProd_Maquina
                Cancel = True
                Exit Sub
            End If
        End If
    End If
End Sub




Private Sub txtOrden_Validate(Cancel As Boolean)

    Cancel = False
    
    If Not IsNumeric(DataCombo1(2).BoundText) Then
        Cancel = True
        MsgBox "Debe elegir una linea"
        Exit Sub
    End If
    
    ' Verificar, dentro de la misma LINEA de maquinarias, que no se repita el número de orden.
    Dim rs As ADOR.Recordset
    Set rs = AplicacionProd.Maquinas.TraerTodos
    rs.Filter = "LineaOrden=" & Val(txtOrden) & " and idProd_Maquina<>" & origen.Registro!idProd_Maquina & " and idProduccionLinea=" & DataCombo1(2).BoundText
    
    If rs.RecordCount > 0 Then
        Cancel = True
        MsgBox "El numero de orden esta siendo usado por la maquina " & rs!descripcion & "-" & origen.Registro!idProd_Maquina
        Exit Sub
    End If
    
    

End Sub
