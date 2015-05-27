CREATE TABLE [dbo].[HorasJornadas] (
    [IdHorasJornada] INT             IDENTITY (1, 1) NOT NULL,
    [IdEmpleado]     INT             NULL,
    [FechaJornada]   DATETIME        NULL,
    [HorasJornada]   NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_HorasJornadas] PRIMARY KEY CLUSTERED ([IdHorasJornada] ASC) WITH (FILLFACTOR = 90)
);

