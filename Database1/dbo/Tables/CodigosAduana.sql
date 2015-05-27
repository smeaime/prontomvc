CREATE TABLE [dbo].[CodigosAduana] (
    [IdCodigoAduana] INT           IDENTITY (1, 1) NOT NULL,
    [Codigo]         INT           NULL,
    [Descripcion]    VARCHAR (100) NULL,
    CONSTRAINT [PK_CodigosAduana] PRIMARY KEY CLUSTERED ([IdCodigoAduana] ASC) WITH (FILLFACTOR = 90)
);

