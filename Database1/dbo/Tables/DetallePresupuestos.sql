CREATE TABLE [dbo].[DetallePresupuestos] (
    [IdDetallePresupuesto]   INT             IDENTITY (1, 1) NOT NULL,
    [IdPresupuesto]          INT             NULL,
    [NumeroItem]             INT             NULL,
    [IdArticulo]             INT             NULL,
    [Cantidad]               NUMERIC (18, 2) NULL,
    [IdUnidad]               INT             NULL,
    [Precio]                 NUMERIC (18, 4) NULL,
    [Adjunto]                VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto]         VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Cantidad1]              NUMERIC (18, 2) NULL,
    [Cantidad2]              NUMERIC (18, 2) NULL,
    [Observaciones]          NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdDetalleAcopios]       INT             NULL,
    [IdDetalleRequerimiento] INT             NULL,
    [OrigenDescripcion]      INT             NULL,
    [IdDetalleLMateriales]   INT             NULL,
    [IdCuenta]               INT             NULL,
    [ArchivoAdjunto1]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto2]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto3]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto4]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto5]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto6]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto7]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto8]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto9]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto10]       VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [FechaEntrega]           DATETIME        NULL,
    [IdCentroCosto]          INT             NULL,
    [PorcentajeBonificacion] NUMERIC (6, 2)  NULL,
    [ImporteBonificacion]    NUMERIC (18, 4) NULL,
    [PorcentajeIva]          NUMERIC (6, 2)  NULL,
    [ImporteIva]             NUMERIC (18, 4) NULL,
    [ImporteTotalItem]       NUMERIC (18, 4) NULL,
    CONSTRAINT [PK_DetallePresupuestos] PRIMARY KEY CLUSTERED ([IdDetallePresupuesto] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetallePresupuestos]([IdPresupuesto] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice2]
    ON [dbo].[DetallePresupuestos]([IdDetalleRequerimiento] ASC) WITH (FILLFACTOR = 90);

