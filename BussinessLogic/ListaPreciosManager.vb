Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports Pronto.ERP.Bll.EntidadManager
Imports System.Data

Imports System.Data.SqlClient
Namespace Pronto.ERP.Bll


    <Serializable()> Public Class ListasPreciosDetalle
        Public Descripcion As String
        Public Emails As String

        Public FechaDesde As Date
        Public FechaHasta As Date

        Public EsPosicion As String

        Public Enviar As String
        Public EsMailOesFax As String

        Public Orden As Integer
        Public Modo As String

        Public AplicarANDuORalFiltro As String
        Public Vendedor As Integer
        Public CuentaOrden1 As Integer
        Public CuentaOrden2 As Integer
        Public Corredor As Integer
        Public Entregador As Integer

        Public IdArticulo As Integer
        Public Contrato As Integer

        Public Destino As Integer
        Public Procedencia As Integer
    End Class

    Public Class ListasPreciosItemManager

        Const Tabla = "ListasPreciosDetalle"

        '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx


        Public Shared Function TraerMetadata(ByVal SC As String, Optional ByVal id As Integer = -1) As DataTable
            If id = -1 Then
                Return ExecDinamico(SC, "select * from  " & Tabla & "  where 1=0")
            Else
                Return ExecDinamico(SC, "select * from  " & Tabla & "  where idListaPreciosDetalle=" & id)
            End If
        End Function

        Public Shared Function Insert(ByVal SC As String, ByVal dt As DataTable) As Integer
            '// Write your own Insert statement blocks 


            'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
            ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
            'y esto? http://www.vbforums.com/showthread.php?t=352219


            ''convertir datarow en datatable
            'Dim ds As New DataSet
            'ds.Tables.Add(dr.Table.Clone())
            'ds.Tables(0).ImportRow(dr)

            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            myConnection.Open()

            Dim adapterForTable1 = New SqlDataAdapter("select * from  " & Tabla & " ", myConnection)
            Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
            adapterForTable1.Update(dt)

        End Function




        Public Shared Function Fetch(ByVal SC As String, ByVal IdLista As Integer) As DataTable

            Return ExecDinamico(SC, String.Format("SELECT IdListaPreciosDetalle,IdListaPrecios,Precio,A.IdArticulo, " & _
                                " Articulos.Descripcion as Producto, A.* ," & _
                                " LOCDES.Descripcion as DestinoDesc " & _
                                " FROM " & Tabla & " A " & _
                                " LEFT OUTER JOIN WilliamsDestinos LOCDES ON IdDestinoDeCartaDePorte = LOCDES.IdWilliamsDestino " & _
                                " LEFT OUTER JOIN Articulos ON A.IdArticulo = Articulos.IdArticulo  WHERE IdListaPrecios=" & IdLista & _
                                ""))

        End Function


        Public Shared Function Update(ByVal SC As String, ByVal dt As DataTable) As Integer
            '// Write your own Insert statement blocks 


            'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
            ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
            'y esto? http://www.vbforums.com/showthread.php?t=352219


            ''convertir datarow en datatable
            'Dim ds As New DataSet
            'ds.Tables.Add(dr.Table.Clone())
            'ds.Tables(0).ImportRow(dr)

            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            myConnection.Open()

            Dim adapterForTable1 = New SqlDataAdapter("select * from  " & Tabla & " ", myConnection)
            Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
            'si te tira error acá, ojito con estar usando el dataset q usaste para el 
            'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update

            adapterForTable1.Update(dt)

        End Function



        Public Shared Function Delete(ByVal SC As String, ByVal Id As Long)
            '// Write your own Delete statement blocks. 
            ExecDinamico(SC, String.Format("DELETE  " & Tabla & "  WHERE IdListaPreciosDetalle={0}", Id))
        End Function


    End Class





    <Serializable()> Public Class ListaPrecios
        Public Descripcion As String
        Public Emails As String

        Public FechaDesde As Date
        Public FechaHasta As Date

        Public EsPosicion As String

        Public Enviar As String
        Public EsMailOesFax As String

        Public Orden As Integer
        Public Modo As String

        Public AplicarANDuORalFiltro As String
        Public Vendedor As Integer
        Public CuentaOrden1 As Integer
        Public CuentaOrden2 As Integer
        Public Corredor As Integer
        Public Entregador As Integer

        Public IdArticulo As Integer
        Public Contrato As Integer

        Public Destino As Integer
        Public Procedencia As Integer
    End Class

    Public Class ListaPreciosManager



        Const Tabla = "ListasPrecios"

        '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx


        Public Shared Function TraerMetadata(ByVal SC As String, Optional ByVal id As Integer = -1) As DataTable
            If id = -1 Then
                Return ExecDinamico(SC, "select * from  " & Tabla & "  where 1=0")
            Else
                Return ExecDinamico(SC, "select * from  " & Tabla & "  where idListaPrecios=" & id)
            End If
        End Function

        Public Shared Function Insert(ByVal SC As String, ByRef dt As DataTable) As Integer
            '// Write your own Insert statement blocks 


            'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
            ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
            'y esto? http://www.vbforums.com/showthread.php?t=352219


            ''convertir datarow en datatable
            'Dim ds As New DataSet
            'ds.Tables.Add(dr.Table.Clone())
            'ds.Tables(0).ImportRow(dr)

            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            myConnection.Open()

            Dim adapterForTable1 = New SqlDataAdapter("select * from  " & Tabla & " ", myConnection)
            Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
            adapterForTable1.Update(dt)

            'está difícil actualizar el identity usando esto
            'http://stackoverflow.com/questions/136536/possible-to-retrieve-identity-column-value-on-insert-using-sqlcommandbuilder-wit

            'Return ExecDinamico(SC, "SELECT " & Tabla & " = SCOPE_IDENTITY()").Rows(0).Item(0) 'no anduvo
            Dim r = ExecDinamico(SC, "SELECT TOP 1 idListaPrecios from ListasPrecios order by idListaPrecios DESC")
            Return r.Rows(0).Item(0)

        End Function




        Public Shared Function Fetch(ByVal SC As String, txtBuscar As String, Optional top As Long = 20000) As DataTable




            Dim sSql = "SELECT top " & top & _
            " IdListaPrecios as [IdListaPrecios], " & _
           "  Descripcion as [Descripcion], " & _
            " IdListaPrecios as [IdAux1], " & _
           "  NumeroLista as [Numero], " & _
            " FechaVigencia, " & _
            " Activa as [Activa?], " & _
            " Monedas.Nombre as [Moneda] " & _
            " FROM ListasPrecios " & _
            " LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=ListasPrecios.IdMoneda " & _
            " WHERE Descripcion LIKE '%" & txtBuscar & "%' " & _
            " ORDER by Descripcion "

            'Return ExecDinamico(SC, "ListasPrecios_TT")  'cambiar esto y el campo [descripcion lista precios]
            Return ExecDinamico(SC, sSql)  'cambiar esto y el campo [descripcion lista precios]
        End Function


        Public Shared Function Update(ByVal SC As String, ByVal dt As DataTable) As Integer
            '// Write your own Insert statement blocks 


            'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
            ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
            'y esto? http://www.vbforums.com/showthread.php?t=352219


            ''convertir datarow en datatable
            'Dim ds As New DataSet
            'ds.Tables.Add(dr.Table.Clone())
            'ds.Tables(0).ImportRow(dr)

            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            myConnection.Open()

            Dim adapterForTable1 = New SqlDataAdapter("select * from  " & Tabla & " ", myConnection)
            Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
            'si te tira error acá, ojito con estar usando el dataset q usaste para el 
            'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update
            adapterForTable1.Update(dt)


        End Function



        Public Shared Function Delete(ByVal SC As String, ByVal Id As Long)
            '// Write your own Delete statement blocks. 
            ExecDinamico(SC, String.Format("DELETE ListasPreciosDetalle WHERE idListaPrecios={0}", Id))
            ExecDinamico(SC, String.Format("DELETE  " & Tabla & "  WHERE idListaPrecios={0}", Id))
        End Function





        Public Shared Function Tarifa(ByVal SC As String, ByVal idCliente As Long, ByVal idArticulo As Long, Optional ByVal idDestino As Long = 0) As Double

            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            'Si el cliente no tiene lista de precio asignada, usar la default

            Dim idlistaPrecio As Long
            Dim dt1 As DataTable = EntidadManager.ExecDinamico(SC, _
                                 "SELECT idListaPrecios FROM Clientes WHERE idCliente= " & idCliente)

            If dt1.Rows.Count > 0 Then
                idlistaPrecio = iisNull(dt1.Rows(0).Item("idListaPrecios"), 0)
                If idlistaPrecio = 0 Then Return 0
            Else
                Return 0
            End If

            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////


            Dim dt As DataTable = EntidadManager.ExecDinamico(SC, _
                                     "SELECT Precio,PrecioRepetidoPeroConPrecision FROM ListasPreciosDetalle WHERE idListaPrecios= " & idlistaPrecio & " AND idArticulo=" & idArticulo & IIf(idDestino <> 0, " AND (IdDestinoDeCartaDePorte=" & idDestino & " OR IdDestinoDeCartaDePorte is null) ORDER BY IdDestinoDeCartaDePorte DESC", ""))

            If dt.Rows.Count > 0 Then
                Tarifa = iisNull(dt.Rows(0).Item("PrecioRepetidoPeroConPrecision"), ArticuloManager.GetItem(SC, idArticulo).CostoPPP)
                If Tarifa = 0 Then
                    Tarifa = iisNull(dt.Rows(0).Item("Precio"), ArticuloManager.GetItem(SC, idArticulo).CostoPPP)
                End If
            Else
                Tarifa = 0
            End If

            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
        End Function


        Public Shared Function GetPreciosSubcontratistaPorIdCliente(ByVal SC As String, ByVal idCliente As Long) As DataRow
            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            'Si el cliente no tiene lista de precio asignada, usar la default

            Dim idListaPrecio As Long
            Dim dt1 As DataTable = EntidadManager.ExecDinamico(SC, _
                                 "SELECT idListaPrecios FROM Clientes WHERE idCliente= " & idCliente)

            If dt1.Rows.Count > 0 Then
                idListaPrecio = iisNull(dt1.Rows(0).Item("idListaPrecios"), 0)
                If idListaPrecio = 0 Then Return Nothing
            Else
                Return Nothing
            End If

            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            'Busco el precio. Puede tener cualquier articulo asociado. Como en realidad esta mal
            'diseñado (calada y balanza son columnas en lugar de articulos de proveedor) busco el primer
            'renglon de la lista de precios de ese subcontratista, que, despues de todo, ha de ser el unico

            Dim dt2 As DataTable = EntidadManager.ExecDinamico(SC, _
                                 "SELECT TOP 1 * FROM ListasPreciosDetalle WHERE idListaPrecios= " & idListaPrecio & " ORDER BY PrecioDescargaLocal,PrecioCaladaLocal DESC")

            'PrecioCaladaLocal
            'PrecioCaladaExportacion
            'PrecioDescargaLocal
            'PrecioDescargaExportacion

            If dt2.Rows.Count > 0 Then
                Return dt2.Rows(0)
            Else
                Return Nothing
            End If



        End Function

        Public Shared Function CrearLista(ByVal SC As String, ByVal Descripcion As String, ByVal IdMoneda As Long) As Long
            Dim dt = ListaPreciosManager.TraerMetadata(SC)
            Dim dr = dt.NewRow
            dr.Item("Descripcion") = Left(Descripcion, 50)
            dr.Item("IdMoneda") = IdMoneda
            dr.Item("NumeroLista") = EntidadManager.ExecDinamico(SC, "select top 1 NumeroLista from ListasPrecios order by NumeroLista DESC").Rows(0).Item(0) + 1
            dt.Rows.Add(dr)

            CrearLista = ListaPreciosManager.Insert(SC, dt)
        End Function

        Public Shared Function CrearleListaAlCliente(ByVal SC As String, ByVal IdCliente As Long) As Long
            Dim myCliente As Cliente = ClienteManager.GetItem(SC, IdCliente)
            If myCliente.IdLocalidad = 0 Then myCliente.IdLocalidad = BuscaIdLocalidadPreciso("CIUDAD AUTONOMA BUENOS AIRES", SC) 'le fuerzo una localidad para que no me aborte la lista de precios
            If myCliente.IdProvincia = 0 Then myCliente.IdProvincia = 2 'BuscaIdProvinciaNET("BUENOS AIRES", SC)
            myCliente.IdListaPrecios = CrearLista(SC, myCliente.RazonSocial & " - Precios", 1)
            If myCliente.Direccion = "" Then myCliente.Direccion = ".."
            If myCliente.CodigoPostal = "" Then myCliente.CodigoPostal = "0"

            ClienteManager.Save(SC, myCliente)
            Return myCliente.IdListaPrecios
        End Function


        Public Shared Function GetPrecioPorLista(ByVal SC As String, ByVal IdArticulo As Long, Optional ByVal IdListaPrecios As Long = 0, Optional ByVal IdMoneda As Long = Nothing) As Double

            Dim oArt As Articulo = ArticuloManager.GetItem(SC, IdArticulo)
            With oArt
                '//////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////
                'Si tiene costoreposicion, me voy
                '//////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////

                If .CostoReposicion > 0 Then Return oArt.CostoReposicion


                If IdListaPrecios <= 0 Then Return 0


                '//////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////
                'busco la lista de precios. Me voy
                '//////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////

                Dim dt2 As DataTable = EntidadManager.ExecDinamico(SC, _
                                     "SELECT TOP 1 * FROM ListasPreciosDetalle WHERE idListaPrecios= " & IdListaPrecios & " ORDER BY Precio DESC")

                If dt2.Rows.Count > 0 Then
                    Return dt2.Rows(0).Item("Precio")
                Else
                    Return 0
                End If


                '//////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////
                'Acá no puede llegar nunca
                'Esto no sé cómo funciona. _UltimoPorIdArticulo
                If IdMoneda = Nothing Then IdMoneda = 1
                Dim ds1 = EntidadManager.GetListTX("ListasPrecios", "_UltimoPorIdArticulo", IdArticulo, IdMoneda)
                'If oRsAux.RecordCount > 0 Then
                '    origen.Registro.Fields("Precio").Value = IIf(IsNull(oRsAux.Fields("Precio").Value), 0, oRsAux.Fields("Precio").Value)
                'End If


            End With

        End Function


        Public Shared Function SavePrecioPorCliente_OBSOLETA_NOUSARMASELDESTINO(ByVal SC As String, ByVal IdCliente As Long, ByVal IdArticulo As Long, ByVal IdDestino As Long, ByVal Precio As Double)
            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////

           

            'busca la lista del cliente
            Dim idListaPrecio As Long
            Dim dt1 As DataTable = EntidadManager.ExecDinamico(SC, _
                                 "SELECT idListaPrecios FROM Clientes WHERE idCliente= " & IdCliente)



            'Si el cliente no tiene lista de precio asignada, crearle una 
            If dt1.Rows.Count > 0 Then
                idListaPrecio = iisNull(dt1.Rows(0).Item("idListaPrecios"), 0)
                If idListaPrecio <= 0 Then
                    Try
                        idListaPrecio = CrearleListaAlCliente(SC, IdCliente)
                    Catch ex As Exception
                        ErrHandler.WriteError("No se pudo crear la lista de precios al facturar. " & ex.Message)
                    End Try

                End If
            Else
                Try
                    idListaPrecio = CrearleListaAlCliente(SC, IdCliente)
                Catch ex As Exception
                    ErrHandler.WriteError("Existe ese cliente?")
                    ErrHandler.WriteAndRaiseError(ex)
                End Try

            End If



            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            'Busco el precio


            Dim idListaDetalle = TablaSelectId(SC, "ListasPreciosDetalle", "idlistaPrecios=" & idListaPrecio & " AND idArticulo=" & IdArticulo & " AND IdDestinoDeCartaDePorte=" & IdDestino)


            If False Then
                'si no lo encuentro con destino, busco solo por articulo
                'Por qué, si ESTAS GRABANDO!!

                If iisNull(idListaDetalle, 0) < 1 Then
                    idListaDetalle = TablaSelectId(SC, "ListasPreciosDetalle", "idlistaPrecios=" & idListaPrecio & " AND idArticulo=" & IdArticulo & " AND ISNULL(IdDestinoDeCartaDePorte,0)<1 ")
                End If
            End If



            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            'Lo creo o lo modifico
            If idListaDetalle = 0 Then
                Dim dt = ListasPreciosItemManager.TraerMetadata(SC)
                Dim dr = dt.NewRow
                dr.Item("IdArticulo") = IdArticulo
                dr.Item("IdListaPrecios") = idListaPrecio
                dr.Item("Precio") = Precio
                dr.Item("PrecioRepetidoPeroConPrecision") = Precio
                dr.Item("IdDestinoDeCartaDePorte") = IdDestino
                dt.Rows.Add(dr)
                ListasPreciosItemManager.Insert(SC, dt)
            Else
                TablaUpdate(SC, "ListasPreciosDetalle", "IdListaPreciosDetalle", idListaDetalle, "Precio", DecimalToString(Precio))
                TablaUpdate(SC, "ListasPreciosDetalle", "IdListaPreciosDetalle", idListaDetalle, "PrecioRepetidoPeroConPrecision", DecimalToString(Precio))
            End If



        End Function


        Shared Function VerificarVencimientoLista(idListaPrecio As Long, SC As String)

            Dim dt1 As DataTable = EntidadManager.ExecDinamico(SC, _
                                 "SELECT FechaVigencia  FROM ListasPrecios WHERE idListaPrecios= " & idListaPrecio)

            Dim fechavigencia As Date? = iisNull(dt1.Rows(0).Item("FechaVigencia"), Nothing)

            If fechavigencia IsNot Nothing And fechavigencia < Now Then
                Throw New Exception("La tarifa de la lista está vencida")
            End If
        End Function


        Public Shared Function SavePrecioPorCliente(ByVal SC As String, ByVal IdCliente As Long, ByVal IdArticulo As Long, ByVal Precio As Double, Optional ByVal IdDestino As Long = -1)
            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////


            'busca la lista del cliente
            Dim idListaPrecio As Long
            Dim dt1 As DataTable = EntidadManager.ExecDinamico(SC, _
                                 "SELECT idListaPrecios FROM Clientes WHERE idCliente= " & IdCliente)



            'Si el cliente no tiene lista de precio asignada, crearle una 
            If dt1.Rows.Count > 0 Then
                idListaPrecio = iisNull(dt1.Rows(0).Item("idListaPrecios"), 0)
                If idListaPrecio <= 0 Then
                    idListaPrecio = CrearleListaAlCliente(SC, IdCliente)
                End If
            Else
                idListaPrecio = CrearleListaAlCliente(SC, IdCliente)
            End If


            VerificarVencimientoLista(idListaPrecio, SC)


            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            'ojo con RECLAMO 8094: Al editar tarifas en el paso 2, no agregar una con destino y una sin destino. 
            'Hace confuso el listado de precios, si ellos tienen que agregar una excepción lo harán a mano.	
            '
            'De hecho. tengo la funcion SavePrecioPorCliente_OBSOLETA_NOUSARMASELDESTINO().......

            'Busco el precio
            Dim idListaDetalle = TablaSelectId(SC, "ListasPreciosDetalle", "idlistaPrecios=" & idListaPrecio & " AND idArticulo=" & IdArticulo & IIf(IdDestino > 0, " AND IdDestinoDeCartaDePorte=" & IdDestino, "") & " AND IdDestinoDeCartaDePorte is Null")

            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            'Lo creo o lo modifico
            If idListaDetalle = 0 Then
                Dim dt = ListasPreciosItemManager.TraerMetadata(SC)
                Dim dr = dt.NewRow
                dr.Item("IdArticulo") = IdArticulo
                dr.Item("IdListaPrecios") = idListaPrecio
                dr.Item("Precio") = Precio
                dr.Item("PrecioRepetidoPeroConPrecision") = Precio
                'dr.Item("IdDestinoDeCartaDePorte") = IdDestino
                dt.Rows.Add(dr)
                ListasPreciosItemManager.Insert(SC, dt)
            Else
                TablaUpdate(SC, "ListasPreciosDetalle", "IdListaPreciosDetalle", idListaDetalle, "Precio", DecimalToString(Precio))
                TablaUpdate(SC, "ListasPreciosDetalle", "IdListaPreciosDetalle", idListaDetalle, "PrecioRepetidoPeroConPrecision", DecimalToString(Precio))
            End If



        End Function



        Public Shared Function SavePrecioExportacionPorCliente(ByVal SC As String, ByVal IdCliente As Long, ByVal IdArticulo As Long, ByVal Precio As Double, Optional ByVal IdDestino As Long = -1)
            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////

          
            'busca la lista del cliente
            Dim idListaPrecio As Long
            Dim dt1 As DataTable = EntidadManager.ExecDinamico(SC, _
                                 "SELECT idListaPrecios FROM Clientes WHERE idCliente= " & IdCliente)



            'Si el cliente no tiene lista de precio asignada, crearle una 
            If dt1.Rows.Count > 0 Then
                idListaPrecio = iisNull(dt1.Rows(0).Item("idListaPrecios"), 0)
                If idListaPrecio <= 0 Then
                    idListaPrecio = CrearleListaAlCliente(SC, IdCliente)
                End If
            Else
                idListaPrecio = CrearleListaAlCliente(SC, IdCliente)
            End If



            VerificarVencimientoLista(idListaPrecio, SC)

            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            'ojo con RECLAMO 8094: Al editar tarifas en el paso 2, no agregar una con destino y una sin destino. 
            'Hace confuso el listado de precios, si ellos tienen que agregar una excepción lo harán a mano.	
            '
            'De hecho. tengo la funcion SavePrecioPorCliente_OBSOLETA_NOUSARMASELDESTINO().......

            'Busco el precio
            Dim idListaDetalle = TablaSelectId(SC, "ListasPreciosDetalle", "idlistaPrecios=" & idListaPrecio & " AND idArticulo=" & IdArticulo & IIf(IdDestino > 0, " AND IdDestinoDeCartaDePorte=" & IdDestino, "") & " AND IdDestinoDeCartaDePorte is Null")

            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            'Lo creo o lo modifico
            If idListaDetalle = 0 Then
                Dim dt = ListasPreciosItemManager.TraerMetadata(SC)
                Dim dr = dt.NewRow
                dr.Item("IdArticulo") = IdArticulo
                dr.Item("IdListaPrecios") = idListaPrecio
                dr.Item("PrecioExportacion") = Precio
                dt.Rows.Add(dr)
                ListasPreciosItemManager.Insert(SC, dt)
            Else
                TablaUpdate(SC, "ListasPreciosDetalle", "IdListaPreciosDetalle", idListaDetalle, "PrecioExportacion", DecimalToString(Precio))
            End If



        End Function


        Public Shared Function SavePrecioEmbarquePorCliente(ByVal SC As String, ByVal IdCliente As Long, ByVal IdArticulo As Long, ByVal Precio As Double)
            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////


            'busca la lista del cliente
            Dim idListaPrecio As Long
            Dim dt1 As DataTable = EntidadManager.ExecDinamico(SC, _
                                 "SELECT idListaPrecios FROM Clientes WHERE idCliente= " & IdCliente)



            'Si el cliente no tiene lista de precio asignada, crearle una 
            If dt1.Rows.Count > 0 Then
                idListaPrecio = iisNull(dt1.Rows(0).Item("idListaPrecios"), 0)
                If idListaPrecio <= 0 Then
                    idListaPrecio = CrearleListaAlCliente(SC, IdCliente)
                End If
            Else
                idListaPrecio = CrearleListaAlCliente(SC, IdCliente)
            End If



            VerificarVencimientoLista(idListaPrecio, SC)

            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            'Busco el precio
            Dim idListaDetalle = TablaSelectId(SC, "ListasPreciosDetalle", "idlistaPrecios=" & idListaPrecio & " AND idArticulo=" & IdArticulo & "   AND IdDestinoDeCartaDePorte is Null")

            '//////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////
            'Lo creo o lo modifico
            If idListaDetalle = 0 Then
                Dim dt = ListasPreciosItemManager.TraerMetadata(SC)
                Dim dr = dt.NewRow
                dr.Item("IdArticulo") = IdArticulo
                dr.Item("IdListaPrecios") = idListaPrecio
                dr.Item("PrecioEmbarque") = Precio
                dt.Rows.Add(dr)
                ListasPreciosItemManager.Insert(SC, dt)
            Else
                TablaUpdate(SC, "ListasPreciosDetalle", "IdListaPreciosDetalle", idListaDetalle, "PrecioEmbarque", DecimalToString(Precio))
            End If



        End Function

    End Class

End Namespace