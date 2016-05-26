VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmEmpresa 
   ClientHeight    =   8760
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10845
   Icon            =   "frmEmpresa.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8760
   ScaleWidth      =   10845
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtArchivoAFIP 
      DataField       =   "ArchivoAFIP"
      Height          =   285
      Left            =   5490
      TabIndex        =   31
      Top             =   5715
      Width           =   5235
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Cancelar"
      Height          =   465
      Index           =   1
      Left            =   2115
      TabIndex        =   29
      Top             =   8190
      Width           =   1725
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Aceptar"
      Height          =   465
      Index           =   0
      Left            =   90
      TabIndex        =   28
      Top             =   8190
      Width           =   1725
   End
   Begin VB.TextBox txtDatosAdicionales3 
      DataField       =   "DatosAdicionales3"
      Height          =   285
      Left            =   90
      TabIndex        =   27
      Top             =   7770
      Width           =   10635
   End
   Begin VB.TextBox txtDatosAdicionales2 
      DataField       =   "DatosAdicionales2"
      Height          =   285
      Left            =   90
      TabIndex        =   25
      Top             =   7095
      Width           =   10635
   End
   Begin VB.TextBox txtDatosAdicionales1 
      DataField       =   "DatosAdicionales1"
      Height          =   285
      Left            =   90
      TabIndex        =   23
      Top             =   6390
      Width           =   10635
   End
   Begin VB.TextBox txtCondicionIva 
      DataField       =   "CondicionIva"
      Height          =   285
      Left            =   90
      TabIndex        =   21
      Top             =   5715
      Width           =   1995
   End
   Begin VB.TextBox txtTelefono2 
      DataField       =   "Telefono2"
      Height          =   285
      Left            =   90
      TabIndex        =   19
      Top             =   4365
      Width           =   10635
   End
   Begin VB.TextBox txtTelefono1 
      DataField       =   "Telefono1"
      Height          =   285
      Left            =   90
      TabIndex        =   17
      Top             =   3690
      Width           =   10635
   End
   Begin VB.TextBox txtProvincia 
      DataField       =   "Provincia"
      Height          =   285
      Left            =   90
      TabIndex        =   15
      Top             =   3030
      Width           =   10635
   End
   Begin VB.TextBox txtCuit 
      Alignment       =   1  'Right Justify
      DataField       =   "Cuit"
      Height          =   285
      Left            =   8640
      TabIndex        =   13
      Top             =   5040
      Width           =   2085
   End
   Begin VB.TextBox txtEmail 
      DataField       =   "Email"
      Height          =   285
      Left            =   2790
      TabIndex        =   11
      Top             =   5040
      Width           =   5235
   End
   Begin VB.TextBox txtCodigoPostal 
      Alignment       =   1  'Right Justify
      DataField       =   "CodigoPostal"
      Height          =   285
      Left            =   90
      TabIndex        =   9
      Top             =   5040
      Width           =   1995
   End
   Begin VB.TextBox txtLocalidad 
      DataField       =   "Localidad"
      Height          =   285
      Left            =   90
      TabIndex        =   7
      Top             =   2355
      Width           =   10635
   End
   Begin VB.TextBox txtDireccion 
      DataField       =   "Direccion"
      Height          =   285
      Left            =   90
      TabIndex        =   5
      Top             =   1680
      Width           =   10635
   End
   Begin VB.TextBox txtDetalleNombre 
      DataField       =   "DetalleNombre"
      Height          =   285
      Left            =   90
      TabIndex        =   3
      Top             =   1005
      Width           =   10635
   End
   Begin VB.TextBox txtNombre 
      DataField       =   "Nombre"
      Height          =   285
      Left            =   90
      TabIndex        =   1
      Top             =   330
      Width           =   10635
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdCodigoIva"
      Height          =   315
      Index           =   3
      Left            =   2205
      TabIndex        =   30
      Tag             =   "DescripcionIva"
      Top             =   5715
      Width           =   2385
      _ExtentX        =   4207
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdCodigoIva"
      Text            =   ""
   End
   Begin VB.Label Label1 
      Caption         =   "Nombre del archivo certificado AFIP p/fact. electronica (s/extension) :"
      Height          =   195
      Index           =   14
      Left            =   5535
      TabIndex        =   32
      Top             =   5445
      Width           =   5145
   End
   Begin VB.Label Label1 
      Caption         =   "Datos adicionales (3) :"
      Height          =   195
      Index           =   13
      Left            =   90
      TabIndex        =   26
      Top             =   7470
      Width           =   1995
   End
   Begin VB.Label Label1 
      Caption         =   "Datos adicionales (2) :"
      Height          =   195
      Index           =   12
      Left            =   90
      TabIndex        =   24
      Top             =   6795
      Width           =   1995
   End
   Begin VB.Label Label1 
      Caption         =   "Datos adicionales (1) :"
      Height          =   195
      Index           =   11
      Left            =   90
      TabIndex        =   22
      Top             =   6090
      Width           =   1995
   End
   Begin VB.Label Label1 
      Caption         =   "Condicion Iva :"
      Height          =   195
      Index           =   10
      Left            =   90
      TabIndex        =   20
      Top             =   5415
      Width           =   1995
   End
   Begin VB.Label Label1 
      Caption         =   "Fax :"
      Height          =   195
      Index           =   9
      Left            =   90
      TabIndex        =   18
      Top             =   4080
      Width           =   1995
   End
   Begin VB.Label Label1 
      Caption         =   "Telefonos :"
      Height          =   195
      Index           =   8
      Left            =   90
      TabIndex        =   16
      Top             =   3405
      Width           =   1995
   End
   Begin VB.Label Label1 
      Caption         =   "Provincia :"
      Height          =   195
      Index           =   7
      Left            =   90
      TabIndex        =   14
      Top             =   2730
      Width           =   1995
   End
   Begin VB.Label Label1 
      Caption         =   "Cuit :"
      Height          =   195
      Index           =   6
      Left            =   8685
      TabIndex        =   12
      Top             =   4770
      Width           =   1995
   End
   Begin VB.Label Label1 
      Caption         =   "Email :"
      Height          =   195
      Index           =   5
      Left            =   2835
      TabIndex        =   10
      Top             =   4770
      Width           =   1995
   End
   Begin VB.Label Label1 
      Caption         =   "Codigo postal :"
      Height          =   195
      Index           =   4
      Left            =   90
      TabIndex        =   8
      Top             =   4755
      Width           =   1995
   End
   Begin VB.Label Label1 
      Caption         =   "Localidad :"
      Height          =   195
      Index           =   3
      Left            =   90
      TabIndex        =   6
      Top             =   2055
      Width           =   1995
   End
   Begin VB.Label Label1 
      Caption         =   "Direccion :"
      Height          =   195
      Index           =   2
      Left            =   90
      TabIndex        =   4
      Top             =   1395
      Width           =   1995
   End
   Begin VB.Label Label1 
      Caption         =   "Adicional nombre :"
      Height          =   195
      Index           =   1
      Left            =   90
      TabIndex        =   2
      Top             =   720
      Width           =   1995
   End
   Begin VB.Label Label1 
      Caption         =   "Nombre completo :"
      Height          =   195
      Index           =   0
      Left            =   90
      TabIndex        =   0
      Top             =   45
      Width           =   1995
   End
