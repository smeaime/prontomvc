Imports System
Imports System.ComponentModel
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports Microsoft.VisualBasic
Imports System.Data.SqlClient 'esto tambien hay que sacarlo de acá
Imports System.Linq
Imports Pronto.ERP.Bll.EntidadManager

Imports adodb.DataTypeEnum
Imports ADODB.ExecuteOptionEnum
Imports ADODB.LockTypeEnum
'Importado de MTSPronto.Genreral, MTSPronto.GralUpd, MTSPronto.GralLector


Public Enum Entidades
    _BorradoSubdiarios
    _ImportacionCobranzas
    _ImportacionCobranzas_Historico
    _TempActivacionCompraMateriales
    _TempAutorizaciones
    _TempAutorizaciones1
    _TempAux
    _TempAux1
    _TempBasesConciliacion
    _TempCondicionesCompra
    _TempCuadroGastosParaCubo
    _TempCuboBalance
    _TempCuboCashFlow
    _TempCuboComparativa
    _TempCuboCostosImportacion
    _TempCuboIngresoEgresosPorObra
    _TempCuboIVAPorObra
    _TempCuboPedidos
    _TempCuboPosicionFinanciera
    _TempCuboPresupuestoEconomico
    _TempCuboPresupuestoFinanciero
    _TempCuboPresupuestoFinanciero2
    _TempCuboPresupuestoFinancieroTeorico
    _TempCuboProduccion
    _TempCuboProyeccionEgresos
    _TempCuboReservaPresupuestaria
    _TempCuboSaldosComprobantesPorObraProveedor
    _TempCuboStock
    _TempCuboVentasEnCuotas
    _TempCuboVentasEnCuotas1
    _TempCuentas
    _TempCuentasCorrientesAcreedores
    _TempDisponibilidadMaterialesPorLM
    _TempEstadoDeFirmas
    _TempEstadoDeObras
    _TempEstadoRMs
    _TempMaterialesImportados
    _TempReservasStock
    _TempSaldoItemsLM
    _TempVentasParaCubo
    Acabados
    AcoAcabados
    AcoBiselados
    AcoCalidades
    AcoCodigos
    AcoColores
    AcoFormas
    AcoGrados
    AcoHHItemsDocumentacion
    AcoHHTareas
    AcoMarcas
    AcoMateriales
    AcoModelos
    AcoNormas
    Acopios
    AcoSchedulers
    AcoSeries
    AcoTipos
    AcoTiposRosca
    AcoTratamientos
    'Actividades Proveedores
    AjustesStock
    AjustesStockSAT
    AlimentacionesElectricas
    AnexosEquipos
    AniosNorma
    AnticiposAlPersonal
    AnticiposAlPersonalSyJ
    ArchivosATransmitir
    ArchivosATransmitirDestinos
    ArchivosATransmitirLoteo
    Articulos
    ArticulosInformacionAdicional
    Asientos
    AsignacionesCostos
    Autorizaciones
    AutorizacionesPorComprobante
    BancoChequeras
    Bancos
    Biselados
    Cajas
    Calidades
    CalidadesClad
    Cargos
    CartasDePorte
    CDPHumedades
    CentrosCosto
    CertificacionesObras
    CertificacionesObrasPxQ
    Choferes
    Clausulas
    Clientes
    Codigos
    CodigosAduana
    CodigosDestinacion
    CodigosUniversales
    CoeficientesContables
    CoeficientesImpositivos
    Colores
    Comparativas
    ComprobantesProveedores
    Conceptos
    Conciliaciones
    'Condiciones Compra
    Conjuntos
    ControlesCalidad
    CostosImportacion
    CostosPromedios
    Cotizaciones
    Cuantificacion
    Cuentas
    CuentasBancarias
    CuentasCorrientesAcreedores
    CuentasCorrientesDeudores
    CuentasEjerciciosContables
    CuentasGastos
    DefinicionAnulaciones
    DefinicionArticulos
    DefinicionesCuadrosContables
    DefinicionesFlujoCaja
    Densidades
    Depositos
    DepositosBancarios
    DescripcionIva
    DetalleAcoAcabados
    DetalleAcoBiselados
    DetalleAcoCalidades
    DetalleAcoCodigos
    DetalleAcoColores
    DetalleAcoFormas
    DetalleAcoGrados
    DetalleAcoHHItemsDocumentacion
    DetalleAcoHHTareas
    DetalleAcoMarcas
    DetalleAcoMateriales
    DetalleAcoModelos
    DetalleAcoNormas
    DetalleAcopios
    DetalleAcopiosEquipos
    DetalleAcopiosRevisiones
    DetalleAcoSchedulers
    DetalleAcoSeries
    DetalleAcoTipos
    DetalleAcoTiposRosca
    DetalleAcoTratamientos
    DetalleAjustesStock
    DetalleAjustesStockSAT
    DetalleArticulosActivosFijos
    DetalleArticulosDocumentos
    DetalleArticulosImagenes
    DetalleArticulosUnidades
    DetalleAsientos
    DetalleAutorizaciones
    DetalleClientes
    DetalleClientesLugaresEntrega
    DetalleComparativas
    DetalleComprobantesProveedores
    DetalleComprobantesProveedoresProvincias
    DetalleConciliaciones
    DetalleConciliacionesNoContables
    DetalleConjuntos
    DetalleControlesCalidad
    DetalleCuentas
    DetalleDefinicionAnulaciones
    DetalleDefinicionesFlujoCajaCuentas
    DetalleDefinicionesFlujoCajaPresupuestos
    DetalleDepositosBancarios
    DetalleDevoluciones
    DetalleDistribucionesObras
    DetalleEmpleados
    DetalleEmpleadosJornadas
    DetalleEmpleadosSectores
    DetalleEquipos
    DetalleEventosDelSistema
    DetalleFacturas
    DetalleFacturasClientesPRESTO
    DetalleFacturasOrdenesCompra
    DetalleFacturasProvincias
    DetalleFacturasRemitos
    DetalleLMateriales
    DetalleLMaterialesRevisiones
    DetalleNotasCredito
    DetalleNotasCreditoImputaciones
    DetalleNotasCreditoOrdenesCompra
    DetalleNotasCreditoProvincias
    DetalleNotasDebito
    DetalleNotasDebitoProvincias
    DetalleObrasDestinos
    DetalleObrasEquiposInstalados
    DetalleObrasPolizas
    DetalleObrasRecepciones
    DetalleObrasSectores
    DetalleOrdenesCompra
    DetalleOrdenesPago
    DetalleOrdenesPagoCuentas
    DetalleOrdenesPagoImpuestos
    DetalleOrdenesPagoRubrosContables
    DetalleOrdenesPagoValores
    DetalleOtrosIngresosAlmacen
    DetalleOtrosIngresosAlmacenSAT
    DetallePatronesGPS
    DetallePedidos
    DetallePedidosSAT
    DetallePresupuestos
    DetallePresupuestosHHObras
    DetallePresupuestosHHObrasPorMes
    DetalleProveedores
    DetalleProveedoresIB
    DetalleProveedoresRubros
    DetalleRecepciones
    DetalleRecepcionesSAT
    DetalleRecibos
    DetalleRecibosCuentas
    DetalleRecibosRubrosContables
    DetalleRecibosValores
    DetalleRemitos
    DetalleRequerimientos
    DetalleReservas
    DetalleSalidasMateriales
    DetalleSalidasMaterialesSAT
    DetalleSolicitudesCompra
    DetalleValesSalida
    DetalleValores
    DetalleValoresCuentas
    DetalleValoresProvincias
    DetalleValoresRubrosContables
    DetalleVentasEnCuotas
    Devoluciones
    DiccionarioEquivalencias
    DiferenciasCambio
    DispositivosGPS
    DistribucionesObras
    dtproperties
    Ejercicios
    EjerciciosContables
    EjerciciosPeriodos
    Empleados
    EmpleadosAccesos
    Empresa
    Equipos
    EstadoPedidos
    'Estados Proveedores
    EstadosVentasEnCuotas
    EventosDelSistema
    ExcelImportador
    Facturas
    FacturasClientesPRESTO
    FacturasCompra
    Familias
    Feriados
    Fletes
    FletesPartesDiarios
    FondosFijos
    Formas
    Formularios
    FormulariosTabIndex
    Ganancias
    GastosFletes
    Grados
    GruposActivosFijos
    GruposObras
    GruposTareasHH
    HorasHombre
    HorasJornadas
    IBCondiciones
    IGCondiciones
    ImpuestosDirectos
    Inventarios
    ItemsDocumentacion
    ItemsPopUpMateriales
    ItemsProduccion
    LecturasGPS
    ListasPrecios
    ListasPreciosDetalle
    LMateriales
    Localidades
    Log
    LogImpuestos
    LugaresEntrega
    Marcas
    Materiales
    Modelos
    Monedas
    MotivosRechazo
    MovimientosFletes
    Normas
    NotasCredito
    NotasDebito
    NovedadesUsuarios
    Obras
    OrdenesCompra
    OrdenesPago
    OrdenesTrabajo
    Origen
    OtrosIngresosAlmacen
    OtrosIngresosAlmacenSAT
    Paises
    Parametros
    Parametros2
    PatronesGPS
    Pedidos
    PedidosAbiertos
    PedidosSAT
    Planos
    PlazosEntrega
    PlazosFijos
    PosicionesImportacion
    PresupuestoFinanciero
    PresupuestoObras
    PresupuestoObrasConsumos
    PresupuestoObrasConsumosTeoricos
    PresupuestoObrasNodos
    PresupuestoObrasNodosConsumos
    PresupuestoObrasNodosPresupuestos
    PresupuestoObrasNodosPxQxPresupuesto
    PresupuestoObrasRubros
    Presupuestos
    ProntoIni
    ProntoIniClaves
    Proveedores
    ProveedoresRubros
    Provincias
    PuntosVenta
    Rangos
    Recepciones
    RecepcionesSAT
    Recibos
    Relaciones
    Remitos
    Requerimientos
    Reservas
    Revaluos
    Rubros
    RubrosContables
    RubrosValores
    SaldosEjercicios
    SalidasMateriales
    SalidasMaterialesSAT
    Scheduler
    Sectores
    Series
    SiNo
    SolicitudesCompra
    Stock
    Subcontratos
    SubcontratosDatos
    SubcontratosPxQ
    Subdiarios
    Subrubros
    Tareas
    TareasFijas
    TarifasFletes
    TarjetasCredito
    Tipos
    TiposCompra
    TiposComprobante
    TiposCuenta
    TiposCuentaGrupos
    TiposEquipo
    TiposImpuesto
    TiposPoliza
    TiposRetencionGanancia
    TiposRosca
    TiposValores
    Titulos
    Traducciones
    Transportistas
    TratamientosTermicos
    Ubicaciones
    Unidades
    UnidadesEmpaque
    UnidadesOperativas
    ValesSalida
    Valores
    ValoresIngresos
    Vendedores
    VentasEnCuotas
    ViasPago
    WilliamsDestinos
    WilliamsMailFiltros
