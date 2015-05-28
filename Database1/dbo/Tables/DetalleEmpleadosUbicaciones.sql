CREATE TABLE [dbo].[DetalleEmpleadosUbicaciones] (
    [IdDetalleEmpleadoUbicacion] INT IDENTITY (1, 1) NOT NULL,
    [IdEmpleado]                 INT NULL,
    [IdUbicacion]                INT NULL,
    CONSTRAINT [PK_DetalleEmpleadosUbicacionesAsignadas] PRIMARY KEY CLUSTERED ([IdDetalleEmpleadoUbicacion] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleEmpleadosUbicaciones_Empleados] FOREIGN KEY ([IdEmpleado]) REFERENCES [dbo].[Empleados] ([IdEmpleado])
);