End
Attribute VB_Name = "frmEmpresa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Empresa
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long

Private Sub cmd_Click(Index As Integer)

   On Error GoTo Mal
   
   Select Case Index
      Case 0
         Dim est As EnumAcciones
         Dim oControl As Control
   
         With origen.Registro
            For Each oControl In Me.Controls
               If TypeOf oControl Is DataCombo Then
                  If Len(oControl.BoundText) <> 0 Then .Fields(oControl.DataField).Value = oControl.BoundText
               ElseIf TypeOf oControl Is DTPicker Then
                  .Fields(oControl.DataField).Value = oControl.Value
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
   End Select
   
   If Index = 0 Then
      glbArchivoAFIP = txtArchivoAFIP.Text
      If Len(Trim(glbArchivoAFIP)) > 0 Then
         MsgBox "Recuerde que el archivo con el certificado para registracion AFIP debe estar en el " & vbCrLf & _
                  "directorio donde estan las plantillas del sistema", vbInformation
      End If
   End If
   
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
   
   Set oAp = Aplicacion
   Set origen = oAp.Empresas.Item(vNewValue)
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
   
   Set oAp = Nothing

End Property

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set origen = Nothing
   Set oBind = Nothing

End Sub

Private Sub txtArchivoAFIP_GotFocus()

   With txtArchivoAFIP
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtArchivoAFIP_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtArchivoAFIP
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtCodigoPostal_GotFocus()

   With txtCodigoPostal
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoPostal_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCodigoPostal
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtCondicionIva_GotFocus()

   With txtCondicionIva
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCondicionIva_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCondicionIva
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtCuit_GotFocus()

   With txtCuit
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCuit_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtCuit
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtDatosAdicionales1_GotFocus()

   With txtDatosAdicionales1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDatosAdicionales1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDatosAdicionales1
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtDatosAdicionales2_GotFocus()

   With txtDatosAdicionales2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDatosAdicionales2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDatosAdicionales2
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtDatosAdicionales3_GotFocus()

   With txtDatosAdicionales3
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDatosAdicionales3_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDatosAdicionales3
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtDetalleNombre_GotFocus()

   With txtDetalleNombre
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDetalleNombre_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDetalleNombre
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtDireccion_GotFocus()

   With txtDireccion
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDireccion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtDireccion
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtEmail_GotFocus()

   With txtEmail
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtEmail_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtEmail
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtLocalidad_GotFocus()

   With txtLocalidad
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtLocalidad_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtLocalidad
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtNombre_GotFocus()

   With txtNombre
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtNombre
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtProvincia_GotFocus()

   With txtProvincia
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtProvincia_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtProvincia
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtTelefono1_GotFocus()

   With txtTelefono1
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTelefono1_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtTelefono1
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub

Private Sub txtTelefono2_GotFocus()

   With txtTelefono2
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTelefono2_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtTelefono2
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         End If
      End With
   End If

End Sub
