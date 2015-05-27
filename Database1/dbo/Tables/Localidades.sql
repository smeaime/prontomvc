CREATE TABLE [dbo].[Localidades] (
    [IdLocalidad]    INT          IDENTITY (1, 1) NOT NULL,
    [Nombre]         VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CodigoPostal]   VARCHAR (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdProvincia]    INT          NULL,
    [EnviarEmail]    TINYINT      NULL,
    [CodigoONCAA]    VARCHAR (20) NULL,
    [CodigoESRI]     VARCHAR (2)  NULL,
    [CodigoWilliams] VARCHAR (20) NULL,
    [CodigoLosGrobo] VARCHAR (20) NULL,
    [Codigo]         INT          NULL,
    [Partido]        VARCHAR (60) NULL,
    [IdPartido]      INT          NULL,
    CONSTRAINT [PK_Localidades] PRIMARY KEY CLUSTERED ([IdLocalidad] ASC) WITH (FILLFACTOR = 90),
    FOREIGN KEY ([IdPartido]) REFERENCES [dbo].[Partidos] ([IdPartido]),
    CONSTRAINT [FK_Localidades_Provincias] FOREIGN KEY ([IdProvincia]) REFERENCES [dbo].[Provincias] ([IdProvincia])
);

