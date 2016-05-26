VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmDefinicionFlujoCaja 
   Caption         =   "Definicion del informe de flujo de caja"
   ClientHeight    =   7575
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7590
   Icon            =   "frmDefinicionFlujoCaja.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7575
   ScaleWidth      =   7590
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "Tipo concepto :"
      Height          =   870
      Left            =   5715
      TabIndex        =   17
      Top             =   45
      Width           =   1815
      Begin VB.OptionButton Option3 
         Caption         =   "Otros"
         Height          =   240
         Left            =   1035
         TabIndex        =   20
         Top             =   540
         Width           =   690
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Egresos"
         Height          =   240
         Left            =   90
         TabIndex        =   19
         Top             =   540
         Width           =   870
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Ingresos"
         Height          =   195
         Left            =   90
         TabIndex        =   18
         Top             =   270
         Width           =   1275
      End
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "frmDefinicionFlujoCaja.frx":076A
      Left            =   2925
      List            =   "frmDefinicionFlujoCaja.frx":0774
      TabIndex        =   15
      Text            =   "Combo1"
      Top             =   45
      Width           =   2670
   End
   Begin VB.TextBox txtDescripcion 
      DataField       =   "Descripcion"
      Height          =   285
      Left            =   1170
      TabIndex        =   1
      Top             =   405
      Width           =   4410
   End
   Begin VB.TextBox txtCodigo 
      Alignment       =   2  'Center
      DataField       =   "Codigo"
      Height          =   285
      Left            =   900
      TabIndex        =   0
      Top             =   45
      Width           =   945
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Cancelar"
      Height          =   330
      Index           =   1
      Left            =   1440
      TabIndex        =   3
      Top             =   7200
      Width           =   1365
   End
   Begin VB.CommandButton Cmd 
      Caption         =   "Aceptar"
      Height          =   330
      Index           =   0
      Left            =   45
      TabIndex        =   2
      Top             =   7200
      Width           =   1365
   End
   Begin Controles1013.DbListView ListaPlan 
      Height          =   1770
      Left            =   45
      TabIndex        =   4
      Top             =   3240
      Width           =   7485
      _ExtentX        =   13203
      _ExtentY        =   3122
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmDefinicionFlujoCaja.frx":0798
      OLEDragMode     =   1
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView Lista 
      Height          =   1950
      Left            =   45
      TabIndex        =   6
      Top             =   945
      Width           =   7485
      _ExtentX        =   13203
      _ExtentY        =   3440
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmDefinicionFlujoCaja.frx":07B4
      OLEDragMode     =   1
      OLEDropMode     =   1
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaRubros 
      Height          =   1770
      Left            =   45
      TabIndex        =   10
      Top             =   5355
      Width           =   7485
      _ExtentX        =   13203
      _ExtentY        =   3122
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmDefinicionFlujoCaja.frx":07D0
      OLEDragMode     =   1
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin Controles1013.DbListView ListaPresupuestos 
      Height          =   6270
      Left            =   7605
      TabIndex        =   12
      Top             =   855
      Visible         =   0   'False
      Width           =   2895
      _ExtentX        =   5106
      _ExtentY        =   11060
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmDefinicionFlujoCaja.frx":07EC
      OLEDragMode     =   1
      OLEDropMode     =   1
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   3015
      Top             =   7200
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
            Picture         =   "frmDefinicionFlujoCaja.frx":0808
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDefinicionFlujoCaja.frx":091A
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDefinicionFlujoCaja.frx":0D6C
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDefinicionFlujoCaja.frx":11BE
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin VB.Label lblRegistros 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0C0&
      Height          =   195
      Left            =   5640
      TabIndex        =   16
      Top             =   2880
      Width           =   1890
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "P/Informe :"
      Height          =   240
      Index           =   2
      Left            =   2025
      TabIndex        =   14
      Top             =   90
      Width           =   795
   End
   Begin VB.Label Label3 
      Caption         =   "Presupuestos por mes / año :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   7650
      TabIndex        =   13
      Top             =   630
      Visible         =   0   'False
      Width           =   2535
   End
   Begin VB.Label Label2 
      Caption         =   "Rubros : "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   90
      TabIndex        =   11
      Top             =   5130
      Width           =   780
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Descripcion :"
      Height          =   195
      Index           =   1
      Left            =   90
      TabIndex        =   9
      Top             =   450
      Width           =   1035
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Codigo :"
      Height          =   195
      Index           =   0
      Left            =   90
      TabIndex        =   8
      Top             =   90
      Width           =   720
   End
   Begin VB.Label Label1 
      Caption         =   "Definicion del concepto de flujo de caja :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   90
      TabIndex        =   7
      Top             =   765
      Width           =   3570
   End
   Begin VB.Label Label4 
      Caption         =   "Plan de cuentas :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   90
      TabIndex        =   5
      Top             =   3015
      Width           =   1545
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Cheques recibidos y no depositados"
         Index           =   1
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Cheques depositados y no acreditados"
         Index           =   2
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Cheques emitidos y no pagados"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Saldo bancos (segun extractos)"
         Index           =   4
      End
   End
   Begin VB.Menu MnuDetPresu 
      Caption         =   "DetallePresu"
      Visible         =   0   'False
      Begin VB.Menu MnuDetB 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetB 
         Caption         =   "Eliminar"
         Index           =   2
      End
   End
