VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 3  'UsesTransaction
END
Attribute VB_Name = "ComprobanteProveedor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Implements InterFazMTS.iCompMTS

Private Function iCompMTS_Cuenta(ByVal NombreTabla As String) As Long

   Dim oCont As ObjectContext
   Dim oL As GralLector
   Dim lErr As Long, sSource As String, sDesc As String
   
   On Error GoTo Mal
   
   Set oCont = GetObjectContext
   
   If oCont Is Nothing Then
      Set oL = CreateObject("MTSPronto.GralLector")
   Else
      Set oL = oCont.CreateInstance("MTSPronto.GralLector")
   End If
   
   iCompMTS_Cuenta = oL.Cuenta(NombreTabla)
   
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetComplete
      End With
   End If
   
Salir:
   Set oL = Nothing
   Set oCont = Nothing
   On Error GoTo 0
   If lErr Then
      Err.Raise lErr, sSource, sDesc
   End If
   Exit Function
   
Mal:
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetAbort
      End With
   End If
   With Err
      lErr = .Number
      sSource = .Source
      sDesc = .Description
   End With
   Resume Salir

End Function

Private Sub iCompMTS_Eliminar(ByVal NombreTabla As String, ByVal vData As Long)

   Dim oCont As ObjectContext
   Dim oA As GralUpd
   Dim lErr As Long, sSource As String, sDesc As String
   
   On Error GoTo Mal
   
   Set oCont = GetObjectContext
   
   If oCont Is Nothing Then
      Set oA = CreateObject("MTSPronto.GralUpd")
   Else
      Set oA = oCont.CreateInstance("MTSPronto.GralUpd")
   End If
   oA.Eliminar NombreTabla, vData
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetComplete
      End With
   End If
   
Salir:
   Set oA = Nothing
   Set oCont = Nothing
   On Error GoTo 0
   If lErr Then
      Err.Raise lErr, sSource, sDesc
   End If
   Exit Sub
   
Mal:
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetAbort
      End With
   End If
   With Err
      lErr = .Number
      sSource = .Source
      sDesc = .Description
   End With
   Resume Salir

End Sub

Private Function iCompMTS_Guardar(ByVal NombreTabla As String, ByVal vData As ADOR.Recordset) As InterFazMTS.MisEstados

   Dim oCont As ObjectContext
   Dim oA As GralUpd
   Dim lErr As Long, sSource As String, sDesc As String
   
   On Error GoTo Mal
   
   Set oCont = GetObjectContext
   
   If oCont Is Nothing Then
      Set oA = CreateObject("MTSPronto.GralUpd")
   Else
      Set oA = oCont.CreateInstance("MTSPronto.GralUpd")
   End If
   
   iCompMTS_Guardar = oA.Guardar(NombreTabla, vData)
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetComplete
      End With
   End If
   
Salir:
   Set oA = Nothing
   Set oCont = Nothing
   On Error GoTo 0
   If lErr Then
      Err.Raise lErr, sSource, sDesc
   End If
   Exit Function
   
Mal:
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetAbort
      End With
   End If
   With Err
      lErr = .Number
      sSource = .Source
      sDesc = .Description
   End With
   Resume Salir

End Function

Private Function iCompMTS_GuardarPorRef(ByVal NombreTabla As String, ByRef vData As ADOR.Recordset) As InterFazMTS.MisEstados

   Dim oCont As ObjectContext
   Dim oA As GralUpd
   Dim lErr As Long, sSource As String, sDesc As String
   
   On Error GoTo Mal
   
   Set oCont = GetObjectContext
   
   If oCont Is Nothing Then
      Set oA = CreateObject("MTSPronto.GralUpd")
   Else
      Set oA = oCont.CreateInstance("MTSPronto.GralUpd")
   End If
   
   iCompMTS_GuardarPorRef = oA.GuardarPorRef(NombreTabla, vData)
   
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetComplete
      End With
   End If
   
Salir:
   Set oA = Nothing
   Set oCont = Nothing
   On Error GoTo 0
   If lErr Then
      Err.Raise lErr, sSource, sDesc
   End If
   Exit Function
   
Mal:
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetAbort
      End With
   End If
   With Err
      lErr = .Number
      sSource = .Source
      sDesc = .Description
   End With
   Resume Salir

End Function

Private Function iCompMTS_LeerUno(ByVal NombreTabla As String, ByVal vData As Long) As ADOR.Recordset

   Dim oCont As ObjectContext
   Dim oL As GralLector
   Dim lErr As Long, sSource As String, sDesc As String
   
   On Error GoTo Mal
   
   Set oCont = GetObjectContext
   
   If oCont Is Nothing Then
      Set oL = CreateObject("MTSPronto.GralLector")
   Else
      Set oL = oCont.CreateInstance("MTSPronto.GralLector")
   End If
   Set iCompMTS_LeerUno = oL.LeerUno(NombreTabla, vData)
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetComplete
      End With
   End If
   
Salir:
   Set oL = Nothing
   Set oCont = Nothing
   On Error GoTo 0
   If lErr Then
      Err.Raise lErr, sSource, sDesc
   End If
   Exit Function
   
Mal:
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetAbort
      End With
   End If
   With Err
      lErr = .Number
      sSource = .Source
      sDesc = .Description
   End With
   Resume Salir
   
End Function

Private Function iCompMTS_TraerFiltrado(ByVal NombreTabla As String, ByVal Filtro As String, Optional ByVal Args As Variant) As ADOR.Recordset

   Dim oCont As ObjectContext
   Dim oL As GralLector
   Dim lErr As Long, sSource As String, sDesc As String
   
   On Error GoTo Mal
   
   Set oCont = GetObjectContext
   
   If oCont Is Nothing Then
      Set oL = CreateObject("MTSPronto.GralLector")
   Else
      Set oL = oCont.CreateInstance("MTSPronto.GralLector")
   End If
   Set iCompMTS_TraerFiltrado = oL.TraerFiltrado(NombreTabla, Filtro, Args)
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetComplete
      End With
   End If
   
Salir:
   Set oL = Nothing
   Set oCont = Nothing
   On Error GoTo 0
   If lErr Then
      Err.Raise lErr, sSource, sDesc
   End If
   Exit Function
   
Mal:
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetAbort
      End With
   End If
   With Err
      lErr = .Number
      sSource = .Source
      sDesc = .Description
   End With
   Resume Salir