End Enum





Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    Public Class ICompMTSManager


        Function TraerFiltrado(ByVal SC As String, ByVal NombreTabla As String, ByVal Filtro As String, ByVal ParamArray Args() As Object) As adodb.Recordset

            Dim ds = GeneralDB.TraerDatos(SC, NombreTabla & "_TX" & Filtro, Args)

            Return DataTable_To_Recordset(ds.Tables(0))

        End Function


        Public Shared Sub Tarea(ByRef myConnection As SqlConnection, ByRef Transaccion As SqlTransaction, ByVal sStoreProcedure As String, ByVal ParamArray Parametros() As Object)
            EntidadManager.Tarea(myConnection, Transaccion, sStoreProcedure, Parametros)
        End Sub

        Public Shared Sub Tarea(ByVal SC As String, ByVal sStoreProcedure As String, ByVal ParamArray Parametros() As Object)
            EntidadManager.Tarea(SC, sStoreProcedure, Parametros)
        End Sub



        Private Shared Function IdNombre(ByVal sTabla As Entidades) As String
            Select Case sTabla
                Case Entidades.Subdiarios
                    Return "IdSubdiario"
                Case Entidades.Valores
                    Return "IdValor"
                Case Entidades.IBCondiciones
                    Return "IdIBCondicion"
                Case Entidades.Recibos
                    Return "IdRecibo"
                Case Entidades.Provincias
                    Return "IdProvincia"
                Case Else
                    Err.Raise(243534)
            End Select
        End Function

        Private Shared Function TablaNombre(ByVal sTabla As Entidades) As String
            Return sTabla.ToString

            'Select Case sTabla
            '    Case Entidades.Subdiarios
            '        Return "Subdiarios"
            '    Case Entidades.Valores
            '        Return "Valores"
            '    Case Entidades.IBCondiciones
            '        Return "IBCondiciones"
            '    Case Entidades.Recibos
            '        Return "Recibos"
            '    Case Entidades.Provincias
            '        Return "Provincias"
            '    Case Else
            '        Err.Raise(243534)
            'End Select
        End Function



        Public Shared Function LeerUno(ByVal SC As String, ByVal sEntidadTabla As Entidades, Optional ByVal Id As Integer = -1) As Data.DataTable
            Return TraerMetadata(SC, sEntidadTabla, Id)
        End Function

        Public Shared Function TraerMetadata(ByVal SC As String, ByVal sEntidadTabla As Entidades, ByVal Descripcion As String) As Data.DataTable
            Dim dtBuscar = ExecDinamico(SC, "SELECT * FROM CtaCtes WHERE Palabra='" & Descripcion & "'")

            If dtBuscar.Rows.Count = 0 Then
                Return ExecDinamico(SC, "select * from " & TablaNombre(sEntidadTabla) & " where 1=0")
            Else
                Return dtBuscar
            End If
        End Function

        Public Shared Function TraerMetadata(ByVal SC As String, ByVal sEntidadTabla As Entidades, Optional ByVal Id As Integer = -1) As Data.DataTable
            'http://social.msdn.microsoft.com/Forums/en-US/adodotnetdataproviders/thread/0cd9d46c-d822-41d4-8456-c921a8632d27/
            'IMPORTANTE:
            'No usar dim sarasa = tblOrder.NewRow
            'sino 
            'Dim drCurrentOrder AS DATAROW = tblOrder.NewRow
            'because you haven't declared drCurrentOrder as a datarow it will be declared as Object.  
            'When you pass it to Rows.Add it is using the overloaded method that accepts an object array instead 
            'of the method that accepts a DataRow.

            If Id = -1 Then
                Return ExecDinamico(SC, "select * from " & TablaNombre(sEntidadTabla) & " where 1=0")
            Else
                Return ExecDinamico(SC, "select * from " & TablaNombre(sEntidadTabla) & " where " & IdNombre(sEntidadTabla) & "=" & Id)
            End If
        End Function

        Public Shared Function Insert(ByVal SC As String, ByVal sEntidadTabla As Entidades, ByVal dt As Data.DataTable) As Integer
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

            Dim adapterForTable1 = New SqlDataAdapter("select * from " & TablaNombre(sEntidadTabla) & "", myConnection)
            Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)

            DataTableForzarRowstateEnAdded(dt)
            adapterForTable1.Update(dt)

            'está difícil actualizar el identity usando esto
            'http://stackoverflow.com/questions/136536/possible-to-retrieve-identity-column-value-on-insert-using-sqlcommandbuilder-wit
            'Return ExecDinamico(SC, "SELECT " & Tabla & " = SCOPE_IDENTITY()").Rows(0).Item(0) 'no anduvo
            Dim r = ExecDinamico(SC, "SELECT TOP 1 " & IdNombre(sEntidadTabla) & " from  " & TablaNombre(sEntidadTabla) & "  order by " & IdNombre(sEntidadTabla) & " DESC")

            Try
                dt.Rows(0).Item(0) = r.Rows(0).Item(0) 'asigno el ID
                Return dt.Rows(0).Item(0)
            Catch ex As Exception
                Return -1
            End Try

        End Function






        Public Shared Function Update(ByVal SC As String, ByVal sEntidadTabla As Entidades, ByVal dt As Data.DataTable) As Integer
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

            Dim adapterForTable1 = New SqlDataAdapter("select * from " & TablaNombre(sEntidadTabla) & "", myConnection)
            Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
            'si te tira error acá, ojito con estar usando el dataset q usaste para el 
            'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update
            adapterForTable1.Update(dt)

        End Function


        Public Shared Function Eliminar(ByVal SC As String, ByVal sEntidadTabla As Entidades, ByVal Id As Long)
            '// Write your own Delete statement blocks. 
            ExecDinamico(SC, String.Format("DELETE  " & TablaNombre(sEntidadTabla) & "  WHERE {1}={0}", Id, IdNombre(sEntidadTabla)))
        End Function

        Public Shared Sub Eliminar(ByVal DefinicionConexion As String, ByVal NombreTabla As String, ByVal vData As Long)

            Dim oSrv As New SrvDatosVieja
            Dim oCont ' As ObjectContext
            '   Dim oSec As MTxAS.SecurityProperty

            'oCont = GetObjectContext

            On Error GoTo MalElim

            If oCont Is Nothing Then
                oSrv = CreateObject("SrvDatos.Servidor")
            Else
                oSrv = oCont.CreateInstance("SrvDatos.Servidor")
                If Not oCont.IsCallerInRole("Administradores") Then
                    Err.Raise(vbObjectError + 250, , "No puede realizar esta operación")
                End If
            End If

            ' If Len(DefinicionConexion) = 0 Then DefinicionConexion = CargarStringConexion1
            If vData > 0 Then
                oSrv.Ejecutar(DefinicionConexion, NombreTabla & "_E", vData)
            End If

            oSrv = Nothing

            If Not oCont Is Nothing Then oCont.SetComplete()

            oSrv = Nothing
            oCont = Nothing

            Exit Sub

