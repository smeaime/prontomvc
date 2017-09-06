



if OBJECT_ID ('fCalidadSerializada') is not null 
    drop function fCalidadSerializada
go 


create FUNCTION fCalidadSerializada
(
    @FK_ID INT -- The foreign key from TableA which is used 
               -- to fetch corresponding records
)
RETURNS VARCHAR(8000)
AS
BEGIN
DECLARE @SomeColumnList VARCHAR(4000);
DECLARE @SomeColumnList2 VARCHAR(4000);

SELECT @SomeColumnList =
    COALESCE(@SomeColumnList + ', ', '') + CAST(Campo AS varchar(100)) + ' '  + CAST(Valor AS varchar(20)) 
FROM CartasDePorteDetalle C
WHERE C.IdCartaDePorte= @FK_ID and valor<>0;



SELECT  
	@SomeColumnList2=
		case when CDP.NobleExtranos > 0 then 'Extraños '       + CAST(CDP.NobleExtranos AS varchar(20))   else  ''  end  + 
		case when CDP.NobleNegros   > 0 then 'Negros '         + CAST(CDP.NobleNegros AS varchar(20))     else  ''  end  +
		case when CDP.NobleQuebrados   > 0 then 'Quebrados '         + CAST(CDP.NobleQuebrados AS varchar(20))     else  ''  end  +
		case when CDP.NobleDaniados   > 0 then 'Dañados '         + CAST(CDP.NobleDaniados AS varchar(20))     else  ''  end  +
		case when CDP.NobleChamico   > 0 then 'Chamico '         + CAST(CDP.NobleChamico AS varchar(20))     else  ''  end  +
		case when CDP.NobleChamico2   > 0 then 'Chamico '         + CAST(CDP.NobleChamico2 AS varchar(20))     else  ''  end  +
		case when CDP.NobleRevolcado   > 0 then 'Revolcado '         + CAST(CDP.NobleRevolcado AS varchar(20))     else  ''  end  +
		case when CDP.NobleObjetables   > 0 then 'Objetables '         + CAST(CDP.NobleObjetables AS varchar(20))     else  ''  end  +
		case when CDP.NobleAmohosados   > 0 then 'Amohosados '         + CAST(CDP.NobleAmohosados AS varchar(20))     else  ''  end  +
		case when CDP.NobleHectolitrico   > 0 then 'Hectolitrico '         + CAST(CDP.NobleHectolitrico AS varchar(20))     else  ''  end  +
		case when CDP.NobleCarbon   > 0 then 'Carbon '         + CAST(CDP.NobleCarbon AS varchar(20))     else  ''  end  +
		case when CDP.NoblePanzaBlanca   > 0 then 'PanzaBlanca '         + CAST(CDP.NoblePanzaBlanca AS varchar(20))     else  ''  end  +
		case when CDP.NoblePicados   > 0 then 'Picados '         + CAST(CDP.NoblePicados AS varchar(20))     else  ''  end  +
		case when CDP.NobleMGrasa   > 0 then 'MGrasa '         + CAST(CDP.NobleMGrasa AS varchar(20))     else  ''  end  +
		case when CDP.NobleAcidezGrasa   > 0 then 'AcidezGrasa '         + CAST(CDP.NobleAcidezGrasa AS varchar(20))     else  ''  end  +
		case when CDP.NobleVerdes   > 0 then 'Verdes '         + CAST(CDP.NobleVerdes AS varchar(20))     else  ''  end  +
		case when CDP.NobleGrado   > 0 then 'Grado '         + CAST(CDP.NobleGrado AS varchar(20))     else  ''  end  +
		case when CDP.NobleConforme   > 0 then 'Conforme '         + CAST(CDP.NobleConforme AS varchar(20))     else  ''  end  +
		case when CDP.NobleACamara   > 0 then 'ACamara '         + CAST(CDP.NobleACamara AS varchar(20))     else  ''  end  +
		case when CDP.CalidadGranosQuemados   > 0 then 'Quemados '         + CAST(CDP.CalidadGranosQuemados AS varchar(20))     else  ''  end  +
		case when CDP.CalidadTierra   > 0 then 'Tierra '         + CAST(CDP.CalidadTierra AS varchar(20))     else  ''  end  



FROM CartasDePorte CDP
WHERE CDP.IdCartaDePorte= @FK_ID;


RETURN 
(
    SELECT  COALESCE(@SomeColumnList2+', ','') + COALESCE(@SomeColumnList,'') + '  |'
)
END

go



--select * from CartasDePorteDetalle where valor <> 0
--select NobleExtranos,idcartadeporte from CartasDePorte where NobleExtranos <> 0

print dbo.fCalidadSerializada(2054771)
print dbo.fCalidadSerializada(20090)






