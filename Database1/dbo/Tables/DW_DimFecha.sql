CREATE TABLE [dbo].[DW_DimFecha] (
    [ClaveFecha]      INT          NOT NULL,
    [Fecha]           DATETIME     NULL,
    [NombreDiaSemana] VARCHAR (10) NULL,
    [NumeroDiaSemana] TINYINT      NULL,
    [NumeroDiaMes]    TINYINT      NULL,
    [NumeroDiaAño]    SMALLINT     NULL,
    [NumeroSemanaAño] TINYINT      NULL,
    [NombreMes]       VARCHAR (10) NULL,
    [NumeroMes]       TINYINT      NULL,
    [NumeroTrimestre] TINYINT      NULL,
    [NumeroAño]       SMALLINT     NULL,
    [NumeroSemestre]  TINYINT      NULL,
    CONSTRAINT [PK_DW_DimFecha] PRIMARY KEY CLUSTERED ([ClaveFecha] ASC) WITH (FILLFACTOR = 90)
);