End
Attribute VB_Name = "frmDefinicionFlujoCaja"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DefinicionFlujoCaja
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long
Dim actL2 As ControlForm
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

Sub EditarPresupuesto(ByVal Cual As Long)

   Dim oF As frmDetDefinicionFlujoCaja
   Dim oL As ListItem
   
   Set oF = New frmDetDefinicionFlujoCaja
   
   With oF
      Set .DefinicionFlujoCaja = origen
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         If Cual = -1 Then
            Set oL = ListaPresupuestos.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaPresupuestos.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtMes.Text
            .SubItems(1) = "" & oF.txtAño.Text
            .SubItems(2) = "" & oF.txtPresupuesto.Text
         End With
      End If
   End With
   lblRegistros.Caption = "" & Lista.ListItems.Count & " elementos"
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
         
         If Not IsNumeric(txtCodigo.Text) Then
            MsgBox "Antes de grabar los items debe ingresar el codigo", vbExclamation
            Exit Sub
         End If
         
         If Len(txtDescripcion.Text) = 0 Then
            MsgBox "Antes de grabar los items debe ingresar la descripcion", vbExclamation
            Exit Sub
         End If
         With origen.Registro
            .Fields("CodigoInforme").Value = Combo1.ListIndex
            If Option1.Value Then
               .Fields("TipoConcepto").Value = 1
            ElseIf Option2.Value Then
               .Fields("TipoConcepto").Value = 2
            Else
               .Fields("TipoConcepto").Value = 3
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
         
         Dim est As EnumAcciones
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
         Else
            est = Modificacion
         End If
            
         If Not actL2 Is Nothing Then
            With actL2
               .ListaEditada = "CashFlow"
               .AccionRegistro = est
               .Disparador = mvarId
            End With
         End If
         
   End Select
   
   Unload Me

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim ListaVacia1 As Boolean, ListaVacia2 As Boolean
   Dim i As Integer
   
   mvarId = vNewValue
   ListaVacia1 = False
   ListaVacia2 = False
   
   Set oAp = Aplicacion
   Set origen = oAp.DefinicionesFlujoCaja.Item(vNewValue)
   
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetDefinicionesFlujoCajaCtas.TraerMascara
                     ListaVacia1 = True
                  Else
                     Set oRs = origen.DetDefinicionesFlujoCajaCtas.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia1 = False
                     Else
                        Set oControl.DataSource = origen.DetDefinicionesFlujoCajaCtas.TraerMascara
                        ListaVacia1 = True
                     End If
                     oRs.Close
                  End If
               Case "ListaPresupuestos"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetDefinicionesFlujoCajaPresu.TraerMascara
                     ListaVacia2 = True
                  Else
                     Set oRs = origen.DetDefinicionesFlujoCajaPresu.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        Set oControl.DataSource = oRs
                        ListaVacia2 = False
                     Else
                        Set oControl.DataSource = origen.DetDefinicionesFlujoCajaPresu.TraerMascara
                        ListaVacia2 = True
                     End If
                     oRs.Close
                  End If
            End Select
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
      Combo1.ListIndex = 0
      Option3.Value = True
   Else
      With origen.Registro
         If Not IsNull(.Fields("CodigoInforme").Value) Then
            Combo1.ListIndex = .Fields("CodigoInforme").Value
         Else
            Combo1.ListIndex = 0
         End If
         If IsNull(.Fields("TipoConcepto").Value) Or .Fields("TipoConcepto").Value = 3 Then
            Option3.Value = True
         ElseIf .Fields("TipoConcepto").Value = 1 Then
            Option1.Value = True
         Else
            Option2.Value = True
         End If
      End With
   End If
   
   If ListaVacia1 Then
      Lista.ListItems.Clear
   End If
   If ListaVacia2 Then
      ListaPresupuestos.ListItems.Clear
   End If
   lblRegistros.Caption = "" & Lista.ListItems.Count & " elementos"
   
   Set oRs = Nothing
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   With ListaPresupuestos
      Set .SmallIcons = img16
      .IconoPequeño = "Original"
   End With
   
   Set ListaPlan.DataSource = Aplicacion.Cuentas.TraerFiltrado("_PorJerarquia", -1)
   Set ListaRubros.DataSource = Aplicacion.RubrosContables.TraerFiltrado("_Financieros")

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

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetA_Click 0
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      PopupMenu MnuDet, , , , MnuDetA(0)
   End If

