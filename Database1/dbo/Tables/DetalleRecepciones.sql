CREATE TABLE [dbo].[DetalleRecepciones] (
    [IdDetalleRecepcion]                         INT             IDENTITY (1, 1) NOT NULL,
    [IdRecepcion]                                INT             NULL,
    [Cantidad]                                   DECIMAL (18, 2) NULL,
    [IdUnidad]                                   INT             NULL,
    [IdArticulo]                                 INT             NULL,
    [IdControlCalidad]                           INT             NULL,
    [Observaciones]                              NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Cantidad1]                                  DECIMAL (18, 2) NULL,
    [Cantidad2]                                  DECIMAL (18, 2) NULL,
    [IdDetallePedido]                            INT             NULL,
    [Controlado]                                 VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CantidadAdicional]                          NUMERIC (18, 2) NULL,
    [Partida]                                    VARCHAR (20)    NULL,
    [CantidadCC]                                 NUMERIC (18, 2) NULL,
    [Cantidad1CC]                                NUMERIC (18, 2) NULL,
    [Cantidad2CC]                                NUMERIC (18, 2) NULL,
    [CantidadAdicionalCC]                        NUMERIC (18, 2) NULL,
    [ObservacionesCC]                            NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CantidadRechazadaCC]                        NUMERIC (18, 2) NULL,
    [IdMotivoRechazo]                            INT             NULL,
    [IdRealizo]                                  INT             NULL,
    [IdDetalleRequerimiento]                     INT             NULL,
    [Trasabilidad]                               VARCHAR (10)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdDetalleAcopios]                           INT             NULL,
    [IdUbicacion]                                INT             NULL,
    [IdObra]                                     INT             NULL,
    [CostoUnitario]                              NUMERIC (18, 4) NULL,
    [IdMoneda]                                   INT             NULL,
    [CotizacionDolar]                            NUMERIC (18, 3) NULL,
    [CotizacionMoneda]                           NUMERIC (18, 3) NULL,
    [EnviarEmail]                                TINYINT         NULL,
    [IdDetalleRecepcionOriginal]                 INT             NULL,
    [IdRecepcionOriginal]                        INT             NULL,
    [IdOrigenTransmision]                        INT             NULL,
    [IdDetalleObraDestino]                       INT             NULL,
    [CantidadEnOrigen]                           NUMERIC (18, 2) NULL,
    [IdDetalleSalidaMateriales]                  INT             NULL,
    [IdPresupuestoObrasNodo]                     INT             NULL,
    [CostoOriginal]                              NUMERIC (18, 4) NULL,
    [IdUsuarioModificoCosto]                     INT             NULL,
    [FechaModificacionCosto]                     DATETIME        NULL,
    [ObservacionModificacionCosto]               NTEXT           NULL,
    [IdMonedaOriginal]                           INT             NULL,
    [NumeroCaja]                                 INT             NULL,
    [IdColor]                                    INT             NULL,
    [IdDetalleLiquidacionFlete]                  INT             NULL,
    [IdUsuarioDioPorCumplidoLiquidacionFletes]   INT             NULL,
    [FechaDioPorCumplidoLiquidacionFletes]       DATETIME        NULL,
    [ObservacionDioPorCumplidoLiquidacionFletes] NTEXT           NULL,
    [Talle]                                      VARCHAR (2)     NULL,
    [IdProduccionTerminado]                      INT             NULL,
    CONSTRAINT [PK_DetalleRecepciones] PRIMARY KEY CLUSTERED ([IdDetalleRecepcion] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleRecepciones_Articulos] FOREIGN KEY ([IdArticulo]) REFERENCES [dbo].[Articulos] ([IdArticulo]),
    CONSTRAINT [FK_DetalleRecepciones_DetallePedidos] FOREIGN KEY ([IdDetallePedido]) REFERENCES [dbo].[DetallePedidos] ([IdDetallePedido]),
    CONSTRAINT [FK_DetalleRecepciones_DetalleRequerimientos] FOREIGN KEY ([IdDetalleRequerimiento]) REFERENCES [dbo].[DetalleRequerimientos] ([IdDetalleRequerimiento]),
    CONSTRAINT [FK_DetalleRecepciones_Recepciones] FOREIGN KEY ([IdRecepcion]) REFERENCES [dbo].[Recepciones] ([IdRecepcion]),
    CONSTRAINT [FK_DetalleRecepciones_Ubicaciones] FOREIGN KEY ([IdUbicacion]) REFERENCES [dbo].[Ubicaciones] ([IdUbicacion])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleRecepciones]([IdRecepcion] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice2]
    ON [dbo].[DetalleRecepciones]([IdDetalleRequerimiento] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice3]
    ON [dbo].[DetalleRecepciones]([IdDetalleSalidaMateriales] ASC) WITH (FILLFACTOR = 90);

