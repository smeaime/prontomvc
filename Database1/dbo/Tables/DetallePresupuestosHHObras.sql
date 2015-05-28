CREATE TABLE [dbo].[DetallePresupuestosHHObras] (
    [IdDetallePresupuestoHHObras] INT             IDENTITY (1, 1) NOT NULL,
    [IdObra]                      INT             NULL,
    [IdSector]                    INT             NULL,
    [HorasPresupuestadas]         NUMERIC (18, 2) NULL,
    [IdEquipo]                    INT             NULL,
    [HorasTerceros]               NUMERIC (18)    NULL,
    [PorcentajeAplicado]          NUMERIC (18)    NULL,
    [PorcentajeAplicadoTerceros]  NUMERIC (18)    NULL,
    [EsObra]                      VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetallePresupuestosHHObras] PRIMARY KEY CLUSTERED ([IdDetallePresupuestoHHObras] ASC) WITH (FILLFACTOR = 90)
);

