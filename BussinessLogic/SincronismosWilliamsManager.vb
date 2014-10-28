﻿Imports Microsoft.VisualBasic
Imports System.Data
Imports System.IO
Imports System.Diagnostics 'para usar Debug.Print
Imports System.Data.SqlClient

Imports System.Linq
Imports System.Linq.Expressions
Imports System.Collections.Generic
Imports System.Linq.Dynamic

Imports CartaDePorteManager
Imports LogicaFacturacion

Imports Pronto.ERP.Bll.EntidadManager

Imports Excel = Microsoft.Office.Interop.Excel



Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports Microsoft.Reporting.WebForms
Imports ProntoFuncionesGenerales
Imports Pronto.ERP.Bll.SincronismosWilliamsManager
Imports Pronto.ERP.Bll.InformesCartaDePorteManager
Imports System.Xml
Imports LogicaInformesWilliamsGerenc







Namespace Pronto.ERP.Bll

    Public Class SincronismosWilliamsManager

        Shared Sub CambiarElNombreDeLaPrimeraHojaDeDow(ByVal fileName As String)
            'traido de http://www.devcurry.com/2009/07/import-excel-data-into-aspnet-gridview_06.html

            Dim oXL As Excel.Application
            Dim oWB As Excel.Workbook
            Dim oSheet As Excel.Worksheet
            Dim oRng As Excel.Range
            Dim oWBs As Excel.Workbooks

            Try
                '  creat a Application object
                oXL = New Excel.ApplicationClass()
                '   get   WorkBook  object
                oWBs = oXL.Workbooks

                Try
                    oWB = oWBs.Open(fileName, Reflection.Missing.Value, Reflection.Missing.Value, _
        Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, _
        Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, Reflection.Missing.Value, _
        Reflection.Missing.Value, Reflection.Missing.Value)
                Catch ex As Exception

                End Try

                'dejé de usar .Sheets
                oSheet = CType(oWB.Worksheets(1), Microsoft.Office.Interop.Excel.Worksheet)


                oSheet.Name = "Hoja1"
                oXL.ActiveWorkbook.Save()





            Catch ex As Exception
                ErrHandler.WriteError("No pudo extraer el excel. " + ex.ToString)
            Finally
                Try
                    'The service (excel.exe) will continue to run
                    If Not oWB Is Nothing Then oWB.Close(False)
                    NAR(oWB)
                    oWBs.Close()
                    NAR(oWBs)
                    'quit and dispose app
                    oXL.Quit()
                    NAR(oXL)
                    'VERY IMPORTANT
                    GC.Collect()

                    'Dispose()  'este me arruinaba todo, me hacia aparecer el cartelote del Prerender
                Catch ex As Exception
                    ErrHandler.WriteError("No pudo cerrar el servicio excel. " + ex.ToString)
                End Try
            End Try

        End Sub
        'Private Shared _iisValidSqlDate As Object

        'Private Shared Property iisValidSqlDate(ByVal p1 As Date) As Object
        '    Get
        '        Return _iisValidSqlDate
        '    End Get
        '    Set(ByVal value As Object)
        '        _iisValidSqlDate = value
        '    End Set
        'End Property-

        Const bPrefijadorauto As Boolean = True








        Public Shared Function Sincronismo_ZENI(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, ByVal titulo As String, ByVal sWHERE As String, ByRef sErrores As String) As String





            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroZENI " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            'Dim a = pDataTable(1)

            Dim sErroresProcedencia, sErroresDestinos As String


            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0


                    sb &= .CodigoSAJPYA.PadLeft(3) 'Grano	STRING(3)	Código de grano Sagpya)    1)    3
                    sb &= IIf(True, 1, 2).ToString.PadRight(3) 'GranelBolsa	STRING(3)	Embalaje del grano 1=Granel 2=Bolsa)    4)    6

                    sb &= Right(.Cosecha, 5).Replace("/", "").PadLeft(4)

                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= Convert.ToDateTime(iisValidSqlDate(.FechaArribo)).ToString("ddMMyyyy") 'FecIng	STRING(8)	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001)    11)    18


                    If .IsHoraNull Then
                        sb &= #12:00:00 AM#.ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    Else
                        sb &= Convert.ToDateTime(.Hora).ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    End If


                    sb &= "  "


                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= Convert.ToDateTime(iisValidSqlDate(.FechaDescarga)).ToString("ddMMyyyy") 'FecSal	STRING(8)	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001)    27)    34
                    sb &= Convert.ToDateTime(iisNull(.FechaDescarga, #12:00:00 AM#)).ToString("hhmmss") 'HorSal	STRING(8)	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556)    35)    42


                    sb &= "  "




                    Dim VendedorCUIT, VendedorDesc As String
                    ' If InStr(.RComercialDesc, "AMAGGI") > 0 Then Stop

                    If .RComercialDesc <> "" And InStr(.RComercialDesc, "ZENI") = 0 Then
                        VendedorCUIT = .RComercialCUIT
                        VendedorDesc = .RComercialDesc
                    ElseIf .IntermediarioDesc <> "" Then
                        VendedorCUIT = .IntermediarioCUIT
                        VendedorDesc = .IntermediarioDesc
                    Else
                        VendedorCUIT = .TitularCUIT
                        VendedorDesc = .TitularDesc
                    End If



                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular
                    'Corredor Endozo		    ?
                    'Comprador Endozo		    ?
                    'Corredor Vendedor		    ?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino


                    '"Según entiendo yo los cambios a realizar:
                    '- En la fecha de Ingreso y de Salida usar formato DDMMYYYY
                    '- En CUIT de planta Origen usar 30646328450
                    '- En Nombre de Planta Origen usar “PLANTA UNICA”
                    '- Mandar el Peso Bruto donde estamos mandando el Peso Neto y viceversa.
                    '- Mandar Movimiento de Stock en 1
                    '- Qué paso con las observaciones? Yo creo que están saliendo"




                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""

                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPuerto	STRING(30)	Nombre Puerto)    57)    86

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130

                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218


                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130

                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITEntregador	STRING(14)	CUIT Entregador)    219)    232
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomEntregador	STRING(30)	Nombre Entregador)    233)    262


                    '////////////////////////////////////////////////////////////////////////////////
                    'Strongly Typed DataSets encountering NULL values – Grrrrrr… 
                    'http://social.msdn.microsoft.com/forums/en-US/winformsdatacontrols/thread/1dad8d0d-6eae-4254-a9d6-22d50da5578a
                    '////////////////////////////////////////////////////////////////////////////////

                    If .IsClienteFacturadoCUITNull Then .ClienteFacturadoCUIT = ""
                    sb &= Left(.ClienteFacturadoCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCargador	STRING(14)	CUIT Cargador)    263)    276
                    If .IsClienteFacturadoNull Then .ClienteFacturado = ""
                    sb &= Left(.ClienteFacturado.ToString, 30).PadRight(30) 'NomCargador 	STRING(30)	Nombre Cargador)    277)    306



                    sb &= Left(cadenavacia.ToString, 14).PadRight(14) 'CUITCorrEndo	STRING(14)	CUIT  Corredor Endozo)    351)    364
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomCorrEndo	STRING(30)	Nombre Corredor Endozo)    365)    394

                    sb &= Left(cadenavacia.ToString, 14).PadRight(14) 'CUITCompEndo	STRING(14)	CUIT Comprador Endozo)    395)    408
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomCompEndo	STRING(30)	Nombre Comprador Endozo)    409)    438

                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9214
                    sb &= Left(VendedorCUIT.Replace("-", ""), 14).PadRight(14) 'CUITEntregador	STRING(14)	CUIT Entregador)    219)    232
                    sb &= Left(VendedorDesc, 30).PadRight(30) 'NomEntregador	STRING(30)	Nombre Entregador)    233)    262



                    Dim cuiplantaorigen = "30646328450"
                    Dim plantaorigenDesc = "PLANTA UNICA"
                    sb &= Left(cuiplantaorigen.ToString.Replace("-", ""), 14).PadRight(14)
                    sb &= Left(plantaorigenDesc.ToString, 30).PadRight(30)






                    sb &= Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
                    sb &= Left(.ProcedenciaDesc.ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
                    sb &= Left(.DestinoCodigoPostal.ToString, 8).PadRight(8) 'CPDestino	STRING(8)	Código Postal Destino)    565)    572
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602


                    If .ProcedenciaCodigoPostal.ToString = "" And InStr(sErroresProcedencia, .ProcedenciaDesc.ToString) = 0 Then
                        'si no tiene codigo ni está ya en sErrores, lo meto

                        ErrHandler.WriteError("La procedencia " & .ProcedenciaDesc.ToString & " no tiene codigo postal")
                        'ErrHandler.WriteError("La carta " & .NumeroCartaDePorte & " no tiene codigo postal de procedencia")

                        'sErroresProcedencia &= "<a href=""CartaPorte.aspx?Id=" & .IdCartaDePorte & """ target=""_blank"">" & .NumeroCartaDePorte & "</a>; "


                        sErroresProcedencia &= "<a href=""Localidades.aspx?Id=" & .Procedencia & """ target=""_blank"">" & .ProcedenciaDesc & "</a>; "
                    End If

                    If .DestinoCodigoPostal.ToString = "" And InStr(sErroresDestinos, .DestinoDesc.ToString) = 0 Then
                        'si no tiene codigo ni está ya en sErrores, lo meto

                        'ErrHandler.WriteError("La carta " & .NumeroCartaDePorte & " no tiene codigo postal de destino")
                        'sErroresDestinos &= "<a href=""CartaPorte.aspx?Id=" & .IdCartaDePorte & """ target=""_blank"">" & .NumeroCartaDePorte & "</a>; "
                        ErrHandler.WriteError("El destino " & .DestinoDesc.ToString & " no tiene codigo postal")

                        sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & .Destino & """ target=""_blank"">" & .DestinoDesc & "</a>; "
                    End If







                    sb &= IIf(True, 1, 0).ToString.PadRight(1) 'CodMovIE	STRING(1)	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr)    603)    603
                    sb &= Left(.Patente.ToString, 6).PadRight(10) 'PatCha	STRING(6)	Patente chasis)    604)    609
                    'sb &= Left(.Acoplado.ToString, 6).PadRight(6) 'PatAcoplado	STRING(6)	Acoplado chasis)    610)    615




                    ''http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9330
                    'estaba pasando el bruto/tara/neto de posicion
                    'sb &= Int(.BrutoPto).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    'sb &= Int(.TaraPto).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    'sb &= Int(.NetoPto).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    'sb &= Int(.Merma).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655
                    'sb &= Int(.NetoFinal).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665

                    sb &= Int(.BrutoFinal).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= Int(.TaraFinal).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= Int(.NetoFinal).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    sb &= Int(.Merma + .HumedadDesnormalizada).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655
                    sb &= Int(.NetoProc).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665





                    sb &= String.Format("{0:F1}", .Humedad).PadLeft(10) 'PorHume	STRING(10)	Porcentaje humedad (un (1) decimal))    666)    675
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorMemaHumedad	STRING(10)	Porcentaje merma humedad (dos (2) decimales))    676)    685
                    sb &= Int(.Merma).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695
                    sb &= Left(cadenavacia.ToString, 10).PadLeft(10) 'PBonHume	STRING(10)	Porcentaje bonificación humedad (dos (2) decimales))    696)    705
                    sb &= Left(cadenavacia.ToString, 10).PadLeft(10) 'KgsBonHu	STRING(10)	Kilos bonificación humedad)    706)    715
                    'esto?
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorZaran	STRING(10)	Porcentaje zarandeo (dos (2) decimales))    716)    725
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10, "0") 'KgsZaran	STRING(10)	Kilos zarandeo (sin decimales))    726)    735
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorDesca	STRING(10)	Porcentaje descarte (dos (2) decimales))    736)    745
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsDesca	STRING(10)	Kilogramos Descarte (Sin Decimales))    746)    755
                    sb &= Left(Val(cadenavacia).ToString, 10).PadLeft(10) 'PorVolat	STRING(10)	Porcentaje volátil (dos (2) decimales))    756)    765
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsVolat	STRING(10)	Kilogramos volátil (sin decimales))    766)    775




                    sb &= Left(cadenavacia.ToString, 8).PadLeft(8) 'CantBolsa	STRING(8)	Cantidad de bolsas)    776)    783
                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'Fumigada	STRING(1)	Condición fumigada 0=no 1=si)    784)    784
                    sb &= Int(.NetoProc).ToString.PadRight(10) 'PesoProcede	STRING(10)	Peso procedencia (Sin Decimales))    785)    794
                    sb &= Left(.Contrato.ToString, 12).PadLeft(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826

                    '//////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////
                    'NO NOS ESTAN ACLARANDO QUÉ SON ESTOS 14 QUE VIENEN 
                    ' DESPUES DEL CONTRATO EN LA POSICION 805
                    sb &= Left(.NumeroCartaDePorte.ToString, 14).PadLeft(14)
                    '//////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////





                    sb &= IIf(True, "c", "v").ToString.PadRight(1) 'TipoTrans	STRING(1)	Tipo de transporte c=camión  v=vagón o=Otro)    841)    841


                    sb &= Left(.NobleGrado.ToString, 10).PadRight(10) 'Grado	STRING(10)	Grado)    842)    851
                    sb &= Left(.Factor.ToString, 10).PadRight(10) 'Factor	STRING(10)	Factor)    852)    861

                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'Observac	STRING(100)	Observaciones)    862)    961


                    'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)
                    Dim sCalidad As String
                    If InStr(.Calidad.ToString.ToLower, "grado 1") > 0 Then
                        sCalidad = "G1"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 2") > 0 Then
                        sCalidad = "G2"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 3") > 0 Then
                        sCalidad = "G3"
                    ElseIf InStr(.Calidad.ToString.ToLower, "camara") > 0 Then
                        sCalidad = "CC"
                    Else
                        sCalidad = "FE"
                    End If
                    sb &= sCalidad.PadRight(4) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



                    sb &= IIf(False, 0, 1).ToString.PadRight(1) 'MovStock	STRING(1)	Señal 1=Movió mercadería)       0=No movió mercadería)    966)    966
                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'ObsAna	STRING(100)	Observaciones Analisis)    967)    1066


                    sb &= Left(Int(.Merma).ToString, 10).PadLeft(10)

                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    'FALTA QUE NOS DIGAN QUE SON ESTOS 25 CARACTERES
                    'sb &= String.Empty.PadRight(25)
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////


                    'sb = sb.Replace(".", ",") 'solucion cabeza por los decimales



                    'For Each dc In pDataTable.Columns
                    '    If Not IsDBNull(dr(i)) Then
                    '        Try
                    '            If IsNumeric(dr(i)) Then
                    '                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                    '            Else
                    '                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                    '            End If
                    '        Catch x As Exception
                    '            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                    '        End Try
                    '    Else
                    '        sb &= Microsoft.VisualBasic.ControlChars.Tab
                    '    End If
                    '    i += 1
                    'Next






                    PrintLine(nF, sb)
                End With
            Next


            FileClose(nF)




            sErrores = "Procedencias sin código postal:<br/> " & sErroresProcedencia & "<br/>Destinos sin código postal: <br/>" & sErroresDestinos

            If True Then
                If sErroresProcedencia <> "" Or sErroresDestinos <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If



            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function




        Public Shared Function Sincronismo_Alabern(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, ByVal titulo As String, ByVal sWHERE As String, ByRef sErrores As String) As String






            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            'Dim vFileName As String = Path.GetTempPath & "DescargasW Alabern" & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            Dim nombre As String
            Dim pv As Integer
            Select Case pv
                Case 1
                    nombre = "DescargasW_BA.txt"
                Case 2
                    nombre = "DescargasW_SL.txt"
                Case 3
                    nombre = "DescargasW_AS.txt"
                Case 4
                    nombre = "DescargasW_BB.txt"
                Case Else
                    nombre = "DescargasW.txt"
            End Select
            Dim vFileName As String = Path.GetTempPath & nombre




            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            'Dim a = pDataTable(1)

            Dim sErroresProcedencia As String = "", sErroresDestinos As String = "", sErroresPrefijo As String = ""


            sb = "Pre |CP      |Vagon   |Fecha Des  |Mer |Descripcion         |Contrato    |CUIT        |Titular                       |Cuit        |Intermediario                 |Cuit        |Rem.Comercial                 |Cuit        |Corredor                      |Cuit        |Destinatario                  |Proced |Descripcion         |Cuit Puerto |Planta|Descripcion         |BrutoPr |TaraPr  |NetoPr  |Bruto   |Tara    |Neto    |MermaTot|Neto Apl|Cal|Cam|Paten  |PatenA |CEE           |Fecha Venc|Fecha Port|Cuit        |Entregador               |CUIT        |Transportista                 |Recibo      |Observaciones                                               |CUIT Chofer |CTG     |Cose|C.Postal|Fecha Arr |T|Km a rec|TarxTon  |TarRef"
            PrintLine(nF, sb)
            sb = "0005|29662696|        |18/02/2013 |023 |Soja                |            |23061320709 |MARANI LUIS AUGUSTO           |00000000000 |                              |30709792888 |Cibeles Cereales              |30506732499 |Alabern Fabrega               |33506737449 |NIDERA                        |002293 |CASILDA             |33506737449 |021583|NIDERA-PGSM         |00000000|00000000|00031000|00045150|00013840|00031310|00000000|00031310|CO |No |KMQ433 |       |99999999999999|01/01/1900|18/02/2013|30556991835 |Martino y Cia.           |20225555371 |TASSI VICTOR JOSE             |000000000000|                                                            |00000000000 |0       |1112|2170    |18/02/2013|A|0       |0        |0"
            'PrintLine(nF, sb)



            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0






                    Dim VendedorCUIT, VendedorDesc As String
                    ' If InStr(.RComercialDesc, "AMAGGI") > 0 Then Stop

                    If .RComercialDesc <> "" And InStr(.RComercialDesc, "ZENI") = 0 Then
                        VendedorCUIT = .RComercialCUIT
                        VendedorDesc = .RComercialDesc
                    ElseIf .IntermediarioDesc <> "" Then
                        VendedorCUIT = .IntermediarioCUIT
                        VendedorDesc = .IntermediarioDesc
                    Else
                        VendedorCUIT = .TitularCUIT
                        VendedorDesc = .TitularDesc
                    End If



                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular
                    'Corredor Endozo		    ?
                    'Comprador Endozo		    ?
                    'Corredor Vendedor		    ?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino


                    '"Según entiendo yo los cambios a realizar:
                    '- En la fecha de Ingreso y de Salida usar formato DDMMYYYY
                    '- En CUIT de planta Origen usar 30646328450
                    '- En Nombre de Planta Origen usar “PLANTA UNICA”
                    '- Mandar el Peso Bruto donde estamos mandando el Peso Neto y viceversa.
                    '- Mandar Movimiento de Stock en 1
                    '- Qué paso con las observaciones? Yo creo que están saliendo"




                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""





                    '01	Pre	04	0000	Sufijo de Carta de Porte
                    Dim prefijo = Left(.NumeroCartaDePorte.ToString, IIf(Len(.NumeroCartaDePorte.ToString) > 8, Len(.NumeroCartaDePorte.ToString) - 8, 0)).PadLeft(4, "0")
                    If prefijo = "0000" Then
                        If bPrefijadorauto Then
                            prefijo = "0005"
                        Else
                            sErroresPrefijo &= "<a href=""CartaDePorte.aspx?Id=" & .IdCartaDePorte & """ target=""_blank"">" & .NumeroCartaDePorte & "</a>; "
                        End If

                    End If
                    sb &= prefijo

                    '02	CP	08	00000000	N° de Carta de Porte
                    sb &= "|" & JustificadoDerecha(Right(.NumeroCartaDePorte.ToString, 8), 8)

                    '03	Vagon	08	Alfanum	N° de Vagón
                    sb &= "|" & JustificadoDerecha(.SubnumeroVagon.ToString, 8)


                    '04	FechaDes	11	dd/mm/aaaab	Fecha Descarga
                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= "|" & Convert.ToDateTime(iisValidSqlDate(.FechaDescarga)).ToString("dd/MM/yyyy") & " "

                    '05	Mer	04	000b	Código de Producto AFIP
                    sb &= "|" & .CodigoSAJPYA.PadLeft(3) & " "

                    '06	Descripcion	20	Alfab	Nombre del Producto
                    sb &= "|" & JustificadoIzquierda(.Producto, 20)

                    '07	Contrato	12	Alfab	N° de Contrato externo
                    sb &= "|" & Left(.Contrato.ToString, 12).PadLeft(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826

                    '08	CUIT	12	00000000000b	CUIT Titular
                    '09	Titular	30	Alfab	Nombre Titular
                    sb &= "|" & JustificadoIzquierda(.TitularCUIT.ToString.Replace("-", ""), 12)
                    sb &= "|" & JustificadoIzquierda(.TitularDesc.ToString, 30)

                    '10	CUIT	12	00000000000b	CUIT Intermediario
                    '11	Intermediario	30	Alfab	Nombre Intermediario
                    sb &= "|" & JustificadoIzquierda(.IntermediarioCUIT.ToString.Replace("-", ""), 12)
                    sb &= "|" & JustificadoIzquierda(.IntermediarioDesc.ToString, 30)

                    '12	CUIT	12	00000000000b	CUIT Remitente Comercial
                    '13:         REM.Comercial	30	Alfab	Nombre Remitente Comercial
                    sb &= "|" & JustificadoIzquierda(.RComercialCUIT.ToString.Replace("-", ""), 12)
                    sb &= "|" & JustificadoIzquierda(.RComercialDesc.ToString, 30)

                    '14	CUIT	12	00000000000b	CUIT Corredor
                    '15	Corredor	30	Alfab	Nombre Corredor
                    sb &= "|" & JustificadoIzquierda(.CorredorCUIT.ToString.Replace("-", ""), 12)
                    sb &= "|" & JustificadoIzquierda(.CorredorDesc.ToString, 30)


                    '16	CUIT	12	00000000000b	CUIT Destinatario
                    '17	Destinatario	30	Alfab	Nombre Destinatario
                    sb &= "|" & JustificadoIzquierda(.DestinatarioCUIT.ToString.Replace("-", ""), 12)
                    sb &= "|" & JustificadoIzquierda(.DestinatarioDesc.ToString, 30)


                    '18	Proced	07	000000	Código de Procedencia (Cod.Localidad Oncca)
                    '19	Descripcion	20	Alfab	Nombre Procedencia
                    sb &= "|" & Left(.ProcedenciaCodigoONCAA.ToString, 7).PadRight(7)
                    sb &= "|" & Left(.ProcedenciaDesc.ToString, 20).PadRight(20)






                    '+ Codigo Planta = Codigo Establecimiento ONCCA (6 digitos, nos están enviando con 5 dígitos)

                    '20	CUIT Puerto	12	00000000000b	CUIT del Puerto - DESTINO
                    '21	Plan	06	0000	Cod.Establecimiento Oncca - DESTINO
                    '22	Descripcion	20	Alfab	Nombre de Establecimiento Oncca - DESTINO
                    sb &= "|" & Left(.DestinoCUIT.ToString.Replace("-", ""), 11).PadRight(11) & " "
                    sb &= "|" & Left(.DestinoCodigoONCAA.ToString, 6).PadLeft(6, "0")
                    sb &= "|" & Left(.DestinoDesc.ToString, 20).PadRight(20)




                    '23	BrutoPr	08	00000000	Kgs.Brutos Procedencia
                    '24	TaraPr	08	00000000	Tara Procedencia
                    '25	NetoPr	08	00000000	Kgs.Neto Procedencia
                    sb &= "|" & Int(.BrutoPto).ToString.PadLeft(8, "0") 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= "|" & Int(.TaraPto).ToString.PadLeft(8, "0") 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= "|" & Int(.NetoPto).ToString.PadLeft(8, "0") 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645

                    '26	Bruto	08	00000000	Kgs.Bruto
                    '27	Tara	08	00000000	Tara
                    '28	Neto	08	00000000	Neto
                    sb &= "|" & Int(.BrutoFinal).ToString.PadLeft(8, "0") 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= "|" & Int(.TaraFinal).ToString.PadLeft(8, "0") 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= "|" & Int(.NetoFinal).ToString.PadLeft(8, "0") 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645

                    '29	MermaTot	08	00000000	Merma Total
                    sb &= "|" & Int(.Merma + .HumedadDesnormalizada).ToString.PadLeft(8, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655


                    '30	Neto Apl	08	00000000	Kgs.Neto Aplicados
                    sb &= "|" & Int(.NetoProc).ToString.PadLeft(8, "0")





                    '31	Cal	03	Alfab	Calidad (Ver Tablas)
                    Dim sCalidad As String

                    Try
                        If InStr(.CalidadDesc.ToString.ToLower, "conforme") > 0 Then
                            sCalidad = "CO"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 1") > 0 Then
                            sCalidad = "G1"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 2") > 0 Then
                            sCalidad = "G2"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 3") > 0 Then
                            sCalidad = "G3"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "camara") > 0 Then
                            sCalidad = "CC"
                        Else
                            sCalidad = "FE"
                        End If
                    Catch ex As Exception
                        ErrHandler.WriteError("Sincro alabern")
                        ErrHandler.WriteError(ex)
                    End Try
                    If .IsCalidadDescNull Then sCalidad = "3"
                    sb &= "|" & sCalidad.PadRight(3) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



                    '+ Cam = \"Si\" o \"No\", nos están enviando 0 o 1 
                    '32	Cam	03	Alfab	Ingreso a Camara  ("Si" / "No")
                    sb &= "|" & JustificadoIzquierda(IIf(.NobleACamara = "0", "No", "Si").ToString, 3)


                    '33	Paten	07	Alfab	Código de Patente
                    sb &= "|" & Left(.Patente.ToString, 6).PadRight(7) 'PatCha	STRING(6)	Patente chasis)    604)    609

                    '34	PatenA	07	Alfab	Código de Patente Acoplado
                    sb &= "|" & JustificadoIzquierda(.Acoplado.ToString, 7)
                    'sb &= Left(.Acoplado.ToString, 6).PadRight(6) 'PatAcoplado	STRING(6)	Acoplado chasis)    610)    615

                    '35	CEE	14	99999999999999	C.E.E.
                    sb &= "|" & JustificadoIzquierda(.CEE.ToString, 14)

                    '36	Fecha Ven	10	dd/mm/aaaa	Fecha Vencimiento
                    If .IsFechaVencimientoNull Then .FechaVencimiento = Nothing
                    sb &= "|" & Convert.ToDateTime(iisValidSqlDate(.FechaVencimiento)).ToString("dd/MM/yyyy")


                    '+ Fecha Port = formato dd/mm/aaaa, nos están enviando un valor numérico sin formato

                    '37	Fecha Port	10	dd/mm/aaaa	Fecha CP
                    sb &= "|" & Convert.ToDateTime(iisValidSqlDate(.FechaDescarga)).ToString("dd/MM/yyyy")



                    '38	CUIT	12	00000000000b	CUIT Entregador
                    '39	Entregador	25	Alfab	Nombre Entregador
                    sb &= "|" & Left(wilycuit.ToString.Replace("-", ""), 11).PadRight(11) & " "
                    sb &= "|" & Left(wily.ToString, 25).PadRight(25) 'Nombre entregador	25	A	


                    '40	CUIT	12	00000000000b	CUIT Transportista
                    If .IsTransportistaCUITNull Then .TransportistaCUIT = ""
                    sb &= "|" & JustificadoIzquierda(.TransportistaCUIT.ToString, 12)
                    '41	Transportista	30	Alfab	Nombre Transportista
                    sb &= "|" & JustificadoIzquierda(.TransportistaDesc.ToString, 30)

                    '42	Recibo	12	000000000000	N° de Recibo
                    sb &= "|" & .NRecibo.ToString.PadLeft(12)

                    '43	Observaciones	60	Alfab	Observaciones varias 
                    sb &= "|" & .Observaciones.ToString.PadLeft(60)

                    '44	CUIT Chofer	12	00000000000b	CUIT Chofer
                    If .IschoferCUITNull Then .choferCUIT = ""
                    sb &= "|" & JustificadoIzquierda(.choferCUIT.ToString.Replace("-", ""), 12)


                    '45	C.T.G.	08	00000000	Cód.Trazabilidad de Granos
                    sb &= "|" & JustificadoIzquierda(.CTG.ToString, 8)

                    '46	Cos.	04	xxyy	Cosecha
                    sb &= "|" & Right(.Cosecha, 5).Replace("/", "").PadLeft(4)


                    '47	CP Procedencia	08	NNNNbbbb	Cód.Postal Procedencia
                    sb &= "|" & Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534

                    '48	Fecha Arribo	10	dd/mm/aaaa	Fecha de Arribo
                    If .IsFechaIngresoNull Then .FechaIngreso = Nothing
                    sb &= "|" & Convert.ToDateTime(iisValidSqlDate(.FechaIngreso)).ToString("dd/MM/yyyy")


                    '49	T	01		Tipo Transporte ( A - Automotor,V - Vagon,O - Otros)
                    '                   1 = Transporte Automotor
                    '2 = Vagón Ferroviario
                    '3 = Barcaza
                    '4 = Otros
                    sb &= "|" & JustificadoIzquierda(IIf(.SubnumeroVagon > 0, 2, 1), 1)

                    '+ Km a rec. = \"Coma\" como separador decimal, nos están enviando el \"Punto\" decimal
                    '50	Km a rec	08	xxxxbbbb	Km.a Recorrer
                    sb &= "|" & JustificadoIzquierda(.KmARecorrer.ToString.Replace(".", ","), 8)
                    '51	TarxTon	09	|xx,yybbbb|	Tarifa x Tn
                    sb &= "|" & JustificadoIzquierda(.Tarifa.ToString("00.00", System.Globalization.CultureInfo.InvariantCulture).Replace(".", ","), 9)
                    '52	TarRef 	09	|xx,yybbbb|	Tarifa Referencia
                    sb &= "|" & JustificadoIzquierda(.Tarifa.ToString("00.00", System.Globalization.CultureInfo.InvariantCulture).Replace(".", ","), 9)










                    'Dim cuiplantaorigen = "30646328450"
                    'Dim plantaorigenDesc = "PLANTA UNICA"
                    'sb &= Left(cuiplantaorigen.ToString.Replace("-", ""), 14).PadRight(14)
                    'sb &= Left(plantaorigenDesc.ToString, 30).PadRight(30)






                    'sb &= Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
                    'sb &= Left(.ProcedenciaDesc.ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
                    'sb &= Left(.DestinoCodigoPostal.ToString, 8).PadRight(8) 'CPDestino	STRING(8)	Código Postal Destino)    565)    572
                    'sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602


                    If .ProcedenciaCodigoONCAA.ToString = "" And InStr(sErroresProcedencia, .ProcedenciaDesc.ToString) = 0 Then
                        'si no tiene codigo ni está ya en sErrores, lo meto

                        ErrHandler.WriteError("La procedencia " & .ProcedenciaDesc.ToString & " no tiene codigo oncca")
                        'ErrHandler.WriteError("La carta " & .NumeroCartaDePorte & " no tiene codigo postal de procedencia")

                        'sErroresProcedencia &= "<a href=""CartaPorte.aspx?Id=" & .IdCartaDePorte & """ target=""_blank"">" & .NumeroCartaDePorte & "</a>; "


                        sErroresProcedencia &= "<a href=""Localidades.aspx?Id=" & .Procedencia & """ target=""_blank"">" & .ProcedenciaDesc & "</a>; "

                        '  por que uso el codigo postal en alabern, si me piden el codigo oncca?

                    End If

                    If .DestinoCodigoONCAA.ToString = "" And InStr(sErroresDestinos, .DestinoDesc.ToString) = 0 Then
                        'si no tiene codigo ni está ya en sErrores, lo meto

                        'ErrHandler.WriteError("La carta " & .NumeroCartaDePorte & " no tiene codigo postal de destino")
                        'sErroresDestinos &= "<a href=""CartaPorte.aspx?Id=" & .IdCartaDePorte & """ target=""_blank"">" & .NumeroCartaDePorte & "</a>; "
                        ErrHandler.WriteError("El destino " & .DestinoDesc.ToString & " no tiene codigo oncca")

                        sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & .Destino & """ target=""_blank"">" & .DestinoDesc & "</a>; "


                        '      por que uso el codigo postal en alabern, si me piden el codigo oncca?
                    End If









                    ''http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9330
                    'estaba pasando el bruto/tara/neto de posicion
                    'sb &= Int(.BrutoPto).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    'sb &= Int(.TaraPto).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    'sb &= Int(.NetoPto).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    'sb &= Int(.Merma).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655
                    'sb &= Int(.NetoFinal).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665

                    'sb &= Int(.BrutoFinal).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    'sb &= Int(.TaraFinal).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    'sb &= Int(.NetoFinal).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    'sb &= Int(.Merma + .HumedadDesnormalizada).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655
                    'sb &= Int(.NetoProc).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665





                    'sb &= String.Format("{0:F1}", .Humedad).PadLeft(10) 'PorHume	STRING(10)	Porcentaje humedad (un (1) decimal))    666)    675
                    'sb &= cadenavacia.ToString.PadLeft(10) 'PorMemaHumedad	STRING(10)	Porcentaje merma humedad (dos (2) decimales))    676)    685
                    'sb &= Int(.Merma).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695
                    'sb &= Left(cadenavacia.ToString, 10).PadLeft(10) 'PBonHume	STRING(10)	Porcentaje bonificación humedad (dos (2) decimales))    696)    705
                    'sb &= Left(cadenavacia.ToString, 10).PadLeft(10) 'KgsBonHu	STRING(10)	Kilos bonificación humedad)    706)    715
                    ''esto?
                    'sb &= cadenavacia.ToString.PadLeft(10) 'PorZaran	STRING(10)	Porcentaje zarandeo (dos (2) decimales))    716)    725
                    'sb &= Int(Val(cadenavacia)).ToString.PadLeft(10, "0") 'KgsZaran	STRING(10)	Kilos zarandeo (sin decimales))    726)    735
                    'sb &= cadenavacia.ToString.PadLeft(10) 'PorDesca	STRING(10)	Porcentaje descarte (dos (2) decimales))    736)    745
                    'sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsDesca	STRING(10)	Kilogramos Descarte (Sin Decimales))    746)    755
                    'sb &= Left(Val(cadenavacia).ToString, 10).PadLeft(10) 'PorVolat	STRING(10)	Porcentaje volátil (dos (2) decimales))    756)    765
                    'sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsVolat	STRING(10)	Kilogramos volátil (sin decimales))    766)    775




                    'sb &= Left(cadenavacia.ToString, 8).PadLeft(8) 'CantBolsa	STRING(8)	Cantidad de bolsas)    776)    783
                    'sb &= IIf(True, 0, 1).ToString.PadRight(1) 'Fumigada	STRING(1)	Condición fumigada 0=no 1=si)    784)    784
                    'sb &= Int(.NetoProc).ToString.PadRight(10) 'PesoProcede	STRING(10)	Peso procedencia (Sin Decimales))    785)    794
                    'sb &= Left(.Contrato.ToString, 12).PadLeft(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826

                    ''//////////////////////////////////////////////////////////
                    ''//////////////////////////////////////////////////////////
                    ''NO NOS ESTAN ACLARANDO QUÉ SON ESTOS 14 QUE VIENEN 
                    '' DESPUES DEL CONTRATO EN LA POSICION 805
                    'sb &= Left(.NumeroCartaDePorte.ToString, 14).PadLeft(14)
                    ''//////////////////////////////////////////////////////////
                    ''//////////////////////////////////////////////////////////





                    'sb &= IIf(True, "c", "v").ToString.PadRight(1) 'TipoTrans	STRING(1)	Tipo de transporte c=camión  v=vagón o=Otro)    841)    841


                    'sb &= Left(.NobleGrado.ToString, 10).PadRight(10) 'Grado	STRING(10)	Grado)    842)    851
                    'sb &= Left(.Factor.ToString, 10).PadRight(10) 'Factor	STRING(10)	Factor)    852)    861

                    'sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'Observac	STRING(100)	Observaciones)    862)    961


                    ''ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)
                    'Dim sCalidad As String
                    'If InStr(.Calidad.ToString.ToLower, "grado 1") > 0 Then
                    '    sCalidad = "G1"
                    'ElseIf InStr(.Calidad.ToString.ToLower, "grado 2") > 0 Then
                    '    sCalidad = "G2"
                    'ElseIf InStr(.Calidad.ToString.ToLower, "grado 3") > 0 Then
                    '    sCalidad = "G3"
                    'ElseIf InStr(.Calidad.ToString.ToLower, "camara") > 0 Then
                    '    sCalidad = "CC"
                    'Else
                    '    sCalidad = "FE"
                    'End If
                    'sb &= sCalidad.PadRight(4) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



                    'sb &= IIf(False, 0, 1).ToString.PadRight(1) 'MovStock	STRING(1)	Señal 1=Movió mercadería)       0=No movió mercadería)    966)    966
                    'sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'ObsAna	STRING(100)	Observaciones Analisis)    967)    1066


                    'sb &= Left(Int(.Merma).ToString, 10).PadLeft(10)

                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    'FALTA QUE NOS DIGAN QUE SON ESTOS 25 CARACTERES
                    'sb &= String.Empty.PadRight(25)
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////


                    'sb = sb.Replace(".", ",") 'solucion cabeza por los decimales



                    'For Each dc In pDataTable.Columns
                    '    If Not IsDBNull(dr(i)) Then
                    '        Try
                    '            If IsNumeric(dr(i)) Then
                    '                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                    '            Else
                    '                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                    '            End If
                    '        Catch x As Exception
                    '            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                    '        End Try
                    '    Else
                    '        sb &= Microsoft.VisualBasic.ControlChars.Tab
                    '    End If
                    '    i += 1
                    'Next






                    PrintLine(nF, sb)
                End With
            Next


            FileClose(nF)







            sErrores = "<br/>Cartas sin prefijo: <br/>" & sErroresPrefijo & "<br/> Procedencias sin código ONCCA:<br/> " & sErroresProcedencia & "<br/>Destinos sin código ONCCA: <br/>" & sErroresDestinos

            If True Then
                If sErroresPrefijo <> "" Or sErroresProcedencia <> "" Or sErroresDestinos <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If



            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function


        Public Shared Function Sincronismo_GrimaldiGrassi(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String



            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroGrimaldi " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            'Dim a = pDataTable(1)




            'creo q el formato es como el de granos del litoral

            '            Cambios a realizar (Comenta Daniel Gomez de Grimaldi Grassi):

            '* Fecha de Descarga: el año debería ser de 4 digitos
            '* El numero de recibo de 10 que no viene informado(si no tienen el dato, deajlo en blanco)
            '* El numero de contrato corredor que nosotros los tenemos de 7 y ustedes lo informan de 15 digitos.






            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0






                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular
                    'Corredor Endozo		    ?
                    'Comprador Endozo		    ?
                    'Corredor Vendedor		    ?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""












                    '///////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 11).PadRight(11) '        CUIT entregador	11	N	
                    sb &= Left(wily.ToString, 25).PadRight(25) 'Nombre entregador	25	A	

                    'Fecha descarga	8	N	formato ddmmaaaa

                    If .IsFechaDescargaNull() Then
                        sb &= "        "
                    Else
                        sb &= .FechaDescarga.ToString("ddMMyyyy") 'Emi	STRING(8)	Fecha de Emisión de Carta de Porte)    1100)    1107
                    End If






                    'CUIT puerto	11	N	
                    'Nombre puerto	20	A	
                    'codpostalLocalidad puerto	20	A	Cgo.postal alineado por izquierda
                    sb &= Left(cadenavacia.ToString, 11).PadRight(11) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
                    sb &= Left(.DestinoDesc.ToString, 20).PadRight(20) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
                    sb &= Left(.DestinoCodigoPostal.ToString, 20).PadRight(20) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534


                    'Nombre producto	20	A	
                    sb &= Left(.Producto.ToString, 20).PadRight(20) 'Nombre entregador	25	A	


                    sb &= Left(.TitularCUIT.ToString.Replace("-", ""), 11).PadRight(11) '        CUIT entregador	11	N	
                    sb &= Left(.TitularDesc.ToString, 30).PadRight(30) 'Nombre entregador	25	A	


                    'CUIT remitente	11	N	
                    'Nombre remitente	30	A	
                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 11).PadRight(11) '        CUIT entregador	11	N	
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'Nombre entregador	25	A	


                    'CUIT comprador	11	N	
                    'Nombre comprador	30	A	


                    'Cod.postal procedencia	8	A	Cgo.postal alineado por izquierda
                    'Nombre procedencia	30	A	
                    sb &= Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8)
                    sb &= Left(.ProcedenciaDesc.ToString, 30).PadRight(30)



                    'Patente	8	A	Alineado por izquierda
                    sb &= Left(.Patente.ToString, 8).PadRight(8) 'PatCha	STRING(6)	Patente chasis)    604)    609


                    'CUIT dueño C.Porte	11	N	
                    'Nombre dueño C.Porte	30	A	
                    sb &= Left(.TitularCUIT.ToString.Replace("-", ""), 11).PadRight(11) '        CUIT entregador	11	N	
                    sb &= Left(.TitularDesc.ToString, 30).PadRight(30) 'Nombre entregador	25	A	



                    'Nro.C.Porte	12	N	
                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= Left(.NumeroCartaDePorte.ToString, 12).PadLeft(12) 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840



                    sb &= .NRecibo.ToString.PadLeft(10)


                    'Kgs.procedencia	8	N	
                    'kgs.brutos	8	N	
                    'Kgs.tara	8	N	
                    'Kgs.netos	8	N	
                    'kgs.merma	8	N	
                    'Kgs.neto final	8	N	
                    sb &= Int(.NetoPto).ToString.PadLeft(8)
                    sb &= Int(.BrutoFinal).ToString.PadLeft(8)
                    sb &= Int(.TaraFinal).ToString.PadLeft(8)
                    sb &= Int(.NetoFinal).ToString.PadLeft(8)
                    sb &= Int(.Merma).ToString.PadLeft(8, "0")
                    sb &= Int(.NetoFinal).ToString.PadLeft(8)



                    'Grado	3	A	Ej. CF  G1  FB
                    Dim sCalidad As String
                    If InStr(.Calidad.ToString.ToLower, "grado 1") > 0 Then
                        sCalidad = "G1"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 2") > 0 Then
                        sCalidad = "G2"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 3") > 0 Then
                        sCalidad = "G3"
                    ElseIf InStr(.Calidad.ToString.ToLower, "camara") > 0 Then
                        sCalidad = "CC"
                    Else
                        sCalidad = "FE"
                    End If
                    sb &= sCalidad.PadRight(3) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)

                    'Observ.calidad	100	A	
                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'Observac	STRING(100)	Observaciones)    862)    961


                    'CUIT cta y ord.1	11	N	
                    'Nombre cta y ord.1	30	A	
                    'CUIT cta y ord.2	11	N	
                    'Nombre cta y ord.2	30	A	
                    'CUIT cta y ord.3	11	N	
                    'Nombre cta y ord.3	30	A	
                    sb &= Left(.RComercialCUIT.ToString.Replace("-", ""), 11).PadRight(11)
                    sb &= Left(.RComercialDesc.ToString, 30).PadRight(30)
                    sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 11).PadRight(11)
                    sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30)
                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 11).PadRight(11)
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30)




                    'Contrato corredor	15	A	
                    sb &= Right(.Contrato.ToString, 7).PadRight(7)
                    'Cosecha	4	N	
                    sb &= Right(.Cosecha, 5).Replace("/", "").PadLeft(4)

                    'CUIT transporte	11	N	
                    'Nombre transporte	30	A	


                    If .IsTransportistaCUITNull Then .TransportistaCUIT = ""
                    sb &= Left(.TransportistaCUIT.ToString, 11).PadRight(11, "0")
                    sb &= Left(.TransportistaDesc.ToString, 30).PadRight(30)



                    '///////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////















                    PrintLine(nF, sb)
                End With
            Next


            FileClose(nF)


            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function

        Public Shared Function Sincronismo_FYO(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String





            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroFYO " & Now.ToString("ddMMMyyyy_HHmmss") & ".csv" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            '            Dim a = pDataTable(1)






            '.CSV
            '"0","519276582",23/08/2011,19,,"CF",7114,30589747409,"EL CALLEJON S.A."          ,0,0,30450,"FUTUROS Y OPCIONES .COM",8,"",44960,14200,30760,23/08/2011,30522881089,"RASIC HNOS S.A.",00000000000,"",00000000000,"",00000000000,"",           0.00, 0.00,"N",0,0,0,0,"c",30760,8, 0:00,"Williams Entregas S.A.",
            '0,"518968687   ",07302011 ,  ,,"FE",    ,"20176863332","CINOLLO VENENGO C.MARIA",0,0  ,0   ,"GRANOS DEL PARANA S.A.",  ,"",42200,12740,29460,30/07/2011,"30700869918","BUNGE ARGENTINA S.A.","           ","","           ","",00000000000,"",0.00,0.00,"N",0,0,0,0  c,     29460,,0:00,"Williams Entregas S.A.",""





            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp
                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular
                    'Corredor Endozo		    ?
                    'Comprador Endozo		    ?
                    'Corredor Vendedor		    ?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""

                    i = 0 : sb = ""

                    Dim cero = 0



                    '<LongNumeroCartaPorte>-1</LongNumeroCartaPorte>
                    '<NombreDescargador>Williams</NombreDescargador>
                    '<CantidadCampos>40</CantidadCampos>



                    '0   0,
                    '1    "519538491",
                    '2    23/08/2011,
                    '3    15,
                    '<PosicionPrimerCampoNumerico>0</PosicionPrimerCampoNumerico>
                    sb &= _cc("0")

                    '<PosicionCartaPorte>1</PosicionCartaPorte>
                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= "," & _cc(.NumeroCartaDePorte.ToString) 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840

                    '<PosicionFechaEntrega>2</PosicionFechaEntrega>
                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= "," & FechaChica(.FechaDescarga)

                    '<PosicionIdProducto>3</PosicionIdProducto>
                    sb &= "," & .CodigoSAJPYA.PadLeft(3)





                    sb &= ","   '4    ,



                    '5    "CC",
                    Dim sCalidad As String
                    If InStr(.Calidad.ToString.ToLower, "grado 1") > 0 Then
                        sCalidad = "G1"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 2") > 0 Then
                        sCalidad = "G2"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 3") > 0 Then
                        sCalidad = "G3"
                    ElseIf InStr(.Calidad.ToString.ToLower, "camara") > 0 Then
                        sCalidad = "CC"
                    Else
                        sCalidad = "FE"
                    End If
                    sb &= "," & _cc(sCalidad)


                    sb &= "," '6    7200, ?? cp puerto?


                    '7    30528749166,
                    '8    "SOCIEDAD ANONIMA SACFIL",
                    '<PosicionCUITVendedor>7</PosicionCUITVendedor>
                    sb &= "," & Left(.TitularCUIT.ToString.Replace("-", ""), 11).PadRight(11)
                    sb &= "," & _cc(.TitularDesc)




                    sb &= ",0" '9    0,
                    sb &= ",0" '10    0,
                    sb &= ",0" '11   30600, 

                    sb &= "," & _cc(.CorredorDesc) '12      "FUTUROS Y OPCIONES .COM",


                    sb &= ","       '13       6605,
                    sb &= ","""""   '14       "",

                    sb &= "," & Int(.BrutoFinal).ToString               '15       45000, bruto
                    sb &= "," & Int(.TaraFinal).ToString '16       14340,  tara
                    sb &= "," & Int(.NetoFinal).ToString '17       30660, neto

                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= "," & FechaChica(iisNull(.FechaArribo, "")) '18       23/08/2011,


                    '19       30541716331,
                    '20       "MOLINO ANDRES LAGOMARSINO E HIJOS ICSA.",
                    '<PosicionCUITComprador>19</PosicionCUITComprador>
                    sb &= "," & Left(.DestinatarioCUIT.ToString.Replace("-", ""), 11).PadRight(11)
                    sb &= "," & _cc(.DestinatarioDesc)


                    '21       00000000000,
                    '22       "",
                    '<PosicionCUITVendedorCyO1>21</PosicionCUITVendedorCyO1>
                    sb &= "," & Left(.IntermediarioCUIT.ToString.Replace("-", ""), 11).PadRight(11)
                    sb &= "," & _cc(.IntermediarioDesc)


                    '23       00000000000,
                    '24       "",
                    '<PosicionCUITVendedorCyO2>23</PosicionCUITVendedorCyO2>
                    sb &= "," & Left(.RComercialCUIT.ToString.Replace("-", ""), 11).PadRight(11)
                    sb &= "," & _cc(.RComercialDesc)


                    sb &= ",00000000000" '25       00000000000,
                    sb &= ","""""       '26       "", 




                    sb &= ",0.00" '27       0.00, 
                    sb &= ",0.00" '28       0.00,
                    sb &= ",""N""" '29       "N",
                    sb &= ",0" '30       0,
                    sb &= ",0" '31       0,
                    sb &= ",0" '32       0,
                    sb &= ",0" '33       0,
                    sb &= "," & _cc(IIf(True, "c", "v").ToString.PadRight(1))  '34           "c",







                    '<PosicionKgsNetoDescargados>35</PosicionKgsNetoDescargados>
                    sb &= "," & Int(.NetoFinal).ToString.PadLeft(10)

                    sb &= "," '36           6605,????
                    sb &= ",0:00" '37           0:00, hora?
                    sb &= "," & _cc(wily) '38 Williams Entregas



                    '<PosicionObservaciones>39</PosicionObservaciones>
                    sb &= "," & _cc(Left(.Observaciones.ToString, 100))






                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    'agregados para info de posicion
                    sb &= "," & _cc(.Producto)
                    sb &= "," & _cc(.ProcedenciaDesc)
                    sb &= "," & _cc(.DestinoDesc)
                    sb &= "," & FechaChica(.FechaArribo)

                    sb &= "," & Int(.BrutoPto).ToString 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= "," & Int(.TaraPto).ToString 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= "," & Int(.NetoPto).ToString 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645






                    PrintLine(nF, sb)
                End With
            Next


            FileClose(nF)


            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function

        Public Shared Function Sincronismo_FYO_Posicion(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String





            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroFYOposicion " & Now.ToString("ddMMMyyyy_HHmmss") & ".csv" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            '            Dim a = pDataTable(1)






            '.CSV
            '"0","519276582",23/08/2011,19,,"CF",7114,30589747409,"EL CALLEJON S.A."          ,0,0,30450,"FUTUROS Y OPCIONES .COM",8,"",44960,14200,30760,23/08/2011,30522881089,"RASIC HNOS S.A.",00000000000,"",00000000000,"",00000000000,"",           0.00, 0.00,"N",0,0,0,0,"c",30760,8, 0:00,"Williams Entregas S.A.",
            '0,"518968687   ",07302011 ,  ,,"FE",    ,"20176863332","CINOLLO VENENGO C.MARIA",0,0  ,0   ,"GRANOS DEL PARANA S.A.",  ,"",42200,12740,29460,30/07/2011,"30700869918","BUNGE ARGENTINA S.A.","           ","","           ","",00000000000,"",0.00,0.00,"N",0,0,0,0  c,     29460,,0:00,"Williams Entregas S.A.",""






            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp
                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular
                    'Corredor Endozo		    ?
                    'Comprador Endozo		    ?
                    'Corredor Vendedor		    ?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""

                    i = 0 : sb = ""

                    Dim cero = 0



                    '<LongNumeroCartaPorte>-1</LongNumeroCartaPorte>
                    '<NombreDescargador>Williams</NombreDescargador>
                    '<CantidadCampos>40</CantidadCampos>



                    '0   0,
                    '1    "519538491",
                    '2    23/08/2011,
                    '3    15,
                    '<PosicionPrimerCampoNumerico>0</PosicionPrimerCampoNumerico>
                    sb &= _cc("0")

                    '<PosicionCartaPorte>1</PosicionCartaPorte>
                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= "," & _cc(.NumeroCartaDePorte.ToString) 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840

                    '<PosicionFechaEntrega>2</PosicionFechaEntrega>
                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= "," & FechaChica(.FechaDescarga)

                    '<PosicionIdProducto>3</PosicionIdProducto>
                    sb &= "," & .CodigoSAJPYA.PadLeft(3)





                    sb &= ","   '4    ,



                    '5    "CC",
                    Dim sCalidad As String
                    If InStr(.Calidad.ToString.ToLower, "grado 1") > 0 Then
                        sCalidad = "G1"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 2") > 0 Then
                        sCalidad = "G2"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 3") > 0 Then
                        sCalidad = "G3"
                    ElseIf InStr(.Calidad.ToString.ToLower, "camara") > 0 Then
                        sCalidad = "CC"
                    Else
                        sCalidad = "FE"
                    End If
                    sb &= "," & _cc(sCalidad)


                    sb &= "," '6    7200, ?? cp puerto?


                    '7    30528749166,
                    '8    "SOCIEDAD ANONIMA SACFIL",
                    '<PosicionCUITVendedor>7</PosicionCUITVendedor>
                    sb &= "," & Left(.TitularCUIT.ToString.Replace("-", ""), 11).PadRight(11)
                    sb &= "," & _cc(.TitularDesc)




                    sb &= ",0" '9    0,
                    sb &= ",0" '10    0,
                    sb &= ",0" '11   30600, 

                    sb &= "," & _cc(.CorredorDesc) '12      "FUTUROS Y OPCIONES .COM",


                    sb &= ","       '13       6605,
                    sb &= ","""""   '14       "",

                    sb &= "," & Int(.BrutoFinal).ToString               '15       45000, bruto
                    sb &= "," & Int(.TaraFinal).ToString '16       14340,  tara
                    sb &= "," & Int(.NetoFinal).ToString '17       30660, neto

                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= "," & FechaChica(iisNull(.FechaArribo, "")) '18       23/08/2011,


                    '19       30541716331,
                    '20       "MOLINO ANDRES LAGOMARSINO E HIJOS ICSA.",
                    '<PosicionCUITComprador>19</PosicionCUITComprador>
                    sb &= "," & Left(.DestinatarioCUIT.ToString.Replace("-", ""), 11).PadRight(11)
                    sb &= "," & _cc(.DestinatarioDesc)


                    '21       00000000000,
                    '22       "",
                    '<PosicionCUITVendedorCyO1>21</PosicionCUITVendedorCyO1>
                    sb &= "," & Left(.IntermediarioCUIT.ToString.Replace("-", ""), 11).PadRight(11)
                    sb &= "," & _cc(.IntermediarioDesc)


                    '23       00000000000,
                    '24       "",
                    '<PosicionCUITVendedorCyO2>23</PosicionCUITVendedorCyO2>
                    sb &= "," & Left(.RComercialCUIT.ToString.Replace("-", ""), 11).PadRight(11)
                    sb &= "," & _cc(.RComercialDesc)


                    sb &= ",00000000000" '25       00000000000,
                    sb &= ","""""       '26       "", 




                    sb &= ",0.00" '27       0.00, 
                    sb &= ",0.00" '28       0.00,
                    sb &= ",""N""" '29       "N",
                    sb &= ",0" '30       0,
                    sb &= ",0" '31       0,
                    sb &= ",0" '32       0,
                    sb &= ",0" '33       0,
                    sb &= "," & _cc(IIf(True, "c", "v").ToString.PadRight(1))  '34           "c",







                    '<PosicionKgsNetoDescargados>35</PosicionKgsNetoDescargados>
                    sb &= "," & Int(.NetoFinal).ToString.PadLeft(10)

                    sb &= "," '36           6605,????
                    sb &= ",0:00" '37           0:00, hora?
                    sb &= "," & _cc(wily) '38 Williams Entregas



                    '<PosicionObservaciones>39</PosicionObservaciones>
                    sb &= "," & _cc(Left(.Observaciones.ToString, 100))



                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////
                    'agregados para info de posicion
                    sb &= "," & _cc(.Producto)
                    sb &= "," & _cc(.ProcedenciaDesc)
                    sb &= "," & _cc(.DestinoDesc)
                    sb &= "," & FechaChica(.FechaArribo)

                    sb &= "," & Int(.BrutoPto).ToString 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= "," & Int(.TaraPto).ToString 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= "," & Int(.NetoPto).ToString 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645



                    '-Entregador()
                    '- Titular -ya estaba
                    '- Corredor -ya estaba
                    '- Producto -estaba el codigo, agregué la desc
                    '- Exportador -el destinatario no?
                    '- Carta de Porte  -ya estaba
                    '- Remitente Comercial -ya estaba
                    '- Intermediario  -ya estaba
                    '- Observaciones  -ya estaba

                    '- Puerto(Descarga) (destino)
                    '- Procedencia
                    '- Kg Procedencia
                    '- Kg Netos
                    '- Posición del día(fecha)



                    PrintLine(nF, sb)
                End With
            Next


            FileClose(nF)


            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function

        Public Shared Function Sincronismo_Lartirigoyen(ByVal pDataTable As DataTable, ByRef sErrores As String, ByVal titulo As String) As String


            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?

            Dim sErroresProcedencia, sErroresDestinos, sErroresCartas As String

            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroLartirigoyen " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataTable.Rows
                i = 0 : sb = ""

                '                                                           Descripción	Tipo de Dato	Longitud        Observaciones()










                Dim cero = 0
                sb &= "30707386076"                                           '1 - CUIT Williams (Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                sb &= "&" & dr("TitularCUIT").ToString.Replace("-", "").PadLeft(11)                        '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.

                ForzarPrefijo5(dr("C.Porte"))
                sb &= "&" & Left(dr("C.Porte").ToString, IIf(Len(dr("C.Porte").ToString) > 8, Len(dr("C.Porte").ToString) - 8, 0)).PadLeft(4, "0")

                sb &= "&" & Right(dr("C.Porte").ToString, 8).PadLeft(8, "0")                      '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                sb &= "&" & cero.ToString.PadLeft(10)                         '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.)
                sb &= "&" & cero.ToString.PadLeft(10)                         '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & dr("R. ComercialCUIT").ToString.Replace("-", "").PadLeft(11)                          '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.
                sb &= "&" & Left(dr("CEE").ToString, 14).PadLeft(14)                         '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1) Código de Autorización de Uso (C.A.U.) 


                Dim stringFechaVencimiento As String
                'If iisValidSqlDate(dr("Vencim.CP")) Then
                stringFechaVencimiento = FechaANSI(iisValidSqlDate(dr("Vencim.CP"))) '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)
                'Else
                'stringFechaVencimiento = Space(8)
                'End If
                sb &= "&" & IIf(stringFechaVencimiento = "00010101", Space(8), stringFechaVencimiento)


                'Columna 14 campo cuit del chofer es obligatorio, cuando no tienen el dato poner 30-00000000-7
                'Columna 12 el campo cuit empresa de transporte es obligatorio, cuando no tienen el dato poner 30-00000000-7

                Dim cuittrans = dr("CUIT Transp.").ToString.Replace("-", "").PadLeft(11)
                sb &= "&" & IIf(cuittrans = "", "30000000007", cuittrans)           '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)


                sb &= "&" & Left(dr("Trasportista").ToString, 30).PadLeft(30).Replace("&", " ")                          '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.

                Dim cuitchofer = dr("CUIT chofer").ToString.Replace("-", "").PadLeft(11)
                sb &= "&" & IIf(cuitchofer = "", "30000000007", cuitchofer)                      '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista



                'Columna 15 liquida viaje poner siempre Sí
                'Columna 16 cobra acarreo poner siempre Sí

                sb &= "&" & IIf(dr("LiquidaViaje").ToString = "SI", "Si", "Si")                         '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                sb &= "&" & IIf(dr("CobraAcarreo").ToString = "SI", "Si", "Si")                        '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No


                'Columna 17 tarifa de flete es obligatorio, cuando no tienen el dato poner 1
                Dim tarif As Double = IIf(iisNull(dr("Tarifa"), 0) = 0, 0, iisNull(dr("Tarifa"), 0))
                sb &= "&" & tarif.ToString.PadLeft(10)                 '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.


                'Columna 19 la tara no puede venir en blanco tanto para camiones o vagones
                'Columna 18 el bruto no puede venir en blanco tanto para camiones o vagones
                If Int(dr("Kg.Bruto Desc.")) = 0 Then
                    dr("Kg.Bruto Desc.") = 0
                    'sErroresCartas &= "<a href=""CartaDePorte.aspx?Id=" & dr("IdCartaDePorte") & """ target=""_blank"">Falta bruto. " & dr("C.Porte") & "</a>; " & "<br/>"
                End If

                If Int(dr("Kg.Tara Desc.")) = 0 Then
                    dr("Kg.Tara Desc.") = 0
                    'sErroresCartas &= "<a href=""CartaDePorte.aspx?Id=" & dr("IdCartaDePorte") & """ target=""_blank"">Falta tara. " & dr("C.Porte") & "</a>; " & "<br/>"
                End If


                sb &= "&" & Int(dr("Kg.Bruto Desc.")).ToString.PadLeft(10)                         '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Tara Desc.")).ToString.PadLeft(10)                         '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.

                sb &= "&" & Int(dr("Kg.Neto Desc.")).ToString.PadLeft(10)                         '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                sb &= "&" & FechaANSI(iisValidSqlDate(dr("Desc.")))     '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD


                sb &= "&" & DecimalToString(dr("H.%")).PadLeft(5)                         '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & Int(iisNull(dr("Mer.Kg."), 0)).ToString.PadLeft(10)                         '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.

                sb &= "&" & Int(iisNull(dr("Otras"), 0)).ToString.PadLeft(10)            '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                        '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                         '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & Int(dr("Kg.Netos")).ToString.PadLeft(10)                      '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.

                sb &= "&" & Left(dr("Contrato"), 14).ToString.PadLeft(14)                           '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.

                sb &= "&" & cero.ToString.PadLeft(14)                          '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.


                'sb &= "& " & Left(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5).PadLeft(5)                         '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.





                '                32-Código Localidad ONCCA / Código de Campo Interno del Sistema:
                'Estamos enviando \"SIN ES\", acá debería ir el código ONCCA o en todo caso no salir el sincro


                'Columna 32 la localidad ONCCA tiene que venir la procedencia de la mercadería, no puede estar en blanco
                If False Then

                    If iisNull(dr("CodigoEstablecimientoProcedencia"), "") = "" Then
                        sErroresCartas &= "<a href=""CartaDePorte.aspx?Id=" & dr("IdCartaDePorte") & """ target=""_blank"">Falta código del establecimiento de procedencia. " & dr("C.Porte") & "</a>; " & "<br/>"
                    End If

                    sb &= "&" & Left(iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString, 6).PadLeft(6)
                Else
                    If iisNull(dr("LocalidadProcedenciaCodigoONCAA"), "") = "" Then
                        sErroresCartas &= "<a href=""CartaDePorte.aspx?Id=" & dr("IdCartaDePorte") & """ target=""_blank"">Falta código ONCCA de Localidad. " & dr("Procedcia.") & "</a>; " & "<br/>"
                    End If

                    sb &= "&" & JustificadoDerecha(iisNull(dr("LocalidadProcedenciaCodigoONCAA"), "").ToString, 6)

                End If



                'Columna 33 los kilómetros es obligatorio, cuando no lo tienen el dato poner 1
                Dim kilometros As Integer = Int(dr("Km"))
                If kilometros <= 0 Then kilometros = 1
                sb &= "&" & kilometros.ToString.PadLeft(10)                        '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.


                '34- Especie está yendo un numero y corresponde una letra ejemplo soja es soja y no 0
                sb &= "&" & CodigoAleaAibal(dr("Producto").ToString).PadLeft(4, " ")             '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)




                sb &= "&" & Right(dr("Cosecha"), 5).Replace("/", "").PadLeft(4)                         '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)


                sb &= "&" & IIf(dr("CorredorCUIT").ToString.Replace("-", "") = "88000000122", "0", dr("CorredorCUIT")).ToString.Replace("-", "").PadLeft(11)                        '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.


                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                        '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)



                sb &= "&" & LeftMasPadLeft(dr("LocalidadDestinoCodigoLosGrobo").ToString, 5)                         '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                sb &= "&" & LeftMasPadLeft(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5)                       '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)



                'If dr("LocalidadProcedenciaCodigoONCAA").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                If dr("LocalidadProcedenciaCodigoLosGrobo").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("Procedcia.").ToString & " es usada en el sincro de LosGrobo y no tiene codigo LosGrobo")

                    sErroresProcedencia &= "<a href=""Localidades.aspx?Id=" & dr("IdLocalidad") & """ target=""_blank"">" & dr("Procedcia.") & "</a>; "
                End If

                'If dr("LocalidadDestinoCodigoONCAA").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                If dr("LocalidadDestinoCodigoLosGrobo").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("DestinoDesc").ToString & " es usada en el sincro de LosGrobo y no tiene codigo LosGrobo")

                    sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & dr("IdWilliamsDestino") & """ target=""_blank"">" & dr("DestinoDesc") & "</a>; "
                End If



                sb &= "&" & dr("SufijoCartaDePorte").ToString.PadLeft(4)                         '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                          '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.


                'Columna 42 el Nº de CTG no puede venir en blanco, si no lo tiene el numero poner 9999999
                sb &= "&" & iisNull(dr("CTG"), "9999999").ToString.PadLeft(8)                         '42 – Numero de CTG	Numérico	8	Número de CTG presente en la CP.

                sb &= "&" & Left(dr("Cal.-Observaciones").ToString.Replace(vbCrLf, "").Replace(vbLf, "").Replace(vbCr, "").Replace("&", " "), 125).PadRight(125)                      '43 – Comentario	Alfa	125	Campo que permita indicar algún mensaje de datos faltantes.

                sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino

                '45 – Código de Establecimiento Procedencia:
                'Estamos enviando \"SIN ESTABLEC, EN CP\", enviar el codigo de Establecimiento o en su defecto vacío
                sb &= "&" & JustificadoDerecha(iisNull(dr("CodigoEstablecimientoProcedencia"), ""), 6)  '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia



                sb &= "&" & iisNull(dr("IdTipoMovimiento"), "").ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                '                                                       1.	Egresos contratos de Venta
                '                                                       2.	Egreso Directo a Destino Productor
                '                                                       3.	Directo Destino contrato de Compra
                '                                                       4.	Ingreso Entregado Productor
                '                                                       5.	Ingreso Contrato de Compra
                '                                                       6.	Reingreso de Mercadería
                '                                                       7.	Transferencia desde otra Planta


                sb &= "&" & JustificadoDerecha(iisNull(dr("Chofer"), "").ToString, 20) '47 – Código de Chofer en Softcereal	Alfa	20 	Código del chofer en el sistema Softcereal
                sb &= "&" & JustificadoDerecha(iisNull(dr("Pat. Chasis"), "").ToString, 10) '48 – Patente del Camión	Alfa	10 	Matrícula del camión
                sb &= "&" & JustificadoDerecha(iisNull(dr("Pat. Acoplado"), "").ToString, 10) '49 – Patente del Acoplado	Alfa	10 	Matrícula del acoplado
                sb &= "&" & JustificadoDerecha(iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString, 5) '50 – Código de planta	Numérico	5 	Código de la planta. 




                '51 – Calidad Conforme	Alfa	2	Acepta los valores Sí/No
                '52-Vagon	Alfa	30	Campo a utilizar para informar el número de vagón en caso de cartas de porte ferroviarias. se debe informar un renglón del txt por cada vagón.
                '53 – Entidad destino	Numérico	11	Código de SoftCereal o CUIT del Productor.
                '54- Guía Propia	Alfa	2	Acepta valores Sí / No. Indicar Sí, si la guía es del Acopio (Lartirigoyen) Indicar No, si la guía corresponde a otra entidad.
                '55 – Localidad ONCCA Municipio Guía	Numérico	5	Código ONCCA del municipio de la guía. 0 si no existe el datoO 9999 si no se pudo determinar el municipio
                '56 – Prefijo Guía	Numérico	4	Prefijo Guía cerealera, 0 si no existe el dato
                '57 – Numero Guia	Numérico	8	Numero Guía Cerealera, 0 si no existe el dato 
                '58 – Oblea Propia	Alfa	2	Acepta valores Sí / No. Indicar Sí, si la Oblea es del Acopio (Lartirigoyen) Indicar No, si la Oblea corresponde a otra entidad.
                '59 – Tipo de Oblea	Alfa	1	Tipo de oblea  acepta los valores A, B, C, D, X o ZO Blanco si no se tiene el dato
                '60 – Número de Oblea	Numérico	8	Numero Guía Cerealera, 0 si no existe el dato o 9999999 si no se tiene el numero

                sb &= "&" & JustificadoDerecha(iisNull(dr("Calidad") = "CO", "Si").ToString, 2)

                Dim subvagon = iisNull(dr("SubNumeroVagon"), "0")
                If subvagon = "0" Then subvagon = ""
                sb &= "&" & JustificadoDerecha(subvagon.ToString, 30)


                sb &= "&" & dr("DestinoCUIT").ToString.Replace("-", "").PadLeft(11)
                sb &= "&" & JustificadoDerecha("Si", 2)

                sb &= "&" & JustificadoDerecha("0", 5)
                sb &= "&" & JustificadoDerecha("0", 4)
                sb &= "&" & JustificadoDerecha("0", 8)
                sb &= "&" & JustificadoDerecha("Si", 2)
                sb &= "&" & JustificadoDerecha("A", 1)
                sb &= "&" & JustificadoDerecha("99999999", 8)




                sb = sb.Replace(".", ",") 'solucion cabeza por los decimales



                'For Each dc In pDataTable.Columns
                '    If Not IsDBNull(dr(i)) Then
                '        Try
                '            If IsNumeric(dr(i)) Then
                '                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            Else
                '                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            End If
                '        Catch x As Exception
                '            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                '        End Try
                '    Else
                '        sb &= Microsoft.VisualBasic.ControlChars.Tab
                '    End If
                '    i += 1
                'Next






                PrintLine(nF, sb)
            Next



            FileClose(nF)


            sErrores = sErroresCartas & "Procedencias sin código:<br/> " & sErroresProcedencia & "<br/>Destinos sin código: <br/>" & sErroresDestinos

            If True Then
                If sErroresProcedencia <> "" Or sErroresDestinos <> "" Or sErroresCartas <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If

            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function

        Public Shared Function Sincronismo_Agrosur(ByVal pDataTable As DataTable, ByRef sErrores As String, ByVal titulo As String, SC As String) As String


            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?

            Dim codigoBahiaBlanca As String
            Using db As New LinqCartasPorteDataContext(Encriptar(SC))
                codigoBahiaBlanca = (From x In db.WilliamsDestinos Where x.Descripcion = "Bahia Blanca" Select x.CodigoLosGrobo).FirstOrDefault
                If codigoBahiaBlanca = "" Then Throw New Exception("Falta asignar código al destino 'Bahia Blanca'")
            End Using
            Dim l As String = iisNull(ParametroManager.TraerValorParametro2(SC, "Williams_SincroGrobo_BahiaBlancaGrupo"), "")
            'la dichosa tabla Parametros no tiene los campos de valor muy largos
            If l = "" Or True Then
                l = "CANGREJALES;LDC - PUERTO GALVAN;CARGILL BAHIA BLANCA;TERMINAL BAHIA BLANCA SA;ACTIAR SRL;PUERTO GALVAN. O.M.H.S.A"  '"LDC - PUERTO GALVAN"
                ParametroManager.GuardarValorParametro2(SC, "Williams_SincroGrobo_BahiaBlancaGrupo", l)
            End If
            Dim bahiablanca = Split(l, ";").ToList





            Dim sErroresProcedencia, sErroresDestinos As String

            Dim sErroresOtros As String

            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroAgrosur " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataTable.Rows
                i = 0 : sb = ""

                '                                                           Descripción	Tipo de Dato	Longitud        Observaciones()

                'Agregar un control para que no salgan cartas de porte con titulares y destinatarios sin cuit
                If dr("TitularCUIT").ToString = "" Then
                    sErroresOtros &= "<br/> Cliente " & dr("Titular").ToString & " sin CUIT. Carta " & dr("C.Porte").ToString
                End If

                If dr("DestinatarioCUIT").ToString = "" Then
                    sErroresOtros &= "<br/> Cliente " & dr("Destinatario").ToString & " sin CUIT. Carta " & dr("C.Porte").ToString
                End If


                Dim cero = 0
                sb &= "30707386076"                                           '1 - CUIT Williams (Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                sb &= "&" & dr("TitularCUIT").ToString.Replace("-", "").PadLeft(11)                        '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.

                ForzarPrefijo5(dr("C.Porte"))
                sb &= "&" & Left(dr("C.Porte").ToString, IIf(Len(dr("C.Porte").ToString) > 8, Len(dr("C.Porte").ToString) - 8, 0)).PadLeft(4, "0")

                sb &= "&" & Right(dr("C.Porte").ToString, 8).PadLeft(8, "0")                      '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                sb &= "&" & cero.ToString.PadLeft(10)                         '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.)
                sb &= "&" & cero.ToString.PadLeft(10)                         '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & dr("R. ComercialCUIT").ToString.Replace("-", "").PadLeft(11)                          '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.
                sb &= "&" & Left(dr("CEE").ToString, 14).PadLeft(14)                         '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1) Código de Autorización de Uso (C.A.U.) 


                Dim stringFechaVencimiento As String
                'If iisValidSqlDate(dr("Vencim.CP")) Then
                stringFechaVencimiento = FechaANSI(iisValidSqlDate(dr("Vencim.CP"))) '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)
                'Else
                'stringFechaVencimiento = Space(8)
                'End If
                sb &= "&" & IIf(stringFechaVencimiento = "00010101", Space(8), stringFechaVencimiento)


                sb &= "&" & dr("CUIT Transp.").ToString.Replace("-", "").PadLeft(11)           '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)
                sb &= "&" & Left(dr("Trasportista").ToString, 30).PadLeft(30).Replace("&", " ")                          '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.
                sb &= "&" & dr("CUIT chofer").ToString.Replace("-", "").PadLeft(11)                         '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista


                sb &= "&" & IIf(dr("LiquidaViaje").ToString = "SI", "Si", "No")                         '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                sb &= "&" & IIf(dr("CobraAcarreo").ToString = "SI", "Si", "No")                        '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No


                sb &= "&" & IIf(iisNull(dr("Tarifa"), 0) = 0, 0, iisNull(dr("Tarifa"), 0)).ToString.PadLeft(10)                         '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.
                sb &= "&" & Int(dr("Kg.Bruto Desc.")).ToString.PadLeft(10)                         '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Tara Desc.")).ToString.PadLeft(10)                         '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Neto Desc.")).ToString.PadLeft(10)                         '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                sb &= "&" & FechaANSI(iisValidSqlDate(dr("Desc.")))     '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD


                sb &= "&" & DecimalToString(dr("H.%")).PadLeft(5)                         '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & Int(iisNull(dr("Mer.Kg."), 0)).ToString.PadLeft(10)                         '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.

                sb &= "&" & cero.ToString.PadLeft(10)            '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                        '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                sb &= "&" & Int(iisNull(dr("Otras"), 0)).ToString.PadLeft(10)                         '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & Int(dr("Kg.Netos")).ToString.PadLeft(10)                      '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.

                sb &= "&" & Left(dr("Contrato"), 14).ToString.PadLeft(14)                           '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.

                sb &= "&" & cero.ToString.PadLeft(14)                          '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.


                'sb &= "& " & Left(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5).PadLeft(5)                         '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.
                sb &= "&" & Left(iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString, 6).PadLeft(6)


                sb &= "&" & Int(dr("Km")).ToString.PadLeft(10)                        '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & dr("EspecieONCAA").ToString.PadLeft(4, " ")                         '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)
                sb &= "&" & Right(dr("Cosecha"), 5).Replace("/", "").PadLeft(4)                         '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)


                sb &= "&" & IIf(dr("CorredorCUIT").ToString.Replace("-", "") = "88000000122", "0", dr("CorredorCUIT")).ToString.Replace("-", "").PadLeft(11)                        '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.


                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                        '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)





                'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11337

                If bahiablanca.Contains(dr("DestinoDesc").ToString.ToUpper) Then
                    dr("LocalidadDestinoCodigoLosGrobo") = codigoBahiaBlanca ' codigo "Bahia Blanca"
                End If

                sb &= "&" & LeftMasPadLeft(dr("LocalidadDestinoCodigoLosGrobo").ToString, 5)                         '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                sb &= "&" & LeftMasPadLeft(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5)                       '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)



                'If dr("LocalidadProcedenciaCodigoONCAA").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                If dr("LocalidadProcedenciaCodigoLosGrobo").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("Procedcia.").ToString & " es usada en el sincro de Agrosur y no tiene codigo Algoritmo (Grobo)")

                    sErroresProcedencia &= "<a href=""Localidades.aspx?Id=" & dr("IdLocalidad") & """ target=""_blank"">" & dr("Procedcia.") & "</a>; "
                End If

                'If dr("LocalidadDestinoCodigoONCAA").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                If dr("LocalidadDestinoCodigoLosGrobo").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("DestinoDesc").ToString & " es usada en el sincro de LosGrobo y no tiene codigo LosGrobo")

                    sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & dr("IdWilliamsDestino") & """ target=""_blank"">" & dr("DestinoDesc") & "</a>; "
                End If






                sb &= "&" & dr("SufijoCartaDePorte").ToString.PadLeft(4)                         '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                          '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.
                sb &= "&" & dr("CTG").ToString.PadLeft(8)                         '42 – Numero de CTG	Numérico	8	Número de CTG presente en la CP.
                sb &= "&" & Left(dr("Cal.-Observaciones").ToString.Replace(vbCrLf, "").Replace(vbLf, "").Replace(vbCr, "").Replace("&", " "), 125).PadRight(125)                      '43 – Comentario	Alfa	125	Campo que permita indicar algún mensaje de datos faltantes.

                sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino

                sb &= "&" & iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString.PadLeft(6)   '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia
                sb &= "&" & iisNull(dr("IdTipoMovimiento"), "").ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                '                                                       1.	Egresos contratos de Venta
                '                                                       2.	Egreso Directo a Destino Productor
                '                                                       3.	Directo Destino contrato de Compra
                '                                                       4.	Ingreso Entregado Productor
                '                                                       5.	Ingreso Contrato de Compra
                '                                                       6.	Reingreso de Mercadería
                '                                                       7.	Transferencia desde otra Planta


                sb = sb.Replace(".", ",") 'solucion cabeza por los decimales



                'For Each dc In pDataTable.Columns
                '    If Not IsDBNull(dr(i)) Then
                '        Try
                '            If IsNumeric(dr(i)) Then
                '                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            Else
                '                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            End If
                '        Catch x As Exception
                '            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                '        End Try
                '    Else
                '        sb &= Microsoft.VisualBasic.ControlChars.Tab
                '    End If
                '    i += 1
                'Next






                PrintLine(nF, sb)
            Next



            FileClose(nF)


            ' sErrores = "Procedencias sin código LosGrobo:<br/> " & sErroresProcedencia & "<br/>Destinos sin código LosGrobo: <br/>" & sErroresDestinos
            sErrores &= sErroresOtros

            If True Then
                'If sErroresProcedencia <> "" Or sErroresDestinos <> "" Or 
                If sErroresOtros <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If

            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function


        Public Shared Function Sincronismo_LosGrobo(ByVal pDataTable As DataTable, ByRef sErrores As String, ByVal titulo As String, SC As String) As String


            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?

            Dim codigoBahiaBlanca As String
            Using db As New LinqCartasPorteDataContext(Encriptar(SC))
                codigoBahiaBlanca = (From x In db.WilliamsDestinos Where x.Descripcion = "Bahia Blanca" Select x.CodigoLosGrobo).FirstOrDefault
                If codigoBahiaBlanca = "" Then Throw New Exception("Falta asignar código al destino 'Bahia Blanca'")
            End Using
            Dim l As String = iisNull(ParametroManager.TraerValorParametro2(SC, "Williams_SincroGrobo_BahiaBlancaGrupo"), "")
            'la dichosa tabla Parametros no tiene los campos de valor muy largos
            If l = "" Or True Then
                l = "CANGREJALES;LDC - PUERTO GALVAN;CARGILL BAHIA BLANCA;TERMINAL BAHIA BLANCA SA;ACTIAR SRL;PUERTO GALVAN. O.M.H.S.A"  '"LDC - PUERTO GALVAN"
                ParametroManager.GuardarValorParametro2(SC, "Williams_SincroGrobo_BahiaBlancaGrupo", l)
            End If
            Dim bahiablanca = Split(l, ";").ToList





            Dim sErroresProcedencia, sErroresDestinos As String

            Dim sErroresOtros As String

            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataTable.Rows
                i = 0 : sb = ""

                '                                                           Descripción	Tipo de Dato	Longitud        Observaciones()

                'Agregar un control para que no salgan cartas de porte con titulares y destinatarios sin cuit
                If dr("TitularCUIT").ToString = "" Then
                    sErroresOtros &= "<br/> Cliente " & dr("Titular").ToString & " sin CUIT. Carta " & dr("C.Porte").ToString
                End If

                If dr("DestinatarioCUIT").ToString = "" Then
                    sErroresOtros &= "<br/> Cliente " & dr("Destinatario").ToString & " sin CUIT. Carta " & dr("C.Porte").ToString
                End If


                Dim cero = 0
                sb &= "30707386076"                                           '1 - CUIT Williams (Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                sb &= "&" & dr("TitularCUIT").ToString.Replace("-", "").PadLeft(11)                        '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.

                ForzarPrefijo5(dr("C.Porte"))
                sb &= "&" & Left(dr("C.Porte").ToString, IIf(Len(dr("C.Porte").ToString) > 8, Len(dr("C.Porte").ToString) - 8, 0)).PadLeft(4, "0")

                sb &= "&" & Right(dr("C.Porte").ToString, 8).PadLeft(8, "0")                      '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                sb &= "&" & cero.ToString.PadLeft(10)                         '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.)
                sb &= "&" & cero.ToString.PadLeft(10)                         '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & dr("R. ComercialCUIT").ToString.Replace("-", "").PadLeft(11)                          '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.
                sb &= "&" & Left(dr("CEE").ToString, 14).PadLeft(14)                         '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1) Código de Autorización de Uso (C.A.U.) 


                Dim stringFechaVencimiento As String
                'If iisValidSqlDate(dr("Vencim.CP")) Then
                stringFechaVencimiento = FechaANSI(iisValidSqlDate(dr("Vencim.CP"))) '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)
                'Else
                'stringFechaVencimiento = Space(8)
                'End If
                sb &= "&" & IIf(stringFechaVencimiento = "00010101", Space(8), stringFechaVencimiento)


                sb &= "&" & dr("CUIT Transp.").ToString.Replace("-", "").PadLeft(11)           '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)
                sb &= "&" & Left(dr("Trasportista").ToString, 30).PadLeft(30).Replace("&", " ")                          '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.
                sb &= "&" & dr("CUIT chofer").ToString.Replace("-", "").PadLeft(11)                         '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista


                sb &= "&" & IIf(dr("LiquidaViaje").ToString = "SI", "Si", "No")                         '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                sb &= "&" & IIf(dr("CobraAcarreo").ToString = "SI", "Si", "No")                        '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No


                sb &= "&" & IIf(iisNull(dr("Tarifa"), 0) = 0, 0, iisNull(dr("Tarifa"), 0)).ToString.PadLeft(10)                         '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.
                sb &= "&" & Int(dr("Kg.Bruto Desc.")).ToString.PadLeft(10)                         '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Tara Desc.")).ToString.PadLeft(10)                         '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Neto Desc.")).ToString.PadLeft(10)                         '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                sb &= "&" & FechaANSI(iisValidSqlDate(dr("Desc.")))     '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD


                sb &= "&" & DecimalToString(dr("H.%")).PadLeft(5)                         '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & Int(iisNull(dr("Mer.Kg."), 0)).ToString.PadLeft(10)                         '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.

                sb &= "&" & cero.ToString.PadLeft(10)            '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                        '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                sb &= "&" & Int(iisNull(dr("Otras"), 0)).ToString.PadLeft(10)                         '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & Int(dr("Kg.Netos")).ToString.PadLeft(10)                      '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.

                sb &= "&" & Left(dr("Contrato"), 14).ToString.PadLeft(14)                           '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.

                sb &= "&" & cero.ToString.PadLeft(14)                          '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.


                'sb &= "& " & Left(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5).PadLeft(5)                         '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.
                sb &= "&" & Left(iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString, 6).PadLeft(6)


                sb &= "&" & Int(dr("Km")).ToString.PadLeft(10)                        '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & dr("EspecieONCAA").ToString.PadLeft(4, " ")                         '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)
                sb &= "&" & Right(dr("Cosecha"), 5).Replace("/", "").PadLeft(4)                         '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)


                sb &= "&" & IIf(dr("CorredorCUIT").ToString.Replace("-", "") = "88000000122", "0", dr("CorredorCUIT")).ToString.Replace("-", "").PadLeft(11)                        '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.


                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                        '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)





                'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11337

                If bahiablanca.Contains(dr("DestinoDesc").ToString.ToUpper) Then
                    dr("LocalidadDestinoCodigoLosGrobo") = codigoBahiaBlanca ' codigo "Bahia Blanca"
                End If

                sb &= "&" & LeftMasPadLeft(dr("LocalidadDestinoCodigoLosGrobo").ToString, 5)                         '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                sb &= "&" & LeftMasPadLeft(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5)                       '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)



                'If dr("LocalidadProcedenciaCodigoONCAA").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                If dr("LocalidadProcedenciaCodigoLosGrobo").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("Procedcia.").ToString & " es usada en el sincro de LosGrobo y no tiene codigo LosGrobo")

                    sErroresProcedencia &= "<a href=""Localidades.aspx?Id=" & dr("IdLocalidad") & """ target=""_blank"">" & dr("Procedcia.") & "</a>; "
                End If

                'If dr("LocalidadDestinoCodigoONCAA").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                If dr("LocalidadDestinoCodigoLosGrobo").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("DestinoDesc").ToString & " es usada en el sincro de LosGrobo y no tiene codigo LosGrobo")

                    sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & dr("IdWilliamsDestino") & """ target=""_blank"">" & dr("DestinoDesc") & "</a>; "
                End If






                sb &= "&" & dr("SufijoCartaDePorte").ToString.PadLeft(4)                         '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                          '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.
                sb &= "&" & dr("CTG").ToString.PadLeft(8)                         '42 – Numero de CTG	Numérico	8	Número de CTG presente en la CP.
                sb &= "&" & Left(dr("Cal.-Observaciones").ToString.Replace(vbCrLf, "").Replace(vbLf, "").Replace(vbCr, "").Replace("&", " "), 125).PadRight(125)                      '43 – Comentario	Alfa	125	Campo que permita indicar algún mensaje de datos faltantes.

                sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino

                sb &= "&" & iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString.PadLeft(6)   '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia
                sb &= "&" & iisNull(dr("IdTipoMovimiento"), "").ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                '                                                       1.	Egresos contratos de Venta
                '                                                       2.	Egreso Directo a Destino Productor
                '                                                       3.	Directo Destino contrato de Compra
                '                                                       4.	Ingreso Entregado Productor
                '                                                       5.	Ingreso Contrato de Compra
                '                                                       6.	Reingreso de Mercadería
                '                                                       7.	Transferencia desde otra Planta


                sb = sb.Replace(".", ",") 'solucion cabeza por los decimales



                'For Each dc In pDataTable.Columns
                '    If Not IsDBNull(dr(i)) Then
                '        Try
                '            If IsNumeric(dr(i)) Then
                '                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            Else
                '                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            End If
                '        Catch x As Exception
                '            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                '        End Try
                '    Else
                '        sb &= Microsoft.VisualBasic.ControlChars.Tab
                '    End If
                '    i += 1
                'Next






                PrintLine(nF, sb)
            Next



            FileClose(nF)


            ' sErrores = "Procedencias sin código LosGrobo:<br/> " & sErroresProcedencia & "<br/>Destinos sin código LosGrobo: <br/>" & sErroresDestinos
            sErrores &= sErroresOtros

            If True Then
                'If sErroresProcedencia <> "" Or sErroresDestinos <> "" Or 
                If sErroresOtros <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If

            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function

        Public Shared Function Sincronismo_YPF_ConLINQ(q As Generic.List(Of CartasConCalada), ByRef sErrores As String, ByVal titulo As String, SC As String) As String


            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?

            Dim codigoBahiaBlanca As String
            Using db As New LinqCartasPorteDataContext(Encriptar(SC))
                codigoBahiaBlanca = (From x In db.WilliamsDestinos Where x.Descripcion = "Bahia Blanca" Select x.CodigoLosGrobo).FirstOrDefault
                If codigoBahiaBlanca = "" Then Throw New Exception("Falta asignar código al destino 'Bahia Blanca'")
            End Using
            Dim l As String = iisNull(ParametroManager.TraerValorParametro2(SC, "Williams_SincroGrobo_BahiaBlancaGrupo"), "")
            'la dichosa tabla Parametros no tiene los campos de valor muy largos
            If l = "" Or True Then
                l = "CANGREJALES;LDC - PUERTO GALVAN;CARGILL BAHIA BLANCA;TERMINAL BAHIA BLANCA SA;ACTIAR SRL;PUERTO GALVAN. O.M.H.S.A"  '"LDC - PUERTO GALVAN"
                ParametroManager.GuardarValorParametro2(SC, "Williams_SincroGrobo_BahiaBlancaGrupo", l)
            End If
            Dim bahiablanca = Split(l, ";").ToList





            Dim sErroresProcedencia, sErroresDestinos As String

            Dim sErroresOtros As String

            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
 
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow

            Const cuitYPF = "30546689979"

            For Each cdp As CartasConCalada In q
                i = 0 : sb = ""




                '  Las columnas Destino (Centro),  Fecha Descarga SIEMPRE deben tener formato TEXTO. El resto de las columnas, formato GENERAL

                '·         Columna CUIT del Remitente Comercial: cuando el CUIT sea distinto a YPF, 
                'entonces este CUIT debe ser igual al CUIT informado en la columna Cuit del Proveedor (Proveedor Granos)

                '·         Columna CUIT del Intermediario: cuando el CUIT sea distinto a YPF, 
                'entonces este CUIT debe ser igual al CUIT informado en la columna Cuit del Proveedor (Proveedor Granos)

                '·         Columna CUIT del Destinatario: cuando el grano sea SOJA, siempre deberá ser el CUIT de YPF

                '·         Columnas Patente Camión, Patente Acoplado: no deben existir espacios en blanco entre las letras y números


                'el titulardesc lo uso en la columna de "cuit de proveedor", y la segunda columna es el "cuit titular
                cdp.TitularDesc = cdp.TitularCUIT
                If cdp.RComercialCUIT <> cuitYPF Then cdp.TitularDesc = cdp.RComercialCUIT
                If cdp.IntermediarioCUIT <> cuitYPF Then cdp.TitularDesc = cdp.IntermediarioCUIT
                If cdp.Producto = "SOJA" Then cdp.TitularDesc = cuitYPF



                cdp.Patente = cdp.Patente.Replace(" ", "")
                cdp.Acoplado = cdp.Acoplado.Replace(" ", "")

            Next



        End Function


        Public Shared Function Sincronismo_YPF(ByVal pDataTable As DataTable, ByRef sErrores As String, ByVal titulo As String, SC As String) As String


            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?

            Dim codigoBahiaBlanca As String
            Using db As New LinqCartasPorteDataContext(Encriptar(SC))
                codigoBahiaBlanca = (From x In db.WilliamsDestinos Where x.Descripcion = "Bahia Blanca" Select x.CodigoLosGrobo).FirstOrDefault
                If codigoBahiaBlanca = "" Then Throw New Exception("Falta asignar código al destino 'Bahia Blanca'")
            End Using
            Dim l As String = iisNull(ParametroManager.TraerValorParametro2(SC, "Williams_SincroGrobo_BahiaBlancaGrupo"), "")
            'la dichosa tabla Parametros no tiene los campos de valor muy largos
            If l = "" Or True Then
                l = "CANGREJALES;LDC - PUERTO GALVAN;CARGILL BAHIA BLANCA;TERMINAL BAHIA BLANCA SA;ACTIAR SRL;PUERTO GALVAN. O.M.H.S.A"  '"LDC - PUERTO GALVAN"
                ParametroManager.GuardarValorParametro2(SC, "Williams_SincroGrobo_BahiaBlancaGrupo", l)
            End If
            Dim bahiablanca = Split(l, ";").ToList





            Dim sErroresProcedencia, sErroresDestinos As String

            Dim sErroresOtros As String

            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataTable.Rows
                i = 0 : sb = ""









                '                                                           Descripción	Tipo de Dato	Longitud        Observaciones()

                'Agregar un control para que no salgan cartas de porte con titulares y destinatarios sin cuit
                If dr("TitularCUIT").ToString = "" Then
                    sErroresOtros &= "<br/> Cliente " & dr("Titular").ToString & " sin CUIT. Carta " & dr("C.Porte").ToString
                End If

                If dr("DestinatarioCUIT").ToString = "" Then
                    sErroresOtros &= "<br/> Cliente " & dr("Destinatario").ToString & " sin CUIT. Carta " & dr("C.Porte").ToString
                End If


                Dim cero = 0
                sb &= "30707386076"                                           '1 - CUIT Williams (Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                sb &= "&" & dr("TitularCUIT").ToString.Replace("-", "").PadLeft(11)                        '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.

                ForzarPrefijo5(dr("C.Porte"))
                sb &= "&" & Left(dr("C.Porte").ToString, IIf(Len(dr("C.Porte").ToString) > 8, Len(dr("C.Porte").ToString) - 8, 0)).PadLeft(4, "0")

                sb &= "&" & Right(dr("C.Porte").ToString, 8).PadLeft(8, "0")                      '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                sb &= "&" & cero.ToString.PadLeft(10)                         '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.)
                sb &= "&" & cero.ToString.PadLeft(10)                         '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & dr("R. ComercialCUIT").ToString.Replace("-", "").PadLeft(11)                          '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.
                sb &= "&" & Left(dr("CEE").ToString, 14).PadLeft(14)                         '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1) Código de Autorización de Uso (C.A.U.) 


                Dim stringFechaVencimiento As String
                'If iisValidSqlDate(dr("Vencim.CP")) Then
                stringFechaVencimiento = FechaANSI(iisValidSqlDate(dr("Vencim.CP"))) '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)
                'Else
                'stringFechaVencimiento = Space(8)
                'End If
                sb &= "&" & IIf(stringFechaVencimiento = "00010101", Space(8), stringFechaVencimiento)


                sb &= "&" & dr("CUIT Transp.").ToString.Replace("-", "").PadLeft(11)           '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)
                sb &= "&" & Left(dr("Trasportista").ToString, 30).PadLeft(30).Replace("&", " ")                          '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.
                sb &= "&" & dr("CUIT chofer").ToString.Replace("-", "").PadLeft(11)                         '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista


                sb &= "&" & IIf(dr("LiquidaViaje").ToString = "SI", "Si", "No")                         '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                sb &= "&" & IIf(dr("CobraAcarreo").ToString = "SI", "Si", "No")                        '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No


                sb &= "&" & IIf(iisNull(dr("Tarifa"), 0) = 0, 0, iisNull(dr("Tarifa"), 0)).ToString.PadLeft(10)                         '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.
                sb &= "&" & Int(dr("Kg.Bruto Desc.")).ToString.PadLeft(10)                         '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Tara Desc.")).ToString.PadLeft(10)                         '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Neto Desc.")).ToString.PadLeft(10)                         '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                sb &= "&" & FechaANSI(iisValidSqlDate(dr("Desc.")))     '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD


                sb &= "&" & DecimalToString(dr("H.%")).PadLeft(5)                         '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & Int(iisNull(dr("Mer.Kg."), 0)).ToString.PadLeft(10)                         '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.

                sb &= "&" & cero.ToString.PadLeft(10)            '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                        '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                sb &= "&" & Int(iisNull(dr("Otras"), 0)).ToString.PadLeft(10)                         '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & Int(dr("Kg.Netos")).ToString.PadLeft(10)                      '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.

                sb &= "&" & Left(dr("Contrato"), 14).ToString.PadLeft(14)                           '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.

                sb &= "&" & cero.ToString.PadLeft(14)                          '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.


                'sb &= "& " & Left(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5).PadLeft(5)                         '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.
                sb &= "&" & Left(iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString, 6).PadLeft(6)


                sb &= "&" & Int(dr("Km")).ToString.PadLeft(10)                        '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & dr("EspecieONCAA").ToString.PadLeft(4, " ")                         '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)
                sb &= "&" & Right(dr("Cosecha"), 5).Replace("/", "").PadLeft(4)                         '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)


                sb &= "&" & IIf(dr("CorredorCUIT").ToString.Replace("-", "") = "88000000122", "0", dr("CorredorCUIT")).ToString.Replace("-", "").PadLeft(11)                        '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.


                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                        '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)





                'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11337

                If bahiablanca.Contains(dr("DestinoDesc").ToString.ToUpper) Then
                    dr("LocalidadDestinoCodigoLosGrobo") = codigoBahiaBlanca ' codigo "Bahia Blanca"
                End If

                sb &= "&" & LeftMasPadLeft(dr("LocalidadDestinoCodigoLosGrobo").ToString, 5)                         '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                sb &= "&" & LeftMasPadLeft(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5)                       '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)



                'If dr("LocalidadProcedenciaCodigoONCAA").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                If dr("LocalidadProcedenciaCodigoLosGrobo").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("Procedcia.").ToString & " es usada en el sincro de LosGrobo y no tiene codigo LosGrobo")

                    sErroresProcedencia &= "<a href=""Localidades.aspx?Id=" & dr("IdLocalidad") & """ target=""_blank"">" & dr("Procedcia.") & "</a>; "
                End If

                'If dr("LocalidadDestinoCodigoONCAA").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                If dr("LocalidadDestinoCodigoLosGrobo").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("DestinoDesc").ToString & " es usada en el sincro de LosGrobo y no tiene codigo LosGrobo")

                    sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & dr("IdWilliamsDestino") & """ target=""_blank"">" & dr("DestinoDesc") & "</a>; "
                End If






                sb &= "&" & dr("SufijoCartaDePorte").ToString.PadLeft(4)                         '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                          '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.
                sb &= "&" & dr("CTG").ToString.PadLeft(8)                         '42 – Numero de CTG	Numérico	8	Número de CTG presente en la CP.
                sb &= "&" & Left(dr("Cal.-Observaciones").ToString.Replace(vbCrLf, "").Replace(vbLf, "").Replace(vbCr, "").Replace("&", " "), 125).PadRight(125)                      '43 – Comentario	Alfa	125	Campo que permita indicar algún mensaje de datos faltantes.

                sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino

                sb &= "&" & iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString.PadLeft(6)   '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia
                sb &= "&" & iisNull(dr("IdTipoMovimiento"), "").ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                '                                                       1.	Egresos contratos de Venta
                '                                                       2.	Egreso Directo a Destino Productor
                '                                                       3.	Directo Destino contrato de Compra
                '                                                       4.	Ingreso Entregado Productor
                '                                                       5.	Ingreso Contrato de Compra
                '                                                       6.	Reingreso de Mercadería
                '                                                       7.	Transferencia desde otra Planta


                sb = sb.Replace(".", ",") 'solucion cabeza por los decimales



                'For Each dc In pDataTable.Columns
                '    If Not IsDBNull(dr(i)) Then
                '        Try
                '            If IsNumeric(dr(i)) Then
                '                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            Else
                '                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            End If
                '        Catch x As Exception
                '            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                '        End Try
                '    Else
                '        sb &= Microsoft.VisualBasic.ControlChars.Tab
                '    End If
                '    i += 1
                'Next






                PrintLine(nF, sb)
            Next



            FileClose(nF)


            ' sErrores = "Procedencias sin código LosGrobo:<br/> " & sErroresProcedencia & "<br/>Destinos sin código LosGrobo: <br/>" & sErroresDestinos
            sErrores &= sErroresOtros

            If True Then
                'If sErroresProcedencia <> "" Or sErroresDestinos <> "" Or 
                If sErroresOtros <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If

            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function

        Public Shared Function Sincronismo_Rivara(ByVal pDataTable As DataTable, ByRef sErrores As String, ByVal titulo As String) As String


            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?

            Dim sErroresProcedencia, sErroresDestinos As String

            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroRivara " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataTable.Rows
                i = 0 : sb = ""

                '                                                           Descripción	Tipo de Dato	Longitud        Observaciones()
                Dim cero = 0
                sb &= "30707386076"                                           '1 - CUIT Williams (Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                sb &= "&" & dr("TitularCUIT").ToString.Replace("-", "").PadLeft(11)                        '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.

                ForzarPrefijo5(dr("C.Porte"))
                sb &= "&" & Left(dr("C.Porte").ToString, IIf(Len(dr("C.Porte").ToString) > 8, Len(dr("C.Porte").ToString) - 8, 0)).PadLeft(4, "0")

                sb &= "&" & Right(dr("C.Porte").ToString, 8).PadLeft(8, "0")                      '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                sb &= "&" & cero.ToString.PadLeft(10)                         '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.)
                sb &= "&" & cero.ToString.PadLeft(10)                         '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & dr("R. ComercialCUIT").ToString.Replace("-", "").PadLeft(11)                          '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.


                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1) Código de Autorización de Uso (C.A.U.) 
                sb &= "&" & Left(iisNull(dr("CEE").ToString, "99999999999999"), 14).PadLeft(14)


                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)
                Dim stringFechaVencimiento As String
                stringFechaVencimiento = FechaANSI(iisValidSqlDate(dr("Vencim.CP")))
                sb &= "&" & IIf(stringFechaVencimiento = "00010101", "00000000", stringFechaVencimiento)




                sb &= "&" & dr("CUIT Transp.").ToString.Replace("-", "").PadLeft(11)           '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)
                sb &= "&" & Left(dr("Trasportista").ToString, 30).PadLeft(30).Replace("&", " ")                          '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.
                sb &= "&" & dr("CUIT chofer").ToString.Replace("-", "").PadLeft(11)                         '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista


                sb &= "&" & IIf(dr("LiquidaViaje").ToString = "SI", "Si", "No")                         '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                sb &= "&" & IIf(dr("CobraAcarreo").ToString = "SI", "Si", "No")                        '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No


                sb &= "&" & IIf(iisNull(dr("Tarifa"), 0) = 0, 0, iisNull(dr("Tarifa"), 0)).ToString.PadLeft(10)                         '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.
                sb &= "&" & Int(dr("Kg.Bruto Desc.")).ToString.PadLeft(10)                         '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Tara Desc.")).ToString.PadLeft(10)                         '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Neto Desc.")).ToString.PadLeft(10)                         '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                sb &= "&" & FechaANSI(iisValidSqlDate(dr("Desc.")))     '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD


                sb &= "&" & DecimalToString(dr("H.%")).PadLeft(5)                         '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & Int(iisNull(dr("Mer.Kg."), 0)).ToString.PadLeft(10)                         '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.

                sb &= "&" & Int(iisNull(dr("Otras"), 0)).ToString.PadLeft(10)            '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                        '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                         '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & Int(dr("Kg.Netos")).ToString.PadLeft(10)                      '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.


                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.
                sb &= "&" & Left(iisNull(dr("Contrato"), "0"), 14).ToString.PadLeft(14)



                sb &= "&" & cero.ToString.PadLeft(14)                          '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.


                'sb &= "& " & Left(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5).PadLeft(5)                         '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.
                sb &= "&" & Left(iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString, 6).PadLeft(6)


                sb &= "&" & Int(dr("Km")).ToString.PadLeft(10)                        '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & dr("EspecieONCAA").ToString.PadLeft(4, " ")                         '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)
                sb &= "&" & Right(dr("Cosecha"), 5).Replace("/", "").PadLeft(4)                         '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)


                sb &= "&" & IIf(dr("CorredorCUIT").ToString.Replace("-", "") = "88000000122", "0", dr("CorredorCUIT")).ToString.Replace("-", "").PadLeft(11)                        '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.


                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                        '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)



                sb &= "&" & LeftMasPadLeft(dr("LocalidadDestinoCodigoLosGrobo").ToString, 5)                         '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                sb &= "&" & LeftMasPadLeft(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5)                       '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)



                'If dr("LocalidadProcedenciaCodigoONCAA").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                If dr("LocalidadProcedenciaCodigoLosGrobo").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("Procedcia.").ToString & " no tiene codigo LosGrobo")

                    sErroresProcedencia &= "<a href=""Localidades.aspx?Id=" & dr("IdLocalidad") & """ target=""_blank"">" & dr("Procedcia.") & "</a>; "
                End If

                'If dr("LocalidadDestinoCodigoONCAA").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                If dr("LocalidadDestinoCodigoLosGrobo").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("DestinoDesc").ToString & " no tiene codigo LosGrobo")

                    sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & dr("IdWilliamsDestino") & """ target=""_blank"">" & dr("DestinoDesc") & "</a>; "
                End If



                sb &= "&" & dr("SufijoCartaDePorte").ToString.PadLeft(4)                         '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                          '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.
                sb &= "&" & dr("CTG").ToString.PadLeft(8)                         '42 – Numero de CTG	Numérico	8	Número de CTG presente en la CP.
                sb &= "&" & Left(dr("Cal.-Observaciones").ToString.Replace(vbCrLf, "").Replace(vbLf, "").Replace(vbCr, "").Replace("&", " "), 125).PadRight(125)                      '43 – Comentario	Alfa	125	Campo que permita indicar algún mensaje de datos faltantes.

                sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino



                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia
                sb &= "&" & iisNull(dr("CodigoEstablecimientoProcedencia"), "0").ToString.PadLeft(6)




                sb &= "&" & iisNull(dr("IdTipoMovimiento"), "").ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                '                                                       1.	Egresos contratos de Venta
                '                                                       2.	Egreso Directo a Destino Productor
                '                                                       3.	Directo Destino contrato de Compra
                '                                                       4.	Ingreso Entregado Productor
                '                                                       5.	Ingreso Contrato de Compra
                '                                                       6.	Reingreso de Mercadería
                '                                                       7.	Transferencia desde otra Planta


                sb = sb.Replace(".", ",") 'solucion cabeza por los decimales



                'For Each dc In pDataTable.Columns
                '    If Not IsDBNull(dr(i)) Then
                '        Try
                '            If IsNumeric(dr(i)) Then
                '                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            Else
                '                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            End If
                '        Catch x As Exception
                '            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                '        End Try
                '    Else
                '        sb &= Microsoft.VisualBasic.ControlChars.Tab
                '    End If
                '    i += 1
                'Next






                PrintLine(nF, sb)
            Next



            FileClose(nF)


            sErrores = "Procedencias sin código LosGrobo:<br/> " & sErroresProcedencia & "<br/>Destinos sin código LosGrobo: <br/>" & sErroresDestinos

            If False Then
                If sErroresProcedencia <> "" Or sErroresDestinos <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If

            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function

        Public Shared Function Sincronismo_Aibal(ByVal pDataTable As DataTable, ByRef sErrores As String, ByVal titulo As String) As String


            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?

            Dim sErroresEspecie, sErroresPrefijo As String
            Dim sErroresProcedencia, sErroresDestinos As String

            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroAibal " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataTable.Rows
                i = 0 : sb = ""

                '                                                           Descripción	Tipo de Dato	Longitud        Observaciones()
                Dim cero = 0
                sb &= "30707386076"                                           '1 - CUIT Williams (Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                sb &= "&" & dr("TitularCUIT").ToString.Replace("-", "").PadLeft(11)                        '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.


                Dim prefijo = Left(dr("C.Porte").ToString, IIf(Len(dr("C.Porte").ToString) > 8, Len(dr("C.Porte").ToString) - 8, 0)).PadLeft(4, "0")
                If prefijo = "0000" Then
                    If bPrefijadorauto Then
                        prefijo = "0005"
                    Else

                        sErroresPrefijo &= "<a href=""CartaDePorte.aspx?Id=" & dr("IdCartaDePorte") & """ target=""_blank"">" & dr("C.Porte") & "</a>; "
                    End If

                End If
                sb &= "&" & prefijo

                sb &= "&" & Right(dr("C.Porte").ToString, 8).PadLeft(8, "0")                      '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                sb &= "&" & cero.ToString.PadLeft(10)                         '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.)
                sb &= "&" & cero.ToString.PadLeft(10)                         '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & dr("R. ComercialCUIT").ToString.Replace("-", "").PadLeft(11)                          '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.


                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1) Código de Autorización de Uso (C.A.U.) 
                sb &= "&" & Left(iisNull(dr("CEE").ToString, "99999999999999"), 14).PadLeft(14)


                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)
                Dim stringFechaVencimiento As String
                stringFechaVencimiento = FechaANSI(iisValidSqlDate(dr("Vencim.CP")))
                sb &= "&" & IIf(stringFechaVencimiento = "00010101", "00000000", stringFechaVencimiento)




                sb &= "&" & dr("CUIT Transp.").ToString.Replace("-", "").PadLeft(11)           '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)
                sb &= "&" & Left(dr("Trasportista").ToString, 30).PadLeft(30).Replace("&", " ")                          '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.
                sb &= "&" & dr("CUIT chofer").ToString.Replace("-", "").PadLeft(11)                         '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista


                sb &= "&" & IIf(dr("LiquidaViaje").ToString = "SI", "Si", "No")                         '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                sb &= "&" & IIf(dr("CobraAcarreo").ToString = "SI", "Si", "No")                        '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No


                sb &= "&" & IIf(iisNull(dr("Tarifa"), 0) = 0, 0, iisNull(dr("Tarifa"), 0)).ToString.PadLeft(10)                         '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.
                sb &= "&" & Int(dr("Kg.Bruto Desc.")).ToString.PadLeft(10)                         '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Tara Desc.")).ToString.PadLeft(10)                         '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Neto Desc.")).ToString.PadLeft(10)                         '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                sb &= "&" & FechaANSI(iisValidSqlDate(dr("Desc.")))     '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD


                sb &= "&" & DecimalToString(dr("H.%")).PadLeft(5)                         '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & Int(iisNull(dr("Mer.Kg."), 0)).ToString.PadLeft(10)                         '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.

                sb &= "&" & Int(iisNull(dr("Otras"), 0)).ToString.PadLeft(10)            '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                        '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                         '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & Int(dr("Kg.Netos")).ToString.PadLeft(10)                      '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.


                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.
                sb &= "&" & Left(iisNull(dr("Contrato"), "0"), 14).ToString.PadLeft(14)



                sb &= "&" & cero.ToString.PadLeft(14)                          '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.


                'sb &= "& " & Left(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5).PadLeft(5)                         '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.

                sb &= "&" & Left(Val(iisNull(dr("CodigoEstablecimientoProcedencia"), "0")).ToString, 6).PadLeft(6)


                sb &= "&" & Int(dr("Km")).ToString.PadLeft(10)                        '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.

                sb &= "&" & CodigoAleaAibal(dr("Producto")).ToString.PadLeft(4, " ")                         '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)
                If dr("EspecieONCAA").ToString = "" Then
                    sErroresEspecie &= "<a href=""CartaDePorte.aspx?Id=" & dr("IdCartaDePorte") & """ target=""_blank"">" & dr("C.Porte") & "</a>; "

                End If

                sb &= "&" & Right(dr("Cosecha"), 5).Replace("/", "").PadLeft(4)                         '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)


                sb &= "&" & IIf(dr("CorredorCUIT").ToString.Replace("-", "") = "88000000122", "0", dr("CorredorCUIT")).ToString.Replace("-", "").PadLeft(11)                        '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.


                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                        '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)



                sb &= "&" & LeftMasPadLeft(dr("LocalidadDestinoCodigoLosGrobo").ToString, 5)                         '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                sb &= "&" & LeftMasPadLeft(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5)                       '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)



                'If dr("LocalidadProcedenciaCodigoONCAA").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                If dr("LocalidadProcedenciaCodigoLosGrobo").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("Procedcia.").ToString & " no tiene codigo LosGrobo")

                    sErroresProcedencia &= "<a href=""Localidades.aspx?Id=" & dr("IdLocalidad") & """ target=""_blank"">" & dr("Procedcia.") & "</a>; "
                End If

                'If dr("LocalidadDestinoCodigoONCAA").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                If dr("LocalidadDestinoCodigoLosGrobo").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("DestinoDesc").ToString & " no tiene codigo LosGrobo")

                    sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & dr("IdWilliamsDestino") & """ target=""_blank"">" & dr("DestinoDesc") & "</a>; "
                End If



                sb &= "&" & dr("SufijoCartaDePorte").ToString.PadLeft(4)                         '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                          '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.
                sb &= "&" & dr("CTG").ToString.PadLeft(8)                         '42 – Numero de CTG	Numérico	8	Número de CTG presente en la CP.
                sb &= "&" & Left(dr("Cal.-Observaciones").ToString.Replace(vbCrLf, "").Replace(vbLf, "").Replace(vbCr, "").Replace("&", " "), 125).PadRight(125)                      '43 – Comentario	Alfa	125	Campo que permita indicar algún mensaje de datos faltantes.

                sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino



                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia
                sb &= "&" & iisNull(dr("CodigoEstablecimientoProcedencia"), "0").ToString.PadLeft(6)


                '                Kari, el problema está en el último campo que informan, que en el caso de 
                'los directos (los 2 primeros y los 2 últimos de este archivo de prueba) no tienen ningún valor en ese campo. 
                '    Decile si los pueden completar con un 2 en el caso de directos. Si ellos no pueden determinar cuando es directo 
                'y cuando no, entonces que lo completen con 0 (cero), pero que no lo dejen vacío porque es eso lo que da error.

                sb &= "&" & iisNull(dr("IdTipoMovimiento"), "0").ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                '                                                       1.	Egresos contratos de Venta
                '                                                       2.	Egreso Directo a Destino Productor
                '                                                       3.	Directo Destino contrato de Compra
                '                                                       4.	Ingreso Entregado Productor
                '                                                       5.	Ingreso Contrato de Compra
                '                                                       6.	Reingreso de Mercadería
                '                                                       7.	Transferencia desde otra Planta


                sb = sb.Replace(".", ",") 'solucion cabeza por los decimales



                'For Each dc In pDataTable.Columns
                '    If Not IsDBNull(dr(i)) Then
                '        Try
                '            If IsNumeric(dr(i)) Then
                '                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            Else
                '                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            End If
                '        Catch x As Exception
                '            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                '        End Try
                '    Else
                '        sb &= Microsoft.VisualBasic.ControlChars.Tab
                '    End If
                '    i += 1
                'Next






                PrintLine(nF, sb)
            Next




            FileClose(nF)


            sErrores = "<br/>Cartas sin prefijo: <br/>" & sErroresPrefijo & _
                        "<br/>Procedencias sin código LosGrobo:<br/> " & sErroresProcedencia & _
                        "<br/>Destinos sin código LosGrobo: <br/>" & sErroresDestinos
            '" <br/>Cartas sin código de Especie ONCAA:<br/> " & sErroresEspecie & _

            If sErroresPrefijo <> "" Or sErroresProcedencia <> "" Or sErroresDestinos <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write

            Return vFileName

        End Function

        Public Shared Function Sincronismo_LaBragadense(ByVal pDataTable As DataTable, ByRef sErrores As String, ByVal titulo As String) As String


            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?

            Dim sErroresEspecie, sErroresPrefijo As String
            Dim sErroresProcedencia, sErroresDestinos As String

            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroLaBragadense " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataTable.Rows
                i = 0 : sb = ""

                '                                                           Descripción	Tipo de Dato	Longitud        Observaciones()
                Dim cero = 0
                sb &= "30707386076"                                           '1 - CUIT Williams (Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                sb &= "&" & dr("TitularCUIT").ToString.Replace("-", "").PadLeft(11)                        '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.


                Dim prefijo = Left(dr("C.Porte").ToString, IIf(Len(dr("C.Porte").ToString) > 8, Len(dr("C.Porte").ToString) - 8, 0)).PadLeft(4, "0")
                If prefijo = "0000" Then
                    If bPrefijadorauto Then
                        prefijo = "0005"
                    Else

                        sErroresPrefijo &= "<a href=""CartaDePorte.aspx?Id=" & dr("IdCartaDePorte") & """ target=""_blank"">" & dr("C.Porte") & "</a>; "
                    End If

                End If
                sb &= "&" & prefijo

                sb &= "&" & Right(dr("C.Porte").ToString, 8).PadLeft(8, "0")                      '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                sb &= "&" & cero.ToString.PadLeft(10)                         '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.)
                sb &= "&" & cero.ToString.PadLeft(10)                         '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & dr("R. ComercialCUIT").ToString.Replace("-", "").PadLeft(11)                          '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.


                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1) Código de Autorización de Uso (C.A.U.) 
                sb &= "&" & Left(iisNull(dr("CEE").ToString, "99999999999999"), 14).PadLeft(14)


                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)
                Dim stringFechaVencimiento As String
                stringFechaVencimiento = FechaANSI(iisValidSqlDate(dr("Vencim.CP")))
                sb &= "&" & IIf(stringFechaVencimiento = "00010101", "00000000", stringFechaVencimiento)




                sb &= "&" & dr("CUIT Transp.").ToString.Replace("-", "").PadLeft(11)           '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)
                sb &= "&" & Left(dr("Trasportista").ToString, 30).PadLeft(30).Replace("&", " ")                          '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.
                sb &= "&" & dr("CUIT chofer").ToString.Replace("-", "").PadLeft(11)                         '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista


                sb &= "&" & IIf(dr("LiquidaViaje").ToString = "SI", "Si", "No")                         '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                sb &= "&" & IIf(dr("CobraAcarreo").ToString = "SI", "Si", "No")                        '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No


                sb &= "&" & IIf(iisNull(dr("Tarifa"), 0) = 0, 0, iisNull(dr("Tarifa"), 0)).ToString.PadLeft(10)                         '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.
                sb &= "&" & Int(dr("Kg.Bruto Desc.")).ToString.PadLeft(10)                         '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Tara Desc.")).ToString.PadLeft(10)                         '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Neto Desc.")).ToString.PadLeft(10)                         '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                sb &= "&" & FechaANSI(iisValidSqlDate(dr("Desc.")))     '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD


                sb &= "&" & DecimalToString(dr("H.%")).PadLeft(5)                         '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & Int(iisNull(dr("Mer.Kg."), 0)).ToString.PadLeft(10)                         '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.

                sb &= "&" & Int(iisNull(dr("Otras"), 0)).ToString.PadLeft(10)            '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                        '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                         '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & Int(dr("Kg.Netos")).ToString.PadLeft(10)                      '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.


                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.
                sb &= "&" & Left(iisNull(dr("Contrato"), "0"), 14).ToString.PadLeft(14)



                sb &= "&" & cero.ToString.PadLeft(14)                          '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.


                'sb &= "& " & Left(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5).PadLeft(5)                         '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.

                sb &= "&" & Left(Val(iisNull(dr("CodigoEstablecimientoProcedencia"), "0")).ToString, 6).PadLeft(6)


                sb &= "&" & Int(dr("Km")).ToString.PadLeft(10)                        '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.



                sb &= "&" & CodigoLaBragadense(dr("Producto")).ToString.PadLeft(4, " ")                         '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)


                If dr("EspecieONCAA").ToString = "" Then
                    sErroresEspecie &= "<a href=""CartaDePorte.aspx?Id=" & dr("IdCartaDePorte") & """ target=""_blank"">" & dr("C.Porte") & "</a>; "

                End If

                sb &= "&" & Right(dr("Cosecha"), 5).Replace("/", "").PadLeft(4)                         '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)


                sb &= "&" & IIf(dr("CorredorCUIT").ToString.Replace("-", "") = "88000000122", "0", dr("CorredorCUIT")).ToString.Replace("-", "").PadLeft(11)                        '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.


                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                        '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)



                sb &= "&" & LeftMasPadLeft(dr("LocalidadDestinoCodigoLosGrobo").ToString, 5)                         '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                sb &= "&" & LeftMasPadLeft(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5)                       '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)



                'If dr("LocalidadProcedenciaCodigoONCAA").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                If dr("LocalidadProcedenciaCodigoLosGrobo").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("Procedcia.").ToString & " no tiene codigo LosGrobo")

                    sErroresProcedencia &= "<a href=""Localidades.aspx?Id=" & dr("IdLocalidad") & """ target=""_blank"">" & dr("Procedcia.") & "</a>; "
                End If

                'If dr("LocalidadDestinoCodigoONCAA").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                If dr("LocalidadDestinoCodigoLosGrobo").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("DestinoDesc").ToString & " no tiene codigo LosGrobo")

                    sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & dr("IdWilliamsDestino") & """ target=""_blank"">" & dr("DestinoDesc") & "</a>; "
                End If



                sb &= "&" & dr("SufijoCartaDePorte").ToString.PadLeft(4)                         '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                          '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.
                sb &= "&" & dr("CTG").ToString.PadLeft(8)                         '42 – Numero de CTG	Numérico	8	Número de CTG presente en la CP.
                sb &= "&" & Left(dr("Cal.-Observaciones").ToString.Replace(vbCrLf, "").Replace(vbLf, "").Replace(vbCr, "").Replace("&", " "), 125).PadRight(125)                      '43 – Comentario	Alfa	125	Campo que permita indicar algún mensaje de datos faltantes.

                sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino



                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia
                sb &= "&" & iisNull(dr("CodigoEstablecimientoProcedencia"), "0").ToString.PadLeft(6)


                '                Kari, el problema está en el último campo que informan, que en el caso de 
                'los directos (los 2 primeros y los 2 últimos de este archivo de prueba) no tienen ningún valor en ese campo. 
                '    Decile si los pueden completar con un 2 en el caso de directos. Si ellos no pueden determinar cuando es directo 
                'y cuando no, entonces que lo completen con 0 (cero), pero que no lo dejen vacío porque es eso lo que da error.

                sb &= "&" & iisNull(dr("IdTipoMovimiento"), "0").ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                '                                                       1.	Egresos contratos de Venta
                '                                                       2.	Egreso Directo a Destino Productor
                '                                                       3.	Directo Destino contrato de Compra
                '                                                       4.	Ingreso Entregado Productor
                '                                                       5.	Ingreso Contrato de Compra
                '                                                       6.	Reingreso de Mercadería
                '                                                       7.	Transferencia desde otra Planta


                sb = sb.Replace(".", ",") 'solucion cabeza por los decimales



                'For Each dc In pDataTable.Columns
                '    If Not IsDBNull(dr(i)) Then
                '        Try
                '            If IsNumeric(dr(i)) Then
                '                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            Else
                '                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            End If
                '        Catch x As Exception
                '            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                '        End Try
                '    Else
                '        sb &= Microsoft.VisualBasic.ControlChars.Tab
                '    End If
                '    i += 1
                'Next






                PrintLine(nF, sb)
            Next




            FileClose(nF)


            sErrores = "<br/>Cartas sin prefijo: <br/>" & sErroresPrefijo & _
                        "<br/>Procedencias sin código LosGrobo:<br/> " & sErroresProcedencia & _
                        "<br/>Destinos sin código LosGrobo: <br/>" & sErroresDestinos
            '" <br/>Cartas sin código de Especie ONCAA:<br/> " & sErroresEspecie & _

            If sErroresPrefijo <> "" Or sErroresProcedencia <> "" Or sErroresDestinos <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write

            Return vFileName

        End Function

        Shared Function CodigoAleaAibal(productoDescripcion As String) As String
            productoDescripcion = productoDescripcion.ToUpper






            If InStr(productoDescripcion, "AVENA") > 0 Then
                Return "AVEN"
            End If
            If InStr(productoDescripcion, "TRIGO CANDEAL") > 0 Then
                Return "CAND"
            End If
            If InStr(productoDescripcion, "CEBADA CERVECERA") > 0 Then
                Return "CEBA"
            End If
            If InStr(productoDescripcion, "CEBADA FORRAJERA") > 0 Then
                Return "CEBF"
            End If
            If InStr(productoDescripcion, "COLZA") > 0 Then
                Return "COLZ"
            End If
            If InStr(productoDescripcion, "OLEICO") > 0 Then
                Return "GIRO"
            End If
            If InStr(productoDescripcion, "GIRASOL") > 0 Then
                Return "GIRA"
            End If
            If InStr(productoDescripcion, "MAIZ") > 0 Then
                Return "MAIZ"
            End If
            If InStr(productoDescripcion, "MIJO") > 0 Then
                Return "MIJO"
            End If
            If InStr(productoDescripcion, "MOHA") > 0 Then
                Return "MOHA"
            End If
            If InStr(productoDescripcion, "SOJA") > 0 Then
                Return "SOJA"
            End If
            If InStr(productoDescripcion, "SOJILLA") > 0 Then
                Return "SOJI"
            End If
            If InStr(productoDescripcion, "SORGO GRANIFERO") > 0 Then
                Return "SORG"
            End If
            If InStr(productoDescripcion, "TRIGO") > 0 Then
                Return "TRIG"
            End If


            If InStr(productoDescripcion, "Aceite de Soja".ToUpper) > 0 Then
                Return "ACEI"
            End If
            If InStr(productoDescripcion, "Algodon".ToUpper) > 0 Then
                Return "ALGO"
            End If
            If InStr(productoDescripcion, "Alpiste".ToUpper) > 0 Then
                Return "ALPI"
            End If
            If InStr(productoDescripcion, "Arroz".ToUpper) > 0 Then
                Return "ARRO"
            End If
            If InStr(productoDescripcion, "Canola".ToUpper) > 0 Then
                Return "CANO"
            End If
            If InStr(productoDescripcion, "Centeno".ToUpper) > 0 Then
                Return "CENT"
            End If
            If InStr(productoDescripcion, "Chia".ToUpper) > 0 Then
                Return "CHIA"
            End If
            If InStr(productoDescripcion, "Girasol Confitero".ToUpper) > 0 Then
                Return "CONF"
            End If
            If InStr(productoDescripcion, "Maiz Flint".ToUpper) > 0 Then
                Return "FLIN"
            End If
            If InStr(productoDescripcion, "Garbanzo".ToUpper) > 0 Then
                Return "GARB"
            End If
            If InStr(productoDescripcion, "Harina de Soja".ToUpper) > 0 Then
                Return "HARI"
            End If
            If InStr(productoDescripcion, "Mani".ToUpper) > 0 Then
                Return "MANI"
            End If
            If InStr(productoDescripcion, "Maiz Map".ToUpper) > 0 Then
                Return "MAP"
            End If
            If InStr(productoDescripcion, "Maiz Pizingallo".ToUpper) > 0 Then
                Return "MZP"
            End If
            If InStr(productoDescripcion, "Poroto Blanco Alubia".ToUpper) > 0 Then
                Return "PA"
            End If
            If InStr(productoDescripcion, "Poroto Colorado".ToUpper) > 0 Then
                Return "PCOL"
            End If

            If InStr(productoDescripcion, "Poroto Negro".ToUpper) > 0 Then
                Return "PN"
            End If

            If InStr(productoDescripcion, "Triticale".ToUpper) > 0 Then
                Return "TRIT"
            End If






            Return ""
            Err.Raise(3333, , "No se encontró el código artículo para el sincro Alea/Aibal: " & productoDescripcion)

            'Select Case codigoONCAA
            '    Case  
            'End Select
        End Function

        Shared Function CodigoLaBragadense(productoDescripcion As String) As String
            productoDescripcion = productoDescripcion.ToUpper

            '
            '
            '
            ''




            If InStr(productoDescripcion, "AVENA") > 0 Then
                Return "02"
            End If
            If InStr(productoDescripcion, "TRIGO") > 0 Then
                Return "01"
            End If
            If InStr(productoDescripcion, "CEBADA CERVECERA") > 0 Then
                Return "03"
            End If
            If InStr(productoDescripcion, "COLZA") > 0 Then
                Return "04"
            End If
            If InStr(productoDescripcion, "GIRASOL") > 0 Then
                Return "09"
            End If
            If InStr(productoDescripcion, "MAIZ") > 0 Then
                Return "06"
            End If
            If InStr(productoDescripcion, "SOJA") > 0 Then
                Return "08"
            End If
            If InStr(productoDescripcion, "SORGO") > 0 Then
                Return "07"
            End If

            Return productoDescripcion
            Err.Raise(3333, , "No se encontró el código artículo para el sincro Alea/Aibal: " & productoDescripcion)

            'Select Case codigoONCAA
            '    Case  
            'End Select
        End Function

        Public Shared Function Sincronismo_Alea(ByVal pDataTable As DataTable, ByRef sErrores As String, ByVal titulo As String) As String


            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?

            Dim sErroresEspecie, sErroresPrefijo, sErroresHumedad As String
            Dim sErroresProcedencia, sErroresDestinos As String


            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroAlea " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataTable.Rows
                i = 0 : sb = ""

                '                                                           Descripción	Tipo de Dato	Longitud        Observaciones()
                Dim cero = 0
                sb &= "30707386076"                                           '1 - CUIT Williams (Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                sb &= "&" & dr("TitularCUIT").ToString.Replace("-", "").PadLeft(11)                        '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.

                Dim prefijo = Left(dr("C.Porte").ToString, IIf(Len(dr("C.Porte").ToString) > 8, Len(dr("C.Porte").ToString) - 8, 0)).PadLeft(4, "0")
                If prefijo = "0000" Then
                    If bPrefijadorauto Then
                        prefijo = "0005"
                    Else
                        sErroresPrefijo &= "<a href=""CartaDePorte.aspx?Id=" & dr("IdCartaDePorte") & """ target=""_blank"">" & dr("C.Porte") & "</a>; "
                    End If
                End If
                sb &= "&" & prefijo



                sb &= "&" & Right(dr("C.Porte").ToString, 8).PadLeft(8, "0")                      '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                sb &= "&" & cero.ToString.PadLeft(10)                         '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.)
                sb &= "&" & cero.ToString.PadLeft(10)                         '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & dr("R. ComercialCUIT").ToString.Replace("-", "").PadLeft(11)                          '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.


                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1) Código de Autorización de Uso (C.A.U.) 
                sb &= "&" & Left(iisNull(dr("CEE").ToString, "99999999999999"), 14).PadLeft(14)


                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)
                Dim stringFechaVencimiento As String
                stringFechaVencimiento = FechaANSI(iisValidSqlDate(dr("Vencim.CP")))
                sb &= "&" & IIf(stringFechaVencimiento = "00010101", "00000000", stringFechaVencimiento)




                sb &= "&" & dr("CUIT Transp.").ToString.Replace("-", "").PadLeft(11)           '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)
                sb &= "&" & Left(dr("Trasportista").ToString, 30).PadLeft(30).Replace("&", " ")                          '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.
                sb &= "&" & dr("CUIT chofer").ToString.Replace("-", "").PadLeft(11)                         '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista


                sb &= "&" & IIf(dr("LiquidaViaje").ToString = "SI", "Si", "No")                         '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                sb &= "&" & IIf(dr("CobraAcarreo").ToString = "SI", "Si", "No")                        '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No


                sb &= "&" & IIf(iisNull(dr("Tarifa"), 0) = 0, 0, iisNull(dr("Tarifa"), 0)).ToString.PadLeft(10)                         '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.
                sb &= "&" & Int(dr("Kg.Bruto Desc.")).ToString.PadLeft(10)                         '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Tara Desc.")).ToString.PadLeft(10)                         '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Neto Desc.")).ToString.PadLeft(10)                         '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                sb &= "&" & FechaANSI(iisValidSqlDate(dr("Desc.")))     '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD

                If iisNull(dr("H.%"), 0) = 0 Then
                    sErroresHumedad &= "<a href=""CartaDePorte.aspx?Id=" & dr("IdCartaDePorte") & """ target=""_blank"">" & dr("C.Porte") & "</a>; "

                End If
                Dim humed = DecimalToString(dr("H.%"))
                sb &= "&" & humed.PadLeft(5)                         '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.


                sb &= "&" & Int(iisNull(dr("Mer.Kg."), 0)).ToString.PadLeft(10)                         '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.

                sb &= "&" & Int(iisNull(dr("Otras"), 0)).ToString.PadLeft(10)            '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                        '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                         '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & Int(dr("Kg.Netos")).ToString.PadLeft(10)                      '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.


                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.
                sb &= "&" & Left(iisNull(dr("Contrato"), "0"), 14).ToString.PadLeft(14)



                sb &= "&" & cero.ToString.PadLeft(14)                          '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.


                'sb &= "& " & Left(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5).PadLeft(5)                         '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.
                sb &= "&" & Left(iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString, 6).PadLeft(6)


                sb &= "&" & Int(dr("Km")).ToString.PadLeft(10)                        '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.



                sb &= "&" & CodigoAleaAibal(dr("Producto")).ToString.PadLeft(4, " ")                         '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)


                If dr("EspecieONCAA").ToString = "" Then
                    sErroresEspecie &= "<a href=""CartaDePorte.aspx?Id=" & dr("IdCartaDePorte") & """ target=""_blank"">" & dr("C.Porte") & "</a>; "

                End If







                sb &= "&" & Right(dr("Cosecha"), 5).Replace("/", "").PadLeft(4)                         '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)


                sb &= "&" & IIf(dr("CorredorCUIT").ToString.Replace("-", "") = "88000000122", "0", dr("CorredorCUIT")).ToString.Replace("-", "").PadLeft(11)                        '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.


                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                        '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)



                sb &= "&" & LeftMasPadLeft(dr("LocalidadDestinoCodigoLosGrobo").ToString, 5)                         '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                sb &= "&" & LeftMasPadLeft(dr("LocalidadProcedenciaCodigoLosGrobo").ToString, 5)                       '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)



                'If dr("LocalidadProcedenciaCodigoONCAA").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                If dr("LocalidadProcedenciaCodigoLosGrobo").ToString = "" And InStr(sErroresProcedencia, dr("Procedcia.").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("Procedcia.").ToString & " no tiene codigo LosGrobo")

                    sErroresProcedencia &= "<a href=""Localidades.aspx?Id=" & dr("IdLocalidad") & """ target=""_blank"">" & dr("Procedcia.") & "</a>; "
                End If

                'If dr("LocalidadDestinoCodigoONCAA").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                If dr("LocalidadDestinoCodigoLosGrobo").ToString = "" And InStr(sErroresDestinos, dr("DestinoDesc").ToString) = 0 Then
                    'si no tiene codigo ni está ya en sErrores, lo meto

                    ErrHandler.WriteError("La localidad " & dr("DestinoDesc").ToString & " no tiene codigo LosGrobo")

                    sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & dr("IdWilliamsDestino") & """ target=""_blank"">" & dr("DestinoDesc") & "</a>; "
                End If



                sb &= "&" & dr("SufijoCartaDePorte").ToString.PadLeft(4)                         '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                          '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.
                sb &= "&" & dr("CTG").ToString.PadLeft(8)                         '42 – Numero de CTG	Numérico	8	Número de CTG presente en la CP.
                sb &= "&" & Left(dr("Cal.-Observaciones").ToString.Replace(vbCrLf, "").Replace(vbLf, "").Replace(vbCr, "").Replace("&", " "), 125).PadRight(125)                      '43 – Comentario	Alfa	125	Campo que permita indicar algún mensaje de datos faltantes.

                sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino



                'https://mail.google.com/mail/u/0/#inbox/13b47cc0a40eb6e4
                '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia
                sb &= "&" & iisNull(dr("CodigoEstablecimientoProcedencia"), "0").ToString.PadLeft(6)




                sb &= "&" & iisNull(dr("IdTipoMovimiento"), "").ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                '                                                       1.	Egresos contratos de Venta
                '                                                       2.	Egreso Directo a Destino Productor
                '                                                       3.	Directo Destino contrato de Compra
                '                                                       4.	Ingreso Entregado Productor
                '                                                       5.	Ingreso Contrato de Compra
                '                                                       6.	Reingreso de Mercadería
                '                                                       7.	Transferencia desde otra Planta


                sb = sb.Replace(".", ",") 'solucion cabeza por los decimales



                'For Each dc In pDataTable.Columns
                '    If Not IsDBNull(dr(i)) Then
                '        Try
                '            If IsNumeric(dr(i)) Then
                '                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            Else
                '                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            End If
                '        Catch x As Exception
                '            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                '        End Try
                '    Else
                '        sb &= Microsoft.VisualBasic.ControlChars.Tab
                '    End If
                '    i += 1
                'Next









                PrintLine(nF, sb)
            Next



            FileClose(nF)


            sErrores = "<br/>Cartas sin prefijo: <br/>" & sErroresPrefijo & _
                        "<br/>Cartas sin Humedad:<br/> " & sErroresHumedad & _
                        "<br/>Procedencias sin código LosGrobo:<br/> " & sErroresProcedencia & _
                        "<br/>Destinos sin código LosGrobo: <br/>" & sErroresDestinos

            '" <br/>Cartas sin código de Especie ONCAA:<br/> " & sErroresEspecie & _

            If True Then
                If sErroresPrefijo <> "" Or sErroresHumedad <> "" Or sErroresProcedencia <> "" Or sErroresDestinos <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If

            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function

        Public Shared Function Sincronismo_Dukarevich(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String





            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroDuka " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            'Dim a = pDataTable(1)


            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0


                    sb &= .CodigoSAJPYA.PadLeft(3) 'Grano	STRING(3)	Código de grano Sagpya)    1)    3
                    sb &= IIf(True, 1, 2).ToString.PadRight(3) 'GranelBolsa	STRING(3)	Embalaje del grano 1=Granel 2=Bolsa)    4)    6

                    sb &= CInt(.KmARecorrer).ToString.PadLeft(4, "0") 'Km	STRING(4)	Km 2000-2001 Ej: 0001)    7)    10

                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= FechaANSI(iisValidSqlDate(.FechaArribo)) 'FecIng	STRING(8)	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001)    11)    18


                    If .IsHoraNull Then
                        sb &= #12:00:00 AM#.ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    Else
                        sb &= Convert.ToDateTime(.Hora).ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    End If


                    sb &= "  "

                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= FechaANSI(iisValidSqlDate(.FechaDescarga)) 'FecSal	STRING(8)	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001)    27)    34
                    sb &= Convert.ToDateTime(iisNull(.FechaDescarga, #12:00:00 AM#)).ToString("hhmmss") 'HorSal	STRING(8)	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556)    35)    42


                    sb &= "  "




                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular
                    'Corredor Endozo		    ?
                    'Comprador Endozo		    ?
                    'Corredor Vendedor		    ?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""

                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPuerto	STRING(30)	Nombre Puerto)    57)    86

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130

                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218

                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITEntregador	STRING(14)	CUIT Entregador)    219)    232
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomEntregador	STRING(30)	Nombre Entregador)    233)    262

                    '////////////////////////////////////////////////////////////////////////////////
                    'Strongly Typed DataSets encountering NULL values – Grrrrrr… 
                    'http://social.msdn.microsoft.com/forums/en-US/winformsdatacontrols/thread/1dad8d0d-6eae-4254-a9d6-22d50da5578a
                    '////////////////////////////////////////////////////////////////////////////////

                    If .IsClienteFacturadoCUITNull Then .ClienteFacturadoCUIT = ""
                    sb &= Left(.ClienteFacturadoCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCargador	STRING(14)	CUIT Cargador)    263)    276
                    If .IsClienteFacturadoNull Then .ClienteFacturado = ""
                    sb &= Left(.ClienteFacturado.ToString, 30).PadRight(30) 'NomCargador 	STRING(30)	Nombre Cargador)    277)    306



                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350





                    sb &= Left(cadenavacia.ToString, 14).PadRight(14) 'CUITCorrEndo	STRING(14)	CUIT  Corredor Endozo)    351)    364
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomCorrEndo	STRING(30)	Nombre Corredor Endozo)    365)    394

                    sb &= Left(cadenavacia.ToString, 14).PadRight(14) 'CUITCompEndo	STRING(14)	CUIT Comprador Endozo)    395)    408
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomCompEndo	STRING(30)	Nombre Comprador Endozo)    409)    438

                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrVend	STRING(14)	CUIT Corredor Vendedor.)    439)    452
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomCorrVend	STRING(30)	Nombre Corredor Vendedor)    453)    482

                    sb &= Left(cadenavacia.ToString, 14).PadRight(14) 'CUITPlantaOrigen	STRING(14)	CUIT Planta Origen)    483)    496
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomPlantaOrigen	STRING(30)	Nombre Planta Origen)    497)    526






                    sb &= Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
                    sb &= Left(.Procedencia.ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
                    sb &= Left(.DestinoCodigoPostal.ToString, 8).PadRight(8) 'CPDestino	STRING(8)	Código Postal Destino)    565)    572
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602



                    sb &= IIf(True, 1, 0).ToString.PadRight(1) 'CodMovIE	STRING(1)	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr)    603)    603
                    sb &= Left(.Patente.ToString, 10).PadRight(10) 'PatCha	STRING(6)	Patente chasis)    604)    609
                    'sb &= Left(.Acoplado.ToString, 6).PadRight(6) 'PatAcoplado	STRING(6)	Acoplado chasis)    610)    615



                    sb &= Int(.NetoPto).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= Int(.TaraPto).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= Int(.BrutoPto).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    sb &= Int(.Merma).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655


                    sb &= Int(.NetoFinal).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665


                    sb &= String.Format("{0:F1}", .Humedad).PadLeft(10) 'PorHume	STRING(10)	Porcentaje humedad (un (1) decimal))    666)    675
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorMemaHumedad	STRING(10)	Porcentaje merma humedad (dos (2) decimales))    676)    685
                    sb &= Int(.Merma).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695
                    sb &= Left(cadenavacia.ToString, 10).PadLeft(10) 'PBonHume	STRING(10)	Porcentaje bonificación humedad (dos (2) decimales))    696)    705
                    sb &= Left(cadenavacia.ToString, 10).PadLeft(10) 'KgsBonHu	STRING(10)	Kilos bonificación humedad)    706)    715




                    'esto?
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorZaran	STRING(10)	Porcentaje zarandeo (dos (2) decimales))    716)    725
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsZaran	STRING(10)	Kilos zarandeo (sin decimales))    726)    735
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorDesca	STRING(10)	Porcentaje descarte (dos (2) decimales))    736)    745
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsDesca	STRING(10)	Kilogramos Descarte (Sin Decimales))    746)    755
                    sb &= Left(Val(cadenavacia).ToString, 10).PadLeft(10) 'PorVolat	STRING(10)	Porcentaje volátil (dos (2) decimales))    756)    765
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsVolat	STRING(10)	Kilogramos volátil (sin decimales))    766)    775



                    sb &= Left(cadenavacia.ToString, 8).PadLeft(8) 'CantBolsa	STRING(8)	Cantidad de bolsas)    776)    783
                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'Fumigada	STRING(1)	Condición fumigada 0=no 1=si)    784)    784



                    sb &= Int(.NetoProc).ToString.PadRight(10) 'PesoProcede	STRING(10)	Peso procedencia (Sin Decimales))    785)    794



                    sb &= Left(.Contrato.ToString, 12).PadRight(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826




                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= Left(.NumeroCartaDePorte.ToString, 14).PadRight(14) 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840





                    sb &= IIf(True, "c", "v").ToString.PadRight(1) 'TipoTrans	STRING(1)	Tipo de transporte c=camión  v=vagón o=Otro)    841)    841


                    sb &= Left(.NobleGrado.ToString, 10).PadLeft(10) 'Grado	STRING(10)	Grado)    842)    851
                    sb &= Left(.Factor.ToString, 10).PadLeft(10) 'Factor	STRING(10)	Factor)    852)    861

                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'Observac	STRING(100)	Observaciones)    862)    961


                    'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)
                    Dim sCalidad As String
                    If InStr(.Calidad.ToString.ToLower, "grado 1") > 0 Then
                        sCalidad = "G1"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 2") > 0 Then
                        sCalidad = "G2"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 3") > 0 Then
                        sCalidad = "G3"
                    ElseIf InStr(.Calidad.ToString.ToLower, "camara") > 0 Then
                        sCalidad = "CC"
                    Else
                        sCalidad = "FE"
                    End If
                    sb &= Left(sCalidad, 4).PadRight(4) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'MovStock	STRING(1)	Señal 1=Movió mercadería)       0=No movió mercadería)    966)    966
                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'ObsAna	STRING(100)	Observaciones Analisis)    967)    1066






                    PrintLine(nF, sb)
                End With
            Next


            FileClose(nF)


            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function

        Shared Sub ForzarPrefijo5(ByRef numcdp As Long)

            'Dim prefijo = Left(numcdp.ToString, IIf(Len(numcdp.ToString) > 8, Len(numcdp.ToString) - 8, 0)).PadLeft(4, "0")
            'sb &= prefijo
            'If prefijo = "0000" Then
            '    If bPrefijadorauto Then
            '        prefijo = "0005"
            '    Else

            '        sErroresPrefijo &= "<a href=""CartaDePorte.aspx?Id=" & .IdCartaDePorte & """ target=""_blank"">" & .NumeroCartaDePorte & "</a>; "
            '    End If
            'End If

            'If Len(numcdp.ToString) > 8 Then

            'End If
            Dim nuevol As Long
            nuevol = Val("5" + Right(numcdp.ToString, 8).PadLeft(8, "0"))

            If numcdp <> nuevol Then
                numcdp = nuevol
            End If

        End Sub


        Public Shared Function Sincronismo_GranosDelParana(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String





            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroGDP " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            'Dim a = pDataTable(1)


            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0


                    sb &= .CodigoSAJPYA.PadLeft(3) 'Grano	STRING(3)	Código de grano Sagpya)    1)    3
                    sb &= IIf(True, 1, 2).ToString.PadRight(3) 'GranelBolsa	STRING(3)	Embalaje del grano 1=Granel 2=Bolsa)    4)    6


                    sb &= Right(.Cosecha, 5).Replace("/", "").PadLeft(4)

                    'sb &= .KmARecorrer.ToString.PadLeft(4, "0") 'Km	STRING(4)	Km 2000-2001 Ej: 0001)    7)    10




                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= Convert.ToDateTime(iisValidSqlDate(.FechaArribo)).ToString("ddMMyyyy")
                    'sb &= FechaANSI(iisValidSqlDate(.FechaArribo)) 'FecIng	STRING(8)	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001)    11)    18
                    If .IsHoraNull Then
                        sb &= #12:00:00 AM#.ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    Else
                        sb &= Convert.ToDateTime(.Hora).ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    End If
                    sb &= "  "



                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing

                    sb &= Convert.ToDateTime(iisValidSqlDate(.FechaDescarga)).ToString("ddMMyyyy")

                    'sb &= FechaANSI(iisValidSqlDate(.FechaDescarga)) 'FecSal	STRING(8)	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001)    27)    34
                    sb &= Convert.ToDateTime(iisNull(.FechaDescarga, #12:00:00 AM#)).ToString("hhmmss") 'HorSal	STRING(8)	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556)    35)    42
                    sb &= "  "








                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular
                    'Corredor Endozo		    ?
                    'Comprador Endozo		    ?
                    'Corredor Vendedor		    ?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""

                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPuerto	STRING(30)	Nombre Puerto)    57)    86

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130

                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218

                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITEntregador	STRING(14)	CUIT Entregador)    219)    232
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomEntregador	STRING(30)	Nombre Entregador)    233)    262

                    '////////////////////////////////////////////////////////////////////////////////
                    'Strongly Typed DataSets encountering NULL values – Grrrrrr… 
                    'http://social.msdn.microsoft.com/forums/en-US/winformsdatacontrols/thread/1dad8d0d-6eae-4254-a9d6-22d50da5578a
                    '////////////////////////////////////////////////////////////////////////////////

                    If .IsClienteFacturadoCUITNull Then .ClienteFacturadoCUIT = ""
                    sb &= Left(.ClienteFacturadoCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCargador	STRING(14)	CUIT Cargador)    263)    276
                    If .IsClienteFacturadoNull Then .ClienteFacturado = ""
                    sb &= Left(.ClienteFacturado.ToString, 30).PadRight(30) 'NomCargador 	STRING(30)	Nombre Cargador)    277)    306



                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350





                    sb &= Left(cadenavacia.ToString, 14).PadRight(14) 'CUITCorrEndo	STRING(14)	CUIT  Corredor Endozo)    351)    364
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomCorrEndo	STRING(30)	Nombre Corredor Endozo)    365)    394

                    sb &= Left(cadenavacia.ToString, 14).PadRight(14) 'CUITCompEndo	STRING(14)	CUIT Comprador Endozo)    395)    408
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomCompEndo	STRING(30)	Nombre Comprador Endozo)    409)    438

                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrVend	STRING(14)	CUIT Corredor Vendedor.)    439)    452
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomCorrVend	STRING(30)	Nombre Corredor Vendedor)    453)    482

                    sb &= Left(cadenavacia.ToString, 14).PadRight(14) 'CUITPlantaOrigen	STRING(14)	CUIT Planta Origen)    483)    496
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomPlantaOrigen	STRING(30)	Nombre Planta Origen)    497)    526






                    sb &= Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
                    sb &= Left(.Procedencia.ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
                    sb &= Left(.DestinoCodigoPostal.ToString, 8).PadRight(8) 'CPDestino	STRING(8)	Código Postal Destino)    565)    572
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602



                    sb &= IIf(True, 1, 0).ToString.PadRight(1) 'CodMovIE	STRING(1)	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr)    603)    603
                    sb &= Left(.Patente.ToString, 6).PadRight(6) 'PatCha	STRING(6)	Patente chasis)    604)    609
                    sb &= Left(.Acoplado.ToString, 6).PadRight(6) 'PatAcoplado	STRING(6)	Acoplado chasis)    610)    615




                    'Estan informando mal los campos:

                    'Pesobrut:   31090
                    'PesoEgre:   13540
                    'PesoNeto:  44630
                    'TotalMermas: 0  (debe ser para este caso 1866)

                    'Te adjunto el excel y el txt que se enviaron a Granos del Parana para que lo corroboren.

                    'Por favor avísame cuando tengas alguna novedad.



                    sb &= Int(.BrutoFinal).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= Int(.TaraFinal).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= Int(.NetoFinal).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    sb &= Int(.Merma + .HumedadDesnormalizada).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655



                    sb &= Int(.NetoProc).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665


                    sb &= String.Format("{0:F1}", .Humedad).PadLeft(10) 'PorHume	STRING(10)	Porcentaje humedad (un (1) decimal))    666)    675
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorMemaHumedad	STRING(10)	Porcentaje merma humedad (dos (2) decimales))    676)    685
                    sb &= Int(.HumedadDesnormalizada).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695
                    sb &= Left(cadenavacia.ToString, 10).PadLeft(10) 'PBonHume	STRING(10)	Porcentaje bonificación humedad (dos (2) decimales))    696)    705
                    sb &= Left(cadenavacia.ToString, 10).PadLeft(10) 'KgsBonHu	STRING(10)	Kilos bonificación humedad)    706)    715




                    'esto?
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorZaran	STRING(10)	Porcentaje zarandeo (dos (2) decimales))    716)    725
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsZaran	STRING(10)	Kilos zarandeo (sin decimales))    726)    735
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorDesca	STRING(10)	Porcentaje descarte (dos (2) decimales))    736)    745
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsDesca	STRING(10)	Kilogramos Descarte (Sin Decimales))    746)    755
                    sb &= Left(Val(cadenavacia).ToString, 10).PadLeft(10) 'PorVolat	STRING(10)	Porcentaje volátil (dos (2) decimales))    756)    765
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsVolat	STRING(10)	Kilogramos volátil (sin decimales))    766)    775



                    sb &= Left(cadenavacia.ToString, 8).PadLeft(8) 'CantBolsa	STRING(8)	Cantidad de bolsas)    776)    783
                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'Fumigada	STRING(1)	Condición fumigada 0=no 1=si)    784)    784


                    'estos no van en el mismo orden que la procedencia (acá va neto-bruto-tara.  En la descarga usas bruto-tara-neto)
                    sb &= Int(.NetoPto).ToString.PadRight(10) 'PesoProcede	STRING(10)	Peso procedencia (Sin Decimales))    785)    794
                    sb &= Int(.BrutoPto).ToString.PadRight(10) 'BrutoProcede	STRING(10)	Bruto procedencia (Sin Decimales))    795)    804
                    sb &= Int(.TaraPto).ToString.PadRight(10) 'TaraProcede	STRING(10)	Tara procedencia (Sin Decimales))    805)    814



                    sb &= Left(.Contrato.ToString, 12).PadRight(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826

                    ForzarPrefijo5(.NumeroCartaDePorte)

                    sb &= Left(.NumeroCartaDePorte.ToString, 14).PadRight(14) 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840
                    sb &= IIf(True, "c", "v").ToString.PadRight(1) 'TipoTrans	STRING(1)	Tipo de transporte c=camión  v=vagón o=Otro)    841)    841


                    sb &= Left(.NobleGrado.ToString, 10).PadRight(10) 'Grado	STRING(10)	Grado)    842)    851
                    sb &= Left(.Factor.ToString, 10).PadRight(10) 'Factor	STRING(10)	Factor)    852)    861

                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'Observac	STRING(100)	Observaciones)    862)    961


                    'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)
                    Dim sCalidad As String
                    If InStr(.Calidad.ToString.ToLower, "grado 1") > 0 Then
                        sCalidad = "G1"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 2") > 0 Then
                        sCalidad = "G2"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 3") > 0 Then
                        sCalidad = "G3"
                    ElseIf InStr(.Calidad.ToString.ToLower, "camara") > 0 Then
                        sCalidad = "CC"
                    Else
                        sCalidad = "FE"
                    End If
                    sb &= sCalidad.PadRight(4) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'MovStock	STRING(1)	Señal 1=Movió mercadería)       0=No movió mercadería)    966)    966
                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'ObsAna	STRING(100)	Observaciones Analisis)    967)    1066


                    sb &= Left(.NumeroCartaDePorte.ToString, 4).PadRight(4) 'Prefijo	STRING(4)	Prefijo de Carta de Porte)    1067)    1070
                    sb &= Left(cadenavacia.ToString, 21).PadRight(21) 'CAU	STRING(21)	CAU de Carta de Porte)    1071)    1091


                    If .IsFechaVencimientoNull Then .FechaVencimiento = Nothing
                    sb &= Convert.ToDateTime(iisValidSqlDate(.FechaVencimiento)).ToString("ddMMyyyy")
                    If .IsFechaIngresoNull Then .FechaIngreso = Nothing
                    sb &= Convert.ToDateTime(iisValidSqlDate(.FechaIngreso)).ToString("ddMMyyyy")
                    'sb &= Left(IIf(.IsFechaVencimientoNull(), cadenavacia, cadenavacia).ToString, 8).PadRight(8) 'Vto	STRING(8)	Fecha Vencimiento de Carta de Porte)    1092)    1099
                    'sb &= Left(IIf(.IsFechaIngresoNull(), cadenavacia, cadenavacia).ToString, 8).PadRight(8) 'Emi	STRING(8)	Fecha de Emisión de Carta de Porte)    1100)    1107


                    If .IsTransportistaCUITNull Then .TransportistaCUIT = ""
                    sb &= Left(.TransportistaCUIT.ToString, 14).PadRight(14, "0") 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118

                    sb &= Left(.TitularCUIT.ToString.Replace("-", ""), 14).PadRight(14) '                CuitTitular	STRING(14)	Cuit Titular Carta de Porte
                    sb &= Left(.TitularDesc.ToString, 30).PadRight(30) 'NomTitular	STRING(30)	Nombre Titular Carta de Porte


                    sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) '                CuitTitular	STRING(14)	Cuit Titular Carta de Porte
                    sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30) 'NomTitular	STRING(30)	Nombre Titular Carta de Porte

                    sb &= Left(.RComercialCUIT.ToString.Replace("-", ""), 14).PadRight(14) '                CuitTitular	STRING(14)	Cuit Titular Carta de Porte
                    sb &= Left(.RComercialDesc.ToString, 30).PadRight(30) 'NomTitular	STRING(30)	Nombre Titular Carta de Porte

                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) '                CuitTitular	STRING(14)	Cuit Titular Carta de Porte
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomTitular	STRING(30)	Nombre Titular Carta de Porte


                    sb &= Int(.SubnumeroVagon).ToString.PadRight(8) 'NumeroVagon 	STRING(8)	Numero de Vagon en caso de que el medio de Tte. Tren


                    'sb = sb.Replace(".", ",") 'solucion cabeza por los decimales



                    'For Each dc In pDataTable.Columns
                    '    If Not IsDBNull(dr(i)) Then
                    '        Try
                    '            If IsNumeric(dr(i)) Then
                    '                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                    '            Else
                    '                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                    '            End If
                    '        Catch x As Exception
                    '            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                    '        End Try
                    '    Else
                    '        sb &= Microsoft.VisualBasic.ControlChars.Tab
                    '    End If
                    '    i += 1
                    'Next






                    PrintLine(nF, sb)
                End With
            Next


            FileClose(nF)


            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function

        Public Shared Function Sincronismo_GranosDelLitoral(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String





            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroGranosDelLitoral " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            'Dim a = pDataTable(1)


            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0




                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular
                    'Corredor Endozo		    ?
                    'Comprador Endozo		    ?
                    'Corredor Vendedor		    ?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""



                    'Aclaraciones:
                    '                NroSuc_E     :  Sucursal interna del Entregador de la entrega o numero de puerto. En todo caso mandar 1
                    'NroOrden_E : Numero de identificación unico de la entrega, junto con la Sucursal. Si no manejan un numero de identificación mandar el numero de CP
                    'Cód_Tipo:       mandar(0)
                    'Contrato        : Contrato del exportador al que fue aplicado en el puerto. Si no lo tienen que venga vacio
                    'NroSucAna   : Los entregadores no lo manejan. Que venga vacio
                    'NroIntAna    : Los entregadores no lo manejan. Que venga vacio


                    '        El formato de cada línea seria entonces del tipo
                    '        a, 1234456789, "Juan Pedro Álvarez", "30752785512    ", 52145


                    sb &= "A"

                    'NroSuc_E	Sucursal Interna	Numérico	4
                    sb &= "," & "1" '.PuntoVenta.ToString.PadLeft(4)


                    'NroOrden_E	Nro Interno de Entrega	Numérico	9
                    sb &= "," & .NumeroCartaDePorte.ToString.PadLeft(9)

                    'Cód_Tipo		Numérico	4
                    sb &= "," & cero.ToString.PadLeft(4)




                    'Contrato		Alfanumérico	20
                    sb &= "," & c(.Contrato.PadLeft(20))

                    'Cod_Merca	Mercaderia	Alfanumérico	20
                    sb &= "," & c(.CodigoSAJPYA.PadLeft(20))

                    'Fecha 8
                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= "," & FechaANSI(iisValidSqlDate(.FechaArribo))







                    'CartadePorte		Numérico	12
                    ForzarPrefijo5(.NumeroCartaDePorte)

                    sb &= "," & .NumeroCartaDePorte.ToString.PadLeft(12)
                    'Recibo		Numérico	12
                    sb &= "," & .NRecibo.ToString.PadLeft(12)


                    '2)	Los kilos brutos deben ser sin la tara y sin descontar las mermas (*) -es decir, el neto (no final)

                    'K Brutos		Numérico	10
                    sb &= "," & .NetoFinal.ToString.PadLeft(10)






                    'sb &= Int(.BrutoFinal).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    'sb &= Int(.TaraFinal).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    'sb &= Int(.NetoFinal).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    'sb &= Int(.Merma + .HumedadDesnormalizada).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655
                    'sb &= Int(.NetoProc).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665


                    '3)	Después de los kilos debería venir el % de humedad, % merma humedad, kilos humedad. Parecería que “% de humedad” y “kilos humedad” están invertidos 

                    'PorcHumedad		Numérico	4,3
                    sb &= "," & String.Format("{0:0.000}", .Humedad).PadLeft(8)
                    'PorcMHum		Numérico	4,3
                    Dim porcmerma = .HumedadDesnormalizada / .NetoFinal * 100
                    sb &= "," & String.Format("{0:0.000}", porcmerma).PadLeft(8)  'este es el porcentaje recalculado que no grabo
                    'KHumedad		Numérico	8
                    sb &= "," & .HumedadDesnormalizada.ToString.PadLeft(8)


                    'PorcZar		Numérico	4,3
                    sb &= "," & cero.ToString.PadLeft(8)
                    'Kg Zarandeo		Numérico	8
                    sb &= "," & cero.ToString.PadLeft(8)
                    'PorcVolatil		Numérico	4,3
                    sb &= "," & cero.ToString.PadLeft(8)
                    'Kg Volátil		Numérico	8
                    sb &= "," & cero.ToString.PadLeft(8)


                    'OtrasMermas		Numérico	8
                    sb &= "," & .Merma.ToString.PadLeft(8)

                    'KNetos		Numérico	10
                    sb &= "," & .NetoProc.ToString.PadLeft(8)
                    'KAplicados		Numérico	10
                    sb &= "," & cero.ToString.PadLeft(8)

                    'Observaciones		Alfanumérico	30
                    sb &= "," & c(.Observaciones.PadLeft(30))


                    'NroSucAna	Nro Interno Suc. Analisis	Numérico	4
                    sb &= "," & cero.ToString.PadLeft(8)
                    'NroIntAna	Nro Interno Analisis	Numérico	9
                    sb &= "," & cero.ToString.PadLeft(8)

                    'Puerto		Numérico	2
                    If .IsDestinoCodigoONCAANull Then .DestinoCodigoONCAA = ""
                    sb &= "," & iisNull(.DestinoCodigoONCAA).PadLeft(2)
                    'Cuit vendedor		Alfanumérico	16
                    sb &= "," & c(.TitularCUIT.PadLeft(16))
                    'Cuit Comprador		Alfanumérico	16
                    sb &= "," & c(.IntermediarioCUIT.PadLeft(16))
                    'Cuit Entregador		Alfanumérico	16
                    sb &= "," & c(.DestinatarioCUIT.PadLeft(16))

                    'Vehículo	1) camion 2) vagon	Numérico	1
                    sb &= "," & IIf(.SubnumeroVagon > 0, 2, 1)
                    'Patente Camion		Alfanumérico	10
                    sb &= "," & c(.Patente.PadLeft(10))
                    'Patente Acoplado		Alfanumérico	10
                    sb &= "," & c(.Acoplado.PadLeft(10))

                    'Fumigada	SI = 1, NO = 0	Numérico	1
                    sb &= "," & "0"
                    'Kg Zar. Gasto		Numérico	8
                    sb &= "," & cero.ToString.PadLeft(8)
                    'Kg Sec. Gasto		Numérico	8
                    sb &= "," & cero.ToString.PadLeft(8)
                    'Kg Aire Frio		Numérico	8
                    sb &= "," & cero.ToString.PadLeft(8)
                    'Kg Fum.Gasto		Numérico	8
                    sb &= "," & cero.ToString.PadLeft(8)


                    'Cuit Chofer		Alfanumérico	16
                    If .IschoferCUITNull Then .choferCUIT = ""
                    sb &= "," & c(.choferCUIT.PadLeft(16))
                    'Cuit Emp.Transp		Alfanumérico	16

                    If .IsTransportistaCUITNull Then .TransportistaCUIT = ""
                    sb &= "," & c(.TransportistaCUIT.PadLeft(16))


                    'CEE		Alfanumérico	14
                    sb &= "," & c(.CEE.PadLeft(14))
                    'Fecha Vto CEE		Fecha	8
                    If .IsFechaVencimientoNull Then .FechaVencimiento = Nothing
                    sb &= "," & FechaANSI(iisValidSqlDate(.FechaVencimiento))


                    'Cuit Intermediario		Alfanumérico	16
                    sb &= "," & c(Left(.IntermediarioCUIT.ToString.Replace("-", ""), 16).PadRight(16))
                    'Cuit REM. Comercial		Alfanumérico	16
                    sb &= "," & c(Left(.RComercialCUIT.ToString.Replace("-", ""), 16).PadRight(16))

                    'Ciudad Origen o CP	Codigo de Ciudad según tabla Oncca o ‘CP’ + el código postal o EST + cód. de establecimiento	Alfanumérico	10
                    sb &= "," & c(.ProcedenciaCodigoPostal.ToString.PadRight(10))
                    'Ciudad Destino o CP	Idem anterior	Alfanumérico	10
                    sb &= "," & c(.DestinoCodigoPostal.ToString.PadRight(10))


                    'Kilos Salidos		Numérico	10
                    sb &= "," & .NetoFinal.ToString.PadRight(10)

                    'Código Vendedor		Numérico	10
                    sb &= "," & cadenavacia.PadRight(10)

                    'Código Comprador		Numérico	10
                    sb &= "," & cadenavacia.PadRight(10)

                    'Código Cosecha		Numérico	4
                    sb &= "," & Right(.Cosecha, 5).Replace("/", "").PadLeft(4)










                    PrintLine(nF, sb)
                End With
            Next


            FileClose(nF)


            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function

        Private Shared Function c(ByVal s As String) As String 'devuelvo la cadena con comillas dobles
            'Return """" & s & """"
            Return _c(s)
        End Function



        Shared Function CodigoArticuloAmaggi(ByVal productoDescripcion As String) As Integer
            '1:                  TRIGO()
            '2:                  MAIZ()
            '3:                  LINO()
            '4:                  AVENA()
            '6:                  CENTENO()
            '7:                  ALPISTE()
            '8:                  GIRASOL()
            '9:                  MIJO()
            '11:                 SORGO(GRANIFERO)
            '12:                 SOJA()
            '15:                 TRIGO(FIDEO)
            '16:                 CEBADA(CERVECERA)
            '17:                 COLZA()
            '18:                 GIRASOL(OLEICO)
            '21:                 CANOLA()
            '25:                 CÁRTAMO()

            If InStr(productoDescripcion, "TRIGO") > 0 Then Return 1
            If InStr(productoDescripcion, "MAIZ") > 0 Then Return 2
            If InStr(productoDescripcion, "LINO") > 0 Then Return 3
            If InStr(productoDescripcion, "AVENA") > 0 Then Return 4
            If InStr(productoDescripcion, "CENTENO") > 0 Then Return 6
            If InStr(productoDescripcion, "ALPISTE") > 0 Then Return 7
            If InStr(productoDescripcion, "GIRASOL") > 0 Then Return 8
            If InStr(productoDescripcion, "MIJO") > 0 Then Return 9
            If InStr(productoDescripcion, "SORGO") > 0 Then Return 11
            If InStr(productoDescripcion, "SOJA") > 0 Then Return 12
            If InStr(productoDescripcion, "FIDEO") > 0 Then Return 15
            If InStr(productoDescripcion, "CEBADA") > 0 Then Return 16
            If InStr(productoDescripcion, "COLZA") > 0 Then Return 17
            If InStr(productoDescripcion, "OLEICO") > 0 Then Return 18
            If InStr(productoDescripcion, "CANOLA") > 0 Then Return 21
            If InStr(productoDescripcion, "CÁRTAMO") > 0 Then Return 25

            Return 0
        End Function


        Public Shared Function Sincronismo_DOW(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String
            Dim vFileName As String = Path.GetTempPath & "SincroDOW " & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net


            'id	    C.Porte	    Arribo	    Hora	Producto	    Contrato	Kg.Proc.    Kg.Bruto Desc.	Kg.Tara Desc.	Kg.Neto Desc.	Kg.Dif.	H.%	Mer.Kg.	Otras	Kg.Netos	Cuit Cargador	Cargador	Corredor	Comprador	cuit vdor. Canje	Vdor.Canje	Cta. Y Ord. 2	Cta. Y Ord. 3	Pat. Chasis	Pat. Acoplado	CUIT Transp.	Trasportista	Cod Oncaa Destino	Destino	Procedcia.	Desc.	Hora	Cal.-Observaciones	Chofer	CUIT chofer	Nro Oncaa	Pta Oncaa	Provincia	CEE	Fecha Emision	Fecha Vto	CTG	Flete Km	Flete Tarifa
            '996484	13803262	01/02/2011		    GIRASOL ALTO OLEICO		    28000	    44860	16790	28070	70	12.8	777	0	27293	30709752053	LAS TRES MARIAS S.R.L.	DIRECTO	30636021578	30709752053	LAS TRES MARIAS S.R.L.			SIU463	SIK586	20-114259609	RAYA OSCAR	12699	FCA.SANTA CLARA	MANDISOVI	01/02/2011	15:20	COND CAMARA - PATRON: 1.4660 MUESTRA: 1.4660	ALBRECH JAVIER	23249679739	0	0		81023210688228	30/01/2011	13/03/2011	63598251	500	140
            '996514	13680080	01/02/2011	 9:08	GIRASOL ALTO OLEICO		    28000	    43700	15100	28600	600	16	1813	0	26787	30708510196	GREGORET ANGEL E HIJOS SH	DIRECTO	30636021578	30708510196	GREGORET ANGEL E HIJOS SH			SSQ343	EJJ104	20-166142394	RAFFINI FABIAN	18461	RECONQUISTA ( PTA BUYATTI	TARTAGAL	01/02/2011	23:40	COND CAMARA - PATRON 1.4699 MUESTRA 1.4686 - PESO ESTIMADO DE PROCEDENCIA	RAFFINI FABIAN	20166142394	0	0	ENTRE RIOS	81016670855188	30/01/2011	05/03/2011	86142262	60	38


            'Dim dt = pDataTable.ToDataTable

            If pDataTable.Rows.Count = 0 Then
                Return ""
            End If

            Dim dt = pDataTable.CopyToDataTable()



            vFileName = DataTableToExcel(dt, vFileName)




            Return vFileName
        End Function



        Public Shared Function Sincronismo_PSALaCalifornia(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String


            'Dado que el sincronismo solicitado para el cliente BLD preveía enviar datos que ya no existen en las Cartas de Porte se solicitó el desarrollo de nuevo del mismo.
            'Ahora, con la estructura que creamos preferente pero incluyendo los datos que se enumera más abajo.
            'Documentar el detalle de la estructura para enviar a la gente de sistemas de BLD.


            'Titular Carta Porte : Nombre y CUIT
            'Intermediario: Nombre y CUIT
            'Remitente Comercial : Nombre y CUIT
            'Corredor : BLD SA ( CUIT 30-70359905-9 )
            'Representante / Entregador: WILLIAMS ENTREGAS SA ( CUIT 30-70738607-6 )
            'Destinatario: Nombre y CUIT
            'Destino : Nombre y CUIT
            'Transportista: Nombre y CUIT
            'Chofer ; Nombre y CUIT
            '            CEE(NRO)
            '            CTG(NRO)
            'Fecha de Carga
            'Fecha de Vencimiento
            '            Contrato()
            'Grano o Producto (Nombre)
            'Código de Grano o Producto
            '            Cosecha()
            'Procedencia; Nombre y CODIGO POSTAL
            'Destino de los Granos: Nombre y CODIGO POSTAL
            '            Patente(Chasis)
            '            Patente(Acoplado)
            'KM a recorrer
            '            Tarifas()
            '            Peso(Bruto(Procedencia))
            'Peso Tara ( \"\"\"\"\"\"\"\"\"\"\"\"\"\")
            'Peso Neto ( \"\"\"\"\"\"\"\"\"\"\"\"\")
            'Fecha de Descarga
            '            Peso(Bruto, (Descarga))
            '            Peso(Tara(Descarga))
            '            Peso(Bruto(Descarga))
            '% Humedad
            'Merma x Humedad
            '            Otras(Mermas)
            'Calidad ; Ej Fuera de Base / Fuera de Estandar etc….
            'Observaciones;


            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroBLD " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            'Dim a = pDataTable(1)


            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0




                    '                    Grano	Texto	1	3	Falta Dato
                    'GranelBolsa	Entero largo	4	3	
                    'Cosecha	Entero largo	7	4	Esta todo en 0 - Falta Dato
                    'FecIng	Fecha/Hora	11	8	No respeta formato DDMMAAAA
                    'HorIng	Texto	19	8	
                    'FechSal	Fecha/Hora	27	8	No respeta formato DDMMAAAA
                    'HorSal	Texto	35	8	
                    'CUITPuerto	Texto	43	14	Falta Dato
                    'NomPuerto	Texto	57	30	No respeta largo dato




                    sb &= .txtCodigoZeni.PadLeft(3) 'Grano	STRING(3)	Código de grano Sagpya)    1)    3
                    sb &= IIf(True, 1, 2).ToString.PadRight(3) 'GranelBolsa	STRING(3)	Embalaje del grano 1=Granel 2=Bolsa)    4)    6

                    sb &= Right(.Cosecha, 5).Replace("/", "").PadLeft(4)


                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= .FechaArribo.ToString("ddMMyyyy")       'FecIng	STRING(8)	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001)    11)    18


                    If .IsHoraNull Then
                        sb &= #12:00:00 AM#.ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    Else
                        sb &= Convert.ToDateTime(.Hora).ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    End If


                    sb &= "  "

                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= .FechaDescarga.ToString("ddMMyyyy")  'FecSal	STRING(8)	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001)    27)    34
                    sb &= Convert.ToDateTime(iisNull(.FechaDescarga, #12:00:00 AM#)).ToString("hhmmss") 'HorSal	STRING(8)	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556)    35)    42


                    sb &= "  "




                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular
                    'Corredor Endozo		    ?
                    'Comprador Endozo		    ?
                    'Corredor Vendedor		    ?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""




                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPuerto	STRING(30)	Nombre Puerto)    57)    86







                    'Titular Carta Porte : Nombre y CUIT
                    'Intermediario: Nombre y CUIT
                    'Remitente Comercial : Nombre y CUIT
                    'Corredor : BLD SA ( CUIT 30-70359905-9 )
                    'Representante / Entregador: WILLIAMS ENTREGAS SA ( CUIT 30-70738607-6 )
                    'Destinatario: Nombre y CUIT

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130

                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

                    '///////////////////////////////////////////////////
                    ' acá va BLD S.A.                      30707386076
                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218
                    '////////////////////////////////////////////////////

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130

                    '////////////////////////////////////////////////////////////////////////////////
                    'Strongly Typed DataSets encountering NULL values – Grrrrrr… 
                    'http://social.msdn.microsoft.com/forums/en-US/winformsdatacontrols/thread/1dad8d0d-6eae-4254-a9d6-22d50da5578a
                    '////////////////////////////////////////////////////////////////////////////////

                    'If .IsClienteFacturadoCUITNull Then .ClienteFacturadoCUIT = ""
                    'sb &= Left(.ClienteFacturadoCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCargador	STRING(14)	CUIT Cargador)    263)    276
                    'If .IsClienteFacturadoNull Then .ClienteFacturado = ""
                    'sb &= Left(.ClienteFacturado.ToString, 30).PadRight(30) 'NomCargador 	STRING(30)	Nombre Cargador)    277)    306

                    sb &= Left(.RComercialCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                    sb &= Left(.RComercialDesc.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350



                    'NomEntregador()                    'Williams(Entregas)
                    ' NomCorrComp()                    'BLD()
                    ' NomComprador()                    ' Destinatario()
                    'NomVendedor()                    'Acá va el Rte Comercial, si no hay RteCom va el Titular
                    'NomCorrEndo()                    'No se manda
                    'NomCompEndo()                    'No se manda
                    'NomCorrVend()                    'No se manda



                    sb &= Left(.TitularCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                    sb &= Left(.TitularDesc.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350

                    sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrEndo	STRING(14)	CUIT  Corredor Endozo)    351)    364
                    sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30) 'NomCorrEndo	STRING(30)	Nombre Corredor Endozo)    365)    394


                    sb &= Left(.RComercialCUIT.ToString, 14).PadRight(14) 'CUITCompEndo	STRING(14)	CUIT Comprador Endozo)    395)    408
                    sb &= Left(.RComercialDesc.ToString, 30).PadRight(30) 'NomCompEndo	STRING(30)	Nombre Comprador Endozo)    409)    438




                    'Titular Carta Porte : Nombre y CUIT
                    'Intermediario: Nombre y CUIT
                    'Remitente Comercial : Nombre y CUIT
                    'Corredor : BLD SA ( CUIT 30-70359905-9 )
                    'Representante / Entregador: WILLIAMS ENTREGAS SA ( CUIT 30-70738607-6 )
                    'Destinatario: Nombre y CUIT




                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrVend	STRING(14)	CUIT Corredor Vendedor.)    439)    452
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomCorrVend	STRING(30)	Nombre Corredor Vendedor)    453)    482

                    sb &= Left(cadenavacia.ToString, 14).PadRight(14) 'CUITPlantaOrigen	STRING(14)	CUIT Planta Origen)    483)    496
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPlantaOrigen	STRING(30)	Nombre Planta Origen)    497)    526





                    'CPProcede	Texto	527	8	Falta Dato
                    'NomProcede	Texto	535	30	Falta Dato
                    'CPDestino	Texto	565	8	
                    'NomDestino	Texto	573	30	
                    'CodMovIE	Texto	603	1	


                    sb &= Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
                    sb &= Left(.ProcedenciaDesc.ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
                    sb &= Left(.DestinoCodigoPostal.ToString, 8).PadRight(8) 'CPDestino	STRING(8)	Código Postal Destino)    565)    572
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602



                    sb &= IIf(True, 1, 0).ToString.PadRight(1) 'CodMovIE	STRING(1)	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr)    603)    603
                    sb &= Left(.Patente.ToString, 6).PadRight(6) 'PatCha	STRING(6)	Patente chasis)    604)    609
                    sb &= Left(.Acoplado.ToString, 6).PadRight(6) 'PatAcoplado	STRING(6)	Acoplado chasis)    610)    615



                    sb &= Int(.NetoPto).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= Int(.TaraPto).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= Int(.BrutoPto).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    sb &= Int(.Merma).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655


                    sb &= Int(.NetoFinal).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665


                    sb &= String.Format("{0:F1}", .Humedad).PadLeft(10) 'PorHume	STRING(10)	Porcentaje humedad (un (1) decimal))    666)    675
                    sb &= cero.ToString.PadLeft(10) 'PorMemaHumedad	STRING(10)	Porcentaje merma humedad (dos (2) decimales))    676)    685
                    sb &= Int(.Merma).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695
                    sb &= Left(cero.ToString, 10).PadLeft(10) 'PBonHume	STRING(10)	Porcentaje bonificación humedad (dos (2) decimales))    696)    705
                    sb &= Left(cero.ToString, 10).PadLeft(10) 'KgsBonHu	STRING(10)	Kilos bonificación humedad)    706)    715




                    'esto?
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorZaran	STRING(10)	Porcentaje zarandeo (dos (2) decimales))    716)    725
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsZaran	STRING(10)	Kilos zarandeo (sin decimales))    726)    735
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorDesca	STRING(10)	Porcentaje descarte (dos (2) decimales))    736)    745
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsDesca	STRING(10)	Kilogramos Descarte (Sin Decimales))    746)    755
                    sb &= Left(Val(cadenavacia).ToString, 10).PadLeft(10) 'PorVolat	STRING(10)	Porcentaje volátil (dos (2) decimales))    756)    765
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsVolat	STRING(10)	Kilogramos volátil (sin decimales))    766)    775



                    sb &= Left(cadenavacia.ToString, 8).PadLeft(8) 'CantBolsa	STRING(8)	Cantidad de bolsas)    776)    783
                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'Fumigada	STRING(1)	Condición fumigada 0=no 1=si)    784)    784



                    sb &= Int(.NetoProc).ToString.PadRight(10) 'PesoProcede	STRING(10)	Peso procedencia (Sin Decimales))    785)    794
                    sb &= Int(.BrutoPto).ToString.PadRight(10) 'BrutoProcede	STRING(10)	Bruto procedencia (Sin Decimales))    795)    804
                    sb &= Int(.TaraPto).ToString.PadRight(10) 'TaraProcede	STRING(10)	Tara procedencia (Sin Decimales))    805)    814



                    sb &= Left(.Contrato.ToString, 12).PadRight(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826
                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= Left(.NumeroCartaDePorte.ToString, 14).PadRight(14) 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840
                    sb &= IIf(True, "c", "v").ToString.PadRight(1) 'TipoTrans	STRING(1)	Tipo de transporte c=camión  v=vagón o=Otro)    841)    841


                    sb &= Left(Int(.NobleGrado).ToString, 10).PadLeft(10) 'Grado	STRING(10)	Grado)    842)    851
                    sb &= Left(Int(.Factor).ToString, 10).PadLeft(10) 'Factor	STRING(10)	Factor)    852)    861

                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'Observac	STRING(100)	Observaciones)    862)    961


                    'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)
                    Dim sCalidad As String
                    If InStr(.Calidad.ToString.ToLower, "grado 1") > 0 Then
                        sCalidad = "G1"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 2") > 0 Then
                        sCalidad = "G2"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 3") > 0 Then
                        sCalidad = "G3"
                    ElseIf InStr(.Calidad.ToString.ToLower, "camara") > 0 Then
                        sCalidad = "CC"
                    Else
                        sCalidad = "FE"
                    End If
                    sb &= sCalidad.PadRight(4) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'MovStock	STRING(1)	Señal 1=Movió mercadería)       0=No movió mercadería)    966)    966
                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'ObsAna	STRING(100)	Observaciones Analisis)    967)    1066


                    sb &= Left(.NumeroCartaDePorte.ToString, 4).PadRight(4) 'Prefijo	STRING(4)	Prefijo de Carta de Porte)    1067)    1070
                    sb &= Left(.CEE.ToString, 21).PadRight(21) 'CAU	STRING(21)	CAU de Carta de Porte)    1071)    1091

                    If .IsFechaVencimientoNull Then .FechaVencimiento = Nothing
                    sb &= .FechaVencimiento.ToString("ddMMyyyy")                        '  Vto	STRING(8)	Fecha Vencimiento de Carta de Porte)    1092)    1099
                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= .FechaArribo.ToString("ddMMyyyy")     'Emi	STRING(8)	Fecha de Emisión de Carta de Porte)    1100)    1107

                    If .IsTransportistaCUITNull Then .TransportistaCUIT = ""
                    sb &= Left(.TransportistaCUIT.ToString, 14).Replace("-", "").PadRight(14) 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118

                    If .IschoferCUITNull Then .choferCUIT = ""
                    sb &= Left(.choferCUIT.ToString, 14).Replace("-", "").PadRight(14) 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118

                    sb &= Left(.CTG.ToString, 10).PadRight(10, "0") 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118

                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    'FALTA QUE NOS DIGAN QUE SON ESTOS 25 CARACTERES
                    'sb &= String.Empty.PadRight(25)
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////

                    'If .IsCalidadDeNull Then .CalidadDe = Nothing
                    'sb &= Left(iisNull(.CalidadDe).ToString, 3).PadLeft(3, " ") 'IdCalidad que les estoy pasando a los de BLD


                    'sb = sb.Replace(".", ",") 'solucion cabeza por los decimales



                    'For Each dc In pDataTable.Columns
                    '    If Not IsDBNull(dr(i)) Then
                    '        Try
                    '            If IsNumeric(dr(i)) Then
                    '                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                    '            Else
                    '                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                    '            End If
                    '        Catch x As Exception
                    '            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                    '        End Try
                    '    Else
                    '        sb &= Microsoft.VisualBasic.ControlChars.Tab
                    '    End If
                    '    i += 1
                    'Next






                    PrintLine(nF, sb)
                End With
            Next


            FileClose(nF)


            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function

        'Public Shared Function Sincronismo_BLD(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String
        'el sincro BLD se hace usando un excel. ---> ExcelToCSV_SincroBLD

        '    'Dado que el sincronismo solicitado para el cliente BLD preveía enviar datos que ya no existen en las Cartas de Porte se solicitó el desarrollo de nuevo del mismo.
        '    'Ahora, con la estructura que creamos preferente pero incluyendo los datos que se enumera más abajo.
        '    'Documentar el detalle de la estructura para enviar a la gente de sistemas de BLD.


        '    'Titular Carta Porte : Nombre y CUIT
        '    'Intermediario: Nombre y CUIT
        '    'Remitente Comercial : Nombre y CUIT
        '    'Corredor : BLD SA ( CUIT 30-70359905-9 )
        '    'Representante / Entregador: WILLIAMS ENTREGAS SA ( CUIT 30-70738607-6 )
        '    'Destinatario: Nombre y CUIT
        '    'Destino : Nombre y CUIT
        '    'Transportista: Nombre y CUIT
        '    'Chofer ; Nombre y CUIT
        '    '            CEE(NRO)
        '    '            CTG(NRO)
        '    'Fecha de Carga
        '    'Fecha de Vencimiento
        '    '            Contrato()
        '    'Grano o Producto (Nombre)
        '    'Código de Grano o Producto
        '    '            Cosecha()
        '    'Procedencia; Nombre y CODIGO POSTAL
        '    'Destino de los Granos: Nombre y CODIGO POSTAL
        '    '            Patente(Chasis)
        '    '            Patente(Acoplado)
        '    'KM a recorrer
        '    '            Tarifas()
        '    '            Peso(Bruto(Procedencia))
        '    'Peso Tara ( \"\"\"\"\"\"\"\"\"\"\"\"\"\")
        '    'Peso Neto ( \"\"\"\"\"\"\"\"\"\"\"\"\")
        '    'Fecha de Descarga
        '    '            Peso(Bruto, (Descarga))
        '    '            Peso(Tara(Descarga))
        '    '            Peso(Bruto(Descarga))
        '    '% Humedad
        '    'Merma x Humedad
        '    '            Otras(Mermas)
        '    'Calidad ; Ej Fuera de Base / Fuera de Estandar etc….
        '    'Observaciones;


        '    'Dim vFileName As String = Path.GetTempFileName() & ".txt"
        '    Dim vFileName As String = Path.GetTempPath & "SincroBLD " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        '    'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

        '    'Dim vFileName As String = "c:\archivo.txt"
        '    Dim nF = FreeFile()

        '    FileOpen(nF, vFileName, OpenMode.Output)
        '    Dim sb As String = ""
        '    Dim dc As DataColumn
        '    For Each dc In pDataTable.Columns
        '        sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
        '    Next
        '    'PrintLine(nF, sb) 'encabezado
        '    Dim i As Integer = 0
        '    Dim dr As DataRow


        '    'Dim a = pDataTable(1)


        '    'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
        '    For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
        '        With cdp

        '            i = 0 : sb = ""

        '            Dim cero = 0




        '            '                    Grano	Texto	1	3	Falta Dato
        '            'GranelBolsa	Entero largo	4	3	
        '            'Cosecha	Entero largo	7	4	Esta todo en 0 - Falta Dato
        '            'FecIng	Fecha/Hora	11	8	No respeta formato DDMMAAAA
        '            'HorIng	Texto	19	8	
        '            'FechSal	Fecha/Hora	27	8	No respeta formato DDMMAAAA
        '            'HorSal	Texto	35	8	
        '            'CUITPuerto	Texto	43	14	Falta Dato
        '            'NomPuerto	Texto	57	30	No respeta largo dato




        '            sb &= .txtCodigoZeni.PadLeft(3) 'Grano	STRING(3)	Código de grano Sagpya)    1)    3
        '            sb &= IIf(True, 1, 2).ToString.PadRight(3) 'GranelBolsa	STRING(3)	Embalaje del grano 1=Granel 2=Bolsa)    4)    6

        '            sb &= Right(.Cosecha, 5).Replace("/", "").PadLeft(4)


        '            If .IsFechaArriboNull Then .FechaArribo = Nothing
        '            sb &= .FechaArribo.ToString("ddMMyyyy")       'FecIng	STRING(8)	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001)    11)    18


        '            If .IsHoraNull Then
        '                sb &= #12:00:00 AM#.ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
        '            Else
        '                sb &= Convert.ToDateTime(.Hora).ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
        '            End If


        '            sb &= "  "

        '            If .IsFechaDescargaNull Then .FechaDescarga = Nothing
        '            sb &= .FechaDescarga.ToString("ddMMyyyy")  'FecSal	STRING(8)	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001)    27)    34
        '            sb &= Convert.ToDateTime(iisNull(.FechaDescarga, #12:00:00 AM#)).ToString("hhmmss") 'HorSal	STRING(8)	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556)    35)    42


        '            sb &= "  "




        '            'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
        '            '------------------------------------------
        '            'Puerto					    Destino
        '            'Recibidor				    WILLIAMS SA
        '            'Comprador				    Destinatario		
        '            'Corredor Comprador		    Corredor
        '            'Entregador				    Destinatario
        '            'Cargador				    (este es a quien se le facturó)
        '            'Vendedor				    Titular
        '            'Corredor Endozo		    ?
        '            'Comprador Endozo		    ?
        '            'Corredor Vendedor		    ?
        '            'Planta Origen			    ?
        '            'Procedencia 			    Origen
        '            'Destino 				    Destino

        '            Dim wily = "Williams Entregas S.A."
        '            Dim wilycuit = "30707386076"
        '            Dim cadenavacia As String = ""




        '            sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56
        '            sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPuerto	STRING(30)	Nombre Puerto)    57)    86







        '            'Titular Carta Porte : Nombre y CUIT
        '            'Intermediario: Nombre y CUIT
        '            'Remitente Comercial : Nombre y CUIT
        '            'Corredor : BLD SA ( CUIT 30-70359905-9 )
        '            'Representante / Entregador: WILLIAMS ENTREGAS SA ( CUIT 30-70738607-6 )
        '            'Destinatario: Nombre y CUIT

        '            sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
        '            sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130

        '            sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
        '            sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

        '            '///////////////////////////////////////////////////
        '            ' acá va BLD S.A.                      30707386076
        '            sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
        '            sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218
        '            '////////////////////////////////////////////////////

        '            sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
        '            sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130

        '            '////////////////////////////////////////////////////////////////////////////////
        '            'Strongly Typed DataSets encountering NULL values – Grrrrrr… 
        '            'http://social.msdn.microsoft.com/forums/en-US/winformsdatacontrols/thread/1dad8d0d-6eae-4254-a9d6-22d50da5578a
        '            '////////////////////////////////////////////////////////////////////////////////

        '            'If .IsClienteFacturadoCUITNull Then .ClienteFacturadoCUIT = ""
        '            'sb &= Left(.ClienteFacturadoCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCargador	STRING(14)	CUIT Cargador)    263)    276
        '            'If .IsClienteFacturadoNull Then .ClienteFacturado = ""
        '            'sb &= Left(.ClienteFacturado.ToString, 30).PadRight(30) 'NomCargador 	STRING(30)	Nombre Cargador)    277)    306

        '            sb &= Left(.RComercialCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
        '            sb &= Left(.RComercialDesc.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350



        '            'NomEntregador()                    'Williams(Entregas)
        '            ' NomCorrComp()                    'BLD()
        '            ' NomComprador()                    ' Destinatario()
        '            'NomVendedor()                    'Acá va el Rte Comercial, si no hay RteCom va el Titular
        '            'NomCorrEndo()                    'No se manda
        '            'NomCompEndo()                    'No se manda
        '            'NomCorrVend()                    'No se manda



        '            sb &= Left(.TitularCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
        '            sb &= Left(.TitularDesc.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350

        '            sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrEndo	STRING(14)	CUIT  Corredor Endozo)    351)    364
        '            sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30) 'NomCorrEndo	STRING(30)	Nombre Corredor Endozo)    365)    394


        '            sb &= Left(.RComercialCUIT.ToString, 14).PadRight(14) 'CUITCompEndo	STRING(14)	CUIT Comprador Endozo)    395)    408
        '            sb &= Left(.RComercialDesc.ToString, 30).PadRight(30) 'NomCompEndo	STRING(30)	Nombre Comprador Endozo)    409)    438




        '            'Titular Carta Porte : Nombre y CUIT
        '            'Intermediario: Nombre y CUIT
        '            'Remitente Comercial : Nombre y CUIT
        '            'Corredor : BLD SA ( CUIT 30-70359905-9 )
        '            'Representante / Entregador: WILLIAMS ENTREGAS SA ( CUIT 30-70738607-6 )
        '            'Destinatario: Nombre y CUIT




        '            sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrVend	STRING(14)	CUIT Corredor Vendedor.)    439)    452
        '            sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomCorrVend	STRING(30)	Nombre Corredor Vendedor)    453)    482

        '            sb &= Left(cadenavacia.ToString, 14).PadRight(14) 'CUITPlantaOrigen	STRING(14)	CUIT Planta Origen)    483)    496
        '            sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPlantaOrigen	STRING(30)	Nombre Planta Origen)    497)    526





        '            'CPProcede	Texto	527	8	Falta Dato
        '            'NomProcede	Texto	535	30	Falta Dato
        '            'CPDestino	Texto	565	8	
        '            'NomDestino	Texto	573	30	
        '            'CodMovIE	Texto	603	1	


        '            sb &= Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
        '            sb &= Left(.ProcedenciaDesc.ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
        '            sb &= Left(.DestinoCodigoPostal.ToString, 8).PadRight(8) 'CPDestino	STRING(8)	Código Postal Destino)    565)    572
        '            sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602



        '            sb &= IIf(True, 1, 0).ToString.PadRight(1) 'CodMovIE	STRING(1)	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr)    603)    603
        '            sb &= Left(.Patente.ToString, 6).PadRight(6) 'PatCha	STRING(6)	Patente chasis)    604)    609
        '            sb &= Left(.Acoplado.ToString, 6).PadRight(6) 'PatAcoplado	STRING(6)	Acoplado chasis)    610)    615



        '            sb &= Int(.NetoPto).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
        '            sb &= Int(.TaraPto).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
        '            sb &= Int(.BrutoPto).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
        '            sb &= Int(.Merma).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655


        '            sb &= Int(.NetoFinal).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665


        '            sb &= String.Format("{0:F1}", .Humedad).PadLeft(10) 'PorHume	STRING(10)	Porcentaje humedad (un (1) decimal))    666)    675
        '            sb &= cero.ToString.PadLeft(10) 'PorMemaHumedad	STRING(10)	Porcentaje merma humedad (dos (2) decimales))    676)    685
        '            sb &= Int(.Merma).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695
        '            sb &= Left(cero.ToString, 10).PadLeft(10) 'PBonHume	STRING(10)	Porcentaje bonificación humedad (dos (2) decimales))    696)    705
        '            sb &= Left(cero.ToString, 10).PadLeft(10) 'KgsBonHu	STRING(10)	Kilos bonificación humedad)    706)    715




        '            'esto?
        '            sb &= cadenavacia.ToString.PadLeft(10) 'PorZaran	STRING(10)	Porcentaje zarandeo (dos (2) decimales))    716)    725
        '            sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsZaran	STRING(10)	Kilos zarandeo (sin decimales))    726)    735
        '            sb &= cadenavacia.ToString.PadLeft(10) 'PorDesca	STRING(10)	Porcentaje descarte (dos (2) decimales))    736)    745
        '            sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsDesca	STRING(10)	Kilogramos Descarte (Sin Decimales))    746)    755
        '            sb &= Left(Val(cadenavacia).ToString, 10).PadLeft(10) 'PorVolat	STRING(10)	Porcentaje volátil (dos (2) decimales))    756)    765
        '            sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsVolat	STRING(10)	Kilogramos volátil (sin decimales))    766)    775



        '            sb &= Left(cadenavacia.ToString, 8).PadLeft(8) 'CantBolsa	STRING(8)	Cantidad de bolsas)    776)    783
        '            sb &= IIf(True, 0, 1).ToString.PadRight(1) 'Fumigada	STRING(1)	Condición fumigada 0=no 1=si)    784)    784



        '            sb &= Int(.NetoProc).ToString.PadRight(10) 'PesoProcede	STRING(10)	Peso procedencia (Sin Decimales))    785)    794
        '            sb &= Int(.BrutoPto).ToString.PadRight(10) 'BrutoProcede	STRING(10)	Bruto procedencia (Sin Decimales))    795)    804
        '            sb &= Int(.TaraPto).ToString.PadRight(10) 'TaraProcede	STRING(10)	Tara procedencia (Sin Decimales))    805)    814



        '            sb &= Left(.Contrato.ToString, 12).PadRight(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826
        '            ForzarPrefijo5(.NumeroCartaDePorte)
        '            sb &= Left(.NumeroCartaDePorte.ToString, 14).PadRight(14) 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840
        '            sb &= IIf(True, "c", "v").ToString.PadRight(1) 'TipoTrans	STRING(1)	Tipo de transporte c=camión  v=vagón o=Otro)    841)    841


        '            sb &= Left(Int(.NobleGrado).ToString, 10).PadLeft(10) 'Grado	STRING(10)	Grado)    842)    851
        '            sb &= Left(Int(.Factor).ToString, 10).PadLeft(10) 'Factor	STRING(10)	Factor)    852)    861

        '            sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'Observac	STRING(100)	Observaciones)    862)    961


        '            'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)
        '            Dim sCalidad As String
        '            If InStr(.Calidad.ToString.ToLower, "grado 1") > 0 Then
        '                sCalidad = "G1"
        '            ElseIf InStr(.Calidad.ToString.ToLower, "grado 2") > 0 Then
        '                sCalidad = "G2"
        '            ElseIf InStr(.Calidad.ToString.ToLower, "grado 3") > 0 Then
        '                sCalidad = "G3"
        '            ElseIf InStr(.Calidad.ToString.ToLower, "camara") > 0 Then
        '                sCalidad = "CC"
        '            Else
        '                sCalidad = "FE"
        '            End If
        '            sb &= sCalidad.PadRight(4) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



        '            sb &= IIf(True, 0, 1).ToString.PadRight(1) 'MovStock	STRING(1)	Señal 1=Movió mercadería)       0=No movió mercadería)    966)    966
        '            sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'ObsAna	STRING(100)	Observaciones Analisis)    967)    1066


        '            sb &= Left(.NumeroCartaDePorte.ToString, 4).PadRight(4) 'Prefijo	STRING(4)	Prefijo de Carta de Porte)    1067)    1070
        '            sb &= Left(.CEE.ToString, 21).PadRight(21) 'CAU	STRING(21)	CAU de Carta de Porte)    1071)    1091

        '            If .IsFechaVencimientoNull Then .FechaVencimiento = Nothing
        '            sb &= .FechaVencimiento.ToString("ddMMyyyy")                        '  Vto	STRING(8)	Fecha Vencimiento de Carta de Porte)    1092)    1099
        '            If .IsFechaArriboNull Then .FechaArribo = Nothing
        '            sb &= .FechaArribo.ToString("ddMMyyyy")     'Emi	STRING(8)	Fecha de Emisión de Carta de Porte)    1100)    1107

        '            If .IsTransportistaCUITNull Then .TransportistaCUIT = ""
        '            sb &= Left(.TransportistaCUIT.ToString, 14).Replace("-", "").PadRight(14) 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118

        '            If .IschoferCUITNull Then .choferCUIT = ""
        '            sb &= Left(.choferCUIT.ToString, 14).Replace("-", "").PadRight(14) 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118

        '            sb &= Left(.CTG.ToString, 10).PadRight(10, "0") 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118

        '            '//////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////
        '            'FALTA QUE NOS DIGAN QUE SON ESTOS 25 CARACTERES
        '            'sb &= String.Empty.PadRight(25)
        '            '//////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////
        '            '//////////////////////////////////////////////////////////////////

        '            'If .IsCalidadDeNull Then .CalidadDe = Nothing
        '            'sb &= Left(iisNull(.CalidadDe).ToString, 3).PadLeft(3, " ") 'IdCalidad que les estoy pasando a los de BLD


        '            'sb = sb.Replace(".", ",") 'solucion cabeza por los decimales



        '            'For Each dc In pDataTable.Columns
        '            '    If Not IsDBNull(dr(i)) Then
        '            '        Try
        '            '            If IsNumeric(dr(i)) Then
        '            '                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
        '            '            Else
        '            '                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
        '            '            End If
        '            '        Catch x As Exception
        '            '            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
        '            '        End Try
        '            '    Else
        '            '        sb &= Microsoft.VisualBasic.ControlChars.Tab
        '            '    End If
        '            '    i += 1
        '            'Next






        '            PrintLine(nF, sb)
        '        End With
        '    Next


        '    FileClose(nF)


        '    Return vFileName
        '    'Return TextToExcel(vFileName, titulo)
        'End Function

        Public Shared Function Sincronismo_SyngentaOBSOLETO(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String



            '            Orden	Nombre	Long.	Descripción	Requerido	Justificacion	Posicion
            '1	Grano	3	Código de grano Sagpya	*	Izquierda	1
            '2	GranelBolsa	3	Embalaje del grano 1=Granel 2=Bolsa	*	Derecha	4
            '3	Cosecha	4	Cosecha 2000-2001 Ej: 0001	*	Izquierda	7
            '4	FecIng	8	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001	*	Izquierda	11
            '5	HorIng	8	Hora de entrada del camión Formato (HHMISS) ej:092556	*	Izquierda	19
            '6	FecSal	8	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001	*	Izquierda	27
            '7	HorSal	8	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556	*	Izquierda	35
            '8	CUITPuerto	14	CUIT PUERTO	*	Izquierda	43
            '9	NomPuerto	30	Nombre Puerto	*	Izquierda	57
            '10	CUITRecibidor	14	CUIT Recibidor	*	Izquierda	87
            '11	NomRecibidor	30	Nombre Recibidor	*	Izquierda	101
            '12	CUITComprador	14	CUIT Comprador	*	Izquierda	131
            '13	NomComp	30	Nombre Comprador	*	Izquierda	145
            '14	CUITCorrComp	14	CUIT Corredor Comprador	*	Izquierda	175
            '15	NomCorrComp	30	Nombre Corredor Comprador	*	Izquierda	189
            '16	CUITEntregador	14	CUIT Entregador	*	Izquierda	219
            '17	NomEntregador	30	Nombre Entregador	*	Izquierda	233
            '18	CUITCargador	14	CUIT Cargador	*	Izquierda	263
            '19	NomCargador	30	Nombre Cargador	*	Izquierda	277
            '20	CUITVendedor	14	CUIT Vendedor	*	Izquierda	307
            '21	NomVendedor	30	Nombre Vendedor	*	Izquierda	321
            '22	CUITCorrEndo	14	CUIT  Corredor Endozo		Izquierda	351
            '23	NomCorrEndo	30	Nombre Corredor Endozo		Izquierda	365
            '24	CUITCompEndo	14	CUIT Comprador Endozo		Izquierda	395
            '25	NomCompEndo	30	Nombre Comprador Endozo		Izquierda	409
            '26	CUITCorrVend	14	CUIT Corredor Vendedor.	*	Izquierda	439
            '27	NomCorrVend	30	Nombre Corredor Vendedor	*	Izquierda	453
            '28	CUITPlantaOrigen	14	CUIT Planta Origen	*	Izquierda	483
            '29	NomPlantaOrigen	30	Nombre Planta Origen	*	Izquierda	497
            '30	CPPorcede	8	Código Postal Procedencia	*	Izquierda	527
            '31	NomProcede	30	Nombre Procedencia	*	Izquierda	535
            '32	CPDestino	8	Código Postal Destino	*	Izquierda	565
            '33	NomDestino	30	Nombre Destino	*	Izquierda	573
            '34	CodMovIE	1	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr	*	Derecha	603
            '35	PatCha	10	Patente chasis		Izquierda	604
            '36	PesoBrut	10	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.	*	Derecha	614
            '37	PesoEgre	10	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales	*	Derecha	624
            '38	PesoNeto	10	Total bruto(PesoBrut-PesoEgre) (sin decimales)	*	Derecha	634
            '39	TotMerm	10	Total mermas (Total mermas sin decimales)		Derecha	644
            '40	TotNeto	10	Total neto ((Camión cargado – Tara)- Total mermas) (sin decimales)	*	Derecha	654
            '41	PorHume	10	Porcentaje humedad (un (1) decimal)		Derecha	664
            '42	PorMemaHumedad	10	Porcentaje merma humedad (dos (2) decimales)		Derecha	674
            '43	KgsHume	10	Kilos humedad (sin decimales)		Derecha	684
            '44	PBonHume	10	Porcentaje bonificación humedad (dos (2) decimales)		Derecha	694
            '45	KgsBonHu	10	Kilos bonificación humedad		Derecha	704
            '46	PorZaran	10	Porcentaje zarandeo (dos (2) decimales)		Derecha	714
            '47	KgsZaran	10	Kilos zarandeo (sin decimales)		Derecha	724
            '48	PorDesca	10	Porcentaje descarte (dos (2) decimales)		Derecha	734
            '49	KgsDesca	10	Kilogramos Descarte (Sin Decimales)		Derecha	744
            '50	PorVolat	10	Porcentaje volátil (dos (2) decimales)		Derecha	754
            '51	KgsVolat	10	Kilogramos volátil (sin decimales)		Derecha	764
            '52	CantBolsa	8	Cantidad de bolsas		Derecha	774
            '53	Fumigada	1	Condición fumigada 0=no 1=si	*	Derecha	782
            '54	PesoProcede	10	Peso procedencia (Sin Decimales)		Derecha	783
            '55	Contrato	12	Número de contrato  (Numeros 0 al 9)		Derecha	793
            '56	CarPorte	14	Número de Carta de Porte (Numeros  0 al 9)	*	Derecha	805
            '57	TipoTrans	1	Tipo de transporte c=camión  v=vagón o=Otro	*	Izquierda	819
            '58	Grado	10	Grado	*	Derecha	820
            '59	Factor	10	Factor	*	Derecha	830
            '60	Observac	100	Observaciones		Izquierda	840
            '61	ConCalidad	4	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o                       Fuera de standart (FE)	*	Izquierda	940
            '62	MovStock	1	Señal 1=Movió mercadería       0=No movió mercadería	*	Izquierda	944
            '63	ObsAna	100	Observaciones Analisis		Izquierda	945


            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroSyngenta " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            'Dim a = pDataTable(1)


            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0




                    '                    Grano	Texto	1	3	Falta Dato
                    'GranelBolsa	Entero largo	4	3	
                    'Cosecha	Entero largo	7	4	Esta todo en 0 - Falta Dato
                    'FecIng	Fecha/Hora	11	8	No respeta formato DDMMAAAA
                    'HorIng	Texto	19	8	
                    'FechSal	Fecha/Hora	27	8	No respeta formato DDMMAAAA
                    'HorSal	Texto	35	8	
                    'CUITPuerto	Texto	43	14	Falta Dato
                    'NomPuerto	Texto	57	30	No respeta largo dato



                    sb &= .CodigoSAJPYA.PadRight(3) 'Grano	STRING(3)	Código de grano Sagpya)    1)    3
                    sb &= IIf(True, 1, 2).ToString.PadRight(3) 'GranelBolsa	STRING(3)	Embalaje del grano 1=Granel 2=Bolsa)    4)    6

                    sb &= Right(.Cosecha, 5).Replace("/", "").PadLeft(4)


                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= .FechaArribo.ToString("ddMMyyyy")       'FecIng	STRING(8)	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001)    11)    18


                    If .IsHoraNull Then
                        sb &= #12:00:00 AM#.ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    Else
                        sb &= Convert.ToDateTime(.Hora).ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    End If


                    sb &= "  "

                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= .FechaDescarga.ToString("ddMMyyyy")  'FecSal	STRING(8)	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001)    27)    34
                    sb &= Convert.ToDateTime(iisNull(.FechaDescarga, #12:00:00 AM#)).ToString("hhmmss") 'HorSal	STRING(8)	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556)    35)    42


                    sb &= "  "




                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular
                    'Corredor Endozo		    ?
                    'Comprador Endozo		    ?
                    'Corredor Vendedor		    ?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""




                    'Comentan que en los siguientes campos se debe mandar (en los 
                    'tres campos) el Intermediario y en 
                    ' caso que no haya Intermediario, en los tres casos el Titular: NomCargador NomCompEndo NomVendedor 
                    If .IntermediarioCUIT = "" Then
                        .IntermediarioCUIT = .TitularCUIT
                        .IntermediarioDesc = .TitularDesc
                    Else
                        Debug.Print(.IntermediarioCUIT)
                    End If







                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPuerto	STRING(30)	Nombre Puerto)    57)    86

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130

                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

                    '///////////////////////////////////////////////////
                    ' acá va BLD S.A.                      30707386076
                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218
                    '////////////////////////////////////////////////////

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Entregador
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomEntregador	STRING(30)	Nombre Entregador)   

                    '////////////////////////////////////////////////////////////////////////////////
                    'Strongly Typed DataSets encountering NULL values – Grrrrrr… 
                    'http://social.msdn.microsoft.com/forums/en-US/winformsdatacontrols/thread/1dad8d0d-6eae-4254-a9d6-22d50da5578a
                    '////////////////////////////////////////////////////////////////////////////////




                    sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCargador	STRING(14)	CUIT Cargador)    263)  
                    sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30)   'NomCargador 	STRING(30)	Nombre Cargador)    277)    306


                    'en "Vendedor" les pasaba el RemComercial. Pidieron que les pasemos el titular por acá (se filtró usando "SYNGENTA" en RemComercial, y
                    ' y parece que no les gustó que apareciera SYNGENTA en el sincro
                    sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                    sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350




                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrEndo	STRING(14)	CUIT  Corredor Endozo)    351)    364
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrEndo	STRING(30)	Nombre Corredor Endozo)    365)    394




                    sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCompEndo	STRING(14)	CUIT Comprador Endozo)    395)    408
                    sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30) 'NomCompEndo	STRING(30)	Nombre Comprador Endozo)    409)    438


                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrVend	STRING(14)	CUIT Corredor Vendedor.)    439)    452
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrVend	STRING(30)	Nombre Corredor Vendedor)    453)    482


                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPlantaOrigen	STRING(14)	CUIT Planta Origen)    483)    496
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPlantaOrigen	STRING(30)	Nombre Planta Origen)    497)    526



                    'CPProcede	Texto	527	8	Falta Dato
                    'NomProcede	Texto	535	30	Falta Dato
                    'CPDestino	Texto	565	8	
                    'NomDestino	Texto	573	30	
                    'CodMovIE	Texto	603	1	


                    sb &= Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
                    sb &= Left(.ProcedenciaDesc.ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
                    sb &= Left(.DestinoCodigoPostal.ToString, 8).PadRight(8) 'CPDestino	STRING(8)	Código Postal Destino)    565)    572
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602





                    sb &= IIf(True, 1, 0).ToString.PadRight(1) 'CodMovIE	STRING(1)	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr)    603)    603
                    sb &= Left(.Patente.ToString, 6).PadRight(10) 'PatCha	STRING(6)	Patente chasis)    604)    609
                    'sb &= Left(.Acoplado.ToString, 6).PadRight(6) 'PatAcoplado	STRING(6)	Acoplado chasis)    610)    615




                    '36	PesoBrut	10	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.	*	Derecha	614
                    '37	PesoEgre	10	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales	*	Derecha	624
                    '38	PesoNeto	10	Total bruto(PesoBrut-PesoEgre) (sin decimales)	*	Derecha	634
                    '39	TotMerm	10	Total mermas (Total mermas sin decimales)		Derecha	644

                    sb &= Int(.NetoPto).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= Int(.TaraPto).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= Int(.BrutoPto).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    sb &= Int(.Merma).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655


                    '40	TotNeto	10	Total neto ((Camión cargado – Tara)- Total mermas) (sin decimales)	*	Derecha	654


                    sb &= Int(.NetoFinal).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665

                    '41	PorHume	10	Porcentaje humedad (un (1) decimal)		Derecha	664
                    '42	PorMemaHumedad	10	Porcentaje merma humedad (dos (2) decimales)		Derecha	674
                    '43	KgsHume	10	Kilos humedad (sin decimales)		Derecha	684
                    '44	PBonHume	10	Porcentaje bonificación humedad (dos (2) decimales)		Derecha	694
                    '45	KgsBonHu	10	Kilos bonificación humedad		Derecha	704

                    sb &= String.Format("{0:F1}", .Humedad).PadLeft(10) 'PorHume	STRING(10)	Porcentaje humedad (un (1) decimal))    666)    675
                    sb &= cero.ToString.PadLeft(10) 'PorMemaHumedad	STRING(10)	Porcentaje merma humedad (dos (2) decimales))    676)    685
                    sb &= Int(.Merma).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695
                    sb &= Left(cero.ToString, 10).PadLeft(10) 'PBonHume	STRING(10)	Porcentaje bonificación humedad (dos (2) decimales))    696)    705
                    sb &= Left(cero.ToString, 10).PadLeft(10) 'KgsBonHu	STRING(10)	Kilos bonificación humedad)    706)    715



                    '46	PorZaran	10	Porcentaje zarandeo (dos (2) decimales)		Derecha	714
                    '47	KgsZaran	10	Kilos zarandeo (sin decimales)		Derecha	724
                    '48	PorDesca	10	Porcentaje descarte (dos (2) decimales)		Derecha	734
                    '49	KgsDesca	10	Kilogramos Descarte (Sin Decimales)		Derecha	744
                    '50	PorVolat	10	Porcentaje volátil (dos (2) decimales)		Derecha	754
                    '51	KgsVolat	10	Kilogramos volátil (sin decimales)		Derecha	764


                    'esto?
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorZaran	STRING(10)	Porcentaje zarandeo (dos (2) decimales))    716)    725
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsZaran	STRING(10)	Kilos zarandeo (sin decimales))    726)    735
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorDesca	STRING(10)	Porcentaje descarte (dos (2) decimales))    736)    745
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsDesca	STRING(10)	Kilogramos Descarte (Sin Decimales))    746)    755
                    sb &= Left(Val(cadenavacia).ToString, 10).PadLeft(10) 'PorVolat	STRING(10)	Porcentaje volátil (dos (2) decimales))    756)    765
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsVolat	STRING(10)	Kilogramos volátil (sin decimales))    766)    775




                    '52	CantBolsa	8	Cantidad de bolsas		Derecha	774
                    '53	Fumigada	1	Condición fumigada 0=no 1=si	*	Derecha	782
                    '54	PesoProcede	10	Peso procedencia (Sin Decimales)		Derecha	783
                    '55	Contrato	12	Número de contrato  (Numeros 0 al 9)		Derecha	793
                    '56	CarPorte	14	Número de Carta de Porte (Numeros  0 al 9)	*	Derecha	805




                    '57	TipoTrans	1	Tipo de transporte c=camión  v=vagón o=Otro	*	Izquierda	819
                    '58	Grado	10	Grado	*	Derecha	820
                    '59	Factor	10	Factor	*	Derecha	830
                    '60	Observac	100	Observaciones		Izquierda	840
                    '61	ConCalidad	4	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o                       Fuera de standart (FE)	*	Izquierda	940
                    '62	MovStock	1	Señal 1=Movió mercadería       0=No movió mercadería	*	Izquierda	944
                    '63	ObsAna	100	Observaciones Analisis		Izquierda	945



                    sb &= Left(cadenavacia.ToString, 8).PadLeft(8) 'CantBolsa	STRING(8)	Cantidad de bolsas)    776)    783
                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'Fumigada	STRING(1)	Condición fumigada 0=no 1=si)    784)    784



                    sb &= Int(.NetoProc).ToString.PadRight(10) 'PesoProcede	STRING(10)	Peso procedencia (Sin Decimales))    785)    794
                    'sb &= Int(.BrutoPto).ToString.PadRight(10) 'BrutoProcede	STRING(10)	Bruto procedencia (Sin Decimales))    795)    804
                    'sb &= Int(.TaraPto).ToString.PadRight(10) 'TaraProcede	STRING(10)	Tara procedencia (Sin Decimales))    805)    814



                    sb &= Left(Val(.Contrato).ToString, 12).PadRight(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826
                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= Left(.NumeroCartaDePorte.ToString, 14).PadLeft(14, "0") 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840
                    sb &= IIf(True, "c", "v").ToString.PadRight(1) 'TipoTrans	STRING(1)	Tipo de transporte c=camión  v=vagón o=Otro)    841)    841


                    If .IsNobleGradoNull Then .NobleGrado = 0
                    sb &= Left(Int(.NobleGrado).ToString, 10).PadLeft(10) 'Grado	STRING(10)	Grado)    842)    851
                    If .IsFactorNull Then .Factor = 0
                    sb &= Left(Int(.Factor).ToString, 10).PadLeft(10) 'Factor	STRING(10)	Factor)    852)    861

                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'Observac	STRING(100)	Observaciones)    862)    961


                    'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)
                    Dim sCalidad As String
                    If .IsCalidadNull Then .Calidad = ""
                    If InStr(.Calidad.ToString.ToLower, "grado 1") > 0 Then
                        sCalidad = "G1"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 2") > 0 Then
                        sCalidad = "G2"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 3") > 0 Then
                        sCalidad = "G3"
                    ElseIf InStr(.Calidad.ToString.ToLower, "camara") > 0 Then
                        sCalidad = "CC"
                    Else
                        sCalidad = "FE"
                    End If
                    sb &= sCalidad.PadRight(4) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'MovStock	STRING(1)	Señal 1=Movió mercadería)       0=No movió mercadería)    966)    966
                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'ObsAna	STRING(100)	Observaciones Analisis)    967)    1066







                    PrintLine(nF, sb)
                End With
            Next


            FileClose(nF)


            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function

        Public Shared Function Sincronismo_Syngenta(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, ByVal titulo As String, ByVal sWHERE As String, ByRef sErrores As String, ByVal SC As String) As String



            '            Orden	Nombre	Long.	Descripción	Requerido	Justificacion	Posicion
            '1	Grano	3	Código de grano Sagpya	*	Izquierda	1
            '2	GranelBolsa	3	Embalaje del grano 1=Granel 2=Bolsa	*	Derecha	4
            '3	Cosecha	4	Cosecha 2000-2001 Ej: 0001	*	Izquierda	7
            '4	FecIng	8	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001	*	Izquierda	11
            '5	HorIng	8	Hora de entrada del camión Formato (HHMISS) ej:092556	*	Izquierda	19
            '6	FecSal	8	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001	*	Izquierda	27
            '7	HorSal	8	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556	*	Izquierda	35
            '8	CUITPuerto	14	CUIT PUERTO	*	Izquierda	43
            '9	NomPuerto	30	Nombre Puerto	*	Izquierda	57
            '10	CUITRecibidor	14	CUIT Recibidor	*	Izquierda	87
            '11	NomRecibidor	30	Nombre Recibidor	*	Izquierda	101
            '12	CUITComprador	14	CUIT Comprador	*	Izquierda	131
            '13	NomComp	30	Nombre Comprador	*	Izquierda	145
            '14	CUITCorrComp	14	CUIT Corredor Comprador	*	Izquierda	175
            '15	NomCorrComp	30	Nombre Corredor Comprador	*	Izquierda	189
            '16	CUITEntregador	14	CUIT Entregador	*	Izquierda	219
            '17	NomEntregador	30	Nombre Entregador	*	Izquierda	233
            '18	CUITCargador	14	CUIT Cargador	*	Izquierda	263
            '19	NomCargador	30	Nombre Cargador	*	Izquierda	277
            '20	CUITVendedor	14	CUIT Vendedor	*	Izquierda	307
            '21	NomVendedor	30	Nombre Vendedor	*	Izquierda	321
            '22	CUITCorrEndo	14	CUIT  Corredor Endozo		Izquierda	351
            '23	NomCorrEndo	30	Nombre Corredor Endozo		Izquierda	365
            '24	CUITCompEndo	14	CUIT Comprador Endozo		Izquierda	395
            '25	NomCompEndo	30	Nombre Comprador Endozo		Izquierda	409
            '26	CUITCorrVend	14	CUIT Corredor Vendedor.	*	Izquierda	439
            '27	NomCorrVend	30	Nombre Corredor Vendedor	*	Izquierda	453
            '28	CUITPlantaOrigen	14	CUIT Planta Origen	*	Izquierda	483
            '29	NomPlantaOrigen	30	Nombre Planta Origen	*	Izquierda	497
            '30	CPPorcede	8	Código Postal Procedencia	*	Izquierda	527
            '31	NomProcede	30	Nombre Procedencia	*	Izquierda	535
            '32	CPDestino	8	Código Postal Destino	*	Izquierda	565
            '33	NomDestino	30	Nombre Destino	*	Izquierda	573
            '34	CodMovIE	1	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr	*	Derecha	603
            '35	PatCha	10	Patente chasis		Izquierda	604
            '36	PesoBrut	10	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.	*	Derecha	614
            '37	PesoEgre	10	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales	*	Derecha	624
            '38	PesoNeto	10	Total bruto(PesoBrut-PesoEgre) (sin decimales)	*	Derecha	634
            '39	TotMerm	10	Total mermas (Total mermas sin decimales)		Derecha	644
            '40	TotNeto	10	Total neto ((Camión cargado – Tara)- Total mermas) (sin decimales)	*	Derecha	654
            '41	PorHume	10	Porcentaje humedad (un (1) decimal)		Derecha	664
            '42	PorMemaHumedad	10	Porcentaje merma humedad (dos (2) decimales)		Derecha	674
            '43	KgsHume	10	Kilos humedad (sin decimales)		Derecha	684
            '44	PBonHume	10	Porcentaje bonificación humedad (dos (2) decimales)		Derecha	694
            '45	KgsBonHu	10	Kilos bonificación humedad		Derecha	704
            '46	PorZaran	10	Porcentaje zarandeo (dos (2) decimales)		Derecha	714
            '47	KgsZaran	10	Kilos zarandeo (sin decimales)		Derecha	724
            '48	PorDesca	10	Porcentaje descarte (dos (2) decimales)		Derecha	734
            '49	KgsDesca	10	Kilogramos Descarte (Sin Decimales)		Derecha	744
            '50	PorVolat	10	Porcentaje volátil (dos (2) decimales)		Derecha	754
            '51	KgsVolat	10	Kilogramos volátil (sin decimales)		Derecha	764
            '52	CantBolsa	8	Cantidad de bolsas		Derecha	774
            '53	Fumigada	1	Condición fumigada 0=no 1=si	*	Derecha	782
            '54	PesoProcede	10	Peso procedencia (Sin Decimales)		Derecha	783
            '55	Contrato	12	Número de contrato  (Numeros 0 al 9)		Derecha	793
            '56	CarPorte	14	Número de Carta de Porte (Numeros  0 al 9)	*	Derecha	805
            '57	TipoTrans	1	Tipo de transporte c=camión  v=vagón o=Otro	*	Izquierda	819
            '58	Grado	10	Grado	*	Derecha	820
            '59	Factor	10	Factor	*	Derecha	830
            '60	Observac	100	Observaciones		Izquierda	840
            '61	ConCalidad	4	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o                       Fuera de standart (FE)	*	Izquierda	940
            '62	MovStock	1	Señal 1=Movió mercadería       0=No movió mercadería	*	Izquierda	944
            '63	ObsAna	100	Observaciones Analisis		Izquierda	945

            Dim sErroresProcedencia, sErroresDestinos, sErroresOtros As String

            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroSyngenta " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            'Dim a = pDataTable(1)


            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0




                    '                    Grano	Texto	1	3	Falta Dato
                    'GranelBolsa	Entero largo	4	3	
                    'Cosecha	Entero largo	7	4	Esta todo en 0 - Falta Dato
                    'FecIng	Fecha/Hora	11	8	No respeta formato DDMMAAAA
                    'HorIng	Texto	19	8	
                    'FechSal	Fecha/Hora	27	8	No respeta formato DDMMAAAA
                    'HorSal	Texto	35	8	
                    'CUITPuerto	Texto	43	14	Falta Dato
                    'NomPuerto	Texto	57	30	No respeta largo dato



                    sb &= .CodigoSAJPYA.PadRight(3) 'Grano	STRING(3)	Código de grano Sagpya)    1)    3
                    sb &= IIf(True, 1, 2).ToString.PadRight(3) 'GranelBolsa	STRING(3)	Embalaje del grano 1=Granel 2=Bolsa)    4)    6

                    sb &= Right(.Cosecha, 5).Replace("/", "").PadLeft(4)


                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= .FechaArribo.ToString("ddMMyyyy")       'FecIng	STRING(8)	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001)    11)    18


                    If .IsHoraNull Then
                        sb &= #12:00:00 AM#.ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    Else
                        sb &= Convert.ToDateTime(.Hora).ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    End If


                    sb &= "  "

                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= .FechaDescarga.ToString("ddMMyyyy")  'FecSal	STRING(8)	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001)    27)    34
                    sb &= Convert.ToDateTime(iisNull(.FechaDescarga, #12:00:00 AM#)).ToString("hhmmss") 'HorSal	STRING(8)	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556)    35)    42


                    sb &= "  "




                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular  'Acá va el Rte Comercial, si no hay RteCom va el Titular
                    'Corredor Endozo		    ?'No se manda?
                    'Comprador Endozo		    ?'No se manda?
                    'Corredor Vendedor		    ?'No se manda?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    'https://mail.google.com/mail/u/0/#search/amaggi/13795391d0a49a8d
                    ' Me llaman de Williams para ver si podemos ver un tema con el sincro Amaggi que les esta saliendo con un error (Carta de Porte del ejemplo: 525174646) mañana lo vemos

                    'Lucas, si los datos están bien cargados se está confeccionando mal el TXT y las cuentas no vienen donde corresponden.
                    'Desconozco los datos de la CP original para que Andrés sepa dónde está el problema.

                    'Por lo que me dijo Juan Pablo, estos datos vienen mal:
                    'Viene comprador BUNGE
                    'Cargador, vendedor y comp endoso: Amaggi





                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""



                    '/////////////////////////////////////////////////////////////////////////////////////////////////////////

                    'Comentan que en los siguientes campos se debe mandar (en los 
                    'tres campos) el Intermediario y en 
                    ' caso que no haya Intermediario, en los tres casos el Titular: NomCargador NomCompEndo NomVendedor 
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8740


                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8740
                    Dim VendedorCUIT, VendedorDesc As String
                    Dim CompradorCUIT, CompradorDesc As String
                    ' If InStr(.RComercialDesc, "AMAGGI") > 0 Then Stop

                    'If .RComercialDesc <> "" And InStr(.RComercialDesc, "AMAGGI") = 0 Then
                    '    VendedorCUIT = .RComercialCUIT
                    '    VendedorDesc = .RComercialDesc
                    'ElseIf .IntermediarioDesc <> "" Then
                    '    VendedorCUIT = .IntermediarioCUIT
                    '    VendedorDesc = .IntermediarioDesc
                    'Else
                    '    VendedorCUIT = .TitularCUIT
                    '    VendedorDesc = .TitularDesc
                    'End If


                    '////////////////////////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////////////////////////

                    'http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=12781
                    'NUESTRO SISTEMA SOLO RECIBE EL CUIT DEL COMPRADOR Y EL CUIT DEL VENDEDOR, LOS 
                    'DATOS DE INTERMEDIARIO Y REMITENTE NO DEBEN INFORMASE.

                    If .RComercialDesc <> "" And InStr(.RComercialDesc, "SYNGENTA") = 0 Then
                        '                    Caso 1
                        'Titular:            PRODUCTOR()
                        'Intermediario: ----------
                        'Rte.comercial() : SYNGENTA()
                        'Destinatario:       EXPORTADOR()

                        'Se informa en:
                        'Vendedor:           PRODUCTOR()
                        'Comprador:          EXPORTADOR()

                        VendedorCUIT = .TitularCUIT
                        VendedorDesc = .TitularDesc

                        CompradorCUIT = .DestinatarioCUIT
                        CompradorDesc = .DestinatarioDesc

                    ElseIf .IntermediarioDesc <> "" And InStr(.IntermediarioDesc, "SYNGENTA") = 0 Then
                        'Caso 2

                        '                    Caso 2
                        'Titular:            PRODUCTOR()
                        'Intermediario:      SYNGENTA()
                        'Rte.comercial() : CLIENTE()
                        'Destinatario:       EXPORTADOR()

                        'Se informa en:
                        'Vendedor:           PRODUCTOR()
                        'Comprador:          CLIENTE()

                        VendedorCUIT = .TitularCUIT
                        VendedorDesc = .TitularDesc

                        CompradorCUIT = .RComercialCUIT
                        CompradorDesc = .RComercialDesc
                    ElseIf .DestinatarioDesc <> "" And InStr(.DestinatarioDesc, "SYNGENTA") = 0 Then
                        'caso 3
                        '                    Caso 3
                        'Titular:            PRODUCTOR()
                        'Intermediario:
                        'Rte.comercial()
                        'Destinatario:       SYNGENTA()

                        'Se informa en:
                        'Vendedor:           PRODUCTOR()
                        'Comprador:          SYNGENTA()

                        VendedorCUIT = .TitularCUIT
                        VendedorDesc = .TitularDesc

                        CompradorCUIT = .DestinatarioCUIT
                        CompradorDesc = .DestinatarioDesc
                    Else
                        VendedorCUIT = .TitularCUIT
                        VendedorDesc = .TitularDesc

                        CompradorCUIT = .DestinatarioCUIT
                        CompradorDesc = .DestinatarioDesc
                    End If





                    'http://bdlconsultores.sytes.net/Consultas/Admin/VerConsultas1.php?recordid=12905
                    '                    Para emitir el sincro syngenta es obligatorio que estén cargados los siguientes campos en todas las cartas de porte emitidas:
                    '                    CTG()
                    '                    CEE()
                    'Fecha de Vencimiento CEE
                    '                    A esto hay que agregarle lo siguiente:
                    'Si la carta tiene corredor DIRECTO, enviar en vez del corredor, el corredor obs

                    If .CTG = 0 Then
                        sErroresOtros &= "<a href=""CartaDePorte.aspx?Id=" & .IdCartaDePorte & """ target=""_blank"">" & .NumeroCartaDePorte & " falta el CTG</a>; <br/>"
                    End If


                    If .CEE = "" Or .IsFechaVencimientoNull Then
                        sErroresOtros &= "<a href=""CartaDePorte.aspx?Id=" & .IdCartaDePorte & """ target=""_blank"">" & .NumeroCartaDePorte & " falta el CEE o Vencimiento</a>; <br/>"
                    End If






                    '[OutOfMemoryException: Exception of type 'System.OutOfMemoryException' was thrown.]
                    '   System.Data.Common.DecimalStorage.SetCapacity(Int32 capacity) +22
                    '   System.Data.RecordManager.set_RecordCapacity(Int32 value) +77
                    '                    System.Data.RecordManager.GrowRecordCapacity(+52)
                    '                    System.Data.RecordManager.NewRecordBase(+34)
                    '   System.Data.DataTable.NewRecord(Int32 sourceRecord) +23
                    '                    System.Data.DataRow.BeginEditInternal(+4817531)
                    '   System.Data.DataRow.set_Item(DataColumn column, Object value) +244
                    '   wCartasDePorte_TX_InformesCorregidoRow.set_IntermediarioCUIT(String Value) in C:\Backup\BDL\BussinessLogic\WillyInformesDataSet7.Designer.vb:4427
                    '   Pronto.ERP.Bll.SincronismosWilliamsManager.Sincronismo_AmaggiDescargas(wCartasDePorte_TX_InformesCorregidoDataTable pDataTable, String titulo, String sWHERE, String& sErrores) +1699
                    '   CartaDePorteInformesConReportViewerSincronismos.btnDescargaSincro_Click(Object sender, EventArgs e) +5006
                    '   System.Web.UI.WebControls.Button.OnClick(EventArgs e) +111
                    '   System.Web.UI.WebControls.Button.RaisePostBackEvent(String eventArgument) +110
                    '   System.Web.UI.WebControls.Button.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument) +10
                    '   System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument) +13
                    '   System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData) +36
                    '   System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint) +1565

                    If .IntermediarioCUIT = "" Then
                        .IntermediarioCUIT = .TitularCUIT
                        .IntermediarioDesc = .TitularDesc
                    Else
                        Debug.Print(.IntermediarioCUIT)
                    End If



                    Try

                        If .TitularDesc.Trim() = "DIRECTO" Then
                            .TitularDesc = ""
                            .TitularCUIT = ""
                        End If

                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try
                        If .IntermediarioDesc.Trim() = "DIRECTO" Then
                            .IntermediarioDesc = ""
                            .IntermediarioCUIT = ""
                        End If
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try
                        If .RComercialDesc.Trim() = "DIRECTO" Then
                            .RComercialDesc = ""
                            .RComercialCUIT = ""
                        End If
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try


                    Try
                        If .CorredorDesc.Trim() = "DIRECTO" Then

                            'http://bdlconsultores.sytes.net/Consultas/Admin/VerConsultas1.php?recordid=12905

                            '                    A esto hay que agregarle lo siguiente:
                            'Si la carta tiene corredor DIRECTO, enviar en vez del corredor, el corredor obs
                            If .Corredor2 > 0 Then
                                .CorredorDesc = NombreVendedor(SC, .Corredor2)
                                .CorredorCUIT = ClienteManager.GetItem(SC, BuscaIdClientePreciso(.CorredorDesc, SC)).Cuit
                            Else
                                .CorredorDesc = ""
                                .CorredorCUIT = ""
                            End If
                        End If

                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try




                    Try

                        If .DestinatarioDesc.Trim() = "DIRECTO" Then
                            .DestinatarioDesc = ""
                            .DestinatarioCUIT = ""
                        End If

                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try




                    '                CUITPUERTO	43	56
                    'NOMPUERTO	57	86
                    'CUITRECIBIDOR	87	100
                    'NOMRECIBIDOR	101	130
                    'CUITCOMPRADOR	131	144
                    'NOMCOMP	145	174
                    'CUITCORRCOMP	175	188
                    'NOMCORRCOMP	189	218
                    'CUITENTREGADOR	219	232
                    'NOMENTREGADOR	233	262
                    'CUITCARGADOR	307	320
                    'NOMCARGADOR	321	350
                    'CUITVENDEDOR	263	276
                    'NOMVENDEDOR	277	306
                    'CUITCORRENDO	351	364
                    'NOMCORRENDO	365	394
                    'CUITCOMPENDO	395	408
                    'NOMCOMPENDO	409	438
                    'CUITCORRVEND	439	452
                    'NOMCORRVEND	453	482
                    'CUITPLANTAORIGEN	483	496
                    'NOMPLANTAORIGEN	497	526
                    'CPPROCEDE	527	534
                    'NOMPROCEDE	535	564
                    'CPDESTINO	565	572
                    'NOMDESTINO	573	602
                    'CODMOVIE	603	603




                    sb &= Left(.DestinoCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPuerto	STRING(30)	Nombre Puerto)    57)    86

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130

                    sb &= Left(CompradorCUIT.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                    sb &= Left(CompradorDesc, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

                    '///////////////////////////////////////////////////
                    ' acá va BLD S.A.                      30707386076
                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218
                    '////////////////////////////////////////////////////

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Entregador
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomEntregador	STRING(30)	Nombre Entregador)   

                    '////////////////////////////////////////////////////////////////////////////////
                    'Strongly Typed DataSets encountering NULL values – Grrrrrr… 
                    'http://social.msdn.microsoft.com/forums/en-US/winformsdatacontrols/thread/1dad8d0d-6eae-4254-a9d6-22d50da5578a
                    '////////////////////////////////////////////////////////////////////////////////



                    'en "Vendedor" les pasaba el RemComercial. Pidieron que les pasemos el titular por acá 
                    '                    (se filtró usando "SYNGENTA" en RemComercial, y
                    ' y parece que no les gustó que apareciera SYNGENTA en el sincro
                    sb &= Left(VendedorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                    sb &= Left(VendedorDesc.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350


                    sb &= Left(.TitularCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCargador	STRING(14)	CUIT Cargador)    263)  
                    sb &= Left(.TitularDesc.ToString, 30).PadRight(30)   'NomCargador 	STRING(30)	Nombre Cargador)    277)    306






                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrEndo	STRING(14)	CUIT  Corredor Endozo)    351)    364
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrEndo	STRING(30)	Nombre Corredor Endozo)    365)    394




                    sb &= Left(VendedorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCompEndo	STRING(14)	CUIT Comprador Endozo)    395)    408
                    sb &= Left(VendedorDesc.ToString, 30).PadRight(30) 'NomCompEndo	STRING(30)	Nombre Comprador Endozo)    409)    438


                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrVend	STRING(14)	CUIT Corredor Vendedor.)    439)    452
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrVend	STRING(30)	Nombre Corredor Vendedor)    453)    482


                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPlantaOrigen	STRING(14)	CUIT Planta Origen)    483)    496
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPlantaOrigen	STRING(30)	Nombre Planta Origen)    497)    526



                    'CPProcede	Texto	527	8	Falta Dato
                    'NomProcede	Texto	535	30	Falta Dato
                    'CPDestino	Texto	565	8	
                    'NomDestino	Texto	573	30	
                    'CodMovIE	Texto	603	1	


                    sb &= Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
                    sb &= Left(.ProcedenciaDesc.ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
                    sb &= Left(.DestinoCodigoPostal.ToString, 8).PadRight(8) 'CPDestino	STRING(8)	Código Postal Destino)    565)    572
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602




                    'Viene un 1 en el TXT, deben enviar un 0.
                    sb &= IIf(False, 1, 0).ToString.PadRight(1) 'CodMovIE	STRING(1)	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr)    603)    603
                    sb &= Left(.Patente.ToString, 6).PadRight(10) 'PatCha	STRING(6)	Patente chasis)    604)    609
                    'sb &= Left(.Acoplado.ToString, 6).PadRight(6) 'PatAcoplado	STRING(6)	Acoplado chasis)    610)    615




                    '36	PesoBrut	10	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.	*	Derecha	614
                    '37	PesoEgre	10	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales	*	Derecha	624
                    '38	PesoNeto	10	Total bruto(PesoBrut-PesoEgre) (sin decimales)	*	Derecha	634
                    '39	TotMerm	10	Total mermas (Total mermas sin decimales)		Derecha	644



                    'https://mail.google.com/mail/#label/Sincros/136a3190360d2620
                    'En la posición 36 que es PESOBRUT va el bruto real del camión. Lo que pesó en destino.
                    'En la posición 37 que es PESOEGRE va la tara real del camión. Lo que pesó en destino.
                    'En la posición 38 que es PESONETO va el PESOBRUT – PESOEGRE
                    'En la posición 40 que es TOTNETO va el neto final, es decir el PESONETO – el total de mermas. Por lo que vos me ponés, aca irían los 29860 kls. Los kilos procedencia por el momento no serian importante.


                    '.BrutoPto
                    '.TaraPto
                    '.NetoPto
                    '.BrutoFinal
                    '.TaraFinal
                    '.NetoFinal
                    '.NetoProc

                    sb &= Int(.BrutoFinal).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= Int(.TaraFinal).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= Int(.NetoFinal).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    sb &= Int(.NetoFinal - .NetoProc).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655


                    '40	TotNeto	10	Total neto ((Camión cargado – Tara)- Total mermas) (sin decimales)	*	Derecha	654

                    sb &= Int(.NetoProc).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665







                    '41	PorHume	10	Porcentaje humedad (un (1) decimal)		Derecha	664
                    '42	PorMemaHumedad	10	Porcentaje merma humedad (dos (2) decimales)		Derecha	674
                    '43	KgsHume	10	Kilos humedad (sin decimales)		Derecha	684
                    '44	PBonHume	10	Porcentaje bonificación humedad (dos (2) decimales)		Derecha	694
                    '45	KgsBonHu	10	Kilos bonificación humedad		Derecha	704

                    sb &= String.Format("{0:F1}", .Humedad).PadLeft(10) 'PorHume	STRING(10)	Porcentaje humedad (un (1) decimal))    666)    675
                    sb &= cero.ToString.PadLeft(10) 'PorMemaHumedad	STRING(10)	Porcentaje merma humedad (dos (2) decimales))    676)    685
                    sb &= Int(.HumedadDesnormalizada).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695
                    sb &= Left(cero.ToString, 10).PadLeft(10) 'PBonHume	STRING(10)	Porcentaje bonificación humedad (dos (2) decimales))    696)    705
                    sb &= Left(cero.ToString, 10).PadLeft(10) 'KgsBonHu	STRING(10)	Kilos bonificación humedad)    706)    715



                    '46	PorZaran	10	Porcentaje zarandeo (dos (2) decimales)		Derecha	714
                    '47	KgsZaran	10	Kilos zarandeo (sin decimales)		Derecha	724
                    '48	PorDesca	10	Porcentaje descarte (dos (2) decimales)		Derecha	734
                    '49	KgsDesca	10	Kilogramos Descarte (Sin Decimales)		Derecha	744
                    '50	PorVolat	10	Porcentaje volátil (dos (2) decimales)		Derecha	754
                    '51	KgsVolat	10	Kilogramos volátil (sin decimales)		Derecha	764


                    'esto?
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorZaran	STRING(10)	Porcentaje zarandeo (dos (2) decimales))    716)    725
                    sb &= Int(Val(.Merma)).ToString.PadLeft(10) 'KgsZaran	STRING(10)	Kilos zarandeo (sin decimales))    726)    735
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorDesca	STRING(10)	Porcentaje descarte (dos (2) decimales))    736)    745
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsDesca	STRING(10)	Kilogramos Descarte (Sin Decimales))    746)    755
                    sb &= Left(Val(cadenavacia).ToString, 10).PadLeft(10) 'PorVolat	STRING(10)	Porcentaje volátil (dos (2) decimales))    756)    765
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsVolat	STRING(10)	Kilogramos volátil (sin decimales))    766)    775




                    '52	CantBolsa	8	Cantidad de bolsas		Derecha	774
                    '53	Fumigada	1	Condición fumigada 0=no 1=si	*	Derecha	782
                    '54	PesoProcede	10	Peso procedencia (Sin Decimales)		Derecha	783
                    '55	Contrato	12	Número de contrato  (Numeros 0 al 9)		Derecha	793
                    '56	CarPorte	14	Número de Carta de Porte (Numeros  0 al 9)	*	Derecha	805




                    '57	TipoTrans	1	Tipo de transporte c=camión  v=vagón o=Otro	*	Izquierda	819
                    '58	Grado	10	Grado	*	Derecha	820
                    '59	Factor	10	Factor	*	Derecha	830
                    '60	Observac	100	Observaciones		Izquierda	840
                    '61	ConCalidad	4	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o                       Fuera de standart (FE)	*	Izquierda	940
                    '62	MovStock	1	Señal 1=Movió mercadería       0=No movió mercadería	*	Izquierda	944
                    '63	ObsAna	100	Observaciones Analisis		Izquierda	945



                    sb &= Left(cadenavacia.ToString, 8).PadLeft(8) 'CantBolsa	STRING(8)	Cantidad de bolsas)    776)    783
                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'Fumigada	STRING(1)	Condición fumigada 0=no 1=si)    784)    784



                    sb &= Int(.NetoProc).ToString.PadRight(10) 'PesoProcede	STRING(10)	Peso procedencia (Sin Decimales))    785)    794
                    'sb &= Int(.BrutoPto).ToString.PadRight(10) 'BrutoProcede	STRING(10)	Bruto procedencia (Sin Decimales))    795)    804
                    'sb &= Int(.TaraPto).ToString.PadRight(10) 'TaraProcede	STRING(10)	Tara procedencia (Sin Decimales))    805)    814





                    sb &= Left(Val(.Contrato).ToString, 12).PadRight(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826
                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= Left(.NumeroCartaDePorte.ToString, 14).PadLeft(14, "0") 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840


                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    'EN LOS CASOS DE VAGONES
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8740
                    '/////////////////////////////////////////////////////////////////////////////////////

                    'Col Nombre Desde Hasta Dato
                    'campo decisivo:
                    '57	TIPOTRANS	819	 819	 S         'Venga una F que indica Ferroviario. por defecto viene A, que es Automotor.
                    sb &= IIf(.SubnumeroVagon > 0, "F", "A").ToString.PadRight(1) 'TipoTrans	STRING(1)	Tipo de transporte c=camión  v=vagón o=Otro)    841)    841

                    'aclaracion de otros campos:
                    '56	CARPORTE	805	 818	 N       'Nro de Carta de Porte, este numero al ser ferroviario porque el TIPOTRANS asi lo indica va a permitir que ingrese duplicada.
                    '79	NUMVAGON	1260	 1270 N      'Numero de Vagon, este nro debe ser el que identifique a cada vagon y logicamente no puede repetirse.
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////







                    sb &= Left(Int(.NobleGrado).ToString, 10).PadLeft(10) 'Grado	STRING(10)	Grado)    842)    851
                    sb &= Left(Int(.Factor).ToString, 10).PadLeft(10) 'Factor	STRING(10)	Factor)    852)    861

                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'Observac	STRING(100)	Observaciones)    862)    961


                    'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)
                    Dim sCalidad As String

                    Try
                        If InStr(.CalidadDesc.ToString.ToLower, "conforme") > 0 Then
                            sCalidad = "CO"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 1") > 0 Then
                            sCalidad = "G1"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 2") > 0 Then
                            sCalidad = "G2"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 3") > 0 Then
                            sCalidad = "G3"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "camara") > 0 Then
                            sCalidad = "CC"
                        Else
                            sCalidad = "FE"
                        End If
                    Catch ex As Exception
                        ErrHandler.WriteError("Sincro amaggi")
                        ErrHandler.WriteError(ex)
                    End Try
                    If .IsCalidadDescNull Then sCalidad = "FE"
                    sb &= sCalidad.PadRight(4) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'MovStock	STRING(1)	Señal 1=Movió mercadería)       0=No movió mercadería)    966)    966
                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'ObsAna	STRING(100)	Observaciones Analisis)    967)    1066








                    '68	DOCUME	1045	1055	S
                    sb &= JustificadoIzquierda(If(.IschoferCUITNull, "", .choferCUIT.Replace("-", "")), 11)





                    '66	CTATRANSPOR	1056	1066	N
                    sb &= JustificadoIzquierda(If(.IsTransportistaCUITNull, "", .TransportistaCUIT.Replace("-", "")), 11)



                    '/////////////////////////////////////////
                    'ensartado
                    '35	PATCHA	1067	1072	S    
                    sb &= JustificadoIzquierda(If(.IsPatenteNull, "", .Patente), 6)
                    '//////////////////////////////////////////

                    '69	PATACO	1073	1078	S
                    sb &= JustificadoIzquierda(If(.IsAcopladoNull, "", .Acoplado), 6)




                    sb &= Space(12)



                    '67	NOMCONDUC	1091	1120	S
                    sb &= JustificadoIzquierda(If(.IsChoferDescNull, "", .ChoferDesc), 30)



                    sb &= Space(13)



                    '70	KMSTIER	1134	1143	N
                    sb &= JustificadoIzquierda(0, 10)
                    '71	KMSASFA	1144	1153	N
                    sb &= JustificadoIzquierda(If(.IsKmARecorrerNull, 0, .KmARecorrer), 10)
                    '72	TARIKMS	1154	1163	N
                    sb &= JustificadoIzquierda(If(.IsTarifaNull, 0, .Tarifa), 10)  'cobran distinto los kilometros en tierra vs asfalto?
                    '73	TARITIE	1164	1173	N
                    sb &= JustificadoIzquierda(If(.IsTarifaNull, 0, .Tarifa), 10)



                    sb &= Space(17)


                    '64	NROCAU	1191	1205	N
                    sb &= JustificadoIzquierda(.CEE, 14)

                    sb &= Space(14)

                    '74	FECVTOCAU	1219	1226	S
                    sb &= JustificadoIzquierda(If(.IsFechaVencimientoNull, Nothing, .FechaVencimiento.ToString("ddMMyyyy")), 8)
                    '76	CTGNRO	1227	1234	N
                    sb &= JustificadoIzquierda(If(.IsCTGNull, 0, .CTG), 8)


                    sb &= Space(9)

                    '77	TIPORTA	1244	1244	N
                    sb &= JustificadoIzquierda(" ", 1)


                    sb &= Space(1)


                    '78	CODRTA	1246	1250	S
                    sb &= JustificadoIzquierda(If(.IsCEENull, "", .CEE), 5)
                    '79	NRO PLANTA ONCCA	1251	1257	N
                    sb &= JustificadoIzquierda(If(.IsDestinoCodigoONCAANull, "", .DestinoCodigoONCAA), 7)


                    If If(.IsDestinoCodigoONCAANull, "", .DestinoCodigoONCAA) = "" AndAlso InStr(sErroresDestinos, .DestinoDesc) = 0 Then
                        'si no tiene codigo ni está ya en sErrores, lo meto

                        ErrHandler.WriteError("Falta el codigo ONCCA para el destino " & .DestinoDesc)

                        sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & .Destino & """ target=""_blank"">" & .DestinoDesc & "</a>; "
                    End If






                    'Col    Nombre            Desde    Hasta      Dato
                    '79           NUMVAGON    1260             1270        N
                    sb &= "  "
                    sb &= JustificadoIzquierda(.SubnumeroVagon, 11)



                    PrintLine(nF, sb)
                End With
            Next




            FileClose(nF)


            sErrores = "Procedencias sin código LosGrobo:<br/> " & sErroresProcedencia & "<br/>Destinos sin código LosGrobo: <br/>" & sErroresDestinos & "<br/>Otros: <br/>" & sErroresOtros

            If True Then
                If sErroresProcedencia <> "" Or sErroresDestinos <> "" Or sErroresOtros <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If

            Return vFileName


        End Function





        Shared Function FormatearCalidad(ByVal s As String) As String

            If InStr(s.ToLower, "grado 1") > 0 Then
                FormatearCalidad = "G1"
            ElseIf InStr(s.ToLower, "grado 2") > 0 Then
                FormatearCalidad = "G2"
            ElseIf InStr(s.ToLower, "grado 3") > 0 Then
                FormatearCalidad = "G3"
            ElseIf InStr(s.ToLower, "camara") > 0 Then
                FormatearCalidad = "CC"
            Else
                FormatearCalidad = "FE"
            End If

        End Function


        Public Shared Function Sincronismo_NOBLEarchivoadicional(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String


            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "wecal2des " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow



            'Dim a = pDataTable(1)

            '            Estamos teniendo problemas ( siempre los tuvimos ) para bajar las calidades
            'de las cartas de porte, por ejemplo el diseño que tenemos es el siguiente :
            '1 - Carta de Porte ( sucursal + número ) ---> 12 posiciones.-
            '2 - Código de rubro ---> 3 posiciones
            '3 - Resultado ---> 20 posiciones
            '4 - Rebaja ---> 20 posiciones

            'Pero como vemos en el archivo adjunto vienen :
            'a) resultados en enteros sin punto.-
            'b) resultados enteros con .00.-
            'c) resultados enteros con punto + 2 decimales + el signo %.-
            'd) otros casos varios.- 

            'Lo mismo pasa con las rebajas.-

            'Que posibilidades hay de estandarizar esta información, por ejemplo :
            'Luego del rubro que venga 1 campo con resultado con 2 enteros y 2 decimales
            '( sin punto ) y a continuación un campo rebaja con 2 enteros y 2 decimales (
            'sin punto ) ó también éste campo que comience en la parte de rebajas.- Pero
            'siempre que sean numéricos ( sin signos ni comentarios ).-

            ' ARCHIVO 2:    wecal2des.txt

            '│ CARPORTE   │ Character │    12 │     │
            '│ CODIGO     │ Character │     3 │     │
            '│ RESULTADO  │ Character │    20 │     │
            '│ REBAJA     │ Character │    20 │     │

            '            1 – CARPORTE = igual a lo informado en la actualidad
            '2 – CODIGO = igual a lo informado en la actualidad, cada rubro de análisis tiene su respectivo código y debe utilizarse la misma tabla que se encuentra en funcionamiento en el sincro actual.-
            '3 – RESULTADO y REBAJA = esto es lo que tenemos que modificar, lo que necesitaríamos es que venga un registro por cada rubro informado con el siguiente diseño :

            'CARTAPORTE char 12 ( 4 de sucursal + 8 de número ).-
            'CODIGO num 3 ( código según tabla rubros ).-
            'RESULTADO num 3,2 ( tres enteros + decimales -> resultado de análisis del rubro ).-
            'REBAJA num 3,2 ( tres enteros + 2 decimales -> porcentae de rebaja, de corresponder, para el rubro tratado, de acuerdo a las tablas respectivas por cereal )
            'Tendríamos que recibir 1 registro por cada rubro informado en la pantalla presentada en tu mail.- (De esto entiendo que puede haber más de una linea por CDP, una por rubro informado)

            '            Código(Descripción)
            '1			ACIDEZ MATERIA GRASA		
            '2:          ACIDO(EURICICO)
            '3:          BROTADOS()
            '4:          CALCINADOS()
            '5:          CALIBRE()
            '6:          CAPACIDAD(GERMINATIVA)
            '7:          CARBON()
            '8:          CHAMICO()
            '9:          COLORACION()
            '10:         CONTENIDO(MAT.GRASA)
            '11:         CUERPOS(EXTRAÑOS)
            '12			CPOS.EXT.COMUN/DESC/ROTO		
            '13:         CPOS.EXT.SIMIL.ALPISTE()
            '14			DEFECTOS/DAÑOS INTENSOS		
            '15			DEFECTOS/DAÑOS LEVES		
            '16			DESCACARADO Y ROTO		
            '17:         DESHECHOS(TOTALES)
            '18			CORNEZUELO (ERGOT.)		
            '19:         FALLING(NUMBER)
            '20:         GLUCOSILONATOS()
            '21:         GLUTEN(HUMEDO)
            '22			GRANOS ALTERADOS PRESENT		
            '23:         GRANOS(AMOHOSADOS)
            '24:         GRANOS(ARDIDOS / DAÑ.CALOR)
            '25:         GRANOS(COLORAD / EST.ROJAS)
            '26			GRANOS CON CARBON		
            '27			GRANOS CON DAÑOS TIPO 1		
            '28			GRANOS CON DAÑOS TIPO 2		
            '29:         GRANOS(DAÑADOS)
            '30			GRANOS DE CARBON		
            '31			GRANOS DE OTRO COLOR		
            '32			GRANOS DE TRIGO PAN		
            '33:         GRANOS(ENYESADOS / MUERTOS)
            '34:         GRANOS(MANCHADOS)
            '35			GRANOS MANCHADOS/COLOR.		
            '36			GRANOS NEGROS		
            '37			GRANOS PANZA BLANCA		
            '38:         GRANOS(PARTIDOS)
            '39:         GRANOS(PELADOS)
            '40:         GRANOS(PICADOS)
            '41:         GRANOS(QUEBRADOS)
            '42:         GRANOS(QUEBRADOS / CHUZOS)
            '43			GRANOS QUEBRADOS/PARTID.		
            '44			GRANOS QUEB/PART.NO REV.		
            '45:         GRANOS(QUEB / Part / PEL / ETC)
            '46:         GRANOS(QUEMADOS / AVERIA)
            '47:         GRANOS(SUELTOS)
            '48			GRANOS VERDE INTENSO		
            '49:         GRANOS(VITREOS)
            '50:         HUMEDAD()
            '51			MATERIAL BAJO ZARANDA		
            '52:         MATERIAS(EXTRAÑAS)
            '53:         MAT.EXT.DIF.GRAN.CEREAL()
            '55			MATERIAS EXTRAÑAS TOTAL.		
            '56			MAT.EXT./SORGO NO GRANIF		
            '57			MAT.INERTES/SEM.EXTRAÑAS		
            '58:         OLORES(COMERCIAL.OBJETAB)
            '59			OTRAS CAUSAS CALIDAD INF		
            '60:         OTRO(TIPO)
            '61:         PESO(HECTOLITRICO)
            '65:         PROTEINA()
            '66			PUNTA NEGRA CON CARBON		
            '67			PUNTA SOMBREADA P.TIERRA		
            '68:         RENDIM.MIN.GRANOS(ENTERO)
            '69			REND. MIN.GRAN.ENT./QUEB		
            '70			REVOLCADOS EN TIERRA		
            '71			SEM. BEJUCO Y/O PORTILLO		
            '72			TEST DE FLOTACION		
            '73:         TIERRA()
            '74:         TOTAL(DAÑADOS)
            '75			TREBOL DE OLOR		
            '76:         VITREOSIDAD()
            '80:         GRADO()
            '81:         TIPO()
            '82:         COLOR()
            '83			OLOR A HUMEDAD		
            '84			OLOR A TREBOL		
            '85			OLOR A CARBON		
            '86			G.PTA.NEG.P/CARB.Y OLOR		
            '96			REBAJAS A LIQUIDAR		
            '97			GRADO A LIQUIDAR		
            '98:         CPOS.EXTRAñOS(c() / TIERRA)
            '99:         CPOS.EXTRAñOS(S / TIERRA)
            '100:        MOHO()
            '101:        TOTAL(c.EXTRAñOS + TIERRA)
            '102			MERMA POR ZARANDEO		
            '103:        CONDICION()
            '104:        INSECTOS(VIVOS)
            '105:        TEMPERATURA()
            '106			MAT.EXTRAñAS S/ESCLEROT.		
            '107			ESCLEROTOS		
            '108			MAT.GRASA-MTRA,LIMP.SSS.		
            '109			KILOS X TARIFA ACONDIC.		
            '110:        GRANOS(VERDES(SOJA))
            '111:        BAJO(ZARANDA(CEBADA))
            '112			PROTEINA S.S.S.		
            '113			GRANOS AMARILLOS		


            Dim cadenavacia As String = String.Empty

            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp



                    sb = RenglonNobleCalidad(.NumeroCartaDePorte, 11, .NobleExtranos, 0, nF)

                    sb = RenglonNobleCalidad(.NumeroCartaDePorte, 36, .NobleNegros, 0, nF)
                    sb = RenglonNobleCalidad(.NumeroCartaDePorte, 41, .NobleQuebrados, 0, nF)
                    sb = RenglonNobleCalidad(.NumeroCartaDePorte, 29, .NobleDaniados, 0, nF)
                    sb = RenglonNobleCalidad(.NumeroCartaDePorte, 8, .NobleChamico, .NobleChamico2, nF)

                    sb = RenglonNobleCalidad(.NumeroCartaDePorte, 70, 0, .NobleRevolcado, nF)
                    sb = RenglonNobleCalidad(.NumeroCartaDePorte, 58, 0, .NobleObjetables, nF)
                    sb = RenglonNobleCalidad(.NumeroCartaDePorte, 23, 0, .NobleAmohosados, nF)

                    sb = RenglonNobleCalidad(.NumeroCartaDePorte, 61, .NobleHectolitrico, 0, nF)
                    sb = RenglonNobleCalidad(.NumeroCartaDePorte, 7, .NobleCarbon, 0, nF)
                    sb = RenglonNobleCalidad(.NumeroCartaDePorte, 37, .NoblePanzaBlanca, 0, nF)
                    sb = RenglonNobleCalidad(.NumeroCartaDePorte, 40, .NoblePicados, 0, nF)

                    sb = RenglonNobleCalidad(.NumeroCartaDePorte, 10, .NobleMGrasa, 0, nF)
                    sb = RenglonNobleCalidad(.NumeroCartaDePorte, 1, .NobleAcidezGrasa, 0, nF)
                    sb = RenglonNobleCalidad(.NumeroCartaDePorte, 110, .NobleVerdes, 0, nF)

                End With
            Next


            FileClose(nF)


            Return vFileName
        End Function

        Private Shared Function RenglonNobleCalidad(ByVal NumeroCarta As Long, ByVal CodigoNoble As Integer, ByVal Resultado As Double, ByVal Rebaja As Double, ByVal nf As Integer) As String
            Dim sb = ""

            'Que posibilidades hay de estandarizar esta información, por ejemplo :
            'Luego del rubro que venga 1 campo con resultado con 2 enteros y 2 decimales
            '( sin punto ) y a continuación un campo rebaja con 2 enteros y 2 decimales (
            'sin punto ) ó también éste campo que comience en la parte de rebajas.- Pero
            'siempre que sean numéricos ( sin signos ni comentarios )
            If Resultado <> 0 Or Rebaja <> 0 Then

                ForzarPrefijo5(NumeroCarta)
                sb &= Left(NumeroCarta.ToString, 12).PadLeft(12, "0")
                sb &= LeftMasPadLeft(CodigoNoble, 3)
                sb &= LeftMasPadLeft(Resultado.ToString("00.00", System.Globalization.CultureInfo.InvariantCulture).Replace(".", ""), 20)
                sb &= LeftMasPadLeft(Rebaja.ToString("00.00", System.Globalization.CultureInfo.InvariantCulture).Replace(".", ""), 20)

                PrintLine(nf, sb)
            End If
            Return sb
        End Function








        Public Shared Function GetListWHERE(ByVal SC As String, Optional ByVal IdObra As Integer = -1, Optional ByVal TipoFiltro As String = "", Optional ByVal IdProveedor As Integer = -1) As Pronto.ERP.BO.CartaDePorteList

            'en fin, vos le pasas el WHERE, y despues dependes de wCartasDePorte_T .....

            'Dim Lista As CartaDePorteList = CartaDePorteDB.GetList(SC)

            'If Lista Is Nothing Then Return Nothing

        End Function












        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////


        Public Shared Function Sincronismo_AndreoliDescargas(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "", Optional ByRef sErrores As String = "") As String





            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10655


            'Los campos de la carta de porte vamos a identificarla así: 1) cargador 2) intermediario 3) remitente comercial.

            '• En todos los casos en los que Amaggi sea el destinatario de la carta de porte puede pasar lo siguiente; 
            'a) El cargador directamente le entrega a Amaggi con lo cual el vendedor nuestro es ese.
            'b) El cargador le entrega a un intermediario (acopio por ejemplo) y este a Amaggi, con lo cuál este último es el que deben informar y por ende el que le vende a Amaggi.
            'c) El cargador le entrega a un intermediario y este a un canjeador (como remitente comercial) en este caso a nosotros nos interesa el remitente comercial.

            'En resumen cuando el destinatario de la carta de porte es Amaggi siempre tomar el último campo (de los 1,2,3,) que es quien le entrega a Amaggi y por ende le vendió la mercadería.

            '• En todos los casos en los que Amaggi sea remitente comercial pasa lo siguiente;

            'Siempre vamos a tener el doble movimiento que hemos charlado., la carta de porte va a aplicar a dos negocios distintos uno de compra y otro de venta .
            'a) El cargador o intermediario es quien le entrega la mercadería a Amaggi (cto de compra)
            'b) El destinatario de la mercadería es a quien Amaggi le cumple un negocio (cto de venta).





            '            Orden	Nombre	Long.	Descripción	Requerido	Justificacion	Posicion
            '1	Grano	3	Código de grano Sagpya	*	Izquierda	1
            '2	GranelBolsa	3	Embalaje del grano 1=Granel 2=Bolsa	*	Derecha	4
            '3	Cosecha	4	Cosecha 2000-2001 Ej: 0001	*	Izquierda	7
            '4	FecIng	8	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001	*	Izquierda	11
            '5	HorIng	8	Hora de entrada del camión Formato (HHMISS) ej:092556	*	Izquierda	19
            '6	FecSal	8	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001	*	Izquierda	27
            '7	HorSal	8	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556	*	Izquierda	35
            '8	CUITPuerto	14	CUIT PUERTO	*	Izquierda	43
            '9	NomPuerto	30	Nombre Puerto	*	Izquierda	57
            '10	CUITRecibidor	14	CUIT Recibidor	*	Izquierda	87
            '11	NomRecibidor	30	Nombre Recibidor	*	Izquierda	101
            '12	CUITComprador	14	CUIT Comprador	*	Izquierda	131
            '13	NomComp	30	Nombre Comprador	*	Izquierda	145
            '14	CUITCorrComp	14	CUIT Corredor Comprador	*	Izquierda	175
            '15	NomCorrComp	30	Nombre Corredor Comprador	*	Izquierda	189
            '16	CUITEntregador	14	CUIT Entregador	*	Izquierda	219
            '17	NomEntregador	30	Nombre Entregador	*	Izquierda	233
            '18	CUITCargador	14	CUIT Cargador	*	Izquierda	263
            '19	NomCargador	30	Nombre Cargador	*	Izquierda	277
            '20	CUITVendedor	14	CUIT Vendedor	*	Izquierda	307
            '21	NomVendedor	30	Nombre Vendedor	*	Izquierda	321
            '22	CUITCorrEndo	14	CUIT  Corredor Endozo		Izquierda	351
            '23	NomCorrEndo	30	Nombre Corredor Endozo		Izquierda	365
            '24	CUITCompEndo	14	CUIT Comprador Endozo		Izquierda	395
            '25	NomCompEndo	30	Nombre Comprador Endozo		Izquierda	409
            '26	CUITCorrVend	14	CUIT Corredor Vendedor.	*	Izquierda	439
            '27	NomCorrVend	30	Nombre Corredor Vendedor	*	Izquierda	453
            '28	CUITPlantaOrigen	14	CUIT Planta Origen	*	Izquierda	483
            '29	NomPlantaOrigen	30	Nombre Planta Origen	*	Izquierda	497
            '30	CPPorcede	8	Código Postal Procedencia	*	Izquierda	527
            '31	NomProcede	30	Nombre Procedencia	*	Izquierda	535
            '32	CPDestino	8	Código Postal Destino	*	Izquierda	565
            '33	NomDestino	30	Nombre Destino	*	Izquierda	573
            '34	CodMovIE	1	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr	*	Derecha	603
            '35	PatCha	10	Patente chasis		Izquierda	604
            '36	PesoBrut	10	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.	*	Derecha	614
            '37	PesoEgre	10	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales	*	Derecha	624
            '38	PesoNeto	10	Total bruto(PesoBrut-PesoEgre) (sin decimales)	*	Derecha	634
            '39	TotMerm	10	Total mermas (Total mermas sin decimales)		Derecha	644
            '40	TotNeto	10	Total neto ((Camión cargado – Tara)- Total mermas) (sin decimales)	*	Derecha	654
            '41	PorHume	10	Porcentaje humedad (un (1) decimal)		Derecha	664
            '42	PorMemaHumedad	10	Porcentaje merma humedad (dos (2) decimales)		Derecha	674
            '43	KgsHume	10	Kilos humedad (sin decimales)		Derecha	684
            '44	PBonHume	10	Porcentaje bonificación humedad (dos (2) decimales)		Derecha	694
            '45	KgsBonHu	10	Kilos bonificación humedad		Derecha	704
            '46	PorZaran	10	Porcentaje zarandeo (dos (2) decimales)		Derecha	714
            '47	KgsZaran	10	Kilos zarandeo (sin decimales)		Derecha	724
            '48	PorDesca	10	Porcentaje descarte (dos (2) decimales)		Derecha	734
            '49	KgsDesca	10	Kilogramos Descarte (Sin Decimales)		Derecha	744
            '50	PorVolat	10	Porcentaje volátil (dos (2) decimales)		Derecha	754
            '51	KgsVolat	10	Kilogramos volátil (sin decimales)		Derecha	764
            '52	CantBolsa	8	Cantidad de bolsas		Derecha	774
            '53	Fumigada	1	Condición fumigada 0=no 1=si	*	Derecha	782
            '54	PesoProcede	10	Peso procedencia (Sin Decimales)		Derecha	783
            '55	Contrato	12	Número de contrato  (Numeros 0 al 9)		Derecha	793
            '56	CarPorte	14	Número de Carta de Porte (Numeros  0 al 9)	*	Derecha	805
            '57	TipoTrans	1	Tipo de transporte c=camión  v=vagón o=Otro	*	Izquierda	819
            '58	Grado	10	Grado	*	Derecha	820
            '59	Factor	10	Factor	*	Derecha	830
            '60	Observac	100	Observaciones		Izquierda	840
            '61	ConCalidad	4	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o                       Fuera de standart (FE)	*	Izquierda	940
            '62	MovStock	1	Señal 1=Movió mercadería       0=No movió mercadería	*	Izquierda	944
            '63	ObsAna	100	Observaciones Analisis		Izquierda	945

            Dim sErroresProcedencia, sErroresDestinos As String

            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroAndreoli " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            'Dim a = pDataTable(1)


            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0




                    '                    Grano	Texto	1	3	Falta Dato
                    'GranelBolsa	Entero largo	4	3	
                    'Cosecha	Entero largo	7	4	Esta todo en 0 - Falta Dato
                    'FecIng	Fecha/Hora	11	8	No respeta formato DDMMAAAA
                    'HorIng	Texto	19	8	
                    'FechSal	Fecha/Hora	27	8	No respeta formato DDMMAAAA
                    'HorSal	Texto	35	8	
                    'CUITPuerto	Texto	43	14	Falta Dato
                    'NomPuerto	Texto	57	30	No respeta largo dato



                    sb &= .CodigoSAJPYA.PadRight(3) 'Grano	STRING(3)	Código de grano Sagpya)    1)    3
                    sb &= IIf(True, 1, 2).ToString.PadRight(3) 'GranelBolsa	STRING(3)	Embalaje del grano 1=Granel 2=Bolsa)    4)    6

                    sb &= Right(.Cosecha, 5).Replace("/", "").PadLeft(4)


                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= .FechaArribo.ToString("ddMMyyyy")       'FecIng	STRING(8)	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001)    11)    18


                    If .IsHoraNull Then
                        sb &= #12:00:00 AM#.ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    Else
                        sb &= Convert.ToDateTime(.Hora).ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    End If


                    sb &= "  "

                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= .FechaDescarga.ToString("ddMMyyyy")  'FecSal	STRING(8)	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001)    27)    34
                    sb &= Convert.ToDateTime(iisNull(.FechaDescarga, #12:00:00 AM#)).ToString("hhmmss") 'HorSal	STRING(8)	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556)    35)    42


                    sb &= "  "




                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular  'Acá va el Rte Comercial, si no hay RteCom va el Titular
                    'Corredor Endozo		    ?'No se manda?
                    'Comprador Endozo		    ?'No se manda?
                    'Corredor Vendedor		    ?'No se manda?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    'https://mail.google.com/mail/u/0/#search/amaggi/13795391d0a49a8d
                    ' Me llaman de Williams para ver si podemos ver un tema con el sincro Amaggi que les esta saliendo con un error (Carta de Porte del ejemplo: 525174646) mañana lo vemos

                    'Lucas, si los datos están bien cargados se está confeccionando mal el TXT y las cuentas no vienen donde corresponden.
                    'Desconozco los datos de la CP original para que Andrés sepa dónde está el problema.

                    'Por lo que me dijo Juan Pablo, estos datos vienen mal:
                    'Viene comprador BUNGE
                    'Cargador, vendedor y comp endoso: Amaggi





                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""




                    'Comentan que en los siguientes campos se debe mandar (en los 
                    'tres campos) el Intermediario y en 
                    ' caso que no haya Intermediario, en los tres casos el Titular: NomCargador NomCompEndo NomVendedor 
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8740


                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8740
                    Dim VendedorCUIT, VendedorDesc As String
                    ' If InStr(.RComercialDesc, "AMAGGI") > 0 Then Stop

                    If .RComercialDesc <> "" And InStr(.RComercialDesc, "ANDREOLI") = 0 Then
                        VendedorCUIT = .RComercialCUIT
                        VendedorDesc = .RComercialDesc
                    ElseIf .IntermediarioDesc <> "" Then
                        VendedorCUIT = .IntermediarioCUIT
                        VendedorDesc = .IntermediarioDesc
                    Else
                        VendedorCUIT = .TitularCUIT
                        VendedorDesc = .TitularDesc
                    End If




                    '[OutOfMemoryException: Exception of type 'System.OutOfMemoryException' was thrown.]
                    '   System.Data.Common.DecimalStorage.SetCapacity(Int32 capacity) +22
                    '   System.Data.RecordManager.set_RecordCapacity(Int32 value) +77
                    '                    System.Data.RecordManager.GrowRecordCapacity(+52)
                    '                    System.Data.RecordManager.NewRecordBase(+34)
                    '   System.Data.DataTable.NewRecord(Int32 sourceRecord) +23
                    '                    System.Data.DataRow.BeginEditInternal(+4817531)
                    '   System.Data.DataRow.set_Item(DataColumn column, Object value) +244
                    '   wCartasDePorte_TX_InformesCorregidoRow.set_IntermediarioCUIT(String Value) in C:\Backup\BDL\BussinessLogic\WillyInformesDataSet7.Designer.vb:4427
                    '   Pronto.ERP.Bll.SincronismosWilliamsManager.Sincronismo_AmaggiDescargas(wCartasDePorte_TX_InformesCorregidoDataTable pDataTable, String titulo, String sWHERE, String& sErrores) +1699
                    '   CartaDePorteInformesConReportViewerSincronismos.btnDescargaSincro_Click(Object sender, EventArgs e) +5006
                    '   System.Web.UI.WebControls.Button.OnClick(EventArgs e) +111
                    '   System.Web.UI.WebControls.Button.RaisePostBackEvent(String eventArgument) +110
                    '   System.Web.UI.WebControls.Button.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument) +10
                    '   System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument) +13
                    '   System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData) +36
                    '   System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint) +1565

                    If .IntermediarioCUIT = "" Then
                        .IntermediarioCUIT = .TitularCUIT
                        .IntermediarioDesc = .TitularDesc
                    Else
                        Debug.Print(.IntermediarioCUIT)
                    End If



                    Try

                        If .TitularDesc.Trim() = "DIRECTO" Then
                            .TitularDesc = ""
                            .TitularCUIT = ""
                        End If

                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try
                        If .IntermediarioDesc.Trim() = "DIRECTO" Then
                            .IntermediarioDesc = ""
                            .IntermediarioCUIT = ""
                        End If
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try
                        If .RComercialDesc.Trim() = "DIRECTO" Then
                            .RComercialDesc = ""
                            .RComercialCUIT = ""
                        End If
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try
                        If .CorredorDesc.Trim() = "DIRECTO" Then
                            .CorredorDesc = ""
                            .CorredorCUIT = ""
                        End If

                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try

                        If .DestinatarioDesc.Trim() = "DIRECTO" Then
                            .DestinatarioDesc = ""
                            .DestinatarioCUIT = ""
                        End If

                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try




                    '                CUITPUERTO	43	56
                    'NOMPUERTO	57	86
                    'CUITRECIBIDOR	87	100
                    'NOMRECIBIDOR	101	130
                    'CUITCOMPRADOR	131	144
                    'NOMCOMP	145	174
                    'CUITCORRCOMP	175	188
                    'NOMCORRCOMP	189	218
                    'CUITENTREGADOR	219	232
                    'NOMENTREGADOR	233	262
                    'CUITCARGADOR	307	320
                    'NOMCARGADOR	321	350
                    'CUITVENDEDOR	263	276
                    'NOMVENDEDOR	277	306
                    'CUITCORRENDO	351	364
                    'NOMCORRENDO	365	394
                    'CUITCOMPENDO	395	408
                    'NOMCOMPENDO	409	438
                    'CUITCORRVEND	439	452
                    'NOMCORRVEND	453	482
                    'CUITPLANTAORIGEN	483	496
                    'NOMPLANTAORIGEN	497	526
                    'CPPROCEDE	527	534
                    'NOMPROCEDE	535	564
                    'CPDESTINO	565	572
                    'NOMDESTINO	573	602
                    'CODMOVIE	603	603




                    sb &= Left(.DestinoCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPuerto	STRING(30)	Nombre Puerto)    57)    86

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130

                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

                    '///////////////////////////////////////////////////
                    ' acá va BLD S.A.                      30707386076
                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218
                    '////////////////////////////////////////////////////

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Entregador
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomEntregador	STRING(30)	Nombre Entregador)   

                    '////////////////////////////////////////////////////////////////////////////////
                    'Strongly Typed DataSets encountering NULL values – Grrrrrr… 
                    'http://social.msdn.microsoft.com/forums/en-US/winformsdatacontrols/thread/1dad8d0d-6eae-4254-a9d6-22d50da5578a
                    '////////////////////////////////////////////////////////////////////////////////



                    'en "Vendedor" les pasaba el RemComercial. Pidieron que les pasemos el titular por acá 
                    '                    (se filtró usando "SYNGENTA" en RemComercial, y
                    ' y parece que no les gustó que apareciera SYNGENTA en el sincro
                    sb &= Left(VendedorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                    sb &= Left(VendedorDesc.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350


                    sb &= Left(.TitularCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCargador	STRING(14)	CUIT Cargador)    263)  
                    sb &= Left(.TitularDesc.ToString, 30).PadRight(30)   'NomCargador 	STRING(30)	Nombre Cargador)    277)    306






                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrEndo	STRING(14)	CUIT  Corredor Endozo)    351)    364
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrEndo	STRING(30)	Nombre Corredor Endozo)    365)    394




                    sb &= Left(VendedorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCompEndo	STRING(14)	CUIT Comprador Endozo)    395)    408
                    sb &= Left(VendedorDesc.ToString, 30).PadRight(30) 'NomCompEndo	STRING(30)	Nombre Comprador Endozo)    409)    438


                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrVend	STRING(14)	CUIT Corredor Vendedor.)    439)    452
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrVend	STRING(30)	Nombre Corredor Vendedor)    453)    482


                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPlantaOrigen	STRING(14)	CUIT Planta Origen)    483)    496
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPlantaOrigen	STRING(30)	Nombre Planta Origen)    497)    526



                    'CPProcede	Texto	527	8	Falta Dato
                    'NomProcede	Texto	535	30	Falta Dato
                    'CPDestino	Texto	565	8	
                    'NomDestino	Texto	573	30	
                    'CodMovIE	Texto	603	1	


                    sb &= Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
                    sb &= Left(.ProcedenciaDesc.ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
                    sb &= Left(.DestinoCodigoPostal.ToString, 8).PadRight(8) 'CPDestino	STRING(8)	Código Postal Destino)    565)    572
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602




                    'Viene un 1 en el TXT, deben enviar un 0.
                    sb &= IIf(False, 1, 0).ToString.PadRight(1) 'CodMovIE	STRING(1)	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr)    603)    603
                    sb &= Left(.Patente.ToString, 6).PadRight(10) 'PatCha	STRING(6)	Patente chasis)    604)    609
                    'sb &= Left(.Acoplado.ToString, 6).PadRight(6) 'PatAcoplado	STRING(6)	Acoplado chasis)    610)    615




                    '36	PesoBrut	10	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.	*	Derecha	614
                    '37	PesoEgre	10	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales	*	Derecha	624
                    '38	PesoNeto	10	Total bruto(PesoBrut-PesoEgre) (sin decimales)	*	Derecha	634
                    '39	TotMerm	10	Total mermas (Total mermas sin decimales)		Derecha	644



                    'https://mail.google.com/mail/#label/Sincros/136a3190360d2620
                    'En la posición 36 que es PESOBRUT va el bruto real del camión. Lo que pesó en destino.
                    'En la posición 37 que es PESOEGRE va la tara real del camión. Lo que pesó en destino.
                    'En la posición 38 que es PESONETO va el PESOBRUT – PESOEGRE
                    'En la posición 40 que es TOTNETO va el neto final, es decir el PESONETO – el total de mermas. 
                    'Por lo que vos me ponés, aca irían los 29860 kls. Los kilos procedencia por el momento no serian importante.


                    '.BrutoPto
                    '.TaraPto
                    '.NetoPto
                    '.BrutoFinal
                    '.TaraFinal
                    '.NetoFinal
                    '.NetoProc

                    sb &= Int(.BrutoFinal).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= Int(.TaraFinal).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= Int(.NetoFinal).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    sb &= Int(.NetoFinal - .NetoProc).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655


                    '40	TotNeto	10	Total neto ((Camión cargado – Tara)- Total mermas) (sin decimales)	*	Derecha	654

                    sb &= Int(.NetoProc).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665







                    '41	PorHume	10	Porcentaje humedad (un (1) decimal)		Derecha	664
                    '42	PorMemaHumedad	10	Porcentaje merma humedad (dos (2) decimales)		Derecha	674
                    '43	KgsHume	10	Kilos humedad (sin decimales)		Derecha	684


                    sb &= String.Format("{0:F1}", .Humedad).PadLeft(10) 'PorHume	STRING(10)	Porcentaje humedad (un (1) decimal))    666)    675
                    ' http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=10980
                    Dim porcmerma = .HumedadDesnormalizada / .NetoFinal * 100
                    sb &= String.Format("{0:0.00}", porcmerma).PadLeft(10)  'este es el porcentaje recalculado que no grabo
                    sb &= Int(.HumedadDesnormalizada).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695



                    '44	PBonHume	10	Porcentaje bonificación humedad (dos (2) decimales)		Derecha	694
                    '45	KgsBonHu	10	Kilos bonificación humedad		Derecha	704

                    sb &= Left(cero.ToString, 10).PadLeft(10) 'PBonHume	STRING(10)	Porcentaje bonificación humedad (dos (2) decimales))    696)    705
                    sb &= Left(cero.ToString, 10).PadLeft(10) 'KgsBonHu	STRING(10)	Kilos bonificación humedad)    706)    715



                    '46	PorZaran	10	Porcentaje zarandeo (dos (2) decimales)		Derecha	714
                    '47	KgsZaran	10	Kilos zarandeo (sin decimales)		Derecha	724
                    '48	PorDesca	10	Porcentaje descarte (dos (2) decimales)		Derecha	734

                    '49	KgsDesca	10	Kilogramos Descarte (Sin Decimales)		Derecha	744
                    '50	PorVolat	10	Porcentaje volátil (dos (2) decimales)		Derecha	754
                    '51	KgsVolat	10	Kilogramos volátil (sin decimales)		Derecha	764


                    'esto?
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorZaran	STRING(10)	Porcentaje zarandeo (dos (2) decimales))    716)    725

                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsDesca	STRING(10)	Kilogramos Descarte (Sin Decimales))    746)    755
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorDesca	STRING(10)	Porcentaje descarte (dos (2) decimales))    736)    745
                    ' http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=10980

                    sb &= Int(Val(.Merma)).ToString.PadLeft(10) 'KgsZaran	STRING(10)	Kilos zarandeo (sin decimales))    726)    735

                    sb &= Left(Val(cadenavacia).ToString, 10).PadLeft(10) 'PorVolat	STRING(10)	Porcentaje volátil (dos (2) decimales))    756)    765
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsVolat	STRING(10)	Kilogramos volátil (sin decimales))    766)    775




                    '52	CantBolsa	8	Cantidad de bolsas		Derecha	774
                    '53	Fumigada	1	Condición fumigada 0=no 1=si	*	Derecha	782
                    '54	PesoProcede	10	Peso procedencia (Sin Decimales)		Derecha	783
                    '55	Contrato	12	Número de contrato  (Numeros 0 al 9)		Derecha	793
                    '56	CarPorte	14	Número de Carta de Porte (Numeros  0 al 9)	*	Derecha	805




                    '57	TipoTrans	1	Tipo de transporte c=camión  v=vagón o=Otro	*	Izquierda	819
                    '58	Grado	10	Grado	*	Derecha	820
                    '59	Factor	10	Factor	*	Derecha	830
                    '60	Observac	100	Observaciones		Izquierda	840
                    '61	ConCalidad	4	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o                       Fuera de standart (FE)	*	Izquierda	940
                    '62	MovStock	1	Señal 1=Movió mercadería       0=No movió mercadería	*	Izquierda	944
                    '63	ObsAna	100	Observaciones Analisis		Izquierda	945



                    sb &= Left(cadenavacia.ToString, 8).PadLeft(8) 'CantBolsa	STRING(8)	Cantidad de bolsas)    776)    783
                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'Fumigada	STRING(1)	Condición fumigada 0=no 1=si)    784)    784



                    sb &= Int(.NetoPto).ToString.PadRight(10) 'PesoProcede	STRING(10)	Peso procedencia (Sin Decimales))    785)    794
                    'sb &= Int(.BrutoPto).ToString.PadRight(10) 'BrutoProcede	STRING(10)	Bruto procedencia (Sin Decimales))    795)    804
                    'sb &= Int(.TaraPto).ToString.PadRight(10) 'TaraProcede	STRING(10)	Tara procedencia (Sin Decimales))    805)    814





                    sb &= Left(Val(.Contrato).ToString, 12).PadRight(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826


                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= Left(.NumeroCartaDePorte.ToString, 14).PadLeft(14, "0") 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840


                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    'EN LOS CASOS DE VAGONES
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8740
                    '/////////////////////////////////////////////////////////////////////////////////////

                    'Col Nombre Desde Hasta Dato
                    'campo decisivo:
                    '57	TIPOTRANS	819	 819	 S         'Venga una F que indica Ferroviario. por defecto viene A, que es Automotor.
                    sb &= IIf(.SubnumeroVagon > 0, "F", "A").ToString.PadRight(1) 'TipoTrans	STRING(1)	Tipo de transporte c=camión  v=vagón o=Otro)    841)    841

                    'aclaracion de otros campos:
                    '56	CARPORTE	805	 818	 N       'Nro de Carta de Porte, este numero al ser ferroviario porque el TIPOTRANS asi lo indica va a permitir que ingrese duplicada.
                    '79	NUMVAGON	1260	 1270 N      'Numero de Vagon, este nro debe ser el que identifique a cada vagon y logicamente no puede repetirse.
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////







                    sb &= Left(Int(.NobleGrado).ToString, 10).PadLeft(10) 'Grado	STRING(10)	Grado)    842)    851
                    sb &= Left(Int(.Factor).ToString, 10).PadLeft(10) 'Factor	STRING(10)	Factor)    852)    861

                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'Observac	STRING(100)	Observaciones)    862)    961


                    'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)
                    Dim sCalidad As String

                    Try
                        If InStr(.CalidadDesc.ToString.ToLower, "conforme") > 0 Then
                            sCalidad = "CO"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 1") > 0 Then
                            sCalidad = "G1"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 2") > 0 Then
                            sCalidad = "G2"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 3") > 0 Then
                            sCalidad = "G3"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "camara") > 0 Then
                            sCalidad = "CC"
                        Else
                            sCalidad = "FE"
                        End If
                    Catch ex As Exception
                        ErrHandler.WriteError("Sincro amaggi")
                        ErrHandler.WriteError(ex)
                    End Try
                    If .IsCalidadDescNull Then sCalidad = "FE"
                    sb &= sCalidad.PadRight(4) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'MovStock	STRING(1)	Señal 1=Movió mercadería)       0=No movió mercadería)    966)    966
                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'ObsAna	STRING(100)	Observaciones Analisis)    967)    1066








                    '68	DOCUME	1045	1055	S
                    sb &= JustificadoIzquierda(If(.IschoferCUITNull, "", .choferCUIT.Replace("-", "")), 11)





                    '66	CTATRANSPOR	1056	1066	N
                    sb &= JustificadoIzquierda(If(.IsTransportistaCUITNull, "", .TransportistaCUIT.Replace("-", "")), 11)



                    '/////////////////////////////////////////
                    'ensartado
                    '35	PATCHA	1067	1072	S    
                    sb &= JustificadoIzquierda(If(.IsPatenteNull, "", .Patente), 6)
                    '//////////////////////////////////////////

                    '69	PATACO	1073	1078	S
                    sb &= JustificadoIzquierda(If(.IsAcopladoNull, "", .Acoplado), 6)




                    sb &= Space(12)



                    '67	NOMCONDUC	1091	1120	S
                    sb &= JustificadoIzquierda(If(.IsChoferDescNull, "", .ChoferDesc), 30)



                    sb &= Space(13)



                    '70	KMSTIER	1134	1143	N
                    sb &= JustificadoIzquierda(0, 10)
                    '71	KMSASFA	1144	1153	N
                    sb &= JustificadoIzquierda(If(.IsKmARecorrerNull, 0, .KmARecorrer), 10)
                    '72	TARIKMS	1154	1163	N
                    sb &= JustificadoIzquierda(If(.IsTarifaNull, 0, .Tarifa), 10)  'cobran distinto los kilometros en tierra vs asfalto?
                    '73	TARITIE	1164	1173	N
                    sb &= JustificadoIzquierda(If(.IsTarifaNull, 0, .Tarifa), 10)



                    sb &= Space(17)


                    '64	NROCAU	1191	1205	N
                    sb &= JustificadoIzquierda(.CEE, 14)

                    sb &= Space(14)

                    '74	FECVTOCAU	1219	1226	S
                    sb &= JustificadoIzquierda(If(.IsFechaVencimientoNull, Nothing, .FechaVencimiento.ToString("ddMMyyyy")), 8)
                    '76	CTGNRO	1227	1234	N
                    sb &= JustificadoIzquierda(If(.IsCTGNull, 0, .CTG), 8)


                    sb &= Space(9)

                    '77	TIPORTA	1244	1244	N
                    sb &= JustificadoIzquierda(" ", 1)


                    sb &= Space(1)


                    '78	CODRTA	1246	1250	S
                    sb &= JustificadoIzquierda(If(.IsCEENull, "", .CEE), 5)
                    '79	NRO PLANTA ONCCA	1251	1257	N
                    sb &= JustificadoIzquierda(If(.IsDestinoCodigoONCAANull, "", .DestinoCodigoONCAA), 7)




                    If If(.IsDestinoCodigoONCAANull, "", .DestinoCodigoONCAA) = "" AndAlso InStr(sErroresDestinos, .DestinoDesc) = 0 Then
                        'si no tiene codigo ni está ya en sErrores, lo meto

                        ErrHandler.WriteError("Falta el codigo ONCCA para el destino " & .DestinoDesc)

                        sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & .Destino & """ target=""_blank"">" & .DestinoDesc & "</a>; "
                    End If






                    'Col    Nombre            Desde    Hasta      Dato
                    '79           NUMVAGON    1260             1270        N
                    sb &= "  "
                    sb &= JustificadoIzquierda(.SubnumeroVagon, 11)



                    PrintLine(nF, sb)
                End With
            Next




            FileClose(nF)


            sErrores = "Procedencias sin código LosGrobo:<br/> " & sErroresProcedencia & "<br/>Destinos sin código LosGrobo: <br/>" & sErroresDestinos

            If True Then
                If sErroresProcedencia <> "" Or sErroresDestinos <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If

            Return vFileName


        End Function

        Public Shared Function Sincronismo_AmaggiDescargas(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "", Optional ByRef sErrores As String = "") As String



            '            Orden	Nombre	Long.	Descripción	Requerido	Justificacion	Posicion
            '1	Grano	3	Código de grano Sagpya	*	Izquierda	1
            '2	GranelBolsa	3	Embalaje del grano 1=Granel 2=Bolsa	*	Derecha	4
            '3	Cosecha	4	Cosecha 2000-2001 Ej: 0001	*	Izquierda	7
            '4	FecIng	8	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001	*	Izquierda	11
            '5	HorIng	8	Hora de entrada del camión Formato (HHMISS) ej:092556	*	Izquierda	19
            '6	FecSal	8	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001	*	Izquierda	27
            '7	HorSal	8	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556	*	Izquierda	35
            '8	CUITPuerto	14	CUIT PUERTO	*	Izquierda	43
            '9	NomPuerto	30	Nombre Puerto	*	Izquierda	57
            '10	CUITRecibidor	14	CUIT Recibidor	*	Izquierda	87
            '11	NomRecibidor	30	Nombre Recibidor	*	Izquierda	101
            '12	CUITComprador	14	CUIT Comprador	*	Izquierda	131
            '13	NomComp	30	Nombre Comprador	*	Izquierda	145
            '14	CUITCorrComp	14	CUIT Corredor Comprador	*	Izquierda	175
            '15	NomCorrComp	30	Nombre Corredor Comprador	*	Izquierda	189
            '16	CUITEntregador	14	CUIT Entregador	*	Izquierda	219
            '17	NomEntregador	30	Nombre Entregador	*	Izquierda	233
            '18	CUITCargador	14	CUIT Cargador	*	Izquierda	263
            '19	NomCargador	30	Nombre Cargador	*	Izquierda	277
            '20	CUITVendedor	14	CUIT Vendedor	*	Izquierda	307
            '21	NomVendedor	30	Nombre Vendedor	*	Izquierda	321
            '22	CUITCorrEndo	14	CUIT  Corredor Endozo		Izquierda	351
            '23	NomCorrEndo	30	Nombre Corredor Endozo		Izquierda	365
            '24	CUITCompEndo	14	CUIT Comprador Endozo		Izquierda	395
            '25	NomCompEndo	30	Nombre Comprador Endozo		Izquierda	409
            '26	CUITCorrVend	14	CUIT Corredor Vendedor.	*	Izquierda	439
            '27	NomCorrVend	30	Nombre Corredor Vendedor	*	Izquierda	453
            '28	CUITPlantaOrigen	14	CUIT Planta Origen	*	Izquierda	483
            '29	NomPlantaOrigen	30	Nombre Planta Origen	*	Izquierda	497
            '30	CPPorcede	8	Código Postal Procedencia	*	Izquierda	527
            '31	NomProcede	30	Nombre Procedencia	*	Izquierda	535
            '32	CPDestino	8	Código Postal Destino	*	Izquierda	565
            '33	NomDestino	30	Nombre Destino	*	Izquierda	573
            '34	CodMovIE	1	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr	*	Derecha	603
            '35	PatCha	10	Patente chasis		Izquierda	604
            '36	PesoBrut	10	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.	*	Derecha	614
            '37	PesoEgre	10	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales	*	Derecha	624
            '38	PesoNeto	10	Total bruto(PesoBrut-PesoEgre) (sin decimales)	*	Derecha	634
            '39	TotMerm	10	Total mermas (Total mermas sin decimales)		Derecha	644
            '40	TotNeto	10	Total neto ((Camión cargado – Tara)- Total mermas) (sin decimales)	*	Derecha	654
            '41	PorHume	10	Porcentaje humedad (un (1) decimal)		Derecha	664
            '42	PorMemaHumedad	10	Porcentaje merma humedad (dos (2) decimales)		Derecha	674
            '43	KgsHume	10	Kilos humedad (sin decimales)		Derecha	684
            '44	PBonHume	10	Porcentaje bonificación humedad (dos (2) decimales)		Derecha	694
            '45	KgsBonHu	10	Kilos bonificación humedad		Derecha	704
            '46	PorZaran	10	Porcentaje zarandeo (dos (2) decimales)		Derecha	714
            '47	KgsZaran	10	Kilos zarandeo (sin decimales)		Derecha	724
            '48	PorDesca	10	Porcentaje descarte (dos (2) decimales)		Derecha	734
            '49	KgsDesca	10	Kilogramos Descarte (Sin Decimales)		Derecha	744
            '50	PorVolat	10	Porcentaje volátil (dos (2) decimales)		Derecha	754
            '51	KgsVolat	10	Kilogramos volátil (sin decimales)		Derecha	764
            '52	CantBolsa	8	Cantidad de bolsas		Derecha	774
            '53	Fumigada	1	Condición fumigada 0=no 1=si	*	Derecha	782
            '54	PesoProcede	10	Peso procedencia (Sin Decimales)		Derecha	783
            '55	Contrato	12	Número de contrato  (Numeros 0 al 9)		Derecha	793
            '56	CarPorte	14	Número de Carta de Porte (Numeros  0 al 9)	*	Derecha	805
            '57	TipoTrans	1	Tipo de transporte c=camión  v=vagón o=Otro	*	Izquierda	819
            '58	Grado	10	Grado	*	Derecha	820
            '59	Factor	10	Factor	*	Derecha	830
            '60	Observac	100	Observaciones		Izquierda	840
            '61	ConCalidad	4	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o                       Fuera de standart (FE)	*	Izquierda	940
            '62	MovStock	1	Señal 1=Movió mercadería       0=No movió mercadería	*	Izquierda	944
            '63	ObsAna	100	Observaciones Analisis		Izquierda	945

            Dim sErroresProcedencia, sErroresDestinos As String

            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroAmaggi " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            'Dim a = pDataTable(1)


            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0




                    '                    Grano	Texto	1	3	Falta Dato
                    'GranelBolsa	Entero largo	4	3	
                    'Cosecha	Entero largo	7	4	Esta todo en 0 - Falta Dato
                    'FecIng	Fecha/Hora	11	8	No respeta formato DDMMAAAA
                    'HorIng	Texto	19	8	
                    'FechSal	Fecha/Hora	27	8	No respeta formato DDMMAAAA
                    'HorSal	Texto	35	8	
                    'CUITPuerto	Texto	43	14	Falta Dato
                    'NomPuerto	Texto	57	30	No respeta largo dato



                    sb &= .CodigoSAJPYA.PadRight(3) 'Grano	STRING(3)	Código de grano Sagpya)    1)    3
                    sb &= IIf(True, 1, 2).ToString.PadRight(3) 'GranelBolsa	STRING(3)	Embalaje del grano 1=Granel 2=Bolsa)    4)    6

                    sb &= Right(.Cosecha, 5).Replace("/", "").PadLeft(4)


                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= .FechaArribo.ToString("ddMMyyyy")       'FecIng	STRING(8)	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001)    11)    18


                    If .IsHoraNull Then
                        sb &= #12:00:00 AM#.ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    Else
                        sb &= Convert.ToDateTime(.Hora).ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    End If


                    sb &= "  "

                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= .FechaDescarga.ToString("ddMMyyyy")  'FecSal	STRING(8)	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001)    27)    34
                    sb &= Convert.ToDateTime(iisNull(.FechaDescarga, #12:00:00 AM#)).ToString("hhmmss") 'HorSal	STRING(8)	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556)    35)    42


                    sb &= "  "




                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular  'Acá va el Rte Comercial, si no hay RteCom va el Titular
                    'Corredor Endozo		    ?'No se manda?
                    'Comprador Endozo		    ?'No se manda?
                    'Corredor Vendedor		    ?'No se manda?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    'https://mail.google.com/mail/u/0/#search/amaggi/13795391d0a49a8d
                    ' Me llaman de Williams para ver si podemos ver un tema con el sincro Amaggi que les esta saliendo con un error (Carta de Porte del ejemplo: 525174646) mañana lo vemos

                    'Lucas, si los datos están bien cargados se está confeccionando mal el TXT y las cuentas no vienen donde corresponden.
                    'Desconozco los datos de la CP original para que Andrés sepa dónde está el problema.

                    'Por lo que me dijo Juan Pablo, estos datos vienen mal:
                    'Viene comprador BUNGE
                    'Cargador, vendedor y comp endoso: Amaggi





                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""




                    'Comentan que en los siguientes campos se debe mandar (en los 
                    'tres campos) el Intermediario y en 
                    ' caso que no haya Intermediario, en los tres casos el Titular: NomCargador NomCompEndo NomVendedor 
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8740


                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8740
                    Dim VendedorCUIT, VendedorDesc As String
                    ' If InStr(.RComercialDesc, "AMAGGI") > 0 Then Stop

                    If .RComercialDesc <> "" And InStr(.RComercialDesc, "AMAGGI") = 0 Then
                        VendedorCUIT = .RComercialCUIT
                        VendedorDesc = .RComercialDesc
                    ElseIf .IntermediarioDesc <> "" Then
                        VendedorCUIT = .IntermediarioCUIT
                        VendedorDesc = .IntermediarioDesc
                    Else
                        VendedorCUIT = .TitularCUIT
                        VendedorDesc = .TitularDesc
                    End If




                    '[OutOfMemoryException: Exception of type 'System.OutOfMemoryException' was thrown.]
                    '   System.Data.Common.DecimalStorage.SetCapacity(Int32 capacity) +22
                    '   System.Data.RecordManager.set_RecordCapacity(Int32 value) +77
                    '                    System.Data.RecordManager.GrowRecordCapacity(+52)
                    '                    System.Data.RecordManager.NewRecordBase(+34)
                    '   System.Data.DataTable.NewRecord(Int32 sourceRecord) +23
                    '                    System.Data.DataRow.BeginEditInternal(+4817531)
                    '   System.Data.DataRow.set_Item(DataColumn column, Object value) +244
                    '   wCartasDePorte_TX_InformesCorregidoRow.set_IntermediarioCUIT(String Value) in C:\Backup\BDL\BussinessLogic\WillyInformesDataSet7.Designer.vb:4427
                    '   Pronto.ERP.Bll.SincronismosWilliamsManager.Sincronismo_AmaggiDescargas(wCartasDePorte_TX_InformesCorregidoDataTable pDataTable, String titulo, String sWHERE, String& sErrores) +1699
                    '   CartaDePorteInformesConReportViewerSincronismos.btnDescargaSincro_Click(Object sender, EventArgs e) +5006
                    '   System.Web.UI.WebControls.Button.OnClick(EventArgs e) +111
                    '   System.Web.UI.WebControls.Button.RaisePostBackEvent(String eventArgument) +110
                    '   System.Web.UI.WebControls.Button.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument) +10
                    '   System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument) +13
                    '   System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData) +36
                    '   System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint) +1565

                    If .IntermediarioCUIT = "" Then
                        .IntermediarioCUIT = .TitularCUIT
                        .IntermediarioDesc = .TitularDesc
                    Else
                        Debug.Print(.IntermediarioCUIT)
                    End If



                    Try

                        If .TitularDesc.Trim() = "DIRECTO" Then
                            .TitularDesc = ""
                            .TitularCUIT = ""
                        End If

                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try
                        If .IntermediarioDesc.Trim() = "DIRECTO" Then
                            .IntermediarioDesc = ""
                            .IntermediarioCUIT = ""
                        End If
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try
                        If .RComercialDesc.Trim() = "DIRECTO" Then
                            .RComercialDesc = ""
                            .RComercialCUIT = ""
                        End If
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try
                        If .CorredorDesc.Trim() = "DIRECTO" Then
                            .CorredorDesc = ""
                            .CorredorCUIT = ""
                        End If

                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try

                        If .DestinatarioDesc.Trim() = "DIRECTO" Then
                            .DestinatarioDesc = ""
                            .DestinatarioCUIT = ""
                        End If

                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try




                    '                CUITPUERTO	43	56
                    'NOMPUERTO	57	86
                    'CUITRECIBIDOR	87	100
                    'NOMRECIBIDOR	101	130
                    'CUITCOMPRADOR	131	144
                    'NOMCOMP	145	174
                    'CUITCORRCOMP	175	188
                    'NOMCORRCOMP	189	218
                    'CUITENTREGADOR	219	232
                    'NOMENTREGADOR	233	262
                    'CUITCARGADOR	307	320
                    'NOMCARGADOR	321	350
                    'CUITVENDEDOR	263	276
                    'NOMVENDEDOR	277	306
                    'CUITCORRENDO	351	364
                    'NOMCORRENDO	365	394
                    'CUITCOMPENDO	395	408
                    'NOMCOMPENDO	409	438
                    'CUITCORRVEND	439	452
                    'NOMCORRVEND	453	482
                    'CUITPLANTAORIGEN	483	496
                    'NOMPLANTAORIGEN	497	526
                    'CPPROCEDE	527	534
                    'NOMPROCEDE	535	564
                    'CPDESTINO	565	572
                    'NOMDESTINO	573	602
                    'CODMOVIE	603	603




                    sb &= Left(.DestinoCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPuerto	STRING(30)	Nombre Puerto)    57)    86

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130

                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

                    '///////////////////////////////////////////////////
                    ' acá va BLD S.A.                      30707386076
                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218
                    '////////////////////////////////////////////////////

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Entregador
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomEntregador	STRING(30)	Nombre Entregador)   

                    '////////////////////////////////////////////////////////////////////////////////
                    'Strongly Typed DataSets encountering NULL values – Grrrrrr… 
                    'http://social.msdn.microsoft.com/forums/en-US/winformsdatacontrols/thread/1dad8d0d-6eae-4254-a9d6-22d50da5578a
                    '////////////////////////////////////////////////////////////////////////////////



                    'en "Vendedor" les pasaba el RemComercial. Pidieron que les pasemos el titular por acá 
                    '                    (se filtró usando "SYNGENTA" en RemComercial, y
                    ' y parece que no les gustó que apareciera SYNGENTA en el sincro
                    sb &= Left(VendedorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                    sb &= Left(VendedorDesc.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350


                    sb &= Left(.TitularCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCargador	STRING(14)	CUIT Cargador)    263)  
                    sb &= Left(.TitularDesc.ToString, 30).PadRight(30)   'NomCargador 	STRING(30)	Nombre Cargador)    277)    306






                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrEndo	STRING(14)	CUIT  Corredor Endozo)    351)    364
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrEndo	STRING(30)	Nombre Corredor Endozo)    365)    394




                    sb &= Left(VendedorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCompEndo	STRING(14)	CUIT Comprador Endozo)    395)    408
                    sb &= Left(VendedorDesc.ToString, 30).PadRight(30) 'NomCompEndo	STRING(30)	Nombre Comprador Endozo)    409)    438


                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrVend	STRING(14)	CUIT Corredor Vendedor.)    439)    452
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrVend	STRING(30)	Nombre Corredor Vendedor)    453)    482


                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPlantaOrigen	STRING(14)	CUIT Planta Origen)    483)    496
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPlantaOrigen	STRING(30)	Nombre Planta Origen)    497)    526



                    'CPProcede	Texto	527	8	Falta Dato
                    'NomProcede	Texto	535	30	Falta Dato
                    'CPDestino	Texto	565	8	
                    'NomDestino	Texto	573	30	
                    'CodMovIE	Texto	603	1	



                    If .ProcedenciaCodigoPostal.ToString = "" And InStr(sErroresProcedencia, .ProcedenciaDesc.ToString) = 0 Then
                        'si no tiene codigo ni está ya en sErrores, lo meto

                        ErrHandler.WriteError("La procedencia " & .ProcedenciaDesc.ToString & " no tiene codigo postal")
                        'ErrHandler.WriteError("La carta " & .NumeroCartaDePorte & " no tiene codigo postal de procedencia")

                        'sErroresProcedencia &= "<a href=""CartaPorte.aspx?Id=" & .IdCartaDePorte & """ target=""_blank"">" & .NumeroCartaDePorte & "</a>; "


                        sErroresProcedencia &= "<a href=""Localidades.aspx?Id=" & .Procedencia & """ target=""_blank"">" & .ProcedenciaDesc & "</a>; "
                    End If


                    sb &= Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
                    sb &= Left(.ProcedenciaDesc.ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
                    sb &= Left(.DestinoCodigoPostal.ToString, 8).PadRight(8) 'CPDestino	STRING(8)	Código Postal Destino)    565)    572
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602




                    'Viene un 1 en el TXT, deben enviar un 0.
                    sb &= IIf(False, 1, 0).ToString.PadRight(1) 'CodMovIE	STRING(1)	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr)    603)    603
                    sb &= Left(.Patente.ToString, 6).PadRight(10) 'PatCha	STRING(6)	Patente chasis)    604)    609
                    'sb &= Left(.Acoplado.ToString, 6).PadRight(6) 'PatAcoplado	STRING(6)	Acoplado chasis)    610)    615




                    '36	PesoBrut	10	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.	*	Derecha	614
                    '37	PesoEgre	10	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales	*	Derecha	624
                    '38	PesoNeto	10	Total bruto(PesoBrut-PesoEgre) (sin decimales)	*	Derecha	634
                    '39	TotMerm	10	Total mermas (Total mermas sin decimales)		Derecha	644



                    'https://mail.google.com/mail/#label/Sincros/136a3190360d2620
                    'En la posición 36 que es PESOBRUT va el bruto real del camión. Lo que pesó en destino.
                    'En la posición 37 que es PESOEGRE va la tara real del camión. Lo que pesó en destino.
                    'En la posición 38 que es PESONETO va el PESOBRUT – PESOEGRE
                    'En la posición 40 que es TOTNETO va el neto final, es decir el PESONETO – el total de mermas. Por lo que vos me ponés, aca irían los 29860 kls. Los kilos procedencia por el momento no serian importante.


                    '.BrutoPto
                    '.TaraPto
                    '.NetoPto
                    '.BrutoFinal
                    '.TaraFinal
                    '.NetoFinal
                    '.NetoProc

                    sb &= Int(.BrutoFinal).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= Int(.TaraFinal).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= Int(.NetoFinal).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    sb &= Int(.NetoFinal - .NetoProc).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655


                    '40	TotNeto	10	Total neto ((Camión cargado – Tara)- Total mermas) (sin decimales)	*	Derecha	654

                    sb &= Int(.NetoProc).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665







                    '41	PorHume	10	Porcentaje humedad (un (1) decimal)		Derecha	664
                    '42	PorMemaHumedad	10	Porcentaje merma humedad (dos (2) decimales)		Derecha	674
                    '43	KgsHume	10	Kilos humedad (sin decimales)		Derecha	684
                    '44	PBonHume	10	Porcentaje bonificación humedad (dos (2) decimales)		Derecha	694
                    '45	KgsBonHu	10	Kilos bonificación humedad		Derecha	704

                    sb &= String.Format("{0:F1}", .Humedad).PadLeft(10) 'PorHume	STRING(10)	Porcentaje humedad (un (1) decimal))    666)    675
                    sb &= cero.ToString.PadLeft(10) 'PorMemaHumedad	STRING(10)	Porcentaje merma humedad (dos (2) decimales))    676)    685
                    sb &= Int(.HumedadDesnormalizada).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695
                    sb &= Left(cero.ToString, 10).PadLeft(10) 'PBonHume	STRING(10)	Porcentaje bonificación humedad (dos (2) decimales))    696)    705
                    sb &= Left(cero.ToString, 10).PadLeft(10) 'KgsBonHu	STRING(10)	Kilos bonificación humedad)    706)    715



                    '46	PorZaran	10	Porcentaje zarandeo (dos (2) decimales)		Derecha	714
                    '47	KgsZaran	10	Kilos zarandeo (sin decimales)		Derecha	724
                    '48	PorDesca	10	Porcentaje descarte (dos (2) decimales)		Derecha	734
                    '49	KgsDesca	10	Kilogramos Descarte (Sin Decimales)		Derecha	744
                    '50	PorVolat	10	Porcentaje volátil (dos (2) decimales)		Derecha	754
                    '51	KgsVolat	10	Kilogramos volátil (sin decimales)		Derecha	764


                    'esto?
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorZaran	STRING(10)	Porcentaje zarandeo (dos (2) decimales))    716)    725
                    sb &= Int(Val(.Merma)).ToString.PadLeft(10) 'KgsZaran	STRING(10)	Kilos zarandeo (sin decimales))    726)    735
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorDesca	STRING(10)	Porcentaje descarte (dos (2) decimales))    736)    745
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsDesca	STRING(10)	Kilogramos Descarte (Sin Decimales))    746)    755
                    sb &= Left(Val(cadenavacia).ToString, 10).PadLeft(10) 'PorVolat	STRING(10)	Porcentaje volátil (dos (2) decimales))    756)    765
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsVolat	STRING(10)	Kilogramos volátil (sin decimales))    766)    775




                    '52	CantBolsa	8	Cantidad de bolsas		Derecha	774
                    '53	Fumigada	1	Condición fumigada 0=no 1=si	*	Derecha	782
                    '54	PesoProcede	10	Peso procedencia (Sin Decimales)		Derecha	783
                    '55	Contrato	12	Número de contrato  (Numeros 0 al 9)		Derecha	793
                    '56	CarPorte	14	Número de Carta de Porte (Numeros  0 al 9)	*	Derecha	805




                    '57	TipoTrans	1	Tipo de transporte c=camión  v=vagón o=Otro	*	Izquierda	819
                    '58	Grado	10	Grado	*	Derecha	820
                    '59	Factor	10	Factor	*	Derecha	830
                    '60	Observac	100	Observaciones		Izquierda	840
                    '61	ConCalidad	4	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o                       Fuera de standart (FE)	*	Izquierda	940
                    '62	MovStock	1	Señal 1=Movió mercadería       0=No movió mercadería	*	Izquierda	944
                    '63	ObsAna	100	Observaciones Analisis		Izquierda	945



                    sb &= Left(cadenavacia.ToString, 8).PadLeft(8) 'CantBolsa	STRING(8)	Cantidad de bolsas)    776)    783
                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'Fumigada	STRING(1)	Condición fumigada 0=no 1=si)    784)    784



                    sb &= Int(.NetoProc).ToString.PadRight(10) 'PesoProcede	STRING(10)	Peso procedencia (Sin Decimales))    785)    794
                    'sb &= Int(.BrutoPto).ToString.PadRight(10) 'BrutoProcede	STRING(10)	Bruto procedencia (Sin Decimales))    795)    804
                    'sb &= Int(.TaraPto).ToString.PadRight(10) 'TaraProcede	STRING(10)	Tara procedencia (Sin Decimales))    805)    814





                    sb &= Left(Val(.Contrato).ToString, 12).PadRight(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826
                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= Left(.NumeroCartaDePorte.ToString, 14).PadLeft(14, "0") 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840


                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    'EN LOS CASOS DE VAGONES
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8740
                    '/////////////////////////////////////////////////////////////////////////////////////

                    'Col Nombre Desde Hasta Dato
                    'campo decisivo:
                    '57	TIPOTRANS	819	 819	 S         'Venga una F que indica Ferroviario. por defecto viene A, que es Automotor.
                    sb &= IIf(.SubnumeroVagon > 0, "F", "A").ToString.PadRight(1) 'TipoTrans	STRING(1)	Tipo de transporte c=camión  v=vagón o=Otro)    841)    841

                    'aclaracion de otros campos:
                    '56	CARPORTE	805	 818	 N       'Nro de Carta de Porte, este numero al ser ferroviario porque el TIPOTRANS asi lo indica va a permitir que ingrese duplicada.
                    '79	NUMVAGON	1260	 1270 N      'Numero de Vagon, este nro debe ser el que identifique a cada vagon y logicamente no puede repetirse.
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////







                    sb &= Left(Int(.NobleGrado).ToString, 10).PadLeft(10) 'Grado	STRING(10)	Grado)    842)    851
                    sb &= Left(Int(.Factor).ToString, 10).PadLeft(10) 'Factor	STRING(10)	Factor)    852)    861

                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'Observac	STRING(100)	Observaciones)    862)    961


                    'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)
                    Dim sCalidad As String

                    Try
                        If InStr(.CalidadDesc.ToString.ToLower, "conforme") > 0 Then
                            sCalidad = "CO"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 1") > 0 Then
                            sCalidad = "G1"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 2") > 0 Then
                            sCalidad = "G2"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 3") > 0 Then
                            sCalidad = "G3"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "camara") > 0 Then
                            sCalidad = "CC"
                        Else
                            sCalidad = "FE"
                        End If
                    Catch ex As Exception
                        ErrHandler.WriteError("Sincro amaggi")
                        ErrHandler.WriteError(ex)
                    End Try
                    If .IsCalidadDescNull Then sCalidad = "FE"
                    sb &= sCalidad.PadRight(4) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'MovStock	STRING(1)	Señal 1=Movió mercadería)       0=No movió mercadería)    966)    966
                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'ObsAna	STRING(100)	Observaciones Analisis)    967)    1066








                    '68	DOCUME	1045	1055	S
                    sb &= JustificadoIzquierda(If(.IschoferCUITNull, "", .choferCUIT.Replace("-", "")), 11)





                    '66	CTATRANSPOR	1056	1066	N
                    sb &= JustificadoIzquierda(If(.IsTransportistaCUITNull, "", .TransportistaCUIT.Replace("-", "")), 11)



                    '/////////////////////////////////////////
                    'ensartado
                    '35	PATCHA	1067	1072	S    
                    sb &= JustificadoIzquierda(If(.IsPatenteNull, "", .Patente), 6)
                    '//////////////////////////////////////////

                    '69	PATACO	1073	1078	S
                    sb &= JustificadoIzquierda(If(.IsAcopladoNull, "", .Acoplado), 6)




                    sb &= Space(12)



                    '67	NOMCONDUC	1091	1120	S
                    sb &= JustificadoIzquierda(If(.IsChoferDescNull, "", .ChoferDesc), 30)



                    sb &= Space(13)



                    '70	KMSTIER	1134	1143	N
                    sb &= JustificadoIzquierda(0, 10)
                    '71	KMSASFA	1144	1153	N
                    sb &= JustificadoIzquierda(If(.IsKmARecorrerNull, 0, .KmARecorrer), 10)
                    '72	TARIKMS	1154	1163	N
                    sb &= JustificadoIzquierda(If(.IsTarifaNull, 0, .Tarifa), 10)  'cobran distinto los kilometros en tierra vs asfalto?
                    '73	TARITIE	1164	1173	N
                    sb &= JustificadoIzquierda(If(.IsTarifaNull, 0, .Tarifa), 10)



                    sb &= Space(17)


                    '64	NROCAU	1191	1205	N
                    sb &= JustificadoIzquierda(.CEE, 14)

                    sb &= Space(14)

                    '74	FECVTOCAU	1219	1226	S
                    sb &= JustificadoIzquierda(If(.IsFechaVencimientoNull, Nothing, .FechaVencimiento.ToString("ddMMyyyy")), 8)
                    '76	CTGNRO	1227	1234	N
                    sb &= JustificadoIzquierda(If(.IsCTGNull, 0, .CTG), 8)


                    sb &= Space(9)

                    '77	TIPORTA	1244	1244	N
                    sb &= JustificadoIzquierda(" ", 1)


                    sb &= Space(1)


                    '78	CODRTA	1246	1250	S
                    sb &= JustificadoIzquierda(If(.IsCEENull, "", .CEE), 5)
                    '79	NRO PLANTA ONCCA	1251	1257	N
                    sb &= JustificadoIzquierda(If(.IsDestinoCodigoONCAANull, "", .DestinoCodigoONCAA), 7)


                    If If(.IsDestinoCodigoONCAANull, "", .DestinoCodigoONCAA) = "" AndAlso InStr(sErroresDestinos, .DestinoDesc) = 0 Then
                        'si no tiene codigo ni está ya en sErrores, lo meto

                        ErrHandler.WriteError("Falta el codigo ONCCA para el destino " & .DestinoDesc)

                        sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & .Destino & """ target=""_blank"">" & .DestinoDesc & "</a>; "
                    End If






                    'Col    Nombre            Desde    Hasta      Dato
                    '79           NUMVAGON    1260             1270        N
                    sb &= "  "
                    sb &= JustificadoIzquierda(.SubnumeroVagon, 11)



                    PrintLine(nF, sb)
                End With
            Next




            FileClose(nF)




            sErrores = "Procedencias sin código postal:<br/> " & sErroresProcedencia & "<br/><br/>Destinos sin código ONCAA: <br/>" & sErroresDestinos

            If True Then
                If sErroresProcedencia <> "" Or sErroresDestinos <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If

            Return vFileName


        End Function

        Public Shared Function Sincronismo_BTGDescargas(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "", Optional ByRef sErrores As String = "") As String



            '            Orden	Nombre	Long.	Descripción	Requerido	Justificacion	Posicion
            '1	Grano	3	Código de grano Sagpya	*	Izquierda	1
            '2	GranelBolsa	3	Embalaje del grano 1=Granel 2=Bolsa	*	Derecha	4
            '3	Cosecha	4	Cosecha 2000-2001 Ej: 0001	*	Izquierda	7
            '4	FecIng	8	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001	*	Izquierda	11
            '5	HorIng	8	Hora de entrada del camión Formato (HHMISS) ej:092556	*	Izquierda	19
            '6	FecSal	8	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001	*	Izquierda	27
            '7	HorSal	8	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556	*	Izquierda	35
            '8	CUITPuerto	14	CUIT PUERTO	*	Izquierda	43
            '9	NomPuerto	30	Nombre Puerto	*	Izquierda	57
            '10	CUITRecibidor	14	CUIT Recibidor	*	Izquierda	87
            '11	NomRecibidor	30	Nombre Recibidor	*	Izquierda	101
            '12	CUITComprador	14	CUIT Comprador	*	Izquierda	131
            '13	NomComp	30	Nombre Comprador	*	Izquierda	145
            '14	CUITCorrComp	14	CUIT Corredor Comprador	*	Izquierda	175
            '15	NomCorrComp	30	Nombre Corredor Comprador	*	Izquierda	189
            '16	CUITEntregador	14	CUIT Entregador	*	Izquierda	219
            '17	NomEntregador	30	Nombre Entregador	*	Izquierda	233
            '18	CUITCargador	14	CUIT Cargador	*	Izquierda	263
            '19	NomCargador	30	Nombre Cargador	*	Izquierda	277
            '20	CUITVendedor	14	CUIT Vendedor	*	Izquierda	307
            '21	NomVendedor	30	Nombre Vendedor	*	Izquierda	321
            '22	CUITCorrEndo	14	CUIT  Corredor Endozo		Izquierda	351
            '23	NomCorrEndo	30	Nombre Corredor Endozo		Izquierda	365
            '24	CUITCompEndo	14	CUIT Comprador Endozo		Izquierda	395
            '25	NomCompEndo	30	Nombre Comprador Endozo		Izquierda	409
            '26	CUITCorrVend	14	CUIT Corredor Vendedor.	*	Izquierda	439
            '27	NomCorrVend	30	Nombre Corredor Vendedor	*	Izquierda	453
            '28	CUITPlantaOrigen	14	CUIT Planta Origen	*	Izquierda	483
            '29	NomPlantaOrigen	30	Nombre Planta Origen	*	Izquierda	497
            '30	CPPorcede	8	Código Postal Procedencia	*	Izquierda	527
            '31	NomProcede	30	Nombre Procedencia	*	Izquierda	535
            '32	CPDestino	8	Código Postal Destino	*	Izquierda	565
            '33	NomDestino	30	Nombre Destino	*	Izquierda	573
            '34	CodMovIE	1	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr	*	Derecha	603
            '35	PatCha	10	Patente chasis		Izquierda	604
            '36	PesoBrut	10	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.	*	Derecha	614
            '37	PesoEgre	10	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales	*	Derecha	624
            '38	PesoNeto	10	Total bruto(PesoBrut-PesoEgre) (sin decimales)	*	Derecha	634
            '39	TotMerm	10	Total mermas (Total mermas sin decimales)		Derecha	644
            '40	TotNeto	10	Total neto ((Camión cargado – Tara)- Total mermas) (sin decimales)	*	Derecha	654
            '41	PorHume	10	Porcentaje humedad (un (1) decimal)		Derecha	664
            '42	PorMemaHumedad	10	Porcentaje merma humedad (dos (2) decimales)		Derecha	674
            '43	KgsHume	10	Kilos humedad (sin decimales)		Derecha	684
            '44	PBonHume	10	Porcentaje bonificación humedad (dos (2) decimales)		Derecha	694
            '45	KgsBonHu	10	Kilos bonificación humedad		Derecha	704
            '46	PorZaran	10	Porcentaje zarandeo (dos (2) decimales)		Derecha	714
            '47	KgsZaran	10	Kilos zarandeo (sin decimales)		Derecha	724
            '48	PorDesca	10	Porcentaje descarte (dos (2) decimales)		Derecha	734
            '49	KgsDesca	10	Kilogramos Descarte (Sin Decimales)		Derecha	744
            '50	PorVolat	10	Porcentaje volátil (dos (2) decimales)		Derecha	754
            '51	KgsVolat	10	Kilogramos volátil (sin decimales)		Derecha	764
            '52	CantBolsa	8	Cantidad de bolsas		Derecha	774
            '53	Fumigada	1	Condición fumigada 0=no 1=si	*	Derecha	782
            '54	PesoProcede	10	Peso procedencia (Sin Decimales)		Derecha	783
            '55	Contrato	12	Número de contrato  (Numeros 0 al 9)		Derecha	793
            '56	CarPorte	14	Número de Carta de Porte (Numeros  0 al 9)	*	Derecha	805
            '57	TipoTrans	1	Tipo de transporte c=camión  v=vagón o=Otro	*	Izquierda	819
            '58	Grado	10	Grado	*	Derecha	820
            '59	Factor	10	Factor	*	Derecha	830
            '60	Observac	100	Observaciones		Izquierda	840
            '61	ConCalidad	4	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o                       Fuera de standart (FE)	*	Izquierda	940
            '62	MovStock	1	Señal 1=Movió mercadería       0=No movió mercadería	*	Izquierda	944
            '63	ObsAna	100	Observaciones Analisis		Izquierda	945

            Dim sErroresProcedencia, sErroresDestinos As String

            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroBTG " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            'Dim a = pDataTable(1)


            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0




                    '                    Grano	Texto	1	3	Falta Dato
                    'GranelBolsa	Entero largo	4	3	
                    'Cosecha	Entero largo	7	4	Esta todo en 0 - Falta Dato
                    'FecIng	Fecha/Hora	11	8	No respeta formato DDMMAAAA
                    'HorIng	Texto	19	8	
                    'FechSal	Fecha/Hora	27	8	No respeta formato DDMMAAAA
                    'HorSal	Texto	35	8	
                    'CUITPuerto	Texto	43	14	Falta Dato
                    'NomPuerto	Texto	57	30	No respeta largo dato



                    sb &= .CodigoSAJPYA.PadRight(3) 'Grano	STRING(3)	Código de grano Sagpya)    1)    3
                    sb &= IIf(True, 1, 2).ToString.PadRight(3) 'GranelBolsa	STRING(3)	Embalaje del grano 1=Granel 2=Bolsa)    4)    6

                    sb &= Right(.Cosecha, 5).Replace("/", "").PadLeft(4)


                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= .FechaArribo.ToString("ddMMyyyy")       'FecIng	STRING(8)	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001)    11)    18


                    If .IsHoraNull Then
                        sb &= #12:00:00 AM#.ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    Else
                        sb &= Convert.ToDateTime(.Hora).ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    End If


                    sb &= "  "

                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= .FechaDescarga.ToString("ddMMyyyy")  'FecSal	STRING(8)	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001)    27)    34
                    sb &= Convert.ToDateTime(iisNull(.FechaDescarga, #12:00:00 AM#)).ToString("hhmmss") 'HorSal	STRING(8)	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556)    35)    42


                    sb &= "  "




                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular  'Acá va el Rte Comercial, si no hay RteCom va el Titular
                    'Corredor Endozo		    ?'No se manda?
                    'Comprador Endozo		    ?'No se manda?
                    'Corredor Vendedor		    ?'No se manda?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    'https://mail.google.com/mail/u/0/#search/amaggi/13795391d0a49a8d
                    ' Me llaman de Williams para ver si podemos ver un tema con el sincro Amaggi que les esta saliendo con un error (Carta de Porte del ejemplo: 525174646) mañana lo vemos

                    'Lucas, si los datos están bien cargados se está confeccionando mal el TXT y las cuentas no vienen donde corresponden.
                    'Desconozco los datos de la CP original para que Andrés sepa dónde está el problema.

                    'Por lo que me dijo Juan Pablo, estos datos vienen mal:
                    'Viene comprador BUNGE
                    'Cargador, vendedor y comp endoso: Amaggi





                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""




                    'Comentan que en los siguientes campos se debe mandar (en los 
                    'tres campos) el Intermediario y en 
                    ' caso que no haya Intermediario, en los tres casos el Titular: NomCargador NomCompEndo NomVendedor 
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8740


                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8740
                    Dim VendedorCUIT, VendedorDesc As String
                    ' If InStr(.RComercialDesc, "AMAGGI") > 0 Then Stop

                    If .RComercialDesc <> "" And InStr(.RComercialDesc, "AMAGGI") = 0 Then
                        VendedorCUIT = .RComercialCUIT
                        VendedorDesc = .RComercialDesc
                    ElseIf .IntermediarioDesc <> "" Then
                        VendedorCUIT = .IntermediarioCUIT
                        VendedorDesc = .IntermediarioDesc
                    Else
                        VendedorCUIT = .TitularCUIT
                        VendedorDesc = .TitularDesc
                    End If




                    '[OutOfMemoryException: Exception of type 'System.OutOfMemoryException' was thrown.]
                    '   System.Data.Common.DecimalStorage.SetCapacity(Int32 capacity) +22
                    '   System.Data.RecordManager.set_RecordCapacity(Int32 value) +77
                    '                    System.Data.RecordManager.GrowRecordCapacity(+52)
                    '                    System.Data.RecordManager.NewRecordBase(+34)
                    '   System.Data.DataTable.NewRecord(Int32 sourceRecord) +23
                    '                    System.Data.DataRow.BeginEditInternal(+4817531)
                    '   System.Data.DataRow.set_Item(DataColumn column, Object value) +244
                    '   wCartasDePorte_TX_InformesCorregidoRow.set_IntermediarioCUIT(String Value) in C:\Backup\BDL\BussinessLogic\WillyInformesDataSet7.Designer.vb:4427
                    '   Pronto.ERP.Bll.SincronismosWilliamsManager.Sincronismo_AmaggiDescargas(wCartasDePorte_TX_InformesCorregidoDataTable pDataTable, String titulo, String sWHERE, String& sErrores) +1699
                    '   CartaDePorteInformesConReportViewerSincronismos.btnDescargaSincro_Click(Object sender, EventArgs e) +5006
                    '   System.Web.UI.WebControls.Button.OnClick(EventArgs e) +111
                    '   System.Web.UI.WebControls.Button.RaisePostBackEvent(String eventArgument) +110
                    '   System.Web.UI.WebControls.Button.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument) +10
                    '   System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument) +13
                    '   System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData) +36
                    '   System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint) +1565

                    If .IntermediarioCUIT = "" Then
                        .IntermediarioCUIT = .TitularCUIT
                        .IntermediarioDesc = .TitularDesc
                    Else
                        Debug.Print(.IntermediarioCUIT)
                    End If



                    Try

                        If .TitularDesc.Trim() = "DIRECTO" Then
                            .TitularDesc = ""
                            .TitularCUIT = ""
                        End If

                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try
                        If .IntermediarioDesc.Trim() = "DIRECTO" Then
                            .IntermediarioDesc = ""
                            .IntermediarioCUIT = ""
                        End If
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try
                        If .RComercialDesc.Trim() = "DIRECTO" Then
                            .RComercialDesc = ""
                            .RComercialCUIT = ""
                        End If
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try
                        If .CorredorDesc.Trim() = "DIRECTO" Then
                            .CorredorDesc = ""
                            .CorredorCUIT = ""
                        End If

                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try

                        If .DestinatarioDesc.Trim() = "DIRECTO" Then
                            .DestinatarioDesc = ""
                            .DestinatarioCUIT = ""
                        End If

                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try




                    '                CUITPUERTO	43	56
                    'NOMPUERTO	57	86
                    'CUITRECIBIDOR	87	100
                    'NOMRECIBIDOR	101	130
                    'CUITCOMPRADOR	131	144
                    'NOMCOMP	145	174
                    'CUITCORRCOMP	175	188
                    'NOMCORRCOMP	189	218
                    'CUITENTREGADOR	219	232
                    'NOMENTREGADOR	233	262
                    'CUITCARGADOR	307	320
                    'NOMCARGADOR	321	350
                    'CUITVENDEDOR	263	276
                    'NOMVENDEDOR	277	306
                    'CUITCORRENDO	351	364
                    'NOMCORRENDO	365	394
                    'CUITCOMPENDO	395	408
                    'NOMCOMPENDO	409	438
                    'CUITCORRVEND	439	452
                    'NOMCORRVEND	453	482
                    'CUITPLANTAORIGEN	483	496
                    'NOMPLANTAORIGEN	497	526
                    'CPPROCEDE	527	534
                    'NOMPROCEDE	535	564
                    'CPDESTINO	565	572
                    'NOMDESTINO	573	602
                    'CODMOVIE	603	603




                    sb &= Left(.DestinoCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPuerto	STRING(30)	Nombre Puerto)    57)    86

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130

                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

                    '///////////////////////////////////////////////////
                    ' acá va BLD S.A.                      30707386076
                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218
                    '////////////////////////////////////////////////////

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Entregador
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomEntregador	STRING(30)	Nombre Entregador)   

                    '////////////////////////////////////////////////////////////////////////////////
                    'Strongly Typed DataSets encountering NULL values – Grrrrrr… 
                    'http://social.msdn.microsoft.com/forums/en-US/winformsdatacontrols/thread/1dad8d0d-6eae-4254-a9d6-22d50da5578a
                    '////////////////////////////////////////////////////////////////////////////////



                    'en "Vendedor" les pasaba el RemComercial. Pidieron que les pasemos el titular por acá 
                    '                    (se filtró usando "SYNGENTA" en RemComercial, y
                    ' y parece que no les gustó que apareciera SYNGENTA en el sincro
                    sb &= Left(VendedorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                    sb &= Left(VendedorDesc.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350


                    sb &= Left(.TitularCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCargador	STRING(14)	CUIT Cargador)    263)  
                    sb &= Left(.TitularDesc.ToString, 30).PadRight(30)   'NomCargador 	STRING(30)	Nombre Cargador)    277)    306






                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrEndo	STRING(14)	CUIT  Corredor Endozo)    351)    364
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrEndo	STRING(30)	Nombre Corredor Endozo)    365)    394




                    sb &= Left(VendedorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCompEndo	STRING(14)	CUIT Comprador Endozo)    395)    408
                    sb &= Left(VendedorDesc.ToString, 30).PadRight(30) 'NomCompEndo	STRING(30)	Nombre Comprador Endozo)    409)    438


                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrVend	STRING(14)	CUIT Corredor Vendedor.)    439)    452
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrVend	STRING(30)	Nombre Corredor Vendedor)    453)    482


                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPlantaOrigen	STRING(14)	CUIT Planta Origen)    483)    496
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPlantaOrigen	STRING(30)	Nombre Planta Origen)    497)    526



                    'CPProcede	Texto	527	8	Falta Dato
                    'NomProcede	Texto	535	30	Falta Dato
                    'CPDestino	Texto	565	8	
                    'NomDestino	Texto	573	30	
                    'CodMovIE	Texto	603	1	


                    sb &= Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
                    sb &= Left(.ProcedenciaDesc.ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
                    sb &= Left(.DestinoCodigoPostal.ToString, 8).PadRight(8) 'CPDestino	STRING(8)	Código Postal Destino)    565)    572
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602




                    'Viene un 1 en el TXT, deben enviar un 0.
                    sb &= IIf(False, 1, 0).ToString.PadRight(1) 'CodMovIE	STRING(1)	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr)    603)    603
                    sb &= Left(.Patente.ToString, 6).PadRight(10) 'PatCha	STRING(6)	Patente chasis)    604)    609
                    'sb &= Left(.Acoplado.ToString, 6).PadRight(6) 'PatAcoplado	STRING(6)	Acoplado chasis)    610)    615




                    '36	PesoBrut	10	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.	*	Derecha	614
                    '37	PesoEgre	10	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales	*	Derecha	624
                    '38	PesoNeto	10	Total bruto(PesoBrut-PesoEgre) (sin decimales)	*	Derecha	634
                    '39	TotMerm	10	Total mermas (Total mermas sin decimales)		Derecha	644



                    'https://mail.google.com/mail/#label/Sincros/136a3190360d2620
                    'En la posición 36 que es PESOBRUT va el bruto real del camión. Lo que pesó en destino.
                    'En la posición 37 que es PESOEGRE va la tara real del camión. Lo que pesó en destino.
                    'En la posición 38 que es PESONETO va el PESOBRUT – PESOEGRE
                    'En la posición 40 que es TOTNETO va el neto final, es decir el PESONETO – el total de mermas. Por lo que vos me ponés, aca irían los 29860 kls. Los kilos procedencia por el momento no serian importante.


                    '.BrutoPto
                    '.TaraPto
                    '.NetoPto
                    '.BrutoFinal
                    '.TaraFinal
                    '.NetoFinal
                    '.NetoProc

                    sb &= Int(.BrutoFinal).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= Int(.TaraFinal).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= Int(.NetoFinal).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    sb &= Int(.NetoFinal - .NetoProc).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655


                    '40	TotNeto	10	Total neto ((Camión cargado – Tara)- Total mermas) (sin decimales)	*	Derecha	654

                    sb &= Int(.NetoProc).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665







                    '41	PorHume	10	Porcentaje humedad (un (1) decimal)		Derecha	664
                    '42	PorMemaHumedad	10	Porcentaje merma humedad (dos (2) decimales)		Derecha	674
                    '43	KgsHume	10	Kilos humedad (sin decimales)		Derecha	684
                    '44	PBonHume	10	Porcentaje bonificación humedad (dos (2) decimales)		Derecha	694
                    '45	KgsBonHu	10	Kilos bonificación humedad		Derecha	704

                    sb &= String.Format("{0:F1}", .Humedad).PadLeft(10) 'PorHume	STRING(10)	Porcentaje humedad (un (1) decimal))    666)    675
                    sb &= cero.ToString.PadLeft(10) 'PorMemaHumedad	STRING(10)	Porcentaje merma humedad (dos (2) decimales))    676)    685
                    sb &= Int(.HumedadDesnormalizada).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695
                    sb &= Left(cero.ToString, 10).PadLeft(10) 'PBonHume	STRING(10)	Porcentaje bonificación humedad (dos (2) decimales))    696)    705
                    sb &= Left(cero.ToString, 10).PadLeft(10) 'KgsBonHu	STRING(10)	Kilos bonificación humedad)    706)    715



                    '46	PorZaran	10	Porcentaje zarandeo (dos (2) decimales)		Derecha	714
                    '47	KgsZaran	10	Kilos zarandeo (sin decimales)		Derecha	724
                    '48	PorDesca	10	Porcentaje descarte (dos (2) decimales)		Derecha	734
                    '49	KgsDesca	10	Kilogramos Descarte (Sin Decimales)		Derecha	744
                    '50	PorVolat	10	Porcentaje volátil (dos (2) decimales)		Derecha	754
                    '51	KgsVolat	10	Kilogramos volátil (sin decimales)		Derecha	764


                    'esto?
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorZaran	STRING(10)	Porcentaje zarandeo (dos (2) decimales))    716)    725
                    sb &= Int(Val(.Merma)).ToString.PadLeft(10) 'KgsZaran	STRING(10)	Kilos zarandeo (sin decimales))    726)    735
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorDesca	STRING(10)	Porcentaje descarte (dos (2) decimales))    736)    745
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsDesca	STRING(10)	Kilogramos Descarte (Sin Decimales))    746)    755
                    sb &= Left(Val(cadenavacia).ToString, 10).PadLeft(10) 'PorVolat	STRING(10)	Porcentaje volátil (dos (2) decimales))    756)    765
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsVolat	STRING(10)	Kilogramos volátil (sin decimales))    766)    775




                    '52	CantBolsa	8	Cantidad de bolsas		Derecha	774
                    '53	Fumigada	1	Condición fumigada 0=no 1=si	*	Derecha	782
                    '54	PesoProcede	10	Peso procedencia (Sin Decimales)		Derecha	783
                    '55	Contrato	12	Número de contrato  (Numeros 0 al 9)		Derecha	793
                    '56	CarPorte	14	Número de Carta de Porte (Numeros  0 al 9)	*	Derecha	805




                    '57	TipoTrans	1	Tipo de transporte c=camión  v=vagón o=Otro	*	Izquierda	819
                    '58	Grado	10	Grado	*	Derecha	820
                    '59	Factor	10	Factor	*	Derecha	830
                    '60	Observac	100	Observaciones		Izquierda	840
                    '61	ConCalidad	4	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o                       Fuera de standart (FE)	*	Izquierda	940
                    '62	MovStock	1	Señal 1=Movió mercadería       0=No movió mercadería	*	Izquierda	944
                    '63	ObsAna	100	Observaciones Analisis		Izquierda	945



                    sb &= Left(cadenavacia.ToString, 8).PadLeft(8) 'CantBolsa	STRING(8)	Cantidad de bolsas)    776)    783
                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'Fumigada	STRING(1)	Condición fumigada 0=no 1=si)    784)    784



                    sb &= Int(.NetoProc).ToString.PadRight(10) 'PesoProcede	STRING(10)	Peso procedencia (Sin Decimales))    785)    794
                    'sb &= Int(.BrutoPto).ToString.PadRight(10) 'BrutoProcede	STRING(10)	Bruto procedencia (Sin Decimales))    795)    804
                    'sb &= Int(.TaraPto).ToString.PadRight(10) 'TaraProcede	STRING(10)	Tara procedencia (Sin Decimales))    805)    814





                    sb &= Left(Val(.Contrato).ToString, 12).PadRight(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826
                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= Left(.NumeroCartaDePorte.ToString, 14).PadLeft(14, "0") 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840


                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    'EN LOS CASOS DE VAGONES
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8740
                    '/////////////////////////////////////////////////////////////////////////////////////

                    'Col Nombre Desde Hasta Dato
                    'campo decisivo:
                    '57	TIPOTRANS	819	 819	 S         'Venga una F que indica Ferroviario. por defecto viene A, que es Automotor.
                    sb &= IIf(.SubnumeroVagon > 0, "F", "A").ToString.PadRight(1) 'TipoTrans	STRING(1)	Tipo de transporte c=camión  v=vagón o=Otro)    841)    841

                    'aclaracion de otros campos:
                    '56	CARPORTE	805	 818	 N       'Nro de Carta de Porte, este numero al ser ferroviario porque el TIPOTRANS asi lo indica va a permitir que ingrese duplicada.
                    '79	NUMVAGON	1260	 1270 N      'Numero de Vagon, este nro debe ser el que identifique a cada vagon y logicamente no puede repetirse.
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////







                    sb &= Left(Int(.NobleGrado).ToString, 10).PadLeft(10) 'Grado	STRING(10)	Grado)    842)    851
                    sb &= Left(Int(.Factor).ToString, 10).PadLeft(10) 'Factor	STRING(10)	Factor)    852)    861

                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'Observac	STRING(100)	Observaciones)    862)    961


                    'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)
                    Dim sCalidad As String

                    Try
                        If InStr(.CalidadDesc.ToString.ToLower, "conforme") > 0 Then
                            sCalidad = "CO"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 1") > 0 Then
                            sCalidad = "G1"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 2") > 0 Then
                            sCalidad = "G2"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 3") > 0 Then
                            sCalidad = "G3"
                        ElseIf InStr(.CalidadDesc.ToString.ToLower, "camara") > 0 Then
                            sCalidad = "CC"
                        Else
                            sCalidad = "FE"
                        End If
                    Catch ex As Exception
                        ErrHandler.WriteError("Sincro amaggi")
                        ErrHandler.WriteError(ex)
                    End Try
                    If .IsCalidadDescNull Then sCalidad = "FE"
                    sb &= sCalidad.PadRight(4) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'MovStock	STRING(1)	Señal 1=Movió mercadería)       0=No movió mercadería)    966)    966
                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'ObsAna	STRING(100)	Observaciones Analisis)    967)    1066








                    '68	DOCUME	1045	1055	S
                    sb &= JustificadoIzquierda(If(.IschoferCUITNull, "", .choferCUIT.Replace("-", "")), 11)





                    '66	CTATRANSPOR	1056	1066	N
                    sb &= JustificadoIzquierda(If(.IsTransportistaCUITNull, "", .TransportistaCUIT.Replace("-", "")), 11)



                    '/////////////////////////////////////////
                    'ensartado
                    '35	PATCHA	1067	1072	S    
                    sb &= JustificadoIzquierda(If(.IsPatenteNull, "", .Patente), 6)
                    '//////////////////////////////////////////

                    '69	PATACO	1073	1078	S
                    sb &= JustificadoIzquierda(If(.IsAcopladoNull, "", .Acoplado), 6)




                    sb &= Space(12)



                    '67	NOMCONDUC	1091	1120	S
                    sb &= JustificadoIzquierda(If(.IsChoferDescNull, "", .ChoferDesc), 30)



                    sb &= Space(13)



                    '70	KMSTIER	1134	1143	N
                    sb &= JustificadoIzquierda(0, 10)
                    '71	KMSASFA	1144	1153	N
                    sb &= JustificadoIzquierda(If(.IsKmARecorrerNull, 0, .KmARecorrer), 10)
                    '72	TARIKMS	1154	1163	N
                    sb &= JustificadoIzquierda(If(.IsTarifaNull, 0, .Tarifa), 10)  'cobran distinto los kilometros en tierra vs asfalto?
                    '73	TARITIE	1164	1173	N
                    sb &= JustificadoIzquierda(If(.IsTarifaNull, 0, .Tarifa), 10)



                    sb &= Space(17)


                    '64	NROCAU	1191	1205	N
                    sb &= JustificadoIzquierda(.CEE, 14)

                    sb &= Space(14)

                    '74	FECVTOCAU	1219	1226	S
                    sb &= JustificadoIzquierda(If(.IsFechaVencimientoNull, Nothing, .FechaVencimiento.ToString("ddMMyyyy")), 8)
                    '76	CTGNRO	1227	1234	N
                    sb &= JustificadoIzquierda(If(.IsCTGNull, 0, .CTG), 8)


                    sb &= Space(9)

                    '77	TIPORTA	1244	1244	N
                    sb &= JustificadoIzquierda(" ", 1)


                    sb &= Space(1)


                    '78	CODRTA	1246	1250	S
                    sb &= JustificadoIzquierda(If(.IsCEENull, "", .CEE), 5)
                    '79	NRO PLANTA ONCCA	1251	1257	N
                    sb &= JustificadoIzquierda(If(.IsDestinoCodigoONCAANull, "", .DestinoCodigoONCAA), 7)


                    If If(.IsDestinoCodigoONCAANull, "", .DestinoCodigoONCAA) = "" AndAlso InStr(sErroresDestinos, .DestinoDesc) = 0 Then
                        'si no tiene codigo ni está ya en sErrores, lo meto

                        ErrHandler.WriteError("Falta el codigo ONCCA para el destino " & .DestinoDesc)

                        sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & .Destino & """ target=""_blank"">" & .DestinoDesc & "</a>; "
                    End If






                    'Col    Nombre            Desde    Hasta      Dato
                    '79           NUMVAGON    1260             1270        N
                    sb &= "  "
                    sb &= JustificadoIzquierda(.SubnumeroVagon, 11)



                    PrintLine(nF, sb)
                End With
            Next




            FileClose(nF)


            sErrores = "Procedencias sin código LosGrobo:<br/> " & sErroresProcedencia & "<br/>Destinos sin código LosGrobo: <br/>" & sErroresDestinos

            If True Then
                If sErroresProcedencia <> "" Or sErroresDestinos <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If

            Return vFileName


        End Function
        Public Shared Function Sincronismo_Lelfun(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "", Optional ByRef sErrores As String = "") As String


            '        casi igual que Zeni/syngenta
            'andreoli tiene los campos nuevos






            '            Orden	Nombre	Long.	Descripción	Requerido	Justificacion	Posicion
            '1	Grano	3	Código de grano Sagpya	*	Izquierda	1
            '2	GranelBolsa	3	Embalaje del grano 1=Granel 2=Bolsa	*	Derecha	4
            '3	Cosecha	4	Cosecha 2000-2001 Ej: 0001	*	Izquierda	7
            '4	FecIng	8	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001	*	Izquierda	11
            '5	HorIng	8	Hora de entrada del camión Formato (HHMISS) ej:092556	*	Izquierda	19
            '6	FecSal	8	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001	*	Izquierda	27
            '7	HorSal	8	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556	*	Izquierda	35
            '8	CUITPuerto	14	CUIT PUERTO	*	Izquierda	43
            '9	NomPuerto	30	Nombre Puerto	*	Izquierda	57
            '10	CUITRecibidor	14	CUIT Recibidor	*	Izquierda	87
            '11	NomRecibidor	30	Nombre Recibidor	*	Izquierda	101
            '12	CUITComprador	14	CUIT Comprador	*	Izquierda	131
            '13	NomComp	30	Nombre Comprador	*	Izquierda	145
            '14	CUITCorrComp	14	CUIT Corredor Comprador	*	Izquierda	175
            '15	NomCorrComp	30	Nombre Corredor Comprador	*	Izquierda	189
            '16	CUITEntregador	14	CUIT Entregador	*	Izquierda	219
            '17	NomEntregador	30	Nombre Entregador	*	Izquierda	233
            '18	CUITCargador	14	CUIT Cargador	*	Izquierda	263
            '19	NomCargador	30	Nombre Cargador	*	Izquierda	277
            '20	CUITVendedor	14	CUIT Vendedor	*	Izquierda	307
            '21	NomVendedor	30	Nombre Vendedor	*	Izquierda	321
            '22	CUITCorrEndo	14	CUIT  Corredor Endozo		Izquierda	351
            '23	NomCorrEndo	30	Nombre Corredor Endozo		Izquierda	365
            '24	CUITCompEndo	14	CUIT Comprador Endozo		Izquierda	395
            '25	NomCompEndo	30	Nombre Comprador Endozo		Izquierda	409
            '26	CUITCorrVend	14	CUIT Corredor Vendedor.	*	Izquierda	439
            '27	NomCorrVend	30	Nombre Corredor Vendedor	*	Izquierda	453
            '28	CUITPlantaOrigen	14	CUIT Planta Origen	*	Izquierda	483
            '29	NomPlantaOrigen	30	Nombre Planta Origen	*	Izquierda	497
            '30	CPPorcede	8	Código Postal Procedencia	*	Izquierda	527
            '31	NomProcede	30	Nombre Procedencia	*	Izquierda	535
            '32	CPDestino	8	Código Postal Destino	*	Izquierda	565
            '33	NomDestino	30	Nombre Destino	*	Izquierda	573
            '34	CodMovIE	1	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr	*	Derecha	603
            '35	PatCha	10	Patente chasis		Izquierda	604
            '36	PesoBrut	10	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.	*	Derecha	614
            '37	PesoEgre	10	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales	*	Derecha	624
            '38	PesoNeto	10	Total bruto(PesoBrut-PesoEgre) (sin decimales)	*	Derecha	634
            '39	TotMerm	10	Total mermas (Total mermas sin decimales)		Derecha	644
            '40	TotNeto	10	Total neto ((Camión cargado – Tara)- Total mermas) (sin decimales)	*	Derecha	654
            '41	PorHume	10	Porcentaje humedad (un (1) decimal)		Derecha	664
            '42	PorMemaHumedad	10	Porcentaje merma humedad (dos (2) decimales)		Derecha	674
            '43	KgsHume	10	Kilos humedad (sin decimales)		Derecha	684
            '44	PBonHume	10	Porcentaje bonificación humedad (dos (2) decimales)		Derecha	694
            '45	KgsBonHu	10	Kilos bonificación humedad		Derecha	704
            '46	PorZaran	10	Porcentaje zarandeo (dos (2) decimales)		Derecha	714
            '47	KgsZaran	10	Kilos zarandeo (sin decimales)		Derecha	724
            '48	PorDesca	10	Porcentaje descarte (dos (2) decimales)		Derecha	734
            '49	KgsDesca	10	Kilogramos Descarte (Sin Decimales)		Derecha	744
            '50	PorVolat	10	Porcentaje volátil (dos (2) decimales)		Derecha	754
            '51	KgsVolat	10	Kilogramos volátil (sin decimales)		Derecha	764
            '52	CantBolsa	8	Cantidad de bolsas		Derecha	774
            '53	Fumigada	1	Condición fumigada 0=no 1=si	*	Derecha	782
            '54	PesoProcede	10	Peso procedencia (Sin Decimales)		Derecha	783
            '55	Contrato	12	Número de contrato  (Numeros 0 al 9)		Derecha	793
            '56	CarPorte	14	Número de Carta de Porte (Numeros  0 al 9)	*	Derecha	805
            '57	TipoTrans	1	Tipo de transporte c=camión  v=vagón o=Otro	*	Izquierda	819
            '58	Grado	10	Grado	*	Derecha	820
            '59	Factor	10	Factor	*	Derecha	830
            '60	Observac	100	Observaciones		Izquierda	840
            '61	ConCalidad	4	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o                       Fuera de standart (FE)	*	Izquierda	940
            '62	MovStock	1	Señal 1=Movió mercadería       0=No movió mercadería	*	Izquierda	944
            '63	ObsAna	100	Observaciones Analisis		Izquierda	945

            Dim sErroresProcedencia, sErroresDestinos As String


            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroLelfun " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            'Dim a = pDataTable(1)


            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0




                    '                    Grano	Texto	1	3	Falta Dato
                    'GranelBolsa	Entero largo	4	3	
                    'Cosecha	Entero largo	7	4	Esta todo en 0 - Falta Dato
                    'FecIng	Fecha/Hora	11	8	No respeta formato DDMMAAAA
                    'HorIng	Texto	19	8	
                    'FechSal	Fecha/Hora	27	8	No respeta formato DDMMAAAA
                    'HorSal	Texto	35	8	
                    'CUITPuerto	Texto	43	14	Falta Dato
                    'NomPuerto	Texto	57	30	No respeta largo dato



                    sb &= .CodigoSAJPYA.PadRight(3) 'Grano	STRING(3)	Código de grano Sagpya)    1)    3
                    sb &= IIf(True, 1, 2).ToString.PadRight(3) 'GranelBolsa	STRING(3)	Embalaje del grano 1=Granel 2=Bolsa)    4)    6

                    sb &= Right(.Cosecha, 5).Replace("/", "").PadLeft(4)


                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= .FechaArribo.ToString("ddMMyyyy")       'FecIng	STRING(8)	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001)    11)    18


                    If .IsHoraNull Then
                        sb &= #12:00:00 AM#.ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    Else
                        sb &= Convert.ToDateTime(.Hora).ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    End If


                    sb &= "  "

                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= .FechaDescarga.ToString("ddMMyyyy")  'FecSal	STRING(8)	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001)    27)    34
                    sb &= Convert.ToDateTime(iisNull(.FechaDescarga, #12:00:00 AM#)).ToString("hhmmss") 'HorSal	STRING(8)	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556)    35)    42


                    sb &= "  "




                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular
                    'Corredor Endozo		    ?
                    'Comprador Endozo		    ?
                    'Corredor Vendedor		    ?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""




                    'Comentan que en los siguientes campos se debe mandar (en los 
                    'tres campos) el Intermediario y en 
                    ' caso que no haya Intermediario, en los tres casos el Titular: NomCargador NomCompEndo NomVendedor 
                    If .IntermediarioCUIT = "" Then
                        .IntermediarioCUIT = .TitularCUIT
                        .IntermediarioDesc = .TitularDesc
                    Else
                        Debug.Print(.IntermediarioCUIT)
                    End If







                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPuerto	STRING(30)	Nombre Puerto)    57)    86

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130

                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

                    '///////////////////////////////////////////////////
                    ' acá va BLD S.A.                      30707386076
                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218
                    '////////////////////////////////////////////////////

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Entregador
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomEntregador	STRING(30)	Nombre Entregador)   

                    '////////////////////////////////////////////////////////////////////////////////
                    'Strongly Typed DataSets encountering NULL values – Grrrrrr… 
                    'http://social.msdn.microsoft.com/forums/en-US/winformsdatacontrols/thread/1dad8d0d-6eae-4254-a9d6-22d50da5578a
                    '////////////////////////////////////////////////////////////////////////////////




                    sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCargador	STRING(14)	CUIT Cargador)    263)  
                    sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30)   'NomCargador 	STRING(30)	Nombre Cargador)    277)    306


                    'en "Vendedor" les pasaba el RemComercial. Pidieron que les pasemos el titular por acá (se filtró usando "SYNGENTA" en RemComercial, y
                    ' y parece que no les gustó que apareciera SYNGENTA en el sincro
                    sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                    sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350




                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrEndo	STRING(14)	CUIT  Corredor Endozo)    351)    364
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrEndo	STRING(30)	Nombre Corredor Endozo)    365)    394




                    sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCompEndo	STRING(14)	CUIT Comprador Endozo)    395)    408
                    sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30) 'NomCompEndo	STRING(30)	Nombre Comprador Endozo)    409)    438


                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrVend	STRING(14)	CUIT Corredor Vendedor.)    439)    452
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrVend	STRING(30)	Nombre Corredor Vendedor)    453)    482


                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPlantaOrigen	STRING(14)	CUIT Planta Origen)    483)    496
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPlantaOrigen	STRING(30)	Nombre Planta Origen)    497)    526



                    'CPProcede	Texto	527	8	Falta Dato
                    'NomProcede	Texto	535	30	Falta Dato
                    'CPDestino	Texto	565	8	
                    'NomDestino	Texto	573	30	
                    'CodMovIE	Texto	603	1	


                    sb &= Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
                    sb &= Left(.ProcedenciaDesc.ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
                    sb &= Left(.DestinoCodigoPostal.ToString, 8).PadRight(8) 'CPDestino	STRING(8)	Código Postal Destino)    565)    572
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602





                    sb &= IIf(True, 1, 0).ToString.PadRight(1) 'CodMovIE	STRING(1)	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr)    603)    603
                    sb &= Left(.Patente.ToString, 6).PadRight(10) 'PatCha	STRING(6)	Patente chasis)    604)    609
                    'sb &= Left(.Acoplado.ToString, 6).PadRight(6) 'PatAcoplado	STRING(6)	Acoplado chasis)    610)    615




                    '36	PesoBrut	10	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.	*	Derecha	614
                    '37	PesoEgre	10	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales	*	Derecha	624
                    '38	PesoNeto	10	Total bruto(PesoBrut-PesoEgre) (sin decimales)	*	Derecha	634
                    '39	TotMerm	10	Total mermas (Total mermas sin decimales)		Derecha	644

                    sb &= Int(.NetoPto).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= Int(.TaraPto).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= Int(.BrutoPto).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    sb &= Int(.Merma).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655


                    '40	TotNeto	10	Total neto ((Camión cargado – Tara)- Total mermas) (sin decimales)	*	Derecha	654


                    sb &= Int(.NetoFinal).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665

                    '41	PorHume	10	Porcentaje humedad (un (1) decimal)		Derecha	664
                    '42	PorMemaHumedad	10	Porcentaje merma humedad (dos (2) decimales)		Derecha	674
                    '43	KgsHume	10	Kilos humedad (sin decimales)		Derecha	684
                    '44	PBonHume	10	Porcentaje bonificación humedad (dos (2) decimales)		Derecha	694
                    '45	KgsBonHu	10	Kilos bonificación humedad		Derecha	704

                    sb &= String.Format("{0:F1}", .Humedad).PadLeft(10) 'PorHume	STRING(10)	Porcentaje humedad (un (1) decimal))    666)    675
                    sb &= cero.ToString.PadLeft(10) 'PorMemaHumedad	STRING(10)	Porcentaje merma humedad (dos (2) decimales))    676)    685
                    sb &= Int(.Merma).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695
                    sb &= Left(cero.ToString, 10).PadLeft(10) 'PBonHume	STRING(10)	Porcentaje bonificación humedad (dos (2) decimales))    696)    705
                    sb &= Left(cero.ToString, 10).PadLeft(10) 'KgsBonHu	STRING(10)	Kilos bonificación humedad)    706)    715



                    '46	PorZaran	10	Porcentaje zarandeo (dos (2) decimales)		Derecha	714
                    '47	KgsZaran	10	Kilos zarandeo (sin decimales)		Derecha	724
                    '48	PorDesca	10	Porcentaje descarte (dos (2) decimales)		Derecha	734
                    '49	KgsDesca	10	Kilogramos Descarte (Sin Decimales)		Derecha	744
                    '50	PorVolat	10	Porcentaje volátil (dos (2) decimales)		Derecha	754
                    '51	KgsVolat	10	Kilogramos volátil (sin decimales)		Derecha	764


                    'esto?
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorZaran	STRING(10)	Porcentaje zarandeo (dos (2) decimales))    716)    725
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsZaran	STRING(10)	Kilos zarandeo (sin decimales))    726)    735
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorDesca	STRING(10)	Porcentaje descarte (dos (2) decimales))    736)    745
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsDesca	STRING(10)	Kilogramos Descarte (Sin Decimales))    746)    755
                    sb &= Left(Val(cadenavacia).ToString, 10).PadLeft(10) 'PorVolat	STRING(10)	Porcentaje volátil (dos (2) decimales))    756)    765
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsVolat	STRING(10)	Kilogramos volátil (sin decimales))    766)    775




                    '52	CantBolsa	8	Cantidad de bolsas		Derecha	774
                    '53	Fumigada	1	Condición fumigada 0=no 1=si	*	Derecha	782
                    '54	PesoProcede	10	Peso procedencia (Sin Decimales)		Derecha	783
                    '55	Contrato	12	Número de contrato  (Numeros 0 al 9)		Derecha	793
                    '56	CarPorte	14	Número de Carta de Porte (Numeros  0 al 9)	*	Derecha	805




                    '57	TipoTrans	1	Tipo de transporte c=camión  v=vagón o=Otro	*	Izquierda	819
                    '58	Grado	10	Grado	*	Derecha	820
                    '59	Factor	10	Factor	*	Derecha	830
                    '60	Observac	100	Observaciones		Izquierda	840
                    '61	ConCalidad	4	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o                       Fuera de standart (FE)	*	Izquierda	940
                    '62	MovStock	1	Señal 1=Movió mercadería       0=No movió mercadería	*	Izquierda	944
                    '63	ObsAna	100	Observaciones Analisis		Izquierda	945



                    sb &= Left(cadenavacia.ToString, 8).PadLeft(8) 'CantBolsa	STRING(8)	Cantidad de bolsas)    776)    783
                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'Fumigada	STRING(1)	Condición fumigada 0=no 1=si)    784)    784



                    sb &= Int(.NetoProc).ToString.PadRight(10) 'PesoProcede	STRING(10)	Peso procedencia (Sin Decimales))    785)    794
                    'sb &= Int(.BrutoPto).ToString.PadRight(10) 'BrutoProcede	STRING(10)	Bruto procedencia (Sin Decimales))    795)    804
                    'sb &= Int(.TaraPto).ToString.PadRight(10) 'TaraProcede	STRING(10)	Tara procedencia (Sin Decimales))    805)    814



                    sb &= Left(Val(.Contrato).ToString, 12).PadRight(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826
                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= Left(.NumeroCartaDePorte.ToString, 14).PadLeft(14, "0") 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840
                    sb &= IIf(True, "c", "v").ToString.PadRight(1) 'TipoTrans	STRING(1)	Tipo de transporte c=camión  v=vagón o=Otro)    841)    841


                    If .IsNobleGradoNull Then .NobleGrado = 0
                    sb &= Left(Int(.NobleGrado).ToString, 10).PadLeft(10) 'Grado	STRING(10)	Grado)    842)    851
                    If .IsFactorNull Then .Factor = 0
                    sb &= Left(Int(.Factor).ToString, 10).PadLeft(10) 'Factor	STRING(10)	Factor)    852)    861

                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'Observac	STRING(100)	Observaciones)    862)    961


                    'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)
                    Dim sCalidad As String
                    If .IsCalidadNull Then .Calidad = ""
                    If InStr(.Calidad.ToString.ToLower, "grado 1") > 0 Then
                        sCalidad = "G1"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 2") > 0 Then
                        sCalidad = "G2"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 3") > 0 Then
                        sCalidad = "G3"
                    ElseIf InStr(.Calidad.ToString.ToLower, "camara") > 0 Then
                        sCalidad = "CC"
                    Else
                        sCalidad = "FE"
                    End If
                    sb &= sCalidad.PadRight(4) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'MovStock	STRING(1)	Señal 1=Movió mercadería)       0=No movió mercadería)    966)    966
                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'ObsAna	STRING(100)	Observaciones Analisis)    967)    1066













                    '68	DOCUME	1045	1055	S
                    sb &= JustificadoIzquierda(If(.IschoferCUITNull, "", .choferCUIT.Replace("-", "")), 11)













                    '66	CTATRANSPOR	1056	1066	N
                    sb &= JustificadoIzquierda(If(.IsTransportistaCUITNull, "", .TransportistaCUIT.Replace("-", "")), 11)



                    '/////////////////////////////////////////
                    'ensartado
                    '35	PATCHA	1067	1072	S    
                    sb &= JustificadoIzquierda(If(.IsPatenteNull, "", .Patente), 6)
                    '//////////////////////////////////////////

                    '69	PATACO	1073	1078	S
                    sb &= JustificadoIzquierda(If(.IsAcopladoNull, "", .Acoplado), 6)




                    sb &= Space(12)



                    '67	NOMCONDUC	1091	1120	S
                    sb &= JustificadoIzquierda(If(.IsChoferDescNull, "", .ChoferDesc), 30)



                    sb &= Space(13)



                    '70	KMSTIER	1134	1143	N
                    sb &= JustificadoIzquierda(0, 10)
                    '71	KMSASFA	1144	1153	N
                    sb &= JustificadoIzquierda(If(.IsKmARecorrerNull, 0, .KmARecorrer), 10)
                    '72	TARIKMS	1154	1163	N
                    sb &= JustificadoIzquierda(If(.IsTarifaNull, 0, .Tarifa), 10)  'cobran distinto los kilometros en tierra vs asfalto?
                    '73	TARITIE	1164	1173	N
                    sb &= JustificadoIzquierda(If(.IsTarifaNull, 0, .Tarifa), 10)



                    sb &= Space(17)


                    '64	NROCAU	1191	1205	N
                    sb &= JustificadoIzquierda(.CEE, 14)

                    sb &= Space(14)

                    '74	FECVTOCAU	1219	1226	S
                    sb &= JustificadoIzquierda(If(.IsFechaVencimientoNull, Nothing, .FechaVencimiento.ToString("ddMMyyyy")), 8)
                    '76	CTGNRO	1227	1234	N
                    sb &= JustificadoIzquierda(If(.IsCTGNull, 0, .CTG), 8)


                    sb &= Space(9)

                    '77	TIPORTA	1244	1244	N
                    sb &= JustificadoIzquierda(" ", 1)


                    sb &= Space(1)


                    '78	CODRTA	1246	1250	S
                    sb &= JustificadoIzquierda(If(.IsCEENull, "", .CEE), 5)
                    '79	NRO PLANTA ONCCA	1251	1257	N
                    sb &= JustificadoIzquierda(If(.IsDestinoCodigoONCAANull, "", .DestinoCodigoONCAA), 7)


                    If If(.IsDestinoCodigoONCAANull, "", .DestinoCodigoONCAA) = "" AndAlso InStr(sErroresDestinos, .DestinoDesc) = 0 Then
                        'si no tiene codigo ni está ya en sErrores, lo meto

                        ErrHandler.WriteError("Falta el codigo ONCCA para el destino " & .DestinoDesc)

                        sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & .Destino & """ target=""_blank"">" & .DestinoDesc & "</a>; "
                    End If






                    'Col    Nombre            Desde    Hasta      Dato
                    '79           NUMVAGON    1260             1270        N
                    sb &= "  "
                    sb &= JustificadoIzquierda(.SubnumeroVagon, 11)



                    PrintLine(nF, sb)
                End With
            Next




            FileClose(nF)


            sErrores = "Procedencias sin código ONCCA:<br/> " & sErroresProcedencia & "<br/>Destinos sin código ONCCA: <br/>" & sErroresDestinos

            If True Then
                If sErroresProcedencia <> "" Or sErroresDestinos <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If

            Return vFileName







        End Function

        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Public Shared Function FiltrarCopias(ByRef dt As DataTable)

        End Function

        Public Shared Function FiltrarCopias(ByRef ds As WillyInformesDataSet)

            '        Filtrar cartas duplicadas. no puedo filtrar por SubnumeroDeFacturacion>0 porque quizas el cliente forma parte de una de esas copias
            '       numerocarta(-vagon)



            '        WHERESSS = "SubnumeroDeFacturacion" como hacemos acá eh? porque 
            'quitar(copias) http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9468
        End Function

        Public Shared Function FiltrarCopiasW(ByRef ds As WillyInformesDataSet)

            '        Filtrar cartas duplicadas. no puedo filtrar por SubnumeroDeFacturacion>0 porque quizas el cliente forma parte de una de esas copias
            '       numerocarta(-vagon)



            '        WHERESSS = "SubnumeroDeFacturacion" como hacemos acá eh? porque 
            'quitar(copias) http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9468
        End Function

        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        Public Shared Function Sincronismo_ACA(ByVal SC As String, ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "", Optional ByRef sErrores As String = "") As String


            '        el sincro de A.C.A toma de varios clientes (ACA NAON, ACA SARASA). en lugar de usar CUIT, se les pasa un numero de cuenta
            '100001: A.C.A.EXPORTACION()
            '100002: A.C.A.CORREDOR()
            '100005: A.C.A.PTA.SAN(NICOLAS)





            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ' 
            '			Registro Standard Recibidores BIT	(para ACA)				'
            '									'
            'Orden	Nombre	Tipo	Long.	Descripción	Desde	Hasta	Requerido	Observacion	Justificacion
            '1	Grano	CHAR	3	Código de grano Sagpya	1	3	*	 	Izquierda
            '2	GranelBolsa	CHAR	3	Embalaje del grano 1=Granel 2=Bolsa	4	6	*	 	Derecha
            '3	Cosecha	CHAR	4	Cosecha 2000-2001 Ej: 0001	7	10	*	 	Izquierda
            '4	FecIng	CHAR	8	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001	11	18	*	 	Izquierda
            '5	HorIng	CHAR	8	Hora de entrada del camión Formato (HHMISS) ej:092556	19	26	*	 	Izquierda
            '6	FecSal	CHAR	8	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001	27	34	*	 	Izquierda
            '7	HorSal	CHAR	8	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556	35	42	*	 	Izquierda
            '8	CUITPuerto	CHAR	14	CUIT PUERTO	43	56	*	 	Izquierda
            '9	NomPuerto	CHAR	30	Nombre Puerto	57	86	*	 	Izquierda
            '10	CUITRecibidor	CHAR	14	CUIT Recibidor	87	100	*	 	Izquierda
            '11	NomRecibidor	CHAR	30	Nombre Recibidor	101	130	*	 	Izquierda
            '12	CUITComprador	CHAR	14	CUIT Comprador	131	144	*	 	Izquierda
            '13	NomComp	CHAR	30	Nombre Comprador	145	174	*	 	Izquierda
            '14	CUITCorrComp	CHAR	14	CUIT Corredor Comprador	175	188	*	 	Izquierda
            '15	NomCorrComp	CHAR	30	Nombre Corredor Comprador	189	218	*	 	Izquierda
            '16	CUITEntregador	CHAR	14	CUIT Entregador	219	232	*	 	Izquierda
            '17	NomEntregador	CHAR	30	Nombre Entregador	233	262	*	 	Izquierda
            '18	CUITCargador	CHAR	14	CUIT Cargador	263	276	*	 	Izquierda
            '19	NomCargador	CHAR	30	Nombre Cargador	277	306	*	 	Izquierda
            '20	CUITVendedor	CHAR	14	CUIT Vendedor	307	320	*	 	Izquierda
            '21	NomVendedor	CHAR	30	Nombre Vendedor	321	350	*	 	Izquierda
            '22	CUITCorrEndo	CHAR	14	CUIT  Corredor Endozo	351	364	 	 	Izquierda
            '23	NomCorrEndo	CHAR	30	Nombre Corredor Endozo	365	394	 	 	Izquierda
            '24	CUITCompEndo	CHAR	14	CUIT Comprador Endozo	395	408	 	 	Izquierda
            '25	NomCompEndo	CHAR	30	Nombre Comprador Endozo	409	438	 	 	Izquierda
            '26	CUITCorrVend	CHAR	14	CUIT Corredor Vendedor.	439	452	*	 	Izquierda
            '27	NomCorrVend	CHAR	30	Nombre Corredor Vendedor	453	482	*	 	Izquierda
            '28	CUITPlantaOrigen	CHAR	14	CUIT Planta Origen	483	496	*	 	Izquierda
            '29	NomPlantaOrigen	CHAR	30	Nombre Planta Origen	497	526	*	 	Izquierda
            '30	CPPorcede	CHAR	8	Código Postal Procedencia	527	534	*	 	Izquierda
            '31	NomProcede	CHAR	30	Nombre Procedencia	535	564	*	 	Izquierda
            '32	CPDestino	CHAR	8	Código Postal Destino	565	572	*	 	Izquierda
            '33	NomDestino	CHAR	30	Nombre Destino	573	602	*	 	Izquierda
            '34	CodMovIE	CHAR	1	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr	603	603	*	 	Derecha
            '35	PatCha	CHAR	10	Patente chasis	604	613	 	 	Izquierda
            '36	PesoBrut	CHAR	10	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.	614	623	*	 	Derecha
            '37	PesoEgre	CHAR	10	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales	624	633	*	 	Derecha
            '38	PesoNeto	CHAR	10	Total bruto(PesoBrut-PesoEgre) (sin decimales)	634	643	*	 	Derecha
            '39	TotMerm	CHAR	10	Total mermas (Total mermas sin decimales)	644	653	 	1	Derecha
            '40	TotNeto	CHAR	10	Total neto ((Camión cargado – Tara)- Total mermas) (sin decimales)	654	663	*	 	Derecha
            '41	PorHume	CHAR	10	Porcentaje humedad (un (1) decimal)	664	673	 	2	Derecha
            '42	PorMemaHumedad	CHAR	10	Porcentaje merma humedad (dos (2) decimales)	674	683	 	2	Derecha
            '43	KgsHume	CHAR	10	Kilos humedad (sin decimales)	684	693	 	2	Derecha
            '44	PBonHume	CHAR	10	Porcentaje bonificación humedad (dos (2) decimales)	694	703	 	3	Derecha
            '45	KgsBonHu	CHAR	10	Kilos bonificación humedad	704	713	 	3	Derecha
            '46	PorZaran	CHAR	10	Porcentaje zarandeo (dos (2) decimales)	714	723	 	4	Derecha
            '47	KgsZaran	CHAR	10	Kilos zarandeo (sin decimales)	724	733	 	4	Derecha
            '48	PorDesca	CHAR	10	Porcentaje descarte (dos (2) decimales)	734	743	 	5	Derecha
            '49	KgsDesca	CHAR	10	Kilogramos Descarte (Sin Decimales)	744	753	 	5	Derecha
            '50	PorVolat	CHAR	10	Porcentaje volátil (dos (2) decimales)	754	763	 	6	Derecha
            '51	KgsVolat	CHAR	10	Kilogramos volátil (sin decimales)	764	773	 	6	Derecha
            '52	CantBolsa	CHAR	8	Cantidad de bolsas	774	781	 	 	Derecha
            '53	Fumigada	CHAR	1	Condición fumigada 0=no 1=si	782	782	*	 	Derecha
            '54	PesoProcede	CHAR	10	Peso procedencia (Sin Decimales)	783	792	 	 	Derecha
            '55	Contrato	CHAR	12	Número de contrato  (Numeros 0 al 9)	793	804	 	 	Derecha
            '56	CarPorte	CHAR	14	Número de Carta de Porte (Numeros  0 al 9)	805	818	*	 	Derecha
            '57	TipoTrans	CHAR	1	Tipo de transporte c=camión  v=vagón o=Otro	819	819	*	 	Izquierda
            '58	Grado	CHAR	10	Grado	820	829	*	 	Derecha
            '59	Factor	CHAR	10	Factor	830	839	*	 	Derecha
            '60	Observac	CHAR	100	Observaciones	840	939	 	 	Izquierda
            '61	ConCalidad	CHAR	4	Condición Calidad Grado(G1,G2 o G3), Conforme(CO),  Camara(CC) o Fuera de standart (FE)	940	943	*	 	'Izquierda
            '62	MovStock	CHAR	1	Señal 1=Movió mercadería       0=No movió mercadería	944	944	*	 	Izquierda
            '63	ObsAna	CHAR	100	Observaciones Analisis	945	1044	 	 	Izquierda'''
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "HPESA_ACA_" & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            Dim sErroresProcedencia, sErroresDestinos As String


            '        el sincro de A.C.A toma de varios clientes (ACA NAON, ACA SARASA). en lugar de usar CUIT, se les pasa un numero de cuenta
            '100001: A.C.A.EXPORTACION()
            '100002: A.C.A.CORREDOR()
            '100005: A.C.A.PTA.SAN(NICOLAS)

            ' en Williams los meten en los campos de cliente (los vi en el remcomercial y intermediario, y tambien en el titular)
            '-sí, pero no hay necesidad de hacerse drama, porque en esos casos tambien ponen el corredor en A.C.A LMTDA

            Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
            Dim clientesACA = (From c In db.linqClientes Where c.RazonSocial.StartsWith("A.C.A") Select c.IdCliente).ToList





            'Dim a = pDataTable(1)


            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0




                    If clientesACA.Contains(.Vendedor) Or clientesACA.Contains(.IdArticulo) Then
                        '        el sincro de A.C.A toma de varios clientes (ACA NAON, ACA SARASA). en lugar de usar CUIT, se les pasa un numero de cuenta
                        'BuscaIdChoferPrecisoConCUIT=
                    End If


                    '                    Grano	Texto	1	3	Falta Dato
                    'GranelBolsa	Entero largo	4	3	
                    'Cosecha	Entero largo	7	4	Esta todo en 0 - Falta Dato
                    'FecIng	Fecha/Hora	11	8	No respeta formato DDMMAAAA
                    'HorIng	Texto	19	8	
                    'FechSal	Fecha/Hora	27	8	No respeta formato DDMMAAAA
                    'HorSal	Texto	35	8	
                    'CUITPuerto	Texto	43	14	Falta Dato
                    'NomPuerto	Texto	57	30	No respeta largo dato





                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11216
                    '                    Con respecto al archivo de datos que nos están enviando para la carga automática de Cartas de Porte, hice un análisis y habría que hacer las siguientes modificaciones para ir optimizando el mismo:

                    'Campo 2 GranelBolsa: Viene en formato alfanumérico (posición izquierda) y va numérico (derecha)

                    'Campo 8 CUITPuerto: Falta poner el CUIT, describo los mismos de los puertos de Bahía Blanca:
                    '                                         33-50223222-9   Puerto Oleaginosa Moreno (Galván)
                    '                                         30-62197317-3   Puerto U.T.E. (Actiar SRL)
                    '                                         30-50679216-5   Puerto Cargill
                    '                                         30-66016810-5   Puerto Terminal Bahía Blanca (TBB)
                    '                                         30-52671272-9   Puerto L.D.C. (Louis Dreyfus)

                    'Campo 12 CUITComprador: Cuando el comprador es ACA Exportación no va número de CUIT, va el código 100001 (Código de nuestros sistemas de ACA Exp.)
                    '                                           Si el comprador es un Tercero o Cooperativa va el CUIT.

                    'Campo 14 CUITCorrComp: Cuando el Corredor Comprador es ACA no va número de CUIT, va el código 100002 (Código de nuestros sistemas de ACA Corredor)
                    '                                           Si el Corredor Comprador es un Tercero  va el CUIT.

                    'Campo 18 CUITCargador: En el caso que el Cargador sea un CDC de la A.C.A., no va el CUIT de A.C.A., va el código de A.C.A. del CDC, en vuestro caso son:
                    '100066:             CDC(c.M.NAON)
                    '100067:             CDC(PEHUAJO)
                    '                                         Si es una Cooperativa o un Tercero, va el CUIT.
                    '                                         En caso que el cereal vaya a una acondicionadora, no hay que poner el CUIT de la Acondicionadora, siempre se toma la
                    '                           Procedencia de la mercadería, o sea el código del CDC o el CUIT de la Coop. o del Tercero (la Acondicionadora no figura
                    '                                         en los negocios de la ACA)

                    'Campo 20 CUITVendedor: En el caso que el Vendedor sea un CDC de la A.C.A., no va el CUIT, va el código de A.C.A. del CDC, en vuestro caso son:
                    '100066:             CDC(c.M.NAON)
                    '100067:             CDC(PEHUAJO)
                    '                                         Si es una Cooperativa o un Tercero, va el CUIT.

                    'Campo 22 CUITCorrEndo: Cuando el Corredor Endozo es ACA no va número de CUIT, va el código 100002 (Código de nuestros sistemas de ACA Corredor)
                    '                                           Si el Corredor Endozo es un Tercero va el CUIT.

                    'Campo 24 CUITCompEndo: Cuando el Comprador Endozo es ACA no va número de CUIT, va el código 100001 (Código de nuestros sistemas de ACA Export.)
                    '                                           Si el Comprador Endozo es un Tercero va el CUIT.

                    'Campo 26 CUITCorrVend: Cuando el Corredor Vendedor es ACA no va número de CUIT, va el código 100002 (Código de nuestros sistemas de ACA Corredor)
                    '                                           Si el Corredor Vendedor es un Tercero va el CUIT.

                    'Campo 28 CUITPlantaOrigen: Esta viniendo el CUIT y Nombre del Puerto de descarga, y tendría que venir si es un CDC de la A.C.A., el código de A.C.A. de la
                    '                                              Planta del CDC, en vuestro caso son:
                    '                                                 100102 PLANTA CDC C. M. NAON
                    '                                 100104 PLANTA CDC PEHUAJO
                    '                                         Si es una Cooperativa o un Tercero, va el CUIT.

                    'Campo 39 TotMerm: Viene en formato alfanumérico (con 0(cero) en todas las posiciones)  y va numérico (solo valor a la derecha si hay merma)

                    'Campo 54 PesoProcede: Viene en formato alfanumérico (izquierda)  y va numérico (derecha)

                    'Campo 55 Contrato: Viene en formato alfanumérico (izquierda)  y va numérico (derecha)

                    'Campo 56 CarPorte: Viene en formato alfanumérico (con ceros a la izquierda)  y va numérico (solo numero C.P. a la derecha)
                    '                               Las cartas de porte de vagón deben venir de la siguiente forma, 8 dígitos CP + 6 dígitos Nro. vagón
                    '                                   Ej. CP 525971853 Nro. vagón 854547, la CP a cargar es  25971853854547 (si el numero de vagón tiene solo 5 dígitos se le
                    '                                    agrega un cero a la izquierda para completar la 6 posiciones)

                    'Campo 57 TipoTrans: La cartas de Porte de vagón vienen con una “c” y corresponde “v”.

                    'Campo 61 ConCalidad: Poner siempre la condición “CC” Condición Cámara.

                    'Adjunto el archivo de Uds. que controle y un archivo Word con la descripción original del formato de archivo, del cual la única modificación que se hizo fue la composición del las Cartas de Porte de vagón, ver modificación campo 56.



                    sb &= .CodigoSAJPYA.PadRight(3) 'Grano	STRING(3)	Código de grano Sagpya)    1)    3
                    sb &= IIf(True, 1, 2).ToString.PadLeft(3) 'GranelBolsa	STRING(3)	Embalaje del grano 1=Granel 2=Bolsa)    4)    6

                    sb &= Right(.Cosecha, 5).Replace("/", "").PadLeft(4)


                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= .FechaArribo.ToString("ddMMyyyy")       'FecIng	STRING(8)	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001)    11)    18


                    If .IsHoraNull Then
                        sb &= #12:00:00 AM#.ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    Else
                        sb &= Convert.ToDateTime(.Hora).ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    End If


                    sb &= "  "

                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= .FechaDescarga.ToString("ddMMyyyy")  'FecSal	STRING(8)	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001)    27)    34
                    sb &= Convert.ToDateTime(iisNull(.FechaDescarga, #12:00:00 AM#)).ToString("hhmmss") 'HorSal	STRING(8)	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556)    35)    42


                    sb &= "  "




                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular
                    'Corredor Endozo		    ?
                    'Comprador Endozo		    ?
                    'Corredor Vendedor		    ?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""




                    'Comentan que en los siguientes campos se debe mandar (en los 
                    'tres campos) el Intermediario y en 
                    ' caso que no haya Intermediario, en los tres casos el Titular: NomCargador NomCompEndo NomVendedor 
                    If .IntermediarioCUIT = "" Then
                        .IntermediarioCUIT = .TitularCUIT
                        .IntermediarioDesc = .TitularDesc
                    Else
                        Debug.Print(.IntermediarioCUIT)
                    End If


                    Try
                        If .TitularDesc = "DIRECTO" Then
                            .IntermediarioDesc = ""
                            .IntermediarioCUIT = ""
                        End If
                        If .IntermediarioDesc = "DIRECTO" Then
                            .IntermediarioDesc = ""
                            .IntermediarioCUIT = ""
                        End If
                        If .RComercialDesc = "DIRECTO" Then
                            .RComercialDesc = ""
                            .RComercialCUIT = ""
                        End If
                        If .CorredorDesc = "DIRECTO" Then
                            .CorredorDesc = ""
                            .CorredorCUIT = ""
                        End If
                        If .DestinatarioDesc = "DIRECTO" Then
                            .DestinatarioDesc = ""
                            .DestinatarioCUIT = ""
                        End If
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try






                    'kkkkk(): Falta poner el CUIT, describo los mismos de los puertos de Bahía Blanca:

                    If If(.IsDestinoCUITNull, "", .DestinoCUIT) = "" AndAlso InStr(sErroresDestinos, .DestinoDesc) = 0 Then
                        'si no tiene codigo ni está ya en sErrores, lo meto

                        ErrHandler.WriteError("Falta el CUIT del destino " & .DestinoDesc)

                        sErroresDestinos &= "<a href=""CDPDestinos.aspx?Id=" & .Destino & """ target=""_blank"">" & .DestinoDesc & "</a>; "
                    End If


                    sb &= Left(.DestinoCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPuerto	STRING(30)	Nombre Puerto)    57)    86




                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130



                    'Campo 12 CUITComprador: Cuando el comprador es ACA Exportación no va número de CUIT, va el código 100001 (Código de nuestros sistemas de ACA Exp.)
                    '                       Si el comprador es un Tercero o Cooperativa va el CUIT.

                    If .DestinatarioCUIT.ToString.Replace("-", "") = "30500120882" Then .DestinatarioCUIT = 100001

                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

                    '///////////////////////////////////////////////////
                    ' acá va BLD S.A.                      30707386076

                    'Campo 14 CUITCorrComp: Cuando el Corredor Comprador es ACA no va número de CUIT, va el código 100002 (Código de nuestros sistemas de ACA Corredor)
                    '                                           Si el Corredor Comprador es un Tercero  va el CUIT.

                    If .CorredorCUIT.ToString.Replace("-", "") = "30500120882" Then .CorredorCUIT = 100002

                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218
                    '////////////////////////////////////////////////////

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Entregador
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomEntregador	STRING(30)	Nombre Entregador)   

                    '////////////////////////////////////////////////////////////////////////////////
                    'Strongly Typed DataSets encountering NULL values – Grrrrrr… 
                    'http://social.msdn.microsoft.com/forums/en-US/winformsdatacontrols/thread/1dad8d0d-6eae-4254-a9d6-22d50da5578a
                    '////////////////////////////////////////////////////////////////////////////////



                    'Campo 18 CUITCargador: En el caso que el Cargador sea un CDC de la A.C.A., no va el CUIT de A.C.A., va el código de A.C.A. del CDC, en vuestro caso son:
                    '100066:             CDC(c.M.NAON)
                    '100067:             CDC(PEHUAJO)
                    '                                         Si es una Cooperativa o un Tercero, va el CUIT.
                    '                                         En caso que el cereal vaya a una acondicionadora, no hay que poner el CUIT de la Acondicionadora, siempre se toma la
                    '                           Procedencia de la mercadería, o sea el código del CDC o el CUIT de la Coop. o del Tercero (la Acondicionadora no figura
                    '                                         en los negocios de la ACA)
                    If .CorredorCUIT.ToString.Replace("-", "") = "30500120882" Then
                        sb &= CodigosACA_CodigoYNombre(.EnumSyngentaDivision)
                    Else
                        sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCargador	STRING(14)	CUIT Cargador)    263)  
                        sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30)   'NomCargador 	STRING(30)	Nombre Cargador)    277)    306
                    End If





                    'en "Vendedor" les pasaba el RemComercial. Pidieron que les pasemos el titular por acá (se filtró usando "SYNGENTA" en RemComercial, y
                    ' y parece que no les gustó que apareciera SYNGENTA en el sincro

                    'Campo 20 CUITVendedor: En el caso que el Vendedor sea un CDC de la A.C.A., no va el CUIT, va el código de A.C.A. del CDC, en vuestro caso son:
                    '100066:             CDC(c.M.NAON)
                    '100067:             CDC(PEHUAJO)
                    '                                        Si es una Cooperativa o un Tercero, va el CUIT.
                    If .CorredorCUIT.ToString.Replace("-", "") = "30500120882" Then
                        sb &= CodigosACA_CodigoYNombre(.EnumSyngentaDivision)
                    Else
                        sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                        sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350
                    End If







                    'Campo 22 CUITCorrEndo: Cuando el Corredor Endozo es ACA no va número de CUIT, va el código 100002 (Código de nuestros sistemas de ACA Corredor)
                    '                                           Si el Corredor Endozo es un Tercero va el CUIT.

                    'Campo 24 CUITCompEndo: Cuando el Comprador Endozo es ACA no va número de CUIT, va el código 100001 (Código de nuestros sistemas de ACA Export.)
                    '                                           Si el Comprador Endozo es un Tercero va el CUIT.

                    'Campo 26 CUITCorrVend: Cuando el Corredor Vendedor es ACA no va número de CUIT, va el código 100002 (Código de nuestros sistemas de ACA Corredor)
                    '                                           Si el Corredor Vendedor es un Tercero va el CUIT.


                    If .CorredorCUIT.ToString.Replace("-", "") = "30500120882" Then .CorredorCUIT = 100002
                    If .IntermediarioCUIT.ToString.Replace("-", "") = "30500120882" Then .IntermediarioCUIT = 100001

                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrEndo	STRING(14)	CUIT  Corredor Endozo)    351)    364
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrEndo	STRING(30)	Nombre Corredor Endozo)    365)    394


                    sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCompEndo	STRING(14)	CUIT Comprador Endozo)    395)    408
                    sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30) 'NomCompEndo	STRING(30)	Nombre Comprador Endozo)    409)    438


                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrVend	STRING(14)	CUIT Corredor Vendedor.)    439)    452
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrVend	STRING(30)	Nombre Corredor Vendedor)    453)    482



                    'Campo 28 CUITPlantaOrigen: Esta viniendo el CUIT y Nombre del Puerto de descarga, y tendría que venir si es un CDC de la A.C.A., el código de A.C.A. de la
                    '             Planta del CDC, en vuestro caso son:  
                    '100102 PLANTA CDC C. M. NAON
                    '100104 PLANTA CDC PEHUAJO
                    '        Si es una Cooperativa o un Tercero, va el CUIT.

                    '#8559 consulta
                    If .IsEnumSyngentaDivisionNull Then .EnumSyngentaDivision = ""
                    If .EnumSyngentaDivision <> "" Then
                        sb &= CodigosACA_Planta(.EnumSyngentaDivision)
                    Else
                        sb &= Left(.TitularCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITPlantaOrigen	STRING(14)	CUIT Planta Origen)    483)    496
                        sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPlantaOrigen	STRING(30)	Nombre Planta Origen)    497)    526
                    End If





                    'CPProcede	Texto	527	8	Falta Dato
                    'NomProcede	Texto	535	30	Falta Dato
                    'CPDestino	Texto	565	8	
                    'NomDestino	Texto	573	30	
                    'CodMovIE	Texto	603	1	


                    sb &= Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
                    sb &= Left(.ProcedenciaDesc.ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
                    sb &= Left(.DestinoCodigoPostal.ToString, 8).PadRight(8) 'CPDestino	STRING(8)	Código Postal Destino)    565)    572
                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602




                    'Viene un 1 en el TXT, deben enviar un 0.
                    sb &= IIf(False, 1, 0).ToString.PadRight(1) 'CodMovIE	STRING(1)	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr)    603)    603
                    sb &= Left(.Patente.ToString, 6).PadRight(10) 'PatCha	STRING(6)	Patente chasis)    604)    609
                    'sb &= Left(.Acoplado.ToString, 6).PadRight(6) 'PatAcoplado	STRING(6)	Acoplado chasis)    610)    615




                    '36	PesoBrut	10	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.	*	Derecha	614
                    '37	PesoEgre	10	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales	*	Derecha	624
                    '38	PesoNeto	10	Total bruto(PesoBrut-PesoEgre) (sin decimales)	*	Derecha	634
                    '39	TotMerm	10	Total mermas (Total mermas sin decimales)		Derecha	644












                    'https://mail.google.com/mail/#label/Sincros/136a3190360d2620
                    'En la posición 36 que es PESOBRUT va el bruto real del camión. Lo que pesó en destino.
                    'En la posición 37 que es PESOEGRE va la tara real del camión. Lo que pesó en destino.
                    'En la posición 38 que es PESONETO va el PESOBRUT – PESOEGRE
                    'En la posición 40 que es TOTNETO va el neto final, es decir el PESONETO – el total de mermas. Por lo que vos me ponés, aca irían los 29860 kls. Los kilos procedencia por el momento no serian importante.


                    '.BrutoPto
                    '.TaraPto
                    '.NetoPto
                    '.BrutoFinal
                    '.TaraFinal
                    '.NetoFinal
                    '.NetoProc

                    sb &= Int(.BrutoFinal).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= Int(.TaraFinal).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= Int(.NetoFinal).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645

                    'Campo 39 TotMerm: Viene en formato alfanumérico (con 0(cero) en todas las posiciones)  y va numérico (solo valor a la derecha si hay merma)
                    'sb &= Int(.Merma).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655
                    sb &= Int(.NetoFinal - .NetoProc).ToString.PadLeft(10, " ")

                    '40	TotNeto	10	Total neto ((Camión cargado – Tara)- Total mermas) (sin decimales)	*	Derecha	654

                    sb &= Int(.NetoProc).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665







                    '41	PorHume	10	Porcentaje humedad (un (1) decimal)		Derecha	664
                    '42	PorMemaHumedad	10	Porcentaje merma humedad (dos (2) decimales)		Derecha	674
                    '43	KgsHume	10	Kilos humedad (sin decimales)		Derecha	684
                    '44	PBonHume	10	Porcentaje bonificación humedad (dos (2) decimales)		Derecha	694
                    '45	KgsBonHu	10	Kilos bonificación humedad		Derecha	704

                    sb &= String.Format("{0:F1}", .Humedad).PadLeft(10) 'PorHume	STRING(10)	Porcentaje humedad (un (1) decimal))    666)    675
                    sb &= cero.ToString.PadLeft(10) 'PorMemaHumedad	STRING(10)	Porcentaje merma humedad (dos (2) decimales))    676)    685


                    sb &= Int(.HumedadDesnormalizada).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695



                    sb &= Left(cero.ToString, 10).PadLeft(10) 'PBonHume	STRING(10)	Porcentaje bonificación humedad (dos (2) decimales))    696)    705
                    sb &= Left(cero.ToString, 10).PadLeft(10) 'KgsBonHu	STRING(10)	Kilos bonificación humedad)    706)    715



                    '46	PorZaran	10	Porcentaje zarandeo (dos (2) decimales)		Derecha	714
                    '47	KgsZaran	10	Kilos zarandeo (sin decimales)		Derecha	724
                    '48	PorDesca	10	Porcentaje descarte (dos (2) decimales)		Derecha	734
                    '49	KgsDesca	10	Kilogramos Descarte (Sin Decimales)		Derecha	744
                    '50	PorVolat	10	Porcentaje volátil (dos (2) decimales)		Derecha	754
                    '51	KgsVolat	10	Kilogramos volátil (sin decimales)		Derecha	764


                    'esto?
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorZaran	STRING(10)	Porcentaje zarandeo (dos (2) decimales))    716)    725
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsZaran	STRING(10)	Kilos zarandeo (sin decimales))    726)    735
                    sb &= cadenavacia.ToString.PadLeft(10) 'PorDesca	STRING(10)	Porcentaje descarte (dos (2) decimales))    736)    745
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsDesca	STRING(10)	Kilogramos Descarte (Sin Decimales))    746)    755
                    sb &= Left(Val(cadenavacia).ToString, 10).PadLeft(10) 'PorVolat	STRING(10)	Porcentaje volátil (dos (2) decimales))    756)    765
                    sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsVolat	STRING(10)	Kilogramos volátil (sin decimales))    766)    775




                    '52	CantBolsa	8	Cantidad de bolsas		Derecha	774
                    '53	Fumigada	1	Condición fumigada 0=no 1=si	*	Derecha	782
                    '54	PesoProcede	10	Peso procedencia (Sin Decimales)		Derecha	783
                    '55	Contrato	12	Número de contrato  (Numeros 0 al 9)		Derecha	793
                    '56	CarPorte	14	Número de Carta de Porte (Numeros  0 al 9)	*	Derecha	805




                    '57	TipoTrans	1	Tipo de transporte c=camión  v=vagón o=Otro	*	Izquierda	819
                    '58	Grado	10	Grado	*	Derecha	820
                    '59	Factor	10	Factor	*	Derecha	830
                    '60	Observac	100	Observaciones		Izquierda	840
                    '61	ConCalidad	4	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o                       Fuera de standart (FE)	*	Izquierda	940
                    '62	MovStock	1	Señal 1=Movió mercadería       0=No movió mercadería	*	Izquierda	944
                    '63	ObsAna	100	Observaciones Analisis		Izquierda	945




                    sb &= Left(cadenavacia.ToString, 8).PadLeft(8) 'CantBolsa	STRING(8)	Cantidad de bolsas)    776)    783
                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'Fumigada	STRING(1)	Condición fumigada 0=no 1=si)    784)    784



                    'Campo 54 PesoProcede: Viene en formato alfanumérico (izquierda)  y va numérico (derecha)
                    sb &= Int(.NetoProc).ToString.PadLeft(10) 'PesoProcede	STRING(10)	Peso procedencia (Sin Decimales))    785)    794

                    'sb &= Int(.BrutoPto).ToString.PadRight(10) 'BrutoProcede	STRING(10)	Bruto procedencia (Sin Decimales))    795)    804
                    'sb &= Int(.TaraPto).ToString.PadRight(10) 'TaraProcede	STRING(10)	Tara procedencia (Sin Decimales))    805)    814



                    'Campo 55 Contrato: Viene en formato alfanumérico (izquierda)  y va numérico (derecha)
                    sb &= Left(Val(.Contrato).ToString, 12).PadLeft(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826


                    'Campo 56 CarPorte: Viene en formato alfanumérico (con ceros a la izquierda)  y va numérico (solo numero C.P. a la derecha)
                    '           Las cartas de porte de vagón deben venir de la siguiente forma, 8 dígitos CP + 6 dígitos Nro. vagón
                    '               Ej. CP 525971853 Nro. vagón 854547, la CP a cargar es  25971853854547 (si el numero de vagón tiene solo 5 dígitos se le
                    '                agrega un cero a la izquierda para completar la 6 posiciones)

                    'ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= Left(.NumeroCartaDePorte.ToString, 8).PadLeft(8, " ") _
                    & Left(.SubnumeroVagon.ToString, 6).PadLeft(6, "0") 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840

                    'Campo 57 TipoTrans: La cartas de Porte de vagón vienen con una “c” y corresponde “v”.
                    sb &= IIf(.SubnumeroVagon = 0, "c", "v").ToString.PadRight(1) 'TipoTrans	STRING(1)	Tipo de transporte c=camión  v=vagón o=Otro)    841)    841



                    sb &= Left(Int(.NobleGrado).ToString, 10).PadLeft(10) 'Grado	STRING(10)	Grado)    842)    851


                    sb &= Left(Int(.Factor).ToString, 10).PadLeft(10) 'Factor	STRING(10)	Factor)    852)    861

                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'Observac	STRING(100)	Observaciones)    862)    961


                    'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)
                    Dim sCalidad As String
                    If InStr(.Calidad.ToString.ToLower, "grado 1") > 0 Then
                        sCalidad = "G1"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 2") > 0 Then
                        sCalidad = "G2"
                    ElseIf InStr(.Calidad.ToString.ToLower, "grado 3") > 0 Then
                        sCalidad = "G3"
                    ElseIf InStr(.Calidad.ToString.ToLower, "camara") > 0 Then
                        sCalidad = "CC"
                    Else
                        sCalidad = "FE"
                    End If
                    'Campo 61 ConCalidad: Poner siempre la condición “CC” Condición Cámara.
                    sCalidad = "CC"
                    sb &= sCalidad.PadRight(4) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



                    sb &= IIf(True, 0, 1).ToString.PadRight(1) 'MovStock	STRING(1)	Señal 1=Movió mercadería)       0=No movió mercadería)    966)    966
                    sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'ObsAna	STRING(100)	Observaciones Analisis)    967)    1066






                    If False Then


                        '68	DOCUME	1045	1055	S
                        sb &= JustificadoIzquierda(If(.IschoferCUITNull, "", .choferCUIT.Replace("-", "")), 11)

                        '66	CTATRANSPOR	1056	1066	N
                        sb &= JustificadoIzquierda(If(.IsTransportistaCUITNull, "", .TransportistaCUIT.Replace("-", "")), 11)

                        '/////////////////////////////////////////
                        'ensartado
                        '35	PATCHA	1067	1072	S    
                        sb &= JustificadoIzquierda(If(.IsPatenteNull, "", .Patente), 6)
                        '//////////////////////////////////////////

                        '69	PATACO	1073	1078	S
                        sb &= JustificadoIzquierda(If(.IsAcopladoNull, "", .Acoplado), 6)

                        sb &= Space(12)

                        '67	NOMCONDUC	1091	1120	S
                        sb &= JustificadoIzquierda(If(.IsChoferDescNull, "", .ChoferDesc), 30)



                        sb &= Space(13)



                        '70	KMSTIER	1134	1143	N
                        sb &= JustificadoIzquierda(0, 10)
                        '71	KMSASFA	1144	1153	N
                        sb &= JustificadoIzquierda(If(.IsKmARecorrerNull, 0, .KmARecorrer), 10)
                        '72	TARIKMS	1154	1163	N
                        sb &= JustificadoIzquierda(If(.IsTarifaNull, 0, .Tarifa), 10)  'cobran distinto los kilometros en tierra vs asfalto?
                        '73	TARITIE	1164	1173	N
                        sb &= JustificadoIzquierda(If(.IsTarifaNull, 0, .Tarifa), 10)



                        sb &= Space(17)


                        '64	NROCAU	1191	1205	N
                        sb &= JustificadoIzquierda(.CEE, 14)

                        sb &= Space(14)

                        '74	FECVTOCAU	1219	1226	S
                        sb &= JustificadoIzquierda(If(.IsFechaVencimientoNull, Nothing, .FechaVencimiento.ToString("ddMMyyyy")), 8)
                        '76	CTGNRO	1227	1234	N
                        sb &= JustificadoIzquierda(If(.IsCTGNull, 0, .CTG), 8)


                        sb &= Space(9)

                        '77	TIPORTA	1244	1244	N
                        sb &= JustificadoIzquierda(" ", 1)


                        sb &= Space(1)


                        '78	CODRTA	1246	1250	S
                        sb &= JustificadoIzquierda(If(.IsCEENull, "", .CEE), 5)
                        '79	NRO PLANTA ONCCA	1251	1257	N
                        sb &= JustificadoIzquierda(If(.IsDestinoCodigoONCAANull, "", .DestinoCodigoONCAA), 7)


                    End If







                    PrintLine(nF, sb)
                End With
            Next


            FileClose(nF)



            sErrores = "<br/>Destinos sin CUIT: <br/>" & sErroresDestinos

            If True Then
                If sErroresProcedencia <> "" Or sErroresDestinos <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If

            Return vFileName


            'Return TextToExcel(vFileName, titulo)
        End Function



        Private Shared Function CodigosACA_Planta(EnumSygentaACA As String) As String


            Select Case EnumSygentaACA
                Case "CDC Pehua.", "CDC Olavar", "CDC Naon", "CDC G.Vill", "CDC Iriart", "CDC Wright"
                    Return "100102"
                Case Else
                    Return ""
            End Select
            '100102 PLANTA CDC C. M. NAON
            '100104 PLANTA CDC PEHUAJO




        End Function


        Private Shared Function CodigosACA_CodigoYNombre(EnumSygentaACA As String) As String

            '100066:             CDC(c.M.NAON)
            '100067:             CDC(PEHUAJO)


            Return ""

        End Function





        Public Shared Function Sincronismo_ReyserCalidades(ByVal SC As String, ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String

            '            Nombre(RESULTA.TXT)
            '            Tipo(ASCII)
            'Longitud de registro	71

            'Descripción del registro

            'Nombre	             Longitud      Desde    Hasta	Tipo de Dato
            'Fecha	de descarga		6	1	6	N	ddmmaa
            'Carta de porte			11	7	17	N	
            'Número de resultado		2	18	19	N
            'Código de ensayo		5	20	24	N
            'Resultado del ensayo		7	25	31	N
            'Kilos  				7	32	38	N
            'Cereal 				2	39	40	N
            'Número de Vagón		8	41	48	N
            'Importe de honorarios		9	49	57	N
            'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja
            'Total de bonificación o rebaja	5	59	63	N	
            'Fuera de standard		1	64	64	A	S-Si	N-No
            'Número de certificado		7	65	71	N	





            'Número de resultado 2 18 19 N Número de certificado 7 65 71 N Con estos datos agreguen un nro correlativo y único, que identifique al análisis y listo, puede ser una numeración interna de Uds. respetando siempre las longitudes de datos del diseño. 
            'Importe de honorarios 9 49 57 N Envíen 0 en los honorarios sino es de la operatoria de Williams. Los honorarios son de la cámara porque la misma cobra por cada análisis. 
            'Bonifica o Rebaja 1 58 58 A B-Bonifica R-Rebaja Esto es clave, por ejemplo el ítems de “Materias extrañas”, bonifica o rebaja, por ejemplo el valor 1.5 cargado en este ítems es Bonifica o Rebaja?. 
            'Total de bonificación o rebaja 5 59 63 N Envíen 0 
            'Fuera de standard 1 64 64 A S-Si N-No Esto es si una calidad mala es S, esto significa que no sirve la calidad. Normalmente viene en N Saludos.-"



            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroReyserCalidades " & Now.ToString("ddMMMyyyy_HHmmss") & ".csv" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow



            Dim id_trigocandeal = BuscaIdArticuloPreciso("TRIGO CANDEAL", SC) 'pan y forrajero
            Dim id_trigopan = BuscaIdArticuloPreciso("TRIGO PAN", SC) 'pan y forrajero
            Dim id_trigoforraj = BuscaIdArticuloPreciso("TRIGO FORRAJERO", SC) 'pan y forrajero

            Dim id_soja = BuscaIdArticuloPreciso("SOJA", SC)
            Dim id_sorgo = BuscaIdArticuloPreciso("SORGO GRANIFERO", SC)
            Dim id_maiz = BuscaIdArticuloPreciso("MAIZ", SC)
            Dim id_girasol = BuscaIdArticuloPreciso("GIRASOL", SC)




            PrintLine(nF, "CartaPorte;IdRubro;DRubro;ResFinal;")

            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0




                    'Nombre	             Longitud      Desde    Hasta	Tipo de Dato
                    'Fecha	de descarga		6	1	6	N	ddmmaa
                    'Carta de porte			11	7	17	N	
                    'Número de resultado		2	18	19	N
                    'Código de ensayo		5	20	24	N
                    'Resultado del ensayo		7	25	31	N
                    'Kilos  				7	32	38	N
                    'Cereal 				2	39	40	N
                    'Número de Vagón		8	41	48	N
                    'Importe de honorarios		9	49	57	N
                    'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja
                    'Total de bonificación o rebaja	5	59	63	N	
                    'Fuera de standard		1	64	64	A	S-Si	N-No
                    'Número de certificado		7	65	71	N	

                    '                                               Nombre	              Lon  Desde Hasta	Tipo de Dato





                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    'consulta AMAGGI
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7963
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////

                    If .IsFueraDeEstandarNull Then .FueraDeEstandar = 0
                    If .IsCalidadMermaChamicoNull Then
                        .CalidadMermaChamico = 0
                        .CalidadMermaChamicoBonifica_o_Rebaja = 0
                    Else
                        'Stop
                    End If
                    If .IsCalidadMermaZarandeoNull Then
                        .CalidadMermaZarandeo = 0
                        .CalidadMermaZarandeoBonifica_o_Rebaja = 0
                    End If
                    If .IsCalidadGranosQuemadosNull Then
                        .CalidadGranosQuemados = 0
                        .CalidadGranosQuemadosBonifica_o_Rebaja = 0
                    End If
                    If .IsCalidadTierraNull Then
                        .CalidadTierra = 0
                        .CalidadTierraBonifica_o_Rebaja = 0
                    End If

                    If .IsCalidadPuntaSombreadaNull Then
                        .CalidadPuntaSombreada = 0
                        '.CalidadTierraBonifica_o_Rebaja = 0
                    End If





                    'dependiendo del cruce Calidad + Articulo, tenes el IdRubro de BLD






                    If .IdArticulo = id_trigocandeal Or .IdArticulo = id_trigopan Or .IdArticulo = id_trigoforraj Then


                        '39	2	Olores Comerciales Objetables	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 39, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")

                        '40	2	Punta Sombreada	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 40, .CalidadPuntaSombreada, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "PuntaSombreada")

                        '41	2	Revolcado en Tierra	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 41, .CalidadTierra, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Tierra")

                        '42	2	Punta Negra por Carbón	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 42, .NobleCarbon, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Carbón")

                        '65	2	Dañado	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 65, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")

                        '66	2	Granos Amohosados	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 66, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")

                        '72	2	Grado 3	Arbitrado
                        If .NobleGrado = 3 Then sb = RenglonBLDCalidad(cdp, 72, .NobleGrado, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado3")

                        '73	2	Proteina	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 73, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Proteina")

                        '79	2	Grado 1	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 79, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")

                        '90	2	Bajo PH	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 90, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "PuntaSombreada")

                        '179	2	Grano Picado	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 179, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picado")

                        '181	2	Grado 2	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 181, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "PuntaSombreada")

                        '266	2	Cuerpos Extraños	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 266, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")

                        '267	2	Granos Dañados	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 267, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañados")

                        '269	2	Granos Quebrados	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 269, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")

                        '270	2	Granos Picados	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 270, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picados")

                        '295	2	Grado 1	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 295, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")


                    ElseIf .IdArticulo = id_maiz Then
                        '298	3	Granos Picados	Arbitrado
                        '260	3	MCV Hdad/Ins V.	Arbitrado
                        '327	3	FACTOR	Arbitrado
                        '290	3	Bajo PH	Arbitrado
                        '263	3	Cuerpos Extraños	Arbitrado
                        '183	3	Chamico	Arbitrado
                        '169	3	Grado 2	Arbitrado



                        '18	3	Olores Comerciales Objetables	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 18, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")

                        '76	3	Granos Dañados	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 76, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")

                        '19	3	Granos Amohosados	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 19, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")

                        '55	3	Grado 1	Arbitrado
                        If .NobleGrado = 1 Then sb = RenglonBLDCalidad(cdp, 55, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")

                        '169	3	Grado 2	Arbitrado
                        If .NobleGrado = 2 Then sb = RenglonBLDCalidad(cdp, 169, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado2")

                        '75	3	Grado 3	Arbitrado
                        If .NobleGrado = 3 Then sb = RenglonBLDCalidad(cdp, 75, .NobleGrado, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado3")

                        '67	3	Granos Quebrados	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 67, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")

                        '298	3	Granos Picados	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 298, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picado")

                        '263	3	Cuerpos Extraños	Arbitrado
                        sb = RenglonBLDCalidad(cdp, 263, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")

                    ElseIf .IdArticulo = id_sorgo Then

                        '128	4	Olores Comerciales Objetables	Arbitrado
                        '135	4	Grado 3	Arbitrado
                        '170	4	Grado 2	Arbitrado
                        '151	4	Grado 1	Arbitrado
                        '253	4	Quebrados	Arbitrado
                        '228	4	Granos amohosados	Arbitrado
                        '229	4	Dañado	Arbitrado
                        '230	4	Granos Amohosados	Arbitrado
                        '231	4	C. Extraños 	Arbitrado
                        '232	4	MCV Olor/Quebra	Arbitrado





                        sb = RenglonBLDCalidad(cdp, 128, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")

                        sb = RenglonBLDCalidad(cdp, 229, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")

                        sb = RenglonBLDCalidad(cdp, 230, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")

                        If .NobleGrado = 1 Then sb = RenglonBLDCalidad(cdp, 151, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")

                        If .NobleGrado = 2 Then sb = RenglonBLDCalidad(cdp, 170, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado2")

                        If .NobleGrado = 3 Then sb = RenglonBLDCalidad(cdp, 135, .NobleGrado, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado3")

                        sb = RenglonBLDCalidad(cdp, 253, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")


                        sb = RenglonBLDCalidad(cdp, 231, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")

                    ElseIf .IdArticulo = id_girasol Then
                        '194	5	Grado 2	Arbitrado
                        If .NobleGrado = 2 Then sb = RenglonBLDCalidad(cdp, 169, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado2")


                    ElseIf .IdArticulo = id_soja Then
                        '136	6	Tierra	Arbitrado
                        '150	6	Avería	Arbitrado
                        '64	6	Granos Quebrados	Arbitrado
                        '116	6	Granos dañados por calor y ardidos	Arbitrado
                        '28	6	Olores Comerciales Objetables	Arbitrado
                        '29	6	Revolcado en Tierra	Arbitrado
                        '30	6	Granos Amohosados	Arbitrado
                        '51	6	Dañados	Arbitrado
                        '54	6	Cuerpos Extraños	Arbitrado
                        '69	6	Total Dañados	Arbitrado
                        '259	6	Merma Conv. ( olor, moho y revolc)	Arbitrado
                        '200	6	Granos Verdes	Arbitrado
                        '224	6	Multa por Incump. Cupos	Arbitrado
                        '341	6	Gastos de Secada	Arbitrado
                        '265	6	Gastos de Fumigación	Arbitrado


                        sb = RenglonBLDCalidad(cdp, 54, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")
                        sb = RenglonBLDCalidad(cdp, 28, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")
                        sb = RenglonBLDCalidad(cdp, 116, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")
                        sb = RenglonBLDCalidad(cdp, 30, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")


                        sb = RenglonBLDCalidad(cdp, 64, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")

                        sb = RenglonBLDCalidad(cdp, 136, .CalidadTierra, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picado")

                        sb = RenglonBLDCalidad(cdp, 200, .NobleVerdes, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Granos Verdes")


                    End If








                End With
            Next


            FileClose(nF)


            Return vFileName

        End Function

        Public Shared Function Sincronismo_BLDCalidades(ByVal SC As String, ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String

            '            Nombre(RESULTA.TXT)
            '            Tipo(ASCII)
            'Longitud de registro	71

            'Descripción del registro

            'Nombre	             Longitud      Desde    Hasta	Tipo de Dato
            'Fecha	de descarga		6	1	6	N	ddmmaa
            'Carta de porte			11	7	17	N	
            'Número de resultado		2	18	19	N
            'Código de ensayo		5	20	24	N
            'Resultado del ensayo		7	25	31	N
            'Kilos  				7	32	38	N
            'Cereal 				2	39	40	N
            'Número de Vagón		8	41	48	N
            'Importe de honorarios		9	49	57	N
            'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja
            'Total de bonificación o rebaja	5	59	63	N	
            'Fuera de standard		1	64	64	A	S-Si	N-No
            'Número de certificado		7	65	71	N	





            'Número de resultado 2 18 19 N Número de certificado 7 65 71 N Con estos datos agreguen un nro correlativo y único, que identifique al análisis y listo, puede ser una numeración interna de Uds. respetando siempre las longitudes de datos del diseño. 
            'Importe de honorarios 9 49 57 N Envíen 0 en los honorarios sino es de la operatoria de Williams. Los honorarios son de la cámara porque la misma cobra por cada análisis. 
            'Bonifica o Rebaja 1 58 58 A B-Bonifica R-Rebaja Esto es clave, por ejemplo el ítems de “Materias extrañas”, bonifica o rebaja, por ejemplo el valor 1.5 cargado en este ítems es Bonifica o Rebaja?. 
            'Total de bonificación o rebaja 5 59 63 N Envíen 0 
            'Fuera de standard 1 64 64 A S-Si N-No Esto es si una calidad mala es S, esto significa que no sirve la calidad. Normalmente viene en N Saludos.-"



            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroBLDCalidades " & Now.ToString("ddMMMyyyy_HHmmss") & ".csv" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow



            Dim id_trigocandeal = BuscaIdArticuloPreciso("TRIGO CANDEAL", SC) 'pan y forrajero
            Dim id_trigopan = BuscaIdArticuloPreciso("TRIGO PAN", SC) 'pan y forrajero
            Dim id_trigoforraj = BuscaIdArticuloPreciso("TRIGO FORRAJERO", SC) 'pan y forrajero

            Dim id_soja = BuscaIdArticuloPreciso("SOJA", SC)
            Dim id_sorgo = BuscaIdArticuloPreciso("SORGO GRANIFERO", SC)
            Dim id_maiz = BuscaIdArticuloPreciso("MAIZ", SC)
            Dim id_girasol = BuscaIdArticuloPreciso("GIRASOL", SC)


            Using db As New LinqCartasPorteDataContext(Encriptar(SC))
                Dim cartas '= db.CartasDePortes.Where(sWHERE)


                PrintLine(nF, "CartaPorte;IdRubro;DRubro;DescuentoFinal;ResFinal;")

                'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
                For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                    'For Each cdp In cartas
                    With cdp

                        i = 0 : sb = ""

                        Dim cero = 0




                        'Nombre	             Longitud      Desde    Hasta	Tipo de Dato
                        'Fecha	de descarga		6	1	6	N	ddmmaa
                        'Carta de porte			11	7	17	N	
                        'Número de resultado		2	18	19	N
                        'Código de ensayo		5	20	24	N
                        'Resultado del ensayo		7	25	31	N
                        'Kilos  				7	32	38	N
                        'Cereal 				2	39	40	N
                        'Número de Vagón		8	41	48	N
                        'Importe de honorarios		9	49	57	N
                        'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja
                        'Total de bonificación o rebaja	5	59	63	N	
                        'Fuera de standard		1	64	64	A	S-Si	N-No
                        'Número de certificado		7	65	71	N	

                        '                                               Nombre	              Lon  Desde Hasta	Tipo de Dato





                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////
                        'consulta AMAGGI
                        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7963
                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////

                        If .IsFueraDeEstandarNull Then .FueraDeEstandar = 0
                        If .IsCalidadMermaChamicoNull Then
                            .CalidadMermaChamico = 0
                            .CalidadMermaChamicoBonifica_o_Rebaja = 0
                        Else
                            'Stop
                        End If
                        If .IsCalidadMermaZarandeoNull Then
                            .CalidadMermaZarandeo = 0
                            .CalidadMermaZarandeoBonifica_o_Rebaja = 0
                        End If
                        If .IsCalidadGranosQuemadosNull Then
                            .CalidadGranosQuemados = 0
                            .CalidadGranosQuemadosBonifica_o_Rebaja = 0
                        End If
                        If .IsCalidadTierraNull Then
                            .CalidadTierra = 0
                            .CalidadTierraBonifica_o_Rebaja = 0
                        End If

                        If .IsCalidadPuntaSombreadaNull Then
                            .CalidadPuntaSombreada = 0
                            '.CalidadTierraBonifica_o_Rebaja = 0
                        End If





                        'dependiendo del cruce Calidad + Articulo, tenes el IdRubro de BLD

                        If Not .IsCalidadDescuentoFinalNull Then
                            If .CalidadDescuentoFinal > 0 Then sb = RenglonBLDCalidad(cdp, 0, .CalidadDescuentoFinal, "", 0, nF, "01", "DescuentoFinal")
                        End If



                        If .IdArticulo = id_trigocandeal Or .IdArticulo = id_trigopan Or .IdArticulo = id_trigoforraj Then


                            '39	2	Olores Comerciales Objetables	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 39, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")

                            '40	2	Punta Sombreada	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 40, .CalidadPuntaSombreada, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "PuntaSombreada")

                            '41	2	Revolcado en Tierra	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 41, .CalidadTierra, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Tierra")

                            '42	2	Punta Negra por Carbón	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 42, .NobleCarbon, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Carbón")

                            '65	2	Dañado	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 65, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")

                            '66	2	Granos Amohosados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 66, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")

                            '72	2	Grado 3	Arbitrado
                            If .NobleGrado = 3 Then sb = RenglonBLDCalidad(cdp, 72, .NobleGrado, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado3")

                            '73	2	Proteina	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 73, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Proteina")

                            '79	2	Grado 1	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 79, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")

                            '90	2	Bajo PH	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 90, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "PuntaSombreada")

                            '179	2	Grano Picado	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 179, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picado")

                            '181	2	Grado 2	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 181, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "PuntaSombreada")

                            '266	2	Cuerpos Extraños	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 266, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")

                            '267	2	Granos Dañados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 267, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañados")

                            '269	2	Granos Quebrados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 269, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")

                            '270	2	Granos Picados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 270, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picados")

                            '295	2	Grado 1	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 295, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")


                        ElseIf .IdArticulo = id_maiz Then
                            '298	3	Granos Picados	Arbitrado
                            '260	3	MCV Hdad/Ins V.	Arbitrado
                            '327	3	FACTOR	Arbitrado
                            '290	3	Bajo PH	Arbitrado
                            '263	3	Cuerpos Extraños	Arbitrado
                            '183	3	Chamico	Arbitrado
                            '169	3	Grado 2	Arbitrado



                            '18	3	Olores Comerciales Objetables	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 18, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")

                            '76	3	Granos Dañados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 76, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")

                            '19	3	Granos Amohosados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 19, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")

                            '55	3	Grado 1	Arbitrado
                            If .NobleGrado = 1 Then sb = RenglonBLDCalidad(cdp, 55, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")

                            '169	3	Grado 2	Arbitrado
                            If .NobleGrado = 2 Then sb = RenglonBLDCalidad(cdp, 169, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado2")

                            '75	3	Grado 3	Arbitrado
                            If .NobleGrado = 3 Then sb = RenglonBLDCalidad(cdp, 75, .NobleGrado, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado3")

                            '67	3	Granos Quebrados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 67, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")

                            '298	3	Granos Picados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 298, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picado")

                            '263	3	Cuerpos Extraños	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 263, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")

                        ElseIf .IdArticulo = id_sorgo Then

                            '128	4	Olores Comerciales Objetables	Arbitrado
                            '135	4	Grado 3	Arbitrado
                            '170	4	Grado 2	Arbitrado
                            '151	4	Grado 1	Arbitrado
                            '253	4	Quebrados	Arbitrado
                            '228	4	Granos amohosados	Arbitrado
                            '229	4	Dañado	Arbitrado
                            '230	4	Granos Amohosados	Arbitrado
                            '231	4	C. Extraños 	Arbitrado
                            '232	4	MCV Olor/Quebra	Arbitrado





                            sb = RenglonBLDCalidad(cdp, 128, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")

                            sb = RenglonBLDCalidad(cdp, 229, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")

                            sb = RenglonBLDCalidad(cdp, 230, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")

                            If .NobleGrado = 1 Then sb = RenglonBLDCalidad(cdp, 151, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")

                            If .NobleGrado = 2 Then sb = RenglonBLDCalidad(cdp, 170, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado2")

                            If .NobleGrado = 3 Then sb = RenglonBLDCalidad(cdp, 135, .NobleGrado, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado3")

                            sb = RenglonBLDCalidad(cdp, 253, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")


                            sb = RenglonBLDCalidad(cdp, 231, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")

                        ElseIf .IdArticulo = id_girasol Then
                            '194	5	Grado 2	Arbitrado
                            If .NobleGrado = 2 Then sb = RenglonBLDCalidad(cdp, 169, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado2")


                        ElseIf .IdArticulo = id_soja Then
                            '136	6	Tierra	Arbitrado
                            '150	6	Avería	Arbitrado
                            '64	6	Granos Quebrados	Arbitrado
                            '116	6	Granos dañados por calor y ardidos	Arbitrado
                            '28	6	Olores Comerciales Objetables	Arbitrado
                            '29	6	Revolcado en Tierra	Arbitrado
                            '30	6	Granos Amohosados	Arbitrado
                            '51	6	Dañados	Arbitrado
                            '54	6	Cuerpos Extraños	Arbitrado
                            '69	6	Total Dañados	Arbitrado
                            '259	6	Merma Conv. ( olor, moho y revolc)	Arbitrado
                            '200	6	Granos Verdes	Arbitrado
                            '224	6	Multa por Incump. Cupos	Arbitrado
                            '341	6	Gastos de Secada	Arbitrado
                            '265	6	Gastos de Fumigación	Arbitrado


                            sb = RenglonBLDCalidad(cdp, 54, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")
                            sb = RenglonBLDCalidad(cdp, 28, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")
                            sb = RenglonBLDCalidad(cdp, 116, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")
                            sb = RenglonBLDCalidad(cdp, 30, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")


                            sb = RenglonBLDCalidad(cdp, 64, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")

                            sb = RenglonBLDCalidad(cdp, 136, .CalidadTierra, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picado")

                            sb = RenglonBLDCalidad(cdp, 200, .NobleVerdes, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Granos Verdes")


                        End If








                    End With
                Next

            End Using

            FileClose(nF)


            Return vFileName

        End Function


        Public Shared Function Sincronismo_PSALaCalifornia_Calidades(ByVal SC As String, ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String

            '            Nombre(RESULTA.TXT)
            '            Tipo(ASCII)
            'Longitud de registro	71

            'Descripción del registro

            'Nombre	             Longitud      Desde    Hasta	Tipo de Dato
            'Fecha	de descarga		6	1	6	N	ddmmaa
            'Carta de porte			11	7	17	N	
            'Número de resultado		2	18	19	N
            'Código de ensayo		5	20	24	N
            'Resultado del ensayo		7	25	31	N
            'Kilos  				7	32	38	N
            'Cereal 				2	39	40	N
            'Número de Vagón		8	41	48	N
            'Importe de honorarios		9	49	57	N
            'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja
            'Total de bonificación o rebaja	5	59	63	N	
            'Fuera de standard		1	64	64	A	S-Si	N-No
            'Número de certificado		7	65	71	N	





            'Número de resultado 2 18 19 N Número de certificado 7 65 71 N Con estos datos agreguen un nro correlativo y único, que identifique al análisis y listo, puede ser una numeración interna de Uds. respetando siempre las longitudes de datos del diseño. 
            'Importe de honorarios 9 49 57 N Envíen 0 en los honorarios sino es de la operatoria de Williams. Los honorarios son de la cámara porque la misma cobra por cada análisis. 
            'Bonifica o Rebaja 1 58 58 A B-Bonifica R-Rebaja Esto es clave, por ejemplo el ítems de “Materias extrañas”, bonifica o rebaja, por ejemplo el valor 1.5 cargado en este ítems es Bonifica o Rebaja?. 
            'Total de bonificación o rebaja 5 59 63 N Envíen 0 
            'Fuera de standard 1 64 64 A S-Si N-No Esto es si una calidad mala es S, esto significa que no sirve la calidad. Normalmente viene en N Saludos.-"



            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroPSACalidades " & Now.ToString("ddMMMyyyy_HHmmss") & ".csv" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow



            Dim id_trigocandeal = BuscaIdArticuloPreciso("TRIGO CANDEAL", SC) 'pan y forrajero
            Dim id_trigopan = BuscaIdArticuloPreciso("TRIGO PAN", SC) 'pan y forrajero
            Dim id_trigoforraj = BuscaIdArticuloPreciso("TRIGO FORRAJERO", SC) 'pan y forrajero

            Dim id_soja = BuscaIdArticuloPreciso("SOJA", SC)
            Dim id_sorgo = BuscaIdArticuloPreciso("SORGO GRANIFERO", SC)
            Dim id_maiz = BuscaIdArticuloPreciso("MAIZ", SC)
            Dim id_girasol = BuscaIdArticuloPreciso("GIRASOL", SC)


            Using db As New LinqCartasPorteDataContext(Encriptar(SC))
                Dim cartas '= db.CartasDePortes.Where(sWHERE)


                PrintLine(nF, "CartaPorte;IdRubro;DRubro;DescuentoFinal;ResFinal;")

                'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
                For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                    'For Each cdp In cartas
                    With cdp

                        i = 0 : sb = ""

                        Dim cero = 0




                        'Nombre	             Longitud      Desde    Hasta	Tipo de Dato
                        'Fecha	de descarga		6	1	6	N	ddmmaa
                        'Carta de porte			11	7	17	N	
                        'Número de resultado		2	18	19	N
                        'Código de ensayo		5	20	24	N
                        'Resultado del ensayo		7	25	31	N
                        'Kilos  				7	32	38	N
                        'Cereal 				2	39	40	N
                        'Número de Vagón		8	41	48	N
                        'Importe de honorarios		9	49	57	N
                        'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja
                        'Total de bonificación o rebaja	5	59	63	N	
                        'Fuera de standard		1	64	64	A	S-Si	N-No
                        'Número de certificado		7	65	71	N	

                        '                                               Nombre	              Lon  Desde Hasta	Tipo de Dato





                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////
                        'consulta AMAGGI
                        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7963
                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////

                        If .IsFueraDeEstandarNull Then .FueraDeEstandar = 0
                        If .IsCalidadMermaChamicoNull Then
                            .CalidadMermaChamico = 0
                            .CalidadMermaChamicoBonifica_o_Rebaja = 0
                        Else
                            'Stop
                        End If
                        If .IsCalidadMermaZarandeoNull Then
                            .CalidadMermaZarandeo = 0
                            .CalidadMermaZarandeoBonifica_o_Rebaja = 0
                        End If
                        If .IsCalidadGranosQuemadosNull Then
                            .CalidadGranosQuemados = 0
                            .CalidadGranosQuemadosBonifica_o_Rebaja = 0
                        End If
                        If .IsCalidadTierraNull Then
                            .CalidadTierra = 0
                            .CalidadTierraBonifica_o_Rebaja = 0
                        End If

                        If .IsCalidadPuntaSombreadaNull Then
                            .CalidadPuntaSombreada = 0
                            '.CalidadTierraBonifica_o_Rebaja = 0
                        End If





                        'dependiendo del cruce Calidad + Articulo, tenes el IdRubro de BLD

                        If Not .IsCalidadDescuentoFinalNull Then
                            If .CalidadDescuentoFinal > 0 Then sb = RenglonBLDCalidad(cdp, 0, .CalidadDescuentoFinal, "", 0, nF, "01", "DescuentoFinal")
                        End If



                        If .IdArticulo = id_trigocandeal Or .IdArticulo = id_trigopan Or .IdArticulo = id_trigoforraj Then


                            '39	2	Olores Comerciales Objetables	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 39, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")

                            '40	2	Punta Sombreada	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 40, .CalidadPuntaSombreada, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "PuntaSombreada")

                            '41	2	Revolcado en Tierra	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 41, .CalidadTierra, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Tierra")

                            '42	2	Punta Negra por Carbón	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 42, .NobleCarbon, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Carbón")

                            '65	2	Dañado	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 65, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")

                            '66	2	Granos Amohosados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 66, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")

                            '72	2	Grado 3	Arbitrado
                            If .NobleGrado = 3 Then sb = RenglonBLDCalidad(cdp, 72, .NobleGrado, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado3")

                            '73	2	Proteina	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 73, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Proteina")

                            '79	2	Grado 1	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 79, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")

                            '90	2	Bajo PH	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 90, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "PuntaSombreada")

                            '179	2	Grano Picado	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 179, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picado")

                            '181	2	Grado 2	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 181, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "PuntaSombreada")

                            '266	2	Cuerpos Extraños	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 266, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")

                            '267	2	Granos Dañados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 267, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañados")

                            '269	2	Granos Quebrados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 269, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")

                            '270	2	Granos Picados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 270, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picados")

                            '295	2	Grado 1	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 295, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")


                        ElseIf .IdArticulo = id_maiz Then
                            '298	3	Granos Picados	Arbitrado
                            '260	3	MCV Hdad/Ins V.	Arbitrado
                            '327	3	FACTOR	Arbitrado
                            '290	3	Bajo PH	Arbitrado
                            '263	3	Cuerpos Extraños	Arbitrado
                            '183	3	Chamico	Arbitrado
                            '169	3	Grado 2	Arbitrado



                            '18	3	Olores Comerciales Objetables	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 18, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")

                            '76	3	Granos Dañados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 76, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")

                            '19	3	Granos Amohosados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 19, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")

                            '55	3	Grado 1	Arbitrado
                            If .NobleGrado = 1 Then sb = RenglonBLDCalidad(cdp, 55, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")

                            '169	3	Grado 2	Arbitrado
                            If .NobleGrado = 2 Then sb = RenglonBLDCalidad(cdp, 169, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado2")

                            '75	3	Grado 3	Arbitrado
                            If .NobleGrado = 3 Then sb = RenglonBLDCalidad(cdp, 75, .NobleGrado, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado3")

                            '67	3	Granos Quebrados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 67, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")

                            '298	3	Granos Picados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 298, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picado")

                            '263	3	Cuerpos Extraños	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 263, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")

                        ElseIf .IdArticulo = id_sorgo Then

                            '128	4	Olores Comerciales Objetables	Arbitrado
                            '135	4	Grado 3	Arbitrado
                            '170	4	Grado 2	Arbitrado
                            '151	4	Grado 1	Arbitrado
                            '253	4	Quebrados	Arbitrado
                            '228	4	Granos amohosados	Arbitrado
                            '229	4	Dañado	Arbitrado
                            '230	4	Granos Amohosados	Arbitrado
                            '231	4	C. Extraños 	Arbitrado
                            '232	4	MCV Olor/Quebra	Arbitrado





                            sb = RenglonBLDCalidad(cdp, 128, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")

                            sb = RenglonBLDCalidad(cdp, 229, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")

                            sb = RenglonBLDCalidad(cdp, 230, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")

                            If .NobleGrado = 1 Then sb = RenglonBLDCalidad(cdp, 151, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")

                            If .NobleGrado = 2 Then sb = RenglonBLDCalidad(cdp, 170, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado2")

                            If .NobleGrado = 3 Then sb = RenglonBLDCalidad(cdp, 135, .NobleGrado, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado3")

                            sb = RenglonBLDCalidad(cdp, 253, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")


                            sb = RenglonBLDCalidad(cdp, 231, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")

                        ElseIf .IdArticulo = id_girasol Then
                            '194	5	Grado 2	Arbitrado
                            If .NobleGrado = 2 Then sb = RenglonBLDCalidad(cdp, 169, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado2")


                        ElseIf .IdArticulo = id_soja Then
                            '136	6	Tierra	Arbitrado
                            '150	6	Avería	Arbitrado
                            '64	6	Granos Quebrados	Arbitrado
                            '116	6	Granos dañados por calor y ardidos	Arbitrado
                            '28	6	Olores Comerciales Objetables	Arbitrado
                            '29	6	Revolcado en Tierra	Arbitrado
                            '30	6	Granos Amohosados	Arbitrado
                            '51	6	Dañados	Arbitrado
                            '54	6	Cuerpos Extraños	Arbitrado
                            '69	6	Total Dañados	Arbitrado
                            '259	6	Merma Conv. ( olor, moho y revolc)	Arbitrado
                            '200	6	Granos Verdes	Arbitrado
                            '224	6	Multa por Incump. Cupos	Arbitrado
                            '341	6	Gastos de Secada	Arbitrado
                            '265	6	Gastos de Fumigación	Arbitrado


                            sb = RenglonBLDCalidad(cdp, 54, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")
                            sb = RenglonBLDCalidad(cdp, 28, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")
                            sb = RenglonBLDCalidad(cdp, 116, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")
                            sb = RenglonBLDCalidad(cdp, 30, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")


                            sb = RenglonBLDCalidad(cdp, 64, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")

                            sb = RenglonBLDCalidad(cdp, 136, .CalidadTierra, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picado")

                            sb = RenglonBLDCalidad(cdp, 200, .NobleVerdes, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Granos Verdes")


                        End If








                    End With
                Next

            End Using

            FileClose(nF)


            Return vFileName

        End Function


        Public Shared Function RenglonBLDCalidad(ByVal cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow, ByVal CodigoEnsayo As Integer, ByVal Resultado As Double, ByVal bonif_O_rebaja As String, ByVal Rebaja As Double, ByVal nf As Integer, ByVal numresultado As String, Optional ByVal descripcion As String = "") As String
            Dim sb = ""



            Dim SEPARADOR = ";"


            With cdp


                '            CartaPorte	IdRubro	DRubro	ResFinal
                '18383242	151	Grado 1	1
                '17960754	55	Grado 1	1
                '18230959	55	Grado 1	1
                '18126000	55	Grado 1	1
                '18424881	54	Cuerpos Extraños	-0.6
                '17835569	55	Grado 1	1
                '18488771	169	Grado 2	0
                '18488770	169	Grado 2	0





                If Resultado <> 0 Or Rebaja <> 0 Then


                    Dim cero = 0


                    ForzarPrefijo5(.NumeroCartaDePorte)


                    sb &= LeftMasPadLeft(.NumeroCartaDePorte, 11) & SEPARADOR   'Carta de porte			11	7	17	N	
                    'sb &= LeftMasPadLeft(CodigoRubroBLD(.Calidad, .Producto), 2) & SEPARADOR                 'Cereal 				2	39	40	N
                    sb &= LeftMasPadLeft(CodigoEnsayo, 2) & SEPARADOR

                    sb &= descripcion & SEPARADOR

                    Dim desc As Double
                    If Not .IsCalidadDescuentoFinalNull Then
                        desc = .CalidadDescuentoFinal
                    Else
                        desc = 0
                    End If
                    sb &= LeftMasPadLeft(desc, 7) & SEPARADOR                 'Descuento Final http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9291    

                    sb &= LeftMasPadLeft(Resultado, 7) & SEPARADOR                 'Resultado del ensayo	7	25	31	N




                    'If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    'sb &= .FechaDescarga.ToString("ddMMyy")         'Fecha	de descarga		6	1	6	N	ddmmaa
                    'sb &= LeftMasPadLeft(numresultado, 2)                   'Número de resultado	2	18	19	N  "01,02,03,04"
                    'sb &= LeftMasPadLeft(CodigoEnsayo, 5)                   'Código de ensayo		5	20	24	N
                    'sb &= LeftMasPadLeft(Int(.NetoFinal), 7)             'Kilos  				7	32	38	N
                    'sb &= LeftMasPadLeft(.SubnumeroVagon, 8)        'Número de Vagón		8	41	48	N
                    'sb &= LeftMasPadLeft(cero, 9)                   'Importe de honorarios	9	49	57	N
                    'sb &= IIf(iisNull(bonif_O_rebaja, 0) = 0, "B", "R")                       'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja
                    'sb &= LeftMasPadLeft((0).ToString("00.00", System.Globalization.CultureInfo.InvariantCulture), 5)                   'Total de bonif/rebaj	5	59	63	N	
                    'sb &= IIf(.FueraDeEstandar <> "SI", "N", "S")                       'Fuera de standard		1	64	64	A	S-Si	N-No
                    'sb &= LeftMasPadLeft(.IdCartaDePorte, 7)                   'Número de certif   	7	65	71	N	
                    'sb &= LeftMasPadLeft(.DestinoCodigoONCAA, 5)


                    sb = Replace(sb, " ", "0")

                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9829
                    'Solicitan agregar al sincronismo de Calidad de BLD una ultima columna, donde se envíe el Destino de la Carta de Porte

                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602




                    PrintLine(nf, sb)
                End If
            End With
            Return sb

        End Function

        Shared Function CodigoRubroBLD(ByVal calidad As String, ByVal productoDescripcion As String) As Integer
            '        IdProducto(DProducto)
            '2:      Trigo()
            '3:      Maiz()
            '4:      Sorgo()
            '5:      Girasol()
            '6:      Soja()


            'esto es una tabla


            '        IdRubro	IdProducto	DRubro	Tipo
            '39	2	Olores Comerciales Objetables	Arbitrado
            '40	2	Punta Sombreada	Arbitrado
            '41	2	Revolcado en Tierra	Arbitrado
            '42	2	Punta Negra por Carbón	Arbitrado
            '65	2	Dañado	Arbitrado
            '66	2	Granos Amohosados	Arbitrado
            '72	2	Grado 3	Arbitrado
            '73	2	Proteina	Arbitrado
            '79	2	Grado 1	Arbitrado
            '90	2	Bajo PH	Arbitrado
            '179	2	Grano Picado	Arbitrado
            '181	2	Grado 2	Arbitrado
            '192	2	Granos Partidos	Arbitrado
            '199	2	Bajo W	Arbitrado
            '266	2	Cuerpos Extraños	Arbitrado
            '267	2	Granos Dañados	Arbitrado
            '268	2	Serv. Fumigacion	Arbitrado
            '269	2	Granos Quebrados	Arbitrado
            '270	2	Granos Picados	Arbitrado
            '271	2	Granos Ardidos	Arbitrado
            '294	2	Arbitraje	Arbitrado
            '295	2	Grado 1	Arbitrado
            '313	2	Granos Picados	Arbitrado
            '335	2	Grano Picado	Arbitrado
            '298	3	Granos Picados	Arbitrado
            '260	3	MCV Hdad/Ins V.	Arbitrado
            '263	3	Cuerpos Extraños	Arbitrado
            '338	3	Fumigacion en Cinta	Arbitrado
            '327	3	FACTOR	Arbitrado
            '290	3	Bajo PH	Arbitrado
            '183	3	Chamico	Arbitrado
            '169	3	Grado 2	Arbitrado
            '55	3	Grado 1	Arbitrado
            '75	3	Grado 3	Arbitrado
            '76	3	Granos Dañados	Arbitrado
            '67	3	Granos Quebrados	Arbitrado
            '18	3	Olores Comerciales Objetables	Arbitrado
            '19	3	Granos Amohosados	Arbitrado
            '128	4	Olores Comerciales Objetables	Arbitrado
            '135	4	Grado 3	Arbitrado
            '170	4	Grado 2	Arbitrado
            '151	4	Grado 1	Arbitrado
            '253	4	Quebrados	Arbitrado
            '228	4	Granos amohosados	Arbitrado
            '229	4	Dañado	Arbitrado
            '230	4	Granos Amohosados	Arbitrado
            '231	4	C. Extraños 	Arbitrado
            '232	4	MCV Olor/Quebra	Arbitrado
            '194	5	Grado 2	Arbitrado
            '136	6	Tierra	Arbitrado
            '150	6	Avería	Arbitrado
            '64	6	Granos Quebrados	Arbitrado
            '116	6	Granos dañados por calor y ardidos	Arbitrado
            '28	6	Olores Comerciales Objetables	Arbitrado
            '29	6	Revolcado en Tierra	Arbitrado
            '30	6	Granos Amohosados	Arbitrado
            '51	6	Dañados	Arbitrado
            '54	6	Cuerpos Extraños	Arbitrado
            '69	6	Total Dañados	Arbitrado
            '259	6	Merma Conv. ( olor, moho y revolc)	Arbitrado
            '200	6	Granos Verdes	Arbitrado
            '224	6	Multa por Incump. Cupos	Arbitrado
            '341	6	Gastos de Secada	Arbitrado
            '265	6	Gastos de Fumigación	Arbitrado




            If InStr(productoDescripcion, "TRIGO") > 0 Then
                '39	2	Olores Comerciales Objetables	Arbitrado
                '40	2	Punta Sombreada	Arbitrado
                '41	2	Revolcado en Tierra	Arbitrado
                '42	2	Punta Negra por Carbón	Arbitrado
                '65	2	Dañado	Arbitrado
                '66	2	Granos Amohosados	Arbitrado
                '72	2	Grado 3	Arbitrado
                '73	2	Proteina	Arbitrado
                '79	2	Grado 1	Arbitrado
                '90	2	Bajo PH	Arbitrado
                '179	2	Grano Picado	Arbitrado
                '181	2	Grado 2	Arbitrado
                '192	2	Granos Partidos	Arbitrado
                '199	2	Bajo W	Arbitrado
                '266	2	Cuerpos Extraños	Arbitrado
                '267	2	Granos Dañados	Arbitrado
                '268	2	Serv. Fumigacion	Arbitrado
                '269	2	Granos Quebrados	Arbitrado
                '270	2	Granos Picados	Arbitrado
                '271	2	Granos Ardidos	Arbitrado
                '294	2	Arbitraje	Arbitrado
                '295	2	Grado 1	Arbitrado
                '313	2	Granos Picados	Arbitrado
                '335	2	Grano Picado	Arbitrado
                If InStr(calidad, "Grano Picado") > 0 Then Return 179
            End If


            If InStr(productoDescripcion, "MAIZ") > 0 Then
                '298	3	Granos Picados	Arbitrado
                '260	3	MCV Hdad/Ins V.	Arbitrado
                '263	3	Cuerpos Extraños	Arbitrado
                '338	3	Fumigacion en Cinta	Arbitrado
                '327	3	FACTOR	Arbitrado
                '290	3	Bajo PH	Arbitrado
                '183	3	Chamico	Arbitrado
                '169	3	Grado 2	Arbitrado
                '55	3	Grado 1	Arbitrado
                '75	3	Grado 3	Arbitrado
                '76	3	Granos Dañados	Arbitrado
                '67	3	Granos Quebrados	Arbitrado
                '18	3	Olores Comerciales Objetables	Arbitrado
                '19	3	Granos Amohosados	Arbitrado
            End If

            If InStr(productoDescripcion, "SORGO") > 0 Then
                '128	4	Olores Comerciales Objetables	Arbitrado
                '135	4	Grado 3	Arbitrado
                '170	4	Grado 2	Arbitrado
                '151	4	Grado 1	Arbitrado
                '253	4	Quebrados	Arbitrado
                '228	4	Granos amohosados	Arbitrado
                '229	4	Dañado	Arbitrado
                '230	4	Granos Amohosados	Arbitrado
                '231	4	C. Extraños 	Arbitrado
                '232	4	MCV Olor/Quebra	Arbitrado
            End If


            If InStr(productoDescripcion, "GIRASOL") > 0 Then
                '194	5	Grado 2	Arbitrado
            End If


            If InStr(productoDescripcion, "SOJA") > 0 Then
                '136	6	Tierra	Arbitrado
                '150	6	Avería	Arbitrado
                '64	6	Granos Quebrados	Arbitrado
                '116	6	Granos dañados por calor y ardidos	Arbitrado
                '28	6	Olores Comerciales Objetables	Arbitrado
                '29	6	Revolcado en Tierra	Arbitrado
                '30	6	Granos Amohosados	Arbitrado
                '51	6	Dañados	Arbitrado
                '54	6	Cuerpos Extraños	Arbitrado
                '69	6	Total Dañados	Arbitrado
                '259	6	Merma Conv. ( olor, moho y revolc)	Arbitrado
                '200	6	Granos Verdes	Arbitrado
                '224	6	Multa por Incump. Cupos	Arbitrado
                '341	6	Gastos de Secada	Arbitrado
                '265	6	Gastos de Fumigación	Arbitrado
            End If




            Return 0
        End Function

        Public Shared Function Sincronismo_AlabernCalidades(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, ByVal titulo As String, ByVal sWHERE As String, ByRef sErrores As String) As String


            '            Cod.Descripción()
            '1:          CONFORME()
            '2:          CONDICION(CAMARA)
            '3:          FUERA(ESTANDAR)





            '            01	Pre	04	0000	Sufijo de Carta de Porte
            '02	CP	08	00000000	N° de Carta de Porte
            '03	Vagon	08	Alfanum	N° de Vagón
            '04	Codi	04	0000	Código de Rubro (Ver Tablas)
            '05	Rubro	06	Alfanum	Nombre de Rubro (Ver Tablas)
            '06	Porcenta	08	00000,00	es el % observado
            '07	Cantidad	08	00000000	
            '08	%Merma	08	00000,00	es el % de merma
            '09	Kg Merma	08	00000000	Kgs.de Merma


            '            Nombre(RESULTA.TXT)
            '            Tipo(ASCII)
            'Longitud de registro	71

            'Descripción del registro

            'Nombre	             Longitud      Desde    Hasta	Tipo de Dato
            'Fecha	de descarga		6	1	6	N	ddmmaa
            'Carta de porte			11	7	17	N	
            'Número de resultado		2	18	19	N
            'Código de ensayo		5	20	24	N
            'Resultado del ensayo		7	25	31	N
            'Kilos  				7	32	38	N
            'Cereal 				2	39	40	N
            'Número de Vagón		8	41	48	N
            'Importe de honorarios		9	49	57	N
            'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja
            'Total de bonificación o rebaja	5	59	63	N	
            'Fuera de standard		1	64	64	A	S-Si	N-No
            'Número de certificado		7	65	71	N	





            'Número de resultado 2 18 19 N Número de certificado 7 65 71 N Con estos datos agreguen un nro correlativo y único, que identifique al análisis y listo, puede ser una numeración interna de Uds. respetando siempre las longitudes de datos del diseño. 
            'Importe de honorarios 9 49 57 N Envíen 0 en los honorarios sino es de la operatoria de Williams. Los honorarios son de la cámara porque la misma cobra por cada análisis. 
            'Bonifica o Rebaja 1 58 58 A B-Bonifica R-Rebaja Esto es clave, por ejemplo el ítems de “Materias extrañas”, bonifica o rebaja, por ejemplo el valor 1.5 cargado en este ítems es Bonifica o Rebaja?. 
            'Total de bonificación o rebaja 5 59 63 N Envíen 0 
            'Fuera de standard 1 64 64 A S-Si N-No Esto es si una calidad mala es S, esto significa que no sirve la calidad. Normalmente viene en N Saludos.-"



            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            'Dim vFileName As String = Path.GetTempPath & "AnalisisW Alabern" & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net



            Dim nombre As String
            Dim pv As Integer
            Select Case pv
                Case 1
                    nombre = "AnalisisW_BA.txt"
                Case 2
                    nombre = "AnalisisW_SL.txt"
                Case 3
                    nombre = "AnalisisW_AS.txt"
                Case 4
                    nombre = "AnalisisW_BB.txt"
                Case Else
                    nombre = "AnalisisW.txt"
            End Select
            Dim vFileName As String = Path.GetTempPath & nombre



            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow

            Dim sErroresProcedencia As String = "", sErroresDestinos As String = "", sErroresPrefijo As String = ""


            sb = "Pre |CP      |Vagon   |Codi|Rubro |Porcenta|Cantidad|% Merma |Kg Merma"
            PrintLine(nF, sb)
            sb = "0005|29662696|        |0002|HD.   |00013,50|00000000|00000,00|00000000"
            'PrintLine(nF, sb)
            sb = "0005|29660882|        |0004|M/E.  |00001,50|00000000|00000,50|00000000"
            'PrintLine(nF, sb)


            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp


                    i = 0 : sb = ""

                    Dim cero = 0




                    'Nombre	             Longitud      Desde    Hasta	Tipo de Dato
                    'Fecha	de descarga		6	1	6	N	ddmmaa
                    'Carta de porte			11	7	17	N	
                    'Número de resultado		2	18	19	N
                    'Código de ensayo		5	20	24	N
                    'Resultado del ensayo		7	25	31	N
                    'Kilos  				7	32	38	N
                    'Cereal 				2	39	40	N
                    'Número de Vagón		8	41	48	N
                    'Importe de honorarios		9	49	57	N
                    'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja
                    'Total de bonificación o rebaja	5	59	63	N	
                    'Fuera de standard		1	64	64	A	S-Si	N-No
                    'Número de certificado		7	65	71	N	

                    '                                               Nombre	              Lon  Desde Hasta	Tipo de Dato



                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    'consulta AMAGGI
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7963
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////

                    If .IsFueraDeEstandarNull Then .FueraDeEstandar = 0
                    If .IsCalidadMermaChamicoNull Then
                        .CalidadMermaChamico = 0
                        .CalidadMermaChamicoBonifica_o_Rebaja = 0
                    Else
                        'Stop
                    End If
                    If .IsCalidadMermaZarandeoNull Then
                        .CalidadMermaZarandeo = 0
                        .CalidadMermaZarandeoBonifica_o_Rebaja = 0
                    End If
                    If .IsCalidadGranosQuemadosNull Then
                        .CalidadGranosQuemados = 0
                        .CalidadGranosQuemadosBonifica_o_Rebaja = 0
                    End If
                    If .IsCalidadTierraNull Then
                        .CalidadTierra = 0
                        .CalidadTierraBonifica_o_Rebaja = 0
                    End If

                    If .IsCalidadPuntaSombreadaNull Then
                        .CalidadPuntaSombreada = 0
                        '.CalidadTierraBonifica_o_Rebaja = 0
                    End If




                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////
                    '                pero si no tiene ninguna calidad, los datos de la carta de porte tienen que ir igual
                    'Mariano Scalella dice
                    'guardiola, los renglones tienen el codigo de la calidad q se mide. lo dejo en blanco entonces? estas excepciones nos las tienen q aclarar
                    'perate q reviso el ejemplo a ver como safan
                    'el codigo de cual es la calidad q se mide va del caracter 20 al 24. en el ejemplo q nos mandaron siempre hay dato ahi. le meto entonces uno obligatorio, con codigo "0000"?
                    '                Andrés(dice)
                    'si, para mandarles un ejemplo
                    'pero en el correo les pregunto

                    'sb = RenglonAlabernCalidad(cdp, 0, 0, 0, 0, nF, "00") 'RENGLON FORZOSO, para que haya dato aunque no haya calada
                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////



                    '            RUBROS(ANALISIS)
                    '            Cod.Descripción()
                    '1:          Total(Dañados)
                    sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '2:          Humedad()
                    sb = RenglonAlabernCalidad(cdp, "HUM", 2, .Humedad, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '3:          Peso(Hectolitrico)
                    sb = RenglonAlabernCalidad(cdp, "HEC", 3, .NobleHectolitrico, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '4:          Materias(Extrañas)
                    sb = RenglonAlabernCalidad(cdp, "EXTR", 4, .NobleExtranos, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '5:          Quebrados()
                    sb = RenglonAlabernCalidad(cdp, "QUE", 5, .NobleQuebrados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '6:          Partidos()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .part, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '7:          Picados()
                    sb = RenglonAlabernCalidad(cdp, "PIC", 7, .NoblePicados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '8:          Punta(Sombreado)
                    sb = RenglonAlabernCalidad(cdp, "SOM", 8, .CalidadPuntaSombreada, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '9:          Punta(Negra)
                    sb = RenglonAlabernCalidad(cdp, "NEG", 9, .NobleNegros, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '10:         Olores(OBJETABLES)
                    sb = RenglonAlabernCalidad(cdp, "OLO", 10, .NobleObjetables, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '11	SEMILLAS DE TREBOL                      
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .tr, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '12:         Tipo()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .t, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '13:         Color()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '14	Granos Amohosados MOHO                  
                    sb = RenglonAlabernCalidad(cdp, "MOH", 14, .NobleAmohosados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '15:         Chamico()
                    sb = RenglonAlabernCalidad(cdp, "CHA", 15, .CalidadMermaChamico, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '16	Granos con Carbon                       
                    sb = RenglonAlabernCalidad(cdp, "CAR", 16, .NobleCarbon, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '17	Revolcado en tierra                     
                    sb = RenglonAlabernCalidad(cdp, "TIE", 17, .CalidadTierra, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '18:         FUMIGACION(Part)
                    sb = RenglonAlabernCalidad(cdp, "FUM", 18, .Fumigada, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '19:         FUMIGACION(CINTA)
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, ., 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '20:         CONDICION(CAMARA)
                    sb = RenglonAlabernCalidad(cdp, "CAM", 20, .NobleACamara, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro





                    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                    ' http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11299
                    '            Select Case .Producto
                    '                Case "MAIZ"
                    '                    If nombre = "grado1" Then bonif_O_rebaja = 1

                    '            End Select


                    '                    Buen día! de los TXT enviados seguimos viendo que en el de AnalisisW_SL.TXT se envia los resultados sin el Þ bonificación o rebaja, es el caso del grado que genera una bonificación de %1,5, y en columna de "Merma" envia 0, cuando debería haber enviado -1,5

                    'Ej.copiado de AnalisisW_SL.TXT
                    'Pre |CP |Vagon |Codi|Rubro |Porcenta|Cantidad|% Merma |Kg Merma
                    '0005|35252656| |0020|CAM |00001,00|00000000|00000,00|0000000
                    '0005|35252651| |0021|GR1 |00001,00|00000000|00000,00|0000000
                    '0005|35252651| |0022|GR2 |00001,00|00000000|00000,00|0000000
                    '0005|35252651| |0023|GR3 |00001,00|00000000|00000,00|0000000

                    'Ej.indicando como se debería ver
                    'Pre |CP |Vagon |Codi|Rubro |Porcenta|Cantidad|% Merma |Kg Merma
                    '0005|35252656| |0020|CAM |00001,00|00000000|00000,00|0000000
                    '0005|35252651| |0021|GR1 |00001,00|00000000|-0001,50|0000000
                    '0005|35252651| |0022|GR2 |00001,00|00000000|-0001,50|0000000
                    '0005|35252651| |0023|GR3 |00001,00|00000000|-0001,50|0000000


                    'En síntesis, la columna de "Merma" en el muestreo que vimos continúa en cero cuando debería estar mostrando el % de bonificación (en negativo) o el % de rebaja (en positivo), siempre y cuando el valor observado en columna "Porcenta" genere un % de bonificación o merma.
                    'Copiamos detalle enviado anteriormente por Inés Werner:


                    '1) Código del rubro.
                    '2) Porcentaje Observado (referido al rubro)
                    '3) Porcentaje de Merma: se informa el descuento o bonificación que debe aplicarse por ese rubro y escala. Puede venir en cero.
                    '4) Kilos de merma:
                    'Es cero eI Porcentaje de merma = 0.
                    'Es distinto de cero si Porcentaje de merma <> 0 y rubro descuenta en Kilos.
                    'Es cero si Porcentaje de merma <> 0 y rubro no descuenta en Kilos.

                    'Si hubiera que cobrar un servicio en kilos (por ejemplo Secada), se parametriza como otro rubro = 46 (en la tabla que enviamos). Porcentaje y kilos lo que vayan a cobrarse.

                    '                    Saludos!()



                    Dim bonifrebajagrado1, cantbonifgrado1
                    Dim bonifrebajagrado2, cantbonifgrado2
                    Dim bonifrebajagrado3, cantbonifgrado3





                    Select Case .Producto
                        Case "MAIZ", "Maiz Pizingallo", "Maiz Map".ToUpper
                            '            Maiz()
                            'Grado 1 bonifica 1 %
                            'Grado 2 no bonifica ni rebaja
                            'Grado 3 Rebaja 1.50%
                            bonifrebajagrado1 = "B"
                            cantbonifgrado1 = -1
                            bonifrebajagrado2 = ""
                            cantbonifgrado2 = 0
                            bonifrebajagrado3 = "R"
                            cantbonifgrado3 = 1.5

                        Case "TRIGO"

                            '            Trigo()
                            'Grado 1 Bonifica 1.50%
                            'Grado 2 no bonifica ni rebaja
                            'Grado 3 Rebaja 1%
                            bonifrebajagrado1 = "B"
                            cantbonifgrado1 = -1.5
                            bonifrebajagrado2 = ""
                            cantbonifgrado2 = 0
                            bonifrebajagrado3 = "R"
                            cantbonifgrado3 = 1
                        Case "SORGO"
                            '            Sorgo()
                            'Grado 1 Bonifica 1%
                            'Grado 2 no bonifica ni rebaja
                            'Grado 3 Rebaja 1.50 %

                            bonifrebajagrado1 = "B"
                            cantbonifgrado1 = -1
                            bonifrebajagrado2 = ""
                            cantbonifgrado2 = 0
                            bonifrebajagrado3 = "R"
                            cantbonifgrado3 = 1.5
                        Case Else
                            bonifrebajagrado1 = ""
                            cantbonifgrado1 = 0
                            bonifrebajagrado2 = ""
                            cantbonifgrado2 = 0
                            bonifrebajagrado3 = ""
                            cantbonifgrado3 = 0
                    End Select

                    '21:         GRADO(1)
                    sb = RenglonAlabernCalidad(cdp, "GR1", 21, .NobleGrado, bonifrebajagrado1, cantbonifgrado1, nF, cantbonifgrado1)  'no tenemos la abreviatura del rubro

                    '22:         GRADO(2)
                    sb = RenglonAlabernCalidad(cdp, "GR2", 22, .NobleGrado, bonifrebajagrado2, cantbonifgrado2, nF, cantbonifgrado2)  'no tenemos la abreviatura del rubro

                    '23:         GRADO(3)
                    sb = RenglonAlabernCalidad(cdp, "GR3", 23, .NobleGrado, bonifrebajagrado3, cantbonifgrado3, nF, cantbonifgrado3)  'no tenemos la abreviatura del rubro





                    '24:         Temperatura()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '25:         Proteinas()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '26:         FONDO()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '27:         MERMA(CONVENIDA)
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '28:         Tierra()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '29:         Averia()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, , 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '30:         Panza(Blanca)
                    sb = RenglonAlabernCalidad(cdp, "BLA", 30, .NoblePanzaBlanca, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '31:         MERMA(TOTAL) 'la merma se indica individualmente en cada calidad http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11124
                    'sb = RenglonAlabernCalidad(cdp, "MER", 31, .Merma, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro



                    '32:         Cuerpos(Extraños)
                    sb = RenglonAlabernCalidad(cdp, "EXT", 32, .NobleExtranos, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '33:         Total(Dañados)
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '34	Quebrados y/o Chuzos                    
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '38:         Ardidos()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '39:         Granos(Verdes)
                    sb = RenglonAlabernCalidad(cdp, "VER", 39, .NobleVerdes, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '40	Humedad y chamicos                      
                    ' sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '41	P.H. grado y tipo (trigo)               
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '42	Grado y color (sorgo)                   
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '43	Grado tipo y color (ma¡z)               
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '44:         Análisis(completo)
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '45	Granos Ardidos y/o Dañados              
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '46:         Gastos(Secada)
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '47	Merma x chamicos                        
                    sb = RenglonAlabernCalidad(cdp, "CHA", 47, .CalidadMermaChamico, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '48:         Silo()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '49:         Merma(Volatil)
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '50	Acidez de la Materia Grasa              
                    sb = RenglonAlabernCalidad(cdp, "ACI", 50, .NobleAcidezGrasa, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '51:         Aflatoxinas()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '52	Arbitraje Otras Causas Calidad Inferior
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '53	Ardidos y Dañados por Calor             
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '54:         Brotados()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .bro, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '55	Coloreados y/o con Estrias Roja         
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '56:         Contenido(Proteico)
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '57:         Cornezuelo()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '58	Descascarado y Roto                     
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '59	Enyesados o Muertos                     
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '60:         Esclerotos()
                    ' sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '61	Excremento de Roedores                  
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '62:         Falling(Number)
                    ' sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '63:         Granos(Helados)
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '64:         Granos(Negros)
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '65	Granos Otro Color                       
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '66:         Granos(Sueltos)
                    ' sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '67	Manchados y/o Coloreados                
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '68	Materia Grasa S.S.S.                    
                    sb = RenglonAlabernCalidad(cdp, "GRA", 68, .NobleMGrasa, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '70:         Otro(Tipo)
                    ' sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '71	Quebrados y/o Chuzos                    
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .chu, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '72	Quebrados y/o Partidos                  
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '73	Rendimiento de Granos Enteros           
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '74	Rendimiento de Granos Quebrados         
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '75	Rendimiento sobre zaranda 6.25 mm       
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '76	Rendimiento sobre zaranda 7.5 mm        
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '77:         Sedimento()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '78	Semillas de Bejuco y/o Porotillo        
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '79:         Total(Dañados)
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '80:         Verde(Intenso)
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '81:         Grado()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '82:         Calibre()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '83:         Capacidad(Germinativa)
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '84:         Tal(Cual)
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '85:         Insectos(Vivos)
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .ins, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '86:         Gluten()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '87:         Zaranda()
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '88	Granos quemados o averia    
                    sb = RenglonAlabernCalidad(cdp, "QUE", 88, .CalidadGranosQuemados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro

                    '999:        Otras(mermas)
                    'sb = RenglonAlabernCalidad(cdp, "DAÑ", 1, .NobleDaniados, 0, 0, nF, 0)  'no tenemos la abreviatura del rubro




                    'sb = RenglonAlabernCalidad(cdp, 0, .NobleGrado, 0, 0, nF, "01") '	0	GRADO
                    'sb = RenglonAlabernCalidad(cdp, 1, .FueraDeEstandar, 0, 0, nF) '	1	GRADO FUERA DE STANDARD
                    'sb = RenglonAlabernCalidad(cdp, 1044, .CalidadMermaChamico, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01") '	1044	MERMA POR CHAMICO
                    'sb = RenglonAlabernCalidad(cdp, 1212, .CalidadMermaZarandeo, .CalidadMermaZarandeoBonifica_o_Rebaja, 0, nF, "02") '	1212	SOBRE ZARANDA  2.5 MM.
                    'sb = RenglonAlabernCalidad(cdp, 1440, .CalidadGranosQuemados, .CalidadGranosQuemadosBonifica_o_Rebaja, 0, nF, "03") '	1440	GRANOS QUEMADOS O DE AVERIA
                    'sb = RenglonAlabernCalidad(cdp, 1531, .CalidadTierra, .CalidadTierraBonifica_o_Rebaja, 0, nF, "04") '	1531	TIERRA

                    'sb = RenglonAlabernCalidad(cdp, 2112, .CalidadPuntaSombreada, .CalidadTierraBonifica_o_Rebaja, 0, nF, "04") '	2112	GRANOS PUNTA SOMBREADA P/TIERRA



                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1111	TOTAL GRANOS DAÑADOS
                    'sb = RenglonAlabernCalidad(cdp, 1112, .NobleExtranos, 0, nF) '	1112	MATERIAS EXTRAÑAS
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1112	TOTAL MATERIAS EXTRAÑAS
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1114	TOTAL MATERIAS EXTRAÑAS INCL. TIERRA.
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1130	TOTAL CALIDAD
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1140	SUB TOTAL
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1150	DESECHOS TOTALES
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1214	BAJO     ZARANDA  2.2 MM.
                    'sb = RenglonAlabernCalidad(cdp, 1300, .NobleDaniados, 0, nF) '	1300	GRANOS DAÑADOS
                    'sb = RenglonAlabernCalidad(cdp, 1311, .NobleVerdes, 0, nF) '	1311	GRANOS VERDES
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1420	GNOS.ARDIDOS Y/O DAÑADOS P/CALOR
                    'sb = RenglonAlabernCalidad(cdp, 1460, .NobleCarbon, 0, nF) '	1460	GRANOS CON CARBON
                    'sb = RenglonAlabernCalidad(cdp, 1470, .NoblePanzaBlanca, 0, nF) '	1470	GRANOS PANZA BLANCA
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1480	GRANOS DE OTRO TIPO
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1490	GRANOS DE OTRO COLOR
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1510	MATERIAS EXTRAÑAS
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1511	MATERIAS EXTRAÑAS  SIN VALOR
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1512	MATERIAS EXTRAÑAS CON VALOR
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1513	MATERIAS INERTES Y SEMILLAS EXTRAÑAS
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1514	MAT.EXT.Y SORGO NO GRANIFERO
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1515	MATERIAS EXTRAÑAS SIN ESCLEROTOS
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1520	CUERPOS EXTRAÑOS
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1521	CUERPOS EXTRAÑOS SIN VALOR
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1522	CUERPOS EXTRAÑOS CON VALOR
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1523	CUERPOS EXTRAÑOS SIMIL ALPISTE
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1524	MATERIAS EXTRAÑAS (SIN TIERRA)
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1525	C.EXTRAÑOS(INC.DESC.ROTOS Y VAN)
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1541	ESCLEROTOS
                    'sb = RenglonAlabernCalidad(cdp, 1551, .NobleNegros, 0, nF) '	1551	GRANOS NEGROS
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1552	GRANOS VERDES INTENSOS
                    'sb = RenglonAlabernCalidad(cdp, 1611, .NobleQuebrados, 0, nF) '	1611	GRANOS QUEBRADOS
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1651	GRANOS QUEBRADOS Y/O CHUZOS
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1652	GRANOS QUEBRADOS Y/O PARTIDOS
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1654	GRANOS QUEBRADOS, PART.,  PEL.,  DAÑADOS
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1655	GRANOS DESCASCARADOS Y ROTOS
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1656	GRANOS PELADOS Y ROTOS
                    'sb = RenglonAlabernCalidad(cdp, 1711, .NobleHectolitrico, 0, nF) '	1711	PESO HECTOLITRICO
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2010	MANCHADO
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2011	LIBRE
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2013	LIGERAMENTE
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2014	RAZONABLEMENTE
                    'sb = RenglonAlabernCalidad(cdp, 2021, .NobleObjetables, 0, nF) '	2021	OLOR OBJETABLE
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2022	OLOR A HUMEDAD
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2023	OLOR A TREBOL
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2024	OLOR A CARBON
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2041	EXCREMENTOS  DE ROEDORES
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2051	CORNEZUELO
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2061	TRIGO PAN
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2062	CHAMICO(semillas cada 100 gr.)
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2063	SEMILLAS DE TREBOL
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2064	SEMILLAS DE TREBOL DE OLOR
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleRevolcado, 0, nF) '	2111	GRANOS REVOLCADOS EN TIERRA
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2112	GRANOS PUNTA SOMBREADA P/TIERRA
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2121	GRANOS REVOLCADOS EN CARBON
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2122	GRANOS PUNTA NEGRA POR CARBON
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2123	G.PTA.NEG.P/CARBON Y OLOR CARBON
                    'sb = RenglonAlabernCalidad(cdp, 2131, .NobleAmohosados, 0, nF) '	2131	GRANOS AMOHOSADOS
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2151	VITREOSIDAD
                    'sb = RenglonAlabernCalidad(cdp, 2161, .NoblePicados, 0, nF) '	2161	GRANOS PICADOS
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2211	DURO
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2213	DENTADO
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2214	SEMI DURO
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2215	BLANDO
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2218	BLANCA
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2219	AMARILLA
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2232	COLORADO
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2233	AMARILLO
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2234	BLANCO
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3020	HUMEDAD
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3113	PROTEINA (s/base 13,5 % H)
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3122	PROTEINA (s.s.s.)
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3212	GLUTEN HÚMEDO M.INTEGRAL(s/base 13.5% H)
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3212	GLUTEN MOL.INT.HUM.B/13,5 %H
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3217	GLUTEN MOL.INT.SECO B/13,5 %H
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3217	GLUTEN SECO M.INTEGRAL(s/base 13.5% H)
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3222	GLUTEN HÚMEDO HARINA (s/base 13.5% H)
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3227	GLUTEN SECO HARINA (s/base 13.5% H)
                    'sb = RenglonAlabernCalidad(cdp, 11, .NobleMGrasa, 0, nF) '	4112	MATERIA GRASA (s.s.s.)
                    'sb = RenglonAlabernCalidad(cdp, 11, .NobleAcidezGrasa, 0, nF) '	4131	ACIDEZ DE LA  MATERIA GRASA
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	4132	CAPACIDAD GERMINATIVA
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	4142	FIBRA (s.s.s.)
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	4268	ACIDO OLEICO
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	4272	ACIDO ERUCICO
                    ''sb = RenglonAlabernCalidad(cdp, 11, .NobleExtranos, 0, nF) '	4510	GLUCOSINOLATOS




                    Dim prefijo = Left(.NumeroCartaDePorte.ToString, IIf(Len(.NumeroCartaDePorte.ToString) > 8, Len(.NumeroCartaDePorte.ToString) - 8, 0)).PadLeft(4, "0")
                    If prefijo = "0000" Then
                        If bPrefijadorauto Then
                            prefijo = "0005"
                        Else

                            sErroresPrefijo &= "<a href=""CartaDePorte.aspx?Id=" & .IdCartaDePorte & """ target=""_blank"">" & .NumeroCartaDePorte & "</a>; "
                        End If
                    End If
                    sb &= prefijo

                    'PrintLine(nF, sb)
                End With
            Next

            FileClose(nF)


            sErrores = "<br/>Cartas sin prefijo: <br/>" & sErroresPrefijo & "<br/> Procedencias sin código ONCCA:<br/> " & sErroresProcedencia & "<br/>Destinos sin código ONCCA: <br/>" & sErroresDestinos

            If True Then
                If sErroresPrefijo <> "" Or sErroresProcedencia <> "" Or sErroresDestinos <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If

            Return vFileName

        End Function

        Public Shared Function Sincronismo_AmaggiCalidades(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, ByVal titulo As String, ByVal sWHERE As String, SC As String) As String

            '            Nombre(RESULTA.TXT)
            '            Tipo(ASCII)
            'Longitud de registro	71

            'Descripción del registro

            'Nombre	             Longitud      Desde    Hasta	Tipo de Dato
            'Fecha	de descarga		6	1	6	N	ddmmaa
            'Carta de porte			11	7	17	N	
            'Número de resultado		2	18	19	N
            'Código de ensayo		5	20	24	N
            'Resultado del ensayo		7	25	31	N
            'Kilos  				7	32	38	N
            'Cereal 				2	39	40	N
            'Número de Vagón		8	41	48	N
            'Importe de honorarios		9	49	57	N
            'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja
            'Total de bonificación o rebaja	5	59	63	N	
            'Fuera de standard		1	64	64	A	S-Si	N-No
            'Número de certificado		7	65	71	N	





            'Número de resultado 2 18 19 N Número de certificado 7 65 71 N Con estos datos agreguen un nro correlativo y único, que identifique al análisis y listo, puede ser una numeración interna de Uds. respetando siempre las longitudes de datos del diseño. 
            'Importe de honorarios 9 49 57 N Envíen 0 en los honorarios sino es de la operatoria de Williams. Los honorarios son de la cámara porque la misma cobra por cada análisis. 
            'Bonifica o Rebaja 1 58 58 A B-Bonifica R-Rebaja Esto es clave, por ejemplo el ítems de “Materias extrañas”, bonifica o rebaja, por ejemplo el valor 1.5 cargado en este ítems es Bonifica o Rebaja?. 
            'Total de bonificación o rebaja 5 59 63 N Envíen 0 
            'Fuera de standard 1 64 64 A S-Si N-No Esto es si una calidad mala es S, esto significa que no sirve la calidad. Normalmente viene en N Saludos.-"



            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroAmaggiAnalisis " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow



            Dim id_trigocandeal = BuscaIdArticuloPreciso("TRIGO CANDEAL", SC) 'pan y forrajero
            Dim id_trigopan = BuscaIdArticuloPreciso("TRIGO PAN", SC) 'pan y forrajero
            Dim id_trigoforraj = BuscaIdArticuloPreciso("TRIGO FORRAJERO", SC) 'pan y forrajero

            Dim id_soja = BuscaIdArticuloPreciso("SOJA", SC)
            Dim id_sorgo = BuscaIdArticuloPreciso("SORGO GRANIFERO", SC)
            Dim id_maiz = BuscaIdArticuloPreciso("MAIZ", SC)
            Dim id_girasol = BuscaIdArticuloPreciso("GIRASOL", SC)








            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp


                    i = 0 : sb = ""

                    Dim cero = 0




                    'Nombre	             Longitud      Desde    Hasta	Tipo de Dato
                    'Fecha	de descarga		6	1	6	N	ddmmaa
                    'Carta de porte			11	7	17	N	
                    'Número de resultado		2	18	19	N
                    'Código de ensayo		5	20	24	N
                    'Resultado del ensayo		7	25	31	N
                    'Kilos  				7	32	38	N
                    'Cereal 				2	39	40	N
                    'Número de Vagón		8	41	48	N
                    'Importe de honorarios		9	49	57	N
                    'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja
                    'Total de bonificación o rebaja	5	59	63	N	
                    'Fuera de standard		1	64	64	A	S-Si	N-No
                    'Número de certificado		7	65	71	N	

                    '                                               Nombre	              Lon  Desde Hasta	Tipo de Dato





                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    'consulta AMAGGI
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7963
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////

                    If .IsFueraDeEstandarNull Then .FueraDeEstandar = 0
                    If .IsCalidadMermaChamicoNull Then
                        .CalidadMermaChamico = 0
                        .CalidadMermaChamicoBonifica_o_Rebaja = 0
                    Else
                        'Stop
                    End If
                    If .IsCalidadMermaZarandeoNull Then
                        .CalidadMermaZarandeo = 0
                        .CalidadMermaZarandeoBonifica_o_Rebaja = 0
                    End If
                    If .IsCalidadGranosQuemadosNull Then
                        .CalidadGranosQuemados = 0
                        .CalidadGranosQuemadosBonifica_o_Rebaja = 0
                    End If
                    If .IsCalidadTierraNull Then
                        .CalidadTierra = 0
                        .CalidadTierraBonifica_o_Rebaja = 0
                    End If

                    If .IsCalidadPuntaSombreadaNull Then
                        .CalidadPuntaSombreada = 0
                        '.CalidadTierraBonifica_o_Rebaja = 0
                    End If




                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////
                    '                pero si no tiene ninguna calidad, los datos de la carta de porte tienen que ir igual
                    'Mariano Scalella dice
                    'guardiola, los renglones tienen el codigo de la calidad q se mide. lo dejo en blanco entonces? 
                    'estas excepciones nos las tienen q aclarar
                    'perate q reviso el ejemplo a ver como safan
                    'el codigo de cual es la calidad q se mide va del caracter 20 al 24. en el ejemplo q nos 
                    'mandaron siempre hay dato ahi. le meto entonces uno obligatorio, con codigo "0000"?
                    '                Andrés(dice)
                    'si, para mandarles un ejemplo
                    'pero en el correo les pregunto

                    sb = RenglonAmaggiCalidad(cdp, 0, 0, 0, 0, nF, "00") 'RENGLON FORZOSO, para que haya dato aunque no haya calada
                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////

                    'sb = RenglonAmaggiCalidad(cdp, 0, .NobleGrado, 0, 0, nF, "01") '	0	GRADO
                    'sb = RenglonAmaggiCalidad(cdp, 1, .FueraDeEstandar, 0, 0, nF) '	1	GRADO FUERA DE STANDARD




                    Select Case CodigoArticuloAmaggi(.Producto)

                        Case 12

                            '	12	SOJA	1044	MERMA POR CHAMICO
                            '	12	SOJA	1300	GRANOS DAÑADOS
                            '	12	SOJA	1440	GRANOS QUEMADOS O DE AVERIA
                            '	12	SOJA	1111	TOTAL GRANOS DAÑADOS
                            '	12	SOJA	1311	GRANOS VERDES
                            '	12	SOJA	1524	MATERIAS EXTRAÑAS (SIN TIERRA)
                            '	12	SOJA	1531	TIERRA
                            '	12	SOJA	1114	TOTAL MATERIAS EXTRAÑAS INCL. TIERRA.
                            '	12	SOJA	1652	GRANOS QUEBRADOS Y/O PARTIDOS
                            '	12	SOJA	1551	GRANOS NEGROS
                            '	12	SOJA	2062	CHAMICO(semillas cada 100 gr.)
                            '	12	SOJA	2111	GRANOS REVOLCADOS EN TIERRA
                            '	12	SOJA	2131	GRANOS AMOHOSADOS
                            '	12	SOJA	3020	HUMEDAD
                            '	12	SOJA	2021	OLOR OBJETABLE
                            '	12	SOJA	3122	PROTEINA (s.s.s.)
                            '	12	SOJA	4112	MATERIA GRASA (s.s.s.)
                            '	12	SOJA	4142	FIBRA (s.s.s.)

                            sb = RenglonAmaggiCalidad(cdp, 1044, .CalidadMermaChamico, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01") '	1044	MERMA POR CHAMICO
                            sb = RenglonAmaggiCalidad(cdp, 1212, .CalidadMermaZarandeo, .CalidadMermaZarandeoBonifica_o_Rebaja, 0, nF, "02") '	1212	SOBRE ZARANDA  2.5 MM.
                            sb = RenglonAmaggiCalidad(cdp, 1440, .CalidadGranosQuemados, .CalidadGranosQuemadosBonifica_o_Rebaja, 0, nF, "03") '	1440	GRANOS QUEMADOS O DE AVERIA
                            sb = RenglonAmaggiCalidad(cdp, 1531, .CalidadTierra, .CalidadTierraBonifica_o_Rebaja, 0, nF, "04") '	1531	TIERRA

                            sb = RenglonAmaggiCalidad(cdp, 2112, .CalidadPuntaSombreada, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05") '	2112	GRANOS PUNTA SOMBREADA P/TIERRA
                            sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1111, .NobleDaniados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1711, .NobleHectolitrico, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1611, .NobleQuebrados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1551, .NobleNegros, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 2021, .NobleObjetables, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 2131, .NobleAmohosados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1460, .NobleCarbon, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1470, .NoblePanzaBlanca, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1311, .NobleVerdes, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 4131, .NobleAcidezGrasa, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 4112, .NobleMGrasa, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")


                            'El ítems 03020 es el único que está en la lista de que mandan en el registro, los otros dos de donde los sacaron?

                            '24041300030894591050 3020 000001500299001200000000000000000B00.00N1110326
                            '24041300030894591050 1112 000000400299001200000000000000000B00.00N1110326
                            '24041300030894591050 2161 000000600299001200000000000000000B00.00N1110326

                        Case 2
                            '	2	MAIZ	2131	GRANOS AMOHOSADOS
                            '	2	MAIZ	2021	OLOR OBJETABLE
                            '	2	MAIZ	2022	OLOR A HUMEDAD
                            '	2	MAIZ	1300	GRANOS DAÑADOS
                            '	2	MAIZ	1510	MATERIAS EXTRAÑAS
                            '	2	MAIZ	1611	GRANOS QUEBRADOS
                            '	2	MAIZ	1480	GRANOS DE OTRO TIPO
                            '	2	MAIZ	1490	GRANOS DE OTRO COLOR
                            '	2	MAIZ	2161	GRANOS PICADOS
                            '	2	MAIZ	2062	CHAMICO(semillas cada 100 gr.)
                            '	2	MAIZ	3020	HUMEDAD
                            '	2	MAIZ	1711	PESO HECTOLITRICO
                            '	2	MAIZ	2211	DURO
                            '	2	MAIZ	2213	DENTADO
                            '	2	MAIZ	2233	AMARILLO
                            '	2	MAIZ	2234	BLANCO
                            '	2	MAIZ	2232	COLORADO
                            '	2	MAIZ	0	GRADO
                            '	2	MAIZ	1	GRADO FUERA DE STANDARD

                            sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1711, .NobleHectolitrico, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")

                            sb = RenglonAmaggiCalidad(cdp, 2131, .NobleAmohosados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 2021, .NobleObjetables, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")

                            sb = RenglonAmaggiCalidad(cdp, 1300, .NobleDaniados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1611, .NobleQuebrados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 2062, .CalidadMermaChamico, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01") '	1044	MERMA POR CHAMICO



                        Case 1
                            sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1711, .NobleHectolitrico, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")

                            sb = RenglonAmaggiCalidad(cdp, 2021, .NobleObjetables, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")

                            sb = RenglonAmaggiCalidad(cdp, 1111, .NobleDaniados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1651, .NobleQuebrados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 2062, .CalidadMermaChamico, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01") '	1044	MERMA POR CHAMICO


                            '	1	TRIGO	2021	OLOR OBJETABLE
                            '	1	TRIGO	2022	OLOR A HUMEDAD
                            '	1	TRIGO	2023	OLOR A TREBOL
                            '	1	TRIGO	2024	OLOR A CARBON
                            '	1	TRIGO	2111	GRANOS REVOLCADOS EN TIERRA
                            '	1	TRIGO	2112	GRANOS PUNTA SOMBREADA P/TIERRA
                            '	1	TRIGO	2121	GRANOS REVOLCADOS EN CARBON
                            '	1	TRIGO	2122	GRANOS PUNTA NEGRA POR CARBON
                            '	1	TRIGO	2123	G.PTA.NEG.P/CARBON Y OLOR CARBON
                            '	1	TRIGO	1300	GRANOS DAÑADOS
                            '	1	TRIGO	1420	GNOS.ARDIDOS Y/O DAÑADOS P/CALOR
                            '	1	TRIGO	1111	TOTAL GRANOS DAÑADOS
                            '	1	TRIGO	1510	MATERIAS EXTRAÑAS
                            '	1	TRIGO	1651	GRANOS QUEBRADOS Y/O CHUZOS
                            '	1	TRIGO	1470	GRANOS PANZA BLANCA
                            '	1	TRIGO	1460	GRANOS CON CARBON
                            '	1	TRIGO	2161	GRANOS PICADOS
                            '	1	TRIGO	2051	CORNEZUELO
                            '	1	TRIGO	2062	CHAMICO(semillas cada 100 gr.)
                            '	1	TRIGO	2064	SEMILLAS DE TREBOL DE OLOR
                            '	1	TRIGO	2214	SEMI DURO
                            '	1	TRIGO	2215	BLANDO
                            '	1	TRIGO	2211	DURO
                            '	1	TRIGO	1711	PESO HECTOLITRICO
                            '	1	TRIGO	0	GRADO
                            '	1	TRIGO	1	GRADO FUERA DE STANDARD
                            '	1	TRIGO	3020	HUMEDAD
                            '	1	TRIGO	3113	PROTEINA (s/base 13,5 % H)
                            '	1	TRIGO	3212	GLUTEN MOL.INT.HUM.B/13,5 %H
                            '	1	TRIGO	3222	GLUTEN HÚMEDO HARINA (s/base 13.5% H)
                            '	1	TRIGO	3217	GLUTEN MOL.INT.SECO B/13,5 %H
                            '	1	TRIGO	3227	GLUTEN SECO HARINA (s/base 13.5% H)
                        Case 4
                            sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1711, .NobleHectolitrico, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")

                            sb = RenglonAmaggiCalidad(cdp, 2021, .NobleObjetables, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")

                            sb = RenglonAmaggiCalidad(cdp, 1300, .NobleDaniados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")


                            '	4	AVENA	1511	MATERIAS EXTRAÑAS  SIN VALOR
                            '	4	AVENA	1512	MATERIAS EXTRAÑAS CON VALOR
                            '	4	AVENA	1656	GRANOS PELADOS Y ROTOS
                            '	4	AVENA	1300	GRANOS DAÑADOS
                            '	4	AVENA	1130	TOTAL CALIDAD
                            '	4	AVENA	2161	GRANOS PICADOS
                            '	4	AVENA	2013	LIGERAMENTE
                            '	4	AVENA	2014	RAZONABLEMENTE
                            '	4	AVENA	2011	LIBRE
                            '	4	AVENA	2010	MANCHADO
                            '	4	AVENA	1711	PESO HECTOLITRICO
                            '	4	AVENA	1480	GRANOS DE OTRO TIPO
                            '	4	AVENA	3020	HUMEDAD
                            '	4	AVENA	2021	OLOR OBJETABLE
                            '	4	AVENA	0	GRADO
                            '	4	AVENA	1	GRADO FUERA DE STANDARD
                            '	4	AVENA	2218	BLANCA
                            '	4	AVENA	2219	AMARILLA

                        Case 3

                            sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")


                            '				
                            '	3	LINO	1520	CUERPOS EXTRAÑOS
                            '	3	LINO	4112	MATERIA GRASA (s.s.s.)
                            '	3	LINO	4131	ACIDEZ DE LA  MATERIA GRASA
                            '	3	LINO	2111	GRANOS REVOLCADOS EN TIERRA
                            '	3	LINO	3020	HUMEDAD
                            '				
                        Case 6
                            sb = RenglonAmaggiCalidad(cdp, 1711, .NobleHectolitrico, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")


                            sb = RenglonAmaggiCalidad(cdp, 1300, .NobleDaniados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1611, .NobleQuebrados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")


                            '				
                            '	6	CENTENO	1521	CUERPOS EXTRAÑOS SIN VALOR
                            '	6	CENTENO	1522	CUERPOS EXTRAÑOS CON VALOR
                            '	6	CENTENO	1611	GRANOS QUEBRADOS
                            '	6	CENTENO	1300	GRANOS DAÑADOS
                            '	6	CENTENO	1130	TOTAL CALIDAD
                            '	6	CENTENO	2051	CORNEZUELO
                            '	6	CENTENO	2161	GRANOS PICADOS
                            '	6	CENTENO	1711	PESO HECTOLITRICO
                            '	6	CENTENO	0	GRADO
                            '	6	CENTENO	1	GRADO FUERA DE STANDARD
                        Case 7
                            sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")


                            sb = RenglonAmaggiCalidad(cdp, 1300, .NobleDaniados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 2062, .CalidadMermaChamico, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01") '	1044	MERMA POR CHAMICO


                            '				
                            '	7	ALPISTE	1525	C.EXTRAÑOS(INC.DESC.ROTOS Y VAN)
                            '	7	ALPISTE	1523	CUERPOS EXTRAÑOS SIMIL ALPISTE
                            '	7	ALPISTE	1300	GRANOS DAÑADOS
                            '	7	ALPISTE	1552	GRANOS VERDES INTENSOS
                            '	7	ALPISTE	2051	CORNEZUELO
                            '	7	ALPISTE	2041	EXCREMENTOS  DE ROEDORES
                            '	7	ALPISTE	2062	CHAMICO(semillas cada 100 gr.)
                            '	7	ALPISTE	3020	HUMEDAD
                        Case 8
                            sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")


                            sb = RenglonAmaggiCalidad(cdp, 2062, .CalidadMermaChamico, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01") '	1044	MERMA POR CHAMICO


                            '	8	GIRASOL	1112	TOTAL MATERIAS EXTRAÑAS
                            '	8	GIRASOL	2062	CHAMICO(semillas cada 100 gr.)
                            '	8	GIRASOL	4112	MATERIA GRASA (s.s.s.)
                            '	8	GIRASOL	4131	ACIDEZ DE LA  MATERIA GRASA
                            '	8	GIRASOL	3020	HUMEDAD
                            '	8	GIRASOL	1515	MATERIAS EXTRAÑAS SIN ESCLEROTOS
                            '	8	GIRASOL	1541	ESCLEROTOS
                        Case 9
                            sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")


                            sb = RenglonAmaggiCalidad(cdp, 1300, .NobleDaniados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 2062, .CalidadMermaChamico, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01") '	1044	MERMA POR CHAMICO


                            '				
                            '	9	MIJO	1300	GRANOS DAÑADOS
                            '	9	MIJO	1520	CUERPOS EXTRAÑOS
                            '	9	MIJO	0	GRADO
                            '	9	MIJO	1	GRADO FUERA DE STANDARD
                            '	9	MIJO	1655	GRANOS DESCASCARADOS Y ROTOS
                            '	9	MIJO	2161	GRANOS PICADOS
                            '	9	MIJO	2062	CHAMICO(semillas cada 100 gr.)
                            '	9	MIJO	3020	HUMEDAD
                        Case 11

                            sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")

                            sb = RenglonAmaggiCalidad(cdp, 2131, .NobleAmohosados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 2021, .NobleObjetables, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")

                            sb = RenglonAmaggiCalidad(cdp, 1300, .NobleDaniados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1611, .NobleQuebrados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 2062, .CalidadMermaChamico, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01") '	1044	MERMA POR CHAMICO



                            '	11	SORGO GRANIFERO	1490	GRANOS DE OTRO COLOR
                            '	11	SORGO GRANIFERO	1300	GRANOS DAÑADOS
                            '	11	SORGO GRANIFERO	1514	MAT.EXT.Y SORGO NO GRANIFERO
                            '	11	SORGO GRANIFERO	1611	GRANOS QUEBRADOS
                            '	11	SORGO GRANIFERO	2161	GRANOS PICADOS
                            '	11	SORGO GRANIFERO	2062	CHAMICO(semillas cada 100 gr.)
                            '	11	SORGO GRANIFERO	3020	HUMEDAD
                            '	11	SORGO GRANIFERO	2021	OLOR OBJETABLE
                            '	11	SORGO GRANIFERO	2022	OLOR A HUMEDAD
                            '	11	SORGO GRANIFERO	2131	GRANOS AMOHOSADOS
                            '	11	SORGO GRANIFERO	0	GRADO
                            '	11	SORGO GRANIFERO	1	GRADO FUERA DE STANDARD
                        Case 15
                            sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1300, .NobleDaniados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1711, .NobleHectolitrico, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")

                            sb = RenglonAmaggiCalidad(cdp, 2021, .NobleObjetables, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")

                            sb = RenglonAmaggiCalidad(cdp, 1111, .NobleDaniados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 1651, .NobleQuebrados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 2062, .CalidadMermaChamico, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01") '	1044	MERMA POR CHAMICO

                            '	15	TRIGO FIDEO	1300	GRANOS DAÑADOS
                            '	15	TRIGO FIDEO	1420	GNOS.ARDIDOS Y/O DAÑADOS P/CALOR
                            '	15	TRIGO FIDEO	1111	TOTAL GRANOS DAÑADOS
                            '	15	TRIGO FIDEO	1510	MATERIAS EXTRAÑAS
                            '	15	TRIGO FIDEO	1651	GRANOS QUEBRADOS Y/O CHUZOS
                            '	15	TRIGO FIDEO	1460	GRANOS CON CARBON
                            '	15	TRIGO FIDEO	2151	VITREOSIDAD
                            '	15	TRIGO FIDEO	2161	GRANOS PICADOS
                            '	15	TRIGO FIDEO	2061	TRIGO PAN
                            '	15	TRIGO FIDEO	2051	CORNEZUELO
                            '	15	TRIGO FIDEO	2062	CHAMICO(semillas cada 100 gr.)
                            '	15	TRIGO FIDEO	2063	SEMILLAS DE TREBOL
                            '	15	TRIGO FIDEO	3113	PROTEINA (s/base 13,5 % H)
                            '	15	TRIGO FIDEO	3020	HUMEDAD
                            '	15	TRIGO FIDEO	1711	PESO HECTOLITRICO
                            '	15	TRIGO FIDEO	2023	OLOR A TREBOL
                            '	15	TRIGO FIDEO	2022	OLOR A HUMEDAD
                            '	15	TRIGO FIDEO	2021	OLOR OBJETABLE
                            '	15	TRIGO FIDEO	2024	OLOR A CARBON
                            '	15	TRIGO FIDEO	2112	GRANOS PUNTA SOMBREADA P/TIERRA
                            '	15	TRIGO FIDEO	2111	GRANOS REVOLCADOS EN TIERRA
                            '	15	TRIGO FIDEO	2122	GRANOS PUNTA NEGRA POR CARBON
                            '	15	TRIGO FIDEO	2123	G.PTA.NEG.P/CARBON Y OLOR CARBON
                            '	15	TRIGO FIDEO	2121	GRANOS REVOLCADOS EN CARBON
                            '	15	TRIGO FIDEO	3212	GLUTEN HÚMEDO M.INTEGRAL(s/base 13.5% H)
                            '	15	TRIGO FIDEO	3217	GLUTEN SECO M.INTEGRAL(s/base 13.5% H)
                            '	15	TRIGO FIDEO	0	GRADO
                            '	15	TRIGO FIDEO	1	GRADO FUERA DE STANDARD
                        Case 16
                            sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")

                            '				
                            '	16	CEBADA CERVECERA	1510	MATERIAS EXTRAÑAS
                            '	16	CEBADA CERVECERA	1140	SUB TOTAL
                            '	16	CEBADA CERVECERA	1654	GRANOS QUEBRADOS, PART.,  PEL.,  DAÑADOS
                            '	16	CEBADA CERVECERA	1513	MATERIAS INERTES Y SEMILLAS EXTRAÑAS
                            '	16	CEBADA CERVECERA	2161	GRANOS PICADOS
                            '	16	CEBADA CERVECERA	1460	GRANOS CON CARBON
                            '	16	CEBADA CERVECERA	1214	BAJO     ZARANDA  2.2 MM.
                            '	16	CEBADA CERVECERA	1150	DESECHOS TOTALES
                            '	16	CEBADA CERVECERA	1212	SOBRE ZARANDA  2.5 MM.
                            '	16	CEBADA CERVECERA	4132	CAPACIDAD GERMINATIVA
                            '	16	CEBADA CERVECERA	3122	PROTEINA (s.s.s.)
                            '	16	CEBADA CERVECERA	3020	HUMEDAD
                        Case 17
                            sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")

                            '	17	COLZA	1520	CUERPOS EXTRAÑOS
                            '	17	COLZA	4112	MATERIA GRASA (s.s.s.)
                            '	17	COLZA	4131	ACIDEZ DE LA  MATERIA GRASA
                            '	17	COLZA	3020	HUMEDAD

                        Case 18
                            sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 2062, .CalidadMermaChamico, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01") '	1044	MERMA POR CHAMICO




                            '	18	GIRASOL OLEICO	1112	TOTAL MATERIAS EXTRAÑAS
                            '	18	GIRASOL OLEICO	2062	CHAMICO(semillas cada 100 gr.)
                            '	18	GIRASOL OLEICO	4112	MATERIA GRASA (s.s.s.)
                            '	18	GIRASOL OLEICO	4131	ACIDEZ DE LA  MATERIA GRASA
                            '	18	GIRASOL OLEICO	3020	HUMEDAD
                            '	18	GIRASOL OLEICO	1515	MATERIAS EXTRAÑAS SIN ESCLEROTOS
                            '	18	GIRASOL OLEICO	1541	ESCLEROTOS
                            '	18	GIRASOL OLEICO	4268	ACIDO OLEICO
                        Case 21
                            sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")

                            '	21	CANOLA	1520	CUERPOS EXTRAÑOS
                            '	21	CANOLA	4112	MATERIA GRASA (s.s.s.)
                            '	21	CANOLA	4131	ACIDEZ DE LA  MATERIA GRASA
                            '	21	CANOLA	4272	ACIDO ERUCICO
                            '	21	CANOLA	4510	GLUCOSINOLATOS
                            '	21	CANOLA	3020	HUMEDAD
                        Case 25
                            sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            sb = RenglonAmaggiCalidad(cdp, 2062, .CalidadMermaChamico, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01") '	1044	MERMA POR CHAMICO


                            '	25	CÁRTAMO	1112	MATERIAS EXTRAÑAS
                            '	25	CÁRTAMO	2062	CHAMICO(semillas cada 100 gr.)
                            '	25	CÁRTAMO	4112	MATERIA GRASA (s.s.s.)
                            '	25	CÁRTAMO	4131	ACIDEZ DE LA  MATERIA GRASA
                            '	25	CÁRTAMO	3020	HUMEDAD

                        Case Else
                            'sb = RenglonAmaggiCalidad(cdp, 3020, .Humedad, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            'sb = RenglonAmaggiCalidad(cdp, 1212, .CalidadMermaZarandeo, .CalidadMermaZarandeoBonifica_o_Rebaja, 0, nF, "02") '	1212	SOBRE ZARANDA  2.5 MM.
                            'sb = RenglonAmaggiCalidad(cdp, 1440, .CalidadGranosQuemados, .CalidadGranosQuemadosBonifica_o_Rebaja, 0, nF, "03") '	1440	GRANOS QUEMADOS O DE AVERIA
                            'sb = RenglonAmaggiCalidad(cdp, 1531, .CalidadTierra, .CalidadTierraBonifica_o_Rebaja, 0, nF, "04") '	1531	TIERRA

                            'sb = RenglonAmaggiCalidad(cdp, 1111, .NobleDaniados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            'sb = RenglonAmaggiCalidad(cdp, 1711, .NobleHectolitrico, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            'sb = RenglonAmaggiCalidad(cdp, 1112, .NobleExtranos, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            'sb = RenglonAmaggiCalidad(cdp, 1611, .NobleQuebrados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            'sb = RenglonAmaggiCalidad(cdp, 2161, .NoblePicados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            'sb = RenglonAmaggiCalidad(cdp, 1551, .NobleNegros, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            'sb = RenglonAmaggiCalidad(cdp, 2021, .NobleObjetables, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            'sb = RenglonAmaggiCalidad(cdp, 2131, .NobleAmohosados, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            'sb = RenglonAmaggiCalidad(cdp, 1460, .NobleCarbon, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            'sb = RenglonAmaggiCalidad(cdp, 1470, .NoblePanzaBlanca, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            'sb = RenglonAmaggiCalidad(cdp, 1311, .NobleVerdes, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            'sb = RenglonAmaggiCalidad(cdp, 4131, .NobleAcidezGrasa, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                            'sb = RenglonAmaggiCalidad(cdp, 4112, .NobleMGrasa, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")


                    End Select

                    'sb = RenglonAmaggiCalidad(cdp, 2112, .Merma, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")

                    'sb = RenglonAmaggiCalidad(cdp, , .Fumigada, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                    'sb = RenglonAmaggiCalidad(cdp, , .NobleACamara, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")
                    'sb = RenglonAmaggiCalidad(cdp, , .NobleGrado, .CalidadTierraBonifica_o_Rebaja, 0, nF, "05")





                    '	CODIGO	NOMBRE	CODIGO	NOMBRE




                    '                    Andres disculpa la demora por este tema, mira probé este análisis y el diseño de 
                    'registro esta OK, pero noto que envían valores de ítems de calidad que no están en las 
                    'tablas de equivalencia del grano de la CP, por ejemplo esta línea mandan uds y es un CP de Soja. Debajo te paso los ítems de análisis con sus equivalencias…

                    'El ítems 03020 es el único que está en la lista de que mandan en el registro, los otros dos de donde los sacaron?

                    '24041300030894591050 3020 000001500299001200000000000000000B00.00N1110326
                    '24041300030894591050 1112 000000400299001200000000000000000B00.00N1110326
                    '24041300030894591050 2161 000000600299001200000000000000000B00.00N1110326


                    '                    GRANOS()
                    '                    ENSAYOS()
                    '                    CODIGO()
                    '                    NOMBRE()
                    '                    CODIGO()
                    '                    NOMBRE()
                    '12:
                    '                    SOJA()
                    '1044:
                    'MERMA POR CHAMICO
                    '12:
                    '                    SOJA()
                    '1300:
                    '                    GRANOS(DAÑADOS)
                    '12:
                    '                    SOJA()
                    '1440:
                    'GRANOS QUEMADOS O DE AVERIA
                    '12:
                    '                    SOJA()
                    '1111:
                    'TOTAL GRANOS DAÑADOS
                    '12:
                    '                    SOJA()
                    '1311:
                    '                    GRANOS(VERDES)
                    '12:
                    '                    SOJA()
                    '1524:
                    'MATERIAS EXTRAÑAS (SIN TIERRA)
                    '12:
                    '                    SOJA()
                    '1531:
                    '                    TIERRA()
                    '12:
                    '                    SOJA()
                    '1114:
                    'TOTAL MATERIAS EXTRAÑAS INCL. TIERRA.
                    '12:
                    '                    SOJA()
                    '1652:
                    'GRANOS QUEBRADOS Y/O PARTIDOS
                    '12:
                    '                    SOJA()
                    '1551:
                    '                    GRANOS(NEGROS)
                    '12:
                    '                    SOJA()
                    '2062:
                    'CHAMICO(semillas cada 100 gr.)
                    '12:
                    '                    SOJA()
                    '2111:
                    'GRANOS REVOLCADOS EN TIERRA
                    '12:
                    '                    SOJA()
                    '2131:
                    '                    GRANOS(AMOHOSADOS)
                    '12:
                    '                    SOJA()
                    '3020:
                    '                    HUMEDAD()
                    '12:
                    '                    SOJA()
                    '2021:
                    '                    OLOR(OBJETABLE)
                    '12:
                    '                    SOJA()
                    '3122:
                    'PROTEINA (s.s.s.)
                    '12:
                    '                    SOJA()
                    '4112:
                    'MATERIA GRASA (s.s.s.)
                    '12:
                    '                    SOJA()
                    '4142:
                    'FIBRA (s.s.s.)



                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1111	TOTAL GRANOS DAÑADOS
                    'sb = RenglonAmaggiCalidad(cdp, 1112, .NobleExtranos, 0, nF) '	1112	MATERIAS EXTRAÑAS
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1112	TOTAL MATERIAS EXTRAÑAS
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1114	TOTAL MATERIAS EXTRAÑAS INCL. TIERRA.
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1130	TOTAL CALIDAD
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1140	SUB TOTAL
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1150	DESECHOS TOTALES
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1214	BAJO     ZARANDA  2.2 MM.
                    'sb = RenglonAmaggiCalidad(cdp, 1300, .NobleDaniados, 0, nF) '	1300	GRANOS DAÑADOS
                    'sb = RenglonAmaggiCalidad(cdp, 1311, .NobleVerdes, 0, nF) '	1311	GRANOS VERDES
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1420	GNOS.ARDIDOS Y/O DAÑADOS P/CALOR
                    'sb = RenglonAmaggiCalidad(cdp, 1460, .NobleCarbon, 0, nF) '	1460	GRANOS CON CARBON
                    'sb = RenglonAmaggiCalidad(cdp, 1470, .NoblePanzaBlanca, 0, nF) '	1470	GRANOS PANZA BLANCA
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1480	GRANOS DE OTRO TIPO
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1490	GRANOS DE OTRO COLOR
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1510	MATERIAS EXTRAÑAS
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1511	MATERIAS EXTRAÑAS  SIN VALOR
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1512	MATERIAS EXTRAÑAS CON VALOR
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1513	MATERIAS INERTES Y SEMILLAS EXTRAÑAS
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1514	MAT.EXT.Y SORGO NO GRANIFERO
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1515	MATERIAS EXTRAÑAS SIN ESCLEROTOS
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1520	CUERPOS EXTRAÑOS
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1521	CUERPOS EXTRAÑOS SIN VALOR
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1522	CUERPOS EXTRAÑOS CON VALOR
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1523	CUERPOS EXTRAÑOS SIMIL ALPISTE
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1524	MATERIAS EXTRAÑAS (SIN TIERRA)
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1525	C.EXTRAÑOS(INC.DESC.ROTOS Y VAN)
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1541	ESCLEROTOS
                    'sb = RenglonAmaggiCalidad(cdp, 1551, .NobleNegros, 0, nF) '	1551	GRANOS NEGROS
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1552	GRANOS VERDES INTENSOS
                    'sb = RenglonAmaggiCalidad(cdp, 1611, .NobleQuebrados, 0, nF) '	1611	GRANOS QUEBRADOS
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1651	GRANOS QUEBRADOS Y/O CHUZOS
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1652	GRANOS QUEBRADOS Y/O PARTIDOS
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1654	GRANOS QUEBRADOS, PART.,  PEL.,  DAÑADOS
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1655	GRANOS DESCASCARADOS Y ROTOS
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	1656	GRANOS PELADOS Y ROTOS
                    'sb = RenglonAmaggiCalidad(cdp, 1711, .NobleHectolitrico, 0, nF) '	1711	PESO HECTOLITRICO
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2010	MANCHADO
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2011	LIBRE
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2013	LIGERAMENTE
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2014	RAZONABLEMENTE
                    'sb = RenglonAmaggiCalidad(cdp, 2021, .NobleObjetables, 0, nF) '	2021	OLOR OBJETABLE
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2022	OLOR A HUMEDAD
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2023	OLOR A TREBOL
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2024	OLOR A CARBON
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2041	EXCREMENTOS  DE ROEDORES
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2051	CORNEZUELO
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2061	TRIGO PAN
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2062	CHAMICO(semillas cada 100 gr.)
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2063	SEMILLAS DE TREBOL
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2064	SEMILLAS DE TREBOL DE OLOR
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleRevolcado, 0, nF) '	2111	GRANOS REVOLCADOS EN TIERRA
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2112	GRANOS PUNTA SOMBREADA P/TIERRA
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2121	GRANOS REVOLCADOS EN CARBON
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2122	GRANOS PUNTA NEGRA POR CARBON
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2123	G.PTA.NEG.P/CARBON Y OLOR CARBON
                    'sb = RenglonAmaggiCalidad(cdp, 2131, .NobleAmohosados, 0, nF) '	2131	GRANOS AMOHOSADOS
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2151	VITREOSIDAD
                    'sb = RenglonAmaggiCalidad(cdp, 2161, .NoblePicados, 0, nF) '	2161	GRANOS PICADOS
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2211	DURO
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2213	DENTADO
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2214	SEMI DURO
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2215	BLANDO
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2218	BLANCA
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2219	AMARILLA
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2232	COLORADO
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2233	AMARILLO
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	2234	BLANCO
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3020	HUMEDAD
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3113	PROTEINA (s/base 13,5 % H)
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3122	PROTEINA (s.s.s.)
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3212	GLUTEN HÚMEDO M.INTEGRAL(s/base 13.5% H)
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3212	GLUTEN MOL.INT.HUM.B/13,5 %H
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3217	GLUTEN MOL.INT.SECO B/13,5 %H
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3217	GLUTEN SECO M.INTEGRAL(s/base 13.5% H)
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3222	GLUTEN HÚMEDO HARINA (s/base 13.5% H)
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	3227	GLUTEN SECO HARINA (s/base 13.5% H)
                    'sb = RenglonAmaggiCalidad(cdp, 11, .NobleMGrasa, 0, nF) '	4112	MATERIA GRASA (s.s.s.)
                    'sb = RenglonAmaggiCalidad(cdp, 11, .NobleAcidezGrasa, 0, nF) '	4131	ACIDEZ DE LA  MATERIA GRASA
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	4132	CAPACIDAD GERMINATIVA
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	4142	FIBRA (s.s.s.)
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	4268	ACIDO OLEICO
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	4272	ACIDO ERUCICO
                    ''sb = RenglonAmaggiCalidad(cdp, 11, .NobleExtranos, 0, nF) '	4510	GLUCOSINOLATOS






                    'PrintLine(nF, sb)
                End With
            Next


            FileClose(nF)


            Return vFileName

        End Function

        Private Shared Function RenglonAmaggiCalidad(ByVal cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow, ByVal CodigoEnsayo As Integer, ByVal Resultado As Double, ByVal bonif_O_rebaja As String, ByVal Rebaja As Double, ByVal nf As Integer, ByVal numresultado As String) As String
            Dim sb = ""

            With cdp


                'Nombre	             Longitud      Desde    Hasta	Tipo de Dato
                'Fecha	de descarga		6	1	6	N	ddmmaa
                'Carta de porte			11	7	17	N	
                'Número de resultado		2	18	19	N
                'Código de ensayo		5	20	24	N
                'Resultado del ensayo		7	25	31	N
                'Kilos  				7	32	38	N
                'Cereal 				2	39	40	N
                'Número de Vagón		8	41	48	N
                'Importe de honorarios		9	49	57	N
                'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja
                'Total de bonificación o rebaja	5	59	63	N	
                'Fuera de standard		1	64	64	A	S-Si	N-No
                'Número de certificado		7	65	71	N	



                If Resultado <> 0 Or Rebaja <> 0 Then

                    'sb &= Left(NumeroCarta.ToString, 12).PadLeft(12, "0")
                    'sb &= LeftMasPadLeft(CodigoNoble, 3)
                    'sb &= LeftMasPadLeft(Resultado.ToString("00.00", System.Globalization.CultureInfo.InvariantCulture).Replace(".", ""), 20)
                    'sb &= LeftMasPadLeft(Rebaja.ToString("00.00", System.Globalization.CultureInfo.InvariantCulture).Replace(".", ""), 20)

                    Dim cero = 0

                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= .FechaDescarga.ToString("ddMMyy")         'Fecha	de descarga		6	1	6	N	ddmmaa


                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= LeftMasPadLeft(.NumeroCartaDePorte, 11)   'Carta de porte			11	7	17	N	


                    sb &= LeftMasPadLeft(numresultado, 2)                   'Número de resultado	2	18	19	N  "01,02,03,04"



                    sb &= LeftMasPadLeft(CodigoEnsayo, 5)                   'Código de ensayo		5	20	24	N

                    sb &= LeftMasPadLeft(Resultado.ToString.Replace(",", "").Replace(".", ""), 7)                   'Resultado del ensayo	7	25	31	N


                    sb &= LeftMasPadLeft(Int(.NetoFinal), 7)             'Kilos  				7	32	38	N
                    sb &= LeftMasPadLeft(CodigoArticuloAmaggi(.Producto), 2)                  'Cereal 				2	39	40	N
                    sb &= LeftMasPadLeft(.SubnumeroVagon, 8)        'Número de Vagón		8	41	48	N
                    sb &= LeftMasPadLeft(cero, 9)                   'Importe de honorarios	9	49	57	N
                    sb &= IIf(iisNull(bonif_O_rebaja, 0) = 0, "B", "R")                       'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja

                    sb &= LeftMasPadLeft((0).ToString("00.00", System.Globalization.CultureInfo.InvariantCulture), 5)                   'Total de bonif/rebaj	5	59	63	N	
                    sb &= IIf(.FueraDeEstandar <> "SI", "N", "S")                       'Fuera de standard		1	64	64	A	S-Si	N-No


                    sb &= LeftMasPadLeft(.IdCartaDePorte, 7)                   'Número de certif   	7	65	71	N	


                    '  sb &= LeftMasPadLeft(.DestinoCodigoONCAA, 5)


                    sb = Replace(sb, " ", "0")

                    PrintLine(nf, sb)
                End If
            End With
            Return sb

        End Function




        Private Shared Function RenglonAlabernCalidad(ByVal cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow, _
                                                      ByVal nombre As String, ByVal CodigoEnsayo As Integer, ByVal Resultado As Double, _
                                                      ByVal bonif_O_rebaja As String, ByVal Rebaja As Double, _
                                                      ByVal nf As Integer, ByVal numresultado As Double) As String
            Dim sb = ""

            With cdp



                'Pre |CP      |Vagon   |Codi|Rubro |Porcenta|Cantidad|% Merma |Kg Merma
                '0005|29662696|        |0002|HD.s 1|00013,50|00000000|00000,00|00000000
                '0005|29660882|        |0004|M/E.  |00001,50|00000000|00000,50|00000000



                If Resultado <> 0 Or Rebaja <> 0 Then

                    Dim cero = 0
                    Dim prefijo = Left(.NumeroCartaDePorte.ToString, IIf(Len(.NumeroCartaDePorte.ToString) > 8, Len(.NumeroCartaDePorte.ToString) - 8, 0)).PadLeft(4, "0")
                    If bPrefijadorauto Then
                        prefijo = "0005"
                    End If


                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10072
                    '* Requerir siempre el prefijo de la carta de porte (el 5)

                    '* Pasa lo mismo que pasaba con el de descargas, el numero empieza en el segundo campo incluyendo el prefijo, entonces no está apareciendo la ultima cifra.

                    'If prefijo <> "5" Then
                    '    Error =
                    'End If
                    sb &= prefijo

                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= "|" & LeftMasPadLeft(Right(.NumeroCartaDePorte.ToString, 8), 8)   'Carta de porte			11	7	17	N	
                    sb &= "|" & LeftMasPadLeft(IIf(.SubnumeroVagon > 0, .SubnumeroVagon, ""), 8)   'Carta de porte			11	7	17	N	




                    'sb &= "|" & LeftMasPadLeft(CodigoArticuloAmaggi(.Producto), 2)                  'Cereal 				2	39	40	N
                    sb &= "|" & JustificadoDerecha(CodigoEnsayo, 4, "0")                   'Código de ensayo		5	20	24	 N
                    sb &= "|" & JustificadoIzquierda(nombre, 6)                   'Número de resultado	2	18	19	N  "01,02,03,04"
                    sb &= "|" & LeftMasPadLeft(Resultado.ToString("00000.00", System.Globalization.CultureInfo.InvariantCulture), 8).Replace(".", ",")                   'Resultado del ensayo	7	25	31	N
                    sb &= "|" & "00000000"
                    If numresultado < 0 Then
                        sb &= "|" & LeftMasPadLeft(numresultado.ToString("0000.00", System.Globalization.CultureInfo.InvariantCulture), 8).Replace(".", ",")                  'Resultado del ensayo	7	25	31	N
                    Else
                        sb &= "|" & LeftMasPadLeft(numresultado.ToString("00000.00", System.Globalization.CultureInfo.InvariantCulture), 8).Replace(".", ",")                  'Resultado del ensayo	7	25	31	N
                    End If



                    'sb &= "|" & LeftMasPadLeft(Int(.NetoFinal), 7)             'Kilos  				7	32	38	N
                    'sb &= "|" & "00000000"
                    Dim kilosmerma As Decimal
                    If nombre = "HUM" Then
                        kilosmerma = .HumedadDesnormalizada
                    Else
                        kilosmerma = .Merma
                    End If
                    sb &= "|" & JustificadoDerecha(Int(kilosmerma), 7, "0")
                    ' sb &= IIf(iisNull(bonif_O_rebaja, 0) = 0, "B", "R")                       'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja
                    ' sb &= LeftMasPadLeft((0).ToString("00.00", System.Globalization.CultureInfo.InvariantCulture), 5)                   'Total de bonif/rebaj	5	59	63	N	
                    ' sb &= IIf(.FueraDeEstandar <> "SI", "N", "S")                       'Fuera de standard		1	64	64	A	S-Si	N-No



                    PrintLine(nf, sb)
                End If
            End With
            Return sb

        End Function

        Public Shared Function Sincronismo_NOBLE(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, ByVal titulo As String, ByVal sWHERE As String, ByRef sErrores As String) As String





            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "we2noble " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow



            'Dim a = pDataTable(1)



            'el sincro de noble genera 2 archivos
            'ARCHIVO 1:     we2noble.txt  

            '│ GRANO      │ Character │     3 │     │
            '│ DESTINO    │ Character │    11 │     │
            '│ NOMDESTINO │ Character │    30 │     │
            '│ COSECHA    │ Character │     4 │     │
            '│ FECSAL     │ Character │     8 │     │
            '│ TIPODOC    │ Character │     1 │     │
            '│ CARPORTE   │ Character │    12 │     │
            '│ NRORECIBO  │ Character │    10 │     │
            '│ FECHADOC   │ Character │    10 │     │
            '│ CUITCARGAD │ Character │    14 │     │
            '│ NOMCARGADO │ Character │    30 │     │
            '│ CUITCTAOR1 │ Character │    14 │     │
            '│ NOMCTAOR1  │ Character │    30 │     │
            '│ CUITCTAOR2 │ Character │    14 │     │
            '│ NOMCTAOR2  │ Character │    30 │     │
            '│ CUITCTAOR3 │ Character │    14 │     │
            '│ NOMCTAOR3  │ Character │    30 │     │
            '│ CUITCORRED │ Character │    14 │     │
            '│ NOMCORRED  │ Character │    30 │     │
            '│ CUITENTREG │ Character │    14 │     │
            '│ NOMENTREG  │ Character │    30 │     │
            '│ CUITCOMPRA │ Character │    14 │     │
            '│ NOMCOMPRAD │ Character │    30 │     │
            '│ CUITTRANSP │ Character │    14 │     │
            '│ NOMTRANSP  │ Character │    30 │     │
            '│ ENTSAL     │ Character │     3 │     │
            '│ PROCEDENC  │ Character │    11 │     │
            '│ NOMPROC    │ Character │    30 │     │
            '│ TIPOTRANS  │ Character │     1 │     │
            '│ NVAGON     │ Character │     6 │     │
            '│ NRTIKTBALN │ Character │    10 │     │
            '│ NMUESTRCAM │ Character │    10 │     │
            '│ PORHUME    │ Character │     6 │     │
            '│ MERMAHUME  │ Character │     6 │     │
            '│ KGMERMAHUM │ Character │    10 │     │
            '│ CONCALID   │ Character │     4 │     │
            '│ DESCCALID  │ Character │    20 │     │
            '│ OTRACALID  │ Character │    20 │     │
            '│ PESONETORI │ Character │    10 │     │
            '│ PESOBRUTDE │ Character │    10 │     │
            '│ TARADEST   │ Character │    10 │     │
            '│ PESONETDES │ Character │    10 │     │
            '│ KGSACONDIC │ Character │    10 │     │
            '│ KGSCALIDAD │ Character │    10 │     │
            '│ KGSVOLAT   │ Character │    10 │     │
            '│ PORCVOLAT  │ Character │     6 │     │
            '│ NRPATENTE  │ Character │     6 │     │
            '│ NRCHASIS   │ Character │     6 │     │
            '│ CARTARE    │ Character │     1 │     │
            '│ CARTAPT    │ Character │     1 │     │
            '│ TIPOPESA   │ Character │     1 │     │
            '│ CUITENTRE2 │ Character │    14 │     │
            '│ RAZENTREG  │ Character │    30 │     │
            '│ CUITCHOF   │ Character │    14 │     │
            '│ RAZONCHOF  │ Character │    30 │     │
            '│ NROCAU     │ Character │    20 │     │
            '│ FVTOCAU      │ Character │    10 │     │
            '│ OPEONCCA     │ Character │    10 │     │
            '│ CONDICION    │ Character │     1 │     │
            '│ CUITCORRE2   │ Character │    11 │     │
            '│ FECPROCE     │ Date      │     8 │     │- SACAR
            '│ FILLER       │ Character │    30 │     │
            '│ NROCTG       │ Character │    11 │     │ Ejemplo : viene bbb69355715
            '│ KMSRECORRIDOS│ Character │    12 │     │ Ejemplo : viene b(6)130.00
            '│ TFAFLETE     │ Character │    12 │     │ Ejemplo : viene b(7)37.05
            '│ CODESTPROC   │ Numeric   │     6 │     │
            '│ LOCOMOTORA   │ Numeric   │    11 │     │
            '│ FEARRIBDES   │ Date      │     8 │     │
            '│ FILLER       │ Character │     2 │     │
            '│ CUITESTDES   │ Numeric   │    11 │     │ 



            ' ARCHIVO 2:    wecal2des.txt

            '│ CARPORTE   │ Character │    12 │     │
            '│ CODIGO     │ Character │     3 │     │
            '│ RESULTADO  │ Character │    20 │     │
            '│ REBAJA     │ Character │    20 │     │

            Dim cadenavacia As String = ""
            Dim sErroresProcedencia, sErroresDestinos As String

            '//////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////
            'consulta NOBLE
            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7870
            '//////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////

            Dim sErroresCartas = ""

            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0
                    Dim sErroresporCarta = ""

                    '│ GRANO      │ Character │     3 │     │
                    '│ DESTINO    │ Character │    11 │     │
                    '│ NOMDESTINO │ Character │    30 │     │

                    sb &= .CodigoSAJPYA.PadRight(3) 'Grano	STRING(3)	Código de grano Sagpya)    1)    3


                    '                    actual viene un código, nuevo viene un cuit	
                    '        Me comentó Horacio que el sistema anterior les mandaba un código interno de williams y 
                    'que ellos identificaban la primera vez, para que de ahí en adelante siempre tome el destino correspondiente

                    If .IsDestinoCodigoWilliamsNull Then .DestinoCodigoWilliams = ""
                    sb &= Left(.DestinoCodigoWilliams.ToString.Replace(" ", ""), 11).PadRight(11) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56


                    sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPuerto	STRING(30)	Nombre Puerto)    57)    86




                    '│ COSECHA    │ Character │     4 │     │
                    '│ FECSAL     │ Character │     8 │     │
                    '│ TIPODOC    │ Character │     1 │     │

                    'Cosecha	4	N	
                    sb &= Right(.Cosecha, 5).Replace("/", "").PadLeft(4)
                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= Fecha_ddMMyyyy(iisValidSqlDate(.FechaDescarga)) 'FecSal	STRING(8)	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001)    27)    34
                    sb &= "C" ' tipodoc 1




                    '│ CARPORTE   │ Character │    12 │     │
                    '│ NRORECIBO  │ Character │    10 │     │
                    '│ FECHADOC   │ Character │    10 │     │
                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= Left(.NumeroCartaDePorte.ToString, 12).PadLeft(12, "0")
                    sb &= Left(.NRecibo.ToString, 10).PadRight(10) 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840

                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= LeftMasPadRight(Fecha_ddMMyyyy(iisValidSqlDate(.FechaArribo)), 10) 'FecIng	STRING(8)	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001)    11)    18







                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular
                    'Corredor Endozo		    ?
                    'Comprador Endozo		    ?
                    'Corredor Vendedor		    ?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino


                    '1 - ‘Destinatario’ -> siempre viene Noble, en los txt actuales pueden venir otros destinatarios.- ( ver si es un datos fijo ó se permiten seleccionar otros cuits ).-
                    '2 – ‘Transportista’ -> debe ser un campo obligatorio.-
                    '3 - ’Kgs. Acondic.’ -> si no hay debe venir con ceros.-
                    '4 - ’Kgs. Calidad’  -> si no hay debe venir con ceros.-
                    '5 – ‘Cuit chofer’ ->  debe ser un campo obligatorio.-
                    '6 – ‘Razón Social chofer’ -> debe ser un campo obligatorio.-
                    '7 – ‘Nro. CAU’ -> debe ser un campo obligatorio.-
                    '8 – ‘Fecha vto. CAU’ -> debe ser un campo obligatorio ( aquí se está informando la fecha con barras, en otros registros la hora, etc. )
                    '9 – ‘Opeoncca’ -> debe ser un campo obligatorio.- ( revisar contenido para ver si es correcto ).-
                    '10 – ‘Nro. CTG’ -> debe ser un campo obligatorio.-
                    '11 – ‘Kms. Recorridos’ -> debe ser un campo obligatorio.-
                    '12 – ‘Tfa. Flete’ -> debe ser un campo obligatorio.-
                    '13 – ‘Cuit destino’ -> debe ser un campo obligatorio.-
                    '14 – ‘Cuit Corredor ‘ -> debe ser un campo obligatorio y actualmente para el corredor ‘Directo’ viene informado el cuit : 88000000122.-



                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"

                    sb &= Left(.TitularCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                    sb &= Left(.TitularDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174






                    'no puede venir en blanco si el siguiente campo tiene información	Lo que solicitan es lo siguiente:
                    'idem anterior	Cuando hay intermediario y RteCom, enviarlos de esta manera
                    'debe venir informado si el campo anterior tiene información	Cuando en la cdp aparece solo uno de los 2, enviar ese primero y el siguiente campo dejarlo vacío

                    If .IntermediarioDesc.ToString <> "" Then
                        sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                        sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

                        sb &= Left(.RComercialCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                        sb &= Left(.RComercialDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174
                    Else

                        sb &= Left(.RComercialCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                        sb &= Left(.RComercialDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

                        sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                        sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174
                    End If







                    sb &= Left(cadenavacia.ToString.Replace("-", ""), 14).PadRight(14) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350

                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218



                    sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130



                    sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITEntregador	STRING(14)	CUIT Entregador)    219)    232
                    sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomEntregador	STRING(30)	Nombre Entregador)    233)    262

                    '////////////////////////////////////////////////////////////////////////////////
                    'Strongly Typed DataSets encountering NULL values – Grrrrrr… 
                    'http://social.msdn.microsoft.com/forums/en-US/winformsdatacontrols/thread/1dad8d0d-6eae-4254-a9d6-22d50da5578a
                    '////////////////////////////////////////////////////////////////////////////////

                    'If .IsClienteFacturadoCUITNull Then .ClienteFacturadoCUIT = ""
                    'sb &= Left(.ClienteFacturadoCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCargador	STRING(14)	CUIT Cargador)    263)    276
                    'If .IsClienteFacturadoNull Then .ClienteFacturado = ""
                    'sb &= Left(.ClienteFacturado.ToString, 30).PadRight(30) 'NomCargador 	STRING(30)	Nombre Cargador)    277)    306



                    If .IsTransportistaCUITNull Then
                        .TransportistaCUIT = ""
                        sErroresporCarta &= " Transportista "
                    End If
                    sb &= Left(.TransportistaCUIT.ToString.Replace("-", ""), 14).PadRight(14, "0") 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118
                    sb &= Left(.TransportistaDesc.ToString, 30).PadRight(30) 'NomEntregador	STRING(30)	Nombre Entregador)    233)    262





                    sb &= "101"  '│ ENTSAL     │ Character │     3 │     │


                    '│ PROCEDENC  │ Character │    11 │     │
                    '   │ NOMPROC    │ Character │    30 │     │


                    'actual viene un código interno, nuevo viene un código postal	Pasa lo mismo que con los destinos
                    'según código campo anterior ( decodificación )	

                    If .IsProcedenciaCodigoWilliamsNull Then .ProcedenciaCodigoWilliams = ""
                    sb &= Left(.ProcedenciaCodigoWilliams.ToString.Trim, 11).PadRight(11) '
                    sb &= Left(.ProcedenciaDesc.ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564








                    sb &= "C" '   │ TIPOTRANS  │ Character │     1 │     │





                    sb &= Int(.SubnumeroVagon).ToString.PadLeft(6, "0") '│ NVAGON     │ Character │     6 │     │





                    sb &= Left(cadenavacia.ToString, 10).PadRight(10) '   │ NRTIKTBALN │ Character │    10 │     │


                    'actual = '0+blancos', nuevo viene todos blancos
                    sb &= JustificadoIzquierda("0", 10)  '│ NMUESTRCAM │ Character │    10 │     │



                    '│ PORHUME    │ Character │     6 │     │
                    '│ MERMAHUME  │ Character │     6 │     │
                    '│ KGMERMAHUM │ Character │    10 │     │


                    sb &= String.Format("{0:F1}", .HumedadDesnormalizada).ToString.PadLeft(6)
                    sb &= String.Format("{0:F1}", .Humedad).PadLeft(6)

                    'actual = 'blancos14,50', nuevo viene todos blancos
                    sb &= Int(.Merma).ToString.PadLeft(10)



                    '│ CONCALID   │ Character │     4 │     │
                    '│ DESCCALID  │ Character │    20 │     │
                    '│ OTRACALID  │ Character │    20 │     │

                    If .IsCalidadDeNull Then .CalidadDe = Nothing
                    sb &= LeftMasPadRight(FormatearCalidad(.CalidadDe), 4)


                    ': ver contenido -> VER nuevo archivo de calidades.- 
                    'ver contenido -> VER nuevo archivo de calidades.- 

                    sb &= LeftMasPadRight(.Observaciones, 20)
                    sb &= cadenavacia.ToString.PadLeft(20)




                    '│ PESONETORI │ Character │    10 │     │
                    '│ PESOBRUTDE │ Character │    10 │     │
                    '│ TARADEST   │ Character │    10 │     │



                    sb &= Int(.NetoFinal).ToString.PadRight(10)
                    sb &= Int(.BrutoPto).ToString.PadLeft(10)
                    sb &= Int(.TaraPto).ToString.PadLeft(10)


                    sb &= Int(.NetoPto).ToString.PadLeft(10)



                    '│ KGSACONDIC │ Character │    10 │     │
                    '│ KGSCALIDAD │ Character │    10 │     │

                    sb &= "".PadLeft(10, "0") '  JustificadoIzquierda("0", 10)
                    sb &= "".PadLeft(10, "0") '  JustificadoIzquierda("0", 10)

                    '│ KGSVOLAT   │ Character │    10 │     │
                    '│ PORCVOLAT  │ Character │     6 │     │

                    sb &= JustificadoIzquierda("0", 10)
                    sb &= JustificadoIzquierda("0", 6)




                    '│ NRPATENTE  │ Character │     6 │     │
                    '│ NRCHASIS   │ Character │     6 │     │





                    sb &= Left(.Patente.ToString, 6).PadRight(6) 'PatCha	STRING(6)	Patente chasis)    604)    609
                    sb &= Left(.Acoplado.ToString, 6).PadRight(6) 'PatAcoplado	STRING(6)	Acoplado chasis)    610)    615



                    '│ CARTARE    │ Character │     1 │     │
                    '│ CARTAPT    │ Character │     1 │     │
                    '│ TIPOPESA   │ Character │     1 │     │
                    sb &= "R"
                    sb &= "P" 'actual : 'P' ( propia ) ó 'T' ( tercero ), nuevo blanco
                    sb &= "B"


                    '│ CUITENTRE2 │ Character │    14 │     │
                    '│ RAZENTREG  │ Character │    30 │     │
                    '│ CUITCHOF   │ Character │    14 │     │
                    '│ RAZONCHOF  │ Character │    30 │     │
                    'actual:             ceros, nuevo : blancos()
                    '                    ok()
                    '                    es(obligatorio)
                    '                    es(obligatorio)
                    sb &= "0".PadRight(14, "0") 'CUITPlantaOrigen	STRING(14)	CUIT Planta Origen)    483)    496
                    sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomPlantaOrigen	STRING(30)	Nombre Planta Origen)    497)    526

                    If .IschoferCUITNull Then
                        .choferCUIT = ""
                        sErroresporCarta &= " Chofer "
                    End If
                    sb &= Left(.choferCUIT.ToString.Replace("-", ""), 14).PadRight(14, "0") 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118
                    sb &= Left(.ChoferDesc.ToString, 30).PadRight(30) 'NomEntregador	STRING(30)	Nombre Entregador)    233)    262





                    '│ NROCAU     │ Character │    20 │     │
                    '│ FVTOCAU      │ Character │    10 │     │
                    If .IsCEENull Then
                        .CEE = ""
                        sErroresporCarta &= "cee"
                    End If
                    sb &= LeftMasPadRight(.CEE, 20)

                    If .IsFechaVencimientoNull Then
                        .FechaVencimiento = Nothing
                        sErroresporCarta &= " VencimientoCEE "
                    End If
                    sb &= JustificadoIzquierda(Fecha_ddMMyyyy(iisValidSqlDate(.FechaVencimiento)), 10)
                    'sb &= LeftMasPadRight(.FechaVencimiento, 10)


                    '│ OPEONCCA     │ Character │    10 │     │

                    'actual : viene información, nuevo blancos 
                    If .IsProcedenciaCodigoONCAANull Then .ProcedenciaCodigoONCAA = ""
                    sb &= Left(.ProcedenciaCodigoONCAA.ToString.Trim, 10).PadRight(10)
                    If .ProcedenciaCodigoONCAA.ToString = "" And InStr(sErroresProcedencia, .ProcedenciaDesc.ToString) = 0 Then
                        'si no tiene codigo ni está ya en sErrores, lo meto


                        ErrHandler.WriteError("La localidad " & .ProcedenciaDesc.ToString & " es usada en el sincro de LosGrobo y no tiene codigo ONCAA")

                        sErroresProcedencia &= "<a href=""Localidades.aspx?Id=" & .Procedencia & """ target=""_blank"">" & .ProcedenciaDesc.ToString & "</a>; "
                    End If



                    '│ CONDICION    │ Character │     1 │     │
                    '│ CUITCORRE2   │ Character │    11 │     │
                    '│ FECPROCE     │ Date      │     8 │     │- SACAR
                    '│ FILLER       │ Character │    30 │     │


                    sb &= LeftMasPadRight(cadenavacia, 1)
                    sb &= LeftMasPadRight("00000000000", 11)

                    'sacar fisicamente del txt
                    If .IsFechaIngresoNull Then .FechaIngreso = Nothing
                    'sb &= LeftMasPadRight(Fecha_ddMMyyyy(.FechaIngreso), 8)

                    sb &= LeftMasPadRight(cadenavacia, 30)




                    '│ NROCTG       │ Character │    11 │     │ Ejemplo : viene bbb69355715
                    '│ KMSRECORRIDOS│ Character │    12 │     │ Ejemplo : viene b(6)130.00
                    '│ TFAFLETE     │ Character │    12 │     │ Ejemplo : viene b(7)37.05


                    If .CTG = 0 Then sErrores &= " CTG "
                    sb &= JustificadoDerecha(.CTG, 11)
                    If .KmARecorrer = 0 Then sErrores &= " KmARecorrer "
                    sb &= JustificadoDerecha(.KmARecorrer, 12)
                    If .Tarifa = 0 Then sErrores &= " Tarifa "
                    sb &= JustificadoDerecha(.Tarifa, 12)



                    '│ CODESTPROC   │ Numeric   │     6 │     │
                    '│ LOCOMOTORA   │ Numeric   │    11 │     │
                    '│ FEARRIBDES   │ Date      │     8 │     │
                    '│ FILLER       │ Character │     2 │     │
                    '│ CUITESTDES   │ Numeric   │    11 │     │ 


                    sb &= LeftMasPadRight("1", 6)
                    sb &= LeftMasPadRight(cadenavacia, 11)
                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= LeftMasPadRight(Fecha_ddMMyyyy(.FechaDescarga), 8)
                    sb &= LeftMasPadRight(cadenavacia, 2)
                    sb &= LeftMasPadRight(cadenavacia, 11)  'no tenemos el establecimiento de destino (ni su CUIT)









                    If sErroresporCarta <> "" Then
                        sErroresCartas &= "<a href=""CartaDePorte.aspx?Id=" & .IdCartaDePorte & """ target=""_blank"">" & .NumeroCartaDePorte & " " & .SubnumeroVagon & "/" & sErroresporCarta & "</a>; " & "<br/>"

                    Else
                        PrintLine(nF, sb)
                    End If


                End With
            Next


            FileClose(nF)






            sErrores = "DATOS FALTANTES <br/> Procedencias sin código ONCAA:<br/> " & sErroresProcedencia & "<br/>Destinos sin código ONCAA: <br/>" & sErroresDestinos & sErroresCartas

            If sErroresProcedencia <> "" Or sErroresDestinos <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write


            Sincronismo_NOBLEarchivoadicional(pDataTable, sWHERE)



            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function

        Public Shared Function Sincronismo_TomasHnos(ByVal pDataTable As DataTable, Optional ByVal titulo As String = "") As String


            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?




            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroTomasHNOS " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataTable.Rows
                i = 0 : sb = ""

                '                                                           Descripción	Tipo de Dato	Longitud        Observaciones()



                '                1 - Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.
                '3 - Sucursal Carta de Porte	Numérico	4	Primeras 4 posiciones del número de CP..
                '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.
                '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1)
                '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)
                '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)
                '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.
                '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista
                '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No
                '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.
                '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.
                '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD
                '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.
                '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.
                '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.
                '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.
                '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.
                '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)
                '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)
                '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.
                '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)
                '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)
                '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.


                '                "Mariano, esto es de Tomas Hnos. El tipo no se explayó en la descripción de
                'los problemas, lo que veo yo es que el punto 3 ""Sucursal Carta de Porte""
                'esta mandando la Carta de Porte completa.
                'Los nros de Carta de Porte son de 12 cifras: 000520239985
                'Williams no carga los ceros así que en el sincro en el punto 3 debería ir
                '""0005"" y en el punto 4 ""20239985"".
                'Creo que por este tema se corren todo el resto de los campos.

                'Por otro lado no estamos mandando el CAU (Para nosotros CEE)"




                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                'consulta TOMAS HERMANOS
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7962
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////


                Dim cero = 0




                sb &= "30707386076"                                           '1 - CUIT Williams (Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                sb &= "&" & dr("TitularCUIT").ToString.Replace("-", "").PadLeft(11)                        '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.
                sb &= "&" & Left(dr("C.Porte").ToString, IIf(Len(dr("C.Porte").ToString) > 8, Len(dr("C.Porte").ToString) - 8, 0)).PadLeft(4, "0")   '3 - Sucursal Carta de Porte	Numérico	4	Primeras 4 posiciones del número de CP..
                sb &= "&" & Right(dr("C.Porte").ToString, 8).PadLeft(8, "0")               '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                sb &= "&" & cero.ToString.PadLeft(10)                         '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.)
                sb &= "&" & cero.ToString.PadLeft(10)                         '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & dr("R. ComercialCUIT").ToString.Replace("-", "").PadLeft(11)                          '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.            '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.
                sb &= "&" & JustificadoDerecha(dr("CEE").ToString, 14)                         '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1) Código de Autorización de Uso (C.A.U.) 



                Dim stringFechaVencimiento As String
                stringFechaVencimiento = FechaANSI(iisValidSqlDate(dr("Vencim.CP")))
                sb &= "&" & IIf(stringFechaVencimiento = "00010101", Space(8), stringFechaVencimiento) '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)


                sb &= "&" & dr("CUIT Transp.").ToString.Replace("-", "").PadLeft(11)           '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)
                sb &= "&" & JustificadoDerecha(dr("Trasportista").ToString, 30).Replace("&", " ")                         '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.
                sb &= "&" & dr("CUIT chofer").ToString.Replace("-", "").PadLeft(11)                         '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista

                sb &= "&" & IIf(dr("LiquidaViaje").ToString = "SI", "Si", "No")                         '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                sb &= "&" & IIf(dr("CobraAcarreo").ToString = "SI", "Si", "No")                        '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No

                sb &= "&" & IIf(iisNull(dr("Tarifa"), 0) = 0, 0, iisNull(dr("Tarifa"), 0)).ToString.PadLeft(10)                         '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.
                sb &= "&" & Int(dr("Kg.Bruto Desc.")).ToString.PadLeft(10)                         '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Tara Desc.")).ToString.PadLeft(10)                         '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Neto Desc.")).ToString.PadLeft(10)                         '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                sb &= "&" & FechaANSI(iisValidSqlDate(iisNull(dr("Desc."))))     '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD
                sb &= "&" & DecimalToString(dr("H.%")).PadLeft(5)                         '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & Int(iisNull(dr("Mer.Kg."), 0)).ToString.PadLeft(10)                         '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.


                sb &= "&" & Int(iisNull(dr("Otras"), 0)).ToString.PadLeft(10)            '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                        '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                         '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & Int(dr("Kg.Netos")).ToString.PadLeft(10)                      '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.
                sb &= "&" & JustificadoDerecha(dr("Contrato").ToString, 14)           '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.


                sb &= "&" & cero.ToString.PadLeft(14)                          '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.

                sb &= "& " & Left(dr("LocalidadProcedenciaCodigoONCAA").ToString, 5).PadLeft(5)                         '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.
                'sb &= "&" & iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString.PadLeft(5)


                sb &= "&" & Int(dr("Km")).ToString.PadLeft(10)                        '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & dr("EspecieONCAA").ToString.PadLeft(4, "0")                         '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)
                sb &= "&" & Right(dr("Cosecha"), 5).Replace("/", "").PadLeft(4)                         '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)
                sb &= "&" & dr("CorredorCUIT").ToString.Replace("-", "").PadLeft(11)                        '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                        '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)
                sb &= "&" & dr("LocalidadDestinoCodigoONCAA").ToString.PadLeft(5)                         '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                sb &= "&" & dr("LocalidadProcedenciaCodigoONCAA").ToString.PadLeft(5)                         '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)
                sb &= "&" & dr("SufijoCartaDePorte").ToString.PadLeft(4)                         '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                          '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.
                sb &= "&" & dr("CTG").ToString.PadLeft(8)                         '42 – Numero de CTG	Numérico	8	Número de CTG presente en la CP.

                sb &= "&" & JustificadoIzquierda(dr("DescripcionEstablecimientoProcedencia") & " " & dr("Cal.-Observaciones").ToString.Replace(vbCrLf, "").Replace(vbCr, "").Replace("&", " "), 125)                       '43 – Comentario	Alfa	125	Campo que permita indicar algún mensaje de datos faltantes.


                sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino

                sb &= "&" & iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString.PadLeft(6)   '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia
                sb &= "&" & iisNull(dr("IdTipoMovimiento"), "").ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                '                                                       1.	Egresos contratos de Venta
                '                                                       2.	Egreso Directo a Destino Productor
                '                                                       3.	Directo Destino contrato de Compra
                '                                                       4.	Ingreso Entregado Productor
                '                                                       5.	Ingreso Contrato de Compra
                '                                                       6.	Reingreso de Mercadería
                '                                                       7.	Transferencia desde otra Planta



                'sb &= "&" & dr("Contrato").ToString.PadLeft(14) '
                'sb &= "&" & dr("Contrato").ToString.PadLeft(14)
                'sb &= "&" & dr("Contrato").ToString.PadLeft(14)

                'sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino
                'sb &= "&" & cero.ToString.PadLeft(6) '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia
                'sb &= "&" & cero.ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                ''                                                       1.	Egresos contratos de Venta
                ''                                                       2.	Egreso Directo a Destino Productor
                ''                                                       3.	Directo Destino contrato de Compra
                ''                                                       4.	Ingreso Entregado Productor
                ''                                                       5.	Ingreso Contrato de Compra
                ''                                                       6.	Reingreso de Mercadería
                ''                                                       7.	Transferencia desde otra Planta


                'sb = sb.Replace(".", ",") 'solucion cabeza por los decimales





                PrintLine(nF, sb)
            Next


            FileClose(nF)


            Return vFileName
            'Return TextToExcel(vFileName, titulo)




        End Function


        Public Shared Function Sincronismo_SantaCatalina(ByVal pDataTable As DataTable, Optional ByVal titulo As String = "") As String


            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?




            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroSantaCatalina " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataTable.Rows
                i = 0 : sb = ""

                '                                                           Descripción	Tipo de Dato	Longitud        Observaciones()



                '                1 - Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.
                '3 - Sucursal Carta de Porte	Numérico	4	Primeras 4 posiciones del número de CP..
                '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.
                '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1)
                '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)
                '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)
                '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.
                '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista
                '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No
                '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.
                '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.
                '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD
                '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.
                '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.
                '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.
                '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.
                '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.
                '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)
                '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)
                '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.
                '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)
                '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)
                '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.


                '                "Mariano, esto es de Tomas Hnos. El tipo no se explayó en la descripción de
                'los problemas, lo que veo yo es que el punto 3 ""Sucursal Carta de Porte""
                'esta mandando la Carta de Porte completa.
                'Los nros de Carta de Porte son de 12 cifras: 000520239985
                'Williams no carga los ceros así que en el sincro en el punto 3 debería ir
                '""0005"" y en el punto 4 ""20239985"".
                'Creo que por este tema se corren todo el resto de los campos.

                'Por otro lado no estamos mandando el CAU (Para nosotros CEE)"




                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                'consulta TOMAS HERMANOS
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7962
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////


                Dim cero = 0




                sb &= "30707386076"                                           '1 - CUIT Williams (Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                sb &= "&" & dr("TitularCUIT").ToString.Replace("-", "").PadLeft(11)                        '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.
                ForzarPrefijo5(dr("C.Porte"))
                sb &= "&" & Left(dr("C.Porte").ToString, IIf(Len(dr("C.Porte").ToString) > 8, Len(dr("C.Porte").ToString) - 8, 0)).PadLeft(4, "0")   '3 - Sucursal Carta de Porte	Numérico	4	Primeras 4 posiciones del número de CP..
                sb &= "&" & Right(dr("C.Porte").ToString, 8).PadLeft(8, "0")               '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                sb &= "&" & cero.ToString.PadLeft(10)                         '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.)
                sb &= "&" & cero.ToString.PadLeft(10)                         '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & dr("R. ComercialCUIT").ToString.Replace("-", "").PadLeft(11)                          '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.            '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.
                sb &= "&" & JustificadoDerecha(dr("CEE").ToString, 14)                         '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1) Código de Autorización de Uso (C.A.U.) 



                Dim stringFechaVencimiento As String
                stringFechaVencimiento = FechaANSI(iisValidSqlDate(dr("Vencim.CP")))
                sb &= "&" & IIf(stringFechaVencimiento = "00010101", Space(8), stringFechaVencimiento) '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)


                sb &= "&" & dr("CUIT Transp.").ToString.Replace("-", "").PadLeft(11)           '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)
                sb &= "&" & JustificadoDerecha(dr("Trasportista").ToString, 30).Replace("&", " ")                         '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.
                sb &= "&" & dr("CUIT chofer").ToString.Replace("-", "").PadLeft(11)                         '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista

                sb &= "&" & IIf(dr("LiquidaViaje").ToString = "SI", "Si", "No")                         '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                sb &= "&" & IIf(dr("CobraAcarreo").ToString = "SI", "Si", "No")                        '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No

                sb &= "&" & IIf(iisNull(dr("Tarifa"), 0) = 0, 0, iisNull(dr("Tarifa"), 0)).ToString.PadLeft(10)                         '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.
                sb &= "&" & Int(dr("Kg.Bruto Desc.")).ToString.PadLeft(10)                         '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Tara Desc.")).ToString.PadLeft(10)                         '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Neto Desc.")).ToString.PadLeft(10)                         '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                sb &= "&" & FechaANSI(iisValidSqlDate(iisNull(dr("Desc."))))     '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD
                sb &= "&" & DecimalToString(dr("H.%")).PadLeft(5)                         '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & Int(iisNull(dr("Mer.Kg."), 0)).ToString.PadLeft(10)                         '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.


                sb &= "&" & Int(iisNull(dr("Otras"), 0)).ToString.PadLeft(10)            '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                        '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                         '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & Int(dr("Kg.Netos")).ToString.PadLeft(10)                      '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.
                sb &= "&" & JustificadoDerecha(dr("Contrato").ToString, 14)           '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.


                sb &= "&" & cero.ToString.PadLeft(14)                          '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.

                sb &= "& " & Left(dr("LocalidadProcedenciaCodigoONCAA").ToString, 5).PadLeft(5)                         '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.
                'sb &= "&" & iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString.PadLeft(5)


                sb &= "&" & Int(dr("Km")).ToString.PadLeft(10)                        '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & dr("EspecieONCAA").ToString.PadLeft(4, "0")                         '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)
                sb &= "&" & Right(dr("Cosecha"), 5).Replace("/", "").PadLeft(4)                         '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)
                sb &= "&" & dr("CorredorCUIT").ToString.Replace("-", "").PadLeft(11)                        '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                        '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)
                sb &= "&" & dr("LocalidadDestinoCodigoONCAA").ToString.PadLeft(5)                         '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                sb &= "&" & dr("LocalidadProcedenciaCodigoONCAA").ToString.PadLeft(5)                         '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)
                sb &= "&" & dr("SufijoCartaDePorte").ToString.PadLeft(4)                         '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                          '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.
                sb &= "&" & dr("CTG").ToString.PadLeft(8)                         '42 – Numero de CTG	Numérico	8	Número de CTG presente en la CP.

                sb &= "&" & JustificadoIzquierda(dr("DescripcionEstablecimientoProcedencia") & " " & dr("Cal.-Observaciones").ToString.Replace(vbCrLf, "").Replace(vbCr, "").Replace("&", " "), 125)                       '43 – Comentario	Alfa	125	Campo que permita indicar algún mensaje de datos faltantes.


                sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino

                sb &= "&" & iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString.PadLeft(6)   '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia
                sb &= "&" & iisNull(dr("IdTipoMovimiento"), "").ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                '                                                       1.	Egresos contratos de Venta
                '                                                       2.	Egreso Directo a Destino Productor
                '                                                       3.	Directo Destino contrato de Compra
                '                                                       4.	Ingreso Entregado Productor
                '                                                       5.	Ingreso Contrato de Compra
                '                                                       6.	Reingreso de Mercadería
                '                                                       7.	Transferencia desde otra Planta



                'sb &= "&" & dr("Contrato").ToString.PadLeft(14) '
                'sb &= "&" & dr("Contrato").ToString.PadLeft(14)
                'sb &= "&" & dr("Contrato").ToString.PadLeft(14)

                'sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino
                'sb &= "&" & cero.ToString.PadLeft(6) '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia
                'sb &= "&" & cero.ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                ''                                                       1.	Egresos contratos de Venta
                ''                                                       2.	Egreso Directo a Destino Productor
                ''                                                       3.	Directo Destino contrato de Compra
                ''                                                       4.	Ingreso Entregado Productor
                ''                                                       5.	Ingreso Contrato de Compra
                ''                                                       6.	Reingreso de Mercadería
                ''                                                       7.	Transferencia desde otra Planta


                'sb = sb.Replace(".", ",") 'solucion cabeza por los decimales





                PrintLine(nF, sb)
            Next


            FileClose(nF)


            Return vFileName
            'Return TextToExcel(vFileName, titulo)




        End Function

        Public Shared Function Sincronismo_MiguelCinque(ByVal pDataTable As DataTable, Optional ByVal titulo As String = "") As String


            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?




            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroMiguelCinque " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataTable.Rows
                i = 0 : sb = ""

                '                                                           Descripción	Tipo de Dato	Longitud        Observaciones()



                '                1 - Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.
                '3 - Sucursal Carta de Porte	Numérico	4	Primeras 4 posiciones del número de CP..
                '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.
                '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1)
                '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)
                '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)
                '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.
                '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista
                '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No
                '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.
                '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.
                '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD
                '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.
                '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.
                '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.
                '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.
                '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.
                '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)
                '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)
                '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.
                '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)
                '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)
                '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.


                '                "Mariano, esto es de Tomas Hnos. El tipo no se explayó en la descripción de
                'los problemas, lo que veo yo es que el punto 3 ""Sucursal Carta de Porte""
                'esta mandando la Carta de Porte completa.
                'Los nros de Carta de Porte son de 12 cifras: 000520239985
                'Williams no carga los ceros así que en el sincro en el punto 3 debería ir
                '""0005"" y en el punto 4 ""20239985"".
                'Creo que por este tema se corren todo el resto de los campos.

                'Por otro lado no estamos mandando el CAU (Para nosotros CEE)"




                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                'consulta TOMAS HERMANOS
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7962
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////


                Dim cero = 0




                sb &= "30707386076"                                           '1 - CUIT Williams (Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                sb &= "&" & dr("TitularCUIT").ToString.Replace("-", "").PadLeft(11)                        '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.
                ForzarPrefijo5(dr("C.Porte"))
                sb &= "&" & Left(dr("C.Porte").ToString, IIf(Len(dr("C.Porte").ToString) > 8, Len(dr("C.Porte").ToString) - 8, 0)).PadLeft(4, "0")   '3 - Sucursal Carta de Porte	Numérico	4	Primeras 4 posiciones del número de CP..
                sb &= "&" & Right(dr("C.Porte").ToString, 8).PadLeft(8, "0")               '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                sb &= "&" & cero.ToString.PadLeft(10)                         '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.)
                sb &= "&" & cero.ToString.PadLeft(10)                         '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & dr("R. ComercialCUIT").ToString.Replace("-", "").PadLeft(11)                          '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.            '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.
                sb &= "&" & JustificadoDerecha(dr("CEE").ToString, 14)                         '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1) Código de Autorización de Uso (C.A.U.) 



                Dim stringFechaVencimiento As String
                stringFechaVencimiento = FechaANSI(iisValidSqlDate(dr("Vencim.CP")))
                sb &= "&" & IIf(stringFechaVencimiento = "00010101", Space(8), stringFechaVencimiento) '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)


                sb &= "&" & dr("CUIT Transp.").ToString.Replace("-", "").PadLeft(11)           '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)
                sb &= "&" & JustificadoDerecha(dr("Trasportista").ToString, 30).Replace("&", " ")                         '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.
                sb &= "&" & dr("CUIT chofer").ToString.Replace("-", "").PadLeft(11)                         '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista

                sb &= "&" & IIf(dr("LiquidaViaje").ToString = "SI", "Si", "No")                         '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                sb &= "&" & IIf(dr("CobraAcarreo").ToString = "SI", "Si", "No")                        '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No

                sb &= "&" & IIf(iisNull(dr("Tarifa"), 0) = 0, 0, iisNull(dr("Tarifa"), 0)).ToString.PadLeft(10)                         '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.
                sb &= "&" & Int(dr("Kg.Bruto Desc.")).ToString.PadLeft(10)                         '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Tara Desc.")).ToString.PadLeft(10)                         '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Neto Desc.")).ToString.PadLeft(10)                         '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                sb &= "&" & FechaANSI(iisValidSqlDate(iisNull(dr("Desc."))))     '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD
                sb &= "&" & DecimalToString(dr("H.%")).PadLeft(5)                         '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & Int(iisNull(dr("Mer.Kg."), 0)).ToString.PadLeft(10)                         '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.


                sb &= "&" & Int(iisNull(dr("Otras"), 0)).ToString.PadLeft(10)            '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                        '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                         '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & Int(dr("Kg.Netos")).ToString.PadLeft(10)                      '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.
                sb &= "&" & JustificadoDerecha(dr("Contrato").ToString, 14)           '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.


                sb &= "&" & cero.ToString.PadLeft(14)                          '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.

                sb &= "& " & Left(dr("LocalidadProcedenciaCodigoONCAA").ToString, 5).PadLeft(5)                         '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.
                'sb &= "&" & iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString.PadLeft(5)


                sb &= "&" & Int(dr("Km")).ToString.PadLeft(10)                        '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & dr("EspecieONCAA").ToString.PadLeft(4, "0")                         '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)
                sb &= "&" & Right(dr("Cosecha"), 5).Replace("/", "").PadLeft(4)                         '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)
                sb &= "&" & dr("CorredorCUIT").ToString.Replace("-", "").PadLeft(11)                        '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                        '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)
                sb &= "&" & dr("LocalidadDestinoCodigoONCAA").ToString.PadLeft(5)                         '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                sb &= "&" & dr("LocalidadProcedenciaCodigoONCAA").ToString.PadLeft(5)                         '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)
                sb &= "&" & dr("SufijoCartaDePorte").ToString.PadLeft(4)                         '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                          '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.
                sb &= "&" & dr("CTG").ToString.PadLeft(8)                         '42 – Numero de CTG	Numérico	8	Número de CTG presente en la CP.

                sb &= "&" & JustificadoIzquierda(dr("DescripcionEstablecimientoProcedencia") & " " & dr("Cal.-Observaciones").ToString.Replace(vbCrLf, "").Replace(vbCr, "").Replace("&", " "), 125)                       '43 – Comentario	Alfa	125	Campo que permita indicar algún mensaje de datos faltantes.


                sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino

                sb &= "&" & iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString.PadLeft(6)   '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia
                sb &= "&" & iisNull(dr("IdTipoMovimiento"), "").ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                '                                                       1.	Egresos contratos de Venta
                '                                                       2.	Egreso Directo a Destino Productor
                '                                                       3.	Directo Destino contrato de Compra
                '                                                       4.	Ingreso Entregado Productor
                '                                                       5.	Ingreso Contrato de Compra
                '                                                       6.	Reingreso de Mercadería
                '                                                       7.	Transferencia desde otra Planta



                'sb &= "&" & dr("Contrato").ToString.PadLeft(14) '
                'sb &= "&" & dr("Contrato").ToString.PadLeft(14)
                'sb &= "&" & dr("Contrato").ToString.PadLeft(14)

                'sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino
                'sb &= "&" & cero.ToString.PadLeft(6) '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia
                'sb &= "&" & cero.ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                ''                                                       1.	Egresos contratos de Venta
                ''                                                       2.	Egreso Directo a Destino Productor
                ''                                                       3.	Directo Destino contrato de Compra
                ''                                                       4.	Ingreso Entregado Productor
                ''                                                       5.	Ingreso Contrato de Compra
                ''                                                       6.	Reingreso de Mercadería
                ''                                                       7.	Transferencia desde otra Planta


                'sb = sb.Replace(".", ",") 'solucion cabeza por los decimales





                PrintLine(nF, sb)
            Next


            FileClose(nF)


            Return vFileName
            'Return TextToExcel(vFileName, titulo)




        End Function

        Public Shared Function Sincronismo_ElEnlace(ByVal pDataTable As DataTable, Optional ByVal titulo As String = "") As String


            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?
            'Los de LosGrobo y TomasHnos, creo que usan el esquema de AlgoritmoSoftHouse. Algún otro lo hace?




            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroElEnlace " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataTable.Rows
                i = 0 : sb = ""

                '                                                           Descripción	Tipo de Dato	Longitud        Observaciones()



                '                1 - Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.
                '3 - Sucursal Carta de Porte	Numérico	4	Primeras 4 posiciones del número de CP..
                '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.
                '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1)
                '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)
                '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)
                '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.
                '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista
                '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No
                '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.
                '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.
                '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD
                '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.
                '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.
                '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.
                '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.
                '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.
                '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)
                '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)
                '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.
                '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)
                '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)
                '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.


                '                "Mariano, esto es de Tomas Hnos. El tipo no se explayó en la descripción de
                'los problemas, lo que veo yo es que el punto 3 ""Sucursal Carta de Porte""
                'esta mandando la Carta de Porte completa.
                'Los nros de Carta de Porte son de 12 cifras: 000520239985
                'Williams no carga los ceros así que en el sincro en el punto 3 debería ir
                '""0005"" y en el punto 4 ""20239985"".
                'Creo que por este tema se corren todo el resto de los campos.

                'Por otro lado no estamos mandando el CAU (Para nosotros CEE)"




                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                'consulta TOMAS HERMANOS
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7962
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////


                Dim cero = 0




                sb &= "30707386076"                                           '1 - CUIT Williams (Entregador	Numérico	11	Código de SoftCereal ó CUIT del Entregador.
                sb &= "&" & dr("TitularCUIT").ToString.Replace("-", "").PadLeft(11)                        '2 - Productor	Numérico	11	Código de SoftCereal ó CUIT del Productor.
                ForzarPrefijo5(dr("C.Porte"))
                sb &= "&" & Left(dr("C.Porte").ToString, IIf(Len(dr("C.Porte").ToString) > 8, Len(dr("C.Porte").ToString) - 8, 0)).PadLeft(4, "0")   '3 - Sucursal Carta de Porte	Numérico	4	Primeras 4 posiciones del número de CP..
                sb &= "&" & Right(dr("C.Porte").ToString, 8).PadLeft(8, "0")               '4 - Número Carta de Porte	Numérico	8	Siguientes 8 posiciones del número de CP
                sb &= "&" & cero.ToString.PadLeft(10)                         '5 -Sucursal Ticket Entrada	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '6 - Número Ticket Entrada	Numérico	10	Se completa con Cero si no esta.)
                sb &= "&" & cero.ToString.PadLeft(10)                         '7 - Sucursal Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & cero.ToString.PadLeft(10)                         '8 - Número Ticket Salida	Numérico	10	Se completa con Cero si no esta.
                sb &= "&" & dr("R. ComercialCUIT").ToString.Replace("-", "").PadLeft(11)                          '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.            '9 - Remitente	Numérico	11	Código de SoftCereal ó CUIT del Remitente. Por defecto se toma al Productor como Remitente.
                sb &= "&" & JustificadoDerecha(dr("CEE").ToString, 14)                         '10 - Número de CAU	Numérico	14	Se completa con valor defecto informado a la Oncca (99999999999999) o Ceros. (1) Código de Autorización de Uso (C.A.U.) 



                Dim stringFechaVencimiento As String
                stringFechaVencimiento = FechaANSI(iisValidSqlDate(dr("Vencim.CP")))
                sb &= "&" & IIf(stringFechaVencimiento = "00010101", Space(8), stringFechaVencimiento) '11 - Fecha Vencimiento CAU	Numérico	8	Se completa con Cero si no esta. Formato AAAAMMDD (1)


                sb &= "&" & dr("CUIT Transp.").ToString.Replace("-", "").PadLeft(11)           '12 - Código Empresa de Transporte	Numérico	11	Código de SoftCereal ó CUIT de la E.T. (2)
                sb &= "&" & JustificadoDerecha(dr("Trasportista").ToString, 30).Replace("&", " ")                         '13 - Nombre Empresa de Transporte	Alfa	30	Razón Social del Transportista.
                sb &= "&" & dr("CUIT chofer").ToString.Replace("-", "").PadLeft(11)                         '14 - CUIT Empresa de Transporte	Alfa 	11	CUIT del Transportista

                sb &= "&" & IIf(dr("LiquidaViaje").ToString = "SI", "Si", "No")                         '15 - Liquida Viaje	Alfa	2	Acepta los valores Sí/No
                sb &= "&" & IIf(dr("CobraAcarreo").ToString = "SI", "Si", "No")                        '16 - Cobra Acarreo	Alfa	2	Acepta los valores Sí/No

                sb &= "&" & IIf(iisNull(dr("Tarifa"), 0) = 0, 0, iisNull(dr("Tarifa"), 0)).ToString.PadLeft(10)                         '17 - Tarifa de Flete	Numérico	10	Hasta 9 posiciones para parte entera y 4 para decimales. Se completa con Cero si  no esta.
                sb &= "&" & Int(dr("Kg.Bruto Desc.")).ToString.PadLeft(10)                         '18 - Kilos Brutos	Numérico	10	Se completa con el Peso Bruto registrado en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Tara Desc.")).ToString.PadLeft(10)                         '19 - Kilos Tara	Numérico	10	Se completa con la Tara registrada en la Balanza. Valor entero. Cero por defecto.
                sb &= "&" & Int(dr("Kg.Neto Desc.")).ToString.PadLeft(10)                         '20 - Kilos Descargados	Numérico	10	Se completa con Peso Bruto – Tara. Valor entero. Cero por defecto.
                sb &= "&" & FechaANSI(iisValidSqlDate(iisNull(dr("Desc."))))     '21 - Fecha Descarga	Numérico	8	Se completa con la fecha de Descarga – Formato AAAAMMDD
                sb &= "&" & DecimalToString(dr("H.%")).PadLeft(5)                         '22 -Porcentaje Humedad	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & Int(iisNull(dr("Mer.Kg."), 0)).ToString.PadLeft(10)                         '23 -Kilos Merma Humedad	Alfa	10	Kilos de Merma registrados por Secada. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '24 -Porcentaje Merma Zarandeo	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(5)                         '25 -Porcentaje Merma Volátil	Numérico	5	Hasta 7 posiciones para parte entera y 4 para decimales. Cero por defecto.


                sb &= "&" & Int(iisNull(dr("Otras"), 0)).ToString.PadLeft(10)            '26 -Kilos Merma Zarandeo	Numérico	10	Kilos de Merma registrados por Zaranda. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                        '27 -Kilos Merma Volátil	Numérico	10	Kilos de Merma registrados por Manipuleo. Valor entero. Cero por defecto.
                sb &= "&" & cero.ToString.PadLeft(10)                         '28 -Kilos Servicio	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & Int(dr("Kg.Netos")).ToString.PadLeft(10)                      '29 -Kilos Netos	Numérico	10	Bruto – Tara – Mermas. Valor entero. Se completa con Cero por defecto.
                sb &= "&" & JustificadoDerecha(dr("Contrato").ToString, 14)           '30 -Número de Contrato de Compra	Numérico	14	Se completa con Cero por defecto.


                sb &= "&" & cero.ToString.PadLeft(14)                          '31 -Número de Contrato de Venta	Numérico	14	Se completa con Cero por defecto.

                sb &= "& " & Left(dr("LocalidadProcedenciaCodigoONCAA").ToString, 5).PadLeft(5)                         '32 -Código Localidad ONCCA	Numérico	5	Se obtiene en base a la procedencia indicada en la Descarga.
                'sb &= "&" & iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString.PadLeft(5)


                sb &= "&" & Int(dr("Km")).ToString.PadLeft(10)                        '33 -Kilómetros	Numérico	10	Valor entero. Se completa con Cero por defecto.
                sb &= "&" & dr("EspecieONCAA").ToString.PadLeft(4, "0")                         '34 -Especie  	Numérico	3	SOJA/MAIZ/TRIG.(3)
                sb &= "&" & Right(dr("Cosecha"), 5).Replace("/", "").PadLeft(4)                         '35 –Cosecha	Numérico	4	Se completa con Formato NNNN Por ej 0607 para 2006/2007. (3)
                sb &= "&" & dr("CorredorCUIT").ToString.Replace("-", "").PadLeft(11)                        '36 - Codigo Corredor	Numérico	11	Se completa con el código  de SoftCereal ó CUIT del Corredor o 0 Si no existe el Dato.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                        '37 -Codigo Comprador/Vendedor 	Numérico	11	Se completa con el Código de SoftCereal ó CUIT de Comprador del Contrato de Venta al que se aplicará la Carta de Porte o 0 Si no existe el Dato. (4)
                sb &= "&" & dr("LocalidadDestinoCodigoONCAA").ToString.PadLeft(5)                         '38 -Localidad ONCCA Destino	Numérico	5	Se completa con la Localidad ONCCA asociada al Puerto (Destino)
                sb &= "&" & dr("LocalidadProcedenciaCodigoONCAA").ToString.PadLeft(5)                         '39 –Localidad ONCCA Procedencia 	Numérico	5	Se completa con la Localidad ONCCA asociada al Campo (Procedencia)
                sb &= "&" & dr("SufijoCartaDePorte").ToString.PadLeft(4)                         '40 – Sufijo Carta de Porte	Numérico	4	Sufijo de la carta de Porte.
                sb &= "&" & dr("DestinatarioCUIT").ToString.Replace("-", "").PadLeft(11)                          '41 – Destinatario CP	Numérico	11	Se completa con el Código de SoftCereal ó CUIT del destinatario de la Carta de Porte o 0 Si no existe el Dato.
                sb &= "&" & dr("CTG").ToString.PadLeft(8)                         '42 – Numero de CTG	Numérico	8	Número de CTG presente en la CP.

                sb &= "&" & JustificadoIzquierda(dr("DescripcionEstablecimientoProcedencia") & " " & dr("Cal.-Observaciones").ToString.Replace(vbCrLf, "").Replace(vbCr, "").Replace("&", " "), 125)                       '43 – Comentario	Alfa	125	Campo que permita indicar algún mensaje de datos faltantes.


                sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino

                sb &= "&" & iisNull(dr("CodigoEstablecimientoProcedencia"), "").ToString.PadLeft(6)   '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia
                sb &= "&" & iisNull(dr("IdTipoMovimiento"), "").ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                '                                                       1.	Egresos contratos de Venta
                '                                                       2.	Egreso Directo a Destino Productor
                '                                                       3.	Directo Destino contrato de Compra
                '                                                       4.	Ingreso Entregado Productor
                '                                                       5.	Ingreso Contrato de Compra
                '                                                       6.	Reingreso de Mercadería
                '                                                       7.	Transferencia desde otra Planta



                'sb &= "&" & dr("Contrato").ToString.PadLeft(14) '
                'sb &= "&" & dr("Contrato").ToString.PadLeft(14)
                'sb &= "&" & dr("Contrato").ToString.PadLeft(14)

                'sb &= "&" & cero.ToString.PadLeft(6) '44 – Código de Establecimiento  Destino	Numérico	6	Código de Establecimiento Destino
                'sb &= "&" & cero.ToString.PadLeft(6) '45 - Código de Establecimiento  Procedencia	Numérico	6	Código de Establecimiento Procedencia
                'sb &= "&" & cero.ToString.PadLeft(4) '46 – Código de Tipo de Movimiento	Numérico	4	Código de Tipo de Movimiento
                ''                                                       1.	Egresos contratos de Venta
                ''                                                       2.	Egreso Directo a Destino Productor
                ''                                                       3.	Directo Destino contrato de Compra
                ''                                                       4.	Ingreso Entregado Productor
                ''                                                       5.	Ingreso Contrato de Compra
                ''                                                       6.	Reingreso de Mercadería
                ''                                                       7.	Transferencia desde otra Planta


                'sb = sb.Replace(".", ",") 'solucion cabeza por los decimales





                PrintLine(nF, sb)
            Next


            FileClose(nF)


            Return vFileName
            'Return TextToExcel(vFileName, titulo)




        End Function



        Public Shared Function Sincronismo_DiazRiganti(ByVal SC As String, ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String









            Dim SEPARADOR As String = ","





            '1Carta porte pto  
            '2Carta  porte  nro 
            '3Fecha emision  
            '4Producto     			Código SAGPyA del producto
            '5contrato                  
            '6Declaracion_calidad     
            '7Procedencia                      	Codigo Postal
            '8Cargador                 		Nro_Cuit con formto:  xx-xxxxxxxx-x
            '9Raz. Soc. cargador      
            '0Procedencia  bruto    
            '11Procedencia  tara        
            '12Procedencia  neto       
            '13Corredor   
            '14Lugar  entrega                     	Codigo Postal
            '15Patente              
            '16Destino bruto        
            '17Destino  tara    
            '18Destino  neto      
            '19Fecha  descarga 
            '20Destinatario             		Nro_Cuit con formto:  xx-xxxxxxxx-x
            '21Raz..soc.destin      
            '22Recibo    
            '23Condicional
            '24Chamico  
            '25Humedad 
            '26Zarandeo    
            '27Secado  
            '28Fumigacion 
            '29Gastos pesos 
            '30 Gastos kilos  
            '31 Merma  gastos 
            '32 Merma zarandeo 
            '33 Merma secado 
            '34 Puesto  
            '35Kg.  netos  reales 
            '36Destino                  		Nro_Cuit con formto:  xx-xxxxxxxx-x
            '37Laboratorio  			Nro_Cuit con formto:  xx-xxxxxxxx-x
            '38Raz. soc    
            '39Mer. vol     
            '40Observaciones  
            '41Entregador                              	Siempre la leyenda: “Williams Entregas S.A.
            '42Raz. Soc Cuenta y Orden



            '   0001,"19895248",10/07/2011,19,,"CC",22142,30646328450,"SYNGENTA AGRO S.A.",44540,14360,30180,"DIAZ RIGANTI CEREALES SRL",43,"EJD161",44520,14380,30140,10/07/2011,33502232229,"OLEAGINOSA MORENO HNOS SA","","N",0, 0.00,0, 0.00,"N",0,0,0,0,0,"","",30140,43,16:22,0,"",0,"","Williams Entregas S.A."
            '   0001,"20143823",10/07/2011,19,13535201,"CC",321,30646328450,"SYNGENTA AGRO S.A.",45000,15990,29010,"DIAZ RIGANTI CEREALES SRL",43,"VGF312",45060,16440,28620,10/07/2011,33502232229,"OLEAGINOSA MORENO HNOS SA","","N",0, 0.00,0, 0.00,"N",0,0,0,0,0,"c","",28620,43,18:47,0,"",0,"","Williams Entregas S.A."
            '   0001,"20009381",10/07/2011,23,137441,"CF",20250,30646328450,"SYNGENTA AGRO S.A.",41665,14980,26685,"DIAZ RIGANTI CEREALES SRL",22044,"JXK670",31580,4860,26720,10/07/2011,30526712729,"LDC ARGENTINA SA","","N",0,13.30,0, 0.00,"N",0,0,0,0,0,"","",26720,22044, 9:47,0,"",0,"","Williams Entregas S.A."





            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroDR " & Now.ToString("ddMMMyyyy_HHmmss") & ".csv" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            Dim cadenavacia As String = ""
            Dim sErroresProcedencia, sErroresDestinos As String
            Dim sErrores As String = ""




            '//////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////

            Dim sErroresCartas = ""

            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0
                    Dim sErroresporCarta = ""






                    '//////////////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////////////

                    '1Carta porte pto  
                    sb &= "0001"


                    '2Carta  porte  nro 
                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= SEPARADOR & _cc(Right(.NumeroCartaDePorte.ToString, 8))  'sacar el 5 de adelante (bastará con tomar 8 digitos)


                    '3Fecha emision  
                    If .IsFechaArriboNull Then .FechaArribo = Nothing
                    sb &= SEPARADOR & .FechaArribo.ToString("MM/dd/yyyy")     'Emi	STRING(8)	Fecha de Emisión de Carta de Porte)    1100)    1107


                    '4Producto     			Código SAGPyA del producto
                    sb &= SEPARADOR & .CodigoSAJPYA 'Grano	STRING(3)	Código de grano Sagpya)    1)    3

                    '5contrato                  
                    sb &= SEPARADOR & Val(.Contrato)


                    '6Declaracion_calidad     
                    If .IsCalidadDeNull Then .CalidadDe = Nothing
                    sb &= SEPARADOR & _cc(FormatearCalidad(.CalidadDe))


                    'Procedencia                      	Codigo Postal
                    sb &= SEPARADOR & Left(.ProcedenciaCodigoPostal.ToString, 8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534


                    'Cargador                 		Nro_Cuit con formto:  xx-xxxxxxxx-x
                    sb &= SEPARADOR & Left(.TitularCUIT.ToString.Replace("-", ""), 14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144

                    'Raz. Soc. cargador      
                    sb &= SEPARADOR & _cc(Left(.TitularDesc.ToString, 30).Replace(",", " ")) 'NomComp	STRING(30)	Nombre Comprador)    145)    174




                    '10Procedencia  bruto    
                    sb &= SEPARADOR & Int(.BrutoPto).ToString

                    'Procedencia  tara        
                    sb &= SEPARADOR & Int(.TaraPto).ToString

                    'Procedencia  neto       
                    sb &= SEPARADOR & Int(.NetoPto).ToString

                    'Corredor   
                    'sb &= SEPARADOR & Left(.CorredorCUIT.ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
                    sb &= SEPARADOR & _cc(Left(.CorredorDesc.ToString, 30)) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218


                    'Lugar  entrega                     	Codigo Postal
                    sb &= SEPARADOR & "0"


                    'Patente              
                    sb &= SEPARADOR & _cc(Left(.Patente.ToString.Replace(",", ""), 6))


                    'Destino bruto        
                    sb &= SEPARADOR & Int(.BrutoFinal).ToString

                    'Destino  tara    
                    sb &= SEPARADOR & Int(.TaraFinal).ToString

                    'Destino  neto      
                    sb &= SEPARADOR & Int(.NetoFinal).ToString


                    'Fecha  descarga 
                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= SEPARADOR & .FechaDescarga.ToString("MM/dd/yyyy")

                    '20Destinatario             		Nro_Cuit con formto:  xx-xxxxxxxx-x
                    sb &= SEPARADOR & Left(.DestinatarioCUIT.ToString.Replace("-", ""), 14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144

                    '21Raz..soc.destin      
                    sb &= SEPARADOR & _cc(Left(.DestinatarioDesc.ToString, 30).Replace(",", " "))


                    'Recibo    
                    sb &= SEPARADOR & _cc(Left(.NRecibo.ToString, 10))

                    'Condicional
                    sb &= SEPARADOR & _cc("N")

                    'Chamico  
                    sb &= SEPARADOR & "0"

                    'Humedad 
                    sb &= SEPARADOR & .Humedad.ToString.Replace(",", ".")
                    'sb &= SEPARADOR & .HumedadDesnormalizada.ToString.Replace(",", ".")
                    'sb &= SEPARADOR & Int(.Merma).ToString.PadLeft(10)



                    'Zarandeo    
                    sb &= SEPARADOR & "0"

                    'Secado  
                    sb &= SEPARADOR & "0"

                    'Fumigacion 
                    sb &= SEPARADOR & _cc("N")

                    'Gastos pesos 
                    sb &= SEPARADOR & "0"

                    '30 Gastos kilos  
                    sb &= SEPARADOR & "0"

                    ' Merma  gastos 
                    sb &= SEPARADOR & .Merma.ToString.Replace(",", ".")

                    ' Merma zarandeo 
                    sb &= SEPARADOR & "0"

                    ' Merma secado 
                    sb &= SEPARADOR & .HumedadDesnormalizada.ToString.Replace(",", ".")

                    ' Puesto  
                    sb &= SEPARADOR & _cc("c")


                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////
                    '1ra (de 2) columna agregada que no figuran en el .doc para que encastre con los ejemplos
                    '///////////////////////////////////////////////////
                    sb &= SEPARADOR & _cc("")
                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////


                    'Kg.  netos  reales 
                    sb &= SEPARADOR & Int(.NetoProc).ToString

                    'Destino                  		Nro_Cuit con formto:  xx-xxxxxxxx-x
                    'aca mandan un codigo, no el cuit (cual? el williams, el oncca, el postal....) -el doc dice claro CUIT !
                    'sb &= SEPARADOR & Left(.DestinoCUIT.ToString.Replace("-", ""), 14) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56
                    sb &= SEPARADOR & .DestinoCodigoPostal.ToString

                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////
                    '2da (de 2) columna agregada que no figuran en el .doc para que encastre con los ejemplos
                    '///////////////////////////////////////////////////
                    sb &= SEPARADOR & Convert.ToDateTime(iisNull(.FechaDescarga, #12:00:00 AM#)).ToString("hh:mm")

                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////


                    'Laboratorio  			Nro_Cuit con formto:  xx-xxxxxxxx-x
                    sb &= SEPARADOR & ""

                    'Raz. soc    )
                    sb &= SEPARADOR & _cc("")

                    'Mer. vol     
                    sb &= SEPARADOR & "0"

                    '40Observaciones  
                    sb &= SEPARADOR & _cc(Left(.Observaciones.ToString, 100).Replace(",", " "))

                    'Entregador                              	Siempre la leyenda: “Williams Entregas S.A.
                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    sb &= SEPARADOR & _cc(wily)

                    'Raz. Soc Cuenta y Orden
                    'sb &= SEPARADOR & ""








                    '//////////////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////////////
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10307
                    'Solicitan agregar el número de vagón, en un campo al final del archivo de sincronismos de Diaz Riganti.
                    sb &= SEPARADOR & _cc(.SubnumeroVagon.ToString)

                    '//////////////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////////////








                    If sErroresporCarta <> "" Then
                        sErroresCartas &= "<a href=""CartaDePorte.aspx?Id=" & .IdCartaDePorte & """ target=""_blank"">" & .NumeroCartaDePorte & " " & .SubnumeroVagon & "/" & sErroresporCarta & "</a>; " & "<br/>"
                    Else
                        PrintLine(nF, sb)
                    End If


                End With
            Next


            FileClose(nF)






            sErrores = "DATOS FALTANTES <br/> Procedencias sin código ONCAA:<br/> " & sErroresProcedencia & "<br/>Destinos sin código ONCAA: <br/>" & sErroresDestinos & sErroresCartas

            '  If sErroresProcedencia <> "" Or sErroresDestinos <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write





            Return vFileName

        End Function








        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////




        Public Shared Function Sincronismo_Ojeda(q As Generic.List(Of CartasConCalada), titulo As String, ByVal sWHERE As String, ByRef sErrores As String, SC As String) As String

            ''            Andres, necesitamos desarrollar sincro de descargas del corredor Ariel Ojeda que contenga estos datos :
            ''Fecha de arribo / Descarga
            ''Nro completo de cp ( con el 5 )
            ''            Titular()
            ''            Intermediario()
            ''            Rte(Comercial)
            ''            Destinatario()
            ''Procedencia / Destino
            ''            Producto()
            ''            Kg(descarga)
            ''            Kg(Merma)
            ''% de humedad y Kg merma x Humedad
            ''Kg netos de descarga ( final incluido mermas )
            
            Dim sErroresCartas As String

            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroOjeda " & Now.ToString("ddMMMyyyy_HHmmss") & ".csv" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)


            Dim SEP = ";"

            For Each i As CartasConCalada In q
                Dim sb As String = ""
                sb &= i.FechaArribo
                sb &= SEP & i.FechaDescarga
                sb &= SEP & i.NumeroCartaDePorteFormateada
                sb &= SEP & i.TitularDesc
                sb &= SEP & i.IntermediarioDesc
                sb &= SEP & i.RComercialDesc
                sb &= SEP & i.DestinatarioDesc

                sb &= SEP & i.ProcedenciaDesc
                sb &= SEP & i.DestinoDesc
                sb &= SEP & i.Producto

                ''            Kg(descarga)
                ''            Kg(Merma)
                sb &= SEP & i.NetoFinal
                sb &= SEP & i.Merma
                ''% de humedad y Kg merma x Humedad
                sb &= SEP & i.Humedad
                sb &= SEP & i.HumedadDesnormalizada
                ''Kg netos de descarga ( final incluido mermas )
                sb &= SEP & i.NetoProc


                sb &= SEP


                PrintLine(nF, sb)



            Next



            'Exigir establecimiento en el sincro argencer.
            sErrores = sErroresCartas

            If True Then
                If sErroresCartas <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If


            FileClose(nF)


            Return vFileName

        End Function

        Public Shared Function Sincronismo_Argencer(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, titulo As String, ByVal sWHERE As String, ByRef sErrores As String, SC As String) As String
            'Formato de SOLVER
            '            Pos. Campo Observaciones Oblig.
            '1 Nro de Carta de porte PP-NNNNNNNN S
            '2 Nro de Recibo Entero N
            '3 Codigo de Establecimiento de Procedencia Código ONCCA N
            '4 Cod. Localidad Procedencia Código ONCCA N
            '5 Nombre Procedencia S
            '6 Código de Establecimiento de Destino Código ONCCA N
            '7 Cód. Localidad ONCCA Destino Código ONCCA N
            '8 Nombre Destino S
            '9 CUIT Comprador PP-NNNNNNNN-V N
            '10 Nombre Comprador S
            '11 CUIT Vendedor PP-NNNNNNNN-V N
            '12 Nombre Vendedor S
            '13 Fecha Descarga aaaaMMdd S
            '14 Cod. Producto Código ONCCA N
            '15:         Desc.Producto(S)
            '16 Cosecha #### N
            '17 Kg. Procedencia Entero S
            '18 Kg. Descargados Entero S
            '19 Porcentaje de Humedad Decimal (2 dec.) N
            '20 Porcentaje de Mermas por Humedad Decimal (2 dec.) N
            '21 Kg. Mermas Humedad Entero N
            '22 Porcentaje de Mermas por Zaranda Decimal (2 dec.) N
            '23 Kg. Mermas Zaranda Entero N
            '24 Porcentaje de Mermas Adicionales Decimal (2 dec.) N
            '25 Kg. Mermas Adicionales Entero N
            '26 Kg. Mermas Entero S
            '27 Kg. Netos Descargados Entero S
            '28 Transporte 1 Transporte Automotor
            '2:          Vagón()
            '3:          Barcaza()
            '            N()
            '29 Patente Camión AAA### N
            '30 Patente Acoplado AAA### N
            '31 Es Conforme C - Conforme
            '            A(-Análisis)
            '            S()
            '32 Fecha Envío del Camión aaaaMMdd N33 CUIT Entregador PP-NNNNNNNN-V S
            '34 Nombre Entregador S
            '35:         Observaciones(N)







            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroArgencer " & Now.ToString("ddMMMyyyy_HHmmss") & ".csv" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            '            Dim a = pDataTable(1)

            Dim SEP = ";"
            Dim s = ""
            s = s & "1 Nro de Carta de porte PP-NNNNNNNN S" & SEP
            s = s & "2 oNro de Recibo Entero N" & SEP
            s = s & "3 Codigo de Establecimiento de Procedencia Código ONCCA N" & SEP
            s = s & "4 Cod. Localidad Procedencia Código ONCCA N" & SEP
            s = s & "5 Nombre Procedencia S" & SEP
            s = s & "6 Código de Establecimiento de Destino Código ONCCA N" & SEP
            s = s & "7 Cód. Localidad ONCCA Destino Código ONCCA N" & SEP
            s = s & "8 Nombre Destino S" & SEP
            s = s & "9 CUIT Comprador PP-NNNNNNNN-V N" & SEP
            s = s & "10 Nombre Comprador S" & SEP
            s = s & "11 CUIT Vendedor PP-NNNNNNNN-V N" & SEP
            s = s & "12 Nombre Vendedor S" & SEP
            s = s & "13 Fecha Descarga aaaaMMdd S" & SEP
            s = s & "14 Cod. Producto Código ONCCA N" & SEP
            s = s & "15 Desc. Producto S" & SEP
            s = s & "16 Cosecha #### N" & SEP
            s = s & "17 Kg. Procedencia Entero S" & SEP
            s = s & "18 Kg. Descargados Entero S" & SEP
            s = s & "19 Porcentaje de Humedad Decimal (2 dec.) N" & SEP
            s = s & "20 Porcentaje de Mermas por Humedad Decimal (2 dec.) N" & SEP
            s = s & "21 Kg. Mermas Humedad Entero N" & SEP
            s = s & "22 Porcentaje de Mermas por Zaranda Decimal (2 dec.) N" & SEP
            s = s & "23 Kg. Mermas Zaranda Entero N" & SEP
            s = s & "24 Porcentaje de Mermas Adicionales Decimal (2 dec.) N" & SEP
            s = s & "25 Kg. Mermas Adicionales Entero N" & SEP
            s = s & "26 Kg. Mermas Entero S" & SEP
            s = s & "27 Kg. Netos Descargados Entero S" & SEP
            s = s & "28 Transporte 1 Transporte Automotor 2 Vagón 3 Barcaza" & SEP
            s = s & "29 Patente Camión AAA### N" & SEP
            s = s & "30 Patente Acoplado AAA### N" & SEP
            s = s & "31 Es Conforme C - Conforme" & SEP
            s = s & "32 Fecha Envío del Camión aaaaMMdd N" & SEP
            s = s & "33 CUIT Entregador PP-NNNNNNNN-V S" & SEP
            s = s & "34 Nombre Entregador S" & SEP
            s = s & "35 Observaciones N" & SEP


            'PrintLine(nF, s)

            '.CSV
            '"0","519276582",23/08/2011,19,,"CF",7114,30589747409,"EL CALLEJON S.A."          ,0,0,30450,"FUTUROS Y OPCIONES .COM",8,"",44960,14200,30760,23/08/2011,30522881089,"RASIC HNOS S.A.",00000000000,"",00000000000,"",00000000000,"",           0.00, 0.00,"N",0,0,0,0,"c",30760,8, 0:00,"Williams Entregas S.A.",
            '0,"518968687   ",07302011 ,  ,,"FE",    ,"20176863332","CINOLLO VENENGO C.MARIA",0,0  ,0   ,"GRANOS DEL PARANA S.A.",  ,"",42200,12740,29460,30/07/2011,"30700869918","BUNGE ARGENTINA S.A.","           ","","           ","",00000000000,"",0.00,0.00,"N",0,0,0,0  c,     29460,,0:00,"Williams Entregas S.A.",""


            Dim sErroresCartas As String

            Using db As New LinqCartasPorteDataContext(Encriptar(SC))





                'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
                For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                    With cdp
                        'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                        '------------------------------------------
                        'Puerto					    Destino
                        'Recibidor				    WILLIAMS SA
                        'Comprador				    Destinatario		
                        'Corredor Comprador		    Corredor
                        'Entregador				    Destinatario
                        'Cargador				    (este es a quien se le facturó)
                        'Vendedor				    Titular
                        'Corredor Endozo		    ?
                        'Comprador Endozo		    ?
                        'Corredor Vendedor		    ?
                        'Planta Origen			    ?
                        'Procedencia 			    Origen
                        'Destino 				    Destino

                        Dim wily = "Williams Entregas S.A."
                        Dim wilycuit = "30-70738607-6"
                        Dim cadenavacia As String = ""

                        i = 0 : sb = ""

                        Dim cero = 0


                        Try

                            Dim CodigoEstablecimientoProcedencia As linqCDPEstablecimiento
                            If Not .IsIdEstablecimientoNull Then
                                CodigoEstablecimientoProcedencia = (From x In db.linqCDPEstablecimientos Where x.IdEstablecimiento = cdp.IdEstablecimiento).FirstOrDefault
                            End If
                            If CodigoEstablecimientoProcedencia.Descripcion = "" Then
                                sErroresCartas &= "<a href=""CDPEstablecimientos.aspx?Id=" & .IdEstablecimiento & """ target=""_blank"">Falta código del establecimiento de procedencia. " & CodigoEstablecimientoProcedencia.AuxiliarString1 & "</a>; " & "<br/>"
                            End If
                        Catch ex As Exception
                            ErrHandler.WriteError(ex.ToString)

                        End Try






                        If Len(.NumeroCartaDePorte.ToString) > 8 Then
                            sb &= Left(.NumeroCartaDePorte.ToString, Len(.NumeroCartaDePorte.ToString) - 8).PadLeft(2, "0")
                        Else
                            sb &= "00"
                        End If

                        ForzarPrefijo5(.NumeroCartaDePorte)
                        sb &= "-" & Right(.NumeroCartaDePorte, 8).PadRight(8, "0")


                        sb &= SEP & .NRecibo.ToString.PadLeft(10)

                        sb &= SEP & "" '.IdEstablecimiento
                        's = s & "3 Codigo de Establecimiento de Procedencia Código ONCCA N" & SEP

                        sb &= SEP & .ProcedenciaCodigoONCAA
                        's = s & "4 Cod. Localidad Procedencia Código ONCCA N" & SEP

                        sb &= SEP & .ProcedenciaDesc
                        's = s & "5 Nombre Procedencia S" & SEP

                        '- En la posición 6 enviar el codigo oncca del destino (ya se está enviando en otra posicion, repetirla)
                        sb &= SEP & .DestinoCodigoONCAA ' .IdEstablecimiento 
                        's = s & "6 Código de Establecimiento de Destino Código ONCCA N" & SEP
                        sb &= SEP & .DestinoCodigoONCAA
                        's = s & "7 Cód. Localidad ONCCA Destino Código ONCCA N" & SEP
                        sb &= SEP & .DestinoDesc
                        's = s & "8 Nombre Destino S" & SEP

                        sb &= SEP & .DestinatarioCUIT
                        's = s & "9 CUIT Comprador PP-NNNNNNNN-V N" & SEP
                        sb &= SEP & .DestinatarioDesc.Replace(SEP, " ")
                        's = s & "10 Nombre Comprador S" & SEP

                        sb &= SEP & .TitularCUIT
                        's = s & "11 CUIT Vendedor PP-NNNNNNNN-V N" & SEP
                        sb &= SEP & .TitularDesc.Replace(SEP, " ")
                        's = s & "12 Nombre Vendedor S" & SEP

                        sb &= SEP & .FechaDescarga.ToString("yyyyMMdd")
                        's = s & "13 Fecha Descarga aaaaMMdd S" & SEP

                        sb &= SEP & .CodigoSAJPYA.PadLeft(3)
                        's = s & "14 Cod. Producto Código ONCCA N" & SEP

                        sb &= SEP & .Producto
                        's = s & "15 Desc. Producto S" & SEP


                        sb &= SEP & Right(.Cosecha, 5).Replace("/", "").PadLeft(4)




                        sb &= SEP & Int(.NetoPto).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                        's = s & "17 Kg. Procedencia Entero S" & SEP

                        sb &= SEP & Int(.NetoFinal).ToString.PadLeft(10)
                        'sb &= SEP &  "18 Kg. Descargados Entero S" & SEP

                        sb &= SEP & .Humedad

                        sb &= SEP & "" ' porcentaje merma humedad

                        sb &= SEP & Int(.HumedadDesnormalizada).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695


                        sb &= SEP & "0.00" '22
                        sb &= SEP & "0"

                        sb &= SEP & "0.00" '24

                        sb &= SEP & "0"
                        sb &= SEP & Int(.Merma)



                        sb &= SEP & Int(.NetoProc).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665
                        ' s = s & "27 Kg. Netos Descargados Entero S" & SEP





                        sb &= SEP & IIf(.SubnumeroVagon > 0, 2, 1) '                s = s & "28 Transporte 1 Transporte Automotor 2 Vagón 3 Barcaza" & SEP

                        sb &= SEP & .Acoplado
                        sb &= SEP & .Patente


                        Dim sCalidad As String

                        Try
                            If InStr(.CalidadDesc.ToString.ToLower, "conforme") > 0 Then
                                sCalidad = "C"
                                'ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 1") > 0 Then
                                '    sCalidad = "G1"
                                'ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 2") > 0 Then
                                '    sCalidad = "G2"
                                'ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 3") > 0 Then
                                '    sCalidad = "G3"
                                'ElseIf InStr(.CalidadDesc.ToString.ToLower, "camara") > 0 Then
                                '    sCalidad = "CC"
                            Else
                                '    sCalidad = "FE"
                                sCalidad = "A"
                            End If
                        Catch ex As Exception
                            ErrHandler.WriteError("Sincro amaggi")
                            ErrHandler.WriteError(ex)
                        End Try
                        If .IsCalidadDescNull Then sCalidad = "FE"
                        sb &= SEP & sCalidad
                        's = s & "31 Es Conforme C - Conforme" & SEP

                        sb &= SEP & .FechaArribo.ToString("yyyyMMdd")
                        ''s = s & "32 Fecha Envío del Camión aaaaMMdd "


                        sb &= SEP & wilycuit
                        's = "N33 CUIT Entregador PP-NNNNNNNN-V S" & SEP

                        sb &= SEP & wily


                        sb &= SEP & .Observaciones

                        sb &= SEP


                        PrintLine(nF, sb)
                    End With
                Next

            End Using


            'Exigir establecimiento en el sincro argencer.
            sErrores = sErroresCartas

            If True Then
                If sErroresCartas <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write
            End If


            FileClose(nF)


            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function



        Public Shared Function Sincronismo_Roagro(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String

            'Formato de SOLVER
            '            Pos. Campo Observaciones Oblig.
            '1 Nro de Carta de porte PP-NNNNNNNN S
            '2 Nro de Recibo Entero N
            '3 Codigo de Establecimiento de Procedencia Código ONCCA N
            '4 Cod. Localidad Procedencia Código ONCCA N
            '5 Nombre Procedencia S
            '6 Código de Establecimiento de Destino Código ONCCA N
            '7 Cód. Localidad ONCCA Destino Código ONCCA N
            '8 Nombre Destino S
            '9 CUIT Comprador PP-NNNNNNNN-V N
            '10 Nombre Comprador S
            '11 CUIT Vendedor PP-NNNNNNNN-V N
            '12 Nombre Vendedor S
            '13 Fecha Descarga aaaaMMdd S
            '14 Cod. Producto Código ONCCA N
            '15:         Desc.Producto(S)
            '16 Cosecha #### N
            '17 Kg. Procedencia Entero S
            '18 Kg. Descargados Entero S
            '19 Porcentaje de Humedad Decimal (2 dec.) N
            '20 Porcentaje de Mermas por Humedad Decimal (2 dec.) N
            '21 Kg. Mermas Humedad Entero N
            '22 Porcentaje de Mermas por Zaranda Decimal (2 dec.) N
            '23 Kg. Mermas Zaranda Entero N
            '24 Porcentaje de Mermas Adicionales Decimal (2 dec.) N
            '25 Kg. Mermas Adicionales Entero N
            '26 Kg. Mermas Entero S
            '27 Kg. Netos Descargados Entero S
            '28 Transporte 1 Transporte Automotor
            '2:          Vagón()
            '3:          Barcaza()
            '            N()
            '29 Patente Camión AAA### N
            '30 Patente Acoplado AAA### N
            '31 Es Conforme C - Conforme
            '            A(-Análisis)
            '            S()
            '32 Fecha Envío del Camión aaaaMMdd N33 CUIT Entregador PP-NNNNNNNN-V S
            '34 Nombre Entregador S
            '35:         Observaciones(N)



            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroRoagro " & Now.ToString("ddMMMyyyy_HHmmss") & ".csv" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            '            Dim a = pDataTable(1)

            Dim SEP = ";"
            Dim s = ""
            s = s & "1 Nro de Carta de porte PP-NNNNNNNN S" & SEP
            s = s & "2 oNro de Recibo Entero N" & SEP
            s = s & "3 Codigo de Establecimiento de Procedencia Código ONCCA N" & SEP
            s = s & "4 Cod. Localidad Procedencia Código ONCCA N" & SEP
            s = s & "5 Nombre Procedencia S" & SEP
            s = s & "6 Código de Establecimiento de Destino Código ONCCA N" & SEP
            s = s & "7 Cód. Localidad ONCCA Destino Código ONCCA N" & SEP
            s = s & "8 Nombre Destino S" & SEP
            s = s & "9 CUIT Comprador PP-NNNNNNNN-V N" & SEP
            s = s & "10 Nombre Comprador S" & SEP
            s = s & "11 CUIT Vendedor PP-NNNNNNNN-V N" & SEP
            s = s & "12 Nombre Vendedor S" & SEP
            s = s & "13 Fecha Descarga aaaaMMdd S" & SEP
            s = s & "14 Cod. Producto Código ONCCA N" & SEP
            s = s & "15 Desc. Producto S" & SEP
            s = s & "16 Cosecha #### N" & SEP
            s = s & "17 Kg. Procedencia Entero S" & SEP
            s = s & "18 Kg. Descargados Entero S" & SEP
            s = s & "19 Porcentaje de Humedad Decimal (2 dec.) N" & SEP
            s = s & "20 Porcentaje de Mermas por Humedad Decimal (2 dec.) N" & SEP
            s = s & "21 Kg. Mermas Humedad Entero N" & SEP
            s = s & "22 Porcentaje de Mermas por Zaranda Decimal (2 dec.) N" & SEP
            s = s & "23 Kg. Mermas Zaranda Entero N" & SEP
            s = s & "24 Porcentaje de Mermas Adicionales Decimal (2 dec.) N" & SEP
            s = s & "25 Kg. Mermas Adicionales Entero N" & SEP
            s = s & "26 Kg. Mermas Entero S" & SEP
            s = s & "27 Kg. Netos Descargados Entero S" & SEP
            s = s & "28 Transporte 1 Transporte Automotor 2 Vagón 3 Barcaza" & SEP
            s = s & "29 Patente Camión AAA### N" & SEP
            s = s & "30 Patente Acoplado AAA### N" & SEP
            s = s & "31 Es Conforme C - Conforme" & SEP
            s = s & "32 Fecha Envío del Camión aaaaMMdd N" & SEP
            s = s & "33 CUIT Entregador PP-NNNNNNNN-V S" & SEP
            s = s & "34 Nombre Entregador S" & SEP
            s = s & "35 Observaciones N" & SEP


            'PrintLine(nF, s)

            '.CSV
            '"0","519276582",23/08/2011,19,,"CF",7114,30589747409,"EL CALLEJON S.A."          ,0,0,30450,"FUTUROS Y OPCIONES .COM",8,"",44960,14200,30760,23/08/2011,30522881089,"RASIC HNOS S.A.",00000000000,"",00000000000,"",00000000000,"",           0.00, 0.00,"N",0,0,0,0,"c",30760,8, 0:00,"Williams Entregas S.A.",
            '0,"518968687   ",07302011 ,  ,,"FE",    ,"20176863332","CINOLLO VENENGO C.MARIA",0,0  ,0   ,"GRANOS DEL PARANA S.A.",  ,"",42200,12740,29460,30/07/2011,"30700869918","BUNGE ARGENTINA S.A.","           ","","           ","",00000000000,"",0.00,0.00,"N",0,0,0,0  c,     29460,,0:00,"Williams Entregas S.A.",""





            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp
                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular
                    'Corredor Endozo		    ?
                    'Comprador Endozo		    ?
                    'Corredor Vendedor		    ?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30-70738607-6"
                    Dim cadenavacia As String = ""

                    i = 0 : sb = ""

                    Dim cero = 0



                    If Len(.NumeroCartaDePorte.ToString) > 8 Then
                        sb &= Left(.NumeroCartaDePorte.ToString, Len(.NumeroCartaDePorte.ToString) - 8).PadLeft(2, "0")
                    Else
                        sb &= "00"
                    End If

                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= "-" & Right(.NumeroCartaDePorte, 8).PadRight(8, "0")


                    sb &= SEP & .NRecibo.ToString.PadLeft(10)

                    sb &= SEP & "" '.IdEstablecimiento
                    's = s & "3 Codigo de Establecimiento de Procedencia Código ONCCA N" & SEP

                    sb &= SEP & .ProcedenciaCodigoONCAA
                    's = s & "4 Cod. Localidad Procedencia Código ONCCA N" & SEP

                    sb &= SEP & .ProcedenciaDesc
                    's = s & "5 Nombre Procedencia S" & SEP

                    sb &= SEP & "" ' .IdEstablecimiento
                    's = s & "6 Código de Establecimiento de Destino Código ONCCA N" & SEP
                    sb &= SEP & .DestinoCodigoONCAA
                    's = s & "7 Cód. Localidad ONCCA Destino Código ONCCA N" & SEP
                    sb &= SEP & .DestinoDesc
                    's = s & "8 Nombre Destino S" & SEP

                    sb &= SEP & .DestinatarioCUIT
                    's = s & "9 CUIT Comprador PP-NNNNNNNN-V N" & SEP
                    sb &= SEP & .DestinatarioDesc.Replace(SEP, " ")
                    's = s & "10 Nombre Comprador S" & SEP

                    sb &= SEP & .TitularCUIT
                    's = s & "11 CUIT Vendedor PP-NNNNNNNN-V N" & SEP
                    sb &= SEP & .TitularDesc.Replace(SEP, " ")
                    's = s & "12 Nombre Vendedor S" & SEP

                    sb &= SEP & .FechaDescarga.ToString("yyyyMMdd")
                    's = s & "13 Fecha Descarga aaaaMMdd S" & SEP

                    sb &= SEP & .CodigoSAJPYA.PadLeft(3)
                    's = s & "14 Cod. Producto Código ONCCA N" & SEP

                    sb &= SEP & .Producto
                    's = s & "15 Desc. Producto S" & SEP


                    sb &= SEP & Right(.Cosecha, 5).Replace("/", "").PadLeft(4)




                    sb &= SEP & Int(.NetoPto).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    's = s & "17 Kg. Procedencia Entero S" & SEP

                    sb &= SEP & Int(.NetoFinal).ToString.PadLeft(10)
                    'sb &= SEP &  "18 Kg. Descargados Entero S" & SEP

                    sb &= SEP & .Humedad

                    sb &= SEP & "" ' porcentaje merma humedad

                    sb &= SEP & Int(.HumedadDesnormalizada).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695


                    sb &= SEP & "0.00" '22
                    sb &= SEP & "0"

                    sb &= SEP & "0.00" '24

                    sb &= SEP & "0"
                    sb &= SEP & Int(.Merma)



                    sb &= SEP & Int(.NetoProc).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665
                    ' s = s & "27 Kg. Netos Descargados Entero S" & SEP





                    sb &= SEP & IIf(.SubnumeroVagon > 0, 2, 1) '                s = s & "28 Transporte 1 Transporte Automotor 2 Vagón 3 Barcaza" & SEP

                    sb &= SEP & .Acoplado
                    sb &= SEP & .Patente


                    Dim sCalidad As String

                    Try
                        If InStr(.CalidadDesc.ToString.ToLower, "conforme") > 0 Then
                            sCalidad = "C"
                            'ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 1") > 0 Then
                            '    sCalidad = "G1"
                            'ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 2") > 0 Then
                            '    sCalidad = "G2"
                            'ElseIf InStr(.CalidadDesc.ToString.ToLower, "grado 3") > 0 Then
                            '    sCalidad = "G3"
                            'ElseIf InStr(.CalidadDesc.ToString.ToLower, "camara") > 0 Then
                            '    sCalidad = "CC"
                        Else
                            '    sCalidad = "FE"
                            sCalidad = "A"
                        End If
                    Catch ex As Exception
                        ErrHandler.WriteError("Sincro amaggi")
                        ErrHandler.WriteError(ex)
                    End Try
                    If .IsCalidadDescNull Then sCalidad = "FE"
                    sb &= SEP & sCalidad
                    's = s & "31 Es Conforme C - Conforme" & SEP

                    sb &= SEP & .FechaArribo.ToString("yyyyMMdd")
                    ''s = s & "32 Fecha Envío del Camión aaaaMMdd "


                    sb &= SEP & wilycuit
                    's = "N33 CUIT Entregador PP-NNNNNNNN-V S" & SEP

                    sb &= SEP & wily


                    sb &= SEP & .Observaciones




                    PrintLine(nF, sb)
                End With
            Next


            FileClose(nF)


            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function



        Public Shared Function Sincronismo_TecnoCampo(ByVal pDataTable As DataTable, Optional ByVal titulo As String = "") As String





            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroTecnoCampo " & Now.ToString("ddMMMyyyy_HHmmss") & ".txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataTable.Rows
                i = 0 : sb = ""



                Dim cero = 0


                sb &= JustificadoIzquierda(dr("CodigoSagypa").ToString, 3) 'Grano	STRING(3)	Código de grano Sagpya)    1)    3
                sb &= JustificadoIzquierda(IIf(True, 1, 2).ToString, 3) 'GranelBolsa	STRING(3)	Embalaje del grano 1=Granel 2=Bolsa)    4)    6

                sb &= Right(dr("Cosecha"), 5).Replace("/", "").PadLeft(4) 'cosecha	STRING(4)	Km 2000-2001 Ej: 0001)    7)    10


                sb &= Fecha_ddMMyyyy(iisValidSqlDate(iisNull(dr("Arribo")))) 'FecIng	STRING(8)	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001)    11)    18
                sb &= Convert.ToDateTime(iisNull(dr("Hora"), #12:00:00 AM#)).ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26

                sb &= "  "

                sb &= Fecha_ddMMyyyy(iisValidSqlDate(dr("FechaDescarga"))) 'FecSal	STRING(8)	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001)    27)    34
                sb &= Convert.ToDateTime(iisNull(dr("HoraDescarga"), #12:00:00 AM#)).ToString("hhmmss") 'HorSal	STRING(8)	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556)    35)    42


                sb &= "  "




                'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                '------------------------------------------
                'Puerto					    Destino
                'Recibidor				    WILLIAMS SA
                'Comprador				    Destinatario		
                'Corredor Comprador		    Corredor
                'Entregador				    Destinatario
                'Cargador				    (este es a quien se le facturó)
                'Vendedor				    Titular
                'Corredor Endozo		    ?
                'Comprador Endozo		    ?
                'Corredor Vendedor		    ?
                'Planta Origen			    ?
                'Procedencia 			    Origen
                'Destino 				    Destino

                Dim wily = "Williams Entregas S.A."
                Dim wilycuit = "30707386076"

                sb &= Left(dr("CadenaVacia").ToString.Replace("-", ""), 14).PadRight(14) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56
                sb &= Left(dr("Destino").ToString, 30).PadRight(30) 'NomPuerto	STRING(30)	Nombre Puerto)    57)    86

                sb &= Left(wilycuit.ToString.Replace("-", ""), 14).PadRight(14) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130

                sb &= Left(dr("DestinatarioCUIT").ToString.Replace("-", ""), 14).PadRight(14) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                sb &= Left(dr("Destinatario").ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

                sb &= Left(dr("CorredorCUIT").ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
                sb &= Left(dr("Corredor ").ToString, 30).PadRight(30) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218

                sb &= Left(dr("DestinatarioCUIT").ToString.Replace("-", ""), 14).PadRight(14) 'CUITEntregador	STRING(14)	CUIT Entregador)    219)    232
                sb &= Left(dr("Destinatario").ToString, 30).PadRight(30) 'NomEntregador	STRING(30)	Nombre Entregador)    233)    262

                sb &= Left(dr("TitularCUIT").ToString.Replace("-", ""), 14).PadRight(14) 'CUITCargador	STRING(14)	CUIT Cargador)    263)    276
                sb &= Left(dr("Titular").ToString, 30).PadRight(30) 'NomCargador 	STRING(30)	Nombre Cargador)    277)    306

                sb &= Left(dr("CadenaVacia").ToString.Replace("-", ""), 14).PadRight(14) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                sb &= Left(dr("CadenaVacia").ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350







                sb &= Left(dr("CadenaVacia").ToString, 14).PadRight(14) 'CUITCorrEndo	STRING(14)	CUIT  Corredor Endozo)    351)    364
                sb &= Left(dr("CadenaVacia").ToString, 30).PadRight(30) 'NomCorrEndo	STRING(30)	Nombre Corredor Endozo)    365)    394

                sb &= Left(dr("CadenaVacia").ToString, 14).PadRight(14) 'CUITCompEndo	STRING(14)	CUIT Comprador Endozo)    395)    408
                sb &= Left(dr("CadenaVacia").ToString, 30).PadRight(30) 'NomCompEndo	STRING(30)	Nombre Comprador Endozo)    409)    438

                sb &= Left(dr("CadenaVacia").ToString.Replace("-", ""), 14).PadRight(14) 'CUITCorrVend	STRING(14)	CUIT Corredor Vendedor.)    439)    452
                sb &= Left(dr("CadenaVacia").ToString, 30).PadRight(30) 'NomCorrVend	STRING(30)	Nombre Corredor Vendedor)    453)    482

                sb &= Left(dr("CadenaVacia").ToString, 14).PadRight(14) 'CUITPlantaOrigen	STRING(14)	CUIT Planta Origen)    483)    496
                sb &= Left(dr("CadenaVacia").ToString, 30).PadRight(30) 'NomPlantaOrigen	STRING(30)	Nombre Planta Origen)    497)    526








                sb &= Left(dr("LocalidadProcedenciaCodigoPostal").ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
                sb &= Left(dr("Procedcia.").ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
                sb &= Left(dr("LocalidadDestinoCodigoPostal").ToString, 8).PadRight(8) 'CPDestino	STRING(8)	Código Postal Destino)    565)    572
                sb &= Left(dr("Destino").ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602



                sb &= IIf(True, 1, 0).ToString.PadRight(1) 'CodMovIE	STRING(1)	Código Mov. 0=Ing 1=Egr 2=Transf.Ing 3=Transf.Egr)    603)    603
                sb &= Left(dr("Pat. Chasis").ToString, 6).PadRight(6) 'PatCha	STRING(6)	Patente chasis)    604)    609
                sb &= Left(dr("Pat. Acoplado").ToString, 6).PadRight(6) 'PatAcoplado	STRING(6)	Acoplado chasis)    610)    615




                sb &= Int(dr("Kg.Bruto Desc.")).ToString.PadLeft(10) 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                sb &= Int(dr("Kg.Tara Desc.")).ToString.PadLeft(10) 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                sb &= Int(dr("Kg.Neto Desc.")).ToString.PadLeft(10) 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                sb &= Int(dr("Otras")).ToString.PadLeft(10, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655


                sb &= Int(dr("Kg.Netos")).ToString.PadLeft(10) 'TotNeto	STRING(10)	Total neto ((Camión cargado - Tara)- Total mermas) (sin decimales))    656)    665


                sb &= String.Format("{0:F1}", dr("H.%")).PadLeft(10) 'PorHume	STRING(10)	Porcentaje humedad (un (1) decimal))    666)    675
                sb &= dr("CadenaVacia").ToString.PadLeft(10) 'PorMemaHumedad	STRING(10)	Porcentaje merma humedad (dos (2) decimales))    676)    685
                sb &= Int(dr("Mer.Kg.")).ToString.PadLeft(10) 'KgsHume	STRING(10)	Kilos humedad (sin decimales))    686)    695
                sb &= Left(dr("CadenaVacia").ToString, 10).PadLeft(10) 'PBonHume	STRING(10)	Porcentaje bonificación humedad (dos (2) decimales))    696)    705
                sb &= Left(dr("CadenaVacia").ToString, 10).PadLeft(10) 'KgsBonHu	STRING(10)	Kilos bonificación humedad)    706)    715




                'esto?
                sb &= dr("CadenaVacia").ToString.PadLeft(10) 'PorZaran	STRING(10)	Porcentaje zarandeo (dos (2) decimales))    716)    725
                sb &= Int(Val(dr("CadenaVacia"))).ToString.PadLeft(10) 'KgsZaran	STRING(10)	Kilos zarandeo (sin decimales))    726)    735
                sb &= dr("CadenaVacia").ToString.PadLeft(10) 'PorDesca	STRING(10)	Porcentaje descarte (dos (2) decimales))    736)    745
                sb &= Int(Val(dr("CadenaVacia"))).ToString.PadLeft(10) 'KgsDesca	STRING(10)	Kilogramos Descarte (Sin Decimales))    746)    755
                sb &= Left(Val(dr("CadenaVacia")).ToString, 10).PadLeft(10) 'PorVolat	STRING(10)	Porcentaje volátil (dos (2) decimales))    756)    765
                sb &= Int(Val(dr("CadenaVacia"))).ToString.PadLeft(10) 'KgsVolat	STRING(10)	Kilogramos volátil (sin decimales))    766)    775



                sb &= Left(dr("CadenaVacia").ToString, 8).PadLeft(8) 'CantBolsa	STRING(8)	Cantidad de bolsas)    776)    783
                sb &= IIf(True, 0, 1).ToString.PadRight(1) 'Fumigada	STRING(1)	Condición fumigada 0=no 1=si)    784)    784





                sb &= Int(dr("Kg.Proc.")).ToString.PadRight(10) 'PesoProcede	STRING(10)	Peso procedencia (Sin Decimales))    785)    794
                sb &= Int(dr("Kg.Bruto Proc.")).ToString.PadRight(10) 'BrutoProcede	STRING(10)	Bruto procedencia (Sin Decimales))    795)    804
                sb &= Int(dr("Kg.Tara Proc.")).ToString.PadRight(10) 'TaraProcede	STRING(10)	Tara procedencia (Sin Decimales))    805)    814


                sb &= Left(dr("Contrato").ToString, 12).PadRight(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826

                ' http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9208
                sb &= Right(dr("C.Porte").ToString, 8).PadRight(14) 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840

                sb &= IIf(True, "c", "v").ToString.PadRight(1) 'TipoTrans	STRING(1)	Tipo de transporte c=camión  v=vagón o=Otro)    841)    841



                sb &= Left(dr("NobleGrado").ToString, 10).PadRight(10) 'Grado	STRING(10)	Grado)    842)    851
                sb &= Left(dr("Factor").ToString, 10).PadRight(10) 'Factor	STRING(10)	Factor)    852)    861

                sb &= Left(dr("Cal.-Observaciones").ToString, 100).PadRight(100) 'Observac	STRING(100)	Observaciones)    862)    961


                'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)
                Dim sCalidad As String
                If InStr(dr("Calidad").ToString.ToLower, "grado 1") > 0 Then
                    sCalidad = "G1"
                ElseIf InStr(dr("Calidad").ToString.ToLower, "grado 2") > 0 Then
                    sCalidad = "G2"
                ElseIf InStr(dr("Calidad").ToString.ToLower, "grado 3") > 0 Then
                    sCalidad = "G3"
                ElseIf InStr(dr("Calidad").ToString.ToLower, "camara") > 0 Then
                    sCalidad = "CC"
                Else
                    sCalidad = "FE"
                End If
                sb &= sCalidad.PadRight(4) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



                sb &= IIf(True, 0, 1).ToString.PadRight(1) 'MovStock	STRING(1)	Señal 1=Movió mercadería)       0=No movió mercadería)    966)    966
                sb &= Left(dr("Cal.-Observaciones").ToString, 100).PadRight(100) 'ObsAna	STRING(100)	Observaciones Analisis)    967)    1066

                ' http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9208
                ForzarPrefijo5(dr("C.Porte"))

                sb &= Left(dr("C.Porte").ToString, IIf(Len(dr("C.Porte").ToString) < 8, 0, Len(dr("C.Porte").ToString) - 8)).PadRight(4) 'Prefijo	STRING(4)	Prefijo de Carta de Porte)    1067)    1070

                sb &= Left(dr("CadenaVacia").ToString, 21).PadRight(21) 'CAU	STRING(21)	CAU de Carta de Porte)    1071)    1091

                sb &= Fecha_ddMMyyyy(iisValidSqlDate(iisNull(dr("Vencim.CP"))))  'Vto	STRING(8)	Fecha Vencimiento de Carta de Porte)    1092)    1099
                sb &= Fecha_ddMMyyyy(iisValidSqlDate(iisNull(dr("FechaIngreso")))) 'Emi	STRING(8)	Fecha de Emisión de Carta de Porte)    1100)    1107

                sb &= Left(dr("CUIT Transp.").ToString, 14).PadRight(14) 'CuitTransp	STRING(14)	CUIT Transportista)    1108)    1121


                '            Aprobaron lo hecho pero dicen que en el archivo faltaba aclarar que faltan estos dos campos:
                'CUIT Chofer	STRING(14)	CUIT Chofer) 1122) 1135
                'CTG	STRING(8)	 1136) 1143

                sb &= Left(dr("CUIT Chofer").ToString, 14).PadRight(14)
                sb &= Left(dr("CTG").ToString, 8).PadRight(8)


                'sb = sb.Replace(".", ",") 'solucion cabeza por los decimales



                'For Each dc In pDataTable.Columns
                '    If Not IsDBNull(dr(i)) Then
                '        Try
                '            If IsNumeric(dr(i)) Then
                '                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            Else
                '                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                '            End If
                '        Catch x As Exception
                '            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                '        End Try
                '    Else
                '        sb &= Microsoft.VisualBasic.ControlChars.Tab
                '    End If
                '    i += 1
                'Next






                PrintLine(nF, sb)
            Next


            FileClose(nF)


            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function












        Public Shared Function Sincronismo_Bunge(ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "", Optional ByRef sErrores As String = "") As String


            'Dado que el sincronismo solicitado para el cliente BLD preveía enviar datos que ya no existen en las Cartas de Porte se solicitó el desarrollo de nuevo del mismo.
            'Ahora, con la estructura que creamos preferente pero incluyendo los datos que se enumera más abajo.
            'Documentar el detalle de la estructura para enviar a la gente de sistemas de BLD.


            'Titular Carta Porte : Nombre y CUIT
            'Intermediario: Nombre y CUIT
            'Remitente Comercial : Nombre y CUIT
            'Corredor : BLD SA ( CUIT 30-70359905-9 )
            'Representante / Entregador: WILLIAMS ENTREGAS SA ( CUIT 30-70738607-6 )
            'Destinatario: Nombre y CUIT
            'Destino : Nombre y CUIT
            'Transportista: Nombre y CUIT
            'Chofer ; Nombre y CUIT
            '            CEE(NRO)
            '            CTG(NRO)
            'Fecha de Carga
            'Fecha de Vencimiento
            '            Contrato()
            'Grano o Producto (Nombre)
            'Código de Grano o Producto
            '            Cosecha()
            'Procedencia; Nombre y CODIGO POSTAL
            'Destino de los Granos: Nombre y CODIGO POSTAL
            '            Patente(Chasis)
            '            Patente(Acoplado)
            'KM a recorrer
            '            Tarifas()
            '            Peso(Bruto(Procedencia))
            'Peso Tara ( \"\"\"\"\"\"\"\"\"\"\"\"\"\")
            'Peso Neto ( \"\"\"\"\"\"\"\"\"\"\"\"\")
            'Fecha de Descarga
            '            Peso(Bruto, (Descarga))
            '            Peso(Tara(Descarga))
            '            Peso(Bruto(Descarga))
            '% Humedad
            'Merma x Humedad
            '            Otras(Mermas)
            'Calidad ; Ej Fuera de Base / Fuera de Estandar etc….
            'Observaciones;


            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "DESCAR947" & ".dat" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow


            'Dim a = pDataTable(1)




            Dim s As String

            's &= vbCrLf & "000528055826190001010023276011030509334206Zerboni Soc Resp Ltda         00000000000                              00000000000                              30703605105Futuros Y Opcio               30711962766Gualtieri e Hijos SRL         11111111113                              11111111113                              C/VYF131   /ACK585   00000000000000000000000000000000000000029100000451100001606000029050000000000000000000000000 N 000000000000002012123000000                                                                                01000000 135024000378 023000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 0000"
            's &= vbCrLf & "000528055827190001010023276011030509334206Zerboni Soc Resp Ltda         00000000000                              00000000000                              30703605105Futuros Y Opcio               30711962766Gualtieri e Hijos SRL         11111111113                              11111111113                              C/RFL491   /RFL491   00000000000000000000000000000000000000030870000437100001292000030790000000000000000000000000 N 000000000000002012123000000                                                                                01000785 150000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 0000"
            's &= vbCrLf & "000528055828190001010023276011030509334206Zerboni Soc Resp Ltda         00000000000                              00000000000                              30703605105Futuros Y Opcio               30711962766Gualtieri e Hijos SRL         11111111113                              11111111113                              C/BUC397   /RPL598   00000000000000000000000000000000000000030680000447700001416000030610000000000000000000000000 N 000000000000002012123000000                                                                                01000673 147000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 0000"
            's &= vbCrLf & "000528153062190001010023444911030607080565LAS LAJITAS SOCIEDAD ANONIMA  00000000000                              00000000000                              30512823099E.ZENI                        30711962766Gualtieri e Hijos SRL         11111111113                              11111111113                              C/IFH456   /IFH457   00000000000000000000000000000000000000030280000452000001491000030290000000000000000000000000 N 000000000000002013010600000                                                                                01000000 120024001060 040094000606 150000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 0000"
            's &= vbCrLf & "000528165076190001010023220211030708270705Agrocereales Don Fernando S R 33708290519LUSTENI SRL                   30502874353AGD                           30512823099E.ZENI                        30711962766Gualtieri e Hijos SRL         11111111113                              11111111113                              C/VIH564   /TQA123   00000000000000000000000000000000000000031360000441300001276000031370000000000000000000000000 N 000000000000002013010700000                                                                                01000000 130024000282 019000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 0000"
            's &= vbCrLf & "000528253061190001010023243611030540807570Miguel Gazzoni E Hijos        00000000000                              00000000000                              30539976091Bertotto Bruera               30711962766Gualtieri e Hijos SRL         11111111113                              11111111113                              C/EBM188   /EBM188   00000000000000000000000000000000000000029980000450200001563000029390000000000000000000000000 N 000000000000002013011400000                                                                                01000000 120000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 0000"
            's &= vbCrLf & "000528274238190001010023306411030708201673Maximiliano Thea Y Federico Ma00000000000                              00000000000                              30506732499Alabern Fabrega               30711962766Gualtieri e Hijos SRL         11111111113                              11111111113                              C/VWU646   /EBN901   00000000000000000000000000000000000000029300000447900001601000028780000000000000000000000000 N 000000000000002013011500000                                                                                01000000 120000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 0000"
            's &= vbCrLf & "000528348071190001010023662811023076556229BECCARIA RAUL HORACIO         30710674570Agronegocios Jewell           30552587827CAG                           30663290262Intagro                       30711962766Gualtieri e Hijos SRL         11111111113                              11111111113                              C/HIY452   /HIY450   00000000000000000000000000000000000000030470000452600001484000030420000000000000000000000000 N 000000000000002023011900000                                                                                01000000 120000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 0000"
            's &= vbCrLf & "000528383994190001010023270511030708613289ESTABLECIMIENTO LOS ROBLES S A00000000000                              00000000000                              30652327474Canzani Casas                 30711962766Gualtieri e Hijos SRL         11111111113                              11111111113                              C/UXF585   /TFC274   00000000000000000000000000000000000000030120000423200001251000029810000000000000000000000000 N 000000000000002013012100000                                                                                01000000 123000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 0000"
            's &= vbCrLf & "000528425858190001010023218311030543487348Acopio Arequito               30708777079G Y T Plus                    30552587827CAG                           30703605105Futuros Y Opcio               30711962766Gualtieri e Hijos SRL         11111111113                              11111111113                              C/GDD308   /JPB073   00000000000000000000000000000000000000030640000451600001444000030720000000000000000000000000 N 000000000000002013012600000                                                                                01000000 120000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 0000"
            's &= vbCrLf & "000528447859190001010023653011030537721274Tomas Hnos                    00000000000                              00000000000                              30528981700Granar                        30711962766Gualtieri e Hijos SRL         11111111113                              11111111113                              C/TSC051   /UOC851   00000000000000000000000000000000000000030960000439100001306000030850000000000000000000000000 N 000000000000002013011600000                                                                                01000000 135000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 0000"
            's &= vbCrLf & "000528447863190001010023653011030537721274Tomas Hnos                    00000000000                              00000000000                              30528981700Granar                        30711962766Gualtieri e Hijos SRL         11111111113                              11111111113                              C/EKD254   /EEK174   00000000000000000000000000000000000000029640000446300001491000029720000000000000000000000000 N 000000000000002013011600000                                                                                01000000 120000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 000000000000 0000"
            'PrintLine(nF, s)




            Dim sErroresProcedencia, sErroresDestinos As String



            'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                With cdp

                    i = 0 : sb = ""

                    Dim cero = 0













                    '                    Grano	Texto	1	3	Falta Dato
                    'GranelBolsa	Entero largo	4	3	
                    'Cosecha	Entero largo	7	4	Esta todo en 0 - Falta Dato
                    'FecIng	Fecha/Hora	11	8	No respeta formato DDMMAAAA
                    'HorIng	Texto	19	8	
                    'FechSal	Fecha/Hora	27	8	No respeta formato DDMMAAAA
                    'HorSal	Texto	35	8	
                    'CUITPuerto	Texto	43	14	Falta Dato
                    'NomPuerto	Texto	57	30	No respeta largo dato


                    ForzarPrefijo5(.NumeroCartaDePorte)
                    sb &= IIf(.NumeroCartaDePorte.ToString.Length > 8, Left(.NumeroCartaDePorte.ToString, 1), "0000").Padleft(4, "0")
                    sb &= JustificadoIzquierda(Right(.NumeroCartaDePorte, 8), 8)

                    'sb &= .txtCodigoZeni.PadLeft(3) 'Grano	STRING(3)	Código de grano Sagpya)    1)    3
                    'sb &= IIf(True, 1, 2).ToString.PadRight(3) 'GranelBolsa	STRING(3)	Embalaje del grano 1=Granel 2=Bolsa)    4)    6
                    'sb &= Right(.Cosecha, 5).Replace("/", "").PadLeft(4)


                    'If .IsFechaArriboNull Then .FechaArribo = Nothing
                    'sb &= .FechaArribo.ToString("ddMMyyyy")       'FecIng	STRING(8)	Fecha de entrada del camión Formato (DDMMYYYY) ej: 01052001)    11)    18


                    'If .IsHoraNull Then
                    '    sb &= #12:00:00 AM#.ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    'Else
                    '    sb &= Convert.ToDateTime(.Hora).ToString("hhmmss")  'HorIng	STRING(8)	Hora de entrada del camión Formato (HHMISS) ej:092556)    19)    26
                    'End If


                    If .IsFechaDescargaNull Then .FechaDescarga = Nothing
                    sb &= .FechaDescarga.ToString("yyyyMMdd")  'FecSal	STRING(8)	Fecha de salida o Descarga del camión Formato(DDMMYYYY) ej:01052001)    27)    34
                    'sb &= Convert.ToDateTime(iisNull(.FechaDescarga, #12:00:00 AM#)).ToString("hhmmss") 'HorSal	STRING(8)	Hora de salida o Descarga del camión  Formato (HHMISS) ej:092556)    35)    42



                    sb &= JustificadoDerecha(.CodigoSAJPYA, 4).Replace(" ", "0")  'Código de producto según el ONCCA	NUMERICO	 4 	codigo  21= ARROZ CASCARA    sino VER TABLA1


                    sb &= JustificadoIzquierda(.ProcedenciaCodigoPostal, 4) 'Código Postal de Localidad de Origen	NUMERICO	 4 	Codigos Postal de procedencia o destino de la merc. (Según TABLA ENCOTEL) 
                    If Val(.ProcedenciaCodigoPostal) = 0 And InStr(sErroresProcedencia, .Procedencia.ToString) = 0 Then
                        'si no tiene codigo ni está ya en sErrores, lo meto

                        ErrHandler.WriteError("La localidad " & .ProcedenciaDesc & " es usada en el sincro  y no tiene codigo postal")

                        sErroresProcedencia &= "<a href=""Localidades.aspx?Id=" & .Procedencia & """ target=""_blank"">" & .ProcedenciaDesc & "</a>; "
                    End If


                    '* Cuando Bunge está como Remitente Comercial, el campo Operación (código) debe ir con código 120, en cualquier otro caso 110.
                    Dim operacionMovimiento As String = "110"
                    If .RComercialDesc.ToUpper.Contains("BUNGE") Or .IntermediarioDesc.ToUpper.Contains("BUNGE") Then
                        operacionMovimiento = "220"

                    End If
                    sb &= JustificadoIzquierda(operacionMovimiento, 3)  'Código de Movimiento según Bunge	NUMERICO	 3 	codigo 110 = recepcion por compra   sino VER TABLA2 

                    ' http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10181
                    'En el mes de mayo habían pedido enviar el numero de contrato como 110 cuando Bunge aparecía como Destinatario (Ingreso) y 220 cuando Bunge aparece como Remitente Comercial (Egreso).
                    'Solicitan que en el caso que Bunge aparezca como Intermediario, también lo consideremos un Egreso y lo mandemos con codigo 220.





                    'Sincro Tecnocampo          ABM ProntoWeb (o CDP física)
                    '------------------------------------------
                    'Puerto					    Destino
                    'Recibidor				    WILLIAMS SA
                    'Comprador				    Destinatario		
                    'Corredor Comprador		    Corredor
                    'Entregador				    Destinatario
                    'Cargador				    (este es a quien se le facturó)
                    'Vendedor				    Titular
                    'Corredor Endozo		    ?
                    'Comprador Endozo		    ?
                    'Corredor Vendedor		    ?
                    'Planta Origen			    ?
                    'Procedencia 			    Origen
                    'Destino 				    Destino

                    Dim wily = "Williams Entregas S.A."
                    Dim wilycuit = "30707386076"
                    Dim cadenavacia As String = ""




                    'sb &= Left(cadenavacia.ToString.Replace("-", ""), 11).PadRight(11) 'CUITPuerto	STRING(14)	CUIT PUERTO)    43)    56
                    'sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPuerto	STRING(30)	Nombre Puerto)    57)    86




                    '                    Orden(Clientes)
                    'Si vienen Cargador + Vendedor + C/Orden1 (también si vienen Cargador + Vendedor):
                    'CARGADOR -> TITULAR 
                    'VENDEDOR -> REMITENTE
                    'C/ ORDEN 1 -> INTERMEDIARIO

                    'Si solo hay Vendedor:
                    'VENDEDOR -> TITULAR

                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10145
                    Dim VendedorCUIT, VendedorDesc As String
                    ' If InStr(.RComercialDesc, "AMAGGI") > 0 Then Stop

                    If .RComercialDesc <> "" And InStr(.RComercialDesc, "BUNGE") = 0 Then
                        VendedorCUIT = .RComercialCUIT
                        VendedorDesc = .RComercialDesc
                    ElseIf .IntermediarioDesc <> "" Then
                        VendedorCUIT = .IntermediarioCUIT
                        VendedorDesc = .IntermediarioDesc
                    Else
                        VendedorCUIT = .TitularCUIT
                        VendedorDesc = .TitularDesc
                    End If




                    sb &= Left(VendedorCUIT.ToString.Replace("-", ""), 11).PadRight(11) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                    sb &= Left(VendedorDesc.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350

                    sb &= Left(.RComercialCUIT.ToString.Replace("-", ""), 11).PadRight(11) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                    sb &= Left(.RComercialDesc.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350


                    sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 11).PadRight(11) 'CUITVendedor	STRING(14)	CUIT Vendedor)    307)    320
                    sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30) 'NomVendedor	STRING(30)	Nombre Vendedor)    321)    350
                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////
                    '///////////////////////////////////////////////////


                    '///////////////////////////////////////////////////
                    ' acá va BLD S.A.                      30707386076
                    sb &= Left(.CorredorCUIT.ToString.Replace("-", ""), 11).PadRight(11) 'CUITCorrComp	STRING(14)	CUIT Corredor Comprador)    175)    188
                    sb &= Left(.CorredorDesc.ToString, 30).PadRight(30) 'NomCorrComp	STRING(30)	Nombre Corredor Comprador)    189)    218
                    '////////////////////////////////////////////////////


                    'sb &= Left(.DestinatarioCUIT.ToString.Replace("-", ""), 11).PadRight(11) 'CUITComprador	STRING(14)	CUIT Comprador)    131)    144
                    'sb &= Left(.DestinatarioDesc.ToString, 30).PadRight(30) 'NomComp	STRING(30)	Nombre Comprador)    145)    174

                    sb &= Left(wilycuit.ToString.Replace("-", ""), 11).PadRight(11) 'CUITRecibidor	STRING(14)	CUIT Recibidor)    87)    100
                    sb &= Left(wily.ToString, 30).PadRight(30) 'NomRecibidor	STRING(30)	Nombre Recibidor)    101)    130



                    If .IsTransportistaCUITNull Then .TransportistaCUIT = ""
                    sb &= Left(.TransportistaCUIT.ToString.Replace("-", ""), 11).PadRight(11) 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118
                    sb &= Left(.TransportistaDesc.ToString, 30).Replace("-", "").PadRight(30) 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118

                    If .IschoferCUITNull Then .choferCUIT = ""
                    sb &= Left(.choferCUIT.ToString.Replace("-", ""), 11).PadRight(11) 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118
                    sb &= Left(.ChoferDesc.ToString, 30).Replace("-", "").PadRight(30) 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118




                    '////////////////////////////////////////////////////////////////////////////////
                    'Strongly Typed DataSets encountering NULL values – Grrrrrr… 
                    'http://social.msdn.microsoft.com/forums/en-US/winformsdatacontrols/thread/1dad8d0d-6eae-4254-a9d6-22d50da5578a
                    '////////////////////////////////////////////////////////////////////////////////

                    'If .IsClienteFacturadoCUITNull Then .ClienteFacturadoCUIT = ""
                    'sb &= Left(.ClienteFacturadoCUIT.ToString.Replace("-", ""), 11).PadRight(11) 'CUITCargador	STRING(14)	CUIT Cargador)    263)    276
                    'If .IsClienteFacturadoNull Then .ClienteFacturado = ""
                    'sb &= Left(.ClienteFacturado.ToString, 30).PadRight(30) 'NomCargador 	STRING(30)	Nombre Cargador)    277)    306




                    'NomEntregador()                    'Williams(Entregas)
                    ' NomCorrComp()                    'BLD()
                    ' NomComprador()                    ' Destinatario()
                    'NomVendedor()                    'Acá va el Rte Comercial, si no hay RteCom va el Titular
                    'NomCorrEndo()                    'No se manda
                    'NomCompEndo()                    'No se manda
                    'NomCorrVend()                    'No se manda




                    'sb &= Left(.IntermediarioCUIT.ToString.Replace("-", ""), 11).PadRight(11) 'CUITCorrEndo	STRING(14)	CUIT  Corredor Endozo)    351)    364
                    'sb &= Left(.IntermediarioDesc.ToString, 30).PadRight(30) 'NomCorrEndo	STRING(30)	Nombre Corredor Endozo)    365)    394


                    'sb &= Left(.RComercialCUIT.ToString, 11).PadRight(11) 'CUITCompEndo	STRING(14)	CUIT Comprador Endozo)    395)    408
                    'sb &= Left(.RComercialDesc.ToString, 30).PadRight(30) 'NomCompEndo	STRING(30)	Nombre Comprador Endozo)    409)    438




                    'Titular Carta Porte : Nombre y CUIT
                    'Intermediario: Nombre y CUIT
                    'Remitente Comercial : Nombre y CUIT
                    'Corredor : BLD SA ( CUIT 30-70359905-9 )
                    'Representante / Entregador: WILLIAMS ENTREGAS SA ( CUIT 30-70738607-6 )
                    'Destinatario: Nombre y CUIT




                    'sb &= Left(cadenavacia.ToString.Replace("-", ""), 11).PadRight(11) 'CUITCorrVend	STRING(14)	CUIT Corredor Vendedor.)    439)    452
                    'sb &= Left(cadenavacia.ToString, 30).PadRight(30) 'NomCorrVend	STRING(30)	Nombre Corredor Vendedor)    453)    482

                    'sb &= Left(cadenavacia.ToString, 11).PadRight(11) 'CUITPlantaOrigen	STRING(14)	CUIT Planta Origen)    483)    496
                    'sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomPlantaOrigen	STRING(30)	Nombre Planta Origen)    497)    526





                    'CPProcede	Texto	527	8	Falta Dato
                    'NomProcede	Texto	535	30	Falta Dato
                    'CPDestino	Texto	565	8	
                    'NomDestino	Texto	573	30	
                    'CodMovIE	Texto	603	1	


                    'sb &= Left(.ProcedenciaCodigoPostal.ToString, 8).PadRight(8) 'CPPorcede 	STRING(8)	Código Postal Procedencia)    527)    534
                    'sb &= Left(.ProcedenciaDesc.ToString, 30).PadRight(30) 'NomProcede	STRING(30)	Nombre Procedencia)    535)    564
                    'sb &= Left(.DestinoCodigoPostal.ToString, 8).PadRight(8) 'CPDestino	STRING(8)	Código Postal Destino)    565)    572
                    'sb &= Left(.DestinoDesc.ToString, 30).PadRight(30) 'NomDestino	STRING(30)	Nombre Destino)    573)    602







                    '22	Letra Patente Chasis 	ALFANUMERICO	 1 	Si es patente vieja Letra de la pcia y si es nueva "/" - Si es vagon poner espacios
                    '23	Patente del Chasis 	ALFANUMERICO	 9 	Patente vieja numero justificado a la derecha y completar con 0 a la izq. Pte. nueva XXX999bbb (MAYUSCULAS)
                    '24	Letra Patente Acoplado	ALFANUMERICO	 1 	Si es patente vieja Letra de la pcia y si es nueva "/" - Si es vagon poner espacios
                    '25	Patente del Acoplado 	ALFANUMERICO	 9 	Patente vieja numero justificado a la derecha y completar con 0 a la izq. Pte. nueva XXX999bbb (MAYUSCULAS)


                    sb &= "C"

                    sb &= "/"
                    sb &= Left(.Patente.ToString, 9).PadRight(9, " ")
                    sb &= "/"
                    sb &= Left(.Acoplado.ToString, 9).PadRight(9, " ")


                    '26	Numero de Vagon o de Barcaza	NUMERICO	 10 	Completar solo si el medio de transporte es Vagon o Barcaza -  Si es camion poner en 0
                    '27	Nombre Operativo o Nombre del Convoy	ALFANUMERICO	 10 	Completar solo si el medio de transporte es Vagon o Barcaza - Si es camion poner en 0
                    '28	Kilos Origen   BRUTO	NUMERICO	 8 	
                    '29	Kilos Origen   TARA	NUMERICO	 8 	
                    '30	Kilos Origen   NETO	NUMERICO	 8 	NETO ORIGEN=BRUTO-TARA
                    '31	Kilos Pesó  BRUTO	NUMERICO	 8 	
                    '32	Kilos Pesó  TARA	NUMERICO	 8 	 
                    '33	Kilos Pesó  NETO	NUMERICO	 8 	NETO=BRUTO-TARA
                    '34	Kilos Merma por Servicios (Secada-Zaranda)	NUMERICO	 8 	Solo en caso que se efectuen en kilos en la balanza
                    '35	Kilos Merma por Volatil	NUMERICO	 8 	Solo en caso que se efectuen en kilos en la balanza
                    '36	Kilos Merma por Otros conceptos	NUMERICO	 8 	Solo en caso que se efectuen en kilos en la balanza
                    '37	Fumiga	ALFANUMERICO	 1 	Si hay fumigada debe traer una S



                    sb &= JustificadoIzquierda(.SubnumeroVagon, 10)  ' '26	Numero de Vagon o de Barcaza	NUMERICO	 10 	Completar solo si el medio de transporte es Vagon o Barcaza -  Si es camion poner en 0
                    sb &= JustificadoIzquierda("", 10).Replace(" ", "0")  '27	Nombre Operativo o Nombre del Convoy	ALFANUMERICO	 10 	Completar solo si el medio de transporte es Vagon o Barcaza - Si es camion poner en 0


                    sb &= Int(.BrutoPto).ToString.PadLeft(8, "0") 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645
                    sb &= Int(.TaraPto).ToString.PadLeft(8, "0") 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= Int(.NetoPto).ToString.PadLeft(8, "0") 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625



                    sb &= Int(.BrutoFinal).ToString.PadLeft(8, "0") 'PesoBrut	STRING(10)	Bruto Ingreso ( Peso del camión cargado (TARA + MERCADERÍA)) Sin.Dec.)    616)    625
                    sb &= Int(.TaraFinal).ToString.PadLeft(8, "0") 'PesoEgre	STRING(10)	Peso de egreso (Peso del camión vacío (TARA)) Sin Decimales)    626)    635
                    sb &= Int(.NetoFinal).ToString.PadLeft(8, "0") 'PesoNeto	STRING(10)	Total bruto(PesoBrut-PesoEgre) (sin decimales))    636)    645

                    sb &= Int(.NetoFinal - .NetoProc).ToString.PadLeft(8, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655


                    'sb &= Int(.Merma).ToString.PadLeft(8, "0") 'TotMerm	STRING(10)	Total mermas (Total mermas sin decimales))    646)    655
                    'sb &= String.Format("{0:F1}", .Humedad).PadLeft(10) 'PorHume	STRING(10)	Porcentaje humedad (un (1) decimal))    666)    675
                    sb &= JustificadoIzquierda("", 8).Replace(" ", "0")
                    sb &= JustificadoIzquierda("", 8).Replace(" ", "0")

                    sb &= " "


                    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '38	Conformidad	ALFANUMERICO	 1 	S=Mercadería conforme  N=Mercadería condicional   C=Cámara
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10145
                    'CALIDAD:
                    'Debe ser Conforme si solo tiene Humedad
                    'Debe ser Fuera de Base o Condiciona, cuando tiene revolcado, cuerpo extraño, etc (quizas tambien tiene humedad)
                    Dim cal As String
                    Select Case .NobleConforme
                        Case ""
                            cal = "S"
                        Case "sss"
                            cal = "N"
                        Case Else
                            cal = "C"

                    End Select

                    cal = "S"   'S=Mercadería conforme

                    If .NobleAmohosados > 0 Or .NobleAmohosados > 0 Or .NobleExtranos > 0 Or .NobleCarbon > 0 Or .NobleAmohosados > 0 Or .NobleAmohosados > 0 Or _
                         .NobleACamara > 0 Or .NobleAcidezGrasa > 0 Or .NobleAmohosados > 0 Or .NobleCarbon > 0 Or .NoblePicados > 0 Or _
                         .NobleExtranos > 0 Or .NobleQuebrados > 0 Or .NobleAmohosados > 0 Or .NobleCarbon > 0 Or .NobleCarbon > 0 Or _
                         .NobleVerdes > 0 Or .NobleAcidezGrasa > 0 Or .NobleAmohosados > 0 Or .NobleCarbon > 0 Or .NobleCarbon > 0 Or _
                         .CalidadDescuentoFinal > 0 Or .NobleObjetables > 0 Or .CalidadPuntaSombreada > 0 Or .CalidadTierra > 0 Or .NobleDaniados > 0 Then

                        cal = "N" 'N=Mercadería condicional

                    End If

                    If .NobleACamara Then
                        cal = "C"  'C=Cámara
                    End If


                    sb &= JustificadoIzquierda(cal, 1)   '38	Conformidad	ALFANUMERICO	 1 	S=Mercadería conforme  N=Mercadería condicional   C=Cámara


                    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                    '39	Codigo de la Cámara	ALFANUMERICO	 1 	campo 38=C(camara)Completar: P=Paraná S=StaFe R=Rosario N=Bs As  T=Calidad Total B=B.BlancaX=Córdoba
                    '40	Número de CEE	NUMERICO	 14 	 
                    '41	Fecha vencimiento CEE	NUMERICO	 8 	Fecha vencimiento (aaaammdd)
                    '42	Código Postal del Cliente	NUMERICO	 4 	Código Postal del domicilio del cliente 
                    '43	Grado	NUMERICO	 1 	 
                    '44	Observaciones	ALFANUMERICO	 80 	 


                    sb &= JustificadoIzquierda(" ", 1) '39	Codigo de la Cámara	ALFANUMERICO	 1 	campo 38=C(camara)Completar: P=Paraná S=StaFe R=Rosario N=Bs As  T=Calidad Total B=B.BlancaX=Córdoba
                    sb &= JustificadoIzquierda(.CEE, 14)  '40	Número de CEE	NUMERICO	 14 	 

                    If .IsFechaVencimientoNull Then .FechaVencimiento = Nothing
                    sb &= JustificadoIzquierda(.FechaVencimiento.ToString("yyyyMMdd"), 8)

                    sb &= JustificadoIzquierda("", 4) '42	Código Postal del Cliente	NUMERICO	 4 	Código Postal del domicilio del cliente 
                    sb &= JustificadoIzquierda("", 1)






                    'esto?
                    'sb &= cadenavacia.ToString.PadLeft(10) 'PorZaran	STRING(10)	Porcentaje zarandeo (dos (2) decimales))    716)    725
                    'sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsZaran	STRING(10)	Kilos zarandeo (sin decimales))    726)    735
                    'sb &= cadenavacia.ToString.PadLeft(10) 'PorDesca	STRING(10)	Porcentaje descarte (dos (2) decimales))    736)    745
                    'sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsDesca	STRING(10)	Kilogramos Descarte (Sin Decimales))    746)    755
                    'sb &= Left(Val(cadenavacia).ToString, 10).PadLeft(10) 'PorVolat	STRING(10)	Porcentaje volátil (dos (2) decimales))    756)    765
                    'sb &= Int(Val(cadenavacia)).ToString.PadLeft(10) 'KgsVolat	STRING(10)	Kilogramos volátil (sin decimales))    766)    775





                    'sb &= Left(.Contrato.ToString, 12).PadRight(12) 'Contrato	STRING(12)	Número de contrato  (Numeros 0 al 9))    815)    826
                    'sb &= Left(.NumeroCartaDePorte.ToString, 11).PadRight(11) 'CarPorte	STRING(14)	Número de Carta de Porte)    827)    840
                    'sb &= IIf(True, "c", "v").ToString.PadRight(1) 'TipoTrans	STRING(1)	Tipo de transporte c=camión  v=vagón o=Otro)    841)    841


                    'sb &= Left(Int(.NobleGrado).ToString, 10).PadLeft(10) 'Grado	STRING(10)	Grado)    842)    851
                    'sb &= Left(Int(.Factor).ToString, 10).PadLeft(10) 'Factor	STRING(10)	Factor)    852)    861


                    sb &= JustificadoIzquierda(.Observaciones, 80)  '


                    'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)
                    'Dim sCalidad As String
                    'If InStr(.Calidad.ToString.ToLower, "grado 1") > 0 Then
                    '    sCalidad = "G1"
                    'ElseIf InStr(.Calidad.ToString.ToLower, "grado 2") > 0 Then
                    '    sCalidad = "G2"
                    'ElseIf InStr(.Calidad.ToString.ToLower, "grado 3") > 0 Then
                    '    sCalidad = "G3"
                    'ElseIf InStr(.Calidad.ToString.ToLower, "camara") > 0 Then
                    '    sCalidad = "CC"
                    'Else
                    '    sCalidad = "FE"
                    'End If
                    'sb &= sCalidad.PadRight(4) 'ConCalidad	STRING(4)	Condición Calidad Grado(G1,G2 o G3), Camara(CC) o Fuera de standart (FE)



                    'sb &= IIf(True, 0, 1).ToString.PadRight(1) 'MovStock	STRING(1)	Señal 1=Movió mercadería)       0=No movió mercadería)    966)    966
                    'sb &= Left(.Observaciones.ToString, 100).PadRight(100) 'ObsAna	STRING(100)	Observaciones Analisis)    967)    1066


                    'sb &= Left(.NumeroCartaDePorte.ToString, 4).PadRight(4) 'Prefijo	STRING(4)	Prefijo de Carta de Porte)    1067)    1070
                    'sb &= Left(.CEE.ToString, 21).PadRight(21) 'CAU	STRING(21)	CAU de Carta de Porte)    1071)    1091

                    'If .IsFechaVencimientoNull Then .FechaVencimiento = Nothing
                    'sb &= .FechaVencimiento.ToString("ddMMyyyy")                        '  Vto	STRING(8)	Fecha Vencimiento de Carta de Porte)    1092)    1099
                    'If .IsFechaArriboNull Then .FechaArribo = Nothing
                    'sb &= .FechaArribo.ToString("ddMMyyyy")     'Emi	STRING(8)	Fecha de Emisión de Carta de Porte)    1100)    1107

                    'If .IsTransportistaCUITNull Then .TransportistaCUIT = ""
                    'sb &= Left(.TransportistaCUIT.ToString, 14).Replace("-", "").PadRight(14) 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118

                    'If .IschoferCUITNull Then .choferCUIT = ""
                    'sb &= Left(.choferCUIT.ToString, 14).Replace("-", "").PadRight(14) 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118

                    'sb &= Left(.CTG.ToString, 10).PadRight(10, "0") 'CuitTransp	STRING(11)	CUIT Transportista)    1108)    1118





                    sb &= RubroBunge(eRubroBunge.Humedad, .HumedadDesnormalizada, .Humedad)


                    For i = 2 To 10
                        '45	Item-Código del Rubro (1)	NUMERICO	 2 	VER TABLA3
                        '46	Item-Kilos de merma según el rubro referido (1)	NUMERICO	 6 	Kilos de merma para el rubro 
                        '47	Item-Si el rubro referido fue a Cámara (1)	ALFANUMERICO	 1 	C= Cuando el rubro fue a cámara   - 
                        '48	Item-Resultado del analisis hecho en la planta (1)	NUMERICO	 4 	Porcentaje del analisis del rubro  ( 2 enteros y 2 decimales)
                        sb &= JustificadoIzquierda(IIf(i = 1, "01", "00"), 2)
                        sb &= JustificadoIzquierda("", 6).Replace(" ", "0")
                        sb &= " " 'C= Cuando el rubro fue a cámara   - 
                        sb &= JustificadoIzquierda("", 4).Replace(" ", "0")
                    Next


                    ' sb &= JustificadoIzquierda(.EspecieONCAA, 6)  '
                    ' sb &= JustificadoIzquierda(.EspecieONCAA, 8)


                    sb &= JustificadoDerecha("000000", 6) '   85	CANTIDAD DE BULTOS O CAJAS - NUMERICO	 6 *
                    sb &= JustificadoDerecha(Val(.Contrato), 8, "0") ' 86	CONTRATO DE VENTA DE BUNGE - NUMERICO	 8 **








                    PrintLine(nF, sb)
                End With
            Next

            'Try
            '    Sincronismo_BungeCalidades("", pDataTable)
            'Catch ex As Exception

            'End Try

            FileClose(nF)

            sErrores = "Procedencias sin código postal:<br/> " & sErroresProcedencia ' & "<br/>Destinos sin código LosGrobo: <br/>" & sErroresDestinos


            If sErroresProcedencia <> "" Or sErroresDestinos <> "" Then vFileName = "" 'si hay errores, no devuelvo el archivo así no hay problema del updatepanel con el response.write




            Return vFileName
            'Return TextToExcel(vFileName, titulo)
        End Function

        Public Enum eRubroBunge
            Humedad = 1
        End Enum

        Public Shared Function RubroBunge(e As eRubroBunge, merma As Integer, porcentaje As Double) As String
            Dim sb As String
            '45	Item-Código del Rubro (1)	NUMERICO	 2 	VER TABLA3
            '46	Item-Kilos de merma según el rubro referido (1)	NUMERICO	 6 	Kilos de merma para el rubro 
            '47	Item-Si el rubro referido fue a Cámara (1)	ALFANUMERICO	 1 	C= Cuando el rubro fue a cámara   - 
            '48	Item-Resultado del analisis hecho en la planta (1)	NUMERICO	 4 	Porcentaje del analisis del rubro  ( 2 enteros y 2 decimales)

            sb &= JustificadoDerecha(Val(e).ToString, 2).Replace(" ", "0")
            sb &= JustificadoDerecha(merma.ToString, 6).Replace(" ", "0")
            sb &= " " 'C= Cuando el rubro fue a cámara   - 
            sb &= LeftMasPadLeft(porcentaje.ToString("00.00", System.Globalization.CultureInfo.InvariantCulture), 5).Replace(".", "")
            Return sb
        End Function


        Public Shared Function Sincronismo_BungeCalidades(ByVal SC As String, ByVal pDataTable As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoDataTable, Optional ByVal titulo As String = "", Optional ByVal sWHERE As String = "") As String


            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10145
            'CALIDAD:
            'Debe ser Conforme si solo tiene Humedad
            'Debe ser Fuera de Base o Condiciona, cuando tiene revolcado, cuerpo extraño, etc (quizas tambien tiene humedad)

            '            Nombre(RESULTA.TXT)
            '            Tipo(ASCII)
            'Longitud de registro	71

            'Descripción del registro

            'Nombre	             Longitud      Desde    Hasta	Tipo de Dato
            'Fecha	de descarga		6	1	6	N	ddmmaa
            'Carta de porte			11	7	17	N	
            'Número de resultado		2	18	19	N
            'Código de ensayo		5	20	24	N
            'Resultado del ensayo		7	25	31	N
            'Kilos  				7	32	38	N
            'Cereal 				2	39	40	N
            'Número de Vagón		8	41	48	N
            'Importe de honorarios		9	49	57	N
            'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja
            'Total de bonificación o rebaja	5	59	63	N	
            'Fuera de standard		1	64	64	A	S-Si	N-No
            'Número de certificado		7	65	71	N	





            'Número de resultado 2 18 19 N Número de certificado 7 65 71 N Con estos datos agreguen un nro correlativo y único, que identifique al análisis y listo, puede ser una numeración interna de Uds. respetando siempre las longitudes de datos del diseño. 
            'Importe de honorarios 9 49 57 N Envíen 0 en los honorarios sino es de la operatoria de Williams. Los honorarios son de la cámara porque la misma cobra por cada análisis. 
            'Bonifica o Rebaja 1 58 58 A B-Bonifica R-Rebaja Esto es clave, por ejemplo el ítems de “Materias extrañas”, bonifica o rebaja, por ejemplo el valor 1.5 cargado en este ítems es Bonifica o Rebaja?. 
            'Total de bonificación o rebaja 5 59 63 N Envíen 0 
            'Fuera de standard 1 64 64 A S-Si N-No Esto es si una calidad mala es S, esto significa que no sirve la calidad. Normalmente viene en N Saludos.-"



            'Dim vFileName As String = Path.GetTempFileName() & ".txt"
            Dim vFileName As String = Path.GetTempPath & "SincroBLDCalidades " & Now.ToString("ddMMMyyyy_HHmmss") & ".csv" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()

            FileOpen(nF, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            'PrintLine(nF, sb) 'encabezado
            Dim i As Integer = 0
            Dim dr As DataRow



            Dim id_trigocandeal = BuscaIdArticuloPreciso("TRIGO CANDEAL", SC) 'pan y forrajero
            Dim id_trigopan = BuscaIdArticuloPreciso("TRIGO PAN", SC) 'pan y forrajero
            Dim id_trigoforraj = BuscaIdArticuloPreciso("TRIGO FORRAJERO", SC) 'pan y forrajero

            Dim id_soja = BuscaIdArticuloPreciso("SOJA", SC)
            Dim id_sorgo = BuscaIdArticuloPreciso("SORGO GRANIFERO", SC)
            Dim id_maiz = BuscaIdArticuloPreciso("MAIZ", SC)
            Dim id_girasol = BuscaIdArticuloPreciso("GIRASOL", SC)


            Using db As New LinqCartasPorteDataContext(Encriptar(SC))
                Dim cartas '= db.CartasDePortes.Where(sWHERE)


                PrintLine(nF, "CartaPorte;IdRubro;DRubro;DescuentoFinal;ResFinal;")

                'http://msdn.microsoft.com/en-us/magazine/cc163877.aspx
                For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In pDataTable.Select(sWHERE)
                    'For Each cdp In cartas
                    With cdp

                        i = 0 : sb = ""

                        Dim cero = 0




                        'Nombre	             Longitud      Desde    Hasta	Tipo de Dato
                        'Fecha	de descarga		6	1	6	N	ddmmaa
                        'Carta de porte			11	7	17	N	
                        'Número de resultado		2	18	19	N
                        'Código de ensayo		5	20	24	N
                        'Resultado del ensayo		7	25	31	N
                        'Kilos  				7	32	38	N
                        'Cereal 				2	39	40	N
                        'Número de Vagón		8	41	48	N
                        'Importe de honorarios		9	49	57	N
                        'Bonifica o Rebaja		1	58	58	A	B-Bonifica	R-Rebaja
                        'Total de bonificación o rebaja	5	59	63	N	
                        'Fuera de standard		1	64	64	A	S-Si	N-No
                        'Número de certificado		7	65	71	N	

                        '                                               Nombre	              Lon  Desde Hasta	Tipo de Dato





                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////
                        'consulta AMAGGI
                        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7963
                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////////////////////////////

                        If .IsFueraDeEstandarNull Then .FueraDeEstandar = 0
                        If .IsCalidadMermaChamicoNull Then
                            .CalidadMermaChamico = 0
                            .CalidadMermaChamicoBonifica_o_Rebaja = 0
                        Else
                            'Stop
                        End If
                        If .IsCalidadMermaZarandeoNull Then
                            .CalidadMermaZarandeo = 0
                            .CalidadMermaZarandeoBonifica_o_Rebaja = 0
                        End If
                        If .IsCalidadGranosQuemadosNull Then
                            .CalidadGranosQuemados = 0
                            .CalidadGranosQuemadosBonifica_o_Rebaja = 0
                        End If
                        If .IsCalidadTierraNull Then
                            .CalidadTierra = 0
                            .CalidadTierraBonifica_o_Rebaja = 0
                        End If

                        If .IsCalidadPuntaSombreadaNull Then
                            .CalidadPuntaSombreada = 0
                            '.CalidadTierraBonifica_o_Rebaja = 0
                        End If





                        'dependiendo del cruce Calidad + Articulo, tenes el IdRubro de BLD

                        If Not .IsCalidadDescuentoFinalNull Then
                            If .CalidadDescuentoFinal > 0 Then sb = RenglonBLDCalidad(cdp, 0, .CalidadDescuentoFinal, "", 0, nF, "01", "DescuentoFinal")
                        End If



                        If .IdArticulo = id_trigocandeal Or .IdArticulo = id_trigopan Or .IdArticulo = id_trigoforraj Then


                            '39	2	Olores Comerciales Objetables	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 39, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")

                            '40	2	Punta Sombreada	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 40, .CalidadPuntaSombreada, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "PuntaSombreada")

                            '41	2	Revolcado en Tierra	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 41, .CalidadTierra, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Tierra")

                            '42	2	Punta Negra por Carbón	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 42, .NobleCarbon, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Carbón")

                            '65	2	Dañado	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 65, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")

                            '66	2	Granos Amohosados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 66, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")

                            '72	2	Grado 3	Arbitrado
                            If .NobleGrado = 3 Then sb = RenglonBLDCalidad(cdp, 72, .NobleGrado, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado3")

                            '73	2	Proteina	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 73, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Proteina")

                            '79	2	Grado 1	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 79, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")

                            '90	2	Bajo PH	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 90, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "PuntaSombreada")

                            '179	2	Grano Picado	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 179, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picado")

                            '181	2	Grado 2	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 181, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "PuntaSombreada")

                            '266	2	Cuerpos Extraños	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 266, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")

                            '267	2	Granos Dañados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 267, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañados")

                            '269	2	Granos Quebrados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 269, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")

                            '270	2	Granos Picados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 270, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picados")

                            '295	2	Grado 1	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 295, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")


                        ElseIf .IdArticulo = id_maiz Then
                            '298	3	Granos Picados	Arbitrado
                            '260	3	MCV Hdad/Ins V.	Arbitrado
                            '327	3	FACTOR	Arbitrado
                            '290	3	Bajo PH	Arbitrado
                            '263	3	Cuerpos Extraños	Arbitrado
                            '183	3	Chamico	Arbitrado
                            '169	3	Grado 2	Arbitrado



                            '18	3	Olores Comerciales Objetables	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 18, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")

                            '76	3	Granos Dañados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 76, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")

                            '19	3	Granos Amohosados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 19, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")

                            '55	3	Grado 1	Arbitrado
                            If .NobleGrado = 1 Then sb = RenglonBLDCalidad(cdp, 55, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")

                            '169	3	Grado 2	Arbitrado
                            If .NobleGrado = 2 Then sb = RenglonBLDCalidad(cdp, 169, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado2")

                            '75	3	Grado 3	Arbitrado
                            If .NobleGrado = 3 Then sb = RenglonBLDCalidad(cdp, 75, .NobleGrado, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado3")

                            '67	3	Granos Quebrados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 67, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")

                            '298	3	Granos Picados	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 298, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picado")

                            '263	3	Cuerpos Extraños	Arbitrado
                            sb = RenglonBLDCalidad(cdp, 263, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")

                        ElseIf .IdArticulo = id_sorgo Then

                            '128	4	Olores Comerciales Objetables	Arbitrado
                            '135	4	Grado 3	Arbitrado
                            '170	4	Grado 2	Arbitrado
                            '151	4	Grado 1	Arbitrado
                            '253	4	Quebrados	Arbitrado
                            '228	4	Granos amohosados	Arbitrado
                            '229	4	Dañado	Arbitrado
                            '230	4	Granos Amohosados	Arbitrado
                            '231	4	C. Extraños 	Arbitrado
                            '232	4	MCV Olor/Quebra	Arbitrado





                            sb = RenglonBLDCalidad(cdp, 128, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")

                            sb = RenglonBLDCalidad(cdp, 229, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")

                            sb = RenglonBLDCalidad(cdp, 230, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")

                            If .NobleGrado = 1 Then sb = RenglonBLDCalidad(cdp, 151, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado1")

                            If .NobleGrado = 2 Then sb = RenglonBLDCalidad(cdp, 170, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado2")

                            If .NobleGrado = 3 Then sb = RenglonBLDCalidad(cdp, 135, .NobleGrado, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado3")

                            sb = RenglonBLDCalidad(cdp, 253, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")


                            sb = RenglonBLDCalidad(cdp, 231, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")

                        ElseIf .IdArticulo = id_girasol Then
                            '194	5	Grado 2	Arbitrado
                            If .NobleGrado = 2 Then sb = RenglonBLDCalidad(cdp, 169, .NoblePicados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Grado2")


                        ElseIf .IdArticulo = id_soja Then
                            '136	6	Tierra	Arbitrado
                            '150	6	Avería	Arbitrado
                            '64	6	Granos Quebrados	Arbitrado
                            '116	6	Granos dañados por calor y ardidos	Arbitrado
                            '28	6	Olores Comerciales Objetables	Arbitrado
                            '29	6	Revolcado en Tierra	Arbitrado
                            '30	6	Granos Amohosados	Arbitrado
                            '51	6	Dañados	Arbitrado
                            '54	6	Cuerpos Extraños	Arbitrado
                            '69	6	Total Dañados	Arbitrado
                            '259	6	Merma Conv. ( olor, moho y revolc)	Arbitrado
                            '200	6	Granos Verdes	Arbitrado
                            '224	6	Multa por Incump. Cupos	Arbitrado
                            '341	6	Gastos de Secada	Arbitrado
                            '265	6	Gastos de Fumigación	Arbitrado


                            sb = RenglonBLDCalidad(cdp, 54, .NobleExtranos, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Extraños")
                            sb = RenglonBLDCalidad(cdp, 28, .NobleObjetables, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Objetables")
                            sb = RenglonBLDCalidad(cdp, 116, .NobleDaniados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Dañado")
                            sb = RenglonBLDCalidad(cdp, 30, .NobleAmohosados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Amohosados")


                            sb = RenglonBLDCalidad(cdp, 64, .NobleQuebrados, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Quebrados")

                            sb = RenglonBLDCalidad(cdp, 136, .CalidadTierra, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Picado")

                            sb = RenglonBLDCalidad(cdp, 200, .NobleVerdes, .CalidadMermaChamicoBonifica_o_Rebaja, 0, nF, "01", "Granos Verdes")


                        End If








                    End With
                Next

            End Using

            FileClose(nF)


            Return vFileName

        End Function

    End Class

    Public Class InformesCartaDePorteManager



        Shared Function TotalesPorDestinos(ByVal SC As String, Optional ByVal dr As DataRow = Nothing) As DataTable
            'Dim dt = EntidadManager.ExecDinamico(HFSC.Value, "Select * from CartasDePorte CDP where Entregador=" & IdEntregador)


            Dim strSQL = String.Format("SELECT  " & vbCrLf & _
                    " 0 as [K_Orden], " & vbCrLf & _
        "       CLIVEN.Razonsocial as   Titular  , " & vbCrLf & _
        "       CLICOR.Nombre as    [Corredor ], " & vbCrLf & _
        "       CLIENT.Razonsocial  as  [Destinatario], " & vbCrLf & _
        "         Articulos.Descripcion as  Producto, " & vbCrLf & _
        "         LOCDES.Descripcion   as  Destino , " & vbCrLf & _
        "       FechaDescarga   as  Arribo , " & vbCrLf & _
        "      NumeroCartaDePorte   as  [C.Porte]  , " & vbCrLf & _
        "       Contrato  as  Contrato , " & vbCrLf & _
        "       NetoPto   as  [Kg.Proc.] , " & vbCrLf & _
        "       BrutoPto   as  [Kg.Bruto Proc.], " & vbCrLf & _
        "       ''   as  [Kg.Dif.] , " & vbCrLf & _
        "         Humedad as  [H.%]	 , " & vbCrLf & _
        "       TaraPto   as  [Kg.Tara Proc.] , " & vbCrLf & _
        "       BrutoFinal   as  [Kg.Bruto Desc.] , " & vbCrLf & _
        "       TaraFinal   as  [Kg.Tara Desc.] , " & vbCrLf & _
        "       NetoFinal   as  [Kg.Neto Desc.] , " & vbCrLf & _
        "         Merma as [Mer.Kg.] , " & vbCrLf & _
        "         Merma as Otras , " & vbCrLf & _
        "        NetoProc  as  [Kg.Netos] , " & vbCrLf & _
        "        LOCORI.Nombre as    [Procedcia.]  " & vbCrLf & _
                      " FROM CartasDePorte CDP " & vbCrLf & _
                       " LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente " & vbCrLf & _
                       " LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente " & vbCrLf & _
                       " LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente " & vbCrLf & _
                       " LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor " & vbCrLf & _
                       " LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente " & vbCrLf & _
                       " LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo " & vbCrLf & _
                       " LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista " & vbCrLf & _
                       " LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer " & vbCrLf & _
                       " LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & vbCrLf & _
                       " LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino " & vbCrLf & _
                    "" & vbCrLf & _
                    "" & vbCrLf & _
                    " UNION ALL " & vbCrLf & _
                    "" & vbCrLf & _
                    "" & vbCrLf & _
                    "SELECT  " & vbCrLf & _
                    " 1 as [K_Orden], " & vbCrLf & _
        "       CLIVEN.Razonsocial as   Titular  , " & vbCrLf & _
        "       CLICOR.Nombre as    [Corredor ], " & vbCrLf & _
        "       CLIENT.Razonsocial  as  [Destinatario], " & vbCrLf & _
        "         Articulos.Descripcion as  Producto, " & vbCrLf & _
        "         LOCDES.Descripcion   as  Destino , " & vbCrLf & _
        "       null   as  Arribo , " & vbCrLf & _
        "      null   as  [C.Porte]  , " & vbCrLf & _
        "       null  as  Contrato , " & vbCrLf & _
        "       SUM(NetoPto)   as  [Kg.Proc.] , " & vbCrLf & _
        "       SUM(BrutoPto)   as  [Kg.Bruto Proc.], " & vbCrLf & _
        "       'TOTAL'   as  [Kg.Dif.] , " & vbCrLf & _
        "         SUM(Humedad) as  [H.%]	 , " & vbCrLf & _
        "       SUM(TaraPto)   as  [Kg.Tara Proc.] , " & vbCrLf & _
        "       SUM(BrutoFinal)   as  [Kg.Bruto Desc.] , " & vbCrLf & _
        "       SUM(TaraFinal)   as  [Kg.Tara Desc.] , " & vbCrLf & _
        "       SUM(NetoFinal)   as  [Kg.Neto Desc.] , " & vbCrLf & _
        "         SUM(Merma) as [Mer.Kg.] , " & vbCrLf & _
        "         SUM(Merma) as Otras , " & vbCrLf & _
        "        SUM(NetoProc)  as  [Kg.Netos] , " & vbCrLf & _
        "        ''   as    [Procedcia.]  " & vbCrLf & _
                      " FROM CartasDePorte CDP " & vbCrLf & _
                       " LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente " & vbCrLf & _
                       " LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente " & vbCrLf & _
                       " LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente " & vbCrLf & _
                       " LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor " & vbCrLf & _
                       " LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente " & vbCrLf & _
                       " LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo " & vbCrLf & _
                       " LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista " & vbCrLf & _
                       " LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer " & vbCrLf & _
                       " LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & vbCrLf & _
                       " LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino " & vbCrLf & _
                "GROUP BY CLIVEN.Razonsocial,CLICOR.Nombre,CLIENT.Razonsocial,Articulos.Descripcion, LOCDES.Descripcion" & vbCrLf & _
                "" & vbCrLf & _
                "" & vbCrLf & _
                "" & vbCrLf & _
        "ORDER BY  Destinos, CLIVEN.Razonsocial,CLICOR.Nombre,K_Orden" & vbCrLf & _
            "")

            Debug.Print(strSQL)

            'SELECT 
            '	0 as [IdAux],
            '	IsNull(Rubros.Descripcion,'') as [K_Rubro],
            '	1 as [K_Orden],
            '                'TOTAL '+IsNull(Rubros.Descripcion,'') as [Rubro],
            '	Null as [Subrubro],
            '	Null as [Codigo],
            '	Null as [Articulo],
            '	SUM(#Auxiliar1.Cantidad) as [Cantidad],
            '	SUM(#Auxiliar1.Importe) as [Importe],
            '	@Vector_T as Vector_T,
            '	@Vector_X as Vector_X
            'FROM #Auxiliar1
            'LEFT OUTER JOIN Articulos Art ON Art.IdArticulo=#Auxiliar1.IdArticulo
            'LEFT OUTER JOIN Rubros ON Art.IdRubro=Rubros.IdRubro
            'GROUP BY Art.IdRubro, Rubros.Descripcion


            '        SELECT 
            '	0 as [IdAux],
            '            'zzzzzzzzzz' as [K_Rubro],
            '	3 as [K_Orden],
            '            'TOTALES GENERALES' as [Rubro],
            '	Null as [Subrubro],
            '	Null as [Codigo],
            '	Null as [Articulo],
            '	SUM(#Auxiliar1.Cantidad) as [Cantidad],
            '	SUM(#Auxiliar1.Importe) as [Importe],
            '	@Vector_T as Vector_T,
            '	@Vector_X as Vector_X
            'FROM #Auxiliar1

            'ORDER BY [K_Rubro],[K_Orden],[Articulo]

            With dr
                Dim strWHERE
                '        strWHERE = "    WHERE 1=1 " & _
                'iisIdValido(.Item("Vendedor"), "           AND CDP.Vendedor = " & .Item("Vendedor"), "") & _
                'iisIdValido(.Item("CuentaOrden1"), "         AND CDP.CuentaOrden1=" & .Item("CuentaOrden1"), "") & _
                'iisIdValido(.Item("CuentaOrden2"), "         AND CDP.CuentaOrden2=" & .Item("CuentaOrden2"), "") & _
                'iisIdValido(.Item("Corredor"), "             AND CDP.Corredor=" & .Item("Corredor"), "") & _
                'iisIdValido(.Item("IdArticulo"), "           AND CDP.IdArticulo=" & .Item("IdArticulo"), "") & _
                'iisIdValido(.Item("Entregador"), "         AND CDP.Entregador=" & .Item("Entregador"), "") & _
                'IIf(iisNull(.Item("EsPosicion"), False), "  AND FechaDescarga IS NULL ", " AND NOT FechaDescarga IS NULL ") & _
                '        "                               AND FechaDeCarga Between '" & iisValidSqlDate(.Item("FechaDesde"), #1/1/1753#) & "' AND '" & iisValidSqlDate(.Item("FechaHasta"), #1/1/2100#) & "'"


                '        'Version con variables en lugar de datarow
                '        Dim strWHERE = "    WHERE 1=1 " & _
                'IIf(IdVendedor > 0, "           AND CDP.Vendedor = " & IdVendedor, "") & _
                'IIf(CuentaOrden1 > 0, "         AND CDP.CuentaOrden1=" & CuentaOrden1, "") & _
                'IIf(CuentaOrden2 > 0, "         AND CDP.CuentaOrden1=" & CuentaOrden2, "") & _
                'IIf(Corredor > 0, "             AND CDP.Corredor=" & Corredor, "") & _
                'IIf(IdArticulo > 0, "           AND CDP.IdArticulo=" & IdArticulo, "") & _
                'IIf(IdEntregador > 0, "         AND CDP.Entregador=" & IdEntregador, "") & _
                'IIf(PosicionODescarga <> "", "  AND NOT FechaDescarga IS NULL ", "") & _
                '"                               AND FechaDeCarga Between '" & FechaDesde & "' AND '" & FechaHasta & "'"


                strSQL += strWHERE
                Debug.Print(strWHERE)
            End With

            Dim dt = EntidadManager.ExecDinamico(SC, strSQL)



            Return dt
        End Function

        Shared Function ComisionesPorDestinoYArticulo(ByVal SC As String, Optional ByVal dr As DataRow = Nothing, Optional ByVal strWHERE As String = "") As DataTable
            'Dim dt = EntidadManager.ExecDinamico(HFSC.Value, "Select * from CartasDePorte CDP where Entregador=" & IdEntregador)



            Dim strSQL = String.Format(" SELECT  CLISC1.Razonsocial as SubcontrDesc, tarifasubcontratista1,tarifasubcontratista1*netofinal /1000 as comision, " & _
            " CDP.Vendedor, CDP.CuentaOrden1,CDP.CuentaOrden2, CDP.Corredor, CDP.Idarticulo, CDP.Entregador, CDP.FechaDescarga, CDP.FechaDeCarga, CDP.NetoFinal/1000 as NetoFinal,CDP.Anulada,CDP.Exporta," & _
             " 0 as [K_Orden], " & vbCrLf & _
        "       CLIVEN.Razonsocial as   Titular  , " & vbCrLf & _
        "       CLICOR.Nombre as    [Corredor ], " & vbCrLf & _
        "       CLIENT.Razonsocial  as  [Destinatario], " & vbCrLf & _
        "         Articulos.Descripcion as  Producto, " & vbCrLf & _
        "         LOCDES.Descripcion   as  Destino , " & vbCrLf & _
        "       FechaDescarga   as  Arribo , FechaArribo, " & vbCrLf & _
        "      NumeroCartaDePorte   as  [C.Porte]  , " & vbCrLf & _
        "       Contrato  as  Contrato , " & vbCrLf & _
        "       NetoPto   as  [Kg.Proc.] , " & vbCrLf & _
        "       BrutoPto   as  [Kg.Bruto Proc.], " & vbCrLf & _
        "       ''   as  [Kg.Dif.] , " & vbCrLf & _
        "         Humedad as  [H.%]	 , " & vbCrLf & _
        "       TaraPto   as  [Kg.Tara Proc.] , " & vbCrLf & _
        "       BrutoFinal   as  [Kg.Bruto Desc.] , " & vbCrLf & _
        "       TaraFinal   as  [Kg.Tara Desc.] , " & vbCrLf & _
        "       NetoFinal/1   as  [Kg.Neto Desc.] , " & vbCrLf & _
        "         Merma as [Mer.Kg.] , " & vbCrLf & _
        "         Merma as Otras , " & vbCrLf & _
        "        NetoProc  as  [Kg.Netos] , " & vbCrLf & _
        "        LOCORI.Nombre as    [Procedcia.], PuntoVenta, " & vbCrLf & _
        "       ExcluirDeSubcontratistas  " & vbCrLf & _
                      " FROM CartasDePorte CDP " & vbCrLf & _
                       " LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente " & vbCrLf & _
                       " LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente " & vbCrLf & _
                       " LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente " & vbCrLf & _
                       " LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor " & vbCrLf & _
        " LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente " & vbCrLf & _
                      " LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente" & _
        " LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente " & _
        " LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo " & vbCrLf & _
                       " LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista " & vbCrLf & _
                       " LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer " & vbCrLf & _
                       " LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & vbCrLf & _
                       " LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino " & vbCrLf & _
                    "" & vbCrLf & _
                    "" & vbCrLf & _
                    " UNION ALL " & vbCrLf & _
                    "" & vbCrLf & _
        "SELECT  CLISC2.Razonsocial as SubcontrDesc, tarifasubcontratista2,tarifasubcontratista2*netofinal/1000 as comision,  " & _
            " CDP.Vendedor, CDP.CuentaOrden1,CDP.CuentaOrden2, CDP.Corredor, CDP.Idarticulo, CDP.Entregador, CDP.FechaDescarga, CDP.FechaDeCarga, CDP.NetoFinal/1000 as NetoFinal,CDP.Anulada,CDP.Exporta," & _
                   " 0 as [K_Orden], " & vbCrLf & _
        "       CLIVEN.Razonsocial as   Titular  , " & vbCrLf & _
        "       CLICOR.Nombre as    [Corredor ], " & vbCrLf & _
        "       CLIENT.Razonsocial  as  [Destinatario], " & vbCrLf & _
        "         Articulos.Descripcion as  Producto, " & vbCrLf & _
        "         LOCDES.Descripcion   as  Destino , " & vbCrLf & _
        "       FechaDescarga   as  Arribo ,  FechaArribo, " & vbCrLf & _
        "      NumeroCartaDePorte   as  [C.Porte]  , " & vbCrLf & _
        "       Contrato  as  Contrato , " & vbCrLf & _
        "       NetoPto   as  [Kg.Proc.] , " & vbCrLf & _
        "       BrutoPto   as  [Kg.Bruto Proc.], " & vbCrLf & _
        "       ''   as  [Kg.Dif.] , " & vbCrLf & _
        "         Humedad as  [H.%]	 , " & vbCrLf & _
        "       TaraPto   as  [Kg.Tara Proc.] , " & vbCrLf & _
        "       BrutoFinal   as  [Kg.Bruto Desc.] , " & vbCrLf & _
        "       TaraFinal   as  [Kg.Tara Desc.] , " & vbCrLf & _
        "       NetoFinal   as  [Kg.Neto Desc.] , " & vbCrLf & _
        "         Merma as [Mer.Kg.] , " & vbCrLf & _
        "         Merma as Otras , " & vbCrLf & _
        "        NetoProc  as  [Kg.Netos] , " & vbCrLf & _
        "        LOCORI.Nombre as    [Procedcia.], PuntoVenta, " & vbCrLf & _
        "       ExcluirDeSubcontratistas  " & vbCrLf & _
                      " FROM CartasDePorte CDP " & vbCrLf & _
                      " LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente " & vbCrLf & _
                       " LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente " & vbCrLf & _
                       " LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente " & vbCrLf & _
                       " LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor " & vbCrLf & _
        " LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente " & vbCrLf & _
                      " LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente" & _
        " LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente " & _
                       " LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo " & vbCrLf & _
                       " LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista " & vbCrLf & _
                       " LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer " & vbCrLf & _
                       " LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & vbCrLf & _
                       " LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino " & vbCrLf & _
                    "" & vbCrLf & _
                    "" & vbCrLf & _
                "" & vbCrLf & _
                "" & vbCrLf & _
                "" & vbCrLf & _
            "")















            Debug.Print(vbCrLf & vbCrLf & vbCrLf & vbCrLf & vbCrLf & vbCrLf & vbCrLf)
            Debug.Print(strSQL)

            'SELECT 
            '	0 as [IdAux],
            '	IsNull(Rubros.Descripcion,'') as [K_Rubro],
            '	1 as [K_Orden],
            '                'TOTAL '+IsNull(Rubros.Descripcion,'') as [Rubro],
            '	Null as [Subrubro],
            '	Null as [Codigo],
            '	Null as [Articulo],
            '	SUM(#Auxiliar1.Cantidad) as [Cantidad],
            '	SUM(#Auxiliar1.Importe) as [Importe],
            '	@Vector_T as Vector_T,
            '	@Vector_X as Vector_X
            'FROM #Auxiliar1
            'LEFT OUTER JOIN Articulos Art ON Art.IdArticulo=#Auxiliar1.IdArticulo
            'LEFT OUTER JOIN Rubros ON Art.IdRubro=Rubros.IdRubro
            'GROUP BY Art.IdRubro, Rubros.Descripcion


            '        SELECT 
            '	0 as [IdAux],
            '            'zzzzzzzzzz' as [K_Rubro],
            '	3 as [K_Orden],
            '            'TOTALES GENERALES' as [Rubro],
            '	Null as [Subrubro],
            '	Null as [Codigo],
            '	Null as [Articulo],
            '	SUM(#Auxiliar1.Cantidad) as [Cantidad],
            '	SUM(#Auxiliar1.Importe) as [Importe],
            '	@Vector_T as Vector_T,
            '	@Vector_X as Vector_X
            'FROM #Auxiliar1

            'ORDER BY [K_Rubro],[K_Orden],[Articulo]

            With dr
                'Dim strWHERE
                '        strWHERE = "    WHERE 1=1 " & _
                'iisIdValido(.Item("Vendedor"), "           AND CDP.Vendedor = " & .Item("Vendedor"), "") & _
                'iisIdValido(.Item("CuentaOrden1"), "         AND CDP.CuentaOrden1=" & .Item("CuentaOrden1"), "") & _
                'iisIdValido(.Item("CuentaOrden2"), "         AND CDP.CuentaOrden2=" & .Item("CuentaOrden2"), "") & _
                'iisIdValido(.Item("Corredor"), "             AND CDP.Corredor=" & .Item("Corredor"), "") & _
                'iisIdValido(.Item("IdArticulo"), "           AND CDP.IdArticulo=" & .Item("IdArticulo"), "") & _
                'iisIdValido(.Item("Entregador"), "         AND CDP.Entregador=" & .Item("Entregador"), "") & _
                'IIf(iisNull(.Item("EsPosicion"), False), "  AND FechaDescarga IS NULL ", " AND NOT FechaDescarga IS NULL ") & _
                '        "                               AND FechaDeCarga Between '" & iisValidSqlDate(.Item("FechaDesde"), #1/1/1753#) & "' AND '" & iisValidSqlDate(.Item("FechaHasta"), #1/1/2100#) & "'"


                '        'Version con variables en lugar de datarow
                '        Dim strWHERE = "    WHERE 1=1 " & _
                'IIf(IdVendedor > 0, "           AND CDP.Vendedor = " & IdVendedor, "") & _
                'IIf(CuentaOrden1 > 0, "         AND CDP.CuentaOrden1=" & CuentaOrden1, "") & _
                'IIf(CuentaOrden2 > 0, "         AND CDP.CuentaOrden1=" & CuentaOrden2, "") & _
                'IIf(Corredor > 0, "             AND CDP.Corredor=" & Corredor, "") & _
                'IIf(IdArticulo > 0, "           AND CDP.IdArticulo=" & IdArticulo, "") & _
                'IIf(IdEntregador > 0, "         AND CDP.Entregador=" & IdEntregador, "") & _
                'IIf(PosicionODescarga <> "", "  AND NOT FechaDescarga IS NULL ", "") & _
                '"                               AND FechaDeCarga Between '" & FechaDesde & "' AND '" & FechaHasta & "'"

                If strWHERE <> "" Then strSQL += "    WHERE  " & strWHERE
                'Debug.Print(strWHERE)
            End With

            Dim dt = EntidadManager.ExecDinamico(SC, strSQL)



            Return dt
        End Function






        '///////////////////////////////////
        '///////////////////////////////////
        'refrescos
        '///////////////////////////////////







        '///////////////////////////////////
        '///////////////////////////////////
        'botones y links
        '///////////////////////////////////



        '///////////////////////////////////
        '///////////////////////////////////
        'toggles
        '///////////////////////////////////

        Sub ResumenVisible(ByVal estado As Boolean)
            'txtPendientesReintegrar.Visible = estado
            'txtReposicionSolicitada.Visible = estado
            'txtSaldo.Visible = estado
            'txtTotalAsignados.Visible = estado
        End Sub



        'Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        '    'http://forums.asp.net/t/1284166.aspx
        '    'esto solo se puede usar si el ODS usa un dataset
        '    'ObjectDataSource1.FilterExpression = GenerarWHERE()
        '    '& " OR " & _
        '    '"Convert(Obra, 'System.String') LIKE '*" & txtBuscar.Text & "*'"


        '    'http://forums.asp.net/p/1379591/2914907.aspx#2914907
        'End Sub

        'Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        '    GridView1.PageIndex = e.NewPageIndex
        '    ReBind()
        'End Sub

















        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        'copiado de funcionesuiweb
        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////



        Public Function DataTableToExcel(ByVal pDataTable As DataTable, Optional ByVal titulo As String = "", Optional ByVal sSufijoNombreArchivo As String = "Notas de Entrega") As String

            Dim vFileName As String = Path.GetTempFileName()
            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)



            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            PrintLine(nF, sb)
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataTable.Rows
                i = 0 : sb = ""
                For Each dc In pDataTable.Columns
                    If Not IsDBNull(dr(i)) Then
                        Try
                            If IsNumeric(dr(i)) Then
                                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                            ElseIf dr(i).GetType.Name = "Byte[]" Then
                                sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                            Else
                                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                            End If
                        Catch x As Exception
                            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                        End Try
                    Else
                        sb &= Microsoft.VisualBasic.ControlChars.Tab
                    End If
                    i += 1
                Next
                PrintLine(nF, sb)
            Next


            FileClose(nF)



            Return TextToExcel(vFileName, titulo, sSufijoNombreArchivo)
        End Function


        Public Function DataTableToExcel(ByVal pDataView As DataView, Optional ByVal titulo As String = "", Optional ByVal sSufijoNombreArchivo As String = "Notas de Entrega") As String

            Dim vFileName As String = Path.GetTempFileName()
            'Dim vFileName As String = "c:\archivo.txt"
            Dim nF = FreeFile()
            FileOpen(nF, vFileName, OpenMode.Output)



            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataView.Table.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            PrintLine(nF, sb)
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataView.Table.Rows
                i = 0 : sb = ""
                For Each dc In pDataView.Table.Columns
                    If Not IsDBNull(dr(i)) Then
                        Try
                            If IsNumeric(dr(i)) Then
                                sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                            Else
                                sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                            End If
                        Catch x As Exception
                            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                        End Try
                    Else
                        sb &= Microsoft.VisualBasic.ControlChars.Tab
                    End If
                    i += 1
                Next
                PrintLine(nF, sb)
            Next


            FileClose(nF)



            Return TextToExcel(vFileName, titulo, sSufijoNombreArchivo)
        End Function



        Public Function TextToExcel(ByVal pFileName As String, Optional ByVal titulo As String = "", Optional ByVal sSufijoNombreArchivo As String = "Notas de Entrega") As String

            Dim vFormato As Excel.XlRangeAutoFormat
            Dim Exc As Excel.Application = CreateObject("Excel.Application")
            Exc.Visible = False
            Exc.DisplayAlerts = False

            'importa el archivo de texto
            'cómo hacer para abrir el .tmp (que es un TAB SEPARATED) para que tome el punto decimal
            'http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=12722
            Exc.Workbooks.OpenText(pFileName, , , , Excel.XlTextQualifier.xlTextQualifierNone, , True, , , , , , , , ".", ",")


            '        Workbooks.OpenText(Filename:=myFile.Name _
            ', Origin:=xlWindows, StartRow:=1, DataType:=xlDelimited, TextQualifier _
            ':=xlDoubleQuote, ConsecutiveDelimiter:=False, TAB:=True, Semicolon:= _
            'False, Comma:=False, Space:=False, Other:=False, FieldInfo:=Array(Array _
            '(1, 1), Array(2, 1)), DecimalSeparator:=".", ThousandsSeparator:=",", _
            'TrailingMinusNumbers:=True)




            Dim Wb As Excel.Workbook = Exc.ActiveWorkbook
            Dim Ws As Excel.Worksheet = CType(Wb.ActiveSheet, Excel.Worksheet)


            'Se le indica el formato al que queremos exportarlo
            Dim valor As Integer = 10

            If valor > -1 Then
                Select Case (valor)
                    Case 10 : vFormato = Excel.XlRangeAutoFormat.xlRangeAutoFormatClassic1
                End Select
                Ws.Range(Ws.Cells(1, 1), Ws.Cells(Ws.UsedRange.Rows.Count, Ws.UsedRange.Columns.Count)).AutoFormat(vFormato) 'le hace autoformato

                'insertar totales
                'Dim filas = Ws.UsedRange.Rows.Count
                'Ws.Cells(filas + 1, "E") = "TOTAL:"
                'Ws.Cells(filas + 1, "F") = Exc.WorksheetFunction.Sum(Ws.Range("F2:F" & filas))
                'Ws.Cells(filas + 1, "G") = Exc.WorksheetFunction.Sum(Ws.Range("G2:G" & filas))
                'Ws.Cells(filas + 1, "H") = Exc.WorksheetFunction.Sum(Ws.Range("H2:H" & filas))
                'Ws.Cells(filas + 1, "I") = Exc.WorksheetFunction.Sum(Ws.Range("I2:I" & filas))
                'Ws.Cells(filas + 1, "J") = Exc.WorksheetFunction.Sum(Ws.Range("J2:J" & filas))
                'Ws.Cells(filas + 1, "K") = Exc.WorksheetFunction.Sum(Ws.Range("K2:K" & filas))
                'Ws.Cells(filas + 1, "N") = Exc.WorksheetFunction.Sum(Ws.Range("N2:N" & filas))
                'Ws.Cells(filas + 1, "O") = Exc.WorksheetFunction.Sum(Ws.Range("O2:O" & filas))
                'Ws.Cells(filas + 1, "P") = Exc.WorksheetFunction.Sum(Ws.Range("P2:P" & filas))


                '/////////////////////////////////
                'muevo la planilla formateada para tener un espacio arriba
                'Ws.Range(Ws.Cells(1, 1), Ws.Cells(filas + 2, Ws.UsedRange.Columns.Count)).Cut(Ws.Cells(10, 1))

                '/////////////////////////////////
                'poner tambien el filtro que se usó para hacer el informe
                If titulo <> "" Then Ws.Cells(7, 1) = titulo

                '/////////////////////////////////
                'insertar la imagen 
                'System.Web.VirtualPathUtility.ToAbsolute("~/Imagenes/Williams.bmp")  
                'Ws.Pictures.Insert("~/Imagenes/Williams.bmp")
                'Dim imag = Ws.Pictures.Insert(Server.MapPath("~/Imagenes/Williams.bmp"))
                'imag.Left = 1
                'imag.top = 1

                '/////////////////////////////////
                'insertar link
                'Dim rg As Excel.Range = Ws.Cells(3, 10)
                ''rg.hip()
                ''rg.Hyperlinks(1).Address = "www.williamsentregas.com.ar"
                ''rg.Hyperlinks(1).TextToDisplay=
                'Ws.Hyperlinks.Add(rg, "http:\\www.williamsentregas.com.ar", , , "Visite: www.williamsentregas.com.ar y vea toda su información en linea!")
                ''Ws.Cells(3, "K") = "=HYPERLINK(" & Chr(34) & "www.williamsentregas.com.ar " & Chr(34) & ", ""Visite: www.williamsentregas.com.ar y vea toda su información en linea!"" )"








                '/////////////////////////////////
                '/////////////////////////////////

                'Usando un GUID
                'pFileName = System.IO.Path.GetTempPath() + Guid.NewGuid().ToString() + ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

                'Usando la hora
                pFileName = System.IO.Path.GetTempPath() + sSufijoNombreArchivo + " " + Now.ToString("ddMMMyyyy_HHmmss") + ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

                '/////////////////////////////////

                'pFileName = Path.GetTempFileName  'tambien puede ser .GetRandomFileName
                'pFileName = Path.GetTempFileName.Replace("tmp", "xls")
                'problemas con el acceso del proceso al archivo? http://www.eggheadcafe.com/software/aspnet/34067727/file-cannot-be-accessed-b.aspx
                'pFileName = "C:\Archivo.xls"
                'File.Delete(pFileName) 'si no borro, va a aparecer el cartelote de sobreescribir. entonces necesito el .DisplayAlerts = False

                Exc.ActiveWorkbook.SaveAs(pFileName, Excel.XlTextQualifier.xlTextQualifierNone - 1, )
            End If


            'Exc.Quit()
            'Wb = Nothing
            'Exc = Nothing

            If Not Wb Is Nothing Then Wb.Close(False)
            NAR(Wb)
            'Wbs.Close()
            'NAR(Wbs)
            'quit and dispose app
            Exc.Quit()
            NAR(Exc)

            Ws = Nothing


            GC.Collect()
            'If valor > -1 Then
            '    Dim p As System.Diagnostics.Process = New System.Diagnostics.Process
            '    p.EnableRaisingEvents = False
            '    'System.Diagnostics.Process.Start(pFileName) 'para qué hace esto?
            'End If
            Return pFileName
        End Function



    End Class

End Namespace






