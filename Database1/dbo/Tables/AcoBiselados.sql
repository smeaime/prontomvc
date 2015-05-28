CREATE TABLE [dbo].[AcoBiselados] (
    [IdAcoBiselado] INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]       INT NULL,
    [IdSubrubro]    INT NULL,
    CONSTRAINT [PK_AcoBiselados] PRIMARY KEY CLUSTERED ([IdAcoBiselado] ASC) WITH (FILLFACTOR = 90)
);

