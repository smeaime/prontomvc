VERSION 5.00
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form frmEtiquetas 
   Caption         =   "Etiquetar sobrante"
   ClientHeight    =   3435
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10800
   LinkTopic       =   "Form1"
   ScaleHeight     =   3435
   ScaleWidth      =   10800
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdPesoBruto 
      Caption         =   "..."
      Height          =   315
      Left            =   3120
      TabIndex        =   33
      Top             =   1440
      Width           =   495
   End
   Begin VB.TextBox txtNumeroCajaReimpresion 
      Alignment       =   2  'Center
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
      Left            =   5550
      TabIndex        =   31
      Top             =   4560
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.CommandButton cmd 
      Cancel          =   -1  'True
      Caption         =   "Reimprimir etiqueta"
      CausesValidation=   0   'False
      Height          =   405
      Index           =   2
      Left            =   6240
      TabIndex        =   30
      Top             =   5040
      Width           =   1620
   End
   Begin VB.TextBox txtUnidades 
      Alignment       =   2  'Center
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
      Left            =   4800
      TabIndex        =   9
      Top             =   2400
      Width           =   1095
   End
   Begin VB.TextBox txtTara 
      Alignment       =   2  'Center
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
      Left            =   4800
      TabIndex        =   5
      Top             =   1920
      Width           =   1095
   End
   Begin VB.TextBox txtPesoBruto 
      Alignment       =   2  'Center
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
      Left            =   2040
      TabIndex        =   4
      Top             =   1440
      Width           =   1095
   End
   Begin VB.TextBox txtNumeroCaja 
      Alignment       =   2  'Center
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   2040
      TabIndex        =   8
      Top             =   2400
      Width           =   1095
   End
   Begin VB.TextBox txtCaracteristicas 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   2160
      TabIndex        =   2
      Top             =   5520
      Width           =   8565
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Salir"
      CausesValidation=   0   'False
      Height          =   405
      Index           =   1
      Left            =   9000
      TabIndex        =   11
      Top             =   2895
      Width           =   1620
   End
   Begin VB.CommandButton cmd 
      Caption         =   "Emitir etiqueta"
      Height          =   405
      Index           =   0
      Left            =   7200
      TabIndex        =   10
      Top             =   2880
      Width           =   1620
   End
   Begin VB.TextBox txtPesoNeto 
      Alignment       =   2  'Center
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
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
      Height          =   315
      Left            =   8400
      TabIndex        =   6
      Top             =   1920
      Width           =   1095
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
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   5460
      TabIndex        =   12
      Top             =   4860
      Width           =   2490
   End
   Begin VB.TextBox txtPartida 
      Alignment       =   2  'Center
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.00"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   11274
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   2040
      TabIndex        =   7
      Top             =   1920
      Width           =   1095
   End
   Begin VB.TextBox txtCodigoArticulo 
      Alignment       =   2  'Center
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0.000"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Enabled         =   0   'False
      Height          =   315
      Left            =   2040
      TabIndex        =   0
      Top             =   120
      Width           =   1725
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   1
      Left            =   3960
      TabIndex        =   1
      Tag             =   "Articulos"
      Top             =   120
      Width           =   6645
      _ExtentX        =   11721
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdArticulo"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   0
      Left            =   2040
      TabIndex        =   3
      Tag             =   "Unidades"
      Top             =   600
      Width           =   1680
      _ExtentX        =   2963
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   3
      Left            =   8400
      TabIndex        =   26
      Tag             =   "Colores"
      Top             =   600
      Width           =   2235
      _ExtentX        =   3942
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdColor"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   4
      Left            =   4800
      TabIndex        =   28
      Tag             =   "Unidades"
      Top             =   1440
      Width           =   1680
      _ExtentX        =   2963
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "Titulo"
      BoundColumn     =   "IdUnidad"
      Text            =   ""
   End
   Begin MSDataListLib.DataCombo DataCombo1 
      Height          =   315
      Index           =   2
      Left            =   4800
      TabIndex        =   24
      Tag             =   "Ubicaciones"
      Top             =   600
      Width           =   2115
      _ExtentX        =   3731
      _ExtentY        =   556
      _Version        =   393216
      Enabled         =   0   'False
      ListField       =   "Titulo"
      BoundColumn     =   "IdUbicacion"
      Text            =   ""
   End
   Begin VB.Line Line1 
      X1              =   120
      X2              =   10440
      Y1              =   1080
      Y2              =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de caja :"
      Height          =   300
      Index           =   13
      Left            =   4065
      TabIndex        =   32
      Top             =   4560
      Visible         =   0   'False
      Width           =   1320
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tipo caja :"
      Height          =   255
      Index           =   12
      Left            =   3840
      TabIndex        =   29
      Top             =   1560
      Width           =   780
   End
   Begin VB.Label lblLabels 
      Caption         =   "Color :"
      Enabled         =   0   'False
      Height          =   255
      Index           =   11
      Left            =   7440
      TabIndex        =   27
      Top             =   720
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Ubicacion :"
      Enabled         =   0   'False
      Height          =   255
      Index           =   10
      Left            =   3960
      TabIndex        =   25
      Top             =   720
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Unidad articulo : "
      Enabled         =   0   'False
      Height          =   255
      Index           =   9
      Left            =   135
      TabIndex        =   23
      Top             =   720
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Unid.x caja :"
      Height          =   255
      Index           =   8
      Left            =   3840
      TabIndex        =   22
      Top             =   2520
      Width           =   915
   End
   Begin VB.Label lblLabels 
      Caption         =   "Tara :"
      Height          =   255
      Index           =   6
      Left            =   3840
      TabIndex        =   21
      Top             =   2040
      Width           =   780
   End
   Begin VB.Label lblLabels 
      Caption         =   "Peso bruto :"
      Height          =   300
      Index           =   5
      Left            =   120
      TabIndex        =   20
      Top             =   1560
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Numero de caja :"
      Height          =   300
      Index           =   4
      Left            =   120
      TabIndex        =   19
      Top             =   2520
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Descripcion etiqueta :"
      Height          =   300
      Index           =   3
      Left            =   480
      TabIndex        =   18
      Top             =   5520
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Peso neto : "
      Height          =   255
      Index           =   1
      Left            =   7320
      TabIndex        =   17
      Top             =   2040
      Width           =   870
   End
   Begin VB.Label lblLabels 
      Caption         =   "Buscar :"
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
      Index           =   14
      Left            =   4560
      TabIndex        =   16
      Top             =   4905
      Width           =   825
   End
   Begin VB.Label lblLabels 
      Caption         =   "Partida"
      Height          =   300
      Index           =   7
      Left            =   120
      TabIndex        =   15
      Top             =   2040
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Articulo :"
      Enabled         =   0   'False
      Height          =   255
      Index           =   2
      Left            =   120
      TabIndex        =   14
      Top             =   240
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "Codigo de articulo :"
      Height          =   300
      Index           =   0
      Left            =   735
      TabIndex        =   13
      Top             =   4860
      Width           =   1815
   End
