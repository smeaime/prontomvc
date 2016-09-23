Imports System.IO
Imports System.Globalization


Public Class ErrHandler

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
            nombre = DirectorioErrores & DateTime.Today.ToString("dd-MM-yy") & ".txt"
            nombreLargo = System.Web.HttpContext.Current.Server.MapPath(nombre)

            If (Not File.Exists(nombreLargo)) Then
                Try
                    File.Create(nombreLargo).Close()
                Catch ex As Exception
                    'si no está creado el directorio "Error", lo graba en el de la aplicacion, pero con hora, por si ya existe otro
                    nombreLargo = System.Web.HttpContext.Current.Server.MapPath("~/" & DateTime.Now.ToString & ".txt")
                    File.Create(nombreLargo).Close()
                End Try
            End If


            Using w As StreamWriter = File.AppendText(nombreLargo)
                w.WriteLine(Constants.vbCrLf & "Log Entry : ")
                w.WriteLine("{0}", DateTime.Now.ToString(CultureInfo.InvariantCulture))
                Dim err As String = "Error in: " & System.Web.HttpContext.Current.Request.Url.ToString() & ". Error Message:" & errorMessage
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
        WriteError(e.Message)
        Err.Raise(22001, e.Message)
        'Throw New ApplicationException("Error en la ejecucion del SP: " + Nombre, ex)
    End Sub
End Class
