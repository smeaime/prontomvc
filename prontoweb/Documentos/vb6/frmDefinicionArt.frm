VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmDefinicionArt 
   Caption         =   "Definicion de Articulos"
   ClientHeight    =   7065
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10020
   Icon            =   "frmDefinicionArt.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7065
   ScaleWidth      =   10020
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame3 
      Height          =   375
      Left            =   3825
      TabIndex        =   46
      Top             =   4860
      Width           =   1410
      Begin VB.OptionButton Option6 
         Caption         =   "NO"
         Height          =   195
         Left            =   765
         TabIndex        =   48
         Top             =   135
         Width           =   555
      End
      Begin VB.OptionButton Option5 
         Caption         =   "SI"
         Height          =   195
         Left            =   90
         TabIndex        =   47
         Top             =   135
         Width           =   555
      End
   End
   Begin VB.Frame Frame4 
      Height          =   375
      Left            =   3825
      TabIndex        =   43
      Top             =   5310
      Width           =   1410
      Begin VB.OptionButton Option8 
         Caption         =   "NO"
         Height          =   195
         Left            =   765
         TabIndex        =   45
         Top             =   135
         Width           =   555
      End
      Begin VB.OptionButton Option7 
         Caption         =   "SI"
         Height          =   195
         Left            =   90
         TabIndex        =   44
         Top             =   135
         Width           =   555
      End
   End
   Begin VB.Frame Frame5 
      Height          =   375
      Left            =   3825
      TabIndex        =   40
      Top             =   5760
      Width           =   1410
      Begin VB.OptionButton Option10 
         Caption         =   "NO"
         Height          =   195
         Left            =   765
         TabIndex        =   42
         Top             =   135
         Width           =   555
      End
      Begin VB.OptionButton Option9 
         Caption         =   "SI"
         Height          =   195
         Left            =   90
         TabIndex        =   41
         Top             =   135
         Width           =   555
      End
   End
   Begin VB.Frame Frame2 
      Height          =   375
      Left            =   3825
      TabIndex        =   37
      Top             =   4050
      Width           =   1410
      Begin VB.OptionButton Option4 
         Caption         =   "NO"
         Height          =   195
         Left            =   765
         TabIndex        =   39
         Top             =   135
         Width           =   555
      End
      Begin VB.OptionButton Option3 
         Caption         =   "SI"
         Height          =   195
         Left            =   90
         TabIndex        =   38
         Top             =   135
         Width           =   555
      End
   End
   Begin VB.Frame Frame1 
      Height          =   375
      Left            =   3825
      TabIndex        =   34
      Top             =   1710
      Width           =   1410
      Begin VB.OptionButton Option1 
         Caption         =   "SI"
         Height          =   195
         Left            =   90
         TabIndex        =   36
         Top             =   135
         Width           =   555
      End
      Begin VB.OptionButton Option2 
         Caption         =   "NO"
         Height          =   195
         Left            =   765
         TabIndex        =   35
         Top             =   135
         Width           =   555
      End
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "&Imprimir mascaras"
      Height          =   405
      Index           =   4
      Left            =   7920
      TabIndex        =   17
      Top             =   6435
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Copiar &mascaras"
      Height          =   405
      Index           =   3
      Left            =   6120
      TabIndex        =   16
      Top             =   6435
      Width           =   1485
   End
   Begin VB.TextBox txtDespues 
      DataField       =   "Despues"
      Height          =   330
      Left            =   7875
      TabIndex        =   6
      Top             =   2160
      Width           =   1890
   End
   Begin VB.TextBox txtAntes 
      DataField       =   "Antes"
      Height          =   330
      Left            =   7875
      TabIndex        =   4
      Top             =   1755
      Width           =   1890
   End
   Begin VB.TextBox txtEtiqueta 
      DataField       =   "Etiqueta"
      Height          =   330
      Left            =   3825
      TabIndex        =   8
      Top             =   2895
      Width           =   3150
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdRubro"
      Height          =   315
      Index           =   1
      Left            =   3825
      TabIndex        =   1
      Tag             =   "Rubros"
      Top             =   555
      Width           =   5955
      _ExtentX        =   10504
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdRubro"
      Text            =   ""
   End
   Begin VB.TextBox txtOrden 
      DataField       =   "Orden"
      Height          =   330
      Left            =   3825
      TabIndex        =   5
      Top             =   2115
      Width           =   675
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Aceptar"
      Height          =   405
      Index           =   0
      Left            =   630
      TabIndex        =   13
      Top             =   6435
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Cancelar"
      Height          =   405
      Index           =   2
      Left            =   4275
      TabIndex        =   15
      Top             =   6435
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "&Eliminar"
      Height          =   405
      Index           =   1
      Left            =   2475
      TabIndex        =   14
      Top             =   6435
      Width           =   1485
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdSubrubro"
      Height          =   315
      Index           =   2
      Left            =   3825
      TabIndex        =   2
      Tag             =   "Subrubros"
      Top             =   960
      Width           =   5955
      _ExtentX        =   10504
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdSubrubro"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "IdFamilia"
      Height          =   315
      Index           =   3
      Left            =   3825
      TabIndex        =   3
      Tag             =   "Familias"
      Top             =   1365
      Visible         =   0   'False
      Width           =   5955
      _ExtentX        =   10504
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdFamilia"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "UnidadDefault"
      Height          =   315
      Index           =   5
      Left            =   7650
      TabIndex        =   12
      Tag             =   "Unidades"
      Top             =   4455
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   3825
      TabIndex        =   0
      Tag             =   "DefinicionArticulos"
      Top             =   180
      Width           =   5955
      _ExtentX        =   10504
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "Clave"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "Campo"
      Height          =   315
      Index           =   10
      Left            =   3825
      TabIndex        =   7
      Tag             =   "BD_Campos"
      Top             =   2520
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "COLUMN_NAME"
      BoundColumn     =   "COLUMN_NAME"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "TablaCombo"
      Height          =   315
      Index           =   11
      Left            =   3825
      TabIndex        =   9
      Tag             =   "BD_Tablas"
      Top             =   3285
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "TABLE_NAME"
      BoundColumn     =   "TABLE_NAME"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "CampoCombo"
      Height          =   315
      Index           =   12
      Left            =   3825
      TabIndex        =   10
      Top             =   3675
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "COLUMN_NAME"
      BoundColumn     =   "COLUMN_NAME"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      DataField       =   "CampoUnidad"
      Height          =   315
      Index           =   13
      Left            =   3825
      TabIndex        =   11
      Tag             =   "BD_Campos"
      Top             =   4455
      Width           =   3705
      _ExtentX        =   6535
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "COLUMN_NAME"
      BoundColumn     =   "COLUMN_NAME"
      Text            =   ""
   End
   Begin VB.Label lblFieldLabel 
      Caption         =   "Es un campo del tipo SI - NO ?"
      Height          =   300
      Index           =   16
      Left            =   180
      TabIndex        =   49
      Top             =   5805
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Agrega la unidad a la descripcion ? ( Si / No ) :"
      Height          =   300
      Index           =   15
      Left            =   180
      TabIndex        =   33
      Top             =   4905
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Usa la abreviatura del campo unidad ? ( Si / No ) :"
      Height          =   300
      Index           =   14
      Left            =   180
      TabIndex        =   32
      Top             =   5355
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Usa la abreviatura del campo ? ( Si / No ) :"
      Height          =   300
      Index           =   13
      Left            =   180
      TabIndex        =   31
      Top             =   4095
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Poner despues (descripcion) :"
      Height          =   300
      Index           =   12
      Left            =   5670
      TabIndex        =   30
      Top             =   2205
      Width           =   2130
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Poner antes (descripcion) :"
      Height          =   300
      Index           =   11
      Left            =   5670
      TabIndex        =   29
      Top             =   1800
      Width           =   2130
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Campo unidad relacionado (opcional) :"
      Height          =   300
      Index           =   10
      Left            =   180
      TabIndex        =   28
      Top             =   4500
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Etiqueta del campo en la tabla ARTICULOS :"
      Height          =   300
      Index           =   9
      Left            =   180
      TabIndex        =   27
      Top             =   2910
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Nombre del campo relacionado en combo (opc.) :"
      Height          =   300
      Index           =   8
      Left            =   180
      TabIndex        =   26
      Top             =   3690
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Familia : "
      Height          =   300
      Index           =   7
      Left            =   180
      TabIndex        =   25
      Top             =   1350
      Visible         =   0   'False
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Subrubro :"
      Height          =   300
      Index           =   6
      Left            =   180
      TabIndex        =   24
      Top             =   960
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Rubro :"
      Height          =   300
      Index           =   5
      Left            =   180
      TabIndex        =   23
      Top             =   570
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Nombre de la tabla relacionada (opcional) :"
      Height          =   300
      Index           =   4
      Left            =   180
      TabIndex        =   22
      Top             =   3300
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Nombre del campo en la tabla ARTICULOS :"
      Height          =   300
      Index           =   3
      Left            =   180
      TabIndex        =   21
      Top             =   2520
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Numero de orden :"
      Height          =   300
      Index           =   2
      Left            =   180
      TabIndex        =   20
      Top             =   2130
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Acceso rapido a mascaras existentes :"
      Height          =   300
      Index           =   0
      Left            =   180
      TabIndex        =   19
      Top             =   180
      Width           =   3480
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Agrega el campo a la descripcion del articulo ? :"
      Height          =   300
      Index           =   1
      Left            =   180
      TabIndex        =   18
      Top             =   1740
      Width           =   3480
   End
