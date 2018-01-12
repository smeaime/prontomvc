
select dbo.RemoveNonASCII(descripcion), * from williamsdestinos 
where descripcion like 'FABRICA SANTA%'

select * from williamsdestinos where descripcion='FABRICA SANTA CLARA ( MRP )'
SELECT * FROM WilliamsDestinos WHERE dbo.[udf-Str-Strip-Control](Descripcion)= dbo.[udf-Str-Strip-Control]('FABRICA SANTA CLARA ( MRP )')

 print dbo.[udf-Str-Strip-Control]('FABRICA SANTA CLARA ( MRP )')
 print dbo.[udf-Str-Strip-Control]('FABRICA SANTA CLARA ( MRP )')

 print  REPLACE('FABRICA SANTA CLARA ( MRP )', char(160), '')
 print  REPLACE('FABRICA SANTA CLARA ( MRP )', char(160), ' ')
--insert into williamsdestinos (Descripcion) values ('FABRICA SANTA CLARA ( VICENTIN )') 

SELECT TOP 1 IdWilliamsDestino FROM WilliamsDestinos WHERE REPLACE(Descripcion, char(160),' ') = REPLACE('FABRICA SANTA CLARA ( MRP )', char(160), ' ')


CREATE FUNCTION [dbo].[udf-Str-Strip-Control](@S varchar(max))
Returns varchar(max)
Begin
    ;with  cte1(N) As (Select 1 From (Values(1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) N(N)),
           cte2(C) As (Select Top (32) Char(Row_Number() over (Order By (Select NULL))-1) From cte1 a,cte1 b)
    Select @S = Replace(@S,C,' ')
     From  cte2

    Return LTrim(RTrim(Replace(Replace(Replace(@S,' ','><'),'<>',''),'><',' ')))
End



CREATE FUNCTION RemoveNonASCII 
(
    @nstring nvarchar(255)
)
RETURNS varchar(255)
AS
BEGIN

    DECLARE @Result varchar(255)
    SET @Result = ''

    DECLARE @nchar nvarchar(1)
    DECLARE @position int

    SET @position = 1
    WHILE @position <= LEN(@nstring)
    BEGIN
        SET @nchar = SUBSTRING(@nstring, @position, 1)
        --Unicode & ASCII are the same from 1 to 255.
        --Only Unicode goes beyond 255
        --0 to 31 are non-printable characters
        IF UNICODE(@nchar) between 32 and 255
            SET @Result = @Result + @nchar
        SET @position = @position + 1
    END

    RETURN @Result

END
GO




create function remove_non_printable_chars (@input_string nvarchar(max))
returns table with schemabinding as return (
  select 
    replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
    replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
    replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
    replace(replace(@input_string collate latin1_general_100_bin2,
        char(1), ''),char(2), ''),char(3), ''),char(4), ''),char(5), ''),char(6), ''),char(7), ''),char(8), ''),char(9), ''),char(10), ''),
        char(11), ''),char(12), ''),char(13), ''),char(14), ''),char(15), ''),char(16), ''),char(17), ''),char(18), ''),char(19), ''),char(20), ''),
        char(21), ''),char(22), ''),char(23), ''),char(24), ''),char(25), ''),char(26), ''),char(27), ''),char(28), ''),char(29), ''),char(30), ''),
        char(31), ''), char(0) , '') 
     as clean_string
);
go