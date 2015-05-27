CREATE TABLE [dbo].[_TempInformacionImpositiva] (
    [IdRegistro] INT            IDENTITY (1, 1) NOT NULL,
    [Campo]      VARCHAR (1000) NULL,
    CONSTRAINT [PK_1] PRIMARY KEY CLUSTERED ([IdRegistro] ASC) WITH (FILLFACTOR = 90)
);