End
Attribute VB_Name = "frmEtiquetas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public mIdUnidadEmpaque As Long
Public bSaltarseAjuste As Boolean

Dim mNumeroCaja As Integer
Dim mIdObra As Integer


Private Sub cmd_Click(Index As Integer)

   Select Case Index
      Case 0
         If Not IsNumeric(DataCombo1(0).BoundText) Then
            MsgBox "Falta la unidad", vbExclamation
            Exit Sub
         End If
         If Not IsNumeric(DataCombo1(1).BoundText) Then
            MsgBox "Falta el articulo", vbExclamation
            Exit Sub
         End If
         If Not IsNumeric(DataCombo1(2).BoundText) Then
            MsgBox "Falta la ubicacion", vbExclamation
            Exit Sub
         End If
         If DataCombo1(3).Visible And Not IsNumeric(DataCombo1(3).BoundText) Then
            MsgBox "Falta el color", vbExclamation
            Exit Sub
         End If
         If Not IsNumeric(DataCombo1(4).BoundText) Then
            MsgBox "Falta el tipo de caja", vbExclamation
            Exit Sub
         End If
         If Len(txtPesoBruto.Text) = 0 Then
            MsgBox "Falta el peso bruto", vbExclamation
            Exit Sub
         End If
         If Len(txtTara.Text) = 0 Then
            MsgBox "Falta la tara", vbExclamation
            Exit Sub
         End If
