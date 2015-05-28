CREATE TABLE [dbo].[AsignacionesCostos] (
    [IdAsignacionCosto]  INT      IDENTITY (1, 1) NOT NULL,
    [IdCostoImportacion] INT      NULL,
    [IdDetallePedido]    INT      NULL,
    [FechaAsignacion]    DATETIME NULL,
    CONSTRAINT [PK_AsignacionesCostos] PRIMARY KEY CLUSTERED ([IdAsignacionCosto] ASC) WITH (FILLFACTOR = 90)
);

