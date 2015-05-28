CREATE TABLE [dbo].[ProduccionAreas] (
    [IdProduccionArea] INT          IDENTITY (1, 1) NOT NULL,
    [Codigo]           VARCHAR (20) NULL,
    [Descripcion]      VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([IdProduccionArea] ASC) WITH (FILLFACTOR = 90)
);

