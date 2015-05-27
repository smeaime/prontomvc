CREATE TABLE [dbo].[DetalleEmpleados] (
    [IdDetalleEmpleado] INT      IDENTITY (1, 1) NOT NULL,
    [IdEmpleado]        INT      NULL,
    [FechaIngreso]      DATETIME NULL,
    [FechaEgreso]       DATETIME NULL,
    CONSTRAINT [PK_DetalleEmpleados] PRIMARY KEY CLUSTERED ([IdDetalleEmpleado] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleEmpleados_Empleados] FOREIGN KEY ([IdEmpleado]) REFERENCES [dbo].[Empleados] ([IdEmpleado])
);

