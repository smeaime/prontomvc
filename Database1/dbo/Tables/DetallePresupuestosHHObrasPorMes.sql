CREATE TABLE [dbo].[DetallePresupuestosHHObrasPorMes] (
    [IdDetallePresupuestoHHObrasPorMes] INT             IDENTITY (1, 1) NOT NULL,
    [IdObra]                            INT             NULL,
    [IdSector]                          INT             NULL,
    [Año]                               INT             NULL,
    [Mes]                               INT             NULL,
    [HorasProgramadas]                  NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DetallePresupuestosHHObrasPorMes] PRIMARY KEY CLUSTERED ([IdDetallePresupuestoHHObrasPorMes] ASC) WITH (FILLFACTOR = 90)
);