End
Attribute VB_Name = "frmDefinicionArt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.DefinicionArt
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Dim actL2 As ControlForm
Private mvarId As Long
Private def_art() As String
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
   
         Dim est As EnumAcciones
         Dim oControl As Control
         Dim dc As DataCombo
      
         For Each dc In DataCombo1
            If dc.Index = 4 Then
               If Len(Trim(dc.BoundText)) = 0 Then
                  MsgBox "Falta completar el campo " & dc.Tag, vbCritical
                  Exit Sub
               End If
               origen.Registro.Fields(dc.DataField).Value = dc.BoundText
            End If
         Next
      
         For Each oControl In Me.Controls
            If TypeOf oControl Is DataCombo Then
               If Len(oControl.BoundText) <> 0 And oControl.Index <> 0 Then
                  origen.Registro.Fields(oControl.DataField).Value = oControl.BoundText
               End If
            ElseIf TypeOf oControl Is DTPicker Then
               origen.Registro.Fields(oControl.DataField).Value = oControl.Value
            End If
         Next
      
         If Len(DataCombo1(11).Text) > 0 Then
            If Not TablaExistente(DataCombo1(11).Text) Then
               MsgBox "La tabla relacionada no existe, reingrese", vbExclamation
               Exit Sub
            End If
         End If
         
         With origen.Registro
            If Option1.Value Then
               .Fields("AddNombre").Value = "SI"
            Else
               .Fields("AddNombre").Value = "NO"
            End If
            If Option3.Value Then
               .Fields("UsaAbreviatura").Value = "SI"
            Else
               .Fields("UsaAbreviatura").Value = "NO"
            End If
            If Option5.Value Then
               .Fields("AgregaUnidadADescripcion").Value = "SI"
            Else
               .Fields("AgregaUnidadADescripcion").Value = "NO"
            End If
            If Option7.Value Then
               .Fields("UsaAbreviaturaUnidad").Value = "SI"
            Else
               .Fields("UsaAbreviaturaUnidad").Value = "NO"
            End If
            If Option9.Value Then
               .Fields("CampoSiNo").Value = "SI"
            Else
               .Fields("CampoSiNo").Value = "NO"
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
      
         If mvarId < 0 Then
            est = alta
            mvarId = origen.Registro.Fields(0).Value
         Else
            est = Modificacion
         End If
            
         With actL2
            .ListaEditada = "DefinicionesArt,DefinicionesArtTodos,+SubDA1"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
         Unload Me

      Case 1
   
         Dim mBorra As Integer
         mBorra = MsgBox("Esta seguro de eliminar los datos definitivamente ?", vbYesNo, "Eliminar")
         If mBorra = vbNo Then
            Exit Sub
         End If
         
         origen.Eliminar
         
         est = baja
            
         With actL2
            .ListaEditada = "DefinicionesArt"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
         Unload Me

      Case 2
   
         Unload Me

      Case 3
   
         Dim DefArtCopia As ComPronto.DefinicionArt
         Dim mvarErr As String
         Dim ofCopia As frmNuevaDefArt
         
         If Len(Trim(DataCombo1(1).BoundText)) = 0 Then
            mvarErr = mvarErr + "No ha definido el rubro." + vbCrLf
         End If
         
         If Len(Trim(DataCombo1(2).BoundText)) = 0 Then
            mvarErr = mvarErr + "No ha definido el subrubro." + vbCrLf
         End If
         
         If Len(Trim(DataCombo1(3).BoundText)) = 0 Then
            mvarErr = mvarErr + "No ha definido la familia." + vbCrLf
         End If
         
         If Len(Trim(mvarErr)) <> 0 Then
            MsgBox mvarErr, vbCritical
            Exit Sub
         End If
         
         Set ofCopia = New frmNuevaDefArt
   
         With ofCopia
            .Id = 0
            .Show vbModal
            If Not .Cancelado Then
               Dim oAp As ComPronto.Aplicacion
               Dim oRs As ADOR.Recordset
               Dim i As Integer
               Set oAp = Aplicacion
               Set oRs = oAp.DefinicionesArt.Item(.Id).Registro
               For i = 4 To oRs.Fields.Count - 1
                  origen.Registro.Fields(i).Value = oRs.Fields(i).Value
               Next
               Set oAp = Nothing
               Set oRs = Nothing
            End If
         End With
         
         With origen.Registro
            If .Fields("AddNombre").Value = "SI" Then Option1.Value = True
            If .Fields("UsaAbreviatura").Value = "SI" Then Option3.Value = True
            If .Fields("AgregaUnidadADescripcion").Value = "SI" Then Option5.Value = True
            If .Fields("UsaAbreviaturaUnidad").Value = "SI" Then Option7.Value = True
            If .Fields("CampoSiNo").Value = "SI" Then Option9.Value = True
            If IsNull(.Fields("CampoUnidad").Value) Then
