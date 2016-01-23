Option Strict On 'para controlar bien lo del Interop con Office

Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO

Imports Microsoft.VisualBasic
Imports Microsoft.VisualBasic.FileIO
Imports Microsoft.VisualBasic.Strings
Imports System
Imports System.Diagnostics
Imports System.Web.UI

Imports Excel = Microsoft.Office.Interop.Excel
Imports Word = Microsoft.Office.Interop.Word
Imports System.IO

Imports System.Data

Imports System.Linq

Imports CartaDePorteManager

Public Module ProntoFuncionesInterop





    Public Function ImprimirWordDOTconStrict(ByVal mPlantilla As String, ByRef Yo As Object, ByVal SC As String, ByVal Session As System.Web.SessionState.HttpSessionState, ByRef Response As System.Web.HttpResponse, ByVal Id As Object, Optional ByVal Arg3 As Object = Nothing, Optional ByVal Arg4 As Object = Nothing, Optional ByVal Arg5 As Object = Nothing, Optional ByVal outputFileName As String = "", Optional ByVal Arg6 As Object = Nothing, Optional ByVal Arg7 As Object = Nothing) As String


        If Val(Id) < 1 Then Return Nothing

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
            plant = Session(SESSIONPRONTO_glbPathPlantillas).ToString & "\" & mPlantilla '"C:\ProntoWeb\Proyectos\Pronto\Documentos\ComprasTerceros.xlt"
        End If
        'Dim xlt As String = Server.MapPath("../..WebComprasTerceros.xlt")

        'Dim xlt As String = "\\192.168.66.2\inetpub\wwwroot\WebComprasTerceros.xlt" 'Server.MapPath("../..WebComprasTerceros) 'http://support.microsoft.com/kb/311731/es   C:\Inetpub\Wwwroot
        'Dim output As String = Path.GetTempPath() & "archivo.xls" 'no funciona bien si uso el raíz
        Dim output As String
        If outputFileName = "" Then
            output = Session("glbPathPlantillas").ToString & "\archivo.doc" 'no funciona bien si uso el raíz
        Else
            output = outputFileName
        End If

        Dim MyFile1 As New FileInfo(plant)
        Try
            If Not MyFile1.Exists Then 'busca la plantilla
                ErrHandler2.WriteError("No se encuentra la plantilla " & plant)
                Err.Raise(234234, , "No se encuentra la plantilla " & plant)
                Return ""
            End If

            MyFile1 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra
            If MyFile1.Exists Then
                MyFile1.Delete()
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Yo, ex.ToString)
            Throw
            'Return ""
        End Try

        '///////////////////////////////////////////
        '///////////////////////////////////////////






        Dim oW As Word.Application
        Dim oDoc As Word.Document
        'Dim oBooks As Excel.Workbooks 'haciendolo así, no queda abierto el proceso en el servidor http://support.microsoft.com/?kbid=317109
        'Dim oBook As Excel.Workbook


        Try
            oW = CType(CreateObject("Word.Application"), Word.Application)
            oW.Visible = False


            'estaría bueno que si acá tarda mucho, salga
            'puede colgarse en este Add o en el Run. Creo que se cuelga en el Add si no tiene
            '  permisos, y en el Run si está mal referenciada la dll
            '-pero se pianta porque no tiene permisos para usar el Excel, o por no poder usar la carpeta con el archivo?
            Try
                oDoc = oW.Documents.Add(DirectCast(plant, Object))
            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString & "Explota en el oW.Documents.Add(plant).  Plantilla: " & plant & " No se puede abrir el almacenamiento de macros? Verficar las referencias de la plantilla a dlls (especialmente COMPRONTO).   Verificar el directorio de plantillas")
                Throw
                'MsgBoxAjax(Yo, ex.ToString & "Explota en el oW.Documents.Add(plant)")
            End Try


            'ProntoFuncionesUIWeb.Current_Alert("Hasta aca llega")
            'Return

            With oDoc


                'Declaracion de la funcion en la plantilla:
                'Public Sub GenerarResFF(ByVal StringConexion As String, _
                '            ByVal Rendicion As Long, _
                '            ByVal IdCuentaFF As Long, _
                '            ByVal mEmpresa As String, _
                '            ByVal mImprime As String, _
                '            ByVal mCopias As Integer, _
                '            ByVal IdObra As Long)




                oW.DisplayAlerts = Word.WdAlertLevel.wdAlertsNone

                'txtPendientesReintegrar.Text = Encriptar(HFSC.Value)
                'ProntoFuncionesUIWeb.Current_Alert("Depurar GenerarResFF " & Encriptar(HFSC.Value) & " " & Rendicion & " " & cmbCuenta.SelectedValue & " EmpresaNombre " & mImprime & " 1 " & mObra)
                'Return

                'Try

                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                'ejecuto la macro. ZONA DE RIESGO (porque VBA puede tirar un error y no volver)
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////


                'Dim s As String = "'" & .Name & "'!GenerarResFF"

                'cómo se pueden depurar estas llamadas desde Word?
                'pasá la cadena de conexion reemplazando las " por "" (2, no 3)
                'como reemplazar una cadena con caracteres extraños automaticamente? 
                '-y grabarla en un archivo?

                'Try

                'Debug.Print("Emision """ & DebugCadenaImprimible(ReEncriptaParaPronto(SC)) & """," & Id & "," & iisNull(Arg3, "Nothing") & "," & iisNull(Arg4, "Nothing") & "," & iisNull(Arg5, "Nothing") & "," & iisNull(Arg6, "Nothing") & "," & iisNull(Arg7, "Nothing"))
                'ErrHandler2.WriteError("Emision """ & DebugCadenaImprimible(ReEncriptaParaPronto(SC)) & """," & Id & "," & iisNull(Arg3, "Nothing") & "," & iisNull(Arg4, "Nothing") & "," & iisNull(Arg5, "Nothing") & "," & iisNull(Arg6, "Nothing") & "," & iisNull(Arg7, "Nothing"))


                '                *Plantillas
                'Se queda colgado?
                'Verificar que tengan puesto un On Error Resume Next (no puedo catchear el error, y queda andando el Winword o Excel)
                '-Mejor dicho, que no tengan un MsgBox al disparar un error
                'Permisos para ejecutar macros




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
                    ErrHandler2.WriteError("Explota en la llamada a Emision ()" & ex.ToString & "")
                    Throw
                End Try

                '                *Plantillas
                'Se queda colgado?
                'Verificar que tengan puesto un On Error Resume Next (no puedo catchear el error, y queda andando el Winword o Excel)
                '-Mejor dicho, que no tengan un MsgBox al disparar un error
                'Permisos para ejecutar macros



                'Catch ex As Exception
                '    ErrHandler2.WriteError(ex.ToString & "Explota en la llamada a la macro. Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro")
                '    'MsgBoxAjax(Yo, ex.ToString & "Explota en la llamada a la macro.")
                'End Try


                'oW.Application.Run("'" & .Name & "'!" & "Emision", Encriptar(SC), Id)
                'oW.Application.Run("'" & .Name & "'!" & "AgregarLogo", "EmpresaNombre", Session("glbPathPlantillas") & "\..")
                'oW.Application.Run("'" & .Name & "'!" & "DatosDelPie")


                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                ' fin de macro
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////


                '//////////////////////



                'Catch ex As Exception
                'ProntoFuncionesUIWeb.Current_Alert("Llega a ejecutar la macro")
                'Return
                'End Try



                'and added it to the saveas command. The extn (.doc) decides on what format
                'the document is saved as.
                Const wrdFormatDocument As Long = 0 '(save in default format)
                ErrHandler2.WriteError("Pudo ejecutar el Emision(), ahora tratará de grabar")
                .SaveAs(DirectCast(output, Object), wrdFormatDocument) 'adherir extension ".doc"

                'oEx.SaveWorkspace(output) 'no usar esto, usar el del workbook
                oW.DisplayAlerts = Word.WdAlertLevel.wdAlertsAll
            End With





            'ProntoFuncionesUIWeb.Current_Alert("Ahora se va a transmitir")

        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString & " Archivo Plantilla: " & plant & vbCrLf & _
            "Verificar que la DLL ComPronto esté bien referenciada en la " & _
            "plantilla. no solamente basta con ver que esten bien las referencias! A veces, aunque figuren bien " & _
            ", el Inter25 explota. Así que no tenés otra manera de probarlo que ejecutando la llamada a Emision , o " & _
            " que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), " & _
            " o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se " & _
            " llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro")

            'MsgBoxAjax(Yo, ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro")
            Throw
            'Return ""
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
            If Not oDoc Is Nothing Then oDoc.Close(False)
            NAR(oDoc)
            'quit and dispose app
            oW.Quit()
            NAR(oW)
            'VERY IMPORTANT
            GC.Collect()
        End Try


        Return output 'porque no estoy pudiendo ejecutar el response desde acá

        Try
            MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)

                Response.TransmitFile(output)
                Response.End()
            Else
                ErrHandler2.WriteError("No se pudo generar el informe. Consulte al administrador")
                'MsgBoxAjax(Yo, "No se pudo generar el informe. Consulte al administrador")
                Return ""
            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString)
            Throw
            'MsgBoxAjax(Yo, ex.ToString)
            'Return ""
        End Try



        ''Mandar el excel al cliente
        'HttpContext.Current.Response.Clear()
        'HttpContext.Current.Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", fileName))
        'HttpContext.Current.Response.ContentType = "application/ms-excel"
        'Dim sw As StringWriter = New StringWriter
        'Dim htw As HtmlTextWriter = New HtmlTextWriter(sw)
        ''  Create a form to contain the grid
        'Dim table As Table = New Table
        'table.GridLines = gv.GridLines
        ''  render the table into the htmlwriter
        'table.RenderControl(htw)
        ''  render the htmlwriter into the response
        'HttpContext.Current.Response.Write(sw.ToString)
        'HttpContext.Current.Response.End()



    End Function

End Module
