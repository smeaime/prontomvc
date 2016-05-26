VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmProductos 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Productos"
   ClientHeight    =   4740
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   6975
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4740
   ScaleWidth      =   6975
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   2745
      TabIndex        =   9
      Top             =   3885
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      Default         =   -1  'True
      Height          =   405
      Index           =   2
      Left            =   4455
      TabIndex        =   10
      Top             =   3885
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   1035
      TabIndex        =   8
      Top             =   3885
      Width           =   1485
   End
   Begin VB.TextBox txtFields 
      DataField       =   "DescripcionEspecifica"
      Height          =   285
      Index           =   2
      Left            =   2370
      TabIndex        =   2
      Top             =   975
      Width           =   4455
   End
   Begin VB.TextBox txtFields 
      DataField       =   "CodigoArticulo"
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
      Index           =   0
      Left            =   2370
      TabIndex        =   0
      Top             =   120
      Width           =   1335
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Descripcion"
      Height          =   285
      Index           =   1
      Left            =   2370
      TabIndex        =   1
      Top             =   555
      Width           =   4455
   End
   Begin VB.TextBox txtFields 
      Alignment       =   1  'Right Justify
      DataField       =   "StockMinimo"
      Height          =   285
      Index           =   4
      Left            =   2370
      TabIndex        =   4
      Top             =   1875
      Width           =   1335
   End
   Begin VB.TextBox txtFields 
      Alignment       =   1  'Right Justify
      DataField       =   "CostoPromedio"
      Enabled         =   0   'False
      Height          =   285
      Index           =   6
      Left            =   2370
      TabIndex        =   6
      Top             =   2760
      Width           =   1335
   End
   Begin VB.TextBox txtFields 
      Alignment       =   1  'Right Justify
      DataField       =   "CostoReposicion"
      Enabled         =   0   'False
      Height          =   285
      Index           =   7
      Left            =   2370
      TabIndex        =   7
      Top             =   3195
      Width           =   1335
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCategoria"
      Height          =   315
      Left            =   2370
      TabIndex        =   3
      Tag             =   "Categorias"
      Top             =   1440
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdCategoria"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo2 
      DataField       =   "IdProcedencia"
      Height          =   315
      Left            =   2370
      TabIndex        =   5
      Tag             =   "Procedencias"
      Top             =   2310
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   556
      _Version        =   393216
      Style           =   2
      ListField       =   "Titulo"
      BoundColumn     =   "IdProcedencia"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Costo reposicion :"
      Height          =   255
      Index           =   7
      Left            =   360
      TabIndex        =   18
      Top             =   3195
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Costo promedio actual :"
      Height          =   255
      Index           =   6
      Left            =   360
      TabIndex        =   17
      Top             =   2760
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Procedencia :"
      Height          =   255
      Index           =   5
      Left            =   360
      TabIndex        =   16
      Top             =   2325
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Stock minimo :"
      Height          =   255
      Index           =   4
      Left            =   360
      TabIndex        =   15
      Top             =   1875
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Categoria"
      Height          =   255
      Index           =   3
      Left            =   360
      TabIndex        =   14
      Top             =   1440
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Descripcion especifica :"
      Height          =   255
      Index           =   2
      Left            =   360
      TabIndex        =   13
      Top             =   960
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Descripcion generica :"
      Height          =   255
      Index           =   1
      Left            =   360
      TabIndex        =   12
      Top             =   555
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo :"
      Height          =   255
      Index           =   0
      Left            =   360
      TabIndex        =   11
      Top             =   120
      Width           =   1815
   End
End
Attribute VB_Name = "frmProductos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents Origen As ComAesa.Producto
Attribute Origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long
Dim actL2 As ControlForm

Private Sub cmd_Click(Index As Integer)

   Select Case Index
   
      Case 0
   
         Dim oControl As Control
         Dim est As EnumAcciones
      
         For Each oControl In Me.Controls
            If TypeOf oControl Is DataCombo Then
               Origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
            End If
         Next
      
         Select Case Origen.Guardar
            Case ComAesa.MisEstados.Correcto
               
            Case ComAesa.MisEstados.ModificadoPorOtro
               MsgBox "El Regsitro ha sido modificado"
            Case ComAesa.MisEstados.NoExiste
               MsgBox "El registro ha sido eliminado"
            Case ComAesa.MisEstados.ErrorDeDatos
               MsgBox "Error de ingreso de datos"
         End Select
      
         If mvarId < 0 Then
            est = alta
         Else
            est = Modificacion
         End If
            
         With actL2
            .AccionRegistro = est
            .Disparador = mvarId
         End With
      
      Case 1
   
         Origen.Eliminar
         
         est = Baja
            
         With actL2
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
   End Select
   
   Unload Me

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oap As ComAesa.Aplicacion
   Dim oControl As Control
   
   mvarId = vNewValue
   
   Set oap = Aplicacion
   Set Origen = oap.Productos.Item(vNewValue)
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = Origen
      
      ' la propiedad Datasource de cada control,
      ' recibe MI objeto que actúa como Proveedor de datos
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = Origen
            If Len(oControl.Tag) Then
               Set oControl.RowSource = oap.CargarLista(oControl.Tag)
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = Origen
         End If
      Next
   
   End With
   
   Set oap = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   
End Sub