'               DataCombo1(5).Enabled = False
               Option6.Value = True
               Option8.Value = True
'               Frame3.Enabled = False
'               Frame4.Enabled = False
            End If
         End With
         
         Unload ofCopia
   
      Case 4
   
         Dim fl As Integer, cl As Integer
         Dim oEx As Excel.Application
         Dim oRsDef As ADOR.Recordset
         Dim oFl As ADODB.Field

         Set oRsDef = Aplicacion.DefinicionesArt.TraerLista
         Set oEx = CreateObject("Excel.Application")

         With oEx

            .Visible = True

            With .Workbooks.Add(glbPathPlantillas & "\Listado.xlt")

               With .ActiveSheet

                  .Name = "Plantillas de def. de articulos"

                  If oRsDef.Fields.Count > 0 Then
                     cl = 1
                     For Each oFl In oRsDef.Fields
                        If cl = 1 Then
                           .Cells(1, cl) = "Item"
                        Else
                           .Cells(1, cl) = oFl.Name
                        End If
                        cl = cl + 1
                     Next
                  End If

                  If oRsDef.RecordCount > 0 Then
                     oRsDef.MoveFirst
                     fl = 2
                     Do While Not oRsDef.EOF
                        cl = 1
                        For Each oFl In oRsDef.Fields
                           If cl = 1 Then
                              .Cells(fl, cl) = fl - 1
                           Else
                              .Cells(fl, cl) = oFl.Value
                           End If
                           cl = cl + 1
                        Next
                        oRsDef.MoveNext
                        fl = fl + 1
                     Loop
                  End If

                  .Range("A1").Select

               End With

               oEx.Run "ArmarFormato"
              .Close False

            End With

            .Quit

         End With

         Set oRsDef = Nothing
         Set oEx = Nothing
         Set oAp = Nothing
         
   End Select
   
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
   
   mvarId = vnewvalue
   
   Set oAp = Aplicacion
   Set origen = oAp.DefinicionesArt.Item(vnewvalue)
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
               If mId(oControl.Tag, 1, 2) = "BD" Then
                  If Trim(mId(oControl.Tag, 4, 10)) = "Campos" Then
                     Set oControl.RowSource = oAp.TablasGenerales.TraerFiltrado("BD", "_Campos", "Articulos")
                  Else
                     Set oControl.RowSource = oAp.TablasGenerales.TraerFiltrado("BD", "_Tablas")
                  End If
               Else
                  Set oControl.RowSource = oAp.CargarLista(oControl.Tag)
               End If
            End If
         Else
            On Error Resume Next
            Set oControl.DataSource = origen
         End If
      Next
   
   End With
   
   Option2.Value = True
   Option4.Value = True
   Option6.Value = True
   Option8.Value = True
   Option10.Value = True
   
   With origen.Registro
      If .Fields("AddNombre").Value = "SI" Then Option1.Value = True
      If .Fields("UsaAbreviatura").Value = "SI" Then Option3.Value = True
      If .Fields("AgregaUnidadADescripcion").Value = "SI" Then Option5.Value = True
      If .Fields("UsaAbreviaturaUnidad").Value = "SI" Then Option7.Value = True
      If .Fields("CampoSiNo").Value = "SI" Then Option9.Value = True
      If IsNull(.Fields("CampoUnidad").Value) Then
