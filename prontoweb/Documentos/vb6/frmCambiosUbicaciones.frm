VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0"; "Controles1013.ocx"
Begin VB.Form frmCambiosUbicaciones 
   Caption         =   "Cambios de ubicaciones"
   ClientHeight    =   7065
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   12225
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   7065
   ScaleWidth      =   12225
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmd 
      Caption         =   "Salir"
      Height          =   360
      Index           =   1
      Left            =   1665
      TabIndex        =   3
      Top             =   6660
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Generar cambios"
      Height          =   360
      Index           =   0
      Left            =   90
      TabIndex        =   2
      Top             =   6660
      Width           =   1485
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Ver stock"
      Height          =   360
      Index           =   2
      Left            =   10620
      TabIndex        =   1
      Top             =   6660
      Width           =   1485
   End
   Begin Controles1013.DbListView Lista 
      Height          =   6180
      Left            =   90
      TabIndex        =   0
      Top             =   450
      Width           =   12030
      _ExtentX        =   21220
      _ExtentY        =   10901
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "frmCambiosUbicaciones.frx":0000
      OLEDragMode     =   1
      OLEDropMode     =   1
      Sorted          =   0   'False
      ColumnHeaderIcons=   "ImgColumnas"
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   1710
      TabIndex        =   5
      Tag             =   "Ubicaciones"
      Top             =   45
      Width           =   5505
      _ExtentX        =   9710
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUbicacion"
      Text            =   ""
   End
   Begin VB.Label lblLabels 
      Caption         =   "Nueva ubicacion :"
      Height          =   255
      Index           =   10
      Left            =   135
      TabIndex        =   6
      Top             =   90
      Width           =   1365
   End
   Begin VB.Label lblEstado 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0FF&
      Caption         =   "MODO CODIGO DE BARRA"
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
      Left            =   9000
      TabIndex        =   4
      Top             =   270
      Visible         =   0   'False
      Width           =   3075
   End
   Begin VB.Menu MnuDet 
      Caption         =   "Detalle"
      Visible         =   0   'False
      Begin VB.Menu MnuDetA 
         Caption         =   "Eliminar"
         Index           =   0
      End
      Begin VB.Menu MnuDetA 
         Caption         =   "Ingreso manual por cajas"
         Index           =   1
      End
   End
End
Attribute VB_Name = "frmCambiosUbicaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private oRsCambios As ADOR.Recordset
Private mVectorX As String, mVectorT As String, mCadena As String
Private mvarModoCodigoBarra As Boolean
Private mvarFormatCodBar As Integer

Private Sub cmd_Click(Index As Integer)

   Dim oF As Form
   
   Select Case Index
      Case 0
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "No ingreso la nueva ubicacion", vbExclamation
            Exit Sub
         End If
         
         Dim oAju As ComPronto.AjusteStock
         Dim oPar As ComPronto.Parametro
         Dim oL As ListItem
         Dim mNumeroAjusteStock As Long
   
         Set oPar = Aplicacion.Parametros.Item(1)
         With oPar.Registro
            mNumeroAjusteStock = .Fields("ProximoNumeroAjusteStock").Value
            .Fields("ProximoNumeroAjusteStock").Value = mNumeroAjusteStock + 1
         End With
         oPar.Guardar
         Set oPar = Nothing
         
         Set oAju = Aplicacion.AjustesStock.Item(-1)
         With oAju
            With .Registro
               .Fields("NumeroAjusteStock").Value = mNumeroAjusteStock
               .Fields("FechaAjuste").Value = Date
               .Fields("Observaciones").Value = "Cambio de ubicacion"
               .Fields("IdRealizo").Value = glbIdUsuario
               .Fields("FechaRegistro").Value = Now
               .Fields("TipoAjuste").Value = ""
               .Fields("IdUsuarioIngreso").Value = glbIdUsuario
               .Fields("FechaIngreso").Value = Now
            End With
            For Each oL In Lista.ListItems
               With .DetAjustesStock.Item(-1)
                  With .Registro
                     .Fields("IdArticulo").Value = oL.SubItems(1)
                     .Fields("Partida").Value = oL.SubItems(7)
                     .Fields("CantidadUnidades").Value = oL.SubItems(9) * -1
                     .Fields("IdUnidad").Value = oL.SubItems(4)
                     .Fields("Observaciones").Value = "Cambio de ubicacion"
                     .Fields("IdUbicacion").Value = oL.SubItems(2)
                     .Fields("IdObra").Value = oL.SubItems(3)
                     .Fields("NumeroCaja").Value = oL.SubItems(8)
                  End With
                  .Modificado = True
               End With
               With .DetAjustesStock.Item(-1)
                  With .Registro
                     .Fields("IdArticulo").Value = oL.SubItems(1)
                     .Fields("Partida").Value = oL.SubItems(7)
                     .Fields("CantidadUnidades").Value = oL.SubItems(9)
                     .Fields("IdUnidad").Value = oL.SubItems(4)
                     .Fields("Observaciones").Value = "Cambio de ubicacion"
                     .Fields("IdUbicacion").Value = DataCombo1(0).BoundText
                     .Fields("IdObra").Value = oL.SubItems(3)
                     .Fields("NumeroCaja").Value = oL.SubItems(8)
                  End With
                  .Modificado = True
               End With
            Next
            .Guardar
         End With
         Set oAju = Nothing
         
         MsgBox "Se ha generado el ajuste de stock numero " & mNumeroAjusteStock
         Unload Me
   
      Case 1
         Me.Hide
         Unload Me
   
      Case 2
         Set oF = New frmConsulta1
         With oF
            .Id = 1
            .Show , Me
         End With
         Set oF = Nothing
   End Select

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   If Not mvarModoCodigoBarra Then Exit Sub
   
   If KeyAscii <> 13 Then
      mCadena = mCadena & Chr(KeyAscii)
      KeyAscii = 0
   ElseIf KeyAscii = 13 Then
      ProcesarCodigoBarras mCadena
      mCadena = ""
      DoEvents
   ElseIf KeyAscii = 27 Then
      mvarModoCodigoBarra = False
      lblEstado.Visible = False
      Set Lista.DataSource = oRsCambios
      DoEvents
      mCadena = ""
   End If

