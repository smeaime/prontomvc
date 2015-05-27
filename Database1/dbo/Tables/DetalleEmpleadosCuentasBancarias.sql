CREATE TABLE [dbo].[DetalleEmpleadosCuentasBancarias] (
    [IdDetalleEmpleadoCuentaBancaria] INT IDENTITY (1, 1) NOT NULL,
    [IdEmpleado]                      INT NULL,
    [IdCuentaBancaria]                INT NULL,
    CONSTRAINT [PK_DetalleEmpleadosCuentasBancarias] PRIMARY KEY CLUSTERED ([IdDetalleEmpleadoCuentaBancaria] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleEmpleadosCuentasBancarias_Empleados] FOREIGN KEY ([IdEmpleado]) REFERENCES [dbo].[Empleados] ([IdEmpleado])
);

