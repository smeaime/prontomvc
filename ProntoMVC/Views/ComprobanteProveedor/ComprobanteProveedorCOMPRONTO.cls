#If Debug Then

VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 1  'vbDataSource
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ComprobanteProveedor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Const NombreTabla = "ComprobantesProveedores"
Private mvarID As Long
Public Registro As ador.Recordset
Public Event Actualizado(ByVal Estado As MisEstados, ByVal Id As Long)
Private mvarDetComprobantesProveedores As DetComprobantesProveedores
Private mvarDetComprobantesProveedoresPrv As DetComprobantesProveedoresPrv

Public Property Get DetComprobantesProveedores() As DetComprobantesProveedores
    
   If mvarDetComprobantesProveedores Is Nothing Then
       Set mvarDetComprobantesProveedores = New DetComprobantesProveedores
       Set mvarDetComprobantesProveedores.Parent = Me
   End If
   
   Set DetComprobantesProveedores = mvarDetComprobantesProveedores

End Property

Public Property Set DetComprobantesProveedores(vData As DetComprobantesProveedores)
    
   Set mvarDetComprobantesProveedores = vData

End Property

Public Property Get DetComprobantesProveedoresPrv() As DetComprobantesProveedoresPrv
    
   If mvarDetComprobantesProveedoresPrv Is Nothing Then
       Set mvarDetComprobantesProveedoresPrv = New DetComprobantesProveedoresPrv
       Set mvarDetComprobantesProveedoresPrv.Parent = Me
   End If
   
   Set DetComprobantesProveedoresPrv = mvarDetComprobantesProveedoresPrv

End Property

Public Property Set DetComprobantesProveedoresPrv(vData As DetComprobantesProveedoresPrv)
    
   Set mvarDetComprobantesProveedoresPrv = vData

End Property

Private Sub Class_Terminate()
    
   Set mvarDetComprobantesProveedores = Nothing
   Set mvarDetComprobantesProveedoresPrv = Nothing
   Set Registro = Nothing
   
End Sub

Public Function Guardar() As MisEstados

   Dim oSrv As MTSPronto.ComprobanteProveedor
   Set oSrv = CreateObject("MTSPronto.ComprobanteProveedor")
   
   On Error GoTo MalGuardar
   
   Registro.Update
   Guardar = oSrv.Guardar(Registro, Me.DetComprobantesProveedores.Registros, _
                           Me.RegistroContable, Me.DetComprobantesProveedoresPrv.Registros)
                           
   Set oSrv = Nothing
   
   Exit Function

MalGuardar:
   Err.Raise Err.Number, Err.Source, Err.Description
   Resume

End Function

Public Function GuardarRegistroContable() As MisEstados

   Dim oSrv As MTSPronto.ComprobanteProveedor
   Set oSrv = CreateObject("MTSPronto.ComprobanteProveedor")
   
   On Error GoTo MalGuardar
   
   Registro.Update
   GuardarRegistroContable = oSrv.GuardarRegistroContable(Me.RegistroContable)
   Set oSrv = Nothing
   
   Exit Function

MalGuardar:
   Err.Raise Err.Number, Err.Source, Err.Description
   Resume

End Function

Public Property Let Id(ByVal vData As Long)

   Dim oSrv As InterFazMTS.iCompMTS
   Set oSrv = CreateObject("MTSPronto.ComprobanteProveedor")
   mvarID = vData
   Set Registro = oSrv.LeerUno(NombreTabla, vData)
   Set oSrv = Nothing

End Property

Public Property Get Id() As Long

   Id = mvarID

End Property

Private Sub Class_GetDataMember(DataMember As String, Data As Object)

   Set Data = Registro

End Sub

Public Sub Eliminar()

   Dim oSrv As InterFazMTS.iCompMTS
   Set oSrv = CreateObject("MTSPronto.ComprobanteProveedor")
   
   On Error GoTo MalElim
   
   Registro.Update
   If mvarID > 0 Then
      oSrv.Eliminar NombreTabla, mvarID
   End If
   Set oSrv = Nothing
   
   Exit Sub

MalElim:
   Err.Raise Err.Number, Err.Source, Err.Description
   Resume

End Sub

