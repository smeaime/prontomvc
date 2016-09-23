Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class Proveedor
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