'         If Len(txtUnidades.Text) = 0 Then
'            MsgBox "Faltan las unidades", vbExclamation
'            Exit Sub
'         End If
         If Len(txtPartida.Text) = 0 Then
            MsgBox "Falta la partida", vbExclamation
            Exit Sub
         End If
         
         Dim oRs As ADOR.Recordset
         Dim mZebra As String, mCodigo As String, mDescripcion As String, mPartida As String, mPeso1 As String
         Dim mNumeroCaja As String, mPesoBruto As String, mTara As String, mUnidades As String, mSP As String
         Dim mColor As String
         Dim mIdStock As Long, mNumeroAjusteStock As Long, mIdObraDefault As Long
         Dim mIdAjusteStock As Long, mIdDetalleAjusteStock As Long, mNumeroCaja1 As Long, mIdColor As Long
         Dim mPeso As Long
         Dim mAux1
         Dim oAju As ComPronto.AjusteStock
         Dim oPar As ComPronto.Parametro
      
         mIdColor = 0
         If DataCombo1(3).Visible Then mIdColor = DataCombo1(3).BoundText
         
         mAux1 = TraerValorParametro2("ProximoNumeroCajaStock")
         If IsNull(mAux1) Then mAux1 = 1
         txtNumeroCaja.Text = mAux1
         
         mPeso1 = txtPesoNeto.Text
         mPeso = Val(txtPesoNeto.Text * 100)
         mPesoBruto = txtPesoBruto.Text
         mTara = txtTara.Text
         mDescripcion = txtCaracteristicas.Text
         mPartida = txtPartida.Text
         mUnidades = txtUnidades.Text
         mColor = DataCombo1(3).Text
         
         If txtNumeroCajaReimpresion.Visible Then
            mNumeroCaja1 = Val(txtNumeroCajaReimpresion.Text)
            mNumeroCaja = Format(Val(txtNumeroCajaReimpresion.Text), "000000")
         Else
            mNumeroCaja1 = Val(txtNumeroCaja.Text)
            mNumeroCaja = Format(Val(txtNumeroCaja.Text), "000000")
         End If
         
         mCodigo = txtCodigoArticulo.Text & mId("                    ", 1, 20 - Len(txtCodigoArticulo.Text))
         
         mCodigo = mCodigo & mPartida & mId("      ", 1, Abs(6 - Len(mPartida)))
         If mNumeroCaja1 > 0 Then
            mCodigo = mCodigo & "C" & mNumeroCaja
         Else
            mCodigo = mCodigo & "K" & mId("000000", 1, 6 - Len(CStr(mPeso))) & CStr(mPeso)
         End If
         
         mZebra = "" & vbCrLf & "FR" & Chr(34) & "PruebaPr" & Chr(34) & vbCrLf & "?" & vbCrLf
         mZebra = mZebra & mId(mDescripcion, 1, 35) & vbCrLf
         mZebra = mZebra & mCodigo & vbCrLf
         If Len(mDescripcion) > 35 Then
            mZebra = mZebra & mId(mDescripcion, 36, 35) & vbCrLf
         Else
            mZebra = mZebra & " " & vbCrLf
         End If
         mZebra = mZebra & mPartida & vbCrLf
         mZebra = mZebra & mNumeroCaja & vbCrLf
         mZebra = mZebra & mPesoBruto & vbCrLf
         mZebra = mZebra & mTara & vbCrLf
         mZebra = mZebra & mPeso1 & vbCrLf
         mZebra = mZebra & Date & vbCrLf
         mZebra = mZebra & mUnidades & vbCrLf
         mZebra = mZebra & mColor & vbCrLf
         mZebra = mZebra & "P1" & vbCrLf
         
         If Not txtNumeroCajaReimpresion.Visible Then
            Set oRs = Aplicacion.UnidadesEmpaque.TraerFiltrado("_PorNumero", mNumeroCaja1)
            If oRs.RecordCount > 0 Then
               MsgBox "Este numero de caja ya fue utilizado, revise el numerador de cajas!", vbExclamation
               oRs.Close
               Set oRs = Nothing
               Exit Sub
            End If
            oRs.Close
         End If
         
         Me.Enabled = False
         
         Me.MousePointer = vbHourglass
         
         GuardarArchivoSecuencial "c:\Zebra.txt", mZebra
         EsperarShell ("Copy c:\Zebra.txt lpt1")
         Me.MousePointer = vbNormal
   
         If txtNumeroCajaReimpresion.Visible Then
            EstadoControles True
            Exit Sub
         End If
         
         
         mAux1 = TraerValorParametro2("IdObraDefault")
         If IsNull(mAux1) Then
            mIdObraDefault = 0
         Else
            mIdObraDefault = mAux1
         End If

        mAux1 = mIdObra