End Function

Private Function iCompMTS_TraerLista(ByVal NombreTabla As String) As ADOR.Recordset

   Dim oCont As ObjectContext
   Dim oL As GralLector
   Dim lErr As Long, sSource As String, sDesc As String
   
   On Error GoTo Mal
   
   Set oCont = GetObjectContext
   
   If oCont Is Nothing Then
      Set oL = CreateObject("MTSPronto.GralLector")
   Else
      Set oL = oCont.CreateInstance("MTSPronto.GralLector")
   End If
   Set iCompMTS_TraerLista = oL.TraerLista(NombreTabla)
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetComplete
      End With
   End If
   
Salir:
   Set oL = Nothing
   Set oCont = Nothing
   On Error GoTo 0
   If lErr Then
      Err.Raise lErr, sSource, sDesc
   End If
   Exit Function
   
Mal:
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetAbort
      End With
   End If
   With Err
      lErr = .Number
      sSource = .Source
      sDesc = .Description
   End With
   Resume Salir


End Function

Private Function iCompMTS_TraerTodos(ByVal NombreTabla As String) As ADOR.Recordset

   Dim oCont As ObjectContext
   Dim oL As GralLector
   Dim lErr As Long, sSource As String, sDesc As String
   
   On Error GoTo Mal
   
   Set oCont = GetObjectContext
   
   If oCont Is Nothing Then
      Set oL = CreateObject("MTSPronto.GralLector")
   Else
      Set oL = oCont.CreateInstance("MTSPronto.GralLector")
   End If
   Set iCompMTS_TraerTodos = oL.TraerTodos(NombreTabla)
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetComplete
      End With
   End If
   
Salir:
   Set oL = Nothing
   Set oCont = Nothing
   On Error GoTo 0
   If lErr Then
      Err.Raise lErr, sSource, sDesc
   End If
   Exit Function
   
Mal:
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetAbort
      End With
   End If
   With Err
      lErr = .Number
      sSource = .Source
      sDesc = .Description
   End With
   Resume Salir

End Function

