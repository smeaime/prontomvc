CREATE TABLE [dbo].[DetalleEmpleadosJornadas] (
    [IdDetalleEmpleadoJornada] INT            IDENTITY (1, 1) NOT NULL,
    [IdEmpleado]               INT            NULL,
    [FechaCambio]              DATETIME       NULL,
    [HorasJornada]             NUMERIC (6, 2) NULL,
    CONSTRAINT [PK_DetalleEmpleadosJornada] PRIMARY KEY CLUSTERED ([IdDetalleEmpleadoJornada] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleEmpleadosJornadas_Empleados] FOREIGN KEY ([IdEmpleado]) REFERENCES [dbo].[Empleados] ([IdEmpleado])
);

