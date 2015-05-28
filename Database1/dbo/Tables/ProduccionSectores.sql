CREATE TABLE [dbo].[ProduccionSectores] (
    [IdProduccionSector] INT          IDENTITY (1, 1) NOT NULL,
    [IdProduccionArea]   INT          NULL,
    [Codigo]             VARCHAR (20) NULL,
    [Descripcion]        VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([IdProduccionSector] ASC) WITH (FILLFACTOR = 90),
    FOREIGN KEY ([IdProduccionArea]) REFERENCES [dbo].[ProduccionAreas] ([IdProduccionArea])
);