'         mIdStock = -1
'         Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_STK", _
'                     Array(DataCombo1(1).BoundText, txtPartida.Text, DataCombo1(2).BoundText, 0, _
'                           DataCombo1(0).BoundText, Val(txtNumeroCaja.Text)))
'         If oRs.RecordCount > 0 Then mIdStock = oRs.Fields(0).Value
'         oRs.Close
'
'         mSP = "Stock_A"
'         If mIdStock > 0 Then mSP = "Stock_M"
'         Aplicacion.Tarea mSP, Array(mIdStock, DataCombo1(1).BoundText, txtPartida.Text, mPeso1, 0, _
'                                     DataCombo1(0).BoundText, DataCombo1(2).BoundText, 0, Val(txtNumeroCaja.Text), 0)
         
         
         If Not bSaltarseAjuste Then
            mIdAjusteStock = -1
            mIdDetalleAjusteStock = -1
            Set oRs = Aplicacion.AjustesStock.TraerFiltrado("_PorMarbete", mNumeroCaja1)
            If oRs.RecordCount > 0 Then
               mIdAjusteStock = oRs.Fields(0).Value
               mNumeroAjusteStock = oRs.Fields("NumeroAjusteStock").Value
            End If
            oRs.Close
            
            If mIdAjusteStock = -1 Then
               Set oPar = Aplicacion.Parametros.Item(1)
               With oPar.Registro
                  mNumeroAjusteStock = .Fields("ProximoNumeroAjusteStock").Value
                  .Fields("ProximoNumeroAjusteStock").Value = mNumeroAjusteStock + 1
               End With
               oPar.Guardar
               Set oPar = Nothing
            Else
               Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetAjustesStock", "AjStk", mIdAjusteStock)
               If oRs.RecordCount > 0 Then
                  mIdDetalleAjusteStock = oRs.Fields(0).Value
               End If
               oRs.Close
            End If
            
            Set oAju = Aplicacion.AjustesStock.Item(mIdAjusteStock)
            With oAju
               With .Registro
                  .Fields("NumeroAjusteStock").Value = mNumeroAjusteStock
                  .Fields("FechaAjuste").Value = Date
                  .Fields("Observaciones").Value = "Ingreso por etiquetado." '& vbCrLf & rchObservaciones.Text
                  .Fields("IdRealizo").Value = glbIdUsuario
                  .Fields("FechaRegistro").Value = Now
                  .Fields("NumeroMarbete").Value = mNumeroCaja1
                  .Fields("TipoAjuste").Value = "P"
                  .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                  .Fields("FechaIngreso").Value = Now
               End With
               With .DetAjustesStock.Item(mIdDetalleAjusteStock)
                  With .Registro
                     .Fields("IdArticulo").Value = DataCombo1(1).BoundText
                     .Fields("Partida").Value = txtPartida.Text
                     .Fields("CantidadUnidades").Value = mPeso1
                     .Fields("IdUnidad").Value = DataCombo1(0).BoundText
                     .Fields("Observaciones").Value = "Ingreso por etiquetado"
                     .Fields("IdUbicacion").Value = DataCombo1(2).BoundText
                     .Fields("IdObra").Value = mIdObraDefault
                     .Fields("NumeroCaja").Value = mNumeroCaja1
                  End With
                  .Modificado = True
               End With
               .Guardar
            End With
            Set oAju = Nothing
         End If
         
         mIdUnidadEmpaque = -1
         Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("UnidadesEmpaque", "_PorNumero", mNumeroCaja1)
         If oRs.RecordCount > 0 Then mIdUnidadEmpaque = oRs.Fields(0).Value
         oRs.Close
         
         mSP = "UnidadesEmpaque_A"
         If mIdAjusteStock > 0 Then mSP = "UnidadesEmpaque_M"
         Aplicacion.Tarea mSP, Array(mIdUnidadEmpaque, mNumeroCaja1, DataCombo1(1).BoundText, txtPartida.Text, _
                                    DataCombo1(0).BoundText, mPesoBruto, mTara, mPeso1, 0, Now, _
                                    DataCombo1(2).BoundText, mIdColor, DataCombo1(4).BoundText)
       
         GuardarValorParametro2 "ProximoNumeroCajaStock", "" & (mNumeroCaja1 + 1)
         txtNumeroCaja.Text = mNumeroCaja1 + 1
         txtPesoBruto.Text = ""
         
         Set oRs = Nothing
            Unload Me
      Case 1
        mIdUnidadEmpaque = -2
         Unload Me
   
      Case 2
         lblLabels(13).Visible = True
         txtNumeroCajaReimpresion.Visible = True
         txtNumeroCajaReimpresion.SetFocus

   End Select

