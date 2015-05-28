CREATE TABLE [dbo].[Calles] (
    [IdCalle] INT          IDENTITY (1, 1) NOT NULL,
    [Nombre]  VARCHAR (50) NULL,
    CONSTRAINT [PK_Calles] PRIMARY KEY CLUSTERED ([IdCalle] ASC) WITH (FILLFACTOR = 90)
);

