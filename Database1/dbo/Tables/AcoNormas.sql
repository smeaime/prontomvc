CREATE TABLE [dbo].[AcoNormas] (
    [IdAcoNorma] INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]    INT NULL,
    [IdSubrubro] INT NULL,
    CONSTRAINT [PK_AcoNormas] PRIMARY KEY CLUSTERED ([IdAcoNorma] ASC) WITH (FILLFACTOR = 90)
);