End Sub

Public Sub HabilitarTodosLosControles()
    EstadoControles True
End Sub

Private Sub cmdPesoBruto_Click()

    Dim oF As frmConexionBalanza
    Dim mOk As Boolean
    
    mOk = False
    
    Set oF = New frmConexionBalanza
    oF.Show vbModal
    txtPesoBruto.Text = oF.txtLectura.Text
    If Len(oF.txtLectura.Text) > 0 Then mOk = True
    Set oF = Nothing
    
    If mOk Then cmd_Click 0
    
End Sub

Private Sub DataCombo1_Change(Index As Integer)

   Dim oRs As ADOR.Recordset
   
   Select Case Index
      Case 0
      
      Case 1
         If IsNumeric(DataCombo1(Index).BoundText) Then
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then
               txtCodigoArticulo.Text = IIf(IsNull(oRs.Fields("Codigo").Value), "", oRs.Fields("Codigo").Value)
               txtCaracteristicas.Text = IIf(IsNull(oRs.Fields("Caracteristicas").Value), "", oRs.Fields("Caracteristicas").Value)
               If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                  DataCombo1(0).BoundText = oRs.Fields("IdUnidad").Value
               End If
            End If
            oRs.Close
         End If
   
      Case 4
         If IsNumeric(DataCombo1(Index).BoundText) Then
            Set oRs = Aplicacion.Unidades.TraerFiltrado("_PorId", DataCombo1(Index).BoundText)
            If oRs.RecordCount > 0 Then
               If Not IsNull(oRs.Fields("UnidadesPorPack").Value) Then
                  txtUnidades.Text = oRs.Fields("UnidadesPorPack").Value
               Else
                  txtUnidades.Text = ""
               End If
               If Not IsNull(oRs.Fields("TaraEnKg").Value) Then
                  txtTara.Text = oRs.Fields("TaraEnKg").Value
               Else
                  txtTara.Text = ""
               End If
            End If
            oRs.Close
         End If
   End Select
      
   Set oRs = Nothing
      
End Sub

Private Sub DataCombo1_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub


Function Init(IdArticulo, IdColor, IdUnidad, idUbicacion, Cantidad, IdObra, NumeroCaja, partida)

   Dim lReturn As Long
   Dim mAux1
   Dim oRs As ADOR.Recordset

