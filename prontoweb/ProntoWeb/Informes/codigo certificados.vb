
Public Sub EmisionCertificadoRetencionGanancias(ByVal mIdOrdenPago As String, _
                                                ByVal mDestino As String, _
                                                ByVal mPrinter As String, _
                                                Optional ByVal mNuevo As Boolean)

   Dim oW As Word.Application
   Dim oRs As ADOR.Recordset
   Dim goMailOL As CEmailOL
   Dim mNumeroCertificado As Long, mIdProveedor As Long, lStatus As Long
   Dim mCopias As Integer
   Dim mFecha As Date
   Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String, mCuitSujeto As String, mBody As String, mPathArchivosExportados As String
   Dim mEmail As String, mSubject As String, mAttachment As String, mProvincia As String, mPrinterAnt As String, mAux1 As String, mAnulada As String, mPlantilla As String
   Dim mRetenido As Double, mCotMon As Double, mMontoOrigen As Double
   
   On Error GoTo Mal
   
   mPlantilla = glbPathPlantillas & "\CertificadoRetencionGanancias_" & glbEmpresaSegunString & ".dot"
   If Len(Dir(mPlantilla)) = 0 Then
      mPlantilla = glbPathPlantillas & "\CertificadoRetencionGanancias.dot"
      If Len(Dir(mPlantilla)) = 0 Then
         MsgBox "Plantilla " & mPlantilla & " inexistente", vbExclamation
         Exit Sub
      End If
   End If
   
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   If Not IsNull(oRs.Fields("PathArchivosExportados").Value) Then
      mPathArchivosExportados = oRs.Fields("PathArchivosExportados").Value
      If Len(mPathArchivosExportados) = 0 Then mPathArchivosExportados = "C:\"
   Else
      mPathArchivosExportados = "C:\"
   End If
   oRs.Close
   
   mCopias = 1
   mAux1 = BuscarClaveINI("Copias retenciones en op")
   If IsNumeric(mAux1) Then mCopias = Val(mAux1)
   
   Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PorId", mIdOrdenPago)
   With oRs
      mComprobante = Format(.Fields("NumeroOrdenPago").Value, "00000000")
      mIdProveedor = .Fields("IdProveedor").Value
      mCotMon = .Fields("CotizacionMoneda").Value
      mFecha = .Fields("FechaOrdenPago").Value
      If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
      .Close
   End With
   
   Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ConDatos", mIdProveedor)
   If oRs.RecordCount > 0 Then
      mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
      mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
      If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
      mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
                           Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
      mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
      mEmail = IIf(IsNull(oRs.Fields("Email").Value), "", oRs.Fields("Email").Value)
   End If
   oRs.Close
   Set oRs = Nothing
   
   Set oW = CreateObject("Word.Application")
   
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetOrdenesPagoImpuestos", "OrdenPago", mIdOrdenPago)
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If oRs.Fields("Tipo").Value = "Ganancias" And Not IsNull(oRs.Fields("Certif.Gan.").Value) Then
               mNumeroCertificado = oRs.Fields("Certif.Gan.").Value
               mMontoOrigen = oRs.Fields("Pago s/imp.").Value * mCotMon
               mRetenido = oRs.Fields("Retencion").Value * mCotMon
               
               With oW
                  .Visible = True
                  With .Documents.Add(mPlantilla)
                     oW.ActiveDocument.FormFields("NumeroCertificado").Result = mNumeroCertificado
                     oW.ActiveDocument.FormFields("Fecha").Result = mFecha
                     oW.ActiveDocument.FormFields("NombreAgente").Result = glbEmpresa
                     oW.ActiveDocument.FormFields("CuitAgente").Result = glbCuit
                     oW.ActiveDocument.FormFields("DomicilioAgente").Result = glbDireccion & " " & glbLocalidad & " " & glbProvincia
                     oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
                     oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
                     oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
                     oW.ActiveDocument.FormFields("Comprobante").Result = mComprobante
                     oW.ActiveDocument.FormFields("Regimen").Result = oRs.Fields("Categoria").Value
                     oW.ActiveDocument.FormFields("MontoOrigen").Result = Format(mMontoOrigen, "$ #,##0.00")
                     oW.ActiveDocument.FormFields("Retencion").Result = Format(mRetenido, "$ #,##0.00")
                     oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
                     mAux1 = BuscarClaveINI("Aclaracion para certificado de retencion de ganancias")
                     If Len(mAux1) > 0 Then
                        oW.ActiveDocument.FormFields("Aclaracion").Result = mAux1
                     End If
                  End With
               End With
            
               If mDestino = "Printer" Then
                  mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
                  If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
                  oW.Documents(1).PrintOut False, , , , , , , mCopias
                  If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
                  
                  If mNuevo And Len(mEmail) > 0 And BuscarClaveINI("Enviar certificado de retencion de ganancias por email", -1) = "SI" Then
                     Set goMailOL = New CEmailOL
                     If Len(Dir(mPathArchivosExportados & "CertificadoRetencionGanancias.doc")) > 0 Then Kill mPathArchivosExportados & "CertificadoRetencionGanancias.doc"
                     oW.ActiveDocument.SaveAs Filename:=mPathArchivosExportados & "CertificadoRetencionGanancias.doc", FileFormat:=wdFormatDocument
                     oW.Documents(1).Close False
                     mSubject = "" & glbEmpresa & " - Certificado de retencion ganancias " & Format(mNumeroCertificado, "00000000")
                     mBody = "Certificado de retencion ganancias." & vbCrLf & vbCrLf
                     mAttachment = mPathArchivosExportados & "CertificadoRetencionGanancias.doc"
                     lStatus = goMailOL.Send(mEmail, True, mSubject, mBody, mAttachment)
                  Else
                     oW.Documents(1).Close False
                  End If
               End If
            End If
            oRs.MoveNext
         Loop
      End If
   End If
   oRs.Close
   
   oW.Selection.HomeKey wdStory

