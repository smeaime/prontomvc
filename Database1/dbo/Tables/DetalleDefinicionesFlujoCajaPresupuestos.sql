CREATE TABLE [dbo].[DetalleDefinicionesFlujoCajaPresupuestos] (
    [IdDetalleDefinicionFlujoCaja] INT             IDENTITY (1, 1) NOT NULL,
    [IdDefinicionFlujoCaja]        INT             NULL,
    [Mes]                          INT             NULL,
    [Año]                          INT             NULL,
    [Presupuesto]                  NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DetalleDefinicionesFlujoCaja] PRIMARY KEY CLUSTERED ([IdDetalleDefinicionFlujoCaja] ASC) WITH (FILLFACTOR = 90)
);

