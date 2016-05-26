VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Begin VB.Form frmAsientos 
   Caption         =   "Asientos contables"
   ClientHeight    =   6600
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11790
   Icon            =   "frmAsientos.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6600
   ScaleWidth      =   11790
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      Caption         =   "Asignar a presupuesto de obra"
      Height          =   195
      Left            =   3825
      TabIndex        =   18
      Top             =   5625
      Width           =   2760
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      Caption         =   "Asiento de apertura del ejercicio :"
      Height          =   195
      Left            =   3825
      TabIndex        =   16
      Top             =   5355
      Width           =   2760
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Habilitar anticipos"
      Height          =   420
      Index           =   3
      Left            =   1620
      TabIndex        =   15
      Top             =   5850
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar asiento"
      Height          =   420
      Index           =   2
      Left            =   1620
      TabIndex        =   14
      Top             =   5355
      Width           =   1470
   End
   Begin VB.TextBox txtSubdiario 
      DataField       =   "Concepto"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   5715
      TabIndex        =   9
      Top             =   495
      Width           =   5970
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
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
      Index           =   1
      Left            =   9630
      TabIndex        =   3
      Top             =   5355
      Width           =   1770
   End
   Begin VB.TextBox txtTotal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   """$""#,##0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Index           =   0
      Left            =   7605
      TabIndex        =   8
      Top             =   5355
      Width           =   1950
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   420
      Index           =   1
      Left            =   90
      TabIndex        =   2
      Top             =   5850
      Width           =   1470
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   420
      Index           =   0
      Left            =   90
      TabIndex        =   1
      Top             =   5355
      Width           =   1470
   End
   Begin VB.TextBox txtNumeroAsiento 
      Alignment       =   1  'Right Justify
      DataField       =   "NumeroAsiento"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   1710
      Locked          =   -1  'True
      TabIndex        =   0
      Top             =   495
      Width           =   795
   End
   Begin MSComctlLib.StatusBar Estado 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   4
      Top             =   6315
      Width           =   11790
      _ExtentX        =   20796
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.DTPicker DTFields 
      DataField       =   "FechaAsiento"
      Height          =   330
      Index           =   0
      Left            =   3375
      TabIndex        =   5
      Top             =   495
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   582
      _Version        =   393216
      Format          =   93454337
      CurrentDate     =   36377
   End
   Begin MSComctlLib.ImageList Img16 
      Left            =   2205
      Top             =   5580
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
            Picture         =   "frmAsientos.frx":076A
            Key             =   "Eliminado"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAsientos.frx":087C
            Key             =   "Nuevo"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAsientos.frx":0CCE
            Key             =   "Modificado"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAsientos.frx":1120
            Key             =   "Original"
         EndProperty
      EndProperty
   End
   Begin VB.PictureBox Lista 
      Height          =   4380
      Left            =   45
      OLEDropMode     =   1  'Manual
      ScaleHeight     =   4320
      ScaleWidth      =   11655
      TabIndex        =   10
      Top             =   900
      Width           =   11715
   End
   Begin MSComctlLib.ImageList imlToolbarIcons 
      Left            =   2790
      Top             =   5625
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAsientos.frx":1572
            Key             =   "Imprimir"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAsientos.frx":1684
            Key             =   "Buscar"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAsientos.frx":1796
            Key             =   "Ayuda"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAsientos.frx":18A8
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAsientos.frx":19BA
            Key             =   "Find"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAsientos.frx":1ACC
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAsientos.frx":1BDE
            Key             =   "Excel"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   11
      Top             =   0
      Width           =   11790
      _ExtentX        =   20796
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "imlToolbarIcons"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageKey        =   "Print"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel"
            Object.ToolTipText     =   "Salida a Excel"
            ImageKey        =   "Excel"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageKey        =   "Find"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
      EndProperty
   End
   Begin VB.PictureBox ListaAnticipos 
      Height          =   555
      Left            =   6705
      ScaleHeight     =   495
      ScaleWidth      =   585
      TabIndex        =   13
      Top             =   5310
      Visible         =   0   'False
      Width           =   645
   End
   Begin VB.Label lblInfo 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   3645
      TabIndex        =   17
      Top             =   5850
      Visible         =   0   'False
      Width           =   7785
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Concepto :"
      Height          =   240
      Index           =   0
      Left            =   4770
      TabIndex        =   12
      Top             =   540
      Width           =   870
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Numero de asiento :"
      Height          =   285
      Index           =   1
      Left            =   135
      TabIndex        =   7
      Top             =   540
      Width           =   1425
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Fecha :"
      Height          =   285
      Index           =   4
      Left            =   2700
      TabIndex        =   6
      Top             =   540
      Width           =   630
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalles"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Agregar"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Modificar"
         Index           =   1
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   2
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Renumerar items"
         Index           =   3
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Poner en cero pase cheque pago diferido"
         Index           =   4
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar pase cheque pago diferido"
         Index           =   5
      End
   End
   Begin VB.Menu MnuDetAnticipos 
      Caption         =   "DetalleAnticipos"
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
Attribute VB_Name = "frmAsientos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Asiento
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mvarIdTipoCuentaGrupoAnticiposAlPersonal As Long
Private mvarStock As Double
Private mvarGrabado As Boolean, mvarHayAnticipos As Boolean, mvarModificado As Boolean
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

Sub Editar(ByVal Cual As Long)

'   If mvarId > 0 Then
'      MsgBox "No puede modificar un asiento ya registrado!", vbCritical
'      Exit Sub
'   End If
   
'   If Not IsNull(origen.Registro.Fields("IdCuentaSubdiario").Value) Then
'      MsgBox "No puede modificar un asiento generado desde un subdiario!", vbCritical
'      Exit Sub
'   End If
   
   Dim oF As frmDetAsientos
   Dim oL As ListItem
   
   Set oF = New frmDetAsientos
   
   With oF
      Set .Asiento = origen
      .FechaAsiento = DTFields(0).Value
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         mvarModificado = True
         If Cual = -1 Then
            Set oL = Lista.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = Lista.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtItem.Text
            .SubItems(3) = "" & oF.txtCodigoCuenta.Text
            .SubItems(4) = "" & oF.DataCombo1(0).Text
            .SubItems(5) = "" & oF.DataCombo1(2).Text
            .SubItems(6) = "" & Format(Val(oF.txtDebe.Text), "Fixed")
            .SubItems(7) = "" & Format(Val(oF.txtHaber.Text), "Fixed")
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
   CalculaAsiento
   ControlarAnticipos
   
End Sub

Public Sub EditarAnticipo(ByVal Cual As Long)

   Dim oF As frmDetAsientosAnticipo
   Dim oL As ListItem
   
   Set oF = New frmDetAsientosAnticipo
   
   With oF
      Set .Asiento = origen
      .Id = Cual
      .Show vbModal, Me
      If .Aceptado Then
         mvarModificado = True
         If Cual = -1 Then
            Set oL = ListaAnticipos.ListItems.Add
            oL.Tag = .IdNuevo
         Else
            Set oL = ListaAnticipos.SelectedItem
         End If
         With oL
            If Cual = -1 Then
               .SmallIcon = "Nuevo"
            Else
               .SmallIcon = "Modificado"
            End If
            .Text = oF.txtLegajo.Text
            .SubItems(1) = "" & oF.DataCombo1(1).Text
            .SubItems(2) = "" & Format(oF.txtImporte.Text, "Fixed")
            .SubItems(3) = "" & Format(oF.txtCuotas.Text, "Fixed")
            .SubItems(4) = "" & oF.txtDetalle.Text
         End With
      End If
   End With
   
   Unload oF
   
   Set oF = Nothing
   
End Sub

Private Sub cmd_Click(Index As Integer)

   Select Case Index
      
      Case 0
      
         If DTFields(0).Value <= gblFechaUltimoCierre And _
               Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
            MsgBox "La fecha no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation
            Exit Sub
         End If

         If Lista.ListItems.Count = 0 Then
            MsgBox "No se puede almacenar un asiento sin detalles", vbExclamation
            Exit Sub
         End If
         
         If Len(txtSubdiario.Text) = 0 Then
            MsgBox "Indique el concepto del asiento", vbExclamation
            Exit Sub
         End If
         
         If origen.DetAsientos.TotalDebe <> origen.DetAsientos.TotalHaber Then
            MsgBox "El asiento no balancea", vbExclamation
            Exit Sub
         End If
         
         Dim dtp As DTPicker
         Dim est As EnumAcciones
         Dim mvarImprime As Integer
      
         With origen.Registro
            For Each dtp In DTFields
               .Fields(dtp.DataField).Value = dtp.Value
            Next
            If Check1.Value = 1 Then
               .Fields("AsientoApertura").Value = "SI"
            Else
               .Fields("AsientoApertura").Value = "NO"
            End If
            If Check2.Value = 1 Then
               .Fields("AsignarAPresupuestoObra").Value = "SI"
            Else
               .Fields("AsignarAPresupuestoObra").Value = "NO"
            End If
         End With
         
         If mvarId < 0 Then
            Dim oPar As ComPronto.Parametro
            Dim mNum As Long
            Set oPar = Aplicacion.Parametros.Item(1)
            With oPar.Registro
               mNum = .Fields("ProximoAsiento").Value
               origen.Registro.Fields("NumeroAsiento").Value = mNum
               .Fields("ProximoAsiento").Value = mNum + 1
            End With
            oPar.Guardar
            Set oPar = Nothing
            With origen.Registro
               .Fields("IdIngreso").Value = glbIdUsuario
               .Fields("FechaIngreso").Value = Now
            End With
         Else
            With origen.Registro
               .Fields("IdModifico").Value = glbIdUsuario
               .Fields("FechaUltimaModificacion").Value = Now
            End With
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
      
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
            mvarGrabado = True
         Else
            est = Modificacion
         End If
            
         mvarModificado = False
         
         With actL2
            .ListaEditada = "AsientosTodos,+SubAs2,+SubAsE"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
'         mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion del Asiento")
'         If mvarImprime = vbYes Then
'            cmdImpre_Click
'         End If
      
         Unload Me
      
      Case 1
      
         If mvarModificado Then
            Dim mvarSale As Integer
            mvarSale = MsgBox("Hay datos no grabados, desea salir igual ?", vbYesNo, "Salir")
            If mvarSale = vbNo Then
               Exit Sub
            End If
            mvarModificado = False
         End If
   
         Unload Me

      Case 2
      
         Dim mvarSeguro As Integer
         mvarSeguro = MsgBox("Esta seguro de eliminar el asiento?", vbYesNo, "Eliminacion del Asiento")
         If mvarSeguro = vbNo Then
            Exit Sub
         End If
         
         Dim mUsuario As String
         Dim mIdAnulo As Long
         Dim mOk As Boolean
         Dim oF As frmAutorizacion
         Set oF = New frmAutorizacion
         With oF
            .Empleado = 0
            .Administradores = True
            .Show vbModal, Me
            mUsuario = .Autorizo
            mIdAnulo = .IdAutorizo
            mOk = .Ok
         End With
         Unload oF
         Set oF = Nothing
         If Not mOk Then
            MsgBox "Eliminacion cancelada", vbExclamation
            Exit Sub
         End If

         Aplicacion.Tarea "Asientos_Eliminar", Array(mvarId)
         Aplicacion.Tarea "Log_InsertarRegistro", Array("AS_EL", 0, 0, Now, 0, _
               "Usuario (" & mIdAnulo & ") " & mUsuario & ", Version " & _
               App.Major & " " & App.Minor & " " & App.Revision, _
               GetCompName(), mUsuario, "Pronto " & App.Major & " " & App.Minor & " " & App.Revision, Null, Null, _
               Null, Null, Null, Null, Null, _
               mIdAnulo, mvarId, Val(txtNumeroAsiento.Text), Null, Null)
         
         With actL2
            .ListaEditada = "AsientosTodos,+SubAs2,+SubAsE"
            .AccionRegistro = EnumAcciones.baja
            .Disparador = mvarId
         End With
         
         Unload Me

      Case 3
      
         mvarHayAnticipos = Not mvarHayAnticipos
         ControlarAnticipos
   
   End Select
   
End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim dtf As DTPicker
   Dim oDet As ComPronto.DetAsiento
   Dim oDetAnt As ComPronto.DetAsientoAnticipos
   Dim ListaVacia As Boolean
   
   mvarId = vNewValue
   mvarModificado = False
   ListaVacia = False
   
   Set oAp = Aplicacion
   
   Set origen = oAp.Asientos.Item(vNewValue)
   
   Set oRs = oAp.Parametros.Item(1).Registro
   With oRs
      mvarIdTipoCuentaGrupoAnticiposAlPersonal = IIf(IsNull(.Fields("IdTipoCuentaGrupoAnticiposAlPersonal").Value), 0, _
                                                      .Fields("IdTipoCuentaGrupoAnticiposAlPersonal").Value)
      gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)
   End With
   oRs.Close
   
   Lista.Sorted = False
   
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
         ElseIf TypeOf oControl Is DbListView Then
            Select Case oControl.Name
               Case "Lista"
                  If vNewValue < 0 Then
                     Set oControl.DataSource = origen.DetAsientos.TraerMascara
                     ListaVacia = True
                  Else
                     Set oRs = origen.DetAsientos.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        ListaVacia = False
                        Set oControl.DataSource = oRs
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           Set oDet = origen.DetAsientos.Item(oRs.Fields(0).Value)
                           oDet.Modificado = True
                           Set oDet = Nothing
                           oRs.MoveNext
                        Loop
                     Else
                        Set oControl.DataSource = origen.DetAsientos.TraerMascara
                        ListaVacia = True
                     End If
                     Set oRs = Nothing
                  End If
               Case "ListaAnticipos"
                  If vNewValue < 0 Then
                  Else
                     Set oRs = origen.DetAsientosAnticipos.TraerTodos
                     If oRs.RecordCount <> 0 Then
                        oRs.MoveFirst
                        Do While Not oRs.EOF
                           Set oDetAnt = origen.DetAsientosAnticipos.Item(oRs.Fields(0).Value)
                           oDetAnt.Modificado = True
                           Set oDetAnt = Nothing
                           oRs.MoveNext
                        Loop
                     End If
                     Set oRs = Nothing
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
   
   If ListaVacia Then
      Lista.ListItems.Clear
   End If
   Lista.Refresh
   
   If mvarId < 0 Then
      Dim oPar As ComPronto.Parametro
      Dim mNum As Long
      Set oPar = oAp.Parametros.Item(1)
      With oPar.Registro
         mNum = .Fields("ProximoAsiento").Value
         origen.Registro.Fields("NumeroAsiento").Value = mNum
      End With
      Set oPar = Nothing
      For Each dtf In DTFields
         dtf.Value = Date
      Next
      Lista.ListItems.Clear
      mvarHayAnticipos = False
      mvarGrabado = False
   Else
      mvarHayAnticipos = False
      mvarGrabado = True
      With origen.Registro
         If Not IsNull(.Fields("IdCuentaSubdiario").Value) And _
               IsNull(.Fields("Concepto").Value) Then
            .Fields("Concepto").Value = oAp.TablasGenerales.TraerFiltrado("Titulos", "_PorId", origen.Registro.Fields("IdCuentaSubdiario").Value).Fields("Titulo").Value
         Else
            If origen.DetAsientosAnticipos.TraerTodos.RecordCount > 0 Then
               mvarHayAnticipos = True
            End If
            ControlarAnticipos
         End If
         If Not IsNull(.Fields("AsientoApertura").Value) And _
               .Fields("AsientoApertura").Value = "SI" Then
            Check1.Value = 1
         End If
         If Not IsNull(.Fields("AsignarAPresupuestoObra").Value) And _
               .Fields("AsignarAPresupuestoObra").Value = "SI" Then
            Check2.Value = 1
         End If
      End With
   End If
   
   Set oRs = Nothing
   Set oAp = Nothing

   cmd(0).Enabled = False
   cmd(2).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(0).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(0).Enabled = True
      If mvarId > 0 Then cmd(2).Enabled = True
   End If
   
   If DTFields(0).Value <= gblFechaUltimoCierre And _
         Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
      cmd(0).Enabled = False
      cmd(2).Enabled = False
   End If

   If origen.AjusteChequesDiferidos Then
      cmd(0).Enabled = False
      cmd(2).Enabled = False
      With lblInfo
         .Caption = "Asiento de ajuste por cheques de pago diferido"
         .Visible = True
      End With
   End If
   
   If Not IsNull(origen.Registro.Fields("FechaGeneracionConsolidado").Value) Then
      cmd(0).Enabled = False
      cmd(2).Enabled = False
      With lblInfo
         .Caption = "Asiento generado por consolidacion"
         .Visible = True
      End With
   End If

End Property

'Private Sub cmdImpre_Click()
'
'   If Not mvarGrabado Then
'      MsgBox "Antes de imprimir debe grabar el comprobante!", vbCritical
'      Exit Sub
'   End If
'
'   Dim oW As Word.Application
'   Dim oRs, oRsDet As ADOR.Recordset
'
'   Me.MousePointer = vbHourglass
'
'   On Error GoTo Mal
'
'   Set oW = CreateObject("Word.Application")
'
'   With oW
'
'      .Visible = False
'
'      With .Documents.Add(App.Path & "\Asiento.dot")
'
'         Set oRs = origen.Registro
'         Set oRsDet = origen.DetAsientos.TraerTodos
'
''         .Unprotect
'         oW.Selection.HomeKey Unit:=wdStory
'         oW.Selection.MoveDown Unit:=wdLine, Count:=3
'         oW.Selection.MoveRight Unit:=wdCell, Count:=4
'
'         With oRsDet
'            Do Until .EOF
'               oW.Selection.MoveRight Unit:=wdCell
'               oW.Selection.TypeText Text:=FormatearArticulo(.Fields("Codigo").Value)
'               oW.Selection.MoveRight Unit:=wdCell
'               oW.Selection.TypeText Text:="" & Format(.Fields("Articulo").Value, "Fixed")
'               oW.Selection.MoveRight Unit:=wdCell
'               oW.Selection.TypeText Text:=.Fields("Deposito").Value
'               oW.Selection.MoveRight Unit:=wdCell
'               oW.Selection.TypeText Text:=.Fields("Partida").Value
'               oW.Selection.MoveRight Unit:=wdCell
'               oW.Selection.TypeText Text:=.Fields("Kilos").Value
'               .MoveNext
'            Loop
'         End With
'
'         oW.ActiveDocument.Protect wdAllowOnlyFormFields
'         oW.ActiveDocument.FormFields("Fecha").Result = oRs.Fields("FechaAsiento").Value
'         oW.ActiveDocument.FormFields("Numero").Result = oRs.Fields("NumeroAsiento").Value
'
'          oRsDet.Close
'          oRs.Close
'
'          oW.ActiveDocument.PrintOut False
'
'       .Close False
'
'      End With
'
'      .Quit
'
'   End With
'
'Mal:
'
'   Set oW = Nothing
'   Set oRsDet = Nothing
'   Set oRs = Nothing
'
'   Me.MousePointer = vbDefault
'
'End Sub

Private Sub DTFields_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTFields(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Activate()
   
   CalculaAsiento

End Sub

Private Sub Form_Load()

   Dim oI As ListImage
   
   With Lista
      Set .SmallIcons = Img16
      .IconoPequeño = "Original"
   End With
   
   With ListaAnticipos
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

   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub Lista_DblClick()

   If Lista.ListItems.Count = 0 Then
      Editar -1
   Else
      Editar Lista.SelectedItem.Tag
   End If

End Sub

Private Sub Lista_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyDelete Then
      MnuDetA_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetA_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetA_Click 1
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If Not origen.AjusteChequesDiferidos Then
         MnuDetA(4).Enabled = False
         MnuDetA(5).Enabled = False
      End If
      If Lista.ListItems.Count = 0 Then
         MnuDetA(1).Enabled = False
         MnuDetA(2).Enabled = False
         PopupMenu MnuDet, , , , MnuDetA(0)
      Else
         MnuDetA(1).Enabled = True
         MnuDetA(2).Enabled = True
         PopupMenu MnuDet, , , , MnuDetA(1)
      End If
   End If

End Sub

Private Sub Lista_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim iFilas As Long, iColumnas As Long, i As Long, mSubNumero As Long
   Dim Filas
   Dim Columnas
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset

   If mvarId > 0 Then
      MsgBox "Solo puede copiar a un asiento nuevo!", vbCritical
      Exit Sub
   End If
   
   If Data.GetFormat(ccCFText) Then
      
      s = Data.GetData(ccCFText)
   
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If UBound(Columnas) < 2 Then
         MsgBox "No hay un comprobante para copiar", vbCritical
         Exit Sub
      End If
      
      If UBound(Filas) > 1 Then
         MsgBox "No puede copiar mas de un comprobante a la vez!", vbCritical
         Exit Sub
      End If
      
      If InStr(1, Columnas(LBound(Columnas) + 1), "asiento") <> 0 Then
      
         Me.MousePointer = vbHourglass
         DoEvents
         
         Set oAp = Aplicacion
         
         Columnas = Split(Filas(1), vbTab)
         
         Set oRsDet = oAp.Asientos.TraerFiltrado("_DetallesPorIdAsiento", Columnas(2))
         
         If oRsDet.RecordCount > 0 Then
            oRsDet.MoveFirst
            Do While Not oRsDet.EOF
               With origen.DetAsientos.Item(-1)
                  For i = 2 To oRsDet.Fields.Count - 1
                     .Registro.Fields(i).Value = oRsDet.Fields(i).Value
                  Next
                  .Registro.Fields("Debe").Value = 0
                  .Registro.Fields("Haber").Value = 0
                  .Registro.Fields("Item").Value = origen.DetAsientos.ProximoItem
                  .Modificado = True
               End With
               oRsDet.MoveNext
            Loop
         End If
         
         oRsDet.Close
         Set oRsDet = Nothing
         
         Set oAp = Nothing
         
         Set Lista.DataSource = origen.DetAsientos.RegistrosConFormato
         CalculaAsiento
         
         mvarModificado = True

         Me.MousePointer = vbDefault
      
      End If
   
   End If

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

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub CalculaAsiento()

   txtTotal(0).Text = Format(origen.DetAsientos.TotalDebe, "#,##0.00")
   txtTotal(1).Text = Format(origen.DetAsientos.TotalHaber, "#,##0.00")
   
End Sub

Private Sub ListaAnticipos_DblClick()

   If ListaAnticipos.ListItems.Count = 0 Then
      EditarAnticipo -1
   Else
      EditarAnticipo ListaAnticipos.SelectedItem.Tag
   End If

End Sub

Private Sub ListaAnticipos_FinCarga()

   CambiarLenguaje Me, "esp", glbIdiomaActual, "DbListView"
   
End Sub

Private Sub ListaAnticipos_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetB_Click 2
   ElseIf KeyCode = vbKeyInsert Then
      MnuDetB_Click 0
   ElseIf KeyCode = vbKeySpace Then
      MnuDetB_Click 1
   End If

End Sub

Private Sub ListaAnticipos_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      If ListaAnticipos.ListItems.Count = 0 Then
         MnuDetB(1).Enabled = False
         MnuDetB(2).Enabled = False
         PopupMenu MnuDetAnticipos, , , , MnuDetB(0)
      Else
         MnuDetB(1).Enabled = True
         MnuDetB(2).Enabled = True
         PopupMenu MnuDetAnticipos, , , , MnuDetB(1)
      End If
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         Editar -1
      Case 1
         Editar Lista.SelectedItem.Tag
      Case 2
'         If Not IsNull(origen.Registro.Fields("IdCuentaSubdiario").Value) Then
'            MsgBox "No puede modificar un asiento generado desde un subdiario!", vbCritical
'            Exit Sub
'         End If
         With Lista.SelectedItem
            origen.DetAsientos.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
         CalculaAsiento
         ControlarAnticipos
      Case 3
         RenumerarItems
      Case 4
         PonerCeroChequePagoDiferido
      Case 5
         EliminarChequePagoDiferido
   End Select

End Sub

Private Sub MnuDetB_Click(Index As Integer)

   Select Case Index
      Case 0
         EditarAnticipo -1
      Case 1
         EditarAnticipo ListaAnticipos.SelectedItem.Tag
      Case 2
         With ListaAnticipos.SelectedItem
            origen.DetAsientosAnticipos.Item(.Tag).Eliminado = True
            .SmallIcon = "Eliminado"
            .ToolTipText = .SmallIcon
         End With
   End Select

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Key
      Case "Imprimir"
         ImprimirConExcel Lista, "Asiento nro. : " & txtNumeroAsiento.Text & "    -    " & _
                                 "Fecha del asiento : " & DTFields(0).Value & "|Detalle : " & txtSubdiario.Text
      Case "Buscar"
         FiltradoLista Lista
      Case "Excel"
         ExportarAExcel Lista, "Asiento nro. : " & txtNumeroAsiento.Text & "    -    " & _
                                 "Fecha del asiento : " & DTFields(0).Value & "|Detalle : " & txtSubdiario.Text
   End Select

End Sub

Public Sub ControlarAnticipos()

   Dim oRs As ADOR.Recordset
   Dim oL As ListItem
   
'   mvarHayAnticipos = False
'
'   With Lista
'      If .ListItems.Count > 0 Then
'         For Each oL In .ListItems
'            If Not origen.DetAsientos.Item(oL.Tag).Eliminado Then
'               If IsNumeric(oL.SubItems(5)) Then
'                  Set oRs = Aplicacion.Cuentas.TraerFiltrado("_PorId", oL.SubItems(5))
'                  If oRs.RecordCount > 0 Then
'                     If Not IsNull(oRs.Fields("IdTipoCuentaGrupo").Value) Then
'                        If oRs.Fields("IdTipoCuentaGrupo").Value = mvarIdTipoCuentaGrupoAnticiposAlPersonal Then
'                           mvarHayAnticipos = True
'                        End If
'                     End If
'                  End If
'                  oRs.Close
'                  If mvarHayAnticipos Then Exit For
'               End If
'            End If
'         Next
'      End If
'   End With
   
   If mvarHayAnticipos Then
      If Not ListaAnticipos.Visible Then
         With Lista
            .Height = Lista.Height * 0.5
         End With
         With ListaAnticipos
            .Top = Lista.Top + Lista.Height + 10
            .Left = Lista.Left
            .Width = Lista.Width
            .Height = Lista.Height * 0.9
            Set oRs = origen.DetAsientosAnticipos.RegistrosConFormato
            If oRs.RecordCount <> 0 Then
               Set .DataSource = oRs
               oRs.MoveFirst
            Else
               Set .DataSource = origen.DetAsientosAnticipos.TraerMascara
               .ListItems.Clear
            End If
            Set oRs = Nothing
            .Visible = True
         End With
      End If
   Else
      If ListaAnticipos.Visible Then
         With ListaAnticipos
'            If .ListItems.Count > 0 Then
'               For Each oL In .ListItems
'                  origen.DetAsientosAnticipos.Item(oL.Tag).Eliminado = True
'               Next
'            End If
'            .ListItems.Clear
            .Visible = False
         End With
         Lista.Height = Lista.Height * 2
      End If
   End If
               
   Set oRs = Nothing

End Sub

Public Sub RenumerarItems()

   Dim oL As ListItem
   Dim i As Integer
   
   i = 1
   For Each oL In Lista.ListItems
      With origen.DetAsientos.Item(oL.Tag)
         If Not .Eliminado Then
            .Registro.Fields("Item").Value = i
            .Modificado = True
            oL.Text = i
            i = i + 1
         End If
      End With
   Next

End Sub

Public Sub PonerCeroChequePagoDiferido()

   Dim oF As frmAutorizacion
   Dim oRs As ADOR.Recordset
   Dim mUsuario As String, s As String
   Dim mIdAnulo As Long
   Dim mOk As Boolean
   Dim iFilas As Integer
   Dim Filas, Columnas
   
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.Asientos
      .Show vbModal, Me
      mOk = .Ok
      mUsuario = .Autorizo
      mIdAnulo = .IdAutorizo
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then
      Exit Sub
   End If
   
   Me.Refresh
   
   Dim mSeguro As Integer
   mSeguro = MsgBox("Esta seguro de poner en cero los items?", vbYesNo, "Poner en cero")
   If mSeguro = vbNo Then
      Exit Sub
   End If

   Filas = VBA.Split(Lista.GetString, vbCrLf)
   s = ""
   For iFilas = LBound(Filas) + 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(iFilas), vbTab)
      If IsNumeric(Columnas(2)) And IsNumeric(Columnas(3)) Then
         Set oRs = origen.DetAsientos.Registros
         With oRs
            If .Fields.Count > 0 Then
               If .RecordCount > 0 Then
                  .MoveFirst
                  Do While Not .EOF
                     If .Fields("IdValor").Value = Val(Columnas(3)) Then
                        origen.DetAsientos.Item(.Fields(0).Value).Registro.Fields("Debe").Value = Null
                        origen.DetAsientos.Item(.Fields(0).Value).Registro.Fields("Haber").Value = Null
                        
                        Aplicacion.Tarea "Asientos_EliminarItemChequePagoDiferido", Array("0", .Fields(0).Value)
                        Aplicacion.Tarea "Log_InsertarRegistro", Array("AS_E1", 0, 0, Now, 0, _
                              "Usuario (" & mIdAnulo & ") " & mUsuario & ", Version " & _
                              App.Major & " " & App.Minor & " " & App.Revision, _
                              GetCompName(), mUsuario, "Pronto " & App.Major & " " & App.Minor & " " & App.Revision, Null, Null, _
                              Null, Null, Null, Null, Null, _
                              mIdAnulo, .Fields(0).Value, Columnas(3), Null, Null)
                     End If
                     .MoveNext
                  Loop
                  .MoveFirst
               End If
            End If
         End With
         Set oRs = Nothing
      End If
   Next
   Set Lista.DataSource = origen.DetAsientos.RegistrosConFormato
   CalculaAsiento

End Sub

Public Sub EliminarChequePagoDiferido()

   Dim oF As frmAutorizacion
   Dim oRs As ADOR.Recordset
   Dim mUsuario As String, s As String
   Dim mIdAnulo As Long
   Dim mOk As Boolean
   Dim iFilas As Integer
   Dim Filas, Columnas
   
   Set oF = New frmAutorizacion
   With oF
      .Empleado = 0
      .IdFormulario = EnumFormularios.Asientos
      .Show vbModal, Me
      mOk = .Ok
      mUsuario = .Autorizo
      mIdAnulo = .IdAutorizo
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then
      Exit Sub
   End If
   
   Me.Refresh
   
   Dim mSeguro As Integer
   mSeguro = MsgBox("Esta seguro de eliminar los items?", vbYesNo, "Eliminar items")
   If mSeguro = vbNo Then
      Exit Sub
   End If

   Filas = VBA.Split(Lista.GetString, vbCrLf)
   s = ""
   For iFilas = LBound(Filas) + 1 To UBound(Filas)
      Columnas = VBA.Split(Filas(iFilas), vbTab)
      If IsNumeric(Columnas(2)) And IsNumeric(Columnas(3)) Then
         Set oRs = origen.DetAsientos.Registros
         With oRs
            If .Fields.Count > 0 Then
               If .RecordCount > 0 Then
                  .MoveFirst
                  Do While Not .EOF
                     If .Fields("IdValor").Value = Val(Columnas(3)) Then
                        origen.DetAsientos.Item(.Fields(0).Value).Eliminado = True
                        
                        Aplicacion.Tarea "Asientos_EliminarItemChequePagoDiferido", Array("E", .Fields(0).Value)
                        Aplicacion.Tarea "Log_InsertarRegistro", Array("AS_E2", 0, 0, Now, 0, _
                              "Usuario (" & mIdAnulo & ") " & mUsuario & ", Version " & _
                              App.Major & " " & App.Minor & " " & App.Revision, _
                              GetCompName(), mUsuario, "Pronto " & App.Major & " " & App.Minor & " " & App.Revision, Null, Null, _
                              Null, Null, Null, Null, Null, _
                              mIdAnulo, .Fields(0).Value, Columnas(3), Null, Null)
                     End If
                     .MoveNext
                  Loop
                  .MoveFirst
               End If
            End If
         End With
         Set oRs = Nothing
      End If
   Next
   Set Lista.DataSource = origen.DetAsientos.RegistrosConFormato
   CalculaAsiento

End Sub