Mal:
   If mDestino = "Printer" Then oW.Quit
   Set oW = Nothing
   Set oRs = Nothing
   Set goMailOL = Nothing

End Sub











Public Sub EmisionCertificadoRetencionIIBB(ByVal mIdOrdenPago As String, _
                                                ByVal mDestino As String, _
                                                ByVal mPrinter As String, _
                                                Optional ByVal mNuevo As Boolean)

   Dim oW As Word.Application
   Dim cALetra As New clsNum2Let
   Dim oRs As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim goMailOL As CEmailOL
   Dim mNumeroCertificado As Long, mIdProveedor As Long, lStatus As Long
   Dim mCopias As Integer
   Dim mFecha As Date
   Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String, mCuitSujeto As String, mProvincia As String, mBody As String, mPathArchivosExportados As String
   Dim mEmail As String, mSubject As String, mAttachment As String, mPrinterAnt As String, mIBNumeroInscripcion As String, mAux1 As String, mPlantilla As String, mPlantilla1 As String
   Dim mCodPos As String, mImporteLetras As String, mAnulada As String
   Dim mRetenido As Double, mRetencionAdicional As Double, mCotMon As Double
   
   On Error GoTo Mal
   
   mCopias = 1
   mAux1 = BuscarClaveINI("Copias retenciones en op")
   If IsNumeric(mAux1) Then mCopias = Val(mAux1)
   
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   If Not IsNull(oRs.Fields("PathArchivosExportados").Value) Then
      mPathArchivosExportados = oRs.Fields("PathArchivosExportados").Value
      If Len(mPathArchivosExportados) = 0 Then mPathArchivosExportados = "C:\"
   Else
      mPathArchivosExportados = "C:\"
   End If
   oRs.Close
   
   Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PorId", mIdOrdenPago)
   With oRs
      mComprobante = Format(.Fields("NumeroOrdenPago").Value, "00000000")
      mIdProveedor = .Fields("IdProveedor").Value
      mCotMon = .Fields("CotizacionMoneda").Value
      mFecha = .Fields("FechaOrdenPago").Value
      If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
      .Close
   End With
   
   Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ConDatos", mIdProveedor)
   If oRs.RecordCount > 0 Then
      mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
      mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
      If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
      mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
                           Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
      mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
      mEmail = IIf(IsNull(oRs.Fields("Email").Value), "", oRs.Fields("Email").Value)
      mIBNumeroInscripcion = IIf(IsNull(oRs.Fields("IBNumeroInscripcion").Value), "", oRs.Fields("IBNumeroInscripcion").Value)
      mCodPos = IIf(IsNull(oRs.Fields("CodigoPostal").Value), "", oRs.Fields("CodigoPostal").Value)
