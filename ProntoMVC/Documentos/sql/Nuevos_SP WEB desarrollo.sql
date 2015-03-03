

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
-- SPs de Web originales de Edu
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////


--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].GetCountRequemientoForEmployee')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE GetCountRequemientoForEmployee
go

CREATE PROCEDURE GetCountRequemientoForEmployee @IdSolicito INT
AS 
    DECLARE @rowcount INT
    SELECT  @rowcount = COUNT(*)
    FROM    Requerimientos
    WHERE   IdSolicito = @IdSolicito
            AND Cumplido <> 'AN'

    IF @rowcount > 0 
        BEGIN
            RETURN @rowcount
        END
    ELSE 
        BEGIN
            RETURN 0
        END
GO

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wArticulos_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wArticulos_A]
go

CREATE PROCEDURE [dbo].[wArticulos_A]
    @IdArticulo INT,
    @Codigo VARCHAR(20),
    @NumeroInventario VARCHAR(20),
    @Descripcion VARCHAR(256),
    @IdRubro INT,
    @IdSubrubro INT,
    @IdUnidad INT,
    @AlicuotaIVA NUMERIC(6, 2),
    @CostoPPP NUMERIC(18, 2),
    @CostoPPPDolar NUMERIC(18, 2),
    @CostoReposicion NUMERIC(18, 2),
    @CostoReposicionDolar NUMERIC(18, 2),
    @Observaciones NTEXT,
    @AuxiliarString5 VARCHAR(50),
    @AuxiliarString6 VARCHAR(50),
    @AuxiliarString7 VARCHAR(50)
AS 
    IF ISNULL(@IdArticulo, 0) <= 0 
        BEGIN
            INSERT  INTO Articulos
                    (
                      Codigo,
                      NumeroInventario,
                      Descripcion,
                      IdRubro,
                      IdSubrubro,
                      IdUnidad,
                      AlicuotaIVA,
                      CostoPPP,
                      CostoPPPDolar,
                      CostoReposicion,
                      CostoReposicionDolar,
                      Observaciones,
                      AuxiliarString5,
                      AuxiliarString6,
                      AuxiliarString7
	              )
            VALUES  (
                      @Codigo,
                      @NumeroInventario,
                      @Descripcion,
                      @IdRubro,
                      @IdSubrubro,
                      @IdUnidad,
                      @AlicuotaIVA,
                      @CostoPPP,
                      @CostoPPPDolar,
                      @CostoReposicion,
                      @CostoReposicionDolar,
                      @Observaciones,
                      @AuxiliarString5,
                      @AuxiliarString6,
                      @AuxiliarString7
	              )
	
            SELECT  @IdArticulo = @@identity
        END
    ELSE 
        BEGIN
            UPDATE  Articulos
            SET     Codigo = @Codigo,
                    NumeroInventario = @NumeroInventario,
                    Descripcion = @Descripcion,
                    IdRubro = @IdRubro,
                    IdSubrubro = @IdSubrubro,
                    IdUnidad = @IdUnidad,
                    AlicuotaIVA = @AlicuotaIVA,
                    CostoPPP = @CostoPPP,
                    CostoPPPDolar = @CostoPPPDolar,
                    CostoReposicion = @CostoReposicion,
                    CostoReposicionDolar = @CostoReposicionDolar,
                    Observaciones = @Observaciones,
                    AuxiliarString5 = @AuxiliarString5,
                    AuxiliarString6 = @AuxiliarString6,
                    AuxiliarString7 = @AuxiliarString7
            WHERE   ( IdArticulo = @IdArticulo )
        END

    IF @@ERROR <> 0 
        RETURN -1
    ELSE 
        RETURN @IdArticulo
GO



--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wArticulos_T]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wArticulos_T]
go

CREATE PROCEDURE [dbo].[wArticulos_T] @IdArticulo INT = NULL
AS 
    SET @IdArticulo = ISNULL(@IdArticulo, -1)

    SELECT Articulos.*,
            Rubros.Descripcion AS [Rubro],
            Subrubros.Descripcion AS [Subrubro],
            ( SELECT    SUM(Stock.CantidadUnidades)
              FROM      Stock
              WHERE     Stock.IdArticulo = Articulos.IdArticulo
            ) AS [Stock actual],
            ( SELECT TOP 1
                        Unidades.Abreviatura
              FROM      Unidades
              WHERE     Articulos.IdUnidad = Unidades.IdUnidad
            ) AS [Un],
            ISNULL(Depositos.Abreviatura, Depositos.Descripcion) + ISNULL(', ' + Ubicaciones.Descripcion, '')
            + ISNULL(' - Est.:' + Ubicaciones.Estanteria, '')
            + ISNULL(' - Mod.:' + Ubicaciones.Modulo, '') + ISNULL(' - Gab.:' + Ubicaciones.Gabeta, '') AS [Ubicacion],
            Unidades.Abreviatura AS [Unidad],
			
 Articulos.Codigo as [Codigo material],  
 Articulos.Descripcion,  
 Articulos.IdArticulo as [Identificador],  
 Rubros.Descripcion as [Rubro],  
 Subrubros.Descripcion as [Subrubro],  
 Articulos.NumeroInventario as [Nro.inv.],  
 Articulos.AlicuotaIVA as [% IVA],  
 Case When Articulos.CostoPPP=0 Then Null Else Articulos.CostoPPP End as [Costo PPP],  
 Case When Articulos.CostoPPPDolar=0 Then Null Else Articulos.CostoPPPDolar End as [Costo PPP u$s],  
 Case When Articulos.CostoReposicion=0 Then Null Else Articulos.CostoReposicion End as [Costo Rep.],  
 Case When Articulos.CostoReposicionDolar=0 Then Null Else Articulos.CostoReposicionDolar End as [Costo Rep u$s],  
 Articulos.StockMinimo as [Stock Min.],  
 Articulos.StockReposicion as [Stock Rep.],  
 (Select Sum(Stock.CantidadUnidades) From Stock Where Stock.IdArticulo=Articulos.IdArticulo) as [Stock actual],  
 (Select Top 1 Unidades.Abreviatura From Unidades Where Articulos.IdUnidad=Unidades.IdUnidad) as [En],  
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+  
 IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+  
 IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+  
 IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+  
 IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],  
 Articulos.FechaAlta as [Fecha alta],  
 Articulos.UsuarioAlta as [Usuario alta],  
 Articulos.FechaUltimaModificacion as [Fecha ult.modif.],  
 Articulos.ParaMantenimiento as [p/mant.],  
 Articulos.AuxiliarString10 as [NMC]  
 --Cuentas.Codigo as [Cod.Cta.Compras],  
 --Cuentas.Descripcion as [Cuenta de compras]
    FROM    Articulos
            LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
            LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro
            LEFT OUTER JOIN Ubicaciones ON Articulos.IdUbicacionStandar = Ubicaciones.IdUbicacion
            LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
            LEFT OUTER JOIN Unidades ON Articulos.IdUnidad = Unidades.IdUnidad
    WHERE   ( @IdArticulo = -1
              OR Articulos.IdArticulo = @IdArticulo
            ) --and IsNull(Articulos.Activo,'')<>'NO'
    ORDER BY Rubros.Descripcion,
            Subrubros.Descripcion,
            Articulos.Codigo

GO
 
--exec wArticulos_t -1

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wArticulos_TL]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wArticulos_TL]
go


CREATE PROCEDURE [dbo].[wArticulos_TL]
AS 
    SELECT  IdArticulo,
            Descripcion AS [Titulo]
    FROM    Articulos
    ORDER BY Descripcion
GO

--exec [wArticulos_TL]

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wRequerimientos_N]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wRequerimientos_N]
go

CREATE PROCEDURE [dbo].[wRequerimientos_N] @IdRequerimiento INT
AS 
    UPDATE  Requerimientos
    SET     Cumplido = 'AN'
    WHERE   IdRequerimiento = @IdRequerimiento
    UPDATE  DetalleRequerimientos
    SET     Cumplido = 'AN'
    WHERE   IdRequerimiento = @IdRequerimiento
GO


--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////


--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wProveedores_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wProveedores_A]
go


CREATE PROCEDURE [dbo].[wProveedores_A]
    @IdProveedor INT,
    @RazonSocial VARCHAR(50),
    @Direccion VARCHAR(50),
    @IdLocalidad SMALLINT,
    @CodigoPostal VARCHAR(30),
    @IdProvincia TINYINT,
    @IdPais INT,
    @Telefono1 VARCHAR(50),
    @Telefono2 VARCHAR(50),
    @Fax VARCHAR(50),
    @Email VARCHAR(50),
    @Cuit VARCHAR(13),
    @IdCodigoIva TINYINT,
    @FechaAlta DATETIME,
    @FechaUltimaCompra DATETIME,
    @Excencion NUMERIC(6, 2),
    @IdCondicionCompra INT,
    @Contacto VARCHAR(50),
    @IdActividad INT,
    @Nif VARCHAR(30),
    @IdEstado INT,
    @EstadoFecha DATETIME,
    @EstadoUsuario VARCHAR(20),
    @AltaUsuario VARCHAR(20),
    @CodigoEmpresa VARCHAR(20),
    @Nombre1 VARCHAR(100),
    @Nombre2 VARCHAR(100),
    @NombreFantasia VARCHAR(50),
    @IGCondicion INT,
    @IGCertificadoAutoretencion VARCHAR(2),
    @IGCertificadoNORetencion VARCHAR(2),
    @IGFechaCaducidadExencion DATETIME,
    @IGPorcentajeNORetencion NUMERIC(6, 2),
    @IvaAgenteRetencion VARCHAR(2),
    @IvaExencionRetencion VARCHAR(2),
    @IvaFechaCaducidadExencion DATETIME,
    @IvaPorcentajeExencion NUMERIC(6, 2),
    @IBNumeroInscripcion VARCHAR(20),
    @IBCondicion INT,
    @IBFechaCaducidadExencion DATETIME,
    @IBPorcentajeExencion NUMERIC(6, 2),
    @SSFechaCaducidadExencion DATETIME,
    @SSPorcentajeExcencion NUMERIC(6, 2),
    @PaginaWeb VARCHAR(50),
    @Habitual VARCHAR(2),
    @Observaciones NTEXT,
    @Saldo NUMERIC(18, 2),
    @CodigoProveedor INT,
    @IdCuenta INT,
    @IdMoneda INT,
    @LimiteCredito NUMERIC(18, 2),
    @TipoProveedor INT,
    @Eventual VARCHAR(2),
    @IdTipoRetencionGanancia INT,
    @Confirmado VARCHAR(2),
    @CodigoPresto VARCHAR(13),
    @BienesOServicios VARCHAR(1),
    @IdIBCondicionPorDefecto INT,
    @RetenerSUSS VARCHAR(2),
    @ChequesALaOrdenDe VARCHAR(50),
    @FechaLimiteExentoGanancias DATETIME,
    @FechaLimiteExentoIIBB DATETIME,
    @IdImpuestoDirectoSUSS INT,
    @Importaciones_NumeroInscripcion VARCHAR(20),
    @Importaciones_DenominacionInscripcion VARCHAR(10),
    @EnviarEmail TINYINT,
    @InformacionAuxiliar VARCHAR(50),
    @CoeficienteIIBBUnificado NUMERIC(6, 2),
    @FechaUltimaPresentacionDocumentacion DATETIME,
    @ObservacionesPresentacionDocumentacion NTEXT,
    @FechaLimiteCondicionIVA DATETIME,
    @CodigoSituacionRetencionIVA VARCHAR(1),
    @SUSSFechaCaducidadExencion DATETIME,
    @Calificacion INT,
    @IdUsuarioIngreso INT,
    @FechaIngreso DATETIME,
    @IdUsuarioModifico INT,
    @FechaModifico DATETIME,
    @Exterior VARCHAR(2),
    @SujetoEmbargado VARCHAR(2),
    @SaldoEmbargo NUMERIC(18, 2),
    @DetalleEmbargo VARCHAR(50),
    @PorcentajeIBDirecto NUMERIC(6, 2),
    @FechaInicioVigenciaIBDirecto DATETIME,
    @FechaFinVigenciaIBDirecto DATETIME,
    @GrupoIIBB INT
AS 
    IF ISNULL(@IdProveedor, 0) <= 0 
        BEGIN
            INSERT  INTO Proveedores
                    (
                      RazonSocial,
                      Direccion,
                      IdLocalidad,
                      CodigoPostal,
                      IdProvincia,
                      IdPais,
                      Telefono1,
                      Telefono2,
                      Fax,
                      Email,
                      Cuit,
                      IdCodigoIva,
                      FechaAlta,
                      FechaUltimaCompra,
                      Excencion,
                      IdCondicionCompra,
                      Contacto,
                      IdActividad,
                      Nif,
                      IdEstado,
                      EstadoFecha,
                      EstadoUsuario,
                      AltaUsuario,
                      CodigoEmpresa,
                      Nombre1,
                      Nombre2,
                      NombreFantasia,
                      IGCondicion,
                      IGCertificadoAutoretencion,
                      IGCertificadoNORetencion,
                      IGFechaCaducidadExencion,
                      IGPorcentajeNORetencion,
                      IvaAgenteRetencion,
                      IvaExencionRetencion,
                      IvaFechaCaducidadExencion,
                      IvaPorcentajeExencion,
                      IBNumeroInscripcion,
                      IBCondicion,
                      IBFechaCaducidadExencion,
                      IBPorcentajeExencion,
                      SSFechaCaducidadExencion,
                      SSPorcentajeExcencion,
                      PaginaWeb,
                      Habitual,
                      Observaciones,
                      Saldo,
                      CodigoProveedor,
                      IdCuenta,
                      IdMoneda,
                      LimiteCredito,
                      TipoProveedor,
                      Eventual,
                      IdTipoRetencionGanancia,
                      Confirmado,
                      CodigoPresto,
                      BienesOServicios,
                      IdIBCondicionPorDefecto,
                      RetenerSUSS,
                      ChequesALaOrdenDe,
                      FechaLimiteExentoGanancias,
                      FechaLimiteExentoIIBB,
                      IdImpuestoDirectoSUSS,
                      Importaciones_NumeroInscripcion,
                      Importaciones_DenominacionInscripcion,
                      EnviarEmail,
                      InformacionAuxiliar,
                      CoeficienteIIBBUnificado,
                      FechaUltimaPresentacionDocumentacion,
                      ObservacionesPresentacionDocumentacion,
                      FechaLimiteCondicionIVA,
                      CodigoSituacionRetencionIVA,
                      SUSSFechaCaducidadExencion,
                      Calificacion,
                      IdUsuarioIngreso,
                      FechaIngreso,
                      IdUsuarioModifico,
                      FechaModifico,
                      Exterior,
                      SujetoEmbargado,
                      SaldoEmbargo,
                      DetalleEmbargo,
                      PorcentajeIBDirecto,
                      FechaInicioVigenciaIBDirecto,
                      FechaFinVigenciaIBDirecto,
                      GrupoIIBB
	              )
            VALUES  (
                      @RazonSocial,
                      @Direccion,
                      @IdLocalidad,
                      @CodigoPostal,
                      @IdProvincia,
                      @IdPais,
                      @Telefono1,
                      @Telefono2,
                      @Fax,
                      @Email,
                      @Cuit,
                      @IdCodigoIva,
                      @FechaAlta,
                      @FechaUltimaCompra,
                      @Excencion,
                      @IdCondicionCompra,
                      @Contacto,
                      @IdActividad,
                      @Nif,
                      @IdEstado,
                      @EstadoFecha,
                      @EstadoUsuario,
                      @AltaUsuario,
                      @CodigoEmpresa,
                      @Nombre1,
                      @Nombre2,
                      @NombreFantasia,
                      @IGCondicion,
                      @IGCertificadoAutoretencion,
                      @IGCertificadoNORetencion,
                      @IGFechaCaducidadExencion,
                      @IGPorcentajeNORetencion,
                      @IvaAgenteRetencion,
                      @IvaExencionRetencion,
                      @IvaFechaCaducidadExencion,
                      @IvaPorcentajeExencion,
                      @IBNumeroInscripcion,
                      @IBCondicion,
                      @IBFechaCaducidadExencion,
                      @IBPorcentajeExencion,
                      @SSFechaCaducidadExencion,
                      @SSPorcentajeExcencion,
                      @PaginaWeb,
                      @Habitual,
                      @Observaciones,
                      @Saldo,
                      @CodigoProveedor,
                      @IdCuenta,
                      @IdMoneda,
                      @LimiteCredito,
                      @TipoProveedor,
                      @Eventual,
                      @IdTipoRetencionGanancia,
                      @Confirmado,
                      @CodigoPresto,
                      @BienesOServicios,
                      @IdIBCondicionPorDefecto,
                      @RetenerSUSS,
                      @ChequesALaOrdenDe,
                      @FechaLimiteExentoGanancias,
                      @FechaLimiteExentoIIBB,
                      @IdImpuestoDirectoSUSS,
                      @Importaciones_NumeroInscripcion,
                      @Importaciones_DenominacionInscripcion,
                      @EnviarEmail,
                      @InformacionAuxiliar,
                      @CoeficienteIIBBUnificado,
                      @FechaUltimaPresentacionDocumentacion,
                      @ObservacionesPresentacionDocumentacion,
                      @FechaLimiteCondicionIVA,
                      @CodigoSituacionRetencionIVA,
                      @SUSSFechaCaducidadExencion,
                      @Calificacion,
                      @IdUsuarioIngreso,
                      @FechaIngreso,
                      @IdUsuarioModifico,
                      @FechaModifico,
                      @Exterior,
                      @SujetoEmbargado,
                      @SaldoEmbargo,
                      @DetalleEmbargo,
                      @PorcentajeIBDirecto,
                      @FechaInicioVigenciaIBDirecto,
                      @FechaFinVigenciaIBDirecto,
                      @GrupoIIBB
	              )
            SELECT  @IdProveedor = @@identity
        END
    ELSE 
        BEGIN
            UPDATE  Proveedores
            SET     RazonSocial = @RazonSocial,
                    Direccion = @Direccion,
                    IdLocalidad = @IdLocalidad,
                    CodigoPostal = @CodigoPostal,
                    IdProvincia = @IdProvincia,
                    IdPais = @IdPais,
                    Telefono1 = @Telefono1,
                    Telefono2 = @Telefono2,
                    Fax = @Fax,
                    Email = @Email,
                    Cuit = @Cuit,
                    IdCodigoIva = @IdCodigoIva,
                    FechaAlta = @FechaAlta,
                    FechaUltimaCompra = @FechaUltimaCompra,
                    Excencion = @Excencion,
                    IdCondicionCompra = @IdCondicionCompra,
                    Contacto = @Contacto,
                    IdActividad = @IdActividad,
                    Nif = @Nif,
                    IdEstado = @IdEstado,
                    EstadoFecha = @EstadoFecha,
                    EstadoUsuario = @EstadoUsuario,
                    AltaUsuario = @AltaUsuario,
                    CodigoEmpresa = @CodigoEmpresa,
                    Nombre1 = @Nombre1,
                    Nombre2 = @Nombre2,
                    NombreFantasia = @NombreFantasia,
                    IGCondicion = @IGCondicion,
                    IGCertificadoAutoretencion = @IGCertificadoAutoretencion,
                    IGCertificadoNORetencion = @IGCertificadoNORetencion,
                    IGFechaCaducidadExencion = @IGFechaCaducidadExencion,
                    IGPorcentajeNORetencion = @IGPorcentajeNORetencion,
                    IvaAgenteRetencion = @IvaAgenteRetencion,
                    IvaExencionRetencion = @IvaExencionRetencion,
                    IvaFechaCaducidadExencion = @IvaFechaCaducidadExencion,
                    IvaPorcentajeExencion = @IvaPorcentajeExencion,
                    IBNumeroInscripcion = @IBNumeroInscripcion,
                    IBCondicion = @IBCondicion,
                    IBFechaCaducidadExencion = @IBFechaCaducidadExencion,
                    IBPorcentajeExencion = @IBPorcentajeExencion,
                    SSFechaCaducidadExencion = @SSFechaCaducidadExencion,
                    SSPorcentajeExcencion = @SSPorcentajeExcencion,
                    PaginaWeb = @PaginaWeb,
                    Habitual = @Habitual,
                    Observaciones = @Observaciones,
                    Saldo = @Saldo,
                    CodigoProveedor = @CodigoProveedor,
                    IdCuenta = @IdCuenta,
                    IdMoneda = @IdMoneda,
                    LimiteCredito = @LimiteCredito,
                    TipoProveedor = @TipoProveedor,
                    Eventual = @Eventual,
                    IdTipoRetencionGanancia = @IdTipoRetencionGanancia,
                    Confirmado = @Confirmado,
                    CodigoPresto = @CodigoPresto,
                    BienesOServicios = @BienesOServicios,
                    IdIBCondicionPorDefecto = @IdIBCondicionPorDefecto,
                    RetenerSUSS = @RetenerSUSS,
                    ChequesALaOrdenDe = @ChequesALaOrdenDe,
                    FechaLimiteExentoGanancias = @FechaLimiteExentoGanancias,
                    FechaLimiteExentoIIBB = @FechaLimiteExentoIIBB,
                    IdImpuestoDirectoSUSS = @IdImpuestoDirectoSUSS,
                    Importaciones_NumeroInscripcion = @Importaciones_NumeroInscripcion,
                    Importaciones_DenominacionInscripcion = @Importaciones_DenominacionInscripcion,
                    EnviarEmail = @EnviarEmail,
                    InformacionAuxiliar = @InformacionAuxiliar,
                    CoeficienteIIBBUnificado = @CoeficienteIIBBUnificado,
                    FechaUltimaPresentacionDocumentacion = @FechaUltimaPresentacionDocumentacion,
                    ObservacionesPresentacionDocumentacion = @ObservacionesPresentacionDocumentacion,
                    FechaLimiteCondicionIVA = @FechaLimiteCondicionIVA,
                    CodigoSituacionRetencionIVA = @CodigoSituacionRetencionIVA,
                    SUSSFechaCaducidadExencion = @SUSSFechaCaducidadExencion,
                    Calificacion = @Calificacion,
                    IdUsuarioIngreso = @IdUsuarioIngreso,
                    FechaIngreso = @FechaIngreso,
                    IdUsuarioModifico = @IdUsuarioModifico,
                    FechaModifico = @FechaModifico,
                    Exterior = @Exterior,
                    SujetoEmbargado = @SujetoEmbargado,
                    SaldoEmbargo = @SaldoEmbargo,
                    DetalleEmbargo = @DetalleEmbargo,
                    PorcentajeIBDirecto = @PorcentajeIBDirecto,
                    FechaInicioVigenciaIBDirecto = @FechaInicioVigenciaIBDirecto,
                    FechaFinVigenciaIBDirecto = @FechaFinVigenciaIBDirecto,
                    GrupoIIBB = @GrupoIIBB
            WHERE   ( IdProveedor = @IdProveedor )
        END

    IF @@ERROR <> 0 
        RETURN -1
    ELSE 
        RETURN @IdProveedor

GO




--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wProveedores_E]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wProveedores_E]
go



CREATE PROCEDURE [dbo].[wProveedores_E] @IdProveedor INT
AS 
    DELETE  Proveedores
    WHERE   ( IdProveedor = @IdProveedor )

GO


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wProveedores_T]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wProveedores_T]
go


CREATE  PROCEDURE [dbo].[wProveedores_T]
    @IdProveedor INT = NULL
AS 
    SET @IdProveedor = ISNULL(@IdProveedor, -1)

    SELECT  Proveedores.*,
            Localidades.Nombre AS [Localidad],
            Provincias.Nombre AS [Provincia],
            Provincias.PlantillaRetencionIIBB,
            Paises.Descripcion AS [Pais],
            DescripcionIva.Descripcion AS [CondicionIVA],
            [Estados Proveedores].Descripcion AS [Estado],
            [Actividades Proveedores].Descripcion AS [Actividad],
            [Condiciones Compra].Descripcion AS [CondicionCompra],
            CASE WHEN IGCondicion IS NULL
                      OR IGCondicion = 1 THEN NULL
                 ELSE TiposRetencionGanancia.Descripcion
            END AS [CategoriaGanancias],
            CASE WHEN ISNULL(Proveedores.IBCondicion, 1) = 1 THEN 'Exento'
                 WHEN ISNULL(Proveedores.IBCondicion, 1) = 2 THEN 'Conv.Mult.'
                 WHEN ISNULL(Proveedores.IBCondicion, 1) = 3
                 THEN 'Juris.Local'
                 WHEN ISNULL(Proveedores.IBCondicion, 1) = 4
                 THEN 'No alcanzado'
                 ELSE NULL
            END AS [SituacionIIBB],
            IBCondiciones.Descripcion AS [CategoriaIIBB],
            Cuentas.Descripcion AS [CuentaContable],
            Monedas.Abreviatura AS [MonedaHabitual],
            ImpuestosDirectos.Descripcion AS [ImpuestoDirectoSUSS],
            E1.Nombre AS [UsuarioIngreso],
            E2.Nombre AS [UsuarioModifico]
    FROM    Proveedores
            LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva
            LEFT OUTER JOIN Localidades ON Proveedores.IdLocalidad = Localidades.IdLocalidad
            LEFT OUTER JOIN Provincias ON Proveedores.IdProvincia = Provincias.IdProvincia
            LEFT OUTER JOIN Paises ON Proveedores.IdPais = Paises.IdPais
            LEFT OUTER JOIN [Estados Proveedores] ON Proveedores.IdEstado = [Estados Proveedores].IdEstado
            LEFT OUTER JOIN [Actividades Proveedores] ON Proveedores.IdActividad = [Actividades Proveedores].IdActividad
            LEFT OUTER JOIN [Condiciones Compra] ON Proveedores.IdCondicionCompra = [Condiciones Compra].IdCondicionCompra
            LEFT OUTER JOIN TiposRetencionGanancia ON Proveedores.IdTipoRetencionGanancia = TiposRetencionGanancia.IdTipoRetencionGanancia
            LEFT OUTER JOIN Cuentas ON Proveedores.IdCuenta = Cuentas.IdCuenta
            LEFT OUTER JOIN IBCondiciones ON Proveedores.IdIBCondicionPorDefecto = IBCondiciones.IdIBCondicion
            LEFT OUTER JOIN Monedas ON Proveedores.IdMoneda = Monedas.IdMoneda
            LEFT OUTER JOIN ImpuestosDirectos ON Proveedores.IdImpuestoDirectoSUSS = ImpuestosDirectos.IdImpuestoDirecto
            LEFT OUTER JOIN Empleados E1 ON Proveedores.IdUsuarioIngreso = E1.IdEmpleado
            LEFT OUTER JOIN Empleados E2 ON Proveedores.IdUsuarioModifico = E2.IdEmpleado
    WHERE   ( @IdProveedor = -1
              OR IdProveedor = @IdProveedor
            ) 
--and IsNull(Eventual,'NO')<>'SI'
    ORDER BY Proveedores.RazonSocial
GO


/*

select * from proveedores
where idproveedor=1872

exec [wProveedores_T] 1872

*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wProveedores_TX_Busqueda]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wProveedores_TX_Busqueda]
go

CREATE  PROCEDURE [dbo].[wProveedores_TX_Busqueda] @Busqueda VARCHAR(100)
AS 
    SELECT  Proveedores.*,
            Localidades.Nombre AS [Localidad],
            Provincias.Nombre AS [Provincia],
            Provincias.PlantillaRetencionIIBB,
            Paises.Descripcion AS [Pais],
            DescripcionIva.Descripcion AS [CondicionIVA],
            [Estados Proveedores].Descripcion AS [Estado],
            [Actividades Proveedores].Descripcion AS [Actividad],
            [Condiciones Compra].Descripcion AS [CondicionCompra],
            CASE WHEN IGCondicion IS NULL
                      OR IGCondicion = 1 THEN NULL
                 ELSE TiposRetencionGanancia.Descripcion
            END AS [CategoriaGanancias],
            CASE WHEN ISNULL(Proveedores.IBCondicion, 1) = 1 THEN 'Exento'
                 WHEN ISNULL(Proveedores.IBCondicion, 1) = 2 THEN 'Conv.Mult.'
                 WHEN ISNULL(Proveedores.IBCondicion, 1) = 3
                 THEN 'Juris.Local'
                 WHEN ISNULL(Proveedores.IBCondicion, 1) = 4
                 THEN 'No alcanzado'
                 ELSE NULL
            END AS [SituacionIIBB],
            IBCondiciones.Descripcion AS [CategoriaIIBB],
            Cuentas.Descripcion AS [CuentaContable],
            Monedas.Abreviatura AS [MonedaHabitual],
            ImpuestosDirectos.Descripcion AS [ImpuestoDirectoSUSS],
            E1.Nombre AS [UsuarioIngreso],
            E2.Nombre AS [UsuarioModifico]
    FROM    Proveedores
            LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva
            LEFT OUTER JOIN Localidades ON Proveedores.IdLocalidad = Localidades.IdLocalidad
            LEFT OUTER JOIN Provincias ON Proveedores.IdProvincia = Provincias.IdProvincia
            LEFT OUTER JOIN Paises ON Proveedores.IdPais = Paises.IdPais
            LEFT OUTER JOIN [Estados Proveedores] ON Proveedores.IdEstado = [Estados Proveedores].IdEstado
            LEFT OUTER JOIN [Actividades Proveedores] ON Proveedores.IdActividad = [Actividades Proveedores].IdActividad
            LEFT OUTER JOIN [Condiciones Compra] ON Proveedores.IdCondicionCompra = [Condiciones Compra].IdCondicionCompra
            LEFT OUTER JOIN TiposRetencionGanancia ON Proveedores.IdTipoRetencionGanancia = TiposRetencionGanancia.IdTipoRetencionGanancia
            LEFT OUTER JOIN Cuentas ON Proveedores.IdCuenta = Cuentas.IdCuenta
            LEFT OUTER JOIN IBCondiciones ON Proveedores.IdIBCondicionPorDefecto = IBCondiciones.IdIBCondicion
            LEFT OUTER JOIN Monedas ON Proveedores.IdMoneda = Monedas.IdMoneda
            LEFT OUTER JOIN ImpuestosDirectos ON Proveedores.IdImpuestoDirectoSUSS = ImpuestosDirectos.IdImpuestoDirecto
            LEFT OUTER JOIN Empleados E1 ON Proveedores.IdUsuarioIngreso = E1.IdEmpleado
            LEFT OUTER JOIN Empleados E2 ON Proveedores.IdUsuarioModifico = E2.IdEmpleado
    WHERE   --IsNull(Eventual,'NO')<>'SI' and  --por qué saqué el filtro de eventuales?
            ISNULL(Confirmado, 'NO') <> 'NO'
            AND Proveedores.RazonSocial LIKE @Busqueda + '%'
--Proveedores.RazonSocial like '%'+@Busqueda+'%'
    ORDER BY Proveedores.RazonSocial
GO


/*

exec [wProveedores_TX_Busqueda] 'asoc'


select Confirmado, * from proveedores
WHERE 
IsNull(Confirmado,'NO')<>'SI' and
Proveedores.RazonSocial like '%'+'Cefe'+'%'





*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wArticulos_TX_Busqueda]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wArticulos_TX_Busqueda
go

CREATE  PROCEDURE [dbo].wArticulos_TX_Busqueda @Busqueda VARCHAR(100)
AS 
    SELECT TOP 100
            IdArticulo,
            Descripcion
    FROM    Articulos
    WHERE   ( Articulos.Descripcion LIKE '' + @Busqueda + '%' )
    ORDER BY Articulos.Descripcion

/*
SELECT TOP 250
Articulos.IdArticulo,

--METODO PARA BUSCAR TAMBIEN POR CODIGO
--(isnull(Articulos.Codigo,'') COLLATE SQL_Latin1_General_CP1_CI_AS+' '+
--	isnull(Articulos.Descripcion,'') COLLATE SQL_Latin1_General_CP1_CI_AS) as Descripcion,
Articulos.Descripcion, 
Articulos.IdCodigo, 
Articulos.Codigo,
Articulos.IdInventario,
Articulos.NumeroInventario,
Articulos.IdRubro,
Articulos.IdUnidad,
Articulos.AlicuotaIVA,
Articulos.CostoPPP,
Articulos.CostoPPPDolar,
Articulos.CostoReposicion,
Articulos.CostoReposicionDolar,
Articulos.Observaciones,
Articulos.IdSubrubro,
 Rubros.Descripcion as [Rubro],
 Subrubros.Descripcion as [Subrubro],
 (Select Sum(Stock.CantidadUnidades) From Stock 
	Where Stock.IdArticulo=Articulos.IdArticulo) as [Stock actual],
 (Select Top 1 Unidades.Abreviatura From Unidades 
	Where Articulos.IdUnidad=Unidades.IdUnidad) as [Un],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion)+
	IsNull(', '+Ubicaciones.Descripcion,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta,'') as [Ubicacion],
 Unidades.Abreviatura as [Unidad]
FROM Articulos
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro 
LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro 
LEFT OUTER JOIN Ubicaciones ON Articulos.IdUbicacionStandar = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Unidades ON Articulos.IdUnidad = Unidades.IdUnidad
WHERE IsNull(Articulos.Activo,'')<>'NO' 
--METODO PARA BUSCAR TAMBIEN POR CODIGO
--and (Articulos.Descripcion like '%'+@Busqueda+'%' or Articulos.Codigo like '%'+@Busqueda+'%') 
--ORDER BY Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS + Articulos.Descripcion
and (Articulos.Descripcion like '%'+@Busqueda+'%') 
ORDER BY Articulos.Descripcion

*/

GO


/*

exec [wArticulos_TX_Busqueda] 'as'


select Confirmado, * from proveedores
WHERE 
IsNull(Confirmado,'NO')<>'SI' and
Proveedores.RazonSocial like '%'+'Cefe'+'%'





*/


--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wProveedores_TL]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wProveedores_TL]
go

CREATE PROCEDURE [dbo].[wProveedores_TL]
AS 
    SELECT  IdProveedor,
            RazonSocial AS [Titulo]
    FROM    Proveedores
--WHERE IsNull(Eventual,'NO')='NO' and IsNull(Confirmado,'SI')='SI'
    ORDER BY RazonSocial
go


--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetProveedoresContactos_TT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetProveedoresContactos_TT]
go


CREATE PROCEDURE [dbo].[wDetProveedoresContactos_TT] @IdProveedor INT
AS 
    SELECT  Det.*
    FROM    DetalleProveedores Det
            LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = Det.IdProveedor
    WHERE   Det.IdProveedor = @IdProveedor

GO

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetProveedoresContactos_T]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetProveedoresContactos_T]
go



CREATE PROCEDURE [dbo].[wDetProveedoresContactos_T]
    @IdDetalleProveedor INT
AS 
    SELECT  *
    FROM    [DetalleProveedores]
    WHERE   ( IdDetalleProveedor = @IdDetalleProveedor )

GO
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetProveedoresContactos_E]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetProveedoresContactos_E]
go



CREATE PROCEDURE [dbo].[wDetProveedoresContactos_E]
    @IdDetalleProveedor INT
AS 
    DELETE  [DetalleProveedores]
    WHERE   ( IdDetalleProveedor = @IdDetalleProveedor )

GO


--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetProveedoresContactos_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetProveedoresContactos_A]
go



CREATE PROCEDURE [dbo].[wDetProveedoresContactos_A]
    @IdDetalleProveedor INT,
    @IdProveedor INT,
    @Contacto VARCHAR(50),
    @Puesto VARCHAR(50),
    @Telefono VARCHAR(50),
    @Email VARCHAR(50)
AS 
    IF ISNULL(@IdDetalleProveedor, 0) <= 0 
        BEGIN
            INSERT  INTO DetalleProveedores
                    (
                      IdProveedor,
                      Contacto,
                      Puesto,
                      Telefono,
                      Email
	              )
            VALUES  (
                      @IdProveedor,
                      @Contacto,
                      @Puesto,
                      @Telefono,
                      @Email
	              )
	
            SELECT  @IdDetalleProveedor = @@identity
        END
    ELSE 
        BEGIN
            UPDATE  DetalleProveedores
            SET     IdProveedor = @IdProveedor,
                    Contacto = @Contacto,
                    Puesto = @Puesto,
                    Telefono = @Telefono,
                    Email = @Email
            WHERE   ( IdDetalleProveedor = @IdDetalleProveedor )
        END

    IF @@ERROR <> 0 
        RETURN -1
    ELSE 
        RETURN @IdDetalleProveedor

GO






--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wRequerimientos_T]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wRequerimientos_T]
go

CREATE PROCEDURE [dbo].[wRequerimientos_T]
    @IdRequerimiento INT = NULL
AS 
    SET NOCOUNT ON

    SET @IdRequerimiento = ISNULL(@IdRequerimiento, -1)

    DECLARE @ActivarSolicitudMateriales VARCHAR(2)
    SET @ActivarSolicitudMateriales = ISNULL(( SELECT TOP 1
                                                        P.ActivarSolicitudMateriales
                                               FROM     Parametros P
                                               WHERE    P.IdParametro = 1
                                             ), 'NO')




-----------------------------
--MARIANO: simplificacion del sp
-----------------------------

    SELECT  Requerimientos.IdRequerimiento,
            Requerimientos.*,
            Requerimientos.NumeroRequerimiento AS [Nro. Req. a Conf.],
            Requerimientos.IdRequerimiento AS [IdReq],
            Requerimientos.FechaRequerimiento AS [Fecha],
            Requerimientos.Cumplido AS [Cump.],
            Requerimientos.Impresa AS [Impresa],
            Requerimientos.Detalle AS [Detalle],
            Obras.NumeroObra AS [Obra],
            ( SELECT    COUNT(*)
              FROM      DetalleRequerimientos Det
              WHERE     Det.IdRequerimiento = Requerimientos.IdRequerimiento
            ) AS [Items],
            ( SELECT TOP 1
                        E.Nombre
              FROM      Empleados E
              WHERE     Requerimientos.Aprobo = E.IdEmpleado
            ) AS [Libero],
            ( SELECT TOP 1
                        E.Nombre
              FROM      Empleados E
              WHERE     Requerimientos.IdSolicito = E.IdEmpleado
            ) AS [Solicito],
            ( SELECT TOP 1
                        E.Nombre
              FROM      Empleados E
              WHERE     Requerimientos.IdComprador = E.IdEmpleado
            ) AS [Comprador],
            Sectores.Descripcion AS [Sector],
            ArchivosATransmitirDestinos.Descripcion AS [Origen],
            Requerimientos.IdRequerimiento AS [IdAux],
            ( SELECT    COUNT(*)
              FROM      DetalleRequerimientos
              WHERE     DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
            ) AS [Cant.Items]
    FROM    Requerimientos
            LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
            LEFT OUTER JOIN CentrosCosto ON Requerimientos.IdCentroCosto = CentrosCosto.IdCentroCosto
            LEFT OUTER JOIN Sectores ON Requerimientos.IdSector = Sectores.IdSector
            LEFT OUTER JOIN Monedas ON Requerimientos.IdMoneda = Monedas.IdMoneda
            LEFT OUTER JOIN ArchivosATransmitirDestinos ON Requerimientos.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
    WHERE   --IsNull(Confirmado,'SI')='NO' and 
            ( @IdRequerimiento = -1
              OR Requerimientos.IdRequerimiento = @IdRequerimiento
            )
    ORDER BY NumeroRequerimiento DESC


-----------------------------
-----------------------------
-----------------------------







/*


-- PRESUPUESTOS 
CREATE TABLE #Auxiliar0 
			(
			 IdRequerimiento INTEGER,
			 Presupuestos VARCHAR(100)
			)

CREATE TABLE #Auxiliar1 
			(
			 IdRequerimiento INTEGER,
			 Presupuesto VARCHAR(13)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetReq.IdRequerimiento,
  Convert(varchar,Presupuestos.Numero)+
	Case When Presupuestos.Subnumero is not null
		Then '/'+Convert(varchar,Presupuestos.Subnumero)
		Else ''
	End
 FROM DetalleRequerimientos DetReq
 LEFT OUTER JOIN DetallePresupuestos ON DetReq.IdDetalleRequerimiento = DetallePresupuestos.IdDetalleRequerimiento
 LEFT OUTER JOIN Presupuestos ON DetallePresupuestos.IdPresupuesto = Presupuestos.IdPresupuesto
 WHERE @IdRequerimiento=-1 or DetReq.IdRequerimiento=@IdRequerimiento

CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdRequerimiento,Presupuesto) ON [PRIMARY]

INSERT INTO #Auxiliar0 
 SELECT IdRequerimiento, ''
 FROM #Auxiliar1
 GROUP BY IdRequerimiento


PRINT '1'

--  CURSOR  
DECLARE @IdRequerimiento1 int, @Presupuesto varchar(13), @P varchar(100), @Corte int
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdRequerimiento, Presupuesto
		FROM #Auxiliar1
		ORDER BY IdRequerimiento
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Presupuesto
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRequerimiento1
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar0
			SET Presupuestos = SUBSTRING(@P,1,100)
			WHERE #Auxiliar0.IdRequerimiento=@Corte
		   END
		SET @P=''
		SET @Corte=@IdRequerimiento1
	   END
	IF NOT @Presupuesto IS NULL
		IF PATINDEX('%'+@Presupuesto+' '+'%', @P)=0
			SET @P=@P+@Presupuesto+' '
	FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Presupuesto
   END
   IF @Corte<>0
      BEGIN
	UPDATE #Auxiliar0
	SET Presupuestos = SUBSTRING(@P,1,100)
	WHERE #Auxiliar0.IdRequerimiento=@Corte
      END
CLOSE Cur
DEALLOCATE Cur

PRINT '2'


--COMPARATIVAS
CREATE TABLE #Auxiliar2 
			(
			 IdRequerimiento INTEGER,
			 Comparativas VARCHAR(100)
			)

CREATE TABLE #Auxiliar3 
			(
			 IdRequerimiento INTEGER,
			 Comparativa INTEGER
			)
INSERT INTO #Auxiliar3 
 SELECT DetReq.IdRequerimiento, Comparativas.Numero
 FROM DetalleRequerimientos DetReq
 LEFT OUTER JOIN DetallePresupuestos ON DetReq.IdDetalleRequerimiento = DetallePresupuestos.IdDetalleRequerimiento
 LEFT OUTER JOIN DetalleComparativas ON DetallePresupuestos.IdDetallePresupuesto = DetalleComparativas.IdDetallePresupuesto
 LEFT OUTER JOIN Comparativas ON DetalleComparativas.IdComparativa = Comparativas.IdComparativa
 WHERE @IdRequerimiento=-1 or DetReq.IdRequerimiento=@IdRequerimiento

CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdRequerimiento,Comparativa) ON [PRIMARY]

INSERT INTO #Auxiliar2 
 SELECT IdRequerimiento, ''
 FROM #Auxiliar3
 GROUP BY IdRequerimiento

PRINT '3'


--  CURSOR  
DECLARE @Comparativa int, @C varchar(100)
SET @Corte=0
SET @C=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdRequerimiento, Comparativa
		FROM #Auxiliar3
		ORDER BY IdRequerimiento
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Comparativa
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRequerimiento1
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar2
			SET Comparativas = SUBSTRING(@C,1,100)
			WHERE #Auxiliar2.IdRequerimiento=@Corte
		   END
		SET @C=''
		SET @Corte=@IdRequerimiento1
	   END
	IF NOT @Comparativa IS NULL
		IF PATINDEX('%'+Convert(varchar,@Comparativa)+' '+'%', @C)=0
			SET @C=@C+Convert(varchar,@Comparativa)+' '
	FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Comparativa
   END
   IF @Corte<>0
      BEGIN
	UPDATE #Auxiliar2
	SET Comparativas = SUBSTRING(@C,1,100)
	WHERE #Auxiliar2.IdRequerimiento=@Corte
      END
CLOSE Cur
DEALLOCATE Cur


PRINT '4'



-- PEDIDOS --
CREATE TABLE #Auxiliar4 
			(
			 IdRequerimiento INTEGER,
			 Pedidos VARCHAR(100)
			)

CREATE TABLE #Auxiliar5 
			(
			 IdRequerimiento INTEGER,
			 Pedido VARCHAR(13)
			)
INSERT INTO #Auxiliar5 
 SELECT 
  DetReq.IdRequerimiento,
  Convert(varchar,Pedidos.NumeroPedido)+
	Case When Pedidos.Subnumero is not null
		Then '/'+Convert(varchar,Pedidos.Subnumero)
		Else ''
	End
 FROM DetalleRequerimientos DetReq
 LEFT OUTER JOIN DetallePedidos ON DetReq.IdDetalleRequerimiento = DetallePedidos.IdDetalleRequerimiento
 LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
 WHERE @IdRequerimiento=-1 or DetReq.IdRequerimiento=@IdRequerimiento

CREATE NONCLUSTERED INDEX IX__Auxiliar5 ON #Auxiliar5 (IdRequerimiento,Pedido) ON [PRIMARY]

INSERT INTO #Auxiliar4 
 SELECT IdRequerimiento, ''
 FROM #Auxiliar5
 GROUP BY IdRequerimiento


PRINT '5'


--  CURSOR  --
DECLARE @Pedido varchar(13)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdRequerimiento, Pedido
		FROM #Auxiliar5
		ORDER BY IdRequerimiento
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Pedido
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRequerimiento1
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar4
			SET Pedidos = SUBSTRING(@P,1,100)
			WHERE #Auxiliar4.IdRequerimiento=@Corte
		   END
		SET @P=''
		SET @Corte=@IdRequerimiento1
	   END
	IF NOT @Pedido IS NULL
		IF PATINDEX('%'+@Pedido+' '+'%', @P)=0
			SET @P=@P+@Pedido+' '
	FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Pedido
   END
   IF @Corte<>0
      BEGIN
	UPDATE #Auxiliar4
	SET Pedidos = SUBSTRING(@P,1,100)
	WHERE #Auxiliar4.IdRequerimiento=@Corte
      END
CLOSE Cur
DEALLOCATE Cur


PRINT '6'



-- RECEPCION DE MATERIALES --
CREATE TABLE #Auxiliar6 
			(
			 IdRequerimiento INTEGER,
			 Recepciones VARCHAR(100)
			)

CREATE TABLE #Auxiliar7 
			(
			 IdRequerimiento INTEGER,
			 Recepcion VARCHAR(20)
			)
INSERT INTO #Auxiliar7 
 SELECT 
  DetReq.IdRequerimiento,
  Case When Recepciones.SubNumero is not null 
	 Then Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+
			Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+
			Convert(varchar,Recepciones.NumeroRecepcion2)+'/'+
			Convert(varchar,Recepciones.SubNumero) ,1,20) 
	 Else Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+
			Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+
			Convert(varchar,Recepciones.NumeroRecepcion2),1,20) 
  End
 FROM DetalleRequerimientos DetReq
 LEFT OUTER JOIN DetalleRecepciones ON DetReq.IdDetalleRequerimiento = DetalleRecepciones.IdDetalleRequerimiento
 LEFT OUTER JOIN Recepciones ON DetalleRecepciones.IdRecepcion = Recepciones.IdRecepcion
 WHERE @IdRequerimiento=-1 or DetReq.IdRequerimiento=@IdRequerimiento

CREATE NONCLUSTERED INDEX IX__Auxiliar7 ON #Auxiliar7 (IdRequerimiento,Recepcion) ON [PRIMARY]

INSERT INTO #Auxiliar6 
 SELECT IdRequerimiento, ''
 FROM #Auxiliar7
 GROUP BY IdRequerimiento


PRINT '7'



--  CURSOR  --
DECLARE @Recepcion varchar(20)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdRequerimiento, Recepcion
		FROM #Auxiliar7
		ORDER BY IdRequerimiento
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Recepcion
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRequerimiento1
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar6
			SET Recepciones = SUBSTRING(@P,1,100)
			WHERE IdRequerimiento=@Corte
		   END
		SET @P=''
		SET @Corte=@IdRequerimiento1
	   END
	IF NOT @Recepcion IS NULL
		IF PATINDEX('%'+@Recepcion+' '+'%', @P)=0
			SET @P=@P+@Recepcion+' '
	FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Recepcion
   END
   IF @Corte<>0
      BEGIN
	UPDATE #Auxiliar6
	SET Recepciones = SUBSTRING(@P,1,100)
	WHERE IdRequerimiento=@Corte
      END
CLOSE Cur
DEALLOCATE Cur


PRINT '8'



-- SALIDAS DE MATERIALES --
CREATE TABLE #Auxiliar8 
			(
			 IdRequerimiento INTEGER,
			 Salidas VARCHAR(100)
			)

CREATE TABLE #Auxiliar9 
			(
			 IdRequerimiento INTEGER,
			 Salida VARCHAR(13)
			)
INSERT INTO #Auxiliar9 
 SELECT 
  DetReq.IdRequerimiento,
  Substring(Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+
	Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+
	Convert(varchar,SalidasMateriales.NumeroSalidaMateriales),1,13)
 FROM DetalleRequerimientos DetReq
 LEFT OUTER JOIN DetalleValesSalida ON DetReq.IdDetalleRequerimiento = DetalleValesSalida.IdDetalleRequerimiento
 LEFT OUTER JOIN DetalleSalidasMateriales ON DetalleValesSalida.IdDetalleValeSalida = DetalleSalidasMateriales.IdDetalleValeSalida
 LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 WHERE @IdRequerimiento=-1 or DetReq.IdRequerimiento=@IdRequerimiento

CREATE NONCLUSTERED INDEX IX__Auxiliar9 ON #Auxiliar9 (IdRequerimiento,Salida) ON [PRIMARY]

INSERT INTO #Auxiliar8 
 SELECT IdRequerimiento, ''
 FROM #Auxiliar9
 GROUP BY IdRequerimiento


PRINT '9'


--  CURSOR  --
DECLARE @Salida varchar(13)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdRequerimiento, Salida
		FROM #Auxiliar9
		ORDER BY IdRequerimiento
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Salida
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRequerimiento1
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar8
			SET Salidas = SUBSTRING(@P,1,100)
			WHERE IdRequerimiento=@Corte
		   END
		SET @P=''
		SET @Corte=@IdRequerimiento1
	   END
	IF NOT @Salida IS NULL
		IF PATINDEX('%'+@Salida+' '+'%', @P)=0
			SET @P=@P+@Salida+' '
	FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Salida
   END
   IF @Corte<>0
      BEGIN
	UPDATE #Auxiliar8
	SET Salidas = SUBSTRING(@P,1,100)
	WHERE IdRequerimiento=@Corte
      END
CLOSE Cur
DEALLOCATE Cur


PRINT '10'



SET NOCOUNT OFF

SELECT 
 Requerimientos.*,
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 #Auxiliar0.Presupuestos as [Presupuestos],
 #Auxiliar2.Comparativas as [Comparativas],
 #Auxiliar4.Pedidos as [Pedidos],
 #Auxiliar6.Recepciones as [Recepciones],
 #Auxiliar8.Salidas as [Salidas],
 (Select Count(*) From DetalleRequerimientos Det 
	Where Det.IdRequerimiento=Requerimientos.IdRequerimiento) as [Items],
 (Select Top 1 E.Nombre From Empleados E 
	Where Requerimientos.Aprobo=E.IdEmpleado) as [Libero],
 (Select Top 1 E.Nombre From Empleados E 
	Where Requerimientos.IdSolicito=E.IdEmpleado) as [Solicito],
 (Select Top 1 E.Nombre From Empleados E 
	Where Requerimientos.IdComprador=E.IdEmpleado) as [Comprador],
 Sectores.Descripcion as [Sector],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 Articulos.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS+' '+
	Articulos.Descripcion as [EquipoDestino],
 TiposCompra.Descripcion as [TipoCompra],
 (Select Top 1 E.Nombre From Empleados E 
  Where E.IdEmpleado=(Select Top 1 Aut.IdAutorizo 
			From AutorizacionesPorComprobante Aut 
			Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and 
				Aut.IdComprobante=Requerimientos.IdRequerimiento)) as [SegundaFirma],
 (Select Top 1 Aut.FechaAutorizacion 
	From AutorizacionesPorComprobante Aut 
	Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and 
		Aut.IdComprobante=Requerimientos.IdRequerimiento) as [FechaSegundaFirma],
 (Select Top 1 E.Nombre From Empleados E 
  Where E.IdEmpleado=(Select Top 1 Det.IdComprador 
			From DetalleRequerimientos Det 
			Where Det.IdRequerimiento=Requerimientos.IdRequerimiento and Det.IdComprador  is not null)) as [CompradorItem]
FROM Requerimientos
LEFT OUTER JOIN Obras ON Requerimientos.IdObra=Obras.IdObra
LEFT OUTER JOIN CentrosCosto ON Requerimientos.IdCentroCosto=CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Sectores ON Requerimientos.IdSector=Sectores.IdSector
LEFT OUTER JOIN Monedas ON Requerimientos.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN ArchivosATransmitirDestinos ON Requerimientos.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN Articulos ON Requerimientos.IdEquipoDestino=Articulos.IdArticulo
LEFT OUTER JOIN #Auxiliar0 ON Requerimientos.IdRequerimiento=#Auxiliar0.IdRequerimiento
LEFT OUTER JOIN #Auxiliar2 ON Requerimientos.IdRequerimiento=#Auxiliar2.IdRequerimiento
LEFT OUTER JOIN #Auxiliar4 ON Requerimientos.IdRequerimiento=#Auxiliar4.IdRequerimiento
LEFT OUTER JOIN #Auxiliar6 ON Requerimientos.IdRequerimiento=#Auxiliar6.IdRequerimiento
LEFT OUTER JOIN #Auxiliar8 ON Requerimientos.IdRequerimiento=#Auxiliar8.IdRequerimiento
LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
WHERE (@IdRequerimiento=-1 or Requerimientos.IdRequerimiento=@IdRequerimiento) and 
	(Confirmado is null or Confirmado<>'NO')
ORDER BY Requerimientos.FechaRequerimiento Desc, Requerimientos.NumeroRequerimiento Desc


PRINT '11'



DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5
DROP TABLE #Auxiliar6
DROP TABLE #Auxiliar7
DROP TABLE #Auxiliar8
DROP TABLE #Auxiliar9
*/





GO

--exec wRequerimientos_T -1
--select * from requerimientos
--delete -requerimientos where idRequerimiento<3000
--delete -Detallerequerimientos where idRequerimiento<3000


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wRequerimientos_TXFecha]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wRequerimientos_TXFecha
go


CREATE Procedure [dbo].[wRequerimientos_TXFecha]

@Desde datetime,
@Hasta datetime,
@IdObraAsignadaUsuario int = Null

AS 

SET NOCOUNT ON

DECLARE @ActivarSolicitudMateriales varchar(2)

SET @ActivarSolicitudMateriales=IsNull((Select Top 1 P.ActivarSolicitudMateriales From Parametros P Where P.IdParametro=1),'NO')
SET @IdObraAsignadaUsuario=IsNull(@IdObraAsignadaUsuario,-1)

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111111111111111111111111111111111133'
IF @ActivarSolicitudMateriales='SI'
	SET @vector_T='0494D922200FFFFF511235D143E16205525500'
ELSE
	SET @vector_T='0494D122200FFFFF511235D143E16205525500'

SELECT 
 Requerimientos.IdRequerimiento,
 Requerimientos.NumeroRequerimiento as [Numero Req.],
 Requerimientos.IdRequerimiento as [IdReq],
 Requerimientos.FechaRequerimiento as [Fecha],

''  as [Vs],
--'' IsNull('/'+Convert(varchar,Requerimientos.NumeradorEliminacionesFirmas),'') as [Vs],

 Requerimientos.Cumplido as [Cump.],
 Requerimientos.Recepcionado as [Recibido],
 Requerimientos.Entregado as [Entregado],
 Requerimientos.Impresa as [Impresa],
 Requerimientos.Detalle as [Detalle],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 dbo.Requerimientos_Presupuestos(Requerimientos.IdRequerimiento)as [Presupuestos],
 dbo.Requerimientos_Comparativas(Requerimientos.IdRequerimiento)as [Comparativas],
 dbo.Requerimientos_Pedidos(Requerimientos.IdRequerimiento)as [Pedidos],
 dbo.Requerimientos_Recepciones(Requerimientos.IdRequerimiento)as [Recepciones],
 dbo.Requerimientos_SalidasMateriales(Requerimientos.IdRequerimiento)as [Salidas], 
 (Select Count(*) From DetalleRequerimientos Where DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento) as [Cant.Items],
 E1.Nombre as [Liberada por],
 E2.Nombre as [Solicitada por],
 Sectores.Descripcion as [Sector],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 Requerimientos.FechaImportacionTransmision as [Fecha imp.transm,],
 Articulos.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS+' '+Articulos.Descripcion as [Equipo destino],
 Requerimientos.UsuarioAnulacion as [Anulo],
 Requerimientos.FechaAnulacion as [Fecha anulacion],
 Requerimientos.MotivoAnulacion as [Motivo anulacion],
 TiposCompra.Descripcion as [Tipo compra],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=(Select Top 1 Aut.IdAutorizo From AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=Requerimientos.IdRequerimiento)) as [2da.Firma],
 (Select Top 1 Aut.FechaAutorizacion 
  From AutorizacionesPorComprobante Aut 
  Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=Requerimientos.IdRequerimiento) as [Fecha 2da.Firma],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=(Select Top 1 Det.IdComprador From DetalleRequerimientos Det 
				Where Det.IdRequerimiento=Requerimientos.IdRequerimiento and Det.IdComprador  is not null)) as [Comprador],
 E3.Nombre as [Importada por],
 Requerimientos.FechaLlegadaImportacion as [Fec.llego SAT],
 dbo.Requerimientos_FechasLiberacion(Requerimientos.IdRequerimiento) as [Fechas de liberacion para compras por item],
 Requerimientos.DetalleImputacion as [Detalle imputacion],
 Requerimientos.Observaciones as [Observaciones],
 Requerimientos.NumeradorEliminacionesFirmas as [Elim.Firmas],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Requerimientos
LEFT OUTER JOIN Obras ON Requerimientos.IdObra=Obras.IdObra
LEFT OUTER JOIN CentrosCosto ON Requerimientos.IdCentroCosto=CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Sectores ON Requerimientos.IdSector=Sectores.IdSector
LEFT OUTER JOIN Monedas ON Requerimientos.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN ArchivosATransmitirDestinos ON Requerimientos.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN Articulos ON Requerimientos.IdEquipoDestino=Articulos.IdArticulo
LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = Requerimientos.Aprobo
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = Requerimientos.IdSolicito
LEFT OUTER JOIN Empleados E3 ON E3.IdEmpleado = Requerimientos.IdImporto
WHERE (Requerimientos.FechaRequerimiento Between @Desde And @Hasta) 
	--and isNull(Requerimientos.Confirmado,'SI')<>'NO' 
	--and IsNull(Requerimientos.ConfirmadoPorWeb,'SI')<>'NO' 
	and	(@IdObraAsignadaUsuario=-1 or Requerimientos.IdObra=@IdObraAsignadaUsuario)
ORDER BY Requerimientos.FechaRequerimiento Desc, Requerimientos.NumeroRequerimiento Desc

GO



--[wRequerimientos_TXFecha] '1/1/2010','1/1/2011'


--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wRequerimientos_TTpaginadoTotalCount]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wRequerimientos_TTpaginadoTotalCount
go


CREATE  PROCEDURE [dbo].wRequerimientos_TTpaginadoTotalCount
(
	@ColumnaParaFiltrar  nvarchar(50)=null,
	@TextoParaFiltrar    nvarchar(50)=null,
	
	@fechadesde datetime,
	@fechahasta datetime
)
AS
SELECT COUNT(*) FROM dbo.Requerimientos
WHERE
  FechaRequerimiento between @fechadesde and @fechahasta
and
	CASE @ColumnaParaFiltrar
		WHEN 'Numero' THEN NumeroRequerimiento
	END
		LIKE '%'+@TextoParaFiltrar+'%'

		GO

--EXEC wRequerimientos_TTpaginadoTotalCount

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wRequerimientos_TTpaginado]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wRequerimientos_TTpaginado]
go



CREATE  PROCEDURE [dbo].wRequerimientos_TTpaginado
(
    @startRowIndex int,
    @maximumRows int,
	
	@ColumnaParaFiltrar  nvarchar(50)=null,
	@TextoParaFiltrar    nvarchar(50)=null,
	
	@sortExpression      nvarchar(50),

	@fechadesde datetime,
	@fechahasta datetime

)
AS

-- http://www.4guysfromrolla.com/webtech/042606-1.shtml acá explican cómo paginar 
-- http://www.4guysfromrolla.com/articles/040407-1.aspx y acá explican cómo paginar Y filtrar. Naturalmente, necesitas los (fastidiosos) parametros de filtrado


DECLARE @first_id int, @startRow int
	
-- A check can be added to make sure @startRowIndex isn't > count(1)
-- from employees before doing any actual work unless it is guaranteed
-- the caller won't do that

-- Get the first employeeID for our page of records
SET ROWCOUNT @startRowIndex

SELECT @first_id = IdRequerimiento 
FROM Requerimientos 

WHERE FechaRequerimiento between @fechadesde and @fechahasta
and
	CASE @ColumnaParaFiltrar
		WHEN 'Numero' THEN NumeroRequerimiento
	END
		LIKE '%'+@TextoParaFiltrar+'%'

ORDER BY IdRequerimiento DESC

-- Now, set the row count to MaximumRows and get
-- all records >= @first_id
SET ROWCOUNT @maximumRows






--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

    DECLARE @ActivarSolicitudMateriales VARCHAR(2)
    SET @ActivarSolicitudMateriales = ISNULL(( SELECT TOP 1
                                                        P.ActivarSolicitudMateriales
                                               FROM     Parametros P
                                               WHERE    P.IdParametro = 1
                                             ), 'NO')




SELECT 
 Requerimientos.IdRequerimiento,
 Requerimientos.IdRequerimiento as id,
 Requerimientos.NumeroRequerimiento as [Numero Req.],
 Requerimientos.NumeroRequerimiento as [Numero],
 Requerimientos.IdRequerimiento as [IdReq],
 Requerimientos.FechaRequerimiento as [Fecha],
 
 '' as [Vs],
 --IsNull('/'+Convert(varchar,Requerimientos.NumeradorEliminacionesFirmas),'') as [Vs],
 
 
 Requerimientos.Cumplido as [Cump.],
 Requerimientos.Recepcionado as [Recibido],
 Requerimientos.Entregado as [Entregado],
 Requerimientos.Impresa as [Impresa],
 Requerimientos.Detalle as [Detalle],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 dbo.Requerimientos_Presupuestos(Requerimientos.IdRequerimiento)as [Presupuestos],
 dbo.Requerimientos_Comparativas(Requerimientos.IdRequerimiento)as [Comparativas],
 dbo.Requerimientos_Pedidos(Requerimientos.IdRequerimiento)as [Pedidos],
 dbo.Requerimientos_Recepciones(Requerimientos.IdRequerimiento)as [Recepciones],
 dbo.Requerimientos_SalidasMateriales(Requerimientos.IdRequerimiento)as [Salidas], 
 (Select Count(*) From DetalleRequerimientos Where DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento) as [Cant.Items],
 E1.Nombre as [Liberada por],
 E2.Nombre as [Solicitada por],
 Sectores.Descripcion as [Sector],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 Requerimientos.FechaImportacionTransmision as [Fecha imp.transm,],
 Articulos.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS+' '+Articulos.Descripcion as [Equipo destino],
 Requerimientos.UsuarioAnulacion as [Anulo],
 Requerimientos.FechaAnulacion as [Fecha anulacion],
 Requerimientos.MotivoAnulacion as [Motivo anulacion],
 TiposCompra.Descripcion as [Tipo compra],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=(Select Top 1 Aut.IdAutorizo From AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=Requerimientos.IdRequerimiento)) as [2da.Firma],
 (Select Top 1 Aut.FechaAutorizacion 
  From AutorizacionesPorComprobante Aut 
  Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=Requerimientos.IdRequerimiento) as [Fecha 2da.Firma],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=(Select Top 1 Det.IdComprador From DetalleRequerimientos Det 
				Where Det.IdRequerimiento=Requerimientos.IdRequerimiento and Det.IdComprador  is not null)) as [Comprador],
 E3.Nombre as [Importada por],
 Requerimientos.FechaLlegadaImportacion as [Fec.llego SAT],
 dbo.Requerimientos_FechasLiberacion(Requerimientos.IdRequerimiento) as [Fechas de liberacion para compras por item],
 Requerimientos.DetalleImputacion as [Detalle imputacion],
 Requerimientos.Observaciones as [Observaciones],
 Requerimientos.NumeradorEliminacionesFirmas as [Elim.Firmas]

FROM Requerimientos
LEFT OUTER JOIN Obras ON Requerimientos.IdObra=Obras.IdObra
LEFT OUTER JOIN CentrosCosto ON Requerimientos.IdCentroCosto=CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Sectores ON Requerimientos.IdSector=Sectores.IdSector
LEFT OUTER JOIN Monedas ON Requerimientos.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN ArchivosATransmitirDestinos ON Requerimientos.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN Articulos ON Requerimientos.IdEquipoDestino=Articulos.IdArticulo
LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = Requerimientos.Aprobo
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = Requerimientos.IdSolicito
LEFT OUTER JOIN Empleados E3 ON E3.IdEmpleado = Requerimientos.IdImporto


    WHERE IdRequerimiento <= @first_id

AND  FechaRequerimiento between @fechadesde and @fechahasta
and
	CASE @ColumnaParaFiltrar
		WHEN 'Numero' THEN NumeroRequerimiento
	END
		LIKE '%'+@TextoParaFiltrar+'%'


    ORDER BY IdRequerimiento DESC


-----------------------------
-----------------------------
--FALTA UN PEDAZO ENORME SACADO PARA ACELERAR
-----------------------------
-----------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

SET ROWCOUNT 0


GO


/*
EXEC dbo.wRequerimientos_TTpaginado 10,100,'','','', '1/1/2010','2/5/2010'
*/

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetRequerimientos_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetRequerimientos_A]
go



CREATE PROCEDURE [dbo].[wDetRequerimientos_A]
    @IdDetalleRequerimiento INT,
    @IdRequerimiento INT,
    @NumeroItem INT,
    @Cantidad NUMERIC(12, 2),
    @IdUnidad INT,
    @IdArticulo INT,
    @FechaEntrega DATETIME,
    @Observaciones NTEXT,
    @Cantidad1 NUMERIC(12, 2),
    @Cantidad2 NUMERIC(12, 2),
    @IdDetalleLMateriales INT,
    @IdComprador INT,
    @NumeroFacturaCompra1 INT,
    @FechaFacturaCompra DATETIME,
    @ImporteFacturaCompra NUMERIC(12, 2),
    @IdProveedor INT,
    @NumeroFacturaCompra2 INT,
    @Cumplido VARCHAR(2),
    @DescripcionManual VARCHAR(250),
    @IdRequerimientoOriginal INT,
    @IdDetalleRequerimientoOriginal INT,
    @IdOrigenTransmision INT,
    @IdAutorizoCumplido INT,
    @IdDioPorCumplido INT,
    @FechaDadoPorCumplido DATETIME,
    @ObservacionesCumplido NTEXT,
    @Costo NUMERIC(18, 2),
    @OrigenDescripcion INT,
    @TipoDesignacion VARCHAR(3),
    @IdLiberoParaCompras INT,
    @FechaLiberacionParaCompras DATETIME,
    @Recepcionado VARCHAR(2),
    @Pagina INT,
    @Item INT,
    @Figura INT,
    @CodigoDistribucion VARCHAR(3),
    @IdEquipoDestino INT,
    @Entregado VARCHAR(2),
    @FechaAsignacionComprador DATETIME,
    @MoP VARCHAR(1),
    @IdDetalleObraDestino INT,
    @Adjunto VARCHAR(2),
    @ArchivoAdjunto1 VARCHAR(100)
AS 

	if @TipoDesignacion=''  set @tipoDesignacion=null

    IF ISNULL(@IdDetalleRequerimiento, 0) <= 0 
        BEGIN
            INSERT  INTO DetalleRequerimientos
                    (
                      IdRequerimiento,
                      NumeroItem,
                      Cantidad,
                      IdUnidad,
                      IdArticulo,
                      FechaEntrega,
                      Observaciones,
                      Cantidad1,
                      Cantidad2,
                      IdDetalleLMateriales,
                      IdComprador,
                      NumeroFacturaCompra1,
                      FechaFacturaCompra,
                      ImporteFacturaCompra,
                      IdProveedor,
                      NumeroFacturaCompra2,
                      Cumplido,
                      DescripcionManual,
                      IdRequerimientoOriginal,
                      IdDetalleRequerimientoOriginal,
                      IdOrigenTransmision,
                      IdAutorizoCumplido,
                      IdDioPorCumplido,
                      FechaDadoPorCumplido,
                      ObservacionesCumplido,
                      Costo,
                      OrigenDescripcion,
                      TipoDesignacion,
                      IdLiberoParaCompras,
                      FechaLiberacionParaCompras,
                      Recepcionado,
                      Pagina,
                      Item,
                      Figura,
                      CodigoDistribucion,
                      IdEquipoDestino,
                      Entregado,
                      FechaAsignacionComprador,
                      MoP,
                      IdDetalleObraDestino,
                      Adjunto,
                      ArchivoAdjunto1

	              )
            VALUES  (
                      @IdRequerimiento,
                      @NumeroItem,
                      @Cantidad,
                      @IdUnidad,
                      @IdArticulo,
                      @FechaEntrega,
                      @Observaciones,
                      @Cantidad1,
                      @Cantidad2,
                      @IdDetalleLMateriales,
                      @IdComprador,
                      @NumeroFacturaCompra1,
                      @FechaFacturaCompra,
                      @ImporteFacturaCompra,
                      @IdProveedor,
                      @NumeroFacturaCompra2,
                      @Cumplido,
                      @DescripcionManual,
                      @IdRequerimientoOriginal,
                      @IdDetalleRequerimientoOriginal,
                      @IdOrigenTransmision,
                      @IdAutorizoCumplido,
                      @IdDioPorCumplido,
                      @FechaDadoPorCumplido,
                      @ObservacionesCumplido,
                      @Costo,
                      @OrigenDescripcion,
                      @TipoDesignacion,
                      @IdLiberoParaCompras,
                      @FechaLiberacionParaCompras,
                      @Recepcionado,
                      @Pagina,
                      @Item,
                      @Figura,
                      @CodigoDistribucion,
                      @IdEquipoDestino,
                      @Entregado,
                      @FechaAsignacionComprador,
                      @MoP,
                      @IdDetalleObraDestino,
                      @Adjunto,
                      @ArchivoAdjunto1

	              )
	
            SELECT  @IdDetalleRequerimiento = @@identity
        END
    ELSE 
        BEGIN
            UPDATE  DetalleRequerimientos
            SET     IdRequerimiento = @IdRequerimiento,
                    NumeroItem = @NumeroItem,
                    Cantidad = @Cantidad,
                    IdUnidad = @IdUnidad,
                    IdArticulo = @IdArticulo,
                    FechaEntrega = @FechaEntrega,
                    Observaciones = @Observaciones,
                    Cantidad1 = @Cantidad1,
                    Cantidad2 = @Cantidad2,
                    IdDetalleLMateriales = @IdDetalleLMateriales,
                    IdComprador = @IdComprador,
                    NumeroFacturaCompra1 = @NumeroFacturaCompra1,
                    FechaFacturaCompra = @FechaFacturaCompra,
                    ImporteFacturaCompra = @ImporteFacturaCompra,
                    IdProveedor = @IdProveedor,
                    NumeroFacturaCompra2 = @NumeroFacturaCompra2,
                    Cumplido = @Cumplido,
                    DescripcionManual = @DescripcionManual,
                    IdRequerimientoOriginal = @IdRequerimientoOriginal,
                    IdDetalleRequerimientoOriginal = @IdDetalleRequerimientoOriginal,
                    IdOrigenTransmision = @IdOrigenTransmision,
                    IdAutorizoCumplido = @IdAutorizoCumplido,
                    IdDioPorCumplido = @IdDioPorCumplido,
                    FechaDadoPorCumplido = @FechaDadoPorCumplido,
                    ObservacionesCumplido = @ObservacionesCumplido,
                    Costo = @Costo,
                    OrigenDescripcion = @OrigenDescripcion,
                    TipoDesignacion = @TipoDesignacion,
                    IdLiberoParaCompras = @IdLiberoParaCompras,
                    FechaLiberacionParaCompras = @FechaLiberacionParaCompras,
                    Recepcionado = @Recepcionado,
                    Pagina = @Pagina,
                    Item = @Item,
                    Figura = @Figura,
                    CodigoDistribucion = @CodigoDistribucion,
                    IdEquipoDestino = @IdEquipoDestino,
                    Entregado = @Entregado,
                    FechaAsignacionComprador = @FechaAsignacionComprador,
                    MoP = @MoP,
                    IdDetalleObraDestino = @IdDetalleObraDestino,
                    Adjunto = @Adjunto,
                    ArchivoAdjunto1 = @ArchivoAdjunto1
            WHERE   ( IdDetalleRequerimiento = @IdDetalleRequerimiento )
        END

    IF @@ERROR <> 0 
        RETURN -1
    ELSE 
        RETURN @IdDetalleRequerimiento

GO


--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetRequerimientos_E]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetRequerimientos_E]
go




CREATE PROCEDURE [dbo].[wDetRequerimientos_E]
    @IdDetalleRequerimiento INT
AS 
    DELETE  [DetalleRequerimientos]
    WHERE   ( IdDetalleRequerimiento = @IdDetalleRequerimiento )

GO

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetRequerimientos_T]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetRequerimientos_T]
go



CREATE PROCEDURE [dbo].[wDetRequerimientos_T]
    @IdDetalleRequerimiento INT
AS 
    SELECT  *
    FROM    [DetalleRequerimientos]
    WHERE   ( IdDetalleRequerimiento = @IdDetalleRequerimiento )

GO

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetRequerimientos_TT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetRequerimientos_TT]
go



CREATE PROCEDURE [dbo].[wDetRequerimientos_TT] @IdRequerimiento INT
AS 
    SELECT  DetReq.*,
            Requerimientos.NumeroRequerimiento,
            Requerimientos.FechaRequerimiento,
            Requerimientos.Aprobo,
            Requerimientos.IdObra AS [IdObra],
            Articulos.Descripcion AS [Articulo],
            Articulos.Codigo,
            ISNULL(Unidades.Abreviatura, Unidades.Descripcion) AS [Unidad],
            ( SELECT    SUM(DetRec.Cantidad)
              FROM      DetalleRecepciones DetRec
                        LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
              WHERE     DetReq.IdDetalleRequerimiento = DetRec.IdDetalleRequerimiento
                        AND ( Recepciones.Anulada IS NULL
                              OR Recepciones.Anulada <> 'SI'
                            )
            ) AS [Entregado],
            DetReq.Cantidad
            - ISNULL(( SELECT   SUM(DetRec.Cantidad)
                       FROM     DetalleRecepciones DetRec
                                LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion = DetRec.IdRecepcion
                       WHERE    DetRec.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
                                AND ( Recepciones.Anulada IS NULL
                                      OR Recepciones.Anulada <> 'SI'
                                    )
                     ), 0) AS [Pendiente],
            ISNULL(( SELECT SUM(DetallePedidos.Cantidad)
                     FROM   DetallePedidos
                     WHERE  DetallePedidos.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
                            AND ( DetallePedidos.Cumplido IS NULL
                                  OR DetallePedidos.Cumplido <> 'AN'
                                )
                   ), 0) AS [Pedido],
            ISNULL(( SELECT SUM(DetalleValesSalida.Cantidad)
                     FROM   DetalleValesSalida
                     WHERE  DetalleValesSalida.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
                            AND ( DetalleValesSalida.Estado IS NULL
                                  OR DetalleValesSalida.Estado <> 'AN'
                                )
                   ), 0) AS [SalidaPorVales],
            0 AS [Reservado],
            Obras.NumeroObra AS [Obra],
            Obras.NumeroObra + ' ' + Obras.Descripcion AS [Obra1],
            Clientes.RazonSocial AS [Cliente],
            Equipos.Descripcion AS [Equipo],
            Rubros.Descripcion AS [Rubro],
            ISNULL(ControlesCalidad.Abreviatura, ControlesCalidad.Descripcion) AS [CC],
            E1.Nombre AS [Libero],
            E2.Nombre AS [Solicito],
            E3.Nombre AS [Comprador],
            Proveedores.RazonSocial AS [ProveedorCompra]
    FROM    DetalleRequerimientos DetReq
            LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetReq.IdRequerimiento
            LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Unidades ON DetReq.IdUnidad = Unidades.IdUnidad
            LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
            LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
            LEFT OUTER JOIN Equipos ON DetReq.IdEquipo = Equipos.IdEquipo
            LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
            LEFT OUTER JOIN ControlesCalidad ON DetReq.IdControlCalidad = ControlesCalidad.IdControlCalidad
            LEFT OUTER JOIN Empleados E1 ON Requerimientos.Aprobo = E1.IdEmpleado
            LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
            LEFT OUTER JOIN Empleados E3 ON Requerimientos.IdComprador = E3.IdEmpleado
            LEFT OUTER JOIN Proveedores ON DetReq.IdProveedor = Proveedores.IdProveedor
    WHERE   DetReq.IdRequerimiento = @IdRequerimiento

GO




--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wRequerimientos_T_ByEmployee]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wRequerimientos_T_ByEmployee]
go

CREATE PROCEDURE [dbo].[wRequerimientos_T_ByEmployee]
    @IdRequerimiento INT = NULL,
    @IdSolicito INT
AS 
    SET NOCOUNT ON

    SET @IdRequerimiento = ISNULL(@IdRequerimiento, -1)

    DECLARE @ActivarSolicitudMateriales VARCHAR(2)
    SET @ActivarSolicitudMateriales = ISNULL(( SELECT TOP 1
                                                        P.ActivarSolicitudMateriales
                                               FROM     Parametros P
                                               WHERE    P.IdParametro = 1
                                             ), 'NO')

/* PRESUPUESTOS */
    CREATE TABLE #Auxiliar0
        (
          IdRequerimiento INTEGER,
          Presupuestos VARCHAR(100)
        )

    CREATE TABLE #Auxiliar1
        (
          IdRequerimiento INTEGER,
          Presupuesto VARCHAR(13)
        )
    INSERT  INTO #Auxiliar1
            SELECT  DetReq.IdRequerimiento,
                    CONVERT(VARCHAR, Presupuestos.Numero)
                    + CASE WHEN Presupuestos.Subnumero IS NOT NULL
                           THEN '/' + CONVERT(VARCHAR, Presupuestos.Subnumero)
                           ELSE ''
                      END
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN DetallePresupuestos ON DetReq.IdDetalleRequerimiento = DetallePresupuestos.IdDetalleRequerimiento
                    LEFT OUTER JOIN Presupuestos ON DetallePresupuestos.IdPresupuesto = Presupuestos.IdPresupuesto
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
            WHERE   ( @IdRequerimiento = -1
                      OR DetReq.IdRequerimiento = @IdRequerimiento
                    )
                    AND Requerimientos.IdSolicito = @IdSolicito
                    AND Requerimientos.Cumplido <> 'AN'

    CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 ( IdRequerimiento, Presupuesto )
    ON  [PRIMARY]

    INSERT  INTO #Auxiliar0
            SELECT  IdRequerimiento,
                    ''
            FROM    #Auxiliar1
            GROUP BY IdRequerimiento

/*  CURSOR  */
    DECLARE @IdRequerimiento1 INT,
        @Presupuesto VARCHAR(13),
        @P VARCHAR(100),
        @Corte INT
    SET @Corte = 0
    SET @P = ''
    DECLARE Cur CURSOR LOCAL FORWARD_ONLY
        FOR SELECT  IdRequerimiento,
                    Presupuesto
            FROM    #Auxiliar1
            ORDER BY IdRequerimiento
    OPEN Cur
    FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Presupuesto
    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @Corte <> @IdRequerimiento1 
                BEGIN
                    IF @Corte <> 0 
                        BEGIN
                            UPDATE  #Auxiliar0
                            SET     Presupuestos = SUBSTRING(@P, 1, 100)
                            WHERE   #Auxiliar0.IdRequerimiento = @Corte
                        END
                    SET @P = ''
                    SET @Corte = @IdRequerimiento1
                END
            IF NOT @Presupuesto IS NULL 
                IF PATINDEX('%' + @Presupuesto + ' ' + '%', @P) = 0 
                    SET @P = @P + @Presupuesto + ' '
            FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Presupuesto
        END
    IF @Corte <> 0 
        BEGIN
            UPDATE  #Auxiliar0
            SET     Presupuestos = SUBSTRING(@P, 1, 100)
            WHERE   #Auxiliar0.IdRequerimiento = @Corte
        END
    CLOSE Cur
    DEALLOCATE Cur


/* COMPARATIVAS */
    CREATE TABLE #Auxiliar2
        (
          IdRequerimiento INTEGER,
          Comparativas VARCHAR(100)
        )

    CREATE TABLE #Auxiliar3
        (
          IdRequerimiento INTEGER,
          Comparativa INTEGER
        )
    INSERT  INTO #Auxiliar3
            SELECT  DetReq.IdRequerimiento,
                    Comparativas.Numero
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN DetallePresupuestos ON DetReq.IdDetalleRequerimiento = DetallePresupuestos.IdDetalleRequerimiento
                    LEFT OUTER JOIN DetalleComparativas ON DetallePresupuestos.IdDetallePresupuesto = DetalleComparativas.IdDetallePresupuesto
                    LEFT OUTER JOIN Comparativas ON DetalleComparativas.IdComparativa = Comparativas.IdComparativa
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
            WHERE   ( @IdRequerimiento = -1
                      OR DetReq.IdRequerimiento = @IdRequerimiento
                    )
                    AND Requerimientos.IdSolicito = @IdSolicito
                    AND Requerimientos.Cumplido <> 'AN'

    CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 ( IdRequerimiento, Comparativa )
    ON  [PRIMARY]

    INSERT  INTO #Auxiliar2
            SELECT  IdRequerimiento,
                    ''
            FROM    #Auxiliar3
            GROUP BY IdRequerimiento

/*  CURSOR  */
    DECLARE @Comparativa INT,
        @C VARCHAR(100)
    SET @Corte = 0
    SET @C = ''
    DECLARE Cur CURSOR LOCAL FORWARD_ONLY
        FOR SELECT  IdRequerimiento,
                    Comparativa
            FROM    #Auxiliar3
            ORDER BY IdRequerimiento
    OPEN Cur
    FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Comparativa
    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @Corte <> @IdRequerimiento1 
                BEGIN
                    IF @Corte <> 0 
                        BEGIN
                            UPDATE  #Auxiliar2
                            SET     Comparativas = SUBSTRING(@C, 1, 100)
                            WHERE   #Auxiliar2.IdRequerimiento = @Corte
                        END
                    SET @C = ''
                    SET @Corte = @IdRequerimiento1
                END
            IF NOT @Comparativa IS NULL 
                IF PATINDEX('%' + CONVERT(VARCHAR, @Comparativa) + ' ' + '%',
                            @C) = 0 
                    SET @C = @C + CONVERT(VARCHAR, @Comparativa) + ' '
            FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Comparativa
        END
    IF @Corte <> 0 
        BEGIN
            UPDATE  #Auxiliar2
            SET     Comparativas = SUBSTRING(@C, 1, 100)
            WHERE   #Auxiliar2.IdRequerimiento = @Corte
        END
    CLOSE Cur
    DEALLOCATE Cur


/* PEDIDOS */
    CREATE TABLE #Auxiliar4
        (
          IdRequerimiento INTEGER,
          Pedidos VARCHAR(100)
        )

    CREATE TABLE #Auxiliar5
        (
          IdRequerimiento INTEGER,
          Pedido VARCHAR(13)
        )
    INSERT  INTO #Auxiliar5
            SELECT  DetReq.IdRequerimiento,
                    CONVERT(VARCHAR, Pedidos.NumeroPedido)
                    + CASE WHEN Pedidos.Subnumero IS NOT NULL
                           THEN '/' + CONVERT(VARCHAR, Pedidos.Subnumero)
                           ELSE ''
                      END
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN DetallePedidos ON DetReq.IdDetalleRequerimiento = DetallePedidos.IdDetalleRequerimiento
                    LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
            WHERE   ( @IdRequerimiento = -1
                      OR DetReq.IdRequerimiento = @IdRequerimiento
                    )
                    AND Requerimientos.IdSolicito = @IdSolicito
                    AND Requerimientos.Cumplido <> 'AN'

    CREATE NONCLUSTERED INDEX IX__Auxiliar5 ON #Auxiliar5 ( IdRequerimiento, Pedido )
    ON  [PRIMARY]

    INSERT  INTO #Auxiliar4
            SELECT  IdRequerimiento,
                    ''
            FROM    #Auxiliar5
            GROUP BY IdRequerimiento

/*  CURSOR  */
    DECLARE @Pedido VARCHAR(13)
    SET @Corte = 0
    SET @P = ''
    DECLARE Cur CURSOR LOCAL FORWARD_ONLY
        FOR SELECT  IdRequerimiento,
                    Pedido
            FROM    #Auxiliar5
            ORDER BY IdRequerimiento
    OPEN Cur
    FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Pedido
    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @Corte <> @IdRequerimiento1 
                BEGIN
                    IF @Corte <> 0 
                        BEGIN
                            UPDATE  #Auxiliar4
                            SET     Pedidos = SUBSTRING(@P, 1, 100)
                            WHERE   #Auxiliar4.IdRequerimiento = @Corte
                        END
                    SET @P = ''
                    SET @Corte = @IdRequerimiento1
                END
            IF NOT @Pedido IS NULL 
                IF PATINDEX('%' + @Pedido + ' ' + '%', @P) = 0 
                    SET @P = @P + @Pedido + ' '
            FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Pedido
        END
    IF @Corte <> 0 
        BEGIN
            UPDATE  #Auxiliar4
            SET     Pedidos = SUBSTRING(@P, 1, 100)
            WHERE   #Auxiliar4.IdRequerimiento = @Corte
        END
    CLOSE Cur
    DEALLOCATE Cur


/* RECEPCION DE MATERIALES */
    CREATE TABLE #Auxiliar6
        (
          IdRequerimiento INTEGER,
          Recepciones VARCHAR(100)
        )

    CREATE TABLE #Auxiliar7
        (
          IdRequerimiento INTEGER,
          Recepcion VARCHAR(20)
        )
    INSERT  INTO #Auxiliar7
            SELECT  DetReq.IdRequerimiento,
                    CASE WHEN Recepciones.SubNumero IS NOT NULL
                         THEN SUBSTRING(SUBSTRING('0000', 1,
                                                  4
                                                  - LEN(CONVERT(VARCHAR, Recepciones.NumeroRecepcion1)))
                                        + CONVERT(VARCHAR, Recepciones.NumeroRecepcion1)
                                        + '-' + SUBSTRING('00000000', 1,
                                                          8
                                                          - LEN(CONVERT(VARCHAR, Recepciones.NumeroRecepcion2)))
                                        + CONVERT(VARCHAR, Recepciones.NumeroRecepcion2)
                                        + '/'
                                        + CONVERT(VARCHAR, Recepciones.SubNumero),
                                        1, 20)
                         ELSE SUBSTRING(SUBSTRING('0000', 1,
                                                  4
                                                  - LEN(CONVERT(VARCHAR, Recepciones.NumeroRecepcion1)))
                                        + CONVERT(VARCHAR, Recepciones.NumeroRecepcion1)
                                        + '-' + SUBSTRING('00000000', 1,
                                                          8
                                                          - LEN(CONVERT(VARCHAR, Recepciones.NumeroRecepcion2)))
                                        + CONVERT(VARCHAR, Recepciones.NumeroRecepcion2),
                                        1, 20)
                    END
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN DetalleRecepciones ON DetReq.IdDetalleRequerimiento = DetalleRecepciones.IdDetalleRequerimiento
                    LEFT OUTER JOIN Recepciones ON DetalleRecepciones.IdRecepcion = Recepciones.IdRecepcion
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
            WHERE   ( @IdRequerimiento = -1
                      OR DetReq.IdRequerimiento = @IdRequerimiento
                    )
                    AND Requerimientos.IdSolicito = @IdSolicito
                    AND Requerimientos.Cumplido <> 'AN'


    CREATE NONCLUSTERED INDEX IX__Auxiliar7 ON #Auxiliar7 ( IdRequerimiento, Recepcion )
    ON  [PRIMARY]

    INSERT  INTO #Auxiliar6
            SELECT  IdRequerimiento,
                    ''
            FROM    #Auxiliar7
            GROUP BY IdRequerimiento

/*  CURSOR  */
    DECLARE @Recepcion VARCHAR(20)
    SET @Corte = 0
    SET @P = ''
    DECLARE Cur CURSOR LOCAL FORWARD_ONLY
        FOR SELECT  IdRequerimiento,
                    Recepcion
            FROM    #Auxiliar7
            ORDER BY IdRequerimiento
    OPEN Cur
    FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Recepcion
    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @Corte <> @IdRequerimiento1 
                BEGIN
                    IF @Corte <> 0 
                        BEGIN
                            UPDATE  #Auxiliar6
                            SET     Recepciones = SUBSTRING(@P, 1, 100)
                            WHERE   IdRequerimiento = @Corte
                        END
                    SET @P = ''
                    SET @Corte = @IdRequerimiento1
                END
            IF NOT @Recepcion IS NULL 
                IF PATINDEX('%' + @Recepcion + ' ' + '%', @P) = 0 
                    SET @P = @P + @Recepcion + ' '
            FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Recepcion
        END
    IF @Corte <> 0 
        BEGIN
            UPDATE  #Auxiliar6
            SET     Recepciones = SUBSTRING(@P, 1, 100)
            WHERE   IdRequerimiento = @Corte
        END
    CLOSE Cur
    DEALLOCATE Cur


/* SALIDAS DE MATERIALES */
    CREATE TABLE #Auxiliar8
        (
          IdRequerimiento INTEGER,
          Salidas VARCHAR(100)
        )

    CREATE TABLE #Auxiliar9
        (
          IdRequerimiento INTEGER,
          Salida VARCHAR(13)
        )
    INSERT  INTO #Auxiliar9
            SELECT  DetReq.IdRequerimiento,
                    SUBSTRING(SUBSTRING('0000', 1,
                                        4
                                        - LEN(CONVERT(VARCHAR, ISNULL(SalidasMateriales.NumeroSalidaMateriales2, 0))))
                              + CONVERT(VARCHAR, ISNULL(SalidasMateriales.NumeroSalidaMateriales2,
                                                        0)) + '-'
                              + SUBSTRING('00000000', 1,
                                          8
                                          - LEN(CONVERT(VARCHAR, SalidasMateriales.NumeroSalidaMateriales)))
                              + CONVERT(VARCHAR, SalidasMateriales.NumeroSalidaMateriales),
                              1, 13)
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN DetalleValesSalida ON DetReq.IdDetalleRequerimiento = DetalleValesSalida.IdDetalleRequerimiento
                    LEFT OUTER JOIN DetalleSalidasMateriales ON DetalleValesSalida.IdDetalleValeSalida = DetalleSalidasMateriales.IdDetalleValeSalida
                    LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
            WHERE   ( @IdRequerimiento = -1
                      OR DetReq.IdRequerimiento = @IdRequerimiento
                    )
                    AND Requerimientos.IdSolicito = @IdSolicito
                    AND Requerimientos.Cumplido <> 'AN'


    CREATE NONCLUSTERED INDEX IX__Auxiliar9 ON #Auxiliar9 ( IdRequerimiento, Salida )
    ON  [PRIMARY]

    INSERT  INTO #Auxiliar8
            SELECT  IdRequerimiento,
                    ''
            FROM    #Auxiliar9
            GROUP BY IdRequerimiento

/*  CURSOR  */
    DECLARE @Salida VARCHAR(13)
    SET @Corte = 0
    SET @P = ''
    DECLARE Cur CURSOR LOCAL FORWARD_ONLY
        FOR SELECT  IdRequerimiento,
                    Salida
            FROM    #Auxiliar9
            ORDER BY IdRequerimiento
    OPEN Cur
    FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Salida
    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @Corte <> @IdRequerimiento1 
                BEGIN
                    IF @Corte <> 0 
                        BEGIN
                            UPDATE  #Auxiliar8
                            SET     Salidas = SUBSTRING(@P, 1, 100)
                            WHERE   IdRequerimiento = @Corte
                        END
                    SET @P = ''
                    SET @Corte = @IdRequerimiento1
                END
            IF NOT @Salida IS NULL 
                IF PATINDEX('%' + @Salida + ' ' + '%', @P) = 0 
                    SET @P = @P + @Salida + ' '
            FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Salida
        END
    IF @Corte <> 0 
        BEGIN
            UPDATE  #Auxiliar8
            SET     Salidas = SUBSTRING(@P, 1, 100)
            WHERE   IdRequerimiento = @Corte
        END
    CLOSE Cur
    DEALLOCATE Cur

    SET NOCOUNT OFF

    SELECT  Requerimientos.*,
            Obras.NumeroObra + ' ' + Obras.Descripcion AS [Obra],
            #Auxiliar0.Presupuestos AS [Presupuestos],
            #Auxiliar2.Comparativas AS [Comparativas],
            #Auxiliar4.Pedidos AS [Pedidos],
            #Auxiliar6.Recepciones AS [Recepciones],
            #Auxiliar8.Salidas AS [Salidas],
            ( SELECT    COUNT(*)
              FROM      DetalleRequerimientos Det
              WHERE     Det.IdRequerimiento = Requerimientos.IdRequerimiento
            ) AS [Items],
            ( SELECT TOP 1
                        E.Nombre
              FROM      Empleados E
              WHERE     Requerimientos.Aprobo = E.IdEmpleado
            ) AS [Libero],
            ( SELECT TOP 1
                        E.Nombre
              FROM      Empleados E
              WHERE     Requerimientos.IdSolicito = E.IdEmpleado
            ) AS [Solicito],
            ( SELECT TOP 1
                        E.Nombre
              FROM      Empleados E
              WHERE     Requerimientos.IdComprador = E.IdEmpleado
            ) AS [Comprador],
            Sectores.Descripcion AS [Sector],
            ArchivosATransmitirDestinos.Descripcion AS [Origen],
            Articulos.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS
            + ' ' + Articulos.Descripcion AS [EquipoDestino],
            TiposCompra.Descripcion AS [TipoCompra],
            ( SELECT TOP 1
                        E.Nombre
              FROM      Empleados E
              WHERE     E.IdEmpleado = ( SELECT TOP 1
                                                Aut.IdAutorizo
                                         FROM   AutorizacionesPorComprobante Aut
                                         WHERE  Aut.IdFormulario = 3
                                                AND Aut.OrdenAutorizacion = 1
                                                AND Aut.IdComprobante = Requerimientos.IdRequerimiento
                                       )
            ) AS [SegundaFirma],
            ( SELECT TOP 1
                        Aut.FechaAutorizacion
              FROM      AutorizacionesPorComprobante Aut
              WHERE     Aut.IdFormulario = 3
                        AND Aut.OrdenAutorizacion = 1
                        AND Aut.IdComprobante = Requerimientos.IdRequerimiento
            ) AS [FechaSegundaFirma],
            ( SELECT TOP 1
                        E.Nombre
              FROM      Empleados E
              WHERE     E.IdEmpleado = ( SELECT TOP 1
                                                Det.IdComprador
                                         FROM   DetalleRequerimientos Det
                                         WHERE  Det.IdRequerimiento = Requerimientos.IdRequerimiento
                                                AND Det.IdComprador IS NOT NULL
                                       )
            ) AS [CompradorItem]
    FROM    Requerimientos
            LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
            LEFT OUTER JOIN CentrosCosto ON Requerimientos.IdCentroCosto = CentrosCosto.IdCentroCosto
            LEFT OUTER JOIN Sectores ON Requerimientos.IdSector = Sectores.IdSector
            LEFT OUTER JOIN Monedas ON Requerimientos.IdMoneda = Monedas.IdMoneda
            LEFT OUTER JOIN ArchivosATransmitirDestinos ON Requerimientos.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
            LEFT OUTER JOIN Articulos ON Requerimientos.IdEquipoDestino = Articulos.IdArticulo
            LEFT OUTER JOIN #Auxiliar0 ON Requerimientos.IdRequerimiento = #Auxiliar0.IdRequerimiento
            LEFT OUTER JOIN #Auxiliar2 ON Requerimientos.IdRequerimiento = #Auxiliar2.IdRequerimiento
            LEFT OUTER JOIN #Auxiliar4 ON Requerimientos.IdRequerimiento = #Auxiliar4.IdRequerimiento
            LEFT OUTER JOIN #Auxiliar6 ON Requerimientos.IdRequerimiento = #Auxiliar6.IdRequerimiento
            LEFT OUTER JOIN #Auxiliar8 ON Requerimientos.IdRequerimiento = #Auxiliar8.IdRequerimiento
            LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
    WHERE   ( @IdRequerimiento = -1
              OR Requerimientos.IdRequerimiento = @IdRequerimiento
            )
            AND ( Confirmado IS NULL
                  OR Confirmado <> 'NO'
                )
            AND Requerimientos.IdSolicito = @IdSolicito
            AND Requerimientos.Cumplido <> 'AN'
    ORDER BY Requerimientos.FechaRequerimiento DESC,
            Requerimientos.NumeroRequerimiento DESC

    DROP TABLE #Auxiliar0
    DROP TABLE #Auxiliar1
    DROP TABLE #Auxiliar2
    DROP TABLE #Auxiliar3
    DROP TABLE #Auxiliar4
    DROP TABLE #Auxiliar5
    DROP TABLE #Auxiliar6
    DROP TABLE #Auxiliar7
    DROP TABLE #Auxiliar8
    DROP TABLE #Auxiliar9
GO

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
-- FIN -- de SPs de Web originales de Edu
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wClientes_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wClientes_A
go



CREATE Procedure wClientes_A

@IdCliente int output,
@RazonSocial	 				varchar(50),
@Direccion 					varchar(50),
@IdLocalidad	 				int,
@CodigoPostal	 				varchar(30),
@IdProvincia	 				int,
@IdPais	 				int,
@Telefono 					varchar(50),
@Fax		 				varchar(50),
@Email 						varchar(200),
@Cuit	 					varchar(13),
@IdCodigoIva	 				tinyint,
@FechaAlta	 				datetime,
@Contacto 					varchar(50),
@EnviarEmail					tinyint,
@DireccionEntrega				varchar(50),
@IdLocalidadEntrega				int,
@IdProvinciaEntrega				int,
@CodigoCliente					int,
@IdCuenta					int,
@Saldo						numeric(18,2),
@SaldoDocumentos				numeric(18,2),
@Vendedor1					int,
@CreditoMaximo				numeric(18,2),
@IGCondicion					int,
@IdCondicionVenta				int,
@IdMoneda					int,
@IBNumeroInscripcion				varchar(20),
@IBCondicion					int,
@TipoCliente					int,
@Codigo					varchar(10),
@IdListaPrecios					int,
@IdIBCondicionPorDefecto 			int,
@Confirmado					varchar(2),
@CodigoPresto					varchar(13),
@Observaciones				ntext,
@Importaciones_NumeroInscripcion		varchar(20),
@Importaciones_DenominacionInscripcion	varchar(10),
@IdCuentaMonedaExt				int,
@Cobrador					int,
@Auxiliar					varchar(50),
@IdIBCondicionPorDefecto2			int,
@IdIBCondicionPorDefecto3			int,
@IdEstado					int,
@NombreFantasia				varchar(50),
@EsAgenteRetencionIVA			varchar(2),
@BaseMinimaParaPercepcionIVA		numeric(18,2),
@PorcentajePercepcionIVA			numeric(6,2),
@IdUsuarioIngreso 				int,
@FechaIngreso 					datetime,
@IdUsuarioModifico 				int,
@FechaModifico 				datetime,
@PorcentajeIBDirecto				numeric(6,2),
@FechaInicioVigenciaIBDirecto			datetime,
@FechaFinVigenciaIBDirecto			datetime,
@GrupoIIBB					int,
@IdBancoDebito int,
@CBU varchar(22),
@PorcentajeIBDirectoCapital numeric(6,2),
@FechaInicioVigenciaIBDirectoCapital datetime,
@FechaFinVigenciaIBDirectoCapital datetime,
@GrupoIIBBCapital int

AS 

INSERT INTO Clientes
(
 RazonSocial,
 Direccion,
 IdLocalidad,
 CodigoPostal,
 IdProvincia,
 IdPais,
 Telefono,
 Fax,
 Email,
 Cuit,
 IdCodigoIva,
 FechaAlta,
 Contacto,
 EnviarEmail,
 DireccionEntrega,
 IdLocalidadEntrega,
 IdProvinciaEntrega,
 CodigoCliente,
 IdCuenta,
 Saldo,
 SaldoDocumentos,
 Vendedor1,
 CreditoMaximo,
 IGCondicion,
 IdCondicionVenta,
 IdMoneda,
 IBNumeroInscripcion,
 IBCondicion,
 TipoCliente,
 Codigo,
 IdListaPrecios,
 IdIBCondicionPorDefecto,
 Confirmado,
 CodigoPresto,
 Observaciones,
 Importaciones_NumeroInscripcion,
 Importaciones_DenominacionInscripcion,
 IdCuentaMonedaExt,
 Cobrador,
 Auxiliar,
 IdIBCondicionPorDefecto2,
 IdIBCondicionPorDefecto3,
 IdEstado,
 NombreFantasia,
 EsAgenteRetencionIVA,
 BaseMinimaParaPercepcionIVA,
 PorcentajePercepcionIVA,
 IdUsuarioIngreso,
 FechaIngreso, 
 IdUsuarioModifico,
 FechaModifico,
 PorcentajeIBDirecto,
 FechaInicioVigenciaIBDirecto,
 FechaFinVigenciaIBDirecto,
 GrupoIIBB,
 IdBancoDebito,
 CBU,
 PorcentajeIBDirectoCapital,
 FechaInicioVigenciaIBDirectoCapital,
 FechaFinVigenciaIBDirectoCapital,
 GrupoIIBBCapital
)
 VALUES 
(
 @RazonSocial,
 @Direccion,
 @IdLocalidad,
 @CodigoPostal,
 @IdProvincia,
 @IdPais,
 @Telefono,
 @Fax,
 @Email,
 @Cuit,
 @IdCodigoIva,
 @FechaAlta,
 @Contacto,
 @EnviarEmail,
 @DireccionEntrega,
 @IdLocalidadEntrega,
 @IdProvinciaEntrega,
 @CodigoCliente,
 @IdCuenta,
 @Saldo,
 @SaldoDocumentos,
 @Vendedor1,
 @CreditoMaximo,
 @IGCondicion,
 @IdCondicionVenta,
 @IdMoneda,
 @IBNumeroInscripcion,
 @IBCondicion,
 @TipoCliente,
 @Codigo,
 @IdListaPrecios,
 @IdIBCondicionPorDefecto,
 @Confirmado,
 @CodigoPresto,
 @Observaciones,
 @Importaciones_NumeroInscripcion,
 @Importaciones_DenominacionInscripcion,
 @IdCuentaMonedaExt,
 @Cobrador,
 @Auxiliar,
 @IdIBCondicionPorDefecto2,
 @IdIBCondicionPorDefecto3,
 @IdEstado,
 @NombreFantasia,
 @EsAgenteRetencionIVA,
 @BaseMinimaParaPercepcionIVA,
 @PorcentajePercepcionIVA,
 @IdUsuarioIngreso,
 @FechaIngreso,
 @IdUsuarioModifico,
 @FechaModifico,
 @PorcentajeIBDirecto,
 @FechaInicioVigenciaIBDirecto,
 @FechaFinVigenciaIBDirecto,
 @GrupoIIBB,
 @IdBancoDebito,
 @CBU,
 @PorcentajeIBDirectoCapital,
 @FechaInicioVigenciaIBDirectoCapital,
 @FechaFinVigenciaIBDirectoCapital,
 @GrupoIIBBCapital
)
SELECT @IdCliente=@@identity
RETURN(@IdCliente)

go

--////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wClientes_M]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wClientes_M
go


CREATE  Procedure wClientes_M

@IdCliente					int,
@RazonSocial	 				varchar(50),
@Direccion 					varchar(50),
@IdLocalidad	 				int,
@CodigoPostal	 				varchar(30),
@IdProvincia	 				int,
@IdPais	 				int,
@Telefono 					varchar(50),
@Fax		 				varchar(50),
@Email 						varchar(200),
@Cuit	 					varchar(13),
@IdCodigoIva	 				tinyint,
@FechaAlta	 				datetime,
@Contacto 					varchar(50),
@EnviarEmail					tinyint,
@DireccionEntrega				varchar(50),
@IdLocalidadEntrega				int,
@IdProvinciaEntrega				int,
@CodigoCliente					int,
@IdCuenta					int,
@Saldo						numeric(18,2),
@SaldoDocumentos				numeric(18,2),
@Vendedor1					int,
@CreditoMaximo				numeric(18,2),
@IGCondicion					int,
@IdCondicionVenta				int,
@IdMoneda					int,
@IBNumeroInscripcion				varchar(20),
@IBCondicion					int,
@TipoCliente					int,
@Codigo					varchar(10),
@IdListaPrecios					int,
@IdIBCondicionPorDefecto 			int,
@Confirmado					varchar(2),
@CodigoPresto					varchar(13),
@Observaciones				ntext,
@Importaciones_NumeroInscripcion		varchar(20),
@Importaciones_DenominacionInscripcion	varchar(10),
@IdCuentaMonedaExt				int,
@Cobrador					int,
@Auxiliar					varchar(50),
@IdIBCondicionPorDefecto2			int,
@IdIBCondicionPorDefecto3			int,
@IdEstado					int,
@NombreFantasia				varchar(50),
@EsAgenteRetencionIVA			varchar(2),
@BaseMinimaParaPercepcionIVA		numeric(18,2),
@PorcentajePercepcionIVA			numeric(6,2),
@IdUsuarioIngreso 				int,
@FechaIngreso 					datetime,
@IdUsuarioModifico 				int,
@FechaModifico 				datetime,
@PorcentajeIBDirecto				numeric(6,2),
@FechaInicioVigenciaIBDirecto			datetime,
@FechaFinVigenciaIBDirecto			datetime,
@GrupoIIBB					int,
@IdBancoDebito int,
@CBU varchar(22),
@PorcentajeIBDirectoCapital numeric(6,2),
@FechaInicioVigenciaIBDirectoCapital datetime,
@FechaFinVigenciaIBDirectoCapital datetime,
@GrupoIIBBCapital int

AS 

UPDATE Clientes
SET
 RazonSocial = @RazonSocial,
 Direccion = @Direccion,
 IdLocalidad = @IdLocalidad,
 CodigoPostal = @CodigoPostal,
 IdProvincia = @IdProvincia,
 IdPais = @IdPais,
 Telefono = @Telefono,
 Fax = @Fax,
 Email = @Email,
 Cuit = @Cuit,
 IdCodigoIva = @IdCodigoIva,
 FechaAlta = @FechaAlta,
 Contacto = @Contacto,
 EnviarEmail = @EnviarEmail,
 DireccionEntrega = @DireccionEntrega,
 IdLocalidadEntrega = @IdLocalidadEntrega,
 IdProvinciaEntrega = @IdProvinciaEntrega,
 CodigoCliente = @CodigoCliente,
 IdCuenta = @IdCuenta,
 Saldo = @Saldo,
 SaldoDocumentos = @SaldoDocumentos,
 Vendedor1 = @Vendedor1,
 CreditoMaximo = @CreditoMaximo,
 IGCondicion = @IGCondicion,
 IdCondicionVenta = @IdCondicionVenta,
 IdMoneda = @IdMoneda,
 IBNumeroInscripcion = @IBNumeroInscripcion,
 IBCondicion = @IBCondicion,
 TipoCliente = @TipoCliente,
 Codigo 	= @Codigo,
 IdListaPrecios = @IdListaPrecios,
 IdIBCondicionPorDefecto = @IdIBCondicionPorDefecto,
 Confirmado = @Confirmado,
 CodigoPresto = @CodigoPresto,
 Observaciones = @Observaciones,
 Importaciones_NumeroInscripcion=@Importaciones_NumeroInscripcion,
 Importaciones_DenominacionInscripcion=@Importaciones_DenominacionInscripcion,
 IdCuentaMonedaExt = @IdCuentaMonedaExt,
 Cobrador = @Cobrador,
 Auxiliar	= @Auxiliar,
 IdIBCondicionPorDefecto2 = @IdIBCondicionPorDefecto2,
 IdIBCondicionPorDefecto3 = @IdIBCondicionPorDefecto3,
 IdEstado = @IdEstado,
 NombreFantasia = @NombreFantasia,
 EsAgenteRetencionIVA	= @EsAgenteRetencionIVA,
 BaseMinimaParaPercepcionIVA = @BaseMinimaParaPercepcionIVA,
 PorcentajePercepcionIVA = @PorcentajePercepcionIVA,
 IdUsuarioIngreso = @IdUsuarioIngreso,
 FechaIngreso = @FechaIngreso,
 IdUsuarioModifico = @IdUsuarioModifico,
 FechaModifico = @FechaModifico,
 PorcentajeIBDirecto = @PorcentajeIBDirecto,
 FechaInicioVigenciaIBDirecto = @FechaInicioVigenciaIBDirecto,
 FechaFinVigenciaIBDirecto=@FechaFinVigenciaIBDirecto,
 GrupoIIBB = @GrupoIIBB,
 IdBancoDebito=@IdBancoDebito,
 CBU=@CBU,
 PorcentajeIBDirectoCapital=@PorcentajeIBDirectoCapital,
 FechaInicioVigenciaIBDirectoCapital=@FechaInicioVigenciaIBDirectoCapital,
 FechaFinVigenciaIBDirectoCapital=@FechaFinVigenciaIBDirectoCapital,
 GrupoIIBBCapital=@GrupoIIBBCapital
WHERE [IdCliente]=@IdCliente

RETURN(@IdCliente)

go



--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--COMPROBANTES DE PROVEEDORES (incluye fondos fijos, que es un comprobante sin IdProveedor/IdCuentaOtros,
--						que no afecta cuenta corriente)

--		encabezado:
--		_A
--		_E
--		_T
--		_TL
--		_T_ByEmployee
--
--		detalle:
--		_A
--		_E
--		_T
--		_TT

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wComprobantesProveedores_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wComprobantesProveedores_A
go



CREATE PROCEDURE [dbo].[wComprobantesProveedores_A]
    @IdComprobanteProveedor INT OUTPUT,
    @IdProveedor INT,
    @IdTipoComprobante INT,
    @FechaComprobante DATETIME,
    @Letra VARCHAR(1),
    @NumeroComprobante1 INT,
    @NumeroComprobante2 INT,
    @NumeroReferencia INT,
    @FechaRecepcion DATETIME,
    @FechaVencimiento DATETIME,
    @TotalBruto NUMERIC(12, 2),
    @TotalIva1 NUMERIC(12, 2),
    @TotalIva2 NUMERIC(12, 2),
    @TotalBonificacion NUMERIC(12, 2),
    @TotalComprobante NUMERIC(12, 2),
    @PorcentajeBonificacion NUMERIC(6, 2),
    @Observaciones NTEXT,
    @DiasVencimiento INT,
    @IdObra INT,
    @IdProveedorEventual INT,
    @IdOrdenPago INT,
    @IdCuenta INT,
    @IdMoneda INT,
    @CotizacionMoneda NUMERIC(18, 4),
    @CotizacionDolar NUMERIC(18, 4),
    @TotalIVANoDiscriminado NUMERIC(18, 2),
    @IdCuentaIvaCompras1 INT,
    @IVAComprasPorcentaje1 NUMERIC(6, 2),
    @IVAComprasImporte1 NUMERIC(18, 2),
    @IdCuentaIvaCompras2 INT,
    @IVAComprasPorcentaje2 NUMERIC(6, 2),
    @IVAComprasImporte2 NUMERIC(18, 2),
    @IdCuentaIvaCompras3 INT,
    @IVAComprasPorcentaje3 NUMERIC(6, 2),
    @IVAComprasImporte3 NUMERIC(18, 2),
    @IdCuentaIvaCompras4 INT,
    @IVAComprasPorcentaje4 NUMERIC(6, 2),
    @IVAComprasImporte4 NUMERIC(18, 2),
    @IdCuentaIvaCompras5 INT,
    @IVAComprasPorcentaje5 NUMERIC(6, 2),
    @IVAComprasImporte5 NUMERIC(18, 2),
    @IdCuentaIvaCompras6 INT,
    @IVAComprasPorcentaje6 NUMERIC(6, 2),
    @IVAComprasImporte6 NUMERIC(18, 2),
    @IdCuentaIvaCompras7 INT,
    @IVAComprasPorcentaje7 NUMERIC(6, 2),
    @IVAComprasImporte7 NUMERIC(18, 2),
    @IdCuentaIvaCompras8 INT,
    @IVAComprasPorcentaje8 NUMERIC(6, 2),
    @IVAComprasImporte8 NUMERIC(18, 2),
    @IdCuentaIvaCompras9 INT,
    @IVAComprasPorcentaje9 NUMERIC(6, 2),
    @IVAComprasImporte9 NUMERIC(18, 2),
    @IdCuentaIvaCompras10 INT,
    @IVAComprasPorcentaje10 NUMERIC(6, 2),
    @IVAComprasImporte10 NUMERIC(18, 2),
    @SubtotalGravado NUMERIC(18, 2),
    @SubtotalExento NUMERIC(18, 2),
    @AjusteIVA NUMERIC(18, 2),
    @PorcentajeIVAAplicacionAjuste NUMERIC(6, 2),
    @BienesOServicios VARCHAR(1),
    @IdDetalleOrdenPagoRetencionIVAAplicada INT,
    @IdIBCondicion INT,
    @PRESTOFactura VARCHAR(13),
    @Confirmado VARCHAR(2),
    @IdProvinciaDestino INT,
    @IdTipoRetencionGanancia INT,
    @NumeroCAI VARCHAR(20),
    @FechaVencimientoCAI DATETIME,
    @IdCodigoAduana INT,
    @IdCodigoDestinacion INT,
    @NumeroDespacho INT,
    @DigitoVerificadorNumeroDespacho VARCHAR(1),
    @FechaDespachoAPlaza DATETIME,
    @IdUsuarioIngreso INT,
    @FechaIngreso DATETIME,
    @IdUsuarioModifico INT,
    @FechaModifico DATETIME,
    @PRESTOProveedor VARCHAR(13),
    @IdCodigoIva INT,
    @CotizacionEuro NUMERIC(18, 4),
    @IdCondicionCompra INT,
    @Importacion_FOB NUMERIC(18, 2),
    @Importacion_PosicionAduana VARCHAR(20),
    @Importacion_Despacho VARCHAR(30),
    @Importacion_Guia VARCHAR(20),
    @Importacion_IdPaisOrigen INT,
    @Importacion_FechaEmbarque DATETIME,
    @Importacion_FechaOficializacion DATETIME,
    @REP_CTAPRO_INS VARCHAR(1),
    @REP_CTAPRO_UPD VARCHAR(1),
    @InformacionAuxiliar VARCHAR(50),
    @GravadoParaSUSS NUMERIC(18, 2),
    @PorcentajeParaSUSS NUMERIC(6, 2),
    @FondoReparo NUMERIC(18, 2),
    @AutoincrementarNumeroReferencia VARCHAR(2),
    @ReintegroImporte NUMERIC(18, 2),
    @ReintegroDespacho VARCHAR(20),
    @ReintegroIdMoneda INT,
    @ReintegroIdCuenta INT,
    @PrestoDestino VARCHAR(20),
    @IdFacturaVenta_RecuperoGastos INT,
    @IdNotaCreditoVenta_RecuperoGastos INT,
    @IdComprobanteImputado INT,
    @IdCuentaOtros INT,
    @PRESTOFechaProceso DATETIME,
    @DestinoPago VARCHAR(1),
    @NumeroRendicionFF INT,
    @Cuit VARCHAR(13),
    @FechaAsignacionPresupuesto DATETIME,
    @Dolarizada VARCHAR(2),
    @NumeroOrdenPagoFondoReparo INT,
    @IdListaPrecios INT,
    @IdComprobanteProveedorOriginal INT,
    @PorcentajeIVAParaMonotributistas NUMERIC(6, 2),
    @IdDiferenciaCambio INT,
    @ConfirmadoPorWeb VARCHAR(2)
AS 
    IF ISNULL(@IdComprobanteProveedor, 0) <= 0 
        BEGIN


            BEGIN TRAN

            IF ISNULL(@AutoincrementarNumeroReferencia, 'SI') = 'SI' 
                BEGIN
                    SET @NumeroReferencia = ISNULL(( SELECT TOP 1
                                                            P.ProximoComprobanteProveedorReferencia
                                                     FROM   Parametros P
                                                     WHERE  P.IdParametro = 1
                                                   ), 1)
                    UPDATE  Parametros
                    SET     ProximoComprobanteProveedorReferencia = @NumeroReferencia
                            + 1
                END

            INSERT  INTO [ComprobantesProveedores]
                    (
                      IdProveedor,
                      IdTipoComprobante,
                      FechaComprobante,
                      Letra,
                      NumeroComprobante1,
                      NumeroComprobante2,
                      NumeroReferencia,
                      FechaRecepcion,
                      FechaVencimiento,
                      TotalBruto,
                      TotalIva1,
                      TotalIva2,
                      TotalBonificacion,
                      TotalComprobante,
                      PorcentajeBonificacion,
                      Observaciones,
                      DiasVencimiento,
                      IdObra,
                      IdProveedorEventual,
                      IdOrdenPago,
                      IdCuenta,
                      IdMoneda,
                      CotizacionMoneda,
                      CotizacionDolar,
                      TotalIVANoDiscriminado,
                      IdCuentaIvaCompras1,
                      IVAComprasPorcentaje1,
                      IVAComprasImporte1,
                      IdCuentaIvaCompras2,
                      IVAComprasPorcentaje2,
                      IVAComprasImporte2,
                      IdCuentaIvaCompras3,
                      IVAComprasPorcentaje3,
                      IVAComprasImporte3,
                      IdCuentaIvaCompras4,
                      IVAComprasPorcentaje4,
                      IVAComprasImporte4,
                      IdCuentaIvaCompras5,
                      IVAComprasPorcentaje5,
                      IVAComprasImporte5,
                      IdCuentaIvaCompras6,
                      IVAComprasPorcentaje6,
                      IVAComprasImporte6,
                      IdCuentaIvaCompras7,
                      IVAComprasPorcentaje7,
                      IVAComprasImporte7,
                      IdCuentaIvaCompras8,
                      IVAComprasPorcentaje8,
                      IVAComprasImporte8,
                      IdCuentaIvaCompras9,
                      IVAComprasPorcentaje9,
                      IVAComprasImporte9,
                      IdCuentaIvaCompras10,
                      IVAComprasPorcentaje10,
                      IVAComprasImporte10,
                      SubtotalGravado,
                      SubtotalExento,
                      AjusteIVA,
                      PorcentajeIVAAplicacionAjuste,
                      BienesOServicios,
                      IdDetalleOrdenPagoRetencionIVAAplicada,
                      IdIBCondicion,
                      PRESTOFactura,
                      Confirmado,
                      IdProvinciaDestino,
                      IdTipoRetencionGanancia,
                      NumeroCAI,
                      FechaVencimientoCAI,
                      IdCodigoAduana,
                      IdCodigoDestinacion,
                      NumeroDespacho,
                      DigitoVerificadorNumeroDespacho,
                      FechaDespachoAPlaza,
                      IdUsuarioIngreso,
                      FechaIngreso,
                      IdUsuarioModifico,
                      FechaModifico,
                      PRESTOProveedor,
                      IdCodigoIva,
                      CotizacionEuro,
                      IdCondicionCompra,
                      Importacion_FOB,
                      Importacion_PosicionAduana,
                      Importacion_Despacho,
                      Importacion_Guia,
                      Importacion_IdPaisOrigen,
                      Importacion_FechaEmbarque,
                      Importacion_FechaOficializacion,
                      REP_CTAPRO_INS,
                      REP_CTAPRO_UPD,
                      InformacionAuxiliar,
                      GravadoParaSUSS,
                      PorcentajeParaSUSS,
                      FondoReparo,
                      AutoincrementarNumeroReferencia,
                      ReintegroImporte,
                      ReintegroDespacho,
                      ReintegroIdMoneda,
                      ReintegroIdCuenta,
                      PrestoDestino,
                      IdFacturaVenta_RecuperoGastos,
                      IdNotaCreditoVenta_RecuperoGastos,
                      IdComprobanteImputado,
                      IdCuentaOtros,
                      PRESTOFechaProceso,
                      DestinoPago,
                      NumeroRendicionFF,
                      Cuit,
                      FechaAsignacionPresupuesto,
                      Dolarizada,
                      NumeroOrdenPagoFondoReparo,
                      IdListaPrecios,
                      IdComprobanteProveedorOriginal,
                      PorcentajeIVAParaMonotributistas,
                      IdDiferenciaCambio,
                      ConfirmadoPorWeb
			  )
            VALUES  (
                      @IdProveedor,
                      @IdTipoComprobante,
                      @FechaComprobante,
                      @Letra,
                      @NumeroComprobante1,
                      @NumeroComprobante2,
                      @NumeroReferencia,
                      @FechaRecepcion,
                      @FechaVencimiento,
                      @TotalBruto,
                      @TotalIva1,
                      @TotalIva2,
                      @TotalBonificacion,
                      @TotalComprobante,
                      @PorcentajeBonificacion,
                      @Observaciones,
                      @DiasVencimiento,
                      @IdObra,
                      @IdProveedorEventual,
                      @IdOrdenPago,
                      @IdCuenta,
                      @IdMoneda,
                      @CotizacionMoneda,
                      @CotizacionDolar,
                      @TotalIVANoDiscriminado,
                      @IdCuentaIvaCompras1,
                      @IVAComprasPorcentaje1,
                      @IVAComprasImporte1,
                      @IdCuentaIvaCompras2,
                      @IVAComprasPorcentaje2,
                      @IVAComprasImporte2,
                      @IdCuentaIvaCompras3,
                      @IVAComprasPorcentaje3,
                      @IVAComprasImporte3,
                      @IdCuentaIvaCompras4,
                      @IVAComprasPorcentaje4,
                      @IVAComprasImporte4,
                      @IdCuentaIvaCompras5,
                      @IVAComprasPorcentaje5,
                      @IVAComprasImporte5,
                      @IdCuentaIvaCompras6,
                      @IVAComprasPorcentaje6,
                      @IVAComprasImporte6,
                      @IdCuentaIvaCompras7,
                      @IVAComprasPorcentaje7,
                      @IVAComprasImporte7,
                      @IdCuentaIvaCompras8,
                      @IVAComprasPorcentaje8,
                      @IVAComprasImporte8,
                      @IdCuentaIvaCompras9,
                      @IVAComprasPorcentaje9,
                      @IVAComprasImporte9,
                      @IdCuentaIvaCompras10,
                      @IVAComprasPorcentaje10,
                      @IVAComprasImporte10,
                      @SubtotalGravado,
                      @SubtotalExento,
                      @AjusteIVA,
                      @PorcentajeIVAAplicacionAjuste,
                      @BienesOServicios,
                      @IdDetalleOrdenPagoRetencionIVAAplicada,
                      @IdIBCondicion,
                      @PRESTOFactura,
                      @Confirmado,
                      @IdProvinciaDestino,
                      @IdTipoRetencionGanancia,
                      @NumeroCAI,
                      @FechaVencimientoCAI,
                      @IdCodigoAduana,
                      @IdCodigoDestinacion,
                      @NumeroDespacho,
                      @DigitoVerificadorNumeroDespacho,
                      @FechaDespachoAPlaza,
                      @IdUsuarioIngreso,
                      @FechaIngreso,
                      @IdUsuarioModifico,
                      @FechaModifico,
                      @PRESTOProveedor,
                      @IdCodigoIva,
                      @CotizacionEuro,
                      @IdCondicionCompra,
                      @Importacion_FOB,
                      @Importacion_PosicionAduana,
                      @Importacion_Despacho,
                      @Importacion_Guia,
                      @Importacion_IdPaisOrigen,
                      @Importacion_FechaEmbarque,
                      @Importacion_FechaOficializacion,
                      @REP_CTAPRO_INS,
                      @REP_CTAPRO_UPD,
                      @InformacionAuxiliar,
                      @GravadoParaSUSS,
                      @PorcentajeParaSUSS,
                      @FondoReparo,
                      @AutoincrementarNumeroReferencia,
                      @ReintegroImporte,
                      @ReintegroDespacho,
                      @ReintegroIdMoneda,
                      @ReintegroIdCuenta,
                      @PrestoDestino,
                      @IdFacturaVenta_RecuperoGastos,
                      @IdNotaCreditoVenta_RecuperoGastos,
                      @IdComprobanteImputado,
                      @IdCuentaOtros,
                      @PRESTOFechaProceso,
                      @DestinoPago,
                      @NumeroRendicionFF,
                      @Cuit,
                      @FechaAsignacionPresupuesto,
                      @Dolarizada,
                      @NumeroOrdenPagoFondoReparo,
                      @IdListaPrecios,
                      @IdComprobanteProveedorOriginal,
                      @PorcentajeIVAParaMonotributistas,
                      @IdDiferenciaCambio,
                      @ConfirmadoPorWeb
			  )

            SELECT  @IdComprobanteProveedor = @@identity

            IF @@ERROR <> 0 
                GOTO AbortTransaction

            COMMIT TRAN
            GOTO EndTransaction

            AbortTransaction:
            ROLLBACK TRAN

            EndTransaction:
        END
    ELSE 
        BEGIN
            UPDATE  ComprobantesProveedores
            SET     IdProveedor = @IdProveedor,
                    IdTipoComprobante = @IdTipoComprobante,
                    FechaComprobante = @FechaComprobante,
                    Letra = @Letra,
                    NumeroComprobante1 = @NumeroComprobante1,
                    NumeroComprobante2 = @NumeroComprobante2,
                    NumeroReferencia = @NumeroReferencia,
                    FechaRecepcion = @FechaRecepcion,
                    FechaVencimiento = @FechaVencimiento,
                    TotalBruto = @TotalBruto,
                    TotalIva1 = @TotalIva1,
                    TotalIva2 = @TotalIva2,
                    TotalBonificacion = @TotalBonificacion,
                    TotalComprobante = @TotalComprobante,
                    PorcentajeBonificacion = @PorcentajeBonificacion,
                    Observaciones = @Observaciones,
                    DiasVencimiento = @DiasVencimiento,
                    IdObra = @IdObra,
                    IdProveedorEventual = @IdProveedorEventual,
                    IdOrdenPago = @IdOrdenPago,
                    IdCuenta = @IdCuenta,
                    IdMoneda = @IdMoneda,
                    CotizacionMoneda = @CotizacionMoneda,
                    CotizacionDolar = @CotizacionDolar,
                    TotalIVANoDiscriminado = @TotalIVANoDiscriminado,
                    IdCuentaIvaCompras1 = @IdCuentaIvaCompras1,
                    IVAComprasPorcentaje1 = @IVAComprasPorcentaje1,
                    IVAComprasImporte1 = @IVAComprasImporte1,
                    IdCuentaIvaCompras2 = @IdCuentaIvaCompras2,
                    IVAComprasPorcentaje2 = @IVAComprasPorcentaje2,
                    IVAComprasImporte2 = @IVAComprasImporte2,
                    IdCuentaIvaCompras3 = @IdCuentaIvaCompras3,
                    IVAComprasPorcentaje3 = @IVAComprasPorcentaje3,
                    IVAComprasImporte3 = @IVAComprasImporte3,
                    IdCuentaIvaCompras4 = @IdCuentaIvaCompras4,
                    IVAComprasPorcentaje4 = @IVAComprasPorcentaje4,
                    IVAComprasImporte4 = @IVAComprasImporte4,
                    IdCuentaIvaCompras5 = @IdCuentaIvaCompras5,
                    IVAComprasPorcentaje5 = @IVAComprasPorcentaje5,
                    IVAComprasImporte5 = @IVAComprasImporte5,
                    IdCuentaIvaCompras6 = @IdCuentaIvaCompras6,
                    IVAComprasPorcentaje6 = @IVAComprasPorcentaje6,
                    IVAComprasImporte6 = @IVAComprasImporte6,
                    IdCuentaIvaCompras7 = @IdCuentaIvaCompras7,
                    IVAComprasPorcentaje7 = @IVAComprasPorcentaje7,
                    IVAComprasImporte7 = @IVAComprasImporte7,
                    IdCuentaIvaCompras8 = @IdCuentaIvaCompras8,
                    IVAComprasPorcentaje8 = @IVAComprasPorcentaje8,
                    IVAComprasImporte8 = @IVAComprasImporte8,
                    IdCuentaIvaCompras9 = @IdCuentaIvaCompras9,
                    IVAComprasPorcentaje9 = @IVAComprasPorcentaje9,
                    IVAComprasImporte9 = @IVAComprasImporte9,
                    IdCuentaIvaCompras10 = @IdCuentaIvaCompras10,
                    IVAComprasPorcentaje10 = @IVAComprasPorcentaje10,
                    IVAComprasImporte10 = @IVAComprasImporte10,
                    SubtotalGravado = @SubtotalGravado,
                    SubtotalExento = @SubtotalExento,
                    AjusteIVA = @AjusteIVA,
                    PorcentajeIVAAplicacionAjuste = @PorcentajeIVAAplicacionAjuste,
                    BienesOServicios = @BienesOServicios,
                    IdDetalleOrdenPagoRetencionIVAAplicada = @IdDetalleOrdenPagoRetencionIVAAplicada,
                    IdIBCondicion = @IdIBCondicion,
                    PRESTOFactura = @PRESTOFactura,
                    Confirmado = @Confirmado,
                    IdProvinciaDestino = @IdProvinciaDestino,
                    IdTipoRetencionGanancia = @IdTipoRetencionGanancia,
                    NumeroCAI = @NumeroCAI,
                    FechaVencimientoCAI = @FechaVencimientoCAI,
                    IdCodigoAduana = @IdCodigoAduana,
                    IdCodigoDestinacion = @IdCodigoDestinacion,
                    NumeroDespacho = @NumeroDespacho,
                    DigitoVerificadorNumeroDespacho = @DigitoVerificadorNumeroDespacho,
                    FechaDespachoAPlaza = @FechaDespachoAPlaza,
                    IdUsuarioIngreso = @IdUsuarioIngreso,
                    FechaIngreso = @FechaIngreso,
                    IdUsuarioModifico = @IdUsuarioModifico,
                    FechaModifico = @FechaModifico,
                    PRESTOProveedor = @PRESTOProveedor,
                    IdCodigoIva = @IdCodigoIva,
                    CotizacionEuro = @CotizacionEuro,
                    IdCondicionCompra = @IdCondicionCompra,
                    Importacion_FOB = @Importacion_FOB,
                    Importacion_PosicionAduana = @Importacion_PosicionAduana,
                    Importacion_Despacho = @Importacion_Despacho,
                    Importacion_Guia = @Importacion_Guia,
                    Importacion_IdPaisOrigen = @Importacion_IdPaisOrigen,
                    Importacion_FechaEmbarque = @Importacion_FechaEmbarque,
                    Importacion_FechaOficializacion = @Importacion_FechaOficializacion,
                    InformacionAuxiliar = @InformacionAuxiliar,
                    GravadoParaSUSS = @GravadoParaSUSS,
                    PorcentajeParaSUSS = @PorcentajeParaSUSS,
                    FondoReparo = @FondoReparo,
                    ReintegroImporte = @ReintegroImporte,
                    ReintegroDespacho = @ReintegroDespacho,
                    ReintegroIdMoneda = @ReintegroIdMoneda,
                    ReintegroIdCuenta = @ReintegroIdCuenta,
                    PrestoDestino = @PrestoDestino,
                    IdFacturaVenta_RecuperoGastos = @IdFacturaVenta_RecuperoGastos,
                    IdNotaCreditoVenta_RecuperoGastos = @IdNotaCreditoVenta_RecuperoGastos,
                    IdComprobanteImputado = @IdComprobanteImputado,
                    IdCuentaOtros = @IdCuentaOtros,
                    PRESTOFechaProceso = @PRESTOFechaProceso,
                    DestinoPago = @DestinoPago,
                    NumeroRendicionFF = @NumeroRendicionFF,
                    Cuit = @Cuit,
                    FechaAsignacionPresupuesto = @FechaAsignacionPresupuesto,
                    Dolarizada = @Dolarizada,
                    NumeroOrdenPagoFondoReparo = @NumeroOrdenPagoFondoReparo,
                    IdListaPrecios = @IdListaPrecios,
                    IdComprobanteProveedorOriginal = @IdComprobanteProveedorOriginal,
                    PorcentajeIVAParaMonotributistas = @PorcentajeIVAParaMonotributistas,
                    IdDiferenciaCambio = @IdDiferenciaCambio,
                    ConfirmadoPorWeb = @ConfirmadoPorWeb
            WHERE   ( IdComprobanteProveedor = @IdComprobanteProveedor )
        END
	

    IF @@ERROR <> 0 
        RETURN -1
    ELSE 
        RETURN @IdComprobanteProveedor


go


--/////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wComprobantesProveedores_T]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wComprobantesProveedores_T]
go



CREATE PROCEDURE [dbo].[wComprobantesProveedores_T]
    @IdComprobanteProveedor INT = NULL
AS 
    SET @IdComprobanteProveedor = ISNULL(@IdComprobanteProveedor, -1)

    SELECT  Cab.*,
/*
Substring(Cab.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,Cab.NumeroComprobante1)))+
	Convert(varchar,Cab.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Cab.NumeroComprobante2)))+
	Convert(varchar,Cab.NumeroComprobante2),1,20) as [Numero],
*/          Cuentas.Descripcion AS [Cuenta],
            Proveedores.RazonSocial AS [Proveedor],
            ProveedoresEventual.RazonSocial AS [ProveedorEventual]
    FROM    ComprobantesProveedores Cab --LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento=DetReq.IdRequerimiento
--LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Cuentas ON Cab.IdCuenta = Cuentas.IdCuenta
--LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
--LEFT OUTER JOIN Obras ON Cab.IdObra = Obras.IdObra
--LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
--LEFT OUTER JOIN Equipos ON DetReq.IdEquipo = Equipos.IdEquipo
--LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
--LEFT OUTER JOIN ControlesCalidad ON DetReq.IdControlCalidad = ControlesCalidad.IdControlCalidad
--LEFT OUTER JOIN Empleados E1 ON Requerimientos.Aprobo = E1.IdEmpleado
--LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
--LEFT OUTER JOIN Empleados E3 ON Requerimientos.IdComprador = E3.IdEmpleado
            LEFT OUTER JOIN Proveedores ON Cab.IdProveedor = Proveedores.IdProveedor
            LEFT OUTER JOIN Proveedores ProveedoresEventual ON Cab.IdProveedorEventual = ProveedoresEventual.IdProveedor
    WHERE   ( @IdComprobanteProveedor = -1
              OR ( IdComprobanteProveedor = @IdComprobanteProveedor )
            )
    ORDER BY IdComprobanteProveedor DESC

go

/*
exec [wComprobantesProveedores_T]

*/
--/////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wComprobantesProveedores_TX_FondosFijos]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wComprobantesProveedores_TX_FondosFijos]
go



CREATE PROCEDURE [dbo].[wComprobantesProveedores_TX_FondosFijos] @IdObra INT = NULL
AS 
    SET @IdObra = ISNULL(@IdObra, -1)

    SELECT  Cab.*,
/*
Substring(Cab.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,Cab.NumeroComprobante1)))+
	Convert(varchar,Cab.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Cab.NumeroComprobante2)))+
	Convert(varchar,Cab.NumeroComprobante2),1,20) as [Numero],
*/          Cuentas.Descripcion AS [Cuenta],
            Proveedores.RazonSocial AS [Proveedor],
            ProveedoresEventual.RazonSocial AS [ProveedorEventual]
    FROM    ComprobantesProveedores Cab --LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento=DetReq.IdRequerimiento
--LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Cuentas ON Cab.IdCuenta = Cuentas.IdCuenta
--LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
--LEFT OUTER JOIN Obras ON Cab.IdObra = Obras.IdObra
--LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
--LEFT OUTER JOIN Equipos ON DetReq.IdEquipo = Equipos.IdEquipo
--LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
--LEFT OUTER JOIN ControlesCalidad ON DetReq.IdControlCalidad = ControlesCalidad.IdControlCalidad
--LEFT OUTER JOIN Empleados E1 ON Requerimientos.Aprobo = E1.IdEmpleado
--LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
--LEFT OUTER JOIN Empleados E3 ON Requerimientos.IdComprador = E3.IdEmpleado
            LEFT OUTER JOIN Proveedores ON Cab.IdProveedor = Proveedores.IdProveedor
            LEFT OUTER JOIN Proveedores ProveedoresEventual ON Cab.IdProveedorEventual = ProveedoresEventual.IdProveedor
    WHERE   ( Cab.IdProveedor IS NULL
              AND Cab.IdCuenta IS NOT NULL
            )
            AND ( @IdObra = -1
                  OR @IdObra = Cab.IdObra
                )
		-- and Cab.Confirmado is not null and Cab.Confirmado='NO'   -- Ahora lo filtro en la lista que
																	-- devuelve el manager del BO. 
    ORDER BY IdComprobanteProveedor DESC

go

/*
exec [wComprobantesProveedores_TX_FondosFijos]

*/





--/////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wComprobantesProveedores_E]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wComprobantesProveedores_E]
go


CREATE PROCEDURE [dbo].[wComprobantesProveedores_E]
    @IdComprobanteProveedor INT
AS 
    DELETE  ComprobantesProveedores
    WHERE   ( IdComprobanteProveedor = @IdComprobanteProveedor )


go
--/////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetComprobantesProveedores_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetComprobantesProveedores_A]
go



CREATE PROCEDURE [dbo].[wDetComprobantesProveedores_A]
    @IdDetalleComprobanteProveedor INT OUTPUT,
    @IdComprobanteProveedor INT,
    @IdArticulo INT,
    @CodigoArticulo VARCHAR(8),
    @IdCuenta INT,
    @CodigoCuenta VARCHAR(10),
    @PorcentajeIvaAplicado NUMERIC(6, 2),
    @Importe NUMERIC(12, 2),
    @IdCuentaGasto INT,
    @IdCuentaIvaCompras1 INT,
    @IVAComprasPorcentaje1 NUMERIC(6, 2),
    @ImporteIVA1 NUMERIC(18, 2),
    @AplicarIVA1 VARCHAR(2),
    @IdCuentaIvaCompras2 INT,
    @IVAComprasPorcentaje2 NUMERIC(6, 2),
    @ImporteIVA2 NUMERIC(18, 2),
    @AplicarIVA2 VARCHAR(2),
    @IdCuentaIvaCompras3 INT,
    @IVAComprasPorcentaje3 NUMERIC(6, 2),
    @ImporteIVA3 NUMERIC(18, 2),
    @AplicarIVA3 VARCHAR(2),
    @IdCuentaIvaCompras4 INT,
    @IVAComprasPorcentaje4 NUMERIC(6, 2),
    @ImporteIVA4 NUMERIC(18, 2),
    @AplicarIVA4 VARCHAR(2),
    @IdCuentaIvaCompras5 INT,
    @IVAComprasPorcentaje5 NUMERIC(6, 2),
    @ImporteIVA5 NUMERIC(18, 2),
    @AplicarIVA5 VARCHAR(2),
    @IdObra INT,
    @Item INT,
    @IdCuentaIvaCompras6 INT,
    @IVAComprasPorcentaje6 NUMERIC(6, 2),
    @ImporteIVA6 NUMERIC(18, 2),
    @AplicarIVA6 VARCHAR(2),
    @IdCuentaIvaCompras7 INT,
    @IVAComprasPorcentaje7 NUMERIC(6, 2),
    @ImporteIVA7 NUMERIC(18, 2),
    @AplicarIVA7 VARCHAR(2),
    @IdCuentaIvaCompras8 INT,
    @IVAComprasPorcentaje8 NUMERIC(6, 2),
    @ImporteIVA8 NUMERIC(18, 2),
    @AplicarIVA8 VARCHAR(2),
    @IdCuentaIvaCompras9 INT,
    @IVAComprasPorcentaje9 NUMERIC(6, 2),
    @ImporteIVA9 NUMERIC(18, 2),
    @AplicarIVA9 VARCHAR(2),
    @IdCuentaIvaCompras10 INT,
    @IVAComprasPorcentaje10 NUMERIC(6, 2),
    @ImporteIVA10 NUMERIC(18, 2),
    @AplicarIVA10 VARCHAR(2),
    @IVAComprasPorcentajeDirecto NUMERIC(6, 2),
    @IdCuentaBancaria INT,
    @PRESTOConcepto VARCHAR(13),
    @PRESTOObra VARCHAR(13),
    @IdDetalleRecepcion INT,
    @TomarEnCalculoDeImpuestos VARCHAR(2),
    @IdRubroContable INT,
    @IdPedido INT,
    @IdDetallePedido INT,
    @Importacion_FOB NUMERIC(18, 2),
    @Importacion_PosicionAduana VARCHAR(20),
    @Importacion_Despacho VARCHAR(30),
    @Importacion_Guia VARCHAR(20),
    @Importacion_IdPaisOrigen INT,
    @Importacion_FechaEmbarque DATETIME,
    @Importacion_FechaOficializacion DATETIME,
    @IdProvinciaDestino1 INT,
    @PorcentajeProvinciaDestino1 NUMERIC(6, 2),
    @IdProvinciaDestino2 INT,
    @PorcentajeProvinciaDestino2 NUMERIC(6, 2),
    @IdDistribucionObra INT,
    @Cantidad NUMERIC(18, 2),
    @IdDetalleObraDestino INT,
    @IdPresupuestoObraRubro INT,
    @IdPedidoAnticipo INT,
    @PorcentajeAnticipo NUMERIC(6, 2),
    @PorcentajeCertificacion NUMERIC(6, 2),
    @IdPresupuestoObrasNodo INT,
    @IdDetalleComprobanteProveedorOriginal INT
AS 
    IF ISNULL(@IdDetalleComprobanteProveedor, 0) <= 0 
        BEGIN




            IF @IdDetalleRecepcion IS NULL
                AND @IdDetallePedido IS NOT NULL 
                BEGIN
                    DECLARE @Letra VARCHAR(1),
                        @NumeroComprobante1 INT,
                        @NumeroComprobante2 INT
                    SET @Letra = ISNULL(( SELECT TOP 1
                                                    Letra
                                          FROM      ComprobantesProveedores
                                          WHERE     IdComprobanteProveedor = @IdComprobanteProveedor
                                        ), '')
                    SET @NumeroComprobante1 = ISNULL(( SELECT TOP 1
                                                                NumeroComprobante1
                                                       FROM     ComprobantesProveedores
                                                       WHERE    IdComprobanteProveedor = @IdComprobanteProveedor
                                                     ), 0)
                    SET @NumeroComprobante2 = ISNULL(( SELECT TOP 1
                                                                NumeroComprobante2
                                                       FROM     ComprobantesProveedores
                                                       WHERE    IdComprobanteProveedor = @IdComprobanteProveedor
                                                     ), 0)

                    DECLARE @DesactivarDarPorCumplidoPedidoSinRecepcionEnCP VARCHAR(2)
                    SET @DesactivarDarPorCumplidoPedidoSinRecepcionEnCP = ISNULL(( SELECT TOP 1
                                                                                            P2.Valor
                                                                                   FROM     Parametros2 P2
                                                                                   WHERE    P2.Campo = 'DesactivarDarPorCumplidoPedidoSinRecepcionEnCP'
                                                                                 ), 'NO')
                    IF @DesactivarDarPorCumplidoPedidoSinRecepcionEnCP = 'NO' 
                        BEGIN
                            UPDATE  DetallePedidos
                            SET     Cumplido = 'SI',
                                    IdDioPorCumplido = 0,
                                    FechaDadoPorCumplido = GETDATE(),
                                    ObservacionesCumplido = 'Comprobante proveedor '
                                    + @Letra + '-' + SUBSTRING('0000', 1, 4 - LEN(CONVERT(VARCHAR, @NumeroComprobante1)))
                                    + CONVERT(VARCHAR, @NumeroComprobante1)
                                    + '-' + SUBSTRING('00000000', 1,
                                                      8
                                                      - LEN(CONVERT(VARCHAR, @NumeroComprobante2)))
                                    + CONVERT(VARCHAR, @NumeroComprobante2)
                            WHERE   IdDetallePedido = @IdDetallePedido
                                    AND ISNULL(Cumplido, 'NO') <> 'AN'
                                    AND ISNULL(Cumplido, 'NO') <> 'SI' 
				
                            EXEC Pedidos_ActualizarEstadoPorIdPedido @IdPedido
                        END
                END



            IF @IdArticulo IS NOT NULL 
                BEGIN
                    DECLARE @FechaComprobante DATETIME,
                        @FechaUltimoCostoReposicion DATETIME,
                        @CotizacionMoneda NUMERIC(18, 4),
                        @CotizacionDolar NUMERIC(18, 4),
                        @CostoReposicion NUMERIC(18, 2),
                        @CostoReposicionDolar NUMERIC(18, 2),
                        @IdMonedaRecepcion INT,
                        @IdMonedaComprobante INT

                    SET @FechaComprobante = ISNULL(( SELECT TOP 1
                                                            FechaComprobante
                                                     FROM   ComprobantesProveedores
                                                     WHERE  IdComprobanteProveedor = @IdComprobanteProveedor
                                                   ),
                                                   CONVERT(DATETIME, '01/01/2000'))
                    SET @CotizacionMoneda = ISNULL(( SELECT TOP 1
                                                            CotizacionMoneda
                                                     FROM   ComprobantesProveedores
                                                     WHERE  IdComprobanteProveedor = @IdComprobanteProveedor
                                                   ), 1)
                    SET @CotizacionDolar = ISNULL(( SELECT TOP 1
                                                            CotizacionDolar
                                                    FROM    ComprobantesProveedores
                                                    WHERE   IdComprobanteProveedor = @IdComprobanteProveedor
                                                  ), 1)
                    SET @IdMonedaComprobante = ISNULL(( SELECT TOP 1
                                                                IdMoneda
                                                        FROM    ComprobantesProveedores
                                                        WHERE   IdComprobanteProveedor = @IdComprobanteProveedor
                                                      ), 1)
                    SET @IdMonedaRecepcion = ISNULL(( SELECT TOP 1
                                                                IdMoneda
                                                      FROM      DetalleRecepciones
                                                      WHERE     DetalleRecepciones.IdDetalleRecepcion = @IdDetalleRecepcion
                                                    ), 1)
                    SET @CostoReposicion = 0
                    SET @CostoReposicionDolar = 0

                    IF ISNULL(@Cantidad, 0) <> 0 
                        SET @CostoReposicion = ROUND(@Importe / @Cantidad
                                                     * @CotizacionMoneda, 2)
			

                    IF ISNULL(@Cantidad, 0) <> 0
                        AND @CotizacionDolar <> 0 
                        SET @CostoReposicionDolar = ROUND(@Importe / @Cantidad
                                                          * @CotizacionMoneda
                                                          / @CotizacionDolar,
                                                          2)
			

                    SET @FechaUltimoCostoReposicion = ISNULL(( SELECT TOP 1
                                                                        Articulos.FechaUltimoCostoReposicion
                                                               FROM     Articulos
                                                               WHERE    Articulos.IdArticulo = @IdArticulo
                                                             ),
                                                             CONVERT(DATETIME, '01/01/2000'))


                    IF @FechaComprobante >= @FechaUltimoCostoReposicion
                        AND @CostoReposicion <> 0
                        AND @CostoReposicionDolar <> 0 
                        UPDATE  Articulos
                        SET     CostoReposicion = @CostoReposicion,
                                CostoReposicionDolar = @CostoReposicionDolar,
                                FechaUltimoCostoReposicion = @FechaComprobante
                        WHERE   Articulos.IdArticulo = @IdArticulo


                    IF ISNULL(@IdDetalleRecepcion, 0) <> 0
                        AND @CotizacionMoneda <> 0
                        AND @IdMonedaComprobante = @IdMonedaRecepcion 
                        UPDATE  DetalleRecepciones
                        SET     CostoUnitario = @CostoReposicion
                                / @CotizacionMoneda
                        WHERE   DetalleRecepciones.IdDetalleRecepcion = @IdDetalleRecepcion
		
                END





            INSERT  INTO [DetalleComprobantesProveedores]
                    (
                      IdComprobanteProveedor,
                      IdArticulo,
                      CodigoArticulo,
                      IdCuenta,
                      CodigoCuenta,
                      PorcentajeIvaAplicado,
                      Importe,
                      IdCuentaGasto,
                      IdCuentaIvaCompras1,
                      IVAComprasPorcentaje1,
                      ImporteIVA1,
                      AplicarIVA1,
                      IdCuentaIvaCompras2,
                      IVAComprasPorcentaje2,
                      ImporteIVA2,
                      AplicarIVA2,
                      IdCuentaIvaCompras3,
                      IVAComprasPorcentaje3,
                      ImporteIVA3,
                      AplicarIVA3,
                      IdCuentaIvaCompras4,
                      IVAComprasPorcentaje4,
                      ImporteIVA4,
                      AplicarIVA4,
                      IdCuentaIvaCompras5,
                      IVAComprasPorcentaje5,
                      ImporteIVA5,
                      AplicarIVA5,
                      IdObra,
                      Item,
                      IdCuentaIvaCompras6,
                      IVAComprasPorcentaje6,
                      ImporteIVA6,
                      AplicarIVA6,
                      IdCuentaIvaCompras7,
                      IVAComprasPorcentaje7,
                      ImporteIVA7,
                      AplicarIVA7,
                      IdCuentaIvaCompras8,
                      IVAComprasPorcentaje8,
                      ImporteIVA8,
                      AplicarIVA8,
                      IdCuentaIvaCompras9,
                      IVAComprasPorcentaje9,
                      ImporteIVA9,
                      AplicarIVA9,
                      IdCuentaIvaCompras10,
                      IVAComprasPorcentaje10,
                      ImporteIVA10,
                      AplicarIVA10,
                      IVAComprasPorcentajeDirecto,
                      IdCuentaBancaria,
                      PRESTOConcepto,
                      PRESTOObra,
                      IdDetalleRecepcion,
                      TomarEnCalculoDeImpuestos,
                      IdRubroContable,
                      IdPedido,
                      IdDetallePedido,
                      Importacion_FOB,
                      Importacion_PosicionAduana,
                      Importacion_Despacho,
                      Importacion_Guia,
                      Importacion_IdPaisOrigen,
                      Importacion_FechaEmbarque,
                      Importacion_FechaOficializacion,
                      IdProvinciaDestino1,
                      PorcentajeProvinciaDestino1,
                      IdProvinciaDestino2,
                      PorcentajeProvinciaDestino2,
                      IdDistribucionObra,
                      Cantidad,
                      IdDetalleObraDestino,
                      IdPresupuestoObraRubro,
                      IdPedidoAnticipo,
                      PorcentajeAnticipo,
                      PorcentajeCertificacion,
                      IdPresupuestoObrasNodo,
                      IdDetalleComprobanteProveedorOriginal
		        )
            VALUES  (
                      @IdComprobanteProveedor,
                      @IdArticulo,
                      @CodigoArticulo,
                      @IdCuenta,
                      @CodigoCuenta,
                      @PorcentajeIvaAplicado,
                      @Importe,
                      @IdCuentaGasto,
                      @IdCuentaIvaCompras1,
                      @IVAComprasPorcentaje1,
                      @ImporteIVA1,
                      @AplicarIVA1,
                      @IdCuentaIvaCompras2,
                      @IVAComprasPorcentaje2,
                      @ImporteIVA2,
                      @AplicarIVA2,
                      @IdCuentaIvaCompras3,
                      @IVAComprasPorcentaje3,
                      @ImporteIVA3,
                      @AplicarIVA3,
                      @IdCuentaIvaCompras4,
                      @IVAComprasPorcentaje4,
                      @ImporteIVA4,
                      @AplicarIVA4,
                      @IdCuentaIvaCompras5,
                      @IVAComprasPorcentaje5,
                      @ImporteIVA5,
                      @AplicarIVA5,
                      @IdObra,
                      @Item,
                      @IdCuentaIvaCompras6,
                      @IVAComprasPorcentaje6,
                      @ImporteIVA6,
                      @AplicarIVA6,
                      @IdCuentaIvaCompras7,
                      @IVAComprasPorcentaje7,
                      @ImporteIVA7,
                      @AplicarIVA7,
                      @IdCuentaIvaCompras8,
                      @IVAComprasPorcentaje8,
                      @ImporteIVA8,
                      @AplicarIVA8,
                      @IdCuentaIvaCompras9,
                      @IVAComprasPorcentaje9,
                      @ImporteIVA9,
                      @AplicarIVA9,
                      @IdCuentaIvaCompras10,
                      @IVAComprasPorcentaje10,
                      @ImporteIVA10,
                      @AplicarIVA10,
                      @IVAComprasPorcentajeDirecto,
                      @IdCuentaBancaria,
                      @PRESTOConcepto,
                      @PRESTOObra,
                      @IdDetalleRecepcion,
                      @TomarEnCalculoDeImpuestos,
                      @IdRubroContable,
                      @IdPedido,
                      @IdDetallePedido,
                      @Importacion_FOB,
                      @Importacion_PosicionAduana,
                      @Importacion_Despacho,
                      @Importacion_Guia,
                      @Importacion_IdPaisOrigen,
                      @Importacion_FechaEmbarque,
                      @Importacion_FechaOficializacion,
                      @IdProvinciaDestino1,
                      @PorcentajeProvinciaDestino1,
                      @IdProvinciaDestino2,
                      @PorcentajeProvinciaDestino2,
                      @IdDistribucionObra,
                      @Cantidad,
                      @IdDetalleObraDestino,
                      @IdPresupuestoObraRubro,
                      @IdPedidoAnticipo,
                      @PorcentajeAnticipo,
                      @PorcentajeCertificacion,
                      @IdPresupuestoObrasNodo,
                      @IdDetalleComprobanteProveedorOriginal
		        )


            SELECT  @IdDetalleComprobanteProveedor = @@identity

        END	
    ELSE 
        BEGIN

            IF @IdDetalleRecepcion IS NULL
                AND @IdDetallePedido IS NOT NULL 
                BEGIN
                    SET @Letra = ISNULL(( SELECT TOP 1
                                                    Letra
                                          FROM      ComprobantesProveedores
                                          WHERE     IdComprobanteProveedor = @IdComprobanteProveedor
                                        ), '')
                    SET @NumeroComprobante1 = ISNULL(( SELECT TOP 1
                                                                NumeroComprobante1
                                                       FROM     ComprobantesProveedores
                                                       WHERE    IdComprobanteProveedor = @IdComprobanteProveedor
                                                     ), 0)
                    SET @NumeroComprobante2 = ISNULL(( SELECT TOP 1
                                                                NumeroComprobante2
                                                       FROM     ComprobantesProveedores
                                                       WHERE    IdComprobanteProveedor = @IdComprobanteProveedor
                                                     ), 0)

                    SET @DesactivarDarPorCumplidoPedidoSinRecepcionEnCP = ISNULL(( SELECT TOP 1
                                                                                            P2.Valor
                                                                                   FROM     Parametros2 P2
                                                                                   WHERE    P2.Campo = 'DesactivarDarPorCumplidoPedidoSinRecepcionEnCP'
                                                                                 ), 'NO')
                    IF @DesactivarDarPorCumplidoPedidoSinRecepcionEnCP = 'NO' 
                        BEGIN
                            UPDATE  DetallePedidos
                            SET     Cumplido = 'SI',
                                    IdDioPorCumplido = 0,
                                    FechaDadoPorCumplido = GETDATE(),
                                    ObservacionesCumplido = 'Comprobante proveedor '
                                    + @Letra + '-' + SUBSTRING('0000', 1, 4 - LEN(CONVERT(VARCHAR, @NumeroComprobante1)))
                                    + CONVERT(VARCHAR, @NumeroComprobante1)
                                    + '-' + SUBSTRING('00000000', 1,
                                                      8
                                                      - LEN(CONVERT(VARCHAR, @NumeroComprobante2)))
                                    + CONVERT(VARCHAR, @NumeroComprobante2)
                            WHERE   IdDetallePedido = @IdDetallePedido
                                    AND ISNULL(Cumplido, 'NO') <> 'AN'
                                    AND ISNULL(Cumplido, 'NO') <> 'SI' 
				
                            EXEC Pedidos_ActualizarEstadoPorIdPedido @IdPedido
                        END
                END

            IF @IdArticulo IS NOT NULL 
                BEGIN
                    SET @FechaComprobante = ISNULL(( SELECT TOP 1
                                                            FechaComprobante
                                                     FROM   ComprobantesProveedores
                                                     WHERE  IdComprobanteProveedor = @IdComprobanteProveedor
                                                   ),
                                                   CONVERT(DATETIME, '01/01/2000'))
                    SET @CotizacionMoneda = ISNULL(( SELECT TOP 1
                                                            CotizacionMoneda
                                                     FROM   ComprobantesProveedores
                                                     WHERE  IdComprobanteProveedor = @IdComprobanteProveedor
                                                   ), 1)
                    SET @CotizacionDolar = ISNULL(( SELECT TOP 1
                                                            CotizacionDolar
                                                    FROM    ComprobantesProveedores
                                                    WHERE   IdComprobanteProveedor = @IdComprobanteProveedor
                                                  ), 1)
                    SET @IdMonedaComprobante = ISNULL(( SELECT TOP 1
                                                                IdMoneda
                                                        FROM    ComprobantesProveedores
                                                        WHERE   IdComprobanteProveedor = @IdComprobanteProveedor
                                                      ), 1)
                    SET @IdMonedaRecepcion = ISNULL(( SELECT TOP 1
                                                                IdMoneda
                                                      FROM      DetalleRecepciones
                                                      WHERE     DetalleRecepciones.IdDetalleRecepcion = @IdDetalleRecepcion
                                                    ), 1)
                    SET @CostoReposicion = 0
                    SET @CostoReposicionDolar = 0
                    IF ISNULL(@Cantidad, 0) <> 0 
                        SET @CostoReposicion = ROUND(@Importe / @Cantidad
                                                     * @CotizacionMoneda, 2)
                    IF ISNULL(@Cantidad, 0) <> 0
                        AND @CotizacionDolar <> 0 
                        SET @CostoReposicionDolar = ROUND(@Importe / @Cantidad
                                                          * @CotizacionMoneda
                                                          / @CotizacionDolar,
                                                          2)
                    SET @FechaUltimoCostoReposicion = ISNULL(( SELECT TOP 1
                                                                        Articulos.FechaUltimoCostoReposicion
                                                               FROM     Articulos
                                                               WHERE    Articulos.IdArticulo = @IdArticulo
                                                             ),
                                                             CONVERT(DATETIME, '01/01/2000'))
                    IF @FechaComprobante >= @FechaUltimoCostoReposicion
                        AND @CostoReposicion <> 0
                        AND @CostoReposicionDolar <> 0 
                        UPDATE  Articulos
                        SET     CostoReposicion = @CostoReposicion,
                                CostoReposicionDolar = @CostoReposicionDolar,
                                FechaUltimoCostoReposicion = @FechaComprobante
                        WHERE   Articulos.IdArticulo = @IdArticulo

                    IF ISNULL(@IdDetalleRecepcion, 0) <> 0
                        AND @CotizacionMoneda <> 0
                        AND @IdMonedaComprobante = @IdMonedaRecepcion 
                        UPDATE  DetalleRecepciones
                        SET     CostoUnitario = @CostoReposicion
                                / @CotizacionMoneda
                        WHERE   DetalleRecepciones.IdDetalleRecepcion = @IdDetalleRecepcion
                END

            UPDATE  DetalleComprobantesProveedores
            SET     IdComprobanteProveedor = @IdComprobanteProveedor,
                    IdArticulo = @IdArticulo,
                    CodigoArticulo = @CodigoArticulo,
                    IdCuenta = @IdCuenta,
                    CodigoCuenta = @CodigoCuenta,
                    PorcentajeIvaAplicado = @PorcentajeIvaAplicado,
                    Importe = @Importe,
                    IdCuentaGasto = @IdCuentaGasto,
                    IdCuentaIvaCompras1 = @IdCuentaIvaCompras1,
                    IVAComprasPorcentaje1 = @IVAComprasPorcentaje1,
                    ImporteIVA1 = @ImporteIVA1,
                    AplicarIVA1 = @AplicarIVA1,
                    IdCuentaIvaCompras2 = @IdCuentaIvaCompras2,
                    IVAComprasPorcentaje2 = @IVAComprasPorcentaje2,
                    ImporteIVA2 = @ImporteIVA2,
                    AplicarIVA2 = @AplicarIVA2,
                    IdCuentaIvaCompras3 = @IdCuentaIvaCompras3,
                    IVAComprasPorcentaje3 = @IVAComprasPorcentaje3,
                    ImporteIVA3 = @ImporteIVA3,
                    AplicarIVA3 = @AplicarIVA3,
                    IdCuentaIvaCompras4 = @IdCuentaIvaCompras4,
                    IVAComprasPorcentaje4 = @IVAComprasPorcentaje4,
                    ImporteIVA4 = @ImporteIVA4,
                    AplicarIVA4 = @AplicarIVA4,
                    IdCuentaIvaCompras5 = @IdCuentaIvaCompras5,
                    IVAComprasPorcentaje5 = @IVAComprasPorcentaje5,
                    ImporteIVA5 = @ImporteIVA5,
                    AplicarIVA5 = @AplicarIVA5,
                    IdObra = @IdObra,
                    Item = @Item,
                    IdCuentaIvaCompras6 = @IdCuentaIvaCompras6,
                    IVAComprasPorcentaje6 = @IVAComprasPorcentaje6,
                    ImporteIVA6 = @ImporteIVA6,
                    AplicarIVA6 = @AplicarIVA6,
                    IdCuentaIvaCompras7 = @IdCuentaIvaCompras7,
                    IVAComprasPorcentaje7 = @IVAComprasPorcentaje7,
                    ImporteIVA7 = @ImporteIVA7,
                    AplicarIVA7 = @AplicarIVA7,
                    IdCuentaIvaCompras8 = @IdCuentaIvaCompras8,
                    IVAComprasPorcentaje8 = @IVAComprasPorcentaje8,
                    ImporteIVA8 = @ImporteIVA8,
                    AplicarIVA8 = @AplicarIVA8,
                    IdCuentaIvaCompras9 = @IdCuentaIvaCompras9,
                    IVAComprasPorcentaje9 = @IVAComprasPorcentaje9,
                    ImporteIVA9 = @ImporteIVA9,
                    AplicarIVA9 = @AplicarIVA9,
                    IdCuentaIvaCompras10 = @IdCuentaIvaCompras10,
                    IVAComprasPorcentaje10 = @IVAComprasPorcentaje10,
                    ImporteIVA10 = @ImporteIVA10,
                    AplicarIVA10 = @AplicarIVA10,
                    IVAComprasPorcentajeDirecto = @IVAComprasPorcentajeDirecto,
                    IdCuentaBancaria = @IdCuentaBancaria,
                    PRESTOConcepto = @PRESTOConcepto,
                    PRESTOObra = @PRESTOObra,
                    IdDetalleRecepcion = @IdDetalleRecepcion,
                    TomarEnCalculoDeImpuestos = @TomarEnCalculoDeImpuestos,
                    IdRubroContable = @IdRubroContable,
                    IdPedido = @IdPedido,
                    IdDetallePedido = @IdDetallePedido,
                    Importacion_FOB = @Importacion_FOB,
                    Importacion_PosicionAduana = @Importacion_PosicionAduana,
                    Importacion_Despacho = @Importacion_Despacho,
                    Importacion_Guia = @Importacion_Guia,
                    Importacion_IdPaisOrigen = @Importacion_IdPaisOrigen,
                    Importacion_FechaEmbarque = @Importacion_FechaEmbarque,
                    Importacion_FechaOficializacion = @Importacion_FechaOficializacion,
                    IdProvinciaDestino1 = @IdProvinciaDestino1,
                    PorcentajeProvinciaDestino1 = @PorcentajeProvinciaDestino1,
                    IdProvinciaDestino2 = @IdProvinciaDestino2,
                    PorcentajeProvinciaDestino2 = @PorcentajeProvinciaDestino2,
                    IdDistribucionObra = @IdDistribucionObra,
                    IdDetalleObraDestino = @IdDetalleObraDestino,
                    IdPresupuestoObraRubro = @IdPresupuestoObraRubro,
                    IdPedidoAnticipo = @IdPedidoAnticipo,
                    PorcentajeAnticipo = @PorcentajeAnticipo,
                    PorcentajeCertificacion = @PorcentajeCertificacion,
                    IdPresupuestoObrasNodo = @IdPresupuestoObrasNodo,
                    IdDetalleComprobanteProveedorOriginal = @IdDetalleComprobanteProveedorOriginal
            WHERE   ( IdDetalleComprobanteProveedor = @IdDetalleComprobanteProveedor )
        END

    RETURN ( @IdDetalleComprobanteProveedor )


go
--/////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetComprobantesProveedores_T]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetComprobantesProveedores_T]
go



CREATE PROCEDURE [dbo].[wDetComprobantesProveedores_T]
    @IdDetalleComprobanteProveedor INT = NULL
AS 
    SELECT  *
    FROM    DetalleComprobantesProveedores
    WHERE   ( IdDetalleComprobanteProveedor = @IdDetalleComprobanteProveedor )


go
--/////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetComprobantesProveedores_TT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetComprobantesProveedores_TT]
go


CREATE PROCEDURE [dbo].[wDetComprobantesProveedores_TT]
    @IdComprobanteProveedor INT
AS 
    SELECT  Det.*,
            CuentasGastos.Descripcion AS [CuentaGastoDescripcion]
    FROM    DetalleComprobantesProveedores Det --LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento=DetReq.IdRequerimiento
            LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN CuentasGastos ON ( Det.IdCuentaGasto = CuentasGastos.IdCuentaGasto )
--LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
--LEFT OUTER JOIN Obras ON Cab.IdObra = Obras.IdObra
--LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
--LEFT OUTER JOIN Equipos ON DetReq.IdEquipo = Equipos.IdEquipo
--LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
--LEFT OUTER JOIN ControlesCalidad ON DetReq.IdControlCalidad = ControlesCalidad.IdControlCalidad
--LEFT OUTER JOIN Empleados E1 ON Requerimientos.Aprobo = E1.IdEmpleado
--LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
--LEFT OUTER JOIN Empleados E3 ON Requerimientos.IdComprador = E3.IdEmpleado
--LEFT OUTER JOIN Proveedores ON DetReq.IdProveedor = Proveedores.IdProveedor
    WHERE   IdComprobanteProveedor = @IdComprobanteProveedor 


go

/*

exec dbo.wComprobantesProveedores_T 81
exec dbo.wComprobantesProveedores_TX_FondosFijos
exec dbo.wDetComprobantesProveedores_TT 6770

select * from obras
exec dbo.wCuentas_TX_CuentasGastoPorObraParaCombo 1
exec dbo.wCuentas_TX_CuentasGastoPorObraParaCombo 2
exec dbo.wCuentas_TX_CuentasGastoPorObraParaCombo 3
exec dbo.wCuentas_TX_CuentasGastoPorObraParaCombo 4
exec dbo.wCuentas_TX_CuentasGastoPorObraParaCombo 5
exec dbo.wCuentas_TX_CuentasGastoPorObraParaCombo 6

exec dbo.CuentasGastos_TL

exec dbo.CuentasGastos_TX_PorCodigo
exec dbo.CuentasGastos_TX_PorCodigo2 

select * from cuentasGastos


select idcuentagasto,* from detallecomprobantesproveedores
where importe=20.66
where not idcuentagasto is null

select * from cuentasgastos

*/

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////




--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////




IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetComprobantesProveedores_E]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetComprobantesProveedores_E]
go


CREATE PROCEDURE [dbo].[wDetComprobantesProveedores_E]
    @IdDetalleComprobanteProveedores INT
AS 
    DELETE  DetalleComprobantesProveedores
    WHERE   ( IdDetalleComprobanteProveedor = @IdDetalleComprobanteProveedores )


go
--/////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetComprobantesProveedoresPrv_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetComprobantesProveedoresPrv_A]
go



CREATE PROCEDURE [dbo].[wDetComprobantesProveedoresPrv_A]
    @IdDetalleComprobanteProveedorProvincias INT OUTPUT,
    @IdComprobanteProveedor INT,
    @IdProvinciaDestino INT,
    @Porcentaje NUMERIC(6, 2)
AS 
    IF ISNULL(@IdDetalleComprobanteProveedorProvincias, 0) <= 0 
        BEGIN 

            INSERT  INTO [DetalleComprobantesProveedoresProvincias]
                    (
                      IdComprobanteProveedor,
                      IdProvinciaDestino,
                      Porcentaje
		        )
            VALUES  (
                      @IdComprobanteProveedor,
                      @IdProvinciaDestino,
                      @Porcentaje
		        )
        END
    ELSE 
        BEGIN
            UPDATE  [DetalleComprobantesProveedoresProvincias]
            SET     IdComprobanteProveedor = @IdComprobanteProveedor,
                    IdProvinciaDestino = @IdProvinciaDestino,
                    Porcentaje = @Porcentaje
            WHERE   ( IdDetalleComprobanteProveedorProvincias = @IdDetalleComprobanteProveedorProvincias )
        END

    RETURN ( @IdDetalleComprobanteProveedorProvincias )


go
--/////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetComprobantesProveedoresPrv_E]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetComprobantesProveedoresPrv_E]
go


CREATE PROCEDURE [dbo].[wDetComprobantesProveedoresPrv_E]
    @IdDetalleComprobanteProveedorProvincias INT
AS 
    DELETE  [DetalleComprobantesProveedoresProvincias]
    WHERE   ( IdDetalleComprobanteProveedorProvincias = @IdDetalleComprobanteProveedorProvincias )


go
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetComprobantesProveedoresPrv_T]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetComprobantesProveedoresPrv_T]
go



CREATE PROCEDURE [dbo].[wDetComprobantesProveedoresPrv_T]
    @IdDetalleComprobanteProveedorProvincias INT = NULL
AS 
    SELECT  *
    FROM    [DetalleComprobantesProveedoresProvincias]
    WHERE   ( IdDetalleComprobanteProveedorProvincias = @IdDetalleComprobanteProveedorProvincias )


go
--/////////////////////////////////////////////////////////////////////



--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--PEDIDOS
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wPedidos_T_ByEmployee]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wPedidos_T_ByEmployee
go

CREATE PROCEDURE wPedidos_T_ByEmployee @IdSolicito INT
AS 
    SET NOCOUNT ON

    DECLARE @ActivarSolicitudMateriales VARCHAR(2),
        @FechaInicial DATETIME
    SET @ActivarSolicitudMateriales = ISNULL(( SELECT TOP 1
                                                        P.ActivarSolicitudMateriales
                                               FROM     Parametros P
                                               WHERE    P.IdParametro = 1
                                             ), 'NO')
    SET @FechaInicial = CONVERT(DATETIME, '01/01/2008')

/* PRESUPUESTOS */
    CREATE TABLE #Auxiliar0
        (
          IdRequerimiento INTEGER,
          Presupuestos VARCHAR(100)
        )

    CREATE TABLE #Auxiliar1
        (
          IdRequerimiento INTEGER,
          Presupuesto VARCHAR(13)
        )
    INSERT  INTO #Auxiliar1
            SELECT  DetReq.IdRequerimiento,
                    CONVERT(VARCHAR, Presupuestos.Numero)
                    + CASE WHEN Presupuestos.Subnumero IS NOT NULL
                           THEN '/' + CONVERT(VARCHAR, Presupuestos.Subnumero)
                           ELSE ''
                      END
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
                    LEFT OUTER JOIN DetallePresupuestos ON DetReq.IdDetalleRequerimiento = DetallePresupuestos.IdDetalleRequerimiento
                    LEFT OUTER JOIN Presupuestos ON DetallePresupuestos.IdPresupuesto = Presupuestos.IdPresupuesto
            WHERE   Requerimientos.IdSolicito = @IdSolicito
                    AND Requerimientos.FechaRequerimiento >= @FechaInicial

    CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 ( IdRequerimiento, Presupuesto )
    ON  [PRIMARY]

    INSERT  INTO #Auxiliar0
            SELECT  IdRequerimiento,
                    ''
            FROM    #Auxiliar1
            GROUP BY IdRequerimiento

/*  CURSOR  */
    DECLARE @IdRequerimiento1 INT,
        @Presupuesto VARCHAR(13),
        @P VARCHAR(100),
        @Corte INT
    SET @Corte = 0
    SET @P = ''
    DECLARE Cur CURSOR LOCAL FORWARD_ONLY
        FOR SELECT  IdRequerimiento,
                    Presupuesto
            FROM    #Auxiliar1
            ORDER BY IdRequerimiento
    OPEN Cur
    FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Presupuesto
    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @Corte <> @IdRequerimiento1 
                BEGIN
                    IF @Corte <> 0 
                        BEGIN
                            UPDATE  #Auxiliar0
                            SET     Presupuestos = SUBSTRING(@P, 1, 100)
                            WHERE   #Auxiliar0.IdRequerimiento = @Corte
                        END
                    SET @P = ''
                    SET @Corte = @IdRequerimiento1
                END
            IF NOT @Presupuesto IS NULL 
                IF PATINDEX('%' + @Presupuesto + ' ' + '%', @P) = 0 
                    SET @P = @P + @Presupuesto + ' '
            FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Presupuesto
        END
    IF @Corte <> 0 
        BEGIN
            UPDATE  #Auxiliar0
            SET     Presupuestos = SUBSTRING(@P, 1, 100)
            WHERE   #Auxiliar0.IdRequerimiento = @Corte
        END
    CLOSE Cur
    DEALLOCATE Cur


/* COMPARATIVAS */
    CREATE TABLE #Auxiliar2
        (
          IdRequerimiento INTEGER,
          Comparativas VARCHAR(100)
        )

    CREATE TABLE #Auxiliar3
        (
          IdRequerimiento INTEGER,
          Comparativa INTEGER
        )
    INSERT  INTO #Auxiliar3
            SELECT  DetReq.IdRequerimiento,
                    Comparativas.Numero
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
                    LEFT OUTER JOIN DetallePresupuestos ON DetReq.IdDetalleRequerimiento = DetallePresupuestos.IdDetalleRequerimiento
                    LEFT OUTER JOIN DetalleComparativas ON DetallePresupuestos.IdDetallePresupuesto = DetalleComparativas.IdDetallePresupuesto
                    LEFT OUTER JOIN Comparativas ON DetalleComparativas.IdComparativa = Comparativas.IdComparativa
            WHERE   Requerimientos.IdSolicito = @IdSolicito
                    AND Requerimientos.FechaRequerimiento >= @FechaInicial

    CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 ( IdRequerimiento, Comparativa )
    ON  [PRIMARY]

    INSERT  INTO #Auxiliar2
            SELECT  IdRequerimiento,
                    ''
            FROM    #Auxiliar3
            GROUP BY IdRequerimiento

/*  CURSOR  */
    DECLARE @Comparativa INT,
        @C VARCHAR(100)
    SET @Corte = 0
    SET @C = ''
    DECLARE Cur CURSOR LOCAL FORWARD_ONLY
        FOR SELECT  IdRequerimiento,
                    Comparativa
            FROM    #Auxiliar3
            ORDER BY IdRequerimiento
    OPEN Cur
    FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Comparativa
    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @Corte <> @IdRequerimiento1 
                BEGIN
                    IF @Corte <> 0 
                        BEGIN
                            UPDATE  #Auxiliar2
                            SET     Comparativas = SUBSTRING(@C, 1, 100)
                            WHERE   #Auxiliar2.IdRequerimiento = @Corte
                        END
                    SET @C = ''
                    SET @Corte = @IdRequerimiento1
                END
            IF NOT @Comparativa IS NULL 
                IF PATINDEX('%' + CONVERT(VARCHAR, @Comparativa) + ' ' + '%',
                            @C) = 0 
                    SET @C = @C + CONVERT(VARCHAR, @Comparativa) + ' '
            FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Comparativa
        END
    IF @Corte <> 0 
        BEGIN
            UPDATE  #Auxiliar2
            SET     Comparativas = SUBSTRING(@C, 1, 100)
            WHERE   #Auxiliar2.IdRequerimiento = @Corte
        END
    CLOSE Cur
    DEALLOCATE Cur


/* PEDIDOS */
    CREATE TABLE #Auxiliar4
        (
          IdRequerimiento INTEGER,
          Pedidos VARCHAR(100)
        )

    CREATE TABLE #Auxiliar5
        (
          IdRequerimiento INTEGER,
          Pedido VARCHAR(13)
        )
    INSERT  INTO #Auxiliar5
            SELECT  DetReq.IdRequerimiento,
                    CONVERT(VARCHAR, Pedidos.NumeroPedido)
                    + CASE WHEN Pedidos.Subnumero IS NOT NULL
                           THEN '/' + CONVERT(VARCHAR, Pedidos.Subnumero)
                           ELSE ''
                      END
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
                    LEFT OUTER JOIN DetallePedidos ON DetReq.IdDetalleRequerimiento = DetallePedidos.IdDetalleRequerimiento
                    LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
            WHERE   Requerimientos.IdSolicito = @IdSolicito
                    AND Requerimientos.FechaRequerimiento >= @FechaInicial

    CREATE NONCLUSTERED INDEX IX__Auxiliar5 ON #Auxiliar5 ( IdRequerimiento, Pedido )
    ON  [PRIMARY]

    INSERT  INTO #Auxiliar4
            SELECT  IdRequerimiento,
                    ''
            FROM    #Auxiliar5
            GROUP BY IdRequerimiento

/*  CURSOR  */
    DECLARE @Pedido VARCHAR(13)
    SET @Corte = 0
    SET @P = ''
    DECLARE Cur CURSOR LOCAL FORWARD_ONLY
        FOR SELECT  IdRequerimiento,
                    Pedido
            FROM    #Auxiliar5
            ORDER BY IdRequerimiento
    OPEN Cur
    FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Pedido
    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @Corte <> @IdRequerimiento1 
                BEGIN
                    IF @Corte <> 0 
                        BEGIN
                            UPDATE  #Auxiliar4
                            SET     Pedidos = SUBSTRING(@P, 1, 100)
                            WHERE   #Auxiliar4.IdRequerimiento = @Corte
                        END
                    SET @P = ''
                    SET @Corte = @IdRequerimiento1
                END
            IF NOT @Pedido IS NULL 
                IF PATINDEX('%' + @Pedido + ' ' + '%', @P) = 0 
                    SET @P = @P + @Pedido + ' '
            FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Pedido
        END
    IF @Corte <> 0 
        BEGIN
            UPDATE  #Auxiliar4
            SET     Pedidos = SUBSTRING(@P, 1, 100)
            WHERE   #Auxiliar4.IdRequerimiento = @Corte
        END
    CLOSE Cur
    DEALLOCATE Cur


/* RECEPCION DE MATERIALES */
    CREATE TABLE #Auxiliar6
        (
          IdRequerimiento INTEGER,
          Recepciones VARCHAR(100)
        )

    CREATE TABLE #Auxiliar7
        (
          IdRequerimiento INTEGER,
          Recepcion VARCHAR(20)
        )
    INSERT  INTO #Auxiliar7
            SELECT  DetReq.IdRequerimiento,
                    CASE WHEN Recepciones.SubNumero IS NOT NULL
                         THEN SUBSTRING(SUBSTRING('0000', 1,
                                                  4
                                                  - LEN(CONVERT(VARCHAR, Recepciones.NumeroRecepcion1)))
                                        + CONVERT(VARCHAR, Recepciones.NumeroRecepcion1)
                                        + '-' + SUBSTRING('00000000', 1,
                                                          8
                                                          - LEN(CONVERT(VARCHAR, Recepciones.NumeroRecepcion2)))
                                        + CONVERT(VARCHAR, Recepciones.NumeroRecepcion2)
                                        + '/'
                                        + CONVERT(VARCHAR, Recepciones.SubNumero),
                                        1, 20)
                         ELSE SUBSTRING(SUBSTRING('0000', 1,
                                                  4
                                                  - LEN(CONVERT(VARCHAR, Recepciones.NumeroRecepcion1)))
                                        + CONVERT(VARCHAR, Recepciones.NumeroRecepcion1)
                                        + '-' + SUBSTRING('00000000', 1,
                                                          8
                                                          - LEN(CONVERT(VARCHAR, Recepciones.NumeroRecepcion2)))
                                        + CONVERT(VARCHAR, Recepciones.NumeroRecepcion2),
                                        1, 20)
                    END
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
                    LEFT OUTER JOIN DetalleRecepciones ON DetReq.IdDetalleRequerimiento = DetalleRecepciones.IdDetalleRequerimiento
                    LEFT OUTER JOIN Recepciones ON DetalleRecepciones.IdRecepcion = Recepciones.IdRecepcion
            WHERE   Requerimientos.IdSolicito = @IdSolicito
                    AND Requerimientos.FechaRequerimiento >= @FechaInicial

    CREATE NONCLUSTERED INDEX IX__Auxiliar7 ON #Auxiliar7 ( IdRequerimiento, Recepcion )
    ON  [PRIMARY]

    INSERT  INTO #Auxiliar6
            SELECT  IdRequerimiento,
                    ''
            FROM    #Auxiliar7
            GROUP BY IdRequerimiento

/*  CURSOR  */
    DECLARE @Recepcion VARCHAR(20)
    SET @Corte = 0
    SET @P = ''
    DECLARE Cur CURSOR LOCAL FORWARD_ONLY
        FOR SELECT  IdRequerimiento,
                    Recepcion
            FROM    #Auxiliar7
            ORDER BY IdRequerimiento
    OPEN Cur
    FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Recepcion
    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @Corte <> @IdRequerimiento1 
                BEGIN
                    IF @Corte <> 0 
                        BEGIN
                            UPDATE  #Auxiliar6
                            SET     Recepciones = SUBSTRING(@P, 1, 100)
                            WHERE   IdRequerimiento = @Corte
                        END
                    SET @P = ''
                    SET @Corte = @IdRequerimiento1
                END
            IF NOT @Recepcion IS NULL 
                IF PATINDEX('%' + @Recepcion + ' ' + '%', @P) = 0 
                    SET @P = @P + @Recepcion + ' '
            FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Recepcion
        END
    IF @Corte <> 0 
        BEGIN
            UPDATE  #Auxiliar6
            SET     Recepciones = SUBSTRING(@P, 1, 100)
            WHERE   IdRequerimiento = @Corte
        END
    CLOSE Cur
    DEALLOCATE Cur


/* SALIDAS DE MATERIALES */
    CREATE TABLE #Auxiliar8
        (
          IdRequerimiento INTEGER,
          Salidas VARCHAR(100)
        )

    CREATE TABLE #Auxiliar9
        (
          IdRequerimiento INTEGER,
          Salida VARCHAR(13)
        )
    INSERT  INTO #Auxiliar9
            SELECT  DetReq.IdRequerimiento,
                    SUBSTRING(SUBSTRING('0000', 1,
                                        4
                                        - LEN(CONVERT(VARCHAR, ISNULL(SalidasMateriales.NumeroSalidaMateriales2, 0))))
                              + CONVERT(VARCHAR, ISNULL(SalidasMateriales.NumeroSalidaMateriales2,
                                                        0)) + '-'
                              + SUBSTRING('00000000', 1,
                                          8
                                          - LEN(CONVERT(VARCHAR, SalidasMateriales.NumeroSalidaMateriales)))
                              + CONVERT(VARCHAR, SalidasMateriales.NumeroSalidaMateriales),
                              1, 13)
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
                    LEFT OUTER JOIN DetalleValesSalida ON DetReq.IdDetalleRequerimiento = DetalleValesSalida.IdDetalleRequerimiento
                    LEFT OUTER JOIN DetalleSalidasMateriales ON DetalleValesSalida.IdDetalleValeSalida = DetalleSalidasMateriales.IdDetalleValeSalida
                    LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
            WHERE   Requerimientos.IdSolicito = @IdSolicito
                    AND Requerimientos.FechaRequerimiento >= @FechaInicial

    CREATE NONCLUSTERED INDEX IX__Auxiliar9 ON #Auxiliar9 ( IdRequerimiento, Salida )
    ON  [PRIMARY]

    INSERT  INTO #Auxiliar8
            SELECT  IdRequerimiento,
                    ''
            FROM    #Auxiliar9
            GROUP BY IdRequerimiento

/*  CURSOR  */
    DECLARE @Salida VARCHAR(13)
    SET @Corte = 0
    SET @P = ''
    DECLARE Cur CURSOR LOCAL FORWARD_ONLY
        FOR SELECT  IdRequerimiento,
                    Salida
            FROM    #Auxiliar9
            ORDER BY IdRequerimiento
    OPEN Cur
    FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Salida
    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @Corte <> @IdRequerimiento1 
                BEGIN
                    IF @Corte <> 0 
                        BEGIN
                            UPDATE  #Auxiliar8
                            SET     Salidas = SUBSTRING(@P, 1, 100)
                            WHERE   IdRequerimiento = @Corte
                        END
                    SET @P = ''
                    SET @Corte = @IdRequerimiento1
                END
            IF NOT @Salida IS NULL 
                IF PATINDEX('%' + @Salida + ' ' + '%', @P) = 0 
                    SET @P = @P + @Salida + ' '
            FETCH NEXT FROM Cur INTO @IdRequerimiento1, @Salida
        END
    IF @Corte <> 0 
        BEGIN
            UPDATE  #Auxiliar8
            SET     Salidas = SUBSTRING(@P, 1, 100)
            WHERE   IdRequerimiento = @Corte
        END
    CLOSE Cur
    DEALLOCATE Cur

    SET NOCOUNT OFF

    SELECT  Requerimientos.*,
            Obras.NumeroObra + ' ' + Obras.Descripcion AS [Obra],
            #Auxiliar0.Presupuestos AS [Presupuestos],
            #Auxiliar2.Comparativas AS [Comparativas],
            #Auxiliar4.Pedidos AS [Pedidos],
            #Auxiliar6.Recepciones AS [Recepciones],
            #Auxiliar8.Salidas AS [Salidas],
            ( SELECT    COUNT(*)
              FROM      DetalleRequerimientos Det
              WHERE     Det.IdRequerimiento = Requerimientos.IdRequerimiento
            ) AS [Items],
            ( SELECT TOP 1
                        E.Nombre
              FROM      Empleados E
              WHERE     Requerimientos.Aprobo = E.IdEmpleado
            ) AS [Libero],
            ( SELECT TOP 1
                        E.Nombre
              FROM      Empleados E
              WHERE     Requerimientos.IdSolicito = E.IdEmpleado
            ) AS [Solicito],
            ( SELECT TOP 1
                        E.Nombre
              FROM      Empleados E
              WHERE     Requerimientos.IdComprador = E.IdEmpleado
            ) AS [Comprador],
            Sectores.Descripcion AS [Sector],
            ArchivosATransmitirDestinos.Descripcion AS [Origen],
            Articulos.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS
            + ' ' + Articulos.Descripcion AS [EquipoDestino],
            TiposCompra.Descripcion AS [TipoCompra],
            ( SELECT TOP 1
                        E.Nombre
              FROM      Empleados E
              WHERE     E.IdEmpleado = ( SELECT TOP 1
                                                Aut.IdAutorizo
                                         FROM   AutorizacionesPorComprobante Aut
                                         WHERE  Aut.IdFormulario = 3
                                                AND Aut.OrdenAutorizacion = 1
                                                AND Aut.IdComprobante = Requerimientos.IdRequerimiento
                                       )
            ) AS [SegundaFirma],
            ( SELECT TOP 1
                        Aut.FechaAutorizacion
              FROM      AutorizacionesPorComprobante Aut
              WHERE     Aut.IdFormulario = 3
                        AND Aut.OrdenAutorizacion = 1
                        AND Aut.IdComprobante = Requerimientos.IdRequerimiento
            ) AS [FechaSegundaFirma],
            ( SELECT TOP 1
                        E.Nombre
              FROM      Empleados E
              WHERE     E.IdEmpleado = ( SELECT TOP 1
                                                Det.IdComprador
                                         FROM   DetalleRequerimientos Det
                                         WHERE  Det.IdRequerimiento = Requerimientos.IdRequerimiento
                                                AND Det.IdComprador IS NOT NULL
                                       )
            ) AS [CompradorItem]
    FROM    Requerimientos
            LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
            LEFT OUTER JOIN CentrosCosto ON Requerimientos.IdCentroCosto = CentrosCosto.IdCentroCosto
            LEFT OUTER JOIN Sectores ON Requerimientos.IdSector = Sectores.IdSector
            LEFT OUTER JOIN Monedas ON Requerimientos.IdMoneda = Monedas.IdMoneda
            LEFT OUTER JOIN ArchivosATransmitirDestinos ON Requerimientos.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
            LEFT OUTER JOIN Articulos ON Requerimientos.IdEquipoDestino = Articulos.IdArticulo
            LEFT OUTER JOIN #Auxiliar0 ON Requerimientos.IdRequerimiento = #Auxiliar0.IdRequerimiento
            LEFT OUTER JOIN #Auxiliar2 ON Requerimientos.IdRequerimiento = #Auxiliar2.IdRequerimiento
            LEFT OUTER JOIN #Auxiliar4 ON Requerimientos.IdRequerimiento = #Auxiliar4.IdRequerimiento
            LEFT OUTER JOIN #Auxiliar6 ON Requerimientos.IdRequerimiento = #Auxiliar6.IdRequerimiento
            LEFT OUTER JOIN #Auxiliar8 ON Requerimientos.IdRequerimiento = #Auxiliar8.IdRequerimiento
            LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
--WHERE IsNull(Requerimientos.Confirmado,'SI')<>'NO' and Requerimientos.IdSolicito = @IdSolicito and 
--	Requerimientos.FechaRequerimiento>=@FechaInicial
    ORDER BY Requerimientos.FechaRequerimiento DESC,
            Requerimientos.NumeroRequerimiento DESC

    DROP TABLE #Auxiliar0
    DROP TABLE #Auxiliar1
    DROP TABLE #Auxiliar2
    DROP TABLE #Auxiliar3
    DROP TABLE #Auxiliar4
    DROP TABLE #Auxiliar5
    DROP TABLE #Auxiliar6
    DROP TABLE #Auxiliar7
    DROP TABLE #Auxiliar8
    DROP TABLE #Auxiliar9
go


/*
exec wPedidos_T_ByEmployee 403
select * from requerimientos

exec wRequerimientos_T_ByEmployee 403

*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--CUENTAS
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCuentas_TL]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wCuentas_TL]
go

CREATE PROCEDURE [dbo].[wCuentas_TL]
AS 
    SELECT  IdCuenta,
            Descripcion + ' ' + CONVERT(VARCHAR, Codigo) AS [Titulo]
    FROM    Cuentas
    WHERE   IdTipoCuenta = 2
            AND LEN(LTRIM(ISNULL(Descripcion, ''))) > 0
    GROUP BY IdCuenta,
            Codigo,
            Descripcion
    ORDER BY Descripcion
go



--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCuentas_TX_PorObraCuentaGasto]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wCuentas_TX_PorObraCuentaGasto]
go

CREATE PROCEDURE [dbo].[wCuentas_TX_PorObraCuentaGasto]
    @IdObra INT,
    @IdCuentaGasto INT,
    @FechaConsulta DATETIME = NULL
AS 
    SET NOCOUNT ON

    SET @FechaConsulta = ISNULL(@FechaConsulta, GETDATE())

    CREATE TABLE #Auxiliar1
        (
          IdCuenta INTEGER,
          IdCuentaGasto INTEGER,
          Codigo INTEGER,
          Descripcion VARCHAR(100)
        )
    INSERT  INTO #Auxiliar1
            SELECT  Cuentas.IdCuenta,
                    Cuentas.IdCuentaGasto,
                    ISNULL(( SELECT TOP 1
                                    dc.CodigoAnterior
                             FROM   DetalleCuentas dc
                             WHERE  dc.IdCuenta = Cuentas.IdCuenta
                                    AND dc.FechaCambio > @FechaConsulta
                             ORDER BY dc.FechaCambio
                           ), Cuentas.Codigo),
                    ISNULL(( SELECT TOP 1
                                    dc.NombreAnterior
                             FROM   DetalleCuentas dc
                             WHERE  dc.IdCuenta = Cuentas.IdCuenta
                                    AND dc.FechaCambio > @FechaConsulta
                             ORDER BY dc.FechaCambio
                           ), Cuentas.Descripcion)
            FROM    Cuentas
            WHERE   ( IdTipoCuenta = 2
                      OR IdTipoCuenta = 4
                    )
                    AND IdObra = @IdObra
                    AND IdCuentaGasto = @IdCuentaGasto

    SET NOCOUNT OFF

    SELECT TOP 1
            *
    FROM    #Auxiliar1
    WHERE   LEN(LTRIM(Descripcion)) > 0

    DROP TABLE #Auxiliar1
go


-- exec wCuentas_TX_PorObraCuentaGasto @IdObra=1,@IdCuentaGasto=207,@FechaConsulta=NULL
/*

select * from detallecuentas

update cuentas
set IdObra=1



select IdCuenta,IdCuentaGasto,IdObra,* 
from cuentas
order by IdCuentaGasto,IdObra

select IdCuenta,IdCuentaGasto,IdObra,* 
from detallecomprobantesproveedores 
where idCuenta=0
order by idobra

select IdObra,* 
from comprobantesproveedores 
where idcomprobanteproveedor=199


exec wCuentas_TX_PorObraCuentaGasto @IdObra=-1,@IdCuentaGasto=6,@FechaConsulta=NULL

exec wCuentas_TX_PorObraCuentaGasto @IdObra=34,@IdCuentaGasto=6,@FechaConsulta=NULL


exec wCuentas_TX_CuentasGastoPorObraParaCombo @IdObra=34   --filtrado por obra
exec wCuentasGastos_TL										--sin filtrar

exec [wCuentas_TX_PorCodigo] 39

select * from cuentas order by codigo

*/



--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCuentas_TX_CuentasGastoPorObraParaCombo]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wCuentas_TX_CuentasGastoPorObraParaCombo]
go


CREATE PROCEDURE [dbo].[wCuentas_TX_CuentasGastoPorObraParaCombo]
    @IdObra INT,
    @FechaConsulta DATETIME = NULL
AS 
    SET NOCOUNT ON

    SET @FechaConsulta = ISNULL(@FechaConsulta, GETDATE())

    CREATE TABLE #Auxiliar1
        (
          IdCuenta INTEGER,
          Codigo INTEGER,
          Descripcion VARCHAR(100)
        )
    INSERT  INTO #Auxiliar1
            SELECT  Cuentas.IdCuenta,
                    ISNULL(( SELECT TOP 1
                                    dc.CodigoAnterior
                             FROM   DetalleCuentas dc
                             WHERE  dc.IdCuenta = Cuentas.IdCuenta
                                    AND dc.FechaCambio > @FechaConsulta
                             ORDER BY dc.FechaCambio
                           ), Cuentas.Codigo),
                    ISNULL(( SELECT TOP 1
                                    dc.NombreAnterior
                             FROM   DetalleCuentas dc
                             WHERE  dc.IdCuenta = Cuentas.IdCuenta
                                    AND dc.FechaCambio > @FechaConsulta
                             ORDER BY dc.FechaCambio
                           ), Cuentas.Descripcion)
            FROM    Cuentas
            WHERE   ( Cuentas.IdTipoCuenta = 2
                      OR Cuentas.IdTipoCuenta = 4
                    )
                    AND IdObra = @IdObra
                    AND Cuentas.IdCuentaGasto IS NOT NULL

    SET NOCOUNT OFF

    SELECT DISTINCT
            Cuentas.IdCuentaGasto,
            CuentasGastos.Descripcion + ' '
            + CONVERT(VARCHAR, #Auxiliar1.Codigo) AS [Titulo] 
--	CuentasGastos.Descripcion as [Titulo]
    FROM    #Auxiliar1
            LEFT OUTER JOIN Cuentas ON #Auxiliar1.IdCuenta = Cuentas.IdCuenta
            LEFT OUTER JOIN CuentasGastos ON Cuentas.IdCuentaGasto = CuentasGastos.IdCuentaGasto
    WHERE   LEN(LTRIM(#Auxiliar1.Descripcion)) > 0
            AND LEN(LTRIM(CuentasGastos.Descripcion)) > 0
    ORDER BY CuentasGastos.Descripcion + ' '
            + CONVERT(VARCHAR, #Auxiliar1.Codigo)
--ORDER by CuentasGastos.Descripcion
go

/*
-Cómo es que hay cuentas de gasto que no tienen IdCuenta asociada para la obra 34?
-Eeh, dame un ID concreto


exec [wCuentas_TX_CuentasGastoPorObraParaCombo] 34

SELECT *
FROM Cuentas
WHERE (Cuentas.IdTipoCuenta=2 or Cuentas.IdTipoCuenta=4) and 
	IdObra=34 and Cuentas.IdCuentaGasto is not null



exec wCuentas_TX_PorObraCuentaGasto @IdObra=34,@IdCuentaGasto=139,@FechaConsulta=NULL


*/


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCuentas_TX_FondosFijos]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wCuentas_TX_FondosFijos]
go

CREATE PROCEDURE [dbo].[wCuentas_TX_FondosFijos] @IdCuentaFF INT = NULL
AS 
    DECLARE @IdTipoCuentaGrupoFF INT
    SET @IdTipoCuentaGrupoFF = ( SELECT TOP 1
                                        Parametros.IdTipoCuentaGrupoFF
                                 FROM   Parametros
                                 WHERE  IdParametro = 1
                               )

    DECLARE @vector_X VARCHAR(30),
        @vector_T VARCHAR(30)
    SET @vector_X = '011133'
    SET @vector_T = '059500'

    SELECT  IdCuenta,
            Descripcion + ' ' + CONVERT(VARCHAR, Codigo) AS [Titulo],
            IdCuenta AS [IdAux],
            NumeroAuxiliar AS [Prox.Nro.Rend.],
            @Vector_T AS Vector_T,
            @Vector_X AS Vector_X
    FROM    Cuentas
    WHERE   IdTipoCuentaGrupo = @IdTipoCuentaGrupoFF
            AND ( ISNULL(@IdCuentaFF, -1) = -1
                  OR ISNULL(@IdCuentaFF, -1) = IdCuenta
                )
            AND LEN(LTRIM(Descripcion)) > 0
--GROUP By IdCuenta, Codigo, Descripcion
    ORDER BY Descripcion
go


/*

exec [wCuentas_TX_FondosFijos]
Select Top 1 Parametros.IdTipoCuentaGrupoFF From Parametros Where IdParametro=1

select * from cuentas

update cuentas
set IdTipoCuentaGrupo=1
*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCuentasGastos_TL]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wCuentasGastos_TL]
go

CREATE PROCEDURE [dbo].[wCuentasGastos_TL]
AS 
    SELECT  IdCuentaGasto,
            Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS + ' '
            + CONVERT(VARCHAR, Codigo COLLATE SQL_Latin1_General_CP1_CI_AS) COLLATE SQL_Latin1_General_CP1_CI_AS AS [Titulo]
    FROM    CuentasGastos
    ORDER BY Descripcion
GO


--exec [wCuentasGastos_TL]

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCuentas_TX_PorCodigo]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wCuentas_TX_PorCodigo]
go

CREATE PROCEDURE [dbo].[wCuentas_TX_PorCodigo]
    @Codigo INT,
    @FechaConsulta DATETIME = NULL
AS 
    SET @FechaConsulta = ISNULL(@FechaConsulta, GETDATE())

    SELECT  Cuentas.*,
            ISNULL(( SELECT TOP 1
                            dc.CodigoAnterior
                     FROM   DetalleCuentas dc
                     WHERE  dc.IdCuenta = Cuentas.IdCuenta
                            AND dc.FechaCambio > @FechaConsulta
                     ORDER BY dc.FechaCambio
                   ), Cuentas.Codigo) AS [Codigo1],
            ISNULL(( SELECT TOP 1
                            dc.NombreAnterior
                     FROM   DetalleCuentas dc
                     WHERE  dc.IdCuenta = Cuentas.IdCuenta
                            AND dc.FechaCambio > @FechaConsulta
                     ORDER BY dc.FechaCambio
                   ), Cuentas.Descripcion) AS [Descripcion1]
    FROM    Cuentas
    WHERE   ISNULL(( SELECT TOP 1
                            dc.CodigoAnterior
                     FROM   DetalleCuentas dc
                     WHERE  dc.IdCuenta = Cuentas.IdCuenta
                            AND dc.FechaCambio > @FechaConsulta
                     ORDER BY dc.FechaCambio
                   ), Cuentas.Codigo) = @Codigo
go

--exec [wCuentas_TX_PorCodigo] 138

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--EMPLEADOS
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wEmpleados_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wEmpleados_A]
go

CREATE PROCEDURE [dbo].[wEmpleados_A]
    @IdEmpleado INT OUTPUT,
    @Legajo INT,
    @Nombre VARCHAR(50)
AS 
    IF ISNULL(@IdEmpleado, 0) <= 0 
        BEGIN
            INSERT  INTO Empleados ( Legajo, Nombre )
            VALUES  ( @Legajo, @Nombre )
	
            SELECT  @IdEmpleado = @@identity
        END
    ELSE 
        BEGIN
            UPDATE  Empleados
            SET     Legajo = @Legajo,
                    Nombre = @Nombre
            WHERE   ( IdEmpleado = @IdEmpleado )
        END

    IF @@ERROR <> 0 
        RETURN -1
    ELSE 
        RETURN @IdEmpleado

GO


--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wEmpleados_E]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wEmpleados_E]
go


CREATE PROCEDURE [dbo].[wEmpleados_E] @IdEmpleado INT
AS 
    DELETE  Empleados
    WHERE   ( IdEmpleado = @IdEmpleado )

GO

--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wEmpleados_T]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wEmpleados_T]
go


CREATE PROCEDURE [dbo].[wEmpleados_T] @IdEmpleado INT = NULL
AS 
    SET @IdEmpleado = ISNULL(@IdEmpleado, -1)

    SELECT  Empleados.*,
            Sectores.Descripcion AS [Sector],
            Cargos.Descripcion AS [Cargo],
            Cuentas.Descripcion AS [FF_Asignado],
            Obras.NumeroObra AS [ObraAsignada]
    FROM    Empleados
            LEFT OUTER JOIN Sectores ON Empleados.IdSector = Sectores.IdSector
            LEFT OUTER JOIN Cargos ON Empleados.IdCargo = Cargos.IdCargo
            LEFT OUTER JOIN Cuentas ON Empleados.IdCuentaFondoFijo = Cuentas.IdCuenta
            LEFT OUTER JOIN Obras ON Empleados.IdObraAsignada = Obras.IdObra
    WHERE   @IdEmpleado = -1
            OR Empleados.IdEmpleado = @IdEmpleado

GO



--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wEmpleados_TL]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wEmpleados_TL]
go


CREATE PROCEDURE [dbo].[wEmpleados_TL]
AS 
    SELECT  IdEmpleado,
            Nombre AS [Titulo]
    FROM    Empleados
    WHERE   ISNULL(Activo, 'SI') = 'SI'
    ORDER BY Nombre

GO


--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wEmpleados_TX_UsuarioNT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wEmpleados_TX_UsuarioNT]
go



CREATE PROCEDURE [dbo].[wEmpleados_TX_UsuarioNT] @UsuarioNT VARCHAR(50)
AS 
    SELECT  *
    FROM    Empleados
    WHERE   UsuarioNT = @UsuarioNT
            AND ISNULL(Activo, 'SI') = 'SI'
GO

/*
exec [wEmpleados_TX_UsuarioNT] 'UsuarioJefe'

exec [wEmpleados_T] 9

*/
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wSectores_TL]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wSectores_TL]
go

CREATE PROCEDURE [dbo].[wSectores_TL]
AS 
    SELECT  IdSector,
            Descripcion AS [Titulo]
    FROM    Sectores
    ORDER BY Descripcion

GO


--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wUnidades_TL]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wUnidades_TL]
go


CREATE PROCEDURE [dbo].[wUnidades_TL]
AS 
    SELECT  IdUnidad,
            Descripcion AS [Titulo]
    FROM    Unidades
    ORDER BY Descripcion

GO

--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wParametros_T]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wParametros_T]
go


CREATE PROCEDURE [dbo].[wParametros_T]
AS 
    SELECT  *
    FROM    Parametros
    WHERE   ( IdParametro = 1 )

GO


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wTiposComprobante_TX_ParaComboProveedores]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wTiposComprobante_TX_ParaComboProveedores]
go

CREATE PROCEDURE [dbo].[wTiposComprobante_TX_ParaComboProveedores]
AS 
    SELECT  IdTipoComprobante,
            DescripcionAb + '  ' + Descripcion AS Titulo
    FROM    TiposComprobante
    WHERE   Agrupacion1 = 'PROVEEDORES'
    ORDER BY Descripcion
GO


/*
exec [wTiposComprobante_TX_ParaComboProveedores]
*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wObras_TX_DestinosParaComboPorIdObra]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wObras_TX_DestinosParaComboPorIdObra]
go

CREATE PROCEDURE [dbo].[wObras_TX_DestinosParaComboPorIdObra] @IdObra INT
AS 
    SELECT  IdDetalleObraDestino,
            Destino + ' - ' + CONVERT(VARCHAR(60), ISNULL(Detalle, '')) AS [Titulo]
    FROM    DetalleObrasDestinos
    WHERE   @IdObra = -1
            OR IdObra = @IdObra
    ORDER BY Destino
GO

/*
exec [wObras_TX_DestinosParaComboPorIdObra] -1
exec [wObras_TX_DestinosParaComboPorIdObra] 0

*/


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wObras_TL]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wObras_TL]
go

CREATE PROCEDURE [dbo].[wObras_TL]
AS 
    SELECT  IdObra
--,NumeroObra as [Titulo]  --version original
            ,
            NumeroObra + ' - ' + Descripcion AS [Titulo] --version mariano 
    FROM    Obras
    WHERE   Obras.FechaFinalizacion IS NULL
            AND Obras.Jerarquia IS NOT NULL
    ORDER BY NumeroObra
GO
/*
exec [wObras_TL]

select * from obras
*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wObras_TX_PorIdCuentaFFParaCombo]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wObras_TX_PorIdCuentaFFParaCombo]
go


CREATE PROCEDURE [dbo].[wObras_TX_PorIdCuentaFFParaCombo]
    @IdCuentaContableFF INT
AS 
    SELECT  IdObra
--,NumeroObra as [Titulo]  --version original
            ,
            NumeroObra + ' - ' + Descripcion AS [Titulo]
    FROM    Obras
    WHERE   ( IdCuentaContableFF = @IdCuentaContableFF )
go

/*
exec [wObras_TX_PorIdCuentaFFParaCombo] 28
exec [wObras_TX_PorIdCuentaFFParaCombo] 57

select * from obras
*/
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCotizaciones_TX_PorFechaMoneda]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wCotizaciones_TX_PorFechaMoneda]
go

CREATE PROCEDURE [dbo].[wCotizaciones_TX_PorFechaMoneda]
    @Fecha DATETIME,
    @IdMoneda INT
AS 
    SELECT TOP 1
            *
    FROM    Cotizaciones
    WHERE   Fecha = @Fecha
            AND IdMoneda = @IdMoneda
go

/*
exec wCotizaciones_TX_PorFechaMoneda '12:00:00 AM',2

*/
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCuentas_TX_PorId]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wCuentas_TX_PorId]
go

CREATE PROCEDURE [dbo].[wCuentas_TX_PorId] @IdCuenta INT
AS 
    SELECT  Cuentas.*,
            TiposCuentaGrupos.EsCajaBanco
    FROM    Cuentas
            LEFT OUTER JOIN TiposCuentaGrupos ON TiposCuentaGrupos.IdTipoCuentaGrupo = Cuentas.IdTipoCuentaGrupo
    WHERE   ( IdCuenta = @IdCuenta )
GO

/*
exec wCuentas_TX_PorId 43
select NumeroAuxiliar,* from cuentas
*/




--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].Articulos_C')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE Articulos_C
go


CREATE PROCEDURE Articulos_C
    @codigo VARCHAR(50),
    @idRubro INTEGER,
    @Descripcion VARCHAR(100)
AS 
    IF @codigo > '0' 
        BEGIN
            SELECT  Articulos.IdArticulo,
                    Articulos.Descripcion,
                    Articulos.IdCodigo,
                    Articulos.Codigo,
                    Articulos.IdInventario,
                    Articulos.NumeroInventario,
                    Articulos.IdRubro,
                    Articulos.IdUnidad,
                    Articulos.AlicuotaIVA,
                    Articulos.CostoPPP,
                    Articulos.CostoPPPDolar,
                    Articulos.CostoReposicion,
                    Articulos.CostoReposicionDolar,
                    Articulos.Observaciones,
                    Articulos.IdSubrubro,
                    Rubros.Descripcion AS [Rubro],
                    Subrubros.Descripcion AS [Subrubro],
                    ( SELECT    SUM(Stock.CantidadUnidades)
                      FROM      Stock
                      WHERE     Stock.IdArticulo = Articulos.IdArticulo
                    ) AS [Stock actual],
                    ( SELECT TOP 1
                                Unidades.Abreviatura
                      FROM      Unidades
                      WHERE     Articulos.IdUnidad = Unidades.IdUnidad
                    ) AS [Un],
                    ISNULL(Depositos.Abreviatura, Depositos.Descripcion)
                    + ISNULL(', ' + Ubicaciones.Descripcion, '')
                    + ISNULL(' - Est.:' + Ubicaciones.Estanteria, '')
                    + ISNULL(' - Mod.:' + Ubicaciones.Modulo, '')
                    + ISNULL(' - Gab.:' + Ubicaciones.Gabeta, '') AS [Ubicacion],
                    Unidades.Abreviatura AS [Unidad]
            FROM    Articulos
                    LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
                    LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro
                    LEFT OUTER JOIN Ubicaciones ON Articulos.IdUbicacionStandar = Ubicaciones.IdUbicacion
                    LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
                    LEFT OUTER JOIN Unidades ON Articulos.IdUnidad = Unidades.IdUnidad
            WHERE   ISNULL(Articulos.Activo, '') <> 'NO'
                    AND Articulos.Codigo = @codigo
        END 
    ELSE 
        IF @Descripcion = '' 
            BEGIN
                SELECT TOP 250
                        Articulos.IdArticulo,
                        Articulos.Descripcion,
                        Articulos.IdCodigo,
                        Articulos.Codigo,
                        Articulos.IdInventario,
                        Articulos.NumeroInventario,
                        Articulos.IdRubro,
                        Articulos.IdUnidad,
                        Articulos.AlicuotaIVA,
                        Articulos.CostoPPP,
                        Articulos.CostoPPPDolar,
                        Articulos.CostoReposicion,
                        Articulos.CostoReposicionDolar,
                        Articulos.Observaciones,
                        Articulos.IdSubrubro,
                        Rubros.Descripcion AS [Rubro],
                        Subrubros.Descripcion AS [Subrubro],
                        ( SELECT    SUM(Stock.CantidadUnidades)
                          FROM      Stock
                          WHERE     Stock.IdArticulo = Articulos.IdArticulo
                        ) AS [Stock actual],
                        ( SELECT TOP 1
                                    Unidades.Abreviatura
                          FROM      Unidades
                          WHERE     Articulos.IdUnidad = Unidades.IdUnidad
                        ) AS [Un],
                        ISNULL(Depositos.Abreviatura, Depositos.Descripcion)
                        + ISNULL(', ' + Ubicaciones.Descripcion, '')
                        + ISNULL(' - Est.:' + Ubicaciones.Estanteria, '')
                        + ISNULL(' - Mod.:' + Ubicaciones.Modulo, '')
                        + ISNULL(' - Gab.:' + Ubicaciones.Gabeta, '') AS [Ubicacion],
                        Unidades.Abreviatura AS [Unidad]
                FROM    Articulos
                        LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
                        LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro
                        LEFT OUTER JOIN Ubicaciones ON Articulos.IdUbicacionStandar = Ubicaciones.IdUbicacion
                        LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
                        LEFT OUTER JOIN Unidades ON Articulos.IdUnidad = Unidades.IdUnidad
                WHERE   ISNULL(Articulos.Activo, '') <> 'NO'
                        AND Articulos.IdRubro = @IdRubro
                ORDER BY Rubros.Descripcion,
                        Subrubros.Descripcion,
                        Articulos.Codigo
            END
        ELSE 
            BEGIN

                DECLARE @substring VARCHAR(50)
                DECLARE @sentence VARCHAR(4000)
                DECLARE @i INT
                SET @sentence = ''

                SET @i = 0

                WHILE ( CHARINDEX(' ', @Descripcion, 1) <> 0 )
                    BEGIN
                        SET @substring = SUBSTRING(@Descripcion, 1,
                                                   CHARINDEX(' ', @Descripcion,
                                                             1) - 1)
                        IF @i = 0 
                            SET @sentence = @sentence
                                + '(Articulos.Descripcion like ''%'
                                + @substring + '%'')'
                        ELSE 
                            SET @sentence = @sentence
                                + 'and (Articulos.Descripcion like ''%'
                                + @substring + '%'')'
                        SET @i = @i + 1
	-- Find Substring up to Separator
                        SET @Descripcion = SUBSTRING(@Descripcion,
                                                     LEN(@substring) + 2,
                                                     LEN(@Descripcion))
                    END

                IF @i = 0 
                    SET @sentence = @sentence
                        + '(Articulos.Descripcion like ''%' + @Descripcion
                        + '%'')'
                ELSE 
                    SET @sentence = @sentence
                        + 'and (Articulos.Descripcion like ''%' + @Descripcion
                        + '%'')'
                SET @sentence = '
SELECT TOP 250
Articulos.IdArticulo,
Articulos.Descripcion,
Articulos.IdCodigo, 
Articulos.Codigo,
Articulos.IdInventario,
Articulos.NumeroInventario,
Articulos.IdRubro,
Articulos.IdUnidad,
Articulos.AlicuotaIVA,
Articulos.CostoPPP,
Articulos.CostoPPPDolar,
Articulos.CostoReposicion,
Articulos.CostoReposicionDolar,
Articulos.Observaciones,
Articulos.IdSubrubro,
 Rubros.Descripcion as Rubro,
 Subrubros.Descripcion as Subrubro,
 (Select Sum(Stock.CantidadUnidades) From Stock 
	Where Stock.IdArticulo=Articulos.IdArticulo) as [Stock actual],
 (Select Top 1 Unidades.Abreviatura From Unidades 
	Where Articulos.IdUnidad=Unidades.IdUnidad) as [Un],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion)+
	IsNull('', ''+Ubicaciones.Descripcion,'''')+
	IsNull('' - Est.:''+Ubicaciones.Estanteria,'''')+
	IsNull('' - Mod.:''+Ubicaciones.Modulo,'''')+
	IsNull('' - Gab.:''+Ubicaciones.Gabeta,'''') as [Ubicacion],
 Unidades.Abreviatura as [Unidad]
FROM Articulos
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro 
LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro 
LEFT OUTER JOIN Ubicaciones ON Articulos.IdUbicacionStandar = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Unidades ON Articulos.IdUnidad = Unidades.IdUnidad
WHERE IsNull(Articulos.Activo,'''')<>''NO'' AND' + @sentence
                IF @idRubro > 0 
                    SET @sentence = @sentence + ' and Articulos.IdRubro = '
                        + CAST(@IdRubro AS VARCHAR(5))
                SET @sentence = @sentence
                    + +' ORDER by Rubros.Descripcion,Subrubros.Descripcion,Articulos.Codigo'
                EXEC ( @sentence
                    )
            END
GO


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wComprobantesProveedores_TX_UltimoComprobantePorIdProveedor]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wComprobantesProveedores_TX_UltimoComprobantePorIdProveedor]
go

CREATE PROCEDURE [wComprobantesProveedores_TX_UltimoComprobantePorIdProveedor] @IdProveedor INT
AS 
    SELECT TOP 1
            *
    FROM    ComprobantesProveedores cp
    WHERE   cp.IdProveedor = @IdProveedor
            OR cp.IdProveedorEventual = @IdProveedor
    ORDER BY cp.FechaComprobante DESC,
            cp.NumeroComprobante2 DESC

go

/*
exec [wComprobantesProveedores_TX_UltimoComprobantePorIdProveedor] 1204

select NumeroCai, * 
from ComprobantesProveedores 
WHERE IdProveedor=1204

select *
from Proveedores 
WHERE IdProveedor=1204

*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].wFondosFijos_TX_ResumenPorIdCuenta')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wFondosFijos_TX_ResumenPorIdCuenta
go


CREATE PROCEDURE wFondosFijos_TX_ResumenPorIdCuenta @IdCuentaFF INT
AS 
    SET NOCOUNT ON

    DECLARE @IdTipoCuentaGrupoFF INT
    SET @IdTipoCuentaGrupoFF = ISNULL(( SELECT TOP 1
                                                IdTipoCuentaGrupoFF
                                        FROM    Parametros
                                        WHERE   IdParametro = 1
                                      ), 0)

    CREATE TABLE #Auxiliar1
        (
          IdCuenta INTEGER,
          Descripcion VARCHAR(100),
          NumeroRendicion INTEGER,
          FondosAsignados NUMERIC(18, 2),
          ReposicionSolicitada NUMERIC(18, 2),
          RendicionesReintegradas NUMERIC(18, 2),
          PagosPendientesReintegrar NUMERIC(18, 2)
        )
    INSERT  INTO #Auxiliar1
            SELECT  Cuentas.IdCuenta,
                    Cuentas.Descripcion + ' ' + CONVERT(VARCHAR, Codigo),
                    Cuentas.NumeroAuxiliar,
                    ISNULL(( SELECT SUM(ISNULL(op.Valores, 0))
                             FROM   OrdenesPago op
                             WHERE  ISNULL(op.IdCuenta, 0) = Cuentas.IdCuenta
                                    AND ISNULL(op.NumeroRendicionFF, 0) = 0
                                    AND ISNULL(op.OPInicialFF, 'NO') = 'SI'
                           ), 0) AS [Fondo asignado],
                    ISNULL(( SELECT SUM(ISNULL(cp.TotalComprobante, 0))
                             FROM   ComprobantesProveedores cp
                             WHERE  ISNULL(cp.Confirmado, 'SI') = 'SI'
                                    AND ISNULL(cp.IdCuenta, 0) = Cuentas.IdCuenta
                                    AND ISNULL(cp.NumeroRendicionFF, 0) = Cuentas.NumeroAuxiliar
                           ), 0) AS [Reposicion solicitada],
                    ( SELECT    SUM(ISNULL(op.Valores, 0))
                      FROM      OrdenesPago op
                      WHERE     ISNULL(op.IdCuenta, 0) = Cuentas.IdCuenta
                                AND ISNULL(op.NumeroRendicionFF, 0) = Cuentas.NumeroAuxiliar
                                AND ISNULL(op.ConfirmacionAcreditacionFF, 'NO') = 'SI'
                    ) AS [Rendiciones reintegradas],
                    ( SELECT    SUM(ISNULL(op.Valores, 0))
                      FROM      OrdenesPago op
                      WHERE     ISNULL(op.IdCuenta, 0) = Cuentas.IdCuenta
                                AND ISNULL(op.NumeroRendicionFF, 0) = Cuentas.NumeroAuxiliar
                                AND ISNULL(op.ConfirmacionAcreditacionFF, 'NO') = 'NO'
                    ) AS [Pagos pendientes de reintegrar]
            FROM    Cuentas
            WHERE   Cuentas.IdTipoCuentaGrupo = @IdTipoCuentaGrupoFF
                    AND LEN(LTRIM(ISNULL(Cuentas.Descripcion, ''))) > 0 

    SET NOCOUNT OFF

    DECLARE @vector_X VARCHAR(50),
        @vector_T VARCHAR(50) 
    SET @vector_X = '0111111133' 
    SET @vector_T = '0028888800' 

    SELECT  IdCuenta,
            Descripcion AS [Cuenta FF],
            NumeroRendicion AS [Rendicion],
            FondosAsignados AS [Fondos asignados],
            ReposicionSolicitada AS [Reposicion solicitada],
            RendicionesReintegradas AS [Rendiciones reintegradas],
            ISNULL(FondosAsignados, 0) - ISNULL(ReposicionSolicitada, 0)
            + ISNULL(RendicionesReintegradas, 0) AS [Saldo],
            PagosPendientesReintegrar AS [PagosPendientesReintegrar],
            @Vector_T AS [Vector_T],
            @Vector_X AS [Vector_X]
    FROM    #Auxiliar1
    WHERE   IdCuenta = @IdCuentaFF
    ORDER BY Descripcion

    DROP TABLE #Auxiliar1
GO


/*
	exec wFondosFijos_TX_Resumen
*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].wFondosFijos_TX_RendicionesPorIdCuentaParaCombo')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wFondosFijos_TX_RendicionesPorIdCuentaParaCombo
go


CREATE PROCEDURE wFondosFijos_TX_RendicionesPorIdCuentaParaCombo @IdCuentaFF INT
AS 
    SET NOCOUNT ON

    SELECT DISTINCT
            cp.NumeroRendicionFF,
            cp.NumeroRendicionFF AS [Titulo]
    FROM    ComprobantesProveedores cp
            LEFT OUTER JOIN Cuentas ON cp.IdCuenta = Cuentas.IdCuenta
            LEFT OUTER JOIN CuentasGastos ON Cuentas.IdCuentaGasto = CuentasGastos.IdCuentaGasto


go


/*
	select * from comprobantesproveedores
	
		 From ComprobantesProveedores cp 
	 Where IsNull(cp.Confirmado,'SI')='SI' and IsNull(cp.IdCuenta,0)=Cuentas.IdCuenta and 
		IsNull(cp.NumeroRendicionFF,0)=Cuentas.NumeroAuxiliar),0) as [Reposicion solicitada], 

	
	exec wFondosFijos_TX_RendicionesPorIdCuentaParaCombo
*/
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////



/*
exec wParametros_T

exec wEmpleados_TX_UsuarioNT @UsuarioNT='Usuario'
--exec Articulos_C 403
exec Articulos_C @codigo=N'0',@idRubro=0,@Descripcion=''

exec Articulos_C @codigo=N'',@idRubro=0,@Descripcion=N'fib'


exec wComprobantesProveedores_A @IdProveedor=-1,@IdTipoComprobante=-1 ,@FechaComprobante=-1,@Letra=-1--,@NumeroComprobante1=-1,@NumeroComprobante2=-1,@NumeroReferencia=-1,@FechaRecepcion=-1,@FechaVencimiento=-1,@TotalBruto=-1,@TotalIva1=-1,@TotalIva2=-1,@TotalBonificacion=-1,@TotalComprobante=-1,@PorcentajeBonificacion=-1,@Observaciones=-1,@DiasVencimiento=-1,@IdObra=-1,@IdProveedorEventual=-1,@IdOrdenPago=-1,@IdCuenta=-1,@IdMoneda=-1,@CotizacionMoneda=-1,@CotizacionDolar=-1,@TotalIVANoDiscriminado=-1,@IdCuentaIvaCompras1=-1,@IVAComprasPorcentaje1=-1,@IVAComprasImporte1=-1,@IdCuentaIvaCompras2=-1,@IVAComprasPorcentaje2=-1,@IVAComprasImporte2=-1,@IdCuentaIvaCompras3=-1,@IVAComprasPorcentaje3=-1,@IVAComprasImporte3=-1,@IdCuentaIvaCompras4=-1,@IVAComprasPorcentaje4=-1,@IVAComprasImporte4=-1,@IdCuentaIvaCompras5=-1,@IVAComprasPorcentaje5=-1,@IVAComprasImporte5=-1,@IdCuentaIvaCompras6=-1,@IVAComprasPorcentaje6=-1,@IVAComprasImporte6=-1,@IdCuentaIvaCompras7=-1,@IVAComprasPorcentaje7=-1,@IVAComprasImporte7=-1,@IdCuentaIvaCompras8=-1,@IVAComprasPorcentaje8=-1,@IVAComprasImporte8=-1,@IdCuentaIvaCompras9=-1,@IVAComprasPorcentaje9=-1,@IVAComprasImporte9=-1,@IdCuentaIvaCompras10=-1,@IVAComprasPorcentaje10=-1,@IVAComprasImporte10=-1,@SubtotalGravado=-1,@SubtotalExento=-1,@AjusteIVA=-1,@PorcentajeIVAAplicacionAjuste=-1,@BienesOServicios=-1,@IdDetalleOrdenPagoRetencionIVAAplicada=-1,@IdIBCondicion=-1,@PRESTOFactura=-1,@Confirmado=-1,@IdProvinciaDestino=-1,@IdTipoRetencionGanancia=-1,@NumeroCAI=-1,@FechaVencimientoCAI=-1,@IdCodigoAduana=-1,@IdCodigoDestinacion=-1,@NumeroDespacho=-1,@DigitoVerificadorNumeroDespacho=-1,@FechaDespachoAPlaza=-1,@IdUsuarioIngreso=-1,@FechaIngreso=-1,@IdUsuarioModifico=-1,@FechaModifico=-1,@PRESTOProveedor=-1,@IdCodigoIva=-1,@CotizacionEuro=-1,@IdCondicionCompra=-1,@Importacion_FOB=-1,@Importacion_PosicionAduana=-1,@Importacion_Despacho=-1,@Importacion_Guia=-1,@Importacion_IdPaisOrigen=-1,@Importacion_FechaEmbarque=-1,@Importacion_FechaOficializacion=-1,@REP_CTAPRO_INS=-1,@REP_CTAPRO_UPD=-1,@InformacionAuxiliar=-1,@GravadoParaSUSS=-1,@PorcentajeParaSUSS=-1,@FondoReparo=-1,@AutoincrementarNumeroReferencia=-1,@ReintegroImporte=-1,@ReintegroDespacho=-1,@ReintegroIdMoneda=-1,@ReintegroIdCuenta=-1,@PrestoDestino=-1,@IdFacturaVenta_RecuperoGastos=-1,@IdNotaCreditoVenta_RecuperoGastos=-1,@IdComprobanteImputado=-1,@IdCuentaOtros=-1,@PRESTOFechaProceso=-1,@DestinoPago=-1,@NumeroRendicionFF=-1,@Cuit=-1,@FechaAsignacionPresupuesto=-1,@Dolarizada=-1,@IdComprobanteProveedor=-1,@NumeroOrdenPagoFondoReparo=-1,@IdListaPrecios=-1,@IdComprobanteProveedorOriginal=-1,@PorcentajeIVAParaMonotributistas=-1,@IdDiferenciaCambio=-1




exec wDetComprobantesProveedores_A @IdDetalleComprobanteProveedor=NULL,@IdComprobanteProveedor=506,@IdArticulo=18,@CodigoArticulo=N'',@IdCuenta=0,@CodigoCuenta=N'',@PorcentajeIvaAplicado=0,@Importe=0,@IdCuentaGasto=0,@IdCuentaIvaCompras1=0,@IVAComprasPorcentaje1=0,@ImporteIVA1=0,@AplicarIVA1=N'',@IdCuentaIvaCompras2=0,@IVAComprasPorcentaje2=0,@ImporteIVA2=0,@AplicarIVA2=N'',@IdCuentaIvaCompras3=0,@IVAComprasPorcentaje3=0,@ImporteIVA3=0,@AplicarIVA3=N'',@IdCuentaIvaCompras4=0,@IVAComprasPorcentaje4=0,@ImporteIVA4=0,@AplicarIVA4=N'',@IdCuentaIvaCompras5=0,@IVAComprasPorcentaje5=0,@ImporteIVA5=0,@AplicarIVA5=N'',@IdObra=0,@Item=0,@IdCuentaIvaCompras6=0,@IVAComprasPorcentaje6=0,@ImporteIVA6=0,@AplicarIVA6=N'',@IdCuentaIvaCompras7=0,@IVAComprasPorcentaje7=0,@ImporteIVA7=0,@AplicarIVA7=N'',@IdCuentaIvaCompras8=0,@IVAComprasPorcentaje8=0,@ImporteIVA8=0,@AplicarIVA8=N'',@IdCuentaIvaCompras9=0,@IVAComprasPorcentaje9=0,@ImporteIVA9=0,@AplicarIVA9=N'',@IdCuentaIvaCompras10=0,@IVAComprasPorcentaje10=0,@ImporteIVA10=0,@AplicarIVA10=N'',@IVAComprasPorcentajeDirecto=0,@IdCuentaBancaria=0,@PRESTOConcepto=N'',@PRESTOObra=N'',@IdDetalleRecepcion=0,@TomarEnCalculoDeImpuestos=N'',@IdRubroContable=0,@IdPedido=0,@IdDetallePedido=0,@Importacion_FOB=0,@Importacion_PosicionAduana=N'',@Importacion_Despacho=N'',@Importacion_Guia=N'',@Importacion_IdPaisOrigen=0,@Importacion_FechaEmbarque=NULL,@Importacion_FechaOficializacion=NULL,@IdProvinciaDestino1=0,@PorcentajeProvinciaDestino1=0,@IdProvinciaDestino2=0,@PorcentajeProvinciaDestino2=0,@IdDistribucionObra=0,@Cantidad=333,@IdDetalleObraDestino=0,@IdPresupuestoObraRubro=0,@IdPedidoAnticipo=0,@PorcentajeAnticipo=0,@PorcentajeCertificacion=0,@IdPresupuestoObrasNodo=0,@IdDetalleComprobanteProveedorOriginal=0
exec wDetComprobantesProveedores_A @IdDetalleComprobanteProveedor=NULL,@IdComprobanteProveedor=509,@IdArticulo=18,@CodigoArticulo=N'',@IdCuenta=0,@CodigoCuenta=N'',@PorcentajeIvaAplicado=0,@Importe=0,@IdCuentaGasto=0,@IdCuentaIvaCompras1=0,@IVAComprasPorcentaje1=0,@ImporteIVA1=0,@AplicarIVA1=N'',@IdCuentaIvaCompras2=0,@IVAComprasPorcentaje2=0,@ImporteIVA2=0,@AplicarIVA2=N'',@IdCuentaIvaCompras3=0,@IVAComprasPorcentaje3=0,@ImporteIVA3=0,@AplicarIVA3=N'',@IdCuentaIvaCompras4=0,@IVAComprasPorcentaje4=0,@ImporteIVA4=0,@AplicarIVA4=N'',@IdCuentaIvaCompras5=0,@IVAComprasPorcentaje5=0,@ImporteIVA5=0,@AplicarIVA5=N'',@IdObra=0,@Item=0,@IdCuentaIvaCompras6=0,@IVAComprasPorcentaje6=0,@ImporteIVA6=0,@AplicarIVA6=N'',@IdCuentaIvaCompras7=0,@IVAComprasPorcentaje7=0,@ImporteIVA7=0,@AplicarIVA7=N'',@IdCuentaIvaCompras8=0,@IVAComprasPorcentaje8=0,@ImporteIVA8=0,@AplicarIVA8=N'',@IdCuentaIvaCompras9=0,@IVAComprasPorcentaje9=0,@ImporteIVA9=0,@AplicarIVA9=N'',@IdCuentaIvaCompras10=0,@IVAComprasPorcentaje10=0,@ImporteIVA10=0,@AplicarIVA10=N'',@IVAComprasPorcentajeDirecto=0,@IdCuentaBancaria=0,@PRESTOConcepto=N'',@PRESTOObra=N'',@IdDetalleRecepcion=0,@TomarEnCalculoDeImpuestos=N'',@IdRubroContable=0,@IdPedido=0,@IdDetallePedido=0,@Importacion_FOB=0,@Importacion_PosicionAduana=N'',@Importacion_Despacho=N'',@Importacion_Guia=N'',@Importacion_IdPaisOrigen=0,@Importacion_FechaEmbarque=NULL,@Importacion_FechaOficializacion=NULL,@IdProvinciaDestino1=0,@PorcentajeProvinciaDestino1=0,@IdProvinciaDestino2=0,@PorcentajeProvinciaDestino2=0,@IdDistribucionObra=0,@Cantidad=333,@IdDetalleObraDestino=0,@IdPresupuestoObraRubro=0,@IdPedidoAnticipo=0,@PorcentajeAnticipo=0,@PorcentajeCertificacion=0,@IdPresupuestoObrasNodo=0,@IdDetalleComprobanteProveedorOriginal=0
exec DetComprobantesProveedores_A @IdDetalleComprobanteProveedor=NULL,@IdComprobanteProveedor=507,@IdArticulo=18,@CodigoArticulo=N'',@IdCuenta=0,@CodigoCuenta=N'',@PorcentajeIvaAplicado=0,@Importe=0,@IdCuentaGasto=0,@IdCuentaIvaCompras1=0,@IVAComprasPorcentaje1=0,@ImporteIVA1=0,@AplicarIVA1=N'',@IdCuentaIvaCompras2=0,@IVAComprasPorcentaje2=0,@ImporteIVA2=0,@AplicarIVA2=N'',@IdCuentaIvaCompras3=0,@IVAComprasPorcentaje3=0,@ImporteIVA3=0,@AplicarIVA3=N'',@IdCuentaIvaCompras4=0,@IVAComprasPorcentaje4=0,@ImporteIVA4=0,@AplicarIVA4=N'',@IdCuentaIvaCompras5=0,@IVAComprasPorcentaje5=0,@ImporteIVA5=0,@AplicarIVA5=N'',@IdObra=0,@Item=0,@IdCuentaIvaCompras6=0,@IVAComprasPorcentaje6=0,@ImporteIVA6=0,@AplicarIVA6=N'',@IdCuentaIvaCompras7=0,@IVAComprasPorcentaje7=0,@ImporteIVA7=0,@AplicarIVA7=N'',@IdCuentaIvaCompras8=0,@IVAComprasPorcentaje8=0,@ImporteIVA8=0,@AplicarIVA8=N'',@IdCuentaIvaCompras9=0,@IVAComprasPorcentaje9=0,@ImporteIVA9=0,@AplicarIVA9=N'',@IdCuentaIvaCompras10=0,@IVAComprasPorcentaje10=0,@ImporteIVA10=0,@AplicarIVA10=N'',@IVAComprasPorcentajeDirecto=0,@IdCuentaBancaria=0,@PRESTOConcepto=N'',@PRESTOObra=N'',@IdDetalleRecepcion=0,@TomarEnCalculoDeImpuestos=N'',@IdRubroContable=0,@IdPedido=0,@IdDetallePedido=0,@Importacion_FOB=0,@Importacion_PosicionAduana=N'',@Importacion_Despacho=N'',@Importacion_Guia=N'',@Importacion_IdPaisOrigen=0,@Importacion_FechaEmbarque=NULL,@Importacion_FechaOficializacion=NULL,@IdProvinciaDestino1=0,@PorcentajeProvinciaDestino1=0,@IdProvinciaDestino2=0,@PorcentajeProvinciaDestino2=0,@IdDistribucionObra=0,@Cantidad=333,@IdDetalleObraDestino=0,@IdPresupuestoObraRubro=0,@IdPedidoAnticipo=0,@PorcentajeAnticipo=0,@PorcentajeCertificacion=0,@IdPresupuestoObrasNodo=0,@IdDetalleComprobanteProveedorOriginal=0
exec wDetComprobantesProveedores_A @IdDetalleComprobanteProveedor=NULL,@IdComprobanteProveedor=509,@IdArticulo=18,@CodigoArticulo=N'',@IdCuenta=0,@CodigoCuenta=N'',@PorcentajeIvaAplicado=0,@Importe=0,@IdCuentaGasto=0,@IdCuentaIvaCompras1=0,@IVAComprasPorcentaje1=0,@ImporteIVA1=0,@AplicarIVA1=N'',@IdCuentaIvaCompras2=0,@IVAComprasPorcentaje2=0,@ImporteIVA2=0,@AplicarIVA2=N'',@IdCuentaIvaCompras3=0,@IVAComprasPorcentaje3=0,@ImporteIVA3=0,@AplicarIVA3=N'',@IdCuentaIvaCompras4=0,@IVAComprasPorcentaje4=0,@ImporteIVA4=0,@AplicarIVA4=N'',@IdCuentaIvaCompras5=0,@IVAComprasPorcentaje5=0,@ImporteIVA5=0,@AplicarIVA5=N'',@IdObra=0,@Item=0,@IdCuentaIvaCompras6=0,@IVAComprasPorcentaje6=0,@ImporteIVA6=0,@AplicarIVA6=N'',@IdCuentaIvaCompras7=0,@IVAComprasPorcentaje7=0,@ImporteIVA7=0,@AplicarIVA7=N'',@IdCuentaIvaCompras8=0,@IVAComprasPorcentaje8=0,@ImporteIVA8=0,@AplicarIVA8=N'',@IdCuentaIvaCompras9=0,@IVAComprasPorcentaje9=0,@ImporteIVA9=0,@AplicarIVA9=N'',@IdCuentaIvaCompras10=0,@IVAComprasPorcentaje10=0,@ImporteIVA10=0,@AplicarIVA10=N'',@IVAComprasPorcentajeDirecto=0,@IdCuentaBancaria=0,@PRESTOConcepto=N'',@PRESTOObra=N'',@IdDetalleRecepcion=0,@TomarEnCalculoDeImpuestos=N'',@IdRubroContable=0,@IdPedido=0,@IdDetallePedido=0,@Importacion_FOB=0,@Importacion_PosicionAduana=N'',@Importacion_Despacho=N'',@Importacion_Guia=N'',@Importacion_IdPaisOrigen=0,@Importacion_FechaEmbarque=NULL,@Importacion_FechaOficializacion=NULL,@IdProvinciaDestino1=0,@PorcentajeProvinciaDestino1=0,@IdProvinciaDestino2=0,@PorcentajeProvinciaDestino2=0,@IdDistribucionObra=0,@Cantidad=121,@IdDetalleObraDestino=0,@IdPresupuestoObraRubro=0,@IdPedidoAnticipo=0,@PorcentajeAnticipo=0,@PorcentajeCertificacion=0,@IdPresupuestoObrasNodo=0,@IdDetalleComprobanteProveedorOriginal=0

exec wDetComprobantesProveedores_TT 56
exec wDetComprobantesProveedores_TT 171
exec wComprobantesProveedores_T 171

select confirmado,numeroreferencia,* from comprobantesproveedores
select * from detallecomprobantesproveedores 
select * from etapas
select * from obrasdestinos

select * from tiposcomprobante
exec wDetComprobantesProveedores_A @IdDetalleComprobanteProveedor=NULL,@IdComprobanteProveedor=520,@IdArticulo=18,@CodigoArticulo=N'',@IdCuenta=0,@CodigoCuenta=N'',@PorcentajeIvaAplicado=0,@Importe=0,@IdCuentaGasto=0,@IdCuentaIvaCompras1=0,@IVAComprasPorcentaje1=0,@ImporteIVA1=0,@AplicarIVA1=N'',@IdCuentaIvaCompras2=0,@IVAComprasPorcentaje2=0,@ImporteIVA2=0,@AplicarIVA2=N'',@IdCuentaIvaCompras3=0,@IVAComprasPorcentaje3=0,@ImporteIVA3=0,@AplicarIVA3=N'',@IdCuentaIvaCompras4=0,@IVAComprasPorcentaje4=0,@ImporteIVA4=0,@AplicarIVA4=N'',@IdCuentaIvaCompras5=0,@IVAComprasPorcentaje5=0,@ImporteIVA5=0,@AplicarIVA5=N'',@IdObra=0,@Item=0,@IdCuentaIvaCompras6=0,@IVAComprasPorcentaje6=0,@ImporteIVA6=0,@AplicarIVA6=N'',@IdCuentaIvaCompras7=0,@IVAComprasPorcentaje7=0,@ImporteIVA7=0,@AplicarIVA7=N'',@IdCuentaIvaCompras8=0,@IVAComprasPorcentaje8=0,@ImporteIVA8=0,@AplicarIVA8=N'',@IdCuentaIvaCompras9=0,@IVAComprasPorcentaje9=0,@ImporteIVA9=0,@AplicarIVA9=N'',@IdCuentaIvaCompras10=0,@IVAComprasPorcentaje10=0,@ImporteIVA10=0,@AplicarIVA10=N'',@IVAComprasPorcentajeDirecto=0,@IdCuentaBancaria=0,@PRESTOConcepto=N'',@PRESTOObra=N'',@IdDetalleRecepcion=0,@TomarEnCalculoDeImpuestos=N'',@IdRubroContable=0,@IdPedido=0,@IdDetallePedido=0,@Importacion_FOB=0,@Importacion_PosicionAduana=N'',@Importacion_Despacho=N'',@Importacion_Guia=N'',@Importacion_IdPaisOrigen=0,@Importacion_FechaEmbarque=NULL,@Importacion_FechaOficializacion=NULL,@IdProvinciaDestino1=0,@PorcentajeProvinciaDestino1=0,@IdProvinciaDestino2=0,@PorcentajeProvinciaDestino2=0,@IdDistribucionObra=0,@Cantidad=34,@IdDetalleObraDestino=0,@IdPresupuestoObraRubro=0,@IdPedidoAnticipo=0,@PorcentajeAnticipo=0,@PorcentajeCertificacion=0,@IdPresupuestoObrasNodo=0,@IdDetalleComprobanteProveedorOriginal=0

select * from proveedores


*/


/*

EXEC @returnstatus = dbo.ufnGetSalesOrderStatusText @Status = 2;
PRINT @returnstatus;

select ProximoComprobanteProveedorReferencia,FechaTimeStamp from parametros

declare @returnstatus int 

exec @returnstatus = dbo.Parametros_M @IdParametro=1,@ProximoPresupuesto=1,@Iva1=21.00,@Iva2=0.00,@ProximaListaAcopio=1,@ProximaListaMateriales=1,@ProximoNumeroRequerimiento=3,@IdUnidadPorUnidad=65,@ProximoNumeroAjusteStock=1,@ProximoNumeroReservaStock=1,@ProximoNumeroPedido=1,@ControlCalidadDefault=1,@ProximoNumeroValeSalida=1,@ProximoNumeroSalidaMateriales=1,@ProximaComparativa=1,@PathAdjuntos=N'',@IdUnidadPorKilo=7,@PedidosGarantia=N'',@PedidosDocumentacion=N'',@PedidosPlazoEntrega=N'',@PedidosLugarEntrega=N'',@PedidosFormaPago=N'',@ProximoNumeroSalidaMaterialesAObra=1,@ProximoNumeroSalidaMaterialesParaFacturar=1,@ProximoNumeroSalidaMateriales2=1,@ProximoNumeroSalidaMaterialesAObra2=1,@ProximoNumeroSalidaMaterialesParaFacturar2=1,@PedidosInspecciones=N'',@PedidosImportante=N'',@PathEnvioEmails=N'',@PathRecepcionEmails=N'',@ProximoNumeroSalidaMaterialesAProveedor=1,@ProximoNumeroSalidaMaterialesAProveedor2=1,@ProximoNumeroDevolucionDeFabrica=1,@ProximoNumeroDevolucionDeFabrica2=1,@ArchivoAyuda=N'',@PathArchivoExcelDatanet=N'',@PathArchivoExcelProveedores=N'',@Porc_IBrutos_Cap=0.00,@Tope_IBrutos_Cap=0.00,@Porc_IBrutos_BsAs=0.00,@Tope_IBrutos_BsAs=0.00,@Porc_IBrutos_BsAsM=0.00,@Tope_IBrutos_BsAsM=0.00,@Decimales=2,@AclaracionAlPieDeFactura=N'',@CotizacionDolar=0.00,@ProximoAsiento=12,@ProximoNumeroInterno=4,@NumeracionUnica=N'SI',@EjercicioActual=0,@IdCuentaVentas=0,@IdCuentaBonificaciones=0,@IdCuentaIvaInscripto=238,@IdCuentaIvaNoInscripto=0,@IdCuentaIvaSinDiscriminar=238,@IdCuentaRetencionIBrutosBsAs=0,@IdCuentaRetencionIBrutosCap=0,@IdCuentaReventas=0,@IdCuentaND=0,@IdCuentaNC=0,@IdCuentaCaja=5,@IdCuentaValores=10,@IdCuentaRetencionIva=0,@IdCuentaRetencionGanancias=246,@IdCuentaRetencionIBrutos=244,@IdCuentaDescuentos=0,@IdCuentaDescuentosyRetenciones=0,@IdUnidad=65,@IdMoneda=1,@IdCuentaCompras=0,
@ProximoComprobanteProveedorReferencia=150
,@ProximoNumeroInternoChequeEmitido=274,@ProximaNumeroOrdenPago=1,@IdCuentaIvaCompras=0,@CAI=N'',@FechaCAI=N'',@ClausulaDolar=N'',@IdMonedaDolar=2,@NumeroCAI_R_A=N'',@FechaCAI_R_A='Ene  1 1900 12:00:00:000AM',@NumeroCAI_F_A=N'',@FechaCAI_F_A='Ene  1 1900 12:00:00:000AM',@NumeroCAI_D_A=N'',@FechaCAI_D_A='Ene  1 1900 12:00:00:000AM',@NumeroCAI_C_A=N'',@FechaCAI_C_A='Ene  1 1900 12:00:00:000AM',@NumeroCAI_R_B=N'',@FechaCAI_R_B='Ene  1 1900 12:00:00:000AM',@NumeroCAI_F_B=N'',@FechaCAI_F_B='Ene  1 1900 12:00:00:000AM',@NumeroCAI_D_B=N'',@FechaCAI_D_B='Ene  1 1900 12:00:00:000AM',@NumeroCAI_C_B=N'',@FechaCAI_C_B='Ene  1 1900 12:00:00:000AM',@NumeroCAI_R_E=N'',@FechaCAI_R_E='Ene  1 1900 12:00:00:000AM',@NumeroCAI_F_E=N'',@FechaCAI_F_E='Ene  1 1900 12:00:00:000AM',@NumeroCAI_D_E=N'',@FechaCAI_D_E='Ene  1 1900 12:00:00:000AM',@NumeroCAI_C_E=N'',@FechaCAI_C_E='Ene  1 1900 12:00:00:000AM',@NumeracionCorrelativa=N'',@ProximoNumeroRefProveedores=1,@ProximoNumeroCuentaContable=76621,@IdCuentaAcreedoresVarios=212,@IdCuentaDeudoresVarios=80,@ProximaOrdenPago=36,@IdCuentaIvaCompras1=117,@IVAComprasPorcentaje1=21.00,@IdCuentaIvaCompras2=117,@IVAComprasPorcentaje2=27.00,@IdCuentaIvaCompras3=117,@IVAComprasPorcentaje3=10.50,@IdCuentaIvaCompras4=NULL,@IVAComprasPorcentaje4=0.00,@IdCuentaIvaCompras5=NULL,@IVAComprasPorcentaje5=0.00,@ProximaOrdenPagoExterior=1,@MinimoNoImponible=0.00,@DeduccionEspecial=0.00,@ProximoNumeroCertificadoRetencionGanancias=10,@IdCuentaVentasTitulo=1,@IdCuentaNDTitulo=0,@IdCuentaNCTitulo=0,@IdCuentaCajaTitulo=4,@IdCuentaValoresTitulo=5,@IdCuentaDescuentosyRetencionesTitulo=0,@IdCuentaComprasTitulo=7,@IdCuentaIvaCompras6=NULL,@IVAComprasPorcentaje6=0.00,@IdCuentaIvaCompras7=NULL,@IVAComprasPorcentaje7=0.00,@IdCuentaIvaCompras8=NULL,@IVAComprasPorcentaje8=0.00,@IdCuentaIvaCompras9=NULL,@IVAComprasPorcentaje9=0.00,@IdCuentaIvaCompras10=NULL,@IVAComprasPorcentaje10=0.00,@ProximoNumeroOrdenCompra=1,@ProximoNumeroRemito=1,@IdCuentaRetencionGananciasCobros=111,@IdTipoCuentaGrupoIVA=36,@IGCondicionExcepcion=4,@IdCuentaIvaVentas1=238,@IVAVentasPorcentaje1=21.00,@IdCuentaIvaVentas2=238,@IVAVentasPorcentaje2=10.50,@IdCuentaIvaVentas3=NULL,@IVAVentasPorcentaje3=0.00,@IdCuentaIvaVentas4=NULL,@IVAVentasPorcentaje4=0.00,@ProximaOrdenPagoOtros=22,@IdTipoComprobanteEfectivo=30,@IdTipoComprobanteDeposito=9,@ProximaNotaDebitoInterna=1,@ProximaNotaCreditoInterna=1,@IdTipoComprobanteCajaIngresos=32,@IdTipoComprobanteCajaEgresos=33,@DirectorioDTS=N'E:\SistemaPronto\GestionCubos\',@PathObra=N'',@FechaUltimoCierre='Jun 30 2000 12:00:00:000AM',@IdConceptoDiferenciaCambio=0,@IdTipoCuentaGrupoFF=1,@ProximoNumeroOtroIngresoAlmacen=1,@AgenteRetencionIVA=N'NO',@ImporteTotalMinimoAplicacionRetencionIVA=0.00,@PorcentajeBaseRetencionIVABienes=0.00,@PorcentajeBaseRetencionIVAServicios=0.00,@ImporteMinimoRetencionIVA=0.00,@ProximoNumeroCertificadoRetencionIVA=0,@ProximoNumeroCertificadoRetencionIIBB=0,@IdTipoComprobanteFacturaCompra=11,@IdTipoComprobanteFacturaVenta=1,@IdTipoComprobanteDevoluciones=5,@IdTipoComprobanteNotaDebito=3,@IdTipoComprobanteNotaCredito=4,@IdTipoComprobanteRecibo=2,@IdControlCalidadStandar=1,@IdTipoCuentaGrupoAnticiposAlPersonal=0,@IdTipoComprobanteNDInternaAcreedores=19,@IdTipoComprobanteNCInternaAcreedores=13,@PercepcionIIBB=N'NO',@OtrasPercepciones1=N'NO',@OtrasPercepciones1Desc=N'',@OtrasPercepciones2=N'NO',@OtrasPercepciones2Desc=N'',@IdCuentaDiferenciaCambio=0,@ProximoNumeroReciboPago=1,@NumeroReciboPagoAutomatico=N'NO',@IdCuentaPercepcionIIBB=0,@IdCuentaOtrasPercepciones1=0,@IdCuentaOtrasPercepciones2=0,@ConfirmarClausulaDolar=N'NO',@ProximoNumeroPedidoExterior=1,@ExigirTrasabilidad_RMLA_PE=N'NO',@AgenteRetencionSUSS=N'SI',@PorcentajeRetencionSUSS=2.10,@ProximoNumeroCertificadoRetencionSUSS=5,@IdCuentaRetencionSUSS=245,@IdCuentaPercepcionIVACompras=118,@IdPuntoVentaNumeracionUnica=0,@AgenteRetencionIIBB=N'SI',@PathArchivosExportados=N'',@IdObraStockDisponible=0,@IdTipoComprobanteOrdenPago=17,@ProximoNumeroInternoRecepcion=1,@IdCuentaRetencionSUSS_Recibida=114,@Plantilla_Factura_A=N'',@Plantilla_Factura_B=N'',@Plantilla_Factura_E=N'',@Plantilla_Devoluciones_A=N'',@Plantilla_Devoluciones_B=N'',@Plantilla_Devoluciones_E=N'',@Plantilla_NotasDebito_A=N'',@Plantilla_NotasDebito_B=N'',@Plantilla_NotasDebito_E=N'',@Plantilla_NotasCredito_A=N'',@Plantilla_NotasCredito_B=N'',@Plantilla_NotasCredito_E=N'',@FechaArranqueCajaYBancos='Jul  1 2000 12:00:00:000AM',@IdRubroVentasEnCuotas=0,@IdConceptoVentasEnCuotas=0,@IdCuentaPlazosFijos=63,@IdCuentaInteresesPlazosFijos=316,@NumeroGeneracionVentaEnCuotas=1,@IdBancoGestionCobroCuotas=0,@PathArchivoCobranzaCuotas=N'',@TipoAmortizacionContable=N'',@FrecuenciaAmortizacionContable=N'',@TipoAmortizacionImpositiva=N'',@FrecuenciaAmortizacionImpositiva=N'',@IdCuentaResultadosEjercicio=280,@IdCuentaResultadosAcumulados=281,@CuentasResultadoDesde=40000,@CuentasResultadoHasta=99999,@CuentasPatrimonialesDesde=10000,@CuentasPatrimonialesHasta=39999,@IdArticuloVariosParaPRESTO=0,@ControlarRubrosContablesEnOP=N'NO',@IdObraActiva=0,@IdCuentaAdicionalIVACompras1=NULL,@IdCuentaAdicionalIVACompras2=NULL,@IdCuentaAdicionalIVACompras3=NULL,@IdCuentaAdicionalIVACompras4=NULL,@IdCuentaAdicionalIVACompras5=NULL,@FechaUltimoCierreEjercicio='Jun 30 2000 12:00:00:000AM',@EmiteAsientoEnOP=N'NO',@IdMonedaEuro=6,@LineasDiarioDetallado=40,@LineasDiarioResumido=40,@PathEnvioEmailsMANTENIMIENTO=N'',@PathRecepcionEmailsMANTENIMIENTO=N'',@ImporteComprobantesMParaRetencionIVA=1000.00,@PorcentajeRetencionIVAComprobantesM=21.00,@ImporteComprobantesMParaRetencionGanancias=0.00,@PorcentajeRetencionGananciasComprobantesM=2.00,@IdTipoComprobanteFacturaCompraExportacion=40,@IvaCompras_DesglosarNOGRAVADOS=N'NO',@IdCuentaImpuestosInternos=0,@Subdiarios_ResumirRegistros=N'NO',@IdCajaEnPesosDefault=1,@ProximoNumeroGastoBancario=1,@ProximoNumeroSolicitudCompra=1,@IdCuentaReintegros=0,@IdArticuloPRONTO_MANTENIMIENTO=0,@ProximoCodigoArticulo=1,
@FechaTimeStamp=0x0000000000085D79,
@PathPlantillas=N'\\serverSQL\DocumentosPronto\Plantillas',@OtrasPercepciones3=N'NO',@OtrasPercepciones3Desc=N'',@IdCuentaOtrasPercepciones3=0,@FechaArranqueMovimientosStock='Jul  1 2000 12:00:00:000AM',@IdCuentaRetencionIvaComprobantesM=0,@IdJefeCompras=9,@ImporteMinimoRetencionIVAServicios=0.00,@IdCuentaPercepcionesIVA=0,@IdCuentaREI_Ganancia=0,@IdCuentaREI_Perdida=0,@ActivarCircuitoChequesDiferidos=N'SI',@BasePRONTOSyJAsociada=NULL,@IdConceptoAnticiposSyJ=NULL,@IdConceptoRecuperoGastos=0,@BasePRONTOConsolidacion=NULL,@PorcentajeConsolidacion=NULL,@BasePRONTOConsolidacion2=NULL,@PorcentajeConsolidacion2=NULL,@BasePRONTOConsolidacion3=NULL,@PorcentajeConsolidacion3=NULL,@IdCuentaAjusteConsolidacion=0,@PathImportacionDatos=N'',@ActivarSolicitudMateriales=NULL,@TopeMinimoRetencionIVA=0.00,@TopeMinimoRetencionIVAServicios=0.00,@IdMonedaPrincipal=1,@IdTipoComprobanteTarjetaCredito=43,@ProximoNumeroOrdenTrabajo=1,@BasePRONTOMantenimiento=N'ProntoMantenimientoMarcalba',@ProximaOrdenPagoFF=1

PRINT @returnstatus
*/

/*
exec proveedores_T 5899


exec FondosFijos_TX_Resumen
*/



--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////



















--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--			PRESUPUESTOS
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////



--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].wPresupuestos_A')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wPresupuestos_A
go



CREATE PROCEDURE wPresupuestos_A
    @IdPresupuesto INT,
    @Numero INT,
    @IdProveedor INT,
    @FechaIngreso DATETIME,
    @Observaciones NTEXT,
    @Bonificacion NUMERIC(6, 2),
    @Plazo VARCHAR(50),
    @validez VARCHAR(50),
    @IdCondicionCompra INT,
    @Garantia VARCHAR(50),
    @LugarEntrega VARCHAR(50),
    @IdComprador INT,
    @Referencia VARCHAR(50),
    @PorcentajeIva1 NUMERIC(6, 2),
    @PorcentajeIva2 NUMERIC(6, 2),
    @Detalle VARCHAR(100),
    @Contacto VARCHAR(50),
    @ImporteBonificacion MONEY,
    @ImporteIva1 MONEY,
    @ImporteTotal MONEY,
    @SubNumero INT,
    @Aprobo INT,
    @IdMoneda INT,
    @FechaAprobacion DATETIME,
    @DetalleCondicionCompra VARCHAR(200),
    @ArchivoAdjunto1 VARCHAR(100),
    @ArchivoAdjunto2 VARCHAR(100),
    @ArchivoAdjunto3 VARCHAR(100),
    @ArchivoAdjunto4 VARCHAR(100),
    @ArchivoAdjunto5 VARCHAR(100),
    @ArchivoAdjunto6 VARCHAR(100),
    @ArchivoAdjunto7 VARCHAR(100),
    @ArchivoAdjunto8 VARCHAR(100),
    @ArchivoAdjunto9 VARCHAR(100),
    @ArchivoAdjunto10 VARCHAR(100),
    @IdPlazoEntrega INT,
    @CotizacionMoneda NUMERIC(18, 3),
    @CircuitoFirmasCompleto VARCHAR(2),
    @ConfirmadoPorWeb VARCHAR(2),
    @FechaCierreCompulsa DATETIME,
    @NombreUsuarioWeb NVARCHAR(256),
    @FechaRespuestaweb DATETIME
AS 
    IF ISNULL(@IdPresupuesto, 0) <= 0 
        BEGIN 
            INSERT  INTO Presupuestos
                    (
                      Numero,
                      IdProveedor,
                      FechaIngreso,
                      Observaciones,
                      Bonificacion,
                      Plazo,
                      validez,
                      IdCondicionCompra,
                      Garantia,
                      LugarEntrega,
                      IdComprador,
                      Referencia,
                      PorcentajeIva1,
                      PorcentajeIva2,
                      Detalle,
                      Contacto,
                      ImporteBonificacion,
                      ImporteIva1,
                      ImporteTotal,
                      SubNumero,
                      Aprobo,
                      IdMoneda,
                      FechaAprobacion,
                      DetalleCondicionCompra,
                      ArchivoAdjunto1,
                      ArchivoAdjunto2,
                      ArchivoAdjunto3,
                      ArchivoAdjunto4,
                      ArchivoAdjunto5,
                      ArchivoAdjunto6,
                      ArchivoAdjunto7,
                      ArchivoAdjunto8,
                      ArchivoAdjunto9,
                      ArchivoAdjunto10,
                      IdPlazoEntrega,
                      CotizacionMoneda,
                      CircuitoFirmasCompleto,
                      ConfirmadoPorWeb,
                      FechaCierreCompulsa,
                      NombreUsuarioWeb,
                      FechaRespuestaweb
			  )
            VALUES  (
                      @Numero,
                      @IdProveedor,
                      @FechaIngreso,
                      @Observaciones,
                      @Bonificacion,
                      @Plazo,
                      @validez,
                      @IdCondicionCompra,
                      @Garantia,
                      @LugarEntrega,
                      @IdComprador,
                      @Referencia,
                      @PorcentajeIva1,
                      @PorcentajeIva2,
                      @Detalle,
                      @Contacto,
                      @ImporteBonificacion,
                      @ImporteIva1,
                      @ImporteTotal,
                      @SubNumero,
                      @Aprobo,
                      @IdMoneda,
                      @FechaAprobacion,
                      @DetalleCondicionCompra,
                      @ArchivoAdjunto1,
                      @ArchivoAdjunto2,
                      @ArchivoAdjunto3,
                      @ArchivoAdjunto4,
                      @ArchivoAdjunto5,
                      @ArchivoAdjunto6,
                      @ArchivoAdjunto7,
                      @ArchivoAdjunto8,
                      @ArchivoAdjunto9,
                      @ArchivoAdjunto10,
                      @IdPlazoEntrega,
                      @CotizacionMoneda,
                      @CircuitoFirmasCompleto,
                      @ConfirmadoPorWeb,
                      @FechaCierreCompulsa,
                      @NombreUsuarioWeb,
                      @FechaRespuestaweb 
			  )
            SELECT  @IdPresupuesto = @@identity
            RETURN ( @IdPresupuesto )
        END
    ELSE 
        BEGIN
            UPDATE  Presupuestos
            SET     Numero = @Numero,
                    IdProveedor = @IdProveedor,
                    FechaIngreso = @FechaIngreso,
                    Observaciones = @Observaciones,
                    Bonificacion = @Bonificacion,
                    Plazo = @Plazo,
                    validez = @validez,
                    IdCondicionCompra = @IdCondicionCompra,
                    Garantia = @Garantia,
                    LugarEntrega = @LugarEntrega,
                    IdComprador = @IdComprador,
                    Referencia = @Referencia,
                    PorcentajeIva1 = @PorcentajeIva1,
                    PorcentajeIva2 = @PorcentajeIva2,
                    Detalle = @Detalle,
                    Contacto = @Contacto,
                    ImporteBonificacion = @ImporteBonificacion,
                    ImporteIva1 = @ImporteIva1,
                    ImporteTotal = @ImporteTotal,
                    SubNumero = @SubNumero,
                    Aprobo = @Aprobo,
                    IdMoneda = @IdMoneda,
                    FechaAprobacion = @FechaAprobacion,
                    DetalleCondicionCompra = @DetalleCondicionCompra,
                    ArchivoAdjunto1 = @ArchivoAdjunto1,
                    ArchivoAdjunto2 = @ArchivoAdjunto2,
                    ArchivoAdjunto3 = @ArchivoAdjunto3,
                    ArchivoAdjunto4 = @ArchivoAdjunto4,
                    ArchivoAdjunto5 = @ArchivoAdjunto5,
                    ArchivoAdjunto6 = @ArchivoAdjunto6,
                    ArchivoAdjunto7 = @ArchivoAdjunto7,
                    ArchivoAdjunto8 = @ArchivoAdjunto8,
                    ArchivoAdjunto9 = @ArchivoAdjunto9,
                    ArchivoAdjunto10 = @ArchivoAdjunto10,
                    IdPlazoEntrega = @IdPlazoEntrega,
                    CotizacionMoneda = @CotizacionMoneda,
                    CircuitoFirmasCompleto = @CircuitoFirmasCompleto,
                    ConfirmadoPorWeb = @ConfirmadoPorWeb,
                    FechaCierreCompulsa = @FechaCierreCompulsa,
                    NombreUsuarioWeb = @NombreUsuarioWeb,
                    FechaRespuestaweb = @FechaRespuestaweb
            WHERE   ( IdPresupuesto = @IdPresupuesto )
            RETURN ( @IdPresupuesto )
        END

GO


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].wPresupuestos_E')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wPresupuestos_E
go


CREATE PROCEDURE wPresupuestos_E @IdPresupuesto INT
AS 
    DELETE  Presupuestos
    WHERE   ( IdPresupuesto = @IdPresupuesto )
GO

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].wPresupuestos_T')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wPresupuestos_T
go


CREATE PROCEDURE wPresupuestos_T
    @IdPresupuesto INT = NULL
AS 
    SET @IdPresupuesto = ISNULL(@IdPresupuesto, -1)

    SELECT  *,
            Proveedores.RazonSocial AS [Proveedor]
    FROM    Presupuestos Cab
            LEFT OUTER JOIN Proveedores ON Cab.IdProveedor = Proveedores.IdProveedor
    WHERE   ( @IdPresupuesto = -1
              OR IdPresupuesto = @IdPresupuesto
            )
    ORDER BY idPresupuesto DESC

GO




-- exec Presupuestos_TT
-- exec wPresupuestos_T 3

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wPresupuestos_TT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wPresupuestos_TT]
go

CREATE  Procedure [dbo].[wPresupuestos_TT]

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1	
			(
			 IdPresupuesto INTEGER,
			 IdRequerimiento INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT DISTINCT
  dp.IdPresupuesto,
  dr.IdRequerimiento
 FROM DetallePresupuestos dp
 LEFT OUTER JOIN Presupuestos pr ON dp.IdPresupuesto=pr.IdPresupuesto
 LEFT OUTER JOIN DetalleRequerimientos dr ON dp.IdDetalleRequerimiento=dr.IdDetalleRequerimiento

SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111111111111111111133'
Set @vector_T='06003423355555553339500'

SELECT 
	Presupuestos.IdPresupuesto,
	Presupuestos.Numero as [Numero Presupuesto],
	Presupuestos.SubNumero as [Orden],
	Case 	When IsNull((Select Count(*) From #Auxiliar1 
				Where #Auxiliar1.IdPresupuesto=Presupuestos.IdPresupuesto),0)=0
		 Then Null
		When IsNull((Select Count(*) From #Auxiliar1 
				Where #Auxiliar1.IdPresupuesto=Presupuestos.IdPresupuesto),0)=1
		 Then Convert(varchar,
			IsNull((Select Top 1 Requerimientos.NumeroRequerimiento
				From #Auxiliar1
				Left Outer Join Requerimientos On #Auxiliar1.IdRequerimiento=Requerimientos.IdRequerimiento
				Where #Auxiliar1.IdPresupuesto=Presupuestos.IdPresupuesto),0))
		 Else 'Varias'
	End as [RM],
	Proveedores.RazonSocial as [Razon social], 
	Presupuestos.FechaIngreso as [Fecha], 
	Presupuestos.Validez as [Validez],
	Presupuestos.Bonificacion as [Bonificacion],
	Presupuestos.Plazo as [Plazo],
	[Condiciones Compra].Descripcion as [Cond. de compra],
	Presupuestos.Garantia as [Garantia],
	Presupuestos.LugarEntrega as [LugarEntrega],
	Empleados.Nombre as [Comprador],
	Presupuestos.Referencia as [Referencia],
	Presupuestos.Detalle as [Detalle],
	Presupuestos.Contacto as [Contacto],
	Presupuestos.ImporteBonificacion as [Bonificacion],
	Presupuestos.ImporteIva1 as [Iva],
	Presupuestos.ImporteTotal as [Total],
	Presupuestos.IdPresupuesto as [IdAux],
	Presupuestos.Aprobo,
	presupuestos.ConfirmadoPorWeb,
	(Select Count(*) From DetallePresupuestos dp 
	 Where dp.IdPresupuesto=Presupuestos.IdPresupuesto) as [Cant.Items],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM Presupuestos
LEFT OUTER JOIN Proveedores ON Presupuestos.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN [Condiciones Compra] ON Presupuestos.IdCondicionCompra = [Condiciones Compra].IdCondicionCompra
LEFT OUTER JOIN Empleados ON Presupuestos.IdComprador = Empleados.IdEmpleado
ORDER BY Presupuestos.FechaIngreso Desc, 
	Presupuestos.Numero Desc, 
	Presupuestos.SubNumero Desc

DROP TABLE #Auxiliar1

GO

--EXEC dbo.wPresupuestos_TT


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--DETALLE
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////




IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].wDetPresupuestos_A')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wDetPresupuestos_A
go



CREATE PROCEDURE wDetPresupuestos_A
    @IdDetallePresupuesto INT ,
    @IdPresupuesto INT,
    @NumeroItem INT,
    @IdArticulo INT,
    @Cantidad NUMERIC(12, 2),
    @IdUnidad INT,
    @Precio NUMERIC(12, 4),
    @Adjunto VARCHAR(2),
    @ArchivoAdjunto VARCHAR(50),
    @Cantidad1 NUMERIC(18, 2),
    @Cantidad2 NUMERIC(18, 2),
    @Observaciones NTEXT,
    @IdDetalleAcopios INT,
    @IdDetalleRequerimiento INT,
    @OrigenDescripcion INT,
    @IdDetalleLMateriales INT,
    @IdCuenta INT,
    @ArchivoAdjunto1 VARCHAR(100),
    @ArchivoAdjunto2 VARCHAR(100),
    @ArchivoAdjunto3 VARCHAR(100),
    @ArchivoAdjunto4 VARCHAR(100),
    @ArchivoAdjunto5 VARCHAR(100),
    @ArchivoAdjunto6 VARCHAR(100),
    @ArchivoAdjunto7 VARCHAR(100),
    @ArchivoAdjunto8 VARCHAR(100),
    @ArchivoAdjunto9 VARCHAR(100),
    @ArchivoAdjunto10 VARCHAR(100),
    @FechaEntrega DATETIME,
    @IdCentroCosto INT,
    @PorcentajeBonificacion NUMERIC(6, 2),
    @ImporteBonificacion NUMERIC(18, 4),
    @PorcentajeIVA NUMERIC(6, 2),
    @ImporteIVA NUMERIC(18, 4),
    @ImporteTotalItem NUMERIC(18, 4)
AS 
    IF ISNULL(@IdDetallePresupuesto, 0) <= 0 
        BEGIN   
            INSERT  INTO [DetallePresupuestos]
                    (
                      IdPresupuesto,
                      NumeroItem,
                      IdArticulo,
                      Cantidad,
                      IdUnidad,
                      Precio,
                      Adjunto,
                      ArchivoAdjunto,
                      Cantidad1,
                      Cantidad2,
                      Observaciones,
                      IdDetalleAcopios,
                      IdDetalleRequerimiento,
                      OrigenDescripcion,
                      IdDetalleLMateriales,
                      IdCuenta,
                      ArchivoAdjunto1,
                      ArchivoAdjunto2,
                      ArchivoAdjunto3,
                      ArchivoAdjunto4,
                      ArchivoAdjunto5,
                      ArchivoAdjunto6,
                      ArchivoAdjunto7,
                      ArchivoAdjunto8,
                      ArchivoAdjunto9,
                      ArchivoAdjunto10,
                      FechaEntrega,
                      IdCentroCosto,
                      PorcentajeBonificacion,
                      ImporteBonificacion,
                      PorcentajeIVA,
                      ImporteIVA,
                      ImporteTotalItem
		        )
            VALUES  (
                      @IdPresupuesto,
                      @NumeroItem,
                      @IdArticulo,
                      @Cantidad,
                      @IdUnidad,
                      @Precio,
                      @Adjunto,
                      @ArchivoAdjunto,
                      @Cantidad1,
                      @Cantidad2,
                      @Observaciones,
                      @IdDetalleAcopios,
                      @IdDetalleRequerimiento,
                      @OrigenDescripcion,
                      @IdDetalleLMateriales,
                      @IdCuenta,
                      @ArchivoAdjunto1,
                      @ArchivoAdjunto2,
                      @ArchivoAdjunto3,
                      @ArchivoAdjunto4,
                      @ArchivoAdjunto5,
                      @ArchivoAdjunto6,
                      @ArchivoAdjunto7,
                      @ArchivoAdjunto8,
                      @ArchivoAdjunto9,
                      @ArchivoAdjunto10,
                      @FechaEntrega,
                      @IdCentroCosto,
                      @PorcentajeBonificacion,
                      @ImporteBonificacion,
                      @PorcentajeIVA,
                      @ImporteIVA,
                      @ImporteTotalItem
		        )
            SELECT  @IdDetallePresupuesto = @@identity
            RETURN ( @IdDetallePresupuesto )

        END 
    ELSE 
        BEGIN
            UPDATE  [DetallePresupuestos]
            SET     IdPresupuesto = @IdPresupuesto,
                    NumeroItem = @NumeroItem,
                    IdArticulo = @IdArticulo,
                    Cantidad = @Cantidad,
                    IdUnidad = @IdUnidad,
                    Precio = @Precio,
                    Adjunto = @Adjunto,
                    ArchivoAdjunto = @ArchivoAdjunto,
                    Cantidad1 = @Cantidad1,
                    Cantidad2 = @Cantidad2,
                    Observaciones = @Observaciones,
                    IdDetalleAcopios = @IdDetalleAcopios,
                    IdDetalleRequerimiento = @IdDetalleRequerimiento,
                    OrigenDescripcion = @OrigenDescripcion,
                    IdDetalleLMateriales = @IdDetalleLMateriales,
                    IdCuenta = @IdCuenta,
                    ArchivoAdjunto1 = @ArchivoAdjunto1,
                    ArchivoAdjunto2 = @ArchivoAdjunto2,
                    ArchivoAdjunto3 = @ArchivoAdjunto3,
                    ArchivoAdjunto4 = @ArchivoAdjunto4,
                    ArchivoAdjunto5 = @ArchivoAdjunto5,
                    ArchivoAdjunto6 = @ArchivoAdjunto6,
                    ArchivoAdjunto7 = @ArchivoAdjunto7,
                    ArchivoAdjunto8 = @ArchivoAdjunto8,
                    ArchivoAdjunto9 = @ArchivoAdjunto9,
                    ArchivoAdjunto10 = @ArchivoAdjunto10,
                    FechaEntrega = @FechaEntrega,
                    IdCentroCosto = @IdCentroCosto,
                    PorcentajeBonificacion = @PorcentajeBonificacion,
                    ImporteBonificacion = @ImporteBonificacion,
                    PorcentajeIVA = @PorcentajeIVA,
                    ImporteIVA = @ImporteIVA,
                    ImporteTotalItem = @ImporteTotalItem
            WHERE   ( IdDetallePresupuesto = @IdDetallePresupuesto )
            RETURN ( @IdDetallePresupuesto )

        END 


GO




--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].wDetPresupuestos_E')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wDetPresupuestos_E
go



CREATE PROCEDURE wDetPresupuestos_E
    @IdDetallePresupuesto INT
AS 
    DELETE  [DetallePresupuestos]
    WHERE   ( IdDetallePresupuesto = @IdDetallePresupuesto )

go


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].wDetPresupuestos_T')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wDetPresupuestos_T
go

CREATE PROCEDURE wDetPresupuestos_T
    @IdDetallePresupuesto INT
AS 
    SELECT  *
    FROM    [DetallePresupuestos]
    WHERE   ( IdDetallePresupuesto = @IdDetallePresupuesto )
GO

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetPresupuestos_TT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetPresupuestos_TT]
go


CREATE PROCEDURE [dbo].[wDetPresupuestos_TT] @IdPresupuesto INT
AS 
    SELECT  Det.*,
            Articulos.Descripcion AS [Articulo]
    FROM    DetallePresupuestos Det --LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento=DetReq.IdRequerimiento
            LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
--LEFT OUTER JOIN CuentasGastos ON (Det.IdCuentaGasto = CuentasGastos.IdCuentaGasto)
--LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
--LEFT OUTER JOIN Obras ON Cab.IdObra = Obras.IdObra
--LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
--LEFT OUTER JOIN Equipos ON DetReq.IdEquipo = Equipos.IdEquipo
--LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
--LEFT OUTER JOIN ControlesCalidad ON DetReq.IdControlCalidad = ControlesCalidad.IdControlCalidad
--LEFT OUTER JOIN Empleados E1 ON Requerimientos.Aprobo = E1.IdEmpleado
--LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
--LEFT OUTER JOIN Empleados E3 ON Requerimientos.IdComprador = E3.IdEmpleado
--LEFT OUTER JOIN Proveedores ON DetReq.IdProveedor = Proveedores.IdProveedor
    WHERE   IdPresupuesto = @IdPresupuesto 


go

/*

exec dbo.[wDetPresupuestos_TT] 81
exec dbo.wComprobantesProveedores_TX_FondosFijos
exec dbo.wDetComprobantesProveedores_TT 81

select * from obras
exec dbo.wCuentas_TX_CuentasGastoPorObraParaCombo 1
exec dbo.wCuentas_TX_CuentasGastoPorObraParaCombo 2
exec dbo.wCuentas_TX_CuentasGastoPorObraParaCombo 3
exec dbo.wCuentas_TX_CuentasGastoPorObraParaCombo 4
exec dbo.wCuentas_TX_CuentasGastoPorObraParaCombo 5
exec dbo.wCuentas_TX_CuentasGastoPorObraParaCombo 6

exec dbo.CuentasGastos_TL

exec dbo.CuentasGastos_TX_PorCodigo
exec dbo.CuentasGastos_TX_PorCodigo2 

select * from cuentasGastos
*/


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCondicionesCompra_TL]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wCondicionesCompra_TL]
go


CREATE PROCEDURE [dbo].[wCondicionesCompra_TL]
AS 
    SELECT  IdCondicionCompra,
            Descripcion AS [Titulo]
    FROM    [Condiciones Compra]
    ORDER BY Descripcion
go

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wMonedas_TL]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wMonedas_TL]
go


CREATE PROCEDURE [dbo].[wMonedas_TL]
AS 
    SELECT  IdMoneda,
            Nombre AS [Titulo]
    FROM    Monedas
    ORDER BY Nombre
go

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wPlazosEntrega_TL]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wPlazosEntrega_TL]
go

CREATE PROCEDURE [dbo].[wPlazosEntrega_TL]
AS 
    SELECT  IdPlazoEntrega,
            Descripcion AS Titulo
    FROM    PlazosEntrega
    ORDER BY Descripcion
go



--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wProveedores_TX_PorCuit]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wProveedores_TX_PorCuit]
go

CREATE PROCEDURE [dbo].[wProveedores_TX_PorCuit] @Cuit VARCHAR(13)
AS 
    SELECT  *
    FROM    Proveedores
    WHERE   Cuit = @Cuit
go

/*
select IdCodigoIva,* from proveedores
*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

--select * from articulos
--select * from presupuestos
--exec wProveedores_TX_PorCuit @Cuit='20000000001'



--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wPresupuestos_TX_PorNumero]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wPresupuestos_TX_PorNumero]
go

CREATE PROCEDURE [dbo].[wPresupuestos_TX_PorNumero] @Numero INT
--,@SubNumero int
AS 
    SELECT  Presupuestos.*,
            PlazosEntrega.Descripcion AS [PlazoEntrega]
    FROM    Presupuestos
            LEFT OUTER JOIN PlazosEntrega ON PlazosEntrega.IdPlazoEntrega = Presupuestos.IdPlazoEntrega
    WHERE   Numero = @Numero
 --AND SubNumero=@SubNumero
go


--exec [wPresupuestos_TX_PorNumero] 4

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--			Originales de INFOPROV de Fido
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[ProntoWeb_CargaTodosLosUsuarios]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [ProntoWeb_CargaTodosLosUsuarios]
go

CREATE PROCEDURE [dbo].[ProntoWeb_CargaTodosLosUsuarios]
AS 
    DELETE  FROM EmpresasPorUsuario

    INSERT  INTO EmpresasPorUsuario ( Usuario, Empresa )
            SELECT  Cuit,
                    'Pronto'
            FROM    DemoPronto.dbo.Proveedores
            WHERE   NOT Cuit IS NULL
                    AND Cuit <> ''
GO



--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[ProntoWeb_CargaComprobantes]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [ProntoWeb_CargaComprobantes]
go

CREATE PROCEDURE [dbo].[ProntoWeb_CargaComprobantes]
AS 
    IF EXISTS ( SELECT  *
                FROM    sysobjects
                WHERE   name = '#Auxiliar1'
                        AND xtype = 'U' ) 
        DROP TABLE [#Auxiliar1] ;

    IF EXISTS ( SELECT  *
                FROM    sysobjects
                WHERE   name = '#Auxiliar2'
                        AND xtype = 'U' ) 
        DROP TABLE [#Auxiliar2] ;

    SET NOCOUNT ON ;

    DECLARE @IdTipoComprobanteOrdenPago INT ;

    SET @IdTipoComprobanteOrdenPago = ( SELECT TOP 1
                                                Parametros.IdTipoComprobanteOrdenPago
                                        FROM    Parametros
                                        WHERE   Parametros.IdParametro = 1
                                      ) ;

    CREATE TABLE #Auxiliar1
        (
          IdCtaCte INTEGER,
          IdProveedor INTEGER,
          IdTipoComprobante INTEGER,
          TipoComprobante VARCHAR(5),
          IdComprobante INTEGER,
          NumeroComprobante VARCHAR(30),
          Referencia INTEGER,
          Fecha DATETIME,
          ImporteTotal NUMERIC(18, 2)
        ) ;			

    INSERT  INTO #Auxiliar1
            SELECT  CtaCte.IdCtaCte,
                    CtaCte.IdProveedor,
                    CASE WHEN CtaCte.IdTipoComp = 16
                         THEN @IdTipoComprobanteOrdenPago
                         ELSE CtaCte.IdTipoComp
                    END,
                    TiposComprobante.DescripcionAB,
                    CtaCte.IdComprobante,
                    CASE WHEN CtaCte.IdTipoComp = @IdTipoComprobanteOrdenPago
                              OR CtaCte.IdTipoComp = 16
                         THEN SUBSTRING(SUBSTRING('00000000', 1,
                                                  8
                                                  - LEN(CONVERT(VARCHAR, CtaCte.NumeroComprobante)))
                                        + CONVERT(VARCHAR, CtaCte.NumeroComprobante),
                                        1, 15)
                         ELSE SUBSTRING(cp.Letra + '-' + SUBSTRING('0000', 1, 4 - LEN(CONVERT(VARCHAR, cp.NumeroComprobante1)))
                                        + CONVERT(VARCHAR, cp.NumeroComprobante1)
                                        + '-' + SUBSTRING('00000000', 1,
                                                          8
                                                          - LEN(CONVERT(VARCHAR, cp.NumeroComprobante2)))
                                        + CONVERT(VARCHAR, cp.NumeroComprobante2),
                                        1, 15)
                    END,
                    CtaCte.NumeroComprobante,
                    CtaCte.Fecha,
                    CtaCte.ImporteTotal * TiposComprobante.Coeficiente
            FROM    CuentasCorrientesAcreedores CtaCte
                    LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = CtaCte.IdTipoComp
                    LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = CtaCte.IdComprobante
 --WHERE CtaCte.IdProveedor=@IdProveedor and (@Todo=-1 or CtaCte.Fecha<=@FechaLimite)
;

    UPDATE  #Auxiliar1
    SET     NumeroComprobante = '00000000'
    WHERE   NumeroComprobante IS NULL ;

    CREATE TABLE #Auxiliar2
        (
          IdCtaCte INTEGER,
          IdProveedor INTEGER,
          IdTipoComprobante INTEGER,
          TipoComprobante VARCHAR(5),
          IdComprobante INTEGER,
          NumeroComprobante VARCHAR(30),
          Referencia INTEGER,
          Fecha DATETIME,
          ImporteTotal NUMERIC(18, 2),
          Saldo NUMERIC(18, 2)
        ) ;
			
    INSERT  INTO #Auxiliar2
            SELECT  MAX(#Auxiliar1.IdCtaCte),
                    #Auxiliar1.IdProveedor,
                    #Auxiliar1.IdTipoComprobante,
                    MAX(#Auxiliar1.TipoComprobante),
                    #Auxiliar1.IdComprobante,
                    MAX(#Auxiliar1.NumeroComprobante),
                    MAX(#Auxiliar1.Referencia),
                    MAX(#Auxiliar1.Fecha),
                    SUM(#Auxiliar1.ImporteTotal),
                    0
            FROM    #Auxiliar1
            GROUP BY #Auxiliar1.IdProveedor,
                    #Auxiliar1.IdTipoComprobante,
                    #Auxiliar1.IdComprobante ;

    SET NOCOUNT OFF ;

    SELECT  #Auxiliar2.IdProveedor,
            #Auxiliar2.TipoComprobante,
            #Auxiliar2.NumeroComprobante,
            #Auxiliar2.Referencia,
            #Auxiliar2.Fecha,
            CASE WHEN #Auxiliar2.ImporteTotal < 0
                 THEN #Auxiliar2.ImporteTotal * -1
                 ELSE NULL
            END AS [Debe],
            CASE WHEN #Auxiliar2.ImporteTotal >= 0
                 THEN #Auxiliar2.ImporteTotal
                 ELSE NULL
            END AS [Haber],
            CASE WHEN #Auxiliar2.IdTipoComprobante = @IdTipoComprobanteOrdenPago
                      OR #Auxiliar2.IdTipoComprobante = 16 THEN NULL
                 ELSE cp.FechaComprobante
            END AS [FechaComprobante],
            CASE WHEN #Auxiliar2.IdTipoComprobante = @IdTipoComprobanteOrdenPago
                 THEN ISNULL(CONVERT(VARCHAR(1000), OrdenesPago.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS),
                             '')
                 ELSE ISNULL(CONVERT(VARCHAR(1000), cp.Observaciones), '')
            END AS [Observaciones]
    FROM    #Auxiliar2
            LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = #Auxiliar2.IdTipoComprobante
            LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = #Auxiliar2.IdComprobante
            LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago = #Auxiliar2.IdComprobante
    ORDER BY #Auxiliar2.IdProveedor,
            #Auxiliar2.Fecha,
            #Auxiliar2.NumeroComprobante ;

/* Estructura de la tabla destino
CREATE TABLE #Auxiliar2
			(
			 IdProveedor INTEGER,
			 TipoComprobante VARCHAR(5),
			 NumeroComprobante VARCHAR(30),
			 Referencia INTEGER,
			 Fecha DATETIME,
			 Debe NUMERIC(18,2),
			 Haber NUMERIC(18,2),
			 FechaComprobante DATETIME,
			 Observaciones VARCHAR(1000)
			)
*/
    DROP TABLE #Auxiliar1 ;
    DROP TABLE #Auxiliar2

GO



--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[ProntoWeb_CargaOrdenesPagoEnCaja]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [ProntoWeb_CargaOrdenesPagoEnCaja]
go



CREATE PROCEDURE [dbo].[ProntoWeb_CargaOrdenesPagoEnCaja]
AS 
    DECLARE @vector_X VARCHAR(50),
        @vector_T VARCHAR(50)
    SET @vector_X = '001111111116666666666616133'
    SET @vector_T = '004904122213333323233362200'

    SELECT  op.IdOrdenPago,
            op.IdOPComplementariaFF,
            op.NumeroOrdenPago AS [Orden en caja],
            op.IdOrdenPago AS [IdOP],
            CASE WHEN op.Exterior = 'SI' THEN 'PE'
                 ELSE NULL
            END AS [Cod],
            op.FechaOrdenPago AS [Fecha Pago],
            CASE WHEN op.Tipo = 'CC' THEN 'Cta. cte.'
                 WHEN op.Tipo = 'FF' THEN 'F. fijo'
                 WHEN op.Tipo = 'OT' THEN 'Otros'
                 ELSE ''
            END AS [Tipo],
            CASE WHEN op.Anulada = 'SI' THEN 'Anulada'
                 ELSE CASE WHEN op.Tipo = 'CC'
                           THEN CASE WHEN op.Estado = 'CA' THEN 'En caja'
                                     WHEN op.Estado = 'FI' THEN 'A la firma'
                                     WHEN op.Estado = 'EN' THEN 'Entregado'
                                     ELSE ''
                                END
                           ELSE ''
                      END
            END AS [Estado],
            Proveedores.IdProveedor AS [IdProveedor],
            Cuentas.Descripcion AS [Cuenta],
            Monedas.Abreviatura AS [Mon.],
            CASE WHEN op.Efectivo = 0 THEN NULL
                 ELSE op.Efectivo
            END AS [Efectivo],
            CASE WHEN op.Descuentos = 0 THEN NULL
                 ELSE op.Descuentos
            END AS [Descuentos],
            CASE WHEN op.Valores = 0 THEN NULL
                 ELSE op.Valores
            END AS [Valores],
            op.Documentos,
            op.Acreedores,
            op.RetencionIVA AS [Ret.IVA],
            op.RetencionGanancias AS [Ret.gan.],
            op.RetencionIBrutos AS [Ret.ing.b.],
            op.RetencionSUSS AS [Ret.SUSS],
            op.GastosGenerales AS [Dev.F.F.],
            CASE WHEN op.Tipo = 'OT' THEN NULL
                 ELSE op.DiferenciaBalanceo
            END AS [Dif. Balanceo],
            ( SELECT TOP 1
                        OrdenesPago.NumeroOrdenPago
              FROM      OrdenesPago
              WHERE     OrdenesPago.IdOrdenPago = op.IdOPComplementariaFF
            ) AS [OP complem. FF],
            op.CotizacionDolar AS [Cotiz. dolar],
            Empleados.Nombre AS [Destinatario fondo fijo],
            @Vector_T AS Vector_T,
            @Vector_X AS Vector_X
    FROM    OrdenesPago op
            LEFT OUTER JOIN Proveedores ON op.IdProveedor = Proveedores.IdProveedor
            LEFT OUTER JOIN Cuentas ON op.IdCuenta = Cuentas.IdCuenta
            LEFT OUTER JOIN Empleados ON op.IdEmpleadoFF = Empleados.IdEmpleado
            LEFT OUTER JOIN Monedas ON op.IdMoneda = Monedas.IdMoneda
    WHERE   op.Estado = 'CA'
            AND ( op.Anulada IS NULL
                  OR op.Anulada <> 'SI'
                )
            AND ( op.Confirmado IS NULL
                  OR op.Confirmado <> 'NO'
                )
    ORDER BY op.FechaOrdenPago,
            op.NumeroOrdenPago



GO

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[ProntoWeb_TodosLosUsuarios]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE ProntoWeb_TodosLosUsuarios
go


CREATE PROCEDURE ProntoWeb_TodosLosUsuarios
AS 
    SELECT  Email,
            Cuit,
            IdProveedor,
            RazonSocial
    FROM    DemoPronto.DBO.Proveedores
    WHERE   ( NOT ( Email IS NULL )
            )
            AND ( NOT ( Cuit IS NULL )
                )
            AND ( NOT ( IdProveedor IS NULL )
                )
            AND ( NOT ( Email = '' )
                )
            AND ( NOT ( Cuit = '' )
                )
    ORDER BY cuit
GO


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[ProntoWeb_CargaTablas]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [ProntoWeb_CargaTablas]
go



CREATE PROCEDURE [dbo].[ProntoWeb_CargaTablas]
AS 
    IF EXISTS ( SELECT  *
                FROM    dbo.sysobjects
                WHERE   id = OBJECT_ID(N'[dbo].[OrdenesPagoEnCaja]')
                        AND OBJECTPROPERTY(id, N'IsUserTable') = 1 ) 
        DROP TABLE [dbo].[OrdenesPagoEnCaja]


    CREATE TABLE [dbo].[OrdenesPagoEnCaja]
        (
          [IdOrdenPago] [int] NOT NULL,
          [IdOPComplementariaFF] [int] NULL,
          [Orden en caja] [int] NULL,
          [IdOP] [int] NULL,
          [Cod] [varchar](2) COLLATE Modern_Spanish_CI_AS
                             NULL,
          [Fecha Pago] [datetime] NULL,
          [Tipo] [varchar](9) COLLATE Modern_Spanish_CI_AS
                              NULL,
          [Estado] [varchar](10) COLLATE Modern_Spanish_CI_AS
                                 NULL,
          [IdProveedor] [int] NULL,
          [Cuenta] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS
                                 NULL,
          [Mon.] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS
                               NULL,
          [Efectivo] [numeric](18, 2) NULL,
          [Descuentos] [numeric](18, 2) NULL,
          [Valores] [numeric](18, 2) NULL,
          [Documentos] [numeric](18, 2) NULL,
          [Acreedores] [numeric](18, 2) NULL,
          [Ret.IVA] [numeric](18, 2) NULL,
          [Ret.gan.] [numeric](18, 2) NULL,
          [Ret.ing.b.] [numeric](18, 2) NULL,
          [Ret.SUSS] [numeric](18, 2) NULL,
          [Dev.F.F.] [numeric](18, 2) NULL,
          [Dif. Balanceo] [numeric](18, 2) NULL,
          [OP complem. FF] [int] NULL,
          [Cotiz. dolar] [numeric](18, 4) NULL,
          [Destinatario fondo fijo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS
                                                  NULL,
          [Vector_T] [varchar](50) COLLATE Modern_Spanish_CI_AS
                                   NULL,
          [Vector_X] [varchar](50) COLLATE Modern_Spanish_CI_AS
                                   NULL
        )
    ON  [PRIMARY]

    INSERT  INTO OrdenesPagoEnCaja
            EXEC ProntoWeb_CargaOrdenesPagoEnCaja

    IF EXISTS ( SELECT  *
                FROM    dbo.sysobjects
                WHERE   id = OBJECT_ID(N'[dbo].[Comprobantes]')
                        AND OBJECTPROPERTY(id, N'IsUserTable') = 1 ) 
        DROP TABLE [dbo].[Comprobantes]

    CREATE TABLE [dbo].[Comprobantes]
        (
          [IdComprobante] [bigint] IDENTITY(1, 1)
                                   NOT NULL,
          [IdProveedor] [int] NULL,
          [TipoComprobante] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS
                                         NULL,
          [NumeroComprobante] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS
                                            NULL,
          [Referencia] [int] NULL,
          [Fecha] [datetime] NULL,
          [Debe] [numeric](18, 2) NULL,
          [Haber] [numeric](18, 2) NULL,
          [FechaComprobante] [datetime] NULL,
          [Observaciones] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS
                                          NULL
        )
    ON  [PRIMARY]

    INSERT  INTO Comprobantes
            EXEC ProntoWeb_CargaComprobantes
    EXEC ProntoWeb_TodosLosUsuarios
    EXEC ProntoWeb_CargaTodosLosUsuarios


GO


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[ProntoWeb_DebeHaberSaldo]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [ProntoWeb_DebeHaberSaldo]
go


CREATE PROCEDURE [dbo].[ProntoWeb_DebeHaberSaldo] @IdProveedor INT
AS 
    SET NOCOUNT ON
 
    DECLARE @IdTipoComprobanteOrdenPago INT
    SET @IdTipoComprobanteOrdenPago = 17
 
    CREATE TABLE #Auxiliar1
        (
          IdCtaCte INTEGER,
          IdProveedor INTEGER,
          IdTipoComprobante INTEGER,
          TipoComprobante VARCHAR(5),
          IdComprobante INTEGER,
          NumeroComprobante VARCHAR(15),
          Referencia INTEGER,
          Fecha DATETIME,
          ImporteTotal NUMERIC(18, 2)
        )
    INSERT  INTO #Auxiliar1
            SELECT  CtaCte.IdCtaCte,
                    CtaCte.IdProveedor,
                    CASE WHEN CtaCte.IdTipoComp = 16
                         THEN @IdTipoComprobanteOrdenPago
                         ELSE CtaCte.IdTipoComp
                    END,
                    TiposComprobante.DescripcionAB,
                    CtaCte.IdComprobante,
                    CASE WHEN CtaCte.IdTipoComp = @IdTipoComprobanteOrdenPago
                              OR CtaCte.IdTipoComp = 16
                              OR cp.IdComprobanteProveedor IS NULL
                         THEN SUBSTRING(SUBSTRING('00000000', 1,
                                                  8
                                                  - LEN(CONVERT(VARCHAR, CtaCte.NumeroComprobante)))
                                        + CONVERT(VARCHAR, CtaCte.NumeroComprobante),
                                        1, 15)
                         ELSE SUBSTRING(cp.Letra + '-' + SUBSTRING('0000', 1, 4 - LEN(CONVERT(VARCHAR, cp.NumeroComprobante1)))
                                        + CONVERT(VARCHAR, cp.NumeroComprobante1)
                                        + '-' + SUBSTRING('00000000', 1,
                                                          8
                                                          - LEN(CONVERT(VARCHAR, cp.NumeroComprobante2)))
                                        + CONVERT(VARCHAR, cp.NumeroComprobante2),
                                        1, 15)
                    END,
                    CtaCte.NumeroComprobante,
                    CtaCte.Fecha,
                    CtaCte.ImporteTotal * TiposComprobante.Coeficiente
            FROM    CuentasCorrientesAcreedores CtaCte
                    LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = CtaCte.IdTipoComp
                    LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = CtaCte.IdComprobante
            WHERE   CtaCte.IdProveedor = @IdProveedor
 
    UPDATE  #Auxiliar1
    SET     NumeroComprobante = '00000000'
    WHERE   NumeroComprobante IS NULL
 
    CREATE TABLE #Auxiliar2
        (
          IdCtaCte INTEGER,
          IdTipoComprobante INTEGER,
          TipoComprobante VARCHAR(5),
          IdComprobante INTEGER,
          NumeroComprobante VARCHAR(15),
          Referencia INTEGER,
          Fecha DATETIME,
          ImporteTotal NUMERIC(18, 2),
          Saldo NUMERIC(18, 2)
        )
    CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 ( Fecha, NumeroComprobante, IdComprobante )
    ON  [PRIMARY]
    INSERT  INTO #Auxiliar2
            SELECT  MAX(#Auxiliar1.IdCtaCte),
                    #Auxiliar1.IdTipoComprobante,
                    MAX(#Auxiliar1.TipoComprobante),
                    #Auxiliar1.IdComprobante,
                    #Auxiliar1.NumeroComprobante,
                    MAX(#Auxiliar1.Referencia),
                    MAX(#Auxiliar1.Fecha),
                    SUM(#Auxiliar1.ImporteTotal),
                    0
            FROM    #Auxiliar1
            GROUP BY #Auxiliar1.IdTipoComprobante,
                    #Auxiliar1.IdComprobante,
                    #Auxiliar1.NumeroComprobante
 
/*  CURSOR  */
    DECLARE @Fecha DATETIME,
        @NumeroComprobante VARCHAR(15),
        @IdComprobante INT,
        @ImporteTotal NUMERIC(18, 2),
        @Saldo NUMERIC(18, 2)
    SET @Saldo = 0
    DECLARE Cur CURSOR LOCAL FORWARD_ONLY
        FOR SELECT  Fecha,
                    NumeroComprobante,
                    IdComprobante,
                    ImporteTotal
            FROM    #Auxiliar2
            ORDER BY Fecha,
                    NumeroComprobante,
                    IdComprobante
    OPEN Cur
    FETCH NEXT FROM Cur INTO @Fecha, @NumeroComprobante, @IdComprobante,
        @ImporteTotal
    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @Saldo = @Saldo + ( @ImporteTotal * -1 )
            UPDATE  #Auxiliar2
            SET     Saldo = @Saldo
            WHERE CURRENT OF Cur
            FETCH NEXT FROM Cur INTO @Fecha, @NumeroComprobante,
                @IdComprobante, @ImporteTotal
        END
    CLOSE Cur
    DEALLOCATE Cur
 
    SET NOCOUNT OFF
 
    SELECT  #Auxiliar2.IdCtaCte,
            #Auxiliar2.TipoComprobante AS [TipoComprobante],
            #Auxiliar2.IdTipoComprobante,
            #Auxiliar2.IdComprobante,
            #Auxiliar2.NumeroComprobante AS [NumeroComprobante],
            #Auxiliar2.Referencia AS [Ref.],
            #Auxiliar2.Fecha AS FechaParaOrden,
            CONVERT(CHAR(10), #Auxiliar2.Fecha, 103) AS Fecha,
            #Auxiliar2.ImporteTotal * -1 AS [Imp.orig.],
            CASE WHEN #Auxiliar2.ImporteTotal < 0
                 THEN #Auxiliar2.ImporteTotal * -1
                 ELSE NULL
            END AS [Debe],
            CASE WHEN #Auxiliar2.ImporteTotal >= 0
                 THEN #Auxiliar2.ImporteTotal
                 ELSE NULL
            END AS [Haber],
            #Auxiliar2.Saldo AS [Saldo],
            CASE WHEN #Auxiliar2.IdTipoComprobante = @IdTipoComprobanteOrdenPago
                      OR #Auxiliar2.IdTipoComprobante = 16 THEN NULL
                 ELSE CONVERT(CHAR(10), cp.FechaComprobante, 103)
            END AS [FechaComprobante],
            CASE WHEN #Auxiliar2.IdTipoComprobante = @IdTipoComprobanteOrdenPago
                 THEN ISNULL(CONVERT(VARCHAR(1000), OrdenesPago.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS),
                             '')
                 ELSE ISNULL(CONVERT(VARCHAR(1000), cp.Observaciones), '')
            END AS [Observaciones]
    FROM    #Auxiliar2
            LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = #Auxiliar2.IdTipoComprobante
            LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = #Auxiliar2.IdComprobante
                                                          AND #Auxiliar2.IdTipoComprobante <> @IdTipoComprobanteOrdenPago
                                                          AND #Auxiliar2.IdTipoComprobante <> 16
            LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago = #Auxiliar2.IdComprobante
                                           AND ( #Auxiliar2.IdTipoComprobante = @IdTipoComprobanteOrdenPago
                                                 OR #Auxiliar2.IdTipoComprobante = 16
                                               )
    ORDER BY FechaParaOrden DESC,
            #Auxiliar2.NumeroComprobante
 
    DROP TABLE #Auxiliar1
    DROP TABLE #Auxiliar2



GO


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[ProntoWeb_OrdenesPagoEnCaja]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [ProntoWeb_OrdenesPagoEnCaja]
go




CREATE PROCEDURE [dbo].[ProntoWeb_OrdenesPagoEnCaja]
AS 
    DECLARE @vector_X VARCHAR(50),
        @vector_T VARCHAR(50)
    SET @vector_X = '001111111116666666666616133'
    SET @vector_T = '004904122213333323233362200'

    SELECT  op.IdOrdenPago,
            op.IdOPComplementariaFF,
            op.NumeroOrdenPago AS [Orden en caja],
            op.IdOrdenPago AS [IdOP],
            CASE WHEN op.Exterior = 'SI' THEN 'PE'
                 ELSE NULL
            END AS [Cod],
            op.FechaOrdenPago AS [Fecha Pago],
            CASE WHEN op.Tipo = 'CC' THEN 'Cta. cte.'
                 WHEN op.Tipo = 'FF' THEN 'F. fijo'
                 WHEN op.Tipo = 'OT' THEN 'Otros'
                 ELSE ''
            END AS [Tipo],
            CASE WHEN op.Anulada = 'SI' THEN 'Anulada'
                 ELSE CASE WHEN op.Tipo = 'CC'
                           THEN CASE WHEN op.Estado = 'CA' THEN 'En caja'
                                     WHEN op.Estado = 'FI' THEN 'A la firma'
                                     WHEN op.Estado = 'EN' THEN 'Entregado'
                                     ELSE ''
                                END
                           ELSE ''
                      END
            END AS [Estado],
            Proveedores.IdProveedor AS [IdProveedor],
            Cuentas.Descripcion AS [Cuenta],
            Monedas.Abreviatura AS [Mon.],
            CASE WHEN op.Efectivo = 0 THEN NULL
                 ELSE op.Efectivo
            END AS [Efectivo],
            CASE WHEN op.Descuentos = 0 THEN NULL
                 ELSE op.Descuentos
            END AS [Descuentos],
            CASE WHEN op.Valores = 0 THEN NULL
                 ELSE op.Valores
            END AS [Valores],
            op.Documentos,
            op.Acreedores,
            op.RetencionIVA AS [Ret.IVA],
            op.RetencionGanancias AS [Ret.gan.],
            op.RetencionIBrutos AS [Ret.ing.b.],
            op.RetencionSUSS AS [Ret.SUSS],
            op.GastosGenerales AS [Dev.F.F.],
            CASE WHEN op.Tipo = 'OT' THEN NULL
                 ELSE op.DiferenciaBalanceo
            END AS [Dif. Balanceo],
            ( SELECT TOP 1
                        OrdenesPago.NumeroOrdenPago
              FROM      OrdenesPago
              WHERE     OrdenesPago.IdOrdenPago = op.IdOPComplementariaFF
            ) AS [OP complem. FF],
            op.CotizacionDolar AS [Cotiz. dolar],
            Empleados.Nombre AS [Destinatario fondo fijo],
            @Vector_T AS Vector_T,
            @Vector_X AS Vector_X
    FROM    OrdenesPago op
            LEFT OUTER JOIN Proveedores ON op.IdProveedor = Proveedores.IdProveedor
            LEFT OUTER JOIN Cuentas ON op.IdCuenta = Cuentas.IdCuenta
            LEFT OUTER JOIN Empleados ON op.IdEmpleadoFF = Empleados.IdEmpleado
            LEFT OUTER JOIN Monedas ON op.IdMoneda = Monedas.IdMoneda
    WHERE   op.Estado = 'CA'
            AND ( op.Anulada IS NULL
                  OR op.Anulada <> 'SI'
                )
            AND ( op.Confirmado IS NULL
                  OR op.Confirmado <> 'NO'
                )
    ORDER BY op.FechaOrdenPago,
            op.NumeroOrdenPago


GO




--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[ProntoWeb_CertificadoGanancias_DatosPorIdOrdenPago]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE ProntoWeb_CertificadoGanancias_DatosPorIdOrdenPago
go
 
CREATE PROCEDURE ProntoWeb_CertificadoGanancias_DatosPorIdOrdenPago @IdOrdenPago INT
AS 
    SET NOCOUNT ON
 
    CREATE TABLE #Auxiliar
        (
          IdDetalleOrdenPagoImpuestos INTEGER,
          IdOrdenPago INTEGER,
          Tipo VARCHAR(10),
          IdTipo INTEGER,
          IdTipoImpuesto INTEGER,
          Categoria VARCHAR(50),
          ImportePagado NUMERIC(18, 2),
          ImpuestoRetenido NUMERIC(18, 2),
          PagosMes NUMERIC(18, 2),
          RetencionesMes NUMERIC(18, 2),
          MinimoIIBB NUMERIC(18, 2),
          AlicuotaIIBB NUMERIC(6, 2),
          AlicuotaConvenioIIBB NUMERIC(6, 2),
          PorcentajeATomarSobreBase NUMERIC(6, 2),
          PorcentajeAdicional NUMERIC(6, 2),
          ImpuestoAdicional NUMERIC(18, 2),
          NumeroCertificadoRetencionGanancias INTEGER,
          NumeroCertificadoRetencionIIBB INTEGER,
          ImporteTotalFacturasMPagadasSujetasARetencion NUMERIC(18, 2)
        )
    INSERT  INTO #Auxiliar
            SELECT  DetOP.IdDetalleOrdenPagoImpuestos,
                    DetOP.IdOrdenPago,
                    DetOP.TipoImpuesto,
                    CASE WHEN DetOP.IdTipoRetencionGanancia IS NOT NULL THEN 1
                         WHEN DetOP.IdIBCondicion IS NOT NULL THEN 2
                         ELSE 0
                    END,
                    CASE WHEN DetOP.IdTipoRetencionGanancia IS NOT NULL
                         THEN DetOP.IdTipoRetencionGanancia
                         WHEN DetOP.IdIBCondicion IS NOT NULL
                         THEN DetOP.IdIBCondicion
                         ELSE NULL
                    END,
                    NULL,
                    DetOP.ImportePagado,
                    DetOP.ImpuestoRetenido,
                    0,
                    0,
                    0,
                    DetOP.AlicuotaAplicada,
                    DetOP.AlicuotaConvenioAplicada,
                    DetOP.PorcentajeATomarSobreBase,
                    DetOP.PorcentajeAdicional,
                    DetOP.ImpuestoAdicional,
                    DetOP.NumeroCertificadoRetencionGanancias,
                    DetOP.NumeroCertificadoRetencionIIBB,
                    DetOP.ImporteTotalFacturasMPagadasSujetasARetencion
            FROM    DetalleOrdenesPagoImpuestos DetOP
            WHERE   DetOP.IdOrdenPago = @IdOrdenPago
                    AND ISNULL(DetOP.IdTipoRetencionGanancia, 0) <> 0
 
    UPDATE  #Auxiliar
    SET     Categoria = ( SELECT TOP 1
                                    TiposRetencionGanancia.Descripcion
                          FROM      TiposRetencionGanancia
                          WHERE     TiposRetencionGanancia.IdTipoRetencionGanancia = #Auxiliar.IdTipoImpuesto
                        )
    WHERE   #Auxiliar.IdTipo = 1
 
    SET NOCOUNT OFF
 
    SELECT  #Auxiliar.IdDetalleOrdenPagoImpuestos,
            #Auxiliar.IdOrdenPago,
            #Auxiliar.Tipo AS [Tipo],
            #Auxiliar.IdTipoImpuesto,
            #Auxiliar.Categoria AS [Regimen],
            #Auxiliar.NumeroCertificadoRetencionGanancias AS [NumeroCertificado],
            OrdenesPago.FechaOrdenPago,
            ( SELECT TOP 1
                        Empresa.Nombre
              FROM      Empresa
              WHERE     Empresa.IdEmpresa = 1
            ) AS [NombreAgente],
            ( SELECT TOP 1
                        Empresa.Cuit
              FROM      Empresa
              WHERE     Empresa.IdEmpresa = 1
            ) AS [CuitAgente],
            ( SELECT TOP 1
                        ISNULL(Empresa.Direccion + ' ', '')
                        + ISNULL(Empresa.Localidad + ' ', '')
                        + ISNULL(Empresa.Provincia, '')
              FROM      Empresa
              WHERE     Empresa.IdEmpresa = 1
            ) AS [DomicilioAgente],
            Proveedores.RazonSocial AS [NombreSujeto],
            Proveedores.Cuit AS [CuitSujeto],
            ISNULL(Proveedores.Direccion + ' ', '')
            + ISNULL(Localidades.Nombre + ' ', '') + ISNULL(Provincias.Nombre
                                                            + ' ', '') AS [DomicilioSujeto],
            SUBSTRING('00000000', 1,
                      8 - LEN(CONVERT(VARCHAR, OrdenesPago.NumeroOrdenPago)))
            + CONVERT(VARCHAR, OrdenesPago.NumeroOrdenPago) AS [Comprobante],
            #Auxiliar.ImportePagado AS [MontoOrigen],
            #Auxiliar.ImpuestoRetenido AS [Retencion]
    FROM    #Auxiliar
            LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago = #Auxiliar.IdOrdenPago
            LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = OrdenesPago.IdProveedor
            LEFT OUTER JOIN Localidades ON Proveedores.IdLocalidad = Localidades.IdLocalidad
            LEFT OUTER JOIN Provincias ON Proveedores.IdProvincia = Provincias.IdProvincia
    ORDER BY #Auxiliar.Tipo,
            #Auxiliar.Categoria
 
    DROP TABLE #Auxiliar
GO

/*
select * from ordenespago order by NumeroOrdenPago DESC
select * from DetalleOrdenesPagoImpuestos
select * from ordenespago where idOrdenpago=6946
select * from proveedores where idproveedor=1283

exec ProntoWeb_CertificadoGanancias_DatosPorIdOrdenPago 6919
*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[ProntoWeb_CertificadoIIBB_DatosPorIdOrdenPago]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE ProntoWeb_CertificadoIIBB_DatosPorIdOrdenPago
go
 
CREATE PROCEDURE ProntoWeb_CertificadoIIBB_DatosPorIdOrdenPago @IdOrdenPago INT
AS 
    SET NOCOUNT ON
 
    CREATE TABLE #Auxiliar
        (
          IdDetalleOrdenPagoImpuestos INTEGER,
          IdOrdenPago INTEGER,
          Tipo VARCHAR(10),
          IdTipo INTEGER,
          IdTipoImpuesto INTEGER,
          Categoria VARCHAR(50),
          ImportePagado NUMERIC(18, 2),
          ImpuestoRetenido NUMERIC(18, 2),
          PagosMes NUMERIC(18, 2),
          RetencionesMes NUMERIC(18, 2),
          MinimoIIBB NUMERIC(18, 2),
          AlicuotaIIBB NUMERIC(6, 2),
          AlicuotaConvenioIIBB NUMERIC(6, 2),
          PorcentajeATomarSobreBase NUMERIC(6, 2),
          PorcentajeAdicional NUMERIC(6, 2),
          ImpuestoAdicional NUMERIC(18, 2),
          NumeroCertificadoRetencionGanancias INTEGER,
          NumeroCertificadoRetencionIIBB INTEGER,
          ImporteTotalFacturasMPagadasSujetasARetencion NUMERIC(18, 2)
        )
    INSERT  INTO #Auxiliar
            SELECT  DetOP.IdDetalleOrdenPagoImpuestos,
                    DetOP.IdOrdenPago,
                    DetOP.TipoImpuesto,
                    CASE WHEN DetOP.IdTipoRetencionGanancia IS NOT NULL THEN 1
                         WHEN DetOP.IdIBCondicion IS NOT NULL THEN 2
                         ELSE 0
                    END,
                    CASE WHEN DetOP.IdTipoRetencionGanancia IS NOT NULL
                         THEN DetOP.IdTipoRetencionGanancia
                         WHEN DetOP.IdIBCondicion IS NOT NULL
                         THEN DetOP.IdIBCondicion
                         ELSE NULL
                    END,
                    NULL,
                    DetOP.ImportePagado,
                    DetOP.ImpuestoRetenido,
                    0,
                    0,
                    0,
                    DetOP.AlicuotaAplicada,
                    DetOP.AlicuotaConvenioAplicada,
                    DetOP.PorcentajeATomarSobreBase,
                    DetOP.PorcentajeAdicional,
                    DetOP.ImpuestoAdicional,
                    DetOP.NumeroCertificadoRetencionGanancias,
                    DetOP.NumeroCertificadoRetencionIIBB,
                    DetOP.ImporteTotalFacturasMPagadasSujetasARetencion
            FROM    DetalleOrdenesPagoImpuestos DetOP
            WHERE   DetOP.IdOrdenPago = @IdOrdenPago
                    AND ISNULL(DetOP.IdIBCondicion, 0) <> 0
 
    UPDATE  #Auxiliar
    SET     Categoria = ( SELECT TOP 1
                                    IBCondiciones.Descripcion
                          FROM      IBCondiciones
                          WHERE     IBCondiciones.IdIBCondicion = #Auxiliar.IdTipoImpuesto
                        )
    WHERE   #Auxiliar.IdTipo = 2
 
    UPDATE  #Auxiliar
    SET     MinimoIIBB = ( SELECT TOP 1
                                    IBCondiciones.ImporteTopeMinimo
                           FROM     IBCondiciones
                           WHERE    IBCondiciones.IdIBCondicion = #Auxiliar.IdTipoImpuesto
                         )
    WHERE   #Auxiliar.IdTipo = 2
 
    SET NOCOUNT OFF
 
    SELECT  #Auxiliar.IdDetalleOrdenPagoImpuestos,
            #Auxiliar.IdOrdenPago,
            #Auxiliar.Tipo AS [Tipo],
            #Auxiliar.IdTipoImpuesto,
            #Auxiliar.Categoria AS [Regimen],
            #Auxiliar.NumeroCertificadoRetencionIIBB AS [NumeroCertificado],
            OrdenesPago.FechaOrdenPago AS [Fecha],
            ( SELECT TOP 1
                        Empresa.Nombre
              FROM      Empresa
              WHERE     Empresa.IdEmpresa = 1
            ) AS [NombreAgente],
            ( SELECT TOP 1
                        Empresa.Cuit
              FROM      Empresa
              WHERE     Empresa.IdEmpresa = 1
            ) AS [CuitAgente],
            ( SELECT TOP 1
                        ISNULL(Empresa.Direccion + ' ', '')
                        + ISNULL(Empresa.Localidad + ' ', '')
                        + ISNULL(Empresa.Provincia, '')
              FROM      Empresa
              WHERE     Empresa.IdEmpresa = 1
            ) AS [DomicilioAgente],
            Proveedores.RazonSocial AS [NombreSujeto],
            Proveedores.Cuit AS [CuitSujeto],
            ISNULL(Proveedores.Direccion + ' ', '')
            + ISNULL(Localidades.Nombre + ' ', '') + ISNULL(Provincias.Nombre
                                                            + ' ', '') AS [DomicilioSujeto],
            Proveedores.IBNumeroInscripcion AS [NumeroInscripcion],
            #Auxiliar.ImportePagado AS [ImportePagado],
            #Auxiliar.PagosMes AS [PagosMes],
            #Auxiliar.RetencionesMes AS [RetencionesMes],
            #Auxiliar.PorcentajeATomarSobreBase AS [%s/base],
            #Auxiliar.AlicuotaIIBB AS [%Alicuota],
            #Auxiliar.ImpuestoRetenido - ISNULL(#Auxiliar.ImpuestoAdicional, 0) AS [ImpuestoCalculado],
            #Auxiliar.PorcentajeAdicional AS [%adic],
            #Auxiliar.ImpuestoAdicional AS [AdicionalImpuesto],
            #Auxiliar.ImpuestoRetenido AS [TotalImpuesto]
    FROM    #Auxiliar
            LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago = #Auxiliar.IdOrdenPago
            LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = OrdenesPago.IdProveedor
            LEFT OUTER JOIN Localidades ON Proveedores.IdLocalidad = Localidades.IdLocalidad
            LEFT OUTER JOIN Provincias ON Proveedores.IdProvincia = Provincias.IdProvincia
    ORDER BY #Auxiliar.Tipo,
            #Auxiliar.Categoria
 
    DROP TABLE #Auxiliar
 
GO

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[ProntoWeb_CertificadoRetencionIVA_DatosPorIdOrdenPago]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE ProntoWeb_CertificadoRetencionIVA_DatosPorIdOrdenPago
go
 
CREATE PROCEDURE ProntoWeb_CertificadoRetencionIVA_DatosPorIdOrdenPago @IdOrdenPago INT
AS 
    SELECT  OrdenesPago.IdOrdenPago,
            OrdenesPago.NumeroCertificadoRetencionIVA AS [NumeroCertificado],
            'OP ' + SUBSTRING('00000000', 1,
                              8
                              - LEN(CONVERT(VARCHAR, OrdenesPago.NumeroOrdenPago)))
            + CONVERT(VARCHAR, OrdenesPago.NumeroOrdenPago) AS [Comprobante],
            OrdenesPago.FechaOrdenPago AS [Fecha],
            ( SELECT TOP 1
                        Empresa.Nombre
              FROM      Empresa
              WHERE     Empresa.IdEmpresa = 1
            ) AS [NombreAgente],
            ( SELECT TOP 1
                        Empresa.Cuit
              FROM      Empresa
              WHERE     Empresa.IdEmpresa = 1
            ) AS [CuitAgente],
            ( SELECT TOP 1
                        ISNULL(Empresa.Direccion + ' ', '')
                        + ISNULL(Empresa.Localidad + ' ', '')
                        + ISNULL(Empresa.Provincia, '')
              FROM      Empresa
              WHERE     Empresa.IdEmpresa = 1
            ) AS [DomicilioAgente],
            Proveedores.RazonSocial AS [NombreSujeto],
            Proveedores.Cuit AS [CuitSujeto],
            ISNULL(Proveedores.Direccion + ' ', '')
            + ISNULL(Localidades.Nombre + ' ', '') + ISNULL(Provincias.Nombre
                                                            + ' ', '') AS [DomicilioSujeto],
            CASE WHEN DetOP.IdImputacion = -1 THEN 'PA'
                 WHEN DetOP.IdImputacion = -2 THEN 'CO'
                 ELSE TiposComprobante.DescripcionAB
            END + ISNULL(' ' + cp.Letra + '-' + SUBSTRING('0000', 1,
                                                          4
                                                          - LEN(CONVERT(VARCHAR, cp.NumeroComprobante1)))
                         + CONVERT(VARCHAR, cp.NumeroComprobante1) + '-'
                         + SUBSTRING('00000000', 1,
                                     8
                                     - LEN(CONVERT(VARCHAR, cp.NumeroComprobante2)))
                         + CONVERT(VARCHAR, cp.NumeroComprobante2), '') AS [Numero],
            CuentasCorrientesAcreedores.Fecha AS [FechaImputacion],
            cp.TotalComprobante * TiposComprobante.Coeficiente
            * cp.CotizacionMoneda AS [ImporteTotal],
            cp.TotalIva1 * TiposComprobante.Coeficiente * cp.CotizacionMoneda AS [ImporteIVA],
            DetOP.ImporteRetencionIVA * OrdenesPago.CotizacionMoneda AS [ImporteRetenido]
    FROM    DetalleOrdenesPago DetOP
            LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago = DetOP.IdOrdenPago
            LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = OrdenesPago.IdProveedor
            LEFT OUTER JOIN Localidades ON Proveedores.IdLocalidad = Localidades.IdLocalidad
            LEFT OUTER JOIN Provincias ON Proveedores.IdProvincia = Provincias.IdProvincia
            LEFT OUTER JOIN CuentasCorrientesAcreedores ON CuentasCorrientesAcreedores.IdCtaCte = DetOP.IdImputacion
            LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = CuentasCorrientesAcreedores.IdTipoComp
            LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = CuentasCorrientesAcreedores.IdComprobante
    WHERE   DetOP.IdOrdenPago = @IdOrdenPago
            AND ISNULL(DetOP.ImporteRetencionIVA, 0) <> 0
GO 

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[ProntoWeb_CertificadoSUSS_DatosPorIdOrdenPago]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE ProntoWeb_CertificadoSUSS_DatosPorIdOrdenPago
go

 
CREATE PROCEDURE ProntoWeb_CertificadoSUSS_DatosPorIdOrdenPago @IdOrdenPago INT
AS 
    SELECT  OrdenesPago.IdOrdenPago,
            OrdenesPago.NumeroCertificadoRetencionSUSS AS [NumeroCertificado],
            'OP ' + SUBSTRING('00000000', 1,
                              8
                              - LEN(CONVERT(VARCHAR, OrdenesPago.NumeroOrdenPago)))
            + CONVERT(VARCHAR, OrdenesPago.NumeroOrdenPago) AS [Comprobante],
            OrdenesPago.FechaOrdenPago AS [Fecha],
            ( SELECT TOP 1
                        Empresa.Nombre
              FROM      Empresa
              WHERE     Empresa.IdEmpresa = 1
            ) AS [NombreAgente],
            ( SELECT TOP 1
                        Empresa.Cuit
              FROM      Empresa
              WHERE     Empresa.IdEmpresa = 1
            ) AS [CuitAgente],
            ( SELECT TOP 1
                        ISNULL(Empresa.Direccion + ' ', '')
                        + ISNULL(Empresa.Localidad + ' ', '')
                        + ISNULL(Empresa.Provincia, '')
              FROM      Empresa
              WHERE     Empresa.IdEmpresa = 1
            ) AS [DomicilioAgente],
            Proveedores.RazonSocial AS [NombreSujeto],
            Proveedores.Cuit AS [CuitSujeto],
            ISNULL(Proveedores.Direccion + ' ', '')
            + ISNULL(Localidades.Nombre + ' ', '') + ISNULL(Provincias.Nombre
                                                            + ' ', '') AS [DomicilioSujeto],
            ( SELECT    SUM(ISNULL(DetOP.ImportePagadoSinImpuestos, 0))
              FROM      DetalleOrdenesPago DetOP
              WHERE     DetOP.IdOrdenPago = OrdenesPago.IdOrdenPago
            ) AS [MontoComprobante],
            ( SELECT TOP 1
                        Imp.Tasa
              FROM      ImpuestosDirectos Imp
              WHERE     Imp.IdImpuestoDirecto = Proveedores.IdImpuestoDirectoSUSS
            ) AS [%Aplicado],
            OrdenesPago.RetencionSUSS AS [Retenido]
    FROM    OrdenesPago
            LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = OrdenesPago.IdProveedor
            LEFT OUTER JOIN Localidades ON Proveedores.IdLocalidad = Localidades.IdLocalidad
            LEFT OUTER JOIN Provincias ON Proveedores.IdProvincia = Provincias.IdProvincia
    WHERE   OrdenesPago.IdOrdenPago = @IdOrdenPago

GO



--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--			Recauchutaje de INFOPROV de Fido
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wOrdenesPago_TX_EnCajaPorProveedor]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wOrdenesPago_TX_EnCajaPorProveedor]
go

CREATE PROCEDURE [dbo].[wOrdenesPago_TX_EnCajaPorProveedor] @IdProveedor INT
AS 
    DECLARE @Estado VARCHAR(2)
    SET @Estado = NULL

    DECLARE @vector_X VARCHAR(50),
        @vector_T VARCHAR(50)

    SELECT  op.IdOrdenPago,
            op.FechaOrdenPago AS [Fecha Pago],
            op.Documentos,
            op.Acreedores,
            op.RetencionIVA AS [RetIVA],
            op.RetencionGanancias AS [RetGan],
            op.RetencionIBrutos AS [RetIngB],
            op.RetencionSUSS AS [RetSUSS],
            op.GastosGenerales AS [Dev.F.F.]
    FROM    OrdenesPago op
            LEFT OUTER JOIN Proveedores ON op.IdProveedor = Proveedores.IdProveedor
            LEFT OUTER JOIN Cuentas ON op.IdCuenta = Cuentas.IdCuenta
            LEFT OUTER JOIN Empleados ON op.IdEmpleadoFF = Empleados.IdEmpleado
            LEFT OUTER JOIN Monedas ON op.IdMoneda = Monedas.IdMoneda
            LEFT OUTER JOIN Obras ON op.IdObra = Obras.IdObra
    WHERE   --op.Estado=@Estado and 
            ( op.Anulada IS NULL
              OR op.Anulada <> 'SI'
            )
            AND ( op.Confirmado IS NULL
                  OR op.Confirmado <> 'NO'
                )
            AND op.IdProveedor = @IdProveedor
    ORDER BY op.FechaOrdenPago DESC,
            op.NumeroOrdenPago DESC

go

/*
exec [wOrdenesPago_TX_EnCajaPorProveedor] 673

SELECT 
 op.IdOrdenPago, 
 op.FechaOrdenPago as [Fecha Pago], 
 op.Documentos,
 op.Acreedores,
 op.RetencionIVA as [RetIVA],
 op.RetencionGanancias as [RetGan],
 op.RetencionIBrutos as [RetIngB],
 op.RetencionSUSS as [RetSUSS],
 op.GastosGenerales as [Dev.F.F.],op.Estado
FROM OrdenesPago op
LEFT OUTER JOIN Proveedores ON op.IdProveedor = Proveedores.IdProveedor 
LEFT OUTER JOIN Cuentas ON op.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Empleados ON op.IdEmpleadoFF = Empleados.IdEmpleado
LEFT OUTER JOIN Monedas ON op.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Obras ON op.IdObra = Obras.IdObra
WHERE 
--op.Estado=@Estado and 
(op.Anulada is null or op.Anulada<>'SI') and  (op.Confirmado is null or op.Confirmado<>'NO')
		and op.IdProveedor=673
ORDER BY op.FechaOrdenPago desc ,op.NumeroOrdenPago desc
*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCtasCtesA_TXPorMayorParaInfoProv]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wCtasCtesA_TXPorMayorParaInfoProv]
go




CREATE PROCEDURE [dbo].[wCtasCtesA_TXPorMayorParaInfoProv] @IdProveedor INT
AS 
    DECLARE @Todo INT
    DECLARE @FechaLimite DATETIME
    DECLARE @FechaDesde DATETIME
    DECLARE @Consolidar INT

    SET @Todo = -1
    SET @FechaLimite = '1/1/2070'
    SET @FechaDesde = NULL
    SET @Consolidar = NULL


    SET NOCOUNT ON

    SET @FechaDesde = ISNULL(@FechaDesde, CONVERT(DATETIME, '1/1/2000'))
    SET @Consolidar = ISNULL(@Consolidar, -1)

    DECLARE @IdTipoComprobanteOrdenPago INT,
        @SaldoInicial NUMERIC(18, 2)
    SET @IdTipoComprobanteOrdenPago = ( SELECT TOP 1
                                                Parametros.IdTipoComprobanteOrdenPago
                                        FROM    Parametros
                                        WHERE   Parametros.IdParametro = 1
                                      )
    IF @Todo = -1 
        SET @SaldoInicial = 0
    ELSE 
        SET @SaldoInicial = ISNULL(( SELECT SUM(ISNULL(CtaCte.ImporteTotal, 0)
                                                * ISNULL(tc.Coeficiente, 1))
                                     FROM   CuentasCorrientesAcreedores CtaCte
                                            LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante = CtaCte.IdTipoComp
                                     WHERE  CtaCte.IdProveedor = @IdProveedor
                                            AND CtaCte.Fecha < @FechaDesde
                                   ), 0)

    CREATE TABLE #Auxiliar1
        (
          IdCtaCte INTEGER,
          IdProveedor INTEGER,
          IdTipoComprobante INTEGER,
          TipoComprobante VARCHAR(5),
          IdComprobante INTEGER,
          NumeroComprobante VARCHAR(15),
          Referencia INTEGER,
          Fecha DATETIME,
          ImporteTotal NUMERIC(18, 2),
          IdMoneda INTEGER
        )
    IF @Todo <> -1 
        INSERT  INTO #Auxiliar1
                SELECT  0,
                        @IdProveedor,
                        0,
                        'INI',
                        0,
                        ' AL ' + CONVERT(VARCHAR, @FechaDesde, 103),
                        0,
                        @FechaDesde,
                        @SaldoInicial,
                        1

    INSERT  INTO #Auxiliar1
            SELECT  CtaCte.IdCtaCte,
                    CtaCte.IdProveedor,
                    CASE WHEN CtaCte.IdTipoComp = 16
                         THEN @IdTipoComprobanteOrdenPago
                         ELSE CtaCte.IdTipoComp
                    END,
                    TiposComprobante.DescripcionAB,
                    CtaCte.IdComprobante,
                    CASE WHEN CtaCte.IdTipoComp = @IdTipoComprobanteOrdenPago
                              OR CtaCte.IdTipoComp = 16
                              OR cp.IdComprobanteProveedor IS NULL
                         THEN SUBSTRING(SUBSTRING('00000000', 1,
                                                  8
                                                  - LEN(CONVERT(VARCHAR, CtaCte.NumeroComprobante)))
                                        + CONVERT(VARCHAR, CtaCte.NumeroComprobante),
                                        1, 15)
                         ELSE SUBSTRING(cp.Letra + '-' + SUBSTRING('0000', 1, 4 - LEN(CONVERT(VARCHAR, cp.NumeroComprobante1)))
                                        + CONVERT(VARCHAR, cp.NumeroComprobante1)
                                        + '-' + SUBSTRING('00000000', 1,
                                                          8
                                                          - LEN(CONVERT(VARCHAR, cp.NumeroComprobante2)))
                                        + CONVERT(VARCHAR, cp.NumeroComprobante2),
                                        1, 15)
                    END,
                    CtaCte.NumeroComprobante,
                    CtaCte.Fecha,
                    CtaCte.ImporteTotal * TiposComprobante.Coeficiente,
                    CtaCte.IdMoneda
            FROM    CuentasCorrientesAcreedores CtaCte
                    LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = CtaCte.IdTipoComp
                    LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = CtaCte.IdComprobante
            WHERE   CtaCte.IdProveedor = @IdProveedor
                    AND ( @Todo = -1
                          OR CtaCte.Fecha BETWEEN @FechaDesde AND @FechaLimite
                        )

    UPDATE  #Auxiliar1
    SET     NumeroComprobante = '00000000'
    WHERE   NumeroComprobante IS NULL

    CREATE TABLE #Auxiliar2
        (
          IdCtaCte INTEGER,
          IdTipoComprobante INTEGER,
          TipoComprobante VARCHAR(5),
          IdComprobante INTEGER,
          NumeroComprobante VARCHAR(15),
          Referencia INTEGER,
          Fecha DATETIME,
          ImporteTotal NUMERIC(18, 2),
          IdMoneda INTEGER
        )
    INSERT  INTO #Auxiliar2
            SELECT  MAX(#Auxiliar1.IdCtaCte),
                    #Auxiliar1.IdTipoComprobante,
                    MAX(#Auxiliar1.TipoComprobante),
                    #Auxiliar1.IdComprobante,
                    #Auxiliar1.NumeroComprobante,
                    MAX(#Auxiliar1.Referencia),
                    MAX(#Auxiliar1.Fecha),
                    SUM(#Auxiliar1.ImporteTotal),
                    #Auxiliar1.IdMoneda
            FROM    #Auxiliar1
            GROUP BY #Auxiliar1.IdTipoComprobante,
                    #Auxiliar1.IdComprobante,
                    #Auxiliar1.NumeroComprobante,
                    #Auxiliar1.IdMoneda

    SET NOCOUNT OFF

    DECLARE @vector_X VARCHAR(30),
        @vector_T VARCHAR(30),
        @vector_E VARCHAR(1000)
    SET @vector_X = '01111118888151133'
    SET @vector_T = '00997144444453900'
    SET @vector_E = '  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 |  |  |  '

    SELECT  TipoComprobante,
            NumeroComprobante,
            CONVERT(CHAR(10), Fecha, 103) AS Fecha,
            CONVERT(CHAR(10), FechaComprobante, 103) AS FechaComprobante,
            #Auxiliar2.IdCtaCte,
            #Auxiliar2.TipoComprobante AS [Comp.],
            #Auxiliar2.IdTipoComprobante,
            #Auxiliar2.IdComprobante,
            #Auxiliar2.NumeroComprobante AS [Numero],
            #Auxiliar2.Referencia AS [Ref.],
            #Auxiliar2.Fecha,
            #Auxiliar2.ImporteTotal * -1 AS [Imp.orig.],
            CASE WHEN #Auxiliar2.ImporteTotal < 0
                 THEN #Auxiliar2.ImporteTotal * -1
                 ELSE NULL
            END AS [Debe],
            CASE WHEN #Auxiliar2.ImporteTotal >= 0
                 THEN #Auxiliar2.ImporteTotal
                 ELSE NULL
            END AS [Haber],
            #Auxiliar2.ImporteTotal AS [Saldo],
            CASE WHEN #Auxiliar2.IdTipoComprobante = @IdTipoComprobanteOrdenPago
                      OR #Auxiliar2.IdTipoComprobante = 16 THEN NULL
                 ELSE cp.FechaComprobante
            END AS [Fecha cmp.],
            CASE WHEN #Auxiliar2.IdTipoComprobante = @IdTipoComprobanteOrdenPago
                 THEN ISNULL(CONVERT(VARCHAR(1000), OrdenesPago.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS),
                             '')
                 ELSE ISNULL(CONVERT(VARCHAR(1000), cp.Observaciones), '')
            END AS [Observaciones],
            Monedas.Abreviatura AS [Mon.origen],
            @Vector_E AS Vector_E,
            @Vector_T AS Vector_T,
            @Vector_X AS Vector_X
    FROM    #Auxiliar2
            LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = #Auxiliar2.IdTipoComprobante
            LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = #Auxiliar2.IdComprobante
                                                          AND #Auxiliar2.IdTipoComprobante <> @IdTipoComprobanteOrdenPago
                                                          AND #Auxiliar2.IdTipoComprobante <> 16
            LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago = #Auxiliar2.IdComprobante
                                           AND ( #Auxiliar2.IdTipoComprobante = @IdTipoComprobanteOrdenPago
                                                 OR #Auxiliar2.IdTipoComprobante = 16
                                               )
            LEFT OUTER JOIN Monedas ON #Auxiliar2.IdMoneda = Monedas.IdMoneda
    ORDER BY FechaComprobante DESC



    DROP TABLE #Auxiliar1
    DROP TABLE #Auxiliar2


go


/*
exec [wCtasCtesA_TXPorMayorParaInfoProv] 100


*/



--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wRequerimientos_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wRequerimientos_A]
go


CREATE PROCEDURE [dbo].[wRequerimientos_A]
    @IdRequerimiento INT,
    @NumeroRequerimiento INT,
    @FechaRequerimiento DATETIME,
    @LugarEntrega NTEXT,
    @Observaciones NTEXT,
    
    @IdObra INT,
    @IdSolicito INT,
    @IdSector INT,
    @MontoPrevisto NUMERIC(12, 2),
    @IdComprador INT,
    
    @Aprobo INT,
    @FechaAprobacion DATETIME,
    @MontoParaCompra NUMERIC(12, 2),
    @Cumplido VARCHAR(2),
    @UsuarioAnulacion VARCHAR(6),
    
    @FechaAnulacion DATETIME,
    @MotivoAnulacion NTEXT,
    @IdRequerimientoOriginal INT,
    @IdOrigenTransmision INT,
    @IdAutorizoCumplido INT,
    
    @IdDioPorCumplido INT,
    @FechaDadoPorCumplido DATETIME,
    @ObservacionesCumplido NTEXT,
    @IdMoneda INT,
    @Detalle VARCHAR(50),
    
    @Confirmado VARCHAR(2),    
    @FechaImportacionTransmision DATETIME,
    @IdEquipoDestino INT,
    @Impresa VARCHAR(2),
    @Recepcionado VARCHAR(2),
    
    @Entregado VARCHAR(2),
    @TipoRequerimiento VARCHAR(2),
    @IdOrdenTrabajo INT,
    @IdTipoCompra INT,
    @IdImporto INT,
    
    @FechaLlegadaImportacion DATETIME,
    @CircuitoFirmasCompleto VARCHAR(2),
    @ConfirmadoPorWeb VARCHAR(2),
    @DirectoACompras VARCHAR(2)
AS 
    DECLARE @ReturnValue INT




    IF ISNULL(@IdRequerimiento, 0) <= 0 
        BEGIN
            BEGIN TRAN
	
            SET @NumeroRequerimiento = ISNULL(( SELECT TOP 1
                                                        P.ProximoNumeroRequerimiento
                                                FROM    Parametros P
                                                WHERE   P.IdParametro = 1
                                              ), 1)
            UPDATE  Parametros
            SET     ProximoNumeroRequerimiento = @NumeroRequerimiento + 1
	
            INSERT  INTO Requerimientos
                    (
                      NumeroRequerimiento,
                      FechaRequerimiento,
                      LugarEntrega,
                      Observaciones,
                      IdObra,
                      IdSolicito,
                      IdSector,
                      MontoPrevisto,
                      IdComprador,
                      Aprobo,
                      FechaAprobacion,
                      MontoParaCompra,
                      Cumplido,
                      UsuarioAnulacion,
                      FechaAnulacion,
                      MotivoAnulacion,
                      IdRequerimientoOriginal,
                      IdOrigenTransmision,
                      IdAutorizoCumplido,
                      IdDioPorCumplido,
                      FechaDadoPorCumplido,
                      ObservacionesCumplido,
                      IdMoneda,
                      Detalle,
                      Confirmado,
                      FechaImportacionTransmision,
                      IdEquipoDestino,
                      Impresa,
                      Recepcionado,
                      Entregado,
                      TipoRequerimiento,
                      IdOrdenTrabajo,
                      IdTipoCompra,
                      IdImporto,
                      FechaLlegadaImportacion,
                      CircuitoFirmasCompleto,
                      ConfirmadoPorWeb,
                      DirectoACompras
	              )
            VALUES  (
                      @NumeroRequerimiento,
                      @FechaRequerimiento,
                      @LugarEntrega,
                      @Observaciones,
                      @IdObra,
                      @IdSolicito,
                      @IdSector,
                      @MontoPrevisto,
                      @IdComprador,
                      @Aprobo,
                      @FechaAprobacion,
                      @MontoParaCompra,
                      @Cumplido,
                      @UsuarioAnulacion,
                      @FechaAnulacion,
                      @MotivoAnulacion,
                      @IdRequerimientoOriginal,
                      @IdOrigenTransmision,
                      @IdAutorizoCumplido,
                      @IdDioPorCumplido,
                      @FechaDadoPorCumplido,
                      @ObservacionesCumplido,
                      @IdMoneda,
                      @Detalle,
                      @Confirmado,
                      @FechaImportacionTransmision,
                      @IdEquipoDestino,
                      @Impresa,
                      @Recepcionado,
                      @Entregado,
                      @TipoRequerimiento,
                      @IdOrdenTrabajo,
                      @IdTipoCompra,
                      @IdImporto,
                      @FechaLlegadaImportacion,
                      @CircuitoFirmasCompleto,
                      @ConfirmadoPorWeb,
                      @DirectoACompras
	              )
	
            SELECT  @ReturnValue = SCOPE_IDENTITY()
	
            IF @@ERROR <> 0 
                BEGIN
                    ROLLBACK TRAN
                    RETURN -1
                END
            ELSE 
                BEGIN
                    COMMIT TRAN
                END
        END
    ELSE 
        BEGIN
            UPDATE  Requerimientos
            SET     NumeroRequerimiento = @NumeroRequerimiento,
                    FechaRequerimiento = @FechaRequerimiento,
                    LugarEntrega = @LugarEntrega,
                    Observaciones = @Observaciones,
                    IdObra = @IdObra,
                    IdSolicito = @IdSolicito,
                    IdSector = @IdSector,
                    MontoPrevisto = @MontoPrevisto,
                    IdComprador = @IdComprador,
                    Aprobo = @Aprobo,
                    FechaAprobacion = @FechaAprobacion,
                    MontoParaCompra = @MontoParaCompra,
                    Cumplido = @Cumplido,
                    UsuarioAnulacion = @UsuarioAnulacion,
                    FechaAnulacion = @FechaAnulacion,
                    MotivoAnulacion = @MotivoAnulacion,
                    IdRequerimientoOriginal = @IdRequerimientoOriginal,
                    IdOrigenTransmision = @IdOrigenTransmision,
                    IdAutorizoCumplido = @IdAutorizoCumplido,
                    IdDioPorCumplido = @IdDioPorCumplido,
                    FechaDadoPorCumplido = @FechaDadoPorCumplido,
                    ObservacionesCumplido = @ObservacionesCumplido,
                    IdMoneda = @IdMoneda,
                    Detalle = @Detalle,
                    Confirmado = @Confirmado,
                    FechaImportacionTransmision = @FechaImportacionTransmision,
                    IdEquipoDestino = @IdEquipoDestino,
	-- Impresa=@Impresa
                    Recepcionado = @Recepcionado,
                    Entregado = @Entregado,
                    TipoRequerimiento = @TipoRequerimiento,
                    IdOrdenTrabajo = @IdOrdenTrabajo,
                    IdTipoCompra = @IdTipoCompra,
                    IdImporto = @IdImporto,
                    FechaLlegadaImportacion = @FechaLlegadaImportacion,
                    CircuitoFirmasCompleto = @CircuitoFirmasCompleto,
                    ConfirmadoPorWeb = @ConfirmadoPorWeb,
                    DirectoACompras = @DirectoACompras
            WHERE   ( IdRequerimiento = @IdRequerimiento )

            SELECT  @ReturnValue = @IdRequerimiento
        END

    IF @@ERROR <> 0 
        RETURN -1
    ELSE 
        RETURN @ReturnValue


GO






--exec wRequerimientos_A @IdRequerimiento=NULL,@NumeroRequerimiento=64200,@FechaRequerimiento=NULL,@LugarEntrega=NULL,
--@Observaciones=NULL,@IdObra=202,@IdSolicito=478,@IdSector=4,@MontoPrevisto=0,@IdComprador=NULL,@Aprobo=0,@FechaAprobacion=NULL,
--@MontoParaCompra=0,@Cumplido=N'NO',@UsuarioAnulacion=NULL,@FechaAnulacion=NULL,@MotivoAnulacion=NULL,@IdRequerimientoOriginal=NULL,
--@IdOrigenTransmision=NULL,@IdAutorizoCumplido=NULL,@IdDioPorCumplido=NULL,@FechaDadoPorCumplido=NULL,@ObservacionesCumplido=NULL,
--@IdMoneda=NULL,@Detalle=NULL,@Confirmado=N'SI',@FechaImportacionTransmision=NULL,@IdEquipoDestino=NULL,@Impresa=NULL,
--@Recepcionado=NULL,@Entregado=NULL,@TipoRequerimiento=NULL,@IdOrdenTrabajo=NULL,@IdTipoCompra=NULL,@IdImporto=NULL,
--@FechaLlegadaImportacion=NULL,@CircuitoFirmasCompleto=NULL,@ConfirmadoPorWeb=N'NO'
--,@DirectoACompras=N'SI'


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////



--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--COMPARATIVAS
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wComparativas_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wComparativas_A
go


CREATE PROCEDURE wComparativas_A
    @IdComparativa INT OUTPUT,
    @Numero INT,
    @Fecha DATETIME,
    @Observaciones NTEXT,
    @IdConfecciono INT,
    @IdAprobo INT,
    @PresupuestoSeleccionado INT,
    @SubNumeroSeleccionado INT,
    @MontoPrevisto NUMERIC(12, 2),
    @MontoParaCompra NUMERIC(12, 2),
    @NumeroRequerimiento INT,
    @FechaAprobacion DATETIME,
    @Obras VARCHAR(20),
    @CircuitoFirmasCompleto VARCHAR(2)
AS 
    IF ISNULL(@IdComparativa, 0) <= 0 
        BEGIN 
 --insert
            INSERT  INTO Comparativas
                    (
                      Numero,
                      Fecha,
                      Observaciones,
                      IdConfecciono,
                      IdAprobo,
                      PresupuestoSeleccionado,
                      SubNumeroSeleccionado,
                      MontoPrevisto,
                      MontoParaCompra,
                      NumeroRequerimiento,
                      FechaAprobacion,
                      Obras,
                      CircuitoFirmasCompleto
                    )
            VALUES  (
                      @Numero,
                      @Fecha,
                      @Observaciones,
                      @IdConfecciono,
                      @IdAprobo,
                      @PresupuestoSeleccionado,
                      @SubNumeroSeleccionado,
                      @MontoPrevisto,
                      @MontoParaCompra,
                      @NumeroRequerimiento,
                      @FechaAprobacion,
                      @Obras,
                      @CircuitoFirmasCompleto
                    )
            SELECT  @IdComparativa = @@identity
        END
    ELSE 
        BEGIN
            UPDATE  Comparativas
            SET     Numero = @Numero,
                    Fecha = @Fecha,
                    Observaciones = @Observaciones,
                    IdConfecciono = @IdConfecciono,
                    IdAprobo = @IdAprobo,
                    PresupuestoSeleccionado = @PresupuestoSeleccionado,
                    SubNumeroSeleccionado = @SubNumeroSeleccionado,
                    MontoPrevisto = @MontoPrevisto,
                    MontoParaCompra = @MontoParaCompra,
                    NumeroRequerimiento = @NumeroRequerimiento,
                    FechaAprobacion = @FechaAprobacion,
                    Obras = @Obras,
                    CircuitoFirmasCompleto = @CircuitoFirmasCompleto
            WHERE   ( IdComparativa = @IdComparativa )
 
 
        END
  
    RETURN ( @IdComparativa )
GO


--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wComparativas_E]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wComparativas_E
go

CREATE PROCEDURE wComparativas_E @IdComparativa INT
AS 
    DELETE  Comparativas
    WHERE   ( IdComparativa = @IdComparativa )
GO



--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wComparativas_T]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wComparativas_T
go

CREATE PROCEDURE wComparativas_T
    @IdComparativa INT = NULL
AS 
    SET @IdComparativa = ISNULL(@IdComparativa, -1)
  
    SELECT  *,
         Cmp.IdComparativa,
 Cmp.Numero,
 Cmp.Fecha as [Fecha Comparativa],
 Case When IsNull(Cmp.PresupuestoSeleccionado,0)<>-1 Then 'Monopresupuesto' Else 'Multipresupuesto' End as [Tipo seleccion],
 (Select Empleados.Nombre From Empleados Where Cmp.IdConfecciono=Empleados.IdEmpleado) as [Confecciono],
 (Select Empleados.Nombre From Empleados Where Cmp.IdAprobo=Empleados.IdEmpleado) as [Aprobo],
 Cmp.MontoPrevisto as [Monto previsto],
 Cmp.MontoParaCompra,
 --(Select Count(*) From #Auxiliar0 Where #Auxiliar0.IdComparativa=Cmp.IdComparativa) as [Cant.Sol.],
 Cmp.ArchivoAdjunto1 as [Archivo adjunto 1],
 Cmp.ArchivoAdjunto2 as [Archivo adjunto 2]
    FROM    Comparativas Cmp
    WHERE   @IdComparativa = -1
            OR ( IdComparativa = @IdComparativa )
    ORDER BY IdComparativa DESC
GO





--EXEC wcomparativas_t












--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wComparativas_TL]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wComparativas_TL
go

CREATE PROCEDURE wComparativas_TL
AS --mono
    SELECT  CONVERT(VARCHAR, Numero) AS Numero,
            CONVERT(VARCHAR, Numero) + ' del ' + CONVERT(VARCHAR, Fecha, 103) AS [Titulo],
            Comparativas.Numero AS Orden
    FROM    Comparativas
    WHERE   PresupuestoSeleccionado IS NOT NULL
            AND PresupuestoSeleccionado <> -1
    UNION

--multi
    SELECT DISTINCT
            CONVERT(VARCHAR, COMP.Numero) + ';'
            + CONVERT(VARCHAR, DETCOMP.idpresupuesto) AS Numero,
            CONVERT(VARCHAR, COMP.Numero) + ' del ' + CONVERT(VARCHAR, Fecha, 103)
            + ' MULTI:' + CONVERT(VARCHAR, DETCOMP.idpresupuesto) + ' '
            + PROV.RazonSocial AS [Titulo],
            COMP.Numero AS Orden
    FROM    detallecomparativas DETCOMP
            INNER JOIN comparativas COMP ON DETCOMP.idcomparativa = COMP.idcomparativa
            INNER JOIN presupuestos PP ON PP.idpresupuesto = DETCOMP.idpresupuesto
            INNER JOIN proveedores PROV ON PP.idproveedor = PROV.idproveedor
    WHERE   DETCOMP.estado = 'MR'
            AND COMP.PresupuestoSeleccionado = -1
    ORDER BY Orden DESC

GO



/*
exec wComparativas_TL

select * 
from comparativas
WHERE PresupuestoSeleccionado=-1

select distinct COMP.numero,DETCOMP.idpresupuesto, PROV.RazonSocial,Convert(varchar,Numero) + ' del ' + Convert(varchar,Fecha,103) as [Titulo]
from detallecomparativas DETCOMP
inner join comparativas COMP on DETCOMP.idcomparativa=COMP.idcomparativa
inner join presupuestos PP on PP.idpresupuesto=DETCOMP.idpresupuesto
inner join proveedores PROV on PP.idproveedor=PROV.idproveedor
where DETCOMP.estado='MR' and COMP.PresupuestoSeleccionado=-1


select * from detallecomparativas

      If Not IsNull(oRsComp.Fields("PresupuestoSeleccionado").Value) And _
            oRsComp.Fields("PresupuestoSeleccionado").Value = -1 Then
             es multip
            


         Set Lista.DataSource = Aplicacion.Comparativas.TraerFiltrado("_ItemsSeleccionados", mIdComparativa)



*/



--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetComparativas_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wDetComparativas_A
go

CREATE PROCEDURE wDetComparativas_A
    @IdDetalleComparativa INT OUTPUT,
    @IdComparativa INT,
    @IdPresupuesto INT,
    @NumeroPresupuesto INT,
    @FechaPresupuesto DATETIME,
    @IdArticulo INT,
    @Cantidad NUMERIC(12, 2),
    @Precio NUMERIC(12, 4),
    @Estado VARCHAR(2),
    @SubNumero INT,
    @Observaciones NTEXT,
    @IdUnidad INT,
    @IdMoneda INT,
    @OrigenDescripcion INT,
    @PorcentajeBonificacion NUMERIC(6, 2),
    @CotizacionMoneda NUMERIC(18, 3),
    @IdDetallePresupuesto INT
AS 
    IF ISNULL(@IdDetalleComparativa, 0) <= 0 
        BEGIN   
    

            INSERT  INTO [DetalleComparativas]
                    (
                      IdComparativa,
                      IdPresupuesto,
                      NumeroPresupuesto,
                      FechaPresupuesto,
                      IdArticulo,
                      Cantidad,
                      Precio,
                      Estado,
                      SubNumero,
                      Observaciones,
                      IdUnidad,
                      IdMoneda,
                      OrigenDescripcion,
                      PorcentajeBonificacion,
                      CotizacionMoneda,
                      IdDetallePresupuesto
		        )
            VALUES  (
                      @IdComparativa,
                      @IdPresupuesto,
                      @NumeroPresupuesto,
                      @FechaPresupuesto,
                      @IdArticulo,
                      @Cantidad,
                      @Precio,
                      @Estado,
                      @SubNumero,
                      @Observaciones,
                      @IdUnidad,
                      @IdMoneda,
                      @OrigenDescripcion,
                      @PorcentajeBonificacion,
                      @CotizacionMoneda,
                      @IdDetallePresupuesto
		        )
            SELECT  @IdDetalleComparativa = @@identity
        END 
    ELSE 
        BEGIN
            UPDATE  [DetalleComparativas]
            SET     IdComparativa = @IdComparativa,
                    IdPresupuesto = @IdPresupuesto,
                    NumeroPresupuesto = @NumeroPresupuesto,
                    FechaPresupuesto = @FechaPresupuesto,
                    IdArticulo = @IdArticulo,
                    Cantidad = @Cantidad,
                    Precio = @Precio,
                    Estado = @Estado,
                    SubNumero = @SubNumero,
                    Observaciones = @Observaciones,
                    IdUnidad = @IdUnidad,
                    IdMoneda = @IdMoneda,
                    OrigenDescripcion = @OrigenDescripcion,
                    PorcentajeBonificacion = @PorcentajeBonificacion,
                    CotizacionMoneda = @CotizacionMoneda,
                    IdDetallePresupuesto = @IdDetallePresupuesto
            WHERE   ( IdDetalleComparativa = @IdDetalleComparativa )
        END

    RETURN ( @IdDetalleComparativa )
GO




--/////////////////////////////////////////////////////////////////////
IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetComparativas_E]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wDetComparativas_E
go


CREATE PROCEDURE wDetComparativas_E
    @IdDetalleComparativa INT
AS 
    DELETE  [DetalleComparativas]
    WHERE   ( IdDetalleComparativa = @IdDetalleComparativa )

GO
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetComparativas_T]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wDetComparativas_T
go


CREATE PROCEDURE wDetComparativas_T
    @IdDetalleComparativa INT
AS 
    SELECT  Det.*,
            Articulos.Descripcion AS [Articulo],
            Unidades.Descripcion AS [Unidad],
            Prov.RazonSocial AS [ProveedorDelPresupuesto]
    FROM    DetalleComparativas Det
            LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
            LEFT OUTER JOIN Presupuestos P ON Det.IdPresupuesto = P.IdPresupuesto
            LEFT OUTER JOIN Proveedores Prov ON P.IdProveedor = Prov.IdProveedor
    WHERE   ( IdDetalleComparativa = @IdDetalleComparativa )
go

--/////////////////////////////////////////////////////////////////////
IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetComparativas_TT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wDetComparativas_TT]
go


CREATE PROCEDURE [dbo].[wDetComparativas_TT] @IdComparativa INT
AS 
    SELECT  Det.*,
            Articulos.Descripcion AS [Articulo],
            Unidades.Descripcion AS [Unidad],
            Prov.RazonSocial AS [ProveedorDelPresupuesto]
--,Cuentas.Descripcion as [CuentaGastoDescripcion]
    FROM    DetalleComparativas Det --LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento=DetReq.IdRequerimiento
            LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
--LEFT OUTER JOIN Cuentas ON Det.IdCuentaGasto = Cuentas.IdCuenta
            LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
--LEFT OUTER JOIN Obras ON Cab.IdObra = Obras.IdObra
--LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
--LEFT OUTER JOIN Equipos ON DetReq.IdEquipo = Equipos.IdEquipo
--LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
--LEFT OUTER JOIN ControlesCalidad ON DetReq.IdControlCalidad = ControlesCalidad.IdControlCalidad
--LEFT OUTER JOIN Empleados E1 ON Requerimientos.Aprobo = E1.IdEmpleado
--LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
--LEFT OUTER JOIN Empleados E3 ON Requerimientos.IdComprador = E3.IdEmpleado
            LEFT OUTER JOIN Presupuestos P ON Det.IdPresupuesto = P.IdPresupuesto
            LEFT OUTER JOIN Proveedores Prov ON P.IdProveedor = Prov.IdProveedor
    WHERE   @IdComparativa = IdComparativa 

GO


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wPedidos_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wPedidos_A]
go


CREATE PROCEDURE [dbo].[wPedidos_A]
    @IdPedido INT,
    @NumeroPedido INT,
    @IdProveedor INT,
    @FechaPedido DATETIME,
    @LugarEntrega NTEXT,
    @FormaPago NTEXT,
    @Observaciones NTEXT,
    @Bonificacion NUMERIC(12, 2),
    @TotalIva1 NUMERIC(12, 2),
    @TotalPedido NUMERIC(12, 2),
    @PorcentajeIva1 NUMERIC(6, 2),
    @IdComprador INT,
    @PorcentajeBonificacion NUMERIC(6, 2),
    @NumeroComparativa INT,
    @Contacto VARCHAR(50),
    @PlazoEntrega NTEXT,
    @Garantia NTEXT,
    @Documentacion NTEXT,
    @Aprobo INT,
    @IdMoneda INT,
    @FechaAprobacion DATETIME,
    @Importante NTEXT,
    @TipoCompra INT,
    @Cumplido VARCHAR(2),
    @DetalleCondicionCompra VARCHAR(200),
    @IdAutorizoCumplido INT,
    @IdDioPorCumplido INT,
    @FechaDadoPorCumplido DATETIME,
    @ObservacionesCumplido NTEXT,
    @SubNumero INT,
    @UsuarioAnulacion VARCHAR(6),
    @FechaAnulacion DATETIME,
    @MotivoAnulacion NTEXT,
    @ImprimeImportante VARCHAR(2),
    @ImprimePlazoEntrega VARCHAR(2),
    @ImprimeLugarEntrega VARCHAR(2),
    @ImprimeFormaPago VARCHAR(2),
    @ImprimeImputaciones VARCHAR(2),
    @ImprimeInspecciones VARCHAR(2),
    @ImprimeGarantia VARCHAR(2),
    @ImprimeDocumentacion VARCHAR(2),
    @CotizacionDolar NUMERIC(18, 3),
    @CotizacionMoneda NUMERIC(18, 3),
    @PedidoExterior VARCHAR(2),
    @IdCondicionCompra INT,
    @IdPedidoOriginal INT,
    @IdOrigenTransmision INT,
    @FechaImportacionTransmision DATETIME,
    @Subcontrato VARCHAR(2),
    @IdPedidoAbierto INT,
    @NumeroLicitacion VARCHAR(20),
    @Transmitir_a_SAT VARCHAR(2),
    @NumeracionAutomatica VARCHAR(2),
    @Impresa VARCHAR(2),
    @EmbarcadoA VARCHAR(50),
    @FacturarA VARCHAR(50),
    @ProveedorExt VARCHAR(50),
    @ImpuestosInternos NUMERIC(18, 2),
    @FechaSalida DATETIME,
    @CodigoControl NUMERIC(10, 0),
    @CircuitoFirmasCompleto VARCHAR(2)
AS 
    DECLARE @ReturnValue INT

    IF ISNULL(@IdPedido, 0) <= 0 
        BEGIN
            BEGIN TRAN
            IF @IdOrigenTransmision IS NULL
                AND ISNULL(@NumeracionAutomatica, 'NO') = 'SI' 
                BEGIN
                    IF @PedidoExterior = 'NO' 
                        BEGIN
                            SET @NumeroPedido = ISNULL(( SELECT TOP 1
                                                                P.ProximoNumeroPedido
                                                         FROM   Parametros P
                                                         WHERE  P.IdParametro = 1
                                                       ), 1)
                            UPDATE  Parametros
                            SET     ProximoNumeroPedido = @NumeroPedido + 1
                        END
                    ELSE 
                        BEGIN
                            SET @NumeroPedido = ISNULL(( SELECT TOP 1
                                                                P.ProximoNumeroPedidoExterior
                                                         FROM   Parametros P
                                                         WHERE  P.IdParametro = 1
                                                       ), 1)
                            UPDATE  Parametros
                            SET     ProximoNumeroPedidoExterior = @NumeroPedido
                                    + 1
                        END
                END
	
            SET @CodigoControl = CONVERT(NUMERIC(10, 0), RAND() * 10000000000)
	
            INSERT  INTO Pedidos
                    (
                      NumeroPedido,
                      IdProveedor,
                      FechaPedido,
                      LugarEntrega,
                      FormaPago,
                      Observaciones,
                      Bonificacion,
                      TotalIva1,
                      TotalPedido,
                      PorcentajeIva1,
                      IdComprador,
                      PorcentajeBonificacion,
                      NumeroComparativa,
                      Contacto,
                      PlazoEntrega,
                      Garantia,
                      Documentacion,
                      Aprobo,
                      IdMoneda,
                      FechaAprobacion,
                      Importante,
                      TipoCompra,
                      Cumplido,
                      DetalleCondicionCompra,
                      IdAutorizoCumplido,
                      IdDioPorCumplido,
                      FechaDadoPorCumplido,
                      ObservacionesCumplido,
                      SubNumero,
                      UsuarioAnulacion,
                      FechaAnulacion,
                      MotivoAnulacion,
                      ImprimeImportante,
                      ImprimePlazoEntrega,
                      ImprimeLugarEntrega,
                      ImprimeFormaPago,
                      ImprimeImputaciones,
                      ImprimeInspecciones,
                      ImprimeGarantia,
                      ImprimeDocumentacion,
                      CotizacionDolar,
                      CotizacionMoneda,
                      PedidoExterior,
                      IdCondicionCompra,
                      IdPedidoOriginal,
                      IdOrigenTransmision,
                      FechaImportacionTransmision,
                      Subcontrato,
                      IdPedidoAbierto,
                      NumeroLicitacion,
                      Transmitir_a_SAT,
                      NumeracionAutomatica,
                      Impresa,
                      EmbarcadoA,
                      FacturarA,
                      ProveedorExt,
                      ImpuestosInternos,
                      FechaSalida,
                      CodigoControl,
                      CircuitoFirmasCompleto
	              )
            VALUES  (
                      @NumeroPedido,
                      @IdProveedor,
                      @FechaPedido,
                      @LugarEntrega,
                      @FormaPago,
                      @Observaciones,
                      @Bonificacion,
                      @TotalIva1,
                      @TotalPedido,
                      @PorcentajeIva1,
                      @IdComprador,
                      @PorcentajeBonificacion,
                      @NumeroComparativa,
                      @Contacto,
                      @PlazoEntrega,
                      @Garantia,
                      @Documentacion,
                      @Aprobo,
                      @IdMoneda,
                      @FechaAprobacion,
                      @Importante,
                      @TipoCompra,
                      @Cumplido,
                      @DetalleCondicionCompra,
                      @IdAutorizoCumplido,
                      @IdDioPorCumplido,
                      @FechaDadoPorCumplido,
                      @ObservacionesCumplido,
                      @SubNumero,
                      @UsuarioAnulacion,
                      @FechaAnulacion,
                      @MotivoAnulacion,
                      @ImprimeImportante,
                      @ImprimePlazoEntrega,
                      @ImprimeLugarEntrega,
                      @ImprimeFormaPago,
                      @ImprimeImputaciones,
                      @ImprimeInspecciones,
                      @ImprimeGarantia,
                      @ImprimeDocumentacion,
                      @CotizacionDolar,
                      @CotizacionMoneda,
                      @PedidoExterior,
                      @IdCondicionCompra,
                      @IdPedidoOriginal,
                      @IdOrigenTransmision,
                      @FechaImportacionTransmision,
                      @Subcontrato,
                      @IdPedidoAbierto,
                      @NumeroLicitacion,
                      @Transmitir_a_SAT,
                      @NumeracionAutomatica,
                      @Impresa,
                      @EmbarcadoA,
                      @FacturarA,
                      @ProveedorExt,
                      @ImpuestosInternos,
                      @FechaSalida,
                      @CodigoControl,
                      @CircuitoFirmasCompleto
	              )

            SELECT  @ReturnValue = SCOPE_IDENTITY()
	
            IF @@ERROR <> 0 
                BEGIN
                    ROLLBACK TRAN
                    RETURN -1
                END
            ELSE 
                BEGIN
                    COMMIT TRAN
                END
        END
    ELSE 
        BEGIN
            UPDATE  Pedidos
            SET     NumeroPedido = @NumeroPedido,
                    IdProveedor = @IdProveedor,
                    FechaPedido = @FechaPedido,
                    LugarEntrega = @LugarEntrega,
                    FormaPago = @FormaPago,
                    Observaciones = @Observaciones,
                    Bonificacion = @Bonificacion,
                    TotalIva1 = @TotalIva1,
                    TotalPedido = @TotalPedido,
                    PorcentajeIva1 = @PorcentajeIva1,
                    IdComprador = @IdComprador,
                    PorcentajeBonificacion = @PorcentajeBonificacion,
                    NumeroComparativa = @NumeroComparativa,
                    Contacto = @Contacto,
                    PlazoEntrega = @PlazoEntrega,
                    Garantia = @Garantia,
                    Documentacion = @Documentacion,
                    Aprobo = @Aprobo,
                    IdMoneda = @IdMoneda,
                    FechaAprobacion = @FechaAprobacion,
                    Importante = @Importante,
                    TipoCompra = @TipoCompra,
                    Cumplido = @Cumplido,
                    DetalleCondicionCompra = @DetalleCondicionCompra,
                    IdAutorizoCumplido = @IdAutorizoCumplido,
                    IdDioPorCumplido = @IdDioPorCumplido,
                    FechaDadoPorCumplido = @FechaDadoPorCumplido,
                    ObservacionesCumplido = @ObservacionesCumplido,
                    SubNumero = @SubNumero,
                    UsuarioAnulacion = @UsuarioAnulacion,
                    FechaAnulacion = @FechaAnulacion,
                    MotivoAnulacion = @MotivoAnulacion,
                    ImprimeImportante = @ImprimeImportante,
                    ImprimePlazoEntrega = @ImprimePlazoEntrega,
                    ImprimeLugarEntrega = @ImprimeLugarEntrega,
                    ImprimeFormaPago = @ImprimeFormaPago,
                    ImprimeImputaciones = @ImprimeImputaciones,
                    ImprimeInspecciones = @ImprimeInspecciones,
                    ImprimeGarantia = @ImprimeGarantia,
                    ImprimeDocumentacion = @ImprimeDocumentacion,
                    CotizacionDolar = @CotizacionDolar,
                    CotizacionMoneda = @CotizacionMoneda,
                    PedidoExterior = @PedidoExterior,
                    IdCondicionCompra = @IdCondicionCompra,
                    IdPedidoOriginal = @IdPedidoOriginal,
                    IdOrigenTransmision = @IdOrigenTransmision,
                    FechaImportacionTransmision = @FechaImportacionTransmision,
                    Subcontrato = @Subcontrato,
                    IdPedidoAbierto = @IdPedidoAbierto,
                    NumeroLicitacion = @NumeroLicitacion,
                    Transmitir_a_SAT = @Transmitir_a_SAT,
                    NumeracionAutomatica = @NumeracionAutomatica,
                    Impresa = @Impresa,
                    EmbarcadoA = @EmbarcadoA,
                    FacturarA = @FacturarA,
                    ProveedorExt = @ProveedorExt,
                    ImpuestosInternos = @ImpuestosInternos,
                    FechaSalida = @FechaSalida,
                    CodigoControl = @CodigoControl,
                    CircuitoFirmasCompleto = @CircuitoFirmasCompleto
            WHERE   ( IdPedido = @IdPedido )

            SELECT  @ReturnValue = @IdPedido
        END

    IF @@ERROR <> 0 
        RETURN -1
    ELSE 
        RETURN @ReturnValue

GO

--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wPedidos_T]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wPedidos_T]
go


CREATE  PROCEDURE [dbo].[wPedidos_T] @IdPedido INT = NULL
AS 
    SET NOCOUNT ON

    SET @IdPedido = ISNULL(@IdPedido, -1)

    CREATE TABLE #Auxiliar0
        (
          IdPedido INTEGER,
          Requerimientos VARCHAR(100),
          Obras VARCHAR(100)
        )

    CREATE TABLE #Auxiliar1
        (
          IdPedido INTEGER,
          NumeroRequerimiento INTEGER,
          NumeroObra VARCHAR(13),
          SAT VARCHAR(1)
        )
    INSERT  INTO #Auxiliar1
            SELECT  DetPed.IdPedido,
                    CASE WHEN Requerimientos.NumeroRequerimiento IS NOT NULL
                         THEN Requerimientos.NumeroRequerimiento
                         ELSE Acopios.NumeroAcopio
                    END,
                    Obras.NumeroObra,
                    CASE WHEN DetalleRequerimientos.IdOrigenTransmision IS NOT NULL
                         THEN 'S'
                         ELSE ''
                    END
            FROM    DetallePedidos DetPed
                    LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
                    LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
                    LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
                    LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
                    LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
            WHERE   @IdPedido = -1
                    OR DetPed.IdPedido = @IdPedido

--Ver como optimizar esto
/*
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdPedido,NumeroRequerimiento) ON [PRIMARY]

INSERT INTO #Auxiliar0 
 SELECT IdPedido, '', ''
 FROM #Auxiliar1
 GROUP BY IdPedido

DECLARE @IdPedido1 int, @NumeroRequerimiento int, @NumeroObra varchar(13), 
	@RMs varchar(100), @Obras varchar(100), @Corte int, @SAT varchar(1)
SET @Corte=0
SET @RMs=''
SET @Obras=''
DECLARE PedReq CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdPedido, NumeroRequerimiento, NumeroObra, SAT
		FROM #Auxiliar1
		ORDER BY IdPedido
OPEN PedReq
FETCH NEXT FROM PedReq INTO @IdPedido1, @NumeroRequerimiento, @NumeroObra, @SAT
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdPedido1
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar0
			SET Requerimientos = SUBSTRING(@RMs,1,100), Obras = SUBSTRING(@Obras,1,100)
			WHERE #Auxiliar0.IdPedido=@Corte
		   END
		SET @RMs=''
		SET @Obras=''
		SET @Corte=@IdPedido1
	   END
	IF NOT @NumeroRequerimiento IS NULL
		IF PATINDEX('%['+CONVERT(VARCHAR,@NumeroRequerimiento)+']'+'%', @RMs)=0
			SET @RMs=@RMs+'['+CONVERT(VARCHAR,@NumeroRequerimiento)+']'+@SAT+' '
	IF NOT @NumeroObra IS NULL
		IF PATINDEX('%'+CONVERT(VARCHAR,@NumeroObra)+' '+'%', @Obras)=0
			SET @Obras=@Obras+@NumeroObra+' '
	FETCH NEXT FROM PedReq INTO @IdPedido1, @NumeroRequerimiento, @NumeroObra, @SAT
   END
 IF @Corte<>0
    BEGIN
	UPDATE #Auxiliar0
	SET Requerimientos = SUBSTRING(@RMs,1,100), Obras = SUBSTRING(@Obras,1,100)
	WHERE #Auxiliar0.IdPedido=@Corte
    END
CLOSE PedReq
DEALLOCATE PedReq

SET NOCOUNT OFF

*/


    SELECT  Pedidos.*,
            #Auxiliar0.Requerimientos AS [RMs],
            #Auxiliar0.Obras AS [Obras],
            Proveedores.RazonSocial AS [Proveedor],
            CASE WHEN TotalIva2 IS NULL
                 THEN TotalPedido - TotalIva1 + Bonificacion
                 ELSE TotalPedido - TotalIva1 - TotalIva2 + Bonificacion
            END AS [NetoGravado],
            Monedas.Abreviatura AS [Moneda],
            E1.Nombre AS [Comprador],
            E2.Nombre AS [Libero],
            ( SELECT    COUNT(*)
              FROM      DetallePedidos
              WHERE     DetallePedidos.IdPedido = Pedidos.IdPedido
            ) AS [CantidadItems],
            PedidosAbiertos.NumeroPedidoAbierto AS [PedidoAbierto],
            ( SELECT TOP 1
                        A.Descripcion
              FROM      Articulos A
              WHERE     A.IdArticulo = ( SELECT TOP 1
                                                Requerimientos.IdEquipoDestino
                                         FROM   DetalleRequerimientos DR
                                                LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DR.IdRequerimiento
                                         WHERE  DR.IdDetalleRequerimiento = ( SELECT TOP 1
                                                                                        DP.IdDetalleRequerimiento
                                                                              FROM      DetallePedidos DP
                                                                              WHERE     DP.IdPedido = Pedidos.IdPedido
                                                                                        AND DP.IdDetalleRequerimiento IS NOT NULL
                                                                            )
                                       )
            ) AS [EquipoDestino],
            cc.Descripcion AS [CondicionCompra],
  Pedidos.FechaSalida as [Fecha salida],
 --Pedidos.Cumplido as [Cump.],
 --#Auxiliar0.Requerimientos as [RM's],
 --#Auxiliar0.Obras as [Obras],
 --Proveedores.RazonSocial as [Proveedor],
 --IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)-
	--IsNull(Pedidos.ImpuestosInternos,0)-IsNull(Pedidos.OtrosConceptos1,0)-IsNull(Pedidos.OtrosConceptos2,0)-
	--IsNull(Pedidos.OtrosConceptos3,0)-IsNull(Pedidos.OtrosConceptos4,0)-IsNull(Pedidos.OtrosConceptos5,0)as [Neto gravado],
 --Case When Bonificacion=0 Then Null Else Bonificacion End as [Bonificacion],
 Case When TotalIva1=0 Then Null Else TotalIva1 End as [Total Iva],
 IsNull(Pedidos.ImpuestosInternos,0)+IsNull(Pedidos.OtrosConceptos1,0)+IsNull(Pedidos.OtrosConceptos2,0)+
	IsNull(Pedidos.OtrosConceptos3,0)+IsNull(Pedidos.OtrosConceptos4,0)+IsNull(Pedidos.OtrosConceptos5,0)as [Otros Conceptos],
 TotalPedido as [Total pedido],
 --Monedas.Nombre as [Moneda],
 --E1.Nombre as [Comprador],
 E2.Nombre as [Liberado por],
 --(Select Count(*) From DetallePedidos Where DetallePedidos.IdPedido=Pedidos.IdPedido) as [Cant.Items],
 --Pedidos.IdPedido as [IdAux],
 --NumeroComparativa as [Comparativa],
 --Case When Pedidos.TipoCompra=1 Then 'Gestion por compras' When Pedidos.TipoCompra=2 Then 'Gestion por terceros' Else Null End as [Tipo compra],
 --Pedidos.Observaciones,
 --DetalleCondicionCompra as [Aclaracion s/condicion de compra],
 --Case When IsNull(PedidoExterior,'NO')='SI' Then 'SI' Else Null End as [Ext.],
 PedidosAbiertos.NumeroPedidoAbierto as [Pedido abierto],
 Pedidos.NumeroLicitacion as [Nro.Licitacion],
 Pedidos.Impresa as [Impresa],
 Pedidos.UsuarioAnulacion as [Anulo],
 Pedidos.FechaAnulacion as [Fecha anulacion],
 Pedidos.MotivoAnulacion as [Motivo anulacion],
 Pedidos.ImpuestosInternos as [Imp.Internos],
 (Select Top 1 A.Descripcion From Articulos A 
	Where A.IdArticulo=(Select Top 1 Requerimientos.IdEquipoDestino 
				From DetalleRequerimientos DR
				Left Outer Join Requerimientos On Requerimientos.IdRequerimiento=DR.IdRequerimiento
				Where DR.IdDetalleRequerimiento=(Select Top 1 DP.IdDetalleRequerimiento 
								 From DetallePedidos DP 
								 Where DP.IdPedido=Pedidos.IdPedido and 
									DP.IdDetalleRequerimiento is not null))) as [Equipo destino],
 Pedidos.CircuitoFirmasCompleto as [Circuito de firmas completo],
 '' as [Condicion IVA]
 --DescripcionIva.Descripcion as [Condicion IVA]
           
    FROM    Pedidos
            LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
            LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda = Monedas.IdMoneda
            LEFT OUTER JOIN PedidosAbiertos ON Pedidos.IdPedidoAbierto = PedidosAbiertos.IdPedidoAbierto
            LEFT OUTER JOIN #Auxiliar0 ON Pedidos.IdPedido = #Auxiliar0.IdPedido
            LEFT OUTER JOIN Empleados E1 ON Pedidos.IdComprador = E1.IdEmpleado
            LEFT OUTER JOIN Empleados E2 ON Pedidos.Aprobo = E2.IdEmpleado
            LEFT OUTER JOIN [Condiciones Compra] cc ON Pedidos.IdCondicionCompra = cc.IdCondicionCompra
    WHERE   @IdPedido = -1
            OR Pedidos.IdPedido = @IdPedido
    ORDER BY NumeroPedido DESC,
            SubNumero DESC

    DROP TABLE #Auxiliar0
    DROP TABLE #Auxiliar1

GO






--EXEC dbo.wPedidos_T	 -1





--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
-- CARTA DE PORTE
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wCartasDePorte_A]
go


CREATE PROCEDURE [dbo].[wCartasDePorte_A]
    @IdCartaDePorte INT,
    @NumeroCartaDePorte BIGINT,
    @SubNumeroVagon INT,
    @IdUsuarioIngreso INT,
    @FechaIngreso DATETIME,
    @Anulada VARCHAR(2),
    @IdUsuarioAnulo INT,
    @FechaAnulacion DATETIME,
    @Observaciones VARCHAR(200),
    @Vendedor INT, --REFERENCES Articulos(idArticulo),
    @CuentaOrden1 INT, --REFERENCES Articulos(idArticulo),
    @CuentaOrden2 INT, --REFERENCES Articulos(idArticulo),
    @Corredor INT, --REFERENCES Articulos(idArticulo),
    @Entregador INT, --REFERENCES Articulos(idArticulo),
    @Procedencia VARCHAR(30),
    @Patente VARCHAR(30),	
--------------------------------------------
    @IdArticulo INT,
    @IdStock INT,
    @Partida VARCHAR(20),
    @IdUnidad INT, -- REFERENCES Unidades(idUnidad),
    @IdUbicacion INT,
    @Cantidad NUMERIC(12, 2),
-----------------------------------------
    @Cupo VARCHAR(30),
    @NetoProc NUMERIC(18, 2),
    @Calidad VARCHAR(30),
    @BrutoPto NUMERIC(18, 2),
    @TaraPto NUMERIC(18, 2),
    @NetoPto NUMERIC(18, 2),
    @Acoplado VARCHAR(30),
    @Humedad NUMERIC(18, 2),
    @Merma NUMERIC(18, 2),
    @NetoFinal NUMERIC(18, 2),
    @FechaDeCarga DATETIME,
    @FechaVencimiento DATETIME,
    @CEE VARCHAR(20),
    @IdTransportista INT,
    @TransportistaCUIT VARCHAR(13),--desnormalizado
    @IdChofer INT,
    @ChoferCUIT VARCHAR(13),  --desnormalizado
    @FechaTimeStamp TIMESTAMP,
    @Cosecha VARCHAR(20),
    @CTG INT,
    @Contrato VARCHAR(20),
    @Destino INT,
    @Subcontr1 INT,
    @Subcontr2 INT,
    @Contrato1 INT,
    @contrato2 INT,
    @KmARecorrer NUMERIC(18, 2),
    @Tarifa NUMERIC(18, 2),
    @FechaDescarga DATETIME,
    @Hora DATETIME,
    @NRecibo INT,
    @CalidadDe INT,
    @TaraFinal NUMERIC(18, 2),
    @BrutoFinal NUMERIC(18, 2),
    @Fumigada NUMERIC(18, 2),
    @Secada NUMERIC(18, 2),
    @Exporta VARCHAR(2),
    @NobleExtranos NUMERIC(18, 2),
    @NobleNegros NUMERIC(18, 2),
    @NobleQuebrados NUMERIC(18, 2),
    @NobleDaniados NUMERIC(18, 2),
    @NobleChamico NUMERIC(18, 2),
    @NobleChamico2 NUMERIC(18, 2),
    @NobleRevolcado NUMERIC(18, 2),
    @NobleObjetables NUMERIC(18, 2),
    @NobleAmohosados NUMERIC(18, 2),
    @NobleHectolitrico NUMERIC(18, 2),
    @NobleCarbon NUMERIC(18, 2),
    @NoblePanzaBlanca NUMERIC(18, 2),
    @NoblePicados NUMERIC(18, 2),
    @NobleMGrasa NUMERIC(18, 2),
    @NobleAcidezGrasa NUMERIC(18, 2),
    @NobleVerdes NUMERIC(18, 2),
    @NobleGrado INT,
    @NobleConforme VARCHAR(2),
    @NobleACamara VARCHAR(2),
    @IdFacturaImputada INT,


    @HumedadDesnormalizada NUMERIC(18, 2),
    @Factor NUMERIC(18, 2),
    @PuntoVenta INT,
    @TarifaFacturada NUMERIC(18, 2),
    @TarifaSubcontratista1 NUMERIC(18, 2),
	@TarifaSubcontratista2 NUMERIC(18, 2),
    @FechaArribo DATETIME,
    @MotivoAnulacion VARCHAR(100),
    @Corredor2 INT



	,
	@NumeroSubfijo				INT	,
	@IdEstablecimiento			INT	,
	@EnumSyngentaDivision	VARCHAR (10),

	@FechaModificacion		DATETIME,
	@IdUsuarioModifico			INT,
	@FechaEmision			DATETIME,
	@ExcluirDeSubcontratistas varchar(2),

	@IdTipoMovimiento			INT,

	@AgregaItemDeGastosAdministrativos		varchar(2),
	@IdClienteAFacturarle					INT,
    @SubnumeroDeFacturacion					INT


AS 
    IF ISNULL(@IdCartaDePorte, 0) <= 0 
        BEGIN 
		 --insert
            INSERT  INTO CartasDePorte
                    (
                      NumeroCartaDePorte,
                      SubnumeroVagon,
                      IdUsuarioIngreso,
                      FechaIngreso,
                      Anulada,
                      IdUsuarioAnulo,
                      FechaAnulacion,
                      Observaciones,
                      Vendedor, --REFERENCES Articulos(idArticulo),
                      CuentaOrden1, --REFERENCES Articulos(idArticulo),
                      CuentaOrden2, --REFERENCES Articulos(idArticulo),
                      Corredor, --REFERENCES Articulos(idArticulo),
                      Entregador,
                      Procedencia,
                      Patente,	
--------------------------------------------
                      IdArticulo,
                      IdStock,
                      Partida,
                      IdUnidad, -- REFERENCES Unidades(idUnidad),
                      IdUbicacion,
                      Cantidad,
-----------------------------------------
                      Cupo,
                      NetoProc,
                      Calidad,
                      BrutoPto,
                      TaraPto,
                      NetoPto,
                      Acoplado,
                      Humedad,
                      Merma,
                      NetoFinal,
                      FechaDeCarga,
                      FechaVencimiento,
                      CEE,
                      IdTransportista,
                      TransportistaCUITdesnormalizado,
                      IdChofer,
                      ChoferCUITdesnormalizado,
                      Cosecha,
                      CTG,
                      Contrato,
                      Destino,
                      Subcontr1,
                      Subcontr2,
                      Contrato1,
                      contrato2,
                      KmARecorrer,
                      Tarifa,
                      FechaDescarga,
                      Hora,
                      NRecibo,
                      CalidadDe,
                      TaraFinal,
                      BrutoFinal,
                      Fumigada,
                      Secada,
                      Exporta,
                      NobleExtranos,
                      NobleNegros,
                      NobleQuebrados,
                      NobleDaniados,
                      NobleChamico,
                      NobleChamico2,
                      NobleRevolcado,
                      NobleObjetables,
                      NobleAmohosados,
                      NobleHectolitrico,
                      NobleCarbon,
                      NoblePanzaBlanca,
                      NoblePicados,
                      NobleMGrasa,
                      NobleAcidezGrasa,
                      NobleVerdes,
                      NobleGrado,
                      NobleConforme,
                      NobleACamara,
                      IdFacturaImputada,

					  HumedadDesnormalizada ,
						Factor ,
						PuntoVenta ,
						TarifaFacturada ,
						TarifaSubcontratista1 ,
						TarifaSubcontratista2 ,
						FechaArribo ,
						MotivoAnulacion ,
						Corredor2 
							,NumeroSubfijo,
	IdEstablecimiento,
	EnumSyngentaDivision,

	FechaModificacion		,
	IdUsuarioModifico			,
	FechaEmision			,
	ExcluirDeSubcontratistas,
	IdTipoMovimiento			,


	AgregaItemDeGastosAdministrativos	,
	IdClienteAFacturarle					,
    SubnumeroDeFacturacion					
                    )

            VALUES  (
                      @NumeroCartaDePorte,
                      @SubNumeroVagon,
                      @IdUsuarioIngreso,
                      @FechaIngreso,
                      @Anulada,
                      @IdUsuarioAnulo,
                      @FechaAnulacion,
                      @Observaciones,
                      @Vendedor, --REFERENCES Articulos(idArticulo),
                      @CuentaOrden1, --REFERENCES Articulos(idArticulo),
                      @CuentaOrden2, --REFERENCES Articulos(idArticulo),
                      @Corredor, --REFERENCES Articulos(idArticulo),
                      @Entregador,
                      @Procedencia,
                      @Patente,	
--------------------------------------------
                      @IdArticulo,
                      @IdStock,
                      @Partida,
                      @IdUnidad, -- REFERENCES Unidades(idUnidad),
                      @IdUbicacion,
                      @Cantidad,
-----------------------------------------
                      @Cupo,
                      @NetoProc,
                      @Calidad,
                      @BrutoPto,
                      @TaraPto,
                      @NetoPto,
                      @Acoplado,
                      @Humedad,
                      @Merma,
                      @NetoFinal,
                      @FechaDeCarga,
                      @FechaVencimiento,
                      @CEE,
                      @IdTransportista,
                      @TransportistaCUIT,--desnormalizado
                      @IdChofer,
                      @ChoferCUIT,
                      @Cosecha,
                      @CTG,
                      @Contrato,
                      @Destino,
                      @Subcontr1,
                      @Subcontr2,
                      @Contrato1,
                      @contrato2,
                      @KmARecorrer,
                      @Tarifa,
                      @FechaDescarga,
                      @Hora,
                      @NRecibo,
                      @CalidadDe,
                      @TaraFinal,
                      @BrutoFinal,
                      @Fumigada,
                      @Secada,
                      @Exporta,
                      @NobleExtranos,
                      @NobleNegros,
                      @NobleQuebrados,
                      @NobleDaniados,
                      @NobleChamico,
                      @NobleChamico2,
                      @NobleRevolcado,
                      @NobleObjetables,
                      @NobleAmohosados,
                      @NobleHectolitrico,
                      @NobleCarbon,
                      @NoblePanzaBlanca,
                      @NoblePicados,
                      @NobleMGrasa,
                      @NobleAcidezGrasa,
                      @NobleVerdes,
                      @NobleGrado,
                      @NobleConforme,
                      @NobleACamara,
                      @IdFacturaImputada,

					      @HumedadDesnormalizada,
    @Factor,
    @PuntoVenta,
    @TarifaFacturada,
    @TarifaSubcontratista1,
	@TarifaSubcontratista2,
    @FechaArribo,
    @MotivoAnulacion ,
    @Corredor2 
		,@NumeroSubfijo,
	@IdEstablecimiento,
	@EnumSyngentaDivision,

	@FechaModificacion		,
	@IdUsuarioModifico			,
	@FechaEmision			,
	@ExcluirDeSubcontratistas,
	@IdTipoMovimiento			


	
	,@AgregaItemDeGastosAdministrativos	,
	@IdClienteAFacturarle					,
    @SubnumeroDeFacturacion					
		        )
            SELECT  @IdCartaDePorte = @@identity
        END

    ELSE 
        BEGIN
            DECLARE @FechaTimeStampAnt TIMESTAMP
            SET @FechaTimeStampAnt = ( SELECT TOP 1
                                                FechaTimeStamp
                                       FROM     CartasDePorte
                                       WHERE    IdCartaDePorte = 1
                                     )
		--IF @FechaTimeStampAnt<>@FechaTimeStamp RETURN(-1)


            UPDATE  CartasDePorte
            SET     NumeroCartaDePorte = @NumeroCartaDePorte,
                    SubNumeroVagon = @SubNumeroVagon,
                    IdUsuarioIngreso = @IdUsuarioIngreso,
                    FechaIngreso = @FechaIngreso,
                    Anulada = @Anulada,
                    IdUsuarioAnulo = @IdUsuarioAnulo,
                    FechaAnulacion = @FechaAnulacion,
                    Observaciones = @Observaciones,
                    Vendedor = @Vendedor, --REFERENCES Articulos(idArticulo),
                    CuentaOrden1 = @CuentaOrden1, --REFERENCES Articulos(idArticulo),
                    CuentaOrden2 = @CuentaOrden2, --REFERENCES Articulos(idArticulo),
                    Corredor = @Corredor, --REFERENCES Articulos(idArticulo),
                    Entregador = @Entregador, --REFERENCES Articulos(idArticulo),
                    Procedencia = @Procedencia,
                    Patente = @Patente,	
--------------------------------------------
                    IdArticulo = @IdArticulo,
                    IdStock = @IdStock,
                    Partida = @Partida,
                    IdUnidad = @IdUnidad, -- REFERENCES Unidades(idUnidad),
                    IdUbicacion = @IdUbicacion,
                    Cantidad = @Cantidad,
-----------------------------------------
                    Cupo = @Cupo,
                    NetoProc = @NetoProc,
                    Calidad = @Calidad,
                    BrutoPto = @BrutoPto,
                    TaraPto = @TaraPto,
                    NetoPto = @NetoPto,
                    Acoplado = @Acoplado,
                    Humedad = @Humedad,
                    Merma = @Merma,
                    NetoFinal = @NetoFinal,
                    FechaDeCarga = @FechaDeCarga,
                    FechaVencimiento = @FechaVencimiento,
                    CEE = @CEE,
                    IdTransportista = @IdTransportista,
                    TransportistaCUITdesnormalizado = @TransportistaCUIT,--desnormalizado
                    IdChofer = @IdChofer,
                    ChoferCUITdesnormalizado = @ChoferCUIT,
                    Cosecha = @Cosecha,
                    CTG = @CTG,
                    Contrato = @Contrato,
                    Destino = @Destino,
                    Subcontr1 = @Subcontr1,
                    Subcontr2 = @Subcontr2,
                    Contrato1 = @Contrato1,
                    contrato2 = @contrato2,
                    KmARecorrer = @KmARecorrer,
                    Tarifa = @Tarifa,
                    FechaDescarga = @FechaDescarga,
                    Hora = @Hora,
                    NRecibo = @NRecibo,
                    CalidadDe = @CalidadDe,
                    TaraFinal = @TaraFinal,
                    BrutoFinal = @BrutoFinal,
                    Fumigada = @Fumigada,
                    Secada = @Secada,
                    Exporta = @Exporta,
                    NobleExtranos = @NobleExtranos,
                    NobleNegros = @NobleNegros,
                    NobleQuebrados = @NobleQuebrados,
                    NobleDaniados = @NobleDaniados,
                    NobleChamico = @NobleChamico,
                    NobleChamico2 = @NobleChamico2,
                    NobleRevolcado = @NobleRevolcado,
                    NobleObjetables = @NobleObjetables,
                    NobleAmohosados = @NobleAmohosados,
                    NobleHectolitrico = @NobleHectolitrico,
                    NobleCarbon = @NobleCarbon,
                    NoblePanzaBlanca = @NoblePanzaBlanca,
                    NoblePicados = @NoblePicados,
                    NobleMGrasa = @NobleMGrasa,
                    NobleAcidezGrasa = @NobleAcidezGrasa,
                    NobleVerdes = @NobleVerdes,
                    NobleGrado = @NobleGrado,
                    NobleConforme = @NobleConforme,
                    NobleACamara = @NobleACamara,
                    IdFacturaImputada = @IdFacturaImputada,
					HumedadDesnormalizada = @HumedadDesnormalizada    ,

					Factor= @Factor,
					PuntoVenta= @PuntoVenta,
					TarifaFacturada=@TarifaFacturada ,
					TarifaSubcontratista1=@TarifaSubcontratista1 ,
					TarifaSubcontratista2=@TarifaSubcontratista2 ,
					FechaArribo=@FechaArribo ,
					MotivoAnulacion=@MotivoAnulacion ,
					Corredor2=@Corredor2 
						,NumeroSubfijo=@NumeroSubfijo,
	IdEstablecimiento=@IdEstablecimiento,	
	EnumSyngentaDivision=@EnumSyngentaDivision	,

	FechaModificacion=@FechaModificacion		,
	IdUsuarioModifico=@IdUsuarioModifico			,
	FechaEmision=@FechaEmision	,		
	ExcluirDeSubcontratistas=@ExcluirDeSubcontratistas,
	IdTipoMovimiento=@IdTipoMovimiento			

	
	,
	AgregaItemDeGastosAdministrativos=@AgregaItemDeGastosAdministrativos,
	IdClienteAFacturarle=@IdClienteAFacturarle,
    SubnumeroDeFacturacion=@SubnumeroDeFacturacion	

            WHERE   ( IdCartaDePorte = @IdCartaDePorte )
 

        END
  
    RETURN ( @IdCartaDePorte )
GO





/*

select * from cartasdeporte

exec wCartasDePorte_A @IdCartaDePorte = 10, @NumeroCartaDePorte = 0, @IdUsuarioIngreso = 0, @FechaIngreso = NULL, @Anulada = N'', @IdUsuarioAnulo = NULL, @FechaAnulacion = NULL, @Observaciones = N'Horreos del Sudeste c/ - KM 240 - Tarifa $ 82,81', @FechaTimeStamp = -8201046125348651008, @Vendedor = NULL, @CuentaOrden1 = NULL, @CuentaOrden2 = NULL, @Corredor = NULL, @Procedencia = N'722', @Patente = N'0', @IdArticulo = 4, @IdStock = NULL, @Partida = N'', @IdUnidad = NULL, @IdUbicacion = NULL, @Cantidad = 0.000000000000000e+000, @Cupo = N'', @NetoProc = 3.089000000000000e+004, @Calidad = N'0', @BrutoPto = 4.500000000000000e+004, @TaraPto = 0.000000000000000e+000, @NetoPto = 0.000000000000000e+000, @Acoplado = N'0', @Humedad = 1.790000000000000e+001, @Merma = 1.670000000000000e+003, @NetoFinal = 0.000000000000000e+000, @FechaDeCarga = 'Abr 30 2010 12:00AM', @FechaVencimiento = 'Jun  8 2010 12:00AM', @CEE = N'80156107561885', @IdTransportista = NULL, @TransportistaCUIT = N'', @IdChofer = NULL, @ChoferCUIT = N''

exec wCartasDePorte_A @IdCartaDePorte = -1, @NumeroCartaDePorte = 508328472, @IdUsuarioIngreso = 0, @FechaIngreso = NULL, @Anulada = N'', @IdUsuarioAnulo = NULL, @FechaAnulacion = NULL, @Observaciones = N'Horreos del Sudeste c/ - KM 240 - Tarifa $ 82,81', @FechaTimeStamp = 0, @Vendedor = NULL, @CuentaOrden1 = NULL, @CuentaOrden2 = NULL, @Corredor = NULL, @Procedencia = N'722', @Patente = N'0', @IdArticulo = 4, @IdStock = NULL, @Partida = N'', @IdUnidad = NULL, @IdUbicacion = NULL, @Cantidad = 0.000000000000000e+000, @Cupo = N'', @NetoProc = 2.996000000000000e+004, @Calidad = N'0', @BrutoPto = 4.536000000000000e+004, @TaraPto = 0.000000000000000e+000, @NetoPto = 0.000000000000000e+000, @Acoplado = N'0', @Humedad = 1.700000000000000e+001, @Merma = 1.300000000000000e+003, @NetoFinal = 0.000000000000000e+000, @FechaDeCarga = 'Abr 30 2010 12:00AM', @FechaVencimiento = 'Jun  8 2010 12:00AM', @CEE = N'80156107561885', @IdTransportista = NULL, @TransportistaCUIT = N''
, @IdChofer = NULL, @ChoferCUIT = N'', @CTG = 0, 
@Entregador = 0,@Contrato = 0 , @Destino = NULL, @Subcontr1 = NULL, @Subcontr2 = NULL
, @Contrato1 = 0, @contrato2 = 0, @KmARecorrer = 0.000000000000000e+000
, @Tarifa = 0.000000000000000e+000, @FechaDescarga = 'Ene  1 1753 12:00AM', @Hora = 'Ene  1 1753 12:00AM'
, @NRecibo = 0, @CalidadDe = NULL, @TaraFinal = 0.000000000000000e+000, @BrutoFinal = 0.000000000000000e+000, @Fumigada = 0.000000000000000e+000
, @Secada = 0.000000000000000e+000, @Exporta = 0, @NobleExtranos = 0.000000000000000e+000, @NobleNegros = 0.000000000000000e+000
, @NobleQuebrados = 0.000000000000000e+000, @NobleDaniados = 0.000000000000000e+000, @NobleChamico = 0.000000000000000e+000
, @NobleChamico2 = 0.000000000000000e+000, @NobleRevolcado = 0.000000000000000e+000, @NobleObjetables = 0.000000000000000e+000
, @NobleAmohosados = 0.000000000000000e+000, @NobleHectolitrico = 0.000000000000000e+000, @NobleCarbon = 0.000000000000000e+000
, @NoblePanzaBlanca = 0.000000000000000e+000, @NoblePicados = 0.000000000000000e+000
, @NobleAcidezGrasa = 0.000000000000000e+000, @NobleVerdes = 0.000000000000000e+000, @NobleMGrasa = 0.000000000000000e+000
, @NobleGrado = 0
, @NobleConforme = 0
, @NobleACamara = 0
*/


    


--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_T]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wCartasDePorte_T
go


CREATE  PROCEDURE [dbo].wCartasDePorte_T
    @IdCartaDePorte INT = NULL

AS 
    SET NOCOUNT ON

    SET @IdCartaDePorte = ISNULL(@IdCartaDePorte, -1)

    if   @IdCartaDePorte=-1
begin
--esto en web no tiene sentido. te estas trayendo TODA la tabla
    SELECT  CDP.*,
            CLIVEN.Razonsocial AS VendedorDesc,
            CLICO1.Razonsocial AS CuentaOrden1Desc,
            CLICO2.Razonsocial AS CuentaOrden2Desc,
            CLICOR.Nombre AS CorredorDesc,
            CLIENT.Razonsocial AS EntregadorDesc,
            CLISC1.Razonsocial AS Subcontr1Desc,
            CLISC2.Razonsocial AS Subcontr2Desc,
            Articulos.Descripcion AS Producto,
            Transportistas.RazonSocial,
--Choferes.RazonSocial,
            LOCORI.Nombre AS ProcedenciaDesc,
            LOCDES.Descripcion AS DestinoDesc,
            DATENAME(month, FechaDescarga) AS Mes,
            DATEPART(year, FechaDescarga) AS Ano 

--IdCartaDePorte,NumeroCartaDePorte,Arribo,Hora,Exporta,Producto, 
    FROM    CartasDePorte CDP
            LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
            LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
            LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
            LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
            LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
            LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
            LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
            LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista
--LEFT OUTER JOIN Choferes ON CDP.IdCliente = Choferes.IdCliente
            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad
            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
    WHERE   @IdCartaDePorte = -1
            OR ( IdCartaDePorte = @IdCartaDePorte )
    --ORDER BY IdCartaDePorte DESC
end
else
begin
    SELECT  CDP.*,
            CLIVEN.Razonsocial AS VendedorDesc,
            CLICO1.Razonsocial AS CuentaOrden1Desc,
            CLICO2.Razonsocial AS CuentaOrden2Desc,
            CLICOR.Nombre AS CorredorDesc,
            CLIENT.Razonsocial AS EntregadorDesc,
            CLISC1.Razonsocial AS Subcontr1Desc,
            CLISC2.Razonsocial AS Subcontr2Desc,
            Articulos.Descripcion AS Producto,
            Transportistas.RazonSocial,
--Choferes.RazonSocial,
            LOCORI.Nombre AS ProcedenciaDesc,
            LOCDES.Descripcion AS DestinoDesc,
            DATENAME(month, FechaDescarga) AS Mes,
            DATEPART(year, FechaDescarga) AS Ano 

--IdCartaDePorte,NumeroCartaDePorte,Arribo,Hora,Exporta,Producto, 
    FROM    CartasDePorte CDP
            LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
            LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
            LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
            LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
            LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
            LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
            LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
            LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista
--LEFT OUTER JOIN Choferes ON CDP.IdCliente = Choferes.IdCliente
            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad
            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
    WHERE   --@IdCartaDePorte = -1            OR 
			( IdCartaDePorte = @IdCartaDePorte )

end


GO







--exec wCartasDePorte_T 
-- select * from vendedores
--select * from CartasDePorte
--select * from WilliamsDestinos

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[VistaCartasPorte]')
                    AND OBJECTPROPERTY(id, N'IsView') = 1 ) 
    DROP VIEW [VistaCartasPorte]
go


CREATE VIEW [dbo].[VistaCartasPorte]
as	

	      
    SELECT  IdCartaDePorte,
			
			cdp.NumeroCartaDePorte, numerosubfijo,subnumerovagon,
			cast (cdp.NumeroCartaDePorte as varchar) +'  '
				+cast (cdp.numerosubfijo as varchar) +'/'
				+cast (cdp.subnumerovagon as varchar) 	
				as NumeroCompleto,
			GETDATE() - cdp.FechaModificacion as FechaDif,
			E1.Nombre as UsuarioIngreso,
			
			Exporta, Vendedor,cdp.IdArticulo,cdp.corredor,cuentaorden2,entregador,procedencia,destino,
			
					NetoProc,
                      BrutoPto,
                      TaraPto,
                      NetoPto,
                      Acoplado,
                      Humedad,
					  cdp.HumedadDesnormalizada,
                      Merma,
					 TaraFinal,
					 BrutoFinal,
					 NetoFinal
                

			,cdp.Observaciones,
			cdp.puntoventa,FechaModificacion,
			NRecibo, Hora,Calidad,Patente,
			cdp.FechaArribo,cdp.FechaDescarga,cdp.Contrato,
	        CLIVEN.Razonsocial AS VendedorDesc,
            CLICO1.Razonsocial AS CuentaOrden1Desc,
            CLICO2.Razonsocial AS CuentaOrden2Desc,
            CLICOR.Nombre AS CorredorDesc,
            CLIENT.Razonsocial AS EntregadorDesc,
            CLISC1.Razonsocial AS Subcontr1Desc,
            CLISC2.Razonsocial AS Subcontr2Desc,
            Articulos.Descripcion AS Producto,
          
			 Transportistas.cuit as  TransportistaCUIT,
			 Transportistas.RazonSocial AS TransportistaDesc,
			
			choferes.cuil as  ChoferCUIT,
			choferes.Nombre as  ChoferDesc,

			isnull(LOCORI.Nombre,'') AS ProcedenciaDesc,
			isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,

            isnull(LOCDES.Descripcion,'') AS DestinoDesc,
			isnull(LOCDES.CodigoONCAA,'') AS DestinoCodigoONCAA,

            
			DATENAME(month, FechaDescarga) AS Mes,
            DATEPART(year, FechaDescarga) AS Ano,
	
				CEE,cdp.FechaIngreso,cdp.FechaVencimiento,cdp.ctg,cdp.KmARecorrer,cdp.TarifaFacturada,cdp.FechaAnulacion,cdp.MotivoAnulacion

    FROM    CartasDePorte CDP
            LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
            LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
            LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
            LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
            LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
            LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
            LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
            LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista
			LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer
            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad
            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
            LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado
            --LEFT OUTER JOIN Empleados E2 ON Proveedores.IdUsuarioModifico = E2.IdEmpleado

GO

            

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasPorte_TTpaginadoYfiltrado]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wCartasPorte_TTpaginadoYfiltrado
go



CREATE  PROCEDURE [dbo].wCartasPorte_TTpaginadoYfiltrado
(

	@ColumnaParaFiltrar  nvarchar(50)=null,
	@TextoParaFiltrar    nvarchar(50)=null,
	
	@sortExpression      nvarchar(50),
	
    @startRowIndex int,
    @maximumRows int
)
AS

--<asp:ListItem Text="Numero" Value="NumeroCartaDePorte" />
 --                       <asp:ListItem Text="Arribo" Value="FechaArribo" />
 --                       <asp:ListItem Text="Titular" Value="VendedorDesc" />
 --                       <asp:ListItem Text="Intermediario" Value="CuentaOrden1Desc" />
 --                       <asp:ListItem Text="R.Comercial" Value="CuentaOrden2Desc" />
 --                       <asp:ListItem Text="Corredor" Value="CorredorDesc" />
 --                       <asp:ListItem Text="Destinatario" Value="EntregadorDesc" />
 --                       <asp:ListItem Text="Producto" Value="Producto" />
 --                       <asp:ListItem Text="Origen" Value="ProcedenciaDesc" />
 --                       <asp:ListItem Text="Destino" Value="DestinoDesc" />
 --                       <asp:ListItem Text="Descarga" Value="FechaDescarga" />
 --                       <asp:ListItem Text="Neto" Value="NetoFinal" />
 --                       <asp:ListItem Text="Export" Value="Export" />


-- http://www.4guysfromrolla.com/webtech/042606-1.shtml acá explican cómo paginar 
-- http://www.4guysfromrolla.com/articles/040407-1.aspx y acá explican cómo paginar Y filtrar. Naturalmente, necesitas los (fastidiosos) parametros de filtrado
-- http://stackoverflow.com/questions/149380/dynamic-sorting-within-sql-stored-procedures acá se discute sobre NO usar SQL dinamico 


DECLARE @first_id int, @startRow int
	
set @ColumnaParaFiltrar='NumeroCartaDePorte' 
set @TextoParaFiltrar='' 

-- A check can be added to make sure @startRowIndex isn't > count(1)
-- from employees before doing any actual work unless it is guaranteed
-- the caller won't do that

-- Get the first employeeID for our page of records
SET ROWCOUNT @startRowIndex



SELECT @first_id = IdCartaDePorte 
FROM CartasDePorte 
--WHERE 
--NumeroCartaDePorte LIKE '*'+@TextoParaFiltrar+'*'

	--CASE @ColumnaParaFiltrar
	--	WHEN 'NumeroCartaDePorte' THEN NumeroCartaDePorte
	--	WHEN 'VendedorDesc' THEN VendedorDesc 
	--END
	--	LIKE '%'+@TextoParaFiltrar+'%'

ORDER BY IdCartaDePorte DESC



-- Now, set the row count to MaximumRows and get
-- all records >= @first_id
SET ROWCOUNT @maximumRows


--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------



SELECT * 
FROM CartasDePorte 
WHERE 


--NumeroCartaDePorte LIKE '*'+@TextoParaFiltrar+'*'  AND

	--CASE @ColumnaParaFiltrar
	--	WHEN 'NumeroCartaDePorte' THEN NumeroCartaDePorte
	--	WHEN 'VendedorDesc' THEN VendedorDesc 
	--	ELSE NULL
	--END
	--	LIKE '%'+@TextoParaFiltrar+'%'
	
 --	AND 
	
	IdCartaDePorte <= @first_id
ORDER BY IdCartaDePorte DESC



--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

SET ROWCOUNT 0





 


--IF @DepartmentID IS NULL
--   -- If @DepartmentID is null, then we want to get all employees
--   EXEC dbo.GetEmployeesSubsetSorted @sortExpression, @startRowIndex, @maximumRows
--ELSE
-- BEGIN
--   -- Otherwise we want to get just those employees in the specified department
--   IF LEN(@sortExpression) = 0
--      SET @sortExpression = 'EmployeeID'

--   -- Since @startRowIndex is zero-based in the data Web control, but one-based w/ROW_NUMBER(), increment
--   SET @startRowIndex = @startRowIndex + 1


--   --dios mio, como puede ser que sean necesarias estas sentencias dinamicas....

--   -- Issue query
--   DECLARE @sql nvarchar(4000)
--   SET @sql = 'SELECT EmployeeID, LastName, FirstName, DepartmentID, Salary, 
--            HireDate, DepartmentName
--   FROM
--      (SELECT EmployeeID, LastName, FirstName, e.DepartmentID, Salary, 
--            HireDate, d.Name as DepartmentName,
--            ROW_NUMBER() OVER(ORDER BY ' + @sortExpression + ') as RowNum
--       FROM Employees e
--         INNER JOIN Departments d ON
--            e.DepartmentID = d.DepartmentID
--       WHERE e.DepartmentID = ' + CONVERT(nvarchar(10), @DepartmentID) + '
--      ) as EmpInfo
--   WHERE RowNum BETWEEN ' + CONVERT(nvarchar(10), @startRowIndex) + 
--               ' AND (' + CONVERT(nvarchar(10), @startRowIndex) + ' + ' 
--               + CONVERT(nvarchar(10), @maximumRows) + ') - 1'
      
--   -- Execute the SQL query
--   EXEC sp_executesql @sql
-- END






GO


/*
EXEC dbo.wCartasPorte_TTpaginadoYfiltrado 'NumeroCartaDePorte','20','',1,120



SELECT vendedordesc,*
FROM VistaCartasPorte 
WHERE vendedordesc LIKE '%'+ 'ACA' + '%'


*/

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////



--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[VistaCartasPorteMovimientos]')
                    AND OBJECTPROPERTY(id, N'IsView') = 1 ) 
    DROP VIEW [VistaCartasPorteMovimientos]
go


CREATE VIEW [dbo].[VistaCartasPorteMovimientos]
as	      
    SELECT  --CDP.*,
			--movs.Anulada,
			movs.*,
			--movs.Contrato,
			--movs.Entrada_o_Salida,
		
			--movs.FechaAnulacion,
			--movs.FechaIngreso,
			--movs.IdAjusteStock,
			--movs.IdCDPMovimiento,
			--movs.Observaciones,
			--movs.Puerto,
			--movs.Tipo,
			--movs.Vapor,
			--movs.Partida,
			
			CDP.NetoPto,
			CDP.Humedad,
			CDP.Calidad,
			CDP.Merma,
			CDP.NetoFinal,
			CDP.ProcedenciaDesc,
			CDP.NRecibo,
			'' as SubtotalPorRecibo,
			CDP.Patente,
			CDP.NumeroCartadePorte,
			--CDP.FechaIngreso,
			CDP.CorredorDesc as CDPCorredorDesc,
			CDP.VendedorDesc as CDPVendedorDesc,
			CDP.exporta,

			MOVSVEN.Razonsocial AS ExportadorOrigen,
            MOVSCORR.Razonsocial AS ExportadorDestino,
            Articulos.Descripcion AS MovProductoDesc,
            MOVSDES.Descripcion AS MovDestinoDesc
         

    FROM    CartasPorteMovimientos MOVS
			LEFT OUTER JOIN [VistaCartasPorte] CDP ON MOVS.idcartadeporte=CDP.idcartadeporte

            LEFT OUTER JOIN Clientes MOVSVEN ON MOVS.IdExportadorOrigen = MOVSVEN.IdCliente
            LEFT OUTER JOIN Clientes MOVSCORR ON MOVS.IdExportadorDestino = MOVSCORR.IdCliente
            LEFT OUTER JOIN WilliamsDestinos MOVSDES ON MOVS.Puerto = MOVSDES.IdWilliamsDestino
            LEFT OUTER JOIN Articulos ON MOVS.IdArticulo = Articulos.IdArticulo
            
   


GO


--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_FacturacionAutomatica]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wCartasDePorte_TX_FacturacionAutomatica]
go



CREATE PROCEDURE [dbo].[wCartasDePorte_TX_FacturacionAutomatica]

@PuntoVenta int

AS

select distinct  

--ColumnaTilde ,
--IdCartaDePorte,
-- IdArticulo,
-- NumeroCartaDePorte, 
-- SubNumeroVagon,
-- SubnumeroDeFacturacion,  FechaArribo,  FechaDescarga,   FacturarselaA,  
-- IdFacturarselaA              		  ,Confirmado,           
-- IdCodigoIVA 		  , CUIT,            ClienteSeparado ,  		 
--  TarifaFacturada            ,
--  Producto,          KgNetos,  IdCorredor, 
--  IdTitular ,      IdIntermediario ,   IdRComercial, 
--  IdDestinatario,             		 
-- Titular  ,        
--   Intermediario  ,  [R. Comercial]  ,        
-- Corredor    ,  		  Destinatario,          
-- DestinoDesc  		 ,        
--   		[Procedcia.] ,            
-- IdDestino   

ColumnaTilde ,
cast (ISNULL(IdCartaDePorte,0) as int)  as IdCartaDePorte, 
cast (ISNULL( IdArticulo,0) as int) as IdArticulo,
ISNULL( NumeroCartaDePorte,0) as NumeroCartaDePorte,
cast (ISNULL( SubNumeroVagon,0) as int) as SubNumeroVagon,
cast (ISNULL( SubnumeroDeFacturacion,0) as int) as SubnumeroDeFacturacion, 
ISNULL( FechaArribo,0) as FechaArribo, 
ISNULL( FechaDescarga,0) as FechaDescarga,  
ISNULL( FacturarselaA,'') as FacturarselaA,  
cast (ISNULL( IdFacturarselaA ,0) as int) as   IdFacturarselaA          		  ,
Confirmado,           
 cast (ISNULL(IdCodigoIVA ,0) as int) as	IdCodigoIVA	  , 
 ISNULL(CUIT,'') as CUIT,            
 ClienteSeparado ,  		 
ISNULL(dbo.wTarifaWilliams( CDP.IdFacturarselaA ,CDP.IdArticulo,CDP.IdDestino , case when isnull(Exporta,'NO')='SI' then 1 else 0 end ,0   ) ,0) as TarifaFacturada  ,
  ISNULL(Producto,'') as Producto ,        
  ISNULL(  KgNetos,0.0) as KgNetos, 
  cast (ISNULL( IdCorredor,0) as int) as IdCorredor, 
 cast (ISNULL( IdTitular,0) as int) as IdTitular ,    
 cast (ISNULL(  IdIntermediario,0) as int) as IdIntermediario ,  
 cast (ISNULL( IdRComercial,0) as int) as IdRComercial, 
 cast (ISNULL( IdDestinatario,0) as int) as IdDestinatario,             		 
 ISNULL(Titular,'') as Titular ,        
  ISNULL( Intermediario,'')  as Intermediario,  
  ISNULL([R. Comercial],'') as [R. Comercial] ,        
 ISNULL(Corredor,'')  as  Corredor,  		 
 ISNULL( Destinatario,'') as Destinatario,          
 ISNULL(DestinoDesc ,'')  as	DestinoDesc	 ,        
ISNULL(  		[Procedcia.],'')  as [Procedcia.],            
cast (ISNULL( IdDestino,0) as int) as  IdDestino ,
cast (ISNULL( IdCartaOriginal,0) as int) as IdCartaOriginal,
 ISNULL( AgregaItemDeGastosAdministrativos,'') as AgregaItemDeGastosAdministrativos

 
from (          

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--tit
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde ,IdCartaDePorte, CDP.IdArticulo,               NumeroCartaDePorte, 
SubNumeroVagon,CDP.SubnumeroDeFacturacion, FechaArribo, FechaDescarga,  CLIVEN.razonsocial as FacturarselaA,  CLIVEN.idcliente as IdFacturarselaA              		  ,isnull(CLIVEN.Confirmado,'NO') as Confirmado,           CLIVEN.IdCodigoIVA  		  ,CLIVEN.CUIT,           '' as ClienteSeparado ,  		 
0.0 as TarifaFacturada            ,Articulos.Descripcion as  Producto,         NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,    CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,             		 CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,     		 CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],      		 CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc  		 ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino   , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
  from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIVEN.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino    
-- INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
 where CLIVEN.SeLeFacturaCartaPorteComoTitular='SI'    and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta

union ALL
   

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--co1 intermediario
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, 
SubNumeroVagon,CDP.SubnumeroDeFacturacion   , FechaArribo,        FechaDescarga  ,      CLICO1.razonsocial as FacturarselaA,  CLICO1.idcliente as IdFacturarselaA    	  ,isnull(CLICO1.Confirmado,'NO') as Confirmado,           CLICO1.IdCodigoIVA    		  ,CLICO1.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,     CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,              CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino    , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
 from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICO1.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino    
-- INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
 where CLICO1.SeLeFacturaCartaPorteComoIntermediario='SI'   and isnull(CDP.IdClienteAFacturarle,-1) <= 0            
 and cdp.puntoVenta=@PuntoVenta


union ALL
   

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--co2 rem comercial
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, SubNumeroVagon ,CDP.SubnumeroDeFacturacion  , 
FechaArribo,        FechaDescarga  ,      CLICO2.razonsocial as FacturarselaA,  CLICO2.idcliente as IdFacturarselaA    	  ,isnull(CLICO2.Confirmado,'NO') as Confirmado,           CLICO2.IdCodigoIVA    		  ,CLICO2.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,    CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,               CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino   , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
  from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICO2.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta   
 where CLICO2.SeLeFacturaCartaPorteComoRemComercial='SI'   and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta


union ALL

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--cliente auxiliar
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, SubNumeroVagon ,CDP.SubnumeroDeFacturacion  , 
FechaArribo,        FechaDescarga  ,      CLIAUX.razonsocial as FacturarselaA,  CLIAUX.idcliente as IdFacturarselaA    	  ,isnull(CLICO2.Confirmado,'NO') as Confirmado,           CLICO2.IdCodigoIVA    		  ,CLICO2.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor,
 Vendedor as IdTitular,    CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario, 
               CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,     
			      CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,   
				        		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino   , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
  from CartasDePorte CDP    
  LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar = CLIAUX.IdCliente     
  LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     
  LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICO2.idListaPrecios = LPD.idListaPrecios    
  LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     
  LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     
  LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     
  LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     
  LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     
  LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista    
   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     
   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     
   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta   
 where CLIAUX.SeLeFacturaCartaPorteComoClienteAuxiliar='SI'   and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta


union ALL

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--destinatario local
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////

SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, 
SubNumeroVagon  ,CDP.SubnumeroDeFacturacion , FechaArribo,        FechaDescarga  ,      CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA    	  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,           CLIENT.IdCodigoIVA    		  ,CLIENT.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,   CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,                CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos    ,cdp.exporta
from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIENT.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
where CLIENT.SeLeFacturaCartaPorteComoDestinatario='SI' and isnull(CDP.Exporta,'NO')='NO'
 and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta


union ALL
  

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--destinatario exportador
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, 
SubNumeroVagon  ,CDP.SubnumeroDeFacturacion , FechaArribo,        FechaDescarga  ,      CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA    	  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,           CLIENT.IdCodigoIVA    		  ,CLIENT.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,   CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,                CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
    from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIENT.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
where CLIENT.SeLeFacturaCartaPorteComoDestinatarioExportador='SI' and CDP.Exporta='SI'
	and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta


union ALL
  

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--corredor
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, 
SubNumeroVagon,CDP.SubnumeroDeFacturacion   , FechaArribo,        FechaDescarga  ,      CLICORCLI.razonsocial as FacturarselaA,  CLICORCLI.idcliente as IdFacturarselaA    	  ,isnull(CLICORCLI.Confirmado,'NO') as Confirmado,           CLICORCLI.IdCodigoIVA    		  ,CLICORCLI.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, 
Vendedor as IdTitular,  CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,                 CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino     , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
from CartasDePorte CDP    LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     
LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICORCLI.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
where CLICORCLI.SeLeFacturaCartaPorteComoCorredor='SI'   and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta


union ALL


--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--cliente explicito (originales)
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, SubNumeroVagon ,
CDP.SubnumeroDeFacturacion  , FechaArribo,        FechaDescarga  ,      CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA    	  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,           CLIENT.IdCodigoIVA    		  ,CLIENT.CUIT,           '' as ClienteSeparado ,  		 
0.0 as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,      CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,             CLIVEN.Razonsocial as   Titular  ,
        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],      
		 CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 
		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino   , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
		 from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLIENT ON CDP.IdClienteAFacturarle = CLIENT.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON isnull(CLIENT.idListaPrecios,1 ) = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
where CDP.IdClienteAFacturarle > 0            
 and cdp.puntoVenta=@PuntoVenta


union ALL

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--cliente explicito (duplicados)
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,CDPduplicadas.IdCartaDePorte, CDP.IdArticulo,    CDP.NumeroCartaDePorte, 
	CDP.SubNumeroVagon ,CDPduplicadas.SubnumeroDeFacturacion  , CDP.FechaArribo,        CDP.FechaDescarga  ,      
	CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA    
		  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,
    CLIENT.IdCodigoIVA    		  ,CLIENT.CUIT,           '' as ClienteSeparado ,  		 
	0.0 as TarifaFacturada       ,Articulos.Descripcion as  Producto,    CDP.NetoFinal  as  KgNetos , 
	CDP.Corredor as IdCorredor, CDP.Vendedor as IdTitular,   CDP.CuentaOrden1 as IdIntermediario, 
	CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,          CLIVEN.Razonsocial as   Titular  ,        
	CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],
    CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 
	LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino    ,
	CDP.IdCartaDePorte as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta

from CartasDePorte CDP    
LEFT OUTER JOIN CartasDePorte CDPduplicadas ON CDP.NumeroCartaDePorte = CDPduplicadas.NumeroCartaDePorte and  CDP.SubNumeroVagon = CDPduplicadas.SubNumeroVagon and CDPduplicadas.SubnumeroDeFacturacion>0    
LEFT OUTER JOIN Clientes CLIENT ON CDPduplicadas.IdClienteAFacturarle = CLIENT.IdCliente     
LEFT OUTER JOIN ListasPreciosDetalle LPD ON isnull(CLIENT.idListaPrecios,1 ) = LPD.idListaPrecios    
LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     
LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
where CDP.IdClienteAFacturarle > 0     
 and cdp.puntoVenta=@PuntoVenta


)  as CDP 


GO





--wCartasDePorte_TX_FacturacionAutomatica 2

--select distinct * from cartasdeporte order by 
--CASE  
--				WHEN isnull(numerocartadeporte,0)=0
--					THEN '    ' + numerocartadeporte
--					ELSE numerocartadeporte
--			END asc



--left(numerocartadeporte,1)
--order by 	 

-- '  ' + FacturarselaA asc

--CASE  
--				WHEN isnull(TarifaFacturada,0)=0
--					THEN '    ' + FacturarselaA
--					ELSE FacturarselaA
--			END as Orden
--		ASC
--DELETE wTempCartasPorteFacturacionAutomatica
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorteMovimientos_TT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wCartasDePorteMovimientos_TT
go


CREATE  PROCEDURE [dbo].wCartasDePorteMovimientos_TT
    
AS 
    SET NOCOUNT ON

    
      
    SELECT  * from vistaCartasPorteMovimientos 
			
GO

--select * from cartaportemovimientos
--exec wCartasDePorteMovimientos_TT

--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_InformesLiviano]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wCartasDePorte_TX_InformesLiviano
go



CREATE  PROCEDURE [dbo].wCartasDePorte_TX_InformesLiviano
    
	@IdCartaDePorte INT = NULL,
    @FechaDesde DATETIME = NULL,
    @FechaHasta DATETIME = NULL
AS 
    SET NOCOUNT ON

    SET @IdCartaDePorte = ISNULL(@IdCartaDePorte, -1)
    SET @FechaDesde = ISNULL(@FechaDesde, CONVERT(DATETIME, '1/1/1900'))
    SET @FechaHasta = ISNULL(@FechaHasta, CONVERT(DATETIME, '1/1/2100'))


      
    SELECT   
	cast (cdp.NumeroCartaDePorte as varchar) +'  '
				+cast (cdp.numerosubfijo as varchar) +'/'
				+cast (cdp.subnumerovagon as varchar) 	
				as NumeroCartaDePorte,
	Exporta, Vendedor,cdp.IdArticulo,cdp.corredor,cuentaorden2,entregador,procedencia,destino,
    NetoFinal,cdp.Anulada,netopto,cdp.Humedad,cdp.HumedadDesnormalizada,cdp.Observaciones,cdp.puntoventa,
     NRecibo, Hora,
    cdp.FechaArribo,cdp.FechaDescarga,cdp.Contrato,cdp.Merma,NetoProc,
            
            CLIVEN.Razonsocial AS VendedorDesc,
            CLICO1.Razonsocial AS CuentaOrden1Desc,
            CLICO2.Razonsocial AS CuentaOrden2Desc,
			
            CASE WHEN CLICOR2.Nombre IS NULL THEN 
						CLICOR.Nombre
                 ELSE 
						CLICOR.Nombre + ' - '+ CLICOR2.Nombre
            END 
				AS CorredorDesc,

            CLIENT.Razonsocial AS EntregadorDesc,
            CLISC1.Razonsocial AS Subcontr1Desc,
            CLISC2.Razonsocial AS Subcontr2Desc,
            Articulos.Descripcion AS Producto,
            Transportistas.RazonSocial AS TransportistaDesc,
--Choferes.RazonSocial,



            isnull(LOCORI.Nombre,'') AS ProcedenciaDesc,
		isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,

            isnull(LOCDES.Descripcion,'') AS DestinoDesc,
			 isnull(LOCDES.CodigoONCAA,'') AS DestinoCodigoONCAA,    
   
               			DATENAME(month, FechaDescarga) AS Mes,
            DATEPART(year, FechaDescarga) AS Ano, 

--null as TarifaSubcontratista1,
--null as TarifaSubcontratista2,
            --FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-'
            --+ CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,
            --FAC.FechaFactura,
            --CLIFAC.RazonSocial AS ClienteFacturado,
            Calidades.Descripcion AS CalidadDesc,
			IdCartaDePorte





--IdCartaDePorte,NumeroCartaDePorte,Arribo,Hora,Exporta,Producto, 
    FROM    CartasDePorte CDP
            LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
            LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
            LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
            LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
            LEFT OUTER JOIN Vendedores CLICOR2 ON CDP.Corredor2 = CLICOR2.IdVendedor
            LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
            LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
            LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
            LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad
            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista
--LEFT OUTER JOIN Choferes ON CDP.IdCliente = Choferes.IdCliente
            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad
            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
            LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura
            LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente
    WHERE   --@IdCartaDePorte=-1 or 
		--(IdCartaDePorte=@IdCartaDePorte) AND 
            NOT ( Vendedor IS NULL
                  OR CLIVEN.Razonsocial = ''
                  OR Corredor IS NULL
                  OR Entregador IS NULL
                  OR CDP.IdArticulo IS NULL
                )
            AND ISNULL(NetoFinal, 0) > 0
            AND ISNULL(CDP.Anulada, 'NO') <> 'SI'
            AND ISNULL(CDP.SubnumeroDeFacturacion, 0) <= 0
            AND ( ISNULL(FechaDescarga, '1/1/1753') BETWEEN @FechaDesde
                                                    AND     @FechaHasta )

--solo incluir las descargas (tambien las descargas facturadas
    ORDER BY IdCartaDePorte DESC


GO


--exec wCartasDePorte_TX_InformesLiviano @IdCartaDePorte = -1


-- select * from facturas
--exec wCartasDePorte_T 
-- select * from vendedores
--select * from WilliamsDestinos

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_Informes]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wCartasDePorte_TX_Informes
go



CREATE  PROCEDURE [dbo].[wCartasDePorte_TX_Informes]
    @IdCartaDePorte INT = NULL,
    @FechaDesde DATETIME = NULL,
    @FechaHasta DATETIME = NULL
AS 
    SET NOCOUNT ON

    SET @IdCartaDePorte = ISNULL(@IdCartaDePorte, -1)
    SET @FechaDesde = ISNULL(@FechaDesde, CONVERT(DATETIME, '1/1/1900'))
    SET @FechaHasta = ISNULL(@FechaHasta, CONVERT(DATETIME, '1/1/2100'))

      
    SELECT  CDP.*,
			CodigoSAJPYA,	
            CLIVEN.Razonsocial AS VendedorDesc,
            CLICO1.Razonsocial AS CuentaOrden1Desc,
            CLICO2.Razonsocial AS CuentaOrden2Desc,
			
            CASE WHEN CLICOR2.Nombre IS NULL THEN 
						CLICOR.Nombre
                 ELSE 
						CLICOR.Nombre + ' - '+ CLICOR2.Nombre
            END 
				AS CorredorDesc,

            CLIENT.Razonsocial AS EntregadorDesc,
            CLISC1.Razonsocial AS Subcontr1Desc,
            CLISC2.Razonsocial AS Subcontr2Desc,
            Articulos.Descripcion AS Producto,


            Transportistas.RazonSocial AS TransportistaDesc,
			 Transportistas.cuit as  TransportistaCUIT,
 choferes.cuil as  choferCUIT,
--Choferes.RazonSocial,

  isnull(LOCORI.Nombre,'') AS ProcedenciaDesc,
			isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal,
		isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,

            isnull(LOCDES.Descripcion,'') AS DestinoDesc,
			--LOCDES.CodigoPostal AS  DestinoCodigoPostal,
			LOCDES.codigoONCAA AS  DestinoCodigoONCAA,

            
   
               			DATENAME(month, FechaDescarga) AS Mes,
            DATEPART(year, FechaDescarga) AS Ano, 

--null as TarifaSubcontratista1,
--null as TarifaSubcontratista2,
            FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-'
            + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,
            FAC.FechaFactura,
            CLIFAC.RazonSocial AS ClienteFacturado,
            Calidades.Descripcion AS CalidadDesc



--IdCartaDePorte,NumeroCartaDePorte,Arribo,Hora,Exporta,Producto, 
    FROM    CartasDePorte CDP
            LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
            LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
            LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
            LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
            LEFT OUTER JOIN Vendedores CLICOR2 ON CDP.Corredor2 = CLICOR2.IdVendedor
            LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
            LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
            LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
            LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad
            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista
			LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer
            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad
            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
            LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura
            LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente
    WHERE   --@IdCartaDePorte=-1 or 
		--(IdCartaDePorte=@IdCartaDePorte) AND 
            NOT ( Vendedor IS NULL
                  OR CLIVEN.Razonsocial = ''
                  OR Corredor IS NULL
                  OR Entregador IS NULL
                  OR CDP.IdArticulo IS NULL
                )
            AND ISNULL(NetoFinal, 0) > 0
            AND ISNULL(CDP.Anulada, 'NO') <> 'SI'
            AND ISNULL(CDP.SubnumeroDeFacturacion, 0) <= 0
            AND ( ISNULL(FechaDescarga, '1/1/1753') BETWEEN @FechaDesde
                                                    AND     @FechaHasta )

--solo incluir las descargas (tambien las descargas facturadas
    ORDER BY IdCartaDePorte DESC




GO


--exec wCartasDePorte_TX_Informes @IdCartaDePorte = -1
--exec dbo.wCartasDePorte_TX_InformesCorregido @IdCartaDePorte=-1,@FechaDesde='1753-01-01 00:00:00',@FechaHasta='2100-01-01 00:00:00'
--exec wCartasDePorte_TX_Informes @IdCartaDePorte = -1, @FechaDesde = 'Ene  1 1753 12:00AM', @FechaHasta = 'Ene  1 2100 12:00AM'
--exec wCartasDePorte_TX_Informes @IdCartaDePorte = -1, @FechaDesde = 'Ene 31 2000 12:00AM', @FechaHasta = 'Ago 28 2010 12:00AM'


--exec wCartasDePorte_TX_Informes @IdCartaDePorte = -1, @FechaDesde = 'Ene  1 1753 12:00AM', @FechaHasta = 'Ene  1 2100 12:00AM'


-- select * from facturas
--exec wCartasDePorte_T 
-- select * from vendedores
--select * from WilliamsDestinos

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_Todas]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wCartasDePorte_TX_Todas
go


CREATE  PROCEDURE [dbo].wCartasDePorte_TX_Todas
    @IdCartaDePorte INT = NULL,
    @FechaDesde DATETIME = NULL,
    @FechaHasta DATETIME = NULL
AS 
    SET NOCOUNT ON

    SET @IdCartaDePorte = ISNULL(@IdCartaDePorte, -1)
    SET @FechaDesde = ISNULL(@FechaDesde, CONVERT(DATETIME, '1/1/1753'))
    SET @FechaHasta = ISNULL(@FechaHasta, CONVERT(DATETIME, '1/1/2100'))

      
    SELECT  CDP.*,
			
			cast (cdp.NumeroCartaDePorte as varchar) +
					CASE WHEN cdp.numerosubfijo<>0 OR cdp.subnumerovagon<>0 THEN 
						'  ' + cast (cdp.numerosubfijo as varchar) + '/' +cast (cdp.subnumerovagon as varchar) 	
					ELSE 
						''
					END							
				as NumeroCompleto,
		
			datediff(minute,cdp.FechaModificacion,GETDATE()) as MinutosModifico,


 			ISNULL(Articulos.AuxiliarString5,'') AS EspecieONCAA,	
 			ISNULL(Articulos.AuxiliarString6,'') AS CodigoSAJPYA,	
 			ISNULL(Articulos.AuxiliarString7,'') AS txtCodigoZeni,	
         


			isnull(CLIVEN.Razonsocial,'') AS TitularDesc,
            isnull(CLIVEN.cuit,'') AS TitularCUIT,
            
			isnull(CLICO1.Razonsocial,'') AS IntermediarioDesc,
            isnull(CLICO1.cuit,'') AS IntermediarioCUIT,
            
			isnull(CLICO2.Razonsocial,'') AS RComercialDesc,
            isnull(CLICO2.cuit,'') AS RComercialCUIT,
            
			isnull(CLICOR.Nombre,'') AS CorredorDesc,
            isnull(CLICOR.cuit,'') AS CorredorCUIT,
            
			isnull(CLIENT.Razonsocial,'') AS DestinatarioDesc,
            isnull(CLIENT.cuit,'') AS DestinatarioCUIT,
            


			isnull(CLISC1.Razonsocial,'') AS Subcontr1Desc,
            isnull(CLISC2.Razonsocial,'') AS Subcontr2Desc,
   
               isnull(Articulos.Descripcion,'') AS Producto,



			 Transportistas.cuit as  TransportistaCUIT,
            isnull(Transportistas.RazonSocial,'') AS TransportistaDesc,
			
			choferes.cuil as  ChoferCUIT,
			choferes.Nombre as  ChoferDesc,

			

            
            isnull(LOCORI.Nombre,'') AS ProcedenciaDesc,
			isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal,
			isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,


            isnull(LOCDES.Descripcion,'') AS DestinoDesc,
			--LOCDES.CodigoPostal AS  DestinoCodigoPostal,
		 	'' AS  DestinoCodigoPostal,
			isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA,

  
              
            DATENAME(month, FechaDescarga) AS Mes,
            DATEPART(year, FechaDescarga) AS Ano, 

--null as TarifaSubcontratista1,
--null as TarifaSubcontratista2,
            
         	FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,
            FAC.FechaFactura,
            isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado,
            isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT,

            
            			Calidades.Descripcion AS CalidadDesc,


						E1.Nombre as UsuarioIngreso
						,		isnull(ESTAB.Descripcion,'') + ' ' + Convert(varchar(200),isnull(ESTAB.AuxiliarString1,'')  COLLATE SQL_Latin1_General_CP1_CI_AS)+ ' ' + Convert(varchar(200),isnull(ESTAB.AuxiliarString2,'')  COLLATE SQL_Latin1_General_CP1_CI_AS ) as EstablecimientoDesc

--IdCartaDePorte,NumeroCartaDePorte,Arribo,Hora,Exporta,Producto, 


    FROM    CartasDePorte CDP
            LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
            LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
            LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
            LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
            LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
            LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
            LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
            LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad
            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista
			LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer
            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad
            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
			LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento
            LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura
            LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente
  LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado

                    
    WHERE   1=1
		--@IdCartaDePorte=-1 or 
		--(IdCartaDePorte=@IdCartaDePorte) AND 
          
            --AND ( ISNULL(FechaArribo, '1/1/1753') BETWEEN @FechaDesde  AND     @FechaHasta )

            AND ( ISNULL(FechaDescarga, FechaArribo) BETWEEN @FechaDesde AND     @FechaHasta )

--solo incluir las descargas (tambien las descargas facturadas
    ORDER BY IdCartaDePorte DESC




GO

--wCartasDePorte_TX_Todas
--select tarifa,tarifafacturada from cartasdeporte

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_Posiciones]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wCartasDePorte_TX_Posiciones
go


CREATE  PROCEDURE [dbo].wCartasDePorte_TX_Posiciones
    @FechaDesde DATETIME = NULL,
    @FechaHasta DATETIME = NULL
AS 
    SET NOCOUNT ON

    SET @FechaDesde = ISNULL(@FechaDesde, CONVERT(DATETIME, '1/1/1753'))
    SET @FechaHasta = ISNULL(@FechaHasta, CONVERT(DATETIME, '1/1/2100'))

      
    SELECT  CDP.*,
			
			cast (cdp.NumeroCartaDePorte as varchar) +
					CASE WHEN cdp.numerosubfijo<>0 OR cdp.subnumerovagon<>0 THEN 
						'  ' + cast (cdp.numerosubfijo as varchar) + '/' +cast (cdp.subnumerovagon as varchar) 	
					ELSE 
						''
					END							
				as NumeroCompleto,
		
			datediff(minute,cdp.FechaModificacion,GETDATE()) as MinutosModifico,


 			ISNULL(Articulos.AuxiliarString5,'') AS EspecieONCAA,	
 			ISNULL(Articulos.AuxiliarString6,'') AS CodigoSAJPYA,	
 			ISNULL(Articulos.AuxiliarString7,'') AS txtCodigoZeni,	
         


			isnull(CLIVEN.Razonsocial,'') AS TitularDesc,
            isnull(CLIVEN.cuit,'') AS TitularCUIT,
            
			isnull(CLICO1.Razonsocial,'') AS IntermediarioDesc,
            isnull(CLICO1.cuit,'') AS IntermediarioCUIT,
            
			isnull(CLICO2.Razonsocial,'') AS RComercialDesc,
            isnull(CLICO2.cuit,'') AS RComercialCUIT,
            
			isnull(CLICOR.Nombre,'') AS CorredorDesc,
            isnull(CLICOR.cuit,'') AS CorredorCUIT,
            
			isnull(CLIENT.Razonsocial,'') AS DestinatarioDesc,
            isnull(CLIENT.cuit,'') AS DestinatarioCUIT,
            


			isnull(CLISC1.Razonsocial,'') AS Subcontr1Desc,
            isnull(CLISC2.Razonsocial,'') AS Subcontr2Desc,
   
               isnull(Articulos.Descripcion,'') AS Producto,



			 Transportistas.cuit as  TransportistaCUIT,
            isnull(Transportistas.RazonSocial,'') AS TransportistaDesc,
			
			choferes.cuil as  ChoferCUIT,
			choferes.Nombre as  ChoferDesc,

			

            
            isnull(LOCORI.Nombre,'') AS ProcedenciaDesc,
			isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal,
			isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,


            isnull(LOCDES.Descripcion,'') AS DestinoDesc,
			--LOCDES.CodigoPostal AS  DestinoCodigoPostal,
		 	'' AS  DestinoCodigoPostal,
			isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA,

  
              
            DATENAME(month, FechaDescarga) AS Mes,
            DATEPART(year, FechaDescarga) AS Ano, 

--null as TarifaSubcontratista1,
--null as TarifaSubcontratista2,
            
         	FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,
            FAC.FechaFactura,
            isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado,
            isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT,

            
            			Calidades.Descripcion AS CalidadDesc,


						E1.Nombre as UsuarioIngreso


--IdCartaDePorte,NumeroCartaDePorte,Arribo,Hora,Exporta,Producto, 


    FROM    CartasDePorte CDP
            LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
            LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
            LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
            LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
            LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
            LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
            LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
            LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad
            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista
			LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer
            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad
            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
            LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura
            LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente
  LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado

                    
    WHERE   1=1
		--@IdCartaDePorte=-1 or 
		--(IdCartaDePorte=@IdCartaDePorte) AND 
          
            --AND ( ISNULL(FechaArribo, '1/1/1753') BETWEEN @FechaDesde  AND     @FechaHasta )

            AND ( ISNULL(FechaDescarga, FechaArribo) BETWEEN @FechaDesde AND     @FechaHasta )

--solo incluir las descargas (tambien las descargas facturadas
            AND NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR CDP.IdArticulo IS NULL) 
			AND ISNULL(NetoProc,0)=0 AND ISNULL(IdFacturaImputada,0)=0 AND ISNULL(CDP.Anulada,'NO')<>'SI' 


    ORDER BY IdCartaDePorte DESC




GO

--wCartasDePorte_TX_Todas
--select tarifa,tarifafacturada from cartasdeporte

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_DescargasDeHoyMasTodasLasPosiciones]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wCartasDePorte_TX_DescargasDeHoyMasTodasLasPosiciones
go


CREATE  PROCEDURE [dbo].wCartasDePorte_TX_DescargasDeHoyMasTodasLasPosiciones
    @FechaHoy DATETIME = NULL
    
AS 
    SET NOCOUNT ON

    SET @FechaHoy = ISNULL(@FechaHoy, GETDATE())
      
    SELECT  CDP.*,
			
			cast (cdp.NumeroCartaDePorte as varchar) +
					CASE WHEN cdp.numerosubfijo<>0 OR cdp.subnumerovagon<>0 THEN 
						'  ' + cast (cdp.numerosubfijo as varchar) + '/' +cast (cdp.subnumerovagon as varchar) 	
					ELSE 
						''
					END							
				as NumeroCompleto,
		
			datediff(minute,cdp.FechaModificacion,GETDATE()) as MinutosModifico,


 			ISNULL(Articulos.AuxiliarString5,'') AS EspecieONCAA,	
 			ISNULL(Articulos.AuxiliarString6,'') AS CodigoSAJPYA,	
 			ISNULL(Articulos.AuxiliarString7,'') AS txtCodigoZeni,	
         


			isnull(CLIVEN.Razonsocial,'') AS TitularDesc,
            isnull(CLIVEN.cuit,'') AS TitularCUIT,
            
			isnull(CLICO1.Razonsocial,'') AS IntermediarioDesc,
            isnull(CLICO1.cuit,'') AS IntermediarioCUIT,
            
			isnull(CLICO2.Razonsocial,'') AS RComercialDesc,
            isnull(CLICO2.cuit,'') AS RComercialCUIT,
            
			isnull(CLICOR.Nombre,'') AS CorredorDesc,
            isnull(CLICOR.cuit,'') AS CorredorCUIT,
            
			isnull(CLIENT.Razonsocial,'') AS DestinatarioDesc,
            isnull(CLIENT.cuit,'') AS DestinatarioCUIT,
            


			isnull(CLISC1.Razonsocial,'') AS Subcontr1Desc,
            isnull(CLISC2.Razonsocial,'') AS Subcontr2Desc,
   
               isnull(Articulos.Descripcion,'') AS Producto,



			 Transportistas.cuit as  TransportistaCUIT,
            isnull(Transportistas.RazonSocial,'') AS TransportistaDesc,
			
			choferes.cuil as  ChoferCUIT,
			choferes.Nombre as  ChoferDesc,

			

            
            isnull(LOCORI.Nombre,'') AS ProcedenciaDesc,
			isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal,
			isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,


            isnull(LOCDES.Descripcion,'') AS DestinoDesc,
			--LOCDES.CodigoPostal AS  DestinoCodigoPostal,
		 	'' AS  DestinoCodigoPostal,
			isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA,

  
              
            DATENAME(month, FechaDescarga) AS Mes,
            DATEPART(year, FechaDescarga) AS Ano, 

--null as TarifaSubcontratista1,
--null as TarifaSubcontratista2,
            
         	FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,
            FAC.FechaFactura,
            isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado,
            isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT,

            
            			Calidades.Descripcion AS CalidadDesc,


						E1.Nombre as UsuarioIngreso


--IdCartaDePorte,NumeroCartaDePorte,Arribo,Hora,Exporta,Producto, 


    FROM    CartasDePorte CDP
            LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
            LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
            LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
            LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
            LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
            LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
            LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
            LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad
            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista
			LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer
            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad
            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
            LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura
            LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente
  LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado

                    
    WHERE   1=1
		--@IdCartaDePorte=-1 or 
		--(IdCartaDePorte=@IdCartaDePorte) AND 
          
            --AND ( ISNULL(FechaArribo, '1/1/1753') BETWEEN @FechaDesde  AND     @FechaHasta )

--            AND ( ISNULL(FechaDescarga, FechaArribo) BETWEEN @FechaDesde AND     @FechaHasta )

--solo incluir las descargas (tambien las descargas facturadas
   AND 
        (                                               
            ( NOT (Vendedor IS NULL OR Corredor IS NULL OR Entregador IS NULL OR CDP.IdArticulo IS NULL) 
				AND 
			  ISNULL(NetoProc,0)=0 AND ISNULL(IdFacturaImputada,0)=0 AND ISNULL(CDP.Anulada,'NO')<>'SI' 
			 ) 
        OR                                              
            ( ISNULL(NetoProc,0)>0 AND fechadescarga >=@FechaHoy  )
        ) 

    ORDER BY IdCartaDePorte DESC

	
GO


--wCartasDePorte_TX_Todas
--select tarifa,tarifafacturada from cartasdeporte

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_InformesCorregido]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wCartasDePorte_TX_InformesCorregido
go


CREATE  PROCEDURE [dbo].wCartasDePorte_TX_InformesCorregido
    @IdCartaDePorte INT = NULL,
    @FechaDesde DATETIME = NULL,
    @FechaHasta DATETIME = NULL,

@idVendedor  INT = NULL,
@idCorredor INT = NULL, 
@idDestinatario INT = NULL, 
@idIntermediario INT = NULL,
@idRComercial INT = NULL, 
@idArticulo INT = NULL, 
@idProcedencia INT = NULL,
@idDestino INT = NULL

AS 
    SET NOCOUNT ON

    SET @IdCartaDePorte = ISNULL(@IdCartaDePorte, -1)
    SET @FechaDesde = ISNULL(@FechaDesde, CONVERT(DATETIME, '1/1/1900'))
    SET @FechaHasta = ISNULL(@FechaHasta, CONVERT(DATETIME, '1/1/2100'))
    SET @idVendedor = ISNULL(@idVendedor, -1)
    SET @idCorredor = ISNULL(@idCorredor, -1)
    SET @idDestinatario = ISNULL(@idDestinatario, -1)
    SET @idIntermediario = ISNULL(@idIntermediario, -1)
    SET @idRComercial = ISNULL(@idRComercial, -1)
    SET @idArticulo = ISNULL(@idArticulo, -1)
    SET @idProcedencia = ISNULL(@idProcedencia, -1)
    SET @idDestino = ISNULL(@idDestino, -1)

      
    SELECT  
			CDP.*,

			ISNULL(Articulos.AuxiliarString5,'') AS EspecieONCAA,	
 			ISNULL(Articulos.AuxiliarString6,'') AS CodigoSAJPYA,	
 			ISNULL(Articulos.AuxiliarString7,'') AS txtCodigoZeni,	

            
			isnull(CLIVEN.Razonsocial,'') AS TitularDesc,
            isnull(CLIVEN.cuit,'') AS TitularCUIT,
            
			isnull(CLICO1.Razonsocial,'') AS IntermediarioDesc,
            isnull(CLICO1.cuit,'') AS IntermediarioCUIT,
            
			isnull(CLICO2.Razonsocial,'') AS RComercialDesc,
            isnull(CLICO2.cuit,'') AS RComercialCUIT,
            
			isnull(CLICOR.Nombre,'') AS CorredorDesc,
            isnull(CLICOR.cuit,'') AS CorredorCUIT,
            
			isnull(CLIENT.Razonsocial,'') AS DestinatarioDesc,
            isnull(CLIENT.cuit,'') AS DestinatarioCUIT,
            


			isnull(CLISC1.Razonsocial,'') AS Subcontr1Desc,
            isnull(CLISC2.Razonsocial,'') AS Subcontr2Desc,
   
               isnull(Articulos.Descripcion,'') AS Producto,
            isnull(Transportistas.RazonSocial,'') AS TransportistaDesc,
            isnull(Choferes.Nombre,'') AS ChoferDesc,

--Choferes.RazonSocial,
            


            isnull(LOCORI.Nombre,'') AS ProcedenciaDesc,
			isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal,
		isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,
		isnull(LOCORI.CodigoWilliams,'') AS ProcedenciaCodigoWilliams,

            isnull(LOCDES.Descripcion,'') AS DestinoDesc,
			--LOCDES.CodigoPostal AS  DestinoCodigoPostal,
			isnull(LOCDES.CodigoPostal,'') AS  DestinoCodigoPostal,
			isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA, 
		isnull(LOCDES.CodigoWilliams,'') 	 AS  DestinoCodigoWilliams, 
		isnull(LOCDES.CUIT,'') 	 AS  DestinoCUIT, 

 choferes.cuil as  choferCUIT,
 Transportistas.cuit as  TransportistaCUIT,
              
            DATENAME(month, FechaDescarga) AS Mes,
            DATEPART(year, FechaDescarga) AS Ano, 

--null as TarifaSubcontratista1,
--null as TarifaSubcontratista2,
            
         	FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,
            FAC.FechaFactura,
            isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado,
            isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT,

            
            Calidades.Descripcion AS CalidadDesc,
			ExcluirDeSubcontratistas


--IdCartaDePorte,NumeroCartaDePorte,Arribo,Hora,Exporta,Producto, 
    FROM    CartasDePorte CDP
            LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente
            LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente
            LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente
            LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor
            LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente
            LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente
            LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente
            LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad
            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista
			LEFT OUTER JOIN Choferes ON CDP.Idchofer = Choferes.Idchofer
            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad
            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino
            LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura
            LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente
  
  
  

                    
    WHERE   --@IdCartaDePorte=-1 or 
		--(IdCartaDePorte=@IdCartaDePorte) AND 
            NOT ( Vendedor IS NULL
                  OR CLIVEN.Razonsocial = ''
                  OR Corredor IS NULL
                  OR Entregador IS NULL
                  OR CDP.IdArticulo IS NULL
                )
            AND ISNULL(NetoFinal, 0) > 0
            AND ISNULL(CDP.Anulada, 'NO') <> 'SI'
            AND ( ISNULL(FechaDescarga, '1/1/1753') BETWEEN @FechaDesde
                                                    AND     @FechaHasta )


and (
		(@idVendedor=Vendedor or @idIntermediario=CuentaOrden1 or  @idRComercial=CuentaOrden2)
		   or 
		(@idVendedor=-1 and  @idIntermediario=-1  and @idRComercial=-1)
	)
and (@idDestinatario=-1 or @idDestinatario=Entregador)
and (@idCorredor=-1 or @idCorredor=Corredor)
and (@idArticulo=-1 or @idArticulo=CDP.IdArticulo )
and (@idProcedencia=-1 or @idProcedencia=Procedencia)
and (@idDestino=-1 or @idDestino=Destino)


      

--solo incluir las descargas (tambien las descargas facturadas
    ORDER BY IdCartaDePorte DESC




GO



--exec wCartasDePorte_TX_InformesCorregido @IdCartaDePorte = -1
--exec wCartasDePorte_TX_Informes @IdCartaDePorte = -1, @FechaDesde = 'Ene  1 1753 12:00AM', @FechaHasta = 'Ene  1 2100 12:00AM'

--exec wCartasDePorte_TX_Informes @IdCartaDePorte = -1, @FechaDesde = 'Ene 31 2000 12:00AM', @FechaHasta = 'Ago 28 2010 12:00AM'
--wCartasDePorte_TX_InformesCorregido -1

--exec wCartasDePorte_TX_Informes @IdCartaDePorte = -1, @FechaDesde = 'Ene  1 1753 12:00AM', @FechaHasta = 'Ene  1 2100 12:00AM'


-- select * from facturas
--exec wCartasDePorte_T 
-- select * from vendedores
--select * from WilliamsDestinos

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

--/////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_E]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wCartasDePorte_E
go

CREATE PROCEDURE wCartasDePorte_E @IdCartaDePorte INT
AS 
    DELETE  CartasDePorte
    WHERE   ( IdCartaDePorte = @IdCartaDePorte )
GO



--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_PorNumero]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wCartasDePorte_TX_PorNumero
go

CREATE PROCEDURE [dbo].wCartasDePorte_TX_PorNumero
    @Numero BIGINT,
    @SubNumeroVagon INT = NULL
	--,@NumeroSubFijo  INT = NULL
AS 
    SELECT  *
    FROM    CartasDePorte
    WHERE   NumeroCartaDePorte = @Numero --AND SubNumero=@SubNumero
            AND SubNumeroVagon = ISNULL(@SubnumeroVagon, SubNumeroVagon)
            --AND NumeroSubFijo = ISNULL(@NumeroSubFijo, NumeroSubFijo)
			--AND isnull(Anulada,'NO')<>'SI'
	order by subnumerodefacturacion desc
go


--exec [dbo].[wCartasDePorte_TX_PorNumero] 4
-- select * from CartasDePorte



--////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wMailsFiltros_TTpaginadoYfiltrado]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wMailsFiltros_TTpaginadoYfiltrado
go



CREATE  PROCEDURE [dbo].wMailsFiltros_TTpaginadoYfiltrado
(

	@ColumnaParaFiltrar  nvarchar(50)=null,
	@TextoParaFiltrar    nvarchar(50)=null,
	@PuntoVenta			 integer=null,

	@sortExpression      nvarchar(50),
	
    @startRowIndex int,
    @maximumRows int
)
AS

                --<asp:ListItem Text="Titular" Value="VendedorDesc" />
                --<asp:ListItem Text="Emails" Value="Emails" />
                --<asp:ListItem Text="Intermediario" Value="CuentaOrden1Desc" />
                --<asp:ListItem Text="R.Comercial" Value="CuentaOrden2Desc" />
                --<asp:ListItem Text="Corredor" Value="CorredorDesc" />
                --<asp:ListItem Text="Destinatario" Value="EntregadorDesc" />
                --<asp:ListItem Text="Producto" Value="Producto" />
                --<asp:ListItem Text="Origen" Value="ProcedenciaDesc" />
                --<asp:ListItem Text="Destino" Value="DestinoDesc" />


-- http://www.4guysfromrolla.com/webtech/042606-1.shtml acá explican cómo paginar 
-- http://www.4guysfromrolla.com/articles/040407-1.aspx y acá explican cómo paginar Y filtrar. Naturalmente, necesitas los (fastidiosos) parametros de filtrado
-- http://stackoverflow.com/questions/149380/dynamic-sorting-within-sql-stored-procedures acá se discute sobre NO usar SQL dinamico 


DECLARE @first_id int, @startRow int
	

-- A check can be added to make sure @startRowIndex isn't > count(1)
-- from employees before doing any actual work unless it is guaranteed
-- the caller won't do that

-- Get the first employeeID for our page of records
SET ROWCOUNT @startRowIndex



SELECT @first_id = IdWilliamsMailFiltro 
FROM WilliamsMailFiltros 
WHERE 
--NumeroCartaDePorte LIKE '*'+@TextoParaFiltrar+'*'
	isnull(PuntoVenta,0)=isnull(@PuntoVenta,0)  
	
	AND

	CASE @ColumnaParaFiltrar
		WHEN 'Emails' THEN Emails 
		ELSE '%'+@TextoParaFiltrar+'%'
	END
		LIKE '%'+@TextoParaFiltrar+'%'


ORDER BY IdWilliamsMailFiltro DESC



-- Now, set the row count to MaximumRows and get
-- all records >= @first_id
SET ROWCOUNT @maximumRows


--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------



SELECT MAILS.*, 
    CLIVEN.Razonsocial as VendedorDesc,
    CLICO1.Razonsocial as CuentaOrden1Desc,
    CLICO2.Razonsocial as CuentaOrden2Desc,
    CLICOR.Nombre as CorredorDesc,
    CLIENT.Razonsocial as EntregadorDesc, 
    Articulos.Descripcion as Producto, 
    LOCORI.Nombre as ProcedenciaDesc, 
    LOCDES.Descripcion as DestinoDesc 
    FROM WilliamsMailFiltros MAILS
    LEFT OUTER JOIN Clientes CLIVEN ON MAILS.Vendedor = CLIVEN.IdCliente
    LEFT OUTER JOIN Clientes CLICO1 ON MAILS.CuentaOrden1 = CLICO1.IdCliente 
    LEFT OUTER JOIN Clientes CLICO2 ON MAILS.CuentaOrden2 = CLICO2.IdCliente 
    LEFT OUTER JOIN Vendedores CLICOR ON MAILS.Corredor = CLICOR.IdVendedor 
    LEFT OUTER JOIN Clientes CLIENT ON MAILS.Entregador = CLIENT.IdCliente
    LEFT OUTER JOIN Articulos ON MAILS.IdArticulo = Articulos.IdArticulo 
    LEFT OUTER JOIN Localidades LOCORI ON MAILS.Procedencia = LOCORI.IdLocalidad 
	LEFT OUTER JOIN WilliamsDestinos LOCDES ON MAILS.Destino = LOCDES.IdWilliamsDestino	

WHERE 


--NumeroCartaDePorte LIKE '*'+@TextoParaFiltrar+'*'  AND
	isnull(PuntoVenta,0)=isnull(@PuntoVenta,0)  
	
	AND

	CASE @ColumnaParaFiltrar
		WHEN 'Emails' THEN Emails 
		ELSE '%'+@TextoParaFiltrar+'%'
	END
		LIKE '%'+@TextoParaFiltrar+'%'
	
 	AND 
	
	IdWilliamsMailFiltro <= @first_id
ORDER BY IdWilliamsMailFiltro DESC



--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

SET ROWCOUNT 0





 


--IF @DepartmentID IS NULL
--   -- If @DepartmentID is null, then we want to get all employees
--   EXEC dbo.GetEmployeesSubsetSorted @sortExpression, @startRowIndex, @maximumRows
--ELSE
-- BEGIN
--   -- Otherwise we want to get just those employees in the specified department
--   IF LEN(@sortExpression) = 0
--      SET @sortExpression = 'EmployeeID'

--   -- Since @startRowIndex is zero-based in the data Web control, but one-based w/ROW_NUMBER(), increment
--   SET @startRowIndex = @startRowIndex + 1


--   --dios mio, como puede ser que sean necesarias estas sentencias dinamicas....

--   -- Issue query
--   DECLARE @sql nvarchar(4000)
--   SET @sql = 'SELECT EmployeeID, LastName, FirstName, DepartmentID, Salary, 
--            HireDate, DepartmentName
--   FROM
--      (SELECT EmployeeID, LastName, FirstName, e.DepartmentID, Salary, 
--            HireDate, d.Name as DepartmentName,
--            ROW_NUMBER() OVER(ORDER BY ' + @sortExpression + ') as RowNum
--       FROM Employees e
--         INNER JOIN Departments d ON
--            e.DepartmentID = d.DepartmentID
--       WHERE e.DepartmentID = ' + CONVERT(nvarchar(10), @DepartmentID) + '
--      ) as EmpInfo
--   WHERE RowNum BETWEEN ' + CONVERT(nvarchar(10), @startRowIndex) + 
--               ' AND (' + CONVERT(nvarchar(10), @startRowIndex) + ' + ' 
--               + CONVERT(nvarchar(10), @maximumRows) + ') - 1'
      
--   -- Execute the SQL query
--   EXEC sp_executesql @sql
-- END






GO


/*
EXEC dbo.wMailsFiltros_TTpaginadoYfiltrado '','',0,'',1,6



SELECT vendedordesc,*
FROM VistaCartasPorte 
WHERE vendedordesc LIKE '%'+ 'ACA' + '%'


*/

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wMailsFiltros_TTpaginadoTotalCount]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wMailsFiltros_TTpaginadoTotalCount
go



CREATE  PROCEDURE [dbo].wMailsFiltros_TTpaginadoTotalCount
AS
SELECT COUNT(*) FROM dbo.Requerimientos
go

--EXEC wRequerimientos_TTpaginadoTotalCount
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////



--/////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wClientes_TTpaginadoYfiltrado]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wClientes_TTpaginadoYfiltrado
go



CREATE  PROCEDURE [dbo].wClientes_TTpaginadoYfiltrado
(

	@ColumnaParaFiltrar  nvarchar(50)=null,
	@TextoParaFiltrar    nvarchar(50)=null,
	
	@sortExpression      nvarchar(50),
	
    @startRowIndex int,
    @maximumRows int
)
AS

--<asp:ListItem Text="Numero" Value="NumeroCartaDePorte" />
 --                       <asp:ListItem Text="Arribo" Value="FechaArribo" />
 --                       <asp:ListItem Text="Titular" Value="VendedorDesc" />
 --                       <asp:ListItem Text="Intermediario" Value="CuentaOrden1Desc" />
 --                       <asp:ListItem Text="R.Comercial" Value="CuentaOrden2Desc" />
 --                       <asp:ListItem Text="Corredor" Value="CorredorDesc" />
 --                       <asp:ListItem Text="Destinatario" Value="EntregadorDesc" />
 --                       <asp:ListItem Text="Producto" Value="Producto" />
 --                       <asp:ListItem Text="Origen" Value="ProcedenciaDesc" />
 --                       <asp:ListItem Text="Destino" Value="DestinoDesc" />
 --                       <asp:ListItem Text="Descarga" Value="FechaDescarga" />
 --                       <asp:ListItem Text="Neto" Value="NetoFinal" />
 --                       <asp:ListItem Text="Exporta" Value="Exporta" />


-- http://www.4guysfromrolla.com/webtech/042606-1.shtml acá explican cómo paginar 
-- http://www.4guysfromrolla.com/articles/040407-1.aspx y acá explican cómo paginar Y filtrar. Naturalmente, necesitas los (fastidiosos) parametros de filtrado
-- http://stackoverflow.com/questions/149380/dynamic-sorting-within-sql-stored-procedures acá se discute sobre NO usar SQL dinamico 


DECLARE @first_id int, @startRow int
	
set @ColumnaParaFiltrar='NumeroCartaDePorte' 
set @TextoParaFiltrar='' 

-- A check can be added to make sure @startRowIndex isn't > count(1)
-- from employees before doing any actual work unless it is guaranteed
-- the caller won't do that

-- Get the first employeeID for our page of records
SET ROWCOUNT @startRowIndex



SELECT @first_id = IdCartaDePorte 
FROM VistaCartasPorte 
WHERE 
--NumeroCartaDePorte LIKE '*'+@TextoParaFiltrar+'*'

	CASE @ColumnaParaFiltrar
		WHEN 'NumeroCartaDePorte' THEN NumeroCartaDePorte
		WHEN 'VendedorDesc' THEN VendedorDesc 
	END
		LIKE '%'+@TextoParaFiltrar+'%'

ORDER BY IdCartaDePorte DESC



-- Now, set the row count to MaximumRows and get
-- all records >= @first_id
SET ROWCOUNT @maximumRows


--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------



SELECT * 
FROM VistaCartasPorte 
WHERE 


--NumeroCartaDePorte LIKE '*'+@TextoParaFiltrar+'*'  AND

	CASE @ColumnaParaFiltrar
		WHEN 'NumeroCartaDePorte' THEN NumeroCartaDePorte
		WHEN 'VendedorDesc' THEN VendedorDesc 
		ELSE NULL
	END
		LIKE '%'+@TextoParaFiltrar+'%'
	
 	AND 
	
	IdCartaDePorte <= @first_id
ORDER BY IdCartaDePorte DESC



--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

SET ROWCOUNT 0





 


--IF @DepartmentID IS NULL
--   -- If @DepartmentID is null, then we want to get all employees
--   EXEC dbo.GetEmployeesSubsetSorted @sortExpression, @startRowIndex, @maximumRows
--ELSE
-- BEGIN
--   -- Otherwise we want to get just those employees in the specified department
--   IF LEN(@sortExpression) = 0
--      SET @sortExpression = 'EmployeeID'

--   -- Since @startRowIndex is zero-based in the data Web control, but one-based w/ROW_NUMBER(), increment
--   SET @startRowIndex = @startRowIndex + 1


--   --dios mio, como puede ser que sean necesarias estas sentencias dinamicas....

--   -- Issue query
--   DECLARE @sql nvarchar(4000)
--   SET @sql = 'SELECT EmployeeID, LastName, FirstName, DepartmentID, Salary, 
--            HireDate, DepartmentName
--   FROM
--      (SELECT EmployeeID, LastName, FirstName, e.DepartmentID, Salary, 
--            HireDate, d.Name as DepartmentName,
--            ROW_NUMBER() OVER(ORDER BY ' + @sortExpression + ') as RowNum
--       FROM Employees e
--         INNER JOIN Departments d ON
--            e.DepartmentID = d.DepartmentID
--       WHERE e.DepartmentID = ' + CONVERT(nvarchar(10), @DepartmentID) + '
--      ) as EmpInfo
--   WHERE RowNum BETWEEN ' + CONVERT(nvarchar(10), @startRowIndex) + 
--               ' AND (' + CONVERT(nvarchar(10), @startRowIndex) + ' + ' 
--               + CONVERT(nvarchar(10), @maximumRows) + ') - 1'
      
--   -- Execute the SQL query
--   EXEC sp_executesql @sql
-- END






GO


/*
EXEC dbo.wClientes_TTpaginadoYfiltrado 'NumeroCartaDePorte','20','',1,120



SELECT vendedordesc,*
FROM VistaCartasPorte 
WHERE vendedordesc LIKE '%'+ 'ACA' + '%'


*/

--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wClientes_TTprimerapagina]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wClientes_TTprimerapagina
go

CREATE  PROCEDURE [dbo].wClientes_TTprimerapagina
AS 
    DECLARE @vector_X VARCHAR(50),
        @vector_T VARCHAR(50)
    SET @vector_X = '01111111111111111111111111111133'
    SET @vector_T = '05120211555514521162222514142200'

    SELECT  TOP 210
			Clientes.IdCliente as Id,
            Clientes.RazonSocial AS [Razon social],
            Clientes.Codigo AS [Codigo],
            Clientes.Direccion,
            L1.Nombre AS [Localidad],
            Clientes.CodigoPostal,
            P1.Nombre AS [Provincia],
            Paises.Descripcion AS [Pais],
            Clientes.Telefono,
            Clientes.Fax,
            Clientes.Email,
            Clientes.Cuit,
            DescripcionIva.Descripcion AS [Condicion IVA],
            Clientes.FechaAlta AS [Fecha alta],
            Clientes.Contacto,
            Clientes.DireccionEntrega AS [Direccion de entrega],
            L2.Nombre AS [Localidad (entrega)],
            P2.Nombre AS [Provincia (entrega)],
            Clientes.CodigoPresto AS [Codigo PRESTO],
            V1.Nombre AS [Vendedor],
            V2.Nombre AS [Cobrador],
            [Estados Proveedores].Descripcion AS [Estado],
            Clientes.NombreFantasia AS [Nombre comercial],
            Clientes.Observaciones,
            E1.Nombre AS [Ingreso],
            Clientes.FechaIngreso AS [Fecha ing.],
            E2.Nombre AS [Modifico],
            Clientes.FechaModifico AS [Fecha modif.],
            C1.Descripcion AS [Cuenta contable],
            C2.Descripcion AS [Cuenta contable (ext.)],
            @Vector_T AS Vector_T,
            @Vector_X AS Vector_X
    FROM    Clientes
            LEFT OUTER JOIN DescripcionIva ON Clientes.IdCodigoIva = DescripcionIva.IdCodigoIva
            LEFT OUTER JOIN Localidades L1 ON Clientes.IdLocalidad = L1.IdLocalidad
            LEFT OUTER JOIN Localidades L2 ON Clientes.IdLocalidadEntrega = L2.IdLocalidad
            LEFT OUTER JOIN Provincias P1 ON Clientes.IdProvincia = P1.IdProvincia
            LEFT OUTER JOIN Provincias P2 ON Clientes.IdProvincia = P2.IdProvincia
            LEFT OUTER JOIN Vendedores V1 ON Clientes.Vendedor1 = V1.IdVendedor
            LEFT OUTER JOIN Vendedores V2 ON Clientes.Cobrador = V2.IdVendedor
            LEFT OUTER JOIN Paises ON Clientes.IdPais = Paises.IdPais
            LEFT OUTER JOIN Empleados E1 ON Clientes.IdUsuarioIngreso = E1.IdEmpleado
            LEFT OUTER JOIN Empleados E2 ON Clientes.IdUsuarioModifico = E2.IdEmpleado
            LEFT OUTER JOIN [Estados Proveedores] ON Clientes.IdEstado = [Estados Proveedores].IdEstado
            LEFT OUTER JOIN Cuentas C1 ON Clientes.IdCuenta = C1.IdCuenta
            LEFT OUTER JOIN Cuentas C2 ON Clientes.IdCuentaMonedaExt = C2.IdCuenta
--WHERE IsNull(Clientes.Confirmado,'SI')='SI'
    ORDER BY IdCliente DESC -- Clientes.RazonSocial

GO

--exec wClientes_TTprimerapagina
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wClientes_TT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wClientes_TT]
go

CREATE  PROCEDURE [dbo].[wClientes_TT]
AS 
    DECLARE @vector_X VARCHAR(50),
        @vector_T VARCHAR(50)
    SET @vector_X = '01111111111111111111111111111133'
    SET @vector_T = '05120211555514521162222514142200'

    SELECT  Clientes.IdCliente,
            Clientes.RazonSocial AS [Razon social],
            Clientes.Codigo AS [Codigo],
            Clientes.Direccion,
            L1.Nombre AS [Localidad],
            Clientes.CodigoPostal,
            P1.Nombre AS [Provincia],
            Paises.Descripcion AS [Pais],
            Clientes.Telefono,
            Clientes.Fax,
            Clientes.Email,
            Clientes.Cuit,
            DescripcionIva.Descripcion AS [Condicion IVA],
            Clientes.FechaAlta AS [Fecha alta],
            Clientes.Contacto,
            Clientes.DireccionEntrega AS [Direccion de entrega],
            L2.Nombre AS [Localidad (entrega)],
            P2.Nombre AS [Provincia (entrega)],
            Clientes.CodigoPresto AS [Codigo PRESTO],
            V1.Nombre AS [Vendedor],
            V2.Nombre AS [Cobrador],
            [Estados Proveedores].Descripcion AS [Estado],
            Clientes.NombreFantasia AS [Nombre comercial],
            Clientes.Observaciones,
            E1.Nombre AS [Ingreso],
            Clientes.FechaIngreso AS [Fecha ing.],
            E2.Nombre AS [Modifico],
            Clientes.FechaModifico AS [Fecha modif.],
            C1.Descripcion AS [Cuenta contable],
            C2.Descripcion AS [Cuenta contable (ext.)],
            @Vector_T AS Vector_T,
            @Vector_X AS Vector_X
    FROM    Clientes
            LEFT OUTER JOIN DescripcionIva ON Clientes.IdCodigoIva = DescripcionIva.IdCodigoIva
            LEFT OUTER JOIN Localidades L1 ON Clientes.IdLocalidad = L1.IdLocalidad
            LEFT OUTER JOIN Localidades L2 ON Clientes.IdLocalidadEntrega = L2.IdLocalidad
            LEFT OUTER JOIN Provincias P1 ON Clientes.IdProvincia = P1.IdProvincia
            LEFT OUTER JOIN Provincias P2 ON Clientes.IdProvincia = P2.IdProvincia
            LEFT OUTER JOIN Vendedores V1 ON Clientes.Vendedor1 = V1.IdVendedor
            LEFT OUTER JOIN Vendedores V2 ON Clientes.Cobrador = V2.IdVendedor
            LEFT OUTER JOIN Paises ON Clientes.IdPais = Paises.IdPais
            LEFT OUTER JOIN Empleados E1 ON Clientes.IdUsuarioIngreso = E1.IdEmpleado
            LEFT OUTER JOIN Empleados E2 ON Clientes.IdUsuarioModifico = E2.IdEmpleado
            LEFT OUTER JOIN [Estados Proveedores] ON Clientes.IdEstado = [Estados Proveedores].IdEstado
            LEFT OUTER JOIN Cuentas C1 ON Clientes.IdCuenta = C1.IdCuenta
            LEFT OUTER JOIN Cuentas C2 ON Clientes.IdCuentaMonedaExt = C2.IdCuenta
--WHERE IsNull(Clientes.Confirmado,'SI')='SI'
ORDER BY IdCliente DESC 
    --ORDER BY Clientes.RazonSocial

GO
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wClientes_TX_Busqueda]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wClientes_TX_Busqueda]
go

CREATE  PROCEDURE [dbo].[wClientes_TX_Busqueda] @Busqueda VARCHAR(100)
AS 
    
    
    SELECT TOP 100
            IdCliente,
            RazonSocial,
            Cuit
    FROM    Clientes
    WHERE   --IsNull(Eventual,'NO')<>'SI' and  --por qué saqué el filtro de eventuales?
--IsNull(Confirmado,'NO')<>'NO' and
            RazonSocial LIKE @Busqueda + '%'

			
--RazonSocial like '%'+@Busqueda+'%'  --busca en el medio. tarda mas en buscar, y mas aun en transmitirse
    
    
      ORDER BY RazonSocial

    
GO

/*

exec [wClientes_TX_Busqueda] 'asoc'


select Confirmado,* from clientes

select Confirmado, * from proveedores
WHERE 
IsNull(Confirmado,'NO')<>'SI' and
Proveedores.RazonSocial like '%'+'Cefe'+'%'




*/
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wClientes_TX_BusquedaConCUIT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wClientes_TX_BusquedaConCUIT
go

CREATE  PROCEDURE [dbo].wClientes_TX_BusquedaConCUIT @Busqueda VARCHAR(100)
AS 
    
    
    SELECT TOP 100
            IdCliente,
            isnull(RazonSocial,'') + ' ' + isnull(Cuit,'') COLLATE Modern_Spanish_ci_as as RazonSocial,
            Cuit
    FROM    Clientes
    WHERE   			
			-- http://stackoverflow.com/questions/156954/search-for-words-in-sql-server-index
			RazonSocial like '%[^A-z^0-9]' + @Busqueda + '%' -- In the middle of a sentence
			OR RazonSocial like  @Busqueda + '%'            -- At the beginning of a sentence


--RazonSocial like '%'+@Busqueda+'%'  --busca en el medio. tarda mas en buscar, y mas aun en transmitirse
    
    
    union

    SELECT TOP 100
            IdCliente,
            isnull(Cuit,'') + ' ' + isnull(RazonSocial,'') COLLATE Modern_Spanish_ci_as  as RazonSocial,
            Cuit
    FROM    Clientes
    WHERE   --IsNull(Eventual,'NO')<>'SI' and  --por qué saqué el filtro de eventuales?
            (Cuit LIKE @Busqueda + '%')
            OR
            REPLACE(Cuit,'-','') LIKE @Busqueda + '%'



    ORDER BY RazonSocial

    
GO



/*

exec [wClientes_TX_BusquedaConCUIT] 'CHAKI'

exec [wClientes_TX_BusquedaConCUIT] 'LDC'
exec [wClientes_TX_BusquedaConCUIT] 'LD'
select Confirmado,* from clientes

select Confirmado, * from proveedores
WHERE 
IsNull(Confirmado,'NO')<>'SI' and
Proveedores.RazonSocial like '%'+'Cefe'+'%'




*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wClientesEntregadores_TX_BusquedaConCUIT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wClientesEntregadores_TX_BusquedaConCUIT
go

CREATE  PROCEDURE [dbo].wClientesEntregadores_TX_BusquedaConCUIT @Busqueda VARCHAR(100)
AS 
    
    
    SELECT TOP 100
            IdCliente,
            isnull(RazonSocial,'') + ' ' + isnull(Cuit,'') COLLATE Modern_Spanish_ci_as as RazonSocial,
            Cuit
    FROM    Clientes
    WHERE   			
			-- http://stackoverflow.com/questions/156954/search-for-words-in-sql-server-index
			(RazonSocial like '%[^A-z^0-9]' + @Busqueda + '%' -- In the middle of a sentence
			OR RazonSocial like  @Busqueda + '%'            -- At the beginning of a sentence
			)
			and clientes.EsEntregador='SI'

--RazonSocial like '%'+@Busqueda+'%'  --busca en el medio. tarda mas en buscar, y mas aun en transmitirse
    
    
    union

    SELECT TOP 100
            IdCliente,
            isnull(Cuit,'') + ' ' + isnull(RazonSocial,'') COLLATE Modern_Spanish_ci_as  as RazonSocial,
            Cuit
    FROM    Clientes
    WHERE   --IsNull(Eventual,'NO')<>'SI' and  --por qué saqué el filtro de eventuales?
            ((Cuit LIKE @Busqueda + '%')
            OR
            REPLACE(Cuit,'-','') LIKE @Busqueda + '%')
			and clientes.EsEntregador='SI'


    ORDER BY RazonSocial

    
GO



/*

exec [wClientes_TX_BusquedaConCUIT] 'CHAKI'

exec [wClientes_TX_BusquedaConCUIT] 'LDC'
exec [wClientes_TX_BusquedaConCUIT] 'LD'
select Confirmado,* from clientes

select Confirmado, * from proveedores
WHERE 
IsNull(Confirmado,'NO')<>'SI' and
Proveedores.RazonSocial like '%'+'Cefe'+'%'




*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wVendedores_TX_BusquedaConCUIT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wVendedores_TX_BusquedaConCUIT
go

CREATE  PROCEDURE [dbo].wVendedores_TX_BusquedaConCUIT @Busqueda VARCHAR(100)
AS 
    
    
    SELECT TOP 100
            IdVendedor,
            Nombre,
            Cuit
    FROM    Vendedores
    WHERE   --IsNull(Eventual,'NO')<>'SI' and  --por qué saqué el filtro de eventuales?
--IsNull(Confirmado,'NO')<>'NO' and
            Nombre LIKE @Busqueda + '%'
--RazonSocial like '%'+@Busqueda+'%'  --busca en el medio. tarda mas en buscar, y mas aun en transmitirse
    
    
    union

    SELECT TOP 100
            IdVendedor,
            Cuit COLLATE SQL_Latin1_General_CP1_CI_AS + ' ' + nombre COLLATE SQL_Latin1_General_CP1_CI_AS,
            Cuit
    FROM    Vendedores
    WHERE   --IsNull(Eventual,'NO')<>'SI' and  --por qué saqué el filtro de eventuales?
            (Cuit LIKE @Busqueda + '%')
            OR
            REPLACE(Cuit,'-','') LIKE @Busqueda + '%'



    ORDER BY Nombre

    
GO



/*

exec [wClientes_TX_Busqueda] 'asoc'


select Confirmado,* from clientes

select Confirmado, * from proveedores
WHERE 
IsNull(Confirmado,'NO')<>'SI' and
Proveedores.RazonSocial like '%'+'Cefe'+'%'




*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wTransportistas_TX_BusquedaConCUIT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wTransportistas_TX_BusquedaConCUIT
go

CREATE  PROCEDURE [dbo].wTransportistas_TX_BusquedaConCUIT @Busqueda VARCHAR(100)
AS 
    
    
    SELECT TOP 100
            IdTransportista,
            RazonSocial,
            Cuit
    FROM    Transportistas
    WHERE   --IsNull(Eventual,'NO')<>'SI' and  --por qué saqué el filtro de eventuales?
--IsNull(Confirmado,'NO')<>'NO' and
            RazonSocial LIKE @Busqueda + '%'
--RazonSocial like '%'+@Busqueda+'%'  --busca en el medio. tarda mas en buscar, y mas aun en transmitirse
    
    
    union

    SELECT TOP 100
            IdTransportista,
            Cuit + ' ' + RazonSocial,
            Cuit
    FROM    Transportistas
    WHERE   --IsNull(Eventual,'NO')<>'SI' and  --por qué saqué el filtro de eventuales?
            (Cuit LIKE @Busqueda + '%')
            OR
            REPLACE(Cuit,'-','') LIKE @Busqueda + '%'



    ORDER BY RazonSocial

    
GO



/*

exec [wClientes_TX_Busqueda] 'asoc'

select * from transportistas

select Confirmado,* from clientes

select Confirmado, * from proveedores
WHERE 
IsNull(Confirmado,'NO')<>'SI' and
Proveedores.RazonSocial like '%'+'Cefe'+'%'




*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wChoferes_TX_BusquedaConCUIT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wChoferes_TX_BusquedaConCUIT
go

CREATE  PROCEDURE [dbo].wChoferes_TX_BusquedaConCUIT @Busqueda VARCHAR(100)
AS 
    
    
    SELECT TOP 100
            IdChofer,
              Nombre,
            Cuil
    FROM    Choferes
    WHERE   --IsNull(Eventual,'NO')<>'SI' and  --por qué saqué el filtro de eventuales?
--IsNull(Confirmado,'NO')<>'NO' and
            nombre LIKE @Busqueda + '%'
--RazonSocial like '%'+@Busqueda+'%'  --busca en el medio. tarda mas en buscar, y mas aun en transmitirse
    
    
    union

    SELECT TOP 100
            IdChofer,
            CUIL + ' ' + nombre,
            Cuil
    FROM    Choferes
    WHERE   --IsNull(Eventual,'NO')<>'SI' and  --por qué saqué el filtro de eventuales?
            (Cuil LIKE @Busqueda + '%')
            OR
            REPLACE(Cuil,'-','') LIKE @Busqueda + '%'



    ORDER BY nombre

    
GO



/*

exec [wClientes_TX_Busqueda] 'asoc'


select Confirmado,* from clientes

select Confirmado, * from proveedores
WHERE 
IsNull(Confirmado,'NO')<>'SI' and
Proveedores.RazonSocial like '%'+'Cefe'+'%'




*/

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wLocalidades_TX_Busqueda]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [wLocalidades_TX_Busqueda]
go

CREATE  PROCEDURE [dbo].[wLocalidades_TX_Busqueda] @Busqueda VARCHAR(100)
AS 
    SELECT TOP 200
            IdLocalidad,
            Nombre,
            CodigoPostal
    FROM    Localidades
    WHERE   --IsNull(Eventual,'NO')<>'SI' and  --por qué saqué el filtro de eventuales?
            Nombre LIKE '%' + @Busqueda + '%'
    ORDER BY Nombre

GO


/*

exec [wLocalidades_TX_Busqueda] 'as'


select  * from localidades
WHERE 
IsNull(Confirmado,'NO')<>'SI' and
Proveedores.RazonSocial like '%'+'Cefe'+'%'





*/

--/////////////////////////////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wFacturas_TT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wFacturas_TT
go

CREATE  PROCEDURE [dbo].wFacturas_TT
AS 
    SET NOCOUNT ON


    DECLARE @IdAbonos VARCHAR(100)
    SET @IdAbonos = ''

/*
--Para qué es todo esto? 


CREATE TABLE #Auxiliar1 
			(
			 IdFactura INTEGER,
			 OCompras VARCHAR(500)
			)

CREATE TABLE #Auxiliar2 
			(
			 IdFactura INTEGER,
			 OCompra VARCHAR(8)
			)
INSERT INTO #Auxiliar2 
 SELECT Det.IdFactura, Substring('00000000',1,8-Len(Convert(varchar,OrdenesCompra.NumeroOrdenCompra)))+Convert(varchar,OrdenesCompra.NumeroOrdenCompra)
 FROM DetalleFacturas Det
 LEFT OUTER JOIN DetalleFacturasOrdenesCompra ON Det.IdDetalleFactura = DetalleFacturasOrdenesCompra.IdDetalleFactura
 LEFT OUTER JOIN Facturas ON Det.IdFactura = Facturas.IdFactura
 LEFT OUTER JOIN DetalleOrdenesCompra ON DetalleFacturasOrdenesCompra.IdDetalleOrdenCompra = DetalleOrdenesCompra.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON DetalleOrdenesCompra.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 WHERE IsNull(FacturaContado,'NO')='NO'

CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdFactura,OCompra) ON [PRIMARY]

INSERT INTO #Auxiliar1 
 SELECT IdFactura, ''
 FROM #Auxiliar2
 GROUP BY IdFactura

--  CURSOR  
DECLARE @IdFactura int, @OCompra varchar(8), @Corte int, @P varchar(500)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdFactura, OCompra
		FROM #Auxiliar2
		ORDER BY IdFactura
OPEN Cur
FETCH NEXT FROM Cur INTO @IdFactura, @OCompra
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdFactura
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar1
			SET OCompras = SUBSTRING(@P,1,500)
			WHERE IdFactura=@Corte
		SET @P=''
		SET @Corte=@IdFactura
	   END
	IF NOT @OCompra IS NULL
		IF PATINDEX('%'+@OCompra+' '+'%', @P)=0
			SET @P=@P+@OCompra+' '
	FETCH NEXT FROM Cur INTO @IdFactura, @OCompra
   END
   IF @Corte<>0
	UPDATE #Auxiliar1
	SET OCompras = SUBSTRING(@P,1,500)
	WHERE IdFactura=@Corte
CLOSE Cur
DEALLOCATE Cur

CREATE TABLE #Auxiliar3 
			(
			 IdFactura INTEGER,
			 Remitos VARCHAR(500)
			)

CREATE TABLE #Auxiliar4 
			(
			 IdFactura INTEGER,
			 Remito VARCHAR(13)
			)
INSERT INTO #Auxiliar4 
 SELECT Det.IdFactura, 
	Substring('0000',1,4-Len(Convert(varchar,IsNull(Remitos.PuntoVenta,0))))+
		Convert(varchar,IsNull(Remitos.PuntoVenta,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+
		Convert(varchar,Remitos.NumeroRemito)
 FROM DetalleFacturas Det
 LEFT OUTER JOIN DetalleFacturasRemitos ON Det.IdDetalleFactura = DetalleFacturasRemitos.IdDetalleFactura
 LEFT OUTER JOIN Facturas ON Det.IdFactura = Facturas.IdFactura
 LEFT OUTER JOIN DetalleRemitos ON DetalleFacturasRemitos.IdDetalleRemito = DetalleRemitos.IdDetalleRemito
 LEFT OUTER JOIN Remitos ON DetalleRemitos.IdRemito = Remitos.IdRemito
 WHERE IsNull(FacturaContado,'NO')='NO'

CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (IdFactura,Remito) ON [PRIMARY]

INSERT INTO #Auxiliar3 
 SELECT IdFactura, ''
 FROM #Auxiliar4
 GROUP BY IdFactura

--  CURSOR  
DECLARE @Remito varchar(13)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdFactura, Remito
		FROM #Auxiliar4
		ORDER BY IdFactura
OPEN Cur
FETCH NEXT FROM Cur INTO @IdFactura, @Remito
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdFactura
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar3
			SET Remitos = SUBSTRING(@P,1,500)
			WHERE IdFactura=@Corte
		SET @P=''
		SET @Corte=@IdFactura
	   END
	IF NOT @Remito IS NULL
		IF PATINDEX('%'+@Remito+' '+'%', @P)=0
			SET @P=@P+@Remito+' '
	FETCH NEXT FROM Cur INTO @IdFactura, @Remito
   END
   IF @Corte<>0
	UPDATE #Auxiliar3
	SET Remitos = SUBSTRING(@P,1,500)
	WHERE IdFactura=@Corte
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF
*/








    DECLARE @vector_X VARCHAR(50),
        @vector_T VARCHAR(50)
    SET @vector_X = '011111111111111111111111111111111133'
    SET @vector_T = '00912114055BB54444425126703433533400'

    SELECT  Facturas.IdFactura,
            Facturas.TipoABC AS [A/B/E],
            Facturas.IdFactura AS [IdAux],
            Facturas.PuntoVenta AS [Pto.vta.],
            Facturas.NumeroFactura AS [Factura],
            Facturas.Anulada AS [Anulada],
            Clientes.CodigoCliente AS [Cod.Cli.],
            Clientes.RazonSocial AS [Cliente],
            DescripcionIva.Descripcion AS [Condicion IVA],
            Clientes.Cuit AS [Cuit],
            Facturas.FechaFactura AS [Fecha Factura], 
 --#Auxiliar1.OCompras as [Ordenes de compra],
 --#Auxiliar3.Remitos as [Remitos],
            Facturas.ImporteTotal - Facturas.ImporteIva1
            - Facturas.ImporteIva2 - Facturas.RetencionIBrutos1
            - Facturas.RetencionIBrutos2 - Facturas.RetencionIBrutos3
            + ISNULL(Facturas.ImporteBonificacion, 0)
            - ISNULL(Facturas.IvaNoDiscriminado, 0)
            - ISNULL(Facturas.PercepcionIVA, 0) AS [Neto gravado],
            Facturas.ImporteBonificacion AS [Bonificacion],
            Facturas.ImporteIva1 + ISNULL(Facturas.IvaNoDiscriminado, 0) AS [Iva],
            Facturas.RetencionIBrutos1 + Facturas.RetencionIBrutos2
            + Facturas.RetencionIBrutos3 AS [IIBB],
            Facturas.PercepcionIVA AS [Perc.IVA],
            Facturas.ImporteTotal AS [Total factura],
            Monedas.Abreviatura AS [Mon.],
            Clientes.Telefono AS [Telefono del cliente],
            Vendedores.Nombre AS [Vendedor],
            Empleados.Nombre AS [Ingreso],
            Facturas.FechaIngreso AS [Fecha ingreso],
            Obras.NumeroObra AS [Obra (x defecto)],
            Provincias.Nombre AS [Provincia destino],
            ( SELECT    COUNT(*)
              FROM      DetalleFacturas df
              WHERE     df.IdFactura = Facturas.IdFactura
            ) AS [Cant.Items],
            ( SELECT    COUNT(*)
              FROM      DetalleFacturas df
              WHERE     df.IdFactura = Facturas.IdFactura
                        AND PATINDEX('%' + CONVERT(VARCHAR, df.IdArticulo)
                                     + '%', @IdAbonos) <> 0
            ) AS [Cant.Abonos],
 --'Grupo '+Convert(varchar,
 --(Select Top 1 oc.Agrupacion2Facturacion 
	--From DetalleFacturasOrdenesCompra dfoc 
	--Left Outer Join DetalleOrdenesCompra doc On doc.IdDetalleOrdenCompra=dfoc.IdDetalleOrdenCompra
	--Left Outer Join OrdenesCompra oc On oc.IdOrdenCompra=doc.IdOrdenCompra
	--Where dfoc.IdFactura=Facturas.IdFactura)) as [Grupo facturacion automatica],
 --Facturas.ActivarRecuperoGastos as [Act.Rec.Gtos.],
 --Case When IsNull(ContabilizarAFechaVencimiento,'NO')='NO' 
	--Then Facturas.FechaFactura
	--Else Facturas.FechaVencimiento
 --End as [Fecha Contab.],
            Facturas.CAE AS [CAE],
            Facturas.RechazoCAE AS [Rech.CAE],
            Facturas.FechaVencimientoORechazoCAE AS [Fecha vto.CAE]
 --@Vector_T as Vector_T,
 --@Vector_X as Vector_X
    FROM    Facturas
            LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente
            LEFT OUTER JOIN DescripcionIva ON ISNULL(Facturas.IdCodigoIva,
                                                     Clientes.IdCodigoIva) = DescripcionIva.IdCodigoIva
            LEFT OUTER JOIN Vendedores ON Clientes.Vendedor1 = Vendedores.IdVendedor
            LEFT OUTER JOIN Monedas ON Facturas.IdMoneda = Monedas.IdMoneda
            LEFT OUTER JOIN Obras ON Facturas.IdObra = Obras.IdObra
            LEFT OUTER JOIN Provincias ON Facturas.IdProvinciaDestino = Provincias.IdProvincia
            LEFT OUTER JOIN Empleados ON Facturas.IdUsuarioIngreso = Empleados.IdEmpleado
--LEFT OUTER JOIN #Auxiliar1 ON Facturas.IdFactura=#Auxiliar1.IdFactura
--LEFT OUTER JOIN #Auxiliar3 ON Facturas.IdFactura=#Auxiliar3.IdFactura
    WHERE   ISNULL(FacturaContado, 'NO') = 'NO'
    ORDER BY Facturas.FechaFactura,
            Facturas.NumeroFactura

/*
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
*/

GO


--exec wFacturas_TT





--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wFacturas_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wFacturas_A
go


CREATE PROCEDURE wFacturas_A
    @IdFactura INT OUTPUT,
    @NumeroFactura INT,
    @TipoABC VARCHAR(1),
    @PuntoVenta SMALLINT,
    @IdCliente INT,
    @FechaFactura DATETIME,
    @IdCondicionVenta SMALLINT,
    @IdVendedor TINYINT,
    @IdTransportista1 TINYINT,
    @IdTransportista2 TINYINT,
    @ItemDireccion TINYINT,
    @OrdenCompra VARCHAR(20),
    @TipoPedidoConsignacion VARCHAR(1),
    @Anulada VARCHAR(2),
    @FechaAnulacion DATETIME,
    @Observaciones NTEXT,
    @IdRemito INT,
    @NumeroRemito INT,
    @IdPedido INT,
    @NumeroPedido INT,
    @ImporteTotal NUMERIC(18, 2),
    @ImporteIva1 NUMERIC(18, 2),
    @ImporteIva2 NUMERIC(18, 2),
    @ImporteBonificacion NUMERIC(18, 2),
    @RetencionIBrutos1 NUMERIC(18, 2),
    @PorcentajeIBrutos1 NUMERIC(6, 2),
    @RetencionIBrutos2 NUMERIC(18, 2),
    @PorcentajeIBrutos2 NUMERIC(6, 2),
    @ConvenioMultilateral VARCHAR(2),
    @RetencionIBrutos3 NUMERIC(18, 2),
    @PorcentajeIBrutos3 NUMERIC(6, 2),
    @IdTipoVentaC SMALLINT,
    @ImporteIvaIncluido NUMERIC(18, 2),
    @CotizacionDolar NUMERIC(18, 3),
    @EsMuestra VARCHAR(2),
    @CotizacionADolarFijo NUMERIC(18, 3),
    @ImporteParteEnDolares NUMERIC(18, 2),
    @ImporteParteEnPesos NUMERIC(18, 2),
    @PorcentajeIva1 NUMERIC(6, 2),
    @PorcentajeIva2 NUMERIC(6, 2),
    @FechaVencimiento DATETIME,
    @IVANoDiscriminado NUMERIC(18, 2),
    @IdMoneda INT,
    @CotizacionMoneda NUMERIC(18, 4),
    @PorcentajeBonificacion NUMERIC(6, 2),
    @OtrasPercepciones1 NUMERIC(18, 2),
    @OtrasPercepciones1Desc VARCHAR(15),
    @OtrasPercepciones2 NUMERIC(18, 2),
    @OtrasPercepciones2Desc VARCHAR(15),
    @IdProvinciaDestino INT,
    @IdIBCondicion INT,
    @IdAutorizaAnulacion INT,
    @IdPuntoVenta INT,
    @NumeroCAI NUMERIC(19, 0),
    @FechaVencimientoCAI DATETIME,
    @NumeroCertificadoPercepcionIIBB INT,
    @NumeroTicketInicial INT,
    @NumeroTicketFinal INT,
    @IdUsuarioIngreso INT,
    @FechaIngreso DATETIME,
    @IdObra INT,
    @IdIBCondicion2 INT,
    @IdIBCondicion3 INT,
    @IdCodigoIva INT,
    @Exportacion_FOB NUMERIC(18, 2),
    @Exportacion_PosicionAduana VARCHAR(20),
    @Exportacion_Despacho VARCHAR(30),
    @Exportacion_Guia VARCHAR(20),
    @Exportacion_IdPaisDestino INT,
    @Exportacion_FechaEmbarque DATETIME,
    @Exportacion_FechaOficializacion DATETIME,
    @OtrasPercepciones3 NUMERIC(18, 2),
    @OtrasPercepciones3Desc VARCHAR(15),
    @NoIncluirEnCubos VARCHAR(2),
    @PercepcionIVA NUMERIC(18, 2),
    @PorcentajePercepcionIVA NUMERIC(6, 2),
    @ActivarRecuperoGastos VARCHAR(2),
    @IdAutorizoRecuperoGastos INT,
    @ContabilizarAFechaVencimiento VARCHAR(2),
    @FacturaContado VARCHAR(2),
    @IdReciboContado INT,
    @EnviarEmail INT,
    @IdOrigenTransmision INT,
    @IdFacturaOriginal INT,
    @FechaImportacionTransmision DATETIME,
    @CuitClienteTransmision VARCHAR(13),
    @IdReciboContadoOriginal INT,
    @DevolucionAnticipo VARCHAR(2),
    @PorcentajeDevolucionAnticipo NUMERIC(18, 10),
    @CAE VARCHAR(14),
    @RechazoCAE VARCHAR(11),
    @FechaVencimientoORechazoCAE DATETIME,
    @IdListaPrecios INT,
    @IdIdentificacionCAE INT
AS 
    INSERT  INTO [Facturas]
            (
              NumeroFactura,
              TipoABC,
              PuntoVenta,
              IdCliente,
              FechaFactura,
              IdCondicionVenta,
              IdVendedor,
              IdTransportista1,
              IdTransportista2,
              ItemDireccion,
              OrdenCompra,
              TipoPedidoConsignacion,
              Anulada,
              FechaAnulacion,
              Observaciones,
              IdRemito,
              NumeroRemito,
              IdPedido,
              NumeroPedido,
              ImporteTotal,
              ImporteIva1,
              ImporteIva2,
              ImporteBonificacion,
              RetencionIBrutos1,
              PorcentajeIBrutos1,
              RetencionIBrutos2,
              PorcentajeIBrutos2,
              ConvenioMultilateral,
              RetencionIBrutos3,
              PorcentajeIBrutos3,
              IdTipoVentaC,
              ImporteIvaIncluido,
              CotizacionDolar,
              EsMuestra,
              CotizacionADolarFijo,
              ImporteParteEnDolares,
              ImporteParteEnPesos,
              PorcentajeIva1,
              PorcentajeIva2,
              FechaVencimiento,
              IVANoDiscriminado,
              IdMoneda,
              CotizacionMoneda,
              PorcentajeBonificacion,
              OtrasPercepciones1,
              OtrasPercepciones1Desc,
              OtrasPercepciones2,
              OtrasPercepciones2Desc,
              IdProvinciaDestino,
              IdIBCondicion,
              IdAutorizaAnulacion,
              IdPuntoVenta,
              NumeroCAI,
              FechaVencimientoCAI,
              NumeroCertificadoPercepcionIIBB,
              NumeroTicketInicial,
              NumeroTicketFinal,
              IdUsuarioIngreso,
              FechaIngreso,
              IdObra,
              IdIBCondicion2,
              IdIBCondicion3,
              IdCodigoIva,
              Exportacion_FOB,
              Exportacion_PosicionAduana,
              Exportacion_Despacho,
              Exportacion_Guia,
              Exportacion_IdPaisDestino,
              Exportacion_FechaEmbarque,
              Exportacion_FechaOficializacion,
              OtrasPercepciones3,
              OtrasPercepciones3Desc,
              NoIncluirEnCubos,
              PercepcionIVA,
              PorcentajePercepcionIVA,
              ActivarRecuperoGastos,
              IdAutorizoRecuperoGastos,
              ContabilizarAFechaVencimiento,
              FacturaContado,
              IdReciboContado,
              EnviarEmail,
              IdOrigenTransmision,
              IdFacturaOriginal,
              FechaImportacionTransmision,
              CuitClienteTransmision,
              IdReciboContadoOriginal,
              DevolucionAnticipo,
              PorcentajeDevolucionAnticipo,
              CAE,
              RechazoCAE,
              FechaVencimientoORechazoCAE,
              IdListaPrecios,
              IdIdentificacionCAE
            )
    VALUES  (
              @NumeroFactura,
              @TipoABC,
              @PuntoVenta,
              @IdCliente,
              @FechaFactura,
              @IdCondicionVenta,
              @IdVendedor,
              @IdTransportista1,
              @IdTransportista2,
              @ItemDireccion,
              @OrdenCompra,
              @TipoPedidoConsignacion,
              @Anulada,
              @FechaAnulacion,
              @Observaciones,
              @IdRemito,
              @NumeroRemito,
              @IdPedido,
              @NumeroPedido,
              @ImporteTotal,
              @ImporteIva1,
              @ImporteIva2,
              @ImporteBonificacion,
              @RetencionIBrutos1,
              @PorcentajeIBrutos1,
              @RetencionIBrutos2,
              @PorcentajeIBrutos2,
              @ConvenioMultilateral,
              @RetencionIBrutos3,
              @PorcentajeIBrutos3,
              @IdTipoVentaC,
              @ImporteIvaIncluido,
              @CotizacionDolar,
              @EsMuestra,
              @CotizacionADolarFijo,
              @ImporteParteEnDolares,
              @ImporteParteEnPesos,
              @PorcentajeIva1,
              @PorcentajeIva2,
              @FechaVencimiento,
              @IVANoDiscriminado,
              @IdMoneda,
              @CotizacionMoneda,
              @PorcentajeBonificacion,
              @OtrasPercepciones1,
              @OtrasPercepciones1Desc,
              @OtrasPercepciones2,
              @OtrasPercepciones2Desc,
              @IdProvinciaDestino,
              @IdIBCondicion,
              @IdAutorizaAnulacion,
              @IdPuntoVenta,
              @NumeroCAI,
              @FechaVencimientoCAI,
              @NumeroCertificadoPercepcionIIBB,
              @NumeroTicketInicial,
              @NumeroTicketFinal,
              @IdUsuarioIngreso,
              @FechaIngreso,
              @IdObra,
              @IdIBCondicion2,
              @IdIBCondicion3,
              @IdCodigoIva,
              @Exportacion_FOB,
              @Exportacion_PosicionAduana,
              @Exportacion_Despacho,
              @Exportacion_Guia,
              @Exportacion_IdPaisDestino,
              @Exportacion_FechaEmbarque,
              @Exportacion_FechaOficializacion,
              @OtrasPercepciones3,
              @OtrasPercepciones3Desc,
              @NoIncluirEnCubos,
              @PercepcionIVA,
              @PorcentajePercepcionIVA,
              @ActivarRecuperoGastos,
              @IdAutorizoRecuperoGastos,
              @ContabilizarAFechaVencimiento,
              @FacturaContado,
              @IdReciboContado,
              @EnviarEmail,
              @IdOrigenTransmision,
              @IdFacturaOriginal,
              @FechaImportacionTransmision,
              @CuitClienteTransmision,
              @IdReciboContadoOriginal,
              @DevolucionAnticipo,
              @PorcentajeDevolucionAnticipo,
              @CAE,
              @RechazoCAE,
              @FechaVencimientoORechazoCAE,
              @IdListaPrecios,
              @IdIdentificacionCAE
            )

    SELECT  @IdFactura = @@identity
    RETURN ( @IdFactura )

GO










--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wFacturas_M]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wFacturas_M
go


CREATE PROCEDURE wFacturas_M
    @IdFactura INT,
    @NumeroFactura INT,
    @TipoABC VARCHAR(1),
    @PuntoVenta SMALLINT,
    @IdCliente INT,
    @FechaFactura DATETIME,
    @IdCondicionVenta SMALLINT,
    @IdVendedor TINYINT,
    @IdTransportista1 TINYINT,
    @IdTransportista2 TINYINT,
    @ItemDireccion TINYINT,
    @OrdenCompra VARCHAR(20),
    @TipoPedidoConsignacion VARCHAR(1),
    @Anulada VARCHAR(2),
    @FechaAnulacion DATETIME,
    @Observaciones NTEXT,
    @IdRemito INT,
    @NumeroRemito INT,
    @IdPedido INT,
    @NumeroPedido INT,
    @ImporteTotal NUMERIC(18, 2),
    @ImporteIva1 NUMERIC(18, 2),
    @ImporteIva2 NUMERIC(18, 2),
    @ImporteBonificacion NUMERIC(18, 2),
    @RetencionIBrutos1 NUMERIC(18, 2),
    @PorcentajeIBrutos1 NUMERIC(6, 2),
    @RetencionIBrutos2 NUMERIC(18, 2),
    @PorcentajeIBrutos2 NUMERIC(6, 2),
    @ConvenioMultilateral VARCHAR(2),
    @RetencionIBrutos3 NUMERIC(18, 2),
    @PorcentajeIBrutos3 NUMERIC(6, 2),
    @IdTipoVentaC SMALLINT,
    @ImporteIvaIncluido NUMERIC(18, 2),
    @CotizacionDolar NUMERIC(18, 3),
    @EsMuestra VARCHAR(2),
    @CotizacionADolarFijo NUMERIC(18, 3),
    @ImporteParteEnDolares NUMERIC(18, 2),
    @ImporteParteEnPesos NUMERIC(18, 2),
    @PorcentajeIva1 NUMERIC(6, 2),
    @PorcentajeIva2 NUMERIC(6, 2),
    @FechaVencimiento DATETIME,
    @IVANoDiscriminado NUMERIC(18, 2),
    @IdMoneda INT,
    @CotizacionMoneda NUMERIC(18, 4),
    @PorcentajeBonificacion NUMERIC(6, 2),
    @OtrasPercepciones1 NUMERIC(18, 2),
    @OtrasPercepciones1Desc VARCHAR(15),
    @OtrasPercepciones2 NUMERIC(18, 2),
    @OtrasPercepciones2Desc VARCHAR(15),
    @IdProvinciaDestino INT,
    @IdIBCondicion INT,
    @IdAutorizaAnulacion INT,
    @IdPuntoVenta INT,
    @NumeroCAI NUMERIC(19, 0),
    @FechaVencimientoCAI DATETIME,
    @NumeroCertificadoPercepcionIIBB INT,
    @NumeroTicketInicial INT,
    @NumeroTicketFinal INT,
    @IdUsuarioIngreso INT,
    @FechaIngreso DATETIME,
    @IdObra INT,
    @IdIBCondicion2 INT,
    @IdIBCondicion3 INT,
    @IdCodigoIva INT,
    @Exportacion_FOB NUMERIC(18, 2),
    @Exportacion_PosicionAduana VARCHAR(20),
    @Exportacion_Despacho VARCHAR(30),
    @Exportacion_Guia VARCHAR(20),
    @Exportacion_IdPaisDestino INT,
    @Exportacion_FechaEmbarque DATETIME,
    @Exportacion_FechaOficializacion DATETIME,
    @OtrasPercepciones3 NUMERIC(18, 2),
    @OtrasPercepciones3Desc VARCHAR(15),
    @NoIncluirEnCubos VARCHAR(2),
    @PercepcionIVA NUMERIC(18, 2),
    @PorcentajePercepcionIVA NUMERIC(6, 2),
    @ActivarRecuperoGastos VARCHAR(2),
    @IdAutorizoRecuperoGastos INT,
    @ContabilizarAFechaVencimiento VARCHAR(2),
    @FacturaContado VARCHAR(2),
    @IdReciboContado INT,
    @EnviarEmail INT,
    @IdOrigenTransmision INT,
    @IdFacturaOriginal INT,
    @FechaImportacionTransmision DATETIME,
    @CuitClienteTransmision VARCHAR(13),
    @IdReciboContadoOriginal INT,
    @DevolucionAnticipo VARCHAR(2),
    @PorcentajeDevolucionAnticipo NUMERIC(18, 10),
    @CAE VARCHAR(14),
    @RechazoCAE VARCHAR(11),
    @FechaVencimientoORechazoCAE DATETIME,
    @IdListaPrecios INT,
    @IdIdentificacionCAE INT
AS 
    UPDATE  Facturas
    SET     NumeroFactura = @NumeroFactura,
            TipoABC = @TipoABC,
            PuntoVenta = @PuntoVenta,
            IdCliente = @IdCliente,
            FechaFactura = @FechaFactura,
            IdCondicionVenta = @IdCondicionVenta,
            IdVendedor = @IdVendedor,
            IdTransportista1 = @IdTransportista1,
            IdTransportista2 = @IdTransportista2,
            ItemDireccion = @ItemDireccion,
            OrdenCompra = @OrdenCompra,
            TipoPedidoConsignacion = @TipoPedidoConsignacion,
            Anulada = @Anulada,
            FechaAnulacion = @FechaAnulacion,
            Observaciones = @Observaciones,
            IdRemito = @IdRemito,
            NumeroRemito = @NumeroRemito,
            IdPedido = @IdPedido,
            NumeroPedido = @NumeroPedido,
            ImporteTotal = @ImporteTotal,
            ImporteIva1 = @ImporteIva1,
            ImporteIva2 = @ImporteIva2,
            ImporteBonificacion = @ImporteBonificacion,
            RetencionIBrutos1 = @RetencionIBrutos1,
            PorcentajeIBrutos1 = @PorcentajeIBrutos1,
            RetencionIBrutos2 = @RetencionIBrutos2,
            PorcentajeIBrutos2 = @PorcentajeIBrutos2,
            ConvenioMultilateral = @ConvenioMultilateral,
            RetencionIBrutos3 = @RetencionIBrutos3,
            PorcentajeIBrutos3 = @PorcentajeIBrutos3,
            IdTipoVentaC = @IdTipoVentaC,
            ImporteIvaIncluido = @ImporteIvaIncluido,
            CotizacionDolar = @CotizacionDolar,
            EsMuestra = @EsMuestra,
            CotizacionADolarFijo = @CotizacionADolarFijo,
            ImporteParteEnDolares = @ImporteParteEnDolares,
            ImporteParteEnPesos = @ImporteParteEnPesos,
            PorcentajeIva1 = @PorcentajeIva1,
            PorcentajeIva2 = @PorcentajeIva2,
            FechaVencimiento = @FechaVencimiento,
            IVANoDiscriminado = @IVANoDiscriminado,
            IdMoneda = @IdMoneda,
            CotizacionMoneda = @CotizacionMoneda,
            PorcentajeBonificacion = @PorcentajeBonificacion,
            OtrasPercepciones1 = @OtrasPercepciones1,
            OtrasPercepciones1Desc = @OtrasPercepciones1Desc,
            OtrasPercepciones2 = @OtrasPercepciones2,
            OtrasPercepciones2Desc = @OtrasPercepciones2Desc,
            IdProvinciaDestino = @IdProvinciaDestino,
            IdIBCondicion = @IdIBCondicion,
            IdAutorizaAnulacion = @IdAutorizaAnulacion,
            IdPuntoVenta = @IdPuntoVenta,
            NumeroCAI = @NumeroCAI,
            FechaVencimientoCAI = @FechaVencimientoCAI,
            NumeroCertificadoPercepcionIIBB = @NumeroCertificadoPercepcionIIBB,
            NumeroTicketInicial = @NumeroTicketInicial,
            NumeroTicketFinal = @NumeroTicketFinal,
            IdUsuarioIngreso = @IdUsuarioIngreso,
            FechaIngreso = @FechaIngreso,
            IdObra = @IdObra,
            IdIBCondicion2 = @IdIBCondicion2,
            IdIBCondicion3 = @IdIBCondicion3,
            IdCodigoIva = @IdCodigoIva,
            Exportacion_FOB = @Exportacion_FOB,
            Exportacion_PosicionAduana = @Exportacion_PosicionAduana,
            Exportacion_Despacho = @Exportacion_Despacho,
            Exportacion_Guia = @Exportacion_Guia,
            Exportacion_IdPaisDestino = @Exportacion_IdPaisDestino,
            Exportacion_FechaEmbarque = @Exportacion_FechaEmbarque,
            Exportacion_FechaOficializacion = @Exportacion_FechaOficializacion,
            OtrasPercepciones3 = @OtrasPercepciones3,
            OtrasPercepciones3Desc = @OtrasPercepciones3Desc,
            NoIncluirEnCubos = @NoIncluirEnCubos,
            PercepcionIVA = @PercepcionIVA,
            PorcentajePercepcionIVA = @PorcentajePercepcionIVA,
            ActivarRecuperoGastos = @ActivarRecuperoGastos,
            IdAutorizoRecuperoGastos = @IdAutorizoRecuperoGastos,
            ContabilizarAFechaVencimiento = @ContabilizarAFechaVencimiento,
            FacturaContado = @FacturaContado,
            IdReciboContado = @IdReciboContado,
            EnviarEmail = @EnviarEmail,
            IdOrigenTransmision = @IdOrigenTransmision,
            IdFacturaOriginal = @IdFacturaOriginal,
            FechaImportacionTransmision = @FechaImportacionTransmision,
            CuitClienteTransmision = @CuitClienteTransmision,
            IdReciboContadoOriginal = @IdReciboContadoOriginal,
            DevolucionAnticipo = @DevolucionAnticipo,
            PorcentajeDevolucionAnticipo = @PorcentajeDevolucionAnticipo,
            CAE = @CAE,
            RechazoCAE = @RechazoCAE,
            FechaVencimientoORechazoCAE = @FechaVencimientoORechazoCAE,
            IdListaPrecios = @IdListaPrecios,
            IdIdentificacionCAE = @IdIdentificacionCAE
    WHERE   ( IdFactura = @IdFactura )

    RETURN ( @IdFactura )

GO

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wNotasCredito_TT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wNotasCredito_TT
go

CREATE  PROCEDURE [dbo].wNotasCredito_TT
AS 
    DECLARE @vector_X VARCHAR(30),
        @vector_T VARCHAR(30)
    SET @vector_X = '0111111111111111111111111133'
    SET @vector_T = '0290144114065555551638172600'

    SELECT  NotasCredito.IdNotaCredito,
            CASE WHEN ( NotasCredito.CtaCte = 'SI'
                        OR NotasCredito.CtaCte IS NULL
                      )
                      AND IdFacturaVenta_RecuperoGastos IS NULL THEN 'Normal'
                 ELSE 'Interna'
            END AS [Tipo],
            NotasCredito.IdNotaCredito AS [IdAux],
            NotasCredito.TipoABC AS [A/B/E],
            NotasCredito.PuntoVenta AS [Pto.vta.],
            NotasCredito.NumeroNotaCredito AS [Nota credito],
            NotasCredito.FechaNotaCredito AS [Fecha credito],
            NotasCredito.Anulada AS [Anulada],
            Clientes.CodigoCliente AS [Cod.Cli.],
            Clientes.RazonSocial AS [Cliente],
            DescripcionIva.Descripcion AS [Condicion IVA],
            Clientes.Cuit AS [Cuit],
            ( ISNULL(NotasCredito.ImporteTotal, 0)
              - ISNULL(NotasCredito.ImporteIva1, 0)
              - ISNULL(NotasCredito.ImporteIva2, 0)
              - ISNULL(NotasCredito.PercepcionIVA, 0)
              - ISNULL(NotasCredito.RetencionIBrutos1, 0)
              - ISNULL(NotasCredito.RetencionIBrutos2, 0)
              - ISNULL(NotasCredito.RetencionIBrutos3, 0)
              - ISNULL(NotasCredito.OtrasPercepciones1, 0)
              - ISNULL(NotasCredito.OtrasPercepciones2, 0)
              - ISNULL(NotasCredito.OtrasPercepciones3, 0) ) AS [Neto gravado],
            NotasCredito.ImporteIva1 AS [Iva],
            ISNULL(NotasCredito.RetencionIBrutos1, 0)
            + ISNULL(NotasCredito.RetencionIBrutos2, 0)
            + ISNULL(NotasCredito.RetencionIBrutos3, 0) AS [Ing.Brutos],
            NotasCredito.PercepcionIVA AS [Perc.IVA],
            ISNULL(NotasCredito.OtrasPercepciones1, 0)
            + ISNULL(NotasCredito.OtrasPercepciones2, 0)
            + ISNULL(NotasCredito.OtrasPercepciones3, 0) AS [Otras perc.],
            NotasCredito.ImporteTotal AS [Total credito],
            Monedas.Abreviatura AS [Mon.],
            Obras.NumeroObra AS [Obra],
            Provincias.Nombre AS [Provincia destino],
            NotasCredito.Observaciones,
            Vendedores.Nombre AS [Vendedor],
            NotasCredito.FechaAnulacion AS [Fecha anulacion],
            Empleados.Nombre AS [Ingreso],
            NotasCredito.FechaIngreso AS [Fecha ingreso]
--	@Vector_T as Vector_T,
--	@Vector_X as Vector_X
    FROM    NotasCredito
            LEFT OUTER JOIN Clientes ON NotasCredito.IdCliente = Clientes.IdCliente
            LEFT OUTER JOIN DescripcionIva ON ISNULL(NotasCredito.IdCodigoIva,
                                                     Clientes.IdCodigoIva) = DescripcionIva.IdCodigoIva
            LEFT OUTER JOIN Obras ON NotasCredito.IdObra = Obras.IdObra
            LEFT OUTER JOIN Vendedores ON NotasCredito.IdVendedor = Vendedores.IdVendedor
            LEFT OUTER JOIN Monedas ON NotasCredito.IdMoneda = Monedas.IdMoneda
            LEFT OUTER JOIN Provincias ON NotasCredito.IdProvinciaDestino = Provincias.IdProvincia
            LEFT OUTER JOIN Empleados ON NotasCredito.IdUsuarioIngreso = Empleados.IdEmpleado
    ORDER BY NotasCredito.NumeroNotaCredito

go




--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wLocalidades_TT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wLocalidades_TT
go

CREATE  PROCEDURE [dbo].wLocalidades_TT
AS 
    SELECT  IdLocalidad,
            Localidades.Nombre AS [Localidad],
            Localidades.CodigoPostal AS [Codigo postal],
            Provincias.Nombre AS [Provincia],
            Paises.Descripcion AS [Pais],
            CodigoONCAA as CodigoONCAA, CodigoWilliams,CodigoLosGrobo,
			Partidos.Nombre AS [Partido]
			--,partidos.idpartido
    FROM    Localidades
            LEFT OUTER JOIN Provincias ON Provincias.IdProvincia = Localidades.IdProvincia
            LEFT OUTER JOIN Paises ON Paises.IdPais = Provincias.IdPais
			LEFT OUTER JOIN Partidos ON Partidos.IdPartido= Localidades.IdPartido
    ORDER BY Localidades.Nombre

go

--wLocalidades_TT
--select * from localidades
--select * from partidos
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetOrdenesCompra_T]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wDetOrdenesCompra_T]
go


CREATE PROCEDURE [wDetOrdenesCompra_T] @IdOrdenCompra INT
AS 
    SELECT  doc.IdDetalleOrdenCompra,
            doc.IdOrdenCompra,
            doc.TipoCancelacion,
            ISNULL(doc.FacturacionAutomatica, 'NO') AS [FacturacionAutomatica],
            doc.NumeroItem AS [Item],
            Articulos.IdArticulo,
            Articulos.Codigo AS [Codigo],
            Articulos.Descripcion AS [Articulo],
            Colores.Descripcion AS [Color],
            doc.Cantidad AS [Cant.],
            Unidades.Abreviatura AS [Un.],
            doc.Precio AS [Precio],
            doc.PorcentajeBonificacion AS [% Bon],
            doc.OrigenDescripcion,
            ( doc.Cantidad * doc.Precio ) * ISNULL(doc.PorcentajeBonificacion,
                                                   0) / 100 AS [Bonificacion],
            ( doc.Cantidad * doc.Precio ) * ( 1
                                              - ISNULL(doc.PorcentajeBonificacion,
                                                       0) / 100 ) AS [Importe],
            ( SELECT    SUM(ISNULL(Stock.CantidadUnidades, 0))
              FROM      Stock
              WHERE     Stock.IdArticulo = doc.IdArticulo
            ) AS [Stock],
            doc.FechaNecesidad AS [Fecha nec.],
            doc.FechaEntrega AS [Fecha ent.],
            doc.Observaciones,
            doc.Cumplido AS [Cum]
    FROM    DetalleOrdenesCompra doc
            LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Unidades ON doc.IdUnidad = Unidades.IdUnidad
            LEFT OUTER JOIN Colores ON doc.IdColor = Colores.IdColor
    WHERE   ( doc.IdOrdenCompra = @IdOrdenCompra )
    ORDER BY doc.NumeroItem

GO


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wComprobantesProveedores_TXFecha]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wComprobantesProveedores_TXFecha]
go




CREATE PROCEDURE [dbo].[wComprobantesProveedores_TXFecha]

@Desde datetime,
@Hasta datetime,
@IdUsuario int

AS

SET NOCOUNT ON

DECLARE @IdUsuarioFF int
SET @IdUsuarioFF=IsNull((Select Top 1 E.IdEmpleado From Empleados E 
				Where E.IdEmpleado=@IdUsuario and E.IdCuentaFondoFijo is not null),-1)

CREATE TABLE #Auxiliar1 (IdComprobanteProveedor INTEGER, IdCuenta INTEGER)
INSERT INTO #Auxiliar1 
 SELECT cp.IdComprobanteProveedor, 
	(Select Top 1 dcp.IdCuenta From DetalleComprobantesProveedores dcp 
	 Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor)
 FROM ComprobantesProveedores cp
 WHERE (cp.FechaRecepcion Between @Desde And @Hasta) and 
	(cp.Confirmado is null or cp.Confirmado<>'NO')

SET NOCOUNT OFF

Declare @vector_X varchar(50),@vector_T varchar(50)
Set @vector_X='0111111111111111111111111111111111133'
Set @vector_T='0093634441221012111111023126263222800'

SELECT 
 cp.IdComprobanteProveedor, 
 TiposComprobante.Descripcion as [Tipo comp.],
 cp.IdComprobanteProveedor as [IdAux ], 
 cp.NumeroReferencia as [Nro.interno],
 Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
	Convert(varchar,cp.NumeroComprobante1)+'-'+Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),1,20) as [Numero],
 Case 	When cp.IdProveedor is not null Then 'Cta. cte.' 
	When cp.IdCuenta is not null Then 'F.fijo' 
	When cp.IdCuentaOtros is not null Then 'Otros' 
	Else Null
 End as [Tipo],
 cp.FechaComprobante as [Fecha comp.], 
 cp.FechaRecepcion as [Fecha recep.],
 cp.FechaVencimiento as [Fecha vto.],
 IsNull(P1.CodigoEmpresa,P2.CodigoEmpresa) as [Cod.Prov.], 
 IsNull(P1.RazonSocial,C1.Descripcion) as [Proveedor / Cuenta], IsNull(P1.RazonSocial,C1.Descripcion) as [Cuenta],
 P2.RazonSocial as [Proveedor FF],
 OrdenesPago.NumeroOrdenPago as [Vale],
 IsNull(diva1.Descripcion,IsNull(diva2.Descripcion,diva3.Descripcion)) as [Condicion IVA], 
 cp.IdObra, cp.IdCuenta, cp.Confirmado,cp.NumeroRendicionFF, cp.NumeroReferencia ,FechaComprobante,
 Convert(varchar,Obras.NumeroObra)+' '+Obras.Descripcion as [Obra],
 C2.Descripcion as [Cuenta contable],
 cp.TotalBruto as [Subtotal],
 cp.TotalIva1 as [IVA 1],
 cp.TotalIva2 as [IVA 2],
 cp.AjusteIVA as [Aj.IVA],
 cp.TotalBonificacion as [Imp.bonif.],
 cp.TotalComprobante as [Total],
 Monedas.Abreviatura as [Mon.],
 cp.CotizacionDolar as [Cotiz. dolar],
 Provincias.Nombre as [Provincia destino],
 cp.Observaciones,
 E1.Nombre as [Ingreso],
 cp.FechaIngreso as [Fecha ingreso],
 E2.Nombre  as [Modifico],
 cp.FechaModifico as [Fecha modif.],
 Case 	When DestinoPago='A' Then 'ADM'
	When DestinoPago='O' Then 'OBRA'
	Else Null
 End as [Dest.Pago],
 cp.NumeroRendicionFF as [Nro.Rend.FF],
 (Select Top 1 DetObra.Destino
	From DetalleComprobantesProveedores Det 
	Left Outer Join DetalleObrasDestinos DetObra On DetObra.IdDetalleObraDestino=Det.IdDetalleObraDestino
	Where Det.IdComprobanteProveedor=cp.IdComprobanteProveedor and Det.IdDetalleObraDestino is not null) as [Etapa],
 (Select Top 1 por.Descripcion
	From DetalleComprobantesProveedores Det 
	Left Outer Join PresupuestoObrasRubros por On por.IdPresupuestoObraRubro=Det.IdPresupuestoObraRubro
	Where Det.IdComprobanteProveedor=cp.IdComprobanteProveedor and Det.IdPresupuestoObraRubro is not null) as [Rubro],
 cp.CircuitoFirmasCompleto as [Circuito de firmas completo],
 cp.ConfirmadoPorWeb
 FROM ComprobantesProveedores cp
LEFT OUTER JOIN Proveedores P1 ON cp.IdProveedor = P1.IdProveedor
LEFT OUTER JOIN Proveedores P2 ON cp.IdProveedorEventual = P2.IdProveedor
LEFT OUTER JOIN Cuentas C1 ON IsNull(cp.IdCuenta,cp.IdCuentaOtros) = C1.IdCuenta
LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Obras ON cp.IdObra = Obras.IdObra
LEFT OUTER JOIN OrdenesPago ON cp.IdOrdenPago = OrdenesPago.IdOrdenPago
LEFT OUTER JOIN Monedas ON cp.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Provincias ON cp.IdProvinciaDestino = Provincias.IdProvincia
LEFT OUTER JOIN DescripcionIva diva1 ON cp.IdCodigoIva = diva1.IdCodigoIva
LEFT OUTER JOIN DescripcionIva diva2 ON P1.IdCodigoIva = diva2.IdCodigoIva
LEFT OUTER JOIN DescripcionIva diva3 ON P2.IdCodigoIva = diva3.IdCodigoIva
LEFT OUTER JOIN Empleados E1 ON cp.IdUsuarioIngreso = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON cp.IdUsuarioModifico = E2.IdEmpleado
LEFT OUTER JOIN #Auxiliar1 ON cp.IdComprobanteProveedor = #Auxiliar1.IdComprobanteProveedor
LEFT OUTER JOIN Cuentas C2 ON #Auxiliar1.IdCuenta = C2.IdCuenta
WHERE (cp.FechaRecepcion Between @Desde And @Hasta) and 
	--(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	(@IdUsuarioFF=-1 or @IdUsuarioFF=cp.IdUsuarioIngreso)
ORDER BY cp.FechaRecepcion,cp.NumeroReferencia

DROP TABLE #Auxiliar1

GO


/*

exec wComprobantesProveedores_TXFecha @Desde = 'Abr  1 2011 12:00AM', @Hasta = 'Abr 30 2011 12:00AM', @IdUsuario = -1

SELECT TOP 10 confirmado,confirmadoporweb,* FROM comprobantesproveedores ORDER BY idcomprobanteproveedor desc 

*/


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--REMITOS
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wRemitos_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wRemitos_A]
go

CREATE PROCEDURE wRemitos_A
    @IdRemito INT OUTPUT,
    @NumeroRemito INT,
    @IdCliente INT,
    @FechaRemito DATETIME,
    @IdCondicionVenta INT,
    @Anulado VARCHAR(2),
    @FechaAnulacion DATETIME,
    @Observaciones NTEXT,
    @ArchivoAdjunto1 VARCHAR(100),
    @ArchivoAdjunto2 VARCHAR(100),
    @ArchivoAdjunto3 VARCHAR(100),
    @ArchivoAdjunto4 VARCHAR(100),
    @ArchivoAdjunto5 VARCHAR(100),
    @ArchivoAdjunto6 VARCHAR(100),
    @ArchivoAdjunto7 VARCHAR(100),
    @ArchivoAdjunto8 VARCHAR(100),
    @ArchivoAdjunto9 VARCHAR(100),
    @ArchivoAdjunto10 VARCHAR(100),
    @Destino INT,
    @IdProveedor INT,
    @IdTransportista INT,
    @TotalBultos INT,
    @ValorDeclarado NUMERIC(18, 2),
    @FechaRegistracion DATETIME,
    @IdAutorizaAnulacion INT,
    @IdPuntoVenta INT,
    @PuntoVenta INT,
    @Patente VARCHAR(25),
    @Chofer VARCHAR(50),
    @NumeroDocumento VARCHAR(30),
    @OrdenCarga VARCHAR(10),
    @OrdenCompra VARCHAR(10),
    @COT VARCHAR(20),
    @IdEquipo INT,
    @IdObra INT,
    @IdListaPrecios INT,
    @IdDetalleClienteLugarEntrega INT
AS 
    INSERT  INTO Remitos
            (
              NumeroRemito,
              IdCliente,
              FechaRemito,
              IdCondicionVenta,
              Anulado,
              FechaAnulacion,
              Observaciones,
              ArchivoAdjunto1,
              ArchivoAdjunto2,
              ArchivoAdjunto3,
              ArchivoAdjunto4,
              ArchivoAdjunto5,
              ArchivoAdjunto6,
              ArchivoAdjunto7,
              ArchivoAdjunto8,
              ArchivoAdjunto9,
              ArchivoAdjunto10,
              Destino,
              IdProveedor,
              IdTransportista,
              TotalBultos,
              ValorDeclarado,
              FechaRegistracion,
              IdAutorizaAnulacion,
              IdPuntoVenta,
              PuntoVenta,
              Patente,
              Chofer,
              NumeroDocumento,
              OrdenCarga,
              OrdenCompra,
              COT,
              IdEquipo,
              IdObra,
              IdListaPrecios,
              IdDetalleClienteLugarEntrega
            )
    VALUES  (
              @NumeroRemito,
              @IdCliente,
              @FechaRemito,
              @IdCondicionVenta,
              @Anulado,
              @FechaAnulacion,
              @Observaciones,
              @ArchivoAdjunto1,
              @ArchivoAdjunto2,
              @ArchivoAdjunto3,
              @ArchivoAdjunto4,
              @ArchivoAdjunto5,
              @ArchivoAdjunto6,
              @ArchivoAdjunto7,
              @ArchivoAdjunto8,
              @ArchivoAdjunto9,
              @ArchivoAdjunto10,
              @Destino,
              @IdProveedor,
              @IdTransportista,
              @TotalBultos,
              @ValorDeclarado,
              GETDATE(),
              @IdAutorizaAnulacion,
              @IdPuntoVenta,
              @PuntoVenta,
              @Patente,
              @Chofer,
              @NumeroDocumento,
              @OrdenCarga,
              @OrdenCompra,
              @COT,
              @IdEquipo,
              @IdObra,
              @IdListaPrecios,
              @IdDetalleClienteLugarEntrega
            )

    SELECT  @IdRemito = @@identity
    RETURN ( @IdRemito )

GO



--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wRemitos_M]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wRemitos_M]
go

CREATE PROCEDURE wRemitos_M
    @IdRemito INT,
    @NumeroRemito INT,
    @IdCliente INT,
    @FechaRemito DATETIME,
    @IdCondicionVenta INT,
    @Anulado VARCHAR(2),
    @FechaAnulacion DATETIME,
    @Observaciones NTEXT,
    @ArchivoAdjunto1 VARCHAR(100),
    @ArchivoAdjunto2 VARCHAR(100),
    @ArchivoAdjunto3 VARCHAR(100),
    @ArchivoAdjunto4 VARCHAR(100),
    @ArchivoAdjunto5 VARCHAR(100),
    @ArchivoAdjunto6 VARCHAR(100),
    @ArchivoAdjunto7 VARCHAR(100),
    @ArchivoAdjunto8 VARCHAR(100),
    @ArchivoAdjunto9 VARCHAR(100),
    @ArchivoAdjunto10 VARCHAR(100),
    @Destino INT,
    @IdProveedor INT,
    @IdTransportista INT,
    @TotalBultos INT,
    @ValorDeclarado NUMERIC(18, 2),
    @FechaRegistracion DATETIME,
    @IdAutorizaAnulacion INT,
    @IdPuntoVenta INT,
    @PuntoVenta INT,
    @Patente VARCHAR(25),
    @Chofer VARCHAR(50),
    @NumeroDocumento VARCHAR(30),
    @OrdenCarga VARCHAR(10),
    @OrdenCompra VARCHAR(10),
    @COT VARCHAR(20),
    @IdEquipo INT,
    @IdObra INT,
    @IdListaPrecios INT,
    @IdDetalleClienteLugarEntrega INT
AS 
    UPDATE  Remitos
    SET     NumeroRemito = @NumeroRemito,
            IdCliente = @IdCliente,
            FechaRemito = @FechaRemito,
            IdCondicionVenta = @IdCondicionVenta,
            Anulado = @Anulado,
            FechaAnulacion = @FechaAnulacion,
            Observaciones = @Observaciones,
            ArchivoAdjunto1 = @ArchivoAdjunto1,
            ArchivoAdjunto2 = @ArchivoAdjunto2,
            ArchivoAdjunto3 = @ArchivoAdjunto3,
            ArchivoAdjunto4 = @ArchivoAdjunto4,
            ArchivoAdjunto5 = @ArchivoAdjunto5,
            ArchivoAdjunto6 = @ArchivoAdjunto6,
            ArchivoAdjunto7 = @ArchivoAdjunto7,
            ArchivoAdjunto8 = @ArchivoAdjunto8,
            ArchivoAdjunto9 = @ArchivoAdjunto9,
            ArchivoAdjunto10 = @ArchivoAdjunto10,
            Destino = @Destino,
            IdProveedor = @IdProveedor,
            IdTransportista = @IdTransportista,
            TotalBultos = @TotalBultos,
            ValorDeclarado = @ValorDeclarado,
            FechaRegistracion = @FechaRegistracion,
            IdAutorizaAnulacion = @IdAutorizaAnulacion,
            IdPuntoVenta = @IdPuntoVenta,
            PuntoVenta = @PuntoVenta,
            Patente = @Patente,
            Chofer = @Chofer,
            NumeroDocumento = @NumeroDocumento,
            OrdenCarga = @OrdenCarga,
            OrdenCompra = @OrdenCompra,
            COT = @COT,
            IdEquipo = @IdEquipo,
            IdObra = @IdObra,
            IdListaPrecios = @IdListaPrecios,
            IdDetalleClienteLugarEntrega = @IdDetalleClienteLugarEntrega
    WHERE   ( IdRemito = @IdRemito )

    RETURN ( @IdRemito )

GO


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetRemitos_A]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wDetRemitos_A]
go
CREATE PROCEDURE wDetRemitos_A
    @IdDetalleRemito INT OUTPUT,
    @IdRemito INT,
    @NumeroItem INT,
    @Cantidad NUMERIC(18, 2),
    @IdUnidad INT,
    @IdArticulo INT,
    @Precio NUMERIC(18, 2),
    @Observaciones NTEXT,
    @PorcentajeCertificacion NUMERIC(6, 2),
    @OrigenDescripcion INT,
    @IdDetalleOrdenCompra INT,
    @TipoCancelacion INT,
    @IdUbicacion INT,
    @IdObra INT,
    @Partida VARCHAR(20),
    @DescargaPorKit VARCHAR(2),
    @NumeroCaja INT
AS 
    BEGIN TRAN

    DECLARE @Anulado VARCHAR(2),
        @IdStock1 INT

--en Web no puedo dejar esta linea, se traba la transaccion si voy a buscar el ID del encabezado que estoy editando
--SET @Anulado=IsNull((Select Top 1 Anulado From Remitos Where IdRemito=@IdRemito),'NO')

    IF @Anulado <> 'SI' 
        BEGIN
            IF ISNULL(@DescargaPorKit, 'NO') <> 'SI' 
                BEGIN
                    SET @IdStock1 = ISNULL(( SELECT TOP 1
                                                    Stock.IdStock
                                             FROM   Stock
                                             WHERE  IdArticulo = @IdArticulo
                                                    AND Partida = @Partida
                                                    AND IdUbicacion = @IdUbicacion
                                                    AND IdObra = @IdObra
                                                    AND IdUnidad = @IdUnidad
                                                    AND ISNULL(NumeroCaja, 0) = ISNULL(@NumeroCaja, 0)
                                           ), 0)
                    IF @IdStock1 > 0 
                        UPDATE  Stock
                        SET     CantidadUnidades = ISNULL(CantidadUnidades, 0)
                                - @Cantidad
                        WHERE   IdStock = @IdStock1
                    ELSE 
                        INSERT  INTO Stock
                                (
                                  IdArticulo,
                                  Partida,
                                  CantidadUnidades,
                                  CantidadAdicional,
                                  IdUnidad,
                                  IdUbicacion,
                                  IdObra,
                                  NumeroCaja
                                )
                        VALUES  (
                                  @IdArticulo,
                                  @Partida,
                                  @Cantidad * -1,
                                  NULL,
                                  @IdUnidad,
                                  @IdUbicacion,
                                  @IdObra,
                                  @NumeroCaja
                                )
                END
            ELSE 
                BEGIN
                    SET NOCOUNT ON
                    CREATE TABLE #Auxiliar1
                        (
                          IdArticuloConjunto INTEGER,
                          IdUnidadConjunto INTEGER,
                          CantidadConjunto NUMERIC(18, 3)
                        )
                    INSERT  INTO #Auxiliar1
                            SELECT  dc.IdArticulo,
                                    dc.IdUnidad,
                                    ISNULL(dc.Cantidad, 0)
                            FROM    DetalleConjuntos dc
                                    LEFT OUTER JOIN Conjuntos ON dc.IdConjunto = Conjuntos.IdConjunto
                            WHERE   ( Conjuntos.IdArticulo = @IdArticulo )

                    DECLARE @IdArticuloConjunto INT,
                        @IdUnidadConjunto INT,
                        @CantidadConjunto NUMERIC(18, 3)
                    CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 ( IdArticuloConjunto )
                    ON  [PRIMARY]
                    DECLARE Cur CURSOR LOCAL FORWARD_ONLY
                        FOR SELECT  IdArticuloConjunto,
                                    IdUnidadConjunto,
                                    CantidadConjunto
                            FROM    #Auxiliar1
                            ORDER BY IdArticuloConjunto
                    OPEN Cur
                    FETCH NEXT FROM Cur INTO @IdArticuloConjunto,
                        @IdUnidadConjunto, @CantidadConjunto
                    WHILE @@FETCH_STATUS = 0
                        BEGIN
                            SET @IdStock1 = ISNULL(( SELECT TOP 1
                                                            Stock.IdStock
                                                     FROM   Stock
                                                     WHERE  IdArticulo = @IdArticuloConjunto
                                                            AND Partida = ''
                                                            AND IdUbicacion = @IdUbicacion
                                                            AND IdObra = @IdObra
                                                            AND IdUnidad = @IdUnidadConjunto
                                                   ), 0)
                            IF @IdStock1 > 0 
                                UPDATE  Stock
                                SET     CantidadUnidades = ISNULL(CantidadUnidades, 0)
                                        - ( @Cantidad * @CantidadConjunto )
                                WHERE   IdStock = @IdStock1
                            ELSE 
                                INSERT  INTO Stock
                                        (
                                          IdArticulo,
                                          Partida,
                                          CantidadUnidades,
                                          CantidadAdicional,
                                          IdUnidad,
                                          IdUbicacion,
                                          IdObra
                                        )
                                VALUES  (
                                          @IdArticuloConjunto,
                                          0,
                                          ( @Cantidad * @CantidadConjunto )
                                          * -1,
                                          NULL,
                                          @IdUnidadConjunto,
                                          @IdUbicacion,
                                          @IdObra
                                        )
                            FETCH NEXT FROM Cur INTO @IdArticuloConjunto,
                                @IdUnidadConjunto, @CantidadConjunto
                        END
                    CLOSE Cur
                    DEALLOCATE Cur

                    DROP TABLE #Auxiliar1
                    SET NOCOUNT OFF
                END
        END

    INSERT  INTO [DetalleRemitos]
            (
              IdRemito,
              NumeroItem,
              Cantidad,
              IdUnidad,
              IdArticulo,
              Precio,
              Observaciones,
              PorcentajeCertificacion,
              OrigenDescripcion,
              IdDetalleOrdenCompra,
              TipoCancelacion,
              IdUbicacion,
              IdObra,
              Partida,
              DescargaPorKit,
              NumeroCaja
            )
    VALUES  (
              @IdRemito,
              @NumeroItem,
              @Cantidad,
              @IdUnidad,
              @IdArticulo,
              @Precio,
              @Observaciones,
              @PorcentajeCertificacion,
              @OrigenDescripcion,
              @IdDetalleOrdenCompra,
              @TipoCancelacion,
              @IdUbicacion,
              @IdObra,
              @Partida,
              @DescargaPorKit,
              @NumeroCaja
            )

    SELECT  @IdDetalleRemito = @@identity

    IF @@ERROR <> 0 
        GOTO AbortTransaction

    COMMIT TRAN
    GOTO EndTransaction

    AbortTransaction:
    ROLLBACK TRAN

    EndTransaction:
    RETURN ( @IdDetalleRemito )

GO




--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wDetRemitos_M]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wDetRemitos_M]
go


CREATE PROCEDURE wDetRemitos_M
    @IdDetalleRemito INT,
    @IdRemito INT,
    @NumeroItem INT,
    @Cantidad NUMERIC(18, 2),
    @IdUnidad INT,
    @IdArticulo INT,
    @Precio NUMERIC(18, 2),
    @Observaciones NTEXT,
    @PorcentajeCertificacion NUMERIC(6, 2),
    @OrigenDescripcion INT,
    @IdDetalleOrdenCompra INT,
    @TipoCancelacion INT,
    @IdUbicacion INT,
    @IdObra INT,
    @Partida VARCHAR(20),
    @DescargaPorKit VARCHAR(2),
    @NumeroCaja INT
AS 
    BEGIN TRAN

    DECLARE @IdStockAnt INT,
        @IdArticuloAnt INT,
        @PartidaAnt VARCHAR(20),
        @CantidadUnidadesAnt NUMERIC(18, 2),
        @IdUnidadAnt INT,
        @IdUbicacionAnt INT,
        @IdObraAnt INT,
        @NumeroCajaAnt INT,
        @IdStock1 INT,
        @Anulado VARCHAR(2)

--en Web no puedo dejar esta linea, se traba la transaccion si voy a buscar el ID del encabezado que estoy editando
--SET @Anulado=IsNull((Select Top 1 Anulado From Remitos Where IdRemito=@IdRemito),'NO')
    IF @Anulado <> 'SI' 
        BEGIN
            SET @IdArticuloAnt = ISNULL(( SELECT TOP 1
                                                    IdArticulo
                                          FROM      DetalleRemitos
                                          WHERE     IdDetalleRemito = @IdDetalleRemito
                                        ), 0)
            SET @PartidaAnt = ISNULL(( SELECT TOP 1
                                                Partida
                                       FROM     DetalleRemitos
                                       WHERE    IdDetalleRemito = @IdDetalleRemito
                                     ), '')
            SET @CantidadUnidadesAnt = ISNULL(( SELECT TOP 1
                                                        Cantidad
                                                FROM    DetalleRemitos
                                                WHERE   IdDetalleRemito = @IdDetalleRemito
                                              ), 0)
            SET @IdUnidadAnt = ISNULL(( SELECT TOP 1
                                                IdUnidad
                                        FROM    DetalleRemitos
                                        WHERE   IdDetalleRemito = @IdDetalleRemito
                                      ), 0)
            SET @IdUbicacionAnt = ISNULL(( SELECT TOP 1
                                                    IdUbicacion
                                           FROM     DetalleRemitos
                                           WHERE    IdDetalleRemito = @IdDetalleRemito
                                         ), 0)
            SET @IdObraAnt = ISNULL(( SELECT TOP 1
                                                IdObra
                                      FROM      DetalleRemitos
                                      WHERE     IdDetalleRemito = @IdDetalleRemito
                                    ), 0)
            SET @NumeroCajaAnt = ISNULL(( SELECT TOP 1
                                                    NumeroCaja
                                          FROM      DetalleRemitos
                                          WHERE     IdDetalleRemito = @IdDetalleRemito
                                        ), 0)

            IF ISNULL(@DescargaPorKit, 'NO') <> 'SI' 
                BEGIN
                    SET @IdStockAnt = ISNULL(( SELECT TOP 1
                                                        Stock.IdStock
                                               FROM     Stock
                                               WHERE    IdArticulo = @IdArticuloAnt
                                                        AND Partida = @PartidaAnt
                                                        AND IdUbicacion = @IdUbicacionAnt
                                                        AND IdObra = @IdObraAnt
                                                        AND IdUnidad = @IdUnidadAnt
                                                        AND ISNULL(NumeroCaja, 0) = ISNULL(@NumeroCajaAnt, 0)
                                             ), 0)
                    IF @IdStockAnt > 0 
                        UPDATE  Stock
                        SET     CantidadUnidades = ISNULL(CantidadUnidades, 0)
                                + @CantidadUnidadesAnt
                        WHERE   IdStock = @IdStockAnt
                    ELSE 
                        INSERT  INTO Stock
                                (
                                  IdArticulo,
                                  Partida,
                                  CantidadUnidades,
                                  CantidadAdicional,
                                  IdUnidad,
                                  IdUbicacion,
                                  IdObra,
                                  NumeroCaja
                                )
                        VALUES  (
                                  @IdArticuloAnt,
                                  @PartidaAnt,
                                  @CantidadUnidadesAnt,
                                  NULL,
                                  @IdUnidadAnt,
                                  @IdUbicacionAnt,
                                  @IdObraAnt,
                                  @NumeroCajaAnt
                                )
		
                    SET @IdStock1 = ISNULL(( SELECT TOP 1
                                                    Stock.IdStock
                                             FROM   Stock
                                             WHERE  IdArticulo = @IdArticulo
                                                    AND Partida = @Partida
                                                    AND IdUbicacion = @IdUbicacion
                                                    AND IdObra = @IdObra
                                                    AND IdUnidad = @IdUnidad
                                                    AND ISNULL(NumeroCaja, 0) = ISNULL(@NumeroCaja, 0)
                                           ), 0)
                    IF @IdStock1 > 0 
                        UPDATE  Stock
                        SET     CantidadUnidades = ISNULL(CantidadUnidades, 0)
                                - @Cantidad
                        WHERE   IdStock = @IdStock1
                    ELSE 
                        INSERT  INTO Stock
                                (
                                  IdArticulo,
                                  Partida,
                                  CantidadUnidades,
                                  CantidadAdicional,
                                  IdUnidad,
                                  IdUbicacion,
                                  IdObra,
                                  NumeroCaja
                                )
                        VALUES  (
                                  @IdArticulo,
                                  @Partida,
                                  @Cantidad * -1,
                                  NULL,
                                  @IdUnidad,
                                  @IdUbicacion,
                                  @IdObra,
                                  @NumeroCaja
                                )
                END
            ELSE 
                BEGIN
                    SET NOCOUNT ON
                    DECLARE @IdArticuloConjunto INT,
                        @IdUnidadConjunto INT,
                        @CantidadConjunto NUMERIC(18, 2)

                    CREATE TABLE #Auxiliar1
                        (
                          IdArticuloConjunto INTEGER,
                          IdUnidadConjunto INTEGER,
                          CantidadConjunto NUMERIC(18, 2)
                        )
                    INSERT  INTO #Auxiliar1
                            SELECT  dc.IdArticulo,
                                    dc.IdUnidad,
                                    ISNULL(dc.Cantidad, 0)
                            FROM    DetalleConjuntos dc
                                    LEFT OUTER JOIN Conjuntos ON dc.IdConjunto = Conjuntos.IdConjunto
                            WHERE   ( Conjuntos.IdArticulo = @IdArticuloAnt )

                    CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 ( IdArticuloConjunto )
                    ON  [PRIMARY]
                    DECLARE Cur CURSOR LOCAL FORWARD_ONLY
                        FOR SELECT  IdArticuloConjunto,
                                    IdUnidadConjunto,
                                    CantidadConjunto
                            FROM    #Auxiliar1
                            ORDER BY IdArticuloConjunto
                    OPEN Cur
                    FETCH NEXT FROM Cur INTO @IdArticuloConjunto,
                        @IdUnidadConjunto, @CantidadConjunto
                    WHILE @@FETCH_STATUS = 0
                        BEGIN
                            SET @IdStock1 = ISNULL(( SELECT TOP 1
                                                            Stock.IdStock
                                                     FROM   Stock
                                                     WHERE  IdArticulo = @IdArticuloConjunto
                                                            AND Partida = ''
                                                            AND IdUbicacion = @IdUbicacion
                                                            AND IdObra = @IdObra
                                                            AND IdUnidad = @IdUnidadConjunto
                                                   ), 0)
                            IF @IdStock1 > 0 
                                UPDATE  Stock
                                SET     CantidadUnidades = ISNULL(CantidadUnidades, 0)
                                        + ( @Cantidad * @CantidadConjunto )
                                WHERE   IdStock = @IdStock1
                            ELSE 
                                INSERT  INTO Stock
                                        (
                                          IdArticulo,
                                          Partida,
                                          CantidadUnidades,
                                          CantidadAdicional,
                                          IdUnidad,
                                          IdUbicacion,
                                          IdObra
                                        )
                                VALUES  (
                                          @IdArticuloConjunto,
                                          0,
                                          ( @Cantidad * @CantidadConjunto ),
                                          NULL,
                                          @IdUnidadConjunto,
                                          @IdUbicacion,
                                          @IdObra
                                        )
                            FETCH NEXT FROM Cur INTO @IdArticuloConjunto,
                                @IdUnidadConjunto, @CantidadConjunto
                        END
                    CLOSE Cur
                    DEALLOCATE Cur
                    DROP TABLE #Auxiliar1

                    CREATE TABLE #Auxiliar2
                        (
                          IdArticuloConjunto INTEGER,
                          IdUnidadConjunto INTEGER,
                          CantidadConjunto NUMERIC(18, 2)
                        )
                    INSERT  INTO #Auxiliar2
                            SELECT  dc.IdArticulo,
                                    dc.IdUnidad,
                                    ISNULL(dc.Cantidad, 0)
                            FROM    DetalleConjuntos dc
                                    LEFT OUTER JOIN Conjuntos ON dc.IdConjunto = Conjuntos.IdConjunto
                            WHERE   ( Conjuntos.IdArticulo = @IdArticulo )

                    CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 ( IdArticuloConjunto )
                    ON  [PRIMARY]
                    DECLARE Cur CURSOR LOCAL FORWARD_ONLY
                        FOR SELECT  IdArticuloConjunto,
                                    IdUnidadConjunto,
                                    CantidadConjunto
                            FROM    #Auxiliar2
                            ORDER BY IdArticuloConjunto
                    OPEN Cur
                    FETCH NEXT FROM Cur INTO @IdArticuloConjunto,
                        @IdUnidadConjunto, @CantidadConjunto
                    WHILE @@FETCH_STATUS = 0
                        BEGIN
                            SET @IdStock1 = ISNULL(( SELECT TOP 1
                                                            Stock.IdStock
                                                     FROM   Stock
                                                     WHERE  IdArticulo = @IdArticuloConjunto
                                                            AND Partida = ''
                                                            AND IdUbicacion = @IdUbicacion
                                                            AND IdObra = @IdObra
                                                            AND IdUnidad = @IdUnidadConjunto
                                                   ), 0)
                            IF @IdStock1 > 0 
                                UPDATE  Stock
                                SET     CantidadUnidades = ISNULL(CantidadUnidades, 0)
                                        - ( @Cantidad * @CantidadConjunto )
                                WHERE   IdStock = @IdStock1
                            ELSE 
                                INSERT  INTO Stock
                                        (
                                          IdArticulo,
                                          Partida,
                                          CantidadUnidades,
                                          CantidadAdicional,
                                          IdUnidad,
                                          IdUbicacion,
                                          IdObra
                                        )
                                VALUES  (
                                          @IdArticuloConjunto,
                                          0,
                                          ( @Cantidad * @CantidadConjunto )
                                          * -1,
                                          NULL,
                                          @IdUnidadConjunto,
                                          @IdUbicacion,
                                          @IdObra
                                        )
                            FETCH NEXT FROM Cur INTO @IdArticuloConjunto,
                                @IdUnidadConjunto, @CantidadConjunto
                        END
                    CLOSE Cur
                    DEALLOCATE Cur
                    DROP TABLE #Auxiliar2
                    SET NOCOUNT OFF
                END
        END

    UPDATE  [DetalleRemitos]
    SET     IdRemito = @IdRemito,
            NumeroItem = @NumeroItem,
            Cantidad = @Cantidad,
            IdUnidad = @IdUnidad,
            IdArticulo = @IdArticulo,
            Precio = @Precio,
            Observaciones = @Observaciones,
            PorcentajeCertificacion = @PorcentajeCertificacion,
            OrigenDescripcion = @OrigenDescripcion,
            IdDetalleOrdenCompra = @IdDetalleOrdenCompra,
            TipoCancelacion = @TipoCancelacion,
            IdUbicacion = @IdUbicacion,
            IdObra = @IdObra,
            Partida = @Partida,
            DescargaPorKit = @DescargaPorKit
    WHERE   ( IdDetalleRemito = @IdDetalleRemito )

    IF @@ERROR <> 0 
        GOTO AbortTransaction

    COMMIT TRAN
    GOTO EndTransaction

    AbortTransaction:
    ROLLBACK TRAN

    EndTransaction:
    RETURN ( @IdDetalleRemito )

GO





--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wOrdenesCompra_TX_DetallesPendientesDeFacturarPorIdCliente]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wOrdenesCompra_TX_DetallesPendientesDeFacturarPorIdCliente]
go


CREATE PROCEDURE wOrdenesCompra_TX_DetallesPendientesDeFacturarPorIdCliente @IdCliente INT
AS 
    SET NOCOUNT ON
    CREATE TABLE #Auxiliar1
        (
          IdDetalleOrdenCompra INTEGER,
          Pendiente NUMERIC(18, 2)
        )
    INSERT  INTO #Auxiliar1
            SELECT  doc.IdDetalleOrdenCompra,
                    CASE WHEN doc.TipoCancelacion = 1
                         THEN doc.Cantidad
                              - ISNULL(( SELECT SUM(ISNULL(df.Cantidad, 0))
                                         FROM   DetalleFacturasOrdenesCompra dfoc
                                                LEFT OUTER JOIN DetalleFacturas df ON df.IdDetalleFactura = dfoc.IdDetalleFactura
                                                LEFT OUTER JOIN Facturas fa ON fa.IdFactura = df.IdFactura
                                         WHERE  dfoc.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
                                                AND ( fa.Anulada IS NULL
                                                      OR fa.Anulada <> 'SI'
                                                    )
                                       ), 0)
                              + ISNULL(( SELECT SUM(ISNULL(dncoc.Cantidad, 0))
                                         FROM   DetalleNotasCreditoOrdenesCompra dncoc
                                                LEFT OUTER JOIN NotasCredito nc ON nc.IdNotaCredito = dncoc.IdNotaCredito
                                         WHERE  dncoc.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
                                                AND ( nc.Anulada IS NULL
                                                      OR nc.Anulada <> 'SI'
                                                    )
                                       ), 0)
                         ELSE 100
                              - ISNULL(( SELECT SUM(ISNULL(df.PorcentajeCertificacion,
                                                           0))
                                         FROM   DetalleFacturasOrdenesCompra dfoc
                                                LEFT OUTER JOIN DetalleFacturas df ON df.IdDetalleFactura = dfoc.IdDetalleFactura
                                                LEFT OUTER JOIN Facturas fa ON fa.IdFactura = df.IdFactura
                                         WHERE  dfoc.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
                                                AND ( fa.Anulada IS NULL
                                                      OR fa.Anulada <> 'SI'
                                                    )
                                       ), 0)
                              + ISNULL(( SELECT SUM(ISNULL(dncoc.PorcentajeCertificacion,
                                                           0))
                                         FROM   DetalleNotasCreditoOrdenesCompra dncoc
                                                LEFT OUTER JOIN NotasCredito nc ON nc.IdNotaCredito = dncoc.IdNotaCredito
                                         WHERE  dncoc.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
                                                AND ( nc.Anulada IS NULL
                                                      OR nc.Anulada <> 'SI'
                                                    )
                                       ), 0)
                    END
            FROM    DetalleOrdenesCompra doc
                    LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
            WHERE   OrdenesCompra.IdCliente = @IdCliente
                    AND ISNULL(OrdenesCompra.Anulada, 'NO') <> 'SI'
                    AND ISNULL(doc.Cumplido, 'NO') = 'NO'

    SET NOCOUNT OFF

    DECLARE @vector_X VARCHAR(30),
        @vector_T VARCHAR(30),
        @Entregado NUMERIC,
        @Pedido NUMERIC
    SET @vector_X = '01111111111111133'
    SET @vector_T = '03904HD0192209100'

    SELECT  0,
            OrdenesCompra.NumeroOrdenCompra AS [OCompra],
            doc.IdDetalleOrdenCompra,
            OrdenesCompra.NumeroOrdenCompraCliente AS [OC(Cli)],
            Obras.NumeroObra AS [Obra],
            doc.NumeroItem AS [Item],
            Articulos.Descripcion + ISNULL(' ' + Colores.Descripcion COLLATE Modern_Spanish_CI_AS,
                                           '') AS [Articulo],
            doc.Cantidad AS [Cant.],
            Unidades.Abreviatura AS [Unidad],
            doc.IdArticulo,
            doc.Precio AS [Precio],
            doc.PorcentajeBonificacion AS [% Bon],
            doc.Cantidad * doc.Precio * ( 1
                                          - ISNULL(doc.PorcentajeBonificacion,
                                                   0) / 100 ) AS [Importe],
            CASE WHEN doc.TipoCancelacion = 1 THEN #Auxiliar1.Pendiente
                 ELSE #Auxiliar1.Pendiente
            END AS [AFacturar],
            CASE WHEN doc.TipoCancelacion = 1
                 THEN CONVERT(VARCHAR, #Auxiliar1.Pendiente)
                 ELSE CONVERT(VARCHAR, #Auxiliar1.Pendiente) + ' %'
            END AS [Pendfacturar],
            @Vector_T AS Vector_T,
            @Vector_X AS Vector_X
    FROM    DetalleOrdenesCompra doc
            LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
            LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Unidades ON doc.IdUnidad = Unidades.IdUnidad
            LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra = Obras.IdObra
            LEFT OUTER JOIN #Auxiliar1 ON doc.IdDetalleOrdenCompra = #Auxiliar1.IdDetalleOrdenCompra
            LEFT OUTER JOIN Colores ON doc.IdColor = Colores.IdColor
    WHERE   OrdenesCompra.IdCliente = @IdCliente
            AND ISNULL(OrdenesCompra.Anulada, '') <> 'SI'
            AND ISNULL(#Auxiliar1.Pendiente, 0) > 0
    DROP TABLE #Auxiliar1

GO

--exec wOrdenesCompra_TX_DetallesPendientesDeFacturarPorIdCliente 25

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wRemitos_TT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wRemitos_TT]
go

CREATE  PROCEDURE wRemitos_TT
AS 
    SET NOCOUNT ON

--esto tarda banda. lo saqué para que prontoweb no llegara al timeout
/*
CREATE TABLE #Auxiliar1 
			(
			 IdRemito INTEGER,
			 Obras VARCHAR(100)
			)

CREATE TABLE #Auxiliar2 
			(
			 IdRemito INTEGER,
			 NumeroObra VARCHAR(13)
			)
INSERT INTO #Auxiliar2 
 SELECT Det.IdRemito, Obras.NumeroObra
 FROM DetalleRemitos Det
 LEFT OUTER JOIN Remitos ON Det.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN Obras ON Det.IdObra = Obras.IdObra

CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdRemito,NumeroObra) ON [PRIMARY]

INSERT INTO #Auxiliar1
 SELECT IdRemito, ''
 FROM #Auxiliar2
 GROUP BY IdRemito


DECLARE @IdRemito int, @NumeroObra varchar(13), @Obras varchar(100), @Corte int
SET @Corte=0
SET @Obras=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdRemito, NumeroObra
		FROM #Auxiliar2
		ORDER BY IdRemito
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRemito, @NumeroObra
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRemito
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar1
			SET Obras = SUBSTRING(@Obras,1,100)
			WHERE #Auxiliar1.IdRemito=@Corte
		SET @Obras=''
		SET @Corte=@IdRemito
	   END
	IF NOT @NumeroObra IS NULL
		IF PATINDEX('%'+CONVERT(VARCHAR,@NumeroObra)+' '+'%', @Obras)=0
			SET @Obras=@Obras+@NumeroObra+' '
	FETCH NEXT FROM Cur INTO @IdRemito, @NumeroObra
   END
 IF @Corte<>0
    BEGIN
	UPDATE #Auxiliar1
	SET Obras = SUBSTRING(@Obras,1,100)
	WHERE #Auxiliar1.IdRemito=@Corte
    END
CLOSE Cur
DEALLOCATE Cur

CREATE TABLE #Auxiliar3 
			(
			 IdRemito INTEGER,
			 OCompras VARCHAR(500)
			)

CREATE TABLE #Auxiliar4 
			(
			 IdRemito INTEGER,
			 OCompra VARCHAR(8)
			)
INSERT INTO #Auxiliar4 
 SELECT Det.IdRemito, 
	Substring('00000000',1,8-Len(Convert(varchar,OrdenesCompra.NumeroOrdenCompra)))+
		Convert(varchar,OrdenesCompra.NumeroOrdenCompra)
 FROM DetalleRemitos Det
 LEFT OUTER JOIN Remitos ON Det.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN DetalleOrdenesCompra ON Det.IdDetalleOrdenCompra = DetalleOrdenesCompra.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON DetalleOrdenesCompra.IdOrdenCompra = OrdenesCompra.IdOrdenCompra

CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (IdRemito,OCompra) ON [PRIMARY]

INSERT INTO #Auxiliar3 
 SELECT IdRemito, ''
 FROM #Auxiliar4
 GROUP BY IdRemito


DECLARE @OCompra varchar(8), @P varchar(500)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdRemito, OCompra
		FROM #Auxiliar4
		ORDER BY IdRemito
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRemito, @OCompra
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRemito
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar3
			SET OCompras = SUBSTRING(@P,1,500)
			WHERE IdRemito=@Corte
		SET @P=''
		SET @Corte=@IdRemito
	   END
	IF NOT @OCompra IS NULL
		IF PATINDEX('%'+@OCompra+' '+'%', @P)=0
			SET @P=@P+@OCompra+' '
	FETCH NEXT FROM Cur INTO @IdRemito, @OCompra
   END
   IF @Corte<>0
	UPDATE #Auxiliar3
	SET OCompras = SUBSTRING(@P,1,500)
	WHERE IdRemito=@Corte
CLOSE Cur
DEALLOCATE Cur

CREATE TABLE #Auxiliar5 
			(
			 IdRemito INTEGER,
			 Facturas VARCHAR(500)
			)

CREATE TABLE #Auxiliar6 
			(
			 IdRemito INTEGER,
			 Factura VARCHAR(15)
			)
INSERT INTO #Auxiliar6 
 SELECT Det.IdRemito, 
	Facturas.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,IsNull(Facturas.PuntoVenta,0))))+
		Convert(varchar,IsNull(Facturas.PuntoVenta,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+
		Convert(varchar,Facturas.NumeroFactura)
 FROM DetalleRemitos Det
 LEFT OUTER JOIN Remitos ON Det.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN DetalleFacturasRemitos ON Det.IdDetalleRemito = DetalleFacturasRemitos.IdDetalleRemito
 LEFT OUTER JOIN Facturas ON DetalleFacturasRemitos.IdFactura = Facturas.IdFactura

CREATE NONCLUSTERED INDEX IX__Auxiliar6 ON #Auxiliar6 (IdRemito,Factura) ON [PRIMARY]

INSERT INTO #Auxiliar5 
 SELECT IdRemito, ''
 FROM #Auxiliar6
 GROUP BY IdRemito

DECLARE @Factura varchar(15)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdRemito, Factura
		FROM #Auxiliar6
		ORDER BY IdRemito
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRemito, @Factura
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRemito
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar5
			SET Facturas = SUBSTRING(@P,1,500)
			WHERE IdRemito=@Corte
		SET @P=''
		SET @Corte=@IdRemito
	   END
	IF NOT @Factura IS NULL
		IF PATINDEX('%'+@Factura+' '+'%', @P)=0
			SET @P=@P+@Factura+' '
	FETCH NEXT FROM Cur INTO @IdRemito, @Factura
   END
   IF @Corte<>0
	UPDATE #Auxiliar5
	SET Facturas = SUBSTRING(@P,1,500)
	WHERE IdRemito=@Corte
CLOSE Cur
DEALLOCATE Cur
*/

    SET NOCOUNT OFF

    DECLARE @vector_X VARCHAR(30),
        @vector_T VARCHAR(30)
    SET @vector_X = '0111111111111111533'
    SET @vector_T = '0E94122EBB432225300'

    SELECT  Remitos.IdRemito,
            SUBSTRING('0000', 1,
                      4 - LEN(CONVERT(VARCHAR, ISNULL(Remitos.PuntoVenta, 0))))
            + CONVERT(VARCHAR, ISNULL(Remitos.PuntoVenta, 0)) + '-'
            + SUBSTRING('00000000', 1,
                        8 - LEN(CONVERT(VARCHAR, Remitos.NumeroRemito)))
            + CONVERT(VARCHAR, Remitos.NumeroRemito) AS [Remito],
            Remitos.IdRemito AS [IdAux],
            Remitos.FechaRemito [Fecha],
            Remitos.Anulado AS [Anulado],
            Clientes.RazonSocial AS [Cliente],
            Proveedores.RazonSocial AS [Proveedor],
 --#Auxiliar1.Obras as [Obras],
 --#Auxiliar3.OCompras as [Ordenes de compra],
 --#Auxiliar5.Facturas as [Facturas],
            CASE WHEN Remitos.Destino = 1 THEN 'A facturar'
                 WHEN Remitos.Destino = 2 THEN 'A proveedor p/fabricar'
                 WHEN Remitos.Destino = 3 THEN 'Con cargo devolucion'
                 WHEN Remitos.Destino = 4 THEN 'Muestra'
                 WHEN Remitos.Destino = 5 THEN 'A prestamo'
                 WHEN Remitos.Destino = 6 THEN 'Traslado'
                 ELSE ''
            END AS [Tipo de remito],
            cc.Descripcion AS [Condicion de venta],
            Transportistas.RazonSocial AS [Transportista],
            Remitos.TotalBultos AS [Bultos],
            Remitos.ValorDeclarado AS [Valor decl.],
            ( SELECT    COUNT(*)
              FROM      DetalleRemitos
              WHERE     DetalleRemitos.IdRemito = Remitos.IdRemito
            ) AS [Cant.Items],
            Remitos.Observaciones,
            @Vector_T AS Vector_T,
            @Vector_X AS Vector_X
    FROM    Remitos
            LEFT OUTER JOIN Clientes ON Remitos.IdCliente = Clientes.IdCliente
            LEFT OUTER JOIN Proveedores ON Remitos.IdProveedor = Proveedores.IdProveedor
            LEFT OUTER JOIN Transportistas ON Remitos.IdTransportista = Transportistas.IdTransportista
            LEFT OUTER JOIN [Condiciones Compra] cc ON Remitos.IdCondicionVenta = cc.IdCondicionCompra
--LEFT OUTER JOIN #Auxiliar1 ON Remitos.IdRemito=#Auxiliar1.IdRemito
--LEFT OUTER JOIN #Auxiliar3 ON Remitos.IdRemito=#Auxiliar3.IdRemito
--LEFT OUTER JOIN #Auxiliar5 ON Remitos.IdRemito=#Auxiliar5.IdRemito
    ORDER BY Remitos.NumeroRemito

--DROP TABLE #Auxiliar1
--DROP TABLE #Auxiliar2
--DROP TABLE #Auxiliar3
--DROP TABLE #Auxiliar4
--DROP TABLE #Auxiliar5
--DROP TABLE #Auxiliar6

GO

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wOrdenesCompra_TX_ItemsPendientesDeRemitirPorIdCliente]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wOrdenesCompra_TX_ItemsPendientesDeRemitirPorIdCliente]
go

CREATE PROCEDURE wOrdenesCompra_TX_ItemsPendientesDeRemitirPorIdCliente @IdCliente INT
AS 
    DECLARE @vector_X VARCHAR(30),
        @vector_T VARCHAR(30)
    SET @vector_X = '00111111111111133'
    SET @vector_T = '00641010022205100'

    SELECT  doc.IdDetalleOrdenCompra,
            doc.IdOrdenCompra,
            OrdenesCompra.NumeroOrdenCompra AS [Orden de compra],
            OrdenesCompra.FechaOrdenCompra [Fecha],
            Clientes.RazonSocial AS [Cliente],
            doc.NumeroItem AS [Item],
            Articulos.Descripcion AS [Articulo],
            doc.Cantidad AS [Cant.],
            Unidades.Descripcion AS [Unidad],
            doc.Precio AS [Precio],
            doc.Cantidad * doc.Precio * ( 1
                                          - ISNULL(doc.PorcentajeBonificacion,
                                                   0) / 100 ) AS [Importe],
            CASE WHEN doc.TipoCancelacion = 1
                 THEN CONVERT(VARCHAR, ISNULL(( SELECT  SUM(ISNULL(drm.Cantidad, 0))
                                                FROM    DetalleRemitos drm
                                                        LEFT OUTER JOIN Remitos ON drm.IdRemito = Remitos.IdRemito
                                                WHERE   drm.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
                                                        AND ( Remitos.Anulado IS NULL
                                                              OR Remitos.Anulado <> 'SI'
                                                            )
                                              ), 0))
                 ELSE CONVERT(VARCHAR, ISNULL(( SELECT  SUM(ISNULL(drm.PorcentajeCertificacion, 0))
                                                FROM    DetalleRemitos drm
                                                        LEFT OUTER JOIN Remitos ON drm.IdRemito = Remitos.IdRemito
                                                WHERE   drm.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
                                                        AND ( Remitos.Anulado IS NULL
                                                              OR Remitos.Anulado <> 'SI'
                                                            )
                                              ), 0)) + ' %'
            END AS [Remitido],
            CASE WHEN doc.TipoCancelacion = 1
                 THEN CONVERT(VARCHAR, doc.Cantidad
                      - ISNULL(( SELECT SUM(ISNULL(drm.Cantidad, 0))
                                 FROM   DetalleRemitos drm
                                        LEFT OUTER JOIN Remitos ON drm.IdRemito = Remitos.IdRemito
                                 WHERE  drm.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
                                        AND ( Remitos.Anulado IS NULL
                                              OR Remitos.Anulado <> 'SI'
                                            )
                               ), 0))
                 ELSE CONVERT(VARCHAR, 100
                      - ISNULL(( SELECT SUM(ISNULL(drm.PorcentajeCertificacion,
                                                   0))
                                 FROM   DetalleRemitos drm
                                        LEFT OUTER JOIN Remitos ON drm.IdRemito = Remitos.IdRemito
                                 WHERE  drm.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
                                        AND ( Remitos.Anulado IS NULL
                                              OR Remitos.Anulado <> 'SI'
                                            )
                               ), 0)) + ' %'
            END AS [Pend.remitir],
            doc.Observaciones,
            doc.PorcentajeBonificacion AS [% Bon],
            @Vector_T AS Vector_T,
            @Vector_X AS Vector_X
    FROM    DetalleOrdenesCompra doc
            LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
            LEFT OUTER JOIN Clientes ON OrdenesCompra.IdCliente = Clientes.IdCliente
            LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Unidades ON doc.IdUnidad = Unidades.IdUnidad
    WHERE   ISNULL(OrdenesCompra.Anulada, '') <> 'SI'
            AND ( OrdenesCompra.IdCliente = @IdCliente
                  OR @idcliente = -1
                )

GO









--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[DetAsientos_TX_PorIdAsiento]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[DetAsientos_TX_PorIdAsiento]
go

					
CREATE Procedure [dbo].[DetAsientos_TX_PorIdAsiento]
@IdAsiento int
AS 
SELECT *
FROM DetalleAsientos
WHERE (IdAsiento=@IdAsiento)
go





--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wAnticiposAlPersonal_TX_Asiento]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wAnticiposAlPersonal_TX_Asiento]
go



CREATE PROCEDURE [dbo].[wAnticiposAlPersonal_TX_Asiento]

@IdAsiento int

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111133'
set @vector_T='022222500'

SELECT
 AP.IdAnticipoAlPersonal,
 Empleados.Legajo as [Legajo],
 Empleados.Nombre as [Nombre],
 Empleados.IdEmpleado,
 AP.Importe as [Importe],
 AP.CantidadCuotas as [Cuotas],
 AP.Detalle as [Detalle],
 Empleados.CuentaBancaria as [Cuenta banco],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM AnticiposAlPersonal AP
LEFT OUTER JOIN Empleados ON AP.IdEmpleado = Empleados.IdEmpleado
WHERE (AP.IdAsiento = @IdAsiento)

GO

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- wRequerimientos_TX_PendientesDeAsignacion y su sp de prepoceso 
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wRequerimientos_TX_PendientesDeAsignacion]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wRequerimientos_TX_PendientesDeAsignacion]
go

CREATE PROCEDURE wRequerimientos_TX_PendientesDeAsignacion
AS 
    DECLARE @IdObraStockDisponible INT,
        @IdDepositoCentral INT,
        @FirmasLiberacion INT

    SET @IdObraStockDisponible = ISNULL(( SELECT TOP 1
                                                    P.IdObraStockDisponible
                                          FROM      Parametros P
                                          WHERE     P.IdParametro = 1
                                        ), 0)
    SET @IdDepositoCentral = ISNULL(( SELECT TOP 1
                                                P2.Valor
                                      FROM      Parametros2 P2
                                      WHERE     P2.Campo = 'IdDepositoCentral'
                                    ), -1)
    SET @FirmasLiberacion = ISNULL(( SELECT TOP 1
                                            CONVERT(INTEGER, Valor)
                                     FROM   Parametros2
                                     WHERE  Campo = 'AprobacionesRM'
                                   ), 1)

    DECLARE @vector_X VARCHAR(50),
        @vector_T VARCHAR(50)
    SET @vector_X = '011111111111111111111111133'
    SET @vector_T = '029999H101115511F4132135200'

    SELECT  DetReq.IdDetalleRequerimiento,
            Requerimientos.NumeroRequerimiento AS [Req.Nro.],
            DetReq.IdDetalleRequerimiento AS [IdAux1],
            DetReq.IdRequerimiento AS [IdAux2],
            ISNULL(Requerimientos.IdObra, LMateriales.IdObra) AS [IdAux3],
            DetReq.TipoDesignacion AS [IdAux4],
            DetReq.NumeroItem AS [Item],
            DetReq.Cantidad AS [Cant.],
            ISNULL(Unidades.Abreviatura, Unidades.Descripcion) AS [Unidad en],
            T.CantidadVales AS [Vales],
            T.CantidadPedida AS [Cant.Ped.],
            T.CantidadRecibida AS [Recibido],
            CASE WHEN DetReq.TipoDesignacion = 'REC'
                 THEN SUBSTRING(SUBSTRING('0000', 1,
                                          4
                                          - LEN(CONVERT(VARCHAR, Recepciones.NumeroRecepcion1)))
                                + CONVERT(VARCHAR, Recepciones.NumeroRecepcion1)
                                + '-' + SUBSTRING('00000000', 1,
                                                  8
                                                  - LEN(CONVERT(VARCHAR, Recepciones.NumeroRecepcion2)))
                                + CONVERT(VARCHAR, Recepciones.NumeroRecepcion2)
                                + '/'
                                + CONVERT(VARCHAR, ISNULL(Recepciones.SubNumero,
                                                          0)), 1, 20)
                 ELSE NULL
            END AS [Recepcion],
            SUBSTRING(SUBSTRING('0000', 1,
                                4
                                - LEN(CONVERT(VARCHAR, Recepciones.NumeroRecepcion1)))
                      + CONVERT(VARCHAR, Recepciones.NumeroRecepcion1) + '-'
                      + SUBSTRING('00000000', 1,
                                  8
                                  - LEN(CONVERT(VARCHAR, Recepciones.NumeroRecepcion2)))
                      + CONVERT(VARCHAR, Recepciones.NumeroRecepcion2) + '/'
                      + CONVERT(VARCHAR, ISNULL(Recepciones.SubNumero, 0)), 1,
                      20) AS [Ult.Recepcion],
            T.CantidadEnStock AS [En stock],
            A1.StockMinimo AS [Stk.min.],
            A1.Descripcion AS Articulo,
            DetReq.FechaEntrega AS [F.entrega],
            E2.Nombre AS [Solicito],
            CASE WHEN ISNULL(Requerimientos.TipoRequerimiento, '') = 'OP'
                 THEN ISNULL(Requerimientos.TipoRequerimiento, '')
                      + CONVERT(VARCHAR, ISNULL(' - '
                                                + ( SELECT TOP 1
                                                            A.NumeroInventario
                                                    FROM    Articulos A
                                                    WHERE   DetReq.IdEquipoDestino = A.IdArticulo
                                                  ), ''))
                 WHEN ISNULL(Requerimientos.TipoRequerimiento, '') = 'OT'
                      OR ISNULL(Requerimientos.TipoRequerimiento, '') = 'ST'
                 THEN ISNULL(Requerimientos.TipoRequerimiento, '')
                      + CONVERT(VARCHAR, ISNULL(' - '
                                                + ( SELECT TOP 1
                                                            OT.NumeroOrdenTrabajo
                                                    FROM    OrdenesTrabajo OT
                                                    WHERE   Requerimientos.IdOrdenTrabajo = OT.IdOrdenTrabajo
                                                  ), ''))
                 ELSE ISNULL(Requerimientos.TipoRequerimiento, '')
            END AS [Tipo Req.],
            Obras.NumeroObra + ' ' + Obras.Descripcion AS [Obra],
            DetReq.Cumplido AS [Cump.],
            DetReq.Recepcionado AS [Recibido],
            DetReq.Observaciones AS [Observaciones item],
            Depositos.Descripcion AS [Deposito],
            @Vector_T AS Vector_T,
            @Vector_X AS Vector_X
    FROM    _Temp_Requerimientos_TX_PendientesDeAsignar T
            LEFT OUTER JOIN DetalleRequerimientos DetReq ON T.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
            LEFT OUTER JOIN Articulos A1 ON DetReq.IdArticulo = A1.IdArticulo
            LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
            LEFT OUTER JOIN DetalleLMateriales ON DetReq.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
            LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales = LMateriales.IdLMateriales
            LEFT OUTER JOIN Empleados E1 ON DetReq.IdComprador = E1.IdEmpleado
            LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
            LEFT OUTER JOIN Cuentas ON DetReq.IdCuenta = Cuentas.IdCuenta
            LEFT OUTER JOIN Unidades ON DetReq.IdUnidad = Unidades.IdUnidad
            LEFT OUTER JOIN Obras ON ISNULL(Requerimientos.IdObra,
                                            LMateriales.IdObra) = Obras.IdObra
            LEFT OUTER JOIN DetalleRecepciones DetRec ON T.IdDetalleRecepcion = DetRec.IdDetalleRecepcion
            LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
            LEFT OUTER JOIN Ubicaciones ON DetRec.IdUbicacion = Ubicaciones.IdUbicacion
            LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
    WHERE   ( DetReq.TipoDesignacion IS NOT NULL
              AND ( DetReq.TipoDesignacion = 'S/D'
                    OR ( DetReq.TipoDesignacion = 'REC'
                         AND Requerimientos.IdObra <> @IdObraStockDisponible
                       )
                    OR ( DetReq.TipoDesignacion = 'STK'
                         AND DetReq.Cantidad > ISNULL(T.CantidadVales, 0)
                       )
                  )
            )
    ORDER BY Requerimientos.NumeroRequerimiento,
            DetReq.NumeroItem


GO



--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wRequerimientos_TX_PendientesDeAsignacion_SubRecalculoRM]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].wRequerimientos_TX_PendientesDeAsignacion_SubRecalculoRM
go

CREATE PROCEDURE wRequerimientos_TX_PendientesDeAsignacion_SubRecalculoRM
AS 
    SET NOCOUNT ON


    DECLARE @Depositos VARCHAR(100)

--IF @Depositos is null or Len(@Depositos)=0
    SET @Depositos = '-1'

    DECLARE @IdObraStockDisponible INT,
        @IdDepositoCentral INT,
        @FirmasLiberacion INT

    SET @IdObraStockDisponible = ISNULL(( SELECT TOP 1
                                                    P.IdObraStockDisponible
                                          FROM      Parametros P
                                          WHERE     P.IdParametro = 1
                                        ), 0)
    SET @IdDepositoCentral = ISNULL(( SELECT TOP 1
                                                P2.Valor
                                      FROM      Parametros2 P2
                                      WHERE     P2.Campo = 'IdDepositoCentral'
                                    ), -1)
    SET @FirmasLiberacion = ISNULL(( SELECT TOP 1
                                            CONVERT(INTEGER, Valor)
                                     FROM   Parametros2
                                     WHERE  Campo = 'AprobacionesRM'
                                   ), 1)

--http://www.orafaq.com/forum/t/23267/2/
-- y si pongo un indice o algo?

/*
Use stacked queries instead of subqueries. Create a separate saved query for JET 
to execute first, and use it as an input "table" for your main query. This 
pre-processing is usually (but not always) faster than a subquery. Likewise, 
try performing aggregation in one query, and then create another query that operates 
on the aggregated results. This post-processing can be orders of magnitude faster 
than a query that tries to do everything in a single query with subqueries.
*/

    CREATE TABLE #Auxiliar1
        (
          IdDetalleRequerimiento INTEGER,
          CantidadPedida NUMERIC(18, 2),
          CantidadRecibida NUMERIC(18, 2),
          CantidadVales NUMERIC(18, 2),
          CantidadEnStock NUMERIC(18, 2),
          IdDetalleRecepcion INTEGER
        )
    CREATE TABLE #Auxiliar2
        (
          IdDetalleRequerimiento INTEGER,
          CantidadPedida NUMERIC(18, 2),
          CantidadRecibida NUMERIC(18, 2),
          CantidadVales NUMERIC(18, 2),
          CantidadEnStock NUMERIC(18, 2),
          IdDetalleRecepcion INTEGER
        )			
			
    INSERT  INTO #Auxiliar2
            SELECT  DetReq.IdDetalleRequerimiento,

--esta que hace? trae los PEDIDOS que estan relacionados con este item de rm
                    ( SELECT    SUM(ISNULL(DetallePedidos.Cantidad, 0))
                      FROM      DetallePedidos
                      WHERE     DetallePedidos.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
                                AND ( DetallePedidos.Cumplido IS NULL
                                      OR DetallePedidos.Cumplido <> 'AN'
                                    )
                    ),
                    0,
                    0,
                    0,
                    0
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
                    LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo



--Las RECEPCIONES (el detalle)
    INSERT  INTO #Auxiliar2
            SELECT  DetReq.IdDetalleRequerimiento,
                    0,
                    ( SELECT    SUM(ISNULL(DetRec.CantidadCC, 0))
                      FROM      DetalleRecepciones DetRec
                                LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion = DetRec.IdRecepcion
                      WHERE     DetRec.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
                                AND ISNULL(Recepciones.Anulada, 'NO') <> 'SI'
                                AND ISNULL(DetRec.IdDetalleSalidaMateriales, 0) = 0
                    ),
                    0,
                    0,
                    0
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
                    LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo





--Los VALES
    INSERT  INTO #Auxiliar2
            SELECT  DetReq.IdDetalleRequerimiento,
                    0,
                    0,
                    ( SELECT    SUM(ISNULL(DetalleValesSalida.Cantidad, 0))
                      FROM      DetalleValesSalida
                      WHERE     DetalleValesSalida.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
                                AND ( DetalleValesSalida.Estado IS NULL
                                      OR DetalleValesSalida.Estado <> 'AN'
                                    )
                    ),
                    0,
                    0
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
                    LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo



--trae el STOCK
    INSERT  INTO #Auxiliar2
            SELECT  DetReq.IdDetalleRequerimiento,
                    0,
                    0,
                    CASE WHEN ISNULL(Articulos.RegistrarStock, 'SI') = 'SI'
                         THEN ( SELECT  SUM(ISNULL(Stock.CantidadUnidades, 0))
                                FROM    Stock
                                        LEFT OUTER JOIN Ubicaciones ON Stock.IdUbicacion = Ubicaciones.IdUbicacion
                                WHERE   DetReq.IdArticulo = Stock.IdArticulo
                              )
                         ELSE NULL
                    END,
                    0,
                    0
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
                    LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo


--RECEPCIONES (el encabezado)
    INSERT  INTO #Auxiliar2
            SELECT  DetReq.IdDetalleRequerimiento,
                    0,
                    0,
                    ( SELECT TOP 1
                                DetRec.IdDetalleRecepcion
                      FROM      DetalleRecepciones DetRec
                                LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
                      WHERE     DetRec.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
                                AND ISNULL(Recepciones.Anulada, 'NO') <> 'SI'
                                AND ISNULL(DetRec.IdDetalleSalidaMateriales, 0) = 0
                      ORDER BY  Recepciones.NumeroRecepcionAlmacen DESC
                    ),
                    0,
                    0
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
                    LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo





--////////////////////////////////

    DELETE  _Temp_Requerimientos_TX_PendientesDeAsignar


    INSERT  INTO _Temp_Requerimientos_TX_PendientesDeAsignar
            SELECT  IdDetalleRequerimiento,
                    SUM(CantidadPedida) AS CantidadPedida,
                    SUM(CantidadRecibida) AS CantidadRecibida,
                    SUM(CantidadVales) AS CantidadVales,
                    SUM(CantidadEnStock) AS CantidadEnStock,
                    IdDetalleRecepcion
            FROM    #Auxiliar2
            GROUP BY IdDetalleRequerimiento,
                    IdDetalleRecepcion
            ORDER BY IdDetalleRequerimiento



GO



--EXEC wRequerimientos_TX_PendientesDeAsignacion_SubRecalculoRM 
--EXEC wRequerimientos_TX_PendientesDeAsignacion



--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- wrequerimientos_tx_pendientes1 y su sp de prepoceso (no confundir con _PendientesDeAsignacion)
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wRequerimientos_TX_Pendientes1]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].wRequerimientos_TX_Pendientes1
go

CREATE PROCEDURE wRequerimientos_TX_Pendientes1
    @TiposComprobante VARCHAR(1)
AS --DECLARE @TiposComprobante varchar(1)
--SET @TiposComprobante ='P'




    SET NOCOUNT ON


    SELECT  T.IdDetalleRequerimiento,
            Requerimientos.NumeroRequerimiento AS [Req.Nro.],
            DetReq.NumeroItem AS [Item],
            DetReq.Cantidad AS [Cant.],
            Unidades.Abreviatura AS [Un.],
            Articulos.Descripcion AS Articulo,
-- #Auxiliar1.CantidadPedida as [Cant.Ped.],
-- #Auxiliar1.CantidadRecibida as [Recibido],
-- #Auxiliar1.CantidadVales as [Vales],
-- Requerimientos.MontoPrevisto as [Monto prev.],
-- Requerimientos.MontoParaCompra as [Monto comp.],
-- E1.Nombre as [Comprador],
-- DetReq.IdDetalleLMateriales,
-- LMateriales.NumeroLMateriales as [L.Mat.],
-- DetalleLMateriales.NumeroOrden as [Itm.LM],
-- #Auxiliar1.CantidadEnStock as [En stock],
            DetReq.IdArticulo,
-- Articulos.StockMinimo as [Stk.min.],
            DetReq.FechaEntrega AS [F.entrega],
            DetReq.IdDetalleRequerimiento AS [IdAux],
            DetReq.IdRequerimiento,
            E2.Nombre AS [Solicito],
            Obras.NumeroObra + ' ' + Obras.Descripcion AS [Obra],
-- Equipos.Tag as [Equipo],
-- Cuentas.Descripcion as [Cuenta contable],
-- DetReq.Cumplido as [Cump.],
            DetReq.Observaciones,
-- DetReq.IdDetalleRequerimiento as [IdAux1],
            DetReq.Observaciones AS [Observaciones item]
-- DetReq.FechaAsignacionComprador as [Fec.Asig.Comprador],
-- TiposCompra.Descripcion as [Tipo compra],
-- E3.Nombre as [2da.Firma],
-- Aut.FechaAutorizacion as [Fecha 2da.Firma],
-- Sectores.Descripcion as [Sector],
-- @Vector_T as Vector_T,
-- @Vector_X as Vector_X
    FROM    _Temp_Requerimientos_TX_Pendientes1 T
            LEFT OUTER JOIN DetalleRequerimientos DetReq ON T.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
            LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
            LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
            LEFT OUTER JOIN DetalleLMateriales ON DetReq.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
            LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales = LMateriales.IdLMateriales
            LEFT OUTER JOIN AutorizacionesPorComprobante Aut ON T.IdAutorizacionPorComprobante = Aut.IdAutorizacionPorComprobante
            LEFT OUTER JOIN Empleados E1 ON DetReq.IdComprador = E1.IdEmpleado
            LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
            LEFT OUTER JOIN Empleados E3 ON Aut.IdAutorizo = E3.IdEmpleado
            LEFT OUTER JOIN Cuentas ON DetReq.IdCuenta = Cuentas.IdCuenta
            LEFT OUTER JOIN Unidades ON DetReq.IdUnidad = Unidades.IdUnidad
            LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
            LEFT OUTER JOIN Obras ON ISNULL(Requerimientos.IdObra,
                                            LMateriales.IdObra) = Obras.IdObra
            LEFT OUTER JOIN Equipos ON LMateriales.IdEquipo = Equipos.IdEquipo
            LEFT OUTER JOIN Sectores ON Requerimientos.IdSector = Sectores.IdSector
    WHERE   ISNULL(DetReq.TipoDesignacion, 'CMP') <> 'S/D'
            AND ( ISNULL(DetReq.TipoDesignacion, 'CMP') <> 'STK'
                  OR ( ISNULL(DetReq.TipoDesignacion, 'CMP') = 'STK'
                       AND ISNULL(T.CantidadPedida, 0) > 0
                       AND DetReq.Cantidad > ISNULL(T.CantidadPedida, 0)
                     )
                )
            AND DetReq.Cantidad > ISNULL(T.CantidadVales, 0)
    ORDER BY Requerimientos.NumeroRequerimiento,
            DetReq.NumeroItem

GO

--EXEC wrequerimientos_tx_pendientes1 P



--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wRequerimientos_TX_Pendientes1_SubRecalculoRM]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].wRequerimientos_TX_Pendientes1_SubRecalculoRM
go

CREATE PROCEDURE wRequerimientos_TX_Pendientes1_SubRecalculoRM
AS 
    SET NOCOUNT ON

    DECLARE @TiposComprobante VARCHAR(1)
    SET @TiposComprobante = 'P'

    DECLARE @CantidadFirmasRM INT,
        @LiberarCircuito VARCHAR(2),
        @FirmasLiberacion INT

    SET @CantidadFirmasRM = ISNULL(( SELECT COUNT(*)
                                     FROM   DetalleAutorizaciones
                                            LEFT OUTER JOIN Autorizaciones ON DetalleAutorizaciones.IdAutorizacion = Autorizaciones.IdAutorizacion
                                     WHERE  Autorizaciones.IdFormulario = 3
                                   ), 0)
    SET @FirmasLiberacion = ISNULL(( SELECT TOP 1
                                            CONVERT(INTEGER, Valor)
                                     FROM   Parametros2
                                     WHERE  Campo = 'AprobacionesRM'
                                   ), 1)
    SET @LiberarCircuito = ISNULL(( SELECT TOP 1
                                            Valor
                                    FROM    Parametros2
                                    WHERE   Campo = 'LiberarRMCircuito'
                                  ), 'NO')


    DELETE  _Temp_Requerimientos_TX_Pendientes1


    INSERT  INTO _Temp_Requerimientos_TX_Pendientes1
            SELECT  DetReq.IdDetalleRequerimiento,


--En pedidos
                    ( SELECT    SUM(ISNULL(DetallePedidos.Cantidad, 0))
                      FROM      DetallePedidos
                      WHERE     DetallePedidos.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
                                AND ( DetallePedidos.Cumplido IS NULL
                                      OR DetallePedidos.Cumplido <> 'AN'
                                    )
                    ), 


--Recibidos
                    ( SELECT    SUM(ISNULL(DetalleRecepciones.CantidadCC, 0))
                      FROM      DetalleRecepciones
                                LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion = DetalleRecepciones.IdRecepcion
                      WHERE     DetalleRecepciones.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
                                AND ( Recepciones.Anulada IS NULL
                                      OR Recepciones.Anulada <> 'SI'
                                    )
                    ), 


--En Vales
                    ( SELECT    SUM(ISNULL(DetalleValesSalida.Cantidad, 0))
                      FROM      DetalleValesSalida
                      WHERE     DetalleValesSalida.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
                                AND ( DetalleValesSalida.Estado IS NULL
                                      OR DetalleValesSalida.Estado <> 'AN'
                                    )
                    ), 


--
                    CASE WHEN ISNULL(Articulos.RegistrarStock, 'SI') = 'SI'
                         THEN ( SELECT  SUM(ISNULL(Stock.CantidadUnidades, 0))
                                FROM    Stock
                                WHERE   DetReq.IdArticulo = Stock.IdArticulo
                              )
                         ELSE NULL
                    END, 


--
                    ( SELECT TOP 1
                                Aut.IdAutorizacionPorComprobante
                      FROM      AutorizacionesPorComprobante Aut
                      WHERE     Aut.IdFormulario = 3
                                AND Aut.OrdenAutorizacion = 1
                                AND Aut.IdComprobante = DetReq.IdRequerimiento
                    )
            FROM    DetalleRequerimientos DetReq
                    LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
                    LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
            WHERE   ( ( @FirmasLiberacion = 1
                        AND Requerimientos.Aprobo IS NOT NULL
                      )
                      OR ( @FirmasLiberacion > 1
                           AND Requerimientos.Aprobo2 IS NOT NULL
                         )
                    )
                    AND ( @TiposComprobante = 'T'
                          OR DetReq.Cumplido IS NULL
                          OR ( DetReq.Cumplido <> 'SI'
                               AND DetReq.Cumplido <> 'AN'
                             )
                        )
                    AND ( @TiposComprobante = 'T'
                          OR Requerimientos.Cumplido IS NULL
                          OR ( Requerimientos.Cumplido <> 'SI'
                               AND Requerimientos.Cumplido <> 'AN'
                             )
                        )
                    AND 
/*	 (@TiposComprobante='T' or DetReq.IdProveedor is null) AND 	*/ ( @TiposComprobante = 'T'
                                                                       OR ( DetReq.IdAproboAlmacen IS NOT NULL
                                                                            OR ( Requerimientos.DirectoACompras IS NOT NULL
                                                                                 AND Requerimientos.DirectoACompras = 'SI'
                                                                               )
                                                                          )
                                                                     )
                    AND ISNULL(Requerimientos.Confirmado, 'SI') <> 'NO'
                    AND ( @LiberarCircuito = 'NO'
                          OR ( @LiberarCircuito = 'SI'
                               AND ISNULL(( SELECT  COUNT(*)
                                            FROM    AutorizacionesPorComprobante Aut
                                            WHERE   Aut.IdFormulario = 3
                                                    AND Aut.IdComprobante = Requerimientos.IdRequerimiento
                                          ), 0) >= @CantidadFirmasRM
                             )
                        )  



GO


--EXEC wRequerimientos_TX_Pendientes1_SubRecalculoRM


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wExistenciasCartaPorteMovimientos]'))
    DROP FUNCTION [dbo].[wExistenciasCartaPorteMovimientos]
go

CREATE FUNCTION [dbo].[wExistenciasCartaPorteMovimientos]
(
	@Fecha datetime,
	@IdArticulo int, 
	@IdDestinoPuerto int
)

RETURNS INT
AS
BEGIN


	RETURN 0

END

go

--select  dbo.wExistenciasCartaPorteMovimientos (null,null,null)


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--IF EXISTS ( SELECT  *
--            FROM    dbo.sysobjects
--            WHERE   id = OBJECT_ID(N'[dbo].wFuncionBusqueda'))
--    DROP FUNCTION [dbo].wFuncionBusqueda
--go

--CREATE FUNCTION wFuncionBusqueda (@q VARCHAR(50))



--RETURNS TABLE AS
--RETURN (

----si sacas los ORDER, parece que no anda en SQL2000/5
----si sacas los ORDER, parece que no anda en SQL2000/5
----si sacas los ORDER, parece que no anda en SQL2000/5

----ademas, el order DESC debiera ser por FechaModificacion!, y no por Id (aunque se parecerán)


--	SELECT TOP 100 IdCliente as ID,isnull(Cuit,'') +' ' + isnull(RazonSocial  COLLATE Modern_Spanish_ci_as,'')  as Numero
--				,'Cliente' AS Tipo,  FechaAlta as fecha,
--				isnull(Telefono,'') + CHAR(13)+CHAR(10) + isnull(Email,'') as item1 
--	FROM dbo.Clientes 
--	WHERE  	-- http://stackoverflow.com/questions/156954/search-for-words-in-sql-server-index
--			RazonSocial like '%[^A-z^0-9]' + @q + '%' -- In the middle of a sentence
--			OR RazonSocial like  @q + '%'            -- At the beginning of a sentence


--		   or 
--		   Cuit LIKE @q+'%'  
--		   or 
--		   isnull(Cuit,'') +' ' + isnull(RazonSocial COLLATE Modern_Spanish_ci_as,'') LIKE @q+'%' 

--	UNION

--	SELECT TOP 100 IdCartaDePorte as ID, 
--				CAST(NumeroCartaDePorte as varchar(100))+' ' + CAST(NumeroSubFijo as varchar) + '-'+ CAST(SubNumeroVagon as varchar) as Numero,
--			'Carta de porte' AS Tipo, FechaModificacion as fecha
--				, '...........con.arribo.el.' +  CONVERT(VARCHAR(8), FechaArribo, 3) AS item1

--	FROM dbo.CartasDePorte 
--	WHERE  
--			isnull(SubNumeroDeFacturacion,0)<=0 
--			AND
--			(
--			NumeroCartaDePorte LIKE @q+'%'
--			OR
--		   SubNumeroVagon LIKE @q+'%'
--		   OR
--		   CAST(NumeroCartaDePorte as varchar(100))+' ' + CAST(NumeroSubFijo as varchar) + '-'+ CAST(SubNumeroVagon as varchar)   LIKE @q+'%' 
--		   )

--	--UNION


--	--SELECT TOP 100 IdAsiento as ID,CAST(NumeroAsiento as varchar(100)),'Asiento' AS Tipo, asientos.FechaAsiento as fecha
--	--			, '' as item1
--	--FROM dbo.Asientos 
--	--WHERE  asientos.NumeroAsiento LIKE @q+'%'
--	----ORDER BY fechaasiento desc   --si sacas los ORDER, parece que no anda en SQL2000/5

--	--UNION

--	--SELECT TOP 100 IdComprobanteProveedor as ID,CAST(NumeroComprobante2 as varchar(100)),'Cmpbte proveedor' AS Tipo, FechaComprobante as fecha
--	--			, '' as item1
--	--FROM dbo.ComprobantesProveedores
--	--WHERE  NumeroComprobante2 LIKE @q+'%'
--	----ORDER BY IdComprobanteProveedor desc

--	UNION

--	SELECT TOP 100 IdRequerimiento,CAST(NumeroRequerimiento  as varchar(100)),'Requerimiento' AS Tipo, FechaRequerimiento as fecha
--				, '' as item1
--	FROM requerimientos
--	WHERE NumeroRequerimiento LIKE @q+'%'
--	ORDER BY IdRequerimiento desc --si sacas los ORDER, parece que no anda en SQL2000/5

--	UNION

--	SELECT TOP 100 IdArticulo,CAST(Descripcion  as varchar(100)),'Articulo' AS Tipo, FechaAlta as fecha
--				, '' as item1
--	FROM Articulos
--	WHERE codigo LIKE @q+'%'or
--		  Descripcion LIKE @q+'%' or
--		  Descripcion like '%[^A-z^0-9]' + @q + '%' -- In the middle of a sentence
--	ORDER BY IdArticulo desc --si sacas los ORDER, parece que no anda en SQL2000/5

--	--UNION

--	--SELECT TOP 100 IdPedido,CAST(NumeroPedido  as varchar(100)),'Pedido' AS Tipo,FechaPedido as fecha
--	--			, '' as item1
--	--FROM pedidos
--	--WHERE NumeroPedido LIKE @q+'%'
--	----ORDER BY IdPedido desc

--	UNION

--	SELECT TOP 100 IdFactura,CAST(NumeroFactura  as varchar(100)),'Factura' AS Tipo, FechaFactura as fecha
--				, '' as item1
--	FROM dbo.Facturas
--	WHERE NumeroFactura LIKE @q+'%'
--	ORDER BY IdFactura desc

--	--UNION

--	--SELECT TOP 100 IdRemito,CAST(NumeroRemito as varchar(100)),'Remito' AS Tipo, FechaRemito as fecha
--	--			, '' as item1
--	--FROM remitos
--	--WHERE NumeroRemito LIKE @q+'%'
--	----ORDER BY IdRemito desc--si sacas los ORDER, parece que no anda en SQL2000/5


--	--UNION

--	--SELECT TOP 100 IdSalidaMateriales,CAST(NumeroSalidaMateriales as varchar(100)),'Salida de materiales' AS Tipo, FechaSalidaMateriales
--	--			, '' as item1
--	--FROM salidasmateriales
--	--WHERE NumeroSalidaMateriales LIKE @q+'%'
--	----ORDER BY IdSalidaMateriales desc--si sacas los ORDER, parece que no anda en SQL2000/5

--	--UNION

--	--SELECT TOP 100 IdRecepcion,CAST(NumeroRecepcion2 as varchar(100)),'Recepción' AS Tipo,FechaRecepcion
--	--			, '' as item1
--	--FROM Recepciones
--	--WHERE NumeroRecepcion2 LIKE @q+'%'
--	----ORDER BY IdRecepcion desc--si sacas los ORDER, parece que no anda en SQL2000/5

--	--UNION

--	--SELECT TOP 100 IdOrdenPago,  CAST(NumeroOrdenPago as varchar(100)),'Orden de pago' AS Tipo, FechaOrdenPago
--	--			, '' as item1
--	--FROM  dbo.OrdenesPago
--	--WHERE NumeroOrdenPago LIKE @q+'%'
--	----ORDER BY IdOrdenPago desc--si sacas los ORDER, parece que no anda en SQL2000/5

--               ) 

               
-- GO
              
--SELECT * FROM dbo.wFuncionBusqueda('102354235235')	
--SELECT * FROM dbo.wFuncionBusqueda('')	
-- wUltimosComprobantesCreados ''

--SELECT * FROM dbo.wFuncionBusqueda('20306762 0-0')	




--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



--IF EXISTS ( SELECT  *
--            FROM    dbo.sysobjects
--            WHERE   id = OBJECT_ID(N'[dbo].wBusqueda')
--                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
--    DROP PROCEDURE [dbo].wBusqueda
--go

--CREATE PROCEDURE wBusqueda
--    @q VARCHAR(50)
--AS

--	SELECT * 
--	FROM dbo.wFuncionBusqueda(@q) 
----	group by Numero
--	order by Fecha desc

--GO


--EXEC wBusqueda '102354235235'
--EXEC wBusqueda '5226099'
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].wUltimosComprobantesCreados')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].wUltimosComprobantesCreados
go

CREATE PROCEDURE wUltimosComprobantesCreados
    @q VARCHAR(50)
AS



select top 20 *
	FROM dbo.wFuncionBusqueda(@q)

	WHERE Numero LIKE @q+'%'
	order by fecha desc



GO



--EXEC wUltimosComprobantesCreados ''



--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


--Para hacer comparaciones de cadenas
--Levenshtein Edit Distance Algorithm
--http://www.sqlteam.com/forums/topic.asp?TOPIC_ID=51540

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[LevenshteinDistance]') ) 
    DROP FUNCTION [LevenshteinDistance]
go

CREATE FUNCTION LevenshteinDistance
    (
      @s1 NVARCHAR(3999),
      @s2 NVARCHAR(3999)
    )
RETURNS INT
AS BEGIN
    DECLARE @s1_len INT,
        @s2_len INT,
        @i INT,
        @j INT,
        @s1_char NCHAR,
        @c INT,
        @c_temp INT,
        @cv0 VARBINARY(8000),
        @cv1 VARBINARY(8000)
    SELECT  @s1_len = LEN(@s1),
            @s2_len = LEN(@s2),
            @cv1 = 0x0000,
            @j = 1,
            @i = 1,
            @c = 0
    WHILE @j <= @s2_len
        SELECT  @cv1 = @cv1 + CAST(@j AS BINARY(2)),
                @j = @j + 1
    WHILE @i <= @s1_len
        BEGIN
            SELECT  @s1_char = SUBSTRING(@s1, @i, 1),
                    @c = @i,
                    @cv0 = CAST(@i AS BINARY(2)),
                    @j = 1
            WHILE @j <= @s2_len
                BEGIN
                    SET @c = @c + 1
                    SET @c_temp = CAST(SUBSTRING(@cv1, @j + @j - 1, 2) AS INT)
                        + CASE WHEN @s1_char = SUBSTRING(@s2, @j, 1) THEN 0
                               ELSE 1
                          END
                    IF @c > @c_temp 
                        SET @c = @c_temp
                    SET @c_temp = CAST(SUBSTRING(@cv1, @j + @j + 1, 2) AS INT)
                        + 1
                    IF @c > @c_temp 
                        SET @c = @c_temp
                    SELECT  @cv0 = @cv0 + CAST(@c AS BINARY(2)),
                            @j = @j + 1
                END
            SELECT  @cv1 = @cv0,
                    @i = @i + 1
        END
    RETURN @c
   END
go








--select dbo.LevenshteinDistance('sdf','asd')
--SELECT TOP 1 IdCliente FROM Clientes WHERE dbo.LevenshteinDistance(RazonSocial,'LEGA,PREGO,FEROS') < 2
--select * from clientes where ltrim(razonsocial)=''


--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////

--cómo traer los parametros default
--http://dev.mainsoft.com/Default.aspx?tabid=181

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[_GetParamDefault]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo]._GetParamDefault
go

CREATE proc _GetParamDefault
@Procname varchar(50),
@ProcParamName varchar(50),
@DefaultValue varchar(100) OUTPUT
as
/* This procedure will return DEFAULT value for
   the parameter in the stored procedure.
    Usage:
    declare @Value varchar(30)
    exec _GetParamDefault 'random_password','@password_type',@value OUTPUT
    SELECT @VALUE
*****************************************************
Created by Eva Zadoyen */

    set nocount on
    declare @sqlstr nvarchar(4000),
    @obj_id int,
    @version int,
    @text varchar(8000),
    @startPos int,
    @endPos int,
    @ParmDefinition NVARCHAR(500)
    select @procName = rtrim(ltrim(@procname))
    set @startPos= charindex(';',@Procname)

    if @startPos<>0
    begin
        set @version = substring(@procname,@startPos +1,1)
        set @procname = left(@procname,len(@procname)-2)
    end
    else
        set @version = 1

    SET @sqlstr =N'SELECT @text_OUT = (SELECT text FROM syscomments
    WHERE id = object_id(@p_name) and colid=1 and number = @vers)'
    SET @ParmDefinition = N'@p_name varchar(50),
        @ParamName varchar (50),
     @vers int,
        @text_OUT varchar(4000) OUTPUT'

    EXEC sp_executesql
        @SQLStr,
        @ParmDefinition,
        @p_name = @procname,
        @ParamName = @ProcParamName,
        @vers = @version,
        @text_OUT =@text OUTPUT

    --select @TEXT
    select @startPos = PATINDEX( '%' + @ProcParamName +'%',@text)
    if @startPos<>0
    begin
        select @text = RIGHT ( @text, len(@text)-(@startPos +1))
        select @endPos= CHARINDEX(char(10),@text) -- find the end of a line
        select @text = LEFT(@text,@endPos-1)
        -- check if there is a default assigned and parse the value to the output
        select @startPos= PATINDEX('%=%',@text)
        if @startPos <>0
        begin
            select @DefaultValue = ltrim(rtrim(right(@text,len(@text)-
(@startPos))))
            select @endPos= CHARINDEX('--',@DefaultValue)
            if @endPos <> 0
            select @DefaultValue = rtrim(left(@DefaultValue,@endPos-1))

            select @endPos= CHARINDEX(',',@DefaultValue)
            if @endPos <> 0
            select @DefaultValue = rtrim(left(@DefaultValue,@endPos-1))
        end
        else
            select @DefaultValue = 'NO DEFAULT SPECIFIED'
    end
    else
        SET @DefaultValue = 'INVALID PARAM NAME'

set nocount off
return
GO

--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[_GetAllProcedures]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo]._GetAllProcedures
go

CREATE PROCEDURE _GetAllProcedures 
AS 

SET NOCOUNT ON 

select sysobjects.name,syscolumns.name from sysobjects, syscolumns 
where 
sysobjects.xtype='P' and 
sysobjects.id = syscolumns.id 

RETURN 
GO


--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////


--VERSION
--if esLaPCdeDesarrollo then version=getdate

DECLARE @version VARCHAR(20)
SET @version = 'SP1.11.4.2'

--print 'Modificando número de versión ' + @version
SET NOCOUNT ON 
IF ( SELECT COUNT(campo)
     FROM   parametros2
     WHERE  campo = 'ProntoWebVersionSQL'
   ) > 0 
    UPDATE  parametros2
    SET     valor = @version
    WHERE   campo = 'ProntoWebVersionSQL'
            AND ( valor = ''
                  OR valor IS NULL
                )
ELSE 
    INSERT  INTO parametros2 ( campo, valor )
    VALUES  (
              'ProntoWebVersionSQL',
              @version
            )
SET NOCOUNT OFF 
go				 


--select * from parametros2 where campo='ProntoWebVersionSQL'
--delete parametros2 where campo='ProntoWebVersionSQL'				 


--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////






/*
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////	   WIKI FAQ (por orden de importancia)  ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////



----------------------------------
----------------------------------
----------------------------------
----------------------------------
CONMUTAR UNA GRILLA CONTRA COLECCIONES VS CONTRA DATATABLES (y dataview?) 
----------------------------------
----------------------------------
----------------------------------
----------------------------------
*el conflicto de hacer bind contra una coleccion (una lista de items del objetito) o un datatable. 
-sí, por ejemplo,no tenes el ColumnaTilde.... 
-Una manera podría ser ponerle los nombres de las propiedades del objeto a las columnas 
correspondientes que devuelva el sp. Incluso podes hacer al reves, y agregarle properties al objeto (que llamen
a las variables) con los nombres de las columnas.
-Ademas tenes otro asunto: en el alta, tenes que mostrar el sp. Todavía en el alta,
si quieren editar, tenes que mostrar lo de ese item. Y si quieren ver una editada, tenes que mostrar solamente las 
imputaciones de ese item... si es que es una imputacion, porque puede ser una cantidad, por ejemplo, y entonces no 
tenes que mostrar ningun checkbox... 
-Si le pones checkbox, la grilla no representa la coleccion del objeto... la grilla es siempre en ese
caso un datatable... 
-Pero cuando lo van a ver, ya no tiene mas el checkbox!
-Entonces AHI está bindeada contra la coleccion...
-Pero como hago para que esa conmutacion sea lo mas elegante posible?
-Creo que la mejor es la de los propertis en el objeto... por lo menos para zafar...
-Pero tenes que parar la ejecucion... si cambias el nombre de las columnas, podes seguir sin parar
-Despues de todo, no te estas saltando un paso? Pones directamente una grilla con checks, en lugar de una grilla
que llame a un popup con grilla (que, de hecho, es lo que haces con las imputaciones, en el mismisimo ABM de 
notas de credito!!!! o sea, en el mismo ABM de NC, tenes los dos metodos (el indirecto para las imputaciones a facturas,
y el directo para las imputaciones a OC)
-El metodo directo es más complejo para programar, pero para el usuario es mas simple...
-Guarda! mira que ese metodo directo lo podes usar porque no es "por item", sino que la imputacion es a nivel
encabezado.
-Y con el Dataview se puede hacer algo?
-Pero el check es un dato...
-Y la columna de orden tambien! quizas el dataview puede bancarse algo...
"Además, un DataView se puede personalizar para presentar un subconjunto de datos de DataTable. 
Esta capacidad permite tener dos controles enlazados al mismo objeto DataTable y que muestren 
versiones distintas de los datos. Por ejemplo, un control puede estar enlazado a un objeto DataView 
que muestre todas las filas de la tabla y el segundo puede estar configurado para mostrar sólo las filas que 
se hayan eliminado de DataTable."
-ok, pero si las vistas son diferentes, las grillas van a tener que ser diferentes tambien...
-Creo que lo mejor es poner las 2 grillas. Y ocultar una u otra.
-Y si despues editas? NO VAS A NECESITAR "ColumnaTilde" en la coleccion del objeto???!!!!!
-Es verdad... 
-(un tercero) Momento! Es que, justamente, ese papel es el que tiene el "Eliminado"!!!!!
-Es verdad!!!! Verdaderísimo!
-Hagamos así: un property ColumnaTilde, que devuelva "Not Eliminado", y chau
-Mejor aun: agregale al dataTable devuelto por el sp, una columna con "Eliminado", y usá ese nombre en la grilla.

--falta agregar el CONTROL de checks
----------------------------------

    Function GenerarWHERE() As String
        ObjGrillaConsulta.FilterExpression = "Convert(Numero, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
                                             & " OR " & _
                                             "Convert(Proveedor, 'System.String') LIKE '*" & txtBuscar.Text & "*'"
    End Function
 
    Sub RebindGridAuxCopiaPresupuesto()
        With GVGrillaConsulta
            Dim pageIndex = .PageIndex
		    
            '/////////////////////////////////////////////////////////////
		    'A LO MACHO
            '/////////////////////////////////////////////////////////////
		    'chupo
		    Dim dt As DataTable = EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TX_Pendientes1).Tables(0)
	        Dim dt As DataTable = RequerimientoManager.GetListTXDetallesPendientes(SC).Tables(0) ' EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TX_Pendientes1).Tables(0)
            'filtro
            'dt = DataTableWHERE(dt, GenerarWHERE)
            'ordeno
            Dim b As Data.DataView = DataTableORDER(dt, "IdDetalleRequerimiento DESC") 
            'b.Sort = "IdDetalleRequerimiento DESC"
            ViewState("Sort") = b.Sort
            '/////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////


            With ds.Tables(0)
                .Columns("IdFactura").ColumnName = "Id"
                .Columns("Factura").ColumnName = "Numero"
                '.Columns("FechaFactura").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
            Dim dt As DataTable = ds.Tables(0)
            dt.DefaultView.Sort = "Id DESC"
            Return dt.DefaultView.Table


            
            '/////////////////////////////////////////////////////////////
            'METODO CON ODS (falta ordenacion)
            '/////////////////////////////////////////////////////////////
            ObjGrillaConsulta.FilterExpression = GenerarWHERE()
            dt=ObjGrillaConsulta.Select()
            '/////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////

           
            
            .DataSourceID = ""
            .DataSource = b
            .DataBind()
            .PageIndex = pageIndex
        End With
    End Sub

    Protected Sub GVGrillaConsulta_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GVGrillaConsulta.PageIndexChanging
        GVGrillaConsulta.PageIndex = e.NewPageIndex
        RebindGridAuxCopiaPresupuesto()
    End Sub

    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
 
        RebindGridAuxCopiaPresupuesto()
        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub
    
----------------------------------
----------------------------------
----------------------------------
----------------------------------
----------------------------------
----------------------------------
----------------------------------
----------------------------------
----------------------------------
----------------------------------
----------------------------------
----------------------------------
----------------------------------




----------------------------------
*Estaría piola que los paneles quedaran desplegados o NO, dependiendo de la ultima vez que se usaron por ese mismo usuario
----------------------------------



----------------------------------
*si el ODS no te ordena
----------------------------------
, podes devolver un dataview al ODS






----------------------------------
LLAMADA STANDARD A LINQ????
----------------------------------
Ejemplos:

Dim a = From o In myComparativa.Detalles Select New With {Key o.SubNumero} Distinct.Count()
guarda con el DISTINCT con anonymous types: http://odetocode.com/blogs/scott/archive/2008/03/25/and-equality-for-all-anonymous-types.aspx
el KEY es la clave...










----------------------------------
EL USO DE LAS GRILLAS CON ODS O BINDEADAS MANUALMENTE
----------------------------------
*sigue poniendome loco el uso de sps en las grillas con ODS...
-de qué manera hacía que se llamase de nuevo al ODS cuando llamo al popup? por qué había problemas para que funcionara
sin poner algo en el filtro "buscar"?
-ya la verdad que no me acuerdo cuando hago el bind manual (con ODS), cuando uso un 
ODS automaticamente, cuando uso directamente un dataset, etc.
1: grilla.databind() en el agregarRenglon
-sí, no te matés mas. Hacé los bind a lo macho:
       gvAuxOCsPendientes.DataSourceID = ""
       gvAuxOCsPendientes.DataSource = EntidadManager.GetStoreProcedure(HFSC.Value, "DetFacturasOrdenesCompra_TXOrdenesCompra", IdDetalleFactura)
       gvAuxOCsPendientes.DataBind()
-y para qué uso entonces los ODS??? Voy a empezar a probar sin usar las ODS






----------------------------------
*para probar un manager con editcontinue, pasalo al frontend, cambiá el nombre de la clase de la pagina para 
----------------------------------
que no tenga el mismo nombre que el objeto, y listo




----------------------------------
*La validacion del encabezado que debas hacer solo despues de la edicion de items, hacela en el manager.
----------------------------------




----------------------------------
*qué uso para grillas en scrol? -simplemente un  <div style="width: 632px; overflow: auto;"> -Me parece que NO anda
así nomas... ese div solo funciona si esta dentro de otra cosa (un panel, etc) -sí, al incluirlo en una <TABLE>, anduvo




*Para el foco en el update panel, usar System.Web.UI.ScriptManager.GetCurrent(Me).SetFocus(ViewState("ClientIDSetfocus"))

*No me anda el autocomplete del SQLPrompt para los stores!!! -Anda, dependiendo de en qué parte del scriptazo lo escribis


*como muestro un msgbox en un popup? -mandas el msgboxajax junto con una nueva llamada al show()

*Manera piola de quitar datarows de una datatable al hacer FOR each?

*Los optionbutton son fastidiosísimos.... La selecccion me tiene enfermo. Buscar estandar





------------------------------------
propery evaluation failed despues de request.redirect
------------------------------------
http://support.microsoft.com/kb/312629/EN-US/
usar segundo parametro: request.redirect("sdsdfsadf", FALSE)


------------------------------------
Enter en un textbox SIN haber hecho textchange
------------------------------------
http://stackoverflow.com/questions/1231327/javascript-enter-key-press
But wait, that functionality is already done on ASP .NET, you can use ASP:Panel controls to wrap your common controls, and you can assign a DefaultButton for the panel to indicate which button gets clicked when the Panel control has focus and the user presses the Enter key.



----------------------------------
Seleccionar texto de un textbox con un click o focus
----------------------------------
http://stackoverflow.com/questions/97459/automatically-select-all-text-on-focus-in-winforms-textbox
http://stackoverflow.com/questions/660554/how-to-automatically-select-all-text-on-focus-in-wpf-textbox

----------------------------------
Gridview grilla transparente?
-----------------------------------
solo pude zafar poniendo transparente el renglon en el rowdatabound


----------------------------------
*Una query parece no terminar más!!!
----------------------------------
-quizas es muy grande (como Requerimientos_TT) y el servidor va dandole los registros de a poco... 
te va a pasar con todo SELECT *. El mismo Pronto los evita con los noditos.... tenes que paginar la consulta....
-y no lo hace automatico el ODS????
-Mostrar ultimos diez, y así?

http://www.4guysfromrolla.com/webtech/042606-1.shtml usa ROWCOUNT SIN tabla temporal
http://weblogs.asp.net/scottgu/archive/2006/01/01/434314.aspx usan el ROW_NUMBER de sql2005

CREATE  PROCEDURE [dbo].wRequerimientos_TTpaginado
(
    @startRowIndex int,
    @maximumRows int
)
AS

--http://www.4guysfromrolla.com/webtech/042606-1.shtml 

DECLARE @first_id int, @startRow int
	
-- A check can be added to make sure @startRowIndex isn't > count(1)
-- from employees before doing any actual work unless it is guaranteed
-- the caller won't do that

-- Get the first employeeID for our page of records
SET ROWCOUNT @startRowIndex
SELECT @first_id = IdRequerimiento 
FROM Requerimientos 
ORDER BY IdRequerimiento

-- Now, set the row count to MaximumRows and get
-- all records >= @first_id
SET ROWCOUNT @maximumRows


SELECT *
FROM dbo.Requerimientos   
WHERE IdRequerimiento >= @first_id
ORDER BY IdRequerimiento

SET ROWCOUNT 0






-- y cómo lo enlazo con la gridview?
http://www.asp.net/data-access/tutorials/efficiently-paging-through-large-amounts-of-data-vb



para el conteo:
CREATE  PROCEDURE [dbo].wRequerimientos_TTpaginadoTotalCount
AS
SELECT COUNT(*) FROM dbo.Requerimientos




         EnablePaging="true" 
         StartRowIndexParameterName="startRowIndex" 
         MaximumRowsParameterName="maximumRows"
         SelectCountMethod="GetTotalNumberOfRMs"


Re: Adding Parameters to the ObjectDataSource.SelectCountMethod
Dec 17, 2008 05:54 PM

It is supported.  ASP.NET automatically passes the same parameters that are sent to your SelectMethod to 
your SelectCountMethod (except the paging and sorting parameters).  In fact, it's not just that it's supported, 
your SelectCountMethod *must* take the same parameters as your SelectMethod (again, minus the paging and sorting parameters).





----------------------------------
----------------------------------
*"quick replace" y Regular expressions, migrando de VB6:
----------------------------------
----------------------------------
http://www.codinghorror.com/blog/2006/07/the-visual-studio-ide-and-regular-expressions.html
http://blogs.msdn.com/b/vseditor/archive/2004/07/12/181078.aspx

CASO 1
Registro.Fields\(\"{[a-zA-Z0-9]+}\"\).Value
oCmpbte.\1

CASO 2
.Fields\(\"{[a-zA-Z0-9]+}\"\).Value
.Item("\1")     o tambien:    .\1  (en los casos en que da error)

CASO 2b
.Fields(0).Value (en los casos en que da error)
.id   

3
oSrv.LeerUno(					
EntidadManager.LeerUno(SC,

3b
.LeerUno("
.LeerUno(SC,"

4
Abs(
Math.ABS

5
Registro.Fields(0).Value				
o.Id

7
NULL
dbnull.value

8
If oRsBco.RecordCount > 0 THEN
If Not IsNothing(oRsBco) THEN

8b
oRsBco.Close()
oRsBco=nothing

9 SOCOTROCO:
    oRsDet = Me.DetOrdenesPagoValores.Registros
    With oRsDet
        If .Fields.Count > 0 Then
            If .RecordCount > 0 Then
                .MoveFirst()
                Do While Not .EOF
por
	oRsDet = sarasa
	FOR Each
	                      
	                      

	                 
10	                            
			.MoveNext()
		Loop
	End If

por

	NEXT
	
	
	
	
11
oRsCont.Fields.Append.Name, .Type, .DefinedSize, .Attributes
oRsCont.Fields.Append (.Name, .Type, .DefinedSize, .Attributes)



Hacer rejunte de las funciones que uso para compatibilidad (LeerUno, TraerFiltrado, etc)



----------------------------------
----------------------------------
*"quick replace" y Regular expressions, migrando de SQL para la datalayer:
----------------------------------
----------------------------------


DESDE (ejemplo @IdAsiento int,) :

		\@{[a-zA-Z0-9]+} {.+},

HASTA:
		SQLtoNET(.\1, "\1", myDataRecord)
		NETtoSQL(myCommand, "@\1", .\1)



----------------------------------
http://stackoverflow.com/questions/701223/net-convert-generic-collection-to-datatable
?? is the null-coalescing operator; it uses the first operand if it is non-null, 
else the second operand is evaluated and used
----------------------------------


----------------------------------
textbox amarillos en Chrome, o con el formateo de fecha, AUTO fill
----------------------------------
http://ryanfarley.com/blog/archive/2005/02/23/1739.aspx

<asp:TextBox Runat="server" ID="Textbox1" autocomplete="off"></asp:TextBox>

To turn off auto-complete for your entire form, all you need to do is add an attribute to your form tag, like this:
<form id="Form1" method="post" runat="server" autocomplete="off">
Easy enough. Now you won't get the auto complete on any of the controls on the form, works for any browser that supports auto-complete. The HTML INPUT tags also support the use of autocomplete=off and since the <asp:TextBox />control renders as INPUT tags then you can use it to set it on a control by control basis. Just add it to the TextBox at design-time (but note that VS.NET will underline it with a squiggly saying that textbox does not have an attribute for autocomplete - but it will still work):
<asp:TextBox Runat="server" ID="Textbox1" autocomplete="off"></asp:TextBox>
or at runtime:
Textbox1.Attributes.Add("autocomplete", "off");














----------------------------------
-funciona esto para contar eliminados? -de dieeeezzzz
----------------------------------
myRecibo.DetallesImputaciones.Count > myRecibo.DetallesImputaciones.Where(Function(i) i.Eliminado = True).Count()





----------------------------------
-Cómo NO ver en el boundfield de la gridview fechas en null?
----------------------------------
        <asp:TemplateField HeaderText="Fecha" ItemStyle-HorizontalAlign="Right">
            <ItemTemplate>
                <%#IIf(Eval("FechaComprobanteImputado") = #12:00:00 AM#, String.Empty, Eval("FechaComprobanteImputado", "{0:dd/M/yyyy}"))%>
            </ItemTemplate>
        </asp:TemplateField>








----------------------------------
como sacarse de encima el designer VIEW (ir directo al markup)
----------------------------------
parece que NO hay otra que usar una macro
http://www.codeproject.com/KB/macros/ToggleAspNetCodeBehind.aspx?print=TRUE







----------------------------------
*en los casos que trabaja con ICompMTS, no sé muy bien si usar un datarow en lugar de un datatable (ejemplo, el save de facturas o recibos, tocando subdiarios)
----------------------------------


*generalmente, cuando no anda un modalpopup es porque tiene mal asignado los botones, que cambiaron de nombre
al copiar el codigo de otro lado



*GRAN SNIPPET PARA HACER WHERE DE UN EXEC:
	Select * FROM OPENROWSET ('SQLOLEDB','Server=NANOPC\FONDO;TRUSTED_CONNECTION=YES;','set fmtonly off
	exec wDemoWilliams2.dbo.wCartasDePorte_TX_Informes @IdCartaDePorte = -1')



*Un golazo la combinacion "script de test de circuito" + "managers editables en ManagerDebug"


*we should handle transaction at Data layer? 
http://bytes.com/topic/asp-net/answers/852663-how-handle-transactions-business-logiclayer-level


*El pasaje de parametros al GetListTX desde el ODS...






*Regenerar el strong typed dataset (dataset tipado)
Do you mean the schema is missing in the .xsd file ... the XML itself? The Designer.cs file is really not part of the .xsd (although it is what makes a Typed DataSet a Typed DataSet).
You can easily re-generate the Designer.cs in your new project ... in the Solution Explorer, right-click on the .xsd and choose "Run Custom Tool". If that option doesn't show up in your context menu, choose Properties instead and type "MSDataSetGenerator" in the Custom Tool property. After that, you'll see the "Run Custom Tool" in the context menu and also any time you make a change to the .xsd in the XML Editor and save the change, the Typed DataSet gets regenerated.




----------------------------------
*Para mejorar el metodo de trabajo:
----------------------------------

Cómo mostrar los bloques de IFs?  (outlining es lo de los puntitos. 
A veces se me descontrolan, y para acomodarlos estoy mil años
Yo hablo de las lineas que tenia el CodeSmart, visual enhancements: Branch lines)
'Safar de choclazos con muchos bloques anidados:
'"If you need more than 3 levels of indentation, you're screwed anyway" Linus Torvalds
'Folding is used to mask excessive length. The presence of folded code can lull developers into 
'a false sense of what clean code looks like. Under the cover of folding, you can end up writing long, 
'horrible spaghetti code blocks. If the code needs the crutch of folding to look organized, it's bad code.
'-Finally someone who hates this useless #region crap. I have the same opinion - it drives me crazy when 
'im looking at someone's code and can't see a thing. Linus Torvalds once wrote: if you need more than 3 levels 
'of indentation, you're screwed anyway. If you need to use #refion - see above :-)
Developer Express CodeRush - Structural highlighting - lines on the left


Class VIEW de una web page en visual studio 2008 (FILE structure, navigation)

-Usar #region


-Quien me esta chupando memoria en el VStudio?
IMPORTANTE-What about unload projects where possible. I sometimes have solutions with 10 to 15 projects in if I disable the ones I am not currently working on I get a good boost. Just have to remember to reload and build before any breaking changes to shared code. – PeteT Jun 22 '09 at 9:07



qué agregar para que el ProntoWeb NO tarde en iniciarse (quiero decir, que esté vivo siempre)?


Las herramientas que usas (Sistema operativo, IDE, plugins, escritorio) deben andar rapido y ser
despejadas, como la interfaz que queres para el pronto.


*/

--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////


--EXEC dbo.CuentasBancarias_TX_TodasParaCombo -1

--EXEC Cuentas_TX_CuentasGastoPorObraParaCombo 207, DEFAULT

--EXEC  cuentas_TX_CuentasGastoPorObraParaCombo 104,-1
--EXEC dbo.Cuentas_TX_PorObraCuentaGasto 207,586


--EXEC OrdenesCompra_TX_PorIdClienteTodosParaCredito 25,1

--SELECT * FROM dbo.CuentasGastos

--select * from prontoini where idprontoiniclave=32
--select * from prontoiniclaves



--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wVistaPedidos]')
                    AND OBJECTPROPERTY(id, N'IsView') = 1 ) 
    DROP VIEW [wVistaPedidos]
go


CREATE VIEW [dbo].[wVistaPedidos]
as	


    --CREATE TABLE #Auxiliar0
    --    (
    --      IdPedido INTEGER,
    --      Requerimientos VARCHAR(100),
    --      Obras VARCHAR(100)
    --    )

    --CREATE TABLE #Auxiliar1
    --    (
    --      IdPedido INTEGER,
    --      NumeroRequerimiento INTEGER,
    --      NumeroObra VARCHAR(13),
    --      SAT VARCHAR(1)
    --    )
    --INSERT  INTO #Auxiliar1
    --        SELECT  DetPed.IdPedido,
    --                CASE WHEN Requerimientos.NumeroRequerimiento IS NOT NULL
    --                     THEN Requerimientos.NumeroRequerimiento
    --                     ELSE Acopios.NumeroAcopio
    --                END,
    --                Obras.NumeroObra,
    --                CASE WHEN DetalleRequerimientos.IdOrigenTransmision IS NOT NULL
    --                     THEN 'S'
    --                     ELSE ''
    --                END
    --        FROM    DetallePedidos DetPed
    --                LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
    --                LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
    --                LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
    --                LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
    --                LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
    --        WHERE   @IdPedido = -1
    --                OR DetPed.IdPedido = @IdPedido




    SELECT  Pedidos.*,
            '' AS [RMs],
            '' AS [Obras],
            Proveedores.RazonSocial AS [Proveedor],
            CASE WHEN TotalIva2 IS NULL
                 THEN TotalPedido - TotalIva1 + Bonificacion
                 ELSE TotalPedido - TotalIva1 - TotalIva2 + Bonificacion
            END AS [NetoGravado],
            Monedas.Abreviatura AS [Moneda],
            E1.Nombre AS [Comprador],
            E2.Nombre AS [Libero],
            ( SELECT    COUNT(*)
              FROM      DetallePedidos
              WHERE     DetallePedidos.IdPedido = Pedidos.IdPedido
            ) AS [CantidadItems],
            PedidosAbiertos.NumeroPedidoAbierto AS [PedidoAbierto],
            ( SELECT TOP 1
                        A.Descripcion
              FROM      Articulos A
              WHERE     A.IdArticulo = ( SELECT TOP 1
                                                Requerimientos.IdEquipoDestino
                                         FROM   DetalleRequerimientos DR
                                                LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DR.IdRequerimiento
                                         WHERE  DR.IdDetalleRequerimiento = ( SELECT TOP 1
                                                                                        DP.IdDetalleRequerimiento
                                                                              FROM      DetallePedidos DP
                                                                              WHERE     DP.IdPedido = Pedidos.IdPedido
                                                                                        AND DP.IdDetalleRequerimiento IS NOT NULL
                                                                            )
                                       )
            ) AS [EquipoDestino],
            cc.Descripcion AS [CondicionCompra],
  Pedidos.FechaSalida as [Fecha salida],

 Case When TotalIva1=0 Then Null Else TotalIva1 End as [Total Iva],
 IsNull(Pedidos.ImpuestosInternos,0)+IsNull(Pedidos.OtrosConceptos1,0)+IsNull(Pedidos.OtrosConceptos2,0)+
	IsNull(Pedidos.OtrosConceptos3,0)+IsNull(Pedidos.OtrosConceptos4,0)+IsNull(Pedidos.OtrosConceptos5,0)as [Otros Conceptos],
 TotalPedido as [Total pedido],
 E2.Nombre as [Liberado por],
 PedidosAbiertos.NumeroPedidoAbierto as [Pedido abierto],
 Pedidos.NumeroLicitacion as [Nro.Licitacion],
 --Pedidos.Impresa as [Impresa],
 Pedidos.UsuarioAnulacion as [Anulo],
 Pedidos.FechaAnulacion as [Fecha anulacion],
 Pedidos.MotivoAnulacion as [Motivo anulacion],
 Pedidos.ImpuestosInternos as [Imp.Internos],
 (Select Top 1 A.Descripcion From Articulos A 
	Where A.IdArticulo=(Select Top 1 Requerimientos.IdEquipoDestino 
				From DetalleRequerimientos DR
				Left Outer Join Requerimientos On Requerimientos.IdRequerimiento=DR.IdRequerimiento
				Where DR.IdDetalleRequerimiento=(Select Top 1 DP.IdDetalleRequerimiento 
								 From DetallePedidos DP 
								 Where DP.IdPedido=Pedidos.IdPedido and 
									DP.IdDetalleRequerimiento is not null))) as [Equipo destino],
 Pedidos.CircuitoFirmasCompleto as [Circuito de firmas completo],
 '' as [Condicion IVA]
 --DescripcionIva.Descripcion as [Condicion IVA]
           
    FROM    Pedidos
            LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
            LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda = Monedas.IdMoneda
            LEFT OUTER JOIN PedidosAbiertos ON Pedidos.IdPedidoAbierto = PedidosAbiertos.IdPedidoAbierto
--            LEFT OUTER JOIN #Auxiliar0 ON Pedidos.IdPedido = #Auxiliar0.IdPedido
            LEFT OUTER JOIN Empleados E1 ON Pedidos.IdComprador = E1.IdEmpleado
            LEFT OUTER JOIN Empleados E2 ON Pedidos.Aprobo = E2.IdEmpleado
            LEFT OUTER JOIN [Condiciones Compra] cc ON Pedidos.IdCondicionCompra = cc.IdCondicionCompra


GO








--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wVistaRequerimientos]')
                    AND OBJECTPROPERTY(id, N'IsView') = 1 ) 
    DROP VIEW wVistaRequerimientos
go


CREATE VIEW [dbo].wVistaRequerimientos
as	

SELECT 
 Requerimientos.IdRequerimiento,
 Requerimientos.NumeroRequerimiento as [Numero Req.],
 Requerimientos.IdRequerimiento as [IdReq],
 Requerimientos.FechaRequerimiento as [Fecha],
 Requerimientos.Cumplido as [Cump.],
 Requerimientos.Recepcionado as [Recibido],
 Requerimientos.Entregado as [Entregado],
 Requerimientos.Impresa as [Impresa],
 Requerimientos.Detalle as [Detalle],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 
 (Select Count(*) From DetalleRequerimientos Where DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento) as [Cant.Items],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.Aprobo=Empleados.IdEmpleado) as [Liberada por],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.IdSolicito=Empleados.IdEmpleado) as [Solicitada por],
 Sectores.Descripcion as [Sector],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 Requerimientos.FechaImportacionTransmision as [Fecha imp.transm,],
 Articulos.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS+' '+
	Articulos.Descripcion as [Equipo destino],
 Requerimientos.UsuarioAnulacion as [Anulo],
 Requerimientos.FechaAnulacion as [Fecha anulacion],
 Requerimientos.MotivoAnulacion as [Motivo anulacion],
 TiposCompra.Descripcion as [Tipo compra],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=(Select Top 1 Aut.IdAutorizo 
				From AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and 
					Aut.IdComprobante=Requerimientos.IdRequerimiento)) as [2da.Firma],
 (Select Top 1 Aut.FechaAutorizacion 
  From AutorizacionesPorComprobante Aut 
  Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and 
	Aut.IdComprobante=Requerimientos.IdRequerimiento) as [Fecha 2da.Firma],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=(Select Top 1 Det.IdComprador 
				From DetalleRequerimientos Det 
				Where Det.IdRequerimiento=Requerimientos.IdRequerimiento and Det.IdComprador  is not null)) as [Comprador],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.IdImporto=Empleados.IdEmpleado) as [Importada por],
 Requerimientos.FechaLlegadaImportacion as [Fec.llego SAT],
  --#Auxiliar10.FechasLiberacionParaCompras as [Fechas de liberacion para compras por item],
 '' as [Fechas de liberacion para compras por item],
 Requerimientos.DetalleImputacion as [Detalle imputacion],

 '' as Vector_T,
 '' as Vector_X
FROM Requerimientos
LEFT OUTER JOIN Obras ON Requerimientos.IdObra=Obras.IdObra
LEFT OUTER JOIN CentrosCosto ON Requerimientos.IdCentroCosto=CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Sectores ON Requerimientos.IdSector=Sectores.IdSector
LEFT OUTER JOIN Monedas ON Requerimientos.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN ArchivosATransmitirDestinos ON Requerimientos.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN Articulos ON Requerimientos.IdEquipoDestino=Articulos.IdArticulo
--LEFT OUTER JOIN #Auxiliar0 ON Requerimientos.IdRequerimiento=#Auxiliar0.IdRequerimiento
--LEFT OUTER JOIN #Auxiliar2 ON Requerimientos.IdRequerimiento=#Auxiliar2.IdRequerimiento
--LEFT OUTER JOIN #Auxiliar4 ON Requerimientos.IdRequerimiento=#Auxiliar4.IdRequerimiento
--LEFT OUTER JOIN #Auxiliar6 ON Requerimientos.IdRequerimiento=#Auxiliar6.IdRequerimiento
--LEFT OUTER JOIN #Auxiliar8 ON Requerimientos.IdRequerimiento=#Auxiliar8.IdRequerimiento
--LEFT OUTER JOIN #Auxiliar10 ON Requerimientos.IdRequerimiento=#Auxiliar10.IdRequerimiento
LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
WHERE IsNull(Requerimientos.Confirmado,'SI')<>'NO' and IsNull(Requerimientos.ConfirmadoPorWeb,'SI')<>'NO'
--ORDER BY Requerimientos.FechaRequerimiento Desc, Requerimientos.NumeroRequerimiento Desc


go







--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistencia]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistencia]
go




create PROCEDURE [dbo].[wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistencia]

@PuntoVenta int,
@Sesion varchar(50)



AS


--select * from  wGrillaPersistencia
--select * from wTempCartasPorteFacturacionAutomatica


--declare @PuntoVenta int
 -- set @PuntoVenta = 1

select distinct  

--ColumnaTilde ,
--IdCartaDePorte,
-- IdArticulo,
-- NumeroCartaDePorte, 
-- SubNumeroVagon,
-- SubnumeroDeFacturacion,  FechaArribo,  FechaDescarga,   FacturarselaA,  
-- IdFacturarselaA              		  ,Confirmado,           
-- IdCodigoIVA 		  , CUIT,            ClienteSeparado ,  		 
--  TarifaFacturada            ,
--  Producto,          KgNetos,  IdCorredor, 
--  IdTitular ,      IdIntermediario ,   IdRComercial, 
--  IdDestinatario,             		 
-- Titular  ,        
--   Intermediario  ,  [R. Comercial]  ,        
-- Corredor    ,  		  Destinatario,          
-- DestinoDesc  		 ,        
--   		[Procedcia.] ,            
-- IdDestino   

ColumnaTilde ,
cast (ISNULL(IdCartaDePorte,0) as int)  as IdCartaDePorte, 
cast (ISNULL( IdArticulo,0) as int) as IdArticulo,
ISNULL( NumeroCartaDePorte,0) as NumeroCartaDePorte,
cast (ISNULL( SubNumeroVagon,0) as int) as SubNumeroVagon,
cast (ISNULL( SubnumeroDeFacturacion,0) as int) as SubnumeroDeFacturacion, 
ISNULL( FechaArribo,0) as FechaArribo, 
ISNULL( FechaDescarga,0) as FechaDescarga,  
ISNULL( FacturarselaA,'') as FacturarselaA,  
cast (ISNULL( IdFacturarselaA ,0) as int) as   IdFacturarselaA          		  ,
Confirmado,           
 cast (ISNULL(IdCodigoIVA ,0) as int) as	IdCodigoIVA	  , 
 ISNULL(CUIT,'') as CUIT,            
 ClienteSeparado ,  		 
ISNULL(dbo.wTarifaWilliams(CDP.IdFacturarselaA ,CDP.IdArticulo,CDP.IdDestino , case when isnull(Exporta,'NO')='SI' then 1 else 0 end   ),0) as TarifaFacturada  ,
  ISNULL(Producto,'') as Producto ,        
  ISNULL(  KgNetos,0.0) as KgNetos, 
  cast (ISNULL( IdCorredor,0) as int) as IdCorredor, 
 cast (ISNULL( IdTitular,0) as int) as IdTitular ,    
 cast (ISNULL(  IdIntermediario,0) as int) as IdIntermediario ,  
 cast (ISNULL( IdRComercial,0) as int) as IdRComercial, 
 cast (ISNULL( IdDestinatario,0) as int) as IdDestinatario,             		 
 ISNULL(Titular,'') as Titular ,        
  ISNULL( Intermediario,'')  as Intermediario,  
  ISNULL([R. Comercial],'') as [R. Comercial] ,        
 ISNULL(Corredor,'')  as  Corredor,  		 
 ISNULL( Destinatario,'') as Destinatario,          
 ISNULL(DestinoDesc ,'')  as	DestinoDesc	 ,        
ISNULL(  		[Procedcia.],'')  as [Procedcia.],            
cast (ISNULL( IdDestino,0) as int) as  IdDestino ,
cast (ISNULL( IdCartaOriginal,0) as int) as IdCartaOriginal,
 ISNULL( AgregaItemDeGastosAdministrativos,'') as AgregaItemDeGastosAdministrativos

 
from (          

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--tit
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde ,IdCartaDePorte, CDP.IdArticulo,               NumeroCartaDePorte, 
SubNumeroVagon,CDP.SubnumeroDeFacturacion, FechaArribo, FechaDescarga,  CLIVEN.razonsocial as FacturarselaA,  CLIVEN.idcliente as IdFacturarselaA              		  ,isnull(CLIVEN.Confirmado,'NO') as Confirmado,           CLIVEN.IdCodigoIVA  		  ,CLIVEN.CUIT,           '' as ClienteSeparado ,  		 
0.0 as TarifaFacturada            ,Articulos.Descripcion as  Producto,         NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,    CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,             		 CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,     		 CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],      		 CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc  		 ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino   , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
  from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIVEN.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino    
-- INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
inner join wGrillaPersistencia  on CDP.IdCartaDePorte=wGrillaPersistencia.idrenglon and wGrillaPersistencia.Sesion=@Sesion 
 where CLIVEN.SeLeFacturaCartaPorteComoTitular='SI'    and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta

union ALL
   

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--co1 intermediario
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, 
SubNumeroVagon,CDP.SubnumeroDeFacturacion   , FechaArribo,        FechaDescarga  ,      CLICO1.razonsocial as FacturarselaA,  CLICO1.idcliente as IdFacturarselaA    	  ,isnull(CLICO1.Confirmado,'NO') as Confirmado,           CLICO1.IdCodigoIVA    		  ,CLICO1.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,     CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,              CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino    , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
 from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICO1.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino    
 inner join wGrillaPersistencia  on CDP.IdCartaDePorte=wGrillaPersistencia.idrenglon and wGrillaPersistencia.Sesion=@Sesion 

-- INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
 where CLICO1.SeLeFacturaCartaPorteComoIntermediario='SI'   and isnull(CDP.IdClienteAFacturarle,-1) <= 0            
 and cdp.puntoVenta=@PuntoVenta


union ALL
   

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--co2 rem comercial
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, SubNumeroVagon ,CDP.SubnumeroDeFacturacion  , 
FechaArribo,        FechaDescarga  ,      CLICO2.razonsocial as FacturarselaA,  CLICO2.idcliente as IdFacturarselaA    	  ,isnull(CLICO2.Confirmado,'NO') as Confirmado,           CLICO2.IdCodigoIVA    		  ,CLICO2.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,    CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,               CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino   , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
  from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICO2.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
  inner join wGrillaPersistencia  on CDP.IdCartaDePorte=wGrillaPersistencia.idrenglon and wGrillaPersistencia.Sesion=@Sesion 

--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta   
 where CLICO2.SeLeFacturaCartaPorteComoRemComercial='SI'   and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta


union ALL

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--cliente auxiliar
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, SubNumeroVagon ,CDP.SubnumeroDeFacturacion  , 
FechaArribo,        FechaDescarga  ,      CLIAUX.razonsocial as FacturarselaA,  CLIAUX.idcliente as IdFacturarselaA    	  ,isnull(CLICO2.Confirmado,'NO') as Confirmado,           CLICO2.IdCodigoIVA    		  ,CLICO2.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor,
 Vendedor as IdTitular,    CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario, 
               CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,     
			      CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,   
				        		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino   , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
  from CartasDePorte CDP    
  inner join wGrillaPersistencia  on CDP.IdCartaDePorte=wGrillaPersistencia.idrenglon and wGrillaPersistencia.Sesion=@Sesion 

  LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar = CLIAUX.IdCliente     
  LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     
  LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICO2.idListaPrecios = LPD.idListaPrecios    
  LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     
  LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     
  LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     
  LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     
  LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     
  LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista    
   LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     
   LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     
   LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta   
 where CLIAUX.SeLeFacturaCartaPorteComoClienteAuxiliar='SI'   and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta


union ALL

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--destinatario local
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////

SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, 
SubNumeroVagon  ,CDP.SubnumeroDeFacturacion , FechaArribo,        FechaDescarga  ,      CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA    	  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,           CLIENT.IdCodigoIVA    		  ,CLIENT.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,   CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,                CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos    ,cdp.exporta
from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIENT.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
inner join wGrillaPersistencia  on CDP.IdCartaDePorte=wGrillaPersistencia.idrenglon and wGrillaPersistencia.Sesion=@Sesion 

--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
where CLIENT.SeLeFacturaCartaPorteComoDestinatario='SI' and isnull(CDP.Exporta,'NO')='NO'
 and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta


union ALL
  

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--destinatario exportador
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, 
SubNumeroVagon  ,CDP.SubnumeroDeFacturacion , FechaArribo,        FechaDescarga  ,      CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA    	  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,           CLIENT.IdCodigoIVA    		  ,CLIENT.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,   CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,                CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
    from CartasDePorte CDP    LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIENT.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
	inner join wGrillaPersistencia  on CDP.IdCartaDePorte=wGrillaPersistencia.idrenglon and wGrillaPersistencia.Sesion=@Sesion 

--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
where CLIENT.SeLeFacturaCartaPorteComoDestinatarioExportador='SI' and CDP.Exporta='SI'
	and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta


union ALL
  

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--corredor
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, 
SubNumeroVagon,CDP.SubnumeroDeFacturacion   , FechaArribo,        FechaDescarga  ,      CLICORCLI.razonsocial as FacturarselaA,  CLICORCLI.idcliente as IdFacturarselaA    	  ,isnull(CLICORCLI.Confirmado,'NO') as Confirmado,           CLICORCLI.IdCodigoIVA    		  ,CLICORCLI.CUIT,           '' as ClienteSeparado ,  		 
0.0  as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, 
Vendedor as IdTitular,  CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,                 CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],       CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino     , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
from CartasDePorte CDP    LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     
inner join wGrillaPersistencia  on CDP.IdCartaDePorte=wGrillaPersistencia.idrenglon and wGrillaPersistencia.Sesion=@Sesion 

LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLICORCLI.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
where CLICORCLI.SeLeFacturaCartaPorteComoCorredor='SI'   and isnull(CDP.IdClienteAFacturarle,-1) <= 0  and isnull(IdFacturaImputada,0)<=0            
 and cdp.puntoVenta=@PuntoVenta


union ALL


--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--cliente explicito (originales)
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,IdCartaDePorte, CDP.IdArticulo,    NumeroCartaDePorte, SubNumeroVagon ,
CDP.SubnumeroDeFacturacion  , FechaArribo,        FechaDescarga  ,      CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA    	  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,           CLIENT.IdCodigoIVA    		  ,CLIENT.CUIT,           '' as ClienteSeparado ,  		 
0.0 as TarifaFacturada       ,Articulos.Descripcion as  Producto,    NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,      CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,             CLIVEN.Razonsocial as   Titular  ,
        CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],      
		 CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 
		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino   , 0 as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta
 from CartasDePorte CDP    
 inner join wGrillaPersistencia  on CDP.IdCartaDePorte=wGrillaPersistencia.idrenglon and wGrillaPersistencia.Sesion=@Sesion 

LEFT OUTER JOIN Clientes CLIENT ON CDP.IdClienteAFacturarle = CLIENT.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON isnull(CLIENT.idListaPrecios,1 ) = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
where CDP.IdClienteAFacturarle > 0            
 and cdp.puntoVenta=@PuntoVenta


union ALL

--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
--cliente explicito (duplicados)
--/////////////////////////////////////////////////////
--/////////////////////////////////////////////////////
SELECT DISTINCT 0 as ColumnaTilde    ,CDPduplicadas.IdCartaDePorte, CDP.IdArticulo,    CDP.NumeroCartaDePorte, 
	CDP.SubNumeroVagon ,CDPduplicadas.SubnumeroDeFacturacion  , CDP.FechaArribo,        CDP.FechaDescarga  ,      
	CLIENT.razonsocial as FacturarselaA,  CLIENT.idcliente as IdFacturarselaA    
		  ,isnull(CLIENT.Confirmado,'NO') as Confirmado,
    CLIENT.IdCodigoIVA    		  ,CLIENT.CUIT,           '' as ClienteSeparado ,  		 
	0.0 as TarifaFacturada       ,Articulos.Descripcion as  Producto,    CDP.NetoFinal  as  KgNetos , 
	CDP.Corredor as IdCorredor, CDP.Vendedor as IdTitular,   CDP.CuentaOrden1 as IdIntermediario, 
	CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,          CLIVEN.Razonsocial as   Titular  ,        
	CLICO1.Razonsocial as   Intermediario  ,      CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],
    CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc    ,         		 
	LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino    ,
	CDP.IdCartaDePorte as IdCartaOriginal,CDP.AgregaItemDeGastosAdministrativos,cdp.exporta

from 

CartasDePorte CDP inner join wGrillaPersistencia  on CDP.IdCartaDePorte=wGrillaPersistencia.idrenglon and wGrillaPersistencia.Sesion=@Sesion 
/*
( Select * from CartasDePorte  --inner join wGrillaPersistencia  on CartasDePorte.IdCartaDePorte=wGrillaPersistencia.idrenglon 
 where cartasdeporte.IdFacturaImputada=0 
)
as
CDP    
*/


LEFT OUTER JOIN CartasDePorte CDPduplicadas ON CDP.NumeroCartaDePorte = CDPduplicadas.NumeroCartaDePorte and  CDP.SubNumeroVagon = CDPduplicadas.SubNumeroVagon and CDPduplicadas.SubnumeroDeFacturacion>0    
LEFT OUTER JOIN Clientes CLIENT ON CDPduplicadas.IdClienteAFacturarle = CLIENT.IdCliente     
LEFT OUTER JOIN ListasPreciosDetalle LPD ON isnull(CLIENT.idListaPrecios,1 ) = LPD.idListaPrecios    
LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     
LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo     LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista     LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer     LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino     
--INNER JOIN  #temptab on  CDP.IdCartaDePorte=#temptab.IdCarta    
where CDP.IdClienteAFacturarle > 0     
 and cdp.puntoVenta=@PuntoVenta


)  as CDP 


go




[wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistencia] 1,'sss'
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////





IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[DetFacturas_TX_ConDatos2]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[DetFacturas_TX_ConDatos2]
go



create PROCEDURE [dbo].[DetFacturas_TX_ConDatos2]  
  
@IdFactura int,  
@IdDetalleFactura int = Null  
  
AS  
  
SET NOCOUNT ON  
  
SET @IdDetalleFactura=IsNull(@IdDetalleFactura,-1)  
  
DECLARE @IdObraDefault int  
SET @IdObraDefault=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdObraDefault'),0)  
  
CREATE TABLE #Auxiliar1   
   (  
    IdDetalleFactura INTEGER,  
    IdColor INTEGER  
   )  
INSERT INTO #Auxiliar1   
 SELECT DetFac.IdDetalleFactura, Max(IsNull(UnidadesEmpaque.IdColor,0))  
 FROM DetalleFacturasRemitos DetFac  
 LEFT OUTER JOIN DetalleRemitos det ON DetFac.IdDetalleRemito = det.IdDetalleRemito  
 LEFT OUTER JOIN UnidadesEmpaque ON det.NumeroCaja = UnidadesEmpaque.NumeroUnidad  
 WHERE DetFac.IdFactura = @IdFactura  
 GROUP BY DetFac.IdDetalleFactura  
  
CREATE TABLE #Auxiliar2   
   (  
    IdDetalleFactura INTEGER,  
    IdColor INTEGER  
   )  
INSERT INTO #Auxiliar2   
 SELECT DetFac.IdDetalleFactura, Max(IsNull(det.IdColor,0))  
 FROM DetalleFacturasOrdenesCompra DetFac  
 LEFT OUTER JOIN DetalleOrdenesCompra det ON DetFac.IdDetalleOrdenCompra = det.IdDetalleOrdenCompra  
 WHERE DetFac.IdFactura = @IdFactura  
 GROUP BY DetFac.IdDetalleFactura  
  
SET NOCOUNT OFF  
  
SELECT  
 DetFac.*,  
 Round((DetFac.Cantidad*DetFac.PrecioUnitario)*(1-(DetFac.Bonificacion/100)),2) as [Importe],  
 Articulos.Codigo as [Codigo],  
 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],  
 IsNull(Articulos.Caracteristicas,Articulos.Descripcion) as [Caracteristicas],  
 IsNull(Articulos.AuxiliarString10,'') as [AuxiliarString10],  
 Articulos.CostoPPP as [CostoPPP],  
 Unidades.Abreviatura as [Unidad],  
 CalidadesClad.Abreviatura as [Calidad],  
 (Select Top 1  OrdenesCompra.IdObra  
  From DetalleFacturasOrdenesCompra DetFacOC  
  Left Outer Join DetalleOrdenesCompra doc On DetFacOC.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra  
  Left Outer Join OrdenesCompra On doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra  
  Where DetFacOC.IdDetalleFactura=DetFac.IdDetalleFactura) as [IdObra],  
 (Select Top 1  Obras.NumeroObra  
  From DetalleFacturasOrdenesCompra DetFacOC  
  Left Outer Join DetalleOrdenesCompra doc On DetFacOC.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra  
  Left Outer Join OrdenesCompra On doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra  
  Left Outer Join Obras On OrdenesCompra.IdObra = Obras.IdObra  
  Where DetFacOC.IdDetalleFactura=DetFac.IdDetalleFactura) as [Obra],  
 (Select Top 1  dr.NumeroCaja  
  From DetalleFacturasRemitos DetFacRem  
  Left Outer Join DetalleRemitos dr On DetFacRem.IdDetalleRemito = dr.IdDetalleRemito  
  Where DetFacRem.IdDetalleFactura=DetFac.IdDetalleFactura) as [NumeroCaja],  
 IsNull((Select Top 1  Colores.Descripcion  
  From DetalleFacturasRemitos DetFacRem  
  Left Outer Join DetalleRemitos dr On DetFacRem.IdDetalleRemito = dr.IdDetalleRemito  
  Left Outer Join UnidadesEmpaque On dr.NumeroCaja = UnidadesEmpaque.NumeroUnidad  
  Left Outer Join DetalleOrdenesCompra doc On dr.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra  
  Left Outer Join Colores On IsNull(UnidadesEmpaque.IdColor,doc.IdColor) = Colores.IdColor  
  Where DetFacRem.IdDetalleFactura=DetFac.IdDetalleFactura),   
 (Select Top 1  Colores.Descripcion  
  From DetalleFacturasOrdenesCompra DetFacOC  
  Left Outer Join DetalleOrdenesCompra doc On DetFacOC.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra  
  Left Outer Join Colores On doc.IdColor = Colores.IdColor  
  Where DetFacOC.IdDetalleFactura=DetFac.IdDetalleFactura)) as [Color],  
 Colores.Descripcion as [Color1],  
 (Select Top 1  dr.Partida  
  From DetalleFacturasRemitos DetFacRem  
  Left Outer Join DetalleRemitos dr On DetFacRem.IdDetalleRemito = dr.IdDetalleRemito  
  Where DetFacRem.IdDetalleFactura=DetFac.IdDetalleFactura) as [Partida],  
 @IdObraDefault as [IdObraDefault],  
 (Select Top 1 Obras.NumeroObra From Obras Where Obras.IdObra=@IdObraDefault) as [ObraDefault]  
FROM DetalleFacturas DetFac  
LEFT OUTER JOIN Articulos ON DetFac.IdArticulo = Articulos.IdArticulo  
LEFT OUTER JOIN Unidades ON DetFac.IdUnidad = Unidades.IdUnidad  
LEFT OUTER JOIN CalidadesClad ON Articulos.IdCalidadClad = CalidadesClad.IdCalidadClad  
LEFT OUTER JOIN #Auxiliar1 ON DetFac.IdDetalleFactura = #Auxiliar1.IdDetalleFactura  
LEFT OUTER JOIN #Auxiliar2 ON DetFac.IdDetalleFactura = #Auxiliar2.IdDetalleFactura  
LEFT OUTER JOIN Colores ON IsNull(#Auxiliar1.IdColor,IsNull(#Auxiliar2.IdColor,DetFac.IdColor)) = Colores.IdColor  
WHERE (@IdFactura=-1 or DetFac.IdFactura = @IdFactura) and (@IdDetalleFactura=-1 or DetFac.IdDetalleFactura=@IdDetalleFactura)  
ORDER BY DetFac.IdDetalleFactura --[Obra]  
  
DROP TABLE #Auxiliar1  
DROP TABLE #Auxiliar2  
go