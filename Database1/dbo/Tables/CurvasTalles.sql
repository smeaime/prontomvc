CREATE TABLE [dbo].[CurvasTalles] (
    [IdCurvaTalle]           INT          IDENTITY (1, 1) NOT NULL,
    [Codigo]                 INT          NULL,
    [Descripcion]            VARCHAR (50) NULL,
    [Curva]                  VARCHAR (50) NULL,
    [CurvaCodigos]           VARCHAR (50) NULL,
    [MostrarCurvaEnInformes] VARCHAR (2)  NULL,
    CONSTRAINT [PK_CurvasTalles] PRIMARY KEY CLUSTERED ([IdCurvaTalle] ASC) WITH (FILLFACTOR = 90)
);