MalElim:
            If Not oCont Is Nothing Then oCont.SetAbort()
            oCont = Nothing
            oSrv = Nothing
            Err.Raise(Err.Number, Err.Source, Err.Description)
            '   Resume

        End Sub


        Public Shared Function Guardar2(ByVal SC As String, ByVal sEntidadTabla As String, ByVal rs As adodb.Recordset)
            '// Write your own Delete statement blocks. 

            Dim enumEntidad = [Enum].Parse(GetType(Entidades), sEntidadTabla)

            If rs.Fields(0).Value > 0 Then
                Update(SC, enumEntidad, RecordSet_To_DataTable(rs))
            Else
                Insert(SC, enumEntidad, RecordSet_To_DataTable(rs))
            End If
        End Function

        Public Shared Function LeerUno(ByVal sc As String, ByVal Tabla As String, ByVal id As Long) As adodb.Recordset
            If id < 1 Then Return DataTable_To_Recordset(ExecDinamico(sc, "Select idproveedor from proveedores where 1=0"))

            Return DataTable_To_Recordset(GetStoreProcedureTop1(sc, Tabla & "_T", id).Table)
        End Function


        Public Function Guardar(ByVal DefinicionConexion As String, ByVal NombreTabla As String, ByVal vData As adodb.Recordset) As MisEstados

            Dim oSrv As New SrvDatosVieja 'As InterfazDatos.IDatos
            Dim oCont 'As ObjectContext

            'oCont = GetObjectContext

            On Error GoTo MalGuardar

            vData.Update()

            'If oCont Is Nothing Then
            '    oSrv = CreateObject("SrvDatos.Servidor")
            'Else
            '    oSrv = oCont.CreateInstance("SrvDatos.Servidor")
            'End If





            If vData.Fields(0).Value > 0 Then
                oSrv.Ejecutar(DefinicionConexion, NombreTabla & "_M", vData)
            Else
                If vData.Fields(0).Type = adUnsignedTinyInt Or vData.Fields(0).Type = adTinyInt Then
                    vData.Fields(0).Value = 0
                    vData.Fields(0).Value = CByte(oSrv.Ejecutar(DefinicionConexion, NombreTabla & "_A", vData))
                Else
                    vData.Fields(0).Value = -1
                    vData.Fields(0).Value = oSrv.Ejecutar(DefinicionConexion, NombreTabla & "_A", vData)
                End If
            End If

            'If Not oCont Is Nothing Then oCont.SetComplete()

            oSrv = Nothing
            oCont = Nothing

            Guardar = MisEstados.Correcto

            Exit Function

