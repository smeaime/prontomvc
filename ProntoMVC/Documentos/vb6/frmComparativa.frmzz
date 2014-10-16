VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "msdatlst.ocx"
Begin VB.Form frmComparativa 
   Caption         =   "Comparativa de costos"
   ClientHeight    =   8055
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11145
   Icon            =   "frmComparativa.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   537
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   743
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdLista 
      Caption         =   ">"
      Height          =   195
      Index           =   3
      Left            =   1170
      TabIndex        =   49
      Top             =   945
      Width           =   285
   End
   Begin VB.CommandButton cmdLista 
      Caption         =   "V"
      Height          =   195
      Index           =   2
      Left            =   810
      TabIndex        =   48
      Top             =   945
      Width           =   285
   End
   Begin MSFlexGridLib.MSFlexGrid MSFlexGrid1 
      Height          =   4245
      Left            =   45
      TabIndex        =   10
      Top             =   1170
      Width           =   11040
      _ExtentX        =   19473
      _ExtentY        =   7488
      _Version        =   393216
      Cols            =   5
      FixedRows       =   0
      FixedCols       =   0
      BackColor       =   12648447
      BackColorFixed  =   -2147483638
      WordWrap        =   -1  'True
      AllowUserResizing=   3
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      OLEDropMode     =   1
   End
   Begin VB.CommandButton cmdLista 
      Caption         =   "+"
      Height          =   195
      Index           =   0
      Left            =   90
      TabIndex        =   47
      Top             =   945
      Width           =   285
   End
   Begin VB.CommandButton cmdLista 
      Caption         =   "-"
      Height          =   195
      Index           =   1
      Left            =   450
      TabIndex        =   46
      Top             =   945
      Width           =   285
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   0
      Left            =   5670
      TabIndex        =   37
      Top             =   855
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   1
      Left            =   5895
      TabIndex        =   36
      Top             =   855
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   2
      Left            =   6120
      TabIndex        =   35
      Top             =   855
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   3
      Left            =   6345
      TabIndex        =   34
      Top             =   855
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   4
      Left            =   6570
      TabIndex        =   33
      Top             =   855
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   5
      Left            =   6795
      TabIndex        =   32
      Top             =   855
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CheckBox Check1 
      Enabled         =   0   'False
      Height          =   195
      Index           =   6
      Left            =   7020
      TabIndex        =   31
      Top             =   855
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.CommandButton cmdImpre 
      Height          =   510
      Left            =   9135
      Picture         =   "frmComparativa.frx":076A
      Style           =   1  'Graphical
      TabIndex        =   21
      Top             =   585
      UseMaskColor    =   -1  'True
      Width           =   735
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Ordenar por Articulo"
      Height          =   330
      Index           =   4
      Left            =   7380
      TabIndex        =   9
      Top             =   765
      Width           =   1680
   End
   Begin VB.CommandButton cmdPegar 
      Height          =   510
      Left            =   9135
      Picture         =   "frmComparativa.frx":0CF4
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   45
      UseMaskColor    =   -1  'True
      Width           =   735
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Cancelar"
      Height          =   510
      Index           =   3
      Left            =   9945
      TabIndex        =   7
      Top             =   585
      Width           =   1095
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Aceptar"
      Height          =   510
      Index           =   2
      Left            =   9945
      TabIndex        =   6
      Top             =   45
      Width           =   1095
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Desmarcar todo"
      Height          =   330
      Index           =   1
      Left            =   7380
      TabIndex        =   5
      Top             =   405
      Width           =   1680
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Marcar menor precio"
      Height          =   330
      Index           =   0
      Left            =   7380
      TabIndex        =   4
      Top             =   45
      Width           =   1680
   End
   Begin VB.TextBox txtNumero 
      Alignment       =   1  'Right Justify
      DataField       =   "Numero"
      Enabled         =   0   'False
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
      Left            =   1170
      Locked          =   -1  'True
      TabIndex        =   0
      Top             =   45
      Width           =   1455
   End
   Begin MSComCtl2.DTPicker DTPicker1 
      DataField       =   "Fecha"
      Height          =   330
      Index           =   0
      Left            =   1170
      TabIndex        =   1
      Top             =   405
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   582
      _Version        =   393216
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   62455809
      CurrentDate     =   36432
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdConfecciono"
      Height          =   315
      Index           =   0
      Left            =   4095
      TabIndex        =   22
      Tag             =   "Empleados"
      Top             =   45
      Width           =   3075
      _ExtentX        =   5424
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo dcfields 
      DataField       =   "IdAprobo"
      Height          =   315
      Index           =   1
      Left            =   4095
      TabIndex        =   24
      Tag             =   "Empleados"
      Top             =   405
      Width           =   3075
      _ExtentX        =   5424
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdEmpleado"
      Text            =   ""
   End
   Begin RichTextLib.RichTextBox rchObservaciones 
      Height          =   1230
      Left            =   45
      TabIndex        =   11
      Top             =   6750
      Width           =   5820
      _ExtentX        =   10266
      _ExtentY        =   2170
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmComparativa.frx":1136
   End
   Begin VB.TextBox txtProveedor 
      Height          =   330
      Left            =   1710
      Locked          =   -1  'True
      TabIndex        =   12
      Top             =   5805
      Width           =   3705
   End
   Begin VB.TextBox txtCondiciones 
      Height          =   330
      Left            =   1710
      Locked          =   -1  'True
      TabIndex        =   14
      Top             =   6210
      Width           =   3705
   End
   Begin VB.TextBox txtPlazo 
      Height          =   330
      Left            =   7380
      Locked          =   -1  'True
      TabIndex        =   16
      Top             =   5805
      Width           =   3705
   End
   Begin VB.TextBox txtValidez 
      Height          =   330
      Left            =   7380
      Locked          =   -1  'True
      TabIndex        =   18
      Top             =   6210
      Width           =   3705
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Elegir 1 presupuesto"
      Height          =   600
      Index           =   5
      Left            =   9540
      TabIndex        =   26
      Top             =   6750
      Width           =   1545
   End
   Begin RichTextLib.RichTextBox rchObservacionesItems 
      Height          =   285
      Left            =   4725
      TabIndex        =   27
      Top             =   5490
      Visible         =   0   'False
      Width           =   690
      _ExtentX        =   1217
      _ExtentY        =   503
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"frmComparativa.frx":11B8
   End
   Begin VB.TextBox txtMontoPrevisto 
      Alignment       =   1  'Right Justify
      DataField       =   "MontoPrevisto"
      Height          =   330
      Left            =   9990
      TabIndex        =   28
      Top             =   5445
      Width           =   1095
   End
   Begin VB.TextBox txtMontoParaCompra 
      Alignment       =   1  'Right Justify
      DataField       =   "MontoParaCompra"
      Height          =   330
      Left            =   7380
      TabIndex        =   38
      Top             =   5445
      Width           =   1365
   End
   Begin VB.TextBox txtNumeroRequerimiento 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   5895
      Locked          =   -1  'True
      TabIndex        =   41
      Top             =   7695
      Width           =   3570
   End
   Begin VB.TextBox txtObras 
      Height          =   735
      Left            =   5895
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   43
      Top             =   6750
      Width           =   3570
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Elegir multipresupuesto"
      Height          =   600
      Index           =   6
      Left            =   9540
      TabIndex        =   45
      Top             =   7380
      Width           =   1545
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Autoriz. :"
      Height          =   195
      Index           =   7
      Left            =   4950
      TabIndex        =   30
      Top             =   855
      Width           =   615
   End
   Begin VB.Label lblData 
      Caption         =   "Aprobo :"
      Height          =   240
      Index           =   1
      Left            =   2970
      TabIndex        =   25
      Top             =   450
      Width           =   1035
   End
   Begin VB.Label lblData 
      Caption         =   "Confecciono :"
      Height          =   240
      Index           =   0
      Left            =   2970
      TabIndex        =   23
      Top             =   90
      Width           =   1035
   End
   Begin VB.Label lblFieldLabel 
      AutoSize        =   -1  'True
      Caption         =   "Fecha : "
      Height          =   240
      Index           =   21
      Left            =   90
      TabIndex        =   3
      Top             =   450
      Width           =   990
   End
   Begin VB.Label Label2 
      Caption         =   "Numero :"
      Height          =   240
      Left            =   90
      TabIndex        =   2
      Top             =   90
      Width           =   990
   End
   Begin VB.Label Label3 
      Caption         =   "Observaciones generales :"
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
      TabIndex        =   44
      Top             =   6570
      Width           =   2355
   End
   Begin VB.Label Label1 
      Caption         =   "Numero(s) de RM :"
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
      Left            =   5940
      TabIndex        =   42
      Top             =   7515
      Width           =   1575
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      Caption         =   "Obras :"
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
      Index           =   2
      Left            =   5940
      TabIndex        =   40
      Top             =   6570
      Width           =   630
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Monto para compra :"
      Height          =   285
      Index           =   4
      Left            =   5760
      TabIndex        =   39
      Top             =   5490
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Monto previsto :"
      Height          =   285
      Index           =   6
      Left            =   8820
      TabIndex        =   29
      Top             =   5490
      Width           =   1170
   End
   Begin VB.Label lblPresupuesto 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   90
      TabIndex        =   20
      Top             =   5490
      Width           =   4320
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Validez de la oferta :"
      Height          =   240
      Index           =   2
      Left            =   5760
      TabIndex        =   19
      Top             =   6255
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Plazo de entrega :"
      Height          =   285
      Index           =   1
      Left            =   5760
      TabIndex        =   17
      Top             =   5850
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Condiciones compra :"
      Height          =   285
      Index           =   0
      Left            =   90
      TabIndex        =   15
      Top             =   6210
      Width           =   1575
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      Caption         =   "Provedor :"
      Height          =   285
      Index           =   3
      Left            =   90
      TabIndex        =   13
      Top             =   5850
      Width           =   1575
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar fila"
         Index           =   0
      End
   End