'   mLOCALE_SMONDECIMALSEP = GetRegionalSetting(LOCALE_SMONDECIMALSEP)
'   If mLOCALE_SMONDECIMALSEP <> "." Then
'      lReturn = SetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SMONDECIMALSEP, ".")
'   End If'

'   mLOCALE_SMONTHOUSANDSEP = GetRegionalSetting(LOCALE_SMONTHOUSANDSEP)
'   If mLOCALE_SMONTHOUSANDSEP <> "," Then
'      lReturn = SetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SMONTHOUSANDSEP, ",")
'   End If

'   mLOCALE_SDECIMAL = GetRegionalSetting(LOCALE_SDECIMAL)
'   If mLOCALE_SDECIMAL <> "." Then
'      lReturn = SetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SDECIMAL, ".")
'   End If

'   mLOCALE_STHOUSAND = GetRegionalSetting(LOCALE_STHOUSAND)
'   If mLOCALE_STHOUSAND <> "," Then
 '     lReturn = SetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_STHOUSAND, ",")
 '  End If

   'AnalizarStringConnection
   
 '  Set Aplicacion = CreateObject("ComPronto.Aplicacion")
 '  Aplicacion.StringConexion = glbStringConexion
   
   Set DataCombo1(0).RowSource = Aplicacion.Unidades.TraerLista
   Set DataCombo1(1).RowSource = Aplicacion.Articulos.TraerLista
   Set DataCombo1(2).RowSource = Aplicacion.Ubicaciones.TraerLista
   Set DataCombo1(3).RowSource = Aplicacion.Colores.TraerLista
   Set DataCombo1(4).RowSource = Aplicacion.Unidades.TraerLista
   DataCombo1(4).BoundText = 10
   
   DataCombo1(1).BoundText = IdArticulo
   DataCombo1(3).BoundText = iisNull(IdColor, 10)
   DataCombo1(0).BoundText = iisNull(IdUnidad, 1)
   DataCombo1(2).BoundText = iisNull(idUbicacion, 1)
     
txtPartida = partida
     
     txtPesoNeto.Text = Cantidad
     txtPesoBruto.Text = Cantidad + 1
   
   
   mAux1 = TraerValorParametro2("ProximoNumeroCajaStock")
   If Not IsNull(mAux1) And IsNumeric(mAux1) Then
      txtNumeroCaja.Text = mAux1
   Else
      txtNumeroCaja.Text = 1
   End If
   
   
   
   UsuarioSistema = GetCurrentUserName()
   UsuarioSistema = mId(UsuarioSistema, 1, Len(UsuarioSistema) - 1)
   glbAdministrador = False
   glbIdUsuario = -1
   Set oRs = Aplicacion.Empleados.TraerFiltrado("_usuarioNT", UsuarioSistema)
   With oRs
      If .RecordCount > 0 Then
         UsuarioSistema = UsuarioSistema & " [ " & IIf(IsNull(.Fields("Nombre").Value), " ", .Fields("Nombre").Value) & " ]"
         glbNombreUsuario = .Fields("Nombre").Value
         glbIdUsuario = oRs.Fields(0).Value
         If Not IsNull(oRs.Fields("Administrador").Value) Then
            If oRs.Fields("Administrador").Value = "SI" Then
               glbAdministrador = True
            End If
         End If
      End If
      .Close
   End With
   
   Set oRs = Nothing


End Function

Private Sub Form_Paint()

   'Degradado Me

End Sub

Private Sub Form_Unload(Cancel As Integer)

   'Set Aplicacion = Nothing

End Sub

