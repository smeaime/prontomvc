CREATE TABLE [dbo].[UnidadesOperativas] (
    [IdUnidadOperativa] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]       VARCHAR (50) NULL,
    [EnviarEmail]       TINYINT      NULL,
    [Codigo]            VARCHAR (10) NULL,
    CONSTRAINT [PK_UnidadesOperativas] PRIMARY KEY CLUSTERED ([IdUnidadOperativa] ASC) WITH (FILLFACTOR = 90)
);

