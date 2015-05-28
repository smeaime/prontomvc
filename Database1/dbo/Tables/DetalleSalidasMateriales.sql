CREATE TABLE [dbo].[DetalleSalidasMateriales] (
    [IdDetalleSalidaMateriales]                    INT             IDENTITY (1, 1) NOT NULL,
    [IdSalidaMateriales]                           INT             NULL,
    [IdArticulo]                                   INT             NULL,
    [IdStock]                                      INT             NULL,
    [Partida]                                      VARCHAR (20)    NULL,
    [Cantidad]                                     DECIMAL (18, 2) NULL,
    [CantidadAdicional]                            DECIMAL (18, 2) NULL,
    [IdUnidad]                                     INT             NULL,
    [Cantidad1]                                    DECIMAL (18, 2) NULL,
    [Cantidad2]                                    DECIMAL (18, 2) NULL,
    [IdDetalleValeSalida]                          INT             NULL,
    [Adjunto]                                      VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto1]                              VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto2]                              VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto3]                              VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto4]                              VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto5]                              VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto6]                              VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto7]                              VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto8]                              VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto9]                              VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto10]                             VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Observaciones]                                NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdUbicacion]                                  INT             NULL,
    [IdObra]                                       INT             NULL,
    [CostoUnitario]                                NUMERIC (18, 4) NULL,
    [IdMoneda]                                     INT             NULL,
    [CotizacionDolar]                              NUMERIC (18, 4) NULL,
    [CotizacionMoneda]                             NUMERIC (18, 4) NULL,
    [IdEquipoDestino]                              INT             NULL,
    [EnviarEmail]                                  TINYINT         NULL,
    [IdDetalleSalidaMaterialesOriginal]            INT             NULL,
    [IdSalidaMaterialesOriginal]                   INT             NULL,
    [IdOrigenTransmision]                          INT             NULL,
    [DescargaPorKit]                               VARCHAR (2)     NULL,
    [FechaImputacion]                              DATETIME        NULL,
    [IdOrdenTrabajo]                               INT             NULL,
    [IdDetalleObraDestino]                         INT             NULL,
    [IdDetalleSalidaMaterialesPRONTOaSAT]          INT             NULL,
    [IdPresupuestoObraRubro]                       INT             NULL,
    [IdCuenta]                                     INT             NULL,
    [IdCuentaGasto]                                INT             NULL,
    [IdPresupuestoObrasNodo]                       INT             NULL,
    [NumeroCaja]                                   INT             NULL,
    [IdUbicacionDestino]                           INT             NULL,
    [IdFlete]                                      INT             NULL,
    [IdDetalleRecepcion]                           INT             NULL,
    [CostoOriginal]                                NUMERIC (18, 4) NULL,
    [IdUsuarioModificoCosto]                       INT             NULL,
    [FechaModificacionCosto]                       DATETIME        NULL,
    [ObservacionModificacionCosto]                 NTEXT           NULL,
    [IdMonedaOriginal]                             INT             NULL,
    [IdDetalleProduccionOrden]                     INT             NULL,
    [IdDetalleLiquidacionFlete]                    INT             NULL,
    [IdUsuarioDioPorCumplidoLiquidacionFletes]     INT             NULL,
    [FechaDioPorCumplidoLiquidacionFletes]         DATETIME        NULL,
    [ObservacionDioPorCumplidoLiquidacionFletes]   NTEXT           NULL,
    [Talle]                                        VARCHAR (2)     NULL,
    [IdColor]                                      INT             NULL,
    [IdPresupuestoObrasNodoFleteLarga]             INT             NULL,
    [IdPresupuestoObrasNodoFleteInterno]           INT             NULL,
    [CostoFleteLarga]                              NUMERIC (18, 2) NULL,
    [CostoFleteInterno]                            NUMERIC (18, 2) NULL,
    [IdUsuarioDioPorRecepcionado]                  INT             NULL,
    [FechaDioPorRecepcionado]                      DATETIME        NULL,
    [ObservacionDioPorRecepcionado]                NTEXT           NULL,
    [ImputarConsumoAObraActualEquipoMantenimiento] VARCHAR (2)     NULL,
    CONSTRAINT [PK_DetalleSalidasMateriales] PRIMARY KEY CLUSTERED ([IdDetalleSalidaMateriales] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleSalidasMateriales_Articulos] FOREIGN KEY ([IdArticulo]) REFERENCES [dbo].[Articulos] ([IdArticulo]),
    CONSTRAINT [FK_DetalleSalidasMateriales_DetalleRecepciones] FOREIGN KEY ([IdDetalleRecepcion]) REFERENCES [dbo].[DetalleRecepciones] ([IdDetalleRecepcion]),
    CONSTRAINT [FK_DetalleSalidasMateriales_DetalleValesSalida] FOREIGN KEY ([IdDetalleValeSalida]) REFERENCES [dbo].[DetalleValesSalida] ([IdDetalleValeSalida]),
    CONSTRAINT [FK_DetalleSalidasMateriales_SalidasMateriales] FOREIGN KEY ([IdSalidaMateriales]) REFERENCES [dbo].[SalidasMateriales] ([IdSalidaMateriales]),
    CONSTRAINT [FK_DetalleSalidasMateriales_Ubicaciones] FOREIGN KEY ([IdUbicacion]) REFERENCES [dbo].[Ubicaciones] ([IdUbicacion])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleSalidasMateriales]([IdSalidaMateriales] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice2]
    ON [dbo].[DetalleSalidasMateriales]([IdDetalleValeSalida] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice4]
    ON [dbo].[DetalleSalidasMateriales]([IdDetalleProduccionOrden] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice3]
    ON [dbo].[DetalleSalidasMateriales]([IdArticulo] ASC) WITH (FILLFACTOR = 90);