Public Sub AnalizarStringConnection()

   On Error GoTo 0
   
   Dim mArchivoDefinicionConexion As String, mPronto As String
   
   mPronto = "M:\Pronto"
   mArchivoDefinicionConexion = Dir(mPronto, vbArchive)
   If mArchivoDefinicionConexion = "" Then
      mPronto = app.Path & "\" & app.Title
      mArchivoDefinicionConexion = Dir(mPronto, vbArchive)
      If mArchivoDefinicionConexion = "" Then Exit Sub
   End If
   
   Dim MydsEncrypt As dsEncrypt
   Dim mArchivoConexion As String, mConexion As String, mEmpresa As String
   Dim mString As String
   Dim i As Integer, mPos As Integer
   Dim mVariosString As Boolean, mOk As Boolean
   Dim mVectorConexiones, mVectorConexion
   
   Set MydsEncrypt = New dsEncrypt
   MydsEncrypt.KeyString = ("EDS")
   
   mArchivoConexion = LeerArchivoSecuencial(mPronto)
   Do While Len(mArchivoConexion) > 0 And _
         (Asc(right(mArchivoConexion, 1)) = 10 Or Asc(right(mArchivoConexion, 1)) = 13)
      mArchivoConexion = mId(mArchivoConexion, 1, Len(mArchivoConexion) - 1)
   Loop
   mArchivoConexion = MydsEncrypt.Encrypt(mArchivoConexion)
   mVectorConexiones = VBA.Split(mArchivoConexion, vbCrLf)

   mVariosString = False
   mConexion = ""
   mEmpresa = ""
   For i = 0 To UBound(mVectorConexiones)
      If Len(mVectorConexiones(i)) > 0 Then
         mVectorConexion = VBA.Split(mVectorConexiones(i), "|")
         If Len(mVectorConexion(1)) > 0 Then
            If Len(mConexion) > 0 Then
               mVariosString = True
            Else
               mEmpresa = mVectorConexion(0)
               mConexion = mVectorConexion(1)
            End If
         End If
      End If
   Next
   
   If Not mVariosString Then
      
      mString = MydsEncrypt.Encrypt(mConexion)
'      GuardarArchivoSecuencial GetWinDir & "\" & App.Title, mString
   
   Else
      
      Dim oRs As ADOR.Recordset
      Set oRs = CreateObject("Ador.Recordset")
      With oRs
         .Fields.Append "IdAux", adInteger
         .Fields.Append "Titulo", adVarChar, 250
         .Open
      End With
      For i = 0 To UBound(mVectorConexiones)
         If Len(mVectorConexiones(i)) > 0 Then
            mVectorConexion = VBA.Split(mVectorConexiones(i), "|")
            If Len(mVectorConexion(1)) > 0 Then
               oRs.AddNew
               oRs.Fields("IdAux").Value = i
               oRs.Fields("Titulo").Value = mVectorConexion(0)
               oRs.Update
            End If
         End If
      Next
   
      Dim oF As frmStringConnection
      Set oF = New frmStringConnection
      With oF
         Set .RecordsetDeStrings = oRs
         .Show vbModal, Me
         mOk = .Ok
         If mOk Then
            If IsNumeric(.DataCombo1(0).BoundText) Then
               mPos = .DataCombo1(0).BoundText
            Else
               mPos = -1
            End If
         End If
      End With
      Unload oF
      Set oF = Nothing
      Set oRs = Nothing
   
      If Not mOk Then End
   
      If mPos <> -1 Then
         mVectorConexion = VBA.Split(mVectorConexiones(mPos), "|")
         mEmpresa = mVectorConexion(0)
         mString = mVectorConexion(1)
         mString = MydsEncrypt.Encrypt(mString)
'         GuardarArchivoSecuencial GetWinDir & "\" & App.Title, mString
      Else
         End
      End If
   
   End If

   Set MydsEncrypt = Nothing
   
   glbStringConexion = mString
   glbEmpresaSegunString = mEmpresa
   
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
            Set oRs = Aplicacion.Articulos.TraerFiltrado("_Busca", txtBusca.Text)
         Else
            Set oRs = Aplicacion.Articulos.TraerLista
         End If
         Set DataCombo1(1).RowSource = oRs
         If oRs.RecordCount > 0 Then
            DataCombo1(1).BoundText = oRs.Fields(0).Value
         End If
         Set oRs = Nothing
      End If
      DataCombo1(1).SetFocus
      SendKeys "%{DOWN}"
   End If

End Sub

