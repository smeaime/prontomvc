CREATE TABLE [dbo].[CodigosDestinacion] (
    [IdCodigoDestinacion] INT           IDENTITY (1, 1) NOT NULL,
    [Codigo]              VARCHAR (4)   NULL,
    [Descripcion]         VARCHAR (100) NULL,
    CONSTRAINT [PK_CodigosDestinacion] PRIMARY KEY CLUSTERED ([IdCodigoDestinacion] ASC) WITH (FILLFACTOR = 90)
);

