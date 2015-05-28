CREATE TABLE [dbo].[AcoGrados] (
    [IdAcoGrado] INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]    INT NULL,
    [IdSubRubro] INT NULL,
    CONSTRAINT [PK_AcoGrados] PRIMARY KEY CLUSTERED ([IdAcoGrado] ASC) WITH (FILLFACTOR = 90)
);