'      If Not IsNull(oRs.Fields("PlantillaRetencionIIBB").Value) Then
'         If Len(RTrim(oRs.Fields("PlantillaRetencionIIBB").Value)) > 0 Then
'            mPlantilla = oRs.Fields("PlantillaRetencionIIBB").Value
'         End If
'      End If
   End If
   oRs.Close
   Set oRs = Nothing
   
   Set oW = CreateObject("Word.Application")
   
   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetOrdenesPagoImpuestos", "OrdenPago", mIdOrdenPago)
   If oRs.Fields.Count > 0 Then
      If oRs.RecordCount > 0 Then
         oRs.MoveFirst
         Do While Not oRs.EOF
            If oRs.Fields("Tipo").Value = "I.Brutos" And Not IsNull(oRs.Fields("Certif.IIBB").Value) Then
               mNumeroCertificado = oRs.Fields("Certif.IIBB").Value
               mRetenido = oRs.Fields("Retencion").Value * mCotMon
               mRetencionAdicional = IIf(IsNull(oRs.Fields("Impuesto adic.").Value), 0, oRs.Fields("Impuesto adic.").Value) * mCotMon
               
               mPlantilla = "CertificadoRetencionIIBB.dot"
               Set oRsAux = Aplicacion.IBCondiciones.TraerFiltrado("_IdCuentaPorProvincia", oRs.Fields("IdTipoImpuesto").Value)
               If oRsAux.RecordCount > 0 Then
                  If Not IsNull(oRsAux.Fields("PlantillaRetencionIIBB").Value) Then
                     If Len(RTrim(oRsAux.Fields("PlantillaRetencionIIBB").Value)) > 0 Then
                        mPlantilla = oRsAux.Fields("PlantillaRetencionIIBB").Value
                     End If
                  End If
               End If
               oRsAux.Close
               mPlantilla1 = mId(mPlantilla, 1, Len(mPlantilla) - 4)
               mPlantilla = glbPathPlantillas & "\" & mPlantilla1 & "_" & glbEmpresaSegunString & ".dot"
               If Len(Dir(mPlantilla)) = 0 Then
                  mPlantilla = glbPathPlantillas & "\" & mPlantilla1 & ".dot"
                  If Len(Dir(mPlantilla)) = 0 Then
                     MsgBox "Plantilla " & mPlantilla & " inexistente", vbExclamation
                     Exit Sub
                  End If
               End If
   
               With oW
                  .Visible = True
                  With .Documents.Add(mPlantilla)
                     
                     If InStr(1, mPlantilla, "Salta") = 0 Then
                        oW.ActiveDocument.FormFields("NumeroCertificado").Result = Format(mNumeroCertificado, "00000000")
                        oW.ActiveDocument.FormFields("Fecha").Result = mFecha
                        oW.ActiveDocument.FormFields("NombreAgente").Result = glbEmpresa
                        oW.ActiveDocument.FormFields("CuitAgente").Result = glbCuit
                        oW.ActiveDocument.FormFields("DomicilioAgente").Result = glbDireccion & " " & glbLocalidad & " " & glbProvincia
                        oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
                        oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
                        oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
                        oW.ActiveDocument.FormFields("NumeroInscripcion").Result = mIBNumeroInscripcion
                        oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
                  
                        oW.Selection.Goto What:=wdGoToBookmark, Name:="DetalleComprobantes"
                        oW.Selection.MoveDown Unit:=wdLine
                        oW.Selection.MoveLeft Unit:=wdCell
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & oRs.Fields("Categoria").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(oRs.Fields("Pago s/imp.").Value * mCotMon, "#,##0.00")
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(oRs.Fields("Pagos mes").Value, "#,##0.00")
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(oRs.Fields("Ret. mes").Value, "#,##0.00")
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & oRs.Fields("% a tomar s/base").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & oRs.Fields("Alicuota.IIBB").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(mRetenido - mRetencionAdicional, "#,##0.00")
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & oRs.Fields("% adic.").Value
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(mRetencionAdicional, "#,##0.00")
                        oW.Selection.MoveRight Unit:=wdCell
                        oW.Selection.TypeText Text:="" & Format(mRetenido, "#,##0.00")
                     
                        oW.Selection.Goto What:=wdGoToBookmark, Name:="TotalRetencion"
                        oW.Selection.MoveRight Unit:=wdCell, Count:=2
                        oW.Selection.TypeText Text:="" & Format(mRetenido, "#,##0.00")
                     
                     ElseIf InStr(1, mPlantilla, "Salta") > 0 Then
                        cALetra.Numero = mRetenido
                        mImporteLetras = cALetra.ALetra
                        oW.ActiveDocument.FormFields("NombreSujeto1").Result = mNombreSujeto
                        oW.ActiveDocument.FormFields("CuitSujeto1").Result = mCuitSujeto
                        oW.ActiveDocument.FormFields("DomicilioSujeto1").Result = mDomicilioSujeto
                        oW.ActiveDocument.FormFields("CodigoPostal1").Result = mCodPos
                        oW.ActiveDocument.FormFields("Monto1").Result = Format(oRs.Fields("Pago s/imp.").Value * mCotMon, "#,##0.00")
                        oW.ActiveDocument.FormFields("Alicuota1").Result = oRs.Fields("Alicuota.IIBB").Value
                        oW.ActiveDocument.FormFields("Retencion1").Result = mRetenido
                        oW.ActiveDocument.FormFields("ImporteEnLetras1").Result = mImporteLetras
                        oW.ActiveDocument.FormFields("Fecha1").Result = mFecha
                        
                        oW.ActiveDocument.FormFields("NombreSujeto2").Result = mNombreSujeto
                        oW.ActiveDocument.FormFields("CuitSujeto2").Result = mCuitSujeto
                        oW.ActiveDocument.FormFields("DomicilioSujeto2").Result = mDomicilioSujeto
                        oW.ActiveDocument.FormFields("CodigoPostal2").Result = mCodPos
                        oW.ActiveDocument.FormFields("Monto2").Result = Format(oRs.Fields("Pago s/imp.").Value * mCotMon, "#,##0.00")
                        oW.ActiveDocument.FormFields("Alicuota2").Result = oRs.Fields("Alicuota.IIBB").Value
                        oW.ActiveDocument.FormFields("Retencion2").Result = mRetenido
                        oW.ActiveDocument.FormFields("ImporteEnLetras2").Result = mImporteLetras
                        oW.ActiveDocument.FormFields("Fecha2").Result = mFecha
                     
                        oW.ActiveDocument.FormFields("NombreSujeto3").Result = mNombreSujeto
                        oW.ActiveDocument.FormFields("CuitSujeto3").Result = mCuitSujeto
                        oW.ActiveDocument.FormFields("DomicilioSujeto3").Result = mDomicilioSujeto
                        oW.ActiveDocument.FormFields("CodigoPostal3").Result = mCodPos
                        oW.ActiveDocument.FormFields("Monto3").Result = Format(oRs.Fields("Pago s/imp.").Value * mCotMon, "#,##0.00")
                        oW.ActiveDocument.FormFields("Alicuota3").Result = oRs.Fields("Alicuota.IIBB").Value
                        oW.ActiveDocument.FormFields("Retencion3").Result = mRetenido
                        oW.ActiveDocument.FormFields("ImporteEnLetras3").Result = mImporteLetras
                        oW.ActiveDocument.FormFields("Fecha3").Result = mFecha
                     
                     End If
            
                  End With
               End With
               
               If mDestino = "Printer" Then
                  mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
                  If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
                  oW.Documents(1).PrintOut False, , , , , , , mCopias
                  If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
                  
                  If mNuevo And Len(mEmail) > 0 And BuscarClaveINI("Enviar certificado de retencion de IIBB por email", -1) = "SI" Then
                     Set goMailOL = New CEmailOL
                     If Len(Dir(mPathArchivosExportados & "CertificadoRetencionIIBB.doc")) > 0 Then Kill mPathArchivosExportados & "CertificadoRetencionIIBB.doc"
                     oW.ActiveDocument.SaveAs Filename:=mPathArchivosExportados & "CertificadoRetencionIIBB.doc", FileFormat:=wdFormatDocument
                     oW.Documents(1).Close False
                     mSubject = "" & glbEmpresa & " - Certificado de retencion IIBB " & Format(mNumeroCertificado, "00000000")
                     mBody = "Certificado de retencion IIBB." & vbCrLf & vbCrLf
                     mAttachment = mPathArchivosExportados & "CertificadoRetencionIIBB.doc"
                     lStatus = goMailOL.Send(mEmail, True, mSubject, mBody, mAttachment)
                  Else
                     oW.Documents(1).Close False
                  End If
               End If
            End If
            oRs.MoveNext
         Loop
      End If
   End If
   oRs.Close
   
   oW.Selection.HomeKey wdStory