Public Function Guardar(ByRef ComprobanteProveedor As ADOR.Recordset, _
                        ByVal Detalles As ADOR.Recordset, _
                        ByVal RegistroContable As ADOR.Recordset, _
                        ByVal DetallesProvincias As ADOR.Recordset) As InterFazMTS.MisEstados

   If Not IsNull(ComprobanteProveedor.Fields("Confirmado").Value) And _
         ComprobanteProveedor.Fields("Confirmado").Value = "NO" Then
      Guardar = GuardarNoConfirmados(ComprobanteProveedor, Detalles)
      Exit Function
   End If
   
   Dim oCont As ObjectContext
   Dim oDet As iCompMTS
   Dim Resp As InterFazMTS.MisEstados
   Dim Datos As ADOR.Recordset
   Dim DatosCtaCte As ADOR.Recordset
   Dim DatosCtaCteNv As ADOR.Recordset
   Dim DatosProveedor As ADOR.Recordset
   Dim DetRem As ADOR.Recordset
   Dim DatosAnt As ADOR.Recordset
   Dim DatosAsiento As ADOR.Recordset
   Dim DatosAsientoNv As ADOR.Recordset
   Dim oRsParametros As ADOR.Recordset
   Dim DatosDetAsiento As ADOR.Recordset
   Dim DatosDetAsientoNv As ADOR.Recordset
   Dim oRsValores As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim oFld As ADOR.Field
   Dim lErr As Long, sSource As String, sDesc As String
   Dim i As Integer, mvarCoeficiente As Integer, mvarCoeficienteAnt As Integer
   Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdentificador As Long, mvarIdCuenta As Long, mIdValor As Long, mvarIdProveedorAnterior As Long
   Dim mvarIdTipoComprobanteAnterior As Long, mvarIdBanco As Long, mvarIdCaja As Long, mvarIdOrdenPagoActual As Long, mvarIdOrdenPagoAnterior As Long, mvarAuxL1 As Long
   Dim mvarIdDetalleComprobanteProveedor As Long, mvarIdDetalleComprobanteProveedorAnt As Long, mvarNumeroReferencia As Long, mvarIdTipoCuentaGrupoIVA As Long
   Dim mTotalAnterior As Double, mvarCotizacionAnt As Double, mvarCotizacionDolar As Double, mvarCotizacionMoneda As Double, mTotalAnteriorDolar As Double, mvarDebe As Double
   Dim mvarHaber As Double, mvarCotizacionEuro As Double, mTotalAnteriorEuro As Double, Tot As Double, TotDol As Double, TotEu As Double, Sdo As Double, SdoDol As Double
   Dim SdoEu As Double
   Dim mvarBorrarEnValores As Boolean, mvarSubdiarios_ResumirRegistros As Boolean, mvarOk As Boolean, mvarProcesar As Boolean, mvarGrabarRegistrosEnCuentaCorriente As Boolean
   
   On Error GoTo Mal
   
   Set oCont = GetObjectContext
   
   If oCont Is Nothing Then
      Set oDet = CreateObject("MTSPronto.General")
   Else
      Set oDet = oCont.CreateInstance("MTSPronto.General")
   End If
   
   mvarIdentificador = ComprobanteProveedor.Fields(0).Value
   mvarCotizacionMoneda = IIf(IsNull(ComprobanteProveedor.Fields("CotizacionMoneda").Value), 0, ComprobanteProveedor.Fields("CotizacionMoneda").Value)
   mvarCotizacionDolar = IIf(IsNull(ComprobanteProveedor.Fields("CotizacionDolar").Value), 0, ComprobanteProveedor.Fields("CotizacionDolar").Value)
   mvarCotizacionEuro = IIf(IsNull(ComprobanteProveedor.Fields("CotizacionEuro").Value), 0, ComprobanteProveedor.Fields("CotizacionEuro").Value)
   mvarIdOrdenPagoActual = IIf(IsNull(ComprobanteProveedor.Fields("IdOrdenPago").Value), 0, ComprobanteProveedor.Fields("IdOrdenPago").Value)
   mvarNumeroReferencia = IIf(IsNull(ComprobanteProveedor.Fields("NumeroReferencia").Value), 0, ComprobanteProveedor.Fields("NumeroReferencia").Value)
   
   Set Datos = oDet.LeerUno("Parametros", 1)
   If IsNull(Datos.Fields("Subdiarios_ResumirRegistros").Value) Or Datos.Fields("Subdiarios_ResumirRegistros").Value = "SI" Then
      mvarSubdiarios_ResumirRegistros = True
   Else
      mvarSubdiarios_ResumirRegistros = False
   End If
   mvarIdTipoCuentaGrupoIVA = IIf(IsNull(Datos.Fields("IdTipoCuentaGrupoIVA").Value), 0, Datos.Fields("IdTipoCuentaGrupoIVA").Value)
   Datos.Close
   
   mvarCoeficiente = 1
   Set Datos = oDet.LeerUno("TiposComprobante", ComprobanteProveedor.Fields("IdTipoComprobante").Value)
   If Datos.RecordCount > 0 Then mvarCoeficiente = Datos.Fields("Coeficiente").Value
   Datos.Close
   Set Datos = Nothing
   mvarCoeficienteAnt = mvarCoeficiente
   
   If Not IsNull(ComprobanteProveedor.Fields("IdDiferenciaCambio").Value) Then
      oDet.Tarea "DiferenciasCambio_MarcarComoGenerada", _
            Array(ComprobanteProveedor.Fields("IdDiferenciaCambio").Value, ComprobanteProveedor.Fields("IdTipoComprobante").Value, ComprobanteProveedor.Fields(0).Value)
   End If
   
   mTotalAnterior = 0
   mvarIdProveedorAnterior = 0
   mvarIdTipoComprobanteAnterior = 0
   mvarIdOrdenPagoAnterior = 0
   mvarGrabarRegistrosEnCuentaCorriente = True
   
   If mvarIdentificador > 0 Then
      Set DatosAnt = oDet.LeerUno("ComprobantesProveedores", mvarIdentificador)
      If DatosAnt.RecordCount > 0 Then
         mvarCotizacionAnt = IIf(IsNull(DatosAnt.Fields("CotizacionMoneda").Value), 1, DatosAnt.Fields("CotizacionMoneda").Value)
         mTotalAnterior = DatosAnt.Fields("TotalComprobante").Value * mvarCotizacionAnt
         If Not IsNull(DatosAnt.Fields("IdProveedor").Value) Then
            mvarIdProveedorAnterior = DatosAnt.Fields("IdProveedor").Value
         End If
         If Not IsNull(DatosAnt.Fields("IdTipoComprobante").Value) Then
            mvarIdTipoComprobanteAnterior = DatosAnt.Fields("IdTipoComprobante").Value
         End If
         Set Datos = oDet.LeerUno("TiposComprobante", DatosAnt.Fields("IdTipoComprobante").Value)
         If Datos.RecordCount > 0 Then
            mvarCoeficienteAnt = Datos.Fields("Coeficiente").Value
         End If
         mvarIdOrdenPagoAnterior = IIf(IsNull(DatosAnt.Fields("IdOrdenPago").Value), 0, DatosAnt.Fields("IdOrdenPago").Value)
         Datos.Close
         Set Datos = Nothing
         
         If Not IsNull(DatosAnt.Fields("IdComprobanteImputado").Value) Then
            mvarAuxL1 = 11
            Set oRsAux = oDet.LeerUno("ComprobantesProveedores", DatosAnt.Fields("IdComprobanteImputado").Value)
            If oRsAux.RecordCount > 0 Then
               mvarAuxL1 = oRsAux.Fields("IdTipoComprobante").Value
            End If
            oRsAux.Close
            
            Set DatosCtaCteNv = oDet.TraerFiltrado("CtasCtesA", "_BuscarComprobante", Array(mvarIdentificador, DatosAnt.Fields("IdTipoComprobante").Value))
            If DatosCtaCteNv.RecordCount > 0 Then
               Tot = DatosCtaCteNv.Fields("ImporteTotal").Value - DatosCtaCteNv.Fields("Saldo").Value
               TotDol = DatosCtaCteNv.Fields("ImporteTotalDolar").Value - DatosCtaCteNv.Fields("SaldoDolar").Value
               TotEu = IIf(IsNull(DatosCtaCteNv.Fields("ImporteTotalEuro").Value), 0, DatosCtaCteNv.Fields("ImporteTotalEuro").Value) - _
                        IIf(IsNull(DatosCtaCteNv.Fields("SaldoEuro").Value), 0, DatosCtaCteNv.Fields("SaldoEuro").Value)
               
               Set DatosCtaCte = oDet.TraerFiltrado("CtasCtesA", "_BuscarComprobante", Array(DatosAnt.Fields("IdComprobanteImputado").Value, mvarAuxL1))
               If DatosCtaCte.RecordCount > 0 Then
                     DatosCtaCte.Fields("Saldo").Value = DatosCtaCte.Fields("Saldo").Value + Tot
                     DatosCtaCte.Fields("SaldoDolar").Value = DatosCtaCte.Fields("SaldoDolar").Value + TotDol
                     DatosCtaCte.Fields("SaldoEuro").Value = IIf(IsNull(DatosCtaCte.Fields("SaldoEuro").Value), 0, DatosCtaCte.Fields("SaldoEuro").Value) + TotEu
                     Resp = oDet.Guardar("CtasCtesA", DatosCtaCte)
               End If
               DatosCtaCte.Close
               Set DatosCtaCte = Nothing
               
               oDet.Eliminar "CtasCtesA", DatosCtaCteNv.Fields(0).Value
            End If
            DatosCtaCteNv.Close
            Set DatosCtaCteNv = Nothing
         End If
      End If
      DatosAnt.Close
      Set DatosAnt = Nothing
   End If
   
   Resp = iCompMTS_GuardarPorRef("ComprobantesProveedores", ComprobanteProveedor)
   
   Set Datos = oDet.LeerUno("ComprobantesProveedores", ComprobanteProveedor.Fields(0).Value)
   If Datos.RecordCount > 0 Then
      mvarNumeroReferencia = IIf(IsNull(Datos.Fields("NumeroReferencia").Value), 0, Datos.Fields("NumeroReferencia").Value)
   End If
   Datos.Close
   
   If mvarIdOrdenPagoActual <> 0 Or mvarIdOrdenPagoAnterior <> 0 Then
      oDet.Tarea "OrdenesPago_ActualizarDiferenciaBalanceo", Array(mvarIdOrdenPagoActual, mvarIdOrdenPagoAnterior)
   End If
   
   If mvarIdProveedorAnterior <> 0 Then
      Set DatosProveedor = oDet.LeerUno("Proveedores", mvarIdProveedorAnterior)
      If IsNull(DatosProveedor.Fields("Saldo").Value) Then
         DatosProveedor.Fields("Saldo").Value = 0
      End If
      DatosProveedor.Fields("Saldo").Value = DatosProveedor.Fields("Saldo").Value + (mTotalAnterior * mvarCoeficienteAnt)
      Resp = oDet.Guardar("Proveedores", DatosProveedor)
      DatosProveedor.Close
      Set DatosProveedor = Nothing
   End If
   If Not IsNull(ComprobanteProveedor.Fields("IdProveedor").Value) Then
      Set DatosProveedor = oDet.LeerUno("Proveedores", ComprobanteProveedor.Fields("IdProveedor").Value)
      If IsNull(DatosProveedor.Fields("Saldo").Value) Then
         DatosProveedor.Fields("Saldo").Value = 0
      End If
      DatosProveedor.Fields("Saldo").Value = DatosProveedor.Fields("Saldo").Value - (ComprobanteProveedor.Fields("TotalComprobante").Value * mvarCoeficiente * mvarCotizacionMoneda)
      If IIf(IsNull(DatosProveedor.Fields("RegistrarMovimientosEnCuentaCorriente").Value), "", DatosProveedor.Fields("RegistrarMovimientosEnCuentaCorriente").Value) = "NO" Then
         mvarGrabarRegistrosEnCuentaCorriente = False
      End If
      Resp = oDet.Guardar("Proveedores", DatosProveedor)
      DatosProveedor.Close
      Set DatosProveedor = Nothing
   End If
   
   'Borra la registracion contable anterior si el comprobante fue modificado
   If mvarIdentificador > 0 Then
      Set DatosAnt = oDet.TraerFiltrado("Subdiarios", "_PorIdComprobante", Array(mvarIdentificador, mvarIdTipoComprobanteAnterior))
      With DatosAnt
         If .RecordCount > 0 Then
            .MoveFirst
            Do While Not .EOF
               oDet.Eliminar "Subdiarios", .Fields(0).Value
               .MoveNext
            Loop
         End If
         .Close
      End With