Public Function RegistroContable() As ador.Recordset

   Dim oSrv As InterFazMTS.iCompMTS
   Dim oRs As ador.Recordset
   Dim oRsCont As ador.Recordset
   Dim oRsDet As ador.Recordset
   Dim oRsDetBD As ador.Recordset
   Dim oFld As ador.Field
   Dim mvarEjercicio As Long, mvarCuentaCompras As Long, mvarCuentaProveedor As Long
   Dim mvarCuentaBonificaciones As Long, mvarCuentaIvaInscripto As Long
   Dim mvarCuentaIvaNoInscripto As Long, mvarCuentaIvaSinDiscriminar As Long
   Dim mvarCuentaComprasTitulo As Long, mvarIdCuenta As Long
   Dim mvarCuentaReintegros As Long
   Dim mvarTotalCompra As Double, mvarImporte As Double, mvarDecimales As Double
   Dim mvarPorcentajeIVA As Double, mvarIVA1 As Double, mvarAjusteIVA As Double
   Dim mvarTotalIVANoDiscriminado As Double, mvarDebe As Double, mvarHaber As Double
   Dim mIdTipoComprobante As Integer, mCoef As Integer, i As Integer
   Dim mvarEsta As Boolean, mvarSubdiarios_ResumirRegistros As Boolean
   
   Set oSrv = CreateObject("MTSPronto.General")
   
   mIdTipoComprobante = Registro.Fields("IdTipoComprobante").Value
   Set oRs = oSrv.LeerUno("TiposComprobante", mIdTipoComprobante)
   mCoef = oRs.Fields("Coeficiente").Value
   oRs.Close
   
   Set oRs = oSrv.LeerUno("Parametros", 1)
   mvarEjercicio = oRs.Fields("EjercicioActual").Value
   mvarCuentaCompras = oRs.Fields("IdCuentaCompras").Value
   mvarCuentaComprasTitulo = oRs.Fields("IdCuentaComprasTitulo").Value
   mvarCuentaBonificaciones = oRs.Fields("IdCuentaBonificaciones").Value
   mvarCuentaIvaInscripto = oRs.Fields("IdCuentaIvaCompras").Value
   mvarCuentaIvaNoInscripto = oRs.Fields("IdCuentaIvaCompras").Value
   mvarCuentaIvaSinDiscriminar = oRs.Fields("IdCuentaIvaSinDiscriminar").Value
   mvarDecimales = oRs.Fields("Decimales").Value
   mvarCuentaProveedor = IIf(IsNull(oRs.Fields("IdCuentaAcreedoresVarios").Value), 0, oRs.Fields("IdCuentaAcreedoresVarios").Value)
   If IsNull(oRs.Fields("Subdiarios_ResumirRegistros").Value) Or oRs.Fields("Subdiarios_ResumirRegistros").Value = "SI" Then
      mvarSubdiarios_ResumirRegistros = True
   Else
      mvarSubdiarios_ResumirRegistros = False
   End If
   mvarCuentaReintegros = IIf(IsNull(oRs.Fields("IdCuentaReintegros").Value), 0, oRs.Fields("IdCuentaReintegros").Value)
   oRs.Close
   
   If Not IsNull(Registro.Fields("IdProveedor").Value) Then
      Set oRs = oSrv.LeerUno("Proveedores", Registro.Fields("IdProveedor").Value)
      If Not IsNull(oRs.Fields("IdCuenta").Value) Then mvarCuentaProveedor = oRs.Fields("IdCuenta").Value
      oRs.Close
   ElseIf Not IsNull(Registro.Fields("IdCuenta").Value) Then
      mvarCuentaProveedor = Registro.Fields("IdCuenta").Value
   ElseIf Not IsNull(Registro.Fields("IdCuentaOtros").Value) Then
      mvarCuentaProveedor = Registro.Fields("IdCuentaOtros").Value
   End If
   
   mvarAjusteIVA = IIf(IsNull(Registro.Fields("AjusteIVA").Value), 0, Registro.Fields("AjusteIVA").Value)
   
   Set oRsCont = CreateObject("ADOR.Recordset")
   Set oRs = oSrv.TraerFiltrado("Subdiarios", "_Estructura")
   
   With oRs
      For Each oFld In .Fields
         With oFld
            oRsCont.Fields.Append .Name, .Type, .DefinedSize, .Attributes
            oRsCont.Fields.Item(.Name).Precision = .Precision
            oRsCont.Fields.Item(.Name).NumericScale = .NumericScale
         End With
      Next
      oRsCont.Open
   End With
   oRs.Close
   
   If Not IsNull(Registro.Fields("Confirmado").Value) And Registro.Fields("Confirmado").Value = "NO" Then
      GoTo Salida
   End If
   
   With oRsCont
      .AddNew
      .Fields("Ejercicio").Value = mvarEjercicio
      .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
      .Fields("IdCuenta").Value = mvarCuentaProveedor
      .Fields("IdTipoComprobante").Value = mIdTipoComprobante
      .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
      .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
      .Fields("IdComprobante").Value = Registro.Fields(0).Value
      If mCoef = 1 Then
         .Fields("Haber").Value = Registro.Fields("TotalComprobante").Value
      Else
         .Fields("Debe").Value = Registro.Fields("TotalComprobante").Value
      End If
      .Update
   End With
   
   If Not IsNull(Registro.Fields("TotalBonificacion").Value) Then
      If Registro.Fields("TotalBonificacion").Value <> 0 Then
         With oRsCont
            .AddNew
            .Fields("Ejercicio").Value = mvarEjercicio
            .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
            .Fields("IdCuenta").Value = mvarCuentaBonificaciones
            .Fields("IdTipoComprobante").Value = mIdTipoComprobante
            .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
            .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
            .Fields("IdComprobante").Value = Registro.Fields(0).Value
            If mCoef = 1 Then
               .Fields("Haber").Value = Registro.Fields("TotalBonificacion").Value
            Else
               .Fields("Debe").Value = Registro.Fields("TotalBonificacion").Value
            End If
            .Update
         End With
      End If
   End If
   