End
Attribute VB_Name = "frmComparativa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WithEvents origen As ComPronto.Comparativa
Attribute origen.VB_VarHelpID = -1
Dim WithEvents oBind As BindingCollection
Attribute oBind.VB_VarHelpID = -1
Private mvarId As Long, mIdAprobo As Long
Private mvarGrabado As Boolean, mvarCerrado As Boolean
Private mTop As Long, mLeft As Long, mHeight As Long, mWidth As Long
Dim actL2 As ControlForm
Const Marcado = &HC0E0FF
Const Desmarcado = &HC0FFFF
Const ColumnaSeleccionada = &HFFC0C0
Const ColumnaNoSeleccionada = &HE0E0E0
Const ColumnaEscogida = &HC0FFC0
Const ColumnasFijas = 7
Private mMatriz As Variant
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

   Dim i As Integer, j As Integer, fl As Integer, cl As Integer
   Dim dc As DataCombo
   Dim dtp As DTPicker
   Dim mvarPresu As Long, mvarSubNum As Long
   Dim mNum As Long
   Dim oPar As ComPronto.Parametro

   Select Case Index
      
      Case 0
   
         CalculaFlex
         MejorPrecio
         Exit Sub
         
      Case 1
         
         DesmarcarTodo
         Exit Sub
         
      Case 2
      
         Dim est As EnumAcciones
         Dim oRs As ADOR.Recordset
         Dim Artic As Long
         Dim mvarImprime As Integer
         
         With origen.Registro
            For Each dc In dcfields
               If dc.Enabled Then
                  If Len(Trim(dc.BoundText)) = 0 And dc.Index <> 1 Then
                     MsgBox "Falta completar el campo " & lblData(dc.Index).Caption, vbCritical
                     Exit Sub
                  End If
                  If Len(Trim(dc.BoundText)) <> 0 Then
                     .Fields(dc.DataField).Value = dc.BoundText
                  End If
               End If
            Next
            For Each dtp In DTPicker1
               .Fields(dtp.DataField).Value = dtp.Value
            Next
            .Fields("Observaciones").Value = rchObservaciones.Text
         End With
         
         If MSFlexGrid1.Cols = 5 Then
            MsgBox "No hay presupuestos en la comparativa", vbExclamation
            Exit Sub
         End If

         Me.MousePointer = vbHourglass
      
         mMatriz = origen.DetComparativas.MatrizId
         
         With MSFlexGrid1
            For cl = ColumnasFijas To .Cols - 1
               mvarPresu = Val(mId(.TextMatrix(0, cl), 13, 6))
               mvarSubNum = Val(mId(.TextMatrix(0, cl), 22, 2))
               For fl = 1 To .Rows - 8
                  Artic = Val(.TextMatrix(fl, 0))
                  .row = fl
                  .col = cl
                  If mMatriz(fl, cl) <> 0 Then
                     If .CellFontBold Then
                        origen.DetComparativas.Item(mMatriz(fl, cl)).Registro.Fields("Estado") = "MR"
                     Else
                        origen.DetComparativas.Item(mMatriz(fl, cl)).Registro.Fields("Estado") = "  "
                     End If
                     origen.DetComparativas.Item(mMatriz(fl, cl)).Modificado = True
                  End If
               Next
            Next
         End With
         
         If mvarId < 0 Then
            Set oPar = Aplicacion.Parametros.Item(1)
            With oPar.Registro
               mNum = .Fields("ProximaComparativa").Value
               origen.Registro.Fields("Numero").Value = mNum
               .Fields("ProximaComparativa").Value = mNum + 1
            End With
            oPar.Guardar
            Set oPar = Nothing
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
            
         With actL2
            .ListaEditada = "Comparativas"
            .AccionRegistro = est
            .Disparador = mvarId
         End With
   
         Me.MousePointer = vbDefault
      
         mvarImprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de Comparativa")
         If mvarImprime = vbYes Then
            cmdImpre_Click
         End If
      
      Case 4
         
         With MSFlexGrid1
            If .Rows > 3 Then
               .col = 5
               .row = 1
               .RowSel = .Rows - 8
               .Sort = flexSortGenericAscending
               .col = 1
               .row = 1
            End If
         End With
      
         Exit Sub
         
      Case 5
         
         For Each dc In dcfields
            If Not IsNumeric(dc.BoundText) Then
               MsgBox "Falta definir quien " & mId(dc.DataField, 3, 20), vbCritical
               Exit Sub
            End If
         Next
         
         With MSFlexGrid1
            If .row <> 0 Then
               MsgBox "Primero debe elegir el presupuesto (Columna elegida, fila 1)" & vbCrLf & _
                        "con un click del mouse", vbExclamation
               Exit Sub
            End If
            If .col >= ColumnasFijas Then
               mvarPresu = Val(mId(.TextArray(PosCelda(0, .col)), 13, 6))
               mvarSubNum = Val(mId(.TextArray(PosCelda(0, .col)), 22, 2))
               fl = 1
               cl = .col
               For i = ColumnasFijas To .Cols - 1
                  .col = i
                  .CellBackColor = ColumnaNoSeleccionada
               Next
               .col = cl
               .CellBackColor = ColumnaEscogida
               If EsPrecio(cl) Then
                  .col = cl + 1
                  .CellBackColor = ColumnaEscogida
               Else
                  .col = cl - 1
                  .CellBackColor = ColumnaEscogida
               End If
            End If
         End With
         
         With origen.Registro
            .Fields("PresupuestoSeleccionado").Value = mvarPresu
            .Fields("SubNumeroSeleccionado").Value = mvarSubNum
         End With
         
         cmd(0).Enabled = False
         cmd(1).Enabled = False
         cmd(4).Enabled = False
         cmd(5).Enabled = False
         cmd(6).Enabled = False
         cmdPegar.Enabled = False
         rchObservaciones.Enabled = False
         For Each dtp In DTPicker1
            dtp.Enabled = False
         Next
         For Each dc In dcfields
            dc.Enabled = False
         Next
         mvarCerrado = True
         
         Exit Sub
         
      Case 6
         
         For Each dc In dcfields
            If Not IsNumeric(dc.BoundText) Then
               MsgBox "Falta definir quien " & mId(dc.DataField, 3, 20), vbCritical
               Exit Sub
            End If
         Next
         
         Dim mConPrecio As Boolean
         
         With MSFlexGrid1
            For fl = 1 To .Rows - 8
               mConPrecio = False
               .row = fl
               For cl = ColumnasFijas To .Cols - 1
                  .col = cl
                  If .CellBackColor = Marcado Then
                     mConPrecio = True
                     Exit For
                  End If
               Next
               If Not mConPrecio Then
                  MsgBox "La fila " & fl & " de la comparativa no tiene precio seleccionado", vbExclamation
                  Exit Sub
               End If
            Next
         End With
         
         With origen.Registro
            .Fields("PresupuestoSeleccionado").Value = -1
            .Fields("SubNumeroSeleccionado").Value = -1
         End With
         
         cmd(0).Enabled = False
         cmd(1).Enabled = False
         cmd(4).Enabled = False
         cmd(5).Enabled = False
         cmd(6).Enabled = False
         cmdPegar.Enabled = False
         rchObservaciones.Enabled = False
         For Each dtp In DTPicker1
            dtp.Enabled = False
         Next
         For Each dc In dcfields
            dc.Enabled = False
         Next
         mvarCerrado = True
         
         Exit Sub
         
   End Select
   
   Unload Me

End Sub

Public Property Let Id(ByVal vNewValue As Long)

   Dim oControl As Control
   Dim oAp As ComPronto.Aplicacion
   Dim oPar As ComPronto.Parametro
   Dim oRs As ADOR.Recordset
   Dim oRsAut As ADOR.Recordset
   Dim dtf As DTPicker
   Dim dc As DataCombo
   Dim dtp As DTPicker
   Dim i As Integer, mCantidadFirmas As Integer
   
   mvarId = vNewValue
   
   Set oAp = Aplicacion
   Set origen = oAp.Comparativas.Item(vNewValue)
   
   Set oBind = New BindingCollection
   
   With oBind
      
      Set .DataSource = origen
      
      For Each oControl In Me.Controls
         If TypeOf oControl Is CommandButton Then
