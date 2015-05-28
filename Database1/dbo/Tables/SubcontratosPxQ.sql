CREATE TABLE [dbo].[SubcontratosPxQ] (
    [IdSubcontratoPxQ]        INT             IDENTITY (1, 1) NOT NULL,
    [IdSubcontrato]           INT             NULL,
    [IdArticulo]              INT             NULL,
    [Mes]                     INT             NULL,
    [Año]                     INT             NULL,
    [Importe]                 NUMERIC (18, 2) NULL,
    [Cantidad]                NUMERIC (18, 2) NULL,
    [ImporteAvance]           NUMERIC (18, 2) NULL,
    [CantidadAvance]          NUMERIC (18, 2) NULL,
    [NumeroCertificado]       INT             NULL,
    [CantidadAvanceAcumulada] NUMERIC (18, 2) NULL,
    [ImporteDescuento]        NUMERIC (18, 2) NULL,
    [ImporteTotal]            NUMERIC (18, 2) NULL,
    [IdPresupuestoObrasNodo]  INT             NULL,
    CONSTRAINT [PK_SubcontratosPxQ] PRIMARY KEY CLUSTERED ([IdSubcontratoPxQ] ASC) WITH (FILLFACTOR = 90)
);