'   If Not IsNull(Registro.Fields("TotalIva1").Value) Then
'      If Registro.Fields("TotalIva1").Value <> 0 Then
'         With oRsCont
'            .AddNew
'            .Fields("Ejercicio").Value = mvarEjercicio
'            .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
'            .Fields("IdCuenta").Value = mvarCuentaIvaInscripto
'            .Fields("IdTipoComprobante").Value = mIdTipoComprobante
'            .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
'            .Fields("FechaComprobante").Value = Registro.Fields("FechaComprobante").Value
'            .Fields("IdComprobante").Value = Registro.Fields(0).Value
'            If mCoef = 1 Then
'               .Fields("Debe").Value = Registro.Fields("TotalIva1").Value
'            Else
'               .Fields("Haber").Value = Registro.Fields("TotalIva1").Value
'            End If
'            .Update
'         End With
'      End If
'   End If
   
'   If Not IsNull(Registro.Fields("TotalIva2").Value) Then
'      If Registro.Fields("TotalIva2").Value <> 0 Then
'         With oRsCont
'            .AddNew
'            .Fields("Ejercicio").Value = mvarEjercicio
'            .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
'            .Fields("IdCuenta").Value = mvarCuentaIvaInscripto
'            .Fields("IdTipoComprobante").Value = mIdTipoComprobante
'            .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
'            .Fields("FechaComprobante").Value = Registro.Fields("FechaComprobante").Value
'            .Fields("IdComprobante").Value = Registro.Fields(0).Value
'            If mCoef = 1 Then
'               .Fields("Debe").Value = Registro.Fields("TotalIva2").Value
'            Else
'               .Fields("Haber").Value = Registro.Fields("TotalIva2").Value
'            End If
'            .Update
'         End With
'      End If
'   End If
   
   Set oRsDet = Me.DetComprobantesProveedores.Registros
   With oRsDet
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               If Not .Fields("Eliminado").Value Then
                  With oRsCont
                     
                     mvarTotalIVANoDiscriminado = 0
                     
                     For i = 1 To 10
                        If oRsDet.Fields("AplicarIVA" & i).Value = "SI" Then

                                    mvarImporte = oRsDet.Fields("Importe").Value
                           mvarPorcentajeIVA = IIf(IsNull(oRsDet.Fields("IVAComprasPorcentaje" & i).Value), 0, oRsDet.Fields("IVAComprasPorcentaje" & i).Value)
                           If Registro.Fields("Letra").Value = "A" Or Registro.Fields("Letra").Value = "M" Then
                              mvarIVA1 = Round(mvarImporte * mvarPorcentajeIVA / 100, mvarDecimales)
                           Else
                              mvarIVA1 = Round((mvarImporte / (1 + (mvarPorcentajeIVA / 100))) * (mvarPorcentajeIVA / 100), mvarDecimales)
                              mvarTotalIVANoDiscriminado = mvarTotalIVANoDiscriminado + mvarIVA1
                           End If
                           If mvarAjusteIVA <> 0 Then
                              mvarIVA1 = mvarIVA1 + mvarAjusteIVA
                              mvarAjusteIVA = 0
                              Registro.Fields("PorcentajeIVAAplicacionAjuste").Value = mvarPorcentajeIVA
                              Registro.Update
                           End If
                           mvarDebe = 0
                           mvarHaber = 0
                           If mCoef = 1 Then
                              If mvarIVA1 >= 0 Then
                                 mvarDebe = mvarIVA1
                              Else
                                 mvarHaber = mvarIVA1 * -1
                              End If
                           Else
                              If mvarIVA1 >= 0 Then
                                 mvarHaber = mvarIVA1
                              Else
                                 mvarDebe = mvarIVA1 * -1
                              End If
                           End If
                           mvarEsta = False
                           If .RecordCount > 0 Then
                              .MoveFirst
                              Do While Not .EOF
                                 If .Fields("IdCuenta").Value = oRsDet.Fields("IdCuentaIvaCompras" & i).Value And _
                                       ((mvarDebe <> 0 And Not IsNull(.Fields("Debe").Value)) Or _
                                          (mvarHaber <> 0 And Not IsNull(.Fields("Haber").Value))) Then
                                    mvarEsta = True
                                    Exit Do
                                 End If
                                 .MoveNext
                              Loop
                           End If
                           If Not mvarEsta Or Not mvarSubdiarios_ResumirRegistros Then .AddNew
                           .Fields("Ejercicio").Value = mvarEjercicio
                           .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
                           .Fields("IdCuenta").Value = oRsDet.Fields("IdCuentaIvaCompras" & i).Value
                           .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                           .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
                           .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
                           .Fields("IdComprobante").Value = Registro.Fields(0).Value
                           If mvarDebe <> 0 Then
                              .Fields("Debe").Value = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value) + mvarDebe
                           Else
                              .Fields("Haber").Value = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value) + mvarHaber
                           End If
                           If Not mvarSubdiarios_ResumirRegistros Then
                              .Fields("IdDetalleComprobante").Value = oRsDet.Fields(0).Value
                           End If
                           .Update
                        End If
                     Next
                     
                     mvarDebe = 0
                     mvarHaber = 0
                     If mCoef = 1 Then
                        mvarDebe = oRsDet.Fields("Importe").Value - mvarTotalIVANoDiscriminado
                     Else
                        mvarHaber = oRsDet.Fields("Importe").Value - mvarTotalIVANoDiscriminado
                     End If
                     mvarIdCuenta = mvarCuentaCompras
                     If Not IsNull(oRsDet.Fields("IdCuenta").Value) Then
                        mvarIdCuenta = oRsDet.Fields("IdCuenta").Value
                     End If
                     mvarEsta = False
                     If .RecordCount > 0 Then
                        .MoveFirst
                        Do While Not .EOF
                           If .Fields("IdCuenta").Value = mvarIdCuenta And _
                                 ((mvarDebe <> 0 And Not IsNull(.Fields("Debe").Value)) Or _
                                    (mvarHaber <> 0 And Not IsNull(.Fields("Haber").Value))) Then
                              mvarEsta = True
                              Exit Do
                           End If
                           .MoveNext
                        Loop
                     End If
                     If Not mvarEsta Or Not mvarSubdiarios_ResumirRegistros Then .AddNew
                     .Fields("Ejercicio").Value = mvarEjercicio
                     .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
                     .Fields("IdCuenta").Value = mvarIdCuenta
                     .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                     .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
                     .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
                     .Fields("IdComprobante").Value = Registro.Fields(0).Value
                     If mvarDebe <> 0 Then
                        If mvarDebe > 0 Then
                           .Fields("Debe").Value = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value) + mvarDebe
                        Else
                           .Fields("Haber").Value = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value) + (mvarDebe * -1)
                        End If
                     Else
                        If mvarHaber > 0 Then
                           .Fields("Haber").Value = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value) + mvarHaber
                        Else
                           .Fields("Debe").Value = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value) + (mvarHaber * -1)
                        End If
                     End If
                     If Not mvarSubdiarios_ResumirRegistros Then
                        .Fields("IdDetalleComprobante").Value = oRsDet.Fields(0).Value
                     End If
                     .Update
                     
                  End With
               End If
               .MoveNext
            Loop
         End If
      End If
   End With
   
   Set oRsDetBD = oSrv.TraerFiltrado("DetComprobantesProveedores", "_PorIdCabecera", Registro.Fields(0).Value)
   With oRsDetBD
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            mvarEsta = False
            If oRsDet.Fields.Count > 0 Then
               If oRsDet.RecordCount > 0 Then
                  oRsDet.MoveFirst
                  Do While Not oRsDet.EOF
                     If .Fields(0).Value = oRsDet.Fields(0).Value Then
                        mvarEsta = True
                        Exit Do
                     End If
                     oRsDet.MoveNext
                  Loop
               End If
            End If
            If Not mvarEsta Then
               With oRsCont
                  .AddNew
                  .Fields("Ejercicio").Value = mvarEjercicio
                  .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
                  If Not IsNull(oRsDetBD.Fields("IdCuenta").Value) Then
                     .Fields("IdCuenta").Value = oRsDetBD.Fields("IdCuenta").Value
                  Else
                     .Fields("IdCuenta").Value = mvarCuentaCompras
                  End If
                  .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                  .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
                  .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
                  .Fields("IdComprobante").Value = Registro.Fields(0).Value
                  If mCoef = 1 Then
                     .Fields("Debe").Value = oRsDetBD.Fields("Importe").Value - mvarTotalIVANoDiscriminado
                  Else
                     .Fields("Haber").Value = oRsDetBD.Fields("Importe").Value - mvarTotalIVANoDiscriminado
                  End If
                  If Not mvarSubdiarios_ResumirRegistros Then
                     .Fields("IdDetalleComprobante").Value = oRsDetBD.Fields(0).Value
                  End If
                  .Update

                  mvarTotalIVANoDiscriminado = 0
                  
                  For i = 1 To 10
                     If oRsDetBD.Fields("AplicarIVA" & i).Value = "SI" Then
                        mvarImporte = oRsDetBD.Fields("Importe").Value
                        mvarPorcentajeIVA = IIf(IsNull(oRsDetBD.Fields("IVAComprasPorcentaje" & i).Value), 0, oRsDetBD.Fields("IVAComprasPorcentaje" & i).Value)
                        If Registro.Fields("Letra").Value = "A" Or Registro.Fields("Letra").Value = "M" Then
                           mvarIVA1 = Round(mvarImporte * mvarPorcentajeIVA / 100, mvarDecimales)
                        Else
                           mvarIVA1 = Round((mvarImporte / (1 + (mvarPorcentajeIVA / 100))) * (mvarPorcentajeIVA / 100), mvarDecimales)
                           mvarTotalIVANoDiscriminado = mvarTotalIVANoDiscriminado + mvarIVA1
                        End If
                        If mvarAjusteIVA <> 0 Then
                           mvarIVA1 = mvarIVA1 + mvarAjusteIVA
                           mvarAjusteIVA = 0
                           Registro.Fields("PorcentajeIVAAplicacionAjuste").Value = mvarPorcentajeIVA
                           Registro.Update
                        End If
                        .AddNew
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
                        .Fields("IdCuenta").Value = oRsDetBD.Fields("IdCuentaIvaCompras" & i).Value
                        .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                        .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
                        .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
                        .Fields("IdComprobante").Value = Registro.Fields(0).Value
                        If mCoef = 1 Then
                           If mvarIVA1 >= 0 Then
                              .Fields("Debe").Value = mvarIVA1
                           Else
                              .Fields("Haber").Value = mvarIVA1 * -1
                           End If
                        Else
                           If mvarIVA1 >= 0 Then
                              .Fields("Haber").Value = mvarIVA1
                           Else
                              .Fields("Debe").Value = mvarIVA1 * -1
                           End If
                        End If
                        If Not mvarSubdiarios_ResumirRegistros Then
                           .Fields("IdDetalleComprobante").Value = oRsDetBD.Fields(0).Value
                        End If
                        .Update
                     End If
                  Next

               End With
            End If
            .MoveNext
         Loop
      End If
      .Close
   End With
   Set oRsDetBD = Nothing
   
   If oRsDet.Fields.Count > 0 Then oRsDet.Close
               
   If Not IsNull(Registro.Fields("ReintegroIdCuenta").Value) Then
      If Registro.Fields("ReintegroImporte").Value <> 0 Then
         With oRsCont
            .AddNew
            .Fields("Ejercicio").Value = mvarEjercicio
            .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
            .Fields("IdCuenta").Value = mvarCuentaReintegros
            .Fields("IdTipoComprobante").Value = mIdTipoComprobante
            .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
            .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
            .Fields("IdComprobante").Value = Registro.Fields(0).Value
            If mCoef = 1 Then
               .Fields("Haber").Value = Registro.Fields("ReintegroImporte").Value
            Else
               .Fields("Debe").Value = Registro.Fields("ReintegroImporte").Value
            End If
            .Update
            .AddNew
            .Fields("Ejercicio").Value = mvarEjercicio
            .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
            .Fields("IdCuenta").Value = Registro.Fields("ReintegroIdCuenta").Value
            .Fields("IdTipoComprobante").Value = mIdTipoComprobante
            .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
            .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
            .Fields("IdComprobante").Value = Registro.Fields(0).Value
            If mCoef = 1 Then
               .Fields("Debe").Value = Registro.Fields("ReintegroImporte").Value
            Else
               .Fields("Haber").Value = Registro.Fields("ReintegroImporte").Value
            End If
            .Update
         End With
      End If
   End If
   