Mal:
   If mDestino = "Printer" Then oW.Quit
   Set oW = Nothing
   Set oRs = Nothing
   Set oRsAux = Nothing
   Set cALetra = Nothing
   Set goMailOL = Nothing
   
End Sub












Public Sub EmisionCertificadoRetencionIVA(ByVal mIdOrdenPago As String, _
                                                ByVal mDestino As String, _
                                                ByVal mPrinter As String, _
                                                Optional ByVal mNuevo As Boolean)

   Dim oW As Word.Application
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim goMailOL As CEmailOL
   Dim mNumeroCertificado As Long, mIdProveedor As Long, lStatus As Long
   Dim mCopias As Integer
   Dim mFecha As Date
   Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String, mPlantilla As String, mBody As String, mPathArchivosExportados As String
   Dim mEmail As String, mSubject As String, mAttachment As String, mCuitSujeto As String, mProvincia As String, mPrinterAnt As String, mAux1 As String, mAnulada As String
   Dim mRetenido As Double, mCotMon As Double, mCotMon1 As Double
   
   On Error GoTo Mal
   
   mPlantilla = glbPathPlantillas & "\CertificadoRetencionIVA_" & glbEmpresaSegunString & ".dot"
   If Len(Dir(mPlantilla)) = 0 Then
      mPlantilla = glbPathPlantillas & "\CertificadoRetencionIVA.dot"
      If Len(Dir(mPlantilla)) = 0 Then
         MsgBox "Plantilla " & mPlantilla & " inexistente", vbExclamation
         Exit Sub
      End If
   End If
   
   mCopias = 1
   mAux1 = BuscarClaveINI("Copias retenciones en op")
   If IsNumeric(mAux1) Then mCopias = Val(mAux1)
   
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   If Not IsNull(oRs.Fields("PathArchivosExportados").Value) Then
      mPathArchivosExportados = oRs.Fields("PathArchivosExportados").Value
      If Len(mPathArchivosExportados) = 0 Then mPathArchivosExportados = "C:\"
   Else
      mPathArchivosExportados = "C:\"
   End If
   oRs.Close
   
   Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PorId", mIdOrdenPago)
   With oRs
      mNumeroCertificado = .Fields("NumeroCertificadoRetencionIVA").Value
      mComprobante = Format(.Fields("NumeroOrdenPago").Value, "00000000")
      mIdProveedor = .Fields("IdProveedor").Value
      mCotMon = .Fields("CotizacionMoneda").Value
      mFecha = .Fields("FechaOrdenPago").Value
      mRetenido = .Fields("RetencionIVA").Value * mCotMon
      If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
      .Close
   End With
   
   Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ConDatos", mIdProveedor)
   If oRs.RecordCount > 0 Then
      mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
      mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
      If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
      mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
                           Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
      mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
      mEmail = IIf(IsNull(oRs.Fields("Email").Value), "", oRs.Fields("Email").Value)
   End If
   oRs.Close
   Set oRs = Nothing
   
   Set oW = CreateObject("Word.Application")
   
   With oW
      .Visible = True
      With .Documents.Add(mPlantilla)
         oW.ActiveDocument.FormFields("NumeroCertificado").Result = mNumeroCertificado
         oW.ActiveDocument.FormFields("Fecha").Result = mFecha
         oW.ActiveDocument.FormFields("NombreAgente").Result = glbEmpresa
         oW.ActiveDocument.FormFields("CuitAgente").Result = glbCuit
         oW.ActiveDocument.FormFields("DomicilioAgente").Result = glbDireccion & " " & glbLocalidad & " " & glbProvincia
         oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
         oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
         oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