MalGuardar:
            If Not oCont Is Nothing Then oCont.SetAbort()
            oCont = Nothing
            oSrv = Nothing
            Err.Raise(Err.Number, Err.Source, Err.Description)
            Resume

        End Function


        Public Function GuardarPorRef(ByVal DefinicionConexion As String, ByVal NombreTabla As String, ByRef vData As adodb.Recordset) As MisEstados

            'En Pronto, cada objeto MTS implementa una interfaz que lo obliga a definir GuardarPorRef.
            'Acá, para simplificar, hacemos una para todos.


            Dim oSrv As New SrvDatosVieja  'As InterfazDatos.IDatos
            Dim oCont 'As ObjectContext

            'Cont = GetObjectContext

            On Error GoTo MalGuardar

            vData.Update()

            If oCont Is Nothing Then
                oSrv = CreateObject("SrvDatos.Servidor")
            Else
                oSrv = oCont.CreateInstance("SrvDatos.Servidor")
            End If

            'If Len(DefinicionConexion) = 0 Then DefinicionConexion = CargarStringConexion1
            If vData.Fields(0).Value > 0 Then
                oSrv.EjecutarPorRef(DefinicionConexion, NombreTabla & "_M", vData)
            Else
                If vData.Fields(0).Type = adUnsignedTinyInt Or vData.Fields(0).Type = adTinyInt Then
                    vData.Fields(0).Value = 0
                    vData.Fields(0).Value = CByte(oSrv.EjecutarPorRef(DefinicionConexion, NombreTabla & "_A", vData))



                    GeneralDB.EjecutarSP(DefinicionConexion, NombreTabla & "_A", vData)

                Else
                    vData.Fields(0).Value = -1
                    vData.Fields(0).Value = oSrv.EjecutarPorRef(DefinicionConexion, NombreTabla & "_A", vData)
                End If
            End If

            If Not oCont Is Nothing Then oCont.SetComplete()

            oSrv = Nothing
            oCont = Nothing

            GuardarPorRef = MisEstados.Correcto
            Exit Function