'   mvarDebe = 0
'   mvarHaber = 0
'   With oRsCont
'      If .RecordCount > 0 Then
'         .MoveFirst
'         Do While Not .EOF
'            If Not IsNull(.Fields("Debe").Value) Then
'               mvarDebe = mvarDebe + .Fields("Debe").Value
'            End If
'            If Not IsNull(.Fields("Haber").Value) Then
'               mvarHaber = mvarHaber + .Fields("Haber").Value
'            End If
'            .MoveNext
'         Loop
'         If mvarDebe - mvarHaber <> 0 Then
'            .MoveFirst
'            Do While Not .EOF
'               If Not IsNull(.Fields("Debe").Value) And _
'                     .Fields("Debe").Value > 0 And mCoef = -1 Then
'                  .Fields("Debe").Value = .Fields("Debe").Value + (mvarDebe - mvarHaber)
'                  .Update
'                  Exit Do
'               End If
'               If Not IsNull(.Fields("Haber").Value) And _
'                     .Fields("Haber").Value > 0 And mCoef = 1 Then
'                  .Fields("Haber").Value = .Fields("Haber").Value + (mvarDebe - mvarHaber)
'                  .Update
'                  Exit Do
'               End If
'               .MoveNext
'            Loop
'         End If
'         .MoveFirst
'      End If
'   End With

Salida:

   Set RegistroContable = oRsCont
   
   Set oRsDet = Nothing
   Set oRs = Nothing
   Set oRsCont = Nothing
   Set oSrv = Nothing

End Function

Public Function IdDetalleRecepcion() As Long

   Dim oRs As ador.Recordset
   Dim mIdDetalleRecepcion As Long
   
   Set oRs = Me.DetComprobantesProveedores.TodosLosRegistros
   With oRs
      If .Fields.Count > 0 Then
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               If Not .Fields("Eliminado").Value Then
                  If Not IsNull(.Fields("IdDetalleRecepcion").Value) Then
                     mIdDetalleRecepcion = .Fields("IdDetalleRecepcion").Value
                     Exit Do
                  End If
               End If
               .MoveNext
            Loop
         End If
      End If
   End With

   Set oRs = Nothing

   IdDetalleRecepcion = mIdDetalleRecepcion

End Function

#End If