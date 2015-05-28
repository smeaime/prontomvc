CREATE TABLE [dbo].[Paises] (
    [IdPais]      INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Codigo]      VARCHAR (3)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EnviarEmail] TINYINT      NULL,
    [Codigo2]     VARCHAR (10) NULL,
    [Cuit]        VARCHAR (11) NULL,
    [CodigoESRI]  VARCHAR (2)  NULL,
    CONSTRAINT [PK_Paises] PRIMARY KEY CLUSTERED ([IdPais] ASC) WITH (FILLFACTOR = 90)
);

