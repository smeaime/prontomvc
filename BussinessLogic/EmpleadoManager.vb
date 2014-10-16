Imports System
Imports System.ComponentModel
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Xml.Linq
Imports System.Linq
Imports System.Data.Linq

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    Public Class EmpleadoManager
        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As EmpleadoList
            Return EmpleadoDB.GetList(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return EmpleadoDB.GetList_fm(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListCombo(ByVal SC As String) As System.Data.DataSet
            Return GeneralDB.TraerDatos(SC, "wEmpleados_TL")
        End Function


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListComboSectorCompras(ByVal SC As String) As System.Data.DataSet
            Return EntidadManager.GetListTX(SC, "Empleados", "TX_PorSector", "Compras", "", "")
        End Function


        Shared Function GetListUsuariosQuePuedenAnularFacturas(ByVal sConexBDLmaster As String) As Object
            Dim db As LinqBDLmasterDataContext = New LinqBDLmasterDataContext(Encriptar(sConexBDLmaster))

            '       
            Dim q = From p In db.DetalleUserPermisos _
                    Join e In db.aspnet_Users On p.UserId Equals e.UserId _
                    Where p.Modulo = "Facturas" And p.PuedeModificar _
                    Select e.UserId, e.UserName

            Return q
        End Function




        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Empleado
            Return EmpleadoDB.GetItem(SC, id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Update Or DataObjectMethodType.Insert, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myEmpleado As Empleado) As Integer
            If myEmpleado.UsuarioNT = "" Then
                Throw New Exception("Nombre de usuario vacío")
            End If
            If myEmpleado.Nombre = "" Then
                Throw New Exception("Nombre de usuario vacío")
            End If
            'If myEmpleado.PuntoVentaAsociado Then
            '    Throw New Exception()
            'End If

            myEmpleado.Id = EmpleadoDB.Save(SC, myEmpleado)
            Return myEmpleado.Id
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myEmpleado As Empleado) As Boolean
            Return EmpleadoDB.Delete(SC, myEmpleado.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function HaveAccess(ByVal SC As String, ByVal UserName As String, ByVal Nodo As String) As Boolean
            Return EmpleadoDB.HaveAccess(SC, UserName, Nodo)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function GetEmployeeByName(ByVal SC As String, ByVal UserName As String) As Empleado
            Return EmpleadoDB.GetEmployeeByName(SC, UserName)
        End Function

    End Class

End Namespace