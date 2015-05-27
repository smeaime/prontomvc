CREATE TABLE [dbo].[ProduccionLineas] (
    [IdProduccionLinea]  INT          IDENTITY (1, 1) NOT NULL,
    [IdProduccionSector] INT          NULL,
    [Codigo]             VARCHAR (20) NULL,
    [Descripcion]        VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([IdProduccionLinea] ASC) WITH (FILLFACTOR = 90),
    FOREIGN KEY ([IdProduccionSector]) REFERENCES [dbo].[ProduccionSectores] ([IdProduccionSector])
);

