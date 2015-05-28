CREATE TABLE [dbo].[AcoCodigos] (
    [IdAcoCodigo] INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]     INT NULL,
    [IdSubrubro]  INT NULL,
    CONSTRAINT [PK_AcoCodigos] PRIMARY KEY CLUSTERED ([IdAcoCodigo] ASC) WITH (FILLFACTOR = 90)
);

