Imports System
Imports System.ComponentModel
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient

Namespace Pronto.ERP.BO

    <Serializable()> Public Class ClienteNuevo

        Public EmailFacturacionElectronica As String
        Public UsaGastosAdmin As String
        Public TelefonosFijosOficina As String
        Public TelefonosCelulares As String
        Public SeLeFacturaCartaPorteComoTitular As String
        Public DireccionDeCorreos As String
        Public IdLocalidadDeCorreos As Long
        Public IdProvinciaDeCorreos As Long
        Public CodigoPostalDeCorreos As String
        Public SeLeFacturaCartaPorteComoIntermediario As String
        Public SeLeFacturaCartaPorteComoRemcomercial As String
        Public SeLeFacturaCartaPorteComoCorredor As String

        Public EsClienteExportador As String
        Public SeLeFacturaCartaPorteComoDestinatarioLocal As String
        Public SeLeFacturaCartaPorteComoDestinatarioExportador As String
        Public SeLeDerivaSuFacturaAlCorredorDeLaCarta As String
        Public IncluyeTarifaEnFactura As String
        Public AutorizacionSyngenta As String
        Public EsEntregador As String
        Public Contactos As String
        Public ObservacionesDeCorreos As String
        Public DeshabilitadoPorCobranzas As String

        Public CorreosElectronicos As String
        Public SeLeFacturaCartaPorteComoClienteAuxiliar As String
        Public EsAcondicionadoraDeCartaPorte As String
        Public HabilitadoParaCartaPorte As String
        Public CartaPorteTipoDeAdjuntoDeFacturacion As Integer?



        Private _Id As Integer = -1
        Private _RazonSocial As String = String.Empty
        Private _Direccion As String = String.Empty
        Private _IdLocalidad As Integer = 0
        Private _Localidad As String = String.Empty
        Private _CodigoPostal As String = String.Empty
        Private _IdProvincia As Integer = 0
        Private _Provincia As String = String.Empty
        Private _IdPais As Integer = 0
        Private _Pais As String = String.Empty
        Private _Telefono1 As String = String.Empty
        Private _Telefono2 As String = String.Empty
        Private _Fax As String = String.Empty
        Private _Email As String = String.Empty
        Private _Cuit As String = String.Empty
        Private _IdCodigoIva As Integer = 0
        Private _IdListaPrecios As Integer = 0
        Private _CodigoIva As String = String.Empty
        Private _FechaAlta As DateTime = DateTime.MinValue
        Private _FechaUltimaCompra As DateTime = DateTime.MinValue
        Private _Excencion As Double = 0
        Private _IdCondicionCompra As Integer = 0
        Private _CondicionCompra As String = String.Empty
        Private _Contacto As String = String.Empty
        Private _IdActividad As Integer = 0
        Private _Actividad As String = String.Empty
        Private _Nif As String = String.Empty
        Private _IdEstado As Integer = 0
        Private _Estado As String = String.Empty
        Private _EstadoFecha As DateTime = DateTime.MinValue
        Private _EstadoUsuario As String = String.Empty
        Private _AltaUsuario As String = String.Empty
        Private _CodigoEmpresa As String = String.Empty
        Private _Nombre1 As String = String.Empty
        Private _Nombre2 As String = String.Empty
        Private _NombreFantasia As String = String.Empty
        Private _IdTipoRetencionGanancia As Integer = 0
        Private _CategoriaGanancias As String = String.Empty
        Private _IGCondicion As Integer = 0
        Private _IGCertificadoAutoretencion As String = String.Empty
        Private _IGCertificadoNORetencion As String = String.Empty
        Private _IGFechaCaducidadExencion As DateTime = DateTime.MinValue
        Private _FechaLimiteExentoGanancias As DateTime = DateTime.MinValue
        Private _IGPorcentajeNORetencion As Double = 0
        Private _IvaAgenteRetencion As String = String.Empty
        Private _IvaExencionRetencion As String = String.Empty
        Private _IvaFechaCaducidadExencion As DateTime = DateTime.MinValue
        Private _IvaPorcentajeExencion As Double = 0
        Private _CodigoSituacionRetencionIVA As String = String.Empty
        Private _SituacionIIBB As String = String.Empty
        Private _IBNumeroInscripcion As String = String.Empty
        Private _IdIBCondicionPorDefecto As Integer = 0
        Private _CategoriaIIBB As String = String.Empty
        Private _IBCondicion As Integer = 0
        Private _IBFechaCaducidadExencion As DateTime = DateTime.MinValue
        Private _FechaLimiteExentoIIBB As DateTime = DateTime.MinValue
        Private _IBPorcentajeExencion As Double = 0
        Private _CoeficienteIIBBUnificado As Double = 0
        Private _SujetoEmbargado As String = String.Empty
        Private _SaldoEmbargo As Double = 0
        Private _DetalleEmbargo As String = String.Empty
        Private _PorcentajeIBDirecto As Double = 0
        Private _FechaInicioVigenciaIBDirecto As DateTime = DateTime.MinValue
        Private _FechaFinVigenciaIBDirecto As DateTime = DateTime.MinValue
        Private _GrupoIIBB As Integer = 0
        Private _SSFechaCaducidadExencion As DateTime = DateTime.MinValue
        Private _SSPorcentajeExcencion As Double = 0
        Private _PaginaWeb As String = String.Empty
        Private _Habitual As String = String.Empty
        Private _Observaciones As String = String.Empty
        Private _Saldo As Double = 0
        Private _CodigoProveedor As Integer = 0
        Private _IdCuenta As Integer = 0
        Private _CuentaContable As String = String.Empty
        Private _IdMoneda As Integer = 0
        Private _MonedaHabitual As String = String.Empty
        Private _LimiteCredito As Double = 0
        Private _TipoProveedor As Integer = 0
        Private _Eventual As String = String.Empty
        Private _Confirmado As String = String.Empty
        Private _CodigoPresto As String = String.Empty
        Private _BienesOServicios As String = String.Empty
        Private _RetenerSUSS As String = String.Empty
        Private _SUSSFechaCaducidadExencion As DateTime = DateTime.MinValue
        Private _ChequesALaOrdenDe As String = String.Empty
        Private _IdImpuestoDirectoSUSS As Integer = 0
        Private _ImpuestoDirectoSUSS As String = String.Empty
        Private _Importaciones_NumeroInscripcion As String = String.Empty
        Private _Importaciones_DenominacionInscripcion As String = String.Empty
        Private _EnviarEmail As Integer = 0
        Private _InformacionAuxiliar As String = String.Empty
        Private _FechaUltimaPresentacionDocumentacion As DateTime = DateTime.MinValue
        Private _ObservacionesPresentacionDocumentacion As String = String.Empty
        Private _FechaLimiteCondicionIVA As DateTime = DateTime.MinValue
        Private _Calificacion As Integer = 0
        Private _IdUsuarioIngreso As Integer = 0
        Private _UsuarioIngreso As String = String.Empty
        Private _FechaIngreso As DateTime = DateTime.MinValue
        Private _IdUsuarioModifico As Integer = 0
        Private _UsuarioModifico As String = String.Empty
        Private _FechaModifico As DateTime = DateTime.MinValue
        Private _Exterior As String = String.Empty




        Public DireccionEntrega As String = String.Empty
        Public IdLocalidadEntrega As Integer = 0
        Public IdProvinciaEntrega As Integer = 0
        Public CodigoCliente As String = String.Empty
        Public saldoDocumentos As Double = 0
        Public Vendedor1 As Integer = 0
        Public creditoMaximo As Double = 0
        Public IdCondicionVenta As Integer = 0
        Public tipoCliente As Integer = 0
        Public codigo As String = String.Empty
        Public idcuentaMonedaExt As Integer = 0
        Public Cobrador As Integer = 0
        Public Auxiliar As String = String.Empty
        Public IdIBCondicionPorDefecto2 As Integer = 0
        Public IdIBCondicionPorDefecto3 As Integer = 0
        Public esAgenteRetencionIVA As Boolean
        Public BaseMinimaParaPercepcionIVA As Double = 0
        Public PorcentajePercepcionIVA As Double = 0
        Public idbancoDebito As Integer = 0
        Public CBU As String = String.Empty
        Public PorcentajeIBDirectoCapital As Double = 0
        Public FechaInicioVigenciaIBDirectoCapital As DateTime = DateTime.MinValue
        Public FechaFinVigenciaIBDirectoCapital As DateTime = DateTime.MinValue
        Public GrupoIIBBCapital As Integer = 0

        Public ExpresionRegularNoAgruparFacturasConEstosVendedores As String
        Public ExigeDatosCompletosEnCartaDePorteQueLoUse As String

        Private _DetallesContactos As ProveedorContactoList = New ProveedorContactoList

        <DataObjectFieldAttribute(True, True, False)> _
        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property

        Public Property RazonSocial() As String
            Get
                Return _RazonSocial
            End Get
            Set(ByVal value As String)
                _RazonSocial = value
            End Set
        End Property

        Public Property Direccion() As String
            Get
                Return _Direccion
            End Get
            Set(ByVal value As String)
                _Direccion = value
            End Set
        End Property

        Public Property IdListaPrecios() As Integer
            Get
                Return _IdListaPrecios
            End Get
            Set(ByVal value As Integer)
                _IdListaPrecios = value
            End Set
        End Property


        Public Property IdLocalidad() As Integer
            Get
                Return _IdLocalidad
            End Get
            Set(ByVal value As Integer)
                _IdLocalidad = value
            End Set
        End Property

        Public Property Localidad() As String
            Get
                Return _Localidad
            End Get
            Set(ByVal value As String)
                _Localidad = value
            End Set
        End Property

        Public Property CodigoPostal() As String
            Get
                Return _CodigoPostal
            End Get
            Set(ByVal value As String)
                _CodigoPostal = value
            End Set
        End Property

        Public Property IdProvincia() As Integer
            Get
                Return _IdProvincia
            End Get
            Set(ByVal value As Integer)
                _IdProvincia = value
            End Set
        End Property

        Public Property Provincia() As String
            Get
                Return _Provincia
            End Get
            Set(ByVal value As String)
                _Provincia = value
            End Set
        End Property

        Public Property IdPais() As Integer
            Get
                Return _IdPais
            End Get
            Set(ByVal value As Integer)
                _IdPais = value
            End Set
        End Property

        Public Property Pais() As String
            Get
                Return _Pais
            End Get
            Set(ByVal value As String)
                _Pais = value
            End Set
        End Property

        Public Property Telefono1() As String
            Get
                Return _Telefono1
            End Get
            Set(ByVal value As String)
                _Telefono1 = value
            End Set
        End Property

        Public Property Telefono2() As String
            Get
                Return _Telefono2
            End Get
            Set(ByVal value As String)
                _Telefono2 = value
            End Set
        End Property

        Public Property Fax() As String
            Get
                Return _Fax
            End Get
            Set(ByVal value As String)
                _Fax = value
            End Set
        End Property

        Public Property Email() As String
            Get
                Return _Email
            End Get
            Set(ByVal value As String)
                _Email = value
            End Set
        End Property

        Public Property Cuit() As String
            Get
                Return _Cuit
            End Get
            Set(ByVal value As String)
                _Cuit = value
            End Set
        End Property

        Public Property IdCodigoIva() As Integer
            Get
                Return _IdCodigoIva
            End Get
            Set(ByVal value As Integer)
                _IdCodigoIva = value
            End Set
        End Property

        Public Property CodigoIva() As String
            Get
                Return _CodigoIva
            End Get
            Set(ByVal value As String)
                _CodigoIva = value
            End Set
        End Property

        Public Property FechaAlta() As DateTime
            Get
                Return _FechaAlta
            End Get
            Set(ByVal value As DateTime)
                _FechaAlta = value
            End Set
        End Property

        Public Property FechaUltimaCompra() As DateTime
            Get
                Return _FechaUltimaCompra
            End Get
            Set(ByVal value As DateTime)
                _FechaUltimaCompra = value
            End Set
        End Property

        Public Property Excencion() As Double
            Get
                Return _Excencion
            End Get
            Set(ByVal value As Double)
                _Excencion = value
            End Set
        End Property

        Public Property IdCondicionCompra() As Integer
            Get
                Return _IdCondicionCompra
            End Get
            Set(ByVal value As Integer)
                _IdCondicionCompra = value
            End Set
        End Property

        Public Property CondicionCompra() As String
            Get
                Return _CondicionCompra
            End Get
            Set(ByVal value As String)
                _CondicionCompra = value
            End Set
        End Property

        Public Property Contacto() As String
            Get
                Return _Contacto
            End Get
            Set(ByVal value As String)
                _Contacto = value
            End Set
        End Property

        Public Property IdActividad() As Integer
            Get
                Return _IdActividad
            End Get
            Set(ByVal value As Integer)
                _IdActividad = value
            End Set
        End Property

        Public Property Actividad() As String
            Get
                Return _Actividad
            End Get
            Set(ByVal value As String)
                _Actividad = value
            End Set
        End Property

        Public Property Nif() As String
            Get
                Return _Nif
            End Get
            Set(ByVal value As String)
                _Nif = value
            End Set
        End Property

        Public Property IdEstado() As Integer
            Get
                Return _IdEstado
            End Get
            Set(ByVal value As Integer)
                _IdEstado = value
            End Set
        End Property

        Public Property Estado() As String
            Get
                Return _Estado
            End Get
            Set(ByVal value As String)
                _Estado = value
            End Set
        End Property

        Public Property EstadoFecha() As DateTime
            Get
                Return _EstadoFecha
            End Get
            Set(ByVal value As DateTime)
                _EstadoFecha = value
            End Set
        End Property

        Public Property EstadoUsuario() As String
            Get
                Return _EstadoUsuario
            End Get
            Set(ByVal value As String)
                _EstadoUsuario = value
            End Set
        End Property

        Public Property AltaUsuario() As String
            Get
                Return _AltaUsuario
            End Get
            Set(ByVal value As String)
                _AltaUsuario = value
            End Set
        End Property

        Public Property CodigoEmpresa() As String
            Get
                Return _CodigoEmpresa
            End Get
            Set(ByVal value As String)
                _CodigoEmpresa = value
            End Set
        End Property

        Public Property Nombre1() As String
            Get
                Return _Nombre1
            End Get
            Set(ByVal value As String)
                _Nombre1 = value
            End Set
        End Property

        Public Property Nombre2() As String
            Get
                Return _Nombre2
            End Get
            Set(ByVal value As String)
                _Nombre2 = value
            End Set
        End Property

        Public Property NombreFantasia() As String
            Get
                Return _NombreFantasia
            End Get
            Set(ByVal value As String)
                _NombreFantasia = value
            End Set
        End Property

        Public Property IdTipoRetencionGanancia() As Integer
            Get
                Return _IdTipoRetencionGanancia
            End Get
            Set(ByVal value As Integer)
                _IdTipoRetencionGanancia = value
            End Set
        End Property

        Public Property CategoriaGanancias() As String
            Get
                Return _CategoriaGanancias
            End Get
            Set(ByVal value As String)
                _CategoriaGanancias = value
            End Set
        End Property
        Public Property IGCondicion() As Integer
            Get
                Return _IGCondicion
            End Get
            Set(ByVal value As Integer)
                _IGCondicion = value
            End Set
        End Property

        Public Property IGCertificadoAutoretencion() As String
            Get
                Return _IGCertificadoAutoretencion
            End Get
            Set(ByVal value As String)
                _IGCertificadoAutoretencion = value
            End Set
        End Property

        Public Property IGCertificadoNORetencion() As String
            Get
                Return _IGCertificadoNORetencion
            End Get
            Set(ByVal value As String)
                _IGCertificadoNORetencion = value
            End Set
        End Property

        Public Property IGFechaCaducidadExencion() As DateTime
            Get
                Return _IGFechaCaducidadExencion
            End Get
            Set(ByVal value As DateTime)
                _IGFechaCaducidadExencion = value
            End Set
        End Property

        Public Property FechaLimiteExentoGanancias() As DateTime
            Get
                Return _FechaLimiteExentoGanancias
            End Get
            Set(ByVal value As DateTime)
                _FechaLimiteExentoGanancias = value
            End Set
        End Property

        Public Property IGPorcentajeNORetencion() As Double
            Get
                Return _IGPorcentajeNORetencion
            End Get
            Set(ByVal value As Double)
                _IGPorcentajeNORetencion = value
            End Set
        End Property

        Public Property IvaAgenteRetencion() As String
            Get
                Return _IvaAgenteRetencion
            End Get
            Set(ByVal value As String)
                _IvaAgenteRetencion = value
            End Set
        End Property

        Public Property IvaExencionRetencion() As String
            Get
                Return _IvaExencionRetencion
            End Get
            Set(ByVal value As String)
                _IvaExencionRetencion = value
            End Set
        End Property

        Public Property IvaFechaCaducidadExencion() As DateTime
            Get
                Return _IvaFechaCaducidadExencion
            End Get
            Set(ByVal value As DateTime)
                _IvaFechaCaducidadExencion = value
            End Set
        End Property

        Public Property IvaPorcentajeExencion() As Double
            Get
                Return _IvaPorcentajeExencion
            End Get
            Set(ByVal value As Double)
                _IvaPorcentajeExencion = value
            End Set
        End Property

        Public Property CodigoSituacionRetencionIVA() As String
            Get
                Return _CodigoSituacionRetencionIVA
            End Get
            Set(ByVal value As String)
                _CodigoSituacionRetencionIVA = value
            End Set
        End Property

        Public Property SituacionIIBB() As String
            Get
                Return _SituacionIIBB
            End Get
            Set(ByVal value As String)
                _SituacionIIBB = value
            End Set
        End Property

        Public Property IBNumeroInscripcion() As String
            Get
                Return _IBNumeroInscripcion
            End Get
            Set(ByVal value As String)
                _IBNumeroInscripcion = value
            End Set
        End Property

        Public Property IdIBCondicionPorDefecto() As Integer
            Get
                Return _IdIBCondicionPorDefecto
            End Get
            Set(ByVal value As Integer)
                _IdIBCondicionPorDefecto = value
            End Set
        End Property

        Public Property CategoriaIIBB() As String
            Get
                Return _CategoriaIIBB
            End Get
            Set(ByVal value As String)
                _CategoriaIIBB = value
            End Set
        End Property

        Public Property IBCondicion() As Integer
            Get
                Return _IBCondicion
            End Get
            Set(ByVal value As Integer)
                _IBCondicion = value
            End Set
        End Property

        Public Property IBFechaCaducidadExencion() As DateTime
            Get
                Return _IBFechaCaducidadExencion
            End Get
            Set(ByVal value As DateTime)
                _IBFechaCaducidadExencion = value
            End Set
        End Property

        Public Property FechaLimiteExentoIIBB() As DateTime
            Get
                Return _FechaLimiteExentoIIBB
            End Get
            Set(ByVal value As DateTime)
                _FechaLimiteExentoIIBB = value
            End Set
        End Property

        Public Property IBPorcentajeExencion() As Double
            Get
                Return _IBPorcentajeExencion
            End Get
            Set(ByVal value As Double)
                _IBPorcentajeExencion = value
            End Set
        End Property

        Public Property CoeficienteIIBBUnificado() As Double
            Get
                Return _CoeficienteIIBBUnificado
            End Get
            Set(ByVal value As Double)
                _CoeficienteIIBBUnificado = value
            End Set
        End Property

        Public Property SujetoEmbargado() As String
            Get
                Return _SujetoEmbargado
            End Get
            Set(ByVal value As String)
                _SujetoEmbargado = value
            End Set
        End Property

        Public Property SaldoEmbargo() As Double
            Get
                Return _SaldoEmbargo
            End Get
            Set(ByVal value As Double)
                _SaldoEmbargo = value
            End Set
        End Property

        Public Property DetalleEmbargo() As String
            Get
                Return _DetalleEmbargo
            End Get
            Set(ByVal value As String)
                _DetalleEmbargo = value
            End Set
        End Property

        Public Property PorcentajeIBDirecto() As Double
            Get
                Return _PorcentajeIBDirecto
            End Get
            Set(ByVal value As Double)
                _PorcentajeIBDirecto = value
            End Set
        End Property

        Public Property FechaInicioVigenciaIBDirecto() As DateTime
            Get
                Return _FechaInicioVigenciaIBDirecto
            End Get
            Set(ByVal value As DateTime)
                _FechaInicioVigenciaIBDirecto = value
            End Set
        End Property

        Public Property FechaFinVigenciaIBDirecto() As DateTime
            Get
                Return _FechaFinVigenciaIBDirecto
            End Get
            Set(ByVal value As DateTime)
                _FechaFinVigenciaIBDirecto = value
            End Set
        End Property

        Public Property GrupoIIBB() As Integer
            Get
                Return _GrupoIIBB
            End Get
            Set(ByVal value As Integer)
                _GrupoIIBB = value
            End Set
        End Property

        Public Property SSFechaCaducidadExencion() As DateTime
            Get
                Return _SSFechaCaducidadExencion
            End Get
            Set(ByVal value As DateTime)
                _SSFechaCaducidadExencion = value
            End Set
        End Property

        Public Property SSPorcentajeExcencion() As Double
            Get
                Return _SSPorcentajeExcencion
            End Get
            Set(ByVal value As Double)
                _SSPorcentajeExcencion = value
            End Set
        End Property

        Public Property PaginaWeb() As String
            Get
                Return _PaginaWeb
            End Get
            Set(ByVal value As String)
                _PaginaWeb = value
            End Set
        End Property

        Public Property Habitual() As String
            Get
                Return _Habitual
            End Get
            Set(ByVal value As String)
                _Habitual = value
            End Set
        End Property

        Public Property Observaciones() As String
            Get
                Return _Observaciones
            End Get
            Set(ByVal value As String)
                _Observaciones = value
            End Set
        End Property

        Public Property Saldo() As Double
            Get
                Return _Saldo
            End Get
            Set(ByVal value As Double)
                _Saldo = value
            End Set
        End Property

        Public Property CodigoProveedor() As Integer
            Get
                Return _CodigoProveedor
            End Get
            Set(ByVal value As Integer)
                _CodigoProveedor = value
            End Set
        End Property

        Public Property IdCuenta() As Integer
            Get
                Return _IdCuenta
            End Get
            Set(ByVal value As Integer)
                _IdCuenta = value
            End Set
        End Property

        Public Property CuentaContable() As String
            Get
                Return _CuentaContable
            End Get
            Set(ByVal value As String)
                _CuentaContable = value
            End Set
        End Property

        Public Property IdMoneda() As Integer
            Get
                Return _IdMoneda
            End Get
            Set(ByVal value As Integer)
                _IdMoneda = value
            End Set
        End Property

        Public Property MonedaHabitual() As String
            Get
                Return _MonedaHabitual
            End Get
            Set(ByVal value As String)
                _MonedaHabitual = value
            End Set
        End Property

        Public Property LimiteCredito() As Double
            Get
                Return _LimiteCredito
            End Get
            Set(ByVal value As Double)
                _LimiteCredito = value
            End Set
        End Property

        Public Property TipoProveedor() As Integer
            Get
                Return _TipoProveedor
            End Get
            Set(ByVal value As Integer)
                _TipoProveedor = value
            End Set
        End Property

        Public Property Eventual() As String
            Get
                Return _Eventual
            End Get
            Set(ByVal value As String)
                _Eventual = value
            End Set
        End Property

        Public Property Confirmado() As String
            Get
                Return _Confirmado
            End Get
            Set(ByVal value As String)
                _Confirmado = value
            End Set
        End Property

        Public Property CodigoPresto() As String
            Get
                Return _CodigoPresto
            End Get
            Set(ByVal value As String)
                _CodigoPresto = value
            End Set
        End Property

        Public Property BienesOServicios() As String
            Get
                Return _BienesOServicios
            End Get
            Set(ByVal value As String)
                _BienesOServicios = value
            End Set
        End Property

        Public Property RetenerSUSS() As String
            Get
                Return _RetenerSUSS
            End Get
            Set(ByVal value As String)
                _RetenerSUSS = value
            End Set
        End Property

        Public Property SUSSFechaCaducidadExencion() As DateTime
            Get
                Return _SUSSFechaCaducidadExencion
            End Get
            Set(ByVal value As DateTime)
                _SUSSFechaCaducidadExencion = value
            End Set
        End Property

        Public Property ChequesALaOrdenDe() As String
            Get
                Return _ChequesALaOrdenDe
            End Get
            Set(ByVal value As String)
                _ChequesALaOrdenDe = value
            End Set
        End Property

        Public Property IdImpuestoDirectoSUSS() As Integer
            Get
                Return _IdImpuestoDirectoSUSS
            End Get
            Set(ByVal value As Integer)
                _IdImpuestoDirectoSUSS = value
            End Set
        End Property

        Public Property ImpuestoDirectoSUSS() As String
            Get
                Return _ImpuestoDirectoSUSS
            End Get
            Set(ByVal value As String)
                _ImpuestoDirectoSUSS = value
            End Set
        End Property

        Public Property Importaciones_NumeroInscripcion() As String
            Get
                Return _Importaciones_NumeroInscripcion
            End Get
            Set(ByVal value As String)
                _Importaciones_NumeroInscripcion = value
            End Set
        End Property

        Public Property Importaciones_DenominacionInscripcion() As String
            Get
                Return _Importaciones_DenominacionInscripcion
            End Get
            Set(ByVal value As String)
                _Importaciones_DenominacionInscripcion = value
            End Set
        End Property

        Public Property EnviarEmail() As Integer
            Get
                Return _EnviarEmail
            End Get
            Set(ByVal value As Integer)
                _EnviarEmail = value
            End Set
        End Property

        Public Property InformacionAuxiliar() As String
            Get
                Return _InformacionAuxiliar
            End Get
            Set(ByVal value As String)
                _InformacionAuxiliar = value
            End Set
        End Property

        Public Property FechaUltimaPresentacionDocumentacion() As DateTime
            Get
                Return _FechaUltimaPresentacionDocumentacion
            End Get
            Set(ByVal value As DateTime)
                _FechaUltimaPresentacionDocumentacion = value
            End Set
        End Property

        Public Property ObservacionesPresentacionDocumentacion() As String
            Get
                Return _ObservacionesPresentacionDocumentacion
            End Get
            Set(ByVal value As String)
                _ObservacionesPresentacionDocumentacion = value
            End Set
        End Property

        Public Property FechaLimiteCondicionIVA() As DateTime
            Get
                Return _FechaLimiteCondicionIVA
            End Get
            Set(ByVal value As DateTime)
                _FechaLimiteCondicionIVA = value
            End Set
        End Property

        Public Property Calificacion() As Integer
            Get
                Return _Calificacion
            End Get
            Set(ByVal value As Integer)
                _Calificacion = value
            End Set
        End Property

        Public Property IdUsuarioIngreso() As Integer
            Get
                Return _IdUsuarioIngreso
            End Get
            Set(ByVal value As Integer)
                _IdUsuarioIngreso = value
            End Set
        End Property

        Public Property UsuarioIngreso() As String
            Get
                Return _UsuarioIngreso
            End Get
            Set(ByVal value As String)
                _UsuarioIngreso = value
            End Set
        End Property

        Public Property FechaIngreso() As DateTime
            Get
                Return _FechaIngreso
            End Get
            Set(ByVal value As DateTime)
                _FechaIngreso = value
            End Set
        End Property

        Public Property IdUsuarioModifico() As Integer
            Get
                Return _IdUsuarioModifico
            End Get
            Set(ByVal value As Integer)
                _IdUsuarioModifico = value
            End Set
        End Property

        Public Property UsuarioModifico() As String
            Get
                Return _UsuarioModifico
            End Get
            Set(ByVal value As String)
                _UsuarioModifico = value
            End Set
        End Property

        Public Property FechaModifico() As DateTime
            Get
                Return _FechaModifico
            End Get
            Set(ByVal value As DateTime)
                _FechaModifico = value
            End Set
        End Property

        Public Property Exterior() As String
            Get
                Return _Exterior
            End Get
            Set(ByVal value As String)
                _Exterior = value
            End Set
        End Property

        Public Property DetallesContactos() As ProveedorContactoList
            Get
                Return _DetallesContactos
            End Get
            Set(ByVal value As ProveedorContactoList)
                _DetallesContactos = value
            End Set
        End Property


    End Class


