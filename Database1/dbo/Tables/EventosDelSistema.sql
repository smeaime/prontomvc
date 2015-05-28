CREATE TABLE [dbo].[EventosDelSistema] (
    [IdEventoDelSistema] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]        VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Importancia]        SMALLINT     NULL,
    CONSTRAINT [PK_EventosDelSistema] PRIMARY KEY CLUSTERED ([IdEventoDelSistema] ASC) WITH (FILLFACTOR = 90)
);

