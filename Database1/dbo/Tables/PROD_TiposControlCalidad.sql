﻿CREATE TABLE [dbo].[PROD_TiposControlCalidad] (
    [IdPROD_TiposControlCalidad] INT             IDENTITY (1, 1) NOT NULL,
    [Codigo]                     VARCHAR (20)    NULL,
    [Descripcion]                VARCHAR (50)    NULL,
    [P1Codigo]                   VARCHAR (20)    NULL,
    [P1Descripcion]              VARCHAR (50)    NULL,
    [P1RangoMinimo]              NUMERIC (18, 2) NULL,
    [P1RangoMaximo]              NUMERIC (18, 2) NULL,
    [P1RangoIdUnidad]            INT             NULL,
    [P1Frecuencia]               NUMERIC (18, 2) NULL,
    [P1FrecuenciaIdUnidad]       INT             NULL,
    [P1EsObligatorio]            VARCHAR (2)     NULL,
    [P2Codigo]                   VARCHAR (20)    NULL,
    [P2Descripcion]              VARCHAR (50)    NULL,
    [P2RangoMinimo]              NUMERIC (18, 2) NULL,
    [P2RangoMaximo]              NUMERIC (18, 2) NULL,
    [P2RangoIdUnidad]            INT             NULL,
    [P2Frecuencia]               NUMERIC (18, 2) NULL,
    [P2FrecuenciaIdUnidad]       INT             NULL,
    [P2EsObligatorio]            VARCHAR (2)     NULL,
    [P3Codigo]                   VARCHAR (20)    NULL,
    [P3Descripcion]              VARCHAR (50)    NULL,
    [P3RangoMinimo]              NUMERIC (18, 2) NULL,
    [P3RangoMaximo]              NUMERIC (18, 2) NULL,
    [P3RangoIdUnidad]            INT             NULL,
    [P3Frecuencia]               NUMERIC (18, 2) NULL,
    [P3FrecuenciaIdUnidad]       INT             NULL,
    [P3EsObligatorio]            VARCHAR (2)     NULL,
    [P4Codigo]                   VARCHAR (20)    NULL,
    [P4Descripcion]              VARCHAR (50)    NULL,
    [P4RangoMinimo]              NUMERIC (18, 2) NULL,
    [P4RangoMaximo]              NUMERIC (18, 2) NULL,
    [P4RangoIdUnidad]            INT             NULL,
    [P4Frecuencia]               NUMERIC (18, 2) NULL,
    [P4FrecuenciaIdUnidad]       INT             NULL,
    [P4EsObligatorio]            VARCHAR (2)     NULL,
    [P5Codigo]                   VARCHAR (20)    NULL,
    [P5Descripcion]              VARCHAR (50)    NULL,
    [P5RangoMinimo]              NUMERIC (18, 2) NULL,
    [P5RangoMaximo]              NUMERIC (18, 2) NULL,
    [P5RangoIdUnidad]            INT             NULL,
    [P5Frecuencia]               NUMERIC (18, 2) NULL,
    [P5FrecuenciaIdUnidad]       INT             NULL,
    [P5EsObligatorio]            VARCHAR (2)     NULL,
    PRIMARY KEY CLUSTERED ([IdPROD_TiposControlCalidad] ASC) WITH (FILLFACTOR = 90)
);