End Sub

Private Sub Lista_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String, mErrores As String
   Dim iFilas As Long, iColumnas As Long
   Dim mError As Boolean
   Dim Filas, Columnas
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then
      
      If Not IsNumeric(txtCodigo.Text) Then
         MsgBox "Antes de definir los items debe ingresar el codigo", vbExclamation
         Exit Sub
      End If
      
      s = Data.GetData(ccCFText)
      
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(0), vbTab)
      If InStr(1, Columnas(LBound(Columnas) + 3), "Cuenta") <> 0 And InStr(1, Columnas(LBound(Columnas) + 4), "Obra") <> 0 Then
         For iFilas = 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            mError = False
            For Each oL In Lista.ListItems
               If oL.SubItems(3) = Columnas(2) Then
                  mError = True
                  Exit For
               End If
            Next
            If Not mError Then
               mError = False
               Set oRs = Aplicacion.DefinicionesFlujoCaja.TraerFiltrado("_ControlDeItems", Array(Columnas(2), 0))
               If oRs.RecordCount > 0 Then
                  If oRs.Fields("IdTipoCuenta").Value <> 2 Then
                     mError = True
                  End If
                  If Not IsNull(oRs.Fields("IdDefinicionFlujoCaja").Value) And _
                        oRs.Fields("IdDefinicionFlujoCaja").Value <> mvarId Then
                     mError = True
                  End If
               End If
               If Not mError Then
                  With origen.DetDefinicionesFlujoCajaCtas.Item(-1)
                     .Registro.Fields("IdCuenta").Value = Columnas(2)
                     .Modificado = True
                  End With
                  Set oL = Lista.ListItems.Add
                  With oL
                     .Tag = txtCodigo.Text
                     .Text = Columnas(1) & " " & Columnas(3)
                     .SubItems(3) = "" & Columnas(2)
                  End With
               End If
            End If
         Next
      ElseIf InStr(1, Columnas(LBound(Columnas) + 4), "cuenta") <> 0 Then
         For iFilas = 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            mError = False
            For Each oL In Lista.ListItems
               If oL.SubItems(3) = Columnas(0) Then
                  mError = True
                  Exit For
               End If
            Next
            If Not mError Then
               mError = False
               Set oRs = Aplicacion.DefinicionesFlujoCaja.TraerFiltrado("_ControlDeItems", Array(Columnas(0), 0))
               If oRs.RecordCount > 0 Then
                  If oRs.Fields("IdTipoCuenta").Value <> 2 Then
                     mError = True
                  End If
                  If Not IsNull(oRs.Fields("IdDefinicionFlujoCaja").Value) And _
                        oRs.Fields("IdDefinicionFlujoCaja").Value <> mvarId Then
                     mError = True
                  End If
               End If
               If Not mError Then
                  With origen.DetDefinicionesFlujoCajaCtas.Item(-1)
                     .Registro.Fields("IdCuenta").Value = Columnas(0)
                     .Modificado = True
                  End With
                  Set oL = Lista.ListItems.Add
                  With oL
                     .Tag = txtCodigo.Text
                     .Text = Columnas(3) & " " & Columnas(1)
                     .SubItems(3) = "" & Columnas(0)
                  End With
               End If
            End If
         Next
      ElseIf InStr(1, Columnas(LBound(Columnas) + 3), "Rubro") <> 0 Then
         For iFilas = 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            mError = False
            For Each oL In Lista.ListItems
               If oL.SubItems(4) = Columnas(2) Then
                  mError = True
                  Exit For
               End If
            Next
            If Not mError Then
               mError = False
               Set oRs = Aplicacion.DefinicionesFlujoCaja.TraerFiltrado("_ControlDeItems", Array(0, Columnas(2)))
               If oRs.RecordCount > 0 Then
                  If Not IsNull(oRs.Fields("IdDefinicionFlujoCaja").Value) And _
                        oRs.Fields("IdDefinicionFlujoCaja").Value <> mvarId Then
                     mError = True
                  End If
               End If
               If Not mError Then
                  With origen.DetDefinicionesFlujoCajaCtas.Item(-1)
                     .Registro.Fields("IdRubroContable").Value = Columnas(2)
                     .Modificado = True
                  End With
                  Set oL = Lista.ListItems.Add
                  With oL
                     .Tag = txtCodigo.Text
                     .SubItems(1) = Columnas(1) & " " & Columnas(3)
                     .SubItems(4) = "" & Columnas(2)
                  End With
               End If
            End If
         Next
      End If
   End If
   lblRegistros.Caption = "" & Lista.ListItems.Count & " elementos"

