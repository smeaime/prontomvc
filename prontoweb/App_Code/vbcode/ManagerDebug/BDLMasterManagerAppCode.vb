Option Infer On

Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Configuration
Imports System.Linq   '"namespace or type specified in ... doesn't contain any " -Sorry Linq is only available in .net 3.5 http://forums.asp.net/t/1332780.aspx  Advanced Compile Options
Imports ADODB.DataTypeEnum
Imports System.Diagnostics
Imports System.Data
Imports System.Data.SqlClient 'esto tambien hay que sacarlo de acá

Imports System.Collections

Imports System.Linq.Dynamic
Imports System.Collections.Generic

Imports Microsoft.VisualBasic


Imports CartaDePorteManager

Namespace Pronto.ERP.Bll

    Public Class BDLMasterEmpresasManagerMigrar






        Public Enum ParametrosDeBdlMaster
            IdUbicacionStockEnTransito
            GenerarSalidaDesdeRecepcionSAT
            NumeracionAutomaticaDeOrdenesDePago
            IdRubroAnticipos
        End Enum

        Public Shared Function GetUltimaBaseQueAccedioUsuario(ByVal userid As String) As String
            Dim db = New LinqBDLmasterDataContext(Encriptar(ConexBDLmaster))

            Dim ue = (From p In db.UserDatosExtendidos _
                           Where p.UserId.ToString = userid _
                           Select p).SingleOrDefault


            If IsNothing(ue) Then
                Return ""
            Else
                Return ue.UltimaBaseAccedida
            End If

        End Function

        Public Shared Function SetUltimaBaseQueAccedioUsuario(ByVal userid As String, ByVal base As String) As Boolean
            Dim db = New LinqBDLmasterDataContext(Encriptar(ConexBDLmaster))

            Dim ue = (From p In db.UserDatosExtendidos _
                           Where p.UserId.ToString = userid _
                           Select p).SingleOrDefault


            If IsNothing(ue) Then
                ue = New UserDatosExtendido
                ue.UserId = New Guid(userid)
                ue.UltimaBaseAccedida = base

                db.UserDatosExtendidos.InsertOnSubmit(ue)
            Else
                If If(ue.UltimaBaseAccedida, "") = "" Then

                End If
                ue.UltimaBaseAccedida = base
            End If

            db.SubmitChanges()
        End Function

        Public Shared Property UltimaVezAccedida(ByVal Usuario, ByVal BaseEmpresa)
            Set(ByVal value)

            End Set
            Get

            End Get
        End Property

        Function TraerValorParametroDeBdlMaster(ByVal SC_BdlMaster As String, ByVal Campo As ParametrosDeBdlMaster) As String

        End Function





        Shared Function GetEmpresa(ByVal IdEmpresa As Integer, ByVal empresaList As Pronto.ERP.BO.EmpresaList) As Pronto.ERP.BO.Empresa

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




        Shared Function SetSiteMap(ByVal Usuario As Usuario) As String

            If Usuario Is Nothing Then Exit Function

            Dim empresa As String
            'empresa = ConfigurationManager.AppSettings("ConfiguracionEmpresa")

            Dim conexion = Usuario.StringConnection 'en SC en la master, estoy usando la bdlmaster. Corregir

            empresa = BDLMasterEmpresasManager.EmpresaPropietariaDeLaBase(conexion)

            If empresa = "Williams" Then
                Return "SiteMapWilliams"
            ElseIf empresa = "Esuco" Then
                Return "SiteMapEsuco"
            End If

        End Function

        Shared Function SetLogoImage_LoginPage(ByVal sConexionBDLmaster As String) As String

            Dim Empresa As String = EmpresaDefaultDel_webconfig()


            If Empresa = "Williams" Then
                Return "~/Imagenes/williams.gif"
            ElseIf Empresa = "Esuco" Then
                Return "~/Imagenes/esuco.gif"
            Else
                Return "~/Imagenes/bdl.gif"
            End If

            '

            'http://www.vbdotnetforums.com/graphics-gdi/22004-how-can-i-transparent-image-picture-box.html
            'Dim bmp As New Bitmap(My.Resources.lite1)
            'bmp.MakeTransparent(Color.Blue)
            'PictureBox1.Image = bmp


            'http://msdn.microsoft.com/en-us/library/ms172507.aspx
        End Function

        Shared Function SetLogoImage_MasterPage(ByVal Usuario As Usuario) As String
            'If Session("IdEmpresa") Is Nothing Then
            '    'LogoImage.ImageUrl = "~/Imagenes/icon_biggrin.gif" ' 
            '    LogoImage.ImageUrl = "~/Imagenes/0bak.gif" '"~/Imagenes/0.jpg"
            '    LogoImage.ImageUrl = "~/Imagenes/williams.gif" '"~/Imagenes/0.jpg"
            'Else
            '    LogoImage.ImageUrl = String.Format("~/Imagenes/{0}.jpg", Session("IdEmpresa"))
            'End If


            If Usuario Is Nothing Then Exit Function

            Dim empresa As String
            'empresa = ConfigurationManager.AppSettings("ConfiguracionEmpresa")

            Dim conexion = Usuario.StringConnection 'en SC en la master, estoy usando la bdlmaster. Corregir

            empresa = BDLMasterEmpresasManager.EmpresaPropietariaDeLaBase(conexion)



            '            URL:	/ProntoWeb/Principal.aspx
            'User:       andres()
            '            Exception(Type) : System.ApplicationException()
            'Message:	Error en la ejecucion del SP: Parametros_TX_Parametros2BuscarClave - System.InvalidOperationException: The 
            'ConnectionString property has not been initialized. at System.Data.SqlClient.SqlConnection.PermissionDemand() at System.Data.SqlClient.SqlConnectionFactory.PermissionDemand(DbConnection outerConnection) at System.Data.ProviderBase.DbConnectionClosed.OpenConnection(DbConnection outerConnection, DbConnectionFactory connectionFactory) at System.Data.SqlClient.SqlConnection.Open() at Pronto.ERP.Dal.GeneralDB.TraerDatos(String SC, String Nombre, Object[] ParametrosQueLeQuieroMandarAsql) in C:\Backup\BDL\DataAccess\GeneralDB.vb:line 137
            'Stack Trace:	 at Pronto.ERP.Dal.GeneralDB.TraerDatos(String SC, String Nombre, Object[] ParametrosQueLeQuieroMandarAsql) in C:\Backup\BDL\DataAccess\GeneralDB.vb:line 228
            'at Pronto.ERP.Bll.ParametroManager.TraerValorParametro2(String SC, String Campo) in C:\Backup\BDL\BussinessLogic\ParametroManager.vb:line 529
            'at Pronto.ERP.Bll.ParametroManager.TraerValorParametro2(String SC, eParam2 Campo) in C:\Backup\BDL\BussinessLogic\ParametroManager.vb:line 516
            'at Pronto.ERP.Bll.BDLMasterEmpresasManagerMigrar.SetLogoImage_MasterPage(Usuario Usuario)
            '            at(MasterPage.ConfiguracionDeLaEmpresa())
            'at MasterPage.Page_Load(Object sender, EventArgs e)
            'at System.Web.UI.Control.OnLoad(EventArgs e)
            '            at(System.Web.UI.Control.LoadRecursive())
            '            at(System.Web.UI.Control.LoadRecursive())
            'at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)

            'acá se piantaba
            'habrá sido que tenían las sesiones abiertas? -y qué con eso?
            'PORQUE PUSO CONTINUAR EN EL SELECCIONAREMPRESA SIN HABER ELEGIDO EN EL LISTBOX Y LO DEJÓ PASAR!!!!!


            Dim logo = ParametroManager.TraerValorParametro2(Usuario.StringConnection, ParametroManager.eParam2.LogoArchivo)
            If logo <> "" Then
                Return "~/Imagenes/" & logo
            ElseIf empresa = "Williams" Then
                Return "~/Imagenes/williams.gif"
            ElseIf empresa = "Esuco" Then
                Return "~/Imagenes/esuco.gif"
            ElseIf empresa = "Autotrol" Then
                Return "~/Imagenes/autotrol.png"
            Else
                Return "~/Imagenes/bdl.gif"
            End If


            '

            'http://www.vbdotnetforums.com/graphics-gdi/22004-how-can-i-transparent-image-picture-box.html
            'Dim bmp As New Bitmap(My.Resources.lite1)
            'bmp.MakeTransparent(Color.Blue)
            'PictureBox1.Image = bmp


            'http://msdn.microsoft.com/en-us/library/ms172507.aspx

        End Function


        Public Shared Function AddEmpresaToSession(ByVal IdEmpresa As String, ByRef Session As Object, ByVal sConexBDLMaster As String, ByVal Yo As Object) As Boolean

            Dim usuario As Usuario = Nothing
            usuario = New Usuario
            usuario.UserId = Session(SESSIONPRONTO_UserId)
            usuario.Nombre = Session(SESSIONPRONTO_UserName)

            'session(SESSIONPRONTO_NombreEmpresa) = lista(0).Descripcion

            If IsNumeric(IdEmpresa) Then
                If usuario.UserId Is Nothing Then
                    'esta el usuario en la empresa? qué pasó?

                    'If usuario Is Nothing Or session(SESSIONPRONTO_UserId) Is Nothing Then
                    '    If Not Request.IsAuthenticated Then
                    '        FormsAuthentication.SignOut()
                    '    End If

                    '    Response.Redirect(FormsAuthentication.LoginUrl)
                    '    Return
                    'End If


                    Return False
                End If
                usuario.IdEmpresa = Convert.ToInt32(IdEmpresa)
                usuario.StringConnection = Encriptar(BDLMasterEmpresasManager.GetConnectionStringEmpresa(usuario.UserId, usuario.IdEmpresa, sConexBDLMaster, "XXXXXX"))
            Else
                'me pasan el parametro de la empresa con el nombre, no con el Id
                usuario.Empresa = IdEmpresa
                usuario.StringConnection = Encriptar(BDLMasterEmpresasManager.GetConnectionStringEmpresa(usuario.UserId, 0, sConexBDLMaster, IdEmpresa))
            End If

            Dim sc = Encriptar(usuario.StringConnection)



            '////////////////////////////////////////////////////
            'busco los tres puntos de la IP. Esto es solamente para que, si hago un terminal donde 
            'está la web, no me pierda
            Dim BaseDeDatos As String = ""
            Dim i As Integer
            Try

                BaseDeDatos = Mid(sc, InStr(sc, "ource=") + 6, InStr(sc, ";") - InStr(sc, "ource=") - 6)
                i = InStr(BaseDeDatos, ".", )
                If i > 0 Then
                    i = i + InStr(Mid(BaseDeDatos, i), ".", )
                    If i > 0 Then
                        i = i + InStr(Mid(BaseDeDatos, i), ".", )
                    End If
                End If
            Catch ex As Exception
                ErrHandler2.WriteError("Es conveniente cambiar por IPs a las canalizaciones sin nombre al usar conexiones remotas -->" & BaseDeDatos & " " & ex.ToString & " " & usuario.StringConnection)
                'Return False
            End Try
            '////////////////////////////////////////////////////



            'BDLMasterEmpresasManagerMigrar.SetUltimaBaseQueAccedioUsuario(Session(SESSIONPRONTO_UserId), usuario.Empresa)

            Session(SESSIONPRONTO_USUARIO) = usuario

            Session(SESSIONPRONTO_DirectorioFTP) = "C:\"

            If sc = "" Then Return False 'por qué pasa esto?



            '////////////////////////////////////////////////////////////////
            ' Busco el usuario web en la lista de usuarios de la empresa
            '////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////

            'esta es la primera linea en que se accede a la base Pronto? -creo que sí
            '-no puedo reducirle el timeout?

            Dim dt As DataTable
            If False Then
                dt = GetStoreProcedure(usuario.StringConnection, enumSPs.Empleados_TX_UsuarioNT, usuario.Nombre)
            Else
                dt = EntidadManager.ExecDinamico(usuario.StringConnection, "Empleados_TX_UsuarioNT '" & usuario.Nombre & "'", 15)

            End If


            '////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////





            If dt.Rows.Count > 0 Then
                'Lo encontró, y me traigo sus datos
                With dt.Rows(0)
                    Session(SESSIONPRONTO_glbIdUsuario) = .Item(0)
                    Session(SESSIONPRONTO_glbIdSector) = .Item("IdSector")
                    Session(SESSIONPRONTO_glbLegajo) = .Item("Legajo")
                    Session(SESSIONPRONTO_glbIdCuentaFFUsuario) = .Item("IdCuentaFondoFijo")
                    Session(SESSIONPRONTO_glbIdObraAsignadaUsuario) = .Item("IdObraAsignada")
                End With

            Else
                'No lo encontró, quizás es un proveedor
                Try

                    Dim plist As ProveedorList = ProveedorManager.GetList(Encriptar(usuario.StringConnection))
                    Dim p As New Proveedor
                    p = plist.Find(Function(obj) obj.Cuit = usuario.Nombre Or obj.RazonSocial = usuario.Nombre)
                    If p IsNot Nothing Then
                        'Che pero guarda, quizás es un proveedor
                        '-como? esta obligado el proveedor a ser un empleado si quiere entrar por web?
                        'BuscarProveedorPorCUIT(

                        ' en vb no se puede hacer la funcion al vuelo:
                        'Person myLocatedObject = myList.Find(delegate(Person p) {return p.ID == 1; });
                        'http://social.msdn.microsoft.com/Forums/en-US/vbgeneral/thread/d47ec876-7fef-4788-a983-8e34647e13df
                        'parece que en vb9 sí se puede!!!!!
                        'list.Find(Function(obj) obj.Name = match)

                        Session(SESSIONPRONTO_glbWebIdProveedor) = p.Id
                        Session(SESSIONPRONTO_glbWebRazonSocial) = p.RazonSocial
                        Session(SESSIONPRONTO_glbWebCUIT) = p.Cuit

                    Else

                        'No se puede mostrar un cuadro de diálogo o formulario modal cuando la aplicación no está en modo UserInteractive. Especifique el estilo ServiceNotification o DefaultDesktopOnly para mostrar una notificación de una aplicación de servicio.
                        'MessageBox.Show("Mensaje ", "Titulo", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly)
                        'Response.Write("El usuario Web no tiene usuario en SQL. Contacte al Administrador del sistema")


                        Dim rol() As String
                        'rol = Roles.GetRolesForUser()
                        rol = Web.Security.Roles.GetRolesForUser(usuario.Nombre)

                        Dim s As String
                        Try
                            Dim base As String = TextoEntre(Encriptar(usuario.StringConnection), "catalog=", ";")
                            If rol(0) = "Cliente" Then
                                'comenté los mensajes que mostraban la cadena de conexion
                                'MsgBoxAlert("El proveedor " & session(SESSIONPRONTO_UserName) & " no se encuentra en la lista de proveedores de " & usuario.StringConnection & ". Contacte al Administrador del sistema")
                                s = "El proveedor '" & Session(SESSIONPRONTO_UserName) & "' no se encuentra en la lista de proveedores de la base " & base & " id:" & usuario.IdEmpresa & ". Contacte al Administrador del sistema"
                                ErrHandler2.WriteError(s)
                                MsgBoxAjaxAndRedirect(Yo, s, "Login.aspx")
                            Else
                                'MsgBoxAlert("El usuario " & session(SESSIONPRONTO_UserName) & " no tiene usuario para conectarse a " & usuario.StringConnection & ". Contacte al Administrador del sistema") 
                                s = "El usuario '" & Session(SESSIONPRONTO_UserName) & "' no tiene usuario Pronto para conectarse a la base '" & base & "' (idbase:" & usuario.IdEmpresa & "). Contacte al Administrador del sistema"
                                ErrHandler2.WriteError(s)
                                MsgBoxAjaxAndRedirect(Yo, s, "Login.aspx")
                            End If
                        Catch ex As Exception
                            'MsgBoxAlert("El usuario " & session(SESSIONPRONTO_UserName) & " no tiene ningún rol asignado. Contacte al Administrador del sistema")
                            s = "El usuario " & Session(SESSIONPRONTO_UserName) & " no tiene ningún rol asignado. Contacte al Administrador del sistema"
                            ErrHandler2.WriteError(s)
                            MsgBoxAjaxAndRedirect(Yo, s, "Login.aspx")
                        End Try

                        Return False


                        Session(SESSIONPRONTO_glbIdUsuario) = ""
                        Session("glbIdSector") = ""
                        Session("glbLegajo") = ""
                        Session("glbIdCuentaFFUsuario") = ""
                        Session(SESSIONPRONTO_glbIdObraAsignadaUsuario) = ""
                    End If
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                    If False Then
                        Throw New Exception("No encuentro '" & usuario.Nombre & "' ni en Empleados ni en Proveedores!")
                        'en realidad puede ser un usuario externo de williams, un proveedor que quiere ver solo el informe
                    End If

                End Try

            End If

            '////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////





            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            Try
                Dim DirPlantilla As String = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(usuario.StringConnection).Item("PathPlantillas").ToString
                If DirPlantilla = "" Then
                    Session("glbPathPlantillas") = "" 'App.Path & "\Plantillas"
                Else
                    Session("glbPathPlantillas") = DirPlantilla
                End If
            Catch ex As Exception
                ProntoFuncionesUIWeb.MsgBoxAlert("No se pudo cargar el parámetro 'PathPlantillas' de la tabla Parametros")
                Session("glbPathPlantillas") = ""
            End Try
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////


            Session(SESSIONPRONTO_USUARIO) = usuario

            Return True



        End Function


        Public Shared Function ElUsuarioTieneUnaSolaEmpresa(ByVal sConexBDLMaster As String, ByVal userId As String) As Boolean
            Dim lista As EmpresaList = EmpresaManager.GetEmpresasPorUsuario(sConexBDLMaster, userId)
            If IsNothing(lista) Then Return False 'no tiene empresa asignada
            If lista.Count = 1 Then
                Return True
            Else
                Return False
            End If
        End Function

        Shared Function ConexionDeLaUnicaBaseDelUsuario(ByVal ConexBDLmaster As String, ByVal userid As String) As String
            Dim lista As Pronto.ERP.BO.EmpresaList = EmpresaManager.GetEmpresasPorUsuario(ConexBDLmaster, userid)
            Return Encriptar(lista(0).ConnectionString)
        End Function

        Shared Function IdEmpresaDeLaUnicaBaseDelUsuario(ByVal ConexBDLmaster As String, ByVal userid As String) As Long
            Dim lista As Pronto.ERP.BO.EmpresaList = EmpresaManager.GetEmpresasPorUsuario(ConexBDLmaster, userid)
            Return lista(0).Id
        End Function



        Public Shared Function EmpresaDefaultDel_webconfig() As String
            Return ConfigurationManager.AppSettings("ConfiguracionEmpresa")
        End Function

        'Public Function GetConnectionString(ByVal IdEmpresa As Integer) As String
        '    Dim empresaList As Pronto.ERP.BO.EmpresaList
        '    empresaList = DirectCast(Application.Item("empresaList"), Pronto.ERP.BO.EmpresaList)
        '    Dim cs As String = String.Empty
        '    For Each empresa As Empresa In empresaList
        '        If (empresa.Id = IdEmpresa) Then
        '            cs = empresa.ConnectionString
        '            'Dim log As Agilmind.RemotingServer.Log
        '            'log = New Agilmind.RemotingServer.Log()
        '            'log.Add(String.Format("(MASTER_PAGE) IdEmpresa: {0} - Empresa: {1} - SC : {2}", empresa.Id, empresa.Descripcion, empresa.ConnectionString), System.Web.Configuration.WebConfigurationManager.AppSettings("PathInfo").ToString)
        '        End If
        '    Next
        '    Return cs
        'End Function

        'Public Function GetIdEmpresaSession(ByVal session) As Integer
        '    If (session("IdEmpresa") IsNot Nothing) Then
        '        Return Convert.ToInt32(session("IdEmpresa"))
        '    Else
        '        Response.Redirect("~/ProntoWeb/Login.aspx") 'no usar Redirect dentro de un try Catch, porque siempre tira excepcion
        '    End If
        'End Function

        Public Function HaveSession(ByVal session) As Boolean
            Dim hs As Boolean = True
            If (session(SESSIONPRONTO_UserId) Is Nothing) Then
                hs = False
            End If
            If (session(SESSIONPRONTO_UserName) Is Nothing) Then
                hs = False
            End If
            If (session("IdEmpresa") Is Nothing) Then
                hs = False
            End If
            If (session("IdEmpleado") Is Nothing) Then
                hs = False
            End If
            If (hs) Then
                Return True
            Else
                Return False
            End If
        End Function





        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////

        'Enum SessionProntoEnum
        '    NombreEmpresa
        'End Enum

        'SessionPronto(session, e as SessionProntoEnum)
        'session(SESSIONPRONTO_NombreEmpresa)



        'Public Property SessionUserId(ByRef Session As HttpSessionState) As String
        '    Get
        '        Return session(SESSIONPRONTO_UserId)
        '    End Get
        '    Set(ByVal value As String)
        '        session(SESSIONPRONTO_UserId) = value
        '    End Set
        'End Property

        'Public Property SessionNombreEmpresa(ByRef Session As HttpSessionState) As Long
        '    Get
        '        Return session(SESSIONPRONTO_NombreEmpresa)
        '    End Get
        '    Set(ByVal value As Long)
        '        session(SESSIONPRONTO_NombreEmpresa) = value
        '    End Set
        'End Property

    End Class

    Public Class MySession
        'http://stackoverflow.com/questions/465522/is-it-a-good-idea-to-create-an-enum-for-the-key-names-of-session-values

        ' Private constructor (use MySession.Current to access the current instance).
        Private Sub New()
        End Sub

        ' Gets the current session.
        Public Shared ReadOnly Property Current() As MySession
            Get
                Dim session As MySession = TryCast(Web.HttpContext.Current.Session("__MySession__"), MySession)
                If session Is Nothing Then
                    session = New MySession()
                    Web.HttpContext.Current.Session("__MySession__") = session
                End If
                Return session
            End Get
        End Property

        ' My session data goes here:
        Public MyString As String
        Public MyFlag As Boolean
        Public MyNumber As Integer
    End Class



    <Serializable()> Public Class BDLmasterUsuarioPermiso
        Public Descripcion As String
        Public Emails As String

    End Class

    Public Class BDLmasterPermisosManager

        Const Tabla = "DetalleUserPermisos"
        Const IdTabla = "IdDetalleUserPermisos"

        '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx

        Public Shared Function Validar(ByVal ConexBDLmaster As String, ByVal dr As DataRow) As String
            With dr
                If iisNull(.Item("CodigoVendedor")) = "" Then
                    Return "Falta un código"
                End If
                If iisNull(.Item("Nombre")) = "" Then
                    Return "Falta la razón social"
                End If

                '////////////////////////////////////////////////
                '/////////         CUIT           ///////////////
                '////////////////////////////////////////////////
                If Not ProntoMVC.Data.FuncionesGenericasCSharp.CUITValido(.Item("CUIT")) Then
                    Return "El CUIT no es valido"
                End If

                'verificar que no existe el cuit 'en realidad lo debería verificar el objeto, no?
                'If (mvarId <= 0 Or BuscarClaveINI("Control estricto del CUIT") = "SI") And _
                'Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Proveedores", "TX_PorCuit", txtCUIT.Text)
                Dim id = EntidadManager.TablaSelectId(ConexBDLmaster, Tabla, "REPLACE(CUIT,'-','')='" & .Item("CUIT").Replace("-", "") & "'   AND IdVendedor<>'" & .Item(0) & "'")
                If id <> 0 Then
                    'For Each dr2 As Data.DataRow In ds.Tables(0).Rows
                    'If IdEntity <> ds.Tables(0).Rows(0).Item(0).Value Then 'And IsNull(oRs.Fields("Exterior").Value) Then
                    Return "El CUIT ya fue asignado" ' al cliente " & dr2!RazonSocial)
                    Exit Function
                    'End If
                    'Next
                End If


                'Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(HFSC.Value, "Vendedores", "TX_PorCuit", TextoWebControl(.FindControl("txtNewCUIT")))
                'If ds.Tables(0).Rows.Count > 0 Then

                '    For Each dr2 As Data.DataRow In ds.Tables(0).Rows
                '        'If IdEntity <> ds.Tables(0).Rows(0).Item(0).Value Then 'And IsNull(oRs.Fields("Exterior").Value) Then
                '        MsgBoxAjax(Me, "El CUIT ya fue asignado al cliente " & dr2!RazonSocial)
                '        Exit Function
                '        'End If
                '    Next
                'End If





                Return ""
            End With
        End Function



        Public Shared Function TraerMetadata(ByVal SC As String, Optional ByVal id As Integer = -1) As DataTable

            If id = -1 Then
                Return EntidadManager.ExecDinamico(SC, "select * from " & Tabla & " where 1=0")
            Else
                Return EntidadManager.ExecDinamico(SC, "select * from " & Tabla & " where " & IdTabla & "=" & id)
            End If


        End Function

        Public Shared Function Insert(ByVal ConexBDLmaster As String, ByVal dt As DataTable) As Integer
            '// Write your own Insert statement blocks 


            'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
            ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
            'y esto? http://www.vbforums.com/showthread.php?t=352219


            ''convertir datarow en datatable
            'Dim ds As New DataSet
            'ds.Tables.Add(dr.Table.Clone())
            'ds.Tables(0).ImportRow(dr)

            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(ConexBDLmaster))
            myConnection.Open()

            Dim adapterForTable1 = New SqlDataAdapter("select * from " & Tabla, myConnection)
            Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
            adapterForTable1.Update(dt)

        End Function

        Public Shared Function Fetch(ByVal ConexBDLmaster As String, ByVal UserId As String, ByVal Modulo As String) As DataRow
            Return Fetch(ConexBDLmaster, UserId, [Enum].Parse(GetType(EntidadesPermisos), Modulo.Replace(" ", "_")))
        End Function

        Public Shared Function Fetch(ByVal ConexBDLmaster As String, ByVal UserId As String, ByVal Modulo As EntidadesPermisos) As DataRow
            Return DataTableWHERE(Fetch(ConexBDLmaster, UserId), "Modulo=" & _c(Modulo.ToString.Replace("_", " "))).Rows(0)
        End Function

        Enum EntidadesPermisos
            'el problema clasico: enums de strings

            'lo que agregues acá, también ponelo en el metodo Fetch 
            'para modificar la cantidad de checks, andá a la grilla del markup de EditarUsuario.aspx
            Establecimientos
            Cartas_de_Porte
            CDPs_Facturacion

            CDPs_VerHistorial
            CDPs_VerFacturaImputada
            CDPs_FacturarleAClienteExplicito

            CDPs_InfGerenciales
            CDPs_InfAnalisisTarifa
            CDPs_ImagenesDescarga
            CDPs_ControlDiario

            CDPs_Importador
            CDPs_Mails
            Clientes
            Comparativas
            Destinos
            Facturas
            Humedad
            Listas_de_Precios
            Notas_de_Crédito
            Pedidos
            Productos
            Requerimientos
            Seguridad_y_Firmas
            Vendedores
            Artículos
            Obras
            Unidades
            Sectores
        End Enum

        Public Shared Function Fetch(ByVal ConexBDLmaster As String, ByVal UserId As String) As DataTable

            'Return EntidadManager.GetListTX(SC, "Vendedores", "TT", Nothing).Tables(0)

            Dim dt As DataTable = EntidadManager.ExecDinamico(ConexBDLmaster, "Select * from " & Tabla & " where UserId=" & _c(UserId))

            s(EntidadesPermisos.Artículos, UserId, dt)
            s(EntidadesPermisos.Sectores, UserId, dt)
            s(EntidadesPermisos.Obras, UserId, dt)
            s(EntidadesPermisos.Unidades, UserId, dt)

            s(EntidadesPermisos.Cartas_de_Porte, UserId, dt)

            s(EntidadesPermisos.CDPs_VerHistorial, UserId, dt)
            s(EntidadesPermisos.CDPs_VerFacturaImputada, UserId, dt)
            s(EntidadesPermisos.CDPs_FacturarleAClienteExplicito, UserId, dt)
            s(EntidadesPermisos.CDPs_InfAnalisisTarifa, UserId, dt)
            s(EntidadesPermisos.CDPs_InfGerenciales, UserId, dt)
            s(EntidadesPermisos.CDPs_ControlDiario, UserId, dt)

            s(EntidadesPermisos.CDPs_ImagenesDescarga, UserId, dt)

            s(EntidadesPermisos.CDPs_Facturacion, UserId, dt)
            s(EntidadesPermisos.CDPs_Importador, UserId, dt)
            s(EntidadesPermisos.CDPs_Mails, UserId, dt)

            s(EntidadesPermisos.Clientes, UserId, dt)
            s(EntidadesPermisos.Comparativas, UserId, dt)
            s(EntidadesPermisos.Destinos, UserId, dt)
            s(EntidadesPermisos.Facturas, UserId, dt)
            s(EntidadesPermisos.Humedad, UserId, dt)
            s(EntidadesPermisos.Listas_de_Precios, UserId, dt)
            s(EntidadesPermisos.Notas_de_Crédito, UserId, dt)

            s(EntidadesPermisos.Pedidos, UserId, dt)

            s(EntidadesPermisos.Productos, UserId, dt)

            s(EntidadesPermisos.Requerimientos, UserId, dt)
            s(EntidadesPermisos.Seguridad_y_Firmas, UserId, dt)
            s(EntidadesPermisos.Vendedores, UserId, dt)

            'dt.Columns.Add("Instalado")

            Return dt
        End Function


        Public Shared Function PuedeLeer(ByVal ConexBDLmaster As String, ByVal UserId As String, ByVal Modulo As EntidadesPermisos) As Boolean
            Return Fetch(ConexBDLmaster, UserId, Modulo).Item("PuedeLeer")
        End Function

        Public Shared Function PuedeModificar(ByVal ConexBDLmaster As String, ByVal UserId As String, ByVal Modulo As EntidadesPermisos) As Boolean
            Return Fetch(ConexBDLmaster, UserId, Modulo).Item("PuedeModificar")
        End Function

        Public Shared Function PuedeEliminar(ByVal ConexBDLmaster As String, ByVal UserId As String, ByVal Modulo As EntidadesPermisos) As Boolean
            Return Fetch(ConexBDLmaster, UserId, Modulo).Item("PuedeEliminar")
        End Function

        Shared Sub s(ByVal m As EntidadesPermisos, ByVal UserId As String, ByRef dt As DataTable)
            Dim Modulo As String = [Enum].GetName(m.GetType(), m).Replace("_", " ")

            If dt.Select("Modulo=" & _c(Modulo)).Length = 0 Then

                Dim dr As DataRow = dt.NewRow

                Randomize()
                dr.Item("IdDetalleUserPermisos") = Rnd(30000)

                dr.Item("Modulo") = Modulo
                dr.Item("UserId") = UserId
                dr.Item("PuedeLeer") = False
                dr.Item("PuedeModificar") = False
                dr.Item("PuedeEliminar") = False
                dr.Item("Instalado") = False
                ', False, False, False)

                'metodo1
                dt.Rows.Add(dr)

                'metodo2
                'dt.ImportRow(dr)
                'dt.AcceptChanges()
            End If
        End Sub





        Public Shared Function Update(ByVal ConexBDLmaster As String, ByVal dt As DataTable) As Integer
            '// Write your own Insert statement blocks 


            'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
            ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
            'y esto? http://www.vbforums.com/showthread.php?t=352219


            ''convertir datarow en datatable
            'Dim ds As New DataSet
            'ds.Tables.Add(dr.Table.Clone())
            'ds.Tables(0).ImportRow(dr)

            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(ConexBDLmaster))
            myConnection.Open()

            Dim adapterForTable1 = New SqlDataAdapter("select * from " & Tabla, myConnection)
            Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
            'si te tira error acá, ojito con estar usando el dataset q usaste para el 
            'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update
            adapterForTable1.Update(dt)

        End Function



        Public Shared Function Delete(ByVal ConexBDLmaster As String, ByVal Id As Long)
            '// Write your own Delete statement blocks. 
            EntidadManager.ExecDinamico(ConexBDLmaster, String.Format("DELETE  " & Tabla & "  WHERE {1}={0}", Id, IdTabla))
        End Function





    End Class


    



    Public Class InformesWebManager
        Shared Function Update(ByVal userid As String, ByVal razonsocial As String, Optional ByVal cuit As String = "")
            Dim db = New LinqBDLmasterDataContext(Encriptar(ConexBDLmaster))


            Dim ue = (From p In db.UserDatosExtendidos _
                           Where p.UserId.ToString = userid _
                           Select p).SingleOrDefault


            If IsNothing(ue) Then
                ue = New UserDatosExtendido
                ue.UserId = New Guid(userid)
                ue.RazonSocial = razonsocial
                ue.CUIT = cuit

                db.UserDatosExtendidos.InsertOnSubmit(ue)
            Else
                ue.RazonSocial = razonsocial
            End If

            db.SubmitChanges()
        End Function



        Public Shared Function RebindTablaInformes(ByVal SC As String) As Generic.List(Of InformesWeb)
            'http://weblogs.asp.net/scottgu/archive/2007/05/19/using-linq-to-sql-part-1.aspx

            'http://stackoverflow.com/questions/793718/paginated-search-results-with-linq-to-sql

            Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

            Dim q = From e In db.InformesWebs

            Return q.ToList
        End Function


        Public Shared Function Traer(ByVal UserId As String) As UserDatosExtendido

            Dim db = New LinqBDLmasterDataContext(Encriptar(ConexBDLmaster))

            Dim uext = (From p In db.UserDatosExtendidos _
                           Where p.UserId.ToString = UserId _
                           Select p).SingleOrDefault

            Return uext
        End Function









    End Class

    Public Class RequerimientoManagerExtension
        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetItemsRequerimientoPendientes(ByVal SC As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, Optional txtBuscar As String = "", Optional cmbBuscarEsteCampo As String = "", Optional fDesde As Date = #1/1/1900#, Optional fHasta As Date = #1/1/2100#) As Object '   List(Of DataRow)

            'Dim txtBuscar As String = ""
            'Dim cmbBuscarEsteCampo As String = ""
            'Dim fDesde = #1/1/1900#, fHasta = #1/18/2100#


            Dim dt As DataTable
            Using db As New DataClasses2DataContext(Encriptar(SC))

                'http://stackoverflow.com/questions/2455659/how-to-use-contains-or-like-in-a-dynamic-linq-query
                'Dim linqDinamico = db.wVistaRequerimientos.Where(cmbBuscarEsteCampo.SelectedValue & ".Contains(@0)", Val(txtBuscar.Text))  'el filtro de columna lo hago con linq dinamico
                Dim linqDinamico As IQueryable(Of wVistaDetRequerimiento)

                If txtBuscar <> "" Then
                    Try
                        Dim busq
                        If cmbBuscarEsteCampo Is Nothing Then
                            'cmbBuscarEsteCampo = "NumeroRequerimiento"
                            'busqueda genérica por default (no especificó columna)
                            linqDinamico = db.wVistaDetRequerimientos.Where("NumeroRequerimiento = @0 OR Articulo.Contains(@1) ", Val(txtBuscar), txtBuscar)
                        Else
                            If cmbBuscarEsteCampo = "NumeroRequerimiento" Then busq = Val(txtBuscar) Else busq = txtBuscar
                            Dim nombrecampo As String = cmbBuscarEsteCampo.Replace("[", "").Replace("]", "")
                            linqDinamico = db.wVistaDetRequerimientos.Where(nombrecampo & " = @0 ", busq)  'el filtro de columna lo hago con linq dinamico
                        End If

                    Catch ex As Exception
                        ' MsgBoxAjax(Me, "No se puede usar ese filtro")
                        linqDinamico = db.wVistaDetRequerimientos
                    End Try
                Else
                    linqDinamico = db.wVistaDetRequerimientos
                End If


                Dim bFiltraPeriodos As Boolean = False '  (Request.QueryString.Get("año") IsNot Nothing)


                'una vez que está filtrado, uso linq normal tipado
                Dim q = (From rm In linqDinamico _
                               Order By rm.NumeroRequerimiento Descending, rm.Item Ascending _
                         Skip startRowIndex Take maximumRows).ToList










                'dt = GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TXFecha, #7/1/2009#, #7/31/2009#, -1)
                'dt = GetStoreProcedure(HFSC.Value, enumSPs.wRequerimientos_TXFecha, TextoAFecha(txtFechaDesde.Text), TextoAFecha(txtFechahasta.Text), -1)
                'dt = q.ToDataTable
                dt = LogicaFacturacion.ToDataTableNull(q)

                Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
                With dc
                    .ColumnName = "ColumnaTilde"
                    .DataType = System.Type.GetType("System.Int32")
                    .DefaultValue = 0
                End With
                dt.Columns.Add(dc)


                With dt
                    .Columns("IdDetalleRequerimiento").ColumnName = "Id"
                    '    .Columns("Numero_Req_").ColumnName = "Numero"


                    '.Columns.Add("Presupuestos")
                    '.Columns.Add("Comparativas")
                    '.Columns.Add("Recepciones")
                    '.Columns.Add("Salidas")
                    '.Columns.Add("Pedidos")
                    '.Columns.Add("Fechas_de_liberacion_para_compras_por_item")
                    '.Columns.Add("Observaciones")
                    '.Columns.Add("Elim_firmas")

                End With

            End Using

            Return dt



        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As RequerimientoList
            'Return RequerimientoDB.GetList(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, _
                                       Optional txtBuscar As String = "", Optional cmbBuscarEsteCampo As String = "", _
                                       Optional fDesde As Date = #1/1/1900#, Optional fHasta As Date = #1/1/2100#, _
                                       Optional bFiltraPeriodos As Boolean = False) As Generic.List(Of wVistaRequerimiento) ' Object '   List(Of DataRow)


            'Dim txtBuscar As String = ""
            'Dim cmbBuscarEsteCampo As String = ""
            'Dim fDesde = #1/1/1900#, fHasta = #1/18/2100#


            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            'With dc
            '    .ColumnName = "ColumnaTilde"
            '    .DataType = System.Type.GetType("System.Int32")
            '    .DefaultValue = 0
            'End With
            If maximumRows = 0 Then maximumRows = 8

            Dim dt As DataTable


            '   Using 
            Dim db As New DataClasses2DataContext(Encriptar(SC))

            'http://stackoverflow.com/questions/2455659/how-to-use-contains-or-like-in-a-dynamic-linq-query
            'Dim linqDinamico = db.wVistaRequerimientos.Where(cmbBuscarEsteCampo.SelectedValue & ".Contains(@0)", Val(txtBuscar.Text))  'el filtro de columna lo hago con linq dinamico
            Dim linqDinamico As IQueryable(Of wVistaRequerimiento)

            If txtBuscar <> "" Then
                Dim busq
                If cmbBuscarEsteCampo = "Numero_Req_" Then busq = Val(txtBuscar) Else busq = txtBuscar
                Dim nombrecampo As String = cmbBuscarEsteCampo.Replace("[", "").Replace("]", "")

                Try
                    'linqDinamico = db.wVistaRequerimientos.Where(nombrecampo & " = @0 ", busq)  'el filtro de columna lo hago con linq dinamico
                    'linqDinamico = db.wVistaRequerimientos.Where(nombrecampo & " like ''")  'el filtro de columna lo hago con linq dinamico
                    linqDinamico = db.wVistaRequerimientos.Where("Convert.ToString(" & nombrecampo & ").Contains(@0) ", busq)  'el filtro de columna lo hago con linq dinamico
                    'And rm.Numero_Req_.ToString.StartsWith(txtBuscar.Text) _
                Catch ex As Exception
                    'MsgBoxAjax(Me, "No se puede usar ese filtro")
                    'linqDinamico = db.wVistaRequerimientos
                    ' linqDinamico = db.wVistaRequerimientos.Where(nombrecampo & ".StartsWith(@0) ", Val(busq))
                    linqDinamico = db.wVistaRequerimientos.Where(nombrecampo & " =@0 ", Val(busq))



                    '                        predicatebuilder()


                    '                        Dim pred = PredicateBuilder.True(Of wVistaRequerimientos)()

                    'pred = pred.And(Function(m As MyClass) m.SomeProperty = someValue)
                    'pred = pred.Or(Function(m As MyClass) m.SomeProperty = someValue)

                    '                        Dim predicate = PredicateBuilder.False(Of Integer)()
                    '                        predicate = predicate.Or(Function(q) q Mod 2 = 0)

                    '                        linqDinamico = db.wVistaRequerimientos.Where(predicate)
                End Try
            Else
                linqDinamico = db.wVistaRequerimientos
            End If




            'una vez que está filtrado, uso linq normal tipado
            Dim q As List(Of wVistaRequerimiento) = (From rm In linqDinamico _
                     Where (rm.fecha <= fHasta And rm.Fecha >= fDesde) _
                       And (Not bFiltraPeriodos Or If(rm.Cump_, "NO") <> "SI") _
                     Order By rm.Numero_Req_ Descending _
                       Skip startRowIndex Take maximumRows).ToList




            Return q
            'End Using


            'If q.Count = 0 Then Return Nothing
            'Dim dt = q.CopyToDataTable
            'With dt
            '    .Columns("IdPedido").ColumnName = "Id"
            '    .Columns("NumeroPedido").ColumnName = "Numero"
            '    .Columns("FechaPedido").ColumnName = "Fecha"
            'End With
            'Return dt

            'Dim dt = GeneralDB.TraerDatos(SC, "wPedidos_T", -1).Tables(0)
            'Dim a = dt.AsEnumerable.Take(8)
            'a.ToDataTable()

            'Try
            '    ds = GeneralDB.TraerDatos(SC, "wPedidos_T", -1)
            'Catch ex As Exception
            '    ds = GeneralDB.TraerDatos(SC, "Pedidos_T", -1)
            'End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres


            'ds.Tables(0).Columns.Add(dc)










        End Function

        Public Shared Function ItemsRequerimientosLiberadosParaComprar(ByVal SC As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, Optional txtBuscar As String = "", Optional cmbBuscarEsteCampo As String = "", Optional fDesde As Date = #1/1/1900#, Optional fHasta As Date = #1/1/2100#, Optional param1 As String = "", Optional param2 As String = "") As Object '   List(Of DataRow)

            'Dim txtBuscar As String = ""
            'Dim cmbBuscarEsteCampo As String = ""
            'Dim fDesde = #1/1/1900#, fHasta = #1/18/2100#


            Dim dt As DataTable
            Using db As New DataClasses2DataContext(Encriptar(SC))

                'http://stackoverflow.com/questions/2455659/how-to-use-contains-or-like-in-a-dynamic-linq-query
                'Dim linqDinamico = db.wVistaRequerimientos.Where(cmbBuscarEsteCampo.SelectedValue & ".Contains(@0)", Val(txtBuscar.Text))  'el filtro de columna lo hago con linq dinamico
                Dim linqDinamico As IQueryable(Of wVistaDetRequerimiento)

                If txtBuscar <> "" Then
                    Try
                        Dim busq As Object
                        If cmbBuscarEsteCampo Is Nothing Then
                            'cmbBuscarEsteCampo = "NumeroRequerimiento"
                            'busqueda genérica por default (no especificó columna)
                            linqDinamico = db.wVistaDetRequerimientos.Where("NumeroRequerimiento = @0 OR Articulo.Contains(@1) ", Val(txtBuscar), txtBuscar)
                        Else
                            If cmbBuscarEsteCampo = "NumeroRequerimiento" Then busq = Val(txtBuscar) Else busq = txtBuscar
                            Dim nombrecampo As String = cmbBuscarEsteCampo.Replace("[", "").Replace("]", "")
                            If IsDate(busq) Then busq = CDate(busq)



                            Dim cab = From i In db.wVistaRequerimientos
                            Dim cabfiltrado = cab
                            Try
                                cabfiltrado = cab.Where(nombrecampo & ".Contains(@0) ", busq)
                            Catch ex As Exception
                                cabfiltrado = cab
                            End Try



                            Dim l = (From det In db.wVistaDetRequerimientos _
                                     Join cabs In cabfiltrado On cabs.IdRequerimiento Equals det.IdRequerimiento _
                                     Select det _
                                     )
                            '.Where(Function(i) i.IdRequerimiento=DetailsView.).DefaultIfEmpty _
                            'On cab.IdRequerimiento Equals det.IdRequerimiento)
                            Try
                                linqDinamico = l.Where(nombrecampo & " = @0 ", busq)
                            Catch ex As Exception
                                linqDinamico = l
                            End Try
                            ' linqDinamico = db.wVistaDetRequerimientos.Where(nombrecampo & " = @0 ", busq)  'el filtro de columna lo hago con linq dinamico
                        End If

                    Catch ex As Exception
                        ' MsgBoxAjax(Me, "No se puede usar ese filtro")
                        linqDinamico = db.wVistaDetRequerimientos
                    End Try
                Else
                    linqDinamico = db.wVistaDetRequerimientos
                End If


                Dim bFiltraPeriodos As Boolean = False '  (Request.QueryString.Get("año") IsNot Nothing)


                If param1 = "Cont" Then Return linqDinamico.Count


                'una vez que está filtrado, uso linq normal tipado
                Dim q = (From det In linqDinamico Join cab In db.wVistaRequerimientos On cab.IdRequerimiento Equals det.IdRequerimiento _
                               Where cab.Liberada_por <> "" And det.Cump <> "SI" And If(cab.Cump_, "") <> "SI" _
                               Order By det.NumeroRequerimiento Descending, det.Item Ascending _
                         Skip startRowIndex Take maximumRows _
                            Select _
                                det.IdDetalleRequerimiento, _
                                det.NumeroRequerimiento, _
                                det.IdArticulo, _
                                det.Articulo, _
                                det.Item, _
                                det.Cant_, _
                                det.Unidad_en, _
                                det.CantidadRecibida, _
                                det.F_entrega, _
                                det.Cump, _
                                cab.Obra, _
                                MontoPrevisto = 0, _
                                MontoParaCompra = 0, _
                                cab.Comprador, _
                                NumeroLMateriales = 0, _
                                NumeroOrden = 0, _
                                CantidadEnStock = 0, _
                               cab.Fecha, _
                               cab.Solicitada_por, _
                               cab.Equipo_destino, _
                               Observaciones = "", _
                               FechaAsignacionComprador = "", _
                               cab.Tipo_compra, _
                                cab._2da_Firma, _
                                cab.Sector _
                            ).DefaultIfEmpty.ToList

                '_


                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                ' exec Requerimientos_TX_PendientesDeFirma 
                ' exec(Requerimientos_TX_Pendientes1) 'T'
                ' exec(Requerimientos_TX_Pendientes1) 'P'


                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                'PENDIENTES DE FIRMA
                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////

                Select Case param1
                    Case "Pendiente"
                    Case "Todos"
                    Case "A la firma"
                        'q = q.Where("")
                    Case Else
                End Select

                '                Where()
                ' ((@FirmasLiberacion=1 and Requerimientos.Aprobo is not null) or (@FirmasLiberacion>1 and Requerimientos.Aprobo2 is not null)) and   
                ' IsNull(DetReq.Cumplido,'NO')<>'SI' and IsNull(DetReq.Cumplido,'NO')<>'AN' and   
                ' IsNull(Requerimientos.Cumplido,'NO')<>'SI' and IsNull(Requerimientos.Cumplido,'NO')<>'AN' and   
                ' IsNull(Requerimientos.Confirmado,'SI')='SI' and   
                ' Not Exists(Select * From AutorizacionesPorComprobante  
                '     Where AutorizacionesPorComprobante.IdFormulario=3 and   
                '    AutorizacionesPorComprobante.IdComprobante=DetReq.IdRequerimiento)  
                'ORDER BY DetReq.FechaEntrega, Requerimientos.NumeroRequerimiento, DetReq.NumeroItem  
                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////



                'MontoPrevisto" HeaderText="Monto prev." />
                'MontoParaCompra" HeaderText="Monto comp." />
                'Nombre" HeaderText="Comprador" />
                'NumeroLMateriales" HeaderText="L.Mat." />
                'NumeroOrden" HeaderText="Itm.LM" />
                'CantidadEnStock" HeaderText="En stock" />
                'StockMinimo" HeaderText="Stk.min." />
                'F_entrega" HeaderText="F.entrega" />
                'Nombre" HeaderText="Solicito" />
                'Descripcion" HeaderText="Obra" />
                'Tag" HeaderText="Equipo" />
                'Descripcion" HeaderText="Cuenta contable" />

                'Observaciones" HeaderText="Observaciones item" />
                'FechaAsignacionComprador" HeaderText="[Fec.Asig.Comprador]" />
                'Observaciones" HeaderText="Tipo compra" />
                'Descripcion" HeaderText="[2da.Firma" />
                'Nombre
                'Descripcion" HeaderText="Sector" />








                'dt = GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TXFecha, #7/1/2009#, #7/31/2009#, -1)
                'dt = GetStoreProcedure(HFSC.Value, enumSPs.wRequerimientos_TXFecha, TextoAFecha(txtFechaDesde.Text), TextoAFecha(txtFechahasta.Text), -1)
                'dt = q.ToDataTable
                dt = LogicaFacturacion.ToDataTableNull(q)

                Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
                With dc
                    .ColumnName = "ColumnaTilde"
                    .DataType = System.Type.GetType("System.Int32")
                    .DefaultValue = 0
                End With
                dt.Columns.Add(dc)

                Try
                    With dt
                        .Columns("IdDetalleRequerimiento").ColumnName = "Id"
                        '    .Columns("Numero_Req_").ColumnName = "Numero"


                        '.Columns.Add("Presupuestos")
                        '.Columns.Add("Comparativas")
                        '.Columns.Add("Recepciones")
                        '.Columns.Add("Salidas")
                        '.Columns.Add("Pedidos")
                        '.Columns.Add("Fechas_de_liberacion_para_compras_por_item")
                        '.Columns.Add("Observaciones")
                        '.Columns.Add("Elim_firmas")

                    End With
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try


            End Using

            Return dt



        End Function


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_IntentonaAbortadaConIQueryablePorRecomendacionPopular(ByVal SC As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, Optional txtBuscar As String = "", Optional cmbBuscarEsteCampo As String = "", Optional fDesde As Date = #1/1/1900#, Optional fHasta As Date = #1/1/2100#, Optional bFiltraPeriodos As Boolean = False) As IQueryable(Of wVistaRequerimiento) ' Object '   List(Of DataRow)


            'Dim txtBuscar As String = ""
            'Dim cmbBuscarEsteCampo As String = ""
            'Dim fDesde = #1/1/1900#, fHasta = #1/18/2100#


            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            'With dc
            '    .ColumnName = "ColumnaTilde"
            '    .DataType = System.Type.GetType("System.Int32")
            '    .DefaultValue = 0
            'End With
            If maximumRows = 0 Then maximumRows = 8

            Dim dt As DataTable


            '   Using 
            Dim db As New DataClasses2DataContext(Encriptar(SC))

            'http://stackoverflow.com/questions/2455659/how-to-use-contains-or-like-in-a-dynamic-linq-query
            'Dim linqDinamico = db.wVistaRequerimientos.Where(cmbBuscarEsteCampo.SelectedValue & ".Contains(@0)", Val(txtBuscar.Text))  'el filtro de columna lo hago con linq dinamico
            Dim linqDinamico As IQueryable(Of wVistaRequerimiento)

            If txtBuscar <> "" Then
                Dim busq
                If cmbBuscarEsteCampo = "Numero_Req_" Then busq = Val(txtBuscar) Else busq = txtBuscar
                Dim nombrecampo As String = cmbBuscarEsteCampo.Replace("[", "").Replace("]", "")

                Try
                    'linqDinamico = db.wVistaRequerimientos.Where(nombrecampo & " = @0 ", busq)  'el filtro de columna lo hago con linq dinamico
                    'linqDinamico = db.wVistaRequerimientos.Where(nombrecampo & " like ''")  'el filtro de columna lo hago con linq dinamico
                    linqDinamico = db.wVistaRequerimientos.Where("Convert.ToString(" & nombrecampo & ").Contains(@0) ", busq)  'el filtro de columna lo hago con linq dinamico
                    'And rm.Numero_Req_.ToString.StartsWith(txtBuscar.Text) _
                Catch ex As Exception
                    'MsgBoxAjax(Me, "No se puede usar ese filtro")
                    'linqDinamico = db.wVistaRequerimientos
                    ' linqDinamico = db.wVistaRequerimientos.Where(nombrecampo & ".StartsWith(@0) ", Val(busq))
                    linqDinamico = db.wVistaRequerimientos.Where(nombrecampo & " =@0 ", Val(busq))



                    '                        predicatebuilder()


                    '                        Dim pred = PredicateBuilder.True(Of wVistaRequerimientos)()

                    'pred = pred.And(Function(m As MyClass) m.SomeProperty = someValue)
                    'pred = pred.Or(Function(m As MyClass) m.SomeProperty = someValue)

                    '                        Dim predicate = PredicateBuilder.False(Of Integer)()
                    '                        predicate = predicate.Or(Function(q) q Mod 2 = 0)

                    '                        linqDinamico = db.wVistaRequerimientos.Where(predicate)
                End Try
            Else
                linqDinamico = db.wVistaRequerimientos
            End If




            'una vez que está filtrado, uso linq normal tipado
            Dim q As IQueryable(Of wVistaRequerimiento) = (From rm In linqDinamico _
                     Where (rm.fecha <= fHasta And rm.Fecha >= fDesde) _
                       And (Not bFiltraPeriodos Or If(rm.Cump_, "NO") <> "SI") _
                     Order By rm.Numero_Req_ Descending _
                       Skip startRowIndex Take maximumRows) ' .ToList




            Return q
            'End Using


            'If q.Count = 0 Then Return Nothing
            'Dim dt = q.CopyToDataTable
            'With dt
            '    .Columns("IdPedido").ColumnName = "Id"
            '    .Columns("NumeroPedido").ColumnName = "Numero"
            '    .Columns("FechaPedido").ColumnName = "Fecha"
            'End With
            'Return dt

            'Dim dt = GeneralDB.TraerDatos(SC, "wPedidos_T", -1).Tables(0)
            'Dim a = dt.AsEnumerable.Take(8)
            'a.ToDataTable()

            'Try
            '    ds = GeneralDB.TraerDatos(SC, "wPedidos_T", -1)
            'Catch ex As Exception
            '    ds = GeneralDB.TraerDatos(SC, "Pedidos_T", -1)
            'End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres


            'ds.Tables(0).Columns.Add(dc)










        End Function

        Public Shared Function GetItemsRequerimientoPendientes_Count(ByVal SC As String, Optional txtBuscar As String = "", Optional cmbBuscarEsteCampo As String = "", Optional fDesde As Date = #1/1/1900#, Optional fHasta As Date = #1/1/2100#, Optional param1 As String = "", Optional param2 As String = "") As Integer 'es importante que sea un Integer y no un Long
            Dim i As Long = EntidadManager.ExecDinamico(SC, "select count(*) from Pedidos").Rows(0).Item(0)

            i = ItemsRequerimientosLiberadosParaComprar(SC, 0, 99999, txtBuscar, cmbBuscarEsteCampo, fDesde, fHasta, "Cont", param2)

            Return i
        End Function
    End Class
End Namespace