End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)

   'F12 para inicializar el modo ingreso por codigo de barras
   If KeyCode = 123 Then
      mvarModoCodigoBarra = True
      lblEstado.Visible = True
      DoEvents
   ElseIf KeyCode = 27 And mvarModoCodigoBarra Then
      mCadena = ""
      mvarModoCodigoBarra = False
      lblEstado.Visible = False
      DoEvents
   End If

End Sub

Private Sub Form_Load()

   Dim mAuxS1 As String
   
   mvarFormatCodBar = 1
   mAuxS1 = BuscarClaveINI("Modelo de registro de codigo de barras")
   If Len(mAuxS1) > 0 And IsNumeric(mAuxS1) Then mvarFormatCodBar = Val(mAuxS1)
   
   Set DataCombo1(0).RowSource = Aplicacion.Ubicaciones.TraerLista
   
   mVectorX = "011111111111133"
   mVectorT = "009999E11220133"
   
   Set oRsCambios = CreateObject("Ador.Recordset")
   With oRsCambios
      .Fields.Append "IdAux", adInteger
      .Fields.Append "Codigo", adVarChar, 50, adFldIsNullable
      .Fields.Append "IdArticulo", adInteger, , adFldIsNullable
      .Fields.Append "IdUbicacion", adInteger, , adFldIsNullable
      .Fields.Append "IdObra", adInteger, , adFldIsNullable
      .Fields.Append "IdUnidad", adInteger, , adFldIsNullable
      .Fields.Append "Articulo", adVarChar, 255, adFldIsNullable
      .Fields.Append "Ubicacion", adVarChar, 100, adFldIsNullable
      .Fields.Append "Partida", adVarChar, 20, adFldIsNullable
      .Fields.Append "Nro.Caja", adInteger, , adFldIsNullable
      .Fields.Append "Cantidad", adDouble, , adFldIsNullable
      .Fields.Item("Cantidad").Precision = 18
      .Fields.Item("Cantidad").NumericScale = 2
      .Fields.Append "Un.", adVarChar, 15, adFldIsNullable
      .Fields.Append "Obra", adVarChar, 50, adFldIsNullable
      .Fields.Append "Vector_T", adVarChar, 50, adFldIsNullable
      .Fields.Append "Vector_X", adVarChar, 50, adFldIsNullable
      .Open
      .AddNew
      .Fields("IdAux").Value = -1
      .Fields("Vector_T").Value = mVectorT
      .Fields("Vector_X").Value = mVectorX
      .Update
   End With
   Set Lista.DataSource = oRsCambios
   Lista.ListItems.Clear

End Sub

Private Sub Form_Paint()

   Degradado Me

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

   Set oRsCambios = Nothing

End Sub

