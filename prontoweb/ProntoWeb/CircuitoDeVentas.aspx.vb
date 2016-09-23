Imports System.IO

Imports CartaDePorteManager

Partial Class CircuitoDeVentas
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Dim FilePath As String = lnkAdjunto1.Text  'si lo grabó el pronto, va a venir con el directorio original...
        If Not IsPostBack Then 'es decir, si es la primera vez que se carga

            Dim FileName As String = System.IO.Path.GetFileName("\")
            Dim MyFile As New FileInfo("Debug.bat")
            'If MyFile.Exists Then
            If ConfigurationManager.AppSettings("Debug") = "SI" Then
                Button1.Visible = True
                Button2.Visible = True
                Button3.Visible = True
                Button8.Visible = True
            Else
                Button1.Visible = False
                Button2.Visible = False
                Button3.Visible = False
                Button8.Visible = False
            End If

            Try
                If InStr(Pronto.ERP.Bll.ErrHandler2.WriteError("Prueba"), "Error") = 0 Then
                    MsgBoxAjax(Me, "El directorio de log de errores no está habilitado")
                End If
            Catch ex As Exception
                MsgBoxAjax(Me, "El directorio de log de errores no está habilitado")
            End Try


            'debug
            'Dim usuario As Usuario
            'Dim sc As String
            'usuario = New Usuario
            'usuario = session(SESSIONPRONTO_USUARIO)
            'sc = usuario.StringConnection
            'Dim depurandoRM As Pronto.ERP.BO.RequerimientoList = Pronto.ERP.Bll.RequerimientoManager.GetList(sc)
            'Dim depurandoPED As Pronto.ERP.BO.PedidoList = Pronto.ERP.Bll.PedidoManager.GetList(sc)
            'Dim depurandoPRE As Pronto.ERP.BO.PresupuestoList = Pronto.ERP.Bll.PresupuestoManager.GetList(sc)
            'Dim depurandoCOMP As Pronto.ERP.BO.ComparativaList = Pronto.ERP.Bll.ComparativaManager.GetList(sc)






        End If


    End Sub


    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    ' Links de mapa de ventas 
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////


    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton2.Click
        Response.Redirect(String.Format("frmConsultaRMsPendientesDeAsignacion.aspx?Id=-1"))
    End Sub

    Protected Sub LinkButton3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton3.Click
        Response.Redirect(String.Format("Presupuesto.aspx?Id=-1"))
    End Sub



    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        Response.Redirect(String.Format("Requerimiento.aspx?Id=-1"))
    End Sub

    Protected Sub LinkButton5_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton5.Click
        Response.Redirect(String.Format("Pedido.aspx?Id=-1"))
    End Sub


    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    ' Tests 
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////


    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        'Tests.Firmas(sc, Session)
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        'Tests.TestFondoFijo(sc, Session)
    End Sub

    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        'Tests.TestSolicitudes(sc, Session)
    End Sub

    Protected Sub Button8_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button8.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        'Tests.Firmas(sc, Session)
        'Tests.TestFondoFijo(sc, Session)
        'Tests.TestSolicitudes(sc, Session)
    End Sub








    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection

        'Tests.ImportarArticulosWilliams(sc)
        'Tests.ImportarHumedadesWilliams(sc)
        'Tests.ImportarChoferesWilliams(sc)
        'Tests.ImportarTransportistasWilliams(sc)
        'Tests.ImportarCalidadesWilliams(sc)
        'Tests.ImportarLocalidadesWilliams(sc)
    End Sub

    Protected Sub LinkButton6_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton6.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        Tests.TestVentas_OC_REM_FAC_REC_CNSapag(Me, sc, Session)
    End Sub

    Protected Sub lnkTest_OC_REM_FAC_REC_Equimac_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkTest_OC_REM_FAC_REC_Equimac.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        Tests.TestVentas_OC_REM_FAC_REC_Equimac(Me, sc, Session)
    End Sub


    Protected Sub LinkButton7_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton7.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        Tests.TestVentas_NC_ND_CNSapag(Me, sc, Session)


    End Sub

    Protected Sub LinkButton9_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton9.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        Tests.TestVentas_NC_ND_Equimac(Me, sc, Session)
    End Sub

    Protected Sub lnkTest_FAC_Equimac_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkTest_FAC_Equimac.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        Tests.TestVentas_FAC_Equimac(Me, sc, Session)
    End Sub
End Class