MalGuardar:
            If Not oCont Is Nothing Then oCont.SetAbort()
            oCont = Nothing
            oSrv = Nothing
            Err.Raise(Err.Number, Err.Source, Err.Description)
            Resume

        End Function





        Public Enum MisEstados
            Correcto = 0
            NoExiste = 1
            ModificadoPorOtro = 2
            ErrorDeDatos = 3
        End Enum







        Private Class SrvDatosVieja

            Dim oCon As ADODB.Connection
            Public Enum srvTipoCom
                srvCmdTexto = 1
                srvCmdTabla = 2
                srvCmdStore = 4
            End Enum
            Dim mTimeOut As Integer

            Friend Sub Conectar(ByVal NombreConexion As String)

                Dim sMsg As String
                Dim oErr As ADODB.Error
                Dim Conexion As String
                Dim Usuario As String
                Dim Clave As String
                '   Dim Spm As MTxSpm.SharedPropertyGroupManager
                '   Dim SpmG As MTxSpm.SharedPropertyGroup
                '   Dim spmProp As MTxSpm.SharedProperty
                '
                '   Set Spm = New MTxSpm.SharedPropertyGroupManager
                '   Set SpmG = Spm.CreatePropertyGroup("srvDatos", LockSetGet, Process, True)
                '   Set spmProp = SpmG.CreateProperty("Conexion", True)
                '   Conexion = spmProp.Value
                '   Set spmProp = SpmG.CreateProperty("Usuario", True)
                '   Usuario = spmProp.Value
                '   Set spmProp = SpmG.CreateProperty("Clave", True)
                '   Clave = spmProp.Value
                '
                '   Set spmProp = Nothing
                '   Set SpmG = Nothing
                '   Set Spm = Nothing

                '   Conexion = LeerArchivoSecuencial(NombreConexion)
                Conexion = NombreConexion

                If Len(Conexion) = 0 Then
                    Err.Raise(vbObjectError + 100, "srvDatos:Conectar", "No se puede conectar con cadena vacía")
                End If

                mTimeOut = 2000

                oCon = New ADODB.Connection

                On Error GoTo MalConexion

                With oCon
                    .Open(Conexion, Usuario, Clave)
                    .CommandTimeout = mTimeOut
                End With

                Exit Sub

