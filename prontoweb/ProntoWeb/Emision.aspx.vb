Imports System.IO
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.Xml
Imports System.Xml.Xsl
Imports Word = Microsoft.Office.Interop.Word


Imports CartaDePorteManager

Partial Class ProntoWeb_Emision
    Inherits System.Web.UI.Page
    Enum FormatosEmision
        Word
        PDF
    End Enum

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Select Case Request.QueryString("format")
            Case 2
                Emitir(Request.QueryString("idReq"), FormatosEmision.PDF)
            Case Else
                Emitir(Request.QueryString("idReq"), FormatosEmision.Word)
        End Select

    End Sub

    Private Sub Emitir(ByVal idReq As Long, ByVal format As String)
        Try
            Dim empresa As New Pronto.ERP.BO.Empresa

            Dim SC As String
            Dim usuario As Usuario = Nothing

            usuario = Session(SESSIONPRONTO_USUARIO)
            SC = usuario.StringConnection



            Dim Pedido As Pronto.ERP.BO.Pedido = New Pronto.ERP.BO.Pedido
            Pedido = PedidoManager.GetItem(SC, idReq, True)
            Dim xml As String = GenerarXML(Pedido)

            Dim extension As String
            If format = FormatosEmision.PDF Then
                extension = "pdf"
            Else
                extension = "doc"
            End If

            empresa.Descripcion = "Equimac"
            Dim xslFilePath As String = Path.Combine(Server.MapPath("~/Templates/"), empresa.Descripcion + ".xsl")

            If File.Exists(xslFilePath) Then
                If format = FormatosEmision.PDF Then
                    Response.ContentType = "application/pdf" 'aca es word o pdf
                Else
                    Response.ContentType = "application/msword" 'aca es word o pdf
                End If
                Dim memoryStream As MemoryStream = New MemoryStream()
                XslTransform(memoryStream, xslFilePath, xml)
                Response.AppendHeader("Content-Length", memoryStream.Length.ToString())
                Response.AppendHeader("Content-Disposition", String.Format("attachment;filename=Pedido{0}.xml", Pedido.Numero))
                Response.BinaryWrite(memoryStream.ToArray())
                Response.Flush()
            Else

            End If


            'Leo, estoy cerca pero no lo saco, lo sigo mañana
            'Dim filename As String = Server.MapPath(String.Format("Temp/{0}.{1}", DateTime.Now.Ticks, extension))
            'Dim arguments As String = String.Format("""{0}"",{1},{2},""{3}"",""{4}""", _
            'New Object(4) {Master.GetConnectionString(Convert.ToInt32(Session("IdEmpresa"))), idReq, Math.Min(CType(format, Integer), 1), _
            'filename, Master.GetEmpresa(Convert.ToInt32(Session("IdEmpresa"))).Descripcion})

            ''Dim myProcess As System.Diagnostics.Process = New System.Diagnostics.Process()
            'myProcess.StartInfo.UserName = "Pronto"
            'myProcess.StartInfo.Domain = Environment.MachineName
            'myProcess.StartInfo.Password = New System.Security.SecureString()
            'myProcess.StartInfo.Password.AppendChar("a")
            'myProcess.StartInfo.Password.AppendChar("g")
            'myProcess.StartInfo.Password.AppendChar("i")
            'myProcess.StartInfo.Password.AppendChar("l")
            'myProcess.StartInfo.Password.AppendChar("m")
            'myProcess.StartInfo.Password.AppendChar("i")
            'myProcess.StartInfo.Password.AppendChar("n")
            'myProcess.StartInfo.Password.AppendChar("d")
            'myProcess.StartInfo.Password.AppendChar("1")
            'myProcess.StartInfo.Password.AppendChar("!")
            ''myProcess.StartInfo.FileName = ConfigurationManager.AppSettings("EmisionExePath")
            'myProcess.StartInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden
            ''myProcess.StartInfo.Arguments = arguments
            'myProcess.StartInfo.UseShellExecute = False
            'myProcess.StartInfo.RedirectStandardOutput = True
            ''myProcess.Start()
            ''myProcess.WaitForExit(150000) 'Espera 15 segundos
            'ProntoWebHelper.Helper.ExecuteProcessAsUser(System.Security.Principal.WindowsIdentity.GetCurrent, _
            '        ConfigurationManager.AppSettings("EmisionExePath"), _
            '        arguments, 30000)
            'If File.Exists(filename) Then
            'If format = FormatosEmision.PDF Then
            'Response.ContentType = "application/pdf" 'aca es word o pdf
            'Else
            '    Response.ContentType = "application/msword" 'aca es word o pdf
            'End If
            'Dim file1 As FileStream = New FileStream(filename, FileMode.Open)
            'Response.AppendHeader("Content-Length", file1.Length.ToString())
            'Response.AppendHeader("Content-Disposition", "attachment;filename=Pedido.doc")

            'Dim buffer As Byte() = New Byte(256) {}
            'Dim readed As Integer = file1.Read(buffer, 0, buffer.Length)
            'Do While readed > 0
            'Response.OutputStream.Write(Buffer, 0, readed)
            'readed = file1.Read(Buffer, 0, Buffer.Length)
            'Loop
            'file1.Close()
            'File.Delete(filename)
            'Else
            '    Response.Write(myProcess.StandardOutput.ReadToEnd())
            'End If
        Catch ex As Exception
            Response.Write("Se ha producido un error: " & ex.ToString)
        End Try

        'Dim myProcess As System.Diagnostics.Process = System.Diagnostics.Process.Start("D:\Proyectos\Pronto Web\TestEmision\bin\Debug\TestEmision.exe", "")
    End Sub
    Function GetEmpresa(ByVal IdEmpresa As Integer) As Pronto.ERP.BO.Empresa
        Dim empresaList As Pronto.ERP.BO.EmpresaList
        empresaList = DirectCast(Application.Item("empresaList"), Pronto.ERP.BO.EmpresaList)
        Dim cs As String = String.Empty
        For Each empresa As Pronto.ERP.BO.Empresa In empresaList
            If (empresa.Id = IdEmpresa) Then
                Return empresa
                'cs = empresa.ConnectionString
                'Dim log As Agilmind.RemotingServer.Log
                'log = New Agilmind.RemotingServer.Log()
                'log.Add(String.Format("(MASTER_PAGE) IdEmpresa: {0} - Empresa: {1} - SC : {2}", empresa.Id, empresa.Descripcion, empresa.ConnectionString), System.Web.Configuration.WebConfigurationManager.AppSettings("PathInfo").ToString)
            End If
        Next
        Return Nothing
    End Function

    Private Function GenerarXML(ByVal Pedido As Pronto.ERP.BO.Pedido) As String
        Dim sb As StringBuilder = New StringBuilder()
        sb.Append("<?xml version=""1.0"" encoding=""ISO-8859-1"" ?>")
        sb.Append("<Pedidos>")
        sb.AppendFormat("<Pedido name=""Aprobo"">{0}</Pedido>", Pedido.Aprobo)
        sb.AppendFormat("<Pedido name=""CircuitoFirmasCompleto"">{0}</Pedido>", Pedido.CircuitoFirmasCompleto)
        sb.AppendFormat("<Pedido name=""Comprador"">{0}</Pedido>", Pedido.Comprador)
        sb.AppendFormat("<Pedido name=""Cumplido"">{0}</Pedido>", Pedido.Cumplido)
        sb.AppendFormat("<Pedido name=""Fecha"">{0}</Pedido>", Pedido.Fecha)
        sb.AppendFormat("<Pedido name=""FechaAnulacion"">{0}</Pedido>", Pedido.FechaAnulacion)
        sb.AppendFormat("<Pedido name=""FechaAprobacion"">{0}</Pedido>", Pedido.FechaAprobacion)
        sb.AppendFormat("<Pedido name=""FechaDadoPorCumplido"">{0}</Pedido>", Pedido.FechaDadoPorCumplido)
        sb.AppendFormat("<Pedido name=""FechaImportacionTransmision"">{0}</Pedido>", Pedido.FechaImportacionTransmision)
        sb.AppendFormat("<Pedido name=""IdPedido"">{0}</Pedido>", Pedido.Id)
        sb.AppendFormat("<Pedido name=""IdAprobo"">{0}</Pedido>", Pedido.IdAprobo)
        sb.AppendFormat("<Pedido name=""IdAutorizoCumplido"">{0}</Pedido>", Pedido.IdAutorizoCumplido)
        sb.AppendFormat("<Pedido name=""IdComprador"">{0}</Pedido>", Pedido.IdComprador)
        sb.AppendFormat("<Pedido name=""IdDioPorCumplido"">{0}</Pedido>", Pedido.IdDioPorCumplido)
        sb.AppendFormat("<Pedido name=""IdMoneda"">{0}</Pedido>", Pedido.IdMoneda)
        sb.AppendFormat("<Pedido name=""IdOrigenTransmision"">{0}</Pedido>", Pedido.IdOrigenTransmision)
        sb.AppendFormat("<Pedido name=""IdPedidoOriginal"">{0}</Pedido>", Pedido.IdPedidoOriginal)
        sb.AppendFormat("<Pedido name=""Impresa"">{0}</Pedido>", Pedido.Impresa)
        sb.AppendFormat("<Pedido name=""LugarEntrega"">{0}</Pedido>", Pedido.LugarEntrega)
        sb.AppendFormat("<Pedido name=""MotivoAnulacion"">{0}</Pedido>", Pedido.MotivoAnulacion)
        sb.AppendFormat("<Pedido name=""Numero"">{0}</Pedido>", Pedido.Numero)
        sb.AppendFormat("<Pedido name=""Observaciones"">{0}</Pedido>", Pedido.Observaciones)
        sb.AppendFormat("<Pedido name=""ObservacionesCumplido"">{0}</Pedido>", Pedido.ObservacionesCumplido)
        sb.AppendFormat("<Pedido name=""UsuarioAnulacion"">{0}</Pedido>", Pedido.UsuarioAnulacion)
        sb.Append("<Detalle>")
        Dim i As Integer = 0
        For Each detalle As Pronto.ERP.BO.PedidoItem In Pedido.Detalles
            i = i + 1
            sb.Append("<ItemElement>")
            sb.AppendFormat("<Item name=""Articulo"">{1}</Item>", i, detalle.Articulo.ToString)
            sb.AppendFormat("<Item name=""Cantidad"">{1}</Item>", i, detalle.Cantidad)
            sb.AppendFormat("<Item name=""Codigo"">{1}</Item>", i, detalle.Codigo)
            sb.AppendFormat("<Item name=""Costo"">{1}</Item>", i, detalle.Costo)
            sb.AppendFormat("<Item name=""Cumplido"">{1}</Item>", i, detalle.Cumplido)
            sb.AppendFormat("<Item name=""Eliminado"">{1}</Item>", i, detalle.Eliminado)
            sb.AppendFormat("<Item name=""FechaDadoPorCumplido"">{1}</Item>", i, detalle.FechaDadoPorCumplido.ToString)
            sb.AppendFormat("<Item name=""FechaEntrega"">{1}</Item>", i, detalle.FechaEntrega.ToString)
            sb.AppendFormat("<Item name=""Id"">{1}</Item>", i, detalle.Id)
            sb.AppendFormat("<Item name=""IdArticulo"">{1}</Item>", i, detalle.IdArticulo)
            sb.AppendFormat("<Item name=""IdAutorizoCumplido"">{1}</Item>", i, detalle.IdAutorizoCumplido)
            sb.AppendFormat("<Item name=""IdDetalleLMateriales"">{1}</Item>", i, detalle.IdDetalleLMateriales)
            sb.AppendFormat("<Item name=""IdDetallePedidoOriginal"">{1}</Item>", i, detalle.IdDetallePedidoOriginal)
            sb.AppendFormat("<Item name=""IdDioPorCumplido"">{1}</Item>", i, detalle.IdDioPorCumplido)
            sb.AppendFormat("<Item name=""IdOrigenTransmision"">{1}</Item>", i, detalle.IdOrigenTransmision)
            sb.AppendFormat("<Item name=""IdPedido"">{1}</Item>", i, detalle.IdPedido)
            sb.AppendFormat("<Item name=""IdPedidoOriginal"">{1}</Item>", i, detalle.IdPedidoOriginal)
            sb.AppendFormat("<Item name=""IdUnidad"">{1}</Item>", i, detalle.IdUnidad)
            sb.AppendFormat("<Item name=""Nuevo"">{1}</Item>", i, detalle.Nuevo)
            sb.AppendFormat("<Item name=""NumeroItem"">{1}</Item>", i, detalle.NumeroItem)
            sb.AppendFormat("<Item name=""Observaciones"">{1}</Item>", i, detalle.Observaciones)
            sb.AppendFormat("<Item name=""ObservacionesCumplido"">{1}</Item>", i, detalle.ObservacionesCumplido)
            sb.AppendFormat("<Item name=""OrigenDescripcion"">{1}</Item>", i, detalle.OrigenDescripcion)
            sb.AppendFormat("<Item name=""Unidad"">{1}</Item>", i, detalle.Unidad)
            sb.AppendFormat("</ItemElement>")
        Next
        sb.Append("</Detalle>")
        sb.Append("</Pedidos>")
        Return sb.ToString
    End Function

    Public Sub XslTransform(ByVal outputStream As Stream, ByVal xslFilePath As String, ByVal xmlSource As String)
        Dim xmlDoc As System.Xml.XmlDocument
        Dim xslT As System.Xml.Xsl.XslCompiledTransform
        xmlDoc = New XmlDocument()
        xslT = New XslCompiledTransform()
        xmlDoc.LoadXml(xmlSource)
        xslT.Load(xslFilePath)
        xslT.Transform(xmlDoc, Nothing, outputStream)
        outputStream.Position = 0
    End Sub


    'Private Sub Emitir(ByVal idReq, ByVal format)
    '    Dim missing As Object = System.Reflection.Missing.Value
    'Dim app As Word.Application = CreateObject("Word.Application")
    '    Dim doc As Word.Document
    '    Dim wordFile As String = Server.MapPath(String.Format("Temp/{0}.doc", DateTime.Now.Ticks))
    '    Try
    '        Dim template As String = String.Format("Pedido1_{0}.dot", "Equimac")
    '        'doc = app.Documents.Add(Server.MapPath(String.Format("/Templates/Pedido1_{0}.dot", "Equimac")), missing, missing, missing)
    '        doc = app.Documents.Open(Server.MapPath("/Templates/" + template), missing, missing, missing)
    '        app.Run("Emision", "Provider=SQLOLEDB.1;Persist Security Info=False;" + Master.GetConnectionString(Convert.ToInt32(Session("IdEmpresa"))), idReq)
    '        doc.SaveAs(wordFile)
    '    Finally
    '        If Not doc Is Nothing Then
    '            doc.Close(missing, missing, missing)
    '            System.Runtime.InteropServices.Marshal.ReleaseComObject(doc)
    '        End If
    '        doc = Nothing
    '        app.Quit(missing, missing, missing)
    '        System.Runtime.InteropServices.Marshal.ReleaseComObject(app)
    '        app = Nothing
    '        GC.Collect()   'Garbage collection.
    '    End Try
    '    If File.Exists(wordFile) Then
    '        If format = FormatosEmision.PDF Then
    '            Response.ContentType = "application/pdf" 'aca es word o pdf
    '        Else
    '            Response.ContentType = "application/msword" 'aca es word o pdf
    '        End If
    '        Response.Headers.Add("Content-Disposition", String.Format("attachment;filename={0}", wordFile))
    '        Response.WriteFile(wordFile)
    '        File.Delete(wordFile)
    '    End If

    'End Sub

End Class