'      Set DatosAnt = oDet.TraerFiltrado("DetComprobantesProveedores", "_PorIdCabecera", mvarIdentificador)
'      With DatosAnt
'         If .RecordCount > 0 Then
'            .MoveFirst
'            Do While Not .EOF
'               oDet.Tarea "Valores_BorrarPorIdDetalleComprobanteProveedor", .Fields(0).Value
'               .MoveNext
'            Loop
'         End If
'         .Close
'      End With
      Set DatosAnt = Nothing
   End If
               
   With Detalles
      If .State <> adStateClosed Then
         If Not .EOF Then
            .Update
            .MoveFirst
         End If
         
         Do While Not .EOF
            .Fields("IdComprobanteProveedor").Value = ComprobanteProveedor.Fields(0).Value
            .Update
            
            If .Fields("Eliminado").Value Then
               oDet.Eliminar "DetComprobantesProveedores", .Fields(0).Value
               oDet.Tarea "Valores_BorrarPorIdDetalleComprobanteProveedor", .Fields(0).Value
            Else
               Set Datos = CreateObject("ADOR.Recordset")
               For i = 0 To .Fields.Count - 2
                  With .Fields(i)
                     Datos.Fields.Append .Name, .Type, .DefinedSize, .Attributes
                     Datos.Fields(.Name).Precision = .Precision
                     Datos.Fields(.Name).NumericScale = .NumericScale
                  End With
               Next
               Datos.Open
               Datos.AddNew
               For i = 0 To .Fields.Count - 2
                  With .Fields(i)
                     Datos.Fields(i).Value = .Value
                  End With
               Next
               Datos.Update
               mvarIdDetalleComprobanteProveedorAnt = Datos.Fields(0).Value
               Resp = oDet.Guardar("DetComprobantesProveedores", Datos)
               mvarIdDetalleComprobanteProveedor = Datos.Fields(0).Value
               Datos.Close
               Set Datos = Nothing
            
               If Not mvarSubdiarios_ResumirRegistros And RegistroContable.RecordCount > 0 Then
                  RegistroContable.MoveFirst
                  Do While Not RegistroContable.EOF
                     If RegistroContable.Fields("IdDetalleComprobante").Value = mvarIdDetalleComprobanteProveedorAnt And mvarIdDetalleComprobanteProveedorAnt <> mvarIdDetalleComprobanteProveedor Then
                        RegistroContable.Fields("IdDetalleComprobante").Value = mvarIdDetalleComprobanteProveedor
                        RegistroContable.Update
                     End If
                     RegistroContable.MoveNext
                  Loop
                  RegistroContable.MoveFirst
               End If
               
               mvarBorrarEnValores = True
               Set oRsAux = oDet.TraerFiltrado("Cuentas", "_CuentaCajaBanco", .Fields("IdCuenta").Value)
               If oRsAux.RecordCount > 0 Then
                  If Not IsNull(oRsAux.Fields("EsCajaBanco").Value) And (oRsAux.Fields("EsCajaBanco").Value = "BA" Or oRsAux.Fields("EsCajaBanco").Value = "CA") Then
                     mvarIdCaja = IIf(IsNull(oRsAux.Fields("IdCaja").Value), 0, oRsAux.Fields("IdCaja").Value)
                     oRsAux.Close
                     
                     mIdValor = -1
                     Set oRsValores = oDet.TraerFiltrado("Valores", "_PorIdDetalleComprobanteProveedor", mvarIdDetalleComprobanteProveedor)
                     If oRsValores.RecordCount > 0 Then
                        mIdValor = oRsValores.Fields(0).Value
                     End If
                     oRsValores.Close
                     Set oRsValores = Nothing
                  
                     mvarIdBanco = 0
                     If Not IsNull(.Fields("IdCuentaBancaria").Value) Then
                        Set oRsAux = oDet.TraerFiltrado("CuentasBancarias", "_PorId", .Fields("IdCuentaBancaria").Value)
                        If oRsAux.RecordCount > 0 Then
                           mvarIdBanco = oRsAux.Fields("IdBanco").Value
                        End If
                        oRsAux.Close
                     End If
                     
                     If mvarIdBanco <> 0 Or mvarIdCaja <> 0 Then
                        Set oRsValores = CopiarRs(oDet.TraerFiltrado("Valores", "_Struc"))
                        With oRsValores
                           .Fields("IdTipoValor").Value = 32
                           .Fields("NumeroValor").Value = 0
                           .Fields("NumeroInterno").Value = 0
                           .Fields("FechaValor").Value = ComprobanteProveedor.Fields("FechaRecepcion").Value
                           .Fields("IdCuentaBancaria").Value = Detalles.Fields("IdCuentaBancaria").Value
                           If mvarIdBanco <> 0 Then .Fields("IdBanco").Value = mvarIdBanco
                           If mvarIdCaja <> 0 Then .Fields("IdCaja").Value = mvarIdCaja
                           .Fields("Importe").Value = Detalles.Fields("Importe").Value
                           .Fields("NumeroComprobante").Value = mvarNumeroReferencia
                           .Fields("FechaComprobante").Value = ComprobanteProveedor.Fields("FechaComprobante").Value
                           If Not IsNull(ComprobanteProveedor.Fields("IdProveedor").Value) Then
                              .Fields("IdProveedor").Value = ComprobanteProveedor.Fields("IdProveedor").Value
                           End If
                           .Fields("IdTipoComprobante").Value = ComprobanteProveedor.Fields("IdTipoComprobante").Value
                           .Fields("IdDetalleComprobanteProveedor").Value = mvarIdDetalleComprobanteProveedor
                           .Fields("IdMoneda").Value = ComprobanteProveedor.Fields("IdMoneda").Value
                           .Fields("CotizacionMoneda").Value = ComprobanteProveedor.Fields("CotizacionMoneda").Value
                           .Fields(0).Value = mIdValor
                        End With
                        Resp = oDet.Guardar("Valores", oRsValores)
                        oRsValores.Close
                        Set oRsValores = Nothing
                        mvarBorrarEnValores = False
                     End If
                  End If
               Else
                  oRsAux.Close
               End If
               Set oRsAux = Nothing
               
               If mvarIdentificador > 0 And mvarBorrarEnValores Then
                  oDet.Tarea "Valores_BorrarPorIdDetalleComprobanteProveedor", .Fields(0).Value
               End If
            End If
            If Not IsNull(.Fields("IdArticulo").Value) Then
               oDet.Tarea "Conjuntos_CalcularCostoConjuntoDesdeComponente", .Fields("IdArticulo").Value
            End If
            .MoveNext
         Loop
      End If
   End With
   
   If Not IsNull(ComprobanteProveedor.Fields("IdProveedor").Value) And mvarGrabarRegistrosEnCuentaCorriente Then
      mTotalAnterior = 0
      mTotalAnteriorDolar = 0
      mTotalAnteriorEuro = 0
      If mvarIdentificador > 0 Then
         Set DatosCtaCteNv = oDet.TraerFiltrado("CtasCtesA", "_BuscarComprobante", Array(ComprobanteProveedor.Fields(0).Value, mvarIdTipoComprobanteAnterior))
         If DatosCtaCteNv.RecordCount > 0 Then
            mTotalAnterior = DatosCtaCteNv.Fields("ImporteTotal").Value - DatosCtaCteNv.Fields("Saldo").Value
            mTotalAnteriorDolar = DatosCtaCteNv.Fields("ImporteTotalDolar").Value - DatosCtaCteNv.Fields("SaldoDolar").Value
            mTotalAnteriorEuro = IIf(IsNull(DatosCtaCteNv.Fields("ImporteTotalEuro").Value), 0, DatosCtaCteNv.Fields("ImporteTotalEuro").Value) - _
                                 IIf(IsNull(DatosCtaCteNv.Fields("SaldoEuro").Value), 0, DatosCtaCteNv.Fields("SaldoEuro").Value)
         Else
            DatosCtaCteNv.Close
            Set DatosCtaCte = oDet.TraerFiltrado("CtasCtesA", "_Struc")
            Set DatosCtaCteNv = CopiarRs(DatosCtaCte)
            DatosCtaCteNv.Fields(0).Value = -1
         End If
      Else
         Set DatosCtaCte = oDet.TraerFiltrado("CtasCtesA", "_Struc")
         Set DatosCtaCteNv = CopiarRs(DatosCtaCte)
         DatosCtaCteNv.Fields(0).Value = -1
      End If
      With DatosCtaCteNv
         Tot = Round(ComprobanteProveedor.Fields("TotalComprobante").Value * mvarCotizacionMoneda, 2)
         TotDol = 0
         If mvarCotizacionDolar <> 0 Then
            TotDol = Round(ComprobanteProveedor.Fields("TotalComprobante").Value * _
                  IIf((mvarCotizacionMoneda = 0), 1, mvarCotizacionMoneda) / mvarCotizacionDolar, 2)
         End If
         TotEu = 0
         If mvarCotizacionEuro <> 0 Then
            TotEu = Round(ComprobanteProveedor.Fields("TotalComprobante").Value * _
                  IIf((mvarCotizacionMoneda = 0), 1, mvarCotizacionMoneda) / mvarCotizacionEuro, 2)
         End If
         
         .Fields("IdProveedor").Value = ComprobanteProveedor.Fields("IdProveedor").Value
         .Fields("NumeroComprobante").Value = mvarNumeroReferencia
         .Fields("Fecha").Value = ComprobanteProveedor.Fields("FechaRecepcion").Value
         .Fields("IdTipoComp").Value = ComprobanteProveedor.Fields("IdTipoComprobante").Value
         .Fields("IdComprobante").Value = ComprobanteProveedor.Fields(0).Value
         .Fields("FechaVencimiento").Value = ComprobanteProveedor.Fields("FechaVencimiento").Value
         .Fields("ImporteTotal").Value = Tot
         .Fields("Saldo").Value = Tot - mTotalAnterior
         .Fields("CotizacionDolar").Value = mvarCotizacionDolar
         .Fields("ImporteTotalDolar").Value = TotDol
         .Fields("SaldoDolar").Value = TotDol - mTotalAnteriorDolar
         .Fields("CotizacionEuro").Value = mvarCotizacionEuro
         .Fields("ImporteTotalEuro").Value = TotEu
         .Fields("SaldoEuro").Value = TotEu - mTotalAnteriorEuro
         .Fields("IdMoneda").Value = ComprobanteProveedor.Fields("IdMoneda").Value
         .Fields("CotizacionMoneda").Value = ComprobanteProveedor.Fields("CotizacionMoneda").Value
      
         If Not IsNull(ComprobanteProveedor.Fields("IdComprobanteImputado").Value) Then
            Sdo = 0
            SdoDol = 0
            SdoEu = 0
            mvarAuxL1 = 11
            Set oRsAux = oDet.LeerUno("ComprobantesProveedores", ComprobanteProveedor.Fields("IdComprobanteImputado").Value)
            If oRsAux.RecordCount > 0 Then
               mvarAuxL1 = oRsAux.Fields("IdTipoComprobante").Value
            End If
            oRsAux.Close
            Set oRsAux = oDet.TraerFiltrado("CtasCtesA", "_BuscarComprobante", _
                     Array(ComprobanteProveedor.Fields("IdComprobanteImputado").Value, mvarAuxL1))
            If oRsAux.RecordCount > 0 Then
               Sdo = oRsAux.Fields("Saldo").Value
               SdoDol = IIf(IsNull(oRsAux.Fields("SaldoDolar").Value), 0, oRsAux.Fields("SaldoDolar").Value)
               SdoEu = IIf(IsNull(oRsAux.Fields("SaldoEuro").Value), 0, oRsAux.Fields("SaldoEuro").Value)
               
               If IsNull(ComprobanteProveedor.Fields("Dolarizada").Value) Or ComprobanteProveedor.Fields("Dolarizada").Value = "NO" Then
                  TotDol = 0
                  If IIf(IsNull(oRsAux.Fields("CotizacionDolar").Value), 0, oRsAux.Fields("CotizacionDolar").Value) <> 0 Then
                     TotDol = Round(Abs(Tot * IIf((mvarCotizacionMoneda = 0), 1, mvarCotizacionMoneda)) / oRsAux.Fields("CotizacionDolar").Value, 2)
                  End If
                  .Fields("CotizacionDolar").Value = oRsAux.Fields("CotizacionDolar").Value
                  .Fields("ImporteTotalDolar").Value = TotDol
                  .Fields("SaldoDolar").Value = TotDol
               End If
               TotEu = 0
               If IIf(IsNull(oRsAux.Fields("CotizacionEuro").Value), 0, oRsAux.Fields("CotizacionEuro").Value) <> 0 Then
                  TotEu = Round(Abs(Tot * IIf((mvarCotizacionMoneda = 0), 1, mvarCotizacionMoneda)) / oRsAux.Fields("CotizacionEuro").Value, 2)
               End If
               .Fields("CotizacionEuro").Value = oRsAux.Fields("CotizacionEuro").Value
               .Fields("ImporteTotalEuro").Value = TotEu
               .Fields("SaldoEuro").Value = TotEu
               If Tot > Sdo Then
                  Tot = Round(Tot - Sdo, 2)
                  oRsAux.Fields("Saldo").Value = 0
                  .Fields("Saldo").Value = Tot
               Else
                  Sdo = Round(Sdo - Tot, 2)
                  oRsAux.Fields("Saldo").Value = Sdo
                  .Fields("Saldo").Value = 0
               End If
               If TotDol > SdoDol Then
                  TotDol = Round(TotDol - SdoDol, 2)
                  oRsAux.Fields("SaldoDolar").Value = 0
                  .Fields("SaldoDolar").Value = TotDol
               Else
                  SdoDol = Round(SdoDol - TotDol, 2)
                  oRsAux.Fields("SaldoDolar").Value = SdoDol
                  .Fields("SaldoDolar").Value = 0
               End If
               If TotEu > SdoEu Then
                  TotEu = Round(TotEu - SdoEu, 2)
                  oRsAux.Fields("SaldoEuro").Value = 0
                  .Fields("SaldoEuro").Value = TotEu
               Else
                  SdoEu = Round(SdoEu - TotEu, 2)
                  oRsAux.Fields("SaldoEuro").Value = SdoEu
                  .Fields("SaldoEuro").Value = 0
               End If
               .Fields("IdImputacion").Value = oRsAux.Fields("IdImputacion").Value
               Resp = oDet.Guardar("CtasCtesA", oRsAux)
            End If
            oRsAux.Close
         End If
      End With

      Resp = oDet.Guardar("CtasCtesA", DatosCtaCteNv)
      If IsNull(DatosCtaCteNv.Fields("IdImputacion").Value) Then
         DatosCtaCteNv.Fields("IdImputacion").Value = DatosCtaCteNv.Fields(0).Value
         Resp = oDet.Guardar("CtasCtesA", DatosCtaCteNv)
      End If
      DatosCtaCteNv.Close
      Set DatosCtaCteNv = Nothing
      Set DatosCtaCte = Nothing
   Else
      If mvarIdentificador > 0 Then
         Set DatosCtaCte = oDet.TraerFiltrado("CtasCtesA", "_BuscarComprobante", Array(ComprobanteProveedor.Fields(0).Value, mvarIdTipoComprobanteAnterior))
         If DatosCtaCte.RecordCount > 0 Then
            oDet.Eliminar "CtasCtesA", DatosCtaCte.Fields(0).Value
         End If
         DatosCtaCte.Close
         Set DatosCtaCte = Nothing
      End If
   End If
   
   mvarDebe = 0
   mvarHaber = 0
   
   With RegistroContable
      If .State <> adStateClosed Then
         If .RecordCount > 0 Then
            .Update
            .MoveFirst
         End If
         Do While Not .EOF
            If Not IsNull(.Fields("Debe").Value) Then
               .Fields("Debe").Value = Round(.Fields("Debe").Value * mvarCotizacionMoneda, 2)
               .Update
               mvarDebe = mvarDebe + .Fields("Debe").Value
            End If
            If Not IsNull(.Fields("Haber").Value) Then
               .Fields("Haber").Value = Round(.Fields("Haber").Value * mvarCotizacionMoneda, 2)
               .Update
               mvarHaber = mvarHaber + .Fields("Haber").Value
            End If
            .MoveNext
         Loop
         If .RecordCount > 0 Then
            If mvarDebe - mvarHaber <> 0 Then
               mvarOk = False
               .MoveFirst
               Do While Not .EOF
                  If Not IsNull(.Fields("Debe").Value) Then
                     mvarProcesar = True
                     Set oRsAux = oDet.TraerFiltrado("Cuentas", "_CuentaParaAjusteSubdiario", .Fields("IdCuenta").Value)
                     If oRsAux.Fields(0).Value = 0 Then mvarProcesar = False
                     oRsAux.Close
                     Set Datos = Nothing
                     If mvarProcesar Then
                        .Fields("Debe").Value = .Fields("Debe").Value - Round(mvarDebe - mvarHaber, 2)
                        mvarOk = True
                        Exit Do
                     End If
                  End If
                  .MoveNext
               Loop
               If Not mvarOk Then
                  .MoveLast
                  If Not IsNull(.Fields("Debe").Value) Then
                     .Fields("Debe").Value = .Fields("Debe").Value - Round(mvarDebe - mvarHaber, 2)
                  Else
                     .Fields("Haber").Value = .Fields("Haber").Value + Round(mvarDebe - mvarHaber, 2)
                  End If
               End If
            End If
            .MoveFirst
         End If
         Do While Not .EOF
            Set Datos = CreateObject("ADOR.Recordset")
            For i = 0 To .Fields.Count - 1
               With .Fields(i)
                  Datos.Fields.Append .Name, .Type, .DefinedSize, .Attributes
                  Datos.Fields(.Name).Precision = .Precision
                  Datos.Fields(.Name).NumericScale = .NumericScale
               End With
            Next
            Datos.Open
            Datos.AddNew
            For i = 0 To .Fields.Count - 1
               With .Fields(i)
                  Datos.Fields(i).Value = .Value
               End With
            Next
            Datos.Fields("IdComprobante").Value = ComprobanteProveedor.Fields(0).Value
            Datos.Fields("NumeroComprobante").Value = mvarNumeroReferencia
            Datos.Update
            Resp = oDet.Guardar("Subdiarios", Datos)
            Datos.Close
            Set Datos = Nothing
            .MoveNext
         Loop
      End If
   End With
   
   With DetallesProvincias
      If .State <> adStateClosed Then
         If Not .EOF Then
            .Update
            .MoveFirst
         End If
         
         Do While Not .EOF
            .Fields("IdComprobanteProveedor").Value = ComprobanteProveedor.Fields(0).Value
            .Update
            If .Fields("Eliminado").Value Then
               oDet.Eliminar "DetComprobantesProveedoresPrv", .Fields(0).Value
            Else
               Set Datos = CreateObject("ADOR.Recordset")
               For i = 0 To .Fields.Count - 2
                  With .Fields(i)
                     Datos.Fields.Append .Name, .Type, .DefinedSize, .Attributes
                     Datos.Fields(.Name).Precision = .Precision
                     Datos.Fields(.Name).NumericScale = .NumericScale
                  End With
               Next
               Datos.Open
               Datos.AddNew
               For i = 0 To .Fields.Count - 2
                  With .Fields(i)
                     Datos.Fields(i).Value = .Value
                  End With
               Next
               Datos.Update
               Resp = oDet.Guardar("DetComprobantesProveedoresPrv", Datos)
               Datos.Close
               Set Datos = Nothing
            End If
            .MoveNext
         Loop
      End If
   End With
   
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetComplete
      End With
   End If
   