MalConexion:
                For Each oErr In oCon.Errors
                    sMsg = sMsg & oErr.Description & vbCrLf
                Next
                Err.Raise(vbObjectError + 101, "AccesoADatos:Conectar", sMsg)

            End Sub



            Public Function LeerRecordset(ByVal NombreConexion As String, ByVal SQL As String, Optional ByVal Args As Object = Nothing, Optional ByVal Tipo As srvTipoCom = srvTipoCom.srvCmdStore) As ADODB.Recordset

                Dim oCont 'As ObjectContext
                Dim oRs As ADODB.Recordset
                Dim oCom As ADODB.Command
                Dim i As Integer
                Dim lErr As Long, sSource As String, sDesc As String

                On Error GoTo Mal

                '                oCont = GetObjectContext

                Conectar(NombreConexion)

                '**********************************************
                ' Si sólo abriera recordsets sin Parámetros, se usaría lo que sigue
                'Set oRs = New ADODB.Recordset
                'oRs.Open SQL, oCon, adOpenForwardOnly, adLockReadOnly
                '**********************************************

                If oCont Is Nothing Then
                    oCom = CreateObject("adodb.Command")
                Else
                    oCom = oCont.CreateInstance("adodb.Command")
                End If

                With oCom

                    .CommandText = SQL
                    .ActiveConnection = oCon
                    .CommandType = Tipo
                    .CommandTimeout = mTimeOut

                    If Not IsNothing(Args) Then

                        .Parameters.Refresh()  ' lee de la definición del SP (Proc. Almacenado), los argumentos que necesita.
                        ' si es uno solo... (El parameters(0) es el valor de retorno del SP

                        Select Case TypeName(Args)
                            Case "Variant()"
                                For i = 0 To UBound(Args)
                                    With .Parameters(i + 1)
                                        Select Case .Type
                                            Case adInteger
                                                .Value = CLng(Args(i))
                                                ' OXO!!!!!!!!! Faltan todos los demás
                                            Case Else
                                                .Value = Args(i)
                                        End Select
                                    End With
                                Next
                            Case "Recordset"
                                For i = 0 To Args.Fields.Count - 1
                                    With .Parameters(i + 1)
                                        Select Case .Type
                                            Case adInteger
                                                .Value = CLng(Args.Fields(i).Value)
                                                ' OXO!!!!!!!!! Faltan todos los demás
                                            Case Else
                                                .Value = Args.Fields(i).Value
                                        End Select
                                    End With
                                Next
                            Case "String"
                                With .Parameters(1)
                                    .Value = Args
                                End With
                            Case Else
                                With .Parameters(1)
                                    Select Case .Type
                                        Case adSingle, adDouble
                                            .Value = CLng(Args)
                                        Case adTinyInt, adUnsignedTinyInt
                                            If Args < 0 Then
                                                .Value = CByte(0)
                                            Else
                                                .Value = CByte(Args)
                                            End If
                                        Case adInteger, adUnsignedInt, adSmallInt, adUnsignedSmallInt
                                            .Value = CLng(Args)
                                        Case Else
                                            .Value = Args
                                            ' OXO!!!!!!!!! Faltan todos los demás
                                    End Select
                                End With
                        End Select

                    End If

                End With

                oRs = New ADODB.Recordset

                With oRs

                    ' para hacer que el recordset esté desconectado
                    .CursorLocation = ADODB.CursorLocationEnum.adUseClient
                    .LockType = adLockBatchOptimistic
                    ' *****************************************
                    .Open(oCom)
                    ' Desconecto el Rs. es igual que set oRs=ocom.Execute
                    .ActiveConnection = Nothing

                End With

                LeerRecordset = oRs

                If Not oCont Is Nothing Then
                    With oCont
                        If .IsInTransaction Then .SetComplete()
                    End With
                End If

