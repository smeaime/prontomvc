CREATE TABLE [dbo].[DetalleDefinicionAnulaciones] (
    [IdDetalleDefinicionAnulacion] INT         IDENTITY (1, 1) NOT NULL,
    [IdDefinicionAnulacion]        INT         NULL,
    [IdEmpleado]                   INT         NULL,
    [IdCargo]                      INT         NULL,
    [IdSector]                     INT         NULL,
    [Administradores]              VARCHAR (2) NULL,
    CONSTRAINT [PK_DetalleDefinicionAnulaciones] PRIMARY KEY CLUSTERED ([IdDetalleDefinicionAnulacion] ASC) WITH (FILLFACTOR = 90)
);

