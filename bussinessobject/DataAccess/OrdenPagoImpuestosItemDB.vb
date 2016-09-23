Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Namespace Pronto.ERP.Dal

    Public Class OrdenPagoImpuestosItemDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As OrdenPagoImpuestosItem
            Dim myOrdenPagoItem As OrdenPagoImpuestosItem = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.DetOrdenesPagoImpuestos_T.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleOrdenPago", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myOrdenPagoItem = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myOrdenPagoItem
        End Function

        Public Shared Function GetList(ByVal SC As String, ByVal IdOrdenPago As Integer) As OrdenPagoImpuestosItemList
            Dim tempList As OrdenPagoImpuestosItemList = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                'DetOrdenPagos_TX_PorIdCabecera    trae los nombres como en la base
                'DetOrdenPagos_TXDeb               formatea para la grilla, con las descripciones de los ids (pero sin algunos ids)

                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.DetOrdenesPagoImpuestos_TXOrdenPago.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdOrdenPago", IdOrdenPago)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    tempList = New OrdenPagoImpuestosItemList
                    If myReader.HasRows Then
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

        Public Shared Function Save(ByVal SC As String, ByVal myOrdenPagoItem As OrdenPagoImpuestosItem) As Integer
            Dim result As Integer = 0

            With myOrdenPagoItem
                'If Not .Eliminado Then
                Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                Try

                    Dim myCommand As SqlCommand

                    If True Then '.Nuevo Then

                        myCommand = New SqlCommand(enumSPs.DetOrdenesPagoImpuestos_A.ToString, myConnection)
                        myCommand.CommandType = CommandType.StoredProcedure

                        Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdDetalleOrdenPagoImpuestos", -1)
                        param.Direction = ParameterDirection.Output

                    Else

                        myCommand = New SqlCommand(enumSPs.DetOrdenesPagoImpuestos_M.ToString, myConnection)
                        myCommand.CommandType = CommandType.StoredProcedure

                        myCommand.Parameters.AddWithValue("@IdDetalleOrdenPagoImpuestos", .Id)
                    End If


                    NETtoSQL(myCommand, "IdOrdenPago", .IdOrdenPago)
                    NETtoSQL(myCommand, "@TipoImpuesto", .TipoImpuesto)
                    NETtoSQL(myCommand, "@IdTipoRetencionGanancia", .IdTipoRetencionGanancia)
                    NETtoSQL(myCommand, "@ImportePagado", .ImportePagado)
                    NETtoSQL(myCommand, "@ImpuestoRetenido", .ImpuestoRetenido)
                    NETtoSQL(myCommand, "@IdIBCondicion", .IdIBCondicion)
                    NETtoSQL(myCommand, "@NumeroCertificadoRetencionGanancias", .NumeroCertificadoRetencionGanancias)
                    NETtoSQL(myCommand, "@NumeroCertificadoRetencionIIBB", .NumeroCertificadoRetencionIIBB)
                    NETtoSQL(myCommand, "@AlicuotaAplicada", .AlicuotaAplicada)
                    NETtoSQL(myCommand, "@AlicuotaConvenioAplicada", .AlicuotaConvenioAplicada)
                    NETtoSQL(myCommand, "@PorcentajeATomarSobreBase", .PorcentajeATomarSobreBase)
                    NETtoSQL(myCommand, "@PorcentajeAdicional", .PorcentajeAdicional)
                    NETtoSQL(myCommand, "@ImpuestoAdicional", .ImpuestoAdicional)
                    NETtoSQL(myCommand, "@LeyendaPorcentajeAdicional", .LeyendaPorcentajeAdicional)
                    NETtoSQL(myCommand, "@ImporteTotalFacturasMPagadasSujetasARetencion", .ImporteTotalFacturasMPagadasSujetasARetencion)


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
                'Else
                'If Not myOrdenPagoItem.Nuevo Then Delete(SC, myOrdenPagoItem.Id)
                'End If
                Return result
            End With
        End Function

        Public Shared Function Delete(ByVal SC As String, ByVal id As Integer) As Boolean
            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wDetOrdenPagos_E", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdDetalleOrdenPago", id)
                myConnection.Open()
                result = myCommand.ExecuteNonQuery
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result > 0
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As OrdenPagoImpuestosItem
            Dim myOrdenPagoItem As OrdenPagoImpuestosItem = New OrdenPagoImpuestosItem
            With myOrdenPagoItem
                


                SQLtoNET(.Id, "IdDetalleOrdenPagoImpuestos", myDataRecord)
                SQLtoNET(myDataRecord, "IdOrdenPago", .IdOrdenPago)
                SQLtoNET(myDataRecord, "Tipo", .TipoImpuesto)

                'SQLtoNET(myDataRecord, "IdTipoImpuesto", .idtipoImpuesto)
                SQLtoNET(myDataRecord, "Categoria", .Categoria)
                SQLtoNET(myDataRecord, "Pago s/imp.", .ImportePagado)
                SQLtoNET(myDataRecord, "Retencion", .ImpuestoRetenido)
                SQLtoNET(myDataRecord, "Pagos mes", .PagosMes)
                SQLtoNET(myDataRecord, "Ret. mes", .RetencionesMes)
                SQLtoNET(myDataRecord, "Min.IIBB", .MinimoIIBB)
                SQLtoNET(myDataRecord, "Alicuota.IIBB", .AlicuotaIIBB)
                SQLtoNET(myDataRecord, "Alicuota Conv.Mul.", .AlicuotaConvenioAplicada)
                SQLtoNET(myDataRecord, "% a tomar s/base", .PorcentajeATomarSobreBase)
                SQLtoNET(myDataRecord, "% adic.", .PorcentajeAdicional)
                SQLtoNET(myDataRecord, "Impuesto adic.", .ImpuestoAdicional)
                SQLtoNET(myDataRecord, "Certif.Gan.", .NumeroCertificadoRetencionGanancias)
                SQLtoNET(myDataRecord, "Certif.IIBB", .NumeroCertificadoRetencionIIBB)
                SQLtoNET(myDataRecord, "Tot.Fact.M a Ret.", ._ImporteTotalFacturasMPagadasSujetasARetencion)


                'SQLtoNET(myDataRecord, "@IdTipoRetencionGanancia", .IdTipoRetencionGanancia)
                'SQLtoNET(myDataRecord, "@ImportePagado", .ImportePagado)
                'SQLtoNET(myDataRecord, "@ImpuestoRetenido", .ImpuestoRetenido)
                'SQLtoNET(myDataRecord, "@IdIBCondicion", .IdIBCondicion)
                'SQLtoNET(myDataRecord, "@NumeroCertificadoRetencionGanancias", .NumeroCertificadoRetencionGanancias)
                'SQLtoNET(myDataRecord, "@NumeroCertificadoRetencionIIBB", .NumeroCertificadoRetencionIIBB)
                'SQLtoNET(myDataRecord, "@AlicuotaAplicada", .AlicuotaAplicada)
                'SQLtoNET(myDataRecord, "@AlicuotaConvenioAplicada", .AlicuotaConvenioAplicada)
                'SQLtoNET(myDataRecord, "@PorcentajeATomarSobreBase", .PorcentajeATomarSobreBase)
                'SQLtoNET(myDataRecord, "@PorcentajeAdicional", .PorcentajeAdicional)
                'SQLtoNET(myDataRecord, "@ImpuestoAdicional", .ImpuestoAdicional)
                'SQLtoNET(myDataRecord, "@LeyendaPorcentajeAdicional", .LeyendaPorcentajeAdicional)
                'SQLtoNET(myDataRecord, "@ImporteTotalFacturasMPagadasSujetasARetencion", .ImporteTotalFacturasMPagadasSujetasARetencion)


                Return myOrdenPagoItem
            End With
        End Function

    End Class
End Namespace