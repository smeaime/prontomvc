
Public Module ProntoVisualBasic
    'Public Function mkf_validacuit(ByVal mk_p_nro As String) As Boolean
    '    Dim mk_suma As Integer
    '    Dim mk_valido As String
    '    mk_p_nro = mk_p_nro.Replace("-", "")
    '    If IsNumeric(mk_p_nro) Then
    '        If mk_p_nro.Length <> 11 Then
    '            mk_valido = False
    '        Else
    '            mk_suma = 0
    '            mk_suma += CInt(mk_p_nro.Substring(0, 1)) * 5
    '            mk_suma += CInt(mk_p_nro.Substring(1, 1)) * 4
    '            mk_suma += CInt(mk_p_nro.Substring(2, 1)) * 3
    '            mk_suma += CInt(mk_p_nro.Substring(3, 1)) * 2
    '            mk_suma += CInt(mk_p_nro.Substring(4, 1)) * 7
    '            mk_suma += CInt(mk_p_nro.Substring(5, 1)) * 6
    '            mk_suma += CInt(mk_p_nro.Substring(6, 1)) * 5
    '            mk_suma += CInt(mk_p_nro.Substring(7, 1)) * 4
    '            mk_suma += CInt(mk_p_nro.Substring(8, 1)) * 3
    '            mk_suma += CInt(mk_p_nro.Substring(9, 1)) * 2
    '            mk_suma += CInt(mk_p_nro.Substring(10, 1)) * 1

    '            If Math.Round(mk_suma / 11, 0) = (mk_suma / 11) Then
    '                mk_valido = True
    '            Else
    '                mk_valido = False
    '            End If
    '        End If
    '    Else
    '        mk_valido = False
    '    End If
    '    Return (mk_valido)
    'End Function





    Protected Sub btnActualizarBase_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnActualizarBase.Click
        BackupMasActualizacionConADONET()
    End Sub

    Sub BackupMasActualizacionConADONET()

        'Dim a = "sp_configure()"
        'Dim a = "RECONFIGURE"
        'Dim a = "sp_configure (('xp_cmdshell', 1)"
        'Dim a = "RECONFIGURE"
        Try

            EntidadManager.ExecDinamico(SC, "EXEC sp_configure 'show advanced options', 1")
            EntidadManager.ExecDinamico(SC, "RECONFIGURE")
            EntidadManager.ExecDinamico(SC, "EXEC sp_configure 'xp_cmdshell', 1")
            EntidadManager.ExecDinamico(SC, "RECONFIGURE")

            Dim parser = New System.Data.SqlClient.SqlConnectionStringBuilder(Encriptar(HFSC.Value))
            Dim servidor As String = parser.DataSource
            Dim base As String = parser.InitialCatalog
            Dim filescript As String = DirApp() & "\Novedades\Nuevos_SP WEB.sql"


            'declare @DBServerName varchar(100)
            'declare @DBName  varchar(100)
            'declare @FilePathName varchar(100)
            'set @DBServerName='MARIANO-PC\SQLEXPRESS'
            'set @DBName='wDemoWilliams'
            'set @FilePathName='"E:\Backup\BDL\ProntoWeb\Proyectos\Pronto\Novedades\Nuevos_SP WEB.sql"'
            ' EXEC(xp_cmdshell)  'sqlcmd -S ' + @DBServerName + ' -d  ' + @DBName + ' -i ' + @FilePathName

            'no puedo usar el archivo que se copió en el IIS para referenciarlo desde el SQL!!!!!

            Dim sSql = " declare @f varchar(100) " & vbCrLf & _
                       " set  @f='""" & filescript & """'" & vbCrLf & _
                       " declare @s varchar(300) " & vbCrLf & _
                       " set @s='sqlcmd -S ''" & servidor & "'' -d  ''" & base & "'' -i ' + @f " & vbCrLf & _
                       "  EXEC xp_cmdshell @s "
            ErrHandler.WriteError(sSql)
            Dim ret = EntidadManager.ExecDinamico(SC, sSql)


            'http://stackoverflow.com/questions/40814/how-do-i-execute-a-large-sql-script-with-go-commands-from-c
            '-necesita una version 2008 de sql? no encuentro las referencias para  Microsoft.SqlServer.Management
            'Dim fileInfo = New FileInfo(filescript)
            'Dim script As String = fileInfo.OpenText().ReadToEnd()
            'Dim connection = New System.Data.SqlClient.SqlConnection(Encriptar(HFSC.Value))
            'Dim a As Microsoft.SqlServer.Management.Common.ServerConnection
            'Dim server = New server(New Microsoft.SqlServer.Management.Common.ServerConnection(connection))
            'server.ConnectionContext.ExecuteNonQuery(script)



            MsgBoxAjax(Me, "Actualizada con éxito")
        Catch ex As Exception
            ErrHandler.WriteError(ex)
            MsgBoxAjax(Me, "Se produjo un error al actualizar. " & ex.Message)
        End Try


    End Sub


    Function ExportarScriptConSMO()
        'http://msdn.microsoft.com/en-us/library/ms162160(v=sql.90).aspx
        'http://stackoverflow.com/questions/3488666/how-to-automate-script-generation-using-smo-in-sql-server

        Dim filescript As String = DirApp() & "\Novedades\Nuevos_SP WEB.sql"

        Dim filescriptdrops As String = DirApp() & "\Novedades\dev\Nuevos_SP WEB drops.sql"

        Try


            'SQL Server 2008 - Backup and Restore Databases using SMO

            Dim parser = New System.Data.SqlClient.SqlConnectionStringBuilder(Encriptar(HFSC.Value))
            Dim servidor As String = parser.DataSource
            Dim user As String = parser.UserID
            Dim pass = parser.Password

            Dim base As String = parser.InitialCatalog


            'Dim connection = New Microsoft.SqlServer.Management.Common.ServerConnection(Encriptar(HFSC.Value))
            Dim connection = New Microsoft.SqlServer.Management.Common.ServerConnection(servidor, user, pass)

            Dim srv = New Server(connection)


            '//Reference the AdventureWorks2008R2 database.  
            Dim db = srv.Databases(base)

            ' http://msdn.microsoft.com/en-us/library/microsoft.sqlserver.management.smo.scriptingoptions.aspx
            '//Define a Scripter object and set the required scripting options. 
            Dim scrp As Scripter



            scrp = New Scripter(srv)



            If False Then

                Using outfile As StreamWriter = New StreamWriter(filescript, True)



                    'Iterate through the tables in database and script each one. Display the script.
                    'Note that the StringCollection type needs the System.Collections.Specialized namespace to be included.
                    Dim tb As Table
                    Dim sp As StoredProcedure
                    Dim smoObjects(1) As Urn
                    Dim i, total As Long



                    For Each sp In db.StoredProcedures
                        If Left(sp.Name, 1) = "w" Then
                            total += 1
                        End If
                    Next
                    Debug.Print(total)


                    Dim drop = New ScriptingOptions()
                    drop.ScriptDrops = True
                    drop.IncludeIfNotExists = True

                    If False Then
                        For Each sp In db.StoredProcedures
                            If Left(sp.Name, 1) = "w" Then
                                If sp.IsSystemObject = False Then
                                    smoObjects = New Urn(0) {}
                                    smoObjects(0) = sp.Urn

                                    Dim sc As StringCollection
                                    sc = scrp.Script(smoObjects)

                                    'outfile.WriteLine(sc.ToString())

                                    'Dim st As String
                                    'For Each st In sc
                                    '    Console.WriteLine(st)
                                    '    outfile.WriteLine(st)
                                    'Next

                                End If
                                i += 1
                                Debug.Print(i)
                            End If
                        Next

                    End If


                    outfile.Close()
                End Using

            End If


            'http://stackoverflow.com/questions/274408/using-smo-to-get-create-script-for-table-defaults

            Dim list = New Generic.List(Of Urn)()
            Dim dataTable = db.EnumObjects(DatabaseObjectTypes.StoredProcedure) '.Table)
            For Each row In dataTable.Rows
                If Left(row("Name"), 1) = "w" Then 'And row("IsSystemObject") = False Then
                    list.Add(New Urn(row("Urn")))
                End If
            Next

            dataTable = db.EnumObjects(DatabaseObjectTypes.View) '.Table)
            For Each row In dataTable.Rows
                If Left(row("Name"), 1) = "w" Then 'And row("IsSystemObject") = False Then
                    list.Add(New Urn(row("Urn")))
                End If
            Next

            dataTable = db.EnumObjects(DatabaseObjectTypes.UserDefinedFunction) '.Table)
            For Each row In dataTable.Rows
                If Left(row("Name"), 1) = "w" Then 'And row("IsSystemObject") = False Then
                    list.Add(New Urn(row("Urn")))
                End If
            Next


            With scrp
                ' scrp.Options.ScriptDrops = True
                '    scrp.Options.WithDependencies = False
                scrp.Options.ScriptSchema = True
                .Options.ScriptData = False
                '    scrp.Options.IncludeIfNotExists = False
                scrp.Options.IncludeHeaders = True
                'scrp.Options.SchemaQualify = True

                '    '.Options.SchemaQualifyForeignKeysReferences = True
                '    '.Options.NoCollation = True
                '    .Options.DriAllConstraints = True
                '    scrp.Options.DriAll = True
                '    .Options.DriAllKeys = True
                '    .Options.DriIndexes = True
                '.Options.ClusteredIndexes = True
                '.Options.NonClusteredIndexes = True



                .Options.ToFileOnly = True
                .Options.FileName = filescript

                .Script(list.ToArray())


                .Options.FileName = filescriptdrops
                scrp.Options.ScriptDrops = True
                .Script(list.ToArray())
            End With

        Catch ex As Exception
            ErrHandler.WriteAndRaiseError(ex)
        End Try

        Dim str As String
        str &= File.ReadAllText(filescriptdrops)
        str &= File.ReadAllText(filescript)

        Dim objStreamWriter As StreamWriter
        objStreamWriter = File.CreateText(filescript)
        objStreamWriter.Write(str)
        objStreamWriter.Close()



        Dim MyFile1 = New FileInfo(filescript)
        Try
            Dim nombrearchivo = MyFile1.Name
            If Not IsNothing(filescript) Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & nombrearchivo)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnNotaCreditoXML)

                Response.TransmitFile(filescript)
                'Response.BinaryWrite()
                'Response.OutputStream


                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            'MsgBoxAjax(Me, ex.Message)
            ErrHandler.WriteError(ex)
        End Try
    End Function



    Protected Sub btnGenerarScript_Click(sender As Object, e As System.EventArgs) Handles btnGenerarScript.Click
        ExportarScriptConSMO()
        'MsgBoxAjax(Me, "Script generado")

    End Sub

    Protected Sub Button7_Click(sender As Object, e As System.EventArgs) Handles Button7.Click
        BackupMasActualizacionConSMO()
    End Sub



    Function BackupMasActualizacionConSMO()
        'http://msdn.microsoft.com/en-us/library/ms162160(v=sql.90).aspx
        'http://stackoverflow.com/questions/3488666/how-to-automate-script-generation-using-smo-in-sql-server


        'SQL Server 2008 - Backup and Restore Databases using SMO

        Dim parser = New System.Data.SqlClient.SqlConnectionStringBuilder(Encriptar(HFSC.Value))
        Dim servidor As String = parser.DataSource
        Dim user As String = parser.UserID
        Dim pass = parser.Password

        Dim base As String = parser.InitialCatalog


        'Dim connection = New Microsoft.SqlServer.Management.Common.ServerConnection(Encriptar(HFSC.Value))
        Dim connection = New Microsoft.SqlServer.Management.Common.ServerConnection(servidor, user, pass)

        Dim srv = New Server(connection)



        '//Reference the AdventureWorks2008R2 database.  
        Dim db = srv.Databases(base)

        Dim tableText As String

        Try

            Dim nuevtablefile As String = DirApp() & "\Novedades\dev\Nuevas_Tablas Web.sql"
            Using FileReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(nuevtablefile)
                tableText = FileReader.ReadToEnd
            End Using

            Dim altertablefile As String = DirApp() & "\Novedades\dev\ALTERTABLE 2011 Modulo WEB.sql"
            Using FileReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(altertablefile)
                tableText = FileReader.ReadToEnd
            End Using

            db.ExecuteNonQuery(tableText)
        Catch ex As Exception
            ErrHandler.WriteError(ex)
        End Try



        Dim filescript As String = DirApp() & "\Novedades\dev\Nuevos_SP WEB desarrollo.sql"
        Using FileReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(filescript)
            tableText = FileReader.ReadToEnd
        End Using


        Try
            db.ExecuteNonQuery(tableText)
        Catch ex As Exception
            ErrHandler.WriteError(ex)
            Dim inner As Exception = ex.InnerException
            While Not (inner Is Nothing)
                MsgBox(inner.Message)
                ErrHandler.WriteError(inner.Message)
                inner = inner.InnerException
            End While

            MsgBoxAjax(Me, ex.Message)

            Throw
            'ex.InnerException
            'ex.InnerException.InnerException
        End Try

        MsgBoxAjax(Me, "exito")

    End Function





End Module