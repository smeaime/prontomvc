Imports System
Imports System.ComponentModel
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports Microsoft.VisualBasic
Imports System.Data.SqlClient 'esto tambien hay que sacarlo de acá
Imports System.Linq
Imports System.Data.Linq
Imports System.Xml.Linq

Imports System.Net.Mail

Imports System.Diagnostics
Imports System.Data

Imports System.IO
'Imports Microsoft.Office.Interop.Excel
Imports Word = Microsoft.Office.Interop.Word

Imports ClaseMigrar.SQLdinamico


Imports CodeEngine.Framework.QueryBuilder




Imports System.Xml
Imports System.Text
Imports System.Security.Cryptography




Partial Public Class LinqCartasPorteDataContext
    Public ReadOnly Property CartasDePortes() As System.Data.Linq.Table(Of CartasDePorte)
        Get
            Return Me.GetTable(Of CartasDePorte)()
        End Get
    End Property
End Class




Namespace Pronto.ERP.Bll




    <DataObjectAttribute()>
    Public Class EntidadManager





        Public Shared Sub regexReplace2(ByRef cadena As String, ByVal buscar As String, ByVal reemplazo As String)
            'buscar = "\[" & buscar & "\]" 'agrego los corchetes
            Try
                reemplazo = ProntoMVC.Data.FuncionesGenericasCSharp.RemoveSpecialCharacters(reemplazo)
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                reemplazo = ""
            End Try

            Dim regexText = New System.Text.RegularExpressions.Regex(buscar)
            cadena = regexText.Replace(cadena, If(reemplazo, ""))

        End Sub



        Public Shared Function IsValidEmail(email As String) As Boolean
            'http://stackoverflow.com/questions/1365407/c-sharp-code-to-validate-email-address
            Try
                email = email.Trim.Replace(";", ",")

                Dim addr = New System.Net.Mail.MailAddress(email) 'solo valida direcciones individuales
                Return addr.Address = email
            Catch ex As Exception
                Return False
            End Try
        End Function



        Public Shared Function MandaEmail_Nuevo(ByVal Para As String, ByVal Asunto As String, ByVal Cuerpo As String, ByVal De As String, ByVal SmtpServer As String, ByVal SmtpUser As String, ByVal SmtpPass As String, Optional ByVal sFileNameAdjunto As String = "", Optional ByVal SmtpPort As Long = 587, Optional ByVal EnableSSL As Integer = 1, Optional ByVal CCO As String = "", Optional ByVal img As String = "", Optional friendlyname As String = "", Optional replyTo As String = "", Optional isHtml As Boolean = True, Optional inlinePNG As String = "", Optional inlinePNG2 As String = "") As Boolean


            Para = Para.Replace(";", ",").Trim
            If Right(Para, 1) = "," Then Para = Left(Para, Para.Length - 1)





            De = De.Replace(";", ",")


            Try



                '/////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////
                'mando mail al comprador
                '/////////////////////////////////////////////////////////////////////////////////

                'metodo usa Imports System.Net.Mail
                'http://weblogs.asp.net/scottgu/archive/2005/12/16/432854.aspx

                'http://lifehacker.com/111166/how-to-use-gmail-as-your-smtp-server



                'If De = "" Then De = "ProntoWebMail@gmail.com"
                'If SmtpServer = "" Then SmtpServer = "smtp.gmail.com"
                'If SmtpUser = "" Then SmtpUser = "ProntoWebMail"
                'If SmtpPass = "" Then SmtpPass = ConfigurationSettings.AppSettings("SmtpPass") '"50TriplesdJQ"


                Using message As New MailMessage() 'De, Para, Asunto, Cuerpo)

                    message.From = New MailAddress(De)

                    Dim lista As String() = Para.Split(",")

                    For Each a As String In lista
                        If IsValidEmail(a) Then message.To.Add(New MailAddress(a))
                    Next


                    message.Subject = Asunto
                    message.Body = Cuerpo




                    If sFileNameAdjunto <> "" Then message.Attachments.Add(New Attachment(sFileNameAdjunto))
                    'Seteo que el server notifique solamente en el error de entrega
                    message.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure
                    message.Priority = MailPriority.High

                    If friendlyname <> "" Then message.From = New MailAddress(De, friendlyname)

                    message.IsBodyHtml = isHtml



                    If CCO <> "" Then
                        'http://www.seesharpdot.net/?p=209
                        'http://forums.asp.net/t/1394642.aspx

                        message.Headers.Add("Disposition-Notification-To", CCO)



                        Dim listacco As String() = CCO.Split(",")

                        For Each a As String In listacco
                            If IsValidEmail(a) Then message.Bcc.Add(New MailAddress(a))
                        Next


                        'message.Bcc.Add(New MailAddress(CCO, CCO)) 'copia oculta
                        message.ReplyTo = New MailAddress(listacco(0))




                        'message.ReplyTo.a.ReplyToList.Add(New MailAddress(mailReplyToAddress)) 'este esta recien en .NET 4

                        '/////////////////////////////////////////////////////////////////////////////////
                        '/////////////////////////////////////////////////////////////////////////////////

                        'aviso de retorno http://msdn.microsoft.com/en-us/vbasic/bb630227.aspx
                        'Add a custom header named Disposition-Notification-To and specify the
                        'read recept address
                        'message.Headers.Add("Disposition-Notification-To", "returnreceipt@return.com")

                        'message.Headers.Add("Disposition-Notification-To", CCO) 'en williams, le mando el aviso al CCO
                    Else
                        message.Headers.Add("Disposition-Notification-To", De)

                    End If



                    If replyTo <> "" Then message.ReplyTo = New MailAddress(replyTo)

                    'message.DeliveryNotificationOptions = DeliveryNotificationOptions.OnSuccess '7 ' DeliveryNotificationOptions.OnFailure | _
                    '                                        DeliveryNotificationOptions.OnSuccess | _
                    'DeliveryNotificationOptions.Delay() 'arriba pusiste onfailure!!!


                    If img <> "" Then
                        'Encajo una "imagen" para hacer el truco del mail de respuesta al leerse
                        'Dim imgLink As New LinkedResource(img)
                        Dim htmlView As AlternateView = AlternateView.CreateAlternateViewFromString(img, Nothing, "text/html")
                        'htmlView.LinkedResources.Add(img)
                        message.AlternateViews.Add(htmlView)
                    End If




                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    Try



                        'http://stackoverflow.com/questions/16442196/email-html-document-embedding-images-using-c-sharp

                        If inlinePNG = "" Then
                            inlinePNG = AppDomain.CurrentDomain.BaseDirectory & "\imagenes\Unnamed.png" '  Server.MapPath("~/Imagenes/williams.gif")
                        End If


                        'message.IsBodyHtml = True
                        Dim inlineLogo As Attachment = New Attachment(inlinePNG)
                        message.Attachments.Add(inlineLogo)
                        Dim contentID As String = "Image"
                        inlineLogo.ContentId = contentID

                        'To make the image display as inline and not as attachment

                        inlineLogo.ContentDisposition.Inline = True
                        inlineLogo.ContentDisposition.DispositionType = System.Net.Mime.DispositionTypeNames.Inline

                        '//To embed image in email

                        'message.Body = "<img src=""cid:" + contentID + """>" & message.Body



                        '/////////////////////////////////////////////////////////////////////////////////
                        '/////////////////////////////////////////////////////////////////////////////////
                        '/////////////////////////////////////////////////////////////////////////////////
                        '/////////////////////////////////////////////////////////////////////////////////
                        '/////////////////////////////////////////////////////////////////////////////////

                        'http://stackoverflow.com/questions/16442196/email-html-document-embedding-images-using-c-sharp


                        If inlinePNG2 = "" Then
                            inlinePNG2 = AppDomain.CurrentDomain.BaseDirectory & "\imagenes\twitterwilliams.jpg" '  Server.MapPath("~/Imagenes/williams.gif")
                        End If



                        'message.IsBodyHtml = True
                        Dim twLogo As Attachment = New Attachment(inlinePNG2)
                        message.Attachments.Add(twLogo)
                        Dim contentIDtw As String = "Image2"
                        twLogo.ContentId = contentIDtw

                        'To make the image display as inline and not as attachment

                        twLogo.ContentDisposition.Inline = True
                        twLogo.ContentDisposition.DispositionType = System.Net.Mime.DispositionTypeNames.Inline

                        '//To embed image in email

                        'message.Body = "<img src=""cid:" + contentID + """>" & message.Body




                    Catch ex As Exception

                        ErrHandler2.WriteError(ex)
                    End Try

                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////



                    Dim emailClient As SmtpClient = New SmtpClient(SmtpServer)

                    emailClient.Port = SmtpPort

                    'Si se solicitó SSL, lo activo
                    If EnableSSL = 1 Then
                        emailClient.EnableSsl = True
                        'Bypass de validación de certificado (para problemas con servidores de SMTP con SSL con certificados que no validan en nuestra máquina)
                        System.Net.ServicePointManager.ServerCertificateValidationCallback = New System.Net.Security.RemoteCertificateValidationCallback(AddressOf ValidarCertificado)
                    End If
                    ''Cargo las credenciales si hacen falta
                    'If Not String.IsNullOrEmpty(SSLuser) Then
                    '    Dim credenciales As New System.Net.NetworkCredential(SSLuser, SSLpass)
                    '    oSMTP.Credentials = credenciales
                    'End If

                    emailClient.EnableSsl = True
                    'emailClient.UseDefaultCredentials = False
                    emailClient.Credentials = New System.Net.NetworkCredential(SmtpUser, SmtpPass)





                    'Try
                    emailClient.Send(message)




                    '//////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////
                    'The remote certificate is invalid according to the validation procedure“.
                    '//////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////
                    'http://varionet.wordpress.com/category/systemnetmail/






                    '//////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////
                    'Problemas con la conexion al servidor SMTP
                    '//////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////


                    'If you have Windows XP SP2 (not sure how it works with SP1), Click CHANGE FIREWALL SETTINGS - click on ADVANCE - 
                    ' click on connection you are using for email -on the next page make sure that there is a check mark in front of 
                    '    POP3 and SMTP. Done! After hours of changing settings, this worked for me. Good luck to you!

                    'Also check off "TLS" under "Use secure connection." ?????
                    'http://forums.asp.net/p/1475014/3431732.aspx
                    'A connection attempt failed because the connected party did not properly respond after a period of time, 
                    'or established connection failed because connected host has failed to respond
                    'http://forum.umbraco.org/yaf_postst7439_A-connection-attempt-failed-because.aspx
                    '        Are you able to jump on the desktop of the webserver and verify that it is able to successfully 
                    'resolve and connect to the below web-service. You can just use IE to navigate to the URL.
                    'If you are unable to hit the service successfully from IE then its likely you have a misconfiguration 
                    'somewhere.I() 'd suggest first pinging the machine from dos, and veriyfing that DNS etc is setup correctly - checking IIS etc. 
                    '            cheers()
                    'http://www.TESTDOM.com/interface/webservices/TESTDOM.asmx

                    '        You can use localhost as your SMTP server only if you have a SMTP Service installed on the same computer hosting the application.

                    'In your case, I do not believe it is trying to connection to localhost (if it is trying to connect 
                    'to localhost, the IP should be 127.0.0.1).  Your application is trying to connect to 66.167.125.100 but there's no response from that IP.

                    'I tested connecting to this IP from my computer (over port 25) and it is responding.  
                    'The most likely cause is that the web server hosting the site does not allow outbound connection to be made

                    'If you have Windows XP SP2 (not sure how it works with SP1), Click CHANGE FIREWALL SETTINGS - click on ADVANCE - 
                    ' click on connection you are using for email -on the next page make sure that there is a check mark in front of 
                    '    POP3 and SMTP. Done! After hours of changing settings, this worked for me. Good luck to you!


                    'http://forums.asp.net/p/1274384/2421592.aspx

                    '        Please make sure it is able to connect from the production server to the server specified in ASP.NET application. 
                    '    Run a ping command from command line prompt to the server's IP address or server name to see the results. 
                    '   You should be able to see the results from command prompt which will indicate whether the connection is successful or not.
                    'According to your description, the server might locate in the same machine or in the same intranet. 
                    'For production enviroment, you might need to have similar deployment. 


                    '//////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////

                    'LabelError.Text = "Mensaje enviado satisfactoriamente"
                    'Catch ex As Exception
                    '    ErrHandler2.WriteError(ex.Message)
                    '    Debug.Print(ex.Message)
                    '    'LabelError.Text = "ERROR: " & ex.Message
                    '    Return False
                    'End Try



                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////

                    'metodo outlook
                    'http://www.elguille.info/colabora/puntoNET/Emanon_OutlookVB.htm
                    'http://www.forosdelweb.com/f29/programacion-con-outlook-vb-net-274661/

                    'Try
                    '    Dim m_OutLook As Microsoft.Office.Interop.Outlook.Application

                    '    Dim objMail As Microsoft.Office.Interop.Outlook.MailItem

                    '    m_OutLook = New Microsoft.Office.Interop.Outlook.Application
                    '    objMail = m_OutLook.CreateItem(Microsoft.Office.Interop.Outlook.OlItemType.olMailItem)
                    '    objMail.To = EmpleadoManager.GetItem(SC, myPresupuesto.IdComprador).Email

                    '    objMail.Subject = "Respuesta a Solicitación de Presupuesto"

                    '    objMail.Body = "El proveedor " & ProveedorManager.GetItem(SC, myPresupuesto.IdComprador).Nombre1 & " ha respondido a la solicitación de presupuesto " & myPresupuesto.Numero
                    '    objMail.Body = objMail.Body & "URL http://localhost:3688/Pronto/ProntoWeb/Presupuesto.aspx?Id=3&Empresa=Marcalba"



                    '    objMail.Send()

                    '    'MessageBox.Show("Mail Enviado", "Integración con OutLook", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)

                    'Catch ex As Exception

                    '    '* Si se produce algun Error Notificar al usuario

                    '    'MessageBox.Show("Error enviando mail")
                    '    Debug.Print(ex.Message)
                    'Finally
                    '    'm_OutLook = Nothing
                    'End Try


                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////////////


                End Using

                Return True
            Catch ex As Exception
                'if your Gmail account does not allow "Less Secure" apps to access it, you'll get an error and message sent to your inbox stating an unauthorized access attempt was caught.

                ErrHandler2.WriteError(ex)
                ErrHandler2.WriteError(De)
                ErrHandler2.WriteError(Para)
                Throw

            End Try

        End Function

        Private Shared Function ValidarCertificado(ByVal sender As Object, ByVal certificate As System.Security.Cryptography.X509Certificates.X509Certificate, ByVal chain As System.Security.Cryptography.X509Certificates.X509Chain, ByVal sslPolicyErrors As System.Net.Security.SslPolicyErrors) As Boolean
            'bypass de la validación del certificado (aplicar aquí validación personalizada si fuera el caso)
            Return True
        End Function





        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        'http://stackoverflow.com/questions/240713/how-can-i-encrypt-a-querystring-in-asp-net?lq=1
        'http://stackoverflow.com/questions/240713/how-can-i-encrypt-a-querystring-in-asp-net?lq=1
        Private Shared _key As String = "!#$a54?3"
        Public Shared Function encryptQueryString(ByVal strQueryString As String) As String
            Dim oES As New Encryption64()
            Return oES.Encrypt(strQueryString, _key)
        End Function

        Public Shared Function decryptQueryString(ByVal strQueryString As String) As String
            Dim oES As New Encryption64()
            Return oES.Decrypt(strQueryString, _key)
        End Function


        Public Shared Function EncriptarEntidadManager(ByVal SC As String) As String
            Dim x As New dsEncrypt
            x.KeyString = ("EDS")
            'Encriptar = x.Encrypt("Provider=SQLOLEDB.1;Persist Security Info=False;" + SC) 'esto era para el caso especial de compronto. pero no lo uses mas, porque sino estropeas las encriptaciones que no son de ese caso!
            EncriptarEntidadManager = x.Encrypt(SC)
        End Function



        Public Shared Function RebindEstablecimientos(ByVal SC As String)
            'http://weblogs.asp.net/scottgu/archive/2007/05/19/using-linq-to-sql-part-1.aspx

            'http://stackoverflow.com/questions/793718/paginated-search-results-with-linq-to-sql

            Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

            Dim establecimientos = From e In db.linqCDPEstablecimientos

            Return establecimientos
        End Function




        Public Shared Function TipoComprobanteAbreviatura(ByVal Id As IdTipoComprobante) As String
            Select Case Id
                Case IdTipoComprobante.Factura
                    Return "FA"
                Case IdTipoComprobante.NotaCredito
                    Return "NC"
                Case IdTipoComprobante.NotaDebito
                    Return "ND"
                Case IdTipoComprobante.Recibo
                    Return "RE"
            End Select
        End Function



        Public Shared Function ErrHandler2WriteErrorLogPronto(ByVal mensaje As String, ByVal SC As String, ByVal sNombreUsuario As String)
            LogPronto(SC, -999, mensaje, sNombreUsuario)
            ErrHandler2.WriteError(mensaje)
        End Function


        'Public Shared Function LogPronto(ByVal SC As String, ByVal Id As Long, ByVal sTipoEntidad As String, ByVal sesion As session)
        '    Return LogPronto(sc,id,stipoentidad,session(session_pronto)
        'End Function


        Public Shared Function LogPronto(ByVal SC As String, ByVal Id As Long, ByVal sTipoEntidadVARCHAR5 As String, Optional ByVal sNombreUsuario As String = "",
                                Optional str3 As String = "", Optional str4 As String = "", Optional str5 As String = "",
                                Optional num1 As Integer = 0, Optional num2 As Integer = 0, Optional num3 As Integer = 0
                            )



            ', Optional Aux3 As Object = DBNull.Value, Optional Aux4 As Object = DBNull.Value) ' , Optional Aux5 As Object = DBNull.Value)



            'todo: vinculos entre Logs y Copias de Historicos
            'Dumps
            'Visor de eventos de windows
            'profiler
            'rendimiento

            Const max = 100

            Dim arrayComentario = Split(sTipoEntidadVARCHAR5, , )


            Try
                EntidadManager.Tarea(SC, "Log_InsertarRegistro", IIf(Id <= 0, "ALTA", "MODIF"),
                              Id, 0, Now, 0, sTipoEntidadVARCHAR5,
                              "", sNombreUsuario, str3, str4, str5,
                            DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value,
                            num1, num2, num3, DBNull.Value, DBNull.Value)


                '@Tipo varchar(5),

                '@IdComprobante int,
                '@IdDetalleComprobante int,
                '@FechaRegistro datetime = Null,
                '@Cantidad numeric(18,2),
                '@Detalle varchar(100),

                '@AuxString1 varchar(50) = Null,
                '@AuxString2 varchar(50) = Null,
                '@AuxString3 varchar(50) = Null,
                '@AuxString4 varchar(50) = Null,
                '@AuxString5 varchar(50) = Null,

                '@AuxDate1 datetime = Null,
                '@AuxDate2 datetime = Null,
                '@AuxDate3 datetime = Null,
                '@AuxDate4 datetime = Null,
                '@AuxDate5 datetime = Null,
                '@AuxNum1 numeric(18,2) = Null,
                '@AuxNum2 numeric(18,2) = Null,
                '@AuxNum3 numeric(18,2) = Null,
                '@AuxNum4 numeric(18,2) = Null,
                '@AuxNum5 numeric(18,2) = Null


                'detalle
                '+5auxstring
                '+5auxdate
                '+5auxnum


            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try
        End Function





        Public Function IdTipoComprobanteDB(ByVal SC) As Long
            Return Val(ParametroManager.ParametroOriginal(SC, ParametroManager.ePmOrg.IdTipoComprobanteFacturaVenta))
            Return Val(ParametroManager.ParametroOriginal(SC, ParametroManager.ePmOrg.IdTipoComprobanteNotaCredito))
            Return Val(ParametroManager.ParametroOriginal(SC, ParametroManager.ePmOrg.IdTipoComprobanteNotaDebito))
            '            SET @IdMonedaPesos=(Select IdMoneda From Parametros Where IdParametro=1)
            'SET @IdMonedaDolar=(Select IdMonedaDolar From Parametros Where IdParametro=1)
            'SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
            'SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
            'SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
            'SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
            'SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)

        End Function




        Public Enum IdTipoComprobante
            Factura = 1
            NotaCredito = 4
            NotaDebito = 3
            Recibo = 2
            Remito = 41
            Devoluciones
            OrdenPago
            ComprobantePrv

            '            SET @IdMonedaPesos=(Select IdMoneda From Parametros Where IdParametro=1)
            'SET @IdMonedaDolar=(Select IdMonedaDolar From Parametros Where IdParametro=1)
            'SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
            'SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
            'SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
            'SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
            'SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
            'verificar que no sean diferentes en distintas bases
            '            1	Factura venta
            '2	Recibo de pago
            '3	Nota de debito
            '4	Nota de credito
            '5	Devolucion
            '6	Cheque
            '7	Documento
            '8	Descuento
            '9	Deposito
            '10	Nota de credito proveedor
            '11	Factura compra
            '13	Nota de credito proveedor (Int.)
            '14	Deposito bancario
            '15	Otros Ingresos
            '16	Compensacion
            '17	Orden de pago
            '18	Nota de debito proveedor
            '19	Nota de debito proveedor (Int.)
            '20	Pedido
            '21	Transferencia bancaria
            '22	Débito bancario
            '24	Lecop
            '25	Patacon
            '26	Cheque lecop
            '27	Cheque patacón
            '28	Débito Bancario Gtos
            '29	Crédito Bancario 
            '30	Deposito Efectivo
            '31	Devolucion Fondo Fijo
            '32	Caja ingresos 
            '33	Caja egresos 
            '34	Anticipos al Personal
            '35	Prestamos al Personal
            '36	Asiento Deudor
            '37	Asiento Acreedor
            '38	Asiento Manual
            '39	Plazo Fijo
            '40	Factura compra (Imp.)
            '41	Remito
            '42	Provision
            '43	Ticket
            '44	Débito Bancario Gtos (Int)
            '45	Crédito Bancario (Int)
            '46	Nota de credito L
            '47	Nota de debito L
            '48	Otros
        End Enum





        <DataObjectMethod(DataObjectMethodType.Select, True)>
        Public Shared Function GetListCombo(ByVal SC As String, ByVal Tabla As String) As System.Data.DataSet
            Return GeneralDB.TraerDatos(SC, "w" & Tabla & "_TL")
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)>
        Public Shared Function GetList(ByVal SC As String, ByVal Tabla As String, ByVal Parametros As Object) As System.Data.DataSet
            Return GeneralDB.TraerDatos(SC, "w" & Tabla & "_TT", Parametros)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)>
        Public Shared Function TraerDatos(ByVal SC As String, ByVal Nombre As String,
                    ByVal ParamArray Parametros() As Object) As System.Data.DataSet
            Return GeneralDB.TraerDatos(SC, Nombre, Parametros)
        End Function




        <DataObjectMethod(DataObjectMethodType.Select, True)>
        Public Shared Function TraerFiltrado(ByVal SC As String, ByVal enumNombreSP_Completo As enumSPs, ByVal ParamArray Parametros() As Object) As System.Data.DataTable
            Return GeneralDB.TraerDatos(SC, enumNombreSP_Completo.ToString, Parametros).Tables(0)
        End Function



        <DataObjectMethod(DataObjectMethodType.Select, True)>
        Public Shared Function GetListTX(ByVal SC As String, ByVal Tabla As String, ByVal TX As String, ByVal ParamArray Parametros() As Object) As System.Data.DataSet
            'Try
            'Return GeneralDB.TraerDatos(SC, "w" & Tabla & "_" & TX, Parametros)
            'Catch ex As Exception
            Return GeneralDB.TraerDatos(SC, Tabla & "_" & TX, Parametros)
            'End Try
        End Function



        <DataObjectMethod(DataObjectMethodType.Select, True)>
        Public Shared Function GetStoreProcedure(ByVal SC As String, ByVal enumNombreSP_Completo As enumSPs, ByVal ParamArray Parametros() As Object) As System.Data.DataTable
            Return GeneralDB.TraerDatos(SC, enumNombreSP_Completo.ToString, Parametros).Tables(0)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)>
        Public Shared Function GetStoreProcedure(ByVal SC As String, ByVal sStoreProcedure As String, ByVal ParamArray Parametros() As Object) As System.Data.DataTable

            'Return GeneralDB.TraerDatos(SC, sStoreProcedure, Parametros).Tables(0)

            Return TraerDatos2(SC, sStoreProcedure, Parametros).Tables(0)

        End Function




        Public Shared Function TraerDatos2(ByVal SC As String, ByVal sStoreProcedure As String, ByVal ParamArray Parametros() As Object) As DataSet


            Dim ds = New DataSet()

            Using myConnection As SqlConnection = New SqlConnection(Encriptar(SC))

                Dim myCommand As SqlCommand = New SqlCommand(sStoreProcedure, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure

                myConnection.Open()


                SqlCommandBuilder.DeriveParameters(myCommand) 'https://stackoverflow.com/a/5181871/1054200

                ' Now you can set values of parameters in a loop
                Dim n As Integer
                For n = 1 To myCommand.Parameters.Count - 1 'empiezo desde 1 para saltarme el parametro @return_value

                    Dim parameter As SqlParameter = myCommand.Parameters(n)


                    Dim p As Object
                    If (n - 1 >= Parametros.Count) Then
                        p = Nothing
                    Else
                        p = Parametros(n - 1)
                    End If


                    parameter.Value = p
                Next





                Dim da = New SqlDataAdapter()
                da.SelectCommand = myCommand

                da.Fill(ds)

            End Using


            Return ds
        End Function




        <DataObjectMethod(DataObjectMethodType.Select, True)>
        Public Shared Function GetStoreProcedureTop1(ByVal SC As String, ByVal enumNombreSP_Completo As enumSPs, ByVal ParamArray Parametros() As Object) As System.Data.DataRow
            Dim d As DataTable = GeneralDB.TraerDatos(SC, enumNombreSP_Completo.ToString, Parametros).Tables(0)
            If d.Rows.Count > 0 Then
                Return d.Rows(0)
            Else
                Return Nothing
            End If
        End Function


        <DataObjectMethod(DataObjectMethodType.Select, True)>
        Public Shared Function GetStoreProcedureTop1(ByVal SC As String, ByVal sStoreProcedure As String, ByVal ParamArray Parametros() As Object) As System.Data.DataRow
            Try
                Dim dt = GeneralDB.TraerDatos(SC, sStoreProcedure, Parametros)
                If dt.Tables(0).Rows.Count > 0 Then
                    Return dt.Tables(0).Rows(0)
                Else
                    Return Nothing
                End If

            Catch ex As Exception
                Try
                    Return GeneralDB.TraerDatos(SC, "w" & sStoreProcedure, Parametros).Tables(0).Rows(0)
                Catch x As Exception
                    ErrHandler2.WriteError(ex.Message)
                    Throw
                End Try
            End Try
        End Function


        Public Shared Function ProntoVariableGlobal(ByVal variable As String) As Object

        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)>
        Public Shared Function ExecDinamico(ByVal SC As String, ByVal sComandoDinamico As String, Optional ByVal timeoutSegundos As Integer = 0) As System.Data.DataTable


            Try
                Dim ret = GeneralDB.ExecDinamico(SC, sComandoDinamico, timeoutSegundos)
                'si no se está conectando remotamente, verificá que en host la ip de SERVERSQL3 esté apuntando a la ip (en numeros) de bdl

                'If IsNothing(ret) Then Return 0
                Return ret
            Catch ex As Exception
                'puede devolver una coleccion de errores
                'verificar que no falte alguna actualizacion de columna...
                ErrHandler2.WriteError(ex.Message)

                If InStr(ex.Message, "tiene un timeout menor que el pedido para la consulta") > 0 Then
                    Try
                        Dim ret = GeneralDB.ExecDinamico(SC, sComandoDinamico)
                        Return ret

                    Catch ex2 As Exception

                        ErrHandler2.WriteError(ex2.Message)
                        Throw

                    End Try

                ElseIf InStr(ex.Message, "El nombre de columna '") > 0 Then
                    If Diagnostics.Debugger.IsAttached Then
                        Stop
                        MsgBox("verificar que no falte alguna actualizacion de columna...")
                    End If

                    ErrHandler2.WriteError("verificar que no falte alguna actualizacion de columna...")
                End If

                Throw
            End Try

        End Function




        Public Shared Function TablaSelect(ByVal sc As String, ByVal Campo As String, ByVal Tabla As String, ByVal idTablaNombre As String, ByVal idTablaValor As Long) As String
            Try
                'ya que estoy haciendo esto, usar el QueryBuilder
                Dim query As New SelectQueryBuilder

                Dim dt As Data.DataTable = ExecDinamico(sc, String.Format("SELECT TOP 1 {0} FROM {1} WHERE {2}={3}", Campo, Tabla, idTablaNombre, idTablaValor))
                If dt.Rows.Count > 0 Then
                    Return dt.Rows(0).Item(0).ToString
                Else
                    Return Nothing
                End If

            Catch ex As Exception
                ErrHandler2.WriteError(ex.Message)
                Throw
            End Try
        End Function

        Enum enumTablas
            Cajas
            TarjetasCredito
        End Enum






        Public Shared Function LeerUno(ByVal sc As String, ByVal Tabla As String, ByVal id As Long) As DataRow
            If id < 1 Then Return Nothing

            Return GetStoreProcedureTop1(sc, Tabla & "_T", id)
        End Function


        Public Shared Function LeerUno(ByVal sc As String, ByVal Tabla As enumTablas, ByVal id As Long) As DataRow
            If id < 1 Then Return Nothing

            Dim dr As DataRow

            Select Case Tabla
                Case enumTablas.Cajas
                    dr = ExecDinamico(sc, String.Format("SELECT * FROM Cajas WHERE idCaja={1}", Tabla, id)).Rows(0)
                Case enumTablas.TarjetasCredito
                    dr = ExecDinamico(sc, String.Format("SELECT * FROM TarjetasCredito WHERE IdTarjetaCredito={1}", Tabla, id)).Rows(0)
            End Select

            Return dr
        End Function



        Public Shared Function TablaSelectId(ByVal sc As String, ByVal Tabla As String, ByVal Where As String) As Long
            Try
                Dim dt = ExecDinamico(sc, String.Format("SELECT TOP 1 * FROM {0} WHERE {1}", Tabla, Where))

                If dt.rows.count > 0 Then
                    Return dt.rows(0).item(0)
                Else
                    Return 0
                End If

            Catch ex As Exception
                ErrHandler2.WriteError(ex.Message)
                Throw

                'Return -1
            End Try
        End Function


        Public Shared Function TablaUpdate(ByVal sc As String, ByVal Tabla As String, ByVal WhereCampo As String, ByVal WhereValor As Long, ByVal SetCampo As String, ByVal SetValor As Object) As Integer

            'ya que estoy haciendo esto, usar el QueryBuilder
            Dim query As New SelectQueryBuilder

            Try
                ExecDinamico(sc, String.Format("UPDATE {0} SET {1}={2} WHERE {3}={4}", Tabla, SetCampo, SetValor, WhereCampo, WhereValor))
                Return 0
            Catch ex As Exception
                ErrHandler2.WriteError(ex.Message)
                Throw
                'Return -1
            End Try
        End Function


        <DataObjectMethod(DataObjectMethodType.Select, True)>
        Public Shared Function GetItem(ByVal SC As String, ByVal Tabla As String, ByVal Id As Integer) As System.Data.DataRow
            'Try
            ' Return GeneralDB.TraerDatos(SC, "w" & Tabla & "_T", CType(Id, Object)).Tables(0).Rows(0)
            'Catch ex As Exception
            Return GeneralDB.TraerDatos(SC, Tabla & "_T", CType(Id, Object)).Tables(0).Rows(0)
            'End Try
        End Function


        Public Shared Sub Tarea(ByRef myConnection As SqlConnection, ByRef Transaccion As SqlTransaction, ByVal sStoreProcedure As String, ByVal ParamArray Parametros() As Object)
            GeneralDB.EjecutarSP(myConnection, Transaccion, sStoreProcedure, Parametros)
        End Sub


        Public Shared Sub Tarea(ByVal SC As String, ByVal sStoreProcedure As String, ByVal ParamArray Parametros() As Object)
            GeneralDB.EjecutarSP(SC, sStoreProcedure, Parametros)
        End Sub




        Shared Function IdPuntoVentaComprobanteFacturaSegunSubnumeroYLetra(ByVal sc As String, ByVal NumeroDePuntoVenta As Integer, ByVal Letra As String) As Long
            Dim mvarPuntoVenta = IdPuntoVentaComprobanteSegunSubnumeroYLetra(sc, NumeroDePuntoVenta, Letra, IdTipoComprobante.Factura)
            Return mvarPuntoVenta
        End Function

        Shared Function IdPuntoVentaComprobanteNotaCreditoSegunSubnumeroYLetra(ByVal sc As String, ByVal NumeroDePuntoVenta As Integer, ByVal Letra As String) As Long
            Dim mvarPuntoVenta = IdPuntoVentaComprobanteSegunSubnumeroYLetra(sc, NumeroDePuntoVenta, Letra, IdTipoComprobante.NotaDebito)
            Return mvarPuntoVenta
        End Function


        Shared Function IdPuntoVentaComprobanteSegunSubnumeroYLetra(ByVal sc As String, ByVal NumeroDePuntoVenta As Integer, ByVal Letra As String, ByVal IdTipoComprobante As IdTipoComprobante) As Long
            Dim mvarPuntoVenta = EntidadManager.TablaSelectId(sc, "PuntosVenta", "PuntoVenta=" & NumeroDePuntoVenta & " AND Letra='" & Letra & "' AND IdTipoComprobante=" & IdTipoComprobante)
            Return mvarPuntoVenta
        End Function


        Public Shared Function ProximoNumeroPorIdPuntoVenta(ByVal SC As String, ByVal IdPuntoVenta As Integer) As Integer
            'Esto es generico para todos los comprobantes con talonario
            Dim oRs As DataRow = EntidadManager.GetStoreProcedureTop1(SC, "PuntosVenta_TX_PorId", IdPuntoVenta)
            Return oRs.Item("ProximoNumero")

        End Function




        Public Shared Function NombreCliente(ByVal SC As String, ByVal IdCliente As Object) As String
            If Not IsNumeric(IdCliente) Then Return Nothing
            If IdCliente <= 0 Then Return Nothing
            Try
                Return EntidadManager.GetItem(SC, "Clientes", IdCliente).Item("RazonSocial")
            Catch ex As Exception
                Return Nothing
            End Try
        End Function


        Public Shared Function NombreProveedor(ByVal SC As String, ByVal IdCliente As Object) As String
            If Not IsNumeric(IdCliente) Then Return Nothing
            Try
                Return EntidadManager.GetItem(SC, "Proveedores", IdCliente).Item("RazonSocial")
            Catch ex As Exception
                Return Nothing
            End Try
        End Function





        Public Shared Function NombreObra(ByVal SC As String, ByVal IdObra As Object) As String
            If Not IsNumeric(IdObra) Then Return Nothing
            Try
                Return EntidadManager.TablaSelect(SC, "isnull(NumeroObra,'') + ' - ' + Convert(varchar(200),isnull(Descripcion,'')  COLLATE SQL_Latin1_General_CP1_CI_AS)", "Obras", "IdObra", IdObra)
            Catch ex As Exception
                Return Nothing
            End Try
        End Function




        Public Shared Function NombreArticulo(ByVal SC As String, ByVal IdArticulo As Object) As String
            If Not IsNumeric(IdArticulo) Then Return Nothing
            Try
                Return ArticuloManager.GetItem(SC, IdArticulo).Descripcion
            Catch ex As Exception
                Return Nothing
            End Try
        End Function


        Public Shared Function NombreArticuloCodigo(ByVal SC As String, ByVal IdArticulo As Object) As String
            If Not IsNumeric(IdArticulo) Then Return Nothing
            Try
                Dim cod As String
                Using db As New DataClassesRequerimientoDataContext(Encriptar(SC))
                    cod = (From a In db.linqArtis Where a.IdArticulo = CLng(IdArticulo) Select a.Codigo).FirstOrDefault
                End Using
                Return cod
            Catch ex As Exception
                Return Nothing
            End Try
        End Function

        Public Shared Function NombreConcepto(ByVal SC As String, ByVal IdConcepto As Object) As String
            Try
                Return EntidadManager.GetItem(SC, "Conceptos", IdConcepto).Item("Descripcion")
            Catch ex As Exception
                Return Nothing
            End Try
        End Function

        Public Shared Function NombreCuenta(ByVal SC As String, ByVal IdCuenta As Object, Optional ByRef CodigoCuenta As String = "") As String
            If Not IsNumeric(IdCuenta) Then Return Nothing
            If IdCuenta <= 0 Then Return Nothing

            Try
                Dim dr = EntidadManager.GetItem(SC, "Cuentas", IdCuenta)
                CodigoCuenta = dr.Item("Codigo")
                Return dr.Item("Descripcion")
            Catch ex As Exception
                Return Nothing
            End Try
        End Function

        Public Shared Function NombreCuentaConSufijo(ByVal SC As String, ByVal IdCuenta As Object) As String
            Dim CodigoCuenta As String

            Dim cuenta = NombreCuenta(SC, IdCuenta, CodigoCuenta)

            Return cuenta + " " + CodigoCuenta
        End Function

        Public Shared Function NombreCuentaGasto(ByVal SC As String, ByVal IdCuentaGasto As Object) As String
            Try
                Return EntidadManager.GetItem(SC, "CuentasGasto", IdCuentaGasto).Item("Descripcion")
            Catch ex As Exception
                Return Nothing
            End Try
        End Function


        Public Shared Function NombreRubroContable(ByVal SC As String, ByVal IdRubro As Object) As String
            Try
                Return EntidadManager.GetItem(SC, "RubrosContables", IdRubro).Item("Descripcion")
            Catch ex As Exception
                Return Nothing
            End Try
        End Function




        Public Shared Function NombreComprobante(ByVal SC As String, ByVal IdTipoComprobante As EntidadManager.IdTipoComprobante, ByVal IdComprobante As Object) As String

            Try
                Select Case IdTipoComprobante

                    Case EntidadManager.IdTipoComprobante.Factura
                        'Return FacturaManager.GetItem(SC, IdComprobante).Numero
                        Return EntidadManager.GetItem(SC, "Facturas", IdComprobante).Item("NumeroFactura")

                    Case EntidadManager.IdTipoComprobante.NotaCredito
                        Return EntidadManager.GetItem(SC, "NotasCredito", IdComprobante).Item("NumeroNotaCredito")
                        'Return NotaDeCreditoManager.GetItem(SC, IdComprobante).NumeroNotaCredito

                    Case EntidadManager.IdTipoComprobante.NotaDebito
                        Return EntidadManager.GetItem(SC, "NotasDebito", IdComprobante).Item("NumeroNotaDebito")
                        'Return NotaDeDebitoManager.GetItem(SC, IdComprobante).NumeroNotaDebito

                    Case EntidadManager.IdTipoComprobante.Devoluciones


                End Select

            Catch ex As Exception
                Return Nothing
            End Try
        End Function

        Public Shared Function NombreComprobanteTipo(ByVal SC As String, ByVal IdTipoComprobante As Long) As String
            Try
                Return EntidadManager.GetItem(SC, "TiposComprobante", IdTipoComprobante).Item("Descripcion")
            Catch ex As Exception
                Return Nothing
            End Try
        End Function


        Public Shared Function NombreValorTipo(ByVal SC As String, ByVal IdValor As Object) As String
            Try
                Return NombreComprobanteTipo(SC, IdValor)
            Catch ex As Exception
                Return Nothing
            End Try
        End Function

        Public Shared Function NombreUnidad(ByVal SC As String, ByVal IdUnidad As Long) As String
            If IdUnidad < 1 Then Return Nothing
            Try
                Return EntidadManager.GetItem(SC, "Unidades", IdUnidad).Item("Descripcion")
            Catch ex As Exception
                Return Nothing
            End Try
        End Function




        Public Shared Function NombreFormaDespacho(ByVal SC As String, ByVal IdFormaDespacho As Long) As String
            If IdFormaDespacho < 1 Then Return ""
            Try
                Select Case IdFormaDespacho

                    Case 1
                        Return "granel"
                    Case 2
                        Return "bolsa"
                    Case 3
                        Return "bigbag"

                End Select



            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                Return ""
            End Try
        End Function


        Public Shared Function NombreUnidadAbreviatura(ByVal SC As String, ByVal IdUnidad As Long) As String
            If IdUnidad < 1 Then Return Nothing
            Try
                Return EntidadManager.GetItem(SC, "Unidades", IdUnidad).Item("Abreviatura")
            Catch ex As Exception
                Return Nothing
            End Try
        End Function


        Public Shared Function NombreVendedor(ByVal SC As String, ByVal IdVendedor As Object) As String
            If Not IsNumeric(IdVendedor) Then Return Nothing
            If IdVendedor < 1 Then Return Nothing
            Try
                Return EntidadManager.GetItem(SC, "Vendedores", IdVendedor).Item("Nombre")
            Catch ex As Exception
                Return Nothing
            End Try
        End Function

        Public Shared Function NombreCondicionVenta_y_Compra(ByVal SC As String, ByVal IdCondicionVentaCompra As Object) As String
            If Not IsNumeric(IdCondicionVentaCompra) Then Return Nothing
            Try
                Return EntidadManager.TablaSelect(SC, "Descripcion", "[Condiciones Compra]", "IdCondicionCompra", IdCondicionVentaCompra)
            Catch ex As Exception
                Return Nothing
            End Try
        End Function

        Public Shared Function NombreIngresosBrutosIIBB(ByVal SC As String, ByVal IdIBCondicion As Object) As String
            If Not IsNumeric(IdIBCondicion) Then Return Nothing
            Try
                Return EntidadManager.TablaSelect(SC, "Descripcion", "IBCondiciones", "IdIBCondicion", IdIBCondicion)
            Catch ex As Exception
                Return Nothing
            End Try
        End Function

        Public Shared Function NombreCondicionIVA(ByVal SC As String, ByVal IdCodigoIVA As Object) As String
            If Not IsNumeric(IdCodigoIVA) Then Return Nothing
            Try
                Return EntidadManager.TablaSelect(SC, "Descripcion", "DescripcionIva", "IdCodigoIVA", IdCodigoIVA)
            Catch ex As Exception
                Return Nothing
            End Try
        End Function


        Public Shared Function NombreDestino(ByVal SC As String, ByVal IdWilliamsDestino As Object) As String
            If Not IsNumeric(IdWilliamsDestino) Then Return Nothing
            Try
                Return EntidadManager.TablaSelect(SC, "Descripcion", "WilliamsDestinos", "IdWilliamsDestino", IdWilliamsDestino)
            Catch ex As Exception
                Return Nothing
            End Try
        End Function

        Public Shared Function NombreLocalidad(ByVal SC As String, ByVal IdLocalidad As Object) As String
            If Not IsNumeric(IdLocalidad) Then Return Nothing
            If IdLocalidad < 1 Then Return Nothing
            Try
                Return EntidadManager.GetItem(SC, "Localidades", IdLocalidad).Item("Nombre")
            Catch ex As Exception
                Return Nothing
            End Try
        End Function


        Public Shared Function NombreProvincia(ByVal SC As String, ByVal IdProvincia As Object) As String
            If Not IsNumeric(IdProvincia) Then Return Nothing
            If IdProvincia < 1 Then Return Nothing
            Try
                Return EntidadManager.GetItem(SC, "Provincias", IdProvincia).Item("Nombre")
            Catch ex As Exception
                Return Nothing
            End Try
        End Function


        Public Shared Function NombreCalidad(ByVal SC As String, ByVal IdCalidad As Object) As String
            If Not IsNumeric(IdCalidad) Then Return Nothing
            Try
                Return EntidadManager.GetItem(SC, "Calidades", IdCalidad).Item("Descripcion")
            Catch ex As Exception
                Return Nothing
            End Try
        End Function



        Public Shared Function LetraSegunTipoIVA(ByVal IdCodigoIva As Long) As String
            Dim mvarTipoABC As String
            'If Session("glbIdCodigoIva") = 1 Then
            If True Then
                Select Case IdCodigoIva
                    Case 1
                        'acá calcula el iva usando el neto total. por qué no lo hace por item como corresponde?
                        'mvarIVA1 = Math.Round(mvarNetoGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
                        'mvarPartePesos = mvarPartePesos + Math.Round((mvarPartePesos + (mvarParteDolares * mvarCotizacion)) * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
                        mvarTipoABC = "A"
                    Case 2
                        'acá calcula el iva usando el neto total. por qué no lo hace por item como corresponde?
                        'mvarIVA1 = Math.Round(mvarNetoGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
                        'mvarIVA2 = Math.Round(mvarNetoGravado * Val(txtPorcentajeIva2.Text) / 100, mvarDecimales)
                        'mvarPartePesos = mvarPartePesos + Math.Round((mvarPartePesos + (mvarParteDolares * mvarCotizacion)) * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales) + _
                        'Math.Round((mvarPartePesos + (mvarParteDolares * mvarCotizacion)) * Val(txtPorcentajeIva2.Text) / 100, mvarDecimales)
                        mvarTipoABC = "A"
                    Case 3
                        mvarTipoABC = "E"
                    Case 8
                        mvarTipoABC = "B"
                    Case 9
                        mvarTipoABC = "A"
                    Case Else
                        'mvarIVANoDiscriminado = Math.Round(mvarNetoGravado - (mvarNetoGravado / (1 + (Val(txtPorcentajeIva1.Text) / 100))), mvarDecimales)
                        mvarTipoABC = "B"
                End Select
            Else
                mvarTipoABC = "C"
            End If

            Return mvarTipoABC
        End Function


        Public Enum EnumFormularios 'este donde se usa???? q diferencia hay con el de IdTipoComprobante?
            ListaAcopio = 1
            ListaMateriales = 2
            RequerimientoMateriales = 3
            NotaPedido = 4
            Comparativa = 5
            AjusteStock = 6
            Presupuesto = 7
            SolicitudMateriales = 8
            SalidaMateriales = 9
            OtroIngresoAlmacen = 10
            RecepcionMateriales = 11
            OrdenesCompra = 21
            Remitos = 22
            Facturas = 23
            Devoluciones = 24
            Recibos = 25
            NotasDebito = 26
            NotasCredito = 27
            ComprobantesProveedores = 31
            OrdenesPago = 32
            Subdiarios = 41
            Asientos = 42
            DepositosBancarios = 51
            DebitosCreditosBancarios = 52
            ResumenesConciliacion = 53
            PlazosFijos = 54
        End Enum


        Public Shared Function GetPrecioPorLista(ByVal SC As String, ByVal IdArticulo As Long, Optional ByVal IdListaPrecios As Long = 0, Optional ByVal IdMoneda As Long = Nothing) As Double
            Return ListaPreciosManager.GetPrecioPorLista(SC, IdArticulo, IdListaPrecios, IdMoneda)
        End Function






        Public Shared Function CircuitoFirmasCompleto(ByVal SC As String, ByVal Comprobante As EnumFormularios,
                                              ByVal IdComprobante As Long,
                                              Optional ByVal Importe As Double = Nothing) As Boolean




            Return True


            Dim oRsAut1 As ADODB.Recordset
            Dim oRsAut2 As ADODB.Recordset
            Dim mCompleto As Boolean
            Dim mCantidadFirmas As Integer
            Dim i As Integer
            Dim mFirmas() As Boolean

            mCompleto = False


            oRsAut1 = EntidadManager.GetListTX(SC, "Autorizaciones", "TX_CantidadAutorizaciones", Comprobante, Importe)

            If oRsAut1.RecordCount > 0 Then

                mCantidadFirmas = oRsAut1.RecordCount
                ReDim mFirmas(mCantidadFirmas)
                For i = 1 To mCantidadFirmas
                    mFirmas(i) = False
                Next

                oRsAut2 = EntidadManager.GetListTX(SC, "AutorizacionesPorComprobante", "TX_AutorizacionesPorComprobante", Comprobante, IdComprobante)

                With oRsAut2
                    If .RecordCount > 0 Then
                        .MoveFirst()
                        Do While Not .EOF
                            oRsAut1.MoveFirst()
                            Do While Not oRsAut1.EOF
                                If oRsAut1.Fields(0).Value = .Fields("OrdenAutorizacion").Value Then
                                    mFirmas(oRsAut1.AbsolutePosition) = True
                                    Exit Do
                                End If
                                oRsAut1.MoveNext()
                            Loop
                            .MoveNext()
                        Loop
                    End If
                    oRsAut2.Close()
                End With

                CircuitoFirmasCompleto = True

                If Comprobante = EnumFormularios.RecepcionMateriales Then
                    oRsAut2 = GetStoreProcedure(SC, enumSPs.Requerimientos_TX_PorId, IdComprobante)
                    If oRsAut2.RecordCount > 0 Then
                        If IIf(IsNull(oRsAut2.Fields("CircuitoFirmasCompleto").Value), "NO", oRsAut2.Fields("CircuitoFirmasCompleto").Value) = "SI" Then
                            oRsAut2.Close()
                            GoTo Salida
                        End If
                        oRsAut2.Close()
                    End If
                ElseIf Comprobante = EnumFormularios.NotaPedido Then
                    'oRsAut2 = PedidoManager.GetListTX(SC, "_PorId", IdComprobante)
                    oRsAut2 = EntidadManager.GetListTX(SC, "Pedidos", "_PorId", IdComprobante)

                    If oRsAut2.RecordCount > 0 Then
                        If IIf(IsNull(oRsAut2.Fields("CircuitoFirmasCompleto").Value), "NO", oRsAut2.Fields("CircuitoFirmasCompleto").Value) = "SI" Then
                            oRsAut2.Close()
                            GoTo Salida
                        End If
                        oRsAut2.Close()
                    End If
                End If

                For i = 1 To mCantidadFirmas
                    If Not mFirmas(i) Then
                        CircuitoFirmasCompleto = False
                        Exit For
                    End If
                Next

            Else

                CircuitoFirmasCompleto = True

            End If

