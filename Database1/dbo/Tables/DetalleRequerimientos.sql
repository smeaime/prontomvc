﻿CREATE TABLE [dbo].[DetalleRequerimientos] (
    [IdDetalleRequerimiento]         INT             IDENTITY (1, 1) NOT NULL,
    [IdRequerimiento]                INT             NULL,
    [NumeroItem]                     INT             NULL,
    [Cantidad]                       NUMERIC (18, 2) NULL,
    [IdUnidad]                       INT             NULL,
    [IdArticulo]                     INT             NULL,
    [FechaEntrega]                   DATETIME        NULL,
    [Observaciones]                  NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Cantidad1]                      NUMERIC (18, 2) NULL,
    [Cantidad2]                      NUMERIC (18, 2) NULL,
    [IdDetalleLMateriales]           INT             NULL,
    [IdControlCalidad]               INT             NULL,
    [Adjunto]                        VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto]                 VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdCentroCosto]                  INT             NULL,
    [IdComprador]                    INT             NULL,
    [NumeroFacturaCompra1]           INT             NULL,
    [FechaFacturaCompra]             DATETIME        NULL,
    [ImporteFacturaCompra]           NUMERIC (18, 2) NULL,
    [IdProveedor]                    INT             NULL,
    [NumeroFacturaCompra2]           INT             NULL,
    [EsBienDeUso]                    VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdCuenta]                       INT             NULL,
    [Cumplido]                       VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Usuario1]                       VARCHAR (6)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [FechaIngreso1]                  DATETIME        NULL,
    [ArchivoAdjunto1]                VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto2]                VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto3]                VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto4]                VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto5]                VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto6]                VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto7]                VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto8]                VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto9]                VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto10]               VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Descripcionmanual]              VARCHAR (250)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EnviarEmail]                    TINYINT         NULL,
    [IdRequerimientoOriginal]        INT             NULL,
    [IdDetalleRequerimientoOriginal] INT             NULL,
    [IdOrigenTransmision]            INT             NULL,
    [IdLlamadoAProveedor]            INT             NULL,
    [FechaLlamadoAProveedor]         DATETIME        NULL,
    [IdLlamadoRegistradoPor]         INT             NULL,
    [FechaRegistracionLlamada]       DATETIME        NULL,
    [ObservacionesLlamada]           NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdAutorizoCumplido]             INT             NULL,
    [IdDioPorCumplido]               INT             NULL,
    [FechaDadoPorCumplido]           DATETIME        NULL,
    [ObservacionesCumplido]          NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdAproboAlmacen]                INT             NULL,
    [IdEquipo]                       INT             NULL,
    [FechaEntrega_Tel]               DATETIME        NULL,
    [PRESTOConcepto]                 VARCHAR (13)    NULL,
    [Costo]                          NUMERIC (18, 2) NULL,
    [OrigenDescripcion]              INT             NULL,
    [TipoDesignacion]                VARCHAR (3)     NULL,
    [IdLiberoParaCompras]            INT             NULL,
    [FechaLiberacionParaCompras]     DATETIME        NULL,
    [Recepcionado]                   VARCHAR (2)     NULL,
    [Pagina]                         INT             NULL,
    [Item]                           INT             NULL,
    [Figura]                         INT             NULL,
    [CodigoDistribucion]             VARCHAR (3)     NULL,
    [IdEquipoDestino]                INT             NULL,
    [Entregado]                      VARCHAR (2)     NULL,
    [FechaAsignacionComprador]       DATETIME        NULL,
    [MoP]                            VARCHAR (1)     NULL,
    [IdDetalleObraDestino]           INT             NULL,
    [IdPresupuestoObraRubro]         INT             NULL,
    [ObservacionesFirmante]          NTEXT           NULL,
    [IdFirmanteObservo]              INT             NULL,
    [FechaUltimaObservacionFirmante] DATETIME        NULL,
    [IdPresupuestoObrasNodo]         INT             NULL,
    CONSTRAINT [PK_DetalleRequerimientos] PRIMARY KEY CLUSTERED ([IdDetalleRequerimiento] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleRequerimientos]([IdRequerimiento] ASC) WITH (FILLFACTOR = 90);

