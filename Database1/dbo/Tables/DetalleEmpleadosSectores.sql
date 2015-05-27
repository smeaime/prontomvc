CREATE TABLE [dbo].[DetalleEmpleadosSectores] (
    [IdDetalleEmpleadoSector] INT      IDENTITY (1, 1) NOT NULL,
    [IdEmpleado]              INT      NULL,
    [FechaCambio]             DATETIME NULL,
    [IdSectorNuevo]           INT      NULL,
    CONSTRAINT [PK_DetalleEmpleadosSectores] PRIMARY KEY CLUSTERED ([IdDetalleEmpleadoSector] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleEmpleadosSectores_Empleados] FOREIGN KEY ([IdEmpleado]) REFERENCES [dbo].[Empleados] ([IdEmpleado])
);

