CREATE TABLE [dbo].[AcoSchedulers] (
    [IdAcoScheduler] INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]        INT NULL,
    [IdSubrubro]     INT NULL,
    CONSTRAINT [PK_AcoSchedulers] PRIMARY KEY CLUSTERED ([IdAcoScheduler] ASC) WITH (FILLFACTOR = 90)
);

