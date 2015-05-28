CREATE TABLE [dbo].[DetalleEmpleadosObras] (
    [IdDetalleEmpleadoObra] INT IDENTITY (1, 1) NOT NULL,
    [IdEmpleado]            INT NULL,
    [IdObra]                INT NULL,
    CONSTRAINT [PK_DetalleEmpleadosObras] PRIMARY KEY CLUSTERED ([IdDetalleEmpleadoObra] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleEmpleadosObras_Empleados] FOREIGN KEY ([IdEmpleado]) REFERENCES [dbo].[Empleados] ([IdEmpleado])
);

