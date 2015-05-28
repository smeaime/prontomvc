CREATE TABLE [dbo].[Subrubros] (
    [IdSubrubro]  INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) NULL,
    [Abreviatura] VARCHAR (15) NULL,
    [EnviarEmail] TINYINT      NULL,
    [Codigo]      INT          NULL,
    CONSTRAINT [PK_SubRubros] PRIMARY KEY CLUSTERED ([IdSubrubro] ASC) WITH (FILLFACTOR = 90)
);

