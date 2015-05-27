CREATE TABLE [dbo].[EmpleadosAccesos] (
    [IdEmpleadoAcceso]           INT           IDENTITY (1, 1) NOT NULL,
    [IdEmpleado]                 INT           NULL,
    [Nodo]                       VARCHAR (100) NULL,
    [Acceso]                     BIT           NOT NULL,
    [Nivel]                      INT           NULL,
    [FechaDesdeParaModificacion] DATETIME      NULL,
    [FechaInicialHabilitacion]   DATETIME      NULL,
    [FechaFinalHabilitacion]     DATETIME      NULL,
    [CantidadAccesos]            INT           NULL,
    [FechaUltimaModificacion]    DATETIME      NULL,
    [IdUsuarioModifico]          INT           NULL,
    [UsuarioNTUsuarioModifico]   VARCHAR (50)  NULL,
    CONSTRAINT [PK_EmpleadosAccesos] PRIMARY KEY CLUSTERED ([IdEmpleadoAcceso] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_EmpleadosAccesos_Empleados] FOREIGN KEY ([IdEmpleado]) REFERENCES [dbo].[Empleados] ([IdEmpleado])
);

