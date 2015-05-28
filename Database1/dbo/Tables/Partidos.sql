CREATE TABLE [dbo].[Partidos] (
    [IdPartido]    INT           IDENTITY (1, 1) NOT NULL,
    [Nombre]       VARCHAR (100) NOT NULL,
    [Codigo]       VARCHAR (15)  NOT NULL,
    [IdProvincia]  INT           NULL,
    [CodigoONCCA]  VARCHAR (15)  NULL,
    [CodigoPostal] VARCHAR (15)  NULL,
    PRIMARY KEY CLUSTERED ([IdPartido] ASC) WITH (FILLFACTOR = 90),
    FOREIGN KEY ([IdProvincia]) REFERENCES [dbo].[Provincias] ([IdProvincia]),
    CONSTRAINT [U_Partidos_Unicidad] UNIQUE NONCLUSTERED ([Nombre] ASC) WITH (FILLFACTOR = 90)
);

