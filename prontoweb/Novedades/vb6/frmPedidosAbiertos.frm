VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmPedidosAbiertos 
   Caption         =   "Pedidos abiertos"
   ClientHeight    =   5325
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8010
   Icon            =   "frmPedidosAbiertos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5325
   ScaleWidth      =   8010
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   1755
      TabIndex        =   16
      Top             =   4815
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   3465
      TabIndex        =   15
      Top             =   4815
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   45
      TabIndex        =   14
      Top             =   4815
      Width           =   1485
   End
   Begin VB.TextBox txtImporteLimite 
      Alignment       =   1  'Right Justify
      DataField       =   "ImporteLimite"
      Height          =   285
      Left            =   1485
      TabIndex        =   3
      Top             =   1095
      Width           =   1635
   End
   Begin VB.TextBox txtBusca 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#.##0,00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Height          =   240
      Left            =   5940
      TabIndex        =   7
      Top             =   675
      Width           =   1995
   End
   Begin VB.TextBox txtNumeroPedidoAbierto 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroPedidoAbierto"
      Height          =   285
      Left            =   1485
      TabIndex        =   0
      Top             =   225
      Width           =   1320
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaPedidoAbierto"
      Height          =   285
      Index           =   0
      Left            =   4590
      TabIndex        =   1
      Top             =   210
      Width           =   1260
      _ExtentX        =   2223
      _ExtentY        =   503
      _Version        =   393216
      Format          =   97320961
      CurrentDate     =   36526
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdProveedor"
      Height          =   315
      Index           =   0
      Left            =   1485
      TabIndex        =   2
      Tag             =   "Proveedores"
      Top             =   630
      Width           =   4380
      _ExtentX        =   7726
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdProveedor"
      Text            =   ""
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "FechaLimite"
      Height          =   285
      Index           =   1
      Left            =   4410
      TabIndex        =   4
      Top             =   1080
      Width           =   1440
      _ExtentX        =   2540
      _ExtentY        =   503
      _Version        =   393216
      CheckBox        =   -1  'True
      Format          =   97320961
      CurrentDate     =   36526
   End
   Begin VB.PictureBox Lista 
      Height          =   2985
      Left            =   45
      OLEDragMode     =   1  'Automatic
      OLEDropMode     =   1  'Manual
      ScaleHeight     =   2925
      ScaleWidth      =   7830
      TabIndex        =   12
      Top             =   1755
      Width           =   7890
   End
   Begin VB.Label lblLabels 
      Caption         =   "Pedidos ya ingresados :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Index           =   16
      Left            =   90
      TabIndex        =   13
      Top             =   1530
      Width           =   2085
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Fecha limite :"
      Height          =   255
      Index           =   2
      Left            =   3285
      TabIndex        =   11
      Top             =   1125
      Width           =   1005
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Importe limite :"
      Height          =   285
      Index           =   0
      Left            =   90
      TabIndex        =   10
      Top             =   1110
      Width           =   1275
   End
   Begin VB.Label lblData 
      Caption         =   "Proveedor :"
      Height          =   285
      Index           =   0
      Left            =   90
      TabIndex        =   9
      Top             =   660
      Width           =   1275
   End
   Begin VB.Label lblLabels 
      Caption         =   "Buscar proveedor :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Index           =   3
      Left            =   5940
      TabIndex        =   8
      Top             =   480
      Width           =   1680
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Fecha de pedido :"
      Height          =   255
      Index           =   22
      Left            =   3060
      TabIndex        =   6
      Top             =   225
      Width           =   1410
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Numero pedido :"
      Height          =   285
      Index           =   1
      Left            =   90
      TabIndex        =   5
      Top             =   195
      Width           =   1275
   End
End
Attribute VB_Name = "frmPedidosAbiertos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.PedidoAbierto
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long
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

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
   
      Case 0
   
         If Val(txtNumeroPedidoAbierto.Text) = 0 Then
            MsgBox "No definio el numero de pedido", vbExclamation
            Exit Sub
         End If
         
         If Not IsNumeric(dcfields(0).BoundText) Then
            MsgBox "No definio el proveedor", vbExclamation
            Exit Sub
         End If
         
         Dim est As EnumAcciones
         Dim oControl As Control
   
         With origen.Registro
            For Each oControl In Me.Controls
               If TypeOf oControl Is DataCombo Then
                  If Len(oControl.BoundText) <> 0 Then
                     .Fields(oControl.DataField).Value = oControl.BoundText
                  End If
               ElseIf TypeOf oControl Is DTPicker Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.Value
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
            .ListaEditada = "PedidosAbiertos"
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
            .ListaEditada = "PedidosAbiertos"
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

Public Property Let Id(ByVal vNewValue As Long)

   Dim oAp As ComPronto.Aplicacion
   Dim oControl As Control
   
   mvarId = vNewValue
   
   DTPicker1(1).Value = DateSerial(Year(Date), 1, 1)
   
   Set oAp = Aplicacion
   Set origen = oAp.PedidosAbiertos.Item(vNewValue)
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
      With origen.Registro
         .Fields("FechaPedidoAbierto").Value = Date
         DTPicker1(0).Value = Date
      End With
      Lista.ListItems.Clear
   Else
      Set Lista.DataSource = oAp.PedidosAbiertos.TraerFiltrado("_PedidosHijos", mvarId)
   
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

Private Sub Form_Load()

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

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub txtBusca_GotFocus()

   With txtBusca
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtBusca_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      If KeyAscii = 13 Then
         Dim oRs As ADOR.Recordset
         If Len(Trim(txtBusca.Text)) <> 0 Then
            Set oRs = Aplicacion.Proveedores.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set oRs = Aplicacion.Proveedores.TraerLista
         End If
         Set dcfields(0).RowSource = oRs
         If oRs.RecordCount > 0 Then
            dcfields(0).BoundText = oRs.Fields(0).Value
         End If
         Set oRs = Nothing
      End If
      dcfields(0).SetFocus
'      SendKeys "%{DOWN}"
   End If

End Sub

Private Sub txtNumeroPedidoAbierto_GotFocus()

   With txtNumeroPedidoAbierto
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroPedidoAbierto_KeyPress(KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
