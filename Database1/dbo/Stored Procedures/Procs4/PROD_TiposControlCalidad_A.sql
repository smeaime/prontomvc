create Procedure PROD_TiposControlCalidad_A

@IdPROD_TiposControlCalidad int output,

@Codigo varchar(20) ,
@Descripcion varchar(50) ,

--Parametros
@P1Codigo varchar(20) ,
@P1Descripcion varchar(50) ,
@P1RangoMinimo numeric(18,2),
@P1RangoMaximo numeric(18,2),
@P1RangoIdUnidad int,
@P1Frecuencia numeric(18,2),
@P1FrecuenciaIdUnidad int,
@P1EsObligatorio varchar (2)  ,

@P2Codigo varchar(20) ,
@P2Descripcion varchar(50) ,
@P2RangoMinimo numeric(18,2),
@P2RangoMaximo numeric(18,2),
@P2RangoIdUnidad int,
@P2Frecuencia numeric(18,2),
@P2FrecuenciaIdUnidad int,
@P2EsObligatorio varchar (2)  ,

@P3Codigo varchar(20) ,
@P3Descripcion varchar(50) ,
@P3RangoMinimo numeric(18,2),
@P3RangoMaximo numeric(18,2),
@P3RangoIdUnidad int,
@P3Frecuencia numeric(18,2),
@P3FrecuenciaIdUnidad int,
@P3EsObligatorio varchar (2)  ,

@P4Codigo varchar(20) ,
@P4Descripcion varchar(50) ,
@P4RangoMinimo numeric(18,2),
@P4RangoMaximo numeric(18,2),
@P4RangoIdUnidad int,
@P4Frecuencia numeric(18,2),
@P4FrecuenciaIdUnidad int,
@P4EsObligatorio varchar (2)  ,

@P5Codigo varchar(20) ,
@P5Descripcion varchar(50) ,
@P5RangoMinimo numeric(18,2),
@P5RangoMaximo numeric(18,2),
@P5RangoIdUnidad int,
@P5Frecuencia numeric(18,2),
@P5FrecuenciaIdUnidad int,
@P5EsObligatorio varchar (2)  

AS 

INSERT INTO [PROD_TiposControlCalidad]
(
Codigo,
Descripcion,

--Parametros
P1Codigo,
P1Descripcion ,
P1RangoMinimo,
P1RangoMaximo ,
P1RangoIdUnidad ,
P1Frecuencia ,
P1FrecuenciaIdUnidad ,
P1EsObligatorio ,

P2Codigo ,
P2Descripcion ,
P2RangoMinimo ,
P2RangoMaximo,
P2RangoIdUnidad,
P2Frecuencia ,
P2FrecuenciaIdUnidad ,
P2EsObligatorio   ,

P3Codigo  ,
P3Descripcion  ,
P3RangoMinimo ,
P3RangoMaximo ,
P3RangoIdUnidad ,
P3Frecuencia ,
P3FrecuenciaIdUnidad ,
P3EsObligatorio   ,

P4Codigo ,
P4Descripcion,
P4RangoMinimo ,
P4RangoMaximo,
P4RangoIdUnidad ,
P4Frecuencia,
P4FrecuenciaIdUnidad ,
P4EsObligatorio    ,

P5Codigo ,
P5Descripcion,
P5RangoMinimo ,
P5RangoMaximo ,
P5RangoIdUnidad ,
P5Frecuencia ,
P5FrecuenciaIdUnidad ,
P5EsObligatorio    
)
VALUES
(
@Codigo,
@Descripcion,

--Parametros
@P1Codigo,
@P1Descripcion ,
@P1RangoMinimo,
@P1RangoMaximo ,
@P1RangoIdUnidad ,
@P1Frecuencia ,
@P1FrecuenciaIdUnidad ,
@P1EsObligatorio ,

@P2Codigo ,
@P2Descripcion ,
@P2RangoMinimo ,
@P2RangoMaximo,
@P2RangoIdUnidad,
@P2Frecuencia ,
@P2FrecuenciaIdUnidad ,
@P2EsObligatorio   ,

@P3Codigo  ,
@P3Descripcion  ,
@P3RangoMinimo ,
@P3RangoMaximo ,
@P3RangoIdUnidad ,
@P3Frecuencia ,
@P3FrecuenciaIdUnidad ,
@P3EsObligatorio   ,

@P4Codigo ,
@P4Descripcion,
@P4RangoMinimo ,
@P4RangoMaximo,
@P4RangoIdUnidad ,
@P4Frecuencia,
@P4FrecuenciaIdUnidad ,
@P4EsObligatorio    ,

@P5Codigo ,
@P5Descripcion,
@P5RangoMinimo ,
@P5RangoMaximo ,
@P5RangoIdUnidad ,
@P5Frecuencia ,
@P5FrecuenciaIdUnidad ,
@P5EsObligatorio    
)

SELECT @IdPROD_TiposControlCalidad=@@identity
RETURN(@IdPROD_TiposControlCalidad)


