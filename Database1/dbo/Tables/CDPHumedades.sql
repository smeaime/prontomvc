CREATE TABLE [dbo].[CDPHumedades] (
    [IdCDPHumedad] INT             IDENTITY (1, 1) NOT NULL,
    [IdArticulo]   INT             NULL,
    [Humedad]      NUMERIC (18, 2) NULL,
    [Merma]        NUMERIC (18, 2) NULL,
    PRIMARY KEY CLUSTERED ([IdCDPHumedad] ASC) WITH (FILLFACTOR = 90),
    FOREIGN KEY ([IdArticulo]) REFERENCES [dbo].[Articulos] ([IdArticulo])
);

