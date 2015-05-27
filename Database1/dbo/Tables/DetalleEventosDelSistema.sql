CREATE TABLE [dbo].[DetalleEventosDelSistema] (
    [IdDetalleEventoDelSistema] INT IDENTITY (1, 1) NOT NULL,
    [IdEventoDelSistema]        INT NULL,
    [IdEmpleado]                INT NULL,
    CONSTRAINT [PK_DetalleEventosDelSistema] PRIMARY KEY CLUSTERED ([IdDetalleEventoDelSistema] ASC) WITH (FILLFACTOR = 90)
);

