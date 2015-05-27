﻿CREATE TABLE [dbo].[DetalleOtrosIngresosAlmacen] (
    [IdDetalleOtroIngresoAlmacen]         INT             IDENTITY (1, 1) NOT NULL,
    [IdOtroIngresoAlmacen]                INT             NULL,
    [IdArticulo]                          INT             NULL,
    [IdStock]                             INT             NULL,
    [Partida]                             VARCHAR (20)    NULL,
    [Cantidad]                            DECIMAL (18, 2) NULL,
    [CantidadAdicional]                   DECIMAL (18, 2) NULL,
    [IdUnidad]                            INT             NULL,
    [Cantidad1]                           DECIMAL (18, 2) NULL,
    [Cantidad2]                           DECIMAL (18, 2) NULL,
    [Adjunto]                             VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto1]                     VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto2]                     VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto3]                     VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto4]                     VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto5]                     VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto6]                     VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto7]                     VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto8]                     VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto9]                     VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto10]                    VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Observaciones]                       NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdUbicacion]                         INT             NULL,
    [IdObra]                              INT             NULL,
    [EnviarEmail]                         TINYINT         NULL,
    [IdDetalleOtroIngresoAlmacenOriginal] INT             NULL,
    [IdOtroIngresoAlmacenOriginal]        INT             NULL,
    [IdOrigenTransmision]                 INT             NULL,
    [CostoUnitario]                       NUMERIC (18, 2) NULL,
    [IdMoneda]                            INT             NULL,
    [IdControlCalidad]                    INT             NULL,
    [Controlado]                          VARCHAR (2)     NULL,
    [CantidadCC]                          NUMERIC (18, 2) NULL,
    [CantidadRechazadaCC]                 NUMERIC (18, 2) NULL,
    [IdDetalleSalidaMateriales]           INT             NULL,
    [IdEquipoDestino]                     INT             NULL,
    [IdOrdenTrabajo]                      INT             NULL,
    [IdDetalleObraDestino]                INT             NULL,
    [Talle]                               VARCHAR (2)     NULL,
    [IdColor]                             INT             NULL,
    CONSTRAINT [PK_DetalleOtrosIngresosAlmacen] PRIMARY KEY CLUSTERED ([IdDetalleOtroIngresoAlmacen] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleOtrosIngresosAlmacen_OtrosIngresosAlmacen] FOREIGN KEY ([IdOtroIngresoAlmacen]) REFERENCES [dbo].[OtrosIngresosAlmacen] ([IdOtroIngresoAlmacen])
);