'         ElseIf TypeOf oControl Is MSFlexGrid Then
'            Dim oDet As ComPronto.DetComparativa
'            Set oRs = origen.DetComparativas.TraerTodos
'            Do While Not oRs.EOF
'               Set oDet = origen.DetComparativas.Item(oRs.Fields("IdDetalleComparativa").Value)
'               Set oDet = Nothing
'               oRs.MoveNext
'            Loop
'            oRs.Close
'            Set oRs = origen.DetComparativas.TodosLosRegistrosConFormato
'            Set oControl.DataSource = oRs
'
'            oRs.Close
'            Set oRs = Nothing
         ElseIf TypeOf oControl Is Label Then
            If Len(oControl.DataField) Then .Add oControl, "Caption", oControl.DataField
         ElseIf TypeOf oControl Is RichTextBox Then
            If Len(oControl.DataField) Then .Add oControl, "textRTF", oControl.DataField
         ElseIf TypeOf oControl Is DataCombo Then
            If Len(oControl.DataField) Then Set oControl.DataSource = origen
            If Len(oControl.Tag) Then
               If oControl.Tag = "Empleados" Then
                  Set oControl.RowSource = oAp.Empleados.TraerFiltrado("_PorSector", "Compras")
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
   
   Dim oDet As ComPronto.DetComparativa
   Set oRs = origen.DetComparativas.TraerTodos
   Do While Not oRs.EOF
      Set oDet = origen.DetComparativas.Item(oRs.Fields("IdDetalleComparativa").Value)
      oDet.Modificado = True
      Set oDet = Nothing
      oRs.MoveNext
   Loop
   oRs.Close
   Set oRs = origen.DetComparativas.TodosLosRegistrosConFormato
   CargaFlex oRs
   oRs.Close
   Set oRs = Nothing
   
   Check1(0).Visible = True
   
   If mvarId = -1 Then
      For Each dtf In DTPicker1
         dtf.Value = Date
      Next
      Set oPar = Aplicacion.Parametros.Item(1)
      With origen.Registro
         .Fields("Numero").Value = oPar.Registro.Fields("ProximaComparativa").Value
         .Fields("PorcentajeIva1").Value = oPar.Registro.Fields("Iva1").Value
         .Fields("PorcentajeIva2").Value = oPar.Registro.Fields("Iva2").Value
         .Fields("IdConfecciono").Value = glbIdUsuario
      End With
      Set oPar = Nothing
      mvarGrabado = False
      mvarCerrado = False
      mIdAprobo = 0
   Else
'      If Not IsNull(origen.Registro.Fields("PresupuestoSeleccionado").Value) Then
'         cmd(0).Enabled = False
'         cmd(1).Enabled = False
'         cmd(2).Enabled = False
'         cmd(4).Enabled = False
'         cmd(5).Enabled = False
'         cmdPegar.Enabled = False
'         rchObservaciones.Enabled = False
'         For Each DTP In DTPicker1
'            DTP.Enabled = False
'         Next
'         For Each dc In dcfields
'            dc.Enabled = False
'         Next
'         mvarCerrado = True
'      Else
         mvarCerrado = False
'      End If
      
      With origen.Registro
         If Not IsNull(.Fields("IdAprobo").Value) Then
            Check1(0).Value = 1
            mIdAprobo = .Fields("IdAprobo").Value
         End If
         rchObservaciones.TextRTF = IIf(IsNull(.Fields("Observaciones").Value), "", .Fields("Observaciones").Value)
      End With
      mCantidadFirmas = 0
      Set oRsAut = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(EnumFormularios.Comparativa, 0))
      If Not oRsAut Is Nothing Then
         If oRsAut.RecordCount > 0 Then
            oRsAut.MoveFirst
            Do While Not oRsAut.EOF
               mCantidadFirmas = mCantidadFirmas + 1
               Check1(mCantidadFirmas).Visible = True
               Check1(mCantidadFirmas).Tag = oRsAut.Fields(0).Value
               oRsAut.MoveNext
            Loop
         End If
         oRsAut.Close
      End If
      Set oRsAut = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(EnumFormularios.Comparativa, mvarId))
      If oRsAut.RecordCount > 0 Then
         oRsAut.MoveFirst
         Do While Not oRsAut.EOF
            For i = 1 To mCantidadFirmas
               If Check1(i).Tag = oRsAut.Fields("OrdenAutorizacion").Value Then
                  Check1(i).Value = 1
                  Exit For
               End If
            Next
            oRsAut.MoveNext
         Loop
      End If
      oRsAut.Close
      Set oRsAut = Nothing
      mvarGrabado = True
   End If
   
   cmd(2).Enabled = False
   If Me.NivelAcceso = Medio Then
      If mvarId <= 0 Then cmd(2).Enabled = True
   ElseIf Me.NivelAcceso = Alto Then
      cmd(2).Enabled = True
   End If
   
   Set oAp = Nothing

End Property

Public Property Let Disparar(ByVal actl1 As ControlForm)
   
   Set Disparar = actl1
   
End Property

Public Property Set Disparar(ByVal actl1 As ControlForm)
   
   Set actL2 = actl1
   
End Property

Private Sub cmdImpre_Click()
   
   If Not mvarGrabado Then
      MsgBox "Antes de imprimir debe grabar la comparativa!", vbCritical
      Exit Sub
   End If
   
   Dim mPlantilla As String
   mPlantilla = glbPathPlantillas & "\Comparativa_" & glbEmpresaSegunString & ".xlt"
   If Len(Dir(mPlantilla)) = 0 Then
      mPlantilla = glbPathPlantillas & "\Comparativa.xlt"
      If Len(Dir(mPlantilla)) = 0 Then
         MsgBox "Plantilla " & mPlantilla & " inexistente", vbExclamation
         Exit Sub
      End If
   End If
   
   Dim oF As frmCopiasImpresion
   Dim mFormulario As String
   Dim mvarOK As Boolean
   Set oF = New frmCopiasImpresion
   With oF
      .txtCopias.Visible = False
      .lblCopias.Visible = False
      With .Option1
         .Caption = "A4"
         .Value = True
      End With
      .Option2.Caption = "A3"
      .Show vbModal, Me
      mFormulario = "A4"
      If .Option2.Value Then mFormulario = "A3"
      mvarOK = .Ok
   End With
   Unload oF
   Set oF = Nothing
   If Not mvarOK Then Exit Sub
   
   Dim oEx As Excel.Application
   Dim oAp As ComPronto.Aplicacion
   Dim oRsPre As ADOR.Recordset
   Dim oRsEmp As ADOR.Recordset
   Dim i As Integer, cl As Integer, cl1 As Integer, fl As Integer
   Dim mvarPresu As Long, mvarSubNum As Long
   Dim mvarFecha As Date
   Dim mvarConfecciono As String, mvarAprobo As String, mvarMPrevisto As String, mvarMCompra As String, mvarMoneda As String
   Dim mvarLibero As String
   Dim mvarPrecioIdeal As Double, mvarPrecioReal As Double
   Dim mCabecera
   
   Set oAp = Aplicacion
   
   With origen.Registro
      mvarPresu = .Fields("Numero").Value
      mvarFecha = .Fields("Fecha").Value
      If IsNull(.Fields("IdConfecciono").Value) Then
         mvarConfecciono = ""
      Else
         mvarConfecciono = oAp.Empleados.Item(.Fields("IdConfecciono").Value).Registro.Fields("Nombre").Value
      End If
      If IsNull(.Fields("IdAprobo").Value) Then
         mvarAprobo = ""
      Else
         mvarAprobo = oAp.Empleados.Item(.Fields("IdAprobo").Value).Registro.Fields("Nombre").Value
      End If
      If IsNull(.Fields("MontoPrevisto").Value) Then
         mvarMPrevisto = ""
      Else
         mvarMPrevisto = Format(.Fields("MontoPrevisto").Value, "Fixed")
      End If
      If IsNull(.Fields("MontoParaCompra").Value) Then
         mvarMCompra = ""
      Else
         mvarMCompra = Format(.Fields("MontoParaCompra").Value, "Fixed")
      End If
   End With
   
'   Me.MousePointer = vbHourglass
'   On Error GoTo Mal
   
   Set oEx = CreateObject("Excel.Application")
   
   With oEx
      .Visible = True
      With .Workbooks.Add(mPlantilla)
         With .ActiveSheet
            .Name = "Comparativa"
            
            cl1 = 0
            For cl = 1 To MSFlexGrid1.Cols - 1
               If MSFlexGrid1.ColWidth(cl) > 20 Then
                  cl1 = cl1 + 1
                  MSFlexGrid1.col = cl
                  If cl >= ColumnasFijas Then
'                     If EsPrecio(cl) Then
'                        .Columns(cl1).ColumnWidth = 30
'                     Else
                        .Columns(cl1).ColumnWidth = 12
'                     End If
                  End If
                  For fl = 0 To MSFlexGrid1.Rows - 1
                     MSFlexGrid1.row = fl
                     If fl = 0 Then
                        'Ampliar altura de fila de cabeceras de columna
                        If cl1 > 4 Then
                           If cl1 Mod 2 = 1 Then
                              mCabecera = VBA.Split(MSFlexGrid1.Text, vbCrLf)
                              .Cells(fl + 7, cl1) = mCabecera(1)
                              .Cells(fl + 7, cl1).Font.Bold = True
                              .Cells(fl + 9, cl1) = "Unitario " & mCabecera(2)
                              .Cells(fl + 9, cl1 + 1) = "Total " & mCabecera(2)
                              mvarMoneda = mCabecera(2)
                              .Range(oEx.Cells(fl + 7, cl1), oEx.Cells(fl + 7, cl1 + 1)).Select
                              With oEx.Selection
                                  .HorizontalAlignment = xlCenter
                                  .VerticalAlignment = xlCenter
                                  .WrapText = True
                                  .Orientation = 0
                                  .AddIndent = False
                                  .IndentLevel = 0
                                  .ShrinkToFit = False
                                  .MergeCells = True
                              End With
                              .Range(oEx.Cells(fl + 8, cl1), oEx.Cells(fl + 8, cl1 + 1)).Select
                              With oEx.Selection
                                  .HorizontalAlignment = xlCenter
                                  .VerticalAlignment = xlCenter
                                  .WrapText = True
                                  .Orientation = 0
                                  .AddIndent = False
                                  .IndentLevel = 0
                                  .ShrinkToFit = False
                                  .MergeCells = True
                              End With
                              oEx.ActiveCell.FormulaR1C1 = "Precio"
                           End If
                        Else
                           .Cells(fl + 7, cl1) = MSFlexGrid1.Text
                        End If
                        'Modifica color de fondo de cabeceras de columna