Private Sub Lista_KeyUp(KeyCode As Integer, Shift As Integer)
   
   If Not mvarModoCodigoBarra Then
      If KeyCode = vbKeyDelete Then MnuDetA_Click 0
   End If

End Sub

Private Sub Lista_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

   If Button = vbRightButton Then
      PopupMenu MnuDet, , , , MnuDetA(0)
   End If

End Sub

Private Sub Lista_OLEDragDrop(Data As MSComctlLib.IVBDataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim s As String
   Dim Filas, Columnas
   Dim iFilas As Long, iColumnas As Long
   Dim oRs As ADOR.Recordset

   If Data.GetFormat(ccCFText) Then
      s = Data.GetData(ccCFText)
      Filas = Split(s, vbCrLf)
      Columnas = Split(Filas(LBound(Filas)), vbTab)
      If UBound(Columnas) < 2 Then
         MsgBox "No hay informacion para copiar", vbCritical
         Exit Sub
      End If
      
      Columnas = Split(Filas(0), vbTab)
      
      If Columnas(1) = "Stock" Then
         For iFilas = 1 To UBound(Filas)
            Columnas = Split(Filas(iFilas), vbTab)
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_Stock", Columnas(0))
            If oRs.RecordCount > 0 Then
               With oRsCambios
                  .AddNew
                  .Fields("IdAux").Value = 0
                  .Fields("Codigo").Value = oRs.Fields("Codigo").Value
                  .Fields("Articulo").Value = oRs.Fields("Descripcion").Value
                  .Fields("IdArticulo").Value = oRs.Fields("IdArticulo").Value
                  .Fields("IdUbicacion").Value = oRs.Fields("IdUbicacion").Value
                  .Fields("IdObra").Value = oRs.Fields("IdObra").Value
                  .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                  .Fields("Ubicacion").Value = oRs.Fields("Ubicacion").Value
                  .Fields("Partida").Value = oRs.Fields("Partida").Value
                  .Fields("Nro.Caja").Value = oRs.Fields("NumeroCaja").Value
                  .Fields("Cantidad").Value = oRs.Fields("CantidadUnidades").Value
                  .Fields("Un.").Value = oRs.Fields("UnidadAb").Value
                  .Fields("Obra").Value = oRs.Fields("Obra").Value
                  .Fields("Vector_T").Value = mVectorT
                  .Fields("Vector_X").Value = mVectorX
                  .Update
               End With
            End If
            oRs.Close
         Next
         Set Lista.DataSource = oRsCambios
      Else
         MsgBox "Informacion invalida!", vbCritical
         Exit Sub
      End If
      
      Set oRs = Nothing
      
      Clipboard.Clear
      
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
      If Data.GetFormat(ccCFText) Then
         s = Data.GetData(ccCFText)
         Filas = Split(s, vbCrLf)
         Columnas = Split(Filas(LBound(Filas)), vbTab)
         Effect = vbDropEffectCopy
      End If
   End If

End Sub

Private Sub Lista_OLEGiveFeedback(Effect As Long, DefaultCursors As Boolean)

   If Effect = vbDropEffectNone Then
      DefaultCursors = False
   End If

End Sub

Private Sub MnuDetA_Click(Index As Integer)

   Select Case Index
      Case 0
         If Not Lista.SelectedItem Is Nothing Then Lista.ListItems.Remove (Lista.object.SelectedItem.Index)
      Case 1
         IngresoManualCajas
   End Select

End Sub

Public Sub ProcesarCodigoBarras(ByVal mCodigoBarras As String)

   Dim oRs As ADOR.Recordset
   Dim oL As ListItem
   Dim mCodArt As String, mArticulo As String, mPartida As String, mObra As String, mUbicacion As String
   Dim mUnidad As String
   Dim mPeso As Double
   Dim mIdDetalle As Long, mNumeroCaja As Long, mIdUbicacion As Long, mIdArticulo As Long, mIdObra As Long
   Dim mIdUnidad As Long
   Dim mEsta As Boolean
   
   Select Case mvarFormatCodBar
      Case 2
         If Len(mCodigoBarras) > 0 And Len(mCodigoBarras) <= 32 Then
            mCodArt = Trim(mId(mCodigoBarras, 1, 20))
            mPartida = Trim(mId(mCodigoBarras, 21, 6))
            
            mNumeroCaja = 0
            mIdUbicacion = 0
            mIdArticulo = 0
            mIdObra = 0
            mIdUnidad = 0
            mUbicacion = ""
            mArticulo = ""
            mObra = ""
            mUnidad = ""
            
            If mId(mCodigoBarras, 27, 1) = "C" Then
               mNumeroCaja = mId(mCodigoBarras, 28, 5)
               Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorNumeroCaja", mNumeroCaja)
               If oRs.RecordCount > 0 Then
                  mPeso = IIf(IsNull(oRs.Fields("CantidadUnidades").Value), 0, oRs.Fields("CantidadUnidades").Value)
                  mIdUbicacion = IIf(IsNull(oRs.Fields("IdUbicacion").Value), 0, oRs.Fields("IdUbicacion").Value)
                  mIdArticulo = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
                  mIdObra = IIf(IsNull(oRs.Fields("IdObra").Value), 0, oRs.Fields("IdObra").Value)
                  mIdUnidad = IIf(IsNull(oRs.Fields("IdUnidad").Value), 0, oRs.Fields("IdUnidad").Value)
                  mUbicacion = IIf(IsNull(oRs.Fields("Ubicacion").Value), "", oRs.Fields("Ubicacion").Value)
                  mArticulo = IIf(IsNull(oRs.Fields("Articulo").Value), "", oRs.Fields("Articulo").Value)
                  mObra = IIf(IsNull(oRs.Fields("Obra").Value), "", oRs.Fields("Obra").Value)
                  mUnidad = IIf(IsNull(oRs.Fields("Un").Value), "", oRs.Fields("Un").Value)
               End If
               oRs.Close
            Else
               mPeso = CDbl(mId(mCodigoBarras, 28, 5)) / 100
               Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", mCodArt)
               If oRs.RecordCount > 0 Then
                  mIdArticulo = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
                  mArticulo = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
               End If
               oRs.Close
            End If
            
            With oRsCambios
               mEsta = False
               If .RecordCount > 0 Then
                  .MoveFirst
                  Do While Not .EOF
                     If .Fields("Nro.Caja").Value = mNumeroCaja Then
                        mEsta = True
                        Exit Do
                     End If
                     .MoveNext
                  Loop
               End If
               If Not mEsta Then
                  .AddNew
                  .Fields("IdAux").Value = 0
                  .Fields("Codigo").Value = mCodArt
                  .Fields("Articulo").Value = mArticulo
                  .Fields("IdArticulo").Value = mIdArticulo
                  .Fields("IdUbicacion").Value = mIdUbicacion
                  .Fields("IdObra").Value = mIdObra
                  .Fields("IdUnidad").Value = mIdUnidad
                  .Fields("Ubicacion").Value = mUbicacion
                  .Fields("Partida").Value = mPartida
                  .Fields("Nro.Caja").Value = mNumeroCaja
                  .Fields("Cantidad").Value = mPeso
                  .Fields("Un.").Value = mUnidad
                  .Fields("Obra").Value = mObra
                  .Fields("Vector_T").Value = mVectorT
                  .Fields("Vector_X").Value = mVectorX
                  .Update
               End If
            End With
         
            If Not mEsta Then
               Set oL = Lista.ListItems.Add
               oL.Tag = 0
               oL.Text = mCodArt
               oL.SubItems(1) = "" & mIdArticulo
               oL.SubItems(2) = "" & mIdUbicacion
               oL.SubItems(3) = "" & mIdObra
               oL.SubItems(4) = "" & mIdUnidad
               oL.SubItems(5) = "" & mArticulo
               oL.SubItems(6) = "" & mUbicacion
               oL.SubItems(7) = "" & mPartida
               oL.SubItems(8) = "" & mNumeroCaja
               oL.SubItems(9) = "" & mPeso
               oL.SubItems(10) = "" & mUnidad
               oL.SubItems(11) = "" & mObra
            End If
         End If
   End Select
   
   Set oRs = Nothing

End Sub

Public Sub IngresoManualCajas()

   Dim oF As frm_Aux
   Dim oL As ListItem
   Dim oRs As ADOR.Recordset
   Dim mOk As Boolean
   Dim mCajas As String, mCodArt As String, mPartida As String, mArticulo As String, mUnidad As String
   Dim mUbicacion As String, mObra As String, mColor As String, mError As String
   Dim i As Integer
   Dim mNumeroCaja As Long, mIdUbicacion As Long, mIdDetalle As Long, mIdArticulo As Long, mIdUnidad As Long
   Dim mIdObra As Long
   Dim mPeso As Double
   Dim mEsta As Boolean
   Dim mVector
   
   Set oF = New frm_Aux
   With oF
      .Caption = "Ingreso manual de cajas"
      .Text1.Visible = False
      .Label1.Caption = "Lista de cajas :"
      With .RichTextBox1
         .Left = oF.Text1.Left
         .Top = oF.Text1.Top
         .Width = oF.Text1.Width
         .Height = oF.Text1.Height * 15
         .Text = ""
         .Visible = True
         .TabIndex = 0
      End With
      .Height = .Height * 2.5
      .Width = .Width * 1
      .cmd(0).Top = .cmd(0).Top * 3.5
      .cmd(1).Top = .cmd(1).Top * 3.5
      .Show vbModal, Me
      mOk = .Ok
      mCajas = .RichTextBox1.Text
   End With
   Unload oF
   Set oF = Nothing
   If Not mOk Then Exit Sub
   
   mError = ""
   mVector = VBA.Split(mCajas, vbCrLf)
   For i = 0 To UBound(mVector)
      If Len(mVector(i)) > 0 And IsNumeric(mVector(i)) Then
         mNumeroCaja = Val(mVector(i))
         
         Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorNumeroCaja", mNumeroCaja)
         If oRs.RecordCount > 0 Then
            mPeso = IIf(IsNull(oRs.Fields("CantidadUnidades").Value), 0, oRs.Fields("CantidadUnidades").Value)
            mIdUbicacion = IIf(IsNull(oRs.Fields("IdUbicacion").Value), 0, oRs.Fields("IdUbicacion").Value)
            mCodArt = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
            mPartida = IIf(IsNull(oRs.Fields("Partida").Value), "", oRs.Fields("Partida").Value)
            mIdArticulo = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
            mIdUnidad = IIf(IsNull(oRs.Fields("IdUnidad").Value), 0, oRs.Fields("IdUnidad").Value)
            mIdObra = IIf(IsNull(oRs.Fields("IdObra").Value), 0, oRs.Fields("IdObra").Value)
            mArticulo = IIf(IsNull(oRs.Fields("Articulo").Value), "", oRs.Fields("Articulo").Value)
            mUnidad = IIf(IsNull(oRs.Fields("Un").Value), "", oRs.Fields("Un").Value)
            mUbicacion = IIf(IsNull(oRs.Fields("Ubicacion").Value), "", oRs.Fields("Ubicacion").Value)
            mObra = IIf(IsNull(oRs.Fields("Obra").Value), "", oRs.Fields("Obra").Value)
            mColor = IIf(IsNull(oRs.Fields("Color").Value), "", oRs.Fields("Color").Value)
            
            With oRsCambios
               mEsta = False
               If .RecordCount > 0 Then
                  .MoveFirst
                  Do While Not .EOF
                     If .Fields("Nro.Caja").Value = mNumeroCaja Then
                        mEsta = True
                        Exit Do
                     End If
                     .MoveNext
                  Loop
               End If
               If Not mEsta Then
                  .AddNew
                  .Fields("IdAux").Value = 0
                  .Fields("Codigo").Value = mCodArt
                  .Fields("Articulo").Value = mArticulo
                  .Fields("IdArticulo").Value = mIdArticulo
                  .Fields("IdUbicacion").Value = mIdUbicacion
                  .Fields("IdObra").Value = mIdObra
                  .Fields("IdUnidad").Value = mIdUnidad
                  .Fields("Ubicacion").Value = mUbicacion
                  .Fields("Partida").Value = mPartida
                  .Fields("Nro.Caja").Value = mNumeroCaja
                  .Fields("Cantidad").Value = mPeso
                  .Fields("Un.").Value = mUnidad
                  .Fields("Obra").Value = mObra
                  .Fields("Vector_T").Value = mVectorT
                  .Fields("Vector_X").Value = mVectorX
                  .Update
               End If
            End With
            
            If Not mEsta Then
               Set oL = Lista.ListItems.Add
               oL.Tag = 0
               oL.Text = mCodArt
               oL.SubItems(1) = "" & mIdArticulo
               oL.SubItems(2) = "" & mIdUbicacion
               oL.SubItems(3) = "" & mIdObra
               oL.SubItems(4) = "" & mIdUnidad
               oL.SubItems(5) = "" & mArticulo
               oL.SubItems(6) = "" & mUbicacion
               oL.SubItems(7) = "" & mPartida
               oL.SubItems(8) = "" & mNumeroCaja
               oL.SubItems(9) = "" & mPeso
               oL.SubItems(10) = "" & mUnidad
               oL.SubItems(11) = "" & mObra
            End If
         End If
         oRs.Close
      End If
Proximo:
   Next
   
   Set oRs = Nothing
   
End Sub