Salir:
                oRs = Nothing
                'Desconectar()
                On Error GoTo 0
                If lErr Then
                    Err.Raise(lErr, sSource, sDesc)
                End If
                Exit Function

Mal:
                If Not oCont Is Nothing Then
                    With oCont
                        If .IsInTransaction Then .SetAbort()
                    End With
                End If
                With Err()
                    lErr = .Number
                    sSource = .Source
                    sDesc = .Description
                End With
                Resume Salir

            End Function



            Public Function Ejecutar(ByVal NombreConexion As String, _
                     ByVal SQL As String, _
                     Optional ByVal Args As Object = Nothing, _
                     Optional ByVal Tipo As srvTipoCom = srvTipoCom.srvCmdStore) As Long

                Dim oCom As ADODB.Command
                Dim i As Integer
                Dim x As Integer
                Dim oCont 'As ObjectContext
                Dim lErr As Long, sSource As String, sDesc As String

                On Error GoTo Mal

                'oCont = GetObjectContext

                Conectar(NombreConexion)

                If oCont Is Nothing Then
                    oCom = CreateObject("adodb.Command")
                Else
                    oCom = oCont.CreateInstance("adodb.Command")
                End If

                With oCom

                    .CommandText = SQL
                    .ActiveConnection = oCon
                    .CommandType = Tipo
                    .CommandTimeout = mTimeOut

                    If Not IsNothing(Args) Then

                        .Parameters.Refresh()  ' lee de la definición del SP (Proc. Almacenado), los argumentos que necesita.
                        ' si es uno solo... (El parameters(0) es el valor de retorno del SP

                        Select Case TypeName(Args)
                            Case "Variant()"
                                For i = 0 To UBound(Args)
                                    With .Parameters(i + 1)
                                        Select Case .Type
                                            Case adInteger
                                                .Value = CLng(Args(i))
                                                ' OXO!!!!!!!!! Faltan todos los demás
                                            Case Else
                                                .Value = Args(i)
                                        End Select
                                    End With
                                Next
                            Case "Recordset"
                                x = Math.Min(.Parameters.Count - 1, Args.Fields.Count)
                                For i = 0 To x - 1
                                    With .Parameters(i + 1)
                                        If Not IsNull(Args.Fields(i).Value) Then
                                            Select Case .Type
                                                Case adSingle
                                                    .Value = CSng(Args.Fields(i).Value)
                                                Case adDouble, adNumeric
                                                    .Value = CDbl(Args.Fields(i).Value)
                                                Case adInteger, adUnsignedInt, adSmallInt, adUnsignedSmallInt
                                                    .Value = CLng(Args.Fields(i).Value)
                                                    ' Faltan todos los demás
                                                Case Else
                                                    If IsNothing(Args.Fields(i).Value) Then
                                                        .Value = DBNull.Value
                                                    Else
                                                        .Value = Args.Fields(i).Value
                                                    End If
                                            End Select
                                        Else
                                            .Value = Args.Fields(i).Value
                                        End If
                                    End With
                                Next
                            Case Else
                                With .Parameters(1)
                                    Select Case .Type
                                        Case adSingle
                                            .Value = CSng(Args)
                                        Case adDouble
                                            .Value = CDbl(Args)
                                        Case adTinyInt, adUnsignedTinyInt
                                            If Args < 0 Then
                                                .Value = CByte(0)
                                            Else
                                                .Value = CByte(Args)
                                            End If
                                        Case adInteger, adUnsignedInt, adSmallInt, adUnsignedSmallInt
                                            .Value = CLng(Args)
                                            ' Faltan todos los demás
                                    End Select
                                End With
                        End Select

                    End If

                    .Execute(, , adExecuteNoRecords) ' ejecuta SIN esperar que se devuelvan registros

                    If Right$(SQL, 2) = "_A" Then
                        Ejecutar = .Parameters(1).Value
                    End If

                End With

                If Not oCont Is Nothing Then
                    With oCont
                        If .IsInTransaction Then .SetComplete()
                    End With
                End If

Salir:
                oCom = Nothing
                'Desconectar()
                On Error GoTo 0
                If lErr Then
                    Err.Raise(lErr, sSource, sDesc)
                End If
                Exit Function