Salida:
            oRsAut1.Close()

            oRsAut1 = Nothing
            oRsAut2 = Nothing

        End Function


        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        Public Shared Function BuscarClaveINI(ByVal mClave As String, ByVal SC As String, ByVal glbIdUsuario As Integer) As String

            Dim oRs As ADODB.Recordset
            Dim s As String

            s = ""


            oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "ProntoIni", "TX_PorClave", mClave, glbIdUsuario))
            If oRs.RecordCount > 0 Then
                s = IIf(IsNull(oRs.Fields("Valor").Value), "", oRs.Fields("Valor").Value)
            End If
            oRs.Close()

            oRs = Nothing

            BuscarClaveINI = s

        End Function

        Public Shared Function TraerFiltradoVB6(ByVal SC As String, ByVal enumNombreSP_Completo As enumSPs, ByVal ParamArray Parametros() As Object) As ADODB.Recordset
            Return DataTable_To_Recordset(GeneralDB.TraerDatos(SC, enumNombreSP_Completo.ToString, Parametros).Tables(0))
        End Function

        Public Shared Function LeerUnoVB6(ByVal sc As String, ByVal Tabla As String, ByVal id As Long) As ADODB.Recordset
            Return DataTable_To_Recordset(GetStoreProcedureTop1(sc, Tabla & "_T", id).Table)
        End Function














        Shared Function BuscaIdArticuloNET(ByVal descripcion As String, ByVal SC As String) As Long
            Dim p As Pronto.ERP.BO.Articulo
            p = ArticuloManager.GetList(SC).Find(Function(obj) InStr(obj.Descripcion.ToUpper, descripcion.ToUpper) > 0)
            If p Is Nothing Then
                Return -1
            Else
                Return p.Id
            End If
        End Function


        Shared Function BuscaIdProveedorNET(ByVal descripcion As String, ByVal SC As String) As Long
            Dim p As Pronto.ERP.BO.Proveedor
            p = ProveedorManager.GetList(SC).Find(Function(obj) InStr(obj.RazonSocial, descripcion) > 0)
            If p Is Nothing Then
                Return -1
            Else
                Return p.Id
            End If

        End Function



        Shared Function BuscaIdUnidadNET(ByVal descripcion As String, ByVal SC As String) As Long
            Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Unidades")
            If ds.Tables(0).Rows.Count > 0 Then
                For Each dr As Data.DataRow In ds.Tables(0).Rows
                    If dr.Item(1) = descripcion Then
                        Return dr.Item("IdUnidad")
                    End If
                Next
            End If

            Return -1

        End Function










        Shared Function facturaelectronica()
            ''////////////////////////////////////////////////////////////////////
            ''Usando el SCFE9 que usa el PRONTO
            ''http://sites.google.com/site/facturaelectronicax/Home/version-full
            ''http://sites.google.com/site/facturaelectronicax/Home/ejemplos/visualbasic

            ''otros
            ''http://www.sistemasagiles.com.ar/trac/wiki/PyRece 
            ''http://www.sistemasagiles.com.ar/tra...uraElectronica
            ''http://www.psicofxp.com/forums/temas-laborales.128/853788-rece-cae-recel-factura-electronica.html
            ''////////////////////////////////////////////////////////////////////
            ''////////////////////////////////////////////////////////////////////

            Dim FE As WSAFIPFE.Factura = New WSAFIPFE.Factura()
            Dim FEx As WSAFIPFE.Factura


            Dim mWS, mvarTipoABC, glbArchivoAFIP, mCodigoMoneda, glbidmonedaeuro, glbidmonedadolar, glbcuit, glbpathplantillas, glbdebugfacturaelectronica
            Dim glbIdMonedaPesos, dtfields(), mfecha, mmodotest, mresul, dcfields(), ors, mncm, mnumeroitem, mdescripcion, midentificador
            Dim ors1, txtcuit, aplicacion, mcae
            Dim mUnidadesCodigoAFIP, mCantidadItem
            Dim compronto, vbdefault
            Dim mvarimprime
            Dim mtipocomprobante
            Dim mdomicilio, mcodigomoneda1, mcuitpais, txtcotizacionmoneda, mvartotalfactura
            Dim mvarsubtotal, mvarimportebonificacion, rchfacturaelectronica, origen
            Dim mvarporcentajeibrutos, mvarporcentajeibrutos2, mvarporcentajeibrutos3
            Dim txttotal
            Dim mpaisdestino, mcliente
            Dim combo1



            If True Or (mWS = "WSFE" And (mvarTipoABC = "A" Or mvarTipoABC = "B")) Then
                If False Then
                    If Len(Trim(glbArchivoAFIP)) = 0 Then
                        ' Me.MousePointer = vbDefault
                        MsgBox("No ha definido el archivo con el certificado AFIP, ingrese a los datos de la empresa y registrelo", vbInformation)
                        Exit Function
                    End If

                    mCodigoMoneda = 0
                    ors = aplicacion.Monedas.TraerFiltrado("_PorId", dcfields(3).BoundText)
                    If ors.RecordCount > 0 Then
                        If Not IsNull(ors.Fields("CodigoAFIP").Value) Then
                            If IsNumeric(ors.Fields("CodigoAFIP").Value) Then mCodigoMoneda = ors.Fields("CodigoAFIP").Value
                        End If
                    End If
                    ors.Close()
                    If mCodigoMoneda = 0 Then
                        If dcfields(3).BoundText = glbIdMonedaPesos Then mCodigoMoneda = 1
                        If dcfields(3).BoundText = glbidmonedadolar Then mCodigoMoneda = 2
                        If dcfields(3).BoundText = glbidmonedaeuro Then mCodigoMoneda = 60
                    End If

                    'Set FE = CreateObject("SCFE9.Factura")
                    FE = CreateObject("WSAFIPFE.Factura")

                    mresul = FE.ActivarLicenciaSiNoExiste(Replace(glbcuit, "-", ""), glbpathplantillas & "\FE_" & Replace(glbcuit, "-", "") & ".lic", "pronto.wsfex@gmail.com", "bdlconsultores")
                    If glbdebugfacturaelectronica Then
                        MsgBox("ActivarLicencia : " & glbpathplantillas & "\FE_" & Replace(glbcuit, "-", "") & ".lic" & " - UltimoMensajeError : " & FE.UltimoMensajeError)
                    End If

                    'FE.ProxyConfigurar False
                    mfecha = "" & Year(dtfields(0).Value) & Format(Month(dtfields(0).Value), "00") & Format(Day(dtfields(0).Value), "00")
                End If
                If mmodotest = "SI" Then
                    mresul = FE.iniciar(0, Replace(glbcuit, "-", ""), glbpathplantillas & "\" & glbArchivoAFIP & ".pfx", "")
                Else
                    'If Len(Dir(glbPathPlantillas & "\SCFE9.lic")) > 0 Then
                    'mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", glbPathPlantillas & "\SCFE9.lic")
                    mresul = FE.iniciar(1, Replace(glbcuit, "-", ""), glbpathplantillas & "\" & glbArchivoAFIP & ".pfx", glbpathplantillas & "\FE_" & Replace(glbcuit, "-", "") & ".lic")
                    'Else
                    'mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", "")
                    'End If
                End If


                'fer me comento que el recibe el crt y manualmente con unas magias lo convierte a pfx
                'cuando le dije que el tango se hace cargo, me pidio que lo discuta con edu, porque quizas así él se ahorra el tramite medio extraño
                'en cuanto al .lic, parece que el pronto (o la biblioteca) lo va a buscar si es que no esta presente


                If mresul Then mresul = FE.ObtenerTicketAcceso()
                With FE
                    If glbdebugfacturaelectronica Then
                        MsgBox("ObtenerTicketAcceso : " & mresul & " - UltimoMensajeError : " & .UltimoMensajeError)
                        mresul = .Dummy
                        MsgBox("Dummy : " & mresul & " - UltimoMensajeError : " & .UltimoMensajeError)
                    End If
                    If mresul Then
                        .FECabeceraCantReg = 1
                        .FECabeceraPresta_serv = 1
                        .indice = 0
                        .FEDetalleFecha_vence_pago = mfecha
                        .FEDetalleFecha_serv_desde = mfecha
                        .FEDetalleFecha_serv_hasta = mfecha
                        .FEDetalleFecha_vence_pago = mfecha
                        .FEDetalleImp_neto = mvarsubtotal - mvarimportebonificacion
                        .FEDetalleImp_total = mvartotalfactura
                        .FEDetalleFecha_cbte = mfecha
                        .FEDetalleNro_doc = Replace(txtcuit.Text, "-", "")
                        .FEDetalleTipo_doc = 80

                        If glbdebugfacturaelectronica Then
                            .ArchivoXMLEnviado = "C:\XMLEnviado.xml"
                            .ArchivoXMLRecibido = "C:\XMLRecibido.xml"
                        End If


                        Dim pventa As Integer = 1

                        Randomize()
                        midentificador = CLng(Rnd() * 100000000)
                        If mvarTipoABC = "A" Then
                            mresul = .Registrar(pventa, 1, "" & midentificador)
                            'mResul = .RegistrarConNumero(dcfields(10).Text, 1, "" & mIdentificador, txtNumeroFactura.Text)
                        Else
                            mresul = .Registrar(pventa, 6, "" & midentificador)
                        End If
                        If glbdebugfacturaelectronica Then
                            MsgBox("Registrar : " & mresul & " - UltimoMensajeError : " & .UltimoMensajeError & " - Motivo : " & .FERespuestaMotivo)
                            rchfacturaelectronica.Text = "Request : " & FE.XMLRequest & vbCrLf & vbCrLf & "Response : " & FE.XMLResponse
                        End If

                        If mresul Then
                            mcae = .FERespuestaDetalleCae
                            mdescripcion = Chr(10) + "CAE: " + .FERespuestaDetalleCae + Chr(10) + "MOTIVO " + .FERespuestaDetalleMotivo +
                                           Chr(10) + "PROCESO " + .FERespuestaReproceso + Chr(10) + "NUMERO: " + Str(.FERespuestaDetalleCbt_desde)
                            With origen.Registro
                                .Fields("CAE").Value = mcae
                                .Fields("IdIdentificacionCAE").Value = midentificador
                                If IsDate(FE.FERespuestaDetalleFecha_vto) Then
                                    .Fields("FechaVencimientoORechazoCAE").Value = FE.FERespuestaDetalleFecha_vto
                                End If
                                '.Fields("Observaciones").Value = .Fields("Observaciones").Value + Chr(10) + mDescripcion
                            End With
                        Else
                            'Me.MousePointer = vbDefault
                            MsgBox("Error al obtener CAE : " + .UltimoMensajeError, vbExclamation)
                            Exit Function
                        End If
                    Else
                        'Me.MousePointer = vbDefault
                        MsgBox("Error al obtener CAE : " + .UltimoMensajeError, vbExclamation)
                        Exit Function
                    End If
                End With
                FE = Nothing

            ElseIf mWS = "WSBFE" And (mvarTipoABC = "A" Or mvarTipoABC = "B") Then
                If Len(Trim(glbArchivoAFIP)) = 0 Then
                    'Me.MousePointer = vbDefault
                    MsgBox("No ha definido el archivo con el certificado AFIP, ingrese a los datos de la empresa y registrelo", vbInformation)
                    Exit Function
                End If

                If mvarTipoABC = "A" Then
                    mtipocomprobante = 1
                Else
                    mtipocomprobante = 6
                End If

                mCodigoMoneda = 0
                ors = aplicacion.Monedas.TraerFiltrado("_PorId", dcfields(3).BoundText)
                If ors.RecordCount > 0 Then
                    If Not IsNull(ors.Fields("CodigoAFIP").Value) Then
                        If IsNumeric(ors.Fields("CodigoAFIP").Value) Then
                            mCodigoMoneda = ors.Fields("CodigoAFIP").Value
                        End If
                    End If
                End If
                ors.Close()
                If mCodigoMoneda = 0 Then
                    If dcfields(3).BoundText = glbIdMonedaPesos Then mCodigoMoneda = 1
                    If dcfields(3).BoundText = glbidmonedadolar Then mCodigoMoneda = 2
                    If dcfields(3).BoundText = glbidmonedaeuro Then mCodigoMoneda = 60
                End If



                FE = CreateObject("SCFE9.Factura")
                FE = CreateObject("WSAFIPFE.Factura")



                mresul = FE.ActivarLicenciaSiNoExiste(Replace(glbcuit, "-", ""), glbpathplantillas & "\FE_" & Replace(glbcuit, "-", "") & ".lic", "pronto.wsfex@gmail.com", "bdlconsultores")
                If glbdebugfacturaelectronica Then
                    MsgBox("ActivarLicencia : " & glbpathplantillas & "\FE_" & Replace(glbcuit, "-", "") & ".lic" & " - UltimoMensajeError : " & FE.UltimoMensajeError)
                End If

                'fer me comento que el recibe el crt y manualmente con unas magias lo convierte a pfx
                'cuando le dije que el tango se hace cargo, me pidio que lo discuta con edu, porque quizas así él se ahorra el tramite medio extraño
                'en cuanto al .lic, parece que el pronto (o la biblioteca) lo va a buscar si es que no esta presente


                'FE.ProxyConfigurar False
                mfecha = "" & Year(dtfields(0).Value) & Format(Month(dtfields(0).Value), "00") & Format(Day(dtfields(0).Value), "00")
                If mmodotest = "SI" Then
                    mresul = FE.iniciar(0, Replace(glbcuit, "-", ""), glbpathplantillas & "\" & glbArchivoAFIP & ".pfx", "")
                Else
                    'If Len(Dir(glbPathPlantillas & "\SCFE9.lic")) > 0 Then
                    'mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", glbPathPlantillas & "\SCFE9.lic")
                    mresul = FE.iniciar(1, Replace(glbcuit, "-", ""), glbpathplantillas & "\" & glbArchivoAFIP & ".pfx", glbpathplantillas & "\FE_" & Replace(glbcuit, "-", "") & ".lic")
                    'Else
                    'mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", "")
                    'End If
                End If
                If mresul Then mresul = FE.bObtenerTicketAcceso()
                With FE
                    If glbdebugfacturaelectronica Then
                        MsgBox("ObtenerTicketAcceso : " & mresul & " - UltimoMensajeError : " & .UltimoMensajeError)
                        mresul = .Dummy
                        MsgBox("Dummy : " & mresul & " - UltimoMensajeError : " & .UltimoMensajeError)
                    End If
                    If mresul Then
                        .bTipo_Doc = 80
                        .bNro_doc = Replace(txtcuit.Text, "-", "")
                        .bTipo_cbte = mtipocomprobante
                        .bPunto_vta = dcfields(10).Text
                        .bImp_total = mvartotalfactura
                        .bImp_neto = mvarsubtotal - mvarimportebonificacion
                        .bimpto_liq = 0
                        .bimpto_liq_rni = 0
                        .bimp_op_ex = 0
                        .bImp_perc = Val(txttotal(6).Text) + Val(txttotal(7).Text) + Val(txttotal(10).Text)
                        .bImp_iibb = mvarporcentajeibrutos + mvarporcentajeibrutos2 + mvarporcentajeibrutos3
                        .bImp_internos = 0
                        .bImp_moneda_id = mCodigoMoneda
                        .bImp_moneda_ctz = Val(txtcotizacionmoneda.Text)
                        .bFecha_cbte = mfecha
                        .bZona = 1

                        ors = origen.DetFacturas.TodosLosRegistros
                        If ors.Fields.Count > 0 Then
                            If ors.RecordCount > 0 Then
                                mCantidadItem = 0
                                ors.MoveFirst()
                                Do While Not ors.EOF
                                    If ors.Fields("Eliminado").Value <> "SI" Then mCantidadItem = mCantidadItem + 1
                                    ors.MoveNext()
                                Loop
                                .bItemCantidad = mCantidadItem
                                mnumeroitem = 0
                                ors.MoveFirst()
                                Do While Not ors.EOF
                                    If ors.Fields("Eliminado").Value <> "SI" Then
                                        mdescripcion = ""
                                        mncm = ""
                                        ors1 = aplicacion.Articulos.TraerFiltrado("_PorId", ors.Fields("IdArticulo").Value)
                                        If ors1.RecordCount > 0 Then
                                            mdescripcion = IIf(IsNull(ors1.Fields("Descripcion").Value), "", ors1.Fields("Descripcion").Value)
                                            mncm = IIf(IsNull(ors1.Fields("AuxiliarString10").Value), "", ors1.Fields("AuxiliarString10").Value)
                                        End If
                                        If Len(mncm) = 0 Then mncm = "99.99.99.99"
                                        ors1.Close()
                                        .bIndiceItem = mnumeroitem
                                        .bITEMpro_codigo_sec = "0"
                                        .bITEMpro_codigo_ncm = mncm
                                        .bITEMpro_ds = mdescripcion
                                        .bITEMpro_precio_uni = ors.Fields("PrecioUnitario").Value
                                        .bITEMpro_qty = ors.Fields("Cantidad").Value
                                        .bITEMpro_umed = 7
                                        .bITEMIva_id = 1
                                        .bITEMimp_total = Math.Round(IIf(IsNull(ors.Fields("Cantidad").Value), 0, ors.Fields("Cantidad").Value) *
                                                                      IIf(IsNull(ors.Fields("PrecioUnitario").Value), 0, ors.Fields("PrecioUnitario").Value) *
                                                                      (1 - (IIf(IsNull(ors.Fields("Bonificacion").Value), 0, ors.Fields("Bonificacion").Value) / 100)), 2)
                                        .bITEMimp_bonif = Math.Round(IIf(IsNull(ors.Fields("Cantidad").Value), 0, ors.Fields("Cantidad").Value) *
                                                                      IIf(IsNull(ors.Fields("PrecioUnitario").Value), 0, ors.Fields("PrecioUnitario").Value) *
                                                                      IIf(IsNull(ors.Fields("Bonificacion").Value), 0, ors.Fields("Bonificacion").Value) / 100, 2)
                                        mnumeroitem = mnumeroitem + 1
                                    End If
                                    ors.MoveNext()
                                Loop
                            End If
                        End If
                        ors = Nothing

                        If glbdebugfacturaelectronica Then
                            .ArchivoXMLEnviado = "C:\XMLEnviado.xml"
                            .ArchivoXMLRecibido = "C:\XMLRecibido.xml"
                        End If

                        Randomize()
                        midentificador = CLng(Rnd() * 100000000)
                        mresul = .bRegistrar(dcfields(10).Text, mtipocomprobante, "" & midentificador)
                        'mResul = .bRegistrarConNumero(dcfields(10).Text, mTipoComprobante, "" & mvarId, 1)
                        If glbdebugfacturaelectronica Then
                            MsgBox("Registrar : " & mresul & " - UltimoMensajeError : " & .UltimoMensajeError & " - Motivo : " & .FERespuestaMotivo)
                            rchfacturaelectronica.Text = "Request : " & FE.XMLRequest & vbCrLf & vbCrLf & "Response : " & FE.XMLResponse
                        End If

                        If mresul Then
                            mcae = .bRespuestaCAE
                            mdescripcion = Chr(10) + "CAE: " + .bRespuestaCAE + Chr(10) + "REPROCESO " + .bRespuestaReproceso +
                                           Chr(10) + "Evento " + .bEventMsg + Chr(10) + "Observacion: " + .bRespuestaOBS
                            With origen.Registro
                                .Fields("CAE").Value = mcae
                                .Fields("IdIdentificacionCAE").Value = midentificador
                                If IsDate(FE.bRespuestaFch_venc_cae) Then
                                    .Fields("FechaVencimientoORechazoCAE").Value = FE.bRespuestaFch_venc_cae
                                End If
                                '.Fields("Observaciones").Value = .Fields("Observaciones").Value + Chr(10) + mDescripcion
                            End With
                        Else
                            ' Me.MousePointer = vbDefault
                            MsgBox("Error al obtener CAE : " + .Permsg + "Detalle: " + .UltimoMensajeError, vbExclamation)
                            Exit Function
                        End If
                    Else
                        'Me.MousePointer = vbDefault
                        MsgBox("Error al obtener CAE : " + .Permsg + "Detalle: " + .UltimoMensajeError, vbExclamation)
                        Exit Function
                    End If
                End With
                FE = Nothing

            ElseIf Len(mWS) > 0 And mvarTipoABC = "E" Then
                If Len(Trim(glbArchivoAFIP)) = 0 Then
                    'Me.MousePointer = vbDefault
                    MsgBox("No ha definido el archivo con el certificado AFIP, ingrese a los datos de la empresa y registrelo", vbInformation)
                    Exit Function
                End If

                mtipocomprobante = 19

                mcodigomoneda1 = ""
                ors = aplicacion.Monedas.TraerFiltrado("_PorId", dcfields(3).BoundText)
                If ors.RecordCount > 0 Then
                    If Not IsNull(ors.Fields("CodigoAFIP").Value) Then
                        If IsNumeric(ors.Fields("CodigoAFIP").Value) Then
                            mcodigomoneda1 = ors.Fields("CodigoAFIP").Value
                        End If
                    End If
                End If
                ors.Close()
                If Len(mcodigomoneda1) = 0 Then
                    If dcfields(3).BoundText = glbIdMonedaPesos Then mcodigomoneda1 = "PES"
                    If dcfields(3).BoundText = glbidmonedadolar Then mcodigomoneda1 = "DOL"
                End If

                ors = aplicacion.Clientes.TraerFiltrado("_PorIdConDatos", dcfields(0).BoundText)
                If ors.RecordCount > 0 Then
                    mpaisdestino = ors.Fields("PaisCodigo2").Value
                    mcuitpais = ors.Fields("CuitPais").Value
                    mcliente = IIf(IsNull(ors.Fields("RazonSocial").Value), "", ors.Fields("RazonSocial").Value)
                    mdomicilio = IIf(IsNull(ors.Fields("Direccion").Value), "", ors.Fields("Direccion").Value & " ") &
                                IIf(IsNull(ors.Fields("Localidad").Value), "", ors.Fields("Localidad").Value & " ") &
                                IIf(IsNull(ors.Fields("Provincia").Value), "", ors.Fields("Provincia").Value & " ") &
                                IIf(IsNull(ors.Fields("Pais").Value), "", ors.Fields("Pais").Value)
                End If
                ors.Close()
                ors = Nothing

                If Len(mpaisdestino) = 0 Then
                    MsgBox("Para el registro electronico de la factura, el pais del destinatario debe tener el codigo 2", vbExclamation)
                    Exit Function
                End If
                If Len(mcuitpais) = 0 Then
                    MsgBox("Para el registro electronico de la factura, el pais del destinatario debe tener el cuit-pais", vbExclamation)
                    Exit Function
                End If

                FEx = CreateObject("WSAFIPFE.Factura")
                If glbdebugfacturaelectronica Then
                    MsgBox("CreateObject('WSAFIPFE.Factura') ok - UltimoMensajeError : " & FEx.UltimoMensajeError)
                End If

                mfecha = "" & Year(dtfields(0).Value) & Format(Month(dtfields(0).Value), "00") & Format(Day(dtfields(0).Value), "00")

                mresul = FEx.ActivarLicencia(Replace(glbcuit, "-", ""), glbpathplantillas & "\FEX_" & Replace(glbcuit, "-", "") & ".lic", "pronto.wsfex@gmail.com", "bdlconsultores")
                If glbdebugfacturaelectronica Then
                    MsgBox("ActivarLicencia : " & glbpathplantillas & "\FEX_" & Replace(glbcuit, "-", "") & ".lic" & " - UltimoMensajeError : " & FEx.UltimoMensajeError)
                End If

                If mmodotest = "SI" Then
                    mresul = FEx.iniciar(0, Replace(glbcuit, "-", ""), glbpathplantillas & "\" & glbArchivoAFIP & ".pfx", "")
                Else
                    If Len(Dir(glbpathplantillas & "\SCFE9.lic")) > 0 Then
                        mresul = FEx.iniciar(1, Replace(glbcuit, "-", ""), glbpathplantillas & "\" & glbArchivoAFIP & ".pfx", glbpathplantillas & "\FEX_" & Replace(glbcuit, "-", "") & ".lic")
                    Else
                        mresul = FEx.iniciar(1, Replace(glbcuit, "-", ""), glbpathplantillas & "\" & glbArchivoAFIP & ".pfx", "")
                    End If
                End If
                If glbdebugfacturaelectronica Then MsgBox("Iniciar : " & mresul & " - UltimoMensajeError : " & FEx.UltimoMensajeError)
                If mresul Then mresul = FEx.xObtenerTicketAcceso()
                With FEx
                    If glbdebugfacturaelectronica Then
                        MsgBox("ObtenerTicketAcceso : " & mresul & " - UltimoMensajeError : " & .UltimoMensajeError)
                        mresul = .Dummy
                        MsgBox("Dummy : " & mresul & " - UltimoMensajeError : " & .UltimoMensajeError)
                    End If
                    If mresul Then
                        .xPunto_vta = dcfields(10).Text
                        .xFecha_cbte = mfecha
                        .xtipo_expo = combo1(0).ListIndex + 1
                        .xDst_cmp = mpaisdestino
                        '                  If Option3(0).Value Then
                        '                     .xPermiso_existente = "S"
                        '                  Else
                        .xPermiso_existente = "N"
                        '                  End If
                        .xPermisoNoInformar = 1
                        .xCliente = mcliente
                        .xCuit_pais_clienteS = mcuitpais
                        .xDomicilio_cliente = mdomicilio
                        .xId_impositivo = ""
                        .xMoneda_id = mcodigomoneda1
                        .xMoneda_ctz = Val(txtcotizacionmoneda.Text)
                        .xObs_comerciales = ""
                        .xImp_total = mvartotalfactura
                        .xForma_pago = dcfields(1).Text
                        .xIncoTerms = "CIF"
                        .xIncoTerms_ds = ""
                        .xIdioma_cbte = 1

                        ors = origen.DetFacturas.TodosLosRegistros
                        If ors.Fields.Count > 0 Then
                            If ors.RecordCount > 0 Then
                                mCantidadItem = 0
                                ors.MoveFirst()
                                Do While Not ors.EOF
                                    If ors.Fields("Eliminado").Value <> "SI" Then mCantidadItem = mCantidadItem + 1
                                    ors.MoveNext()
                                Loop
                                .xItemCantidad = mCantidadItem
                                mnumeroitem = 0
                                ors.MoveFirst()
                                Do While Not ors.EOF
                                    If ors.Fields("Eliminado").Value <> "SI" Then
                                        mdescripcion = ""
                                        mncm = ""
                                        ors1 = aplicacion.Articulos.TraerFiltrado("_PorId", ors.Fields("IdArticulo").Value)
                                        If ors1.RecordCount > 0 Then
                                            mdescripcion = IIf(IsNull(ors1.Fields("Descripcion").Value), "", ors1.Fields("Descripcion").Value)
                                            mncm = IIf(IsNull(ors1.Fields("AuxiliarString10").Value), "", ors1.Fields("AuxiliarString10").Value)
                                        End If
                                        If Len(mncm) = 0 Then mncm = "99.99.99.99"
                                        ors1.Close()

                                        mUnidadesCodigoAFIP = ""
                                        ors1 = aplicacion.Unidades.TraerFiltrado("_PorId", ors.Fields("IdUnidad").Value)
                                        If ors1.RecordCount > 0 Then
                                            mUnidadesCodigoAFIP = IIf(IsNull(ors1.Fields("CodigoAFIP").Value), "", ors1.Fields("CodigoAFIP").Value)
                                        End If
                                        If Len(mUnidadesCodigoAFIP) = 0 Then mUnidadesCodigoAFIP = "7"
                                        ors1.Close()

                                        .xIndiceItem = mnumeroitem
                                        .xITEMPro_codigo = mncm
                                        .xITEMPro_ds = mdescripcion
                                        .xITEMPro_qty = ors.Fields("Cantidad").Value
                                        .xITEMPro_umed = mUnidadesCodigoAFIP
                                        .xITEMPro_precio_uni = ors.Fields("PrecioUnitario").Value
                                        .xITEMPro_precio_item = Math.Round(IIf(IsNull(ors.Fields("Cantidad").Value), 0, ors.Fields("Cantidad").Value) *
                                                                      IIf(IsNull(ors.Fields("PrecioUnitario").Value), 0, ors.Fields("PrecioUnitario").Value) *
                                                                      (1 - (IIf(IsNull(ors.Fields("Bonificacion").Value), 0, ors.Fields("Bonificacion").Value) / 100)), 2)
                                        mnumeroitem = mnumeroitem + 1
                                    End If
                                    ors.MoveNext()
                                Loop
                            End If
                        End If
                        ors = Nothing

                        Randomize()
                        midentificador = CLng(Rnd() * 100000000)
                        mresul = .xRegistrar(dcfields(10).Text, mtipocomprobante, "" & midentificador)
                        If glbdebugfacturaelectronica Then MsgBox("Registrar : " & mresul & " - UltimoMensajeError : " & .UltimoMensajeError)

                        If mresul Then
                            mcae = .xRespuestaCAE
                            mdescripcion = Chr(10) + "CAE: " + .xRespuestaCAE + Chr(10) + "REPROCESO " + .xRespuestaReproceso +
                                           Chr(10) + "Evento " + .xEventMsg + Chr(10) + "Observacion: " + .xRespuestaMotivos_obs
                            With origen.Registro
                                .Fields("CAE").Value = mcae
                                .Fields("IdIdentificacionCAE").Value = midentificador
                                If IsDate(Mid(FEx.xRespuestaFch_venc_cae, 7, 2) & "/" & Mid(FEx.xRespuestaFch_venc_cae, 5, 2) & "/" & Mid(FEx.xRespuestaFch_venc_cae, 1, 4)) Then
                                    .Fields("FechaVencimientoORechazoCAE").Value = CDate(Mid(FEx.xRespuestaFch_venc_cae, 7, 2) & "/" & Mid(FEx.xRespuestaFch_venc_cae, 5, 2) & "/" & Mid(FEx.xRespuestaFch_venc_cae, 1, 4))
                                End If
                            End With
                        Else
                            'Me.MousePointer = vbDefault
                            MsgBox("Error al obtener CAE : " + .xerrmsg + "Detalle: " + .UltimoMensajeError, vbExclamation)
                            Exit Function
                        End If
                    Else
                        ' Me.MousePointer = vbDefault
                        MsgBox("Error al obtener CAE : " + .xerrmsg + "Detalle: " + .UltimoMensajeError, vbExclamation)
                        Exit Function
                    End If
                End With
                FEx = Nothing
            End If

            ' If mvarId < 0 Then
            '     If mCAEManual = "SI" Then
            '         mCAE = ""
            'Set oF = New frm_Aux
            'With oF
            '             .Caption = "Ingresar numero de CAE"
            '             With .Label2(0)
            '                 .Caption = "Numero de CAE :"
            '                 .Visible = True
            '             End With
            '             With .Text1
            '                 .Text = ""
            '      .Top = oF.DTFields(0).Top
            '      .Left = oF.DTFields(0).Left
            '                 .Width = .Width * 2
            '             End With
            '             With .Label1
            '                 .Caption = "Fecha vto. CAE :"
            '                 .Visible = True
            '             End With
            '             With .DTFields(0)
            '      .Top = oF.Label1.Top
            '      .Value = Date
            '                 .Visible = True
            '             End With
            '             .Width = .Width * 1.5
            '             .Height = .Height * 0.7
            '             .cmd(0).Top = .Label1.Top + .Label1.Height + 100
            '             .cmd(0).Left = .Width / 2 - (.cmd(0).Width / 2)
            '             .cmd(0).Height = .cmd(0).Height * 0.75
            '             .cmd(1).Visible = False
            '             .Show(vbModal, Me)
            '             If .Ok Then
            '                 mCAE = Val(.Text1.Text)
            '                 mvarFechaVencimientoCAE = .DTFields(0).Value
            '             End If
            '         End With
            'Unload oF
            'Set oF = Nothing
            '         If Len(mCAE) < 14 Then
            '             Me.MousePointer = vbDefault
            '             MsgBox("Debe ingresar el numero de CAE", vbExclamation)
            '             Exit Function
            '         End If
            '         With origen.Registro
            '             .Fields("CAE").Value = mCAE
            '             .Fields("FechaVencimientoORechazoCAE").Value = mvarFechaVencimientoCAE
            '         End With
            '     End If

            '     Dim oPto As ComPronto.PuntoVenta
            '     oPto = Aplicacion.PuntosVenta.Item(dcfields(10).BoundText)
            '     With oPto.Registro
            '         mvarNumero = .Fields("ProximoNumero").Value
            '         .Fields("ProximoNumero").Value = mvarNumero + 1
            '         origen.Registro.Fields("NumeroFactura").Value = mvarNumero
            '     End With
            '     oPto.Guardar()
            '     oPto = Nothing

            '     oRs = Aplicacion.Facturas.TraerFiltrado("_PorNumeroComprobante", Array(mvarTipoABC, Val(dcfields(10).Text), mvarNumero))
            '     If oRs.RecordCount > 0 Then
            '         oRs.Close()
            '         oRs = Nothing
            '         Me.MousePointer = vbDefault
            '         MsgBox("Ya existe esta factura!", vbExclamation)
            '         Exit Function
            '     End If
            '     oRs.Close()

            '     If dcfields(4).Enabled And Check1(0).Value = 1 Then
            '         Dim oPrv As ComPronto.Provincia
            '         oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", origen.Registro.Fields("IdIBCondicion").Value)
            '         If oRs.RecordCount > 0 Then
            '             If Not IsNull(oRs.Fields("IdProvincia").Value) Then
            '                 oPrv = Aplicacion.Provincias.Item(oRs.Fields("IdProvincia").Value)
            '                 With oPrv.Registro
            '                     mNum = IIf(IsNull(.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value), 1, .Fields("ProximoNumeroCertificadoPercepcionIIBB").Value)
            '                     origen.Registro.Fields("NumeroCertificadoPercepcionIIBB").Value = mNum
            '                     .Fields("ProximoNumeroCertificadoPercepcionIIBB").Value = mNum + 1
            '                 End With
            '                 oPrv.Guardar()
            '                 oPrv = Nothing
            '             End If
            '         End If
            '         oRs.Close()
            '         oRs = Nothing
            '     End If
            ' End If

            Select Case origen.Guardar
                Case compronto.MisEstados.Correcto
                Case compronto.MisEstados.ModificadoPorOtro
                    MsgBox("El registro ha sido modificado")
                Case compronto.MisEstados.NoExiste
                    MsgBox("El registro ha sido eliminado")
                Case compronto.MisEstados.ErrorDeDatos
                    MsgBox("Error de ingreso de datos")
            End Select

            '//Recupero de gastos
            '//actualiza las notas de credito NC deudores y proveedores

            mvarimprime = MsgBox("Desea imprimir ahora ?", vbYesNo, "Impresion de la Factura")
            '  If mvarImprime = vbYes Then cmdImpre_Click(0)

            ' Unload(Me)




        End Function


        Public Shared Function GetInitialsFromString(ByVal fullName As String) As String
            If fullName.Contains(",") Then
                fullName = NormalizeName(fullName)
            End If
            Dim nameArray As String() = fullName.Split(" ")
            Dim initials As String = String.Empty
            For Each name As String In nameArray
                If name.Length > 0 Then
                    initials += name.Chars(0)
                End If
            Next
            Return initials.ToUpper()
        End Function

        Public Shared Function NormalizeName(ByVal fullName As String) As String
            Dim name As String() = fullName.Split(",")
            Return String.Format("{0} {1}", Trim(name(1)), Trim(name(0)))
        End Function


        Public Shared Function ImprimirWordDOT_VersionDLL(ByVal mPlantilla As String,
                                                          ByRef Yo As Object,
                                                          ByVal SC As String,
                                                          ByVal SessionDummy As Object,
                                                          ByRef ResponseDummy As Object,
                                                          ByVal Id As Long,
                                                          Optional ByVal Arg3 As Object = Nothing,
                                                          Optional ByVal Arg4 As Object = Nothing,
                                                          Optional ByVal Arg5 As Object = Nothing,
                                                          Optional ByVal outputFileName As String = "",
                                                          Optional ByVal Arg6 As Object = Nothing,
                                                          Optional ByVal Arg7 As Object = Nothing) As String

            If Id < 1 Then Return Nothing

            'Verificar:
            '1) Permisos ASPNET (o IUSR_<machine> si usas impersonate)   
            '        http://geeks.ms/blogs/lruiz/archive/2007/03/15/como-utilizar-com-interop-office-excel-en-tus-proyectos-asp-net-y-no-morir-en-el-intento.aspx  
            '        http://blog.crowe.co.nz/archive/2006/03/02/589.aspx  
            '   Reiniciar IIS
            '2) Trust Center de Excel 07
            '3) ComPronto mal referenciada en la plantilla XLT
            '4) Hotfix     http://kbalertz.com/968494/Description-Excel-hotfix-March.aspx
            'http://www.developerdotstar.com/community/automate_excel_dotnet

            'If cmbCuenta.SelectedValue = -1 Or Not IsNumeric(txtRendicion.Text) Then
            '    'ProntoFuncionesUIWeb.MsgBoxAjax(Me, "Elija una Cuenta")
            '    MsgBoxAjax(Me, "Elija una Cuenta y Rendición")
            '    Exit Sub
            'End If
            'Dim Rendicion As Integer = txtRendicion.Text 'iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(HFSC.Value, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))
            'Dim mImprime As String = "N"
            'Dim mObra As Long = iisNull(session(SESSIONPRONTO_glbIdObraAsignadaUsuario), -1)

            'es importante en estos dos archivos poner bien el directorio. 
            Dim plant As String
            plant = mPlantilla
            'Dim xlt As String = Server.MapPath("../..WebComprasTerceros.xlt")

            'Dim xlt As String = "\\192.168.66.2\inetpub\wwwroot\WebComprasTerceros.xlt" 'Server.MapPath("../..WebComprasTerceros) 'http://support.microsoft.com/kb/311731/es   C:\Inetpub\Wwwroot
            'Dim output As String = Path.GetTempPath() & "archivo.xls" 'no funciona bien si uso el raíz
            Dim output As String
            If outputFileName = "" Then
                output = "archivo.doc" 'no funciona bien si uso el raíz
            Else
                output = outputFileName
            End If

            Dim MyFile1 As New FileInfo(plant)
            Try
                If Not MyFile1.Exists Then 'busca la plantilla
                    ErrHandler2.WriteError("No se encuentra la plantilla " & plant)
                    '  MsgBoxAjax(Yo, "No se encuentra la plantilla " & plant)
                    Return ""
                End If

                MyFile1 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra
                If MyFile1.Exists Then
                    MyFile1.Delete()
                End If

            Catch ex As Exception
                ErrHandler2.WriteError(ex.Message)
                'MsgBoxAjax(Yo, ex.Message)
                Throw
                'Return ""
            End Try

            Dim oW As Word.Application
            Dim oDoc As Microsoft.Office.Interop.Word.Document
            'Dim oBooks As Excel.Workbooks 'haciendolo así, no queda abierto el proceso en el servidor http://support.microsoft.com/?kbid=317109

            Try
                oW = CreateObject("Word.Application")
                oW.Visible = False
                'estaría bueno que si acá tarda mucho, salga
                'puede colgarse en este Add o en el Run. Creo que se cuelga en el Add si no tiene
                '  permisos (-permisos de qué???), y en el Run si está mal referenciada la dll
                '-pero se pianta porque no tiene permisos para usar el Excel, o por no poder usar la carpeta con el archivo?
                Try
                    oDoc = oW.Documents.Add(plant)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex.Message & "Explota en el oW.Documents.Add(plant).  Plantilla: " & plant & " No se puede abrir el " &
                                          "almacenamiento de macros? Verficar las referencias de la plantilla a dlls (especialmente COMPRONTO). " &
                                          "Verificar el directorio de plantillas. Tiene permisos para usar el directorio?")
                    Throw
                End Try

                If IsNothing(oDoc) Then
                    'why the methord "Microsoft.Office.Interop.Word.ApplicationClass.Documents.Add" Returns null in .net web page
                    'http://social.msdn.microsoft.com/Forums/en/vbgeneral/thread/5deb3d3a-552c-4dfd-8d94-236b8a441daf
                    'http://forums.asp.net/t/1232621.aspx
                    ErrHandler2.WriteError("!!!! ALERTA !!!! ALERTA !!!!!!!!!!! oDoc está en NOTHING!!! Muy probable que " &
                                          "esté mal el impersonate (no dejarlo en true vacío, ponerle el " &
                                          "usuario y el pass) " & IsNothing(oW) & "  Plantilla: " & plant & "")

                    'Parece ser que puede ser por el impersonate… ERA ESO!!!! No me dejaba poner el 
                    'impersonate=true vacío, le tuve que poner el usuario!!!!!!!!!!!

                    'Huyo. Pero antes cierro todo
                    Try
                        NAR(oDoc)
                        'quit and dispose app
                        oW.Quit()
                        NAR(oW)
                        'VERY IMPORTANT
                        GC.Collect()
                    Catch ex As Exception
                        ErrHandler2.WriteError(ex)
                        'COM object that has been separated from its underlying RCW cannot be used.?????
                    End Try

                    Return ""
                End If

                With oDoc
                    oW.DisplayAlerts = False ' Word.WdAlertLevel.wdAlertsNone

                    'ejecuto la macro. ZONA DE RIESGO (porque VBA puede tirar un error y no volver)

                    Dim sStringVBA = "Emision """ & DebugCadenaImprimible(ClaseMigrar.ReEncriptaParaPronto(SC)) & """," & Id & "," & iisNull(Arg3, "Nothing") & "," & iisNull(Arg4, "Nothing") & "," & iisNull(Arg5, "Nothing") & "," & iisNull(Arg6, "Nothing") & "," & iisNull(Arg7, "Nothing")

                    'Debug.Print(sStringVBA)
                    'ErrHandler2.WriteError(sStringVBA)

                    'Acá es el cuelgue clásico: no solamente basta con ver que esten bien las referencias! A veces,
                    'aunque figuren bien, el Inter25 explota. Así que no tenés otra manera de probarlo que ejecutando la
                    'llamada a Emision desde el Excel del servidor y ver donde explota.
                    '-No está encontrando los controles del UserControl o el UserForm (que tiene el codigo de barras)
                    '-Claro! Porque, en cuanto ve que no esta el Inter25.OCX, desaparece la instancia del control!!!!

                    'Cómo hacer para que si se cuelga la llamada a .Run, salga a los 10 segundos?
                    'Corro el riesgo de que se tilde el sitio:
                    'The RPC server is unavailable. (Excepción de HRESULT: 0x800706BA)   (Remote Procedure Call)
                    'http://forums.asp.net/p/1134671/1808767.aspx
                    'http://forums.asp.net/p/1134671/1808767.aspx
                    '                Hi(there!)
                    '                That looks VBA-ish: Have you manually invoked the VBA editor on the server at least once (under the same account ASP.Net will use later)? That could solve the hanging, but Office performance on the web server will be just horrible (for Office was not designed to work in a multi user environment).
                    'So we refrained from using Office InterOp at all. Instead we used OleDocumentProperties to pass server side information to some auto-starting Excel macros and let them do all the work, e.g. pulling data into work sheets using the connection settings provided via OleDocumentProperties by Asp.Net.
                    'Just have a look at Microsoft's DsoFile.dll (comes with source code and .Net InterOp wrappers): The Dsofile.dll files lets you edit Office document properties when you do not have Office installed [sic].

                    Try
                        If Arg7 IsNot Nothing Then
                            ErrHandler2.WriteError("6 argumento")
                            oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4, Arg5, Arg6, Arg7)
                        ElseIf Arg6 IsNot Nothing Then
                            ErrHandler2.WriteError("5 argumento")
                            oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4, Arg5, Arg6)
                        ElseIf Arg5 IsNot Nothing Then
                            ErrHandler2.WriteError("4 argumento")
                            oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4, Arg5)
                        ElseIf Arg4 IsNot Nothing Then
                            ErrHandler2.WriteError("3 argumento")
                            oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4)
                        ElseIf Arg3 IsNot Nothing Then
                            ErrHandler2.WriteError("2 argumento")
                            oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3)
                        Else
                            ErrHandler2.WriteError("1 argumento")
                            oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id)
                        End If
                    Catch ex As Exception
                        ErrHandler2.WriteError("Explota en la llamada a Emision ()" & ex.Message & "")
                        'Throw
                    End Try

                    'Se queda colgado?
                    'Verificar que tengan puesto un On Error Resume Next (no puedo catchear el error, y queda andando el Winword o Excel)
                    '-Mejor dicho, que no tengan un MsgBox al disparar un error
                    'Permisos para ejecutar macros

                    'and added it to the saveas command. The extn (.doc) decides on what format
                    'the document is saved as.
                    Const wrdFormatDocument As Object = 0 '(save in default format)
                    ErrHandler2.WriteError("Pudo ejecutar el Emision(), ahora tratará de grabar")

                    Try
                        'verificar q la ruta existe, sino se queda muy colgado
                        .SaveAs(output, wrdFormatDocument) 'adherir extension ".doc"
                    Catch ex As Exception
                        ErrHandler2.WriteError("Explotó el .SaveAs()  " & IsNothing(oDoc) & " " & output & " " & wrdFormatDocument & ex.Message &
                            "Tiró 'El comando falló' o 'Command fail'? " &
                            "Revisá http://social.msdn.microsoft.com/Forums/en/netfx64bit/thread/65a355ce-49c1-47f1-8c12-d9cf5f23c53e" &
                            "y http://support.microsoft.com/default.aspx?scid=kb;EN-US;244264")
                        Throw
                    End Try

                    'oEx.SaveWorkspace(output) 'no usar esto, usar el del workbook
                    oW.DisplayAlerts = True '  Word.WdAlertLevel.wdAlertsAll ' True
                End With

                'ProntoFuncionesUIWeb.Current_Alert("Ahora se va a transmitir")

            Catch ex As Exception
                ErrHandler2.WriteError(ex.Message & " Archivo Plantilla: " & plant & vbCrLf &
                "Figura en el log una llamada a Emision() o explotó antes? Verificar que la DLL ComPronto esté bien referenciada en la " &
                "plantilla. no solamente basta con ver que esten bien las referencias! A veces, aunque figuren bien " &
                ", el Inter25 explota. Así que no tenés otra manera de probarlo que ejecutando la llamada a Emision , o " &
                " que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), " &
                " o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se " &
                " llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro. Si no figura en el log " &
                " una llamada a Emision, es que ni siquiera se lo pudo llamar")

                'MsgBoxAjax(Yo, ex.Message & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro")
                'Throw
                output = ""
            Finally
                'System.Runtime.InteropServices.Marshal.ReleaseComObject(oBooks)
                'oBooks = Nothing
                'oEx.Quit()
                'System.Runtime.InteropServices.Marshal.ReleaseComObject(oEx)
                'oEx = Nothing
                'http://forums.devx.com/showthread.php?threadid=155202
                'MAKE SURE TO KILL ALL INSTANCES BEFORE QUITING! if you fail to do this
                'The service (excel.exe) will continue to run
                Try
                    ErrHandler2.WriteError("cerrando...")
                    If Not oDoc Is Nothing Then oDoc.Close(False)
                    ErrHandler2.WriteError("oDoc.Close(False) exito")
                    NAR(oDoc)
                    ErrHandler2.WriteError("NAR(oDoc) exito")
                    'quit and dispose app
                    oW.Quit()
                    ErrHandler2.WriteError("oW.Quit() exito")

                    NAR(oW) 'pinta q es acá donde se trula

                    ErrHandler2.WriteError(" NAR(oW) exito")
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try

                Try
                    'VERY IMPORTANT
                    GC.Collect()
                    ErrHandler2.WriteError("Se llamó con exito a GC.Collect")
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try
            End Try

            Return output 'porque no estoy pudiendo ejecutar el response desde acá

        End Function

        Public Shared Function ImprimirWordDOT_VersionDLL_PDF(ByVal mPlantilla As String,
                                                              ByRef Yo As Object,
                                                              ByVal SC As String,
                                                              ByVal SessionDummy As Object,
                                                              ByRef ResponseDummy As Object,
                                                              ByVal Id As Long,
                                                              Optional ByVal Arg3 As Object = Nothing,
                                                              Optional ByVal Arg4 As Object = Nothing,
                                                              Optional ByVal Arg5 As Object = Nothing,
                                                              Optional ByVal outputFileName As String = "",
                                                              Optional ByVal Arg6 As Object = Nothing,
                                                              Optional ByVal Arg7 As Object = Nothing) As String

            If Id < 1 Then Return Nothing

            'Verificar:
            '1) Permisos ASPNET (o IUSR_<machine> si usas impersonate)   
            '        http://geeks.ms/blogs/lruiz/archive/2007/03/15/como-utilizar-com-interop-office-excel-en-tus-proyectos-asp-net-y-no-morir-en-el-intento.aspx  
            '        http://blog.crowe.co.nz/archive/2006/03/02/589.aspx  
            '   Reiniciar IIS
            '2) Trust Center de Excel 07
            '3) ComPronto mal referenciada en la plantilla XLT
            '4) Hotfix     http://kbalertz.com/968494/Description-Excel-hotfix-March.aspx


            'http://www.developerdotstar.com/community/automate_excel_dotnet


            'If cmbCuenta.SelectedValue = -1 Or Not IsNumeric(txtRendicion.Text) Then
            '    'ProntoFuncionesUIWeb.MsgBoxAjax(Me, "Elija una Cuenta")
            '    MsgBoxAjax(Me, "Elija una Cuenta y Rendición")
            '    Exit Sub
            'End If
            'Dim Rendicion As Integer = txtRendicion.Text 'iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(HFSC.Value, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))
            'Dim mImprime As String = "N"
            'Dim mObra As Long = iisNull(session(SESSIONPRONTO_glbIdObraAsignadaUsuario), -1)

            '///////////////////////////////////////////
            '///////////////////////////////////////////
            'es importante en estos dos archivos poner bien el directorio. 
            Dim plant As String
            If InStr(mPlantilla, "\") > 0 Then
                plant = mPlantilla
            Else
                plant = mPlantilla '"C:\ProntoWeb\Proyectos\Pronto\Documentos\ComprasTerceros.xlt"
            End If
            'Dim xlt As String = Server.MapPath("../..WebComprasTerceros.xlt")

            'Dim xlt As String = "\\192.168.66.2\inetpub\wwwroot\WebComprasTerceros.xlt" 'Server.MapPath("../..WebComprasTerceros) 'http://support.microsoft.com/kb/311731/es   C:\Inetpub\Wwwroot
            'Dim output As String = Path.GetTempPath() & "archivo.xls" 'no funciona bien si uso el raíz
            Dim output As String
            If outputFileName = "" Then
                output = "archivo.doc" 'no funciona bien si uso el raíz
            Else
                output = outputFileName
            End If

            Dim MyFile1 As New FileInfo(plant)
            Try
                If Not MyFile1.Exists Then 'busca la plantilla
                    ErrHandler2.WriteError("No se encuentra la plantilla " & plant)
                    '  MsgBoxAjax(Yo, "No se encuentra la plantilla " & plant)
                    Return ""
                End If

                MyFile1 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra
                If MyFile1.Exists Then
                    MyFile1.Delete()
                End If

            Catch ex As Exception
                ErrHandler2.WriteError(ex.Message)
                'MsgBoxAjax(Yo, ex.Message)
                Throw
                'Return ""
            End Try

            Dim oW As Word.Application
            Dim oDoc As Microsoft.Office.Interop.Word.Document
            'Dim oBooks As Excel.Workbooks 'haciendolo así, no queda abierto el proceso en el servidor http://support.microsoft.com/?kbid=317109

            Try
                Try
                    oW = CreateObject("Word.Application")
                    oW.Visible = False
                Catch ex As Exception
                    ErrHandler2.WriteError(ex.Message & "Explota al crear el word.Application. Verificar permisos) " &
                        " 8)	Habilitar permisos para Interop Office (en IIS7 en lugar de usar la cuenta 'Network Service'  usa() 'IIS APPPOOL\DefaultAppPool') " &
                        "a.	1. In DCOMCNFG, right click on the My Computer and select properties.  " &
                        "b.	2. Choose the COM Securities tab " &
                        "c.	3. In Access Permissions, click 'Edit Defaults' and add 'Network Service' (o 'Servicio de red',  o la 'IIS APPPOOL\DefaultAppPool' si usa II7 ) to it and give it 'Allow local access' permission. Do the same for <Machine_name>\Users. " &
                        "d.	4. In launch and Activation Permissions, click 'Edit Defaults' and add Network Service to it and give it 'Local launch' and 'Local Activation' permission. Do the same for <Machine_name>\Users " &
                        "e.	Press OK and thats it. i can run my application now. ")

                    Throw

                End Try

                'estaría bueno que si acá tarda mucho, salga
                'puede colgarse en este Add o en el Run. Creo que se cuelga en el Add si no tiene
                '  permisos (-permisos de qué???), y en el Run si está mal referenciada la dll
                '-pero se pianta porque no tiene permisos para usar el Excel, o por no poder usar la carpeta con el archivo?
                Try
                    oDoc = oW.Documents.Add(plant)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex.Message & "Explota en el oW.Documents.Add(plant).  Plantilla: " & plant & " No se puede abrir el " &
                                          "almacenamiento de macros? Verficar las referencias de la plantilla a dlls (especialmente COMPRONTO). " &
                                          "Verificar el directorio de plantillas. Tiene permisos para usar el directorio?")
                    Throw
                End Try

                If IsNothing(oDoc) Then
                    'why the methord "Microsoft.Office.Interop.Word.ApplicationClass.Documents.Add" Returns null in .net web page
                    'http://social.msdn.microsoft.com/Forums/en/vbgeneral/thread/5deb3d3a-552c-4dfd-8d94-236b8a441daf
                    'http://forums.asp.net/t/1232621.aspx
                    ErrHandler2.WriteError("!!!! ALERTA !!!! ALERTA !!!!!!!!!!! oDoc está en NOTHING!!! Muy probable que " &
                                            "esté mal el impersonate (no dejarlo en true vacío, ponerle el " &
                                            "usuario y el pass)  " &
                                            " no impersones desde el web.config, hacelo en el IIS con el ApplicationPool correspondiente, y cambiale la cuenta de  " &
                                            "            NetworkService por la de Administrador para sacarte los problemas del Interop de Office  " &
                                            "1 metete en el administrador del iis " &
                                            "2 en los grupos de aplicaciones " &
                                            "3 elegi el grupo que este usando el sitio " &
                                            "4 y en configuracion avanzada " &
                                            "5:                  elegi 'Identidad' " &
                                            "6:                  cuenta personalizada " &
                                            "7 y asignale algun usuario con permisos de administrador " &
                                             IsNothing(oW) & "  Plantilla: " & plant)

                    'Parece ser que puede ser por el impersonate… ERA ESO!!!! No me dejaba poner el 
                    'impersonate=true vacío, le tuve que poner el usuario!!!!!!!!!!!
                    'Huyo. Pero antes cierro todo
                    Try
                        NAR(oDoc)
                        'quit and dispose app
                        oW.Quit()
                        NAR(oW)
                        'VERY IMPORTANT
                        GC.Collect()
                    Catch ex As Exception
                        ErrHandler2.WriteError(ex)
                        'COM object that has been separated from its underlying RCW cannot be used.?????
                    End Try

                    Return ""
                End If

                With oDoc
                    oW.DisplayAlerts = False ' Word.WdAlertLevel.wdAlertsNone

                    '///////////////////////////////////////////////////////////////////////////////////////////
                    'ejecuto la macro. ZONA DE RIESGO (porque VBA puede tirar un error y no volver)
                    '///////////////////////////////////////////////////////////////////////////////////////////

                    Dim sStringVBA = "Emision """ & DebugCadenaImprimible(ClaseMigrar.ReEncriptaParaPronto(SC)) & """," & Id & "," & iisNull(Arg3, "Nothing") & "," & iisNull(Arg4, "Nothing") & "," & iisNull(Arg5, "Nothing") & "," & iisNull(Arg6, "Nothing") & "," & iisNull(Arg7, "Nothing")

                    Debug.Print(sStringVBA)
                    ErrHandler2.WriteError(sStringVBA)

                    'Acá es el cuelgue clásico: no solamente basta con ver que esten bien las referencias! A veces,
                    'aunque figuren bien, el Inter25 explota. Así que no tenés otra manera de probarlo que ejecutando la
                    'llamada a Emision desde el Excel del servidor y ver donde explota.
                    '-No está encontrando los controles del UserControl o el UserForm (que tiene el codigo de barras)
                    '-Claro! Porque, en cuanto ve que no esta el Inter25.OCX, desaparece la instancia del control!!!!

                    'Cómo hacer para que si se cuelga la llamada a .Run, salga a los 10 segundos?
                    'Corro el riesgo de que se tilde el sitio:
                    'The RPC server is unavailable. (Excepción de HRESULT: 0x800706BA)   (Remote Procedure Call)

                    'http://forums.asp.net/p/1134671/1808767.aspx
                    'http://forums.asp.net/p/1134671/1808767.aspx
                    '                Hi(there!)
                    '                That looks VBA-ish: Have you manually invoked the VBA editor on the server at least once (under the same account ASP.Net will use later)? That could solve the hanging, but Office performance on the web server will be just horrible (for Office was not designed to work in a multi user environment).
                    'So we refrained from using Office InterOp at all. Instead we used OleDocumentProperties to pass server side information to some auto-starting Excel macros and let them do all the work, e.g. pulling data into work sheets using the connection settings provided via OleDocumentProperties by Asp.Net.
                    'Just have a look at Microsoft's DsoFile.dll (comes with source code and .Net InterOp wrappers): The Dsofile.dll files lets you edit Office document properties when you do not have Office installed [sic].

                    Try
                        If Arg7 IsNot Nothing Then
                            ErrHandler2.WriteError("6 argumento")
                            oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4, Arg5, Arg6, Arg7)
                        ElseIf Arg6 IsNot Nothing Then
                            ErrHandler2.WriteError("5 argumento")
                            oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4, Arg5, Arg6)
                        ElseIf Arg5 IsNot Nothing Then
                            ErrHandler2.WriteError("4 argumento")
                            oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4, Arg5)
                        ElseIf Arg4 IsNot Nothing Then
                            ErrHandler2.WriteError("3 argumento")
                            oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4)
                        ElseIf Arg3 IsNot Nothing Then
                            ErrHandler2.WriteError("2 argumento")
                            oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3)
                        Else
                            ErrHandler2.WriteError("1 argumento")
                            oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id)
                        End If
                    Catch ex As Exception
                        ErrHandler2.WriteError("Explota en la llamada a Emision ()" & ex.Message & "")
                        'Throw
                    End Try

                    'Se queda colgado?
                    'Verificar que tengan puesto un On Error Resume Next (no puedo catchear el error, y queda andando el Winword o Excel)
                    '-Mejor dicho, que no tengan un MsgBox al disparar un error
                    'Permisos para ejecutar macros

                    'and added it to the saveas command. The extn (.doc) decides on what format
                    'the document is saved as.
                    Const wrdFormatDocument As Object = 17 'Word.WdSaveFormat.wdFormatPDF  '(save in default format)
                    'verificar que la extension es pdf
                    If Right(output, 3) <> "pdf" Then Throw New Exception("La extension debe ser pdf")

                    ErrHandler2.WriteError("Pudo ejecutar el Emision(), ahora tratará de grabar")

                    Try
                        'verificar q la ruta existe, sino se queda muy colgado
                        .SaveAs(output, wrdFormatDocument) 'adherir extension ".doc"
                    Catch ex As Exception
                        ErrHandler2.WriteError("Explotó el .SaveAs()  " & IsNothing(oDoc) & " " & output & " " & wrdFormatDocument & ex.Message &
                            "Tiró 'El comando falló' o 'Command fail'? " &
                            "Revisá http://social.msdn.microsoft.com/Forums/en/netfx64bit/thread/65a355ce-49c1-47f1-8c12-d9cf5f23c53e" &
                            "y http://support.microsoft.com/default.aspx?scid=kb;EN-US;244264")
                        Throw
                    End Try

                    'oEx.SaveWorkspace(output) 'no usar esto, usar el del workbook
                    oW.DisplayAlerts = True '  Word.WdAlertLevel.wdAlertsAll ' True
                End With

                'ProntoFuncionesUIWeb.Current_Alert("Ahora se va a transmitir")

            Catch ex As Exception
                ErrHandler2.WriteError(ex.Message & " Archivo Plantilla: " & plant & vbCrLf &
                "Figura en el log una llamada a Emision() o explotó antes? Verificar que la DLL ComPronto esté bien referenciada en la " &
                "plantilla. no solamente basta con ver que esten bien las referencias! A veces, aunque figuren bien " &
                ", el Inter25 explota. Así que no tenés otra manera de probarlo que ejecutando la llamada a Emision , o " &
                " que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), " &
                " o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se " &
                " llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro. Si no figura en el log " &
                " una llamada a Emision, es que ni siquiera se lo pudo llamar")

                'MsgBoxAjax(Yo, ex.Message & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro")
                'Throw
                output = ""
            Finally
                'System.Runtime.InteropServices.Marshal.ReleaseComObject(oBook)
                'oBook = Nothing
                'System.Runtime.InteropServices.Marshal.ReleaseComObject(oBooks)
                'oBooks = Nothing
                'oEx.Quit()
                'System.Runtime.InteropServices.Marshal.ReleaseComObject(oEx)
                'oEx = Nothing
                'http://forums.devx.com/showthread.php?threadid=155202
                'MAKE SURE TO KILL ALL INSTANCES BEFORE QUITING! if you fail to do this
                'The service (excel.exe) will continue to run
                Try
                    ErrHandler2.WriteError("cerrando...")
                    If Not oDoc Is Nothing Then oDoc.Close(False)
                    ErrHandler2.WriteError("oDoc.Close(False) exito")
                    NAR(oDoc)
                    ErrHandler2.WriteError("NAR(oDoc) exito")
                    'quit and dispose app
                    oW.Quit()
                    ErrHandler2.WriteError("oW.Quit() exito")

                    NAR(oW) 'pinta q es acá donde se trula

                    ErrHandler2.WriteError(" NAR(oW) exito")
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try

                Try
                    'VERY IMPORTANT
                    GC.Collect()
                    ErrHandler2.WriteError("Se llamó con exito a GC.Collect")
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try
            End Try

            Return output 'porque no estoy pudiendo ejecutar el response desde acá
        End Function
    End Class





    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






    Public Class CartaPorteManagerAux




        Public Shared Sub RefrescarAnulacionesyConsistenciaDeImputacionesEntreCDPyFacturasOnotasDeCredito(ByVal SC As String, SESSIONPRONTO_Busqueda As String)

            'hago un UNION de las facturas anuladas y de las notas de credito
            '-no, las de nota de credito ya no se liberan automaticamente. Quedan imputadas y se liberan explicitamente.

            Dim s1 =
        " select idcartadeporte,idfacturaimputada from  cartasdeporte " &
        " where idfacturaimputada in   " &
        "		(                    " &
        "            select idfactura from facturas " &
        "                where ANULADA='SI' and  " &
        "                LEFT(CAST(Observaciones AS nvarchar(100)),23) <>' -- NO LIBERAR CDPS -- '  " &
        "       )"

            Dim dt As DataTable = EntidadManager.ExecDinamico(SC, s1)



            'Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

            'Dim o = From i In db.CartasPorteMovimientos _
            '            Where i.IdFacturaImputada=




            If dt.Rows.Count > 0 Then

                Dim o = (From i In dt Select CStr(i("IdCartaDePorte") & "-" & i("idfacturaimputada"))).ToArray
                Dim ids = Join(o, ",")

                EntidadManager.LogPronto(SC, -1, "Desimputacion " & ids, SESSIONPRONTO_Busqueda)




                Dim strsql =
        " update cartasdeporte " &
        " set IdFacturaImputada = 0" &
        " where idfacturaimputada in   " &
        "		(                    " &
        "            select idfactura from facturas " &
        "                where ANULADA='SI' and  " &
        "                LEFT(CAST(Observaciones AS nvarchar(100)),23) <>' -- NO LIBERAR CDPS -- '  " &
        "       )"
                EntidadManager.ExecDinamico(SC, strsql)





            End If


            '//////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////
            'hacer tambien el update de buques

            Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
            Dim buques As List(Of CartasPorteMovimiento) = (From i In db.CartasPorteMovimientos
                                                            Join f In db.linqFacturas On i.IdFacturaImputada Equals f.IdFactura
                                                            Where f.Anulada = "SI"
                                                            Select i).ToList
            ' And i.Anulada <> "SI" _

            For Each b As CartasPorteMovimiento In buques
                'b.Anulada = "SI"
                b.IdFacturaImputada = Nothing
            Next
            db.SubmitChanges()
            '//////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////



            'Dim o = From i In db.CartasPorteMovimientos _
            '            Where i.IdFacturaImputada=





            '        update(cartasdeporte)
            '        IdFacturaImputada = 0
            'where idfacturaimputada in   
            '		(select idfactura from facturas
            '		where ANULADA='SI')


            '        SELECT
            ' DetCre.IdDetalleNotaCreditoImputaciones,
            ' DetCre.IdNotaCredito,
            ' DetCre.IdImputacion,
            ' TiposComprobante.DescripcionAB,
            ' CuentasCorrientesDeudores.NumeroComprobante as [Numero],
            ' CuentasCorrientesDeudores.Fecha,
            ' DetCre.Importe,
            ' CuentasCorrientesDeudores.idcomprobante
            ' --,Facturas.idFactura
            'FROM DetalleNotasCreditoImputaciones DetCre
            'LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=DetCre.IdNotaCredito
            'LEFT OUTER JOIN CuentasCorrientesDeudores ON CuentasCorrientesDeudores.IdCtaCte=DetCre.IdImputacion
            'LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CuentasCorrientesDeudores.IdTipoComp
            '--LEFT OUTER JOIN Facturas ON Facturas.NumeroFactura=CuentasCorrientesDeudores.NumeroComprobante
            'where TiposComprobante.DescripcionAB='FA'


        End Sub

        Shared Function CartasPorteImputadas(ByVal SC As String, ByVal IdFactura As Long) As Generic.List(Of CartasDePorte)

            Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

            Dim listaCartasImputadasAlaFactura As IQueryable(Of CartasDePorte) = From e In db.CartasDePortes
                                                                                 Where e.IdFacturaImputada = IdFactura
                                                                                 Order By e.NumeroCartaDePorte Ascending
                                                                                 Select e

            Return listaCartasImputadasAlaFactura.ToList

        End Function




    End Class



    Public Class Encryption64
        Private key() As Byte = {}
        Private IV() As Byte = {&H12, &H34, &H56, &H78, &H90, &HAB, &HCD, &HEF}

        Public Function Decrypt(ByVal stringToDecrypt As String,
            ByVal sEncryptionKey As String) As String
            Dim inputByteArray(stringToDecrypt.Length) As Byte
            Try
                key = System.Text.Encoding.UTF8.GetBytes(Left(sEncryptionKey, 8))
                Dim des As New DESCryptoServiceProvider()
                inputByteArray = Convert.FromBase64String(stringToDecrypt)
                Dim ms As New MemoryStream()
                Dim cs As New CryptoStream(ms, des.CreateDecryptor(key, IV),
                    CryptoStreamMode.Write)
                cs.Write(inputByteArray, 0, inputByteArray.Length)
                cs.FlushFinalBlock()
                Dim encoding As System.Text.Encoding = System.Text.Encoding.UTF8
                Return encoding.GetString(ms.ToArray())
            Catch e As Exception
                Return e.Message
            End Try
        End Function

        Public Function Encrypt(ByVal stringToEncrypt As String,
            ByVal SEncryptionKey As String) As String
            Try
                key = System.Text.Encoding.UTF8.GetBytes(Left(SEncryptionKey, 8))
                Dim des As New DESCryptoServiceProvider()
                Dim inputByteArray() As Byte = Encoding.UTF8.GetBytes(
                    stringToEncrypt)
                Dim ms As New MemoryStream()
                Dim cs As New CryptoStream(ms, des.CreateEncryptor(key, IV),
                    CryptoStreamMode.Write)
                cs.Write(inputByteArray, 0, inputByteArray.Length)
                cs.FlushFinalBlock()
                Return Convert.ToBase64String(ms.ToArray())
            Catch e As Exception
                Return e.Message
            End Try
        End Function

    End Class



    Public Class ErrHandler2

        ''' Handles error by accepting the error message
        ''' Displays the page on which the error occured
        ''' 
        Public Const DirectorioErrores = "~/Error/"

        Public Shared Function WriteError(ByVal e As Exception) As String


            'Dim lastErrorWrapper As HttpException = Server.GetLastError()
            Dim lastErrorWrapper As Exception = e

            'copiado del Global.asax

            Dim lastError As Exception = e

            Dim lastErrorTypeName = lastError.GetType().ToString()
            Dim lastErrorMessage = lastError.Message
            Dim lastErrorStackTrace = lastError.StackTrace


            ' Attach the Yellow Screen of Death for this error   
            Dim YSODmarkup As String
            Dim lastErrorWrapperHttp As System.Web.HttpException
            Try
                If InStr(lastErrorWrapper.GetType.FullName, "HttpException") > 0 Then
                    lastErrorWrapperHttp = lastErrorWrapper

                    YSODmarkup = lastErrorWrapperHttp.GetHtmlErrorMessage()
                    If (Not String.IsNullOrEmpty(YSODmarkup)) Then

                        Dim YSOD = Net.Mail.Attachment.CreateAttachmentFromString(YSODmarkup, "YSOD.htm")
                    End If
                End If


                Console.WriteLine(lastErrorMessage)
            Catch ex As Exception
                'acá no pasó nada.... (para cuidarse de circularidades en el logueo de errores)
            End Try


            '///////////////////////////////////////////////////////////
            Return WriteError(lastErrorTypeName & vbCrLf & lastErrorMessage & vbCrLf & lastErrorStackTrace & vbCrLf & lastError.Source)
        End Function



        Public Shared Function WriteError(ByVal errorMessage As String) As String
            'http://www.dotnetcurry.com/ShowArticle.aspx?ID=94
            Dim nombre, nombreLargo As String
            Try

                Console.WriteLine(errorMessage)




                If System.Web.HttpContext.Current Is Nothing Then
                    'esta funcion tendría que recibir el DirApp?
                    'Path.GetTempPath()

                    Dim p = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location)

                    nombre = "\Error\" & DateTime.Today.ToString("dd-MM-yy") & ".txt"
                    nombreLargo = p + nombre 'Path.Combine(p, "AggregatorItems.xml")


                    'Return Nothing 'donde escribo el archivo????????

                Else
                    nombre = DirectorioErrores & DateTime.Today.ToString("dd-MM-yy") & ".txt"
                    nombreLargo = System.Web.HttpContext.Current.Server.MapPath(nombre)
                End If




                If (Not File.Exists(nombreLargo)) Then
                    Try
                        File.Create(nombreLargo).Close()
                    Catch ex As Exception
                        'si no está creado el directorio "Error", lo graba en el de la aplicacion, pero con hora, por si ya existe otro


                        If System.Web.HttpContext.Current IsNot Nothing Then
                            nombreLargo = System.Web.HttpContext.Current.Server.MapPath("~/" & DateTime.Now.ToString & ".txt")
                            File.Create(nombreLargo).Close()
                        Else
                            Return Nothing
                        End If
                    End Try
                End If


                Using w As StreamWriter = File.AppendText(nombreLargo)
                    w.WriteLine(Constants.vbCrLf & "Log Entry : ")
                    w.WriteLine("{0}", DateTime.Now.ToString(System.Globalization.CultureInfo.InvariantCulture))
                    Dim s As String = ""
                    Try
                        If System.Web.HttpContext.Current IsNot Nothing Then
                            s = System.Web.HttpContext.Current.Request.Url.ToString()
                        End If
                    Catch ex As Exception
                    End Try
                    Dim err As String = "Error in: " & s & ". Error Message:" & errorMessage
                    w.WriteLine(err)
                    w.WriteLine("__________________________")
                    w.Flush()
                    w.Close()

                    Debug.Print(err)
                End Using

            Catch ex As Exception
                'Excepción del tipo 'System.UnauthorizedAccessException'
                Return Nothing 'WriteError(ex.Message) 'si es recursivo, se puede trular....
            End Try
            Return nombreLargo

        End Function

        Public Shared Sub WriteAndRaiseError(ByVal errorMessage As String)
            WriteError(errorMessage)
            Err.Raise(22001, errorMessage)
            'Throw New ApplicationException("Error en la ejecucion del SP: " + Nombre, ex)
        End Sub

        Public Shared Sub WriteAndRaiseError(ByVal e As Exception)
            WriteError(e.ToString)
            Err.Raise(22001, e.ToString) ' e.Message)
            'Throw New ApplicationException("Error en la ejecucion del SP: " + Nombre, ex)
        End Sub
    End Class

End Namespace