'         DataCombo1(5).Enabled = False
         Option6.Value = True
         Option8.Value = True
'         Frame3.Enabled = False
'         Frame4.Enabled = False
      End If
   End With
   
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

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim HayAbreviatura As Boolean
   Dim mvarTabla As String
   
   Select Case Index
      Case 0
         If InStr(1, DataCombo1(0).BoundText, "|") <> 0 Then
            ActualizaCombos (DataCombo1(0).BoundText)
         End If
      Case 11
         If Len(Trim(DataCombo1(11).Text)) <> 0 Then
            If mId(DataCombo1(11).Text, 1, 3) = "Aco" Then
               mvarTabla = mId(DataCombo1(11).Text, 4, Len(DataCombo1(11).Text) - 3)
               If mvarTabla = "Schedulers" Then mvarTabla = "Scheduler"
            Else
               mvarTabla = DataCombo1(11).Text
            End If
            HayAbreviatura = False
'            Set oAp = Aplicacion
            Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("BD", "_Campos", mvarTabla)
            If oRs.Fields.Count > 0 Then
               If oRs.RecordCount > 0 Then
                  oRs.MoveFirst
                  Do While Not oRs.EOF
                     If oRs.Fields("COLUMN_NAME").Value = "Abreviatura" Then
                        HayAbreviatura = True
                        Exit Do
                     End If
                     oRs.MoveNext
                  Loop
               End If
            End If
            Set DataCombo1(12).RowSource = oRs
            Set oRs = Nothing
            Set oAp = Nothing
            If HayAbreviatura Then
               origen.Registro.Fields("UsaAbreviatura").Value = "SI"
               Frame2.Enabled = True
            Else
               origen.Registro.Fields("UsaAbreviatura").Value = "NO"
               Option4.Value = True
               Frame2.Enabled = False
            End If
         Else
            With origen.Registro
               .Fields("CampoCombo").Value = Null
               .Fields("UsaAbreviatura").Value = Null
            End With
            Option4.Value = True
            Frame2.Enabled = False
         End If
      Case 13
         If Len(Trim(DataCombo1(13).Text)) <> 0 Then
            Frame3.Enabled = True
            Frame4.Enabled = True
         Else
