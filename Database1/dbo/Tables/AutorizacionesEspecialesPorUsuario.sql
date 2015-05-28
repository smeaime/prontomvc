CREATE TABLE [dbo].[AutorizacionesEspecialesPorUsuario] (
    [IdAutorizacionEspecialUsuario] INT IDENTITY (1, 1) NOT NULL,
    [IdUsuario]                     INT NULL,
    [IdCuenta]                      INT NULL,
    CONSTRAINT [PK_AutorizacionesEspecialesPorUsuario] PRIMARY KEY CLUSTERED ([IdAutorizacionEspecialUsuario] ASC)
);