'                        .Range(oEx.Cells(fl + 7, cl1), oEx.Cells(fl + 9, cl1)).Select
'                        With oEx.Selection.Interior
'                           MSFlexGrid1.col = cl
'                           If MSFlexGrid1.CellBackColor = ColumnaEscogida Then
'                              .ColorIndex = 36
'                              .Pattern = xlSolid
'                           Else
'                              .ColorIndex = 15
'                              .Pattern = xlSolid
'                           End If
'                        End With
                     Else
                        If MSFlexGrid1.row = MSFlexGrid1.Rows - 2 Then
                           rchObservacionesItems.TextRTF = MSFlexGrid1.Text
                           .Cells(fl + 9, cl1) = rchObservacionesItems.Text
                        Else
                           .Cells(fl + 9, cl1) = MSFlexGrid1.Text
                        End If
                     End If
                     'Modifica formato de celdas con precios comparados
                     If cl1 >= ColumnasFijas - 2 And fl > 0 And IsNumeric(MSFlexGrid1.Text) Then
                        MSFlexGrid1.col = cl
                        If MSFlexGrid1.CellBackColor = Marcado Then
                           .Cells(fl + 9, cl1).Font.Bold = True
                        End If
                        If fl >= MSFlexGrid1.Rows - 7 Then
                           .Cells(fl + 9, cl1).NumberFormat = "#,##0.00"
                        Else
                           .Cells(fl + 9, cl1).NumberFormat = "#,##0.0000"
                        End If
                     End If
                  Next
               End If
            Next
            
            .Cells(2, 5) = "COMPARATIVA Nro. : " & mvarPresu
            .Cells(3, 5) = "FECHA : " & mvarFecha
            .Cells(4, 5) = "Comprador/a : " & mvarConfecciono
            .Cells(5, 2) = "Obra/s : " & txtObras.Text
            .Cells(6, 2) = "RM / LA : " & txtNumeroRequerimiento.Text
'            .Cells(5, 5) = "Aprobo      : " & mvarAprobo
'            .Cells(6, 5) = "Monto previsto : " & mvarMPrevisto
            
            .Cells(MSFlexGrid1.Rows + 10, 1).Select
            .Rows(MSFlexGrid1.Rows + 10).RowHeight = 25
            .Cells(MSFlexGrid1.Rows + 10, 1) = "Obs.Grales. : " & rchObservaciones.Text
            
            .Cells(MSFlexGrid1.Rows + 11, 1).Select
            .Rows(MSFlexGrid1.Rows + 11).RowHeight = 10
            .Cells(MSFlexGrid1.Rows + 11, 1) = "Monto previsto : " & mvarMoneda & " " & mvarMPrevisto
            
            .Cells(MSFlexGrid1.Rows + 12, 1).Select
            .Rows(MSFlexGrid1.Rows + 12).RowHeight = 10
            .Cells(MSFlexGrid1.Rows + 12, 1) = "Monto para compra : " & mvarMoneda & " " & mvarMCompra
            
            cl1 = 0
            For cl = 1 To MSFlexGrid1.Cols - 1
               If MSFlexGrid1.ColWidth(cl) > 20 Then
                  cl1 = cl1 + 1
                  If cl1 > 4 And cl1 Mod 2 = 1 Then
                     .Range(oEx.Cells(MSFlexGrid1.Rows + 5, cl1), oEx.Cells(MSFlexGrid1.Rows + 5, cl1 + 1)).Select
                     With oEx.Selection
                         .HorizontalAlignment = xlCenter
                         .VerticalAlignment = xlCenter
                         .WrapText = True
                         .AddIndent = False
                         .MergeCells = True
                     End With
                     .Range(oEx.Cells(MSFlexGrid1.Rows + 6, cl1), oEx.Cells(MSFlexGrid1.Rows + 6, cl1 + 1)).Select
                     With oEx.Selection
                         .HorizontalAlignment = xlCenter
                         .VerticalAlignment = xlCenter
                         .WrapText = True
                         .AddIndent = False
                         .MergeCells = True
                     End With
                     .Range(oEx.Cells(MSFlexGrid1.Rows + 7, cl1), oEx.Cells(MSFlexGrid1.Rows + 7, cl1 + 1)).Select
                     With oEx.Selection
                         .HorizontalAlignment = xlLeft
                         .VerticalAlignment = xlCenter
                         .WrapText = True
                         .AddIndent = False
                         .MergeCells = True
                     End With
                     .Range(oEx.Cells(MSFlexGrid1.Rows + 8, cl1), oEx.Cells(MSFlexGrid1.Rows + 8, cl1 + 1)).Select
                     With oEx.Selection
                         .HorizontalAlignment = xlCenter
                         .VerticalAlignment = xlCenter
                         .WrapText = True
                         .AddIndent = False
                         .MergeCells = True
                     End With
                  End If
               End If
            Next
            
            mvarLibero = ""
            If Not IsNull(origen.Registro.Fields("IdAprobo").Value) Then
               Set oRsEmp = Aplicacion.Empleados.Item(origen.Registro.Fields("IdAprobo").Value).Registro
               If Not IsNull(oRsEmp.Fields("Iniciales").Value) Then
                  mvarLibero = "" & oRsEmp.Fields("Iniciales").Value
                  If Not IsNull(origen.Registro.Fields("FechaAprobacion").Value) Then
                     mvarLibero = mvarLibero & "  " & origen.Registro.Fields("FechaAprobacion").Value
                  End If
               End If
               oRsEmp.Close
            End If

            oEx.Rows(MSFlexGrid1.Rows + 6).RowHeight = 25
            oEx.Rows(MSFlexGrid1.Rows + 7).RowHeight = 25
            oEx.Run "ArmarFormato", glbStringConexion, mvarId, mvarLibero, glbPathPlantillas, glbEmpresaSegunString, mFormulario
         End With
      
         If BuscarClaveINI("Agregar hoja adicional en comparativas") = "SI" Then
            .Sheets("Hoja2").Select
            With .ActiveSheet
               .Name = "Real Vs Ideal"
               
               .Columns("A:A").ColumnWidth = 5
               .Columns("B:B").ColumnWidth = 60
               
               .Cells(7, 2) = "Material"
               .Cells(7, 3) = "Precio ideal"
               .Cells(7, 4) = "Precio real"
               .Range(.Cells(7, 2), .Cells(7, 4)).Select
               oEx.Selection.Font.Bold = True
               
               For fl = 1 To MSFlexGrid1.Rows - 8
                  .Cells(fl + 9, 2) = MSFlexGrid1.TextMatrix(fl, 2)
                  .Cells(fl + 9, 2).WrapText = True
                  MSFlexGrid1.row = fl
                  mvarPrecioIdeal = 0
                  mvarPrecioReal = 0
                  For cl = ColumnasFijas To MSFlexGrid1.Cols - 1
                     MSFlexGrid1.col = cl
                     If MSFlexGrid1.CellPicture <> 0 Then mvarPrecioIdeal = Val(MSFlexGrid1.Text)
                     If MSFlexGrid1.CellBackColor = Marcado Then mvarPrecioReal = Val(MSFlexGrid1.Text)
                  Next
                  If mvarPrecioReal = 0 Then
                     For cl = ColumnasFijas To MSFlexGrid1.Cols - 1
                        MSFlexGrid1.col = cl
                        If Val(mId(MSFlexGrid1.TextMatrix(0, cl), 13, 6)) = origen.Registro.Fields("PresupuestoSeleccionado").Value And _
                              Val(mId(MSFlexGrid1.TextMatrix(0, cl), 22, 2)) = origen.Registro.Fields("SubNumeroSeleccionado").Value Then
                           mvarPrecioReal = Val(MSFlexGrid1.Text)
                           Exit For
                        End If
                     Next
                  End If
                  .Cells(fl + 9, 3) = mvarPrecioIdeal
                  .Cells(fl + 9, 3).NumberFormat = "#,##0.0000"
                  .Cells(fl + 9, 4) = mvarPrecioReal
                  .Cells(fl + 9, 4).NumberFormat = "#,##0.0000"
               Next
               
               .Cells(fl + 9, 3) = "=SUM(R[-" & Trim(Str(fl - 1)) & "]C[]:R[-1]C[])"
               .Cells(fl + 9, 4) = "=SUM(R[-" & Trim(Str(fl - 1)) & "]C[]:R[-1]C[])"
               
               .Cells(2, 5) = "COMPARATIVA Nro. : " & mvarPresu
               .Cells(3, 5) = "FECHA : " & mvarFecha
               .Cells(4, 5) = "Comprador/a : " & mvarConfecciono
               .Cells(5, 2) = "Obra/s : " & txtObras.Text
               .Cells(6, 2) = "RM / LA : " & txtNumeroRequerimiento.Text
            
               .Range(.Cells(7, 2), .Cells(fl + 9 - 1, 4)).Select
               With oEx.Selection.Borders(xlEdgeLeft)
                   .LineStyle = xlContinuous
                   .Weight = xlThin
                   .ColorIndex = xlAutomatic
               End With
               With oEx.Selection.Borders(xlEdgeTop)
                   .LineStyle = xlContinuous
                   .Weight = xlThin
                   .ColorIndex = xlAutomatic
               End With
               With oEx.Selection.Borders(xlEdgeBottom)
                   .LineStyle = xlContinuous
                   .Weight = xlThin
                   .ColorIndex = xlAutomatic
               End With
               With oEx.Selection.Borders(xlEdgeRight)
                   .LineStyle = xlContinuous
                   .Weight = xlThin
                   .ColorIndex = xlAutomatic
               End With
               With oEx.Selection.Borders(xlInsideVertical)
                   .LineStyle = xlContinuous
                   .Weight = xlThin
                   .ColorIndex = xlAutomatic
               End With
               With oEx.Selection.Borders(xlInsideHorizontal)
                   .LineStyle = xlContinuous
                   .Weight = xlThin
                   .ColorIndex = xlAutomatic
               End With
               .Cells(1, 1).Select
            End With
            
            .Sheets("Comparativa").Select
         End If
      End With
   End With
         