'         oW.ActiveDocument.FormFields("Comprobante").Result = mComprobante
         oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
      End With
   End With

   oW.Selection.Goto What:=wdGoToBookmark, Name:="DetalleComprobantes"
   oW.Selection.MoveDown Unit:=wdLine
   oW.Selection.MoveLeft Unit:=wdCell
   Set oRsDet = Aplicacion.TablasGenerales.TraerFiltrado("DetOrdenesPago", "OrdenPago", mIdOrdenPago)
   With oRsDet
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If Not IsNull(.Fields("Ret.Iva").Value) And .Fields("Ret.Iva").Value <> 0 Then
               mCotMon1 = IIf(IsNull(.Fields("CotizacionMoneda").Value), 1, .Fields("CotizacionMoneda").Value)
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Comp.").Value), "", .Fields("Comp.").Value) & " " & IIf(IsNull(.Fields("Numero").Value), "", .Fields("Numero").Value)
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & .Fields("Fecha").Value
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & Format(.Fields("Tot.Comp.").Value * mCotMon1, "#,##0.00")
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & Format(.Fields("IVA").Value * mCotMon1, "#,##0.00")
               oW.Selection.MoveRight Unit:=wdCell
               oW.Selection.TypeText Text:="" & Format(.Fields("Ret.Iva").Value, "#,##0.00")
            End If
            .MoveNext
         Loop
      End If
      .Close
   End With
   Set oRsDet = Aplicacion.TablasGenerales.TraerFiltrado("ComprobantesProveedores", "_ConRetencionIvaPorIdOrdenPago", mIdOrdenPago)
   With oRsDet
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            oW.Selection.MoveRight Unit:=wdCell
            oW.Selection.TypeText Text:="" & IIf(IsNull(.Fields("Comprobante").Value), "", .Fields("Comprobante").Value) & " *"
            oW.Selection.MoveRight Unit:=wdCell
            oW.Selection.TypeText Text:="" & .Fields("Fecha").Value
            oW.Selection.MoveRight Unit:=wdCell
            oW.Selection.TypeText Text:="" & Format(.Fields("TotalComprobante").Value, "#,##0.00")
            oW.Selection.MoveRight Unit:=wdCell
            oW.Selection.TypeText Text:="" & Format(.Fields("ImporteIva").Value, "#,##0.00")
            oW.Selection.MoveRight Unit:=wdCell
            oW.Selection.TypeText Text:="" & Format(.Fields("ImporteRetencionIvaEnOrdenPago").Value, "#,##0.00")
            .MoveNext
         Loop
      End If
      .Close
   End With
   Set oRsDet = Nothing

   oW.Selection.Goto What:=wdGoToBookmark, Name:="TotalRetencion"
   oW.Selection.MoveRight Unit:=wdCell, Count:=2
   oW.Selection.TypeText Text:="" & Format(mRetenido, "#,##0.00")

   If mDestino = "Printer" Then
      mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
      If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
      oW.Documents(1).PrintOut False, , , , , , , mCopias
      If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
      
      If mNuevo And Len(mEmail) > 0 And BuscarClaveINI("Enviar certificado de retencion de iva por email", -1) = "SI" Then
         Set goMailOL = New CEmailOL
         If Len(Dir(mPathArchivosExportados & "CertificadoRetencionIva.doc")) > 0 Then Kill mPathArchivosExportados & "CertificadoRetencionIva.doc"
         oW.ActiveDocument.SaveAs Filename:=mPathArchivosExportados & "CertificadoRetencionIva.doc", FileFormat:=wdFormatDocument
         oW.Documents(1).Close False
         mSubject = "" & glbEmpresa & " - Certificado de retencion iva " & Format(mNumeroCertificado, "00000000")
         mBody = "Certificado de retencion iva." & vbCrLf & vbCrLf
         mAttachment = mPathArchivosExportados & "CertificadoRetencionIva.doc"
         lStatus = goMailOL.Send(mEmail, True, mSubject, mBody, mAttachment)
      Else
         oW.Documents(1).Close False
      End If
   End If
   
   oW.Selection.HomeKey wdStory