Salir:
   Guardar = Resp
   Set oDet = Nothing
   Set oCont = Nothing
   Set oRsAux = Nothing
   On Error GoTo 0
   If lErr Then
      Err.Raise lErr, sSource, sDesc
   End If
   Exit Function
   
Mal:
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetAbort
      End With
   End If
   With Err
      lErr = .Number
      sSource = .Source
      sDesc = .Description
   End With
   oDet.Tarea "Log_InsertarRegistro", Array("MTSCP", ComprobanteProveedor.Fields(0).Value, 0, Now, 0, _
         "Error " & Err.Number & Err.Description & ", " & Err.Source, _
         "MTSPronto " & App.Major & " " & App.Minor & " " & App.Revision)
   Resume Salir

End Function

Public Function GuardarRegistroContable(ByVal RegistroContable As ADOR.Recordset) As InterFazMTS.MisEstados

   Dim oCont As ObjectContext
   Dim oDet As iCompMTS
   Dim Resp As InterFazMTS.MisEstados
   Dim oRsComprobante As ADOR.Recordset
   Dim Datos As ADOR.Recordset
   Dim DatosAsiento As ADOR.Recordset
   Dim DatosAsientoNv As ADOR.Recordset
   Dim oRsParametros As ADOR.Recordset
   Dim DatosDetAsiento As ADOR.Recordset
   Dim DatosDetAsientoNv As ADOR.Recordset
   Dim oFld As ADOR.Field
   Dim lErr As Long, sSource As String, sDesc As String
   Dim i As Integer
   Dim mvarNumeroAsiento, mvarIdAsiento, mvarIdCuenta As Long
   Dim mvarCotizacionMoneda, mvarDebe, mvarHaber As Double
   
   On Error GoTo Mal
   
   Set oCont = GetObjectContext
   
   If oCont Is Nothing Then
      Set oDet = CreateObject("MTSPronto.General")
   Else
      Set oDet = oCont.CreateInstance("MTSPronto.General")
   End If
   
   mvarCotizacionMoneda = 0
   mvarDebe = 0
   mvarHaber = 0
   
   With RegistroContable
      If .State <> adStateClosed Then
         If .RecordCount > 0 Then
            .Update
            .MoveFirst
            Set oRsComprobante = oDet.LeerUno("ComprobantesProveedores", RegistroContable.Fields("IdComprobante").Value)
            mvarCotizacionMoneda = oRsComprobante.Fields("CotizacionMoneda").Value
            oRsComprobante.Close
            Set oRsComprobante = Nothing
         End If
         Do While Not .EOF
            If Not IsNull(.Fields("Debe").Value) Then
               .Fields("Debe").Value = .Fields("Debe").Value * mvarCotizacionMoneda
               .Update
               mvarDebe = mvarDebe + .Fields("Debe").Value
            End If
            If Not IsNull(.Fields("Haber").Value) Then
               .Fields("Haber").Value = .Fields("Haber").Value * mvarCotizacionMoneda
               .Update
               mvarHaber = mvarHaber + .Fields("Haber").Value
            End If
            .MoveNext
         Loop
         If .RecordCount > 0 Then
            .MoveLast
            If mvarDebe - mvarHaber <> 0 Then
               If Not IsNull(.Fields("Debe").Value) Then
                  .Fields("Debe").Value = .Fields("Debe").Value - (mvarDebe - mvarHaber)
               Else
                  .Fields("Haber").Value = .Fields("Haber").Value + (mvarDebe - mvarHaber)
               End If
            End If
            .MoveFirst
         End If
         Do While Not .EOF
            Set Datos = CreateObject("ADOR.Recordset")
            For i = 0 To .Fields.Count - 1
               With .Fields(i)
                  Datos.Fields.Append .Name, .Type, .DefinedSize, .Attributes
                  Datos.Fields(.Name).Precision = .Precision
                  Datos.Fields(.Name).NumericScale = .NumericScale
               End With
            Next
            Datos.Open
            Datos.AddNew
            For i = 0 To .Fields.Count - 1
               With .Fields(i)
                  Datos.Fields(i).Value = .Value
               End With
            Next
            Datos.Update
            Resp = oDet.Guardar("Subdiarios", Datos)
            Datos.Close
            Set Datos = Nothing
            .MoveNext
         Loop
      End If
   End With
   
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetComplete
      End With
   End If
   
