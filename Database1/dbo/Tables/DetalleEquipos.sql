CREATE TABLE [dbo].[DetalleEquipos] (
    [IdDetalleEquipo] INT     IDENTITY (1, 1) NOT NULL,
    [IdEquipo]        INT     NULL,
    [IdPlano]         INT     NULL,
    [EnviarEmail]     TINYINT NULL,
    CONSTRAINT [PK_DetalleEquipos] PRIMARY KEY CLUSTERED ([IdDetalleEquipo] ASC) WITH (FILLFACTOR = 90)
);