Mal:
   If mDestino = "Printer" Then oW.Quit
   Set oW = Nothing
   Set goMailOL = Nothing

End Sub















Public Sub EmisionCertificadoRetencionSUSS(ByVal mIdOrdenPago As String, _
                                                ByVal mDestino As String, _
                                                ByVal mPrinter As String, _
                                                Optional ByVal mNuevo As Boolean)

   Dim oW As Word.Application
   Dim oRs As ADOR.Recordset
   Dim oRsDet As ADOR.Recordset
   Dim oRsAux As ADOR.Recordset
   Dim goMailOL As CEmailOL
   Dim mNumeroCertificado As Long, mIdProveedor As Long, lStatus As Long
   Dim mCopias As Integer
   Dim mFecha As Date
   Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String, mPlantilla As String, mBody As String, mPathArchivosExportados As String
   Dim mEmail As String, mSubject As String, mAttachment As String, mCuitSujeto As String, mProvincia As String, mPrinterAnt As String, mAux1 As String, mAnulada As String
   Dim mDescripcionImpuesto As String
   Dim mRetenido As Double, mCotMon As Double, mvarPorcentajeRetencionSUSS As Double, mvarTopeAnualSUSS As Double, mvarBaseCalculoSUSS As Double, mvarRetenidoAño As Double
   Dim mvarImporteAcumulado As Double
   
   On Error GoTo Mal
   
   mPlantilla = glbPathPlantillas & "\CertificadoRetencionSUSS_" & glbEmpresaSegunString & ".dot"
   If Len(Dir(mPlantilla)) = 0 Then
      mPlantilla = glbPathPlantillas & "\CertificadoRetencionSUSS.dot"
      If Len(Dir(mPlantilla)) = 0 Then
         MsgBox "Plantilla " & mPlantilla & " inexistente", vbExclamation
         Exit Sub
      End If
   End If
   
   mCopias = 1
   mAux1 = BuscarClaveINI("Copias retenciones en op")
   If IsNumeric(mAux1) Then mCopias = Val(mAux1)
   
   Set oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
   If Not IsNull(oRs.Fields("PathArchivosExportados").Value) Then
      mPathArchivosExportados = oRs.Fields("PathArchivosExportados").Value
      If Len(mPathArchivosExportados) = 0 Then mPathArchivosExportados = "C:\"
   Else
      mPathArchivosExportados = "C:\"
   End If
   mvarPorcentajeRetencionSUSS = IIf(IsNull(oRs.Fields("PorcentajeRetencionSUSS").Value), 0, oRs.Fields("PorcentajeRetencionSUSS").Value)
   oRs.Close
   
   Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PorId", mIdOrdenPago)
   With oRs
      mNumeroCertificado = .Fields("NumeroCertificadoRetencionSUSS").Value
      mComprobante = Format(.Fields("NumeroOrdenPago").Value, "00000000")
      mIdProveedor = .Fields("IdProveedor").Value
      mCotMon = .Fields("CotizacionMoneda").Value
      mFecha = .Fields("FechaOrdenPago").Value
      mRetenido = .Fields("RetencionSUSS").Value * mCotMon
      If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
      .Close
   End With
   
   mvarTopeAnualSUSS = 0
   mvarRetenidoAño = 0
   mvarImporteAcumulado = 0
   mDescripcionImpuesto = ""
   
   Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ConDatos", mIdProveedor)
   With oRs
      If .RecordCount > 0 Then
         mNombreSujeto = IIf(IsNull(.Fields("RazonSocial").Value), "", .Fields("RazonSocial").Value)
         mProvincia = IIf(IsNull(.Fields("Provincia").Value), "", .Fields("Provincia").Value)
         If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
         mDomicilioSujeto = Trim(IIf(IsNull(.Fields("Direccion").Value), "", .Fields("Direccion").Value)) & " " & _
                              Trim(IIf(IsNull(.Fields("Localidad").Value), "", .Fields("Localidad").Value)) & " " & mProvincia
         mCuitSujeto = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
         mEmail = IIf(IsNull(oRs.Fields("Email").Value), "", oRs.Fields("Email").Value)
         If Not IsNull(.Fields("IdImpuestoDirectoSUSS").Value) Then
            Set oRsAux = Aplicacion.ImpuestosDirectos.TraerFiltrado("_PorId", .Fields("IdImpuestoDirectoSUSS").Value)
            If oRsAux.RecordCount > 0 Then
               mDescripcionImpuesto = IIf(IsNull(oRsAux.Fields("Descripcion").Value), 0, oRsAux.Fields("Descripcion").Value)
               mvarPorcentajeRetencionSUSS = IIf(IsNull(oRsAux.Fields("Tasa").Value), 0, oRsAux.Fields("Tasa").Value)
               mvarTopeAnualSUSS = IIf(IsNull(oRsAux.Fields("TopeAnual").Value), 0, oRsAux.Fields("TopeAnual").Value)
            End If
            oRsAux.Close
         End If
      End If
      .Close
   End With
   
   If mvarTopeAnualSUSS > 0 Then
      Set oRs = Aplicacion.OrdenesPago.TraerFiltrado("_PagosAcumuladoAnual", Array(mIdProveedor, mFecha, mIdOrdenPago))
      With oRs
         If .RecordCount > 0 Then
            mvarRetenidoAño = IIf(IsNull(.Fields("RetenidoAño").Value), 0, .Fields("RetenidoAño").Value)
            mvarImporteAcumulado = IIf(IsNull(.Fields("ImporteAcumulado").Value), 0, .Fields("ImporteAcumulado").Value)
         End If
         .Close
      End With
   End If
   
   Set oRsDet = Aplicacion.TablasGenerales.TraerFiltrado("DetOrdenesPago", "OrdenPago", mIdOrdenPago)
   mvarBaseCalculoSUSS = 0
   With oRsDet
      If .RecordCount > 0 Then
         .MoveFirst
         Do While Not .EOF
            If Not IsNull(.Fields("s/impuesto").Value) And .Fields("Gravado IVA").Value <> 0 Then
               mvarBaseCalculoSUSS = mvarBaseCalculoSUSS + .Fields("Gravado IVA").Value
            Else
               mvarBaseCalculoSUSS = mvarBaseCalculoSUSS + .Fields("Importe").Value
            End If
            .MoveNext
         Loop
      End If
      .Close
   End With
   
   Set oW = CreateObject("Word.Application")
   
   With oW
      .Visible = True
      With .Documents.Add(mPlantilla)
         oW.ActiveDocument.FormFields("Descripcion").Result = mDescripcionImpuesto
         oW.ActiveDocument.FormFields("NumeroCertificado").Result = mNumeroCertificado
         oW.ActiveDocument.FormFields("Fecha").Result = mFecha
         oW.ActiveDocument.FormFields("NombreAgente").Result = glbEmpresa
         oW.ActiveDocument.FormFields("CuitAgente").Result = glbCuit
         oW.ActiveDocument.FormFields("DomicilioAgente").Result = glbDireccion & " " & glbLocalidad & " " & glbProvincia
         oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
         oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
         oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
         oW.ActiveDocument.FormFields("Comprobante").Result = "OP " & mComprobante
         oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
         
         If mvarTopeAnualSUSS > 0 Then
            oW.ActiveDocument.FormFields("Leyenda1").Result = "Pagos acumulados en el año :"
            oW.ActiveDocument.FormFields("Importe1").Result = Format(mvarImporteAcumulado + mvarBaseCalculoSUSS, "#,##0.00")
            oW.ActiveDocument.FormFields("Leyenda2").Result = "Porcentaje aplicado para la retencion :"
            oW.ActiveDocument.FormFields("Importe2").Result = Format(mvarPorcentajeRetencionSUSS, "#,##0.00")
            oW.ActiveDocument.FormFields("Leyenda3").Result = "Retencion sobre acumulado anual :"
            oW.ActiveDocument.FormFields("Importe3").Result = Format(Round((mvarImporteAcumulado + mvarBaseCalculoSUSS) * mvarPorcentajeRetencionSUSS / 100, 2), "#,##0.00")
            oW.ActiveDocument.FormFields("Leyenda4").Result = "Retenido en el año :"
            oW.ActiveDocument.FormFields("Importe4").Result = Format(mvarRetenidoAño, "#,##0.00")
            oW.ActiveDocument.FormFields("Leyenda5").Result = "Retencion realizada :"
            oW.ActiveDocument.FormFields("Importe5").Result = Format(mRetenido, "#,##0.00")
         Else
            oW.ActiveDocument.FormFields("Leyenda1").Result = "Monto del comprobante que origina la retencion :"
            oW.ActiveDocument.FormFields("Importe1").Result = Format(mvarBaseCalculoSUSS, "#,##0.00")
            oW.ActiveDocument.FormFields("Leyenda2").Result = "Porcentaje aplicado para la retencion :"
            oW.ActiveDocument.FormFields("Importe2").Result = Format(mvarPorcentajeRetencionSUSS, "#,##0.00")
            oW.ActiveDocument.FormFields("Leyenda3").Result = "Monto de la retencion :"
            oW.ActiveDocument.FormFields("Importe3").Result = Format(mRetenido, "#,##0.00")
         End If
      End With
   End With
   
   oW.Selection.HomeKey wdStory

   If mDestino = "Printer" Then
      mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
      If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
      oW.Documents(1).PrintOut False, , , , , , , mCopias
      If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
      
      If mNuevo And Len(mEmail) > 0 And BuscarClaveINI("Enviar certificado de retencion de SUSS por email", -1) = "SI" Then
         Set goMailOL = New CEmailOL
         If Len(Dir(mPathArchivosExportados & "CertificadoRetencionSUSS.doc")) > 0 Then Kill mPathArchivosExportados & "CertificadoRetencionSUSS.doc"
         oW.ActiveDocument.SaveAs Filename:=mPathArchivosExportados & "CertificadoRetencionSUSS.doc", FileFormat:=wdFormatDocument
         oW.Documents(1).Close False
         mSubject = "" & glbEmpresa & " - Certificado de retencion SUSS " & Format(mNumeroCertificado, "00000000")
         mBody = "Certificado de retencion SUSS." & vbCrLf & vbCrLf
         mAttachment = mPathArchivosExportados & "CertificadoRetencionSUSS.doc"
         lStatus = goMailOL.Send(mEmail, True, mSubject, mBody, mAttachment)
      Else
         oW.Documents(1).Close False
      End If
   End If
   
Mal:
   If mDestino = "Printer" Then oW.Quit
   Set oW = Nothing
   Set oRs = Nothing
   Set oRsDet = Nothing
   Set oRsAux = Nothing
   Set goMailOL = Nothing
   
End Sub