Salir:
   GuardarRegistroContable = Resp
   Set oDet = Nothing
   Set oCont = Nothing
   On Error GoTo 0
   If lErr Then
      Err.Raise lErr, sSource, sDesc
   End If
   Exit Function
   
Mal:
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetAbort
      End With
   End If
   With Err
      lErr = .Number
      sSource = .Source
      sDesc = .Description
   End With
   Resume Salir

End Function

Private Function GuardarNoConfirmados(ByRef ComprobanteProveedor As ADOR.Recordset, ByVal Detalles As ADOR.Recordset) As InterFazMTS.MisEstados

   Dim oCont As ObjectContext
   Dim oDet As iCompMTS
   Dim Resp As InterFazMTS.MisEstados
   Dim lErr As Long, sSource As String, sDesc As String
   Dim Datos As ADOR.Recordset
   Dim i As Integer
   Dim oFld As ADOR.Field
   
   On Error GoTo Mal
   
   Set oCont = GetObjectContext
   
   If oCont Is Nothing Then
      Set oDet = CreateObject("MTSPronto.General")
   Else
      Set oDet = oCont.CreateInstance("MTSPronto.General")
   End If
   
   Resp = iCompMTS_GuardarPorRef("ComprobantesProveedores", ComprobanteProveedor)
   
   With Detalles
      
      If .State <> adStateClosed Then
      
         If Not .EOF Then
            .Update
            .MoveFirst
         End If
         
         Do While Not .EOF
            
            .Fields("IdComprobanteProveedor").Value = ComprobanteProveedor.Fields(0).Value
            .Update
            
            If .Fields("Eliminado").Value Then
               oDet.Eliminar "DetComprobantesProveedores", .Fields(0).Value
            Else
               Set Datos = CreateObject("ADOR.Recordset")
               For i = 0 To .Fields.Count - 2
                  With .Fields(i)
                     Datos.Fields.Append .Name, .Type, .DefinedSize, .Attributes
                     Datos.Fields(.Name).Precision = .Precision
                     Datos.Fields(.Name).NumericScale = .NumericScale
                  End With
               Next
               Datos.Open
               Datos.AddNew
               For i = 0 To .Fields.Count - 2
                  With .Fields(i)
                     Datos.Fields(i).Value = .Value
                  End With
               Next
               Datos.Update
               Resp = oDet.Guardar("DetComprobantesProveedores", Datos)
               Datos.Close
               Set Datos = Nothing
            End If
            
            .MoveNext
         
         Loop
      
      End If
   
   End With
   
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetComplete
      End With
   End If
   
