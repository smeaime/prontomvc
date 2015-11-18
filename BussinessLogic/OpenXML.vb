Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports Pronto.ERP.Bll.EntidadManager
Imports System.Data
Imports System.Diagnostics

Imports System.Linq
Imports System.IO
Imports System.Data.SqlClient
Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging
Imports DocumentFormat.OpenXml.Wordprocessing
Imports DocumentFormat.OpenXml.Spreadsheet

Imports OpenXmlPowerTools


Namespace Pronto.ERP.Bll



    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '¨XML. sacar del facturamanager
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////






    Public Class OpenXML_Pronto


        Public Shared Function NotaCreditoXML_DOCX(ByVal oFac As Pronto.ERP.BO.NotaDeCredito, ByVal sConex As String) As String

            'Dim oFac As Pronto.ERP.BO.Requerimiento = CType(Me.ViewState(mKey), Pronto.ERP.BO.Requerimiento)

            Dim plantilla = OpenXML_Pronto.CargarPlantillaDeSQL(enumPlantilla.NotaCreditoA, sConex)


            Dim wordDoc As WordprocessingDocument = WordprocessingDocument.Open(plantilla, True)


            Dim settings As New SimplifyMarkupSettings
            With settings
                .RemoveComments = True
                .RemoveContentControls = True
                .RemoveEndAndFootNotes = True
                .RemoveFieldCodes = False
                .RemoveLastRenderedPageBreak = True
                .RemovePermissions = True
                .RemoveProof = True
                .RemoveRsidInfo = True
                .RemoveSmartTags = True
                .RemoveSoftHyphens = True
                .ReplaceTabsWithSpaces = True
            End With
            MarkupSimplifier.SimplifyMarkup(wordDoc, settings)


            'GenerarDiccionario()



            Using (wordDoc)
                Dim docText As String = Nothing
                Dim sr As StreamReader = New StreamReader(wordDoc.MainDocumentPart.GetStream)



                Using (sr)
                    docText = sr.ReadToEnd
                End Using

                '/////////////////////////////
                '/////////////////////////////
                'Hace el reemplazo
                '/////////////////////////////

                'domicilio()
                'Localidad=


                regexReplace(docText, "#Cliente#", oFac.Cliente.RazonSocial)
                regexReplace(docText, "#CodigoCliente#", oFac.Cliente.CodigoCliente)
                regexReplace(docText, "#Direccion#", oFac.Cliente.Direccion) 'oFac.Domicilio)
                regexReplace(docText, "#Localidad#", oFac.Cliente.Localidad) 'oFac.Domicilio)
                regexReplace(docText, "#CUIT#", oFac.Cliente.Cuit)

                regexReplace(docText, "#Vendedor#", oFac.VendedorNombre_Descripcion)
                'regexReplace(docText, "#CUIT#", oFac.ClienteCUIT)

                regexReplace(docText, "#Numero#", oFac.Numero)
                regexReplace(docText, "#Fecha#", oFac.Fecha)
                regexReplace(docText, "#CondicionIVA#", oFac.CodigoIVA_Descripcion)
                regexReplace(docText, "#CondicionVenta#", oFac.CondicionVenta_Descripcion)
                regexReplace(docText, "#CAE#", oFac.CAE)

                regexReplace(docText, "#Observaciones#", oFac.Observaciones)
                'regexReplace(docText, "lugarentrega", oFac.LugarEntrega)


                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'regexReplace(docText, "#Subtotal#", oFac.SubTotal)  'NO USAR. El reemplazo del pie está al final de esta funcion
                'regexReplace(docText, "#IVA#", oFac.ImporteIva1)
                'regexReplace(docText, "#Total#", oFac.Total)




                Dim sw As StreamWriter = New StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create))
                Using (sw)
                    sw.Write(docText)
                End Using







                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                Dim mainPart = wordDoc.MainDocumentPart
                'Dim contentBloc = mainPart.HeaderParts..Descendants(Of Wordprocessing.SdtBlock)().First

                'http://stackoverflow.com/questions/7026449/replacing-bookmarks-in-docx-file-using-openxml-sdk-and-c-cli
                'http://openxmldeveloper.org/blog/b/openxmldeveloper/archive/2011/09/01/how-to-retrieve-the-text-of-a-bookmark-from-an-openxml-wordprocessingml-document.aspx
                'http://openxmldeveloper.org/blog/b/openxmldeveloper/archive/2011/09/06/replacing-text-of-a-bookmark-in-an-openxml-wordprocessingml-document.aspx





                Dim formfield = wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.FormFieldData)().FirstOrDefault
                'Dim e = formfield.GetFirstChild(Of Wordprocessing.Enabled)()
                'e.Val = True
                'Dim parent = formfield.Parent
                'Dim runEEE = New Wordprocessing.Run(New Wordprocessing.Text("sfsdf"))
                'parent.ReplaceChild(runEEE, formfield)

                'Dim t = formfield.GetFirstChild(Of Wordprocessing.TextInput)()


                Dim bookmarkstartCliente = (From bookmark In _
                                 wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
                               Where bookmark.Name = "Cliente" _
                               Select bookmark).SingleOrDefault
                '
                '   
                '

                Try


                    Dim textoRellenar = ""
                    Dim bsText As DocumentFormat.OpenXml.OpenXmlElement = bookmarkstartCliente.NextSibling
                    If Not bsText Is Nothing Then
                        If TypeOf bsText Is Wordprocessing.BookmarkEnd Then
                            'Add Text element after start bookmark
                            bookmarkstartCliente.Parent.InsertAfter(New Wordprocessing.Run(New Wordprocessing.Text(textoRellenar)), _
                                                                    bookmarkstartCliente)
                        Else
                            'Change Bookmark Text
                            If TypeOf bsText Is Wordprocessing.Run Then
                                If bsText.GetFirstChild(Of Wordprocessing.Text)() Is Nothing Then
                                    'bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 2)
                                    'bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 1)
                                    bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 0)
                                End If
                                bsText.GetFirstChild(Of Wordprocessing.Text)().Text = textoRellenar 'bookmarkstartCliente.Name
                            End If
                        End If
                    End If

                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try




                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                'CUERPO  (repetir renglones)
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                'http://msdn.microsoft.com/en-us/library/cc850835(office.14).aspx

                '///////////////////////////////////////////////////////////////////////////////////
                '   http://stackoverflow.com/a/3783607/1054200
                '@Matt S: I've put in a few extra links that should also help you get started. There are a number of ways 
                'to do repeaters with Content Controls - one is what you mentioned. The other way is to use Building Blocks. 
                'Another way is to kind of do the opposite of what you mentioned - put a table with just a header row and then 
                'create rows populated with CCs in the cells (creo que esto es lo que hago yo). Do take a look 
                'at the Word Content Control Kit as well - that will save your life in working with CCs until you 
                'become much more familiar. – Otaku Sep 25 '10 at 15:46
                '/////////////////////////////////////////////////////////////////////////////////////

                '  'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk




                '///////////////////////////////////////
                'en VBA, Edu busca el sector así:
                '
                '            Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
                '
                '-no encuentro en qué lugar dice "Detalles"!!! -ahí está (Ctrl-I). no sé como mostrarlos. Edu se maneja
                ' con bookmarks. Para hacer la migracion, debería imitar lo mas posible esa idea (haciendolo
                ' compatible, mostrando los bookmarks como placeholders, etc.
                ' APARECEN CON CORCHETES SI TIENEN UN ITEM. SI ES UNA UBICACION, APARECEN CON EL I-beam (una "I" grande)
                '- y cómo sé el nombre que tiene???????
                '///////////////////////////////////////

                'mostrar bookmarks en Word2007
                'http://www.google.com.ar/imgres?um=1&hl=es&safe=off&sa=N&biw=1163&bih=839&tbm=isch&tbnid=VBegw7vZDThDNM:&imgrefurl=http://www.howtogeek.com/76142/navigate-long-documents-in-word-2007-and-2010-using-bookmarks/&docid=lavUxX3WcLhNAM&imgurl=http://www.howtogeek.com/wp-content/uploads/2011/10/05_turning_on_show_bookmarks.png&w=544&h=414&ei=cNNiT7OYAoKgtwfd2eWLCA&zoom=1&iact=rc&dur=312&sig=101947458089387539527&page=1&tbnh=145&tbnw=191&start=0&ndsp=20&ved=1t:429,r:1,s:0&tx=113&ty=93

                '            Isn() 't there a way in Word 2007 to show all bookmarks in a document
                'In any version of Word, you can get the Bookmark dialog to display the names 
                'of all the bookmarks by both checking the "Hidden bookmarks" box *and* 
                'selecting "Sort by: Location." You can select any given bookmark name and 
                'click Go To to find it.

                '//////////////////////////////////////////////////////////////
                'cómo mostrar el tab de DEVELOPER en office
                'Click the Microsoft Office Button, and then click Excel Options, PowerPoint Options, or Word Options.
                'Click Popular, and then select the Show Developer tab in the Ribbon check box.
                '//////////////////////////////////////////////////////////////

                '//////////////////////////////////////////////////
                'en VBA, Edu busca el sector así:
                '
                '            Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
                '
                'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                '//////////////////////////////////////////////////////////
                Dim bookmarkDetalles = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
                           Where bookmark.Name = "Detalles" Or bookmark.Name = "Detalle" _
                           Select bookmark).FirstOrDefault


                Dim tempParent

                Dim placeholderCANT = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.Text)() _
                                          Where bookmark.Text = "#Descripcion#" _
                                          Select bookmark).FirstOrDefault

                If Not placeholderCANT Is Nothing Then
                    tempParent = placeholderCANT.Parent
                Else
                    tempParent = bookmarkDetalles.Parent
                End If



                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////

                'qué tabla contiene al bookmark "Detalles"? (es el que usa Edu en VBA)
                Dim table As Wordprocessing.Table

                ' Find the second row in the table.
                Dim row1 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(0)
                Dim row2 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(1)


                If True Then

                    Try

                        'METODO B:
                        'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                        ' loop till we get the containing element in case bookmark is inside a table etc.
                        ' keep checking the element's parent and update it till we reach the Body
                        Dim isInTable As Boolean = False

                        While Not TypeOf (tempParent.Parent) Is Wordprocessing.Body ',) <> mainPart.Document.Body
                            tempParent = tempParent.Parent
                            If (TypeOf (tempParent) Is Wordprocessing.TableRow And Not isInTable) Then
                                isInTable = True
                                Exit While
                            End If
                        End While

                        If isInTable Then
                            'table = tempParent
                            'no basta con saber la tabla. necesito saber la posicion del bookmark en la tabla
                            'table.ChildElements(
                            'bookmarkDetalles.
                            row1 = tempParent
                            table = row1.Parent
                        Else
                            Err.Raise(5454, "asdasdasa")
                        End If

                    Catch ex As Exception
                        'no encontró el bookmark "Detalles". Me conformo con la primera row donde encuentre #Cant#

                    End Try


                Else

                    '////////////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////////////
                    'METODO A:
                    ' Find the first table in the document.
                    table = wordDoc.MainDocumentPart.Document.Body.Elements(Of Wordprocessing.Table)().First



                End If

                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////







                ''Make a copy of the 2nd row (assumed that the 1st row is header) http://patrickyong.net/tags/openxml/
                'Dim rows = table.Elements(Of Wordprocessing.TableRow)()
                For Each i As NotaDeCreditoItem In oFac.Detalles
                    Dim dupRow As DocumentFormat.OpenXml.OpenXmlElement = row1.CloneNode(True)
                    'Dim dupRow2 = row2.CloneNode(True)

                    'CeldaReemplazos(dupRow, -1, i)


                    For CeldaColumna As Long = 0 To row1.Elements(Of Wordprocessing.TableCell)().Count - 1
                        Try

                            '///////////////////////////
                            'renglon 1
                            '///////////////////////////

                            CeldaReemplazosNotaCredito(dupRow, CeldaColumna, i)


                            '///////////////////////////
                            'renglon 2
                            '///////////////////////////

                            '    CeldaReemplazos(dupRow2, CeldaColumna, i)
                            '    table.AppendChild(dupRow2)



                        Catch ex As Exception
                            ErrHandler.WriteError(ex)
                        End Try

                    Next

                    table.AppendChild(dupRow)


                Next

                table.RemoveChild(row1)
                'row2.Parent.RemoveChild(row2)





                '/////////////////////////////
                '/////////////////////////////
                'PIE
                '/////////////////////////////
                '/////////////////////////////

                For Each pie As FooterPart In wordDoc.MainDocumentPart.FooterParts
                    'Dim pie = wordDoc.MainDocumentPart.FooterParts.First
                    pie.GetStream()

                    docText = Nothing
                    sr = New StreamReader(pie.GetStream())

                    Using (sr)
                        docText = sr.ReadToEnd
                    End Using

                    regexReplace(docText, "observaciones", oFac.Observaciones)
                    regexReplace(docText, "lugarentrega", oFac.LugarEntrega)
                    regexReplace(docText, "libero", oFac.Aprobo)
                    regexReplace(docText, "fecharecepcion", oFac.Fecha)
                    regexReplace(docText, "jefesector", "")

                    regexReplace(docText, "#Subtotal#", FF2(oFac.SubTotal))
                    regexReplace(docText, "#IVA#", FF2(oFac.ImporteIva1))
                    regexReplace(docText, "#PorcIVA#", oFac.PorcentajeIva1)
                    regexReplace(docText, "#Total#", FF2(oFac.ImporteTotal))


                    sw = New StreamWriter(pie.GetStream(FileMode.Create))
                    Using (sw)
                        sw.Write(docText)
                    End Using
                Next


                'buscar bookmark http://openxmldeveloper.org/discussions/formats/f/13/p/2539/8302.aspx
                'Dim mainPart As MainDocumentPart = wordDoc.MainDocumentPart()
                'Dim bookmarkStart = mainPart.Document.Body.Descendants().Where(bms >= bms.Name = "testBookmark").SingleOrDefault()
                'Dim bookmarkEnd = mainPart.Document.Body.Descendants().Where(bme >= bme.Id.Value = bookmarkStart.Id.Value).SingleOrDefault()
                'BookmarkStart.Remove()
                'BookmarkEnd.Remove()




                mainPart.Document.Save()
                wordDoc.Close()


                Return plantilla
                'Return wordDoc.ToString
                'Return docText

            End Using
        End Function





        Shared Sub CreateWordProcessingDocument(ByVal Origen As String, ByVal Destino As String)
            'Getting Started with the Open XML SDK 2.0 for Microsoft Office
            'http://msdn.microsoft.com/en-us/library/bb456488.aspx

            'http://msdn.microsoft.com/en-us/library/ff478190.aspx


            'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template

            'http://stackoverflow.com/questions/4565185/iterating-xml-nodes-using-vba


            'http://msdn.microsoft.com/en-us/library/cc197932(v=office.12).aspx
            'http://stackoverflow.com/questions/3764585/wordml-templating-with-xml-schema-and-openxml-sdk
            'http://geekswithblogs.net/DanBedassa/archive/2009/01/16/dynamically-generating-word-2007-.docx-documents-using-.net.aspx
            'http://blogs.msdn.com/b/ericwhite/archive/2010/07/02/processing-all-content-parts-in-an-open-xml-wordprocessingml-document.aspx



            Dim docText As String
            ' Create a document by supplying the filepath.

            Using doc As WordprocessingDocument = _
                WordprocessingDocument.Open(Origen, WordprocessingDocumentType.Document)

                ' Add a main document part. 
                Dim mainPart As MainDocumentPart = doc.MainDocumentPart()



                Using sr = New StreamReader(doc.MainDocumentPart.GetStream())

                    docText = sr.ReadToEnd()
                End Using


                'mainPart.DeleteParts(mainPart.CustomXmlParts)
                'Dim customXmlPart As CustomXmlPart= mainPart.AddNewPart<CustomXmlPart>();
                'Dim ts As StreamWriter = New StreamWriter(CustomXmlPart.GetStream())
                'ts.Write(customXML)
            End Using



            Using destdoc As WordprocessingDocument = _
                WordprocessingDocument.Create(Destino, WordprocessingDocumentType.Document)

                Dim mainPart As MainDocumentPart = destdoc.AddMainDocumentPart
                mainPart.Document = New Wordprocessing.Document()

                Using sw = New StreamWriter(mainPart.GetStream(FileMode.Create))
                    sw.Write(docText)
                End Using

                mainPart.Document.Save()
                destdoc.Close()
            End Using


        End Sub



        ' To search and replace content in a document part. 
        Public Shared Sub FacturaXML_DOCX(ByVal document As String, ByVal oFac As Pronto.ERP.BO.Factura, ByVal SC As String)

            'Dim oFac As Pronto.ERP.BO.Requerimiento = CType(Me.ViewState(mKey), Pronto.ERP.BO.Requerimiento)


            Dim wordDoc As WordprocessingDocument = WordprocessingDocument.Open(document, True)



            Dim settings As New SimplifyMarkupSettings
            With settings
                .RemoveComments = True
                .RemoveContentControls = True
                .RemoveEndAndFootNotes = True
                .RemoveFieldCodes = False
                .RemoveLastRenderedPageBreak = True
                .RemovePermissions = True
                .RemoveProof = True
                .RemoveRsidInfo = True
                .RemoveSmartTags = True
                .RemoveSoftHyphens = True
                .ReplaceTabsWithSpaces = True
            End With
            MarkupSimplifier.SimplifyMarkup(wordDoc, settings)





            Using (wordDoc)
                Dim docText As String = Nothing
                Dim sr As StreamReader = New StreamReader(wordDoc.MainDocumentPart.GetStream)



                Using (sr)
                    docText = sr.ReadToEnd
                End Using

                '/////////////////////////////
                '/////////////////////////////
                'Hace el reemplazo
                '/////////////////////////////




                Try
                    oFac.Cliente = ClienteManager.GetItem(SC, oFac.IdCliente)
                    regexReplace(docText, "#Cliente#", oFac.Cliente.RazonSocial)
                    regexReplace(docText, "#CodigoCliente#", oFac.Cliente.CodigoCliente)


                    regexReplace(docText, "#Direccion#", oFac.Cliente.Direccion) 'oFac.Domicilio)
                    'regexReplace(docText, "#DomicilioRenglon2#", oFac.Domicilio) 'oFac.Domicilio)


                    regexReplace(docText, "#Localidad#", oFac.Cliente.Localidad) 'oFac.Domicilio)
                    regexReplace(docText, "#CUIT#", oFac.Cliente.Cuit)
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try

                regexReplace(docText, "#NumeroFactura#", oFac.Numero)
                regexReplace(docText, "#Fecha#", oFac.Fecha)
                regexReplace(docText, "#CondicionIVA#", oFac.CondicionIVADescripcion)
                regexReplace(docText, "#CondicionVenta#", oFac.CondicionVentaDescripcion)
                regexReplace(docText, "#CAE#", oFac.CAE)

                regexReplace(docText, "#Observaciones#", oFac.Observaciones)
                'regexReplace(docText, "lugarentrega", oFac.LugarEntrega)




                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'regexReplace(docText, "#Subtotal#", oFac.SubTotal)  'NO USAR. El reemplazo del pie está al final de esta funcion
                'regexReplace(docText, "#IVA#", oFac.ImporteIva1)
                'regexReplace(docText, "#Total#", oFac.Total)




                Dim sw As StreamWriter = New StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create))
                Using (sw)
                    sw.Write(docText)
                End Using







                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                Dim mainPart = wordDoc.MainDocumentPart
                'Dim contentBloc = mainPart.HeaderParts..Descendants(Of Wordprocessing.SdtBlock)().First

                'http://stackoverflow.com/questions/7026449/replacing-bookmarks-in-docx-file-using-openxml-sdk-and-c-cli
                'http://openxmldeveloper.org/blog/b/openxmldeveloper/archive/2011/09/01/how-to-retrieve-the-text-of-a-bookmark-from-an-openxml-wordprocessingml-document.aspx
                'http://openxmldeveloper.org/blog/b/openxmldeveloper/archive/2011/09/06/replacing-text-of-a-bookmark-in-an-openxml-wordprocessingml-document.aspx





                Dim formfield = wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.FormFieldData)().FirstOrDefault
                'Dim e = formfield.GetFirstChild(Of Wordprocessing.Enabled)()
                'e.Val = True
                'Dim parent = formfield.Parent
                'Dim runEEE = New Wordprocessing.Run(New Wordprocessing.Text("sfsdf"))
                'parent.ReplaceChild(runEEE, formfield)

                'Dim t = formfield.GetFirstChild(Of Wordprocessing.TextInput)()


                Dim bookmarkstartCliente = (From bookmark In _
                                 wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
                               Where bookmark.Name = "Cliente" _
                               Select bookmark).SingleOrDefault

                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/a/4725777/1054200
                'http://stackoverflow.com/a/4725777/1054200
                'http://stackoverflow.com/a/4725777/1054200
                'http://stackoverflow.com/a/4725777/1054200
                'Dim textoCliente = bmCliente.NextSibling(Of Wordprocessing.Run)()
                'If Not IsNull(textoCliente) Then
                '    Dim textito = textoCliente.GetFirstChild(Of Wordprocessing.Text)()
                '    textito.Text = "blah"
                'End If
                '
                '   
                '

                Try

                    Dim textoRellenar = "RazonSocial S.A." 'EntidadManager.NombreCliente(sc, oFac.IdCliente)

                    Dim bsText As DocumentFormat.OpenXml.OpenXmlElement = bookmarkstartCliente.NextSibling
                    If Not bsText Is Nothing Then
                        If TypeOf bsText Is Wordprocessing.BookmarkEnd Then
                            'Add Text element after start bookmark
                            bookmarkstartCliente.Parent.InsertAfter(New Wordprocessing.Run(New Wordprocessing.Text(textoRellenar)), _
                                                                    bookmarkstartCliente)
                        Else
                            'Change Bookmark Text
                            If TypeOf bsText Is Wordprocessing.Run Then
                                If bsText.GetFirstChild(Of Wordprocessing.Text)() Is Nothing Then
                                    'bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 2)
                                    'bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 1)
                                    bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 0)
                                End If
                                bsText.GetFirstChild(Of Wordprocessing.Text)().Text = textoRellenar 'bookmarkstartCliente.Name
                            End If
                        End If
                    End If

                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try




                'Dim ccWithTable As Wordprocessing.SdtBlock = mainPart.Document.Body.Descendants(Of Wordprocessing.SdtBlock)().Where _
                '                        (Function(r) r.SdtProperties.GetFirstChild(Of Wordprocessing.Tag)().Val = tblTag).Single()


                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                'CUERPO  (repetir renglones)
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                'http://msdn.microsoft.com/en-us/library/cc850835(office.14).aspx

                '///////////////////////////////////////////////////////////////////////////////////
                '   http://stackoverflow.com/a/3783607/1054200
                '@Matt S: I've put in a few extra links that should also help you get started. There are a number of ways 
                'to do repeaters with Content Controls - one is what you mentioned. The other way is to use Building Blocks. 
                'Another way is to kind of do the opposite of what you mentioned - put a table with just a header row and then 
                'create rows populated with CCs in the cells (creo que esto es lo que hago yo). Do take a look 
                'at the Word Content Control Kit as well - that will save your life in working with CCs until you 
                'become much more familiar. – Otaku Sep 25 '10 at 15:46
                '/////////////////////////////////////////////////////////////////////////////////////

                '  'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk




                '///////////////////////////////////////
                'en VBA, Edu busca el sector así:
                '
                '            Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
                '
                '-no encuentro en qué lugar dice "Detalles"!!! -ahí está (Ctrl-I). no sé como mostrarlos. Edu se maneja
                ' con bookmarks. Para hacer la migracion, debería imitar lo mas posible esa idea (haciendolo
                ' compatible, mostrando los bookmarks como placeholders, etc.
                ' APARECEN CON CORCHETES SI TIENEN UN ITEM. SI ES UNA UBICACION, APARECEN CON EL I-beam (una "I" grande)
                '- y cómo sé el nombre que tiene???????
                '///////////////////////////////////////

                'mostrar bookmarks en Word2007
                'http://www.google.com.ar/imgres?um=1&hl=es&safe=off&sa=N&biw=1163&bih=839&tbm=isch&tbnid=VBegw7vZDThDNM:&imgrefurl=http://www.howtogeek.com/76142/navigate-long-documents-in-word-2007-and-2010-using-bookmarks/&docid=lavUxX3WcLhNAM&imgurl=http://www.howtogeek.com/wp-content/uploads/2011/10/05_turning_on_show_bookmarks.png&w=544&h=414&ei=cNNiT7OYAoKgtwfd2eWLCA&zoom=1&iact=rc&dur=312&sig=101947458089387539527&page=1&tbnh=145&tbnw=191&start=0&ndsp=20&ved=1t:429,r:1,s:0&tx=113&ty=93

                '            Isn() 't there a way in Word 2007 to show all bookmarks in a document
                'In any version of Word, you can get the Bookmark dialog to display the names 
                'of all the bookmarks by both checking the "Hidden bookmarks" box *and* 
                'selecting "Sort by: Location." You can select any given bookmark name and 
                'click Go To to find it.

                '//////////////////////////////////////////////////////////////
                'cómo mostrar el tab de DEVELOPER en office
                'Click the Microsoft Office Button, and then click Excel Options, PowerPoint Options, or Word Options.
                'Click Popular, and then select the Show Developer tab in the Ribbon check box.
                '//////////////////////////////////////////////////////////////

                '//////////////////////////////////////////////////
                'en VBA, Edu busca el sector así:
                '
                '            Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
                '
                'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                '//////////////////////////////////////////////////////////




                Dim bookmarkDetalles = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
           Where bookmark.Name = "Detalles" Or bookmark.Name = "Detalle" _
           Select bookmark).FirstOrDefault


                Dim tempParent

                Dim placeholderCANT = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.Text)() _
                                          Where bookmark.Text = "#Descripcion#" _
                                          Select bookmark).FirstOrDefault

                If Not placeholderCANT Is Nothing Then
                    tempParent = placeholderCANT.Parent
                Else
                    tempParent = bookmarkDetalles.Parent
                End If



                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////

                'qué tabla contiene al bookmark "Detalles"? (es el que usa Edu en VBA)
                Dim table As Wordprocessing.Table

                ' Find the second row in the table.
                Dim row1 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(0)
                Dim row2 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(1)


                If True Then

                    'METODO B:
                    'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                    ' loop till we get the containing element in case bookmark is inside a table etc.
                    ' keep checking the element's parent and update it till we reach the Body
                    'Dim tempParent = bookmarkDetalles.Parent
                    Dim isInTable As Boolean = False

                    While Not TypeOf (tempParent.Parent) Is Wordprocessing.Body ',) <> mainPart.Document.Body
                        tempParent = tempParent.Parent
                        If (TypeOf (tempParent) Is Wordprocessing.TableRow And Not isInTable) Then
                            isInTable = True
                            Exit While
                        End If
                    End While

                    If isInTable Then
                        'table = tempParent
                        'no basta con saber la tabla. necesito saber la posicion del bookmark en la tabla
                        'table.ChildElements(
                        'bookmarkDetalles.
                        row1 = tempParent
                        table = row1.Parent
                    Else
                        Err.Raise(5454, "asdasdasa")
                    End If

                Else

                    '////////////////////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////////////////////
                    'METODO A:
                    ' Find the first table in the document.
                    table = wordDoc.MainDocumentPart.Document.Body.Elements(Of Wordprocessing.Table)().First

                End If

                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////







                ''Make a copy of the 2nd row (assumed that the 1st row is header) http://patrickyong.net/tags/openxml/
                'Dim rows = table.Elements(Of Wordprocessing.TableRow)()
                For Each i As FacturaItem In oFac.Detalles
                    Dim dupRow As DocumentFormat.OpenXml.OpenXmlElement = row1.CloneNode(True)
                    'Dim dupRow2 = row2.CloneNode(True)

                    'CeldaReemplazos(dupRow, -1, i)


                    For CeldaColumna As Long = 0 To row1.Elements(Of Wordprocessing.TableCell)().Count - 1
                        Try

                            '///////////////////////////
                            'renglon 1
                            '///////////////////////////

                            CeldaReemplazosFactura(dupRow, CeldaColumna, i)


                            '///////////////////////////
                            'renglon 2
                            '///////////////////////////

                            '    CeldaReemplazos(dupRow2, CeldaColumna, i)
                            '    table.AppendChild(dupRow2)



                        Catch ex As Exception
                            ErrHandler.WriteError(ex)
                        End Try

                    Next

                    table.AppendChild(dupRow)


                Next

                table.RemoveChild(row1)
                'row2.Parent.RemoveChild(row2)





                '/////////////////////////////
                '/////////////////////////////
                'PIE
                '/////////////////////////////
                '/////////////////////////////

                For Each pie As FooterPart In wordDoc.MainDocumentPart.FooterParts
                    'Dim pie = wordDoc.MainDocumentPart.FooterParts.First
                    pie.GetStream()

                    docText = Nothing
                    sr = New StreamReader(pie.GetStream())

                    Using (sr)
                        docText = sr.ReadToEnd
                    End Using

                    regexReplace(docText, "observaciones", oFac.Observaciones)
                    regexReplace(docText, "lugarentrega", oFac.LugarEntrega)
                    regexReplace(docText, "libero", oFac.Aprobo)
                    regexReplace(docText, "fecharecepcion", oFac.Fecha)
                    regexReplace(docText, "jefesector", "")

                    'regexReplace(docText, "#PorB#", FF2(oFac.PorcentajeBonificacion))
                    'regexReplace(docText, "#MontoBonif#", FF2(oFac.ImporteBonificacion))
                    'Subtotal = (FF2(oFac.Total) - FF2(oFac.ImporteIva1) - oFac.IBrutos) * (100 - oFac.PorcentajeBonificacion) / 100

                    regexReplace(docText, "#Subtotal#", FF2(oFac.Total) - FF2(oFac.ImporteIva1) - oFac.IBrutos)
                    regexReplace(docText, "#IVA#", FF2(oFac.ImporteIva1))
                    regexReplace(docText, "#IIBB#", oFac.IBrutos)
                    regexReplace(docText, "#Total#", FF2(oFac.Total))


                    sw = New StreamWriter(pie.GetStream(FileMode.Create))
                    Using (sw)
                        sw.Write(docText)
                    End Using
                Next


                'buscar bookmark http://openxmldeveloper.org/discussions/formats/f/13/p/2539/8302.aspx
                'Dim mainPart As MainDocumentPart = wordDoc.MainDocumentPart()
                'Dim bookmarkStart = mainPart.Document.Body.Descendants().Where(bms >= bms.Name = "testBookmark").SingleOrDefault()
                'Dim bookmarkEnd = mainPart.Document.Body.Descendants().Where(bme >= bme.Id.Value = bookmarkStart.Id.Value).SingleOrDefault()
                'BookmarkStart.Remove()
                'BookmarkEnd.Remove()



            End Using
        End Sub

        Public Shared Sub RemitoParaLDC_XML_DOCX_Williams(ByVal document As String, ByVal oFac As ProntoMVC.Data.Models.FertilizantesCupos, ByVal SC As String)

            'Dim oFac As Pronto.ERP.BO.Requerimiento = CType(Me.ViewState(mKey), Pronto.ERP.BO.Requerimiento)


            Dim wordDoc As WordprocessingDocument = WordprocessingDocument.Open(document, True)



            Dim settings As New SimplifyMarkupSettings
            With settings
                .RemoveComments = True
                .RemoveContentControls = True
                .RemoveEndAndFootNotes = True
                .RemoveFieldCodes = False
                .RemoveLastRenderedPageBreak = True
                .RemovePermissions = True
                .RemoveProof = True
                .RemoveRsidInfo = True
                .RemoveSmartTags = True
                .RemoveSoftHyphens = True
                .ReplaceTabsWithSpaces = True
            End With
            MarkupSimplifier.SimplifyMarkup(wordDoc, settings)





            Using (wordDoc)
                Dim docText As String = Nothing
                Dim sr As StreamReader = New StreamReader(wordDoc.MainDocumentPart.GetStream)



                Using (sr)
                    docText = sr.ReadToEnd
                End Using

                '/////////////////////////////
                '/////////////////////////////
                'Hace el reemplazo
                '/////////////////////////////




                Try
                    'oFac.Cliente = ClienteManager.GetItem(SC, oFac.IdCliente)
                    'regexReplace(docText, "#Cliente#", oFac.Cliente.RazonSocial)
                    'regexReplace(docText, "#CodigoCliente#", oFac.Cliente.CodigoCliente)


                    'regexReplace(docText, "#Direccion#", oFac.Cliente.Direccion) 'oFac.Domicilio)
                    'regexReplace(docText, "#DomicilioRenglon2#", oFac.Domicilio) 'oFac.Domicilio)


                    'regexReplace(docText, "#Localidad#", oFac.Cliente.Localidad) 'oFac.Domicilio)
                    'regexReplace(docText, "#CUIT#", oFac.Cliente.Cuit)
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try

                regexReplace(docText, "#NumeroFactura#", oFac.NumeradorTexto)
                'regexReplace(docText, "#Fecha#", oFac.Fecha)
                'regexReplace(docText, "#CondicionIVA#", oFac.CondicionIVADescripcion)
                'regexReplace(docText, "#CondicionVenta#", oFac.CondicionVentaDescripcion)
                'regexReplace(docText, "#CAE#", oFac.CAE)

                regexReplace(docText, "#Observaciones#", oFac.Observaciones)
                'regexReplace(docText, "lugarentrega", oFac.LugarEntrega)


                regexReplace(docText, "#Fecha#", Convert.ToDateTime(If(oFac.FechaIngreso, DateTime.MinValue)).ToShortDateString)
                regexReplace(docText, "#Cliente#", If(oFac.Cliente1 IsNot Nothing, oFac.Cliente1.RazonSocial, ""))
                regexReplace(docText, "#Direccion#", If(oFac.Cliente1 IsNot Nothing, oFac.Cliente1.Direccion, ""))
                regexReplace(docText, "#CUIT#", If(oFac.Cliente1 IsNot Nothing, oFac.Cliente1.Cuit, ""))
                regexReplace(docText, "#IVA#", 0)
                regexReplace(docText, "#Transportista#", If(oFac.Transportista1 IsNot Nothing, oFac.Transportista1.RazonSocial, ""))
                regexReplace(docText, "#CUIT_Transportista#", If(oFac.Transportista1 IsNot Nothing, oFac.Transportista1.Cuit, ""))
                regexReplace(docText, "#DomicilioTransportista#", If(oFac.Transportista1 IsNot Nothing, oFac.Transportista1.Direccion, ""))
                regexReplace(docText, "#Producto#", If(oFac.Transportista1 IsNot Nothing, oFac.Articulo.Descripcion, ""))
                regexReplace(docText, "#Composicion#",
                                     If(oFac.Articulo1 IsNot Nothing, oFac.Articulo1.Descripcion + " " + oFac.Porcentaje1.ToString + "%" + vbCrLf, "") & _
                                     If(oFac.Articulo2 IsNot Nothing, oFac.Articulo2.Descripcion + " " + oFac.Porcentaje2.ToString + "%" + vbCrLf, "") & _
                                     If(oFac.Articulo3 IsNot Nothing, oFac.Articulo3.Descripcion + " " + oFac.Porcentaje3.ToString + "%" + vbCrLf, "") & _
                                     If(oFac.Articulo4 IsNot Nothing, oFac.Articulo4.Descripcion + " " + oFac.Porcentaje4.ToString + "%" + vbCrLf, "") & _
                    "")
                regexReplace(docText, "#FormaDespacho#", NombreFormaDespacho(SC, If(oFac.FormaDespacho, 0)))
                regexReplace(docText, "#Bruto#", If(oFac.Bruto, 0))
                regexReplace(docText, "#Tara#", If(oFac.Tara, 0))
                regexReplace(docText, "#Neto#", If(oFac.Cantidad, 0))



                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'regexReplace(docText, "#Subtotal#", oFac.SubTotal)  'NO USAR. El reemplazo del pie está al final de esta funcion
                'regexReplace(docText, "#IVA#", oFac.ImporteIva1)
                'regexReplace(docText, "#Total#", oFac.Total)




                Dim sw As StreamWriter = New StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create))
                Using (sw)
                    sw.Write(docText)
                End Using







                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                Dim mainPart = wordDoc.MainDocumentPart
                'Dim contentBloc = mainPart.HeaderParts..Descendants(Of Wordprocessing.SdtBlock)().First

                'http://stackoverflow.com/questions/7026449/replacing-bookmarks-in-docx-file-using-openxml-sdk-and-c-cli
                'http://openxmldeveloper.org/blog/b/openxmldeveloper/archive/2011/09/01/how-to-retrieve-the-text-of-a-bookmark-from-an-openxml-wordprocessingml-document.aspx
                'http://openxmldeveloper.org/blog/b/openxmldeveloper/archive/2011/09/06/replacing-text-of-a-bookmark-in-an-openxml-wordprocessingml-document.aspx





                Dim formfield = wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.FormFieldData)().FirstOrDefault
                'Dim e = formfield.GetFirstChild(Of Wordprocessing.Enabled)()
                'e.Val = True
                'Dim parent = formfield.Parent
                'Dim runEEE = New Wordprocessing.Run(New Wordprocessing.Text("sfsdf"))
                'parent.ReplaceChild(runEEE, formfield)

                'Dim t = formfield.GetFirstChild(Of Wordprocessing.TextInput)()


                Dim bookmarkstartCliente = (From bookmark In _
                                 wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
                               Where bookmark.Name = "Cliente" _
                               Select bookmark).SingleOrDefault

                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/a/4725777/1054200
                'http://stackoverflow.com/a/4725777/1054200
                'http://stackoverflow.com/a/4725777/1054200
                'http://stackoverflow.com/a/4725777/1054200
                'Dim textoCliente = bmCliente.NextSibling(Of Wordprocessing.Run)()
                'If Not IsNull(textoCliente) Then
                '    Dim textito = textoCliente.GetFirstChild(Of Wordprocessing.Text)()
                '    textito.Text = "blah"
                'End If
                '
                '   
                '

                Try

                    Dim textoRellenar = "RazonSocial S.A." 'EntidadManager.NombreCliente(sc, oFac.IdCliente)

                    Dim bsText As DocumentFormat.OpenXml.OpenXmlElement = bookmarkstartCliente.NextSibling
                    If Not bsText Is Nothing Then
                        If TypeOf bsText Is Wordprocessing.BookmarkEnd Then
                            'Add Text element after start bookmark
                            bookmarkstartCliente.Parent.InsertAfter(New Wordprocessing.Run(New Wordprocessing.Text(textoRellenar)), _
                                                                    bookmarkstartCliente)
                        Else
                            'Change Bookmark Text
                            If TypeOf bsText Is Wordprocessing.Run Then
                                If bsText.GetFirstChild(Of Wordprocessing.Text)() Is Nothing Then
                                    'bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 2)
                                    'bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 1)
                                    bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 0)
                                End If
                                bsText.GetFirstChild(Of Wordprocessing.Text)().Text = textoRellenar 'bookmarkstartCliente.Name
                            End If
                        End If
                    End If

                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try




                'Dim ccWithTable As Wordprocessing.SdtBlock = mainPart.Document.Body.Descendants(Of Wordprocessing.SdtBlock)().Where _
                '                        (Function(r) r.SdtProperties.GetFirstChild(Of Wordprocessing.Tag)().Val = tblTag).Single()


                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                'CUERPO  (repetir renglones)
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                'http://msdn.microsoft.com/en-us/library/cc850835(office.14).aspx

                '///////////////////////////////////////////////////////////////////////////////////
                '   http://stackoverflow.com/a/3783607/1054200
                '@Matt S: I've put in a few extra links that should also help you get started. There are a number of ways 
                'to do repeaters with Content Controls - one is what you mentioned. The other way is to use Building Blocks. 
                'Another way is to kind of do the opposite of what you mentioned - put a table with just a header row and then 
                'create rows populated with CCs in the cells (creo que esto es lo que hago yo). Do take a look 
                'at the Word Content Control Kit as well - that will save your life in working with CCs until you 
                'become much more familiar. – Otaku Sep 25 '10 at 15:46
                '/////////////////////////////////////////////////////////////////////////////////////

                '  'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk




                '///////////////////////////////////////
                'en VBA, Edu busca el sector así:
                '
                '            Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
                '
                '-no encuentro en qué lugar dice "Detalles"!!! -ahí está (Ctrl-I). no sé como mostrarlos. Edu se maneja
                ' con bookmarks. Para hacer la migracion, debería imitar lo mas posible esa idea (haciendolo
                ' compatible, mostrando los bookmarks como placeholders, etc.
                ' APARECEN CON CORCHETES SI TIENEN UN ITEM. SI ES UNA UBICACION, APARECEN CON EL I-beam (una "I" grande)
                '- y cómo sé el nombre que tiene???????
                '///////////////////////////////////////

                'mostrar bookmarks en Word2007
                'http://www.google.com.ar/imgres?um=1&hl=es&safe=off&sa=N&biw=1163&bih=839&tbm=isch&tbnid=VBegw7vZDThDNM:&imgrefurl=http://www.howtogeek.com/76142/navigate-long-documents-in-word-2007-and-2010-using-bookmarks/&docid=lavUxX3WcLhNAM&imgurl=http://www.howtogeek.com/wp-content/uploads/2011/10/05_turning_on_show_bookmarks.png&w=544&h=414&ei=cNNiT7OYAoKgtwfd2eWLCA&zoom=1&iact=rc&dur=312&sig=101947458089387539527&page=1&tbnh=145&tbnw=191&start=0&ndsp=20&ved=1t:429,r:1,s:0&tx=113&ty=93

                '            Isn() 't there a way in Word 2007 to show all bookmarks in a document
                'In any version of Word, you can get the Bookmark dialog to display the names 
                'of all the bookmarks by both checking the "Hidden bookmarks" box *and* 
                'selecting "Sort by: Location." You can select any given bookmark name and 
                'click Go To to find it.

                '//////////////////////////////////////////////////////////////
                'cómo mostrar el tab de DEVELOPER en office
                'Click the Microsoft Office Button, and then click Excel Options, PowerPoint Options, or Word Options.
                'Click Popular, and then select the Show Developer tab in the Ribbon check box.
                '//////////////////////////////////////////////////////////////

                '//////////////////////////////////////////////////
                'en VBA, Edu busca el sector así:
                '
                '            Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
                '
                'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                '//////////////////////////////////////////////////////////




                '     Dim bookmarkDetalles = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
                'Where bookmark.Name = "Detalles" Or bookmark.Name = "Detalle" _
                'Select bookmark).FirstOrDefault


                '     Dim tempParent

                '     Dim placeholderCANT = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.Text)() _
                '                               Where bookmark.Text = "#Descripcion#" _
                '                               Select bookmark).FirstOrDefault

                '     If Not placeholderCANT Is Nothing Then
                '         tempParent = placeholderCANT.Parent
                '     Else
                '         tempParent = bookmarkDetalles.Parent
                '     End If



                '     '////////////////////////////////////////////////////////////////////////////////////
                '     '////////////////////////////////////////////////////////////////////////////////////
                '     '////////////////////////////////////////////////////////////////////////////////////
                '     '////////////////////////////////////////////////////////////////////////////////////

                '     'qué tabla contiene al bookmark "Detalles"? (es el que usa Edu en VBA)
                '     Dim table As Wordprocessing.Table

                '     ' Find the second row in the table.
                '     Dim row1 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(0)
                '     Dim row2 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(1)


                '     If True Then

                '         'METODO B:
                '         'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                '         ' loop till we get the containing element in case bookmark is inside a table etc.
                '         ' keep checking the element's parent and update it till we reach the Body
                '         'Dim tempParent = bookmarkDetalles.Parent
                '         Dim isInTable As Boolean = False

                '         While Not TypeOf (tempParent.Parent) Is Wordprocessing.Body ',) <> mainPart.Document.Body
                '             tempParent = tempParent.Parent
                '             If (TypeOf (tempParent) Is Wordprocessing.TableRow And Not isInTable) Then
                '                 isInTable = True
                '                 Exit While
                '             End If
                '         End While

                '         If isInTable Then
                '             'table = tempParent
                '             'no basta con saber la tabla. necesito saber la posicion del bookmark en la tabla
                '             'table.ChildElements(
                '             'bookmarkDetalles.
                '             row1 = tempParent
                '             table = row1.Parent
                '         Else
                '             Err.Raise(5454, "asdasdasa")
                '         End If

                '     Else

                '         '////////////////////////////////////////////////////////////////////////////////////
                '         '////////////////////////////////////////////////////////////////////////////////////
                '         'METODO A:
                '         ' Find the first table in the document.
                '         table = wordDoc.MainDocumentPart.Document.Body.Elements(Of Wordprocessing.Table)().First

                '     End If

                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////





                '/////////////////////////////
                '/////////////////////////////
                'PIE
                '/////////////////////////////
                '/////////////////////////////

                For Each pie As FooterPart In wordDoc.MainDocumentPart.FooterParts
                    'Dim pie = wordDoc.MainDocumentPart.FooterParts.First
                    pie.GetStream()

                    docText = Nothing
                    sr = New StreamReader(pie.GetStream())

                    Using (sr)
                        docText = sr.ReadToEnd
                    End Using


                    regexReplace(docText, "#transporte#", If(oFac.Transportista1 IsNot Nothing, oFac.Transportista1.RazonSocial, ""))
                    regexReplace(docText, "#patente#", oFac.Chasis)
                    regexReplace(docText, "#acoplado#", oFac.Acoplado)
                    regexReplace(docText, "#chofer#", If(oFac.Chofere IsNot Nothing, oFac.Chofere.Nombre, ""))
                    regexReplace(docText, "#CUIL#", If(oFac.Chofere IsNot Nothing, oFac.Chofere.Cuil, ""))


                    'regexReplace(docText, "lugarentrega", oFac.LugarEntrega)
                    'regexReplace(docText, "libero", oFac.Aprobo)
                    'regexReplace(docText, "fecharecepcion", oFac.Fecha)
                    'regexReplace(docText, "jefesector", "")

                    ''regexReplace(docText, "#PorB#", FF2(oFac.PorcentajeBonificacion))
                    ''regexReplace(docText, "#MontoBonif#", FF2(oFac.ImporteBonificacion))
                    ''Subtotal = (FF2(oFac.Total) - FF2(oFac.ImporteIva1) - oFac.IBrutos) * (100 - oFac.PorcentajeBonificacion) / 100

                    'regexReplace(docText, "#Subtotal#", FF2(oFac.Total) - FF2(oFac.ImporteIva1) - oFac.IBrutos)
                    'regexReplace(docText, "#IVA#", FF2(oFac.ImporteIva1))
                    'regexReplace(docText, "#IIBB#", oFac.IBrutos)
                    'regexReplace(docText, "#Total#", FF2(oFac.Total))


                    sw = New StreamWriter(pie.GetStream(FileMode.Create))
                    Using (sw)
                        sw.Write(docText)
                    End Using
                Next


                'buscar bookmark http://openxmldeveloper.org/discussions/formats/f/13/p/2539/8302.aspx
                'Dim mainPart As MainDocumentPart = wordDoc.MainDocumentPart()
                'Dim bookmarkStart = mainPart.Document.Body.Descendants().Where(bms >= bms.Name = "testBookmark").SingleOrDefault()
                'Dim bookmarkEnd = mainPart.Document.Body.Descendants().Where(bme >= bme.Id.Value = bookmarkStart.Id.Value).SingleOrDefault()
                'BookmarkStart.Remove()
                'BookmarkEnd.Remove()



            End Using
        End Sub

        Public Shared Sub OrdenCarga_XML_DOCX_Williams(ByVal document As String, ByVal oFac As ProntoMVC.Data.Models.FertilizantesCupos, ByVal SC As String)

            'Dim oFac As Pronto.ERP.BO.Requerimiento = CType(Me.ViewState(mKey), Pronto.ERP.BO.Requerimiento)


            Dim wordDoc As WordprocessingDocument = WordprocessingDocument.Open(document, True)



            Dim settings As New SimplifyMarkupSettings
            With settings
                .RemoveComments = True
                .RemoveContentControls = True
                .RemoveEndAndFootNotes = True
                .RemoveFieldCodes = False
                .RemoveLastRenderedPageBreak = True
                .RemovePermissions = True
                .RemoveProof = True
                .RemoveRsidInfo = True
                .RemoveSmartTags = True
                .RemoveSoftHyphens = True
                .ReplaceTabsWithSpaces = True
            End With
            MarkupSimplifier.SimplifyMarkup(wordDoc, settings)





            Using (wordDoc)
                Dim docText As String = Nothing
                Dim sr As StreamReader = New StreamReader(wordDoc.MainDocumentPart.GetStream)



                Using (sr)
                    docText = sr.ReadToEnd
                End Using

                '/////////////////////////////
                '/////////////////////////////
                'Hace el reemplazo
                '/////////////////////////////




                Try
                    'oFac.Cliente = ClienteManager.GetItem(SC, oFac.IdCliente)
                    'regexReplace(docText, "#Cliente#", oFac.Cliente.RazonSocial)
                    'regexReplace(docText, "#CodigoCliente#", oFac.Cliente.CodigoCliente)


                    'regexReplace(docText, "#Direccion#", oFac.Cliente.Direccion) 'oFac.Domicilio)
                    'regexReplace(docText, "#DomicilioRenglon2#", oFac.Domicilio) 'oFac.Domicilio)


                    'regexReplace(docText, "#Localidad#", oFac.Cliente.Localidad) 'oFac.Domicilio)
                    'regexReplace(docText, "#CUIT#", oFac.Cliente.Cuit)
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try

                regexReplace(docText, "#NumeroFactura#", oFac.NumeradorTexto)
                'regexReplace(docText, "#Fecha#", oFac.Fecha)
                'regexReplace(docText, "#CondicionIVA#", oFac.CondicionIVADescripcion)
                'regexReplace(docText, "#CondicionVenta#", oFac.CondicionVentaDescripcion)
                'regexReplace(docText, "#CAE#", oFac.CAE)

                regexReplace(docText, "#Observaciones#", oFac.Observaciones)
                'regexReplace(docText, "lugarentrega", oFac.LugarEntrega)

                regexReplace(docText, "#Fecha#", Convert.ToDateTime(oFac.FechaIngreso).ToShortDateString)
                regexReplace(docText, "#cupo#", oFac.NumeradorTexto)
                regexReplace(docText, "#despacho#", oFac.Despacho)
                regexReplace(docText, "#Cliente#", If(oFac.Cliente1 IsNot Nothing, oFac.Cliente1.RazonSocial, ""))
                regexReplace(docText, "#Producto#", If(oFac.Articulo IsNot Nothing, oFac.Articulo.Descripcion, ""))
                regexReplace(docText, "#Contrato#", oFac.Contrato)
                regexReplace(docText, "#FormaDespacho#", NombreFormaDespacho(SC, If(oFac.FormaDespacho, 0)))
                regexReplace(docText, "#Cantidad#", If(oFac.Cantidad, 0))
                regexReplace(docText, "#Maximo#", If(oFac.KilosMaximo, 0))
                regexReplace(docText, "#Chofer#", If(oFac.Chofere IsNot Nothing, oFac.Chofere.Nombre, ""))
                regexReplace(docText, "#CUIL#", If(oFac.Chofere IsNot Nothing, oFac.Chofere.Cuil, ""))
                regexReplace(docText, "#chasis#", oFac.Chasis)
                regexReplace(docText, "#acoplado#", oFac.Acoplado)
                regexReplace(docText, "#destino#", NombreDestino(SC, oFac.Destino))



                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'NO USAR. El reemplazo del pie está al final de esta funcion
                'regexReplace(docText, "#Subtotal#", oFac.SubTotal)  'NO USAR. El reemplazo del pie está al final de esta funcion
                'regexReplace(docText, "#IVA#", oFac.ImporteIva1)
                'regexReplace(docText, "#Total#", oFac.Total)




                Dim sw As StreamWriter = New StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create))
                Using (sw)
                    sw.Write(docText)
                End Using







                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                Dim mainPart = wordDoc.MainDocumentPart
                'Dim contentBloc = mainPart.HeaderParts..Descendants(Of Wordprocessing.SdtBlock)().First

                'http://stackoverflow.com/questions/7026449/replacing-bookmarks-in-docx-file-using-openxml-sdk-and-c-cli
                'http://openxmldeveloper.org/blog/b/openxmldeveloper/archive/2011/09/01/how-to-retrieve-the-text-of-a-bookmark-from-an-openxml-wordprocessingml-document.aspx
                'http://openxmldeveloper.org/blog/b/openxmldeveloper/archive/2011/09/06/replacing-text-of-a-bookmark-in-an-openxml-wordprocessingml-document.aspx





                Dim formfield = wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.FormFieldData)().FirstOrDefault
                'Dim e = formfield.GetFirstChild(Of Wordprocessing.Enabled)()
                'e.Val = True
                'Dim parent = formfield.Parent
                'Dim runEEE = New Wordprocessing.Run(New Wordprocessing.Text("sfsdf"))
                'parent.ReplaceChild(runEEE, formfield)

                'Dim t = formfield.GetFirstChild(Of Wordprocessing.TextInput)()


                Dim bookmarkstartCliente = (From bookmark In _
                                 wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
                               Where bookmark.Name = "Cliente" _
                               Select bookmark).SingleOrDefault

                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/questions/3308299/replace-bookmark-text-in-word-file-using-open-xml-sdk
                'http://stackoverflow.com/a/4725777/1054200
                'http://stackoverflow.com/a/4725777/1054200
                'http://stackoverflow.com/a/4725777/1054200
                'http://stackoverflow.com/a/4725777/1054200
                'Dim textoCliente = bmCliente.NextSibling(Of Wordprocessing.Run)()
                'If Not IsNull(textoCliente) Then
                '    Dim textito = textoCliente.GetFirstChild(Of Wordprocessing.Text)()
                '    textito.Text = "blah"
                'End If
                '
                '   
                '

                Try

                    Dim textoRellenar = "RazonSocial S.A." 'EntidadManager.NombreCliente(sc, oFac.IdCliente)

                    Dim bsText As DocumentFormat.OpenXml.OpenXmlElement = bookmarkstartCliente.NextSibling
                    If Not bsText Is Nothing Then
                        If TypeOf bsText Is Wordprocessing.BookmarkEnd Then
                            'Add Text element after start bookmark
                            bookmarkstartCliente.Parent.InsertAfter(New Wordprocessing.Run(New Wordprocessing.Text(textoRellenar)), _
                                                                    bookmarkstartCliente)
                        Else
                            'Change Bookmark Text
                            If TypeOf bsText Is Wordprocessing.Run Then
                                If bsText.GetFirstChild(Of Wordprocessing.Text)() Is Nothing Then
                                    'bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 2)
                                    'bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 1)
                                    bsText.InsertAt(New Wordprocessing.Text(textoRellenar), 0)
                                End If
                                bsText.GetFirstChild(Of Wordprocessing.Text)().Text = textoRellenar 'bookmarkstartCliente.Name
                            End If
                        End If
                    End If

                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try




                'Dim ccWithTable As Wordprocessing.SdtBlock = mainPart.Document.Body.Descendants(Of Wordprocessing.SdtBlock)().Where _
                '                        (Function(r) r.SdtProperties.GetFirstChild(Of Wordprocessing.Tag)().Val = tblTag).Single()


                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                'CUERPO  (repetir renglones)
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                'http://msdn.microsoft.com/en-us/library/cc850835(office.14).aspx

                '///////////////////////////////////////////////////////////////////////////////////
                '   http://stackoverflow.com/a/3783607/1054200
                '@Matt S: I've put in a few extra links that should also help you get started. There are a number of ways 
                'to do repeaters with Content Controls - one is what you mentioned. The other way is to use Building Blocks. 
                'Another way is to kind of do the opposite of what you mentioned - put a table with just a header row and then 
                'create rows populated with CCs in the cells (creo que esto es lo que hago yo). Do take a look 
                'at the Word Content Control Kit as well - that will save your life in working with CCs until you 
                'become much more familiar. – Otaku Sep 25 '10 at 15:46
                '/////////////////////////////////////////////////////////////////////////////////////

                '  'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk




                '///////////////////////////////////////
                'en VBA, Edu busca el sector así:
                '
                '            Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
                '
                '-no encuentro en qué lugar dice "Detalles"!!! -ahí está (Ctrl-I). no sé como mostrarlos. Edu se maneja
                ' con bookmarks. Para hacer la migracion, debería imitar lo mas posible esa idea (haciendolo
                ' compatible, mostrando los bookmarks como placeholders, etc.
                ' APARECEN CON CORCHETES SI TIENEN UN ITEM. SI ES UNA UBICACION, APARECEN CON EL I-beam (una "I" grande)
                '- y cómo sé el nombre que tiene???????
                '///////////////////////////////////////

                'mostrar bookmarks en Word2007
                'http://www.google.com.ar/imgres?um=1&hl=es&safe=off&sa=N&biw=1163&bih=839&tbm=isch&tbnid=VBegw7vZDThDNM:&imgrefurl=http://www.howtogeek.com/76142/navigate-long-documents-in-word-2007-and-2010-using-bookmarks/&docid=lavUxX3WcLhNAM&imgurl=http://www.howtogeek.com/wp-content/uploads/2011/10/05_turning_on_show_bookmarks.png&w=544&h=414&ei=cNNiT7OYAoKgtwfd2eWLCA&zoom=1&iact=rc&dur=312&sig=101947458089387539527&page=1&tbnh=145&tbnw=191&start=0&ndsp=20&ved=1t:429,r:1,s:0&tx=113&ty=93

                '            Isn() 't there a way in Word 2007 to show all bookmarks in a document
                'In any version of Word, you can get the Bookmark dialog to display the names 
                'of all the bookmarks by both checking the "Hidden bookmarks" box *and* 
                'selecting "Sort by: Location." You can select any given bookmark name and 
                'click Go To to find it.

                '//////////////////////////////////////////////////////////////
                'cómo mostrar el tab de DEVELOPER en office
                'Click the Microsoft Office Button, and then click Excel Options, PowerPoint Options, or Word Options.
                'Click Popular, and then select the Show Developer tab in the Ribbon check box.
                '//////////////////////////////////////////////////////////////

                '//////////////////////////////////////////////////
                'en VBA, Edu busca el sector así:
                '
                '            Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
                '
                'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                '//////////////////////////////////////////////////////////




                '     Dim bookmarkDetalles = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
                'Where bookmark.Name = "Detalles" Or bookmark.Name = "Detalle" _
                'Select bookmark).FirstOrDefault


                '     Dim tempParent

                '     Dim placeholderCANT = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.Text)() _
                '                               Where bookmark.Text = "#Descripcion#" _
                '                               Select bookmark).FirstOrDefault

                '     If Not placeholderCANT Is Nothing Then
                '         tempParent = placeholderCANT.Parent
                '     Else
                '         tempParent = bookmarkDetalles.Parent
                '     End If



                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////

                ''qué tabla contiene al bookmark "Detalles"? (es el que usa Edu en VBA)
                'Dim table As Wordprocessing.Table

                '' Find the second row in the table.
                'Dim row1 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(0)
                'Dim row2 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(1)


                'If True Then

                '    'METODO B:
                '    'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                '    ' loop till we get the containing element in case bookmark is inside a table etc.
                '    ' keep checking the element's parent and update it till we reach the Body
                '    'Dim tempParent = bookmarkDetalles.Parent
                '    Dim isInTable As Boolean = False

                '    While Not TypeOf (tempParent.Parent) Is Wordprocessing.Body ',) <> mainPart.Document.Body
                '        tempParent = tempParent.Parent
                '        If (TypeOf (tempParent) Is Wordprocessing.TableRow And Not isInTable) Then
                '            isInTable = True
                '            Exit While
                '        End If
                '    End While

                '    If isInTable Then
                '        'table = tempParent
                '        'no basta con saber la tabla. necesito saber la posicion del bookmark en la tabla
                '        'table.ChildElements(
                '        'bookmarkDetalles.
                '        row1 = tempParent
                '        table = row1.Parent
                '    Else
                '        Err.Raise(5454, "asdasdasa")
                '    End If

                'Else

                '    '////////////////////////////////////////////////////////////////////////////////////
                '    '////////////////////////////////////////////////////////////////////////////////////
                '    'METODO A:
                '    ' Find the first table in the document.
                '    table = wordDoc.MainDocumentPart.Document.Body.Elements(Of Wordprocessing.Table)().First

                'End If

                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////







                ''Make a copy of the 2nd row (assumed that the 1st row is header) http://patrickyong.net/tags/openxml/
                'Dim rows = table.Elements(Of Wordprocessing.TableRow)()





                '/////////////////////////////
                '/////////////////////////////
                'PIE
                '/////////////////////////////
                '/////////////////////////////

                For Each pie As FooterPart In wordDoc.MainDocumentPart.FooterParts
                    'Dim pie = wordDoc.MainDocumentPart.FooterParts.First
                    pie.GetStream()

                    docText = Nothing
                    sr = New StreamReader(pie.GetStream())

                    Using (sr)
                        docText = sr.ReadToEnd
                    End Using

                    regexReplace(docText, "observaciones", oFac.Observaciones)
                    'regexReplace(docText, "lugarentrega", oFac.LugarEntrega)
                    'regexReplace(docText, "libero", oFac.Aprobo)
                    'regexReplace(docText, "fecharecepcion", oFac.Fecha)
                    regexReplace(docText, "jefesector", "")


                    'regexReplace(docText, "#PorB#", FF2(oFac.PorcentajeBonificacion))
                    'regexReplace(docText, "#MontoBonif#", FF2(oFac.ImporteBonificacion))
                    'Subtotal = (FF2(oFac.Total) - FF2(oFac.ImporteIva1) - oFac.IBrutos) * (100 - oFac.PorcentajeBonificacion) / 100

                    'regexReplace(docText, "#Subtotal#", FF2(oFac.Total) - FF2(oFac.ImporteIva1) - oFac.IBrutos)
                    'regexReplace(docText, "#IVA#", FF2(oFac.ImporteIva1))
                    'regexReplace(docText, "#IIBB#", oFac.IBrutos)
                    'regexReplace(docText, "#Total#", FF2(oFac.Total))


                    sw = New StreamWriter(pie.GetStream(FileMode.Create))
                    Using (sw)
                        sw.Write(docText)
                    End Using
                Next


                'buscar bookmark http://openxmldeveloper.org/discussions/formats/f/13/p/2539/8302.aspx
                'Dim mainPart As MainDocumentPart = wordDoc.MainDocumentPart()
                'Dim bookmarkStart = mainPart.Document.Body.Descendants().Where(bms >= bms.Name = "testBookmark").SingleOrDefault()
                'Dim bookmarkEnd = mainPart.Document.Body.Descendants().Where(bme >= bme.Id.Value = bookmarkStart.Id.Value).SingleOrDefault()
                'BookmarkStart.Remove()
                'BookmarkEnd.Remove()



            End Using
        End Sub


        Public Shared Sub RequerimientoXML_DOCX(ByVal document As String, ByVal oFac As Pronto.ERP.BO.Requerimiento, ByVal SC As String)

            'Dim oFac As Pronto.ERP.BO.Requerimiento = CType(Me.ViewState(mKey), Pronto.ERP.BO.Requerimiento)


            Dim wordDoc As WordprocessingDocument = WordprocessingDocument.Open(document, True)



            Dim settings As New SimplifyMarkupSettings
            With settings
                .RemoveComments = True
                .RemoveContentControls = True
                .RemoveEndAndFootNotes = True
                .RemoveFieldCodes = False
                .RemoveLastRenderedPageBreak = True
                .RemovePermissions = True
                .RemoveProof = True
                .RemoveRsidInfo = True
                .RemoveSmartTags = True
                .RemoveSoftHyphens = True
                .ReplaceTabsWithSpaces = True
            End With
            MarkupSimplifier.SimplifyMarkup(wordDoc, settings)





            Using (wordDoc)
                Dim docText As String = Nothing
                Dim sr As StreamReader = New StreamReader(wordDoc.MainDocumentPart.GetStream)



                Using (sr)
                    docText = sr.ReadToEnd
                End Using

                '/////////////////////////////
                '/////////////////////////////
                'ENCABEZADO
                'Hace el reemplazo
                '/////////////////////////////
                With oFac

                    regexReplace(docText, "#Cliente#", oFac.Sector)
                    'regexReplace(docText, "#CodigoCliente#", oFac.Cliente.CodigoCliente)
                    'regexReplace(docText, "#Direccion#", oFac.Cliente.Direccion) 'oFac.Domicilio)
                    'regexReplace(docText, "#Localidad#", oFac.Cliente.Localidad) 'oFac.Domicilio)



                    'regexReplace(docText, "#CUIT#", oFac.Cliente.Cuit)

                    regexReplace(docText, "#Numero#", oFac.Numero)
                    regexReplace(docText, "#Fecha#", oFac.Fecha)
                    'regexReplace(docText, "#CondicionIVA#", oFac.CondicionIVADescripcion)
                    'regexReplace(docText, "#CondicionVenta#", oFac.CondicionVentaDescripcion)
                    'regexReplace(docText, "#CAE#", oFac.CAE)

                    regexReplace(docText, "#Observaciones#", oFac.Observaciones)


                    regexReplace(docText, "#Detalle#", oFac.Detalle)


                    regexReplace(docText, "#Solicito#", oFac.Solicito)
                    regexReplace(docText, "#Sector#", oFac.Sector)

                    regexReplace(docText, "#Tipo#", "Obra") ' oFac.tipo) obra
                    regexReplace(docText, "#TipoDes#", NombreObra(SC, .IdObra)) ' oFac.TipoDes) codigo obra
                    regexReplace(docText, "#TipoDes1#", "") ' NombreObr(SC, .IdObra)) 'oFac.TipoDes1) nombre obra

                End With

                Dim sw As StreamWriter = New StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create))
                Using (sw)
                    sw.Write(docText)
                End Using


                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                'CUERPO  (repetir renglones)
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                'http://msdn.microsoft.com/en-us/library/cc850835(office.14).aspx
                '///////////////////////////////////////////////////////////////////////////////////
                '   http://stackoverflow.com/a/3783607/1054200
                '@Matt S: I've put in a few extra links that should also help you get started. There are a number of ways 
                'to do repeaters with Content Controls - one is what you mentioned. The other way is to use Building Blocks. 
                'Another way is to kind of do the opposite of what you mentioned - put a table with just a header row and then 
                'create rows populated with CCs in the cells (creo que esto es lo que hago yo). Do take a look 
                'at the Word Content Control Kit as well - that will save your life in working with CCs until you 
                'become much more familiar. – Otaku Sep 25 '10 at 15:46
                '/////////////////////////////////////////////////////////////////////////////////////
                '  'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                '//////////////////////////////////////////////////
                'en VBA, Edu busca el sector así:     Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
                'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                '//////////////////////////////////////////////////////////

                '//////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////
                'busco el primer renglon de la tabla de detalle
                '//////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////
                Dim tempParent

                'busco el bookmark Detalles
                Dim bookmarkDetalles = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
                                        Where bookmark.Name = "Detalles" Or bookmark.Name = "Detalle" _
                                        Select bookmark).FirstOrDefault

                '... o tambien el tag Descripcion
                Dim placeholderCANT = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.Text)() _
                                          Where bookmark.Text = "#Descripcion#" _
                                          Select bookmark).FirstOrDefault


                If Not placeholderCANT Is Nothing Then
                    tempParent = placeholderCANT.Parent
                Else
                    tempParent = bookmarkDetalles.Parent
                End If





                'qué tabla contiene al bookmark "Detalles"? (es el que usa Edu en VBA)
                Dim table As Wordprocessing.Table

                ' Find the second row in the table.
                Dim row1 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(0)
                Dim row2 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(1)


                'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                ' loop till we get the containing element in case bookmark is inside a table etc.
                ' keep checking the element's parent and update it till we reach the Body
                'Dim tempParent = bookmarkDetalles.Parent
                Dim isInTable As Boolean = False

                While Not TypeOf (tempParent.Parent) Is Wordprocessing.Body ',) <> mainPart.Document.Body
                    tempParent = tempParent.Parent
                    If (TypeOf (tempParent) Is Wordprocessing.TableRow And Not isInTable) Then
                        isInTable = True
                        Exit While
                    End If
                End While

                If isInTable Then
                    'table = tempParent
                    'no basta con saber la tabla. necesito saber la posicion del bookmark en la tabla
                    'table.ChildElements(
                    'bookmarkDetalles.
                    row1 = tempParent
                    table = row1.Parent
                Else
                    Err.Raise(5454, "asdasdasa")
                End If





                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                'hago los reemplazos
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////


                ''Make a copy of the 2nd row (assumed that the 1st row is header) http://patrickyong.net/tags/openxml/
                'Dim rows = table.Elements(Of Wordprocessing.TableRow)()
                For Each i As RequerimientoItem In oFac.Detalles
                    Dim dupRow As DocumentFormat.OpenXml.OpenXmlElement = row1.CloneNode(True)
                    'Dim dupRow2 = row2.CloneNode(True)

                    'CeldaReemplazos(dupRow, -1, i)


                    For CeldaColumna As Long = 0 To row1.Elements(Of Wordprocessing.TableCell)().Count - 1
                        Try

                            '///////////////////////////
                            'renglon 1
                            '///////////////////////////


                            Dim texto As String = dupRow.InnerXml
                            With i
                                regexReplace(texto, "#item#", iisNull(.NumeroItem))
                                regexReplace(texto, "#Cant#", iisNull(.Cantidad))
                                regexReplace(texto, "#Unidad#", iisNull(.Unidad))
                                regexReplace(texto, "#Codigo#", iisNull(.Codigo))
                                '                regexReplace(texto, "#Precio#", iisNull(itemFactura.Precio))
                                '              regexReplace(texto, "#Importe#", iisNull(itemFactura.ImporteTotalItem))


                                Dim desc As String = IIf(.OrigenDescripcion <> 2, .Articulo, "") & " " & IIf(.OrigenDescripcion <> 1, .Observaciones, "")
                                regexReplace(texto, "#Descripcion#", desc)


                                regexReplace(texto, "#FechaEntrega#", iisNull(.FechaEntrega))

                                regexReplace(texto, "#FechaRecepcion#", "")



                                regexReplace(texto, "#FechaNecesidad#", iisNull(.FechaNecesidad))
                                regexReplace(texto, "#ListaMat#", iisNull(.ListaMateriales))
                                regexReplace(texto, "#itLM#", iisNull(.ItemListaMaterial))
                                regexReplace(texto, "#Equipo#", iisNull(.Equipo))
                                regexReplace(texto, "#CentrocostoCuenta#", iisNull(.centrocosto))
                                regexReplace(texto, "#BienUso#", IIf(iisNull(.bien_o_uso, False) = True, "SI", "NO"))
                                regexReplace(texto, "#controlcalidad#", iisNull(.ControlDeCalidad))
                                regexReplace(texto, "#adj#", iisNull(.Adjunto))
                                regexReplace(texto, "#Proveedor#", iisNull(.proveedor))
                                regexReplace(texto, "#nroFactPedido#", iisNull(.NumeroFacturaCompra1))
                                regexReplace(texto, "#FechaFact#", "") 'iisNull(.FechaFacturaCompra))
                            End With

                            dupRow.InnerXml = texto





                            '///////////////////////////
                            'renglon 2
                            '///////////////////////////

                            '    CeldaReemplazos(dupRow2, CeldaColumna, i)
                            '    table.AppendChild(dupRow2)



                        Catch ex As Exception
                            ErrHandler.WriteError(ex)
                        End Try

                    Next

                    table.AppendChild(dupRow)


                Next

                table.RemoveChild(row1)
                'row2.Parent.RemoveChild(row2)





                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                'PIE
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                For Each pie As FooterPart In wordDoc.MainDocumentPart.FooterParts
                    'Dim pie = wordDoc.MainDocumentPart.FooterParts.First
                    pie.GetStream()

                    docText = Nothing
                    sr = New StreamReader(pie.GetStream())

                    Using (sr)
                        docText = sr.ReadToEnd
                    End Using

                    regexReplace(docText, "#Observaciones#", oFac.Observaciones)
                    regexReplace(docText, "#LugarEntrega#", oFac.LugarEntrega)
                    regexReplace(docText, "#Liberado#", IIf(Val(oFac.IdAprobo) > 0, EntidadManager.GetInitialsFromString(oFac.Aprobo) & " " & oFac.FechaAprobacion, ""))  'iniciales + fecha + hora
                    regexReplace(docText, "#JefeSector#", "")
                    regexReplace(docText, "#Calidad#", "")
                    regexReplace(docText, "#Planeamiento#", "")
                    regexReplace(docText, "#GerenciaSector#", "")


                    regexReplace(docText, "#Total#", FF2(0))
                    regexReplace(docText, "#Total2#", FF2(0))

                    'regexReplace(docText, "#Subtotal#", FF2(oFac.SubTotal))
                    'regexReplace(docText, "#IVA#", FF2(oFac.ImporteIva1))
                    'regexReplace(docText, "#IIBB#", oFac.IBrutos)
                    'regexReplace(docText, "#Total#", FF2(oFac.Total))


                    sw = New StreamWriter(pie.GetStream(FileMode.Create))
                    Using (sw)
                        sw.Write(docText)
                    End Using
                Next


                'buscar bookmark http://openxmldeveloper.org/discussions/formats/f/13/p/2539/8302.aspx
                'Dim mainPart As MainDocumentPart = wordDoc.MainDocumentPart()
                'Dim bookmarkStart = mainPart.Document.Body.Descendants().Where(bms >= bms.Name = "testBookmark").SingleOrDefault()
                'Dim bookmarkEnd = mainPart.Document.Body.Descendants().Where(bme >= bme.Id.Value = bookmarkStart.Id.Value).SingleOrDefault()
                'BookmarkStart.Remove()
                'BookmarkEnd.Remove()



            End Using
        End Sub

        Public Shared Sub PedidoXML_DOCX(ByVal document As String, ByVal oFac As Pronto.ERP.BO.Pedido, ByVal SC As String)

            'Dim oFac As Pronto.ERP.BO.Requerimiento = CType(Me.ViewState(mKey), Pronto.ERP.BO.Requerimiento)


            Dim wordDoc As WordprocessingDocument = WordprocessingDocument.Open(document, True)



            Dim settings As New SimplifyMarkupSettings
            With settings
                .RemoveComments = True
                .RemoveContentControls = True
                .RemoveEndAndFootNotes = True
                .RemoveFieldCodes = False
                .RemoveLastRenderedPageBreak = True
                .RemovePermissions = True
                .RemoveProof = True
                .RemoveRsidInfo = True
                .RemoveSmartTags = True
                .RemoveSoftHyphens = True
                .ReplaceTabsWithSpaces = True
            End With
            MarkupSimplifier.SimplifyMarkup(wordDoc, settings)





            Using (wordDoc)
                Dim docText As String = Nothing
                Dim sr As StreamReader = New StreamReader(wordDoc.MainDocumentPart.GetStream)



                Using (sr)
                    docText = sr.ReadToEnd
                End Using

                '/////////////////////////////
                '/////////////////////////////
                'ENCABEZADO
                'Hace el reemplazo
                '/////////////////////////////
                With oFac

                    'regexReplace(docText, "#Cliente#", oFac.Sector)
                    'regexReplace(docText, "#CodigoCliente#", oFac.Cliente.CodigoCliente)
                    'regexReplace(docText, "#Direccion#", oFac.Cliente.Direccion) 'oFac.Domicilio)
                    'regexReplace(docText, "#Localidad#", oFac.Cliente.Localidad) 'oFac.Domicilio)



                    'regexReplace(docText, "#CUIT#", oFac.Cliente.Cuit)

                    regexReplace(docText, "#Numero#", oFac.Numero)
                    regexReplace(docText, "#Fecha#", oFac.Fecha)
                    'regexReplace(docText, "#CondicionIVA#", oFac.CondicionIVADescripcion)
                    'regexReplace(docText, "#CondicionVenta#", oFac.CondicionVentaDescripcion)
                    'regexReplace(docText, "#CAE#", oFac.CAE)

                    regexReplace(docText, "#Observaciones#", oFac.Observaciones)


                    'regexReplace(docText, "#Detalle#", oFac.Detalle)


                    'regexReplace(docText, "#Solicito#", oFac.Solicito)
                    'regexReplace(docText, "#Sector#", oFac.Sector)

                    regexReplace(docText, "#Tipo#", "Obra") ' oFac.tipo) obra
                    'regexReplace(docText, "#TipoDes#", NombreObra(SC, .IdObra)) ' oFac.TipoDes) codigo obra
                    regexReplace(docText, "#TipoDes1#", "") ' NombreObr(SC, .IdObra)) 'oFac.TipoDes1) nombre obra

                End With

                Dim sw As StreamWriter = New StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create))
                Using (sw)
                    sw.Write(docText)
                End Using


                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                'CUERPO  (repetir renglones)
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                'http://msdn.microsoft.com/en-us/library/cc850835(office.14).aspx
                '///////////////////////////////////////////////////////////////////////////////////
                '   http://stackoverflow.com/a/3783607/1054200
                '@Matt S: I've put in a few extra links that should also help you get started. There are a number of ways 
                'to do repeaters with Content Controls - one is what you mentioned. The other way is to use Building Blocks. 
                'Another way is to kind of do the opposite of what you mentioned - put a table with just a header row and then 
                'create rows populated with CCs in the cells (creo que esto es lo que hago yo). Do take a look 
                'at the Word Content Control Kit as well - that will save your life in working with CCs until you 
                'become much more familiar. – Otaku Sep 25 '10 at 15:46
                '/////////////////////////////////////////////////////////////////////////////////////
                '  'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                '//////////////////////////////////////////////////
                'en VBA, Edu busca el sector así:     Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
                'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                '//////////////////////////////////////////////////////////

                '//////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////
                'busco el primer renglon de la tabla de detalle
                '//////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////
                Dim tempParent

                'busco el bookmark Detalles
                Dim bookmarkDetalles = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
                                        Where bookmark.Name = "Detalles" Or bookmark.Name = "Detalle" _
                                        Select bookmark).FirstOrDefault

                '... o tambien el tag Descripcion
                Dim placeholderCANT = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.Text)() _
                                          Where bookmark.Text = "#Descripcion#" _
                                          Select bookmark).FirstOrDefault


                If Not placeholderCANT Is Nothing Then
                    tempParent = placeholderCANT.Parent
                Else
                    tempParent = bookmarkDetalles.Parent
                End If





                'qué tabla contiene al bookmark "Detalles"? (es el que usa Edu en VBA)
                Dim table As Wordprocessing.Table

                ' Find the second row in the table.
                Dim row1 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(0)
                Dim row2 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(1)


                'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                ' loop till we get the containing element in case bookmark is inside a table etc.
                ' keep checking the element's parent and update it till we reach the Body
                'Dim tempParent = bookmarkDetalles.Parent
                Dim isInTable As Boolean = False

                While Not TypeOf (tempParent.Parent) Is Wordprocessing.Body ',) <> mainPart.Document.Body
                    tempParent = tempParent.Parent
                    If (TypeOf (tempParent) Is Wordprocessing.TableRow And Not isInTable) Then
                        isInTable = True
                        Exit While
                    End If
                End While

                If isInTable Then
                    'table = tempParent
                    'no basta con saber la tabla. necesito saber la posicion del bookmark en la tabla
                    'table.ChildElements(
                    'bookmarkDetalles.
                    row1 = tempParent
                    table = row1.Parent
                Else
                    Err.Raise(5454, "asdasdasa")
                End If





                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                'hago los reemplazos
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////


                ''Make a copy of the 2nd row (assumed that the 1st row is header) http://patrickyong.net/tags/openxml/
                'Dim rows = table.Elements(Of Wordprocessing.TableRow)()
                For Each i As PedidoItem In oFac.Detalles
                    Dim dupRow As DocumentFormat.OpenXml.OpenXmlElement = row1.CloneNode(True)
                    'Dim dupRow2 = row2.CloneNode(True)

                    'CeldaReemplazos(dupRow, -1, i)


                    For CeldaColumna As Long = 0 To row1.Elements(Of Wordprocessing.TableCell)().Count - 1
                        Try

                            '///////////////////////////
                            'renglon 1
                            '///////////////////////////


                            Dim texto As String = dupRow.InnerXml
                            With i
                                regexReplace(texto, "#item#", iisNull(.NumeroItem))
                                regexReplace(texto, "#Cant#", iisNull(.Cantidad))
                                regexReplace(texto, "#Unidad#", iisNull(.Unidad))
                                regexReplace(texto, "#Codigo#", iisNull(.Codigo))
                                '                regexReplace(texto, "#Precio#", iisNull(itemFactura.Precio))
                                '              regexReplace(texto, "#Importe#", iisNull(itemFactura.ImporteTotalItem))


                                Dim desc As String = IIf(.OrigenDescripcion <> 2, .Articulo, "") & " " & IIf(.OrigenDescripcion <> 1, .Observaciones, "")
                                regexReplace(texto, "#Descripcion#", desc)


                                regexReplace(texto, "#FechaEntrega#", iisNull(.FechaEntrega))

                                regexReplace(texto, "#FechaRecepcion#", "")



                                regexReplace(texto, "#FechaNecesidad#", iisNull(.FechaNecesidad))
                                'regexReplace(texto, "#ListaMat#", iisNull(.ListaMateriales))
                                'regexReplace(texto, "#itLM#", iisNull(.ItemListaMaterial))
                                'regexReplace(texto, "#Equipo#", iisNull(.Equipo))
                                'regexReplace(texto, "#CentrocostoCuenta#", iisNull(.centrocosto))
                                'regexReplace(texto, "#BienUso#", IIf(iisNull(.bien_o_uso, False) = True, "SI", "NO"))
                                'regexReplace(texto, "#controlcalidad#", iisNull(.ControlDeCalidad))
                                'regexReplace(texto, "#adj#", iisNull(.Adjunto))
                                'regexReplace(texto, "#Proveedor#", iisNull(.proveedor))
                                'regexReplace(texto, "#nroFactPedido#", iisNull(.NumeroFacturaCompra1))
                                regexReplace(texto, "#FechaFact#", "") 'iisNull(.FechaFacturaCompra))
                            End With

                            dupRow.InnerXml = texto





                            '///////////////////////////
                            'renglon 2
                            '///////////////////////////

                            '    CeldaReemplazos(dupRow2, CeldaColumna, i)
                            '    table.AppendChild(dupRow2)



                        Catch ex As Exception
                            ErrHandler.WriteError(ex)
                        End Try

                    Next

                    table.AppendChild(dupRow)


                Next

                table.RemoveChild(row1)
                'row2.Parent.RemoveChild(row2)





                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                'PIE
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                For Each pie As FooterPart In wordDoc.MainDocumentPart.FooterParts
                    'Dim pie = wordDoc.MainDocumentPart.FooterParts.First
                    pie.GetStream()

                    docText = Nothing
                    sr = New StreamReader(pie.GetStream())

                    Using (sr)
                        docText = sr.ReadToEnd
                    End Using

                    regexReplace(docText, "#Observaciones#", oFac.Observaciones)
                    regexReplace(docText, "#LugarEntrega#", oFac.LugarEntrega)
                    regexReplace(docText, "#Liberado#", IIf(Val(oFac.IdAprobo) > 0, EntidadManager.GetInitialsFromString(oFac.Aprobo) & " " & oFac.FechaAprobacion, ""))  'iniciales + fecha + hora
                    regexReplace(docText, "#JefeSector#", "")
                    regexReplace(docText, "#Calidad#", "")
                    regexReplace(docText, "#Planeamiento#", "")
                    regexReplace(docText, "#GerenciaSector#", "")


                    regexReplace(docText, "#Total#", FF2(0))
                    regexReplace(docText, "#Total2#", FF2(0))

                    'regexReplace(docText, "#Subtotal#", FF2(oFac.SubTotal))
                    'regexReplace(docText, "#IVA#", FF2(oFac.ImporteIva1))
                    'regexReplace(docText, "#IIBB#", oFac.IBrutos)
                    'regexReplace(docText, "#Total#", FF2(oFac.Total))


                    sw = New StreamWriter(pie.GetStream(FileMode.Create))
                    Using (sw)
                        sw.Write(docText)
                    End Using
                Next


                'buscar bookmark http://openxmldeveloper.org/discussions/formats/f/13/p/2539/8302.aspx
                'Dim mainPart As MainDocumentPart = wordDoc.MainDocumentPart()
                'Dim bookmarkStart = mainPart.Document.Body.Descendants().Where(bms >= bms.Name = "testBookmark").SingleOrDefault()
                'Dim bookmarkEnd = mainPart.Document.Body.Descendants().Where(bme >= bme.Id.Value = bookmarkStart.Id.Value).SingleOrDefault()
                'BookmarkStart.Remove()
                'BookmarkEnd.Remove()



            End Using
        End Sub


        Public Shared Sub ComparativaXML_XLSX(ByVal document As String, ByVal oFac As Pronto.ERP.BO.Comparativa, ByVal SC As String)

            'Dim oFac As Pronto.ERP.BO.Requerimiento = CType(Me.ViewState(mKey), Pronto.ERP.BO.Requerimiento)

            Dim wordDoc As WordprocessingDocument = WordprocessingDocument.Open(document, True)
            'Dim wordDoc As Spreadsheet = SpreadsheetDocument.Open(document, True)



            'Dim settings As New SimplifyMarkupSettings
            'With settings
            '    .RemoveComments = True
            '    .RemoveContentControls = True
            '    .RemoveEndAndFootNotes = True
            '    .RemoveFieldCodes = False
            '    .RemoveLastRenderedPageBreak = True
            '    .RemovePermissions = True
            '    .RemoveProof = True
            '    .RemoveRsidInfo = True
            '    .RemoveSmartTags = True
            '    .RemoveSoftHyphens = True
            '    .ReplaceTabsWithSpaces = True
            'End With
            'MarkupSimplifier.SimplifyMarkup(wordDoc, settings)





            Using (wordDoc)
                Dim docText As String = Nothing
                Dim sr As StreamReader = New StreamReader(wordDoc.MainDocumentPart.GetStream)



                Using (sr)
                    docText = sr.ReadToEnd
                End Using

                '/////////////////////////////
                '/////////////////////////////
                'ENCABEZADO
                'Hace el reemplazo
                '/////////////////////////////
                With oFac

                    regexReplace(docText, "#Cliente#", oFac.IdConfecciono)
                    'regexReplace(docText, "#CodigoCliente#", oFac.Cliente.CodigoCliente)
                    'regexReplace(docText, "#Direccion#", oFac.Cliente.Direccion) 'oFac.Domicilio)
                    'regexReplace(docText, "#Localidad#", oFac.Cliente.Localidad) 'oFac.Domicilio)



                    'regexReplace(docText, "#CUIT#", oFac.Cliente.Cuit)

                    regexReplace(docText, "#Numero#", oFac.Numero)
                    regexReplace(docText, "#Fecha#", oFac.Fecha)
                    'regexReplace(docText, "#CondicionIVA#", oFac.CondicionIVADescripcion)
                    'regexReplace(docText, "#CondicionVenta#", oFac.CondicionVentaDescripcion)
                    'regexReplace(docText, "#CAE#", oFac.CAE)

                    regexReplace(docText, "#Observaciones#", oFac.Observaciones)


                    'regexReplace(docText, "#Solicito#", oFac.Solicito)
                    'regexReplace(docText, "#Sector#", oFac.Sector)

                    regexReplace(docText, "#Tipo#", "Obra") ' oFac.tipo) obra
                    'regexReplace(docText, "#TipoDes#", NombreObra(SC, .IdObra)) ' oFac.TipoDes) codigo obra
                    regexReplace(docText, "#TipoDes1#", "") ' NombreObr(SC, .IdObra)) 'oFac.TipoDes1) nombre obra

                End With

                Dim sw As StreamWriter = New StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create))
                Using (sw)
                    sw.Write(docText)
                End Using


                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                'CUERPO  (repetir renglones)
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                'http://msdn.microsoft.com/en-us/library/cc850835(office.14).aspx
                '///////////////////////////////////////////////////////////////////////////////////
                '   http://stackoverflow.com/a/3783607/1054200
                '@Matt S: I've put in a few extra links that should also help you get started. There are a number of ways 
                'to do repeaters with Content Controls - one is what you mentioned. The other way is to use Building Blocks. 
                'Another way is to kind of do the opposite of what you mentioned - put a table with just a header row and then 
                'create rows populated with CCs in the cells (creo que esto es lo que hago yo). Do take a look 
                'at the Word Content Control Kit as well - that will save your life in working with CCs until you 
                'become much more familiar. – Otaku Sep 25 '10 at 15:46
                '/////////////////////////////////////////////////////////////////////////////////////
                '  'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                '//////////////////////////////////////////////////
                'en VBA, Edu busca el sector así:     Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
                'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                '//////////////////////////////////////////////////////////

                '//////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////
                'busco el primer renglon de la tabla de detalle
                '//////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////
                Dim tempParent

                'busco el bookmark Detalles
                Dim bookmarkDetalles = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
                                        Where bookmark.Name = "Detalles" Or bookmark.Name = "Detalle" _
                                        Select bookmark).FirstOrDefault

                '... o tambien el tag Descripcion
                Dim placeholderCANT = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.Text)() _
                                          Where bookmark.Text = "#Descripcion#" _
                                          Select bookmark).FirstOrDefault


                If Not placeholderCANT Is Nothing Then
                    tempParent = placeholderCANT.Parent
                Else
                    tempParent = bookmarkDetalles.Parent
                End If





                'qué tabla contiene al bookmark "Detalles"? (es el que usa Edu en VBA)
                Dim table As Wordprocessing.Table

                ' Find the second row in the table.
                Dim row1 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(0)
                Dim row2 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(1)


                'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
                ' loop till we get the containing element in case bookmark is inside a table etc.
                ' keep checking the element's parent and update it till we reach the Body
                'Dim tempParent = bookmarkDetalles.Parent
                Dim isInTable As Boolean = False

                While Not TypeOf (tempParent.Parent) Is Wordprocessing.Body ',) <> mainPart.Document.Body
                    tempParent = tempParent.Parent
                    If (TypeOf (tempParent) Is Wordprocessing.TableRow And Not isInTable) Then
                        isInTable = True
                        Exit While
                    End If
                End While

                If isInTable Then
                    'table = tempParent
                    'no basta con saber la tabla. necesito saber la posicion del bookmark en la tabla
                    'table.ChildElements(
                    'bookmarkDetalles.
                    row1 = tempParent
                    table = row1.Parent
                Else
                    Err.Raise(5454, "asdasdasa")
                End If





                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                'hago los reemplazos
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////////////


                ''Make a copy of the 2nd row (assumed that the 1st row is header) http://patrickyong.net/tags/openxml/
                'Dim rows = table.Elements(Of Wordprocessing.TableRow)()
                For Each i As ComparativaItem In oFac.Detalles
                    Dim dupRow As DocumentFormat.OpenXml.OpenXmlElement = row1.CloneNode(True)
                    'Dim dupRow2 = row2.CloneNode(True)

                    'CeldaReemplazos(dupRow, -1, i)


                    For CeldaColumna As Long = 0 To row1.Elements(Of Wordprocessing.TableCell)().Count - 1
                        Try

                            '///////////////////////////
                            'renglon 1
                            '///////////////////////////


                            Dim texto As String = dupRow.InnerXml
                            With i
                                'regexReplace(texto, "#item#", iisNull(.NumeroItem))
                                regexReplace(texto, "#Cant#", iisNull(.Cantidad))
                                regexReplace(texto, "#Unidad#", iisNull(.Unidad))
                                regexReplace(texto, "#Codigo#", iisNull(.Codigo))
                                '                regexReplace(texto, "#Precio#", iisNull(itemFactura.Precio))
                                '              regexReplace(texto, "#Importe#", iisNull(itemFactura.ImporteTotalItem))


                                Dim desc As String = IIf(.OrigenDescripcion <> 2, .Articulo, "") & " " & IIf(.OrigenDescripcion <> 1, .Observaciones, "")
                                regexReplace(texto, "#Descripcion#", desc)


                                'regexReplace(texto, "#FechaEntrega#", iisNull(.FechaEntrega))



                                'regexReplace(texto, "#FechaNecesidad#", iisNull(.FechaNecesidad))
                                'regexReplace(texto, "#ListaMat#", iisNull(.ListaMateriales))
                                'regexReplace(texto, "#itLM#", iisNull(.ItemListaMaterial))
                                'regexReplace(texto, "#Equipo#", iisNull(.Equipo))
                                'regexReplace(texto, "#CentrocostoCuenta#", iisNull(.centrocosto))
                                'regexReplace(texto, "#BienUso#", IIf(iisNull(.bien_o_uso, False) = True, "SI", "NO"))
                                'regexReplace(texto, "#controlcalidad#", iisNull(.ControlDeCalidad))
                                'regexReplace(texto, "#adj#", iisNull(.Adjunto))
                                'regexReplace(texto, "#Proveedor#", iisNull(.proveedor))
                                'regexReplace(texto, "#nroFactPedido#", iisNull(.NumeroFacturaCompra1))
                                'regexReplace(texto, "#FechaFact#", "") 'iisNull(.FechaFacturaCompra))
                            End With

                            dupRow.InnerXml = texto





                            '///////////////////////////
                            'renglon 2
                            '///////////////////////////

                            '    CeldaReemplazos(dupRow2, CeldaColumna, i)
                            '    table.AppendChild(dupRow2)



                        Catch ex As Exception
                            ErrHandler.WriteError(ex)
                        End Try

                    Next

                    table.AppendChild(dupRow)


                Next

                table.RemoveChild(row1)
                'row2.Parent.RemoveChild(row2)





                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                'PIE
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                For Each pie As FooterPart In wordDoc.MainDocumentPart.FooterParts
                    'Dim pie = wordDoc.MainDocumentPart.FooterParts.First
                    pie.GetStream()

                    docText = Nothing
                    sr = New StreamReader(pie.GetStream())

                    Using (sr)
                        docText = sr.ReadToEnd
                    End Using

                    regexReplace(docText, "#Observaciones#", oFac.Observaciones)
                    'regexReplace(docText, "#LugarEntrega#", oFac.LugarEntrega)
                    ' regexReplace(docText, "#Liberado#", IIf(Val(oFac.IdAprobo) > 0, EntidadManager.GetInitialsFromString(oFac.Aprobo) & " " & oFac.FechaAprobacion, ""))  'iniciales + fecha + hora
                    regexReplace(docText, "#JefeSector#", "")
                    regexReplace(docText, "#Calidad#", "")
                    regexReplace(docText, "#Planeamiento#", "")
                    regexReplace(docText, "#GerenciaSector#", "")


                    regexReplace(docText, "#Total#", FF2(0))
                    regexReplace(docText, "#Total2#", FF2(0))

                    'regexReplace(docText, "#Subtotal#", FF2(oFac.SubTotal))
                    'regexReplace(docText, "#IVA#", FF2(oFac.ImporteIva1))
                    'regexReplace(docText, "#IIBB#", oFac.IBrutos)
                    'regexReplace(docText, "#Total#", FF2(oFac.Total))


                    sw = New StreamWriter(pie.GetStream(FileMode.Create))
                    Using (sw)
                        sw.Write(docText)
                    End Using
                Next


                'buscar bookmark http://openxmldeveloper.org/discussions/formats/f/13/p/2539/8302.aspx
                'Dim mainPart As MainDocumentPart = wordDoc.MainDocumentPart()
                'Dim bookmarkStart = mainPart.Document.Body.Descendants().Where(bms >= bms.Name = "testBookmark").SingleOrDefault()
                'Dim bookmarkEnd = mainPart.Document.Body.Descendants().Where(bme >= bme.Id.Value = bookmarkStart.Id.Value).SingleOrDefault()
                'BookmarkStart.Remove()
                'BookmarkEnd.Remove()



            End Using
        End Sub

        Shared Sub CeldaTexto(ByRef row As Wordprocessing.TableRow, ByVal numcelda As Integer, ByVal texto As String)
            ' Find the third cell in the row.
            Dim cell As Wordprocessing.TableCell = row.Elements(Of Wordprocessing.TableCell)().ElementAt(numcelda)
            ' Find the first paragraph in the table cell.
            Dim parag As Wordprocessing.Paragraph = cell.Elements(Of Wordprocessing.Paragraph)().First()
            ' Find the first run in the paragraph.
            Dim run As Wordprocessing.Run = parag.Elements(Of Wordprocessing.Run)().First()
            ' Set the text for the run.
            Dim text As Wordprocessing.Text = run.Elements(Of Wordprocessing.Text)().First()
            text.Text = texto

        End Sub

        Shared Sub CeldaReemplazosFactura(ByRef row As Wordprocessing.TableRow, ByVal numcelda As Integer, ByVal itemFactura As Pronto.ERP.BO.FacturaItem)

            If False Then
                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'lo recomienda Otaku! http://stackoverflow.com/a/5293425/1054200


                'METODO 1
                ' Find the third cell in the row.
                Dim cell As Wordprocessing.TableCell = row.Elements(Of Wordprocessing.TableCell)().ElementAt(numcelda)
                ' Find the first paragraph in the table cell.
                Dim parag As Wordprocessing.Paragraph = cell.Elements(Of Wordprocessing.Paragraph)().First()
                ' Find the first run in the paragraph.
                Dim run As Wordprocessing.Run = parag.Elements(Of Wordprocessing.Run)().First()
                ' Set the text for the run.
                Dim text As Wordprocessing.Text = run.Elements(Of Wordprocessing.Text)().First()


                Dim texto As String = text.Text
                regexReplace(texto, "#Numero#", iisNull(itemFactura.NumeroItem))
                regexReplace(texto, "#Cant#", iisNull(itemFactura.Cantidad))
                regexReplace(texto, "Unidad", iisNull(itemFactura.Unidad))
                regexReplace(texto, "Codigo", iisNull(itemFactura.Codigo))
                regexReplace(texto, "#Precio#", FF2(iisNull(itemFactura.Precio)))
                regexReplace(texto, "#Importe#", iisNull(itemFactura.ImporteTotalItem))
                regexReplace(texto, "#Descripcion#", iisNull(itemFactura.Articulo))
                regexReplace(texto, "FechaEntrega", iisNull(itemFactura.FechaEntrega))

                text.Text = texto

            Else
                'METODO 2
                'al editar varias veces el tag, el texto puede estar desperdigado en varios Run's del Paragraph...

                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!


                'http://stackoverflow.com/questions/7752932/simplify-clean-up-xml-of-a-docx-word-document
                'lo recomienda Otaku! http://stackoverflow.com/a/5293425/1054200
                'http://ericwhite.com/blog/2011/03/09/getting-started-with-open-xml-powertools-markup-simplifier/
                'http://powertools.codeplex.com/releases/view/74771
                'http://www.youtube.com/watch?v=LBFAXNlEBFA&feature=player_embedded



                Dim texto As String = row.InnerXml

                regexReplace(texto, "#Numero#", iisNull(itemFactura.NumeroItem))
                regexReplace(texto, "#Cant#", iisNull(itemFactura.Cantidad))
                regexReplace(texto, "Unidad", iisNull(itemFactura.Unidad))
                regexReplace(texto, "Codigo", iisNull(itemFactura.Codigo))
                regexReplace(texto, "#Precio#", iisNull(itemFactura.Precio))
                regexReplace(texto, "#Importe#", iisNull(itemFactura.Precio) * iisNull(itemFactura.Cantidad))
                regexReplace(texto, "#Descripcion#", iisNull(itemFactura.Articulo))
                regexReplace(texto, "FechaEntrega", iisNull(itemFactura.FechaEntrega))

                row.InnerXml = texto

            End If


        End Sub

        Shared Sub CeldaReemplazosNotaCredito(ByRef row As Wordprocessing.TableRow, ByVal numcelda As Integer, ByVal itemNC As Pronto.ERP.BO.NotaDeCreditoItem)

            If False Then
                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'lo recomienda Otaku! http://stackoverflow.com/a/5293425/1054200


                'METODO 1
                ' Find the third cell in the row.
                Dim cell As Wordprocessing.TableCell = row.Elements(Of Wordprocessing.TableCell)().ElementAt(numcelda)
                ' Find the first paragraph in the table cell.
                Dim parag As Wordprocessing.Paragraph = cell.Elements(Of Wordprocessing.Paragraph)().First()
                ' Find the first run in the paragraph.
                Dim run As Wordprocessing.Run = parag.Elements(Of Wordprocessing.Run)().First()
                ' Set the text for the run.
                Dim text As Wordprocessing.Text = run.Elements(Of Wordprocessing.Text)().First()

                With itemNC

                    Dim texto As String = text.Text
                    'regexReplace(texto, "#Numero#", iisNull(.NumeroItem))
                    'regexReplace(texto, "#Cant#", iisNull(.))
                    'regexReplace(texto, "Unidad", iisNull(.Unidad))
                    'regexReplace(texto, "Codigo", iisNull(.Codigo))
                    'regexReplace(texto, "#Precio#", iisNull(.Precio))
                    regexReplace(texto, "#Importe#", iisNull(.ImporteTotalItem))
                    regexReplace(texto, "#Descripcion#", iisNull(.Concepto))
                    'regexReplace(texto, "FechaEntrega", iisNull(.FechaEntrega))

                    text.Text = texto
                End With

            Else
                'METODO 2
                'al editar varias veces el tag, el texto puede estar desperdigado en varios Run's del Paragraph...

                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'AAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!
                'ES LA MARCA DE LA AUTOCORRECCION DE WORD!!!!!!


                'http://stackoverflow.com/questions/7752932/simplify-clean-up-xml-of-a-docx-word-document
                'lo recomienda Otaku! http://stackoverflow.com/a/5293425/1054200
                'http://ericwhite.com/blog/2011/03/09/getting-started-with-open-xml-powertools-markup-simplifier/
                'http://powertools.codeplex.com/releases/view/74771
                'http://www.youtube.com/watch?v=LBFAXNlEBFA&feature=player_embedded



                Dim texto As String = row.InnerXml

                With itemNC
                    'regexReplace(texto, "#Numero#", iisNull(.NumeroItem))
                    'regexReplace(texto, "#Cant#", iisNull(.Cantidad))
                    'regexReplace(texto, "Unidad", iisNull(.Unidad))
                    'regexReplace(texto, "Codigo", iisNull(.Codigo))
                    'regexReplace(texto, "#Precio#", iisNull(.Precio))
                    regexReplace(texto, "#Importe#", iisNull(.ImporteTotalItem))
                    regexReplace(texto, "#Descripcion#", iisNull(.Concepto))
                    'regexReplace(texto, "#Descripcion#", iisNull(.Articulo))
                    'regexReplace(texto, "FechaEntrega", iisNull(.FechaEntrega))

                End With
                row.InnerXml = texto

            End If


        End Sub





        Sub LoadItems(ByVal ActiveDocument As MainDocumentPart)
            'http://stackoverflow.com/questions/4565185/iterating-xml-nodes-using-vba

            'Dim totalItemsCount As Integer
            'totalItemsCount = ActiveDocument.CustomXMLParts(ActiveDocument.CustomXMLParts.Count).SelectNodes("//Items")(1).ChildNodes.Count
            'Dim item As String

            'For i = 1 To totalItemsCount
            '    item = ActiveDocument.CustomXMLParts(ActiveDocument.CustomXMLParts.Count).SelectNodes("//Items")(1).ChildNodes(i).text
            '    item = Replace(item, " ", Empty)

            '    If Len(item) > 1 Then
            '        ItemUserControl.lstItems.AddItem(pvargItem) : item()
            '    End If
            'Next i
        End Sub

        Public Sub OpenWordprocessingDocumentReadonly(ByVal filepath As String)
            ' Open a WordprocessingDocument based on a filepath.
            Using wordDocument As WordprocessingDocument = WordprocessingDocument.Open(filepath, False)
                ' Assign a reference to the existing document body. 
                Dim body As Wordprocessing.Body = wordDocument.MainDocumentPart.Document.Body

                ' Attempt to add some text.
                Dim para As Wordprocessing.Paragraph = body.AppendChild(New Wordprocessing.Paragraph())
                Dim run As Wordprocessing.Run = para.AppendChild(New Wordprocessing.Run())
                run.AppendChild(New Wordprocessing.Text("Append text in body, but text is not saved - OpenWordprocessingDocumentReadonly"))

                ' Call Save to generate an exception and show that access is read-only.
                ' wordDocument.MainDocumentPart.Document.Save()
            End Using
        End Sub

        Shared Sub GuardarEnSQL(ByVal connectionString As String, ByVal plantilla As enumPlantilla, ByVal nombrearchivo As String, ByVal observaciones As String, ByVal pathPlantillaXML As String)
            'http://stackoverflow.com/questions/2259037/upload-download-file-from-sql-server-2005-2008-from-winforms-c-sharp-app
            'Saving:

            'http://msdn.microsoft.com/en-us/library/4f5s1we0(VS.80).aspx
            'Retreival:

            'http://msdn.microsoft.com/en-us/library/87z0hy49(VS.80).aspx

            Dim nombreunico As String = plantilla.ToString

            VerificarFormatoDOCX(nombrearchivo)

            Dim stream As FileStream = New FileStream(pathPlantillaXML, FileMode.Open, FileAccess.Read)
            Dim reader As BinaryReader = New BinaryReader(stream)

            Dim photo() As Byte = reader.ReadBytes(stream.Length)

            reader.Close()
            stream.Close()


            EntidadManager.ExecDinamico(connectionString, "DELETE PlantillasXML where NombreUnico='" & nombreunico & "' ")

            Using connection As SqlConnection = New SqlConnection(Encriptar(connectionString))

                Dim command As SqlCommand = New SqlCommand("INSERT INTO PlantillasXML (NombreUnico,NombreArchivo, BinarioPlantillaXML, Observaciones) " & _
                            "Values(@NombreUnico, @NombreArchivo, @BinarioPlantillaXML, @Observaciones)", connection)

                command.Parameters.Add("@NombreUnico", System.Data.SqlDbType.NVarChar, 50).Value = nombreunico
                command.Parameters.Add("@NombreArchivo", System.Data.SqlDbType.NVarChar, 50).Value = nombrearchivo
                command.Parameters.Add("@BinarioPlantillaXML", System.Data.SqlDbType.Image, photo.Length).Value = photo
                command.Parameters.Add("@Observaciones", System.Data.SqlDbType.NVarChar, 200).Value = observaciones

                connection.Open()
                command.ExecuteNonQuery()
            End Using
        End Sub

        Shared Function VerificarFormatoDOCX(ByVal sArchivo As String) As Boolean

        End Function


        Enum enumPlantilla
            FacturaA
            FacturaB
            FacturaE
            NotaCreditoA
            NotaCreditoB
            NotaCreditoE
            NotaDebitoA
            NotaDebitoB
            NotaDebitoE
        End Enum

        Shared Function NombrePlantilla(ByVal plantilla As enumPlantilla, ByVal SC As String) As String
            Dim nombreArchivoDestino As String
            Try
                Dim dt = EntidadManager.ExecDinamico(SC, "SELECT NombreArchivo FROM PlantillasXML where NombreUnico='" & plantilla.ToString & "'")

                If dt.Rows.Count > 0 Then
                    nombreArchivoDestino = dt.Rows(0).Item(0)
                Else
                    nombreArchivoDestino = ""
                End If



            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try

            Return nombreArchivoDestino
        End Function


        Shared Function CargarPlantillaDeSQL(ByVal plantilla As enumPlantilla, ByVal connectionString As String) As String

            Dim NombrePlantilla = plantilla.ToString
            Dim nombreArchivoDestino As String = EntidadManager.ExecDinamico(connectionString, "SELECT NombreArchivo FROM PlantillasXML where NombreUnico='" & NombrePlantilla & "'").Rows(0).Item(0)
            'nombreArchivoDestino = DirApp() & "\Documentos\" & "_" & nombreArchivoDestino


            'nombreArchivoDestino = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location) & "\Documentos\" & "_" & nombreArchivoDestino
            nombreArchivoDestino = System.IO.Path.GetTempPath & "_" & nombreArchivoDestino


            'por qué no le devuelvo directamente el array de bytes, en lugar del nombre del archivo?

            Using connection As SqlConnection = New SqlConnection(Encriptar(connectionString))



                ' Assumes that connection is a valid SqlConnection object.
                Dim command As SqlCommand = New SqlCommand( _
                  "SELECT BinarioPlantillaXML FROM PlantillasXML where NombreUnico='" & NombrePlantilla & "'", connection)

                ' Writes the BLOB to a file (*.bmp).
                Dim stream As FileStream
                ' Streams the binary data to the FileStream object.
                Dim writer As BinaryWriter
                ' The size of the BLOB buffer.
                Dim bufferSize As Integer = 100
                ' The BLOB byte() buffer to be filled by GetBytes.
                Dim outByte(bufferSize - 1) As Byte
                ' The bytes returned from GetBytes.
                Dim retval As Long
                ' The starting position in the BLOB output.
                Dim startIndex As Long = 0

                ' The publisher id to use in the file name.
                Dim pubID As String = ""

                ' Open the connection and read data into the DataReader.
                connection.Open()


                ' Create a file to hold the output.
                stream = New FileStream(nombreArchivoDestino, FileMode.Create, FileAccess.Write)
                writer = New BinaryWriter(stream)


                Dim imageData As Byte() = DirectCast(command.ExecuteScalar(), Byte())

                If imageData Is Nothing Then Err.Raise(2323, "No se encontró la plantilla")

                writer.Write(imageData, 0, imageData.Length)

                stream.Close()
                ' Close the reader and the connection.

                connection.Close()

            End Using

            Return nombreArchivoDestino
        End Function

        Public Shared Function CargarPlantillaDesdeArchivo(ByVal origen As String, ByVal destino As String) As String


            Dim docText As String
            ' Create a document by supplying the filepath.

            Using doc As WordprocessingDocument = _
                WordprocessingDocument.Open(origen, WordprocessingDocumentType.Document)

                ' Add a main document part. 
                Dim mainPart As MainDocumentPart = doc.MainDocumentPart()



                Using sr = New StreamReader(doc.MainDocumentPart.GetStream())

                    docText = sr.ReadToEnd()
                End Using


                'mainPart.DeleteParts(mainPart.CustomXmlParts)
                'Dim customXmlPart As CustomXmlPart= mainPart.AddNewPart<CustomXmlPart>();
                'Dim ts As StreamWriter = New StreamWriter(CustomXmlPart.GetStream())
                'ts.Write(customXML)
            End Using



            Using destdoc As WordprocessingDocument = _
                WordprocessingDocument.Create(destino, WordprocessingDocumentType.Document)

                Dim mainPart As MainDocumentPart = destdoc.AddMainDocumentPart
                mainPart.Document = New Document()

                Using sw = New StreamWriter(mainPart.GetStream(FileMode.Create))
                    sw.Write(docText)
                End Using

                mainPart.Document.Save()
                destdoc.Close()
            End Using
        End Function




        Public Shared Sub regexReplace(ByRef cadena As String, ByVal buscar As String, ByVal reemplazo As String)
            'buscar = "\[" & buscar & "\]" 'agrego los corchetes
            buscar = buscar

            Dim regexText = New System.Text.RegularExpressions.Regex(buscar)
            cadena = regexText.Replace(cadena, If(reemplazo, ""))

        End Sub
    End Class





    'Public Class _Obsoleta_ProntoOpenOOXMLviejaDeRequerimientosObsoleta


    '    Public Shared Sub CreateWordprocessingDocument(ByVal Origen As String, ByVal Destino As String)
    '        'Getting Started with the Open XML SDK 2.0 for Microsoft Office
    '        'http://msdn.microsoft.com/en-us/library/bb456488.aspx

    '        'http://msdn.microsoft.com/en-us/library/ff478190.aspx



    '        'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template



    '        'http://stackoverflow.com/questions/4565185/iterating-xml-nodes-using-vba


    '        Dim docText As String
    '        ' Create a document by supplying the filepath.

    '        Using doc As WordprocessingDocument = _
    '            WordprocessingDocument.Open(Origen, WordprocessingDocumentType.Document)

    '            ' Add a main document part. 
    '            Dim mainPart As MainDocumentPart = doc.MainDocumentPart()



    '            Using sr = New StreamReader(doc.MainDocumentPart.GetStream())

    '                docText = sr.ReadToEnd()
    '            End Using


    '            'mainPart.DeleteParts(mainPart.CustomXmlParts)
    '            'Dim customXmlPart As CustomXmlPart= mainPart.AddNewPart<CustomXmlPart>();
    '            'Dim ts As StreamWriter = New StreamWriter(CustomXmlPart.GetStream())
    '            'ts.Write(customXML)
    '        End Using



    '        Using destdoc As WordprocessingDocument = _
    '            WordprocessingDocument.Create(Destino, WordprocessingDocumentType.Document)

    '            Dim mainPart As MainDocumentPart = destdoc.AddMainDocumentPart
    '            mainPart.Document = New Document()

    '            Using sw = New StreamWriter(mainPart.GetStream(FileMode.Create))
    '                sw.Write(docText)
    '            End Using

    '            mainPart.Document.Save()
    '            destdoc.Close()
    '        End Using


    '    End Sub

    '    ' To search and replace content in a document part. 
    '    Public Shared Sub SearchAndReplace(ByVal document As String, ByVal myRM As Pronto.ERP.BO.Requerimiento)

    '        'Dim myRM As Pronto.ERP.BO.Requerimiento = CType(Me.ViewState(mKey), Pronto.ERP.BO.Requerimiento)


    '        Dim wordDoc As WordprocessingDocument = WordprocessingDocument.Open(document, True)
    '        Using (wordDoc)
    '            Dim docText As String = Nothing
    '            Dim sr As StreamReader = New StreamReader(wordDoc.MainDocumentPart.GetStream)

    '            Using (sr)
    '                docText = sr.ReadToEnd
    '            End Using

    '            '/////////////////////////////
    '            '/////////////////////////////
    '            'Hace el reemplazo
    '            '/////////////////////////////


    '            regexReplace(docText, "TAGobracodigo", "") 'myRM.Obra)
    '            regexReplace(docText, "TAGobradescripcion", myRM.Obra) ' cmbObra.SelectedItem.Text)

    '            regexReplace(docText, "TAGnumero", myRM.Numero)
    '            regexReplace(docText, "TAGsolicito", myRM.Solicito)
    '            regexReplace(docText, "TAGfecha", myRM.Fecha)
    '            regexReplace(docText, "TAGdetalle", myRM.Detalle)
    '            regexReplace(docText, "TAGsector", myRM.Sector)

    '            regexReplace(docText, "observaciones", myRM.Observaciones)
    '            regexReplace(docText, "lugarentrega", myRM.LugarEntrega)
    '            regexReplace(docText, "libero", myRM.Aprobo)
    '            regexReplace(docText, "jefesector", "")




    '            'For Each i In myRM.Detalles
    '            '    regexReplace(docText, "R0" & i.NumeroItem & "cant", i.Cantidad)
    '            '    regexReplace(docText, "R0" & i.NumeroItem & "unid", i.Unidad)
    '            '    regexReplace(docText, "R0" & i.NumeroItem & "codigo", i.Codigo)
    '            '    regexReplace(docText, "R0" & i.NumeroItem & "descripcion", i.Articulo)
    '            '    regexReplace(docText, "R0" & i.NumeroItem & "observaciones", i.Observaciones)
    '            '    regexReplace(docText, "R0" & i.NumeroItem & "fechanecesidad", i.FechaEntrega)
    '            'Next

    '            'como limpiar 




    '            '/////////////////////////////
    '            '/////////////////////////////
    '            '/////////////////////////////


    '            Dim sw As StreamWriter = New StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create))
    '            Using (sw)
    '                sw.Write(docText)
    '            End Using


    '            '/////////////////////////////
    '            '/////////////////////////////
    '            '/////////////////////////////
    '            '/////////////////////////////
    '            '/////////////////////////////
    '            '/////////////////////////////
    '            '/////////////////////////////
    '            '/////////////////////////////
    '            '/////////////////////////////


    '            'http://msdn.microsoft.com/en-us/library/cc850835(office.14).aspx


    '            ' Find the first table in the document.
    '            Dim table As Wordprocessing.Table = _
    '                    wordDoc.MainDocumentPart.Document.Body.Elements(Of Wordprocessing.Table)().First

    '            ' Find the second row in the table.
    '            Dim row1 As Wordprocessing.TableRow = table.Elements(Of Wordprocessing.TableRow)().ElementAt(5)
    '            Dim row2 As Wordprocessing.TableRow = table.Elements(Of Wordprocessing.TableRow)().ElementAt(6)


    '            ''Make a copy of the 2nd row (assumed that the 1st row is header) http://patrickyong.net/tags/openxml/
    '            'Dim rows = table.Elements(Of Wordprocessing.TableRow)()


    '            For Each i In myRM.Detalles
    '                Dim dupRow = row1.CloneNode(True) ' rows(4).CloneNode(True)

    '                'regexReplace(docText, "R01cant", i.Cantidad)
    '                'regexReplace(docText, "R01unid", i.Unidad)
    '                'regexReplace(docText, "R01codigo", i.Codigo)
    '                'regexReplace(docText, "R01descripcion", i.Articulo)
    '                'regexReplace(docText, "R01observaciones", i.Observaciones)
    '                'regexReplace(docText, "R01fechanecesidad", i.FechaEntrega)


    '                CeldaTexto(dupRow, 0, i.NumeroItem)
    '                CeldaTexto(dupRow, 1, i.Cantidad)
    '                CeldaTexto(dupRow, 2, i.Unidad)
    '                CeldaTexto(dupRow, 3, i.Codigo)
    '                CeldaTexto(dupRow, 4, i.Articulo)
    '                CeldaTexto(dupRow, 5, i.FechaEntrega)

    '                table.AppendChild(dupRow)




    '                Dim dupRow2 = row2.CloneNode(True) ' rows(4).CloneNode(True)

    '                CeldaTexto(dupRow2, 4, i.Observaciones)
    '                table.AppendChild(dupRow2)

    '            Next

    '            table.RemoveChild(row1)
    '            table.RemoveChild(row2)





    '            '/////////////////////////////
    '            '/////////////////////////////
    '            '/////////////////////////////
    '            '/////////////////////////////

    '            For Each pie As FooterPart In wordDoc.MainDocumentPart.FooterParts
    '                'Dim pie = wordDoc.MainDocumentPart.FooterParts.First
    '                pie.GetStream()

    '                docText = Nothing
    '                sr = New StreamReader(pie.GetStream())

    '                Using (sr)
    '                    docText = sr.ReadToEnd
    '                End Using

    '                regexReplace(docText, "observaciones", myRM.Observaciones)
    '                regexReplace(docText, "lugarentrega", myRM.LugarEntrega)
    '                regexReplace(docText, "libero", myRM.Aprobo)
    '                regexReplace(docText, "fecharecepcion", myRM.Fecha)
    '                regexReplace(docText, "jefesector", "")

    '                sw = New StreamWriter(pie.GetStream(FileMode.Create))
    '                Using (sw)
    '                    sw.Write(docText)
    '                End Using
    '            Next


    '            'buscar bookmark http://openxmldeveloper.org/discussions/formats/f/13/p/2539/8302.aspx
    '            'Dim mainPart As MainDocumentPart = wordDoc.MainDocumentPart()
    '            'Dim bookmarkStart = mainPart.Document.Body.Descendants().Where(bms >= bms.Name = "testBookmark").SingleOrDefault()
    '            'Dim bookmarkEnd = mainPart.Document.Body.Descendants().Where(bme >= bme.Id.Value = bookmarkStart.Id.Value).SingleOrDefault()
    '            'BookmarkStart.Remove()
    '            'BookmarkEnd.Remove()



    '        End Using
    '    End Sub

    '    Shared Sub CeldaTexto(ByRef row As Wordprocessing.TableRow, ByVal numcelda As Integer, ByVal texto As String)
    '        ' Find the third cell in the row.
    '        Dim cell As Wordprocessing.TableCell = row.Elements(Of Wordprocessing.TableCell)().ElementAt(numcelda)
    '        ' Find the first paragraph in the table cell.
    '        Dim parag As Paragraph = cell.Elements(Of Paragraph)().First()
    '        ' Find the first run in the paragraph.
    '        Dim run As Run = parag.Elements(Of Run)().First()
    '        ' Set the text for the run.
    '        Dim text As Text = run.Elements(Of Text)().First()
    '        text.Text = texto

    '    End Sub



    '    Shared Sub regexReplace(ByRef cadena As String, ByVal buscar As String, ByVal reemplazo As String)
    '        'buscar = "\[" & buscar & "\]" 'agrego los corchetes
    '        buscar = buscar

    '        Dim regexText = New Regex(buscar)
    '        cadena = regexText.Replace(cadena, reemplazo)

    '    End Sub

    '    Sub LoadItems(ByVal ActiveDocument As MainDocumentPart)
    '        'http://stackoverflow.com/questions/4565185/iterating-xml-nodes-using-vba

    '        'Dim totalItemsCount As Integer
    '        'totalItemsCount = ActiveDocument.CustomXMLParts(ActiveDocument.CustomXMLParts.Count).SelectNodes("//Items")(1).ChildNodes.Count
    '        'Dim item As String

    '        'For i = 1 To totalItemsCount
    '        '    item = ActiveDocument.CustomXMLParts(ActiveDocument.CustomXMLParts.Count).SelectNodes("//Items")(1).ChildNodes(i).text
    '        '    item = Replace(item, " ", Empty)

    '        '    If Len(item) > 1 Then
    '        '        ItemUserControl.lstItems.AddItem(pvargItem) : item()
    '        '    End If
    '        'Next i
    '    End Sub


    '    Public Sub OpenWordprocessingDocumentReadonly(ByVal filepath As String)
    '        ' Open a WordprocessingDocument based on a filepath.
    '        Using wordDocument As WordprocessingDocument = WordprocessingDocument.Open(filepath, False)
    '            ' Assign a reference to the existing document body. 
    '            Dim body As Body = wordDocument.MainDocumentPart.Document.Body

    '            ' Attempt to add some text.
    '            Dim para As Paragraph = body.AppendChild(New Paragraph())
    '            Dim run As Run = para.AppendChild(New Run())
    '            run.AppendChild(New Text("Append text in body, but text is not saved - OpenWordprocessingDocumentReadonly"))

    '            ' Call Save to generate an exception and show that access is read-only.
    '            ' wordDocument.MainDocumentPart.Document.Save()
    '        End Using
    '    End Sub


    'End Class

End Namespace









