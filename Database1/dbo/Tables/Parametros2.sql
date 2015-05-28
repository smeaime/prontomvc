CREATE TABLE [dbo].[Parametros2] (
    [IdParametro] INT           IDENTITY (1, 1) NOT NULL,
    [Campo]       VARCHAR (50)  NULL,
    [Valor]       VARCHAR (500) NULL,
    CONSTRAINT [PK_Parametros2] PRIMARY KEY CLUSTERED ([IdParametro] ASC) WITH (FILLFACTOR = 90)
);