Salir:
   GuardarNoConfirmados = Resp
   Set oDet = Nothing
   Set oCont = Nothing
   On Error GoTo 0
   If lErr Then
      Err.Raise lErr, sSource, sDesc
   End If
   Exit Function
   
Mal:
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetAbort
      End With
   End If
   With Err
      lErr = .Number
      sSource = .Source
      sDesc = .Description
   End With
   Resume Salir

End Function

Private Sub iCompMTS_Tarea(ByVal NombreTarea As String, Optional ByVal Args As Variant)

   Dim oCont As ObjectContext
   Dim oA As GralUpd
   Dim lErr As Long, sSource As String, sDesc As String
   
   On Error GoTo Mal
   
   Set oCont = GetObjectContext
   
   If oCont Is Nothing Then
      Set oA = CreateObject("MTSPronto.GralUpd")
   Else
      Set oA = oCont.CreateInstance("MTSPronto.GralUpd")
   End If
   
   oA.Tarea NombreTarea, Args
   
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetComplete
      End With
   End If
   
Salir:
   Set oA = Nothing
   Set oCont = Nothing
   On Error GoTo 0
   If lErr Then
      Err.Raise lErr, sSource, sDesc
   End If
   Exit Sub
   
Mal:
   If Not oCont Is Nothing Then
      With oCont
         If .IsInTransaction Then .SetAbort
      End With
   End If
   With Err
      lErr = .Number
      sSource = .Source
      sDesc = .Description
   End With
   Resume Salir

End Sub

Private Function iCompMTS_GuardarTodos(ByVal NombreTabla As String, ByRef vData As ADOR.Recordset) As InterFazMTS.MisEstados

   Dim oA As GralUpd
   Dim lErr As Long, sSource As String, sDesc As String
   
   On Error GoTo Mal
   
   Set oA = CreateObject("MTSPronto.GralUpd")
   
   iCompMTS_GuardarTodos = oA.GuardarTodos(NombreTabla, vData)
   
Salir:
   Set oA = Nothing
   On Error GoTo 0
   If lErr Then
      Err.Raise lErr, sSource, sDesc
   End If
   Exit Function
   
Mal:
   With Err
      lErr = .Number
      sSource = .Source
      sDesc = .Description
   End With
   Resume Salir

End Function