End Sub

Private Sub Lista_OLEDragOver(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long
   Dim iColumnas As Long
   Dim oL As ListItem

   If State = vbEnter Then
      If Data.GetFormat(ccCFText) Then ' si el dato es texto
         s = Data.GetData(ccCFText) ' tomo el dato
         Filas = Split(s, vbCrLf) ' armo un vector por filas
         Columnas = Split(Filas(LBound(Filas)), vbTab)
         If Columnas(LBound(Columnas) + 1) <> "Descripcion" Then
            Effect = vbDropEffectNone
         Else
            Effect = vbDropEffectCopy
         End If
      End If
   End If

End Sub

Private Sub Lista_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub ListaPlan_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaPresupuestos_DblClick()

   If ListaPresupuestos.ListItems.Count = 0 Then
      EditarPresupuesto -1
   Else
      EditarPresupuesto ListaPresupuestos.SelectedItem.Tag
   End If

End Sub

Private Sub ListaPresupuestos_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaPresupuestos_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetB_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetB_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetB_Click 1
   End If

End Sub

Private Sub ListaPresupuestos_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If ListaPresupuestos.ListItems.Count = 0 Then
         MnuDetB(1).Enabled = False
         MnuDetB(2).Enabled = False
         PopupMenu MnuDetPresu, , , , MnuDetB(0)
      Else
         MnuDetB(1).Enabled = True
         MnuDetB(2).Enabled = True
         PopupMenu MnuDetPresu, , , , MnuDetB(1)
      End If
   End If

End Sub

Private Sub ListaRubros_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Dim oL As ListItem
   Dim mError As Boolean
   
   On Error Resume Next
   
   Select Case Index
      Case 0
         For Each oL In Lista.ListItems
            If oL.Selected Then
               origen.DetDefinicionesFlujoCajaCtas.Item(Lista.object.SelectedItem.Tag).Eliminado = True
               Lista.ListItems.Remove (Lista.object.SelectedItem.Index)
            End If
         Next
      Case 1
         mError = False
         For Each oL In Lista.ListItems
            If oL.SubItems(2) = "Cheques recibidos y no depositados" Then
               mError = True
               Exit For
            End If
         Next
         If Not mError Then
            With origen.DetDefinicionesFlujoCajaCtas.Item(-1)
               .Registro.Fields("OtroConcepto").Value = "Cheques recibidos y no depositados"
               .Modificado = True
            End With
            Lista.ListItems.Add.SubItems(2) = "Cheques recibidos y no depositados"
         End If
      Case 2
         mError = False
         For Each oL In Lista.ListItems
            If oL.SubItems(2) = "Cheques depositados y no acreditados" Then
               mError = True
               Exit For
            End If
         Next
         If Not mError Then
            With origen.DetDefinicionesFlujoCajaCtas.Item(-1)
               .Registro.Fields("OtroConcepto").Value = "Cheques depositados y no acreditados"
               .Modificado = True
            End With
            Lista.ListItems.Add.SubItems(2) = "Cheques depositados y no acreditados"
         End If
      Case 3
         mError = False
         For Each oL In Lista.ListItems
            If oL.SubItems(2) = "Cheques emitidos y no pagados" Then
               mError = True
               Exit For
            End If
         Next
         If Not mError Then
            With origen.DetDefinicionesFlujoCajaCtas.Item(-1)
               .Registro.Fields("OtroConcepto").Value = "Cheques emitidos y no pagados"
               .Modificado = True
            End With
            Lista.ListItems.Add.SubItems(2) = "Cheques emitidos y no pagados"
         End If
      Case 4
         mError = False
         For Each oL In Lista.ListItems
            If oL.SubItems(2) = "Saldo bancos (segun extractos)" Then
               mError = True
               Exit For
            End If
         Next
         If Not mError Then
            With origen.DetDefinicionesFlujoCajaCtas.Item(-1)
               .Registro.Fields("OtroConcepto").Value = "Saldo bancos (segun extractos)"
               .Modificado = True
            End With
            Lista.ListItems.Add.SubItems(2) = "Saldo bancos (segun extractos)"
         End If
   End Select
   lblRegistros.Caption = "" & Lista.ListItems.Count & " elementos"

End Sub

Private Sub MnuDetB_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarPresupuesto -1
      Case 1
         EditarPresupuesto ListaPresupuestos.SelectedItem.Tag
      Case 2
         With ListaPresupuestos.SelectedItem
            origen.DetDefinicionesFlujoCajaPresu.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub txtCodigo_GotFocus()

   With txtCodigo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtDescripcion_GotFocus()

   With txtDescripcion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub
