CREATE TABLE [dbo].[CartasDePorteMailClusters] (
    [IdCartaDePorte]           INT NULL,
    [AgrupadorDeTandaPeriodos] INT NULL,
    FOREIGN KEY ([IdCartaDePorte]) REFERENCES [dbo].[CartasDePorte] ([IdCartaDePorte])
);

