CREATE TABLE [dbo].[DetalleAcopiosEquipos] (
    [IdDetalleAcopioEquipo]         INT     IDENTITY (1, 1) NOT NULL,
    [IdAcopio]                      INT     NULL,
    [IdEquipo]                      INT     NULL,
    [EnviarEmail]                   TINYINT NULL,
    [IdAcopioOriginal]              INT     NULL,
    [IdDetalleAcopioEquipoOriginal] INT     NULL,
    [IdOrigenTransmision]           INT     NULL,
    CONSTRAINT [PK_DetalleAcopiosEquipos] PRIMARY KEY CLUSTERED ([IdDetalleAcopioEquipo] ASC) WITH (FILLFACTOR = 90)
);