Private Sub txtCodigoArticulo_GotFocus()

   With txtCodigoArticulo
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtCodigoArticulo_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtCodigoArticulo_Validate(Cancel As Boolean)

   If Len(txtCodigoArticulo.Text) <> 0 Then
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.Articulos.TraerFiltrado("_PorCodigo", txtCodigoArticulo.Text)
      If oRs.RecordCount > 0 Then
         DataCombo1(1).BoundText = oRs.Fields(0).Value
      Else
         MsgBox "Codigo de material incorrecto", vbExclamation
         Cancel = True
         txtCodigoArticulo.Text = ""
      End If
      oRs.Close
      Set oRs = Nothing
   End If
   
End Sub

Private Sub txtNumeroCaja_GotFocus()

   With txtNumeroCaja
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtNumeroCaja_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroCajaReimpresion_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtNumeroCajaReimpresion_LostFocus()

   If Len(txtNumeroCajaReimpresion.Text) = 0 Then
      EstadoControles True
   Else
      Dim oRs As ADOR.Recordset
      Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("Stock", "_PorNumeroCaja", txtNumeroCajaReimpresion.Text)
      With oRs
         If .RecordCount > 0 Then
            EstadoControles False
            txtCodigoArticulo.Text = IIf(IsNull(.Fields("Codigo").Value), "", .Fields("Codigo").Value)
            txtCaracteristicas.Text = IIf(IsNull(.Fields("Caracteristicas").Value), "", .Fields("Caracteristicas").Value)
            txtPartida.Text = IIf(IsNull(.Fields("Partida").Value), "", .Fields("Partida").Value)
            DataCombo1(0).BoundText = .Fields("IdUnidad").Value
            DataCombo1(1).BoundText = .Fields("IdArticulo").Value
            DataCombo1(2).BoundText = .Fields("IdUbicacion").Value
            .Close
            Set oRs = Aplicacion.UnidadesEmpaque.TraerFiltrado("_PorNumero", txtNumeroCajaReimpresion.Text)
            With oRs
               If .RecordCount > 0 Then
                  If Not IsNull(.Fields("IdColor").Value) Then DataCombo1(3).BoundText = .Fields("IdColor").Value
                  If Not IsNull(.Fields("IdUnidadTipoCaja").Value) Then DataCombo1(4).BoundText = .Fields("IdUnidadTipoCaja").Value
                  txtPesoBruto.Text = .Fields("PesoBruto").Value
                  txtTara.Text = .Fields("Tara").Value
                  txtPesoNeto.Text = .Fields("PesoNeto").Value
               End If
               .Close
            End With
         Else
            .Close
            Set oRs = Nothing
            MsgBox "Numero de caja inexistente", vbExclamation
            EstadoControles True
         End If
      End With
   End If

End Sub

Private Sub txtPartida_GotFocus()

   With txtPartida
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPartida_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtPesoBruto_Change()

   CalcularPeso

End Sub

Private Sub txtPesoBruto_GotFocus()

   With txtPesoBruto
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtPesoBruto_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Private Sub txtTara_Change()

   CalcularPeso

End Sub

Private Sub txtTara_GotFocus()

   With txtTara
      .SelStart = 0
      .SelLength = Len(.Text)
   End With

End Sub

Private Sub txtTara_KeyPress(KeyAscii As Integer)

   If KeyAscii = Asc(vbCr) Then SendKeys "{TAB}", True

End Sub

Public Sub CalcularPeso()

   txtPesoNeto.Text = Round(Val(txtPesoBruto.Text) - Val(txtTara.Text), 2)

End Sub

Public Sub EstadoControles(ByVal Estado As Boolean)

   txtCodigoArticulo.Enabled = Estado
   txtPartida.Enabled = Estado
   txtPesoBruto.Enabled = Estado
   txtTara.Enabled = Estado
   txtPesoNeto.Enabled = Estado
   txtUnidades.Enabled = Estado
   DataCombo1(0).Enabled = Estado
   DataCombo1(1).Enabled = Estado
   DataCombo1(2).Enabled = Estado
   DataCombo1(3).Enabled = Estado
   DataCombo1(4).Enabled = Estado
   
   txtNumeroCajaReimpresion.Visible = Not Estado
   lblLabels(13).Visible = Not Estado

End Sub