'   With MSFlexGrid1
'      .row = 0
'      For cl = 5 To .Cols - 1
'         .col = cl
'         mvarPresu = Val(Mid(.TextArray(PosCelda(0, .col)), 13, 6))
'         mvarSubNum = Val(Mid(.TextArray(PosCelda(0, .col)), 22, 2))
'         Set oRsPre = oAp.Presupuestos.TraerFiltrado("_PorNumero", Array(mvarPresu, mvarSubNum))
'         If oRsPre.Fields.Count > 0 Then
'            If oRsPre.RecordCount > 0 Then
'               oW.Selection.MoveRight Unit:=wdCell
'               oW.Selection.TypeText Text:="" & oRsPre.Fields("Numero").Value & " del " & oRsPre.Fields("FechaIngreso").Value
'               If mvarCerrado And origen.Registro.Fields("PresupuestoSeleccionado").Value = mvarPresu Then
''                        oW.Selection.Shading.BackgroundPatternColor = 14277081
'               End If
'               oW.Selection.MoveRight Unit:=wdCell
'               oW.Selection.TypeText Text:="" & oAp.Proveedores.Item(oRsPre.Fields("IdProveedor").Value).Registro.Fields("RazonSocial").Value
'               oW.Selection.MoveRight Unit:=wdCell
'               oW.Selection.TypeText Text:="" & oAp.CondicionesCompra.Item(oRsPre.Fields("IdCondicionCompra").Value).Registro.Fields("Descripcion").Value
'               oW.Selection.MoveRight Unit:=wdCell
'               oW.Selection.TypeText Text:="" & IIf(IsNull(oRsPre.Fields("Plazo").Value), "", oRsPre.Fields("Plazo").Value)
'               oW.Selection.MoveRight Unit:=wdCell
'               oW.Selection.TypeText Text:="" & IIf(IsNull(oRsPre.Fields("Validez").Value), "", oRsPre.Fields("Validez").Value)
'            End If
'            oRsPre.Close
'         End If
'      Next
'   End With
'   oW.ActiveDocument.FormFields("Numero").Result = origen.Registro.Fields("Numero").Value
'   oW.ActiveDocument.FormFields("Fecha").Result = origen.Registro.Fields("Fecha").Value
'   oW.ActiveDocument.FormFields("Confecciono").Result = dcfields(0).Text
'   oW.ActiveDocument.FormFields("Aprobo").Result = dcfields(1).Text
          
   GoTo Salida
   
Mal:

   oEx.Quit
   Me.MousePointer = vbDefault
   MsgBox "Se ha producido un error al imprimir ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical

Salida:

   Me.MousePointer = vbDefault
   Set oEx = Nothing
   Set oRsPre = Nothing
   Set oRsEmp = Nothing
   Set oAp = Nothing

End Sub

Private Sub cmdLista_Click(Index As Integer)

   If mTop = 0 Then
      With MSFlexGrid1
         mTop = .Top
         mLeft = .Left
         mWidth = .Width
         mHeight = .Height
      End With
   End If
   
   If Index = 0 Then
      With MSFlexGrid1
         .Height = mHeight * 1.61
         '.Width = Me.ScaleWidth - 100
      End With
   ElseIf Index = 1 Then
      With MSFlexGrid1
         .Top = mTop
         .Left = mLeft
         .Width = mWidth
         .Height = mHeight
      End With
   ElseIf Index = 2 Then
      With MSFlexGrid1
         .Height = .Height * 1.05
      End With
   ElseIf Index = 3 Then
      With MSFlexGrid1
         .Width = .Width * 1.05
      End With
   End If

End Sub

Private Sub dcfields_Change(Index As Integer)

   If IsNumeric(dcfields(Index).BoundText) Then
      origen.Registro.Fields(dcfields(Index).DataField).Value = dcfields(Index).BoundText
   Else
      If Index = 1 Then
         origen.Registro.Fields(dcfields(Index).DataField).Value = Null
      End If
   End If

End Sub

Private Sub dcfields_Click(Index As Integer, Area As Integer)

   If Index = 1 And Me.Visible And IsNumeric(dcfields(Index).BoundText) Then
      If dcfields(Index).BoundText <> mIdAprobo Then
         PideAutorizacion
      End If
   End If
   
End Sub

Private Sub dcfields_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True
   
End Sub

Private Sub dcfields_Validate(Index As Integer, Cancel As Boolean)

'   If Index = 1 Then
'      If IsNumeric(dcfields(Index).BoundText) Then
'         Dim of As frmAutorizacion1
'         Set of = New frmAutorizacion1
'         With of
'            .IdUsuario = dcfields(Index).BoundText
'            .Show vbModal, Me
'         End With
'         If Not of.OK Then
'            origen.Registro.Fields(dcfields(Index).DataField).Value = Null
'            Check1(0).Value = 0
'         Else
'            Check1(0).Value = 1
'         End If
'         Unload of
'         Set of = Nothing
'      End If
'   End If

End Sub

Private Sub DTPicker1_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then PostMessage DTPicker1(Index).hwnd, WM_KEYDOWN, VK_TAB, 0

End Sub

Private Sub Form_Activate()

   CalculaFlex

End Sub

Private Sub Form_Load()

   CambiarLenguaje Me, "esp", glbIdiomaActual

End Sub

Private Sub Form_Paint()

   Degradado Me
   
End Sub

Private Sub Form_Resize()

'   ResizeForm Me

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set actL2 = Nothing
   Set origen = Nothing
   Set oBind = Nothing
   
End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         BorraItem
   End Select

End Sub

Private Sub MSFlexGrid1_Click()

   If mvarCerrado Then
      MsgBox "La comparativa fue cerrada!", vbCritical
      Exit Sub
   End If
   
   Dim mvarPresu As Long, presu As Long, SubNum As Long, Artic As Long
   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim i As Integer, fl As Integer, fl_ant As Integer, cl As Integer, cl_ant As Integer
   
   Set oAp = Aplicacion
   
   With MSFlexGrid1
   
      fl_ant = .row
      cl_ant = .col
      
      If .col >= ColumnasFijas Then
'         mvarPresu = Val(Mid(.TextArray(PosCelda(0, .col)), 13, 6))
         .row = 0
         cl = .col
         For i = ColumnasFijas To .Cols - 1
            .col = i
            presu = Val(mId(.Text, 13, 6))
            SubNum = Val(mId(.Text, 22, 2))
            If presu = origen.Registro.Fields("PresupuestoSeleccionado").Value And SubNum = origen.Registro.Fields("SubNumeroSeleccionado").Value Then
               .CellBackColor = ColumnaEscogida
            Else
               .CellBackColor = ColumnaNoSeleccionada
            End If
         Next
         .col = cl
         .CellBackColor = ColumnaSeleccionada
         If EsPrecio(cl) Then
            .col = cl + 1
            .CellBackColor = ColumnaSeleccionada
         Else
            .col = cl - 1
            .CellBackColor = ColumnaSeleccionada
         End If
         MostrarDatosPresupuesto cl
      End If
      .row = fl_ant
      .col = cl_ant
   End With

   Set oRs = Nothing
   Set oAp = Nothing
   
End Sub

Private Sub MSFlexGrid1_DblClick()

   If mvarCerrado Then
      MsgBox "La comparativa fue cerrada!", vbCritical
      Exit Sub
   End If
   
   Dim i As Integer, fl As Integer, cl As Integer
   
   With MSFlexGrid1
      If Not .col >= ColumnasFijas Or Not EsPrecio(.col) Or Not IsNumeric(.Text) Then
         MsgBox "Puede marcar solo sobre los precios unitarios"
         Exit Sub
      End If
      fl = .row
      cl = .col
      For i = ColumnasFijas To .Cols - 1
         .col = i
         .CellBackColor = Desmarcado
         .CellFontBold = False
      Next
      .row = fl
      .col = cl
      .CellBackColor = Marcado
      .CellFontBold = True
   End With
   
End Sub