End Namespace

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    Public Class ClienteManager




        '<DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListCombo(ByVal SC As String) As System.Data.DataSet
            Return EntidadManager.TraerDatos(SC, "wClientes_TL")
        End Function




        ''<DataObjectMethod(DataObjectMethodType.Update Or DataObjectMethodType.Insert, True)> _
        'Public Shared Function Save(ByVal SC As String, ByVal myProveedor As Cliente) As Integer
        '    'myProveedor.Id = ProveedorDB.Save(SC, myProveedor)
        '    Return myProveedor.ID
        'End Function

        '<DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As ClienteNuevo
            Dim myCliente As ClienteNuevo

            If id < 1 Then Return Nothing

            'If True Then
            myCliente = ClienteDB.GetItem(SC, id)
            'Else
            '    myCliente = GetItemComPronto(SC, id, False)
            'End If


            If False Then
                Try
                    myCliente.ExpresionRegularNoAgruparFacturasConEstosVendedores = EntidadManager.TablaSelect(SC, "ExpresionRegularNoAgruparFacturasConEstosVendedores", "Clientes", "IdCliente", id)
                    myCliente.ExigeDatosCompletosEnCartaDePorteQueLoUse = EntidadManager.TablaSelect(SC, "ExigeDatosCompletosEnCartaDePorteQueLoUse", "Clientes", "IdCliente", id)
                    myCliente.IncluyeTarifaEnFactura = EntidadManager.TablaSelect(SC, "IncluyeTarifaEnFactura ", "Clientes", "IdCliente", id)


                    myCliente.DireccionDeCorreos = EntidadManager.TablaSelect(SC, "DireccionDeCorreos ", "Clientes", "IdCliente", id)
                    myCliente.IdLocalidadDeCorreos = Val(EntidadManager.TablaSelect(SC, "IdLocalidadDeCorreos ", "Clientes", "IdCliente", id))
                    myCliente.IdProvinciaDeCorreos = Val(EntidadManager.TablaSelect(SC, "IdProvinciaDeCorreos ", "Clientes", "IdCliente", id))
                    myCliente.CodigoPostalDeCorreos = EntidadManager.TablaSelect(SC, "CodigoPostalDeCorreos ", "Clientes", "IdCliente", id)
                    myCliente.ObservacionesDeCorreos = EntidadManager.TablaSelect(SC, "ObservacionesDeCorreos ", "Clientes", "IdCliente", id)


                    myCliente.SeLeFacturaCartaPorteComoTitular = EntidadManager.TablaSelect(SC, "SeLeFacturaCartaPorteComoTitular ", "Clientes", "IdCliente", id)
                    myCliente.SeLeFacturaCartaPorteComoIntermediario = EntidadManager.TablaSelect(SC, "SeLeFacturaCartaPorteComoIntermediario ", "Clientes", "IdCliente", id)
                    myCliente.SeLeFacturaCartaPorteComoRemcomercial = EntidadManager.TablaSelect(SC, "SeLeFacturaCartaPorteComoRemcomercial ", "Clientes", "IdCliente", id)
                    myCliente.SeLeFacturaCartaPorteComoCorredor = EntidadManager.TablaSelect(SC, "SeLeFacturaCartaPorteComoCorredor ", "Clientes", "IdCliente", id)

                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try
            End If

            Try

                With myCliente

                    Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
                    Dim oCliente As linqCliente = (From i In db.linqClientes Where i.IdCliente = id).SingleOrDefault

                    Try


                        .ExpresionRegularNoAgruparFacturasConEstosVendedores = oCliente.ExpresionRegularNoAgruparFacturasConEstosVendedores
                        .ExigeDatosCompletosEnCartaDePorteQueLoUse = oCliente.ExigeDatosCompletosEnCartaDePorteQueLoUse
                        .IncluyeTarifaEnFactura = oCliente.IncluyeTarifaEnFactura


                        .DireccionDeCorreos = oCliente.DireccionDeCorreos
                        .IdLocalidadDeCorreos = If(oCliente.IdLocalidadDeCorreos, -1)
                        .IdProvinciaDeCorreos = If(oCliente.IdProvinciaDeCorreos, -1)
                        .CodigoPostalDeCorreos = oCliente.CodigoPostalDeCorreos
                        .ObservacionesDeCorreos = oCliente.ObservacionesDeCorreos


                        .SeLeFacturaCartaPorteComoTitular = oCliente.SeLeFacturaCartaPorteComoTitular
                        .SeLeFacturaCartaPorteComoIntermediario = oCliente.SeLeFacturaCartaPorteComoIntermediario
                        .SeLeFacturaCartaPorteComoRemcomercial = oCliente.SeLeFacturaCartaPorteComoRemcomercial
                        .SeLeFacturaCartaPorteComoCorredor = oCliente.SeLeFacturaCartaPorteComoCorredor

                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try


                    Try
                        .SeLeFacturaCartaPorteComoDestinatarioLocal = oCliente.SeLeFacturaCartaPorteComoDestinatario
                        .SeLeFacturaCartaPorteComoDestinatarioExportador = oCliente.SeLeFacturaCartaPorteComoDestinatarioExportador
                        .SeLeDerivaSuFacturaAlCorredorDeLaCarta = oCliente.SeLeDerivaSuFacturaAlCorredorDeLaCarta

                        .SeLeFacturaCartaPorteComoClienteAuxiliar = oCliente.SeLeFacturaCartaPorteComoClienteAuxiliar
                        .EsAcondicionadoraDeCartaPorte = oCliente.EsAcondicionadoraDeCartaPorte

                        .HabilitadoParaCartaPorte = iisNull(oCliente.HabilitadoParaCartaPorte, "SI") <> "NO"

                        .Eventual = IIf(iisNull(oCliente.IdEstado, 1) = 2, "SI", "NO")

                        .Contactos = oCliente.Contactos
                        .CorreosElectronicos = oCliente.CorreosElectronicos
                        .TelefonosFijosOficina = oCliente.TelefonosFijosOficina
                        .TelefonosCelulares = oCliente.TelefonosCelulares

                        .EsEntregador = oCliente.EsEntregador

                        .CartaPorteTipoDeAdjuntoDeFacturacion = If(oCliente.CartaPorteTipoDeAdjuntoDeFacturacion, -1)



                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try



                    Try

                        Dim oDet As DetalleClientes = (From i In db.DetalleClientes _
                                                            Where i.IdCliente = myCliente.Id _
                                                            And i.Acciones = "EmailFacturacionElectronica"
                                                        ).SingleOrDefault

                        If oDet IsNot Nothing Then .EmailFacturacionElectronica = oDet.Email
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try

                        Dim oDet As DetalleClientes = (From i In db.DetalleClientes _
                                                            Where i.IdCliente = myCliente.Id _
                                                            And i.Acciones = "AutorizacionSyngenta"
                                                        ).SingleOrDefault

                        If oDet IsNot Nothing Then .AutorizacionSyngenta = oDet.Contacto
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                    Try

                        Dim oDet As DetalleClientes = (From i In db.DetalleClientes _
                                                            Where i.IdCliente = myCliente.Id _
                                                            And i.Acciones = "EsExportadorCartaPorte"
                                                        ).SingleOrDefault

                        If oDet IsNot Nothing Then .EsClienteExportador = oDet.Contacto
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try



                    Try

                        Dim oDet As DetalleClientes = (From i In db.DetalleClientes _
                                                            Where i.IdCliente = myCliente.Id _
                                                            And i.Acciones = "UsaGastosAdmin"
                                                        ).SingleOrDefault

                        If oDet IsNot Nothing Then .UsaGastosAdmin = oDet.Contacto Else .UsaGastosAdmin = "SI"
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try



                    Try

                        Dim oDet As DetalleClientes = (From i In db.DetalleClientes _
                                                            Where i.IdCliente = myCliente.Id _
                                                            And i.Acciones = "DeshabilitadoPorCobranzas"
                                                        ).SingleOrDefault

                        If oDet IsNot Nothing Then .DeshabilitadoPorCobranzas = oDet.Contacto Else .DeshabilitadoPorCobranzas = "SI"
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try



                End With
            Catch ex As Exception
                ErrHandler.WriteError(ex)

            End Try



            Return myCliente
            'Return ProveedorDB.GetItem(SC, id)
        End Function

        ''<DataObjectMethod(DataObjectMethodType.Select, False)> _
        'Public Shared Function GetItemComPronto(ByVal SC As String, ByVal id As Integer, ByVal getClienteDetalles As Boolean) As Pronto.ERP.BO.Cliente
        '    Dim myCliente As Pronto.ERP.BO.Cliente
        '    'myCliente = ClienteDB.GetItem(SC, id)
        '    myCliente = New Pronto.ERP.BO.Cliente

        '    Dim Aplicacion = ClaseMigrar.CrearAppCompronto(SC) '  = CrearAppCompronto(SC)
        '    'myCliente.__COMPRONTO_Cliente = Aplicacion.Clientes.Item(id)

        '    myCliente = ConvertirComProntoClienteAPuntoNET(Aplicacion.Clientes.Item(id))
        '    Try
        '        myCliente.ExpresionRegularNoAgruparFacturasConEstosVendedores = EntidadManager.TablaSelect(SC, "ExpresionRegularNoAgruparFacturasConEstosVendedores", "Clientes", "IdCliente", id)
        '        myCliente.ExigeDatosCompletosEnCartaDePorteQueLoUse = EntidadManager.TablaSelect(SC, "ExigeDatosCompletosEnCartaDePorteQueLoUse", "Clientes", "IdCliente", id)
        '    Catch ex As Exception
        '        ErrHandler.WriteError(ex)
        '    End Try
        '    Return myCliente
        'End Function



        '<DataObjectMethod(DataObjectMethodType.Update Or DataObjectMethodType.Insert, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myCliente As Pronto.ERP.BO.ClienteNuevo, Optional ByVal sNombreUsuario As String = "") As Integer


            Dim s = Validar(SC, myCliente)
            If s <> "" Then
                Throw New Exception(s)
            End If


            If True Then
                'METODO NORMAL
                myCliente.Id = ClienteDB.Save(SC, myCliente)
            Else

                'METODO COMPRONTO
                'Dim oClienteCOMPRONTO = ClaseMigrar.ConvertirPuntoNETClienteAComPronto(SC, myCliente)
                'oClienteCOMPRONTO.Guardar()

                'actualizo manualmente campos nuevos
            End If

            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "ExpresionRegularNoAgruparFacturasConEstosVendedores", "'" & myCliente.ExpresionRegularNoAgruparFacturasConEstosVendedores & "'")
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "ExigeDatosCompletosEnCartaDePorteQueLoUse", "'" & myCliente.ExigeDatosCompletosEnCartaDePorteQueLoUse & "'")
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "IncluyeTarifaEnFactura", "'" & myCliente.IncluyeTarifaEnFactura & "'")


            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "DireccionDeCorreos", "'" & myCliente.DireccionDeCorreos & "'")
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "IdLocalidadDeCorreos", myCliente.IdLocalidadDeCorreos)
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "IdProvinciaDeCorreos", myCliente.IdProvinciaDeCorreos)
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "CodigoPostalDeCorreos", "'" & myCliente.CodigoPostalDeCorreos & "'")
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "ObservacionesDeCorreos", "'" & myCliente.ObservacionesDeCorreos & "'")

            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "SeLeFacturaCartaPorteComoTitular", "'" & myCliente.SeLeFacturaCartaPorteComoTitular & "'")
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "SeLeFacturaCartaPorteComoIntermediario", "'" & myCliente.SeLeFacturaCartaPorteComoIntermediario & "'")
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "SeLeFacturaCartaPorteComoRemcomercial", "'" & myCliente.SeLeFacturaCartaPorteComoRemcomercial & "'")
            EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "SeLeFacturaCartaPorteComoCorredor", "'" & myCliente.SeLeFacturaCartaPorteComoCorredor & "'")
            'EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "SeLeFacturaCartaPorteComoDestinatario", "'" & myCliente.SeLeFacturaCartaPorteComoDestinatario & "'")
            'EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myCliente.Id, "SeLeFacturaCartaPorteComoDestinatario", "'" & myCliente.SeLeFacturaCartaPorteComoDestinatario & "'")




            Try

                Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
                Dim oCliente As linqCliente = (From i In db.linqClientes Where i.IdCliente = myCliente.Id).SingleOrDefault
                oCliente.SeLeFacturaCartaPorteComoDestinatario = myCliente.SeLeFacturaCartaPorteComoDestinatarioLocal
                oCliente.SeLeFacturaCartaPorteComoDestinatarioExportador = myCliente.SeLeFacturaCartaPorteComoDestinatarioExportador
                oCliente.SeLeDerivaSuFacturaAlCorredorDeLaCarta = myCliente.SeLeDerivaSuFacturaAlCorredorDeLaCarta



                oCliente.HabilitadoParaCartaPorte = IIf(myCliente.HabilitadoParaCartaPorte, "SI", "NO")
                oCliente.IdEstado = IIf(myCliente.Eventual = "SI", 2, 1)


                With oCliente
                    .SeLeFacturaCartaPorteComoClienteAuxiliar = myCliente.SeLeFacturaCartaPorteComoClienteAuxiliar
                    .EsAcondicionadoraDeCartaPorte = myCliente.EsAcondicionadoraDeCartaPorte




                    .Contactos = myCliente.Contactos
                    .CorreosElectronicos = myCliente.CorreosElectronicos
                    .TelefonosFijosOficina = myCliente.TelefonosFijosOficina
                    .TelefonosCelulares = myCliente.TelefonosCelulares

                    .EsEntregador = myCliente.EsEntregador
                    .CartaPorteTipoDeAdjuntoDeFacturacion = myCliente.CartaPorteTipoDeAdjuntoDeFacturacion




                End With
                'If IsNothing(ue) Then
                '    ue = New UserDatosExtendido
                '    ue.UserId = New Guid(userid)
                '    ue.RazonSocial = razonsocial
                '    ue.CUIT = cuit

                '    db.UserDatosExtendidos.InsertOnSubmit(ue)
                'Else
                '    ue.RazonSocial = razonsocial
                'End If


                'Dim oCliente As linqCliente = (From i In db.linqClientes _
                '                               Join det In db.DetalleClientes On i.IdCliente Equals det.IdCliente _
                '                    Where i.IdCliente = myCliente.Id).SingleOrDefault

                Try

                    Dim oDet As DetalleClientes = (From i In db.DetalleClientes _
                                                        Where i.IdCliente = myCliente.Id _
                                                        And i.Acciones = "EmailFacturacionElectronica"
                                                    ).SingleOrDefault
                    If IsNothing(oDet) Then
                        oDet = New DetalleClientes
                        oDet.IdCliente = myCliente.Id
                        oDet.Acciones = "EmailFacturacionElectronica"
                        oDet.Email = myCliente.EmailFacturacionElectronica
                        db.DetalleClientes.InsertOnSubmit(oDet)
                    Else
                        oDet.Email = myCliente.EmailFacturacionElectronica
                    End If
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try

                Try

                    Dim oDet As DetalleClientes = (From i In db.DetalleClientes _
                                                        Where i.IdCliente = myCliente.Id _
                                                        And i.Acciones = "AutorizacionSyngenta"
                                                    ).SingleOrDefault
                    If IsNothing(oDet) Then
                        oDet = New DetalleClientes
                        oDet.IdCliente = myCliente.Id
                        oDet.Acciones = "AutorizacionSyngenta"
                        oDet.Contacto = myCliente.AutorizacionSyngenta
                        db.DetalleClientes.InsertOnSubmit(oDet)
                    Else
                        oDet.Contacto = myCliente.AutorizacionSyngenta
                    End If
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try

                Try

                    Dim oDet As DetalleClientes = (From i In db.DetalleClientes _
                                                        Where i.IdCliente = myCliente.Id _
                                                        And i.Acciones = "EsExportadorCartaPorte"
                                                    ).SingleOrDefault
                    If IsNothing(oDet) Then
                        oDet = New DetalleClientes
                        oDet.IdCliente = myCliente.Id
                        oDet.Acciones = "EsExportadorCartaPorte"
                        oDet.Contacto = myCliente.EsClienteExportador
                        db.DetalleClientes.InsertOnSubmit(oDet)
                    Else
                        oDet.Contacto = myCliente.EsClienteExportador
                    End If
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try



                Try

                    Dim oDet As DetalleClientes = (From i In db.DetalleClientes _
                                                        Where i.IdCliente = myCliente.Id _
                                                        And i.Acciones = "UsaGastosAdmin"
                                                    ).SingleOrDefault
                    If IsNothing(oDet) Then
                        oDet = New DetalleClientes
                        oDet.IdCliente = myCliente.Id
                        oDet.Acciones = "UsaGastosAdmin"
                        oDet.Contacto = myCliente.UsaGastosAdmin
                        db.DetalleClientes.InsertOnSubmit(oDet)
                    Else
                        oDet.Contacto = myCliente.UsaGastosAdmin
                    End If
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try



                Try

                    Dim oDet As DetalleClientes = (From i In db.DetalleClientes _
                                                        Where i.IdCliente = myCliente.Id _
                                                        And i.Acciones = "DeshabilitadoPorCobranzas"
                                                    ).SingleOrDefault
                    If IsNothing(oDet) Then
                        oDet = New DetalleClientes
                        oDet.IdCliente = myCliente.Id
                        oDet.Acciones = "DeshabilitadoPorCobranzas"
                        oDet.Contacto = myCliente.UsaGastosAdmin
                        db.DetalleClientes.InsertOnSubmit(oDet)
                    Else
                        oDet.Contacto = myCliente.DeshabilitadoPorCobranzas
                    End If
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try


                db.SubmitChanges()

            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try





            'todo: no hay manera de grabar los datos anteriores?
            EntidadManager.LogPronto(SC, myCliente.Id, "Cliente", sNombreUsuario)

            Return myCliente.Id

        End Function


        '<DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As ProveedorList
            'Return ProveedorDB.GetList(SC)
        End Function

        '<DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            'Return ProveedorDB.GetList_fm(SC)
        End Function

        '<DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListDataset(ByVal SC As String) As System.Data.DataSet



            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As Data.DataSet
            'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            'With dc
            '    .ColumnName = "ColumnaTilde"
            '    .DataType = System.Type.GetType("System.Int32")
            '    .DefaultValue = 0
            'End With

            ds = EntidadManager.TraerDatos(SC, "wClientes_TT")

            'Try
            '    ds = EntidadManager.TraerDatos(SC, "wClientes_T", -1)
            'Catch ex As Exception
            '    ds = EntidadManager.TraerDatos(SC, "wClientes_TT")
            '    'ds = EntidadManager.TraerDatos(SC, "Clientes_TT")
            'End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdCliente").ColumnName = "Id"
                '.Columns("NumeroRequerimiento").ColumnName = "Numero"
                '.Columns("FechaRequerimiento").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
            Return ds

        End Function

        '<DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListDatasetWHERE(ByVal SC As String, ByVal ColumnaParaFiltrar As String, ByVal TextoParaFiltrar As String, ByVal sortExpression As String, ByVal startRowIndex As Long, ByVal maximumRows As Long) As System.Data.DataSet



            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As Data.DataSet
            'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            'With dc
            '    .ColumnName = "ColumnaTilde"
            '    .DataType = System.Type.GetType("System.Int32")
            '    .DefaultValue = 0
            'End With

            ds = EntidadManager.TraerDatos(SC, "wClientes_TT")

            'Try
            '    ds = EntidadManager.TraerDatos(SC, "wClientes_T", -1)
            'Catch ex As Exception
            '    ds = EntidadManager.TraerDatos(SC, "wClientes_TT")
            '    'ds = EntidadManager.TraerDatos(SC, "Clientes_TT")
            'End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdCliente").ColumnName = "Id"
                '.Columns("NumeroRequerimiento").ColumnName = "Numero"
                '.Columns("FechaRequerimiento").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
            Return ds

        End Function








        'Public Shared Function ConvertirComProntoClienteAPuntoNET(ByVal oCliente) As Pronto.ERP.BO.Cliente ' ) As Pronto.ERP.BO.Cliente
        '    Dim oDest As New Pronto.ERP.BO.Cliente

        '    '///////////////////////////
        '    '///////////////////////////
        '    'ENCABEZADO
        '    With oCliente.Registro


        '        oDest.Id = oCliente.Id



        '        'sp_columns Clientes  --para traer lista de columnas de la tabla




        '        oDest.RazonSocial = SQLtoNET(.Fields("RazonSocial"))
        '        oDest.Direccion = SQLtoNET(.Fields("Direccion"))
        '        oDest.IdLocalidad = SQLtoNET(.Fields("IdLocalidad"))
        '        oDest.CodigoPostal = SQLtoNET(.Fields("CodigoPostal"))
        '        oDest.IdProvincia = SQLtoNET(.Fields("IdProvincia"))
        '        oDest.IdPais = SQLtoNET(.Fields("IdPais"))
        '        oDest.Telefono1 = SQLtoNET(.Fields("Telefono"))
        '        oDest.Fax = SQLtoNET(.Fields("Fax"))
        '        oDest.Email = iisNull(.Fields("Email").Value)
        '        oDest.Cuit = iisNull(.Fields("Cuit").Value)
        '        oDest.IdCodigoIva = iisNull(.Fields("IdCodigoIva").Value, 0)
        '        oDest.FechaAlta = SQLtoNET(.Fields("FechaAlta"))
        '        oDest.Contacto = SQLtoNET(.Fields("Contacto"))
        '        oDest.EnviarEmail = SQLtoNET(.Fields("EnviarEmail"))
        '        oDest.IdCuenta = SQLtoNET(.Fields("IdCuenta"))
        '        oDest.IGCondicion = SQLtoNET(.Fields("IGCondicion"))
        '        oDest.IdMoneda = SQLtoNET(.Fields("IdMoneda"))
        '        oDest.IBNumeroInscripcion = SQLtoNET(.Fields("IBNumeroInscripcion"))
        '        oDest.IBCondicion = SQLtoNET(.Fields("IBCondicion"))
        '        oDest.IdUsuarioIngreso = SQLtoNET(.Fields("IdUsuarioIngreso"))
        '        oDest.FechaIngreso = SQLtoNET(.Fields("FechaIngreso"))
        '        oDest.IdUsuarioModifico = SQLtoNET(.Fields("IdUsuarioModifico"))
        '        oDest.FechaModifico = SQLtoNET(.Fields("FechaModifico"))
        '        oDest.PorcentajeIBDirecto = SQLtoNET(.Fields("PorcentajeIBDirecto"))
        '        oDest.FechaInicioVigenciaIBDirecto = SQLtoNET(.Fields("FechaInicioVigenciaIBDirecto"))
        '        oDest.FechaFinVigenciaIBDirecto = SQLtoNET(.Fields("FechaFinVigenciaIBDirecto"))
        '        oDest.GrupoIIBB = SQLtoNET(.Fields("GrupoIIBB"))
        '        oDest.IdListaPrecios = SQLtoNET(.Fields("IdListaPrecios"))
        '        oDest.IdIBCondicionPorDefecto = SQLtoNET(.Fields("IdIBCondicionPorDefecto"))
        '        oDest.Confirmado = SQLtoNET(.Fields("Confirmado"))
        '        oDest.CodigoPresto = SQLtoNET(.Fields("CodigoPresto"))
        '        oDest.Observaciones = iisNull(.Fields("Observaciones").Value)
        '        oDest.Importaciones_NumeroInscripcion = SQLtoNET(.Fields("Importaciones_NumeroInscripcion"))
        '        oDest.Importaciones_DenominacionInscripcion = SQLtoNET(.Fields("Importaciones_DenominacionInscripcion"))
        '        oDest.IdEstado = SQLtoNET(.Fields("IdEstado"))
        '        oDest.NombreFantasia = SQLtoNET(.Fields("NombreFantasia"))
        '        oDest.DireccionEntrega = SQLtoNET(.Fields("DireccionEntrega"))
        '        oDest.idLocalidadEntrega = SQLtoNET(.Fields("idLocalidadEntrega"))
        '        oDest.IdProvinciaEntrega = SQLtoNET(.Fields("IdProvinciaEntrega"))
        '        oDest.CodigoCliente = SQLtoNET(.Fields("CodigoCliente"))
        '        oDest.Saldo = SQLtoNET(.Fields("Saldo"))
        '        oDest.saldoDocumentos = SQLtoNET(.Fields("SaldoDocumentos"))
        '        oDest.Vendedor1 = SQLtoNET(.Fields("Vendedor1"))
        '        oDest.creditoMaximo = SQLtoNET(.Fields("CreditoMaximo"))
        '        oDest.IdCondicionVenta = SQLtoNET(.Fields("IdCondicionVenta"))
        '        oDest.tipoCliente = SQLtoNET(.Fields("TipoCliente"))
        '        oDest.codigo = SQLtoNET(.Fields("Codigo"))
        '        oDest.idcuentaMonedaExt = SQLtoNET(.Fields("IdCuentaMonedaExt"))
        '        oDest.Cobrador = SQLtoNET(.Fields("Cobrador"))
        '        oDest.Auxiliar = SQLtoNET(.Fields("Auxiliar"))
        '        oDest.IdIBCondicionPorDefecto2 = SQLtoNET(.Fields("IdIBCondicionPorDefecto2"))
        '        oDest.IdIBCondicionPorDefecto3 = SQLtoNET(.Fields("IdIBCondicionPorDefecto3"))
        '        oDest.esAgenteRetencionIVA = IIf(iisNull(.Fields("EsAgenteRetencionIVA").Value, "NO") = "SI", True, False)
        '        oDest.BaseMinimaParaPercepcionIVA = SQLtoNET(.Fields("BaseMinimaParaPercepcionIVA"))
        '        oDest.PorcentajePercepcionIVA = SQLtoNET(.Fields("PorcentajePercepcionIVA"))
        '        oDest.idbancoDebito = SQLtoNET(.Fields("IdBancoDebito"))
        '        oDest.CBU = SQLtoNET(.Fields("CBU"))
        '        Try
        '            oDest.PorcentajeIBDirectoCapital = SQLtoNET(.Fields("PorcentajeIBDirectoCapital"))
        '            oDest.FechaInicioVigenciaIBDirectoCapital = SQLtoNET(.Fields("FechaInicioVigenciaIBDirectoCapital"))
        '            oDest.FechaFinVigenciaIBDirectoCapital = SQLtoNET(.Fields("FechaFinVigenciaIBDirectoCapital"))
        '            oDest.GrupoIIBBCapital = SQLtoNET(.Fields("GrupoIIBBCapital"))
        '        Catch ex As Exception

        '        End Try


        '    End With


        '    ''///////////////////////////
        '    ''///////////////////////////
        '    ''DETALLE
        '    'Dim rsDet As adodb.Recordset = oCliente.DetClientes.TraerTodos

        '    'With rsDet
        '    '    If Not .EOF Then .MoveFirst()

        '    '    Do While Not .EOF

        '    '        Dim oDetCliente  = oCliente.DetClientes.Item(rsDet.Fields("IdDetalleCliente"))

        '    '        Dim item As New ClienteItem


        '    '        With oDetCliente.Registro

        '    '            item.IdArticulo = .Fields("IdArticulo").Value
        '    '            item.Articulo = rsDet.Fields(6).Value 'el nombre
        '    '            item.Cantidad = .Fields("Cantidad").Value
        '    '            item.Precio = .Fields("PrecioUnitario").Value
        '    '            item.PrecioUnitarioTotal = .Fields("PrecioUnitarioTotal").Value
        '    '            item.ImporteTotalItem = item.PrecioUnitarioTotal * item.Cantidad


        '    '            'item.Precio = .Fields("PrecioUnitarioTotal").Value
        '    '        End With

        '    '        oDest.Detalles.Add(item)
        '    '        .MoveNext()
        '    '    Loop

        '    'End With


        '    Return oDest
        'End Function







        '<DataObjectMethod(DataObjectMethodType.Delete, True)> _
        'Public Shared Function GetListParaWebService(ByVal SC As String, ByVal Busqueda As String) As ProveedorList
        '    'Return ProveedorDB.GetListParaWebService(SC, Busqueda)
        'End Function




        '<DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As ProveedorContactoList
            'Return ProveedorContactoDB.GetList(SC, id)
        End Function


        Public Shared Function Delete(ByVal SC As String, ByVal idCliente As Long) As Boolean
            Dim Aplicacion = ClaseMigrar.CrearAppCompronto(SC) '  = CrearAppCompronto(SC)
            Dim oClienteCOMPRONTO = Aplicacion.Clientes.Item(idCliente)
            oClienteCOMPRONTO.Eliminar()
        End Function

        '<DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myCliente As Pronto.ERP.BO.Cliente) As Boolean
            Dim Aplicacion = ClaseMigrar.CrearAppCompronto(SC)
            Dim oClienteCOMPRONTO = Aplicacion.Clientes.Item(myCliente.Id)
            oClienteCOMPRONTO.Eliminar()
            'Return ProveedorDB.Delete(SC, myProveedor.Id)
        End Function


        Public Shared Function Validar(ByVal SC As String, ByVal c As ClienteNuevo) As String

            If c.Eventual = "NO" Then
                If BDLMasterEmpresasManager.EmpresaPropietariaDeLaBase(SC) = "Williams" Then
                    If Not mkf_validacuit(c.Cuit) Then
                        Return "El CUIT no es valido"
                    End If
                    If c.IdLocalidad <= 0 Then Return "La localidad no es válida"
                    If c.Direccion = "" Then Return "Ingrese la dirección"
                    If c.CodigoPostal = "" Then Return "Ingrese el código postal"
                    If c.IdProvincia <= 0 Then Return "Ingrese la provincia"

                End If
            End If

            If c.Telefono1.Length > 30 Then Return "El telefono tiene como máximo 30 caracteres"

            If Trim(c.RazonSocial) = "" Then
                Return "La razón social está en blanco"
            End If

            '////////////////////////////////////////////////
            '/////////         CUIT           ///////////////
            '////////////////////////////////////////////////
            If c.Cuit <> "" Then
                If Not mkf_validacuit(c.Cuit) Then
                    Return "El CUIT no es valido"
                End If

                If c.IdLocalidad <= 0 Then Return "La localidad no es válida"
                If c.IdCuenta <= 0 Then Return "La cuenta no es válida"


                'verificar que no existe el cuit 'en realidad lo debería verificar el objeto, no?
                'If (mvarId <= 0 Or BuscarClaveINI("Control estricto del CUIT") = "SI") And _
                Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Clientes", "TX_PorCuit", c.Cuit)
                If ds.Tables(0).Rows.Count > 0 Then
                    For Each dr As Data.DataRow In ds.Tables(0).Rows
                        If c.Id <> ds.Tables(0).Rows(0).Item(0) Then 'And IsNull(oRs.Fields("Exterior").Value) Then
                            Return "El CUIT ya fue asignado al cliente " & dr!RazonSocial
                        End If
                    Next
                End If
            Else
                'Se puede poner CUIT provisorio?
                'Return "El CUIT está vacío" 
            End If

            '////////////////////////////////////////////////
            '////////////////////////////////////////////////
            '////////////////////////////////////////////////

            Return ""
        End Function
    End Class


    Class ClienteDB

        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Pronto.ERP.BO.ClienteNuevo
            Dim myCliente As Pronto.ERP.BO.ClienteNuevo = Nothing
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Try


                Dim myCommand As SqlCommand = New SqlCommand(enumSPs.Clientes_T.ToString, myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.AddWithValue("@IdCliente", id)
                myConnection.Open()
                Dim myReader As SqlDataReader = myCommand.ExecuteReader
                Try
                    If myReader.Read Then
                        myCliente = FillDataRecord(myReader)
                    End If
                    myReader.Close()
                Finally
                    CType(myReader, IDisposable).Dispose()
                End Try
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return myCliente
        End Function

        Private Shared Function FillDataRecord(ByVal myDataRecord As IDataRecord) As Pronto.ERP.BO.ClienteNuevo
            Dim myCliente As Pronto.ERP.BO.ClienteNuevo = New Pronto.ERP.BO.ClienteNuevo
            With myCliente


                SQLtoNET(myDataRecord, "@IdCliente", .Id)



                SQLtoNET(myDataRecord, "@RazonSocial", .RazonSocial)
                SQLtoNET(myDataRecord, "@Direccion", .Direccion)
                SQLtoNET(myDataRecord, "@IdLocalidad", .IdLocalidad)
                SQLtoNET(myDataRecord, "@CodigoPostal", .CodigoPostal)
                SQLtoNET(myDataRecord, "@IdProvincia", .IdProvincia)
                SQLtoNET(myDataRecord, "@IdPais", .IdPais)
                SQLtoNET(myDataRecord, "@Telefono", .Telefono1)
                SQLtoNET(myDataRecord, "@Fax", .Fax)
                SQLtoNET(myDataRecord, "@Email", .Email)
                SQLtoNET(myDataRecord, "@Cuit", .Cuit)
                SQLtoNET(myDataRecord, "@IdCodigoIva", .IdCodigoIva)
                SQLtoNET(myDataRecord, "@FechaAlta", .FechaAlta)
                SQLtoNET(myDataRecord, "@Contacto", .Contacto)
                SQLtoNET(myDataRecord, "@EnviarEmail", .EnviarEmail)
                SQLtoNET(myDataRecord, "@IdCuenta", .IdCuenta)
                SQLtoNET(myDataRecord, "@IGCondicion", .IGCondicion)



                SQLtoNET(myDataRecord, "@IdMoneda", .IdMoneda)
                SQLtoNET(myDataRecord, "@IBNumeroInscripcion", .IBNumeroInscripcion)
                SQLtoNET(myDataRecord, "@IBCondicion", .IBCondicion)
                SQLtoNET(myDataRecord, "@IdUsuarioIngreso", .IdUsuarioIngreso)
                SQLtoNET(myDataRecord, "@FechaIngreso", .FechaIngreso)





                SQLtoNET(myDataRecord, "@IdUsuarioModifico", .IdUsuarioModifico)
                SQLtoNET(myDataRecord, "@FechaModifico", .FechaModifico)
                SQLtoNET(myDataRecord, "@PorcentajeIBDirecto", .PorcentajeIBDirecto)
                SQLtoNET(myDataRecord, "@FechaInicioVigenciaIBDirecto", .FechaInicioVigenciaIBDirecto)
                SQLtoNET(myDataRecord, "@FechaFinVigenciaIBDirecto", .FechaFinVigenciaIBDirecto)
                SQLtoNET(myDataRecord, "@GrupoIIBB", .GrupoIIBB)
                SQLtoNET(myDataRecord, "@IdListaPrecios", .IdListaPrecios)
                SQLtoNET(myDataRecord, "@IdIBCondicionPorDefecto", .IdIBCondicionPorDefecto)
                SQLtoNET(myDataRecord, "@Confirmado", .Confirmado)
                SQLtoNET(myDataRecord, "@CodigoPresto", .CodigoPresto)
                SQLtoNET(myDataRecord, "@Observaciones", .Observaciones)
                SQLtoNET(myDataRecord, "@Importaciones_NumeroInscripcion", .Importaciones_NumeroInscripcion)



                SQLtoNET(myDataRecord, "@Importaciones_DenominacionInscripcion", .Importaciones_DenominacionInscripcion)
                SQLtoNET(myDataRecord, "@IdEstado", .IdEstado)
                SQLtoNET(myDataRecord, "@NombreFantasia", .NombreFantasia)
                SQLtoNET(myDataRecord, "@DireccionEntrega", .DireccionEntrega)
                SQLtoNET(myDataRecord, "@idLocalidadEntrega", .IdLocalidadEntrega)
                SQLtoNET(myDataRecord, "@IdProvinciaEntrega", .IdProvinciaEntrega)
                SQLtoNET(myDataRecord, "@CodigoCliente", .CodigoCliente)
                SQLtoNET(myDataRecord, "@Saldo", .Saldo)
                SQLtoNET(myDataRecord, "@saldoDocumentos", .saldoDocumentos)


                SQLtoNET(myDataRecord, "@Vendedor1", .Vendedor1)
                SQLtoNET(myDataRecord, "@creditoMaximo", .creditoMaximo)
                SQLtoNET(myDataRecord, "@IdCondicionVenta", .IdCondicionVenta)
                SQLtoNET(myDataRecord, "@tipoCliente", .tipoCliente)
                SQLtoNET(myDataRecord, "@codigo", .codigo)
                SQLtoNET(myDataRecord, "@idcuentaMonedaExt", .idcuentaMonedaExt)
                SQLtoNET(myDataRecord, "@Cobrador", .Cobrador)


                SQLtoNET(myDataRecord, "@Auxiliar", .Auxiliar)
                SQLtoNET(myDataRecord, "@IdIBCondicionPorDefecto2", .IdIBCondicionPorDefecto2)
                SQLtoNET(myDataRecord, "@IdIBCondicionPorDefecto3", .IdIBCondicionPorDefecto3)

                Dim sTemp As String
                SQLtoNET(myDataRecord, "@esAgenteRetencionIVA", sTemp)
                IIf(iisNull(sTemp, "NO") = "SI", True, False)

                SQLtoNET(myDataRecord, "@BaseMinimaParaPercepcionIVA", .BaseMinimaParaPercepcionIVA)
                SQLtoNET(myDataRecord, "@PorcentajePercepcionIVA", .PorcentajePercepcionIVA)
                SQLtoNET(myDataRecord, "@idbancoDebito", .idbancoDebito)
                SQLtoNET(myDataRecord, "@CBU", .CBU)
                SQLtoNET(myDataRecord, "@Cobrador", .Cobrador)


                Try
                    SQLtoNET(myDataRecord, "@PorcentajeIBDirectoCapital", .PorcentajeIBDirectoCapital)
                    SQLtoNET(myDataRecord, "@FechaInicioVigenciaIBDirectoCapital", .FechaInicioVigenciaIBDirectoCapital)
                    SQLtoNET(myDataRecord, "@FechaFinVigenciaIBDirectoCapital", .FechaFinVigenciaIBDirectoCapital)
                    SQLtoNET(myDataRecord, "@GrupoIIBBCapital", .GrupoIIBBCapital)


                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try



                Return myCliente
            End With
        End Function


        Public Shared Function Save(ByVal SC As String, ByVal myCliente As Pronto.ERP.BO.ClienteNuevo) As Integer



            Dim result As Integer = 0
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            Dim Transaccion As SqlTransaction
            myConnection.Open()
            Transaccion = myConnection.BeginTransaction()
            Try
                Dim myCommand As SqlCommand
                With myCliente


                    If .Id = -1 Then

                        myCommand = New SqlCommand("wClientes_A", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        Dim param As SqlParameter = myCommand.Parameters.AddWithValue("@IdCliente", -1)
                        param.Direction = ParameterDirection.Output

                    Else

                        myCommand = New SqlCommand("wClientes_M", myConnection)

                        myCommand.Transaction = Transaccion
                        myCommand.CommandType = CommandType.StoredProcedure

                        myCommand.Parameters.AddWithValue("@IdCliente", .Id)
                    End If



                    NETtoSQL(myCommand, "@RazonSocial", .RazonSocial)
                    NETtoSQL(myCommand, "@Direccion", .Direccion)
                    NETtoSQL(myCommand, "@IdLocalidad", .IdLocalidad)
                    NETtoSQL(myCommand, "@CodigoPostal", .CodigoPostal)
                    NETtoSQL(myCommand, "@IdProvincia", .IdProvincia)
                    NETtoSQL(myCommand, "@IdPais", .IdPais)
                    NETtoSQL(myCommand, "@Telefono", .Telefono1)
                    NETtoSQL(myCommand, "@Fax", .Fax)
                    NETtoSQL(myCommand, "@Email", .Email)
                    NETtoSQL(myCommand, "@Cuit", .Cuit)
                    NETtoSQL(myCommand, "@IdCodigoIva", .IdCodigoIva)
                    NETtoSQL(myCommand, "@FechaAlta", .FechaAlta)
                    NETtoSQL(myCommand, "@Contacto", .Contacto)
                    NETtoSQL(myCommand, "@EnviarEmail", .EnviarEmail)
                    NETtoSQL(myCommand, "@IdCuenta", .IdCuenta)
                    NETtoSQL(myCommand, "@IGCondicion", .IGCondicion)



                    NETtoSQL(myCommand, "@IdMoneda", .IdMoneda)
                    NETtoSQL(myCommand, "@IBNumeroInscripcion", .IBNumeroInscripcion)
                    NETtoSQL(myCommand, "@IBCondicion", .IBCondicion)
                    NETtoSQL(myCommand, "@IdUsuarioIngreso", .IdUsuarioIngreso)
                    NETtoSQL(myCommand, "@FechaIngreso", .FechaIngreso)





                    NETtoSQL(myCommand, "@IdUsuarioModifico", .IdUsuarioModifico)
                    NETtoSQL(myCommand, "@FechaModifico", .FechaModifico)
                    NETtoSQL(myCommand, "@PorcentajeIBDirecto", .PorcentajeIBDirecto)
                    NETtoSQL(myCommand, "@FechaInicioVigenciaIBDirecto", .FechaInicioVigenciaIBDirecto)
                    NETtoSQL(myCommand, "@FechaFinVigenciaIBDirecto", .FechaFinVigenciaIBDirecto)
                    NETtoSQL(myCommand, "@GrupoIIBB", .GrupoIIBB)
                    NETtoSQL(myCommand, "@IdListaPrecios", .IdListaPrecios)
                    NETtoSQL(myCommand, "@IdIBCondicionPorDefecto", .IdIBCondicionPorDefecto)
                    NETtoSQL(myCommand, "@Confirmado", .Confirmado)
                    NETtoSQL(myCommand, "@CodigoPresto", .CodigoPresto)
                    NETtoSQL(myCommand, "@Observaciones", .Observaciones)
                    NETtoSQL(myCommand, "@Importaciones_NumeroInscripcion", .Importaciones_NumeroInscripcion)



                    NETtoSQL(myCommand, "@Importaciones_DenominacionInscripcion", .Importaciones_DenominacionInscripcion)
                    NETtoSQL(myCommand, "@IdEstado", .IdEstado)
                    NETtoSQL(myCommand, "@NombreFantasia", .NombreFantasia)
                    NETtoSQL(myCommand, "@DireccionEntrega", .DireccionEntrega)
                    NETtoSQL(myCommand, "@IdLocalidadEntrega", .IdLocalidadEntrega)
                    NETtoSQL(myCommand, "@IdProvinciaEntrega", .IdProvinciaEntrega)
                    NETtoSQL(myCommand, "@CodigoCliente", .CodigoCliente)
                    NETtoSQL(myCommand, "@Saldo", .Saldo)
                    NETtoSQL(myCommand, "@saldoDocumentos", .saldoDocumentos)


                    NETtoSQL(myCommand, "@Vendedor1", .Vendedor1)
                    NETtoSQL(myCommand, "@creditoMaximo", .creditoMaximo)
                    NETtoSQL(myCommand, "@IdCondicionVenta", .IdCondicionVenta)
                    NETtoSQL(myCommand, "@tipoCliente", .tipoCliente)
                    NETtoSQL(myCommand, "@codigo", .codigo)
                    NETtoSQL(myCommand, "@idcuentaMonedaExt", .idcuentaMonedaExt)
                    NETtoSQL(myCommand, "@Cobrador", .Cobrador)


                    NETtoSQL(myCommand, "@Auxiliar", .Auxiliar)
                    NETtoSQL(myCommand, "@IdIBCondicionPorDefecto2", .IdIBCondicionPorDefecto2)
                    NETtoSQL(myCommand, "@IdIBCondicionPorDefecto3", .IdIBCondicionPorDefecto3)
                    NETtoSQL(myCommand, "@esAgenteRetencionIVA", IIf(.esAgenteRetencionIVA, "SI", "NO"))
                    NETtoSQL(myCommand, "@BaseMinimaParaPercepcionIVA", .BaseMinimaParaPercepcionIVA)
                    NETtoSQL(myCommand, "@PorcentajePercepcionIVA", .PorcentajePercepcionIVA)
                    NETtoSQL(myCommand, "@idbancoDebito", .idbancoDebito)
                    NETtoSQL(myCommand, "@CBU", .CBU)


                    Try
                        NETtoSQL(myCommand, "@PorcentajeIBDirectoCapital", .PorcentajeIBDirectoCapital)
                        NETtoSQL(myCommand, "@FechaInicioVigenciaIBDirectoCapital", .FechaInicioVigenciaIBDirectoCapital)
                        NETtoSQL(myCommand, "@FechaFinVigenciaIBDirectoCapital", .FechaFinVigenciaIBDirectoCapital)
                        NETtoSQL(myCommand, "@GrupoIIBBCapital", .GrupoIIBBCapital)


                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try



                    Dim returnValue As DbParameter
                    returnValue = myCommand.CreateParameter
                    returnValue.Direction = ParameterDirection.ReturnValue
                    myCommand.Parameters.Add(returnValue)
                    'myConnection.Open()
                    myCommand.ExecuteNonQuery()
                    result = Convert.ToInt32(returnValue.Value)

                    'For Each myOrdenPagoItem As OrdenPagoItem In myOrdenPago.DetallesImputaciones
                    '    myOrdenPagoItem.IdOrdenPago = result




                    '    If myOrdenPagoItem.Eliminado Then
                    '        'EntidadManager.GetStoreProcedure(SC, "DetOrdenPagos_E", .Id)
                    '    Else
                    '        Dim IdAntesDeGrabar = myOrdenPagoItem.Id
                    '        myOrdenPagoItem.Id = OrdenPagoItemDB.Save(SC, myOrdenPagoItem)


                    '        'Como un item nuevo consiguió un nuevo id al grabarse, 
                    '        'lo tengo que refrescar en el resto de las colecciones
                    '        'de imputacion (en el prontovb6, se usaba -100,-101,etc)
                    '        '-OK, eso si los items del resto de las colecciones (Valores,Cuentas)
                    '        'estuviesen imputadas contra la de Imputaciones. Pero, de donde demonios saqué
                    '        'que esto es así?

                    '        'For Each o As OrdenPagoAnticiposAlPersonalItem In .DetallesAnticiposAlPersonal
                    '        '    If o. = IdAntesDeGrabar Then
                    '        '        o. = myOrdenPagoItem.Id
                    '        '    End If
                    '        'Next

                    '        'For Each o As OrdenPagoCuentasItem In .DetallesCuentas
                    '        '    If o. = IdAntesDeGrabar Then
                    '        '        o. = myOrdenPagoItem.Id
                    '        '    End If
                    '        'Next
                    '    End If
                    'Next


                    ''//////////////////////////////////////////////////////////////////////////////////////
                    'Colecciones adicionales
                    ''//////////////////////////////////////////////////////////////////////////////////////

                    'For Each myOrdenPagoAnticiposAlPersonalItem As OrdenPagoAnticiposAlPersonalItem In myOrdenPago.DetallesAnticiposAlPersonal
                    '    myOrdenPagoAnticiposAlPersonalItem.IdOrdenPago = result
                    '    OrdenPagoAnticiposAlPersonalItemDB.Save(SC, myOrdenPagoAnticiposAlPersonalItem)
                    'Next
                    'For Each myOrdenPagoCuentasItem As OrdenPagoCuentasItem In myOrdenPago.DetallesCuentas
                    '    myOrdenPagoCuentasItem.IdOrdenPago = result
                    '    OrdenPagoCuentasItemDB.Save(SC, myOrdenPagoCuentasItem)
                    'Next




                End With
                Transaccion.Commit()
                myConnection.Close()
            Catch e As Exception
                Transaccion.Rollback()
                ErrHandler.WriteAndRaiseError(e)
                'Return -1 'qué conviene usar? disparar errores o devolver -1?
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
            Return result
        End Function
    End Class
End Namespace





