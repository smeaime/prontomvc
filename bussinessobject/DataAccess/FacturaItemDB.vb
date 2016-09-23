Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class FacturaItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As FacturaItem
            Dim myFacturaItem As FacturaItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetFacturas_T", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleFactura", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myFacturaItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myFacturaItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdFactura As Integer) As FacturaItemList
            Dim tempList As FacturaItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("DetFacturas_TX_PorIdCabecera", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdFactura", IdFactura)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.HasRows Then
                        tempList = New FacturaItemList
                        While myReader.Read
                            tempList.Add(FillDataRecord(myReader))
                        End While
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return tempList
        End Function

        Public Shared Function Save(ByVal SC As String, ByVal myFacturaItem As FacturaItem) As Integer
            Dim result As Integer = 0
            With myFacturaItem
                If Not .Eliminado Then
                    Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                    Try

                        Dim myCommand As SqlCommand

                        If .Nuevo Then

                            myCommand = New SqlCommand("DetFacturas_A", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleFactura", -1)
                            param.Direction = ParameterDirection.Output

                        Else

                            myCommand = New SqlCommand("DetFacturas_M", myConnection)
                            myCommand.CommandType = CommandType.StoredProcedure

                            myCommand.Parameters.AddWithValue("@IdDetalleFactura", .Id)
                        End If



                        NETtoSQL(myCommand, "@IdFactura", .IdFactura)
                        NETtoSQL(myCommand, "@NumeroFactura", .NumeroFactura)
                        NETtoSQL(myCommand, "@TipoABC", .TipoABC)
                        NETtoSQL(myCommand, "@PuntoVenta", .PuntoVenta)
                        NETtoSQL(myCommand, "@IdArticulo", .IdArticulo)
                        NETtoSQL(myCommand, "@CodigoArticulo", .CodigoArticulo)
                        NETtoSQL(myCommand, "@Cantidad", .Cantidad)
                        NETtoSQL(myCommand, "@Costo", .Costo)
                        NETtoSQL(myCommand, "@PrecioUnitario", .Precio)
                        NETtoSQL(myCommand, "@Bonificacion", .Bonificacion)
                        NETtoSQL(myCommand, "@IdDetalleRemito", .IdDetalleRemito)
                        NETtoSQL(myCommand, "@ParteDolar", .ParteDolar)
                        NETtoSQL(myCommand, "@PartePesos", .PartePesos)
                        NETtoSQL(myCommand, "@PorcentajeCertificacion", .PorcentajeCertificacion)
                        NETtoSQL(myCommand, "@OrigenDescripcion", .OrigenDescripcion)
                        NETtoSQL(myCommand, "@TipoCancelacion", .TipoCancelacion)
                        NETtoSQL(myCommand, "@IdUnidad", .IdUnidad)
                        NETtoSQL(myCommand, "@PrecioUnitarioTotal", .PrecioUnitarioTotal)
                        NETtoSQL(myCommand, "@Observaciones", .Observaciones)
                        NETtoSQL(myCommand, "@NotaAclaracion", .NotaAclaracion)
                        NETtoSQL(myCommand, "@EnviarEmail", .EnviarEmail)
                        NETtoSQL(myCommand, "@IdOrigenTransmision", .IdOrigenTransmision)
                        NETtoSQL(myCommand, "@IdFacturaOriginal", .IdFacturaOriginal)
                        NETtoSQL(myCommand, "@IdDetalleFacturaOriginal", .IdDetalleFacturaOriginal)
                        NETtoSQL(myCommand, "@FechaImportacionTransmision", .FechaImportacionTransmision)


                        Dim returnValue As DbParameter
                        returnValue = myCommand.CreateParameter
                        returnValue.Direction = ParameterDirection.ReturnValue
                        myCommand.Parameters.Add(returnValue)
                        myConnection.Open()
                        myCommand.ExecuteNonQuery()
                        result = Convert.ToInt32(returnValue.Value)
                        myConnection.Close()
                    Finally
                        CType(myConnection, IDisposable).Dispose()
                    End Try
                Else
                    If Not myFacturaItem.Nuevo Then Delete(SC, myFacturaItem.Id)
                End If
            End With
            Return result
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetFacturas_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleFactura", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As FacturaItem
            Dim myFacturaItem As FacturaItem = New FacturaItem
            


            With myFacturaItem
                SQLtoNET(myDataRecord, "@IdDetalleFactura", .Id)




                SQLtoNET(myDataRecord, "@NumeroFactura", .NumeroFactura)
                SQLtoNET(myDataRecord, "@TipoABC", .TipoABC)
                SQLtoNET(myDataRecord, "@PuntoVenta", .PuntoVenta)
                SQLtoNET(myDataRecord, "@IdArticulo", .IdArticulo)
                SQLtoNET(myDataRecord, "@CodigoArticulo", .CodigoArticulo)
                SQLtoNET(myDataRecord, "@Cantidad", .Cantidad)
                SQLtoNET(myDataRecord, "@Costo", .Costo)
                SQLtoNET(myDataRecord, "@PrecioUnitario", .Precio)
                SQLtoNET(myDataRecord, "@Bonificacion", .Bonificacion)
                SQLtoNET(myDataRecord, "@IdDetalleRemito", .IdDetalleRemito)
                SQLtoNET(myDataRecord, "@ParteDolar", .ParteDolar)
                SQLtoNET(myDataRecord, "@PartePesos", .PartePesos)
                SQLtoNET(myDataRecord, "@PorcentajeCertificacion", .PorcentajeCertificacion)
                SQLtoNET(myDataRecord, "@OrigenDescripcion", .OrigenDescripcion)
                SQLtoNET(myDataRecord, "@TipoCancelacion", .TipoCancelacion)
                SQLtoNET(myDataRecord, "@IdUnidad", .IdUnidad)
                SQLtoNET(myDataRecord, "@PrecioUnitarioTotal", .PrecioUnitarioTotal)
                SQLtoNET(myDataRecord, "@Observaciones", .Observaciones)
                SQLtoNET(myDataRecord, "@NotaAclaracion", .NotaAclaracion)
                SQLtoNET(myDataRecord, "@EnviarEmail", .EnviarEmail)
                SQLtoNET(myDataRecord, "@IdOrigenTransmision", .IdOrigenTransmision)
                SQLtoNET(myDataRecord, "@IdFacturaOriginal", .IdFacturaOriginal)
                SQLtoNET(myDataRecord, "@IdDetalleFacturaOriginal", .IdDetalleFacturaOriginal)
                SQLtoNET(myDataRecord, "@FechaImportacionTransmision", .FechaImportacionTransmision)

                

            End With


            Return myFacturaItem
        End Function
    End Class
End Namespace