Private Sub MSFlexGrid1_KeyUp(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyDelete Then
      MnuDetA_Click 0
   End If

End Sub

Private Sub MSFlexGrid1_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      PopupMenu MnuDet, , , , MnuDetA(0)
   Else
      If Shift = 2 Then
         With MSFlexGrid1
            If Not .col >= ColumnasFijas Or Not EsPrecio(.col) Or Not IsNumeric(.Text) Then
               MsgBox "Puede marcar solo sobre los precios unitarios"
               Exit Sub
            End If
            Dim i, fl, cl As Integer
            fl = .row
            cl = .col
            For i = ColumnasFijas To .Cols - 1
               .col = i
               .CellBackColor = Desmarcado
               .CellFontBold = False
            Next
            .row = fl
            .col = cl
            .CellBackColor = Marcado
            .CellFontBold = True
         End With
      End If
   End If

End Sub

Private Sub MSFlexGrid1_OLEDragDrop(Data As MSHierarchicalFlexGridLib.DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   If mvarCerrado Then
      MsgBox "La comparativa fue cerrada!", vbCritical
      Exit Sub
   End If
   
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long, mIdDet As Long
   Dim mEsta As Boolean, mError As Boolean
   Dim mCantidad As Double
   Dim s As String, mObs As String
   Dim oL As ListItem
   Dim oAp As ComPronto.Aplicacion
   Dim oPre As ComPronto.Presupuesto
   Dim oRsDetPre As ADOR.Recordset
   Dim oRsDetPreCopia As ADOR.Recordset
   Dim oRsDetCom As ADOR.Recordset
   Dim oRs As ADOR.Recordset

   On Error GoTo Mal
   
   If Data.GetFormat(ccCFText) Then
      
      s = Data.GetData(ccCFText)
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      
      If InStr(1, Columnas(LBound(Columnas) + 1), "Presupuesto") <> 0 Then
      
         Set oAp = Aplicacion
         
         For iFilas = LBound(Filas) + 1 To UBound(Filas)
            
            Columnas = Split(Filas(iFilas), vbTab)
            
            Set oRsDetCom = origen.DetComparativas.TodosLosRegistros
            
            If oRsDetCom.State <> adStateClosed Then
               If oRsDetCom.RecordCount > 0 Then
                  oRsDetCom.MoveFirst
                  Do While Not oRsDetCom.EOF
                     If oRsDetCom.Fields("IdPresupuesto").Value = Val(Columnas(19)) Then
                        MsgBox "Presupuesto ya ingresado en esta comparativa !", vbCritical
                        oRsDetCom.Close
                        Set oRsDetCom = Nothing
                        Exit Sub
                     End If
                     oRsDetCom.MoveNext
                  Loop
               End If
               oRsDetCom.Close
            End If
            
            Set oPre = oAp.Presupuestos.Item(Columnas(19))
            Set oRsDetPre = oPre.DetPresupuestos.TraerTodos
            Set oRsDetPreCopia = oRsDetPre.Clone
            
            With oRsDetPre
               If .RecordCount > 0 Then
                  Do While Not .EOF
                     mError = False
                     oRsDetPreCopia.MoveFirst
                     Do While Not oRsDetPreCopia.EOF
                        If oRsDetPreCopia.Fields("IdArticulo").Value = .Fields("IdArticulo").Value And _
                           oRsDetPreCopia.Fields("OrigenDescripcion").Value = .Fields("OrigenDescripcion").Value And _
                           (.Fields("OrigenDescripcion").Value = 1 Or _
                            (.Fields("OrigenDescripcion").Value >= 2 And oRsDetPreCopia.Fields("Observaciones").Value = .Fields("Observaciones").Value)) Then
                           If oRsDetPreCopia.Fields("Prec.Unit.").Value <> .Fields("Prec.Unit.").Value Then
                              mError = True
                              Exit Do
                           End If
                        End If
                        oRsDetPreCopia.MoveNext
                     Loop
                     If mError Then
                        MsgBox "Los items " & .Fields("Item").Value & " y " & _
                                 oRsDetPreCopia.Fields("Item").Value & " del presupuesto son iguales" & vbCrLf & _
                                 "y tienen precios diferentes, la solicitud no sera incorporada", vbExclamation
                        GoTo Salida
                     End If
                     .MoveNext
                  Loop
                  .MoveFirst
               End If
               oRsDetPreCopia.Close
            End With
            
            Do While Not oRsDetPre.EOF
               mEsta = False
               mCantidad = 0
               mIdDet = -1
               Set oRs = origen.DetComparativas.Registros
               If oRs.Fields.Count > 0 Then
                  If oRs.RecordCount > 0 Then
                     oRs.MoveFirst
                     Do While Not oRs.EOF
                        If Not oRs.Fields("Eliminado").Value Then
                           If oRs.Fields("IdPresupuesto").Value = oRsDetPre.Fields("IdPresupuesto").Value And _
                              oRs.Fields("IdArticulo").Value = oRsDetPre.Fields("IdArticulo").Value And _
                              oRs.Fields("Precio").Value = oRsDetPre.Fields("Prec.Unit.").Value And _
                              oRs.Fields("OrigenDescripcion").Value = oRsDetPre.Fields("OrigenDescripcion").Value And _
                              (IsNull(oRs.Fields("OrigenDescripcion").Value) Or oRs.Fields("OrigenDescripcion").Value = 1 Or _
                               (oRs.Fields("OrigenDescripcion").Value >= 2 And oRs.Fields("Observaciones").Value = oRsDetPre.Fields("Observaciones").Value)) Then
                              mEsta = True
                              mIdDet = oRs.Fields(0).Value
                              mCantidad = oRs.Fields("Cantidad").Value
                              Exit Do
                           End If
                        End If
                        oRs.MoveNext
                     Loop
                  End If
                  oRs.Close
               End If
               If Not mEsta Then
                  With origen.DetComparativas.Item(-1)
                     .Registro.Fields("IdPresupuesto").Value = Columnas(19)
                     .Registro.Fields("IdDetallePresupuesto").Value = oRsDetPre.Fields(0).Value
                     .Registro.Fields("NumeroPresupuesto").Value = oPre.Registro.Fields("Numero").Value
                     .Registro.Fields("SubNumero").Value = oPre.Registro.Fields("SubNumero").Value
                     .Registro.Fields("FechaPresupuesto").Value = oPre.Registro.Fields("FechaIngreso").Value
                     .Registro.Fields("IdMoneda").Value = oPre.Registro.Fields("IdMoneda").Value
                     .Registro.Fields("IdArticulo").Value = oRsDetPre.Fields("IdArticulo").Value
                     .Registro.Fields("Cantidad").Value = oRsDetPre.Fields("Cantidad").Value
                     .Registro.Fields("Precio").Value = oRsDetPre.Fields("Prec.Unit.").Value
                     .Registro.Fields("PorcentajeBonificacion").Value = oRsDetPre.Fields("% Bon").Value
                     .Registro.Fields("IdUnidad").Value = oRsDetPre.Fields("IdUnidad").Value
                     .Registro.Fields("OrigenDescripcion").Value = oRsDetPre.Fields("OrigenDescripcion").Value
                     .Registro.Fields("CotizacionMoneda").Value = IIf(IsNull(oPre.Registro.Fields("CotizacionMoneda").Value), 1, oPre.Registro.Fields("CotizacionMoneda").Value)
                     rchObservacionesItems.TextRTF = IIf(IsNull(oRsDetPre.Fields("Observaciones").Value), "", oRsDetPre.Fields("Observaciones").Value)
                     mObs = Replace(rchObservacionesItems.Text, ",", " ")
                     mObs = Replace(mObs, ";", " ")
                     mObs = Replace(mObs, Chr(13) + Chr(10) + Chr(13) + Chr(10), " ")
                     .Registro.Fields("Observaciones").Value = mObs
                     .Modificado = True
                  End With
               Else
                  origen.DetComparativas.Item(mIdDet).Registro.Fields("Cantidad").Value = mCantidad + oRsDetPre.Fields("Cantidad").Value
               End If
               oRsDetPre.MoveNext
            Loop
            oRsDetPre.Close
            
         Next
      
         Set oRs = origen.DetComparativas.TodosLosRegistrosConFormato
         CargaFlex oRs
         oRs.Close
         CalculaFlex
         
      Else
         
         MsgBox "Objeto invalido!"
         Exit Sub
      
      End If
   
   End If

Salida:

   Set oRsDetCom = Nothing
   Set oRsDetPre = Nothing
   Set oRsDetPreCopia = Nothing
   Set oRs = Nothing
   Set oPre = Nothing
   Set oAp = Nothing
   
   Exit Sub

Mal:
   MsgBox "No se pudo completar la operacion ..." & vbCrLf & Err.Number & " " & Err.Description, vbCritical
   Resume Salida

End Sub

Private Sub MSFlexGrid1_OLEDragOver(Data As MSHierarchicalFlexGridLib.DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single, State As Integer)

   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long
   Dim iColumnas As Long

   If State = vbEnter Then
      If Data.GetFormat(ccCFText) Then
         s = Data.GetData(ccCFText)
         Filas = Split(s, vbCrLf)
         Columnas = Split(Filas(LBound(Filas)), vbTab)
         Effect = vbDropEffectCopy
      End If
   End If

End Sub

Private Sub MSFlexGrid1_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub cmdPegar_Click()

   If mvarCerrado Then
      MsgBox "La comparativa fue cerrada!", vbCritical
      Exit Sub
   End If
   
   Dim s As String
   Dim Filas
   Dim Columnas
   Dim iFilas As Long, iColumnas As Long, i As Long
   Dim oAp As ComPronto.Aplicacion
   Dim oPre As ComPronto.Presupuesto
   Dim oRsDetPre, oRs As ADOR.Recordset

   If Not Clipboard.GetFormat(vbCFText) Then
      MsgBox "No hay informacion en el portapapeles", vbCritical
      Exit Sub
   End If
   
   s = Clipboard.GetText(vbCFText)
   
   Filas = Split(s, vbCrLf)
   Columnas = Split(Filas(LBound(Filas)), vbTab)
   
   If UBound(Columnas) < 2 Then
      MsgBox "No hay Comparativas para copiar", vbCritical
      Exit Sub
   End If
   
   If InStr(1, Columnas(LBound(Columnas) + 1), "Presupuesto") <> 0 Then
   
      Set oAp = Aplicacion
      
      For iFilas = LBound(Filas) + 1 To UBound(Filas)
         
         Columnas = Split(Filas(iFilas), vbTab)
         
         Set oPre = oAp.Presupuestos.Item(Columnas(0))
         Set oRsDetPre = oPre.DetPresupuestos.TraerTodos
         
         Do While Not oRsDetPre.EOF
            With origen.DetComparativas.Item(-1)
               .Registro.Fields("IdPresupuesto").Value = oRsDetPre.Fields("IdPresupuesto").Value
               .Registro.Fields("IdDetallePresupuesto").Value = oRsDetPre.Fields(0).Value
               .Registro.Fields("NumeroPresupuesto").Value = oPre.Registro.Fields("Numero").Value
               .Registro.Fields("FechaPresupuesto").Value = oPre.Registro.Fields("FechaIngreso").Value
               .Registro.Fields("IdArticulo").Value = oRsDetPre.Fields("IdArticulo").Value
               .Registro.Fields("Cantidad").Value = oRsDetPre.Fields("Cantidad").Value
               .Registro.Fields("Precio").Value = oRsDetPre.Fields("Prec.Unit.").Value
               .Registro.Fields("SubNumero").Value = oPre.Registro.Fields("SubNumero").Value
               rchObservacionesItems.TextRTF = IIf(IsNull(oRsDetPre.Fields("Observaciones").Value), "", oRsDetPre.Fields("Observaciones").Value)
               .Registro.Fields("Observaciones").Value = rchObservacionesItems.Text
               .Registro.Fields("IdUnidad").Value = oRsDetPre.Fields("IdUnidad").Value
               .Registro.Fields("IdMoneda").Value = oRsDetPre.Fields("IdMoneda").Value
               .Registro.Fields("OrigenDescripcion").Value = oRsDetPre.Fields("OrigenDescripcion").Value
               .Modificado = True
            End With
            oRsDetPre.MoveNext
         Loop
         oRsDetPre.Close
         
         Set oRs = origen.DetComparativas.TodosLosRegistrosConFormato
         CargaFlex oRs
         oRs.Close
         
         Set oRsDetPre = Nothing
         Set oRs = Nothing
         Set oPre = Nothing
         
      Next
   
      Clipboard.Clear
      CalculaFlex
      
   Else
      
      MsgBox "Objeto invalido!"
      Exit Sub
   
   End If
   
End Sub

Private Sub txtNumero_GotFocus()

   With txtNumero
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumero_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Sub MejorPrecio()

   Dim fl As Integer, cl As Integer
   
   With MSFlexGrid1
      For fl = 1 To .Rows - 8
         .row = fl
         For cl = ColumnasFijas To .Cols - 1
            .col = cl
            If .CellPicture = 0 Then
               .CellBackColor = Desmarcado
               .CellFontBold = False
            Else
               .CellBackColor = Marcado
               .CellFontBold = True
            End If
         Next
      Next
      .Refresh
   End With

End Sub

Public Sub DesmarcarTodo()
         
   Dim fl As Integer, cl As Integer
   
   With MSFlexGrid1
      For fl = 1 To .Rows - 8
         .row = fl
         For cl = ColumnasFijas To .Cols - 1
            .col = cl
            .CellBackColor = Desmarcado
            .CellFontBold = False
         Next
      Next
      .Refresh
   End With
   
End Sub

Function PosCelda(row As Integer, col As Integer) As Long

   PosCelda = row * MSFlexGrid1.Cols + col

End Function

Public Sub MostrarDatosPresupuesto(ByVal cl As Integer)

   Dim oAp As ComPronto.Aplicacion
   Dim oRs As ADOR.Recordset
   Dim mvarPresu As Long, mvarSubNum As Long
   
   Set oAp = Aplicacion
   
   With MSFlexGrid1
      If cl >= ColumnasFijas Then
         .row = 0
         .col = cl
         mvarPresu = Val(mId(.Text, 13, 6))
         mvarSubNum = Val(mId(.Text, 22, 2))
         Set oRs = oAp.Presupuestos.TraerFiltrado("_PorNumero", Array(mvarPresu, mvarSubNum))
         If oRs.Fields.Count > 0 Then
            If oRs.RecordCount > 0 Then
               lblPresupuesto.Caption = "Presupuesto : " & oRs.Fields("Numero").Value & " del " & oRs.Fields("FechaIngreso").Value
               txtProveedor.Text = oAp.Proveedores.Item(oRs.Fields("IdProveedor").Value).Registro.Fields("RazonSocial").Value
               txtCondiciones.Text = oAp.CondicionesCompra.Item(oRs.Fields("IdCondicionCompra").Value).Registro.Fields("Descripcion").Value
               txtPlazo.Text = IIf(IsNull(oRs.Fields("Plazo").Value), "", oRs.Fields("Plazo").Value)
               txtValidez.Text = IIf(IsNull(oRs.Fields("Validez").Value), "", oRs.Fields("Validez").Value)
            End If
         End If
         oRs.Close
      End If
   End With

   Set oRs = Nothing
   Set oAp = Nothing
   
End Sub

Public Sub CargaFlex(ByVal oRs As ADOR.Recordset)

   Dim s As String, sObs As String
   Dim i As Integer, I1 As Integer, h As Integer
   Dim HayObservaciones As Boolean
   
   With MSFlexGrid1
      h = .Rows - 1
      For i = h To 1 Step -1
         .RemoveItem (i)
      Next
      .Cols = ColumnasFijas + (((oRs.Fields.Count - ColumnasFijas) / 3) * 2)
      .row = 0
      I1 = 0
      For i = 0 To oRs.Fields.Count - 1
         If mId(oRs.Fields(i).Name, 1, 11) <> "Observacion" Then
            .col = I1
            .Text = oRs.Fields(i).Name
            I1 = I1 + 1
         End If
      Next
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            s = ""
            sObs = ""
            HayObservaciones = False
            For i = 0 To oRs.Fields.Count - 1
               If mId(oRs.Fields(i).Name, 1, 11) <> "Observacion" Then
                  If oRs.AbsolutePosition = oRs.RecordCount - 1 Then
                     If i > ColumnasFijas - 1 Then
                        rchObservacionesItems.TextRTF = IIf(IsNull(oRs.Fields(i).Value), "", oRs.Fields(i).Value)
                        s = s & rchObservacionesItems.Text & "" & vbTab
                     Else
                        s = s & oRs.Fields(i).Value & "" & vbTab
                     End If
                  Else
                     s = s & oRs.Fields(i).Value & "" & vbTab
                     If mId(oRs.Fields(i).Name, 1, 11) <> "Presupuesto" Then
                        If oRs.Fields(i).Name = "Sort" Or oRs.Fields(i).Name = "DescripcionConObs" Then
                           sObs = sObs & oRs.Fields(i).Value & " _" & vbTab
                        Else
                           sObs = sObs & "" & vbTab
                        End If
                     End If
                  End If
               Else
                  If Len(Trim(oRs.Fields(i).Value)) > 0 Then
                     sObs = sObs & oRs.Fields(i).Value & "" & vbTab
                     HayObservaciones = True
                  Else
                     sObs = sObs & "" & vbTab
                  End If
               End If
            Next
            .AddItem (s)
            If HayObservaciones Then .AddItem (sObs)
            oRs.MoveNext
         Loop
      End If
   End With
               
End Sub
               
Public Sub CalculaFlex()

   Dim oRs As ADOR.Recordset
   Dim cl As Integer, fl As Integer, Mejor_Col As Integer, mPosCot As Integer
   Dim presu As Long, SubNum As Long, Artic As Long
   Dim Mejor_Precio As Double, Precio_Celda As Double
   Dim HayObservaciones As Boolean
         
   Me.MousePointer = vbHourglass
      
   With MSFlexGrid1
      .RowHeight(0) = 800
      .ColWidth(0) = 0
      
      For cl = 0 To .Cols - 1
         Select Case cl
            Case 0
               .ColWidth(cl) = 10
               .ColAlignment(cl) = flexAlignRightCenter
            Case 1
               .ColWidth(cl) = 500
               .ColAlignment(cl) = flexAlignRightCenter
            Case 2
               .ColWidth(cl) = 5000
               .ColAlignment(cl) = flexAlignLeftCenter
            Case 3
               .ColWidth(cl) = 800
               .ColAlignment(cl) = flexAlignRightCenter
            Case 4
               .ColWidth(cl) = 1000
               .ColAlignment(cl) = flexAlignLeftCenter
            Case 5
               .ColWidth(cl) = 10
               .ColAlignment(cl) = flexAlignLeftCenter
            Case 6
               .ColWidth(cl) = 10
               .ColAlignment(cl) = flexAlignLeftCenter
            Case Is > ColumnasFijas - 1
               If EsPrecio(cl) Then
                  .ColWidth(cl) = 3000
               Else
                  .ColWidth(cl) = 1000
               End If
               .ColAlignment(cl) = flexAlignRightCenter
         End Select
      Next
      
      .row = 0
      For cl = 0 To .Cols - 1
         .col = cl
         .CellAlignment = flexAlignCenterCenter
         .CellBackColor = ColumnaNoSeleccionada
      Next
      
      If .Rows > 3 Then
         .row = .Rows - 1
         
         For fl = .Rows - 7 To .Rows - 5
            .row = fl
            For cl = 1 To .Cols - 1
               .col = cl
'               .CellFontBold = True
               If fl = .Rows - 5 Then
                  .CellBackColor = &H80FFFF
               End If
               If IsNumeric(.Text) Then
                  .Text = Format(.Text, "#,##0.00")
               End If
            Next
         Next
      
         For fl = .Rows - 4 To .Rows - 1
            .row = fl
            For cl = 1 To .Cols - 1
               .col = cl
               .CellBackColor = &HFFFFFF
               .CellAlignment = flexAlignLeftTop
            Next
         Next
         .RowHeight(.Rows - 3) = 700
         .RowHeight(.Rows - 2) = 1000
      
         For fl = 1 To .Rows - 8
            Mejor_Precio = -1
            .row = fl
            .col = 2
            .RowHeight(.row) = 700
            If Len(Trim(.Text)) = 0 Then
               HayObservaciones = True
               .RowHeight(.row) = 1000
            Else
               HayObservaciones = False
            End If
            For cl = ColumnasFijas To .Cols - 1
               .col = cl
               If HayObservaciones Then
                  .CellAlignment = flexAlignLeftTop
                  If Len(Trim(.Text)) > 5 Then
                     .CellBackColor = &HFFFFFF
                  End If
               Else
                  If EsPrecio(cl) And IsNumeric(Replace(.Text, ",", "")) Then
                     .Text = Format(.Text, "#,##0.0000")
                     Precio_Celda = Val(Replace(.Text, ",", ""))
                     If InStr(1, .TextMatrix(0, cl), "Eq.$:") <> 0 Then
                        mPosCot = InStr(1, .TextMatrix(0, cl), "Eq.$:")
                        If IsNumeric(mId(.TextMatrix(0, cl), mPosCot + 5, 7)) Then
                           Precio_Celda = Precio_Celda * CDbl(mId(.TextMatrix(0, cl), mPosCot + 5, 7))
                        End If
                     End If
                     If Precio_Celda <> 0 And (Precio_Celda < Mejor_Precio Or Mejor_Precio = -1) Then
                        Mejor_Col = cl
                        Mejor_Precio = Precio_Celda
                     End If
                  End If
               End If
            Next
            If Mejor_Precio <> -1 Then
               .col = Mejor_Col
               Set .CellPicture = LoadPicture("C:\Pronto\Imagenes\Happy.bmp")
            End If
         Next
      End If
      
      mMatriz = origen.DetComparativas.MatrizId
      For cl = ColumnasFijas To .Cols - 1
         .col = cl
         .row = 0
         presu = Val(mId(.TextMatrix(0, cl), 13, 6))
         SubNum = Val(mId(.TextMatrix(0, cl), 22, 2))
         If presu = origen.Registro.Fields("PresupuestoSeleccionado").Value And SubNum = origen.Registro.Fields("SubNumeroSeleccionado").Value Then
            .CellBackColor = ColumnaEscogida
            MostrarDatosPresupuesto cl
         End If
         For fl = 1 To .Rows - 8
            Artic = Val(.TextMatrix(fl, 0))
            .row = fl
            .col = cl
            If mMatriz(fl, cl) <> 0 Then
               If origen.DetComparativas.Item(mMatriz(fl, cl)).Registro.Fields("Estado").Value = "MR" Then
                  .CellBackColor = Marcado
                  .CellFontBold = True
               End If
            End If
         Next
      Next
   End With
   
   txtObras.Text = origen.Obras
   txtNumeroRequerimiento.Text = origen.RMs_LAs

   Me.MousePointer = vbDefault
      
End Sub

Public Function EsPrecio(ByVal cl As Integer) As Boolean

   If (cl - (ColumnasFijas - 1)) / 2 <> Int((cl - (ColumnasFijas - 1)) / 2) Then
      EsPrecio = True
   Else
      EsPrecio = False
   End If

End Function

Public Function BorraItem()

   If mvarCerrado Then
      MsgBox "La comparativa fue cerrada!", vbCritical
      Exit Function
   End If
   
   If Not (MSFlexGrid1.row <= MSFlexGrid1.Rows - 8 And MSFlexGrid1.row > 0) Then
      MsgBox "Tiene que posicionar el cursor en un material!", vbExclamation
      Exit Function
   End If
   
   On Error GoTo Salida
   
   Me.MousePointer = vbHourglass
   DoEvents
   
   Dim oRs As ADOR.Recordset
   Dim oRsArt As ADOR.Recordset
   Dim cl As Integer, mOrigenDescripcion As Integer
   Dim mvarPresu As Long, mvarSubNum As Long
   Dim mArticuloFlex As String, mvarArticulo As String, mvarArticuloConObs As String
   Dim mvarArticuloSinObs As String
   
   Set oRs = origen.DetComparativas.TodosLosRegistros
   
   With MSFlexGrid1
      For cl = ColumnasFijas To .Cols - 1
         .col = 2
         mArticuloFlex = .Text
         .col = cl
         oRs.MoveFirst
         Do While Not oRs.EOF
            mvarArticuloConObs = ""
            mvarArticuloSinObs = ""
            mvarArticulo = ""
            If Not IsNull(oRs.Fields("IdArticulo").Value) Then
               Set oRsArt = Aplicacion.Articulos.TraerFiltrado("_TT", oRs.Fields("IdArticulo").Value)
               If oRsArt.RecordCount > 0 Then
                  mvarArticuloConObs = oRsArt.Fields("Descripcion").Value & " [Id " & oRs.Fields("IdArticulo").Value & "]"
                  mvarArticuloSinObs = oRsArt.Fields("Descripcion").Value & " [Id " & oRs.Fields("IdArticulo").Value & "]"
               End If
               oRsArt.Close
               If Not IsNull(oRs.Fields("Observaciones").Value) Then
                  mvarArticuloConObs = mvarArticuloConObs & " " & oRs.Fields("Observaciones").Value
               End If
            End If
            If Not IsNull(oRs.Fields("OrigenDescripcion").Value) Then
               mOrigenDescripcion = oRs.Fields("OrigenDescripcion").Value
            Else
               mOrigenDescripcion = 1
            End If
            If (mOrigenDescripcion = 1 Or mOrigenDescripcion = 3) And _
                  Not IsNull(oRs.Fields("IdArticulo").Value) Then
               mvarArticulo = mvarArticuloSinObs
            End If
            If mOrigenDescripcion = 2 Or mOrigenDescripcion = 3 Then
               If Len(Trim(mvarArticulo)) > 0 Then
                  mvarArticulo = mvarArticuloConObs
               Else
                  mvarArticulo = oRs.Fields("Observaciones").Value
               End If
            End If
            If mArticuloFlex = mId(mvarArticulo, 1, Len(mArticuloFlex)) Then
               origen.DetComparativas.Item(oRs.Fields(0).Value).Eliminado = True
            End If
            oRs.MoveNext
         Loop
      Next
   End With
   oRs.Close
   
Salida:

   Set oRs = origen.DetComparativas.TodosLosRegistrosConFormato
   CargaFlex oRs
   oRs.Close
   
   Set oRsArt = Nothing
   Set oRs = Nothing
   
   CalculaFlex

   Me.MousePointer = vbDefault
   DoEvents

End Function

Private Sub txtNumeroRequerimiento_GotFocus()

   With txtNumeroRequerimiento
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroRequerimiento_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub PideAutorizacion()

   Dim oF As frmAutorizacion1
   Set oF = New frmAutorizacion1
   With oF
      .IdUsuario = dcfields(1).BoundText
      .Show vbModal, Me
   End With
   If Not oF.Ok Then
      With origen.Registro
         .Fields(dcfields(1).DataField).Value = Null
         .Fields("FechaAprobacion").Value = Null
      End With
      Check1(0).Value = 0
      mIdAprobo = 0
   Else
      With origen.Registro
         .Fields("FechaAprobacion").Value = Now
         mIdAprobo = .Fields("IdAprobo").Value
      End With
      Check1(0).Value = 1
   End If
   Unload oF
   Set oF = Nothing

End Sub

Private Sub txtObras_GotFocus()

   With txtObras
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtObras_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then
      SendKeys "{TAB}", True
   Else
      With txtObras
         If Len(Trim(.Text)) >= origen.Registro.Fields(.DataField).DefinedSize And Chr(KeyAscii) <> vbBack Then
            KeyAscii = 0
         Else
            If KeyAscii >= Asc("a") And KeyAscii <= Asc("z") Then
               KeyAscii = KeyAscii - 32
            End If
         End If
      End With
   End If

End Sub