Mal:
                If Not oCont Is Nothing Then
                    With oCont
                        If .IsInTransaction Then .SetAbort()
                    End With
                End If
                With Err()
                    lErr = .Number
                    sSource = .Source
                    sDesc = .Description
                End With
                Resume Salir

            End Function

            Public Function EjecutarPorRef(ByVal NombreConexion As String, _
                     ByVal SQL As String, _
                     Optional ByRef Args As Object = Nothing, _
                     Optional ByVal Tipo As srvTipoCom = srvTipoCom.srvCmdStore) As Long

                Dim oCom As ADODB.Command
                Dim i As Integer
                Dim x As Integer
                Dim oCont 'As ObjectContext
                Dim lErr As Long, sSource As String, sDesc As String

                On Error GoTo Mal

                'oCont = GetObjectContext

                Conectar(NombreConexion)

                If oCont Is Nothing Then
                    oCom = CreateObject("adodb.Command")
                Else
                    oCom = oCont.CreateInstance("adodb.Command")
                End If

                With oCom

                    .CommandText = SQL
                    .ActiveConnection = oCon
                    .CommandType = Tipo
                    .CommandTimeout = mTimeOut

                    If Not IsNothing(Args) Then

                        .Parameters.Refresh()  ' lee de la definición del SP (Proc. Almacenado), los argumentos que necesita.
                        ' si es uno solo... (El parameters(0) es el valor de retorno del SP

                        Select Case TypeName(Args)
                            Case "Variant()"
                                For i = 0 To UBound(Args)
                                    With .Parameters(i + 1)
                                        Select Case .Type
                                            Case adInteger
                                                .Value = CLng(Args(i))
                                                ' OXO!!!!!!!!! Faltan todos los demás
                                            Case Else
                                                .Value = Args(i)
                                        End Select
                                    End With
                                Next
                            Case "Recordset"
                                x = Math.Min(.Parameters.Count - 1, Args.Fields.Count)
                                For i = 0 To x - 1
                                    With .Parameters(i + 1)
                                        If Not IsNull(Args.Fields(i).Value) Then
                                            Select Case .Type
                                                Case adSingle
                                                    .Value = CSng(Args.Fields(i).Value)
                                                Case adDouble, adNumeric
                                                    .Value = CDbl(Args.Fields(i).Value)
                                                Case adInteger, adUnsignedInt, adSmallInt, adUnsignedSmallInt
                                                    .Value = CLng(Args.Fields(i).Value)
                                                    ' OXO!!!!!!!!! Faltan todos los demás
                                                Case Else
                                                    .Value = Args.Fields(i).Value
                                            End Select
                                        Else
                                            .Value = Args.Fields(i).Value
                                        End If
                                    End With
                                Next
                            Case Else
                                With .Parameters(1)
                                    Select Case .Type
                                        Case adSingle
                                            .Value = CSng(Args)
                                        Case adDouble
                                            .Value = CDbl(Args)
                                        Case adTinyInt, adUnsignedTinyInt
                                            If Args < 0 Then
                                                .Value = CByte(0)
                                            Else
                                                .Value = CByte(Args)
                                            End If
                                        Case adInteger, adUnsignedInt, adSmallInt, adUnsignedSmallInt
                                            .Value = CLng(Args)
                                            ' OXO!!!!!!!!! Faltan todos los demás
                                    End Select
                                End With
                        End Select

                    End If

                    .Execute(, , adExecuteNoRecords) ' ejecuta SIN esperar que se devuelvan registros

                    If Right$(SQL, 2) = "_A" Then
                        EjecutarPorRef = .Parameters(1).Value
                    End If

                End With

                If Not oCont Is Nothing Then
                    With oCont
                        If .IsInTransaction Then .SetComplete()
                    End With
                End If

Salir:
                oCom = Nothing
                'Desconectar()
                On Error GoTo 0
                If lErr Then
                    Err.Raise(lErr, sSource, sDesc)
                End If
                Exit Function

Mal:
                If Not oCont Is Nothing Then
                    With oCont
                        If .IsInTransaction Then .SetAbort()
                    End With
                End If
                With Err()
                    lErr = .Number
                    sSource = .Source
                    sDesc = .Description
                End With
                Resume Salir

            End Function


            Private Function IDatos_Ejecutar(ByVal NombreConexion As String, ByVal SQL As String, ByVal Args As Object, Optional ByVal Tipo As srvTipoCom = 4&) As Long

                IDatos_Ejecutar = Me.Ejecutar(NombreConexion, SQL, Args, Tipo)

            End Function

            Private Function IDatos_EjecutarPorRef(ByVal NombreConexion As String, ByVal SQL As String, Optional ByRef Args As Object = Nothing, Optional ByVal Tipo As srvTipoCom = 4&) As Long

                IDatos_EjecutarPorRef = Me.EjecutarPorRef(NombreConexion, SQL, Args, Tipo)

            End Function

            Private Function IDatos_LeerRecordset(ByVal NombreConexion As String, ByVal SQL As String, Optional ByVal Args As Object = Nothing, Optional ByVal Tipo As srvTipoCom = 4&) As adodb.Recordset

                IDatos_LeerRecordset = Me.LeerRecordset(NombreConexion, SQL, Args, Tipo)

            End Function

        End Class

        Protected Overrides Sub Finalize()
            MyBase.Finalize()
        End Sub
    End Class






End Namespace