'            DataCombo1(5).Enabled = False
            Option6.Value = True
            Option8.Value = True
'            Frame3.Enabled = False
'            Frame4.Enabled = False
            With origen.Registro
               .Fields("UnidadDefault").Value = Null
               .Fields("AgregaUnidadADescripcion").Value = Null
               .Fields("UsaAbreviaturaUnidad").Value = Null
            End With
         End If
   End Select

End Sub

Private Sub DataCombo1_GotFocus(Index As Integer)

   If Index > 0 Then
      SendKeys "%{DOWN}"
   End If
   
   With DataCombo1(Index)
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub Form_Load()

   If mvarId < 0 Then
      cmd(1).Enabled = False
   End If
   origen.Registro.Fields("IdFamilia").Value = 1
   
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

Private Sub Option1_Click()

   If Option1.Value Then
      txtAntes.Enabled = True
      txtDespues.Enabled = True
      Frame2.Enabled = True
      Frame3.Enabled = True
      Frame4.Enabled = True
   End If

End Sub

Private Sub Option2_Click()

   If Option2.Value Then
      txtAntes.Enabled = False
      txtDespues.Enabled = False
      Option4.Value = True
      Option6.Value = True
      Option8.Value = True
      Frame2.Enabled = False
      Frame3.Enabled = False
      Frame4.Enabled = False
   End If

End Sub

Private Sub txtAntes_GotFocus()

   With txtAntes
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtAntes_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      If Len(Trim(txtAntes.Text)) >= origen.Registro.Fields("Antes").DefinedSize And Chr(KeyAscii) <> vbBack Then
         KeyAscii = 0
      End If
   End If

End Sub

Private Sub txtDespues_GotFocus()
   
   With txtDespues
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtDespues_KeyPress(KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      If Len(Trim(txtDespues.Text)) >= origen.Registro.Fields("Despues").DefinedSize And Chr(KeyAscii) <> vbBack Then
         KeyAscii = 0
      End If
   End If

End Sub

Private Sub txtEtiqueta_GotFocus()
   
   With txtEtiqueta
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtEtiqueta_KeyPress(KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      If Len(Trim(txtEtiqueta.Text)) >= origen.Registro.Fields("Etiqueta").DefinedSize And Chr(KeyAscii) <> vbBack Then
         KeyAscii = 0
      End If
   End If

End Sub

Private Sub txtOrden_GotFocus()
   
   With txtOrden
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtOrden_KeyPress(KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtUnidades_KeyPress(KeyAscii As Integer)
   
   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Function ActualizaCombos(mText As String)
         
   Dim mClave
   mClave = Split(mText, "|")
   DataCombo1(1).BoundText = CInt(mClave(0))
   DataCombo1(2).BoundText = CInt(mClave(1))
   DataCombo1(3).BoundText = CInt(mClave(2))

End Function
