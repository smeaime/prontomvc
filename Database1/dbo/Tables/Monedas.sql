CREATE TABLE [dbo].[Monedas] (
    [IdMoneda]        INT             IDENTITY (1, 1) NOT NULL,
    [Nombre]          VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Abreviatura]     VARCHAR (15)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EquivalenciaUS]  NUMERIC (18, 4) NULL,
    [CodigoAFIP]      VARCHAR (3)     NULL,
    [GeneraImpuestos] VARCHAR (2)     NULL,
    [EnviarEmail]     TINYINT         NULL,
    CONSTRAINT [PK_Monedas] PRIMARY KEY CLUSTERED ([IdMoneda] ASC) WITH (FILLFACTOR = 90)
);

