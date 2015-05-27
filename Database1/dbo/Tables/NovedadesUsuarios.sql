CREATE TABLE [dbo].[NovedadesUsuarios] (
    [IdNovedadUsuarios]  INT           IDENTITY (1, 1) NOT NULL,
    [IdEmpleado]         INT           NOT NULL,
    [IdEventoDelSistema] INT           NULL,
    [FechaEvento]        DATETIME      NULL,
    [Confirmado]         VARCHAR (2)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [FechaConfirmacion]  DATETIME      NULL,
    [Detalle]            VARCHAR (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdEnviadoPor]       INT           NULL,
    [IdElemento]         INT           NULL,
    [TipoElemento]       VARCHAR (50)  NULL,
    CONSTRAINT [PK_NovedadesUsuarios] PRIMARY KEY CLUSTERED ([IdNovedadUsuarios] ASC) WITH (FILLFACTOR = 90)